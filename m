Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E901BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 20:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7694C205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 20:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JinwTQR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390795AbgEMUE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 16:04:28 -0400
Received: from mail-eopbgr680059.outbound.protection.outlook.com ([40.107.68.59]:53070
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733117AbgEMUE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 16:04:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7pwHyMsU7zp0PovYCTX1DEzOfVQKJwbLzfwuT2Wtf+9/xyVFFsm985Vid1JwTmssMdWWSxO/53Q2xbKIJnVd4vd4OyC+HgVXL3ic5sukWTGDzCPP2mXMg3wwbHB1CF4O7Ajs8J/AjXDV1DjdLN8kJMgy+L4z9Ol53bEhd2+lTLJO82HeWxaa0LsputrG5MAE7mFutunuAxHUg8ltdTDXZxwQcFysfiQlQrrKnx5hV1ds3cTwtBJhIEnIaB6cYGEucBq7Ztx38UnpWYHWRM/c4XoxlsS7pcmf9j+oSdwW7Ikfz9LDCxBwAMIJsUIfYiiwuZxRgq7Ga7vgjt3Gee1UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jxxBx3Fmfq45QmMEqohpmQEpSCXMZEL1P8ZCOz+Nfs=;
 b=Y8OKnQQmeP1wSYl9gTr5H6r0xFKpAHbwPCL0w08CaC61BEN9WndrIWtMMNqWwVgs16uYTrWZtR0QHwvvzRR7V1YNXSVs8lvYLKLC/SlAQUdygjE715M3JRh/ry8n4P0qDN2CMcEmnJLVARbdvJiIY4K3S71RIfrY+mR8ZnZ+N5hSCc9+TSkB8c/PdUOe6c2kTEcLj5Hvcv4S4gQThSzoaRK28GO533NSZ1gZq1jNiEhCMJxZkejg4RXPzSdFhUTZ6GCq6V///EvOVPlr+T19FksrUcmVUaSHKCbVUNzOh+QLM5HXts8TdutY2mEOdEnJfx5a+zm1MyhkVVTBcIxQ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jxxBx3Fmfq45QmMEqohpmQEpSCXMZEL1P8ZCOz+Nfs=;
 b=JinwTQR+n7r8Ob1cYo9uD7nmGpkUO1qswAZzn0R8m0UlN+VRQya14R389bJhiAf2u5D8JKAjPLLGUVtSex+UZhZ+uS2zAKiRjNhfjkPBE9jwkonwucssEkEaAuk6/AWP8jeFK7fhCtOxUZeNUXzJIgRD8SfOaXx4VHchkagyvqk=
Authentication-Results: zytor.com; dkim=none (message not signed)
 header.d=none;zytor.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2352.namprd12.prod.outlook.com (2603:10b6:802:25::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Wed, 13 May
 2020 20:04:25 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::c0f:2938:784f:ed8d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::c0f:2938:784f:ed8d%7]) with mapi id 15.20.3000.022; Wed, 13 May 2020
 20:04:25 +0000
Subject: RE: [PATCH v2 10/10] cacheinfo: Move resctrl's get_cache_id() to the
 cacheinfo header file
To:     James Morse <james.morse@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>
References: <20200430170400.21501-1-james.morse@arm.com>
 <20200430170400.21501-11-james.morse@arm.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <a1255e05-6056-a731-9244-3a3ec84d1cb2@amd.com>
Date:   Wed, 13 May 2020 15:04:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200430170400.21501-11-james.morse@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR17CA0051.namprd17.prod.outlook.com
 (2603:10b6:3:13f::13) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by DM5PR17CA0051.namprd17.prod.outlook.com (2603:10b6:3:13f::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24 via Frontend Transport; Wed, 13 May 2020 20:04:23 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 29804eca-c397-42e4-9136-08d7f778d587
X-MS-TrafficTypeDiagnostic: SN1PR12MB2352:
X-Microsoft-Antispam-PRVS: <SN1PR12MB23529CF943BE02FE6785161D95BF0@SN1PR12MB2352.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j42aKClu+aufpIhU56zPygiu1SB9f7RG57kiUuT6p41GRlgRTDy+sdMHvX5Bx65c63zw7bOqS92qVUNAFZ88ETdkP5HXYo/36iJfAdJeKrYjOc0WSFRSc6dWrZBw1Sq0a64Y+r2Br2Be+BTE84V0Ol/nI2QaMRzWY5MPcAvHtVigtckZ56xEg6PEJc2FrXSAmZTktmrPsguUoxO1jOWDN6b7R9xEGdabXujfx29eSZKXbyzr0JFd537LffjPBqEGXCPa/6qTp9HQcWfwHybev3Oe/PNm/WADTCmXzQO7zExVtfyLT0egySS3AeFz9nXqA2n2Y008Pf4aSyjbxu751tjLQHCiWx65CksRRi2SPo6hzQFjw/EwJzsmNcaaYpSizpxV74MBeUGZZxJrBhiqCEIeXOT97axRocrO3+dMOtlVGSqZb1+egA1EZtmUChmRbyp1BA9diUAG1k1b4ZSAy3Xqss0ttX5fR1yiiftB1vMEj4mSLsaRut47RnlT4F2Sbjk9Hg0S9C66Ly4U7KQni/wfhTcNbx/r6KWuFGTI2iz85L0cH+hXdjrcyjpF/Q/D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(33430700001)(110136005)(6486002)(16576012)(33440700001)(44832011)(31696002)(66556008)(4326008)(66476007)(316002)(478600001)(31686004)(54906003)(8676002)(956004)(2906002)(36756003)(86362001)(186003)(2616005)(53546011)(8936002)(26005)(52116002)(16526019)(66946007)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: zi3mfB0TEYD4A57FCIyq1IrQB9wrJdnz1+Mrc9uorZ10kkuPzumPY6nNcGDeg1DPi/pmJpMDgZkhZzWP3FNf6Il3Sn8Bqo45EkP2qKEE7B8vDbqU86bg2tRD7u/1fezb/qabisSQrcrE8jmJ2ADVF0n+ZYU9SoxP5BVqcWospqZTwjwO4br93IjUKALxqESRU5fh5U04dlAV/Zlg3EU2AzI8rOVxvnHjvrDwRzEYOuqb5TNazA9UV9xDW2KPMptDY6dlnJyLal5E2hM49gyt6i1bTxahQyJpJuFC5pvrRC39xqaH/SShOyDHLTMyndj32XVHma27QjYgczbD4Hu7phx/3hBUqfzkdiluMA8FbtxelgOOWtKeScAboX31nAH8cn3Pe03XMsCBt3bT8XN/a2qaxmQtCkuFYWxlkelfxGIDtHqrzZJ93LQ6Rin7TtFDjOdNlXqFUAKIJnH5GIiln7DOobvG6/gkStbVPkH5Jag=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29804eca-c397-42e4-9136-08d7f778d587
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 20:04:24.9760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oeubI+RBFhVmF5YwWYtFkI73UhAtrjESNhLzUrvXKjXIBSDiq6K+CGl7ieTKP4bK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2352
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: James Morse <james.morse@arm.com>
> Sent: Thursday, April 30, 2020 12:04 PM
> To: x86@kernel.org; linux-kernel@vger.kernel.org
> Cc: Fenghua Yu <fenghua.yu@intel.com>; Reinette Chatre
> <reinette.chatre@intel.com>; Thomas Gleixner <tglx@linutronix.de>; Ingo
> Molnar <mingo@redhat.com>; Borislav Petkov <bp@alien8.de>; H Peter Anvin
> <hpa@zytor.com>; Moger, Babu <Babu.Moger@amd.com>; James Morse
> <james.morse@arm.com>
> Subject: [PATCH v2 10/10] cacheinfo: Move resctrl's get_cache_id() to the
> cacheinfo header file
> 
> resctrl/core.c defines get_cache_id() for use in its cpu-hotplug
> callbacks. This gets the id attribute of the cache at the corresponding
> level of a cpu.
> 
> Later rework means this private function needs to be shared. Move
> it to the header file.
> 
> The name conflicts with a different definition in intel_cacheinfo.c,
> name it get_cpu_cacheinfo_id() to show its relation with
> get_cpu_cacheinfo().
> 
> Now this is visible on other architectures, check the id attribute
> has actually been set.
> 
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Babu Moger <babu.moger@amd.com>

> ---
>  arch/x86/kernel/cpu/resctrl/core.c | 17 ++---------------
>  include/linux/cacheinfo.h          | 21 +++++++++++++++++++++
>  2 files changed, 23 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c
> b/arch/x86/kernel/cpu/resctrl/core.c
> index 00c88f42742c..f6458cefcac3 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -350,19 +350,6 @@ static void rdt_get_cdp_l2_config(void)
>  	rdt_get_cdp_config(RDT_RESOURCE_L2, RDT_RESOURCE_L2CODE);
>  }
> 
> -static int get_cache_id(int cpu, int level)
> -{
> -	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(cpu);
> -	int i;
> -
> -	for (i = 0; i < ci->num_leaves; i++) {
> -		if (ci->info_list[i].level == level)
> -			return ci->info_list[i].id;
> -	}
> -
> -	return -1;
> -}
> -
>  static void
>  mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m, struct
> rdt_resource *r)
>  {
> @@ -560,7 +547,7 @@ static int domain_setup_mon_state(struct rdt_resource
> *r, struct rdt_domain *d)
>   */
>  static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  {
> -	int id = get_cache_id(cpu, r->cache_level);
> +	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
>  	struct list_head *add_pos = NULL;
>  	struct rdt_domain *d;
> 
> @@ -606,7 +593,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource
> *r)
> 
>  static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>  {
> -	int id = get_cache_id(cpu, r->cache_level);
> +	int id = get_cpu_cacheinfo_id(cpu, r->cache_level);
>  	struct rdt_domain *d;
> 
>  	d = rdt_find_domain(r, id, NULL);
> diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
> index 46b92cd61d0c..4f72b47973c3 100644
> --- a/include/linux/cacheinfo.h
> +++ b/include/linux/cacheinfo.h
> @@ -3,6 +3,7 @@
>  #define _LINUX_CACHEINFO_H
> 
>  #include <linux/bitops.h>
> +#include <linux/cpu.h>
>  #include <linux/cpumask.h>
>  #include <linux/smp.h>
> 
> @@ -119,4 +120,24 @@ int acpi_find_last_cache_level(unsigned int cpu);
> 
>  const struct attribute_group *cache_get_priv_group(struct cacheinfo
> *this_leaf);
> 
> +/*
> + * Get the id of the cache associated with @cpu at level @level.
> + * cpuhp lock must be held.
> + */
> +static inline int get_cpu_cacheinfo_id(int cpu, int level)
> +{
> +	struct cpu_cacheinfo *ci = get_cpu_cacheinfo(cpu);
> +	int i;
> +
> +	for (i = 0; i < ci->num_leaves; i++) {
> +		if (ci->info_list[i].level == level) {
> +			if (ci->info_list[i].attributes & CACHE_ID)
> +				return ci->info_list[i].id;
> +			return -1;
> +		}
> +	}
> +
> +	return -1;
> +}
> +
>  #endif /* _LINUX_CACHEINFO_H */
> --
> 2.26.1

