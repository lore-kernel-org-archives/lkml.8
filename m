Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED96C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38766208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NSZJf3Cw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgCXOW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:22:59 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:29532 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727270AbgCXOW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585059777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=+TmMAyQNdrsWtGKQJAPznO269BAHbZfbwCisH4kJOrg=;
        b=NSZJf3CwGxIxIoZShzyIuicCkBiq6jCStpsIqpUQMD3ouqtyTHCD9FiN8v9Xd9ZgFZM2eM
        ts//bW3UeVJLGTkpwk8thqV2OYrVF5IUUhr+bOaJ9u0LztrIpSUF4871jm9Kz0P9BdTO9B
        FqE8BDc2Ls15a/uQq2S0R/j1LolgoJY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-ii-GG5eyOzmxWs7MUxp1FA-1; Tue, 24 Mar 2020 10:22:53 -0400
X-MC-Unique: ii-GG5eyOzmxWs7MUxp1FA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28FE1800D5E;
        Tue, 24 Mar 2020 14:22:52 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-69.pek2.redhat.com [10.72.12.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B53C05C557;
        Tue, 24 Mar 2020 14:22:48 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        iamjoonsoo.kim@lge.com, hannes@cmpxchg.org, mhocko@kernel.org,
        vbabka@suse.cz, bhe@redhat.com
Subject: [PATCH 4/5] mm/vmstat.c: move the per-node stats to the front of /proc/zoneinfo
Date:   Tue, 24 Mar 2020 22:22:28 +0800
Message-Id: <20200324142229.12028-5-bhe@redhat.com>
In-Reply-To: <20200324142229.12028-1-bhe@redhat.com>
References: <20200324142229.12028-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moving makes the layout of /proc/zoneinfo more sensible. And there
are 4 zones at most currently, it doesn't need to scroll down much to get
to the 1st populated zone, even though the 1st populated zone is MOVABLE
zone.

Node 2, per-node stats
      nr_inactive_anon 48
      nr_active_anon 15454
...
      nr_foll_pin_acquired 0
      nr_foll_pin_released 0
Node 2, zone      DMA
  pages free     0
        min      0
        low      0
        high     0
        spanned  0
        present  0
        managed  0
Node 2, zone    DMA32
  pages free     0
        min      0
        low      0
        high     0
        spanned  0
        present  0
        managed  0
Node 2, zone   Normal
  pages free     0
        min      0
        low      0
        high     0
        spanned  0
        present  0
        managed  0
Node 2, zone  Movable
  pages free     196346
        min      3540
...
        managed  262144

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/vmstat.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 6fd1407f4632..4bbf9be786da 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1567,13 +1567,6 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 {
 	int i;
 	seq_printf(m, "Node %d, zone %8s", pgdat->node_id, zone->name);
-	if (is_zone_first_populated(pgdat, zone)) {
-		seq_printf(m, "\n  per-node stats");
-		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
-			seq_printf(m, "\n      %-12s %lu", node_stat_name(i),
-				   node_page_state(pgdat, i));
-		}
-	}
 	seq_printf(m,
 		   "\n  pages free     %lu"
 		   "\n        min      %lu"
@@ -1648,7 +1641,18 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
  */
 static int zoneinfo_show(struct seq_file *m, void *arg)
 {
+	int i;
 	pg_data_t *pgdat = (pg_data_t *)arg;
+
+	if (node_state(pgdat->node_id, N_MEMORY)) {
+		seq_printf(m, "Node %d, per-node stats", pgdat->node_id);
+		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
+			seq_printf(m, "\n      %-12s %lu", node_stat_name(i),
+				   node_page_state(pgdat, i));
+		}
+		seq_putc(m, '\n');
+	}
+
 	walk_zones_in_node(m, pgdat, false, false, zoneinfo_show_print);
 	return 0;
 }
-- 
2.17.2

