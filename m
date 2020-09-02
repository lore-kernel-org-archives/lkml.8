Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA86C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 08:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B7DA207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 08:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599036926;
	bh=mfoCecgG24RsRJtuuLU9UhUf+PeRc8u7kbA9jNUr3Sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oS7KuoFqbKhsBnfAOeExcSCVoC10j2R0Wjpn7QxdROTLMVSSHBy9nG03pg5Cn2wSd
	 EKlSkqtAlXa57Vnfkt13SWz/0PEk3aXPDoHZ/rtU1hHep1NUldUO+8MryNmBAU3dcn
	 A1u1wq8H0v2E5nQ8B0dz/N01CZ/yPGANnR3W5Tl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgIBIzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 04:55:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgIBIzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 04:55:23 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46C8420829;
        Wed,  2 Sep 2020 08:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599036923;
        bh=mfoCecgG24RsRJtuuLU9UhUf+PeRc8u7kbA9jNUr3Sg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Or5QcCAwzq6x4gNCiN/jJY8cGHk6oss/IQqwsQ2DgFAzDFjFnphL1v7y9mCWNlE3H
         sdTyHnZ6gAJPqhixWnnPNH8MsyJMm4gUzEJFxTfbRv9XqkBg39WNT8G3HwYTgkW/mV
         iRDxfOmMou/bl9qXReaej4UA+BN/yVdJNYTUehcw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH rdma-next 1/4] gcov: Open-code kmemdup() to work correctly with kernel and user space pointers
Date:   Wed,  2 Sep 2020 11:55:10 +0300
Message-Id: <20200902085513.748149-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902085513.748149-1-leon@kernel.org>
References: <20200902085513.748149-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The kernel with KASAN and GCOV enabled generates the following splat
due to the situation that gcov_info can be both user and kernel pointer.

It is triggered by the memcpy() inside kmemdup(), so as a possible solution
let's copy fields manually.

 ==================================================================
 BUG: KASAN: global-out-of-bounds in kmemdup+0x43/0x70
 Read of size 120 at addr ffffffffa0d2c780 by task modprobe/296

 CPU: 0 PID: 296 Comm: modprobe Not tainted 5.9.0-rc1+ #1860
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04 /01/2014
 Call Trace:
   dump_stack+0x128/0x1af
   print_address_description.constprop.0+0x2c/0x3f0
   _raw_spin_lock_irqsave+0x34/0xa0
   __kasan_check_read+0x1d/0x30
   kmemdup+0x43/0x70
   kmemdup+0x43/0x70
   gcov_info_dup+0x2d/0x730
   __kasan_check_write+0x20/0x30
   __mutex_unlock_slowpath+0x10d/0x740
   gcov_event+0x88d/0xd30
   gcov_module_notifier+0xe9/0x100
   notifier_call_chain+0xeb/0x170
   blocking_notifier_call_chain+0x75/0xc0
   __x64_sys_delete_module+0x326/0x5a0
   do_init_module+0x810/0x810
   syscall_enter_from_user_mode+0x40/0x420
   trace_hardirqs_on+0x45/0xb0
   syscall_enter_from_user_mode+0x40/0x420
   do_syscall_64+0x45/0x70
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

 The buggy address belongs to the variable:
  __gcov_.uverbs_attr_get_obj+0x60/0xfffffffffff778e0 [mlx5_ib]

 Memory state around the buggy address:
  ffffffffa0d2c680: 00 f9 f9 f9 f9 f9 f9 f9 00 00 00 00 00 f9 f9 f9
  ffffffffa0d2c700: f9 f9 f9 f9 00 00 00 00 00 f9 f9 f9 f9 f9 f9 f9
 >ffffffffa0d2c780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f9 f9
                                                              ^
  ffffffffa0d2c800: f9 f9 f9 f9 00 00 00 00 00 f9 f9 f9 f9 f9 f9 f9
  ffffffffa0d2c880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ==================================================================
 Disabling lock debugging due to kernel taint
 ---[ end trace 065ea9cc2ba144a6 ]---

Cc: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 kernel/gcov/gcc_4_7.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/gcov/gcc_4_7.c b/kernel/gcov/gcc_4_7.c
index 908fdf5098c3..6d706c5eed5c 100644
--- a/kernel/gcov/gcc_4_7.c
+++ b/kernel/gcov/gcc_4_7.c
@@ -275,13 +275,13 @@ struct gcov_info *gcov_info_dup(struct gcov_info *info)
 	size_t fi_size; /* function info size */
 	size_t cv_size; /* counter values size */

-	dup = kmemdup(info, sizeof(*dup), GFP_KERNEL);
+	dup = kzalloc(sizeof(*dup), GFP_KERNEL);
 	if (!dup)
 		return NULL;

-	dup->next = NULL;
-	dup->filename = NULL;
-	dup->functions = NULL;
+	for (fi_idx = 0; fi_idx < GCOV_COUNTERS; fi_idx++)
+		dup->merge[fi_idx] = info->merge[fi_idx];
+	dup->n_functions = info->n_functions;

 	dup->filename = kstrdup(info->filename, GFP_KERNEL);
 	if (!dup->filename)
--
2.26.2

