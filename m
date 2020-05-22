Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C70C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 450DD2072C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VKvyRdFk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbgEVRqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 13:46:24 -0400
Received: from mail-bn7nam10on2074.outbound.protection.outlook.com ([40.107.92.74]:6146
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730680AbgEVRqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 13:46:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmWiOYqnIhFaoQjwG5xO+7BoN+XTXM2p/6fk5Ttm8J0kK91LEPehH/7MLjTuNlYf0AEzqqzUW8S7Qq9fAXLRY4j/v6nf69SYZyiS4lao1Z+WmgXC3HeUCX4nR0csZLN2wRpqx6M17oWBFvgoPqI95oMDTOWyUPpl9kKOAZk38x1aCexBSYs7GOdLCh3uadFYhUOpfKf+q7GDOyn/9P+jeI8PXtyHkvRfFqlXr7FJbRvhCh7m58DYAfVi5BBwe0hOe998pYdHkNRzdIQ50g6bcJ8QBTJ/KidKl+uoqKJ/6PdZ7HB7OyiTI4t64Kx2LvClmSaqsqm1k9en/l1csXhxSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LY9+WgEM7QOhVJMsCbA11pCsupGE4YaWQjkkdWe93N8=;
 b=UySSxP7i6sSbSLBDO91NI32CwIlMDFkLpM6a4Z47zuBj+OrvWhusThfTM4TxrR5xTdP12x3mrTyp6GFNxNnDMFpgEo1nJIUx36z9r5ABbtrowxsMyt+VFcDSD2NRkMedmqzKM1n8zMnjVB2dJq08zuDmWfOY5Yvi0vbW5bT1qy/sKHR10bW3+g4R1QfzG7vaFqxI3ZmXpvyNH5Ppic20nDhuOXNu8R1qfR9z5y3z9J2ahkGgrzzW8XLxpuhP90r1nQ2Mbt5zxKUWYSRPauu3V4PWtpxa3P+rsEFJ/yhkOA3q4HO6Z7vXQyHkx7uajNSaEsIxACO28/OjT1ObVP0oPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LY9+WgEM7QOhVJMsCbA11pCsupGE4YaWQjkkdWe93N8=;
 b=VKvyRdFkVh0/okZG49VMyeXxX4Q/q8I2F2TJIlc+JLMRRZZnSwz3ZdEk0ORfjZgYF6O9kOSAZTO0d7Alp3s/9c6lmCQLKC+UCwsQqPgZu1h7qI/jgvvBoFhSfMFCHJkiKzAVCtzBkAWdmEcfn9Bmr+IjQssT3ZXeq/ugkpclLo0=
Authentication-Results: zytor.com; dkim=none (message not signed)
 header.d=none;zytor.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2382.namprd12.prod.outlook.com (2603:10b6:802:2e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Fri, 22 May
 2020 17:46:17 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2%3]) with mapi id 15.20.3021.027; Fri, 22 May 2020
 17:46:17 +0000
Subject: RE: [PATCH v3 07/10] x86/resctrl: Add arch_needs_linear to explain
 AMD/Intel MBA difference
To:     James Morse <james.morse@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>
References: <20200518131924.7741-1-james.morse@arm.com>
 <20200518131924.7741-8-james.morse@arm.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <1eb6e476-9fe9-db84-693e-99b13d6d9102@amd.com>
Date:   Fri, 22 May 2020 12:46:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200518131924.7741-8-james.morse@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR1401CA0015.namprd14.prod.outlook.com
 (2603:10b6:4:4a::25) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by DM5PR1401CA0015.namprd14.prod.outlook.com (2603:10b6:4:4a::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Fri, 22 May 2020 17:46:16 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: af668567-d4a2-41cf-1172-08d7fe780751
X-MS-TrafficTypeDiagnostic: SN1PR12MB2382:
X-Microsoft-Antispam-PRVS: <SN1PR12MB23823DA2F26B369D8898B4C195B40@SN1PR12MB2382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FERdzVuWUy0oDVpW0j2awNHc9x/2pGUBB50bENGHK8NSbeJNP9aDWfu1A7t6hQJdfTXr2W+KvSQd4I5m7+cLt/PiheUTaFOF8gV7/t1lHlGP6z5fPC6taFvEAV9Pyyj7FiTF4UsjHir7QN7OENAr3f6oOZnT8x3dDErMbsatUdPqOqolJ4GLnAb1MFQZgaZDyesQ1vt9DVHf2O/89CgkCcjI17AyEU2UPMq9Qgw0PZuOqPaZ45cKj1K/MUOJEwK/WClM1DNJ5RwEdOgnLgBp7Z3LwDe7I8VDOD/S3fZp74aHQGRHaRtd4EJxaVZINhcHjepGZod2kiHX1wuQNNra7NwhW/T2pNJaWCTS1h8S8qaugFmm3OLumLRKbnRNGo8H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(8936002)(2616005)(44832011)(956004)(8676002)(66946007)(4326008)(6486002)(66476007)(2906002)(31686004)(66556008)(478600001)(110136005)(26005)(54906003)(52116002)(16576012)(53546011)(16526019)(316002)(86362001)(5660300002)(186003)(36756003)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: RiVgJoHs4KdabKfv1K+JhXcBRI46+L50PnFK9hXGRCuDO2sSq5hZ3/4LWWXdiFM8Dtbeirai6GJYskr5OkjqbwxJrJhGQTz0tYD1pMtjmRi8Agoo+kzfmVckG03mh3nH6zqWcGqVBEq2GDIvPp1GSN5iKS8BehD5zJ9fwJ3JAlDsUNErk/+c5S2oSn8SwvJayk1WaiqO+HkjP1l9MRUzQ9ipShHJ/kgbRsebDJ42425gDrH0ZcrOh9oXLQAeLuh5+8JT3xT38yVfb0y7VTyZGpjH7ZKO3n/RSxIsYmB/REk7FmSptGxyQHWUkge0Y5VckiqbWQQ2OYGlGFyJ/SJOGPpny9Zu++wzxWjt02lJKJy7roL+wiDUEZYkG08VGuK9tS/bsWxWf41PXw3UBjHwtudPnWLcFWpCkqIwOAoZUtsk2Zl/Fa+zrrjefvCoabe6IPFNNYa+9TQ00aIxRotsL2ewoDUDeRX4uK2Inv7hyTo=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af668567-d4a2-41cf-1172-08d7fe780751
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 17:46:17.6124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /zf10epzbmd1ARkucofRCObGZfVrPcS4Q/JcBaOwBt+GVlE7X/4t8QXU3rUUTHKc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2382
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good.

> -----Original Message-----
> From: James Morse <james.morse@arm.com>
> Sent: Monday, May 18, 2020 8:19 AM
> To: x86@kernel.org; linux-kernel@vger.kernel.org
> Cc: Fenghua Yu <fenghua.yu@intel.com>; Reinette Chatre
> <reinette.chatre@intel.com>; Thomas Gleixner <tglx@linutronix.de>; Ingo
> Molnar <mingo@redhat.com>; Borislav Petkov <bp@alien8.de>; H Peter Anvin
> <hpa@zytor.com>; Moger, Babu <Babu.Moger@amd.com>; James Morse
> <james.morse@arm.com>
> Subject: [PATCH v3 07/10] x86/resctrl: Add arch_needs_linear to explain
> AMD/Intel MBA difference
> 
> The configuration values user-space provides to the resctrl filesystem
> are ABI. To make this work on another architecture we want to move all
> the ABI bits out of /arch/x86 and under /fs.
> 
> To do this, the differences between AMD and Intel CPUs needs to be
> explained to resctrl via resource properties, instead of function
> pointers that let the arch code accept subtly different values on
> different platforms/architectures.
> 
> For MBA, Intel CPUs reject configuration attempts for non-linear
> resources, whereas AMD ignore this field as its MBA resource is never
> linear. To merge the parse/validate functions we need to explain
> this difference.
> 
> Add arch_needs_linear to indicate the arch code needs the linear
> property to be true to configure this resource. AMD can set this
> and delay_linear to false. Intel can set arch_needs_linear
> to true to keep the existing "No support for non-linear MB domains"
> error message for affected platforms.
> 
> CC: Babu Moger <Babu.Moger@amd.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reviewed-by: Babu Moger <babu.moger@amd.com>

> 
> ---
> An alternative to this is for Intel non-linear MBA resources to
> clear alloc_capable as they can't be configured anyway.
> ---
>  arch/x86/kernel/cpu/resctrl/core.c        | 3 +++
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 8 +++++++-
>  arch/x86/kernel/cpu/resctrl/internal.h    | 2 ++
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c
> b/arch/x86/kernel/cpu/resctrl/core.c
> index e1fed3928b59..c6b73b0ee070 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -260,6 +260,7 @@ static bool __get_mem_config_intel(struct rdt_resource
> *r)
>  	r->num_closid = edx.split.cos_max + 1;
>  	max_delay = eax.split.max_delay + 1;
>  	r->default_ctrl = MAX_MBA_BW;
> +	r->membw.arch_needs_linear = true;
>  	if (ecx & MBA_IS_LINEAR) {
>  		r->membw.delay_linear = true;
>  		r->membw.min_bw = MAX_MBA_BW - max_delay;
> @@ -267,6 +268,7 @@ static bool __get_mem_config_intel(struct rdt_resource
> *r)
>  	} else {
>  		if (!rdt_get_mb_table(r))
>  			return false;
> +		r->membw.arch_needs_linear = false;
>  	}
>  	r->data_width = 3;
> 
> @@ -288,6 +290,7 @@ static bool __rdt_get_mem_config_amd(struct
> rdt_resource *r)
> 
>  	/* AMD does not use delay */
>  	r->membw.delay_linear = false;
> +	r->membw.arch_needs_linear = false;
> 
>  	r->membw.min_bw = 0;
>  	r->membw.bw_gran = 1;
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index 934c8fb8a64a..e3bcd77add2b 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -33,6 +33,12 @@ static bool bw_validate_amd(char *buf, unsigned long
> *data,
>  	unsigned long bw;
>  	int ret;
> 
> +	/* temporary: always false on AMD */
> +	if (!r->membw.delay_linear && r->membw.arch_needs_linear) {
> +		rdt_last_cmd_puts("No support for non-linear MB domains\n");
> +		return false;
> +	}
> +
>  	ret = kstrtoul(buf, 10, &bw);
>  	if (ret) {
>  		rdt_last_cmd_printf("Non-decimal digit in MB value %s\n", buf);
> @@ -82,7 +88,7 @@ static bool bw_validate(char *buf, unsigned long *data,
> struct rdt_resource *r)
>  	/*
>  	 * Only linear delay values is supported for current Intel SKUs.
>  	 */
> -	if (!r->membw.delay_linear) {
> +	if (!r->membw.delay_linear && r->membw.arch_needs_linear) {
>  		rdt_last_cmd_puts("No support for non-linear MB domains\n");
>  		return false;
>  	}
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
> b/arch/x86/kernel/cpu/resctrl/internal.h
> index dd51e23e346b..0b288b6fefd9 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -370,6 +370,7 @@ struct rdt_cache {
>   * struct rdt_membw - Memory bandwidth allocation related data
>   * @min_bw:		Minimum memory bandwidth percentage user can
> request
>   * @bw_gran:		Granularity at which the memory bandwidth is allocated
> + * @arch_needs_linear:	True if we can't configure non-linear resources
>   * @delay_linear:	True if memory B/W delay is in linear scale
>   * @mba_sc:		True if MBA software controller(mba_sc) is enabled
>   * @mb_map:		Mapping of memory B/W percentage to memory B/W
> delay
> @@ -378,6 +379,7 @@ struct rdt_membw {
>  	u32		min_bw;
>  	u32		bw_gran;
>  	u32		delay_linear;
> +	bool		arch_needs_linear;
>  	bool		mba_sc;
>  	u32		*mb_map;
>  };
> --
> 2.19.1

