Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8514BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A9F921841
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593266306;
	bh=C4CZ/M9ITZrqQHLFJzKFmKmEbF1OrOch6eNdkBtZKo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BXVZyMksl2qNjH5IgllgYQrGjTSt/lD1kh9IBf1pcnUQqtTrf19xS6Bj4SHGlXPoJ
	 rx1HraduZhQXvvzTcCYF4ZajwXOTCd0v54u6fbXnbwubVNfZHl9CCg5H19DRopGBtc
	 AhXT8KniQb6xeB4bk5WpbuQY6ouP0O8n8oNLnjYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgF0N6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 09:58:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbgF0N6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 09:58:22 -0400
Received: from localhost.localdomain (unknown [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE7E9217A0;
        Sat, 27 Jun 2020 13:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593266301;
        bh=C4CZ/M9ITZrqQHLFJzKFmKmEbF1OrOch6eNdkBtZKo8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1U9JIwpNBKNId0ocS+ly2ORX2r31nzZUZ96BVG8/7+8oeNW7uvIJ8o4WJIXNIFha3
         IVLaNnWEyIk7EkpJWdh/FfsGa1GIAjWJI4WgtvTjT5KxVou+SfjgWuezFbxFTh8KxY
         Neqp9iQh4IVGT1wUfU/kky3w1rWg5YOXw4vNCkzA=
From:   guoren@kernel.org
To:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        anup@brainfault.org, greentime.hu@sifive.com, zong.li@sifive.com,
        aou@eecs.berkeley.edu, tglx@linutronix.de, tycho@tycho.ws,
        nickhu@andestech.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 2/3] riscv: Fixup lockdep_assert_held with wrong param cpu_running
Date:   Sat, 27 Jun 2020 13:57:07 +0000
Message-Id: <1593266228-61125-3-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593266228-61125-1-git-send-email-guoren@kernel.org>
References: <1593266228-61125-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zong Li <zong.li@sifive.com>

The cpu_running is not a lock-class, it lacks the dep_map member in
completion. It causes the error as follow:

arch/riscv/kernel/smpboot.c: In function '__cpu_up':
./include/linux/lockdep.h:364:52: error: 'struct completion' has no member named 'dep_map'
  364 | #define lockdep_is_held(lock)  lock_is_held(&(lock)->dep_map)
      |                                                    ^~
./include/asm-generic/bug.h:113:25: note: in definition of macro 'WARN_ON'
  113 |  int __ret_warn_on = !!(condition);    \
      |                         ^~~~~~~~~
./include/linux/lockdep.h:390:27: note: in expansion of macro 'lockdep_is_held'
  390 |   WARN_ON(debug_locks && !lockdep_is_held(l)); \
      |                           ^~~~~~~~~~~~~~~
arch/riscv/kernel/smpboot.c:118:2: note: in expansion of macro 'lockdep_assert_held'
  118 |  lockdep_assert_held(&cpu_running);

There are a lot of archs which use cpu_running in smpboot.c (arm,
arm64, openrisc, xtensa, s390, x86, mips), but none of them try
lockdep_assert_held(&cpu_running.wait.lock). So Just remove it.

Signed-off-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/kernel/smpboot.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 4e99227..defc4e1 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -121,7 +121,6 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 
 	ret = start_secondary_cpu(cpu, tidle);
 	if (!ret) {
-		lockdep_assert_held(&cpu_running);
 		wait_for_completion_timeout(&cpu_running,
 					    msecs_to_jiffies(1000));
 
-- 
2.7.4

