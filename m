Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B18CC4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF8F20838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/A6/rCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgBZW5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 17:57:00 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45293 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgBZW47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 17:56:59 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so520286pfg.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 14:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pdWVOw3XbP9rnJNpBWicc5Lm1aX3lGrV8mP9d8FqVX4=;
        b=a/A6/rCoSO3AEeorvAoIiFDSyMkth38Q4wbPm8ZYRKFJdpUCBdxKiywuOmA4pC3tvc
         pAILl6lTGpIICjVWMjx83+oF5QjalA4G6ShShcVbMn7Cipge8d3ufWtqdTInYoLBfmeE
         cpHZrcprqeqMzTEgcQqdkNXsBa/QbbvqsjLnyFSlGVoDZbVGEKLGdcNfXGxOod3AWBVg
         fIvtCWfrJ/c3HPblRDEK0l2RBmtc1M2b78uvos4GRTBfknLjUSjFZ6bC5KZteXc3n45/
         vP51Yye8a2jur90D7nDUDLdsjBxPKbcmwgla87aPIkxHhrN7emRr0tDiqE9QhFlsNrfS
         F25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pdWVOw3XbP9rnJNpBWicc5Lm1aX3lGrV8mP9d8FqVX4=;
        b=eCjmhYNA6uNrE1GRuS506F3aZAJvvbIssDK8+yU1BQqcVSC9C9SQbhzOGojr8wW/4M
         IBsLfuLXrddAUJQIk5hXfbuyqWHQsz0pZTiUfxvUlDCC1ebVcjhZ99emJfeZ1U1fgJlI
         lWHIYsS18EbS6me79GB6+i2TLVSNVjqoAsdaNGqzQDFTdPqTzED6gUwAAttMhJHB6f2C
         Cu7+iW5KBgEmFOCalll7DvsfBYLYRvAAemDxkO8mLZSE6Ghdp4128hQ3vFJPMcKHgeJu
         8s5wvziCiSjt2RzUZVCbqpdu9+MhDt2MkQnaH4ROC6b7nJlm1Z66rVuZ8FCrDHjVl+qC
         2y3w==
X-Gm-Message-State: APjAAAVHh1p0fplRg3t5MI0h+UqWHSWQ/R9aQbxdscfYXN6dqomCIPUi
        9T76vgchQWM8qbJGk2CTyw7T4SJJji4=
X-Google-Smtp-Source: APXvYqwsYxZKJyp01pvqLvjYh0AU2nXwiOUIbz6J3L7PEiflTZJNw2/fDMVEX0Dz5/wpKy5R3T3ILg==
X-Received: by 2002:a63:3c46:: with SMTP id i6mr1060690pgn.413.1582757817192;
        Wed, 26 Feb 2020 14:56:57 -0800 (PST)
Received: from localhost (g183.222-224-185.ppp.wakwak.ne.jp. [222.224.185.183])
        by smtp.gmail.com with ESMTPSA id v7sm3979771pfn.61.2020.02.26.14.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 14:56:56 -0800 (PST)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>
Cc:     Stafford Horne <shorne@gmail.com>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Christian Brauner <christian@brauner.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>
Subject: [PATCH 3/3] openrisc: Cleanup copy_thread_tls docs and comments
Date:   Thu, 27 Feb 2020 07:56:25 +0900
Message-Id: <20200226225625.28935-4-shorne@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200226225625.28935-1-shorne@gmail.com>
References: <20200226225625.28935-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously copy_thread_tls was copy_thread and before that something
else.  Remove the documentation about the regs parameter that didn't
exist in either version.

Next, fix comment wrapping and details about how TLS pointer gets to the
copy_thread_tls function.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index 6695f167e126..b442e7b59e17 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -122,7 +122,6 @@ extern asmlinkage void ret_from_fork(void);
  * @usp: user stack pointer or fn for kernel thread
  * @arg: arg to fn for kernel thread; always NULL for userspace thread
  * @p: the newly created task
- * @regs: CPU context to copy for userspace thread; always NULL for kthread
  * @tls: the Thread Local Storate pointer for the new process
  *
  * At the top of a newly initialized kernel stack are two stacked pt_reg
@@ -180,7 +179,8 @@ copy_thread_tls(unsigned long clone_flags, unsigned long usp,
 			userregs->sp = usp;
 
 		/*
-		 * For CLONE_SETTLS set "tp" (r10) to the TLS pointer passed to sys_clone.
+		 * For CLONE_SETTLS set "tp" (r10) to the TLS pointer passed
+		 * in clone_args to sys_clone3.
 		 */
 		if (clone_flags & CLONE_SETTLS)
 			userregs->gpr[10] = tls;
-- 
2.21.0

