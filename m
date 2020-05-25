Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF2DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FFC220878
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391065AbgEYOv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 10:51:27 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:33964 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390995AbgEYOvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:51:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TzckEPv_1590418275;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0TzckEPv_1590418275)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 25 May 2020 22:51:15 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [RFC PATCH 5/5] x86/hw_breakpoint: Prevent data breakpoints on debug_idt_table
Date:   Mon, 25 May 2020 14:51:02 +0000
Message-Id: <20200525145102.122557-6-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200525145102.122557-1-laijs@linux.alibaba.com>
References: <20200525145102.122557-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A data breakpoint on the IDT is terrifying and should be avoided.
The IDT on CPU entry area is already protected. The debug IDT
should be also protected, although it is seldom used and only
used for short time.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
Please drop this patch when Peter's work to remove debug_idt_table
is merged.

 arch/x86/kernel/hw_breakpoint.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index 9579bd6fb589..83d8b1fcbc76 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -284,6 +284,11 @@ static inline bool within_cpu_entry(unsigned long addr, unsigned long end)
 			return true;
 	}
 
+	/* debug_idt_table is used when load_debug_idt() */
+	if (within_area(addr, end, (unsigned long)debug_idt_table,
+			sizeof(debug_idt_table[0]) * IDT_ENTRIES))
+		return true;
+
 	return false;
 }
 
-- 
2.20.1

