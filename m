Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2052C04EB5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C644D214AF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YkjiS+ME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgBGPta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 10:49:30 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:37470 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgBGPt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 10:49:29 -0500
Received: by mail-pl1-f201.google.com with SMTP id t12so1494832plo.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 07:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=h3qfQ9LRi5N0qigJWfoGv8msgYMXUxdJ6Wg38GofYCI=;
        b=YkjiS+MEPCnpLguXWANVXOvT1xbFH5YPK5MdfmeJSjIaA+ULWbqphdPx0y9EkX01ra
         OFai7qOEOYfahypi895lsPxS5Hm452ZHqgjnbFNiAyWabGFSH7u4tVc6DBRGtiXgG0uI
         q8RswqxiiK+Xt5Ggu7zVj5mqDZr1a/Sf53rz0kJ5DVxTbEKAaR3D/13IysrzUVYmqQjk
         RrCe08X1sTdiYxxJie2tmqfNabIZwMZVi8BxLNsLeMn5HnatiL/PU2rYHYDp6W2Kf9rJ
         kaJIGy0SAiNJ2eu6wnKX1yImCzkERnX/ks7TNmHzyo9cjaZsONpQLcqyRsSXGKM5LcRG
         BywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=h3qfQ9LRi5N0qigJWfoGv8msgYMXUxdJ6Wg38GofYCI=;
        b=c/0veMDnaVctdq80bSjLyOUcHUEewlg2OYTDeNsip+7vRjN2eQyNuofO/EEKUet3LV
         +EZg1NLAhRRDAdt1aq8TiYsFUUVEuCtwOo5HuWGTO+NipTEdq/1ecJ/+DCn78MYldYbf
         hEYf32V11FWYv5ze9GxvqQAcEVLIihe61gR0jtx05Mu9wWNc48AIRNE0U+uZ5pOacIxi
         CSXr7AnNUbiQbpJ+BEtesWGb5pXXi8Mhn1GeS/Diop9P5AqSEG5G7dIr2ArIQ82tAmdi
         BLNZJpJR4gGiYymL0qN/JEW16/PGpPpm0W4vIs2IwyJn47+e53wx2qELYyHH7Qk7bF6/
         J4YQ==
X-Gm-Message-State: APjAAAWQwK2w8OeFrSPmOohhfoqk6SbzsJ5WLW1hLw7bZqnu/9GLQpSx
        zhYFkeQx94f1u9bO7nQJN5Yfeoc43U+9wg==
X-Google-Smtp-Source: APXvYqzPDRWfpWygEJxgEjlxpR10axRJBXoRLMy0FMJr5L4XAp9RkXazuSeIJwOTQPYzNPYxUv8t0BN7yM/yDQ==
X-Received: by 2002:a63:131e:: with SMTP id i30mr10159891pgl.43.1581090568932;
 Fri, 07 Feb 2020 07:49:28 -0800 (PST)
Date:   Fri,  7 Feb 2020 07:49:15 -0800
Message-Id: <20200207154915.83739-1-edumazet@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v2] x86/traps: do not hash pointers in handle_stack_overflow()
From:   Eric Dumazet <edumazet@google.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mangling stack pointers in handle_stack_overflow() is moot,
as registers (including RSP/RBP) are clear anyway.

Also switch to pr_emerg() as suggested by Thomas.

BUG: stack guard page was hit at 0000000063381e80 (stack is 000000008edc5696..0000000012256c50)
kernel stack overflow (double-fault): 0000 [#1] PREEMPT SMP KASAN
...
RSP: 0018:ffffc90002c1ffc0 EFLAGS: 00010802
RAX: 1ffff11004a0094c RBX: ffff888025004180 RCX: c9d82d1007bb146c
RDX: dffffc0000000000 RSI: ffff888025004a40 RDI: ffff888025004180
RBP: ffffc90002c201c0 R08: dffffc0000000000 R09: fffffbfff1405915
R10: fffffbfff1405915 R11: 0000000000000000 R12: ffff888025004a60
R13: ffff888025004a10 R14: c9d82d1007bb146c R15: ffff888025004180
...

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 6ef00eb6fbb925e86109f86845e2b3ccef4023ec..318df13e267638c4888f1c3f611aff34818b3bd2 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -296,7 +296,7 @@ __visible void __noreturn handle_stack_overflow(const char *message,
 						struct pt_regs *regs,
 						unsigned long fault_address)
 {
-	printk(KERN_EMERG "BUG: stack guard page was hit at %p (stack is %p..%p)\n",
+	pr_emerg("BUG: stack guard page was hit at %px (stack is %px..%px)\n",
 		 (void *)fault_address, current->stack,
 		 (char *)current->stack + THREAD_SIZE - 1);
 	die(message, regs, 0);
-- 
2.25.0.341.g760bfbb309-goog

