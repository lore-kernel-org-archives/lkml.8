Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C00C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 22:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0271B2072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 22:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LUePeN+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgFBWMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 18:12:17 -0400
Received: from mail-dm6nam10on2089.outbound.protection.outlook.com ([40.107.93.89]:5185
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726112AbgFBWMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 18:12:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5g46+xxqTgWU6I+eUfhkFjMoN2yHji2VR9GHDFkzCO2OJAaih59JGNe+XUVgabLPAzhS0dJAmVoRGFChxVUk5rldvhqudTkMInikgLKzBLxOaWu55Nwl9T/8rdG8mHYnZrrVJUt2q4g9bnFCcKbXK+mXKT1CeWmzLZY0ZN0BJ4oe4ABrU+qxuTLrlGM/mmiko+AF7DQfURF3x+rJf7OPVezqZI84hxxPHuId5Y+1nwJfmrfEjPc5l1UueRlkIl2E1XaS1m3Alxi/D94k4t6/0h1Fpxbq6k7SRY20EVaCDq/BdlFEsqr/WcTNZ0pVlcouhFOSyRH0RnPTbsE7pXSCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoCOobOMm/+k0g13A2zKf2k2WTNpM1P9VcpwfP71Qts=;
 b=WPmODchOfpkbB3AMdLgJLxiwlyqkq4i5LuEBrPfXbFXfu76sTqXwQ2Zl9a1F/TQm4sHv9yilhCvC5zVd10Mmcodoxdyh7RStLDebFMk7HYqD/Hcdr88AbZ1suSg3evNeOSZQHzyWxX3cS7BVpr48ScpEi4Bzuk1m/cMPBT6UUEjaWBB5/p+g3GdP0L0B8fRTb3OiqrjGXavY5c0VdmfDbsgPwdMQTOmo8Hw/aPODAGprJMF+emkC7Z3+IHFO2p3JyEFgAwi8KX/C4v7B8xrvcpvF2y2KbtEQ9ggKdPWRmD+RyiV2OwDzvYcBnjWK+Kt6BJG1Iv49a+yMCb2wja2m5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoCOobOMm/+k0g13A2zKf2k2WTNpM1P9VcpwfP71Qts=;
 b=LUePeN+XwnCQ3Ico4+hzk0eHNd1lDj7kOAO0t5CH6SBjcL/dKQS8Uma4Qfi1edZSOP2nj2XPRo7ROzW+xStuRTzIVEbLko6rKV6xFyyQOQWhM4ooBM2XvqnutuUFADr9TzK/KFIBvYrJH/J8BgUZfYmTv2+0ISqp3fG1eSEuKxw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2463.namprd12.prod.outlook.com (2603:10b6:802:22::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Tue, 2 Jun
 2020 22:12:12 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2%3]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 22:12:12 +0000
Subject: RE: [PATCH] x86/resctrl: Fix memory bandwidth counter width for AMD
To:     Reinette Chatre <reinette.chatre@intel.com>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <159105232628.48268.7763865625735367523.stgit@naples-babu.amd.com>
 <b7625596-c1f9-798d-a138-b619178497b2@intel.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <c7c5c0e5-6839-234e-38e0-69834aa2c8dd@amd.com>
Date:   Tue, 2 Jun 2020 17:12:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <b7625596-c1f9-798d-a138-b619178497b2@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0701CA0017.namprd07.prod.outlook.com
 (2603:10b6:803:28::27) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.79] (165.204.77.1) by SN4PR0701CA0017.namprd07.prod.outlook.com (2603:10b6:803:28::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19 via Frontend Transport; Tue, 2 Jun 2020 22:12:12 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a7816d29-2615-4579-b927-08d807420010
X-MS-TrafficTypeDiagnostic: SN1PR12MB2463:
X-Microsoft-Antispam-PRVS: <SN1PR12MB24630E4C92B726CB13C5127E958B0@SN1PR12MB2463.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dzyKl3pktLU6oqTHAWLpTMw1GYMVraPqeVeqe3L4D04oSBQKFUpXofvSyDN0IFFokPDO+l/EcHFIHarQxqbAqCdqf8wRoIpPLwFTHW749jyFIZQ4JnuD0aR8P4aEX73c9FJfnt6Kvq095BzeLk9//yKgEHtgPHZeLhyVApMJizMic+s4KLpEkZOCZt11sU0D81rCm/HrPu413JQUHcrgQ7Lh2xrDKfQ+WqOnO5rMP79c3TMO0ccaPocPTE/XcbrVjsG57D1MWhLK5C9R7I5CptDQNgZU6mKl3NG60hDsQ/PQW1chhRK0EMSsA34yAx8Z81LPTiR84oEOlShBtFCKxaASOFEYQMo6nqzpHCGjVWALoNn7COoErKR6RpJFDVd7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(31696002)(8936002)(66946007)(8676002)(66476007)(66556008)(52116002)(2906002)(6486002)(5660300002)(26005)(956004)(16526019)(2616005)(186003)(16576012)(110136005)(316002)(478600001)(44832011)(53546011)(83380400001)(36756003)(31686004)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: BAio/9qEKvuqqgjiNtCnpwcgm4qAXzGIijZ6cCjbSdF4PAE4umOcl+6HLM2eIh4lxoD9cxRwNnPzNoKXsruZOdOzT1DGgurVXwroVolB+UFMwnlyTuCsPaAGKesGBKDtXm6S09N1IRrpALYJzKGoe4Gbw6/zqfqJaVWdNl1XmTjNZtWD2iuc/FGf7XV5rtfV5i51mfK9NZgF8eHPNumV4KK0xAqyoJMEKl+/LjUABVr1E/6998iYUaZLPYmkCdzChNJtCywrPmtygP3gwTZ+jrHiYTJ7R6erX3X3K4iWLMMFMb/QR9JGyjf7qRwHWZjbEgmq/aQi7SDAGJyx8g0URH+4BO+9riCyWriR2iihXmqgXaFnwtUCwiS6TYM/kZXHKjKOLMQCKJ6re5cNJ7ZtAE3Gptgl/uoUMhfoDXPJD/86qPHRPwneVNv1tv8mYdILD6xE0CnvqFsDbRWY6ITYoMP8tnUE4Gucg9cbt1y7RzE=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7816d29-2615-4579-b927-08d807420010
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 22:12:12.4666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fkgg208uD4KtGtPRTqTgZ5Tk3a7quR60mFiYFFRfmcKr6gRmqWtKDFs0jcmpZoRU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2463
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Reinette Chatre <reinette.chatre@intel.com>
> Sent: Tuesday, June 2, 2020 4:51 PM
> To: Moger, Babu <Babu.Moger@amd.com>; fenghua.yu@intel.com;
> tglx@linutronix.de; mingo@redhat.com; bp@alien8.de; x86@kernel.org;
> hpa@zytor.com; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] x86/resctrl: Fix memory bandwidth counter width for AMD
> 
> Hi Babu,
> 
> On 6/1/2020 4:00 PM, Babu Moger wrote:
> > Memory bandwidth is calculated reading the monitoring counter
> > at two intervals and calculating the delta. It is the software’s
> > responsibility to read the count often enough to avoid having
> > the count roll over _twice_ between reads.
> >
> > The current code hardcodes the bandwidth monitoring counter's width
> > to 24 bits for AMD. This is due to default base counter width which
> > is 24. Currently, AMD does not implement the CPUID 0xF.[ECX=1]:EAX
> > to adjust the counter width. But, the AMD hardware supports much
> > wider bandwidth counter with the default width of 44 bits.
> >
> > Kernel reads these monitoring counters every 1 second and adjusts the
> > counter value for overflow. With 24 bits and scale value of 64 for AMD,
> > it can only measure up to 1GB/s without overflowing. For the rates
> > above 1GB/s this will fail to measure the bandwidth.
> >
> > Fix the issue setting the default width to 44 bits by adjusting the
> > offset.
> >
> > AMD future products will implement the CPUID 0xF.[ECX=1]:EAX.
> >
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > ---
> > - Sending it second time. Email client had some issues first time.
> > - Generated the patch on top of
> >    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git (x86/cache).
> >
> >  arch/x86/kernel/cpu/resctrl/core.c     |    8 +++++++-
> >  arch/x86/kernel/cpu/resctrl/internal.h |    1 +
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kernel/cpu/resctrl/core.c
> b/arch/x86/kernel/cpu/resctrl/core.c
> > index 12f967c6b603..6040e9ae541b 100644
> > --- a/arch/x86/kernel/cpu/resctrl/core.c
> > +++ b/arch/x86/kernel/cpu/resctrl/core.c
> > @@ -983,7 +983,13 @@ void resctrl_cpu_detect(struct cpuinfo_x86 *c)
> >  		c->x86_cache_occ_scale = ebx;
> >  		if (c->x86_vendor == X86_VENDOR_INTEL)
> >  			c->x86_cache_mbm_width_offset = eax & 0xff;
> > -		else
> > +		else if (c->x86_vendor == X86_VENDOR_AMD) {
> > +			if (eax)
> 
> This test checks if _any_ bit is set in eax ...
> 
> > +				c->x86_cache_mbm_width_offset = eax & 0xff;
> 
> ... with the assumption that the first eight bits contain a value.
> 
> Even so, now that Intel and AMD will be using eax in the same way,
> perhaps it can be done simpler by always using eax to obtain the offset
> (and thus avoid the code duplication) and on AMD initialize the default
> if it cannot be obtained from eax?
> 
> What I mean is something like:
> 
> @@ -1024,10 +1024,12 @@ void resctrl_cpu_detect(struct cpuinfo_x86 *c)
> 
>  		c->x86_cache_max_rmid  = ecx;
>  		c->x86_cache_occ_scale = ebx;
> -		if (c->x86_vendor == X86_VENDOR_INTEL)
> -			c->x86_cache_mbm_width_offset = eax & 0xff;
> -		else
> -			c->x86_cache_mbm_width_offset = -1;
> +		c->x86_cache_mbm_width_offset = eax & 0xff;
> +		if (c->x86_vendor == X86_VENDOR_AMD &&
> +		    c->x86_cache_mbm_width_offset == 0) {
> +			c->x86_cache_mbm_width_offset =
> +				MBM_CNTR_WIDTH_OFFSET_AMD;
> +		}
>  	}
>  }
> 
> What do you think?

That looks good. But we still need to keep the
default(c->x86_cache_mbm_width_offset = -1;) for non-AMD and non-Intel.
How about this?

diff --git a/arch/x86/kernel/cpu/resctrl/core.c
b/arch/x86/kernel/cpu/resctrl/core.c
index 12f967c6b603..7269bd896ba9 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -983,6 +983,9 @@ void resctrl_cpu_detect(struct cpuinfo_x86 *c)
                c->x86_cache_occ_scale = ebx;
                if (c->x86_vendor == X86_VENDOR_INTEL)
                        c->x86_cache_mbm_width_offset = eax & 0xff;
+               else if (c->x86_vendor == X86_VENDOR_AMD)
+                       c->x86_cache_mbm_width_offset = eax ? eax & 0xff :
+
MBM_CNTR_WIDTH_OFFSET_AMD;
                else
                        c->x86_cache_mbm_width_offset = -1;
        }
