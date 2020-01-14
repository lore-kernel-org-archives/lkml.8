Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E38FC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98F12467D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996658;
	bh=IwlnD3gylgsFIjT/sKWm453OL+MT8zvnLChM6b2Fy0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0K6uAtAwfGvL2G3j9D1Rtdimz8RL3/T/7WuyZ5epkQD5jUkXtkRBtxBjH8vRHxYT2
	 ZHGL+7jCbROHLiBWQs2Avwem0p6RmQW6+Xi2VWPIfsQbyfNmlDZzyLcru0AKMeCSds
	 /9LeOFwrjULmMs1nQNuZPPa4OM7Ituh/pgz1lHi0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbgANKK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:10:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:45202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731919AbgANKKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:10:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B43772467A;
        Tue, 14 Jan 2020 10:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996649;
        bh=IwlnD3gylgsFIjT/sKWm453OL+MT8zvnLChM6b2Fy0I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xxFZEUsnjHXQHv87+SItqp6W/6r9guE6eq6eJ0mUsR/o8RMlaREntdiZN0yXjlGQT
         9r5vEi6o/QcDDeQATyL/7dPJVCRTu68uuu4ZHP1RRcyrir90oEHY2L9Se+QHa59wND
         GmvuxSaSUXpkGVzlDnEGE9JCcMegnUKZYck+SWk4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: [PATCH 4.14 33/39] arm64: cpufeature: Avoid warnings due to unused symbols
Date:   Tue, 14 Jan 2020 11:02:07 +0100
Message-Id: <20200114094345.996008920@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094336.210038037@linuxfoundation.org>
References: <20200114094336.210038037@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will.deacon@arm.com>

commit 12eb369125abe92bfc55e9ce198200f5807b63ff upstream.

An allnoconfig build complains about unused symbols due to functions
that are called via conditional cpufeature and cpu_errata table entries.

Annotate these as __maybe_unused if they are likely to be generic, or
predicate their compilation on the same option as the table entry if
they are specific to a given alternative.

Signed-off-by: Will Deacon <will.deacon@arm.com>
[Just a portion of the original patch]
Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/cpufeature.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -799,11 +799,6 @@ static bool has_no_hw_prefetch(const str
 		MIDR_CPU_VAR_REV(1, MIDR_REVISION_MASK));
 }
 
-static bool runs_at_el2(const struct arm64_cpu_capabilities *entry, int __unused)
-{
-	return is_kernel_in_hyp_mode();
-}
-
 static bool hyp_offset_low(const struct arm64_cpu_capabilities *entry,
 			   int __unused)
 {
@@ -937,6 +932,12 @@ static int __init parse_kpti(char *str)
 }
 early_param("kpti", parse_kpti);
 
+#ifdef CONFIG_ARM64_VHE
+static bool runs_at_el2(const struct arm64_cpu_capabilities *entry, int __unused)
+{
+	return is_kernel_in_hyp_mode();
+}
+
 static void cpu_copy_el2regs(const struct arm64_cpu_capabilities *__unused)
 {
 	/*
@@ -950,6 +951,7 @@ static void cpu_copy_el2regs(const struc
 	if (!alternatives_applied)
 		write_sysreg(read_sysreg(tpidr_el1), tpidr_el2);
 }
+#endif
 
 #ifdef CONFIG_ARM64_SSBD
 static int ssbs_emulation_handler(struct pt_regs *regs, u32 instr)


