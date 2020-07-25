Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE777C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 12:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C69C7206EB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 12:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ETGt1qpG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wiHiuEw/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgGYMOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 08:14:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44110 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726639AbgGYMOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 08:14:45 -0400
Date:   Sat, 25 Jul 2020 12:14:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595679282;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ni0mfcHzkt3QVnomHKCgVf5CNK+FqZMyLli/6XR0Mso=;
        b=ETGt1qpGFDhcbt92bQE5hAU+I7hLfhCfaYSpGHl+m6gJLO8761SQbQgzgAbJKlqUKTRVkD
        giXMjwWkhjOFDYiQ8YXhuvEwuabHa2Z1hQJ7jJS1ukPeFLmG23ZhdT2sf+b5XUC7GhUZUu
        oMM3h8kmiP6jOiUzRCtGWMCWOyYCttdqR9mc8Cu9AILlxo426O53ujSKqzflR1ZIaoierU
        7NOhXqPRw4oESSy7zaWtW/Egra+rXb13ERIdJiMBy9xLjQnSN/TCzqSHrtF+f1BLhDM5WO
        SLTC3mYgoYb6+hlPYLxre3AkjlPLXrX1I1RA9gwE/n94VpaC3Yp2zvso81cr6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595679282;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ni0mfcHzkt3QVnomHKCgVf5CNK+FqZMyLli/6XR0Mso=;
        b=wiHiuEw/QQJHu/SrEogM4KygH+qc8aAcqSKCI6brFzmBuROz3//XzGq+GRuarEpdicp5sp
        5ZMHEVRcE+C/S6BA==
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/split_lock: Enable the split lock feature on
 Sapphire Rapids and Alder Lake CPUs
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1595634320-79689-1-git-send-email-fenghua.yu@intel.com>
References: <1595634320-79689-1-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Message-ID: <159567928168.4006.15289187589508335521.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     3aae57f0c3ba57715cf89201b5a5f290684078a5
Gitweb:        https://git.kernel.org/tip/3aae57f0c3ba57715cf89201b5a5f290684078a5
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Fri, 24 Jul 2020 16:45:20 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 25 Jul 2020 12:17:00 +02:00

x86/split_lock: Enable the split lock feature on Sapphire Rapids and Alder Lake CPUs

Add Sapphire Rapids and Alder Lake processors to CPU list to enumerate
and enable the split lock feature.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/1595634320-79689-1-git-send-email-fenghua.yu@intel.com
---
 arch/x86/kernel/cpu/intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 0ab48f1..b6b7b38 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1156,6 +1156,8 @@ static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	1),
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		1),
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		1),
+	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	1),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		1),
 	{}
 };
 
