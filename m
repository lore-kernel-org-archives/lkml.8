Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3E1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAE4220781
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592934304;
	bh=rT4koIr7UtLX4GCIHsdvAcf7eYSMsgw4pKrRl6Cftnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IOTL0fKqVGV0D4kp7FSzR4i1YJVMJkSCAip4goj19syfB2PhxISMUck7+8dmVtmaZ
	 IZSaa+25UjPdpDt8ODnh5sjN5z0J7PH0qR5Wf2GUPtVKtJ/mBR1GQExEM5i6z3JhZS
	 rccdxHKhmAali/UIYXMcJIIpjLLhdWhehfyNfdoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733299AbgFWRpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:45:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733075AbgFWRpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:45:02 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9D9220780;
        Tue, 23 Jun 2020 17:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592934301;
        bh=rT4koIr7UtLX4GCIHsdvAcf7eYSMsgw4pKrRl6Cftnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l5UI7vjpirdxvGDLqNw/1mU19QdmERY4zDRkZsmsxsG7jkn0t8PYxKm9EyJfDNNX2
         9Kf7qBWpGJnpqkRLW+9uZF0eZlwyFyuvQvy7hoFAOGQHizWjaLoEZm228bJGIQVSb6
         8ug8T4uZ6cAHXLO4drT3YoUPzSkujvXYjcwYSfEI=
Date:   Tue, 23 Jun 2020 18:44:56 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Jiping Ma <Jiping.Ma2@windriver.com>, zhe.he@windriver.com,
        bruce.ashfield@gmail.com, yue.tao@windriver.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        paul.gortmaker@windriver.com, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH][V3] arm64: perf: Get the wrong PC value in REGS_ABI_32
 mode
Message-ID: <20200623174456.GA5087@willie-the-truck>
References: <1589165527-188401-1-git-send-email-jiping.ma2@windriver.com>
 <20200526102611.GA1363@C02TD0UTHF1T.local>
 <1e57ec27-1d54-c7cd-5e5b-6c0cc47f9891@windriver.com>
 <20200527151928.GC59947@C02TD0UTHF1T.local>
 <cd66a2e4-c953-8b09-b775-d982bb1be47a@windriver.com>
 <20200528075418.GB22156@willie-the-truck>
 <20200618130332.GA53391@C02TD0UTHF1T.local>
 <20200623171909.GC4819@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623171909.GC4819@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 06:19:10PM +0100, Will Deacon wrote:
> So, I think we should take this patch (which puts the PC where you'd expect
> to find it for compat tasks) and then we could consider removing the current
> lr/sp fudging as a separate patch, which we could revert if it causes a
> problem. However, I'm not sure I want to open that up.

Patch below...

Will

--->8

From 7452148b87ed8c82826474366dbe536fd960d3a7 Mon Sep 17 00:00:00 2001
From: Jiping Ma <jiping.ma2@windriver.com>
Date: Mon, 11 May 2020 10:52:07 +0800
Subject: [PATCH] arm64: perf: Report the PC value in REGS_ABI_32 mode

A 32-bit perf querying the registers of a compat task using REGS_ABI_32
will receive zeroes from w15, when it expects to find the PC.

Return the PC value for register dwarf register 15 when returning register
values for a compat task to perf.

Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
Link: https://lore.kernel.org/r/1589165527-188401-1-git-send-email-jiping.ma2@windriver.com
[will: Shuffled code and added a comment]
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/perf_regs.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
index 0bbac612146e..952b26a05d0f 100644
--- a/arch/arm64/kernel/perf_regs.c
+++ b/arch/arm64/kernel/perf_regs.c
@@ -15,15 +15,25 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 		return 0;
 
 	/*
-	 * Compat (i.e. 32 bit) mode:
-	 * - PC has been set in the pt_regs struct in kernel_entry,
-	 * - Handle SP and LR here.
+	 * Our handling of compat tasks (PERF_SAMPLE_REGS_ABI_32) is weird. For
+	 * a 32-bit perf inspecting a 32-bit task, then it will look at the
+	 * first 16 registers. These correspond directly to the registers saved
+	 * in our pt_regs structure, with the exception of the PC, so we copy
+	 * that down (x15 corresponds to SP_hyp in the architecture). So far, so
+	 * good. The oddity arises when a 64-bit perf looks at a 32-bit task and
+	 * asks for registers beyond PERF_REG_ARM_MAX. In this case, we return
+	 * SP_usr, LR_usr and PC in the positions where the AArch64 registers
+	 * would normally live. The initial idea was to allow a 64-bit unwinder
+	 * to unwinder a 32-bit task and, although it's not clear how well that
+	 * works in practice, we're kind of stuck with this interface now.
 	 */
 	if (compat_user_mode(regs)) {
 		if ((u32)idx == PERF_REG_ARM64_SP)
 			return regs->compat_sp;
 		if ((u32)idx == PERF_REG_ARM64_LR)
 			return regs->compat_lr;
+		if (idx == 15)
+			return regs->pc;
 	}
 
 	if ((u32)idx == PERF_REG_ARM64_SP)
-- 
2.27.0.111.gc72c7da667-goog

