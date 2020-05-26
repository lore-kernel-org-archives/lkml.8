Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AE3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 01:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADE78207DA
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 01:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388510AbgEZBmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 21:42:43 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:40486 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388442AbgEZBml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 21:42:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0TzfuFzj_1590457357;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0TzfuFzj_1590457357)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 May 2020 09:42:37 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Changbin Du <changbin.du@intel.com>,
        Martin Molnar <martin.molnar.programming@gmail.com>
Subject: [RFC PATCH V2 6/7] x86/entry: is_debug_stack() don't check of DB1 stack
Date:   Tue, 26 May 2020 01:42:20 +0000
Message-Id: <20200526014221.2119-7-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200526014221.2119-1-laijs@linux.alibaba.com>
References: <20200525152517.GY325280@hirez.programming.kicks-ass.net>
 <20200526014221.2119-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IST-shift code is removed from entry code, #DB will not
at DB1 stack. So we remove the check of DB1 stack in
is_debug_stack().

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/kernel/nmi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 1c58454ac5fb..2f463f5880c6 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -500,15 +500,10 @@ static noinstr bool is_debug_stack(unsigned long addr)
 {
 	struct cea_exception_stacks *cs = __this_cpu_read(cea_exception_stacks);
 	unsigned long top = CEA_ESTACK_TOP(cs, DB);
-	unsigned long bot = CEA_ESTACK_BOT(cs, DB1);
+	unsigned long bot = CEA_ESTACK_BOT(cs, DB);
 
 	if (__this_cpu_read(debug_stack_usage))
 		return true;
-	/*
-	 * Note, this covers the guard page between DB and DB1 as well to
-	 * avoid two checks. But by all means @addr can never point into
-	 * the guard page.
-	 */
 	return addr >= bot && addr < top;
 }
 #endif
-- 
2.20.1

