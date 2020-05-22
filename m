Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F3AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87DED2072C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LgbKGJpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbgEVRrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 13:47:10 -0400
Received: from mail-eopbgr680085.outbound.protection.outlook.com ([40.107.68.85]:51259
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730750AbgEVRrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 13:47:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZPcmjcJpjhkdoJYNVgLpiIg1C/ogNPaUe94Na99rRJbR1H7s4i1tEB+4hOmYGU6vMFDLwMIpkjsbMDJQnp5BpNMXGKbTJ5D0jXObapk9GN4S4hM1oEes4THU/D5ySfgn5DGA+9FR+HtO3c4EsScrAU8JMMVqOXmRBSNenaFZFciUx+WGAfSPkydCDIj6gvUhvv2tEVDPE3y7BUN7iFIv8M3fySkkXURp2itVRx4W695RRkyYr8oRsDiWmNL47oxR99DhRQuvtkz5j44URHAIA7/h3JkuWfe0C/Ml89Y/V2u+ucn8H3Hfjq/aVm2ew2fWtvEM1fab3a7BpPpNvH6bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWco/JzVnqtAVm42ryCHq7pK5Wqk3cxgFgIXxp/za0w=;
 b=jf4+J8C4YGsCSbEugyWIzjNp7GouCBzB0Ft2GTxaIlCZSSzh+jCBJOm1xGZusGxR/DiZRaShUuTKkZDajibUoAm1/pQYOxrceDZj5DA9rNBkgjzYcCDACc50vuyfX3dgSIY6dAh1OoTxkJrJaBho0na44lUtga5DupL7HXKzUVW5eM6o1S/aoSTBrb8YT8Aqi0VJ8o8kqOm5+Ei6SpnksGGqlbWSJm+6DslIQuHTsKwbYv8lQZoIRBG+ooR6TTDAIxMoCf9GScx9sUOaz6KUOAJpujVP7/Mg4v8OizSCoVQDWb7stboQZ9PPPDj8529spxgxSiGMgw0GN149Da+CUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWco/JzVnqtAVm42ryCHq7pK5Wqk3cxgFgIXxp/za0w=;
 b=LgbKGJpTF75LzDycNp4T0DwoZM5JskXcfYHHfFQfENfoOY+BzCtjsGoaiqhPSJPtlCXx0rPz5RFPSMQYuYmtdxPchpOEqG1uu0QUtCOXqHwFwZehllGQZb4m3DrQtro0eH9IdmtQJ/+Q8xHDAb14jXpHryJpo7Cx1oyMN+Dqma8=
Authentication-Results: zytor.com; dkim=none (message not signed)
 header.d=none;zytor.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2349.namprd12.prod.outlook.com (2603:10b6:802:2a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.26; Fri, 22 May
 2020 17:47:04 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2%3]) with mapi id 15.20.3021.027; Fri, 22 May 2020
 17:47:04 +0000
Subject: RE: [PATCH v3 09/10] x86/resctrl: Add arch_has_{sparse,empty}_bitmaps
 to explain CAT differences
To:     James Morse <james.morse@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>
References: <20200518131924.7741-1-james.morse@arm.com>
 <20200518131924.7741-10-james.morse@arm.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <b76c9118-7f6b-8d85-82a7-650d7db96c96@amd.com>
Date:   Fri, 22 May 2020 12:47:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200518131924.7741-10-james.morse@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR1401CA0005.namprd14.prod.outlook.com
 (2603:10b6:4:4a::15) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by DM5PR1401CA0005.namprd14.prod.outlook.com (2603:10b6:4:4a::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Fri, 22 May 2020 17:47:03 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e81739de-e499-4f1f-de8d-08d7fe78234c
X-MS-TrafficTypeDiagnostic: SN1PR12MB2349:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2349845AC29EBB72464AAB4595B40@SN1PR12MB2349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XmMRrA/p3yOucYRNRlQ8Sh1FYtuxl8tCqVfqYQbqO17Yyhw3dziSCDZQ809Pua6DQULJ0PAbUiFUNOG4BzIfXGp3wsqd+Mhvqgygp7OdWXULOFXHmZPkVsU6f0TIFnG3vruH8O9qTv7Q43dZHd2wGNSkh9O2wVzKuq4hhFG/8po30Z/85mTpuydw921YTkOYA0AWUEB3Bub3N57Yw1b/mI6wIcLlsZsEV+cGoPoEEAzo8GxAV2oAq+ynNCiC+u/kNC1Z2El7MQ162pVWT/xwYNYRdkS8uFtbWEJB4DbUOZLtBUN6lSlLcgaUZnQ0c1iSIIHCG0xyIbCZb9YE7sDr4nAIIQbZEjxGg3W4Omz7C49Jo0l5u5ZaPt+rTZbpnyU9NhVzJ0K1OFQjNkRVTeNHg1TS2zUcixAuYwJ6f5UMb10=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(66476007)(66946007)(66556008)(956004)(2616005)(31686004)(186003)(16526019)(16576012)(316002)(8676002)(54906003)(5660300002)(110136005)(478600001)(44832011)(36756003)(26005)(8936002)(31696002)(6486002)(52116002)(2906002)(86362001)(53546011)(4326008)(142933001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: sNrry6TGp+6Fznx1LgW5TCjfnHpt7cApFKsm6nSRM910gRo/hD0Grj5Ne4Rb1E/HlM58PqFAa0d6W1FCzyzLCnu4+40c4rO1yWq63nu4PtTcQsPZ+SKPWNjwiD0qwT1mXIsX2LJQsKVAzIo7/WjN0ttbFEYcMlgn0990y9awuQM3CpUI8L01aYmGjOtchFS5fchDjwilP3792gBvMU0m/Q2GB4E6D93KCnck5rBEP0w5cBpFtrrbfcM5dKQrYIgwN6xqO2J3fTf+XOkFDajVj/vNY2oEdtBe4a9y7WLuyCiHc8FX1rSrmeBk9BUQmNFCveMo4063D3dLgWrvVSTwh2zV0od8fToSWPsqzkEqHAXGBp+BkVA/KKvB3ZpK/RLCCdotY1uaJXxv9jTz4FegwH15Lwyy1i8pIx9CjhMYytpqusvADMnrHz81svhtEZ7IhAxWzng1K05iIHNGAmKv+0THay/DmLpwoRzfcOZXdr8=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e81739de-e499-4f1f-de8d-08d7fe78234c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 17:47:03.9484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xS2NvNf9HzF8gjVUUEiYk2rthxj53ckdGCx3AanjomWIE4o1fy+rNyG7qSGBHrkC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2349
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: James Morse <james.morse@arm.com>
> Sent: Monday, May 18, 2020 8:19 AM
> To: x86@kernel.org; linux-kernel@vger.kernel.org
> Cc: Fenghua Yu <fenghua.yu@intel.com>; Reinette Chatre
> <reinette.chatre@intel.com>; Thomas Gleixner <tglx@linutronix.de>; Ingo
> Molnar <mingo@redhat.com>; Borislav Petkov <bp@alien8.de>; H Peter Anvin
> <hpa@zytor.com>; Moger, Babu <Babu.Moger@amd.com>; James Morse
> <james.morse@arm.com>
> Subject: [PATCH v3 09/10] x86/resctrl: Add arch_has_{sparse,empty}_bitmaps to
> explain CAT differences
> 
> Intel CPUs expect the cache bitmap provided by user-space to have on
> a single span of 1s, whereas AMD can support bitmaps like 0xf00f.
> Arm's MPAM support also allows sparse bitmaps.
> 
> Similarly, Intel CPUs check at least one bit set, whereas AMD CPUs
> are quite happy with an empty bitmap. Arm's MPAM allows an empty
> bitmap.
> 
> To move resctrl out to /fs/ we need to explain platform differences
> like this. Add two resource properties arch_has_{empty,sparse}_bitmaps.
> Test these around the relevant parts of cbm_validate().
> 
> Merging the validate calls causes AMD to gain the min_cbm_bits test
> needed for Haswell, but as it always sets this value to 1, it will
> never match.
> 
> CC: Babu Moger <Babu.Moger@amd.com>
> CC: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Babu Moger <babu.moger@amd.com>

> ---
>  arch/x86/kernel/cpu/resctrl/core.c        | 14 ++++----
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 39 ++++++-----------------
>  arch/x86/kernel/cpu/resctrl/internal.h    |  8 ++---
>  3 files changed, 22 insertions(+), 39 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c
> b/arch/x86/kernel/cpu/resctrl/core.c
> index 223e5b90bcfd..587f9791d2a6 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -922,9 +922,10 @@ static __init void rdt_init_res_defs_intel(void)
>  		    r->rid == RDT_RESOURCE_L3CODE ||
>  		    r->rid == RDT_RESOURCE_L2 ||
>  		    r->rid == RDT_RESOURCE_L2DATA ||
> -		    r->rid == RDT_RESOURCE_L2CODE)
> -			r->cbm_validate = cbm_validate_intel;
> -		else if (r->rid == RDT_RESOURCE_MBA) {
> +		    r->rid == RDT_RESOURCE_L2CODE) {
> +			r->cache.arch_has_sparse_bitmaps = false;
> +			r->cache.arch_has_empty_bitmaps = false;
> +		} else if (r->rid == RDT_RESOURCE_MBA) {
>  			r->msr_base = MSR_IA32_MBA_THRTL_BASE;
>  			r->msr_update = mba_wrmsr_intel;
>  		}
> @@ -941,9 +942,10 @@ static __init void rdt_init_res_defs_amd(void)
>  		    r->rid == RDT_RESOURCE_L3CODE ||
>  		    r->rid == RDT_RESOURCE_L2 ||
>  		    r->rid == RDT_RESOURCE_L2DATA ||
> -		    r->rid == RDT_RESOURCE_L2CODE)
> -			r->cbm_validate = cbm_validate_amd;
> -		else if (r->rid == RDT_RESOURCE_MBA) {
> +		    r->rid == RDT_RESOURCE_L2CODE) {
> +			r->cache.arch_has_sparse_bitmaps = true;
> +			r->cache.arch_has_empty_bitmaps = true;
> +		} else if (r->rid == RDT_RESOURCE_MBA) {
>  			r->msr_base = MSR_IA32_MBA_BW_BASE;
>  			r->msr_update = mba_wrmsr_amd;
>  		}
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index b0e24cb6f85c..cc854bb369c9 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -76,12 +76,14 @@ int parse_bw(struct rdt_parse_data *data, struct
> rdt_resource *r,
>  }
> 
>  /*
> - * Check whether a cache bit mask is valid. The SDM says:
> + * Check whether a cache bit mask is valid.
> + * For Intel the SDM says:
>   *	Please note that all (and only) contiguous '1' combinations
>   *	are allowed (e.g. FFFFH, 0FF0H, 003CH, etc.).
>   * Additionally Haswell requires at least two bits set.
> + * AMD allows non-contiguous bitmasks.
>   */
> -bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r)
> +static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
>  {
>  	unsigned long first_bit, zero_bit, val;
>  	unsigned int cbm_len = r->cache.cbm_len;
> @@ -93,7 +95,8 @@ bool cbm_validate_intel(char *buf, u32 *data, struct
> rdt_resource *r)
>  		return false;
>  	}
> 
> -	if (val == 0 || val > r->default_ctrl) {
> +	if ((!r->cache.arch_has_empty_bitmaps && val == 0) ||
> +	    (val > r->default_ctrl)) {
>  		rdt_last_cmd_puts("Mask out of range\n");
>  		return false;
>  	}
> @@ -101,7 +104,9 @@ bool cbm_validate_intel(char *buf, u32 *data, struct
> rdt_resource *r)
>  	first_bit = find_first_bit(&val, cbm_len);
>  	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit);
> 
> -	if (find_next_bit(&val, cbm_len, zero_bit) < cbm_len) {
> +	/* Are non-contiguous bitmaps allowed? */
> +	if (!r->cache.arch_has_sparse_bitmaps &&
> +	    (find_next_bit(&val, cbm_len, zero_bit) < cbm_len)) {
>  		rdt_last_cmd_printf("The mask %lx has non-consecutive 1-
> bits\n", val);
>  		return false;
>  	}
> @@ -116,30 +121,6 @@ bool cbm_validate_intel(char *buf, u32 *data, struct
> rdt_resource *r)
>  	return true;
>  }
> 
> -/*
> - * Check whether a cache bit mask is valid. AMD allows non-contiguous
> - * bitmasks
> - */
> -bool cbm_validate_amd(char *buf, u32 *data, struct rdt_resource *r)
> -{
> -	unsigned long val;
> -	int ret;
> -
> -	ret = kstrtoul(buf, 16, &val);
> -	if (ret) {
> -		rdt_last_cmd_printf("Non-hex character in the mask %s\n",
> buf);
> -		return false;
> -	}
> -
> -	if (val > r->default_ctrl) {
> -		rdt_last_cmd_puts("Mask out of range\n");
> -		return false;
> -	}
> -
> -	*data = val;
> -	return true;
> -}
> -
>  /*
>   * Read one cache bit mask (hex). Check that it is valid for the current
>   * resource type.
> @@ -165,7 +146,7 @@ int parse_cbm(struct rdt_parse_data *data, struct
> rdt_resource *r,
>  		return -EINVAL;
>  	}
> 
> -	if (!r->cbm_validate(data->buf, &cbm_val, r))
> +	if (!cbm_validate(data->buf, &cbm_val, r))
>  		return -EINVAL;
> 
>  	if ((rdtgrp->mode == RDT_MODE_EXCLUSIVE ||
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
> b/arch/x86/kernel/cpu/resctrl/internal.h
> index 5919aae946ba..35f8137c4dce 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -357,6 +357,8 @@ struct msr_param {
>   *			in a cache bit mask
>   * @shareable_bits:	Bitmask of shareable resource with other
>   *			executing entities
> + * @arch_has_sparse_bitmaps:	True if a bitmap like f00f is valid.
> + * @arch_has_empty_bitmaps:	True if the '0' bitmap is valid.
>   */
>  struct rdt_cache {
>  	unsigned int	cbm_len;
> @@ -364,6 +366,8 @@ struct rdt_cache {
>  	unsigned int	cbm_idx_mult;
>  	unsigned int	cbm_idx_offset;
>  	unsigned int	shareable_bits;
> +	bool		arch_has_sparse_bitmaps;
> +	bool		arch_has_empty_bitmaps;
>  };
> 
>  /**
> @@ -433,7 +437,6 @@ struct rdt_parse_data {
>   * @cache:		Cache allocation related data
>   * @format_str:		Per resource format string to show domain
> value
>   * @parse_ctrlval:	Per resource function pointer to parse control values
> - * @cbm_validate	Cache bitmask validate function
>   * @evt_list:		List of monitoring events
>   * @num_rmid:		Number of RMIDs available
>   * @mon_scale:		cqm counter * mon_scale = occupancy in bytes
> @@ -460,7 +463,6 @@ struct rdt_resource {
>  	int (*parse_ctrlval)(struct rdt_parse_data *data,
>  			     struct rdt_resource *r,
>  			     struct rdt_domain *d);
> -	bool (*cbm_validate)(char *buf, u32 *data, struct rdt_resource *r);
>  	struct list_head	evt_list;
>  	int			num_rmid;
>  	unsigned int		mon_scale;
> @@ -603,8 +605,6 @@ void cqm_setup_limbo_handler(struct rdt_domain
> *dom, unsigned long delay_ms);
>  void cqm_handle_limbo(struct work_struct *work);
>  bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
>  void __check_limbo(struct rdt_domain *d, bool force_free);
> -bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r);
> -bool cbm_validate_amd(char *buf, u32 *data, struct rdt_resource *r);
>  void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
> 
>  #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
> --
> 2.19.1

