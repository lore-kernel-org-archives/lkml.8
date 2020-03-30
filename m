Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD73FC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8860920771
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WwE2k8bV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbgC3W0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 18:26:14 -0400
Received: from mail-eopbgr690080.outbound.protection.outlook.com ([40.107.69.80]:1856
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729210AbgC3W0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 18:26:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKrkTWc7oFH3d97J/K2QNmmGQLCe7IKt+MbD7hfupSxAnaZgI8nFeg8CBt5G2wikruAKfwYng9Kk4G50MNNj6/RHx6R3advpwRO9ThcasinRQRIYywgvVe+5XXYtaYWNBPezNukxVxJDZJayHRt6pqmSP6K+1eNFxh+z/vHML/bACc7ZV9WTfyMpSTFpwy/i6Mn8xbdM+Lb8g/YlkDYL7FnlmL2qfK80XG6Or7aGfoU8huWPSav7mwrI+eThGeJ9XkhFA1w2LiHAcg3dbcJ6M07CSOCn+EgbtmkoTpr0NK8v9/HaWmYR1P1o6qRk5oIuXdY1slnqSvUeTS+Qr7AN+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ozG5w59M3QSRn+8hX5T4j3YGLUMDX23sksYDBV/xBc=;
 b=L2riKfhmAhFh7JJCFfQxV5/CG2waCRD/Go9w27WA6THWqayWOAgw7qo9C1/tjIYbksByLUSqLiS+VVrBNFSVSeRg234phS2MY2PitPM9JaxJh4QjrSBODoUmLfcxmUM0d47aIzTW9av2GgnnIgh6FarRLT5ZxRYPrrcshsbfh/ipIhY4Bo+iQi9KPQMvGBwA2IytZyn8gGJjGoEaisau9xuWI8M0BrVTpe0lKMZpA/R7wDHg7oUh3iKAmrGkIIWR/Xqqd1oZkpT7kfweg6sSnTmenHiOcUhqE6n0WvTOW9tGDYej91cRgNr/OYykNgNdq3ptiNb41AiSjBAozz3OMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ozG5w59M3QSRn+8hX5T4j3YGLUMDX23sksYDBV/xBc=;
 b=WwE2k8bV4YLV6MmHBdZiRqeW0pje/WZdlVkl+24SvCCg+W0rzmHWpdf3mQ0CyQ0mesyJlqfL1DEBilWYsXAlh6aus5Ujim/hv8jopKdUKhT4ia4xwVAl4E3WbovJBgQK2H/fRYIXgbex5H4A/dG7XwUyfsuKsjIQIz2sCkPbogE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ashish.Kalra@amd.com; 
Received: from DM5PR12MB1386.namprd12.prod.outlook.com (2603:10b6:3:77::9) by
 DM5PR12MB1529.namprd12.prod.outlook.com (2603:10b6:4:3::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.18; Mon, 30 Mar 2020 22:25:58 +0000
Received: from DM5PR12MB1386.namprd12.prod.outlook.com
 ([fe80::969:3d4e:6f37:c33c]) by DM5PR12MB1386.namprd12.prod.outlook.com
 ([fe80::969:3d4e:6f37:c33c%12]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 22:25:58 +0000
Date:   Mon, 30 Mar 2020 22:25:51 +0000
From:   Ashish Kalra <ashish.kalra@amd.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Konrad Rzeszutek Wilk <konrad@darnok.org>, hch@lst.de,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, luto@kernel.org, peterz@infradead.org,
        dave.hansen@linux-intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, brijesh.singh@amd.com,
        Thomas.Lendacky@amd.com
Subject: Re: [PATCH v2] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20200330222551.GA22743@ashkalra_ubuntu_server>
References: <20191209231346.5602-1-Ashish.Kalra@amd.com>
 <20191220015245.GA7010@localhost.localdomain>
 <20200121200947.GA24884@ashkalra_ubuntu_server>
 <20200121205403.GC75374@Konrads-MacBook-Pro.local>
 <20200124230008.GA1565@ashkalra_ubuntu_server>
 <20200204193500.GA15564@ashkalra_ubuntu_server>
 <20200303170353.GC31627@char.us.oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303170353.GC31627@char.us.oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: DM6PR02CA0040.namprd02.prod.outlook.com
 (2603:10b6:5:177::17) To DM5PR12MB1386.namprd12.prod.outlook.com
 (2603:10b6:3:77::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server (165.204.77.1) by DM6PR02CA0040.namprd02.prod.outlook.com (2603:10b6:5:177::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18 via Frontend Transport; Mon, 30 Mar 2020 22:25:57 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 46578906-bf3a-4ed1-1fec-08d7d4f951fc
X-MS-TrafficTypeDiagnostic: DM5PR12MB1529:|DM5PR12MB1529:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB15294EE0B6237E7BFAD824C68ECB0@DM5PR12MB1529.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1386.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(478600001)(33716001)(8676002)(44832011)(1076003)(16526019)(26005)(8936002)(4326008)(186003)(6666004)(5660300002)(2906002)(956004)(66476007)(6496006)(52116002)(7416002)(86362001)(316002)(9686003)(6916009)(55016002)(66946007)(33656002)(81166006)(81156014)(66556008);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V1eB7G48QnrtsRJcDuk9F12pAvZdUr3SiHJH+k0u1Jj+3v17+jB920DPTfx5RDvYe4EKPLcRSC4bvJQftngH6TS5KeCaNbeRg5tpOKGMzI0nPPH9GYG04A7sJJjVh4L8R7DDznNWR9v0ly/XoKlWpemISvcS9553hd6Qv3zFWt+BAk7R54B5vTBYCcTqG4gwCC53ac9+TM232gx6VQW04LPwIcd5dVe7rS/urSLie6YKPnvPnLQl5vipU9LFa2R1oXmNFDSpyqGrJeNsF6Uhw8cGh4Z8zZJ+sjd0oHdY/lQlzdllpkUqT1FaGGnz2N+bYv0rv6WFoyBCCA1RqyRG1AgVzYn7xiqwkJqRR2wyn5u/koUCRUlj3i3phcvu4g9p1+rH2qVLyqtSpJGXB5kCWbWUaTOAkf0Unz9WUdsdhKi7NwINohAHuksF5jgAQvk2
X-MS-Exchange-AntiSpam-MessageData: jFZUvw8CreeiIy9zj2r7I7MqNB/3zFI5ncg28de0/HhpBep58lvlaV1iw8f0LoKAhr4ieJo7rssJiHUDObZwTgKIMtIPDEYMNxzN3me52ri1Cj0lYoxQfYdJvf8/gL+AlLlYopHtn2ik1JzCKknRLQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46578906-bf3a-4ed1-1fec-08d7d4f951fc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 22:25:58.6116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LnJbc6XInHonQTJ3JygCS0jLQj8wkU+CWOEDzPRYqWLRW36wzEwEjXgzRiXUHfh/zJn5FObg3NyesbyCeTqx1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1529
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Konrad,

On Tue, Mar 03, 2020 at 12:03:53PM -0500, Konrad Rzeszutek Wilk wrote:
> On Tue, Feb 04, 2020 at 07:35:00PM +0000, Ashish Kalra wrote:
> > Hello Konrad,
> > 
> > Looking fwd. to your feedback regarding support of other memory
> > encryption architectures such as Power, S390, etc.
> > 
> > Thanks,
> > Ashish
> > 
> > On Fri, Jan 24, 2020 at 11:00:08PM +0000, Ashish Kalra wrote:
> > > On Tue, Jan 21, 2020 at 03:54:03PM -0500, Konrad Rzeszutek Wilk wrote:
> > > > > 
> > > > > Additional memory calculations based on # of PCI devices and
> > > > > their memory ranges will make it more complicated with so
> > > > > many other permutations and combinations to explore, it is
> > > > > essential to keep this patch as simple as possible by 
> > > > > adjusting the bounce buffer size simply by determining it
> > > > > from the amount of provisioned guest memory.
> > > >> 
> > > >> Please rework the patch to:
> > > >> 
> > > >>  - Use a log solution instead of the multiplication.
> > > >>    Feel free to cap it at a sensible value.
> > > 
> > > Ok.
> > > 
> > > >> 
> > > >>  - Also the code depends on SWIOTLB calling in to the
> > > >>    adjust_swiotlb_default_size which looks wrong.
> > > >> 
> > > >>    You should not adjust io_tlb_nslabs from swiotlb_size_or_default.
> > > 
> > > >>    That function's purpose is to report a value.
> > > >> 
> > > >>  - Make io_tlb_nslabs be visible outside of the SWIOTLB code.
> > > >> 
> > > >>  - Can you utilize the IOMMU_INIT APIs and have your own detect which would
> > > >>    modify the io_tlb_nslabs (and set swiotbl=1?).
> > > 
> > > This seems to be a nice option, but then IOMMU_INIT APIs are
> > > x86-specific and this swiotlb buffer size adjustment is also needed
> > > for other memory encryption architectures like Power, S390, etc.
> 
> Oh dear. That I hadn't considered.
> > > 
> > > >> 
> > > >>    Actually you seem to be piggybacking on pci_swiotlb_detect_4gb - so
> > > >>    perhaps add in this code ? Albeit it really should be in it's own
> > > >>    file, not in arch/x86/kernel/pci-swiotlb.c
> > > 
> > > Actually, we piggyback on pci_swiotlb_detect_override which sets
> > > swiotlb=1 as x86_64_start_kernel() and invocation of sme_early_init()
> > > forces swiotlb on, but again this is all x86 architecture specific.
> 
> Then it looks like the best bet is to do it from within swiotlb_init?
> We really can't do it from swiotlb_size_or_default - that function
> should just return a value and nothing else.
> 

Actually, we need to do it in swiotlb_size_or_default() as this gets called by
reserve_crashkernel_low() in arch/x86/kernel/setup.c and used to
reserve low crashkernel memory. If we adjust swiotlb size later in
swiotlb_init() which gets called later than reserve_crashkernel_low(),
then any swiotlb size changes/expansion will conflict/overlap with the
low memory reserved for crashkernel.

Thanks,
Ashish
