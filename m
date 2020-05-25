Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46591C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DD4B2078B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390978AbgEYOvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 10:51:16 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:60593 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391026AbgEYOvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:51:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TzdBWj._1590418271;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0TzdBWj._1590418271)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 25 May 2020 22:51:11 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [RFC PATCH 3/5] x86/hw_breakpoint: Prevent data breakpoints on per_cpu cpu_tss_rw
Date:   Mon, 25 May 2020 14:51:00 +0000
Message-Id: <20200525145102.122557-4-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200525145102.122557-1-laijs@linux.alibaba.com>
References: <20200525145102.122557-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_tss_rw is not directly referenced by hardware, but
cpu_tss_rw is also used in CPU entry code, especially
when #DB shifts its stacks. If a data breakpoint is on
the cpu_tss_rw.x86_tss.ist[IST_INDEX_DB], it will cause
recursive #DB (and then #DF soon for #DB is generated
after the access, IST-shifting, is done).

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/kernel/hw_breakpoint.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index f859095c1b6c..7d3966b9aa12 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -255,6 +255,19 @@ static inline bool within_cpu_entry(unsigned long addr, unsigned long end)
 		if (within_area(addr, end, (unsigned long)get_cpu_gdt_rw(cpu),
 				GDT_SIZE))
 			return true;
+
+		/*
+		 * cpu_tss_rw is not directly referenced by hardware, but
+		 * cpu_tss_rw is also used in CPU entry code, especially
+		 * when #DB shifts its stacks. If a data breakpoint is on
+		 * the cpu_tss_rw.x86_tss.ist[IST_INDEX_DB], it will cause
+		 * recursive #DB (and then #DF soon for #DB is generated
+		 * after the access, IST-shifting, is done).
+		 */
+		if (within_area(addr, end,
+				(unsigned long)&per_cpu(cpu_tss_rw, cpu),
+				sizeof(struct tss_struct)))
+			return true;
 	}
 
 	return false;
-- 
2.20.1

