Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4135C35280
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 01:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 868EB20725
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 01:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgEHBsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 21:48:10 -0400
Received: from mail1.windriver.com ([147.11.146.13]:32858 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgEHBsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 21:48:10 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 0481lvLQ004206
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Thu, 7 May 2020 18:47:57 -0700 (PDT)
Received: from pek-lpggp2 (128.224.153.75) by ALA-HCB.corp.ad.wrs.com
 (147.11.189.41) with Microsoft SMTP Server id 14.3.487.0; Thu, 7 May 2020
 18:47:41 -0700
Received: by pek-lpggp2 (Postfix, from userid 20544)    id 0C0C0721D10; Fri,  8
 May 2020 09:47:10 +0800 (CST)
From:   Jiping Ma <jiping.ma2@windriver.com>
To:     <will.deacon@arm.com>, <paul.gortmaker@windriver.com>,
        <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
        <jiping.ma2@windriver.com>, <bruce.ashfield@gmail.com>,
        <yue.tao@windriver.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <zhe.he@windriver.com>
Subject: [PATCH] perf: perf can not parser the backtrace of app with dwarf mode in the 32bit system and 64bit kernel.
Date:   Fri, 8 May 2020 09:47:10 +0800
Message-ID: <1588902430-250663-1-git-send-email-jiping.ma2@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Record PC value from regs[15], it should be regs[32] in REGS_ABI_32 mode,
which cause perf parser the backtrace failed.

Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
---
 arch/arm64/kernel/perf_regs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
index 0bbac61..4e5c68e 100644
--- a/arch/arm64/kernel/perf_regs.c
+++ b/arch/arm64/kernel/perf_regs.c
@@ -32,6 +32,10 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 	if ((u32)idx == PERF_REG_ARM64_PC)
 		return regs->pc;
 
+	if (perf_reg_abi(current) == PERF_SAMPLE_REGS_ABI_32
+		&& idx == 15)
+		idx = PERF_REG_ARM64_PC;
+
 	return regs->regs[idx];
 }
 
-- 
1.9.1

