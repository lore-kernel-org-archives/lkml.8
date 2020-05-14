Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA836C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7416C2065F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ue2S5JfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgENQqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 12:46:00 -0400
Received: from mail-bn8nam12on2048.outbound.protection.outlook.com ([40.107.237.48]:20226
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725999AbgENQp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 12:45:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKXho1bCzWHLU18ipmYwpoxw9e7j/eolaYeSA70M74dBfHWihZNrvw3srbzTZz6ywoX+JhVfRe4MqeLVD2i1msD0300kffkCN8lBpvCmJUyhMb/JBIxANX6m2EhvvkbVg+zxiCkT5acbNSV+HS7Z6TkAgkHA/NL1I4HuKpAmRhLdEW4plot4+6DL/bk8Xx21zwFc4NkeH6pClreilPFct/JDToGq9UPOwI5fAmBGyLDXDEVnHuNkUiKVFWl8wSEYWQMF1LZBzTt5qOWGeO+6AL1uLeTMk8Ug87nMoRUH1PSYZc6g9JMFGycstaa33d026Lp6iLXGVs3qmwq1KHkCAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwZq4RehmaMbRA3ixlKIksTA4YWUaT7lOf7ZuJtECeU=;
 b=bVb6a1cBa3NogigRABW3rNxAhtGN4hkiszLd+hOOrKA+aNaDNFubetEw93OYOe0w6xBsUIwSeYUDmT69qPMlDccLozg4yIOSjVzT4ZcUh7mBtADCehDfAS1JO6U72I2h5IMmNsSgn0jzyG6kqn6Oij7J44etPY17a5h4ERcPm2hjdwUnBzkTAbbTRC0Sx3j1rhuJunXbDg6QmXPWkIHgxasR0g0M7z4BWxobvJ9bR6BxJTIDF/kt9C7b0t5QqRHkqCFp/s3QIntflIt1l4YKXtw4p7l3hi7ax17Y7uN6cymXxCeC2EeQrtykJKkbQC5urLtwftxiGDOhUhWbXOhD4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwZq4RehmaMbRA3ixlKIksTA4YWUaT7lOf7ZuJtECeU=;
 b=ue2S5JfH+FQUpr61iaV70aWDremgzdtdMc1c5EYgSzIKfIRgJYy7immrjvHQgbKsVhD9fLRlU69dsObnYvfKcj000Ge+zAB6aree6AdQk5t3pNQDdmZA6cUZ0Q5CphKus3Ib7eeySOmRYKRaDTgvMK82qmy0nIBn3tK9FVmS+m4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2400.namprd12.prod.outlook.com (2603:10b6:802:2f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Thu, 14 May
 2020 16:45:53 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::c0f:2938:784f:ed8d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::c0f:2938:784f:ed8d%7]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 16:45:53 +0000
Subject: RE: [PATCH V3 1/4] x86/resctrl: Enable user to view and select thread
 throttling mode
To:     Reinette Chatre <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>
Cc:     "kuo-lang.tseng@intel.com" <kuo-lang.tseng@intel.com>,
        "ravi.v.shankar@intel.com" <ravi.v.shankar@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1588808537.git.reinette.chatre@intel.com>
 <56f9ee29b04599cdf502565dc223a70912a449f6.1588808538.git.reinette.chatre@intel.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <0d1fc0a8-7544-861e-a2f6-42c34ad798d9@amd.com>
Date:   Thu, 14 May 2020 11:45:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <56f9ee29b04599cdf502565dc223a70912a449f6.1588808538.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:805:de::24) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by SN6PR05CA0011.namprd05.prod.outlook.com (2603:10b6:805:de::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.10 via Frontend Transport; Thu, 14 May 2020 16:45:51 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 68d9011a-0eda-4333-7d29-08d7f82643dc
X-MS-TrafficTypeDiagnostic: SN1PR12MB2400:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2400CBF57644A116BB142BC495BC0@SN1PR12MB2400.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AVfs1FsUmu5b4Mr1JhpTXnR0/Pk3MWeULptsietDfzmg/ZyuOdM3O1t0fZ7Lv+UTErWvx5RLCgKm4/AqHMXaPeTtU3zDemLKaDbH5hmV6XU/sxkRa0RgZy+rRRI7de/CJ6NoAlr/hzroj2X23U7nwOQK4EsJ/iV7JaEmm+MNg7ZWOA3SgpCz7mANwLFqzUA3sstsdn444u7ijK22BFcJoLH0DrI3INdIiBrafo1J+Yy01Tei1cjkljemKzp9TiojBy1HyEktkq8Aq7QPvIuXIYKaBzFtTQyVqgYPKAPJH6mURCz8gNouhYHGpO+s8yihX/vID8Awy61qYIJhgr7aId6Ymobe9oo/P8ycbfAHKrTaVGHEyvU/D4/C9AosHj7tlCP6Rvwn7nbQ/0qf+oCq9ieJ16eTXsDLbe1T9Fn8NwNtbur7dRc9EVa7aeIBgKXwlYKl2qN+ccKSo0eYVd9o2qOlRozuK1+wubedouaZqen5KTpqehbGLwSVFt+uIO8u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(44832011)(478600001)(956004)(2906002)(8936002)(16526019)(66556008)(186003)(110136005)(54906003)(86362001)(36756003)(16576012)(316002)(52116002)(66476007)(6486002)(26005)(2616005)(66946007)(31686004)(7416002)(31696002)(5660300002)(4326008)(8676002)(53546011)(30864003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: VqaJa6v9xnqk0z4nI9uugVClaQBAQK152GuAt5XEx3mKVcyCf1amLmkE3vfmkJXRm73vc5XwPMVFlHTjpfQnDVVb4dIsNq7J224is4pHlj2O/g+3tZZu3QSIsIPfCB3EKjUAVBF0yAWNVmEIG+zXwp8FFXfAetacNxDTFLBIVS2Nc3Fjh8sgmK8IOEOIyeLf4G/txRy9HnxbjjyZ8LKVTcJYcE7TK6v94wc5JdPmTJGzT0+3FZcKxEuOII0VYUErxsggXABMdSK4VaDCKwA9/cnRMBbG6o6O813idRfY0XSwqpaaMs7RCxdPhoXgfC15ur5Rrx8FGoRnMNUJaHd4PssPacevGexAkca10QELrTp4KFyNYzmgMgIjnfp0gL4JDQDXyBwIEbMdM6fQCN37gLy9sXRHm/IVrs3Xhp1vtOVwxlq9lG1tYD7+7HZsGdF0VcQM/E+ujaB7oPwLCK37p7rLR3xFxLAkogWjlIFQ7gY=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d9011a-0eda-4333-7d29-08d7f82643dc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 16:45:53.2410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZSqxkx0UsTuH5F4VZPEHa+M4ZYdxZmBu6i76b3/AnR+LcapiYBXTl8LY5lJh1Sv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2400
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinnette,

The patches did not apply on my tree. I got the latest tree today. You
might want to check again.
Hunk #1 FAILED at 29.
1 out of 7 hunks FAILED -- saving rejects to file
arch/x86/kernel/cpu/resctrl/rdtgroup.c.rej


> -----Original Message-----
> From: Reinette Chatre <reinette.chatre@intel.com>
> Sent: Wednesday, May 6, 2020 6:50 PM
> To: tglx@linutronix.de; fenghua.yu@intel.com; bp@alien8.de;
> tony.luck@intel.com
> Cc: kuo-lang.tseng@intel.com; ravi.v.shankar@intel.com; mingo@redhat.com;
> Moger, Babu <Babu.Moger@amd.com>; hpa@zytor.com; x86@kernel.org;
> linux-kernel@vger.kernel.org; Reinette Chatre <reinette.chatre@intel.com>
> Subject: [PATCH V3 1/4] x86/resctrl: Enable user to view and select thread
> throttling mode
> 
> Intel Memory Bandwidth Allocation (MBA) control is provided per
> processor core. At the same time different CLOS, configured with different
> bandwidth percentages, can be assigned to the hardware threads
> sharing a core. In the original implementation of MBA the maximum throttling
> of the per-thread CLOS is allocated to the core. Specifically, the lower
> bandwidth percentage is allocated to the core.
> 
> Newer systems can be configured to allocate either maximum or
> minimum throttling of the per-thread CLOS values to the core.
> 
> Introduce a new resctrl file, "thread_throttle_mode", on Intel systems
> that exposes to the user how per-thread values are allocated to
> a core. On systems that support the original MBA implementation the
> file will always display "max". On systems that can be configured
> the possible values are "min" or "max" that the user can modify by
> writing these same words to the file.
> 
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> Changes since V2:
> - Rebase on top of recently merged series "x86/resctrl: Support wider
>   MBM counters". Small change needed to take into account
>   asm/resctrl_sched.h -> asm/resctrl.h name change.
> - Fix rST formatting of documentation (resctrl_ui.rst) describing
>   new "thread_throttle_mode" resctrl file.
> 
>  Documentation/x86/resctrl_ui.rst       |  19 ++-
>  arch/x86/kernel/cpu/resctrl/core.c     |  32 +++++
>  arch/x86/kernel/cpu/resctrl/internal.h |  13 ++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 188 ++++++++++++++++++++++++-
>  4 files changed, 249 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/x86/resctrl_ui.rst
> b/Documentation/x86/resctrl_ui.rst
> index 5368cedfb530..861ee2816470 100644
> --- a/Documentation/x86/resctrl_ui.rst
> +++ b/Documentation/x86/resctrl_ui.rst
> @@ -138,6 +138,19 @@ with respect to allocation:
>  		non-linear. This field is purely informational
>  		only.
> 
> +"thread_throttle_mode":
> +		Indicator (on some CPU models control) on Intel systems
> +		of how tasks running on threads of a physical core are
> +		throttled in cases where they request different memory
> +		bandwidth percentages:
> +
> +		"min":
> +			the largest percentage is applied
> +			to all threads
> +		"max":
> +			the smallest percentage is applied
> +			to all threads
> +
>  If RDT monitoring is available there will be an "L3_MON" directory
>  with the following files:
> 
> @@ -364,8 +377,10 @@ to the next control step available on the hardware.
> 
>  The bandwidth throttling is a core specific mechanism on some of Intel
>  SKUs. Using a high bandwidth and a low bandwidth setting on two threads
> -sharing a core will result in both threads being throttled to use the
> -low bandwidth. The fact that Memory bandwidth allocation(MBA) is a core
> +sharing a core may result in both threads being throttled to use the
> +low bandwidth (see "thread_throttle_mode").
> +
> +The fact that Memory bandwidth allocation(MBA) may be a core
>  specific mechanism where as memory bandwidth monitoring(MBM) is done at
>  the package level may lead to confusion when users try to apply control
>  via the MBA and then monitor the bandwidth to see if the controls are
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c
> b/arch/x86/kernel/cpu/resctrl/core.c
> index 12f967c6b603..1bc686777069 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -250,6 +250,30 @@ static inline bool rdt_get_mb_table(struct rdt_resource
> *r)
>  	return false;
>  }
> 
> +/*
> + * Model-specific test to determine if platform where memory bandwidth
> + * control is applied to a core can be configured to apply either the
> + * maximum or minimum of the per-thread delay values.
> + * By default, platforms where memory bandwidth control is applied to a
> + * core will select the maximum delay value of the per-thread CLOS.
> + *
> + * NOTE: delay value programmed to hardware is inverse of bandwidth
> + * percentage configured via user interface.
> + */
> +bool mba_cfg_supports_min_max_intel(void)
> +{
> +	switch (boot_cpu_data.x86_model) {
> +	case INTEL_FAM6_ATOM_TREMONT_D:
> +	case INTEL_FAM6_ICELAKE_X:
> +	case INTEL_FAM6_ICELAKE_D:
> +		return true;
> +	default:
> +		return false;
> +	}
> +
> +	return false;
> +}

I see that you are calling this function multiple times. Why don't you
make it as a property in rdt_resource. Set it only once during the
init(may be in get_mem_config_intel). Then you can use it wherever
required. This also probably help James to make everything architecture
independent. What do you think?

I assume that this property is probably not part of CPUID.

> +
>  static bool __get_mem_config_intel(struct rdt_resource *r)
>  {
>  	union cpuid_0x10_3_eax eax;
> @@ -270,6 +294,11 @@ static bool __get_mem_config_intel(struct
> rdt_resource *r)
>  	}
>  	r->data_width = 3;
> 
> +	if (mba_cfg_supports_min_max_intel())
> +		thread_throttle_mode_init_intel_rw();
> +	else
> +		thread_throttle_mode_init_intel_ro();
> +
>  	r->alloc_capable = true;
>  	r->alloc_enabled = true;
> 
> @@ -580,6 +609,9 @@ static void domain_add_cpu(int cpu, struct rdt_resource
> *r)
> 
>  	rdt_domain_reconfigure_cdp(r);
> 
> +	if (mba_cfg_supports_min_max_intel())
> +		wrmsrl(MSR_MBA_CFG, mba_cfg_msr);
> +
>  	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
>  		kfree(d);
>  		return;
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
> b/arch/x86/kernel/cpu/resctrl/internal.h
> index f20a47d120b1..c5f4cb91009b 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -9,6 +9,7 @@
> 
>  #define MSR_IA32_L3_QOS_CFG		0xc81
>  #define MSR_IA32_L2_QOS_CFG		0xc82
> +#define MSR_MBA_CFG			0xc84
>  #define MSR_IA32_L3_CBM_BASE		0xc90
>  #define MSR_IA32_L2_CBM_BASE		0xd10
>  #define MSR_IA32_MBA_THRTL_BASE		0xd50
> @@ -21,6 +22,9 @@
> 
>  #define L2_QOS_CDP_ENABLE		0x01ULL
> 
> +#define MBA_THROTTLE_MODE_MIN		0x01ULL
> +#define MBA_THROTTLE_MODE_MAX		0x00ULL
> +
>  /*
>   * Event IDs are used to program IA32_QM_EVTSEL before reading event
>   * counter from IA32_QM_CTR
> @@ -38,6 +42,8 @@
>  #define MBA_MAX_MBPS			U32_MAX
>  #define MAX_MBA_BW_AMD			0x800
> 
> +#define MBA_THROTTLE_MODE_MASK		BIT_ULL(0)
> +
>  #define RMID_VAL_ERROR			BIT_ULL(63)
>  #define RMID_VAL_UNAVAIL		BIT_ULL(62)
>  /*
> @@ -47,6 +53,10 @@
>   */
>  #define MBM_CNTR_WIDTH_OFFSET_MAX (62 - MBM_CNTR_WIDTH_BASE)
> 
> +/*
> + * MSR_MBA_CFG cache
> + */
> +extern u64 mba_cfg_msr;
> 
>  struct rdt_fs_context {
>  	struct kernfs_fs_context	kfc;
> @@ -611,5 +621,8 @@ void __check_limbo(struct rdt_domain *d, bool
> force_free);
>  bool cbm_validate_intel(char *buf, u32 *data, struct rdt_resource *r);
>  bool cbm_validate_amd(char *buf, u32 *data, struct rdt_resource *r);
>  void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
> +bool mba_cfg_supports_min_max_intel(void);
> +void thread_throttle_mode_init_intel_rw(void);
> +void thread_throttle_mode_init_intel_ro(void);
> 
>  #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index d7cb5ab0d1f0..6a9408060ac4 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -29,6 +29,7 @@
> 
>  #include <uapi/linux/magic.h>
> 
> +#include <asm/intel-family.h>
>  #include <asm/resctrl.h>
>  #include "internal.h"
> 
> @@ -38,6 +39,7 @@ DEFINE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
>  static struct kernfs_root *rdt_root;
>  struct rdtgroup rdtgroup_default;
>  LIST_HEAD(rdt_all_groups);
> +u64 mba_cfg_msr;
> 
>  /* Kernel fs node for "info" directory under root */
>  static struct kernfs_node *kn_info;
> @@ -1017,6 +1019,134 @@ static int max_threshold_occ_show(struct
> kernfs_open_file *of,
>  	return 0;
>  }
> 
> +/*
> + * As documented in the Intel SDM, on systems supporting the original MBA
> + * implementation the delay value allocated to a core is always the maximum
> + * of the delay values assigned to the hardware threads sharing the core.
> + *
> + * Some systems support a model-specific MSR with which this default
> + * behavior can be changed. On these systems the core can be allocated
> + * with either the minimum or maximum delay value assigned to its hardware
> + * threads.
> + *
> + * NOTE: The hardware deals with memory delay values that may be
> programmed
> + * from zero (implying zero delay, and full bandwidth available) to the
> + * maximum specified in CPUID. The software interface deals with memory
> + * bandwidth percentages that are the inverse of the delay values (100%
> + * memory bandwidth from user perspective is zero MBA delay from hardware
> + * perspective). When maximum throttling is active the core is allocated
> + * with the maximum delay value that from the software interface will be
> + * the minimum of the bandwidth percentages assigned to the hardware
> threads
> + * sharing the core.
> + */
> +static int rdt_thread_throttle_mode_show(struct kernfs_open_file *of,
> +					 struct seq_file *seq, void *v)
> +{
> +	unsigned int throttle_mode = 0;
> +
> +	if (mba_cfg_supports_min_max_intel())
> +		throttle_mode = mba_cfg_msr &
> MBA_THROTTLE_MODE_MASK;
> +
> +	seq_puts(seq,
> +		 throttle_mode == MBA_THROTTLE_MODE_MIN ? "min\n" :
> "max\n");
> +
> +	return 0;
> +}
> +
> +static void update_mba_cfg(void *data)
> +{
> +	u64 *mba_cfg = data;
> +
> +	wrmsrl(MSR_MBA_CFG, *mba_cfg);
> +}
> +
> +/*
> + * The model-specific MBA configuration MSR has package scope. Making a
> + * system-wide MBA configuration change thus needs to modify the MSR on
> one
> + * CPU from each package.
> + */
> +static int rdt_system_mba_cfg_set(u64 mba_cfg)
> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA];
> +	cpumask_var_t cpu_mask;
> +	struct rdt_domain *d;
> +
> +	if (list_is_singular(&r->domains)) {
> +		wrmsrl(MSR_MBA_CFG, mba_cfg);
> +		goto out;
> +	}
> +
> +	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL)) {
> +		rdt_last_cmd_puts("Memory allocation error\n");
> +		return -ENOMEM;
> +	}
> +
> +	list_for_each_entry(d, &r->domains, list)
> +		cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
> +
> +	on_each_cpu_mask(cpu_mask, update_mba_cfg, &mba_cfg, 1);
> +
> +	free_cpumask_var(cpu_mask);
> +out:
> +	mba_cfg_msr = mba_cfg;
> +	return 0;
> +}
> +
> +/*
> + * See NOTE associated with rdt_thread_throttle_mode_show() for
> + * details of the min/max interpretation.
> + */
> +static ssize_t rdt_thread_throttle_mode_write(struct kernfs_open_file *of,
> +					      char *buf, size_t nbytes,
> +					      loff_t off)
> +{
> +	u64 mba_cfg;
> +	int ret = 0;
> +
> +	if (nbytes == 0)
> +		return -EINVAL;
> +
> +	cpus_read_lock();
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	rdt_last_cmd_clear();
> +
> +	/*
> +	 * Additional check.
> +	 * This function should not be associated with the user space file
> +	 * on systems that do not support configuration.
> +	 */
> +	if (!mba_cfg_supports_min_max_intel()) {
> +		rdt_last_cmd_puts("Platform does not support mode
> changes\n");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	mba_cfg = mba_cfg_msr & MBA_THROTTLE_MODE_MASK;
> +
> +	if ((sysfs_streq(buf, "min") && mba_cfg ==
> MBA_THROTTLE_MODE_MIN) ||
> +	    (sysfs_streq(buf, "max") && mba_cfg ==
> MBA_THROTTLE_MODE_MAX))
> +		goto out;
> +
> +	if (sysfs_streq(buf, "min")) {
> +		mba_cfg = MBA_THROTTLE_MODE_MIN;
> +	} else if (sysfs_streq(buf, "max")) {
> +		mba_cfg = MBA_THROTTLE_MODE_MAX;
> +	} else {
> +		rdt_last_cmd_puts("Unknown or unsupported mode\n");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	mba_cfg = (mba_cfg_msr & ~MBA_THROTTLE_MODE_MASK) |
> mba_cfg;
> +	ret = rdt_system_mba_cfg_set(mba_cfg);
> +
> +out:
> +	mutex_unlock(&rdtgroup_mutex);
> +	cpus_read_unlock();
> +	return ret ?: nbytes;
> +}
> +
>  static ssize_t max_threshold_occ_write(struct kernfs_open_file *of,
>  				       char *buf, size_t nbytes, loff_t off)
>  {
> @@ -1512,6 +1642,16 @@ static struct rftype res_common_files[] = {
>  		.seq_show	= rdt_delay_linear_show,
>  		.fflags		= RF_CTRL_INFO | RFTYPE_RES_MB,
>  	},
> +	/*
> +	 * Platform specific which (if any) capabilities are provided by
> +	 * thread_throttle_mode. Defer some initialization to platform
> +	 * discovery.
> +	 */
> +	{
> +		.name		= "thread_throttle_mode",
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdt_thread_throttle_mode_show,
> +	},
>  	{
>  		.name		= "max_threshold_occupancy",
>  		.mode		= 0644,
> @@ -1571,6 +1711,47 @@ static struct rftype res_common_files[] = {
> 
>  };
> 
> +static struct rftype *rdtgroup_rftype_by_name(const char *name)
> +{
> +	struct rftype *rfts, *rft;
> +	int len;
> +
> +	rfts = res_common_files;
> +	len = ARRAY_SIZE(res_common_files);
> +
> +	for (rft = rfts; rft < rfts + len; rft++) {
> +		if (!strcmp(rft->name, name))
> +			return rft;
> +	}
> +
> +	return NULL;
> +}
> +
> +void __init thread_throttle_mode_init_intel_rw(void)
> +{
> +	struct rftype *rft;
> +
> +	rft = rdtgroup_rftype_by_name("thread_throttle_mode");
> +	if (!rft)
> +		return;
> +
> +	rft->mode = 0644;
> +	rft->write = rdt_thread_throttle_mode_write;
> +	rft->fflags = RF_CTRL_INFO | RFTYPE_RES_MB;
> +}
> +
> +void __init thread_throttle_mode_init_intel_ro(void)
> +{
> +	struct rftype *rft;
> +
> +	rft = rdtgroup_rftype_by_name("thread_throttle_mode");
> +	if (!rft)
> +		return;
> +
> +	rft->mode = 0444;
> +	rft->fflags = RF_CTRL_INFO | RFTYPE_RES_MB;
> +}
> +
>  static int rdtgroup_add_files(struct kernfs_node *kn, unsigned long fflags)
>  {
>  	struct rftype *rfts, *rft;
> @@ -1582,7 +1763,7 @@ static int rdtgroup_add_files(struct kernfs_node *kn,
> unsigned long fflags)
>  	lockdep_assert_held(&rdtgroup_mutex);
> 
>  	for (rft = rfts; rft < rfts + len; rft++) {
> -		if ((fflags & rft->fflags) == rft->fflags) {
> +		if (rft->fflags && ((fflags & rft->fflags) == rft->fflags)) {
>  			ret = rdtgroup_add_file(kn, rft);
>  			if (ret)
>  				goto error;
> @@ -2239,6 +2420,11 @@ static int reset_all_ctrls(struct rdt_resource *r)
>  	smp_call_function_many(cpu_mask, rdt_ctrl_update, &msr_param, 1);
>  	put_cpu();
> 
> +	if (mba_cfg_supports_min_max_intel()) {
> +		mba_cfg_msr = 0;
> +		on_each_cpu_mask(cpu_mask, update_mba_cfg,
> &mba_cfg_msr, 1);
> +	}
> +
>  	free_cpumask_var(cpu_mask);
> 
>  	return 0;
> --
> 2.21.0

