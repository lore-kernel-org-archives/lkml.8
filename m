Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443FAC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 15:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CD79208B3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 15:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qwnpl8yv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NqAVw616"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgHNPXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 11:23:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37360 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgHNPXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 11:23:32 -0400
Date:   Fri, 14 Aug 2020 15:23:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597418609;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yGQQf07hrYbBnbd1/0pfdoSYassUGL+600WBlA+0nqs=;
        b=qwnpl8yvajaFgURpO54wZC6nSBMe9H8pxbXSa6/4d3GO3Gyzht03WSmaNttejdVp8iHydX
        FsC3MoIbgxE61t0Fd5thIUELSKJrmF41FKcJjHRWif+0697CoV2OpgS2d6tYDggxM5OlbH
        gMsY+hYhOXHE98nTNBhJlHIt5/7T9RDeGfZzyBrTonzgvWI/sSjFPSjkrN0zQXgrShRoii
        vQpiuzERO6Ivh91fdHOvrVJfSGzOUgbxOBMPi2IUrFsesyJEd27NASsrFq82iI3wc/QLeE
        td0nhuvYJgnGcYmVx67PE5dspYCP20beGG6MGetiYSyGeo0LVbyOu7MDtcPpPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597418609;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yGQQf07hrYbBnbd1/0pfdoSYassUGL+600WBlA+0nqs=;
        b=NqAVw616379XXt5/Bgiw/EcYFhoHXzywKNJdzyW9kNnBfVSVTPUZXCSUCa33JmUjqoV+W3
        mjEzYaB19SO2rkCA==
From:   "tip-bot2 for Zhang Rui" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/rapl: Add support for Intel SPR platform
Cc:     Zhang Rui <rui.zhang@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Len Brown <len.brown@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200811153149.12242-4-rui.zhang@intel.com>
References: <20200811153149.12242-4-rui.zhang@intel.com>
MIME-Version: 1.0
Message-ID: <159741860874.3192.8459468822006053326.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     bcfd218b66790243ef303c1b35ce59f786ded225
Gitweb:        https://git.kernel.org/tip/bcfd218b66790243ef303c1b35ce59f786ded225
Author:        Zhang Rui <rui.zhang@intel.com>
AuthorDate:    Tue, 11 Aug 2020 23:31:49 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 14 Aug 2020 12:35:12 +02:00

perf/x86/rapl: Add support for Intel SPR platform

Intel SPR platform uses fixed 16 bit energy unit for DRAM RAPL domain,
and fixed 0 bit energy unit for Psys RAPL domain.
After this, on SPR platform the energy counters appear in perf list.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Acked-by: Len Brown <len.brown@intel.com>
Link: https://lore.kernel.org/r/20200811153149.12242-4-rui.zhang@intel.com
---
 arch/x86/events/rapl.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index d0002eb..67b411f 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -133,6 +133,7 @@ struct rapl_pmus {
 enum rapl_unit_quirk {
 	RAPL_UNIT_QUIRK_NONE,
 	RAPL_UNIT_QUIRK_INTEL_HSW,
+	RAPL_UNIT_QUIRK_INTEL_SPR,
 };
 
 struct rapl_model {
@@ -627,6 +628,14 @@ static int rapl_check_hw_unit(struct rapl_model *rm)
 	case RAPL_UNIT_QUIRK_INTEL_HSW:
 		rapl_hw_unit[PERF_RAPL_RAM] = 16;
 		break;
+	/*
+	 * SPR shares the same DRAM domain energy unit as HSW, plus it
+	 * also has a fixed energy unit for Psys domain.
+	 */
+	case RAPL_UNIT_QUIRK_INTEL_SPR:
+		rapl_hw_unit[PERF_RAPL_RAM] = 16;
+		rapl_hw_unit[PERF_RAPL_PSYS] = 0;
+		break;
 	default:
 		break;
 	}
@@ -757,6 +766,16 @@ static struct rapl_model model_skl = {
 	.rapl_msrs      = intel_rapl_msrs,
 };
 
+static struct rapl_model model_spr = {
+	.events		= BIT(PERF_RAPL_PP0) |
+			  BIT(PERF_RAPL_PKG) |
+			  BIT(PERF_RAPL_RAM) |
+			  BIT(PERF_RAPL_PSYS),
+	.unit_quirk	= RAPL_UNIT_QUIRK_INTEL_SPR,
+	.msr_power_unit = MSR_RAPL_POWER_UNIT,
+	.rapl_msrs      = intel_rapl_msrs,
+};
+
 static struct rapl_model model_amd_fam17h = {
 	.events		= BIT(PERF_RAPL_PKG),
 	.msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
@@ -793,6 +812,7 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&model_hsx),
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&model_spr),
 	X86_MATCH_VENDOR_FAM(AMD,	0x17,		&model_amd_fam17h),
 	X86_MATCH_VENDOR_FAM(HYGON,	0x18,		&model_amd_fam17h),
 	{},
