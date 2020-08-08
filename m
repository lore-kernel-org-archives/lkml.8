Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2DEC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 09:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2FD220855
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 09:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxnleFpS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgHHJuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 05:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgHHJui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 05:50:38 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A75C061756
        for <linux-kernel@vger.kernel.org>; Sat,  8 Aug 2020 02:50:37 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a15so3760350wrh.10
        for <linux-kernel@vger.kernel.org>; Sat, 08 Aug 2020 02:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iu+xGq/4Dn8boKbZib4AWJ+d5oeBv4YdO2v6rLcz6X0=;
        b=PxnleFpSMGNsYP2bmpZLHWDleM3D/LQ+Ug5cNcfmZ0H3YW6UCwVWMJojacIekW4OTY
         MiT0Ta8+TjdqMibQoKoH6FWhqBfI7gP3dKwer384nZSN4amDAbUJCjgfol7HenZ2IAQJ
         eJAQw7zzgjrwB/P8iaQVdphR4eq0qNA7QhBDB8b6dcAxUaMhSQgSyos2t+s8emEVGh3N
         uxpwZ+HUPJ0mQOzorX74I9bch8D+b6HYg/xBTPUSp6GMEcp5H1K87uNLaHfAaJatLG7R
         gpfTptszj7OQ1D4rC8AUU9EqKmagKmuLeLRW6/945KTR1/B+4+DYRNN/ZVL8xP2PGVTo
         L5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iu+xGq/4Dn8boKbZib4AWJ+d5oeBv4YdO2v6rLcz6X0=;
        b=k8mgS2JXnku47exQlRXaD902CGx8YUtMx7gHMNaMEFDyYtPubWJ/UdxWRBFpmuEE14
         BZPvMaNNxL6LSIuACo9X1ns227chN721W4Y6Aq6owWVsrzDZmt107C8jV3NG24EofCNu
         NAKMOOcCK33zsVVYwuJgcSOQrlE2Ns0ZDcMgyc6J8U8i6sctr3HzzkF1BWuo4Gnnqndr
         FxrHpCtrwIChZsU+nEFYCfuBjzKygEu58t/T0PD64lA77U0eLeS+o1etsSUS7lxCAtfi
         WxacFYMN/LX3YCNoXKzSiSURw16p7CMWQURW5Y9AHq8v/LZ4ysiR4xBt1oLSXau7jkBK
         T99w==
X-Gm-Message-State: AOAM531XUuBQyJoTNTrpbj1dBnIORkOXXHqePQhWAmUcPmJhpqZyQkfk
        WNINxWBG4EiDGXK/r7rxPJJ4vcnP9/Q=
X-Google-Smtp-Source: ABdhPJwDlExzuCWZWtgQKlspwM6lkWCctnh+AsaxICv5NkIh1LlIJ/DSp6ei7MwuW0gEZRO4P9GBCA==
X-Received: by 2002:adf:ee83:: with SMTP id b3mr15506244wro.163.1596880235998;
        Sat, 08 Aug 2020 02:50:35 -0700 (PDT)
Received: from Sahara-MacBookPro.darkmatter.uae ([31.215.141.243])
        by smtp.gmail.com with ESMTPSA id i66sm14152504wma.35.2020.08.08.02.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 02:50:35 -0700 (PDT)
From:   kpark3469@gmail.com
To:     linux-kernel@vger.kernel.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        keun-o.park@digital14.com
Subject: [PATCH] mm: slub: re-initialize randomized freelist sequence in calculate_sizes
Date:   Sat,  8 Aug 2020 13:50:30 +0400
Message-Id: <20200808095030.13368-1-kpark3469@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sahara <keun-o.park@digital14.com>

Slab cache flags are exported to sysfs and are allowed to get modified
from userspace. Some of those may call calculate_sizes function because
the changed flag can take an effect on slab object size and layout,
which means kmem_cache may have different order and objects.
The freelist pointer corruption occurs if some slab flags are modified
while CONFIG_SLAB_FREELIST_RANDOM is turned on.

 $ echo 0 > /sys/kernel/slab/zs_handle/store_user
 $ echo 0 > /sys/kernel/slab/zspage/store_user
 $ mkswap /dev/block/zram0
 $ swapon /dev/block/zram0 -p 32758

 =============================================================================
 BUG zs_handle (Not tainted): Freepointer corrupt
 -----------------------------------------------------------------------------

 Disabling lock debugging due to kernel taint
 INFO: Slab 0xffffffbf29603600 objects=102 used=102 fp=0x0000000000000000 flags=0x0200
 INFO: Object 0xffffffca580d8d78 @offset=3448 fp=0xffffffca580d8ed0

 Redzone 00000000f3cddd6c: bb bb bb bb bb bb bb bb                          ........
 Object 0000000082d5d74e: 6b 6b 6b 6b 6b 6b 6b a5                          kkkkkkk.
 Redzone 000000008fd80359: bb bb bb bb bb bb bb bb                          ........
 Padding 00000000c7f56047: 5a 5a 5a 5a 5a 5a 5a 5a                          ZZZZZZZZ

In this example, an Android device tries to use zram as a swap and to
turn off store_user in order to reduce the slub object size.
When calculate_sizes is called in kmem_cache_open, size, order and
objects for zs_handle is:
 size:360, order:0, objects:22
However, if the SLAB_STORE_USER bit is cleared in store_user_store:
 size: 56, order:1, objects:73

All the size, order, and objects is changed by calculate_sizes(), but
the size of the random_seq array is still old value(22). As a result,
out-of-bound array access can occur at shuffle_freelist() when slab
allocation is requested.

This patch fixes the problem by re-allocating the random_seq array
with re-calculated correct objects value.

Fixes: 210e7a43fa905 ("mm: SLUB freelist randomization")
Reported-by: Ari-Pekka Verta <ari-pekka.verta@digital14.com>
Reported-by: Timo Simola <timo.simola@digital14.com>
Signed-off-by: Sahara <keun-o.park@digital14.com>
---
 mm/slub.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index f226d66408ee..be1e4d6682b8 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3704,7 +3704,22 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
 	if (oo_objects(s->oo) > oo_objects(s->max))
 		s->max = s->oo;
 
-	return !!oo_objects(s->oo);
+	if (!oo_objects(s->oo))
+		return 0;
+
+	/*
+	 * Initialize the pre-computed randomized freelist if slab is up.
+	 * If the randomized freelist random_seq is already initialized,
+	 * free and re-initialize it with re-calculated value.
+	 */
+	if (slab_state >= UP) {
+		if (s->random_seq)
+			cache_random_seq_destroy(s);
+		if (init_cache_random_seq(s))
+			return 0;
+	}
+
+	return 1;
 }
 
 static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
@@ -3748,12 +3763,6 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
 	s->remote_node_defrag_ratio = 1000;
 #endif
 
-	/* Initialize the pre-computed randomized freelist if slab is up */
-	if (slab_state >= UP) {
-		if (init_cache_random_seq(s))
-			goto error;
-	}
-
 	if (!init_kmem_cache_nodes(s))
 		goto error;
 
-- 
2.17.1

