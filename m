Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC9EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AA0020679
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Mmy7w/DR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgFCPEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 11:04:22 -0400
Received: from mail-mw2nam10on2082.outbound.protection.outlook.com ([40.107.94.82]:56672
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725930AbgFCPEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 11:04:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gt5P8TNT4MIamy+ssvhySEbDJ14wL5slUifqIz0IQhjTH3h/m3tap8sM43Q83J3O1TfLZKvO/yAfMEcyhwTSgx+sW9mtMuDfGpLU9Le73/qEtcRq95qClbi7T7/Jf8SD66KLfaIHXWvzlGnpX5chPH31DGR5hXsZv3NazgKA+sgnRLMbdtX1d2/y2XcLnD98zclvot4pbluCekVriGNle2+wWv+Fyf+eJ8PWRUnNXVUsYKGuPfWhZnUNvtzJqO4EI6BBQbUloHuxwWL+BZH1YF2vD40FfIpzIXVgXnaMQuvY9bR9VI3gymYdETbHjn4MJMf3Sk0iXCWhhdqSjrc3aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2L8TRbviClBFGaertjUnPL10lQlIA51I1O7bZ7IkGHw=;
 b=Rg6Oj9ZcirK92kRyb2sEM34YCFmRmGDIi/k4vxU7bqp1wqCt/076jLmHi2aMxe/PqMtf29xIB9H/FuMBQ1QWeNkj2DtqZLWHIh+PpTSfUtbPJ5qLOGnA/4kPTps5AfNR4nWba7P9ll0KDL3mhOmI2VRzAGQCMy7/94wqEb521mA/7vGc68lRzrsrEwcos/46jSwBtgdYpotWtr9hUQ1DHFTOpPCFKCGFS+t+n3XoqapyXZNptHjk1EypLtK5RxRTmOCNoPWG6GIn/ZbQ21SwZj31ox3CuL+bhaMKNJ04+iYUY9v3UjtmLwyNGIxVYYN3oL2YPRiIdcze5O06Muo5mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2L8TRbviClBFGaertjUnPL10lQlIA51I1O7bZ7IkGHw=;
 b=Mmy7w/DRm7hE9Jw7ZS99zArBWMdWj6abgcC8O0wisMF2xt1YtTmh6Z9jCKgTitjvdphu+fbTwqo70uRPmaz6d2Wwtux67pCcmSmMqGHyCsWP4MO7NN53jhMn5r9WrvDinojD4zI5h9+fZViuY1mNBUh6EG2h0OirnNofYQmaQTs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2575.namprd12.prod.outlook.com (2603:10b6:802:25::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 3 Jun
 2020 15:04:18 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2%3]) with mapi id 15.20.3045.024; Wed, 3 Jun 2020
 15:04:17 +0000
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
 <c7c5c0e5-6839-234e-38e0-69834aa2c8dd@amd.com>
 <6cc9bdb5-bf41-ed8b-0b30-3464d6c290b9@intel.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <e66f9bf4-d6b4-fe0a-48fc-405afff54961@amd.com>
Date:   Wed, 3 Jun 2020 10:04:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <6cc9bdb5-bf41-ed8b-0b30-3464d6c290b9@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0701CA0011.namprd07.prod.outlook.com
 (2603:10b6:803:28::21) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.79] (165.204.77.1) by SN4PR0701CA0011.namprd07.prod.outlook.com (2603:10b6:803:28::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Wed, 3 Jun 2020 15:04:17 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 78aa0155-b960-4729-25dd-08d807cf6328
X-MS-TrafficTypeDiagnostic: SN1PR12MB2575:
X-Microsoft-Antispam-PRVS: <SN1PR12MB25758ED0771AD33720106B8E95880@SN1PR12MB2575.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0pB/cQzTduErcSDK6TjWIm9lnJteT10uz2Gf2Dx2cWoI5uauDhfU/2FCahCmAlwrOT3rH3GqQhD1ci2mZoPLer4W0O+LGiGmc5buy97z3XsTLK0jL4dGG49gMHtG3iCfMbeEbMOGNCM57WsVwLbJufpKiPab78LFzqmQjhKmJEqQB4tbO27FsVTW2E/NdjbR5LGIQ8oRpW0ehPwKHLhZQn4i4KjY1T/rb5sXVf+HGKWkkJ9/ieKDrMGjvimSfeqojoamOMdwpZz7JtUyI3xZPk1Yp4v62i/y3ym8AVke7Yw75IyZrWdtO7EKhst4Jy87f8p/af34Ww7tPbLaytbDaMmboEYKjM2EYoOgK4FAfo+UODByq6Vjyj95yP2Lt6Cn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(110136005)(26005)(16576012)(8676002)(44832011)(8936002)(186003)(16526019)(31696002)(316002)(53546011)(83380400001)(2616005)(956004)(31686004)(6486002)(5660300002)(66946007)(52116002)(66476007)(36756003)(478600001)(66556008)(2906002)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: akkuTl5tj53s2x6w12XJ+BVZQd9c+rL0hSEgyS7hP9lu6iT3poKT1+t9rlI7SeoJrouB/I4C+yBOM02K26fk+s8Z8vawpvwxASLCIuj4UZ0mli/nskZ0mTwHCisgVIQZZH4d5eX2SM5+YKe/6jtTdLKdkw/kljOL+FWXWkk/2b3fYE4q1lkzIJi67uWIFCRksF6SyCu4EFfoSnZo5leKKSF68Vx/vn4AkxX004Rmfazg7v0NiSaQPm4wEY2AKQYIjS6yvTN0Yv3GjeQ1/5sO/rk3dDYC0dza+wKhvvMuxZzHSqn1jkbZgvAWZBNllJlp06DZEvwtcyhxLWM9hfQzUkX3NFSCKLd9UaG4ga0kjAnEWKst9Vjxm7smjO0TQE+K2ZEgfG7wOcYiKGmD5cuEyAdyVH5PqyeDbjiVlYOzDxmIp3q1+SVP4rSWNvUMn4tjIt7iDNyYrfzQW9v80JsRkXevWSknBbRCqjsjtVJWu0Y=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78aa0155-b960-4729-25dd-08d807cf6328
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 15:04:17.8134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Zw9nAVAt2u4DUUnPFZQfP4FXjLR9bpQUYb8KLoyHsjrTn3Vj0jtOLI5pBjSDGc0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2575
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

> -----Original Message-----
> From: Reinette Chatre <reinette.chatre@intel.com>
> Sent: Tuesday, June 2, 2020 6:28 PM
> To: Moger, Babu <Babu.Moger@amd.com>; fenghua.yu@intel.com;
> tglx@linutronix.de; mingo@redhat.com; bp@alien8.de; x86@kernel.org;
> hpa@zytor.com; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] x86/resctrl: Fix memory bandwidth counter width for AMD
> 
> Hi Babu,
> 
> On 6/2/2020 3:12 PM, Babu Moger wrote:
> >
> >
> >> -----Original Message-----
> >> From: Reinette Chatre <reinette.chatre@intel.com>
> >> Sent: Tuesday, June 2, 2020 4:51 PM
> >> To: Moger, Babu <Babu.Moger@amd.com>; fenghua.yu@intel.com;
> >> tglx@linutronix.de; mingo@redhat.com; bp@alien8.de; x86@kernel.org;
> >> hpa@zytor.com; linux-kernel@vger.kernel.org
> >> Subject: Re: [PATCH] x86/resctrl: Fix memory bandwidth counter width for
> AMD
> >>
> >> Hi Babu,
> >>
> >> On 6/1/2020 4:00 PM, Babu Moger wrote:
> >>> Memory bandwidth is calculated reading the monitoring counter
> >>> at two intervals and calculating the delta. It is the software’s
> >>> responsibility to read the count often enough to avoid having
> >>> the count roll over _twice_ between reads.
> >>>
> >>> The current code hardcodes the bandwidth monitoring counter's width
> >>> to 24 bits for AMD. This is due to default base counter width which
> >>> is 24. Currently, AMD does not implement the CPUID 0xF.[ECX=1]:EAX
> >>> to adjust the counter width. But, the AMD hardware supports much
> >>> wider bandwidth counter with the default width of 44 bits.
> >>>
> >>> Kernel reads these monitoring counters every 1 second and adjusts the
> >>> counter value for overflow. With 24 bits and scale value of 64 for AMD,
> >>> it can only measure up to 1GB/s without overflowing. For the rates
> >>> above 1GB/s this will fail to measure the bandwidth.
> >>>
> >>> Fix the issue setting the default width to 44 bits by adjusting the
> >>> offset.
> >>>
> >>> AMD future products will implement the CPUID 0xF.[ECX=1]:EAX.
> >>>
> >>> Signed-off-by: Babu Moger <babu.moger@amd.com>
> >>> ---
> >>> - Sending it second time. Email client had some issues first time.
> >>> - Generated the patch on top of
> >>>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git (x86/cache).
> >>>
> >>>  arch/x86/kernel/cpu/resctrl/core.c     |    8 +++++++-
> >>>  arch/x86/kernel/cpu/resctrl/internal.h |    1 +
> >>>  2 files changed, 8 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c
> >> b/arch/x86/kernel/cpu/resctrl/core.c
> >>> index 12f967c6b603..6040e9ae541b 100644
> >>> --- a/arch/x86/kernel/cpu/resctrl/core.c
> >>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> >>> @@ -983,7 +983,13 @@ void resctrl_cpu_detect(struct cpuinfo_x86 *c)
> >>>  		c->x86_cache_occ_scale = ebx;
> >>>  		if (c->x86_vendor == X86_VENDOR_INTEL)
> >>>  			c->x86_cache_mbm_width_offset = eax & 0xff;
> >>> -		else
> >>> +		else if (c->x86_vendor == X86_VENDOR_AMD) {
> >>> +			if (eax)
> >>
> >> This test checks if _any_ bit is set in eax ...
> >>
> >>> +				c->x86_cache_mbm_width_offset = eax & 0xff;
> >>
> >> ... with the assumption that the first eight bits contain a value.
> >>
> >> Even so, now that Intel and AMD will be using eax in the same way,
> >> perhaps it can be done simpler by always using eax to obtain the offset
> >> (and thus avoid the code duplication) and on AMD initialize the default
> >> if it cannot be obtained from eax?
> >>
> >> What I mean is something like:
> >>
> >> @@ -1024,10 +1024,12 @@ void resctrl_cpu_detect(struct cpuinfo_x86 *c)
> >>
> >>  		c->x86_cache_max_rmid  = ecx;
> >>  		c->x86_cache_occ_scale = ebx;
> >> -		if (c->x86_vendor == X86_VENDOR_INTEL)
> >> -			c->x86_cache_mbm_width_offset = eax & 0xff;
> >> -		else
> >> -			c->x86_cache_mbm_width_offset = -1;
> >> +		c->x86_cache_mbm_width_offset = eax & 0xff;
> >> +		if (c->x86_vendor == X86_VENDOR_AMD &&
> >> +		    c->x86_cache_mbm_width_offset == 0) {
> >> +			c->x86_cache_mbm_width_offset =
> >> +				MBM_CNTR_WIDTH_OFFSET_AMD;
> >> +		}
> >>  	}
> >>  }
> >>
> >> What do you think?
> >
> > That looks good. But we still need to keep the
> > default(c->x86_cache_mbm_width_offset = -1;) for non-AMD and non-Intel.
> > How about this?
> 
> This original default of -1 was added to deal with AMD when it was not
> known to support eax. Now that AMD's support of eax is captured among
> the default code I did not find it necessary to keep that considering
> resctrl_cpu_detect() is only called on AMD and Intel.

Ok. Sure. Will re-post with changes.

> > diff --git a/arch/x86/kernel/cpu/resctrl/core.c
> > b/arch/x86/kernel/cpu/resctrl/core.c
> > index 12f967c6b603..7269bd896ba9 100644
> > --- a/arch/x86/kernel/cpu/resctrl/core.c
> > +++ b/arch/x86/kernel/cpu/resctrl/core.c
> > @@ -983,6 +983,9 @@ void resctrl_cpu_detect(struct cpuinfo_x86 *c)
> >                 c->x86_cache_occ_scale = ebx;
> >                 if (c->x86_vendor == X86_VENDOR_INTEL)
> >                         c->x86_cache_mbm_width_offset = eax & 0xff;
> > +               else if (c->x86_vendor == X86_VENDOR_AMD)
> > +                       c->x86_cache_mbm_width_offset = eax ? eax & 0xff :
> 
> This has the same concern that I mentioned earlier where the contents of
> the entire register is used to determine if the first eight bits
> contains a value. Did I miss something obvious?

You are right. I will make the change as you suggested. Thanks

> 
> > +
> > MBM_CNTR_WIDTH_OFFSET_AMD;
> >                 else
> >                         c->x86_cache_mbm_width_offset = -1;
> >         }
> >
> 
> Reinette
