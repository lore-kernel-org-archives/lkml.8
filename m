Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBB8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44AC320720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d9ySLTx9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1RzMBbBV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgGHJwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:52:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48070 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728648AbgGHJvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:51:54 -0400
Date:   Wed, 08 Jul 2020 09:51:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594201912;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8M2w+Ln973lNCrRueRCpHitdbIOU97JvYA9rTVOP6dU=;
        b=d9ySLTx9owbVnoZ/frJU/p39PHkFXnRTiJlv+ijOBO+nkakTcU+zelX4lE9FRTnVl5jNuA
        dEK7d81awT/UCAc1mQV3IJDkuHi2phl3QdsQAhC4XLdhmkb8KeC7lmluI9/vlfoGPPFkUF
        dcaurdEAKmV+aZiulnVrkxYPR7F6SlHG+rLy2Dh43DOWNEjYfBZVBqF+1uiwsab+SYZvuR
        DyTfVSQ8MMM/prj8pZ88Ml7E5lNYcFswMo+7Dfw7SWMGWaMzZSL1Mg78yPfBPz2Jh5B6MU
        zsHua2KAvhdUXYvqIik/9Kwe+ZJVL3u3W7sHMy/87RsHu6GeIT2s6A34RkKXAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594201912;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8M2w+Ln973lNCrRueRCpHitdbIOU97JvYA9rTVOP6dU=;
        b=1RzMBbBVc/sTQ+ldQBc3vZmxJb/3WG0WHJoaSO44st/E3mFhBFIVJW6nfFxxVBK5dihpru
        WI9ydJBBc7d7zHBA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Expose CPUID enumeration bits for arch LBR
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1593780569-62993-9-git-send-email-kan.liang@linux.intel.com>
References: <1593780569-62993-9-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159420191172.4006.7150584896673059399.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     af6cf129706b2f79e12f97e62d977e7f653cdfd1
Gitweb:        https://git.kernel.org/tip/af6cf129706b2f79e12f97e62d977e7f653cdfd1
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 03 Jul 2020 05:49:14 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 08 Jul 2020 11:38:53 +02:00

perf/x86: Expose CPUID enumeration bits for arch LBR

The LBR capabilities of Architecture LBR are retrieved from the CPUID
enumeration once at boot time. The capabilities have to be saved for
future usage.

Several new fields are added into structure x86_pmu to indicate the
capabilities. The fields will be used in the following patches.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1593780569-62993-9-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/perf_event.h      | 13 ++++++++++-
 arch/x86/include/asm/perf_event.h | 40 ++++++++++++++++++++++++++++++-
 2 files changed, 53 insertions(+)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 7dbf148..cc81177 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -693,6 +693,19 @@ struct x86_pmu {
 	bool		lbr_double_abort;	   /* duplicated lbr aborts */
 	bool		lbr_pt_coexist;		   /* (LBR|BTS) may coexist with PT */
 
+	/*
+	 * Intel Architectural LBR CPUID Enumeration
+	 */
+	unsigned int	lbr_depth_mask:8;
+	unsigned int	lbr_deep_c_reset:1;
+	unsigned int	lbr_lip:1;
+	unsigned int	lbr_cpl:1;
+	unsigned int	lbr_filter:1;
+	unsigned int	lbr_call_stack:1;
+	unsigned int	lbr_mispred:1;
+	unsigned int	lbr_timed_lbr:1;
+	unsigned int	lbr_br_type:1;
+
 	void		(*lbr_reset)(void);
 	void		(*lbr_read)(struct cpu_hw_events *cpuc);
 	void		(*lbr_save)(void *ctx);
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 2df7073..9ffce7d 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -142,6 +142,46 @@ union cpuid10_edx {
 	unsigned int full;
 };
 
+/*
+ * Intel Architectural LBR CPUID detection/enumeration details:
+ */
+union cpuid28_eax {
+	struct {
+		/* Supported LBR depth values */
+		unsigned int	lbr_depth_mask:8;
+		unsigned int	reserved:22;
+		/* Deep C-state Reset */
+		unsigned int	lbr_deep_c_reset:1;
+		/* IP values contain LIP */
+		unsigned int	lbr_lip:1;
+	} split;
+	unsigned int		full;
+};
+
+union cpuid28_ebx {
+	struct {
+		/* CPL Filtering Supported */
+		unsigned int    lbr_cpl:1;
+		/* Branch Filtering Supported */
+		unsigned int    lbr_filter:1;
+		/* Call-stack Mode Supported */
+		unsigned int    lbr_call_stack:1;
+	} split;
+	unsigned int            full;
+};
+
+union cpuid28_ecx {
+	struct {
+		/* Mispredict Bit Supported */
+		unsigned int    lbr_mispred:1;
+		/* Timed LBRs Supported */
+		unsigned int    lbr_timed_lbr:1;
+		/* Branch Type Field Supported */
+		unsigned int    lbr_br_type:1;
+	} split;
+	unsigned int            full;
+};
+
 struct x86_pmu_capability {
 	int		version;
 	int		num_counters_gp;
