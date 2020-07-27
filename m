Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D7CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4578020809
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 21:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcQwbCob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgG0Vir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 17:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgG0Viq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 17:38:46 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A49FC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 14:38:46 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id m9so8219631qvx.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 14:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OBPW13q5QlzlSrMzZgbTLPGHsSTa3HJ7NZm2XA+DWro=;
        b=IcQwbCobh7vNkJkcr8tb+vx7W74HheX2L8Fr7dpZ/em+hbTwhHjTLmVR+cPsFn6OsS
         gPOStCmf9ky3UPVmE+InLyxIWDCcHAS77jlOJpw0ym4EqJyydFZ8mDhkIIfnsBfVTLMK
         USUO2V1Pn8scghR4r3f87qt6DArxNQxzZd/Dlu0LiMs7L1FQR4Q8or8lgs7hH0e4qzS7
         7QK0AhL4agBclZPMj6pGcJLOYAV9Ru8R4+qRTdJHOYEj5JExzL9ACW2pXGvB2C/F4u+t
         LksyLeCqSowFyLoejfb9YdEZFCQLPt7IMNUxVKhgdiI2FP27N8A3XU5tPFjxdUTwadTU
         rx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OBPW13q5QlzlSrMzZgbTLPGHsSTa3HJ7NZm2XA+DWro=;
        b=Dcg8TZmk+27XGnZU7aM4VM1QXWYvShXbjMm7x2qdxORTEHbD31RI2V74Kw1m+H1E0E
         8C9eYvjvTasB22scRzcq11/UOOXCSEyZWemBdZh4pFQhuEEpVxBiIWrCDv314G/lSfpI
         x2YeA1X8zRyyRgPPEDs4f6+9kHJX3oNmESZW1rMbsAI2mUVd2O2irAmDDvcyJ1kQYK10
         zT+I5ULEqX1GQAISjbKQJ7Ec8ETM0aMSe14ZSY23hjwUALgXx4pYE1UBDGlJa9oX7H/E
         EkcgS8bdCCKuhOmcKanE+Elc4Hogn0Q8DdaisCtH4XJeskm2hgCGbL1v/CeRPi66Lbku
         PNFg==
X-Gm-Message-State: AOAM530A4Fe6rY598h23eeOHKsBifjA9Gu52PW4hBNYNNjdthtN7ZrL6
        mMe44Bm39LjHVk0xcY6++w==
X-Google-Smtp-Source: ABdhPJztgREWPYXpbY24y3xYJ2ab/diXDmx2tovh1N/94fVvWPtBBHR0/+nE3r/ezlx7C21gRN1SYQ==
X-Received: by 2002:ad4:5748:: with SMTP id q8mr23598337qvx.1.1595885925464;
        Mon, 27 Jul 2020 14:38:45 -0700 (PDT)
Received: from localhost.localdomain ([209.94.141.207])
        by smtp.gmail.com with ESMTPSA id y7sm17423217qta.36.2020.07.27.14.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 14:38:44 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: [Linux-kernel-mentees] [PATCH] ptrace: Prevent kernel-infoleak in ptrace_get_syscall_info()
Date:   Mon, 27 Jul 2020 17:36:44 -0400
Message-Id: <20200727213644.328662-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ptrace_get_syscall_info() is copying uninitialized stack memory to
userspace due to the compiler not initializing holes in statically
allocated structures. Fix it by initializing `info` with memset().

Cc: stable@vger.kernel.org
Fixes: 201766a20e30 ("ptrace: add PTRACE_GET_SYSCALL_INFO request")
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
 kernel/ptrace.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 43d6179508d6..e48d05b765b5 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -960,15 +960,17 @@ ptrace_get_syscall_info(struct task_struct *child, unsigned long user_size,
 			void __user *datavp)
 {
 	struct pt_regs *regs = task_pt_regs(child);
-	struct ptrace_syscall_info info = {
-		.op = PTRACE_SYSCALL_INFO_NONE,
-		.arch = syscall_get_arch(child),
-		.instruction_pointer = instruction_pointer(regs),
-		.stack_pointer = user_stack_pointer(regs),
-	};
+	struct ptrace_syscall_info info;
 	unsigned long actual_size = offsetof(struct ptrace_syscall_info, entry);
 	unsigned long write_size;
 
+	memset(&info, 0, sizeof(info));
+
+	info.op	= PTRACE_SYSCALL_INFO_NONE;
+	info.arch = syscall_get_arch(child);
+	info.instruction_pointer = instruction_pointer(regs);
+	info.stack_pointer = user_stack_pointer(regs);
+
 	/*
 	 * This does not need lock_task_sighand() to access
 	 * child->last_siginfo because ptrace_freeze_traced()
-- 
2.25.1

