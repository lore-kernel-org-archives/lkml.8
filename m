Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD32C2BA15
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D3720784
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iE3ui9H3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388358AbgDBOBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:01:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22281 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731579AbgDBOB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585836087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=26MBqTIy3VM6rKEvhuSVZBdiFAMRZ0dKsv4z+LdLChM=;
        b=iE3ui9H3Zu8XH8Zs1cYEALMJYCaaC+Chew/eJhlN6gJC+NfIm2Ln6dnPK+eK9WYQlqKlSZ
        gWj9+OjezryBKGF1pt7BzeZ0ABlMZTAoBOU3uYpChgSB4xi/dTiKHe68vjf0YpkmNbk86a
        MVCFMw6l3B3h2NXwhKG7mZLVgdvwhbE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-hw1VebTMNkSo8S_JMaEvkA-1; Thu, 02 Apr 2020 10:01:24 -0400
X-MC-Unique: hw1VebTMNkSo8S_JMaEvkA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF136107ACCC;
        Thu,  2 Apr 2020 14:01:22 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-36.pek2.redhat.com [10.72.12.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D8DD360BF1;
        Thu,  2 Apr 2020 14:01:19 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        iamjoonsoo.kim@lge.com, mhocko@kernel.org, bhe@redhat.com,
        mgorman@techsingularity.net, rientjes@google.com
Subject: [PATCH v2 1/3] mm/page_alloc.c: only tune sysctl_lowmem_reserve_ratio value once when changing it
Date:   Thu,  2 Apr 2020 22:01:11 +0800
Message-Id: <20200402140113.3696-2-bhe@redhat.com>
In-Reply-To: <20200402140113.3696-1-bhe@redhat.com>
References: <20200402140113.3696-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

