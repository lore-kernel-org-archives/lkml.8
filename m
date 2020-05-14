Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD34C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 20:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFD1B2065F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 20:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="h0gM5857"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgENUGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 16:06:18 -0400
Received: from mail-mw2nam10on2071.outbound.protection.outlook.com ([40.107.94.71]:6196
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728070AbgENUGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 16:06:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIdziI/2pDuDUEws5dHgOdH5wjl6X/KIbQyaVUiAcBrXpObm+LXxN2Qx7pKh0nCTR6DFG3zE6nRwj0G3Kqs6tPYX7tLJ3Ijg7wNyj6Q3rqnwO0xodanh9MqNe8mWnhOaBNMQ5LTsbKk8SLlLWUfRRTS6BYqpLkPlS9s94lrCMOGEYKvtj1gddktZF3oWzBdCj02wssvXaR1Vmrjtu5aQXaF5i5kjqjO9IYm2FPWmhCh8OgCPubxcw2HJtWXw5Jbtwd8LFdgM2YwmmerBL0FL9Q4etI/zzKQBj69Feh0ODPyc4FgpTZ5Kf+P+Q5/+7OGCOGTO45zxWeQgWlJvwHJSEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xWxvfTmo9rHuzHoMnM8XgEP7KI90pyij9D/E//lh10=;
 b=lBI0vd5f7PF0HaZW9ZRPhoOnBtzcxmRYiMNuYAEBVfFelV3XmcKHFx9xb9ID053REOAl/J1/VBptBYY447FQNIRZ0C3jWlxMxzQ46GoMZcUJkGPxCGKYgSdtDPe+b+stfJLcdTiofs1veu1m9iiI613MwVuQsnNidaB9FQbYGLK0hpV/M7bQArrWHVfXAmHLFE0NHMxk2XxJPUthuSmJvckhAhan4uj7NMsLaVniLKK4o/JI2kC8uq2+KYRhZ6AveCfqMw250HKnKXXgs9yiqTAVe9r/M4gZou5P79Z5St3+vRTYoKwZULsNXU4yCV7dA1osGUy35HVQcQ9BX0NI3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xWxvfTmo9rHuzHoMnM8XgEP7KI90pyij9D/E//lh10=;
 b=h0gM5857UOVFzWfXSR/6Iud4NbOMB+c97ZHU8bwGDg2e08DkEz84GRsBbADCb4EG9/RVmNIyKm7E3j+wuzT6RwQiavI7gwB2U1MBPeRSfjG+rlqig5mF6uJThM3JkzntHay4dL07zl6gsJBO0bxzzshypeNyRN2bWAvYW6a0alg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2544.namprd12.prod.outlook.com (2603:10b6:802:2b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Thu, 14 May
 2020 20:06:11 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::c0f:2938:784f:ed8d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::c0f:2938:784f:ed8d%7]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 20:06:11 +0000
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
 <0d1fc0a8-7544-861e-a2f6-42c34ad798d9@amd.com>
 <591cfbf0-fe1d-d96c-9842-79e62e76fbfe@intel.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <18d277fd-6523-319c-d560-66b63ff606b8@amd.com>
Date:   Thu, 14 May 2020 15:06:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <591cfbf0-fe1d-d96c-9842-79e62e76fbfe@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0083.namprd12.prod.outlook.com
 (2603:10b6:802:21::18) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by SN1PR12CA0083.namprd12.prod.outlook.com (2603:10b6:802:21::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Thu, 14 May 2020 20:06:10 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6b6567b1-ced2-4c62-5925-08d7f8423fa6
X-MS-TrafficTypeDiagnostic: SN1PR12MB2544:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2544C17F81324EEADFDC058D95BC0@SN1PR12MB2544.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xr0XLhkJPNWoGdXcdg6VjLLdIpQHebSx6MjYpqEcOeJE0fDgO6tz5yIQAokxfMBezdpp9KchpiMdK9eP6NzHhsMZJkEvwIv2yhopo/8qlFW6R1J3J97DjwaeahdClaeER6YWk50cy3X7O8vjOQcrXKJF+TrPgrNbUzFwKC1e/XasVRdr00nHBL5UQ+5Q7bPpdZ7kb+MlIAsjgIugGQ27uuXsThHVe4ARx7vuUUgwvCc0PfXZzKnRpCa7LhGX1hP4oRIem7TLYC2M65hTwwD2tuefdE/u9wkqxt1ecXnc3Xa1kqyaoLzgg8tSe4G+zesC3OZAkxN+ECZ6NDFPbUbHEvVqp4FaFPcmN2gRmXhgOtcwyA7bHa+bP3wND5Lguijx6gFAvC/t2X5+4pvrNSe+BeEI8sUBor9twiWJ/iS0E3eIMZPC0rN1qmOL/jfdm757NtcKuf4kaDoRSKyS3GR6POfN5MHg9DivUkv0AHSxIOEjy/ZEw7F4/Hw16qBtM0H1+8sk+Cyn2d42OYeLsQr33xEwpuePCiB98YwVgld3RMoRTr5qLnGKzqiRiuS3fL3D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(52116002)(83080400001)(478600001)(31696002)(2906002)(8936002)(45080400002)(7416002)(966005)(53546011)(44832011)(16526019)(31686004)(5660300002)(54906003)(6666004)(86362001)(110136005)(66556008)(316002)(26005)(6486002)(36756003)(4326008)(16576012)(8676002)(186003)(66946007)(66476007)(2616005)(956004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: h4Fgn/YhBb7nh3TTvT+6mJ9MCw2KuAnh28ottiGC84Fh/OzFh8lkoorRNpvY7BGkZq/4o3lqRB6fW8CBJqShwIikTB8R9cgocuAEqYSzpeTXSwQOoh6r3GODGUcFKncLnta5p6yVjLmgrcjX/CnhQWd0nWHUEigvhOpgdpSSvfM7uIjQhxML2CzSH/iFVi7NIB0Q8I2CA1DhQBXjVk7Lo1UoACd1DW5JGTwvWZcXBQEgKMAmJJ9GbZrRB015TB/XJcJF7TS0juAWViimr/U94hXeUjkhw4uvLmolpKWxBuI4OFRFepE2dHezmFMY8+h3kz4AT4VZTobB+Oq9c8kkFEhNpdAkLVHBKEz/2g6NsHEep/HCuC26wOh1FTMWHiDLd7F0bUyaGIpjxvLSDjg46jwG/r/fNzcb3b5zvDFd+AB2ZDs99xMn+scfr3zU4jV63oFiSd64UKqFaL738OpJJs+kgQ5kZMCU2pYl2Vxjefc=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b6567b1-ced2-4c62-5925-08d7f8423fa6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 20:06:11.7499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y4ZOq6+BCbOu/xHcMLi/4WC1xIabyTqeftcXWNGbsKwjamynfVpv4QDZTxIAP1+Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2544
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Reinette Chatre <reinette.chatre@intel.com>
> Sent: Thursday, May 14, 2020 1:11 PM
> To: Moger, Babu <Babu.Moger@amd.com>; tglx@linutronix.de;
> fenghua.yu@intel.com; bp@alien8.de; tony.luck@intel.com
> Cc: kuo-lang.tseng@intel.com; ravi.v.shankar@intel.com; mingo@redhat.com;
> hpa@zytor.com; x86@kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH V3 1/4] x86/resctrl: Enable user to view and select thread
> throttling mode
> 
> Hi Babu,
> 
> Thank you very much for taking a look.
> 
> On 5/14/2020 9:45 AM, Babu Moger wrote:
> > Hi Reinnette,
> >
> > The patches did not apply on my tree. I got the latest tree today. You
> 
> Which tree did you use as baseline? These patches should apply cleanly
> on top of the other resctrl patches already queued for inclusion into
> v5.8 as found on the x86/cache branch of the tip repo.

Oh. Ok. I was using linux master.  Never mind..

> 
> > might want to check again.
> > Hunk #1 FAILED at 29.
> > 1 out of 7 hunks FAILED -- saving rejects to file
> > arch/x86/kernel/cpu/resctrl/rdtgroup.c.rej
> >
> >
> >> -----Original Message-----
> >> From: Reinette Chatre <reinette.chatre@intel.com>
> >> Sent: Wednesday, May 6, 2020 6:50 PM
> >> To: tglx@linutronix.de; fenghua.yu@intel.com; bp@alien8.de;
> >> tony.luck@intel.com
> >> Cc: kuo-lang.tseng@intel.com; ravi.v.shankar@intel.com;
> mingo@redhat.com;
> >> Moger, Babu <Babu.Moger@amd.com>; hpa@zytor.com; x86@kernel.org;
> >> linux-kernel@vger.kernel.org; Reinette Chatre <reinette.chatre@intel.com>
> >> Subject: [PATCH V3 1/4] x86/resctrl: Enable user to view and select thread
> >> throttling mode
> >>
> 
> ...
> 
> >> diff --git a/arch/x86/kernel/cpu/resctrl/core.c
> >> b/arch/x86/kernel/cpu/resctrl/core.c
> >> index 12f967c6b603..1bc686777069 100644
> >> --- a/arch/x86/kernel/cpu/resctrl/core.c
> >> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> >> @@ -250,6 +250,30 @@ static inline bool rdt_get_mb_table(struct
> rdt_resource
> >> *r)
> >>  	return false;
> >>  }
> >>
> >> +/*
> >> + * Model-specific test to determine if platform where memory bandwidth
> >> + * control is applied to a core can be configured to apply either the
> >> + * maximum or minimum of the per-thread delay values.
> >> + * By default, platforms where memory bandwidth control is applied to a
> >> + * core will select the maximum delay value of the per-thread CLOS.
> >> + *
> >> + * NOTE: delay value programmed to hardware is inverse of bandwidth
> >> + * percentage configured via user interface.
> >> + */
> >> +bool mba_cfg_supports_min_max_intel(void)
> >> +{
> >> +	switch (boot_cpu_data.x86_model) {
> >> +	case INTEL_FAM6_ATOM_TREMONT_D:
> >> +	case INTEL_FAM6_ICELAKE_X:
> >> +	case INTEL_FAM6_ICELAKE_D:
> >> +		return true;
> >> +	default:
> >> +		return false;
> >> +	}
> >> +
> >> +	return false;
> >> +}
> >
> > I see that you are calling this function multiple times. Why don't you
> 
> It is called:
> - once during initialization
> - once per package initialization (when first CPU on a package comes online)
> - once per read from or write to the new "thread_throttle_mode" file
> 
> > make it as a property in rdt_resource. Set it only once during the
> > init(may be in get_mem_config_intel). Then you can use it wherever
> > required. This also probably help James to make everything architecture
> > independent. What do you think?
> 
> If I understand correctly this would require understanding how each
> architecture behaves in this regard to ensure the property within
> rdt_resource is initialized correctly. While it could just be set within
> get_mem_config_intel as you suggest, this property would be present in
> AMD's resource and thus need a value ... could you please provide
> guidance what this property should be on AMD? I looked at the bandwidth
> enforcement section of
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdevelop
> er.amd.com%2Fwp-
> content%2Fresources%2F56375.pdf&amp;data=02%7C01%7Cbabu.moger%40a
> md.com%7C5e7d546489d54002870808d7f8322934%7C3dd8961fe4884e608e11
> a82d994e183d%7C0%7C0%7C637250766898923893&amp;sdata=hQ6usFmXiUX
> p%2BZCrM2qdVn2Z3Ggx1c2g4nVwrEqrzG4%3D&amp;reserved=0 but it is not
> obvious to me where bandwidth is actually enforced and how this
> enforcement is affected when threads and/or cores are running tasks with
> different CLOS that have different bandwidth limits assigned.
> 
> With AMD's properties understood then the new "thread_throttle_mode"
> file could be visible on all platforms, not just Intel, and display
> accurate values for all and be architecture independent.
> 
> Alternatively, the new property could have values: UNDEFINED, MIN, MAX,
> or PER_THREAD ... with AMD having UNDEFINED and the
> "thread_throttle_mode" continues to be visible on Intel platforms only.
> 
> I would appreciate your thoughts on this.

Here is the text from spec.
"Platform QOS features are implemented on a logical processor basis.
Therefore, multiple hardware threads of a single physical CPU core may
have independent resource monitoring and enforcement configurations."

So, bandwidth allocation is already at thread level. But AMD does not use
memory delay throttle model to control the allocation like Intel does. So,
I would say you can initialize it as UNDEFINED not to cause any confusion.


> 
> > I assume that this property is probably not part of CPUID.
> 
> Correct. This specific property is model specific, but also transient in
> that it is replaced by X86_FEATURE_PER_THREAD_MBA (that is part of
> CPUID) in future platforms.
> 
> Reinette
