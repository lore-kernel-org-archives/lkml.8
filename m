Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85946C4742D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63E71206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595281447;
	bh=chd+ib/cbDlfiW7AeRJRwNrGF6lP5ILfJ2mmvVxKzfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lv2BK3LMeUjUYLFBnXM1IA9KASgf5SCnZYzCPTo4fnJXCNvErHO3lEEmQJ1IQDGae
	 6DlwZcXHIVv6tkmqFmqPwrj8FzrnbXApEvj20OAbHraGe99dnTA1JYlvs2QTDqvqAk
	 JF//yDNmPIBcWwyrvfAnjsTQRfpk1b4kRauOIILA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgGTViN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 17:38:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727914AbgGTVh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 17:37:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32AF122D03;
        Mon, 20 Jul 2020 21:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595281077;
        bh=chd+ib/cbDlfiW7AeRJRwNrGF6lP5ILfJ2mmvVxKzfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=psaDkPxty/vgZrSVyn4ynpl4FyUYxsSMsF2eumbTVoLKx8bkkui1wSx2x6SEMc82Y
         L08iMkCdnotonSKOwxNGXRbHparIXOE+cl8vQlkhWHXjGwxWmN0WXgJU6cNRA7/rLE
         zGFDTXRzibAwGqPj8lKMj0q/MMu9gfLyonlJnNlo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.7 34/40] arm64: Use test_tsk_thread_flag() for checking TIF_SINGLESTEP
Date:   Mon, 20 Jul 2020 17:37:09 -0400
Message-Id: <20200720213715.406997-34-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200720213715.406997-1-sashal@kernel.org>
References: <20200720213715.406997-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

[ Upstream commit 5afc78551bf5d53279036e0bf63314e35631d79f ]

Rather than open-code test_tsk_thread_flag() at each callsite, simply
replace the couple of offenders with calls to test_tsk_thread_flag()
directly.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/debug-monitors.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 48222a4760c2e..87fa932108ee3 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -393,14 +393,14 @@ void user_rewind_single_step(struct task_struct *task)
 	 * If single step is active for this thread, then set SPSR.SS
 	 * to 1 to avoid returning to the active-pending state.
 	 */
-	if (test_ti_thread_flag(task_thread_info(task), TIF_SINGLESTEP))
+	if (test_tsk_thread_flag(task, TIF_SINGLESTEP))
 		set_regs_spsr_ss(task_pt_regs(task));
 }
 NOKPROBE_SYMBOL(user_rewind_single_step);
 
 void user_fastforward_single_step(struct task_struct *task)
 {
-	if (test_ti_thread_flag(task_thread_info(task), TIF_SINGLESTEP))
+	if (test_tsk_thread_flag(task, TIF_SINGLESTEP))
 		clear_regs_spsr_ss(task_pt_regs(task));
 }
 
-- 
2.25.1

