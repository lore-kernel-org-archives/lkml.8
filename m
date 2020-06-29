Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74F8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE474214F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387580AbgF2VXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:23:17 -0400
Received: from mga03.intel.com ([134.134.136.65]:63961 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729585AbgF2SvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:51:24 -0400
IronPort-SDR: fiVoY/wcKy4M3E25MyPpNox6plOE2qe1BsdHAm+XjIYycGaV4iuN97q2Ka4wEkrqiljNvkZNFi
 QE+Sj1wXYCzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="146025480"
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; 
   d="scan'208";a="146025480"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 11:36:01 -0700
IronPort-SDR: J8TtCQ2KE3lFgd0aaHp/VMcLQkTJMLLFgiMlIjEU7vyztLiuNuvzz3ZCwnY1v43gOhOWetqw17
 BQdy7/Ir83cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; 
   d="scan'208";a="424906847"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 29 Jun 2020 11:36:01 -0700
Received: from [10.251.5.114] (kliang2-mobl.ccr.corp.intel.com [10.251.5.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id BB0A8580107;
        Mon, 29 Jun 2020 11:35:58 -0700 (PDT)
Subject: Re: [PATCH V2 01/23] x86/cpufeatures: Add Architectural LBRs feature
 bit
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com, wei.w.wang@intel.com
References: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
 <1593195620-116988-2-git-send-email-kan.liang@linux.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <be786c01-8010-2add-bec3-18f4045f682e@linux.intel.com>
Date:   Mon, 29 Jun 2020 14:35:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1593195620-116988-2-git-send-email-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/26/2020 2:19 PM, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> CPUID.(EAX=07H, ECX=0):EDX[19] indicates whether Intel CPU support
> Architectural LBRs.
> 
> The Architectural Last Branch Records (LBR) feature enables recording
> of software path history by logging taken branches and other control
> flows. The feature will be supported in the perf_events subsystem.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>   arch/x86/include/asm/cpufeatures.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 02dabc9..72ba4c5 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -366,6 +366,7 @@
>   #define X86_FEATURE_MD_CLEAR		(18*32+10) /* VERW clears CPU buffers */
>   #define X86_FEATURE_TSX_FORCE_ABORT	(18*32+13) /* "" TSX_FORCE_ABORT */
>   #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
> +#define X86_FEATURE_ARCH_LBR		(18*32+19) /* Intel ARCH LBR */
>   #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
>   #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
>   #define X86_FEATURE_FLUSH_L1D		(18*32+28) /* Flush L1D cache */
> 

The "Reviewed-by" tag from Dave Hansen was missing in the previous patch.
The patch below adds the tag and applies minor updates to the commit 
message. Please use the new one instead.

Please let me know if I need to resend the whole patch set for the update.

Thanks,
Kan

 From ed05798e52377f85cd93193838648d1c151ca0a4 Mon Sep 17 00:00:00 2001
From: Kan Liang <kan.liang@linux.intel.com>
Date: Tue, 12 Nov 2019 09:09:14 -0800
Subject: [PATCH V2 01/23] x86/cpufeatures: Add Architectural LBRs 
feature bit

CPUID.(EAX=07H, ECX=0):EDX[19] indicates whether an Intel CPU supports
Architectural LBRs.

The "X86_FEATURE_..., word 18" is already mirrored from CPUID
"0x00000007:0 (EDX)". Add X86_FEATURE_ARCH_LBR under the "word 18"
section.

The feature will appear as "arch_lbr" in /proc/cpuinfo.

The Architectural Last Branch Records (LBR) feature enables recording
of software path history by logging taken branches and other control
flows. The feature will be supported in the perf_events subsystem.

Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
  arch/x86/include/asm/cpufeatures.h | 1 +
  1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h 
b/arch/x86/include/asm/cpufeatures.h
index 02dabc9..72ba4c5 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -366,6 +366,7 @@
  #define X86_FEATURE_MD_CLEAR		(18*32+10) /* VERW clears CPU buffers */
  #define X86_FEATURE_TSX_FORCE_ABORT	(18*32+13) /* "" TSX_FORCE_ABORT */
  #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
+#define X86_FEATURE_ARCH_LBR		(18*32+19) /* Intel ARCH LBR */
  #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control 
(IBRS + IBPB) */
  #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread 
Indirect Branch Predictors */
  #define X86_FEATURE_FLUSH_L1D		(18*32+28) /* Flush L1D cache */
-- 
2.7.4

