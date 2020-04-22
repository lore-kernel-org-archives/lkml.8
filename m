Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC5AC55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F6252077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587549700;
	bh=X7tkqdwf/gdG2Xy9w+W21yJY2bhLGPbO3mQXETkAvbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t8ceBCzvhT4clIpjLXwJioxYGDRZNEo5G6/keaan852g3pd8YLzRDZxuV+OhC7u/c
	 qLFfaZRumiJdTEJd14VEMd8jdhdLOuOEfTxjVjv2NpSoWTdbaDwcRExFdyqejlheWR
	 FCgXrQAAQmgCSdZAX5xk5pAXqRJzx0F641DZF6b8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgDVKBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:01:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbgDVKBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:01:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A0902076C;
        Wed, 22 Apr 2020 10:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587549694;
        bh=X7tkqdwf/gdG2Xy9w+W21yJY2bhLGPbO3mQXETkAvbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VFJDJWfbWPzJNUMgOzT1/CmsCGiFjgBZtCpmjVLXGWpP1MphyseHlazlLySW33w+w
         52VpZeg/pVk1nVCnLkYt/ID2+6z4KZfDctu5pljgpmgEa97/z5NE6iUMTf9KddCLse
         //sUiUtQMCfw04VZZfn4DMmFPziDrm0xQ/+RF4YU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>
Subject: [PATCH 4.4 069/100] x86/mitigations: Clear CPU buffers on the SYSCALL fast path
Date:   Wed, 22 Apr 2020 11:56:39 +0200
Message-Id: <20200422095035.514854526@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095022.476101261@linuxfoundation.org>
References: <20200422095022.476101261@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

The fast SYSCALL exit path returns with SYSRET to userspace after
verifying that there's no pending work. MDS mitigation mandates that CPU
buffers must be cleared on transition from kernel to userspace so do
that here too.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/entry/entry_64.S        |    2 ++
 arch/x86/include/asm/spec-ctrl.h |    2 ++
 arch/x86/kernel/cpu/bugs.c       |    5 +++++
 3 files changed, 9 insertions(+)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -218,6 +218,8 @@ entry_SYSCALL_64_fastpath:
 	testl	$_TIF_ALLWORK_MASK, ASM_THREAD_INFO(TI_flags, %rsp, SIZEOF_PTREGS)
 	jnz	int_ret_from_sys_call_irqs_off	/* Go to the slow path */
 
+	call	mds_user_clear_buffers
+
 	movq	RIP(%rsp), %rcx
 	movq	EFLAGS(%rsp), %r11
 	RESTORE_C_REGS_EXCEPT_RCX_R11
--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -85,4 +85,6 @@ static inline void speculative_store_byp
 extern void speculation_ctrl_update(unsigned long tif);
 extern void speculation_ctrl_update_current(void);
 
+extern void mds_user_clear_buffers(void);
+
 #endif
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -263,6 +263,11 @@ static int __init mds_cmdline(char *str)
 }
 early_param("mds", mds_cmdline);
 
+void mds_user_clear_buffers(void)
+{
+	mds_user_clear_cpu_buffers();
+}
+
 #undef pr_fmt
 #define pr_fmt(fmt)	"TAA: " fmt
 


