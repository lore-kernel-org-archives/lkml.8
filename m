Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60746C2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 04:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3DB22464
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 04:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JNLE/o0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgBGEil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 23:38:41 -0500
Received: from mail-vk1-f201.google.com ([209.85.221.201]:36461 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGEil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 23:38:41 -0500
Received: by mail-vk1-f201.google.com with SMTP id j25so494937vkn.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 20:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=sBK5cpzGHdIvUKaHqM1DgwIph0gnDXoiKcHaONWU+rA=;
        b=JNLE/o0Uutt+U6wL5PzjCJyy0nAXeXri1cda0G4JS4P2v+vnWMR4H1/o1TiBn6vL2Q
         3nh6zs+he2dhoU7JvePW9hMesQWhf+nQ4QeV2R1+pAWb1j8l/0y/3IbSn/q2vSvJkIUg
         yp6UOMAItxzc3ikmNvNi/EjU7VCnwQnuFfOauHXY7hVC18TsSOfhPrLEBww8lXYiTJj0
         QLRXTvwbyQCFyx9oGwusnk4SejUp7OSYMW3bc+u84gjVz7PcIeoSp9ygOZWshFdo0r5v
         S1TjfkhPAga2GgrGPhHz/xSqAJmQ/HIWuVY2E4VbRbzCQtx8GoXjIKFp3RRYfj8wHDPd
         Lerw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=sBK5cpzGHdIvUKaHqM1DgwIph0gnDXoiKcHaONWU+rA=;
        b=STKM/yiQoFMBFZwY4DPNT9C0Bv86UynJ0+AtsPZz8zjIyhO9BHFadttLBzwc3NY/kr
         XsP3FPUFbIeDmWSSiSO47sFrHhpP18IA2T9BC8DPFfaE6hNvkGHN4voOll/TKMnm9Z/D
         WVQy7pw694TPukniUHUxUXD7yoxoLZ7kHDhcQ2o4Tf4adxdFRyU3Y1d7KPpDi6HYtJax
         9ntF8nt6reOuhLKRNZMO7rAzY20a/gGisD/tBsYFB393sxHkwCOVhVnTySZT7MOdmbOS
         e4aNigzQvElTA/YoXXxzYbqp58BdppASFygXw6YwEQtWS5pikZ86GTvnKkbEoFEI18Cy
         +ieQ==
X-Gm-Message-State: APjAAAX4K68yNW3PbYtZ6yiywYoykDbASfpSvdTFNS7ZIZNIwf6fieQt
        rEiKaXWUeze2y6DurzF5d7cZqUJyfVbiUA==
X-Google-Smtp-Source: APXvYqz+0+eoXFKnJHGjg2TE/rXwFQoeel6t7oQy5zR3utAoabzfg9B7Y+7SFYfhPtyFhUEPx2iv996F+nPqKw==
X-Received: by 2002:a1f:bd8d:: with SMTP id n135mr3841794vkf.88.1581050319527;
 Thu, 06 Feb 2020 20:38:39 -0800 (PST)
Date:   Thu,  6 Feb 2020 20:38:36 -0800
Message-Id: <20200207043836.106657-1-edumazet@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH] x86/traps: do not hash pointers in handle_stack_overflow()
From:   Eric Dumazet <edumazet@google.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mangling stack pointers in handle_stack_overflow() is moot,
as registers (including RSP/RBP) are clear anyway.

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
---
 arch/x86/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 6ef00eb6fbb925e86109f86845e2b3ccef4023ec..44873df292bd3f9f77bb721c53cb8a1c40994cca 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -296,7 +296,7 @@ __visible void __noreturn handle_stack_overflow(const char *message,
 						struct pt_regs *regs,
 						unsigned long fault_address)
 {
-	printk(KERN_EMERG "BUG: stack guard page was hit at %p (stack is %p..%p)\n",
+	printk(KERN_EMERG "BUG: stack guard page was hit at %px (stack is %px..%px)\n",
 		 (void *)fault_address, current->stack,
 		 (char *)current->stack + THREAD_SIZE - 1);
 	die(message, regs, 0);
-- 
2.25.0.341.g760bfbb309-goog

