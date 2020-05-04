Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D579C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 16:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A8D020721
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 16:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="JmYLsNz6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbgEDQHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 12:07:45 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:60498 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726578AbgEDQHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 12:07:45 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 74A802E1328;
        Mon,  4 May 2020 19:07:42 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id XFRQHSghwv-7ebiFwpY;
        Mon, 04 May 2020 19:07:42 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1588608462; bh=KD7pqcqmqr2MDuVLcfG3e1Q0DT+u7iGuuqIXuZXITnw=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=JmYLsNz6oKNS/b/P0BSekGqLg7SlV9HxXkHUY0SCX0+PJ7BFzFQQBIsJAGGdw5qyU
         ywpUh0EPBM0n1SSFHQeEaI2nw6oEiCgiT9L4WWmg6JJbJTOb6cOd8WQjp98lk/ReMT
         dl2ymWrA7ba9e0ynoEkdA4GYlPBtqR2kpEgh6rZ4=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b081:409::1:8])
        by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id hrZEXGjF63-7eY8meVx;
        Mon, 04 May 2020 19:07:40 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH] slub: limit count of partial slabs scanned to gather
 statistics
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Date:   Mon, 04 May 2020 19:07:39 +0300
Message-ID: <158860845968.33385.4165926113074799048.stgit@buzz>
User-Agent: StGit/0.22-32-g6a05
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To get exact count of free and used objects slub have to scan list of
partial slabs. This may take at long time. Scanning holds spinlock and
blocks allocations which move partial slabs to per-cpu lists and back.

Example found in the wild:

# cat /sys/kernel/slab/dentry/partial
14478538 N0=7329569 N1=7148969
# time cat /sys/kernel/slab/dentry/objects
286225471 N0=136967768 N1=149257703

real	0m1.722s
user	0m0.001s
sys	0m1.721s

The same problem in slab was addressed in commit f728b0a5d72a ("mm, slab:
faster active and free stats") by adding more kmem cache statistics.
For slub same approach requires atomic op on fast path when object frees.

Let's simply limit count of scanned slabs and print warning.
Limit set in /sys/module/slub/parameters/max_partial_to_count.
Default is 10000 which should be enough for most sane cases.

Return linear approximation if list of partials is longer than limit.
Nobody should notice difference.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 mm/slub.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 9bf44955c4f1..86a366f7acb6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2407,16 +2407,29 @@ static inline unsigned long node_nr_objs(struct kmem_cache_node *n)
 #endif /* CONFIG_SLUB_DEBUG */
 
 #if defined(CONFIG_SLUB_DEBUG) || defined(CONFIG_SYSFS)
+
+static unsigned long max_partial_to_count __read_mostly = 10000;
+module_param(max_partial_to_count, ulong, 0644);
+
 static unsigned long count_partial(struct kmem_cache_node *n,
 					int (*get_count)(struct page *))
 {
+	unsigned long counted = 0;
 	unsigned long flags;
 	unsigned long x = 0;
 	struct page *page;
 
 	spin_lock_irqsave(&n->list_lock, flags);
-	list_for_each_entry(page, &n->partial, slab_list)
+	list_for_each_entry(page, &n->partial, slab_list) {
 		x += get_count(page);
+
+		if (++counted > max_partial_to_count) {
+			pr_warn_once("SLUB: too much partial slabs to count all objects, increase max_partial_to_count.\n");
+			/* Approximate total count of objects */
+			x = mult_frac(x, n->nr_partial, counted);
+			break;
+		}
+	}
 	spin_unlock_irqrestore(&n->list_lock, flags);
 	return x;
 }

