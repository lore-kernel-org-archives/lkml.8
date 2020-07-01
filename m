Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A730AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 22:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83496207F5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 22:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DCOcOlpv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgGAWOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 18:14:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43529 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726960AbgGAWOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 18:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593641688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=bQb32/SaJZufmc/q7s+tyKjNogq0Gy4EIBWlQy//p8M=;
        b=DCOcOlpvRWMyQgBQaLNnookoSHX9aJHC6SYXSS3jFWsfWFCRMVcmieNai24dL5F5mlOhNH
        EkcpAYetlVrWabuhg3XIx+rexyJ4vkXBs3nvpYyHYBXrQERjTQmz6yjhN4eYV/XdUYAdU7
        TODN4DbUPIdFmh0dFL0Vi6z8RHwXKS8=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-ySXXF1pHMs29UTV9Hblo7w-1; Wed, 01 Jul 2020 18:14:46 -0400
X-MC-Unique: ySXXF1pHMs29UTV9Hblo7w-1
Received: by mail-pg1-f199.google.com with SMTP id e22so18991302pgl.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 15:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bQb32/SaJZufmc/q7s+tyKjNogq0Gy4EIBWlQy//p8M=;
        b=e9X/PvwWacj1/M8r8k7XYxd3dHkCly98dKbc7ZMovDpjRxXk7GOpE3cKhlIvBn/Y9/
         /7E2Oeb2xYakO2iCkMcxH+lX4NpAAfnMt2zNJdXV9npdZC9UuA0owP3qRvj82I60vV0D
         x4ga2eBYxAgsbgLpJoHLxlgWq/Kbj7bJCGVNNCQUeS/D+FGZ5DcKuQ8LEvDku34fwZOV
         pHREUaTpyOgsPHm9elNSzD6cWXfikV+12l6vHibLLlW8eTaIYWPiSoqnb1c1Z0OcBWEZ
         JLKtjzrqcg0s62DNJw4Q6CMlI+dwJRcIPmDYYTH2oGy3THkWzweGU/6Ttc3v5scR3tRO
         WPzQ==
X-Gm-Message-State: AOAM530lAhRTXO/wa6QviQCEEmwvvo1C0y26ngh542U4AtVti8Tds1/m
        Quhmb7yujkYXHdACv5zTnfcu4CGLqtt/XZbr8i3S2diGDgZxPSMwRmVHHtd2XNKtwLElKa6OEBg
        wAb5kkL15KdYEosF1oJTIogui
X-Received: by 2002:a17:902:fe11:: with SMTP id g17mr24013379plj.145.1593641684951;
        Wed, 01 Jul 2020 15:14:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFdvc/WtQ+mMt1LPHoxqyDf9VjA9s5BpTGQK1trOcKSTKxk2LHBrXcJPTmY4MjY2gBSv/yxw==
X-Received: by 2002:a17:902:fe11:: with SMTP id g17mr24013361plj.145.1593641684671;
        Wed, 01 Jul 2020 15:14:44 -0700 (PDT)
Received: from localhost ([110.227.183.4])
        by smtp.gmail.com with ESMTPSA id m12sm6091920pjf.17.2020.07.01.15.14.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 15:14:44 -0700 (PDT)
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
Subject: [PATCH 1/2] mm/memcontrol: Fix OOPS inside mem_cgroup_get_nr_swap_pages()
Date:   Thu,  2 Jul 2020 03:44:19 +0530
Message-Id: <1593641660-13254-2-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593641660-13254-1-git-send-email-bhsharma@redhat.com>
References: <1593641660-13254-1-git-send-email-bhsharma@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prabhakar reported an OOPS inside mem_cgroup_get_nr_swap_pages()
function in a corner case seen on some arm64 boards when kdump kernel
runs with "cgroup_disable=memory" passed to the kdump kernel via
bootargs.

The root-cause behind the same is that currently mem_cgroup_swap_init()
function is implemented as a subsys_initcall() call instead of a
core_initcall(), this means 'cgroup_memory_noswap' still
remains set to the default value (false) even when memcg is disabled via
"cgroup_disable=memory" boot parameter.

This may result in premature OOPS inside mem_cgroup_get_nr_swap_pages()
function in corner cases:

  [    0.265617] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000188
  [    0.274495] Mem abort info:
  [    0.277311]   ESR = 0x96000006
  [    0.280389]   EC = 0x25: DABT (current EL), IL = 32 bits
  [    0.285751]   SET = 0, FnV = 0
  [    0.288830]   EA = 0, S1PTW = 0
  [    0.291995] Data abort info:
  [    0.294897]   ISV = 0, ISS = 0x00000006
  [    0.298765]   CM = 0, WnR = 0
  [    0.301757] [0000000000000188] user address but active_mm is swapper
  [    0.308174] Internal error: Oops: 96000006 [#1] SMP
  [    0.313097] Modules linked in:
  <..snip..>
  [    0.331384] pstate: 00400009 (nzcv daif +PAN -UAO BTYPE=--)
  [    0.337014] pc : mem_cgroup_get_nr_swap_pages+0x9c/0xf4
  [    0.342289] lr : mem_cgroup_get_nr_swap_pages+0x68/0xf4
  [    0.347564] sp : fffffe0012b6f800
  [    0.350905] x29: fffffe0012b6f800 x28: fffffe00116b3000
  [    0.356268] x27: fffffe0012b6fb00 x26: 0000000000000020
  [    0.361631] x25: 0000000000000000 x24: fffffc00723ffe28
  [    0.366994] x23: fffffe0010d5b468 x22: fffffe00116bfa00
  [    0.372357] x21: fffffe0010aabda8 x20: 0000000000000000
  [    0.377720] x19: 0000000000000000 x18: 0000000000000010
  [    0.383082] x17: 0000000043e612f2 x16: 00000000a9863ed7
  [    0.388445] x15: ffffffffffffffff x14: 202c303d70617773
  [    0.393808] x13: 6f6e5f79726f6d65 x12: 6d5f70756f726763
  [    0.399170] x11: 2073656761705f70 x10: 6177735f726e5f74
  [    0.404533] x9 : fffffe00100e9580 x8 : fffffe0010628160
  [    0.409895] x7 : 00000000000000a8 x6 : fffffe00118f5e5e
  [    0.415258] x5 : 0000000000000001 x4 : 0000000000000000
  [    0.420621] x3 : 0000000000000000 x2 : 0000000000000000
  [    0.425983] x1 : 0000000000000000 x0 : fffffc0060079000
  [    0.431346] Call trace:
  [    0.433809]  mem_cgroup_get_nr_swap_pages+0x9c/0xf4
  [    0.438735]  shrink_lruvec+0x404/0x4f8
  [    0.442516]  shrink_node+0x1a8/0x688
  [    0.446121]  do_try_to_free_pages+0xe8/0x448
  [    0.450429]  try_to_free_pages+0x110/0x230
  [    0.454563]  __alloc_pages_slowpath.constprop.106+0x2b8/0xb48
  [    0.460366]  __alloc_pages_nodemask+0x2ac/0x2f8
  [    0.464938]  alloc_page_interleave+0x20/0x90
  [    0.469246]  alloc_pages_current+0xdc/0xf8
  [    0.473379]  atomic_pool_expand+0x60/0x210
  [    0.477514]  __dma_atomic_pool_init+0x50/0xa4
  [    0.481910]  dma_atomic_pool_init+0xac/0x158
  [    0.486220]  do_one_initcall+0x50/0x218
  [    0.490091]  kernel_init_freeable+0x22c/0x2d0
  [    0.494489]  kernel_init+0x18/0x110
  [    0.498007]  ret_from_fork+0x10/0x18
  [    0.501614] Code: aa1403e3 91106000 97f82a27 14000011 (f940c663)
  [    0.507770] ---[ end trace 9795948475817de4 ]---
  [    0.512429] Kernel panic - not syncing: Fatal exception
  [    0.517705] Rebooting in 10 seconds..

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
 mm/memcontrol.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 19622328e4b5..8323e4b7b390 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7186,6 +7186,13 @@ static struct cftype memsw_files[] = {
 	{ },	/* terminate */
 };
 
+/*
+ * If mem_cgroup_swap_init() is implemented as a subsys_initcall()
+ * instead of a core_initcall(), this could mean cgroup_memory_noswap still
+ * remains set to false even when memcg is disabled via "cgroup_disable=memory"
+ * boot parameter. This may result in premature OOPS inside 
+ * mem_cgroup_get_nr_swap_pages() function in corner cases.
+ */
 static int __init mem_cgroup_swap_init(void)
 {
 	/* No memory control -> no swap control */
@@ -7200,6 +7207,6 @@ static int __init mem_cgroup_swap_init(void)
 
 	return 0;
 }
-subsys_initcall(mem_cgroup_swap_init);
+core_initcall(mem_cgroup_swap_init);
 
 #endif /* CONFIG_MEMCG_SWAP */
-- 
2.7.4

