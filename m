Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1873C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A284920756
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="su5xPjIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbgEVRqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 13:46:43 -0400
Received: from mail-eopbgr760084.outbound.protection.outlook.com ([40.107.76.84]:60480
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730680AbgEVRql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 13:46:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AK+GUctfaMR/alQn0JVF368OgN7zxbueFW/feypvKCrLKm5Wbcoe79lxPmEY4JlEEKIi8F32dyqibdBK01DJp5382kixTxhdINue0ChCnKAQc1ES+ucLTz3n2BWv7twhXFtfTx8a5XuQjtb0Y1Y1sDKK4XlXi6kFjuEcjDZNwJQeqcPp/rKX9nnp63KBBL264e0LOWncJQb5jxawPMBwTI5glRNFffmwO6kNccf+zRoq3rgJmbDFKSPU94qC55vVi2h5qdr8KjaOrGaiPvnK4ptGxyQ7e7ZdkJRvw9gPF/1lZKZV644JzTeoEznitF7CRKiS1Y1VyQme54LW+o4KBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEuKnysb8OxrA3D1W2e9xrXo7m1sdmc4EMku/6pVgNs=;
 b=LyIHHzet3uHyTb5Uod93ZR5tyCTcBGLUGyrpU0bLSRH/8h4rfOSSxkWSHxPYq7FlbStNn1BJKXmpRD0IyivYOfzzxS6SVZhOGQp4BV1/7EstCt+H6xGcKFUT5d9p3k1IbUhBvBqipG+CrjG25+/qrwc/HfxWB4mbjBQtm+tajMsf1eBgmdTv8ebEg4QfkmGJMzngA1Y9plXkvET3D2AQ19088HSNfjR0qx6zPjmN0QoeeIpOCZ9jtu7cSfR7vCfpoiOcWC9m1RQ7UvyEBOUBoTltjrlQ2hHj0DPnTXTGbZ1KJkBSV0ovVbon7HXqczm0wlqecTYnVSDCn1/Mg+eybw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEuKnysb8OxrA3D1W2e9xrXo7m1sdmc4EMku/6pVgNs=;
 b=su5xPjIakyIcdMdzTv+M00SVqocnbE6MF9qTN2J4Weqj5K9V2H+BMGkm1LpAko/4Di2YSZiAz0Lz/7vTV9pkvb0Ms1WwpC/BojAyd2Y631ukDn1xnIL/nqxcZoRKLwI7DysziNfD5KdSEtdnuLfmdy4/9+uphWqHyi4vFPYfYN8=
Authentication-Results: zytor.com; dkim=none (message not signed)
 header.d=none;zytor.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2382.namprd12.prod.outlook.com (2603:10b6:802:2e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Fri, 22 May
 2020 17:46:39 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2%3]) with mapi id 15.20.3021.027; Fri, 22 May 2020
 17:46:39 +0000
Subject: RE: [PATCH v3 08/10] x86/resctrl: Merge AMD/Intel parse_bw() calls
To:     James Morse <james.morse@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>
References: <20200518131924.7741-1-james.morse@arm.com>
 <20200518131924.7741-9-james.morse@arm.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <14a0af1d-3879-d89c-20a8-a6d5118d5bf1@amd.com>
Date:   Fri, 22 May 2020 12:46:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200518131924.7741-9-james.morse@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR1401CA0011.namprd14.prod.outlook.com
 (2603:10b6:4:4a::21) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by DM5PR1401CA0011.namprd14.prod.outlook.com (2603:10b6:4:4a::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Fri, 22 May 2020 17:46:37 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e09425a4-9c3d-4879-c2c8-08d7fe781446
X-MS-TrafficTypeDiagnostic: SN1PR12MB2382:
X-Microsoft-Antispam-PRVS: <SN1PR12MB23826D7B48139BEB0B73DE0C95B40@SN1PR12MB2382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: An2jnOKqpjlO4Bb5MfRLw+ciWiXzNR6NYjSTftQbV/umev8SZn5K4fgvHfOAbQ+5pJDOXF+vctXEvGSUu/im3mKOLwtDcNBahhs+PyahEtAQCOeB1ZsjdoRU6L8oWoBzOaL2g73WeRLfw/1+nAXGQyKKv0q6GXBZ3fhNNLkuBwrCjX5y5vS0wIckjTvlJjMnkQq2S+GiGBzJezyTSuZT4v7uZgHmia2Ygix63Ml57CC7uwrgeBMCtv6VKsIJen4EB9XMOOJslR491nL5YNryXALs3tfrnaSCwg3ECesKpWfcU2DTtkc+BY4f4ssytivT+YOvKWoNze8t/TXntYyLCJFZ1KInB6qagZXjWEtKEa8kBJSZ2wDSJI5+kM5rVdH3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(8936002)(2616005)(44832011)(956004)(8676002)(66946007)(4326008)(6486002)(66476007)(2906002)(31686004)(66556008)(478600001)(110136005)(26005)(54906003)(52116002)(16576012)(53546011)(16526019)(316002)(86362001)(5660300002)(186003)(36756003)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: OulonRzJyQT1s53nMIjGPTSut2XCF+mgz8UnBbZ/nfjnQrKqh4iOQ0Uux+Urg5atbWMBz+1XqnmyIMaFDFgnpSbFAksb3T1i64ck8dJtShS7+CrzyG84E38YPdv4s7QnhFuLc+QJl84tIrKLaAmI6/pAySV/mQM0r03e6PNRsh4CR0wrg9QPLRErYFwrhsL77+cBCsN38McExtUqNNE6PFSe//40OfAOMacq+wV9Q72bRMAzFSrZKQQuh2owBPYJ7mWgjIXvaY0waad6SmW8FU/VLPEC5YKXNJDuWhqQ2Zc0dk/9uMqxajgqtUz8iFKgC8aZFcXle3eugD+L6rMFshulhKifTkmANduGBYmx4tJyRoqStvS19FdqrkaesbpCMFmCIgwCHAlD69QhD2ehQeHot5obtBSqjnLuBcROFrpS4J3N8v18ZF73E1Si5frm+i7Dfv248csME+cIxuoGuBh87PephzDXcCj6eNhYXC0=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e09425a4-9c3d-4879-c2c8-08d7fe781446
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 17:46:39.0834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YsQ09MivA4Zk4nX4zxHjChvcum1oqO+/thZGWTUe8xJOF5snLfImDtbPWTfUKe8F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2382
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
> Subject: [PATCH v3 08/10] x86/resctrl: Merge AMD/Intel parse_bw() calls
> 
> Now that we've explained arch_needs_linear to resctrl, the parse_bw()
> calls are almost the same between AMD and Intel.
> 
> The difference is '!is_mba_sc()', which is not checked on AMD. This
> will always be true on AMD CPUs as mba_sc cannot be enabled as
> is_mba_linear() is false.
> 
> Removing this duplication means user-space visible behaviour and
> error messages are not validated or generated in different places.
> 
> CC: Babu Moger <Babu.Moger@amd.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reviewed-by : Babu Moger <babu.moger@amd.com>

> ---
>  arch/x86/kernel/cpu/resctrl/core.c        |  3 +-
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 57 +----------------------
>  arch/x86/kernel/cpu/resctrl/internal.h    |  6 +--
>  3 files changed, 5 insertions(+), 61 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c
> b/arch/x86/kernel/cpu/resctrl/core.c
> index c6b73b0ee070..223e5b90bcfd 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -168,6 +168,7 @@ struct rdt_resource rdt_resources_all[] = {
>  		.name			= "MB",
>  		.domains		= domain_init(RDT_RESOURCE_MBA),
>  		.cache_level		= 3,
> +		.parse_ctrlval		= parse_bw,
>  		.format_str		= "%d=%*u",
>  		.fflags			= RFTYPE_RES_MB,
>  	},
> @@ -926,7 +927,6 @@ static __init void rdt_init_res_defs_intel(void)
>  		else if (r->rid == RDT_RESOURCE_MBA) {
>  			r->msr_base = MSR_IA32_MBA_THRTL_BASE;
>  			r->msr_update = mba_wrmsr_intel;
> -			r->parse_ctrlval = parse_bw_intel;
>  		}
>  	}
>  }
> @@ -946,7 +946,6 @@ static __init void rdt_init_res_defs_amd(void)
>  		else if (r->rid == RDT_RESOURCE_MBA) {
>  			r->msr_base = MSR_IA32_MBA_BW_BASE;
>  			r->msr_update = mba_wrmsr_amd;
> -			r->parse_ctrlval = parse_bw_amd;
>  		}
>  	}
>  }
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index e3bcd77add2b..b0e24cb6f85c 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -21,59 +21,6 @@
>  #include <linux/slab.h>
>  #include "internal.h"
> 
> -/*
> - * Check whether MBA bandwidth percentage value is correct. The value is
> - * checked against the minimum and maximum bandwidth values specified by
> - * the hardware. The allocated bandwidth percentage is rounded to the next
> - * control step available on the hardware.
> - */
> -static bool bw_validate_amd(char *buf, unsigned long *data,
> -			    struct rdt_resource *r)
> -{
> -	unsigned long bw;
> -	int ret;
> -
> -	/* temporary: always false on AMD */
> -	if (!r->membw.delay_linear && r->membw.arch_needs_linear) {
> -		rdt_last_cmd_puts("No support for non-linear MB domains\n");
> -		return false;
> -	}
> -
> -	ret = kstrtoul(buf, 10, &bw);
> -	if (ret) {
> -		rdt_last_cmd_printf("Non-decimal digit in MB value %s\n", buf);
> -		return false;
> -	}
> -
> -	if (bw < r->membw.min_bw || bw > r->default_ctrl) {
> -		rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n",
> bw,
> -				    r->membw.min_bw, r->default_ctrl);
> -		return false;
> -	}
> -
> -	*data = roundup(bw, (unsigned long)r->membw.bw_gran);
> -	return true;
> -}
> -
> -int parse_bw_amd(struct rdt_parse_data *data, struct rdt_resource *r,
> -		 struct rdt_domain *d)
> -{
> -	unsigned long bw_val;
> -
> -	if (d->have_new_ctrl) {
> -		rdt_last_cmd_printf("Duplicate domain %d\n", d->id);
> -		return -EINVAL;
> -	}
> -
> -	if (!bw_validate_amd(data->buf, &bw_val, r))
> -		return -EINVAL;
> -
> -	d->new_ctrl = bw_val;
> -	d->have_new_ctrl = true;
> -
> -	return 0;
> -}
> -
>  /*
>   * Check whether MBA bandwidth percentage value is correct. The value is
>   * checked against the minimum and max bandwidth values specified by the
> @@ -110,8 +57,8 @@ static bool bw_validate(char *buf, unsigned long *data,
> struct rdt_resource *r)
>  	return true;
>  }
> 
> -int parse_bw_intel(struct rdt_parse_data *data, struct rdt_resource *r,
> -		   struct rdt_domain *d)
> +int parse_bw(struct rdt_parse_data *data, struct rdt_resource *r,
> +	     struct rdt_domain *d)
>  {
>  	unsigned long bw_val;
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
> b/arch/x86/kernel/cpu/resctrl/internal.h
> index 0b288b6fefd9..5919aae946ba 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -470,10 +470,8 @@ struct rdt_resource {
> 
>  int parse_cbm(struct rdt_parse_data *data, struct rdt_resource *r,
>  	      struct rdt_domain *d);
> -int parse_bw_intel(struct rdt_parse_data *data, struct rdt_resource *r,
> -		   struct rdt_domain *d);
> -int parse_bw_amd(struct rdt_parse_data *data, struct rdt_resource *r,
> -		 struct rdt_domain *d);
> +int parse_bw(struct rdt_parse_data *data, struct rdt_resource *r,
> +	     struct rdt_domain *d);
> 
>  extern struct mutex rdtgroup_mutex;
> 
> --
> 2.19.1

