Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22A9C55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 09:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BBDD2076C
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 09:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qy8uu973"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgDYJNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 05:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgDYJNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 05:13:52 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43325C09B04A
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 02:13:52 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id q18so5840313pgm.11
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 02:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ECciQwpgKDmf2McP6BUwtAeSaQDTvXNzb0GBUXol1JE=;
        b=qy8uu973g69+z1E6psbmI1cqUGVkTf2JwEIUZJF8WCZDACTepAaomeDrWAYc2F4KiU
         WRPs3chHhgDfytU6gDVMctgQ9BexEl2sGE7DgjGx2cq0mr20aiwXRfTMybquXl3CfYjk
         ggPJti1PQfHmHZNYDZBRhhM/OMZYz9CCaO5rDd3GWW6d5Q/LYteolkrpr6oW7nbTHqeK
         hz0zDWhhCUNu2aeYpSMstjMhet4zpRg2hTSNpMFigVeyo7zLBZUi/OxqW4KT99huYk/g
         8OWfYMFR/6vU0rOFsWjJknVdoqfr3t5tvOF5jmMebj7RJag7JSnSvRFwzFl8u517PEki
         EO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ECciQwpgKDmf2McP6BUwtAeSaQDTvXNzb0GBUXol1JE=;
        b=YjCeraZaVQ6GkKQKK0M+xBBWmYirSRmr6T/d+8vBjsWZc1EHN9fnuNOkQLTQ8eFHOO
         jcq9uQyEelVblF1PXvUXlNQlbuvtJ2dkQoTsN3aS1hBP5hs5iA5PDU64ZbIjIxwCYIHE
         HCtNsdGKPFHvrhRbjRYiC1MH3P+XZHMvK8TBRDQud4Wng9DMG7bcBiVOej3x0TMrl9XZ
         oSCXV00T421foQISJoM5x1XCLhDZp8TtIC70hnUqblFTY8/T+0xhclDXoXyxR89LfkpL
         C2kQ231cB+M70GP1Y00B4m6WYNdOIyib8G86C1a5qzBUN13trb+EU5blbC24yMZrWlmV
         9bkg==
X-Gm-Message-State: AGi0Pua4KJtXgFs6BNlCMSziLXKS9lt3RCrcXaYy1/4O35hmALDMvyJL
        f+1biEvUbrEIuQ/YMB9k+Fw=
X-Google-Smtp-Source: APiQypJOVNNFeNJSQmsPv0FjJnNr8iruVg1Zd7cGWPy/xjbupZDQ/37eZcdbdJYY0Epl1seKi3d1XQ==
X-Received: by 2002:aa7:8259:: with SMTP id e25mr13969052pfn.82.1587806031538;
        Sat, 25 Apr 2020 02:13:51 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id o1sm6553360pjs.39.2020.04.25.02.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2020 02:13:50 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] mm/slub: do not place freelist pointer to middle of object if redzone is on
Date:   Sat, 25 Apr 2020 17:13:38 +0800
Message-Id: <20200425091338.24283-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent kernel fails to boot when slub redzone is turned on. This is
caused by commit 3202fa62fb ("slub: relocate freelist pointer to middle of
object") which relocates freelist pointer to middle of object. In this
case, get_track() gets a wrong address and then the redzone is overwritten.

This patch fixes it by relocating freelist pointer after the object, as
what slub posion does.

[    2.390256][    T0] =============================================================================
[    2.392816][    T0] BUG kmem_cache_node (Not tainted): Redzone overwritten
[    2.393735][    T0] -----------------------------------------------------------------------------
[    2.393735][    T0]
[    2.395168][    T0] Disabling lock debugging due to kernel taint
[    2.395923][    T0] INFO: 0xffff88805c000380-0xffff88805c000387 @offset=896. First byte 0x0 instead of 0xbb
[    2.397175][    T0] INFO: Slab 0xffffea0001700000 objects=25 used=25 fp=0x0000000000000000 flags=0xfffffc0010200
[    2.398882][    T0] INFO: Object 0xffff88805c000300 @offset=768 fp=0xffff88805c000580
[    2.398882][    T0]
[    2.400145][    T0] Redzone ffff88805c000280: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
[    2.401593][    T0] Redzone ffff88805c000290: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
[    2.403825][    T0] Redzone ffff88805c0002a0: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
[    2.405853][    T0] Redzone ffff88805c0002b0: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
[    2.407714][    T0] Redzone ffff88805c0002c0: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
[    2.411066][    T0] Redzone ffff88805c0002d0: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
[    2.413818][    T0] Redzone ffff88805c0002e0: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
[    2.415482][    T0] Redzone ffff88805c0002f0: bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
[    2.416975][    T0] Object ffff88805c000300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    2.418445][    T0] Object ffff88805c000310: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    2.420183][    T0] Object ffff88805c000320: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    2.421911][    T0] Object ffff88805c000330: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    2.423491][    T0] Object ffff88805c000340: 00 00 00 00 00 00 00 00 e8 ed 4a b9 09 7b 20 83  ..........J..{ .
[    2.425186][    T0] Object ffff88805c000350: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    2.426901][    T0] Object ffff88805c000360: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    2.428673][    T0] Object ffff88805c000370: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    2.430431][    T0] Redzone ffff88805c000380: 00 00 00 00 00 00 00 00                          ........
[    2.485141][    T0] Padding ffff88805c000490: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    2.494198][    T0] Padding ffff88805c0004a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    2.503094][    T0] Padding ffff88805c0004b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    2.578370][    T0] Padding ffff88805c0004c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    2.584420][    T0] Padding ffff88805c0004d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    2.590139][    T0] Padding ffff88805c0004e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    2.596915][    T0] Padding ffff88805c0004f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[    2.604002][    T0] CPU: 0 PID: 0 Comm: swapper Tainted: G    B             5.7.0-rc1+ #53
[    2.608493][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
[    2.612959][    T0] Call Trace:
[    2.613953][    T0]  dump_stack+0x8c/0xc0
[    2.615063][    T0]  check_bytes_and_report.cold+0x60/0x95
[    2.616572][    T0]  check_object+0x1c1/0x280
[    2.617462][    T0]  ? pvclock_clocksource_read+0xf6/0x1c0
[    2.618646][    T0]  ? __kmem_cache_create+0x16a/0x670
[    2.619692][    T0]  alloc_debug_processing+0x129/0x170
[    2.620766][    T0]  ___slab_alloc+0x58c/0x630
[    2.621804][    T0]  ? __kmem_cache_create+0x16a/0x670
[    2.622631][    T0]  ? print_unlock_imbalance_bug+0x40/0x40
[    2.623630][    T0]  ? lock_acquire+0x11f/0x200
[    2.624421][    T0]  ? __kmem_cache_create+0x16a/0x670
[    2.625342][    T0]  ? __slab_alloc+0x1c/0x30
[    2.626106][    T0]  ? ___slab_alloc+0x5/0x630
[    2.626890][    T0]  __slab_alloc+0x1c/0x30
[    2.627500][    T0]  kmem_cache_alloc_node+0xab/0x2e0
[    2.628222][    T0]  __kmem_cache_create+0x16a/0x670
[    2.628883][    T0]  ? mem_init_print_info+0x2af/0x2be
[    2.629596][    T0]  create_boot_cache+0xa4/0xc8
[    2.630282][    T0]  kmem_cache_init+0x80/0x14a
[    2.631233][    T0]  start_kernel+0x67a/0xa2a
[    2.631905][    T0]  ? thread_stack_cache_init+0x6/0x6
[    2.632553][    T0]  ? x86_family+0x5/0x20
[    2.633085][    T0]  ? load_ucode_bsp+0x50/0x216
[    2.633629][    T0]  secondary_startup_64+0xa4/0xb0
[    2.634243][    T0] FIX kmem_cache_node: Restoring 0xffff88805c000380-0xffff88805c000387=0xbb
[    2.634243][    T0]
[    2.635532][    T0] FIX kmem_cache_node: Marking all objects used
[    2.636287][    T0] =============================================================================

Fixes: 3202fa62fb ("slub: relocate freelist pointer to middle of object")
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 332d4b459a90..59c5b49038b0 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3570,7 +3570,7 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
 	 */
 	s->inuse = size;
 
-	if (((flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON)) ||
+	if (((flags & (SLAB_TYPESAFE_BY_RCU | SLAB_RED_ZONE | SLAB_POISON)) ||
 		s->ctor)) {
 		/*
 		 * Relocate free pointer after the object if it is not
-- 
2.25.1

