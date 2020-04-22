Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9EAC5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1BF820781
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551600;
	bh=Le5r4ZEgqHViB7UDMuTUHMRwchWcpxKe6N8tGPIdKdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1AS63SROFYU8XmyQxe1n+/1y5jkVv65TcSed5KrSCoB/rVv3Uu0aUW4MSfraSwaKk
	 m+B+nIo0KsNjcMa+IQ5JXxhzoRqzk6WM0LAh6gVkjDVMUXK45pCKpMmy2o6oU+tR6T
	 xHk8T3m3WwC+mMQ1OOUDTzn1m/FQmEDE9c4DIdt4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731186AbgDVKdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:33:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730469AbgDVKYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:24:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C8612075A;
        Wed, 22 Apr 2020 10:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587551091;
        bh=Le5r4ZEgqHViB7UDMuTUHMRwchWcpxKe6N8tGPIdKdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WMBB5Wk/NxtyZGcGww71Ovn1Wkr74v+XaZLc7PRzfpIHNpVrMSDLahM8JBjKJMssP
         SG3hwdX4Zx/lQ4w0IYnDEqj+0hVErXKyTiVX9Yd2vA5aKvOHSPX/bbndZ+Bkc5GYJD
         krLTO2cEASTCSRt0Zmg9uK99PHerdyDLmbKyKRk0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 096/166] x86/xen: Make the boot CPU idle task reliable
Date:   Wed, 22 Apr 2020 11:57:03 +0200
Message-Id: <20200422095059.319186761@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095047.669225321@linuxfoundation.org>
References: <20200422095047.669225321@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miroslav Benes <mbenes@suse.cz>

[ Upstream commit 2f62f36e62daec43aa7b9633ef7f18e042a80bed ]

The unwinder reports the boot CPU idle task's stack on XEN PV as
unreliable, which affects at least live patching. There are two reasons
for this. First, the task does not follow the x86 convention that its
stack starts at the offset right below saved pt_regs. It allows the
unwinder to easily detect the end of the stack and verify it. Second,
startup_xen() function does not store the return address before jumping
to xen_start_kernel() which confuses the unwinder.

Amend both issues by moving the starting point of initial stack in
startup_xen() and storing the return address before the jump, which is
exactly what call instruction does.

Signed-off-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/xen/xen-head.S | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index 1d0cee3163e41..d63806e1ff7ae 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -35,7 +35,11 @@ SYM_CODE_START(startup_xen)
 	rep __ASM_SIZE(stos)
 
 	mov %_ASM_SI, xen_start_info
-	mov $init_thread_union+THREAD_SIZE, %_ASM_SP
+#ifdef CONFIG_X86_64
+	mov initial_stack(%rip), %rsp
+#else
+	mov pa(initial_stack), %esp
+#endif
 
 #ifdef CONFIG_X86_64
 	/* Set up %gs.
@@ -51,7 +55,7 @@ SYM_CODE_START(startup_xen)
 	wrmsr
 #endif
 
-	jmp xen_start_kernel
+	call xen_start_kernel
 SYM_CODE_END(startup_xen)
 	__FINIT
 #endif
-- 
2.20.1



