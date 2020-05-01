Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468BEC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 12:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28600208D6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 12:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgEAMjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 08:39:07 -0400
Received: from mga06.intel.com ([134.134.136.31]:43428 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728712AbgEAMjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 08:39:06 -0400
IronPort-SDR: +FQcpJX0C4oDnmZHRHSQkKdRsY5zoU0lUYWVcWrCPaM0f8NKpOVfZNiZo1uZPzIRWo2ALbEREh
 1+rjDOhk6lnQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 05:39:05 -0700
IronPort-SDR: KSBvJqfyNu7/praWRQS99BlITNMEqdVcQkB199G9WWqFBNQBf88FmoMgI2elcJPakmtiZdvt4J
 mzLd5BxGqN+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,339,1583222400"; 
   d="scan'208";a="283166856"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 01 May 2020 05:39:05 -0700
Received: from [10.255.228.89] (ajayravi-mobl.amr.corp.intel.com [10.255.228.89])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 7280D5804A0;
        Fri,  1 May 2020 05:39:04 -0700 (PDT)
Subject: Re: [PATCH V2] perf/x86/intel/uncore: Add Comet Lake support
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com
References: <1585857179-180207-1-git-send-email-kan.liang@linux.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <67e69c8c-4a63-59b4-6013-ba45b1e3d15b@linux.intel.com>
Date:   Fri, 1 May 2020 08:39:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1585857179-180207-1-git-send-email-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Could you please take a look the patch, and apply the patch if it's OK?

Thanks,
Kan

On 4/2/2020 3:52 PM, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The uncore subsystem on Comet Lake is similar to Sky Lake.
> The only difference is the new PCI IDs for IMC.
> 
> Share the perf code with Sky Lake.
> Add new PCI IDs in the table.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
> 
> Changes since V1:
> - Rebase on top of tip.git perf/core branch
>    commit 629b3df7ecb0 ("Merge branch 'x86/cpu' into perf/core, to resolve conflict")
> 
>   arch/x86/events/intel/uncore.c     |  2 ++
>   arch/x86/events/intel/uncore_snb.c | 66 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 68 insertions(+)
> 
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index cf76d66..b9c2876 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1514,6 +1514,8 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
>   	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X,		&skx_uncore_init),
>   	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L,		&skl_uncore_init),
>   	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE,		&skl_uncore_init),
> +	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&skl_uncore_init),
> +	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&skl_uncore_init),
>   	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&icl_uncore_init),
>   	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_NNPI,	&icl_uncore_init),
>   	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&icl_uncore_init),
> diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
> index 3de1065..5c40367 100644
> --- a/arch/x86/events/intel/uncore_snb.c
> +++ b/arch/x86/events/intel/uncore_snb.c
> @@ -42,6 +42,17 @@
>   #define PCI_DEVICE_ID_INTEL_WHL_UQ_IMC		0x3ed0
>   #define PCI_DEVICE_ID_INTEL_WHL_4_UQ_IMC	0x3e34
>   #define PCI_DEVICE_ID_INTEL_WHL_UD_IMC		0x3e35
> +#define PCI_DEVICE_ID_INTEL_CML_H1_IMC		0x9b44
> +#define PCI_DEVICE_ID_INTEL_CML_H2_IMC		0x9b54
> +#define PCI_DEVICE_ID_INTEL_CML_H3_IMC		0x9b64
> +#define PCI_DEVICE_ID_INTEL_CML_U1_IMC		0x9b51
> +#define PCI_DEVICE_ID_INTEL_CML_U2_IMC		0x9b61
> +#define PCI_DEVICE_ID_INTEL_CML_U3_IMC		0x9b71
> +#define PCI_DEVICE_ID_INTEL_CML_S1_IMC		0x9b33
> +#define PCI_DEVICE_ID_INTEL_CML_S2_IMC		0x9b43
> +#define PCI_DEVICE_ID_INTEL_CML_S3_IMC		0x9b53
> +#define PCI_DEVICE_ID_INTEL_CML_S4_IMC		0x9b63
> +#define PCI_DEVICE_ID_INTEL_CML_S5_IMC		0x9b73
>   #define PCI_DEVICE_ID_INTEL_ICL_U_IMC		0x8a02
>   #define PCI_DEVICE_ID_INTEL_ICL_U2_IMC		0x8a12
>   #define PCI_DEVICE_ID_INTEL_TGL_U1_IMC		0x9a02
> @@ -771,6 +782,50 @@ static const struct pci_device_id skl_uncore_pci_ids[] = {
>   		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WHL_UD_IMC),
>   		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
>   	},
> +	{ /* IMC */
> +		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_H1_IMC),
> +		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
> +	},
> +	{ /* IMC */
> +		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_H2_IMC),
> +		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
> +	},
> +	{ /* IMC */
> +		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_H3_IMC),
> +		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
> +	},
> +	{ /* IMC */
> +		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_U1_IMC),
> +		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
> +	},
> +	{ /* IMC */
> +		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_U2_IMC),
> +		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
> +	},
> +	{ /* IMC */
> +		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_U3_IMC),
> +		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
> +	},
> +	{ /* IMC */
> +		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_S1_IMC),
> +		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
> +	},
> +	{ /* IMC */
> +		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_S2_IMC),
> +		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
> +	},
> +	{ /* IMC */
> +		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_S3_IMC),
> +		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
> +	},
> +	{ /* IMC */
> +		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_S4_IMC),
> +		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
> +	},
> +	{ /* IMC */
> +		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_S5_IMC),
> +		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
> +	},
>   	{ /* end: all zeroes */ },
>   };
>   
> @@ -863,6 +918,17 @@ static const struct imc_uncore_pci_dev desktop_imc_pci_ids[] = {
>   	IMC_DEV(WHL_UQ_IMC, &skl_uncore_pci_driver),	/* 8th Gen Core U Mobile Quad Core */
>   	IMC_DEV(WHL_4_UQ_IMC, &skl_uncore_pci_driver),	/* 8th Gen Core U Mobile Quad Core */
>   	IMC_DEV(WHL_UD_IMC, &skl_uncore_pci_driver),	/* 8th Gen Core U Mobile Dual Core */
> +	IMC_DEV(CML_H1_IMC, &skl_uncore_pci_driver),
> +	IMC_DEV(CML_H2_IMC, &skl_uncore_pci_driver),
> +	IMC_DEV(CML_H3_IMC, &skl_uncore_pci_driver),
> +	IMC_DEV(CML_U1_IMC, &skl_uncore_pci_driver),
> +	IMC_DEV(CML_U2_IMC, &skl_uncore_pci_driver),
> +	IMC_DEV(CML_U3_IMC, &skl_uncore_pci_driver),
> +	IMC_DEV(CML_S1_IMC, &skl_uncore_pci_driver),
> +	IMC_DEV(CML_S2_IMC, &skl_uncore_pci_driver),
> +	IMC_DEV(CML_S3_IMC, &skl_uncore_pci_driver),
> +	IMC_DEV(CML_S4_IMC, &skl_uncore_pci_driver),
> +	IMC_DEV(CML_S5_IMC, &skl_uncore_pci_driver),
>   	IMC_DEV(ICL_U_IMC, &icl_uncore_pci_driver),	/* 10th Gen Core Mobile */
>   	IMC_DEV(ICL_U2_IMC, &icl_uncore_pci_driver),	/* 10th Gen Core Mobile */
>   	{  /* end marker */ }
> 
