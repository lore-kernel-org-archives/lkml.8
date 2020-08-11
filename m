Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCA1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EABE120658
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NLa7yMoF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgHKHyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 03:54:24 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58167 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726397AbgHKHyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 03:54:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597132462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=2TA1qUQTA106lCApZkYqx4DJzgphPi5RyaFz/tNYgI8=;
        b=NLa7yMoF3GcVBE+sKncQaMdMq1rl2q89gJNdYyaWSh0neF5DdQhpn5jkxepe72DosSX5XU
        YmLoHVAJCzvdRORr1b9MrJ+T7vGSLe/jI+qYHjDtGIvXV+B5/+nqcZV/8B1PUkdubnk/Nn
        qeMtGzn2FnoywfHXxK/7Z2tLlxG9aUQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-fTfFC_9GOue5LbbqOdFu8Q-1; Tue, 11 Aug 2020 03:54:21 -0400
X-MC-Unique: fTfFC_9GOue5LbbqOdFu8Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E62B7E919;
        Tue, 11 Aug 2020 07:54:19 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-96.pek2.redhat.com [10.72.13.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E34855D9DD;
        Tue, 11 Aug 2020 07:54:15 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        sonnyrao@chromium.org, yuzhao@google.com, rientjes@google.com,
        bhe@redhat.com
Subject: [PATCH] Revert "mm/vmstat.c: do not show lowmem reserve protection information of empty zone"
Date:   Tue, 11 Aug 2020 15:54:12 +0800
Message-Id: <20200811075412.12872-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 26e7deadaae1755faf1f6d1a68988c4b8348df59.

Sonny reported that one of their tests started failing on the latest
kernel on their Chrome OS platform. The root cause is that the above
commit removed the protection line of empty zone, while the parser used
in the test relies on the protection line to mark the end of each zone.

Let's revert it to avoid breaking userspace testing or applications.

Cc: <stable@vger.kernel.org> # 5.8.x
Reported-by: Sonny Rao <sonnyrao@chromium.org>
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/vmstat.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 5b35c0eb8c57..62376dc66ec0 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1644,12 +1644,6 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 		   zone->present_pages,
 		   zone_managed_pages(zone));
 
-	/* If unpopulated, no other information is useful */
-	if (!populated_zone(zone)) {
-		seq_putc(m, '\n');
-		return;
-	}
-
 	seq_printf(m,
 		   "\n        protection: (%ld",
 		   zone->lowmem_reserve[0]);
@@ -1657,6 +1651,12 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 		seq_printf(m, ", %ld", zone->lowmem_reserve[i]);
 	seq_putc(m, ')');
 
+	/* If unpopulated, no other information is useful */
+	if (!populated_zone(zone)) {
+		seq_putc(m, '\n');
+		return;
+	}
+
 	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
 		seq_printf(m, "\n      %-12s %lu", zone_stat_name(i),
 			   zone_page_state(zone, i));
-- 
2.17.2

