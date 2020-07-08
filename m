Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83611C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C44920774
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QcfiHbRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgGHNOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:14:31 -0400
Received: from mail-dm6nam12on2054.outbound.protection.outlook.com ([40.107.243.54]:19921
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729167AbgGHNO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:14:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hk3GrGAPve5m7i0uKNcLlsmjKF+TF+ICladSTpw9CgwrjXmc2D5VDsh6AXC/QVPN4ykUdDoj3qGXhJ3C1Nyk87JmoBsAqYRMTSM58gCxAh/yD5kv+Gv43zO1/CJrGHcDxOe0/5fqYF5s8zzjWRltMxVOLWZK4MjEn5U6W/3ItSR+FyxymvrlTCo0x60Te0AbenYSToCCW8eUEjoAdab8qMnoYdQnm6eWLNnWvb2pzaAym2iiHSUfZnIkdUM/dQwvphEW9kB9NkVSxfGjm2UWKGQ6GmkI/3Vvb4l0v1+avcKCKLodRG5Gyrww1iap1d3cMfw7zoVUIHkoC4QxxsFvFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWoGhX71UWptRC1OzmZAW5MA2mpcXrTlTVTmPZwPflc=;
 b=ncWy/xxQYE9pXdhU9d4HfqCWRjeUKxx4Rtt9bHDzwY81/tBP7VKfSEnSEOHFOUhvOl0u6/vE3ms5E03EwBq+r1kkqipTDmNIidpQ4AWPxv9NrLVLFbPr2tovOqCZ2Jpf5XeFAHqWOiNenh+xrNk+fDxIpBn4DkWzSSGfnEGba9didlTfS+AFcRtnCGjrL1TsTDNB0LcYWBoJqVURXSRxrVHoCUZcQxP3x0Ej4mqTQRARLhxSvcijHB9ftP2+p2jBuElFCFOOUMf9yqoL431MF6z9xhI6H8wExzYNi+0RRvPQF2sJDP88YHgNhq0UKBSgRzeBQUap98l6x9ryy1TdTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWoGhX71UWptRC1OzmZAW5MA2mpcXrTlTVTmPZwPflc=;
 b=QcfiHbRPibigM9GvknAh5o8WEo/wNPeiAGF+DBK64/zf4W5lGw1IEy3OCZpvpQWl0DpXKnZx4Gv9Jyaqc37hyhwZ0vT3Dy9VZ5pMt3N8r4V/HjYfL+1xcViGP1dmETf/uAVUSL7+4IT+vYgRD2Se3WtVA8IAcr744nZeh8F7tIo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB3274.namprd12.prod.outlook.com (2603:10b6:5:182::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.23; Wed, 8 Jul 2020 13:14:27 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::25ec:e6ba:197c:4eb0]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::25ec:e6ba:197c:4eb0%8]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 13:14:27 +0000
Subject: Re: arch/arm64/kernel/acpi.c:99:30: sparse: sparse: incorrect type in
 return expression (different address spaces)
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel test robot <lkp@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <202006230441.zXXGmJJO%lkp@intel.com>
 <CAHp75Vc-+NCA=1CX+0GQfUNK-Mn1Y6-aj8TdCvm+pNBKF-Ax1g@mail.gmail.com>
 <CAHp75VeE=BrT5haBt8EL+ARGKah6D48XznTPf8RGseyXi=jRcw@mail.gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <5b3d1bb9-445c-729f-abe3-dae5fd5af3c2@amd.com>
Date:   Wed, 8 Jul 2020 08:14:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <CAHp75VeE=BrT5haBt8EL+ARGKah6D48XznTPf8RGseyXi=jRcw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0008.namprd21.prod.outlook.com
 (2603:10b6:805:106::18) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.118] (165.204.77.1) by SN6PR2101CA0008.namprd21.prod.outlook.com (2603:10b6:805:106::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.4 via Frontend Transport; Wed, 8 Jul 2020 13:14:26 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f0314265-51ed-4f12-bfd4-08d82340d72a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3274:
X-Microsoft-Antispam-PRVS: <DM6PR12MB327449732AF2F1C53A8BBA85EC670@DM6PR12MB3274.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-Forefront-PRVS: 04583CED1A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hbNSWlycnLOQLDezir1s3Fd86913mkCOxAw7RZ9z3ALv/Yk3uexai11My0m/d3tboC0Kpb2iYP7RzZIcKonKtX0kb+3qDKwPpay6ImR6PrSDJT6Bv7X16YPudqOdGxcxAq2M1eVShB6UZDpY64i6wQ5K3L6OijM2OrGUb90yId+ymoUz/1NNjtNdAPynj+TRpqES2Ph0TCG4SIMluQmVBWQIRteaXU/j4nGh9Ld+5rmxITg7DPnOb9RyZWBeMSkIUqxYixgS4C1LgZrHv/mJ8EB9a6WRc4vWsRp/5KF0pQnx8l72LvnkoLhL+R3s2/772Ew+b05f068jmBrEbQAVcsU16GPz0WWRHvlyl8kM7vrIeku9Sb981ZSblsI/unNcajmU7gEU4F0pGlbf0JgZ5bq3o7l1AUxuawh0g+HADUSpzOdWRH2qZcsTkMKjTPRskCuQReS4v/BWS4G19XsSow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(39850400004)(366004)(136003)(346002)(6486002)(8676002)(36756003)(26005)(16526019)(52116002)(83380400001)(186003)(2906002)(45080400002)(966005)(478600001)(31696002)(54906003)(86362001)(16576012)(110136005)(66946007)(316002)(8936002)(2616005)(4326008)(53546011)(956004)(66476007)(66556008)(31686004)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: KsJjEPiOQRILcDschJJUnr3yf4JvjDitqlu2K2aWyX+H1QBcfOWJeFapGwEVChc6ReZDlOM8VVPvD/VIpYvkuKnaSWtEkm9iqULemGIfNpebWxWQw2yraqpnSt3M9X6CmZPMm64zbjIVUtb625O85/lbUlDGzye1iudUZ4CvbIaUt1DW5zJSWs1C1GSQMda/4RLGHuI1DUbQQuaqnm7CfKq/xAigW/C1qgSvTKRGgUEPkD7JmWgwh4bm4Ndy9GlWGjjA9xd1Ep6nd8wGCO5PSyh+ZfV4P5O9EfFdhZmFlztJCh1ywXgIMlV6zhaQCc3k1lJsGIdQBeB1kY4HiNVu9kTDCtZ+aMFUYs4ZMJVTtnel2ACnm3OuTgL5N2pnjpTj4vAcoK6W3LYoxrTYJoYfCgpyVsCNr39Sp5p0hJNC5MzX7nd/NwU+A++1i13JiLTIDoQYyJKGEeIl7FNidew1ce8ouR3vRBS7O6Dp4un0zbA=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0314265-51ed-4f12-bfd4-08d82340d72a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 13:14:26.9546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nO/V4e1GVLq9DdcSo0ALeHPYlKcw6FbMlgxXn1vkXxD1s1zMKZ3x2Nviez2AuRYOdK6qKNQl+ddhFMZU58WTBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3274
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/20 4:55 PM, Andy Shevchenko wrote:
> On Tue, Jun 23, 2020 at 12:42 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>>
>> On Mon, Jun 22, 2020 at 11:53 PM kernel test robot <lkp@intel.com> wrote:
>>>
>>> tree:   https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&amp;data=02%7C01%7Cthomas.lendacky%40amd.com%7C22287276fb644db559c908d816f70d4f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637284597621062483&amp;sdata=Kc%2Fk%2B39BMLFJW6MwcqHxMUkygKU7DJdTITq25UdCGr0%3D&amp;reserved=0 master
>>> head:   dd0d718152e4c65b173070d48ea9dfc06894c3e5
>>> commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
>>> date:   4 days ago
>>> config: arm64-randconfig-s031-20200622 (attached as .config)
>>> compiler: aarch64-linux-gcc (GCC) 9.3.0
>>> reproduce:
>>>         # apt-get install sparse
>>>         # sparse version: v0.6.2-rc1-18-g27caae40-dirty
>>>         git checkout 670d0a4b10704667765f7d18f7592993d02783aa
>>>         # save the attached .config to linux build tree
>>>         make W=1 C=1 ARCH=arm64 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
>>>
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>
>>>
>>> sparse warnings: (new ones prefixed by >>)
>>>
>>>>> arch/arm64/kernel/acpi.c:99:30: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
>>>>> arch/arm64/kernel/acpi.c:99:30: sparse:     expected void [noderef] __iomem *
>>>    arch/arm64/kernel/acpi.c:99:30: sparse:     got void *
>>>>> arch/arm64/kernel/acpi.c:107:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *map @@
>>>    arch/arm64/kernel/acpi.c:107:24: sparse:     expected void *addr
>>>>> arch/arm64/kernel/acpi.c:107:24: sparse:     got void [noderef] __iomem *map
>>
>> ...
>>
>>> 6c9a58e84e59a2 Andy Shevchenko 2017-07-18   94  void __init __iomem *__acpi_map_table(unsigned long phys, unsigned long size)
>>> 6c9a58e84e59a2 Andy Shevchenko 2017-07-18  102  void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
>>
>> Seems like a new sparse fixed some sparse issues and reveals that the
>> above was a mistake and should be reverted.
> 
> Either this patch
> f7750a79568788473c5e8092ee58a52248f34329 x86, mpparse, x86/acpi,
> x86/PCI, x86/dmi, SFI: Use memremap() for RAM mappings
> shouldn't change to memremap(), or

This patch is required for proper functioning of SME/SEV support and
should not be reverted.

Thanks,
Tom

> 
> void __iomem __ref *acpi_os_map_iomem(acpi_physical_address phys,
> acpi_size size);
> void __ref acpi_os_unmap_iomem(void __iomem *virt, acpi_size size);
> 
> Should be cleaned so they either not working with __iomem, or in
> special cases force address space for above mentioned functions.
> 
