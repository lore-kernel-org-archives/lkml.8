Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6697C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E25524684
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996340;
	bh=ZgMGAjc1Tj8ADvk10RiUDnwnbLBquCBX3M4ZhVaYJVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Df0c/AYGxgw2eyvRCklMGTpi1BjRIhYjJm56W7ZiW7B/9/Vcjg0Qd3L1H4IqnMUCc
	 FzbzniDHkujRmCvz0BJbtaLfd5EIU4GEVn849W6eCyUXTqi1VueYvGzfm/dcHxcioG
	 cFIVJ2aVrZX4lmbHVhDMkgztS6pdPKX1OQ2Odbio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgANKFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:05:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:33796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729531AbgANKFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:05:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 137FD24683;
        Tue, 14 Jan 2020 10:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996335;
        bh=ZgMGAjc1Tj8ADvk10RiUDnwnbLBquCBX3M4ZhVaYJVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cI2vONeDyfFGleTYjJ4f1jl5Msn10wdq5zpPZwkhlH7+B6UWJuL6FysSZ0xu+YsZa
         j9OUlRVg2RmT5TkESYz9g/5LXPk+w7LiA9fudLciDmeoi/C3BK1Z0toOq3fCB0Q7KT
         xK1QH++EwhsjMcAZ4e7kKLOPxjViOkaJxKQ7bZuY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amanieu dAntras <amanieu@gmail.com>,
        linux-parisc@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 5.4 60/78] parisc: Implement copy_thread_tls
Date:   Tue, 14 Jan 2020 11:01:34 +0100
Message-Id: <20200114094401.489409411@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094352.428808181@linuxfoundation.org>
References: <20200114094352.428808181@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amanieu d'Antras <amanieu@gmail.com>

commit d2f36c787b2181561d8b95814f8cdad64b348ad7 upstream.

This is required for clone3 which passes the TLS value through a
struct rather than a register.

Signed-off-by: Amanieu d'Antras <amanieu@gmail.com>
Cc: linux-parisc@vger.kernel.org
Cc: <stable@vger.kernel.org> # 5.3.x
Link: https://lore.kernel.org/r/20200102172413.654385-5-amanieu@gmail.com
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/parisc/Kconfig          |    1 +
 arch/parisc/kernel/process.c |    8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -62,6 +62,7 @@ config PARISC
 	select HAVE_FTRACE_MCOUNT_RECORD if HAVE_DYNAMIC_FTRACE
 	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
+	select HAVE_COPY_THREAD_TLS
 
 	help
 	  The PA-RISC microprocessor is designed by Hewlett-Packard and used
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -208,8 +208,8 @@ arch_initcall(parisc_idle_init);
  * Copy architecture-specific thread state
  */
 int
-copy_thread(unsigned long clone_flags, unsigned long usp,
-	    unsigned long kthread_arg, struct task_struct *p)
+copy_thread_tls(unsigned long clone_flags, unsigned long usp,
+	    unsigned long kthread_arg, struct task_struct *p, unsigned long tls)
 {
 	struct pt_regs *cregs = &(p->thread.regs);
 	void *stack = task_stack_page(p);
@@ -254,9 +254,9 @@ copy_thread(unsigned long clone_flags, u
 		cregs->ksp = (unsigned long)stack + THREAD_SZ_ALGN + FRAME_SIZE;
 		cregs->kpc = (unsigned long) &child_return;
 
-		/* Setup thread TLS area from the 4th parameter in clone */
+		/* Setup thread TLS area */
 		if (clone_flags & CLONE_SETTLS)
-			cregs->cr27 = cregs->gr[23];
+			cregs->cr27 = tls;
 	}
 
 	return 0;


