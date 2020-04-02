Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E64C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF8420678
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eTReEbIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387529AbgDBHeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:34:19 -0400
Received: from mail-dm6nam10on2088.outbound.protection.outlook.com ([40.107.93.88]:2144
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725845AbgDBHeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 03:34:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnUIy16Z9lDU+XLXwFychWr1ZIWhhwfF1mpMY7k/K64AaAULkQCi03fJgpRZ721aMbOBepxjRo3oSSMKgg8KbdTGVrIvb8I+yMjV7eI+nYsxLGc3GX+rRYVwsewiWcIi9gnF3eBEsk+2JWhbwUXQ5syPyHgrueyL0txKzdy8cJOM7vgXUJQnjMx5Bq6wMI7S1UZos2tzOacDK3PXfsRdCGznc44IhSn8xDd5Q+s/Hh2w/KIMjHZ+NOgRD5GDUWyUMWVeYErpAp4J9R9ATPQdXYsuFUXIKsFTyqL0HQW4K/5g8bjfbJGSYox3S+Gtx9TP3G5Qe5UXh7nBxC5CF/Kh4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yx1XF22oMCwtp8k1x4Jo1yufwfNv/qE9z5qlr4PXJ6c=;
 b=lB7BL/UOQ5FkI07k0CdlobtX007LfoXBX/9rmKi/j0Hhw/219aSUEgg884DE9fkjaEosQqAZqieg+sZOc4wP1wDdgI3DNVB7VqHeZaJTqcsCqNg+sMJOg8f4jg2zGA8Gb0D4aJvi94H2ODq7YPPbD+U2RHpNIteQmZd4FIiGV0knOoR3nu0+B+lDP7nBO6Sm0Uj4UAdMUb4FnxlQ/M+ryee/XcrXWy1UgfglchHTOCzxb0F9/EgTgB5gUqS3/lZiHT4qN0wbuCVQrmms70PP9WVSVRtH5FW0vj2aV40kb43GaamXYmBrAtTxYvT8pOnU0gtAQn8dhp4eAGzehnJH2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yx1XF22oMCwtp8k1x4Jo1yufwfNv/qE9z5qlr4PXJ6c=;
 b=eTReEbInVeUHEFn3G5+M2TH3O0zD9IpKwJmpYtebrVXJ9o9HqK8Vit0PJ8V5xQRt+mMt5sgrKjM9dxAa7ucl2YPJ+x43hJpotY8R1qjb8syBYH946nz2j1wwtuudtTKFqI7wAogP6kMBbpKvhwKcSwKkSV0UqFccV/KLhprBZPs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3913.namprd12.prod.outlook.com (2603:10b6:5:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Thu, 2 Apr
 2020 07:34:03 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::f164:85c4:1b51:14d2]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::f164:85c4:1b51:14d2%4]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 07:34:03 +0000
Subject: Re: AMD DC graphics display code enables -mhard-float, -msse, -msse2
 without any visible FPU state protection
To:     Jann Horn <jannh@google.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
References: <CAG48ez2Sx4ELkM94aD_h_J7K7KBOeuGmvZLKRkg3n_f2WoZ_cg@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <4c5fe55d-9db9-2f61-59b2-1fb2e1b45ed0@amd.com>
Date:   Thu, 2 Apr 2020 09:33:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <CAG48ez2Sx4ELkM94aD_h_J7K7KBOeuGmvZLKRkg3n_f2WoZ_cg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0099.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::40) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR01CA0099.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend Transport; Thu, 2 Apr 2020 07:33:58 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d5416cc3-da8f-47b6-e246-08d7d6d837a4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3913:|DM6PR12MB3913:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB39136CF72994DCDEAC4BA6EF83C60@DM6PR12MB3913.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0361212EA8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(2616005)(52116002)(31696002)(186003)(4326008)(110136005)(7416002)(16526019)(54906003)(478600001)(8676002)(6666004)(36756003)(6636002)(66476007)(81166006)(66946007)(66556008)(81156014)(316002)(8936002)(86362001)(2906002)(31686004)(5660300002)(6486002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hOMmNFLzX9IgZhSD29Bs9/bUaNVQrCWKAtMg5R+vzlgGn59E4Ujd0UfzdEM1TX/mfkZjJj/SRV3ppjkoZiVB+BISeb2Fq9+ReNxOR8TzcfzabUrTsY52Guppo9ctDLVwMaQ/xuOeO2SQtKokEaf2m3pjRNNrepHaLtuxw0g9CEqrZz86aghNv2KKN7GDZy0IK65kSAGTV3zcGlgHXhv49PXaKop+EldeCNWIrpmYrM/VVHWz8sgcUMKZs1He/tMbMcDyZJtufnu6+xyX9p//Q8MycfICCzkZI+QIKUCVu1GrOnldNgYimbWtDTMy8wajJ7GRn0oC4QyvrZaHLoVkYCDEBYMP20nEXj+5YFvV6eI/Ci1CSXsqbMtlDKsVy1+p4v7KfiPdxv57Gfl4ByxDe8AYPoLdjBW4ByEA5w9xmWgYeoUl1+tQd4wKB1jCjGaP
X-MS-Exchange-AntiSpam-MessageData: 6/BzDC+dmV3F/VSZE936k0LsPFi/EB8W8AHyHle4oTh34UDpSe482Em/qTb1rM2rkIv5EOxOhmNrZomXsL28KMjrXNXGZW6fgkXfxe8kxYoYUiRR7d+VYPyvM8he210Hwj6MeE/vEQD42bDkTUtzp+FZvTYQod+NyWEfd4sAAOBIBupNzf7muf/N58j+j+Ae+mgDnhsvDGisP34V+PnaBQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5416cc3-da8f-47b6-e246-08d7d6d837a4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2020 07:34:03.4870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LoJAvslZ1LA2L5uhpz8Z4FdAb4u6T5Azv+bk8dw+8EvHUb54qUMotoyU/UAY+So7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3913
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jann,

Am 02.04.20 um 04:34 schrieb Jann Horn:
> [x86 folks in CC so that they can chime in on the precise rules for this stuff]
>
> Hi!
>
> I noticed that several makefiles under drivers/gpu/drm/amd/display/dc/
> turn on floating-point instructions in the compiler flags
> (-mhard-float, -msse and -msse2) in order to make the "float" and
> "double" types usable from C code without requiring helper functions.
>
> However, as far as I know, code running in normal kernel context isn't
> allowed to use floating-point registers without special protection
> using helpers like kernel_fpu_begin() and kernel_fpu_end() (which also
> require that the protected code never blocks). If you violate that
> rule, that can lead to various issues - among other things, I think
> the kernel will clobber userspace FPU register state, and I think the
> kernel code can blow up if a context switch happens at the wrong time,
> since in-kernel task switches don't preserve FPU state.
>
> Is there some hidden trick I'm missing that makes it okay to use FPU
> registers here?
>
> I would try testing this, but unfortunately none of the AMD devices I
> have here have the appropriate graphics hardware...

yes, using the floating point calculations in the display code has been 
a source of numerous problems and confusion in the past.

The calls to kernel_fpu_begin() and kernel_fpu_end() are hidden behind 
the DC_FP_START() and DC_FP_END() macros which are supposed to hide the 
architecture depend handling for x86 and PPC64.

This originated from the graphics block integrated into AMD CPU (where 
we knew which fp unit we had), but as far as I know is now also used for 
dedicated AMD GPUs as well.

I'm not really a fan of this either, but so far we weren't able to 
convince the hardware engineers to not use floating point calculations 
for the display stuff.

Regards,
Christian.
