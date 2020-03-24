Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9249DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A39420870
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WRdKUAZ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgCXOWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:22:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:48878 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727270AbgCXOWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585059773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=O7EMuney8gEiJb0wo0noEWCYTocW+RKYyaMoY0nHgzo=;
        b=WRdKUAZ/lbtGaYLUkhzNhpher04/tHYOgcNK7RgvMACMQ3Vaxzo+AJDqbm2Dd4frvhjewM
        3aIEj4pAUpvSYncksW1XO3TvDIeLJy8eHmf/B4kJDVgnjfiuuqQS+nuI14qdYaLl3GOeLn
        A/80nVktD3YpcenoFab8/q5GNvXZo34=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-hV_BtkOTODC5p6M5PaLp6A-1; Tue, 24 Mar 2020 10:22:49 -0400
X-MC-Unique: hV_BtkOTODC5p6M5PaLp6A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39ED4100550D;
        Tue, 24 Mar 2020 14:22:48 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-69.pek2.redhat.com [10.72.12.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31EE35C241;
        Tue, 24 Mar 2020 14:22:42 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        iamjoonsoo.kim@lge.com, hannes@cmpxchg.org, mhocko@kernel.org,
        vbabka@suse.cz, bhe@redhat.com
Subject: [PATCH 3/5] mm/vmstat.c: do not show lowmem reserve protection information of empty zone
Date:   Tue, 24 Mar 2020 22:22:27 +0800
Message-Id: <20200324142229.12028-4-bhe@redhat.com>
In-Reply-To: <20200324142229.12028-1-bhe@redhat.com>
References: <20200324142229.12028-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

