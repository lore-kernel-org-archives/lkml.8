Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC57C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4217208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hzAkbaXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgCXOWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:22:46 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:24311 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726802AbgCXOWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585059765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=26MBqTIy3VM6rKEvhuSVZBdiFAMRZ0dKsv4z+LdLChM=;
        b=hzAkbaXbpFljmS2fqeu8i1vs2fS/Y6UQD8I2pp5BpyNiunpVUoVhhzeuIQGOkktSbT32At
        fDjinS/HZJ1/ataEh2lQHrf8xXWDkNaZ5dB3ZH0UrLl0nvWv88aa4c95ur3EeM+r6uRLWV
        BjizP/KJthdom7y/nKbiql240P0mSWM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-Tuqqbt2YPQSierum3NSpzQ-1; Tue, 24 Mar 2020 10:22:41 -0400
X-MC-Unique: Tuqqbt2YPQSierum3NSpzQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B93D10CE786;
        Tue, 24 Mar 2020 14:22:39 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-69.pek2.redhat.com [10.72.12.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A869F5C241;
        Tue, 24 Mar 2020 14:22:35 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        iamjoonsoo.kim@lge.com, hannes@cmpxchg.org, mhocko@kernel.org,
        vbabka@suse.cz, bhe@redhat.com
Subject: [PATCH 1/5] mm/page_alloc.c: only tune sysctl_lowmem_reserve_ratio value once when changing it
Date:   Tue, 24 Mar 2020 22:22:25 +0800
Message-Id: <20200324142229.12028-2-bhe@redhat.com>
In-Reply-To: <20200324142229.12028-1-bhe@redhat.com>
References: <20200324142229.12028-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When people write to /proc/sys/vm/lowmem_reserve_ratio to change
sysctl_lowmem_reserve_ratio[], setup_per_zone_lowmem_reserve()
is called to recalculate all ->lowmem_reserve[] for each zone of all
nodes as below:

static void setup_per_zone_lowmem_reserve(void)
{
...
	for_each_online_pgdat(pgdat) {
		for (j = 0; j < MAX_NR_ZONES; j++) {
			...
			while (idx) {
				...
				if (sysctl_lowmem_reserve_ratio[idx] < 1) {
					sysctl_lowmem_reserve_ratio[idx] = 0;
					lower_zone->lowmem_reserve[j] = 0;
                                } else {
				...
			}
		}
	}
}

Meanwhile, here, sysctl_lowmem_reserve_ratio[idx] will be tuned if its
value is smaller than '1'. As we know, sysctl_lowmem_reserve_ratio[] is
set for zone without regarding to which node it belongs to. That means
the tuning will be done on all nodes, even though it has been done in the
first node.

And the tuning will be done too even when init_per_zone_wmark_min()
calls setup_per_zone_lowmem_reserve(), where actually nobody tries to
change sysctl_lowmem_reserve_ratio[].

So now move the tuning into lowmem_reserve_ratio_sysctl_handler(), to
make code logic more reasonable.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 mm/page_alloc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ca1453204e66..c0c788798d8b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7840,8 +7840,7 @@ static void setup_per_zone_lowmem_reserve(void)
 				idx--;
 				lower_zone = pgdat->node_zones + idx;
 
-				if (sysctl_lowmem_reserve_ratio[idx] < 1) {
-					sysctl_lowmem_reserve_ratio[idx] = 0;
+				if (!sysctl_lowmem_reserve_ratio[idx]) {
 					lower_zone->lowmem_reserve[j] = 0;
 				} else {
 					lower_zone->lowmem_reserve[j] =
@@ -8106,7 +8105,15 @@ int sysctl_min_slab_ratio_sysctl_handler(struct ctl_table *table, int write,
 int lowmem_reserve_ratio_sysctl_handler(struct ctl_table *table, int write,
 	void __user *buffer, size_t *length, loff_t *ppos)
 {
+	int i;
+
 	proc_dointvec_minmax(table, write, buffer, length, ppos);
+
+	for (i = 0; i < MAX_NR_ZONES; i++) {
+		if (sysctl_lowmem_reserve_ratio[i] < 1)
+			sysctl_lowmem_reserve_ratio[i] = 0;
+	}
+
 	setup_per_zone_lowmem_reserve();
 	return 0;
 }
-- 
2.17.2

