Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFBFC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D641020788
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BAq86NAs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgCXOXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:23:00 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:44672 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727270AbgCXOXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585059779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=zQWZEZmUvi4qR88INJygABxgVNbImLNogNiP/46ZYIU=;
        b=BAq86NAsx+rymdUcLd3UkTN4PSphSVWGdE98raixIyC0MMmorXlSGzjJTBBHc6KEsEEnDf
        MO2AIayBPBUDJygMRSjC8Q4oH/2MrY2a/PVijW41DMmV+yYuAroFJYo3W2JhBMNaCFBKkR
        ve7P2c6COdqKlXfiVaIUjqs2rXlKeJQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-QyoWTaspMVCP-mDcxPeR4Q-1; Tue, 24 Mar 2020 10:22:56 -0400
X-MC-Unique: QyoWTaspMVCP-mDcxPeR4Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B40B8024DB;
        Tue, 24 Mar 2020 14:22:55 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-69.pek2.redhat.com [10.72.12.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3F835C241;
        Tue, 24 Mar 2020 14:22:52 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        iamjoonsoo.kim@lge.com, hannes@cmpxchg.org, mhocko@kernel.org,
        vbabka@suse.cz, bhe@redhat.com
Subject: [PATCH 5/5] mm/vmstat.c: remove the useless code
Date:   Tue, 24 Mar 2020 22:22:29 +0800
Message-Id: <20200324142229.12028-6-bhe@redhat.com>
In-Reply-To: <20200324142229.12028-1-bhe@redhat.com>
References: <20200324142229.12028-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one calls is_zone_first_populated(), remove it.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/vmstat.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 4bbf9be786da..7097eb99f30d 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1548,20 +1548,6 @@ static const struct seq_operations pagetypeinfo_op = {
 	.show	= pagetypeinfo_show,
 };
 
-static bool is_zone_first_populated(pg_data_t *pgdat, struct zone *zone)
-{
-	int zid;
-
-	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
-		struct zone *compare = &pgdat->node_zones[zid];
-
-		if (populated_zone(compare))
-			return zone == compare;
-	}
-
-	return false;
-}
-
 static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 							struct zone *zone)
 {
-- 
2.17.2

