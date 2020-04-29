Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845E9C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 04:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 669862070B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 04:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgD2EDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 00:03:46 -0400
Received: from mail5.windriver.com ([192.103.53.11]:55984 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbgD2EDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 00:03:46 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 03T429Dc016366
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Tue, 28 Apr 2020 21:02:45 -0700
Received: from pek-lpggp2 (128.224.153.75) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.487.0; Tue, 28 Apr 2020
 21:02:21 -0700
Received: by pek-lpggp2 (Postfix, from userid 20544)    id 9CBF2721D81; Wed, 29
 Apr 2020 12:01:51 +0800 (CST)
From:   Jiping Ma <jiping.ma2@windriver.com>
To:     <will.deacon@arm.com>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <jiping.ma2@windriver.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] perf: perf can not parser the backtrace of app in the 32bit system and 64bit kernel.
Date:   Wed, 29 Apr 2020 12:01:51 +0800
Message-ID: <1588132911-64901-1-git-send-email-jiping.ma2@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Record PC value from regs[15], it should be regs[32], which cause perf
parser the backtrace failed.

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

