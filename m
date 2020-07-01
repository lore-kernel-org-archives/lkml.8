Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBAAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 22:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED9B1207F5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 22:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="awDmTn3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgGAWO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 18:14:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44389 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727057AbgGAWOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 18:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593641690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=xoqk9QTtScU+aPGKHoCc+VNYKEEQhDvkQeRwCbimQV8=;
        b=awDmTn3N5uvVaegRezZRYwFAXlwPYX/3uUq5fRPM4MIj4/v7eu6aAwPmy5dlQSMS68It55
        Yw+UbW47lKPp5Sp5SMN54vZysLxkUqvZdf0hawv05g3mVtQJCS4Za8x+Jt6MnII0KTVbLc
        rX61g5UWqJT17GjdWWFb8px8HWTUtK4=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-w5hQHdbBPuSXXypqXX_hYg-1; Wed, 01 Jul 2020 18:14:48 -0400
X-MC-Unique: w5hQHdbBPuSXXypqXX_hYg-1
Received: by mail-pl1-f197.google.com with SMTP id r11so8590972plo.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 15:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xoqk9QTtScU+aPGKHoCc+VNYKEEQhDvkQeRwCbimQV8=;
        b=RuSmUvofqGLhyF+I8KRna/dWAiDN6wwOms9XwfCo6eLC65BsEif9oh5fza14lIR/oe
         ILJtr642IRy3dUKzVGiR2z13OoTnTQF9TKHOR0oTs4Z8jkWWqMBhA11+Ug8SusGd6uic
         vMtN+g7BN0O5NximfRlp/ZtYSDipE+4UAr7YQ7uF8hLvJJiob5ZHYH+ExDfk1wXEt0mB
         vTFd+av1/aLSbE1qD5pZS9ZZAqvTgtVxbGSgWw3qh0fXL4iD/CI9cWbAl483Cmm4etS4
         0HGgYmIBJmxVGGY/MQtWc68FNzuLhi/4tUIXq6++lp7RlfGhtNlHe/9fZgeu/kqcjy4Y
         zKkw==
X-Gm-Message-State: AOAM530duSPNWgGQ2cBsV0pIAoTNBpTp1K1vQOS6hD58PDXQ04x9mFHG
        6r+J0RQ0HXFgmkUFnVLtapmkLYY9LHEp2GQTHDZ1dcn7gUg9FU65yIPaq2med3HVPwShvP7pcPg
        GItTL5M8Y9QcXRMcpmHMQYtcH
X-Received: by 2002:a17:902:148:: with SMTP id 66mr23151068plb.308.1593641687738;
        Wed, 01 Jul 2020 15:14:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSel1QkbgREE+b1y+g1hJfoMILEzByCbKnUpkCkK6gLrD4a7/08WiZHMyUAY4DMfVWE25z8w==
X-Received: by 2002:a17:902:148:: with SMTP id 66mr23151046plb.308.1593641687475;
        Wed, 01 Jul 2020 15:14:47 -0700 (PDT)
Received: from localhost ([110.227.183.4])
        by smtp.gmail.com with ESMTPSA id h6sm6973231pfg.25.2020.07.01.15.14.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 15:14:47 -0700 (PDT)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org
Cc:     bhsharma@redhat.com, bhupesh.linux@gmail.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: [PATCH 2/2] arm64: Allocate crashkernel always in ZONE_DMA
Date:   Thu,  2 Jul 2020 03:44:20 +0530
Message-Id: <1593641660-13254-3-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593641660-13254-1-git-send-email-bhsharma@redhat.com>
References: <1593641660-13254-1-git-send-email-bhsharma@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit bff3b04460a8 ("arm64: mm: reserve CMA and crashkernel in
ZONE_DMA32") allocates crashkernel for arm64 in the ZONE_DMA32.

However as reported by Prabhakar, this breaks kdump kernel booting in
ThunderX2 like arm64 systems. I have noticed this on another ampere
arm64 machine. The OOM log in the kdump kernel looks like this:

  [    0.240552] DMA: preallocated 128 KiB GFP_KERNEL pool for atomic allocations
  [    0.247713] swapper/0: page allocation failure: order:1, mode:0xcc1(GFP_KERNEL|GFP_DMA), nodemask=(null),cpuset=/,mems_allowed=0
  <..snip..>
  [    0.274706] Call trace:
  [    0.277170]  dump_backtrace+0x0/0x208
  [    0.280863]  show_stack+0x1c/0x28
  [    0.284207]  dump_stack+0xc4/0x10c
  [    0.287638]  warn_alloc+0x104/0x170
  [    0.291156]  __alloc_pages_slowpath.constprop.106+0xb08/0xb48
  [    0.296958]  __alloc_pages_nodemask+0x2ac/0x2f8
  [    0.301530]  alloc_page_interleave+0x20/0x90
  [    0.305839]  alloc_pages_current+0xdc/0xf8
  [    0.309972]  atomic_pool_expand+0x60/0x210
  [    0.314108]  __dma_atomic_pool_init+0x50/0xa4
  [    0.318504]  dma_atomic_pool_init+0xac/0x158
  [    0.322813]  do_one_initcall+0x50/0x218
  [    0.326684]  kernel_init_freeable+0x22c/0x2d0
  [    0.331083]  kernel_init+0x18/0x110
  [    0.334600]  ret_from_fork+0x10/0x18

This patch limits the crashkernel allocation to the first 1GB of
the RAM accessible (ZONE_DMA), as otherwise we might run into OOM
issues when crashkernel is executed, as it might have been originally
allocated from either a ZONE_DMA32 memory or mixture of memory chunks
belonging to both ZONE_DMA and ZONE_DMA32.

Fixes: bff3b04460a8 ("arm64: mm: reserve CMA and crashkernel in ZONE_DMA32")
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org
Reported-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 arch/arm64/mm/init.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 1e93cfc7c47a..02ae4d623802 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -91,8 +91,15 @@ static void __init reserve_crashkernel(void)
 	crash_size = PAGE_ALIGN(crash_size);
 
 	if (crash_base == 0) {
-		/* Current arm64 boot protocol requires 2MB alignment */
-		crash_base = memblock_find_in_range(0, arm64_dma32_phys_limit,
+		/* Current arm64 boot protocol requires 2MB alignment.
+		 * Also limit the crashkernel allocation to the first
+		 * 1GB of the RAM accessible (ZONE_DMA), as otherwise we
+		 * might run into OOM issues when crashkernel is executed,
+		 * as it might have been originally allocated from
+		 * either a ZONE_DMA32 memory or mixture of memory
+		 * chunks belonging to both ZONE_DMA and ZONE_DMA32.
+		 */
+		crash_base = memblock_find_in_range(0, arm64_dma_phys_limit,
 				crash_size, SZ_2M);
 		if (crash_base == 0) {
 			pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
@@ -101,6 +108,11 @@ static void __init reserve_crashkernel(void)
 		}
 	} else {
 		/* User specifies base address explicitly. */
+		if (crash_base + crash_size > arm64_dma_phys_limit) {
+			pr_warn("cannot reserve crashkernel: region is allocatable only in ZONE_DMA range\n");
+			return;
+		}
+
 		if (!memblock_is_region_memory(crash_base, crash_size)) {
 			pr_warn("cannot reserve crashkernel: region is not memory\n");
 			return;
-- 
2.7.4

