Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91526C83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 22:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E39D20757
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 22:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="iOr8ewoJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgD2WYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 18:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726481AbgD2WYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 18:24:13 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FD6C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 15:24:11 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c63so3822164qke.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 15:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N5mT0UrjUVQ+LKtL+fJLsV3ZSWofkUiis5zRHwPIn6g=;
        b=iOr8ewoJWDPUm01VpYhUnSr9hu0AeEv6mfKoy4WSbmPz+/U2GA7+WDNRk0WJsTr04U
         WhxArBkqGiHwH0eVdTIWnoL2lyOAaBVi4x1F0X0nEES18bInCY3AoJMlIib4tpDmAdxs
         X7eeSjHDlUpSG+PL0co1Tyuc+DJhSQ4t8uQ+LuavTBCLciYgDVJx3PVtAcyjl3j4wKri
         +DOHBcB3E07UZcN0SYf130nFWdo5rAhUExJzxtOhx+0LMeZ6/Fs5yr2STov3KzQztfHR
         x1GxeerLoqqe9mY/rx8xoHFNGVexQMEVsKc0iGMkuGORAV/L/eIfTdeeManhzMDJZbM2
         w42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N5mT0UrjUVQ+LKtL+fJLsV3ZSWofkUiis5zRHwPIn6g=;
        b=JUsTA9vZvR3YoBByo2k6b94PyeuBTuIbfZYasQ2TwCbgNxmwhBpjl3vUJijKieU4EM
         rOwlUTu48R+5bSMFKsMLKlrBTeieRRo/lsKlI4NWYU10KEQp8ni44QOJJkWNJS9KaP3+
         EMK1YQiBSWM/9r0D6lbayk2uXlyRrrvEVj99DhMvNGybxzaWQV3uayAegmN8GV1XwDBs
         hU0eG0g3nXXlP15oab0T+LbFktSIWG3C/16AveroSmMeUqp/kQ0krizEkRMeNGoC40EO
         JkF+tILqpAr7FauIgyaA5IY9TpyBbSaFd0RngSYQ00olMczao1BMNsfPNA+oqlU0iey9
         MIug==
X-Gm-Message-State: AGi0PuZUg8QDZHnTjzuDHTqjJpICOUiBMFNfdr2/Zee/fLjESQjji79i
        Cu+9OT4+gvzsscvxIOjxcazI+pbVnDhEHw==
X-Google-Smtp-Source: APiQypLmSLmxNDDWl0UnrQSTpUW2GmUZbQRHdvicW/k4j+I6MtsmkbywTZggJAVAGijrzMf1lY8ehQ==
X-Received: by 2002:a37:e54:: with SMTP id 81mr644968qko.284.1588199049619;
        Wed, 29 Apr 2020 15:24:09 -0700 (PDT)
Received: from ovpn-113-19.phx2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id v27sm517889qtb.35.2020.04.29.15.24.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Apr 2020 15:24:08 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     cl@linux.com, rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] mm/slub: fix stack overruns with SLUB_STATS
Date:   Wed, 29 Apr 2020 18:23:56 -0400
Message-Id: <20200429222356.4322-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to copy SLUB_STATS items from root memcg cache to new
memcg cache copies. Doing so could result in stack overruns because the
store function only accepts 0 to clear the stat and returns an error for
everything else while the show method would print out the whole stat.
Then, the mismatch of the lengths returns from show and store methods
happens in memcg_propagate_slab_attrs(),

else if (root_cache->max_attr_size < ARRAY_SIZE(mbuf))
	buf = mbuf;

max_attr_size is only 2 from slab_attr_store(), then, it uses mbuf[64]
in show_stat() later where a bounch of sprintf() would overrun the stack
variable. Fix it by always allocating a page of buffer to be used in
show_stat() if SLUB_STATS=y which should only be used for debug purpose.

 # echo 1 > /sys/kernel/slab/fs_cache/shrink
 BUG: KASAN: stack-out-of-bounds in number+0x421/0x6e0
 Write of size 1 at addr ffffc900256cfde0 by task kworker/76:0/53251

 Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
 Workqueue: memcg_kmem_cache memcg_kmem_cache_create_func
 Call Trace:
  dump_stack+0xa7/0xea
  print_address_description.constprop.5.cold.7+0x64/0x384
  __kasan_report.cold.8+0x76/0xda
  kasan_report+0x41/0x60
  __asan_store1+0x6d/0x70
  number+0x421/0x6e0
  vsnprintf+0x451/0x8e0
  sprintf+0x9e/0xd0
  show_stat+0x124/0x1d0
  alloc_slowpath_show+0x13/0x20
  __kmem_cache_create+0x47a/0x6b0

 addr ffffc900256cfde0 is located in stack of task kworker/76:0/53251 at offset 0 in frame:
  process_one_work+0x0/0xb90

 this frame has 1 object:
  [32, 72) 'lockdep_map'

 Memory state around the buggy address:
  ffffc900256cfc80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffffc900256cfd00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 >ffffc900256cfd80: 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1
                                                        ^
  ffffc900256cfe00: 00 00 00 00 00 f2 f2 f2 00 00 00 00 00 00 00 00
  ffffc900256cfe80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ==================================================================
 Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: __kmem_cache_create+0x6ac/0x6b0
 Workqueue: memcg_kmem_cache memcg_kmem_cache_create_func
 Call Trace:
  dump_stack+0xa7/0xea
  panic+0x23e/0x452
  __stack_chk_fail+0x22/0x30
  __kmem_cache_create+0x6ac/0x6b0

Fixes: 107dab5c92d5 ("slub: slub-specific propagation changes")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/slub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 9bf44955c4f1..57731f29dde3 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5639,7 +5639,8 @@ static void memcg_propagate_slab_attrs(struct kmem_cache *s)
 		 */
 		if (buffer)
 			buf = buffer;
-		else if (root_cache->max_attr_size < ARRAY_SIZE(mbuf))
+		else if (root_cache->max_attr_size < ARRAY_SIZE(mbuf) &&
+			 !IS_ENABLED(CONFIG_SLUB_STATS))
 			buf = mbuf;
 		else {
 			buffer = (char *) get_zeroed_page(GFP_KERNEL);
-- 
2.21.0 (Apple Git-122.2)

