Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A0FC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 01:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BA1D20747
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 01:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgEGBFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 21:05:15 -0400
Received: from mail1.windriver.com ([147.11.146.13]:41706 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbgEGBFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 21:05:12 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 04714x0n014145
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Wed, 6 May 2020 18:04:59 -0700 (PDT)
Received: from pek-lpggp2 (128.224.153.75) by ALA-HCB.corp.ad.wrs.com
 (147.11.189.41) with Microsoft SMTP Server id 14.3.487.0; Wed, 6 May 2020
 18:04:39 -0700
Received: by pek-lpggp2 (Postfix, from userid 20544)    id C7017721D10; Thu,  7
 May 2020 09:04:08 +0800 (CST)
From:   Jiping Ma <jiping.ma2@windriver.com>
To:     <will.deacon@arm.com>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <jiping.ma2@windriver.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] perf: perf can not parser the backtrace of app with dwarf mode in the 32bit system and 64bit kernel.
Date:   Thu, 7 May 2020 09:04:08 +0800
Message-ID: <1588813448-161858-1-git-send-email-jiping.ma2@windriver.com>
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
index 0bbac61..04088e6 100644
--- a/arch/arm64/kernel/perf_regs.c
+++ b/arch/arm64/kernel/perf_regs.c
@@ -32,6 +32,10 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 	if ((u32)idx == PERF_REG_ARM64_PC)
 		return regs->pc;
 
+	if (perf_reg_abi(current) == PERF_SAMPLE_REGS_ABI_32
+		&& idx == 15)
+		return regs->regs[PERF_REG_ARM64_PC];
+
 	return regs->regs[idx];
 }
 
-- 
1.9.1

