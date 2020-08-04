Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8777BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75F4921744
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgHDOPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:15:12 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:9833 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbgHDOPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:15:05 -0400
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 04 Aug 2020 07:15:05 -0700
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 04 Aug 2020 07:15:04 -0700
Received: from gkohli-linux.qualcomm.com ([10.204.78.26])
  by ironmsg01-blr.qualcomm.com with ESMTP; 04 Aug 2020 19:44:50 +0530
Received: by gkohli-linux.qualcomm.com (Postfix, from userid 427023)
        id 5DC1C486A; Tue,  4 Aug 2020 19:44:47 +0530 (IST)
From:   Gaurav Kohli <gkohli@codeaurora.org>
To:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        maz@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        neeraju@codeaurora.org, Gaurav Kohli <gkohli@codeaurora.org>
Subject: [PATCH] arm64: Skip apply SSBS call for non SSBS system
Date:   Tue,  4 Aug 2020 19:44:42 +0530
Message-Id: <1596550484-11029-1-git-send-email-gkohli@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a system where no cpu's implement SSBS, for
them no need to set pstate. This might help to save
few cpu cycles during context switch.

Signed-off-by: Gaurav Kohli <gkohli@codeaurora.org>

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 6089638..79f80f1 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -477,6 +477,13 @@ static void ssbs_thread_switch(struct task_struct *next)
 	struct pt_regs *regs = task_pt_regs(next);
 
 	/*
+	 * For Targets which don't have SSBS support, they
+	 * can return from here.
+	 */
+	if (!IS_ENABLED(CONFIG_ARM64_SSBD))
+		return;
+
+	/*
 	 * Nothing to do for kernel threads, but 'regs' may be junk
 	 * (e.g. idle task) so check the flags and bail early.
 	 */
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

