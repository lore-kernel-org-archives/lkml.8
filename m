Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC14CC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA212074D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJzbc3Ku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388444AbgDBOBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:01:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27510 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388395AbgDBOBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585836096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=O7EMuney8gEiJb0wo0noEWCYTocW+RKYyaMoY0nHgzo=;
        b=jJzbc3Ku4iYkltLvdGGmtpeVelK9u6Zl0kSQq8QAo1JnrB7bOhfX5solwzD4yHtVCUzlGG
        SS4Jhoxrs+trpyKh0//PsY20JPcYx+scKS+L+v3U1Vt2myoacz9sEdtgO2n1ta+JC5bsPP
        Z/dDyDCTVvLpML08Wc+6CO3GB46ZiKM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-YWpRpI3-MdO32gPxYsTtuw-1; Thu, 02 Apr 2020 10:01:31 -0400
X-MC-Unique: YWpRpI3-MdO32gPxYsTtuw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4036C107ACC4;
        Thu,  2 Apr 2020 14:01:29 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-36.pek2.redhat.com [10.72.12.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7CB9E60BF1;
        Thu,  2 Apr 2020 14:01:26 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        iamjoonsoo.kim@lge.com, mhocko@kernel.org, bhe@redhat.com,
        mgorman@techsingularity.net, rientjes@google.com
Subject: [PATCH v2 3/3] mm/vmstat.c: do not show lowmem reserve protection information of empty zone
Date:   Thu,  2 Apr 2020 22:01:13 +0800
Message-Id: <20200402140113.3696-4-bhe@redhat.com>
In-Reply-To: <20200402140113.3696-1-bhe@redhat.com>
References: <20200402140113.3696-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because the lowmem reserve protection of a zone can't tell anything if
the zone is empty, except of adding one more line in /proc/zoneinfo.

Let's remove it from that zone's showing.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/vmstat.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 96d21a792b57..6fd1407f4632 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1590,6 +1590,12 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 		   zone->present_pages,
 		   zone_managed_pages(zone));
 
+	/* If unpopulated, no other information is useful */
+	if (!populated_zone(zone)) {
+		seq_putc(m, '\n');
+		return;
+	}
+
 	seq_printf(m,
 		   "\n        protection: (%ld",
 		   zone->lowmem_reserve[0]);
@@ -1597,12 +1603,6 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 		seq_printf(m, ", %ld", zone->lowmem_reserve[i]);
 	seq_putc(m, ')');
 
-	/* If unpopulated, no other information is useful */
-	if (!populated_zone(zone)) {
-		seq_putc(m, '\n');
-		return;
-	}
-
 	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
 		seq_printf(m, "\n      %-12s %lu", zone_stat_name(i),
 			   zone_page_state(zone, i));
-- 
2.17.2

