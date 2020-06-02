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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6153CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EB1320810
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mQABlHxG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgFBObC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 10:31:02 -0400
Received: from mail-bn8nam12on2080.outbound.protection.outlook.com ([40.107.237.80]:57632
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726043AbgFBObB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 10:31:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DjvmKDmBqkzzkAk+FnH9W5BUR0tHmXtYF5fv3H+nQCGquZ8h9Q5spGKMPuChxnumPXDvvVMT81rK+OY0xACx0s602g5R6YW8tmnsovzFfZL3OgUTAL6kgf2Gnr6p6dZF+9cJG1DLb42JXmr/fwlaulUrAM9XrzP0kSUBK4TnUi7+5e6h6CuSHZd5vLffmqGKN6Bn7UDKchqVcNQ0VeaAXBOoX1BplcqZCg0rB2ak873mWYfRuwrzdmKOw3Q4lxui8TXSh/MrIF+7MZIlTY+tO2hWjOVDKjc0drxKZY3PoIo+reJMXEqfNIc1hjQMdHyJ0kFzQk11BS/y6PasZrZGkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEvhPEce+38apYaRRaRvgqEr44B5aJQxUOHS9Otz5zE=;
 b=PwrflJWG/G//V2JlUOgy8zmQ3jpwg84iDC8h0kMBPSBrEiwcnRM3kMMaGz1ukyhv2s7fFo4cY1CQafHUHxUnwGhiAserRTc5IxWMrfl0yBecA/XPV+TR9/4GL2qJIlP6Dg13sgd9FUM8FhsnOwwlHgRAz4AcXR0k2/8HmDjeiKtCD+dXl5RMEQEyOxOqJZ40Fkl7Lr5WQkuWAMwnQe9tOXz8b4zYAyyW+AdB5nBs5+8KUjD5+rGihLUzRlATA/FQP7DEJ77yC4JqIS2tHoBze7Yi2sRQHMqaVROxwv4JThvcLvbWyB/Oa4Y0p9T1DdXQvO4E1PXqJJbM1lDSWj00AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEvhPEce+38apYaRRaRvgqEr44B5aJQxUOHS9Otz5zE=;
 b=mQABlHxG+vrQqjWU+XqUnd27Ag2djL/xQQ8BmpiUemUgl7nBO/dbfR2y3bW9x+JV2uSyB1O/rt8im5OdnwJBZ14WWX5rKxIweoXV2dhD73p1Hw8TnGghwhfSDl5qV/9nGYcmzg1i4a5WF+/UdFwen+j6/DYjgndMLPiRCgdA7F4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2542.namprd12.prod.outlook.com (2603:10b6:802:26::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Tue, 2 Jun
 2020 14:30:58 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2%3]) with mapi id 15.20.3045.024; Tue, 2 Jun 2020
 14:30:58 +0000
Subject: RE: [PATCH] x86/resctrl: Fix memory bandwidth counter width for AMD
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <159105232628.48268.7763865625735367523.stgit@naples-babu.amd.com>
 <20200601232318.GA57376@romley-ivt3.sc.intel.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <b66d3781-1353-8f0e-95ff-425d31143c7b@amd.com>
Date:   Tue, 2 Jun 2020 09:30:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200601232318.GA57376@romley-ivt3.sc.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR18CA0029.namprd18.prod.outlook.com
 (2603:10b6:5:15b::42) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.79] (165.204.77.1) by DM6PR18CA0029.namprd18.prod.outlook.com (2603:10b6:5:15b::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19 via Frontend Transport; Tue, 2 Jun 2020 14:30:57 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6514a6ed-2c66-49b0-4723-08d8070190ce
X-MS-TrafficTypeDiagnostic: SN1PR12MB2542:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2542AD4A3A4CE6C951160500958B0@SN1PR12MB2542.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7rrbLLYuGf0wCTczm683MRl9zghN17Jc2pLApRkYpfeviXae7Y539GO7vVGO4SGKt7HPty9/4ZHtYyfJId8so2/WwIbYFXkbaA3Ilh0a7MNlQP2B0N9jPV5iQGmRms/FzKx2zzY733NoqGf6FnMkQqrbIdlFalVU0wpVc0Rxsp6jILd5qnclaA982j6QIyJMioedrmDqhDQUa/sKBrjh9ZhmTLIiE9fZIEwYUgSbWTlE9BWgqx5ONs+h3JhyejFrbKiuWua24AEhTxiWrlyRlAec2XzqYBMY6Zjjdhfk7h3Sqe3tJcwC+6jF5GvZWqoeh3ArlxytUvuPbNJkn/FQpIDvCBPiFE882bIGtA6HGxUQPPFIPbT3Hd5Q3wgav7aY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(31696002)(86362001)(2906002)(6916009)(44832011)(316002)(16576012)(5660300002)(54906003)(6486002)(66476007)(956004)(31686004)(66556008)(4326008)(26005)(478600001)(2616005)(186003)(16526019)(52116002)(66946007)(53546011)(36756003)(83380400001)(8676002)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: MvNgxB5CUiLqw/EQKtU47KXIbSfw4rib+LpbyMBvtYDXtlNZNo2sBs1l6qOkjJO3k3uzAMgstmoziYsosrBQcSwMRR3SzECL/65XwIndKn3QZOQ4q3QxNcAERO8F61ca1QvM3td25R/PlKTfeKDDwgAsi1ulqR4sIpQDTu0D4ntmRr2nNYtczpvs6vKZChV1i7l4B2lMRWHFuWH0oSrPWZxmTfWJOwn+qiXMg/f4JhYtfABpI6U4QjR58pwxyy2EyPIOdsBhyCkwkg5eV/K74nh0+L9/7eaRJPtnNQ9mM0nG2giIZ4rx/NeaMkCNiUJy/dpeT7NtffJ63GHXARZnlUSGa4ZkA9EZ1ykqaSKpgP24mqomjPjhLtzW3kAKOqPNw01G+h+3XbBTONatieCU10FSgqavjSIP+4QTKrw0ksWTUe1Um7kk/u5NCl71RPblj2eDIHUGd4w1pvDcFrXK5GXQzlvypuWMWJEp3DPECHY=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6514a6ed-2c66-49b0-4723-08d8070190ce
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 14:30:58.0393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+et2iZYTfiEMlzwBza3JbO6RWR6WhPNVulFxEnd16uFgFU9XrcScrZmQEd7f4gM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2542
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,

> -----Original Message-----
> From: Fenghua Yu <fenghua.yu@intel.com>
> Sent: Monday, June 1, 2020 6:23 PM
> To: Moger, Babu <Babu.Moger@amd.com>
> Cc: reinette.chatre@intel.com; tglx@linutronix.de; mingo@redhat.com;
> bp@alien8.de; x86@kernel.org; hpa@zytor.com; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] x86/resctrl: Fix memory bandwidth counter width for AMD
> 
> On Mon, Jun 01, 2020 at 06:00:29PM -0500, Babu Moger wrote:
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
> > +				c->x86_cache_mbm_width_offset = eax & 0xff;
> 
> When AMD implements CPUID.0x1f.1:eax, will the offset be based on 24 or 44?
> Seems it makes senses to be based on 44 because default counter width is 44.

It will be based on 24 just like Intel. So, it will be 24 + offset

> 
> > +			else
> > +				c->x86_cache_mbm_width_offset =
> > +					MBM_CNTR_WIDTH_OFFSET_AMD;
> 
> If that's the case, you don't need this "else" because the CPUID reports
> offset as 0 for default width 44.
> 
> This will match the Intel code above.
> 
> Otherwise, the code is awkward.

Yes. It is bit awkward. Other way is to add check in
rdt_get_mon_l3_config. I thought this way is better.
Thanks
