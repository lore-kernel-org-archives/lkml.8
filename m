Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53618C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 14:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 377F9212CC
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 14:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgDSOlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 10:41:18 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:33441 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725793AbgDSOlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 10:41:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Tw-JNwQ_1587307258;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Tw-JNwQ_1587307258)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 19 Apr 2020 22:40:59 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Armijn Hemel <armijn@tjaldur.nl>
Subject: [PATCH 2/3] x86: remove address operator on function machine_check()
Date:   Sun, 19 Apr 2020 14:40:48 +0000
Message-Id: <20200419144049.1906-3-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419144049.1906-1-laijs@linux.alibaba.com>
References: <20200419144049.1906-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

machine_check is function address, the address operator
on it is nop for compiler.

Make it consistent with the other function addresses in the
same file.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/kernel/idt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 87ef69a72c52..98bcb502f967 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -93,7 +93,7 @@ static const __initconst struct idt_data def_idts[] = {
 	INTG(X86_TRAP_DB,		debug),
 
 #ifdef CONFIG_X86_MCE
-	INTG(X86_TRAP_MC,		&machine_check),
+	INTG(X86_TRAP_MC,		machine_check),
 #endif
 
 	SYSG(X86_TRAP_OF,		overflow),
@@ -186,7 +186,7 @@ static const __initconst struct idt_data ist_idts[] = {
 	ISTG(X86_TRAP_NMI,	nmi,		IST_INDEX_NMI),
 	ISTG(X86_TRAP_DF,	double_fault,	IST_INDEX_DF),
 #ifdef CONFIG_X86_MCE
-	ISTG(X86_TRAP_MC,	&machine_check,	IST_INDEX_MCE),
+	ISTG(X86_TRAP_MC,	machine_check,	IST_INDEX_MCE),
 #endif
 };
 
-- 
2.20.1

