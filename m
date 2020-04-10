Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B47C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 14:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15EAE20CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 14:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="w7LYBzQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgDJOc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 10:32:26 -0400
Received: from mail-bn8nam11on2086.outbound.protection.outlook.com ([40.107.236.86]:6271
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726009AbgDJOcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 10:32:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBjv8cbcYEIRUHT+Yoa432fmj4rTfUghyHHLoWrVugCyYfdLpTbjDoNdpDDskJp6gK40CLFSz0BjvqBSxQCgq4pWJhowAjqzoA56HVOIx7Jx3m9fUV4+Ndihbwk1QU/3ZK/Pcr67Iz0Q7H1tA0vMIyYlGYIOWAtIrxECEg3TF/V7o6xYbGLRjQRUMfdAZro2f8nGpyeo8D9LSCpW79xeH/Y6JW3WVd9Sq82r6LRF4ATOXy4csEACdMEONPMaQDwHLsowXdNprFoL6ZDiawLvga0ZJNQXcCj53ShFL17W/C2IQYrzQ6rsXN/5QvEJ8N5+2Qs01Br+hlZtzWFfNJbPkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbaUiDGnutiCJGffQGAF21AN+a8LhZFvuNR22aHRACY=;
 b=jYOds0aS+OT+FFc2SyLwJV7ad5rK+gu9/quycEWJyOcynoFyYgtGMCAjpfjxrO+VRyZyYLPJ5Zbd7Ez3MiTG9hYFiJWSomlGoNn1rJ7tHlRy0R/sLp/oiEGsTL8LGfmE8z1Uvobq1Xar3lDel2+LoTAGpqoTwUnXEg38Vb3/FnaFbS1FB32o0+r96M/r2yWkYB8L8mv45NuNL8aHyJlvIQDonBKvkFz5mw2GNxWEnp7rxEjVSuQKB9rSzAcPp/1FUqpKZkZPyCvvAX/ZVRINZndwQOgL23E/xLi3SokSZlNWrV7Egg6FxLqjui4VZhjsIQ2BzeGIgrby2gNIFFns7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbaUiDGnutiCJGffQGAF21AN+a8LhZFvuNR22aHRACY=;
 b=w7LYBzQqxifZXx5/OtctN32YtrpFPriWPuWnpFwraTYUXeEhwVRVxAm563CqioehrWpJi0OM9NY/3DjrhPCiNYxdl/bqeiDtAjarZ+IG5W7In8Bokc7K4K7/GhyRY6fQ28rkLc3NWC6fimEy2RJxHtU6wYE8j7R1s8R/ypoxah0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3963.namprd12.prod.outlook.com (2603:10b6:5:1cd::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Fri, 10 Apr
 2020 14:31:47 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::f164:85c4:1b51:14d2]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::f164:85c4:1b51:14d2%4]) with mapi id 15.20.2878.025; Fri, 10 Apr 2020
 14:31:47 +0000
Subject: Re: AMD DC graphics display code enables -mhard-float, -msse, -msse2
 without any visible FPU state protection
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jann Horn <jannh@google.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        mhiramat@kernel.org
References: <CAG48ez2Sx4ELkM94aD_h_J7K7KBOeuGmvZLKRkg3n_f2WoZ_cg@mail.gmail.com>
 <4c5fe55d-9db9-2f61-59b2-1fb2e1b45ed0@amd.com>
 <20200402141308.GB20730@hirez.programming.kicks-ass.net>
 <20200409155956.GQ20760@hirez.programming.kicks-ass.net>
 <20200409170916.GR20760@hirez.programming.kicks-ass.net>
 <87a2f2fc-972d-ab9b-a29d-72f02d94e60e@amd.com>
 <20200409200125.GB2483@worktop.programming.kicks-ass.net>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <56fd0509-ebef-f7b5-3ca1-fc51ca493a4c@amd.com>
Date:   Fri, 10 Apr 2020 16:31:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200409200125.GB2483@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::17) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by FR2P281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17 via Frontend Transport; Fri, 10 Apr 2020 14:31:44 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0967d14d-5972-4b71-022a-08d7dd5be644
X-MS-TrafficTypeDiagnostic: DM6PR12MB3963:|DM6PR12MB3963:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB39631A0757CE0B1C2004A28183DE0@DM6PR12MB3963.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0369E8196C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(81156014)(8676002)(6916009)(54906003)(8936002)(478600001)(6666004)(31686004)(86362001)(31696002)(6486002)(7416002)(36756003)(5660300002)(2616005)(2906002)(66574012)(52116002)(186003)(316002)(4326008)(66476007)(66946007)(16526019)(66556008);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fHGKcgySaieGmExdfNAguIG2OByd83Q78VyOei2FnUasDV3Gs3zreBmDq3dfuJM0upSaANniHDKphsXZLOzdkGuIb48OJYLkR3l6iCRHVtZiNzTbohNNdveBkh2u7EmYh3Noc0Uy4XPKN6weUCPLePX4NS+Z3xKTqegvZQ6ZJQyIgWJKlKy4hb6kOoK4HtEdd/Ri5dev7AR1DrmEfMOVyJq/Wke5puqLoAJhfuSqGiec1eRL5fb49OICtKxboiNzr1QaTvQ30JYI7x0eICTRXlk0kpBk0niHLpZUBqDrE8IxoyQSFD5Zfga2Zj3HiVQT8gEfP25QaKUqQWXmum9KH1cP3+uXwZ/k/xw+9ci5ZW6GSE/UpdCMDh9rjSX/6EWp1DsQvQTIvW6DfZ4ltGE9F1O/DMAwTm5e6YUPXjsb3CZ/MVOrVNHJErjZB3mLDmuM
X-MS-Exchange-AntiSpam-MessageData: /O1V2FwJGIxwSGpTVDCMyUUEdiLdEU76R9Z9Y7OVVwI7/cCHqbGKhi8T/DVCLt+3Vby5DJ8Y4KcXrcgc/HNRsGtXN9a8EXLYeSe9mg0yU80s0rU/fy37U1VAqgAeqfaoqaBa6TcslkSP+gBRd3qm7hAk7jH5TtK6WWkWZbhKYhKRRb4uF3CJ87sInJYng5iAH7a9gT2DOIYdM5fF7crMvA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0967d14d-5972-4b71-022a-08d7dd5be644
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2020 14:31:47.5544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWn0rKbn0ifYP13u6XcykXlSypdW9Ffz3h2cG0Yq7cj/xLrbek3hqh4WsMHw3alr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3963
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 09.04.20 um 22:01 schrieb Peter Zijlstra:
> On Thu, Apr 09, 2020 at 08:15:57PM +0200, Christian König wrote:
>> Am 09.04.20 um 19:09 schrieb Peter Zijlstra:
>>> On Thu, Apr 09, 2020 at 05:59:56PM +0200, Peter Zijlstra wrote:
>>> [SNIP]
>>>> I'll need another approach, let me consider.
>>> Christian; it says these files are generated, does that generator know
>>> which functions are wholly in FPU context and which are not?
>> Well that "generator" is still a human being :)
>>
>> It's just that the formulae for the calculation come from the hardware team
>> and we are not able to easily transcript them to fixed point calculations.
> Well, if it's a human, can this human respect the kernel coding style a
> bit more :-) Some of that stuff is atrocious.

Yes, I know. That's unfortunately something we still need to work on as 
well.

>> We are currently in the process of moving all the stuff which requires
>> floating point into a single C file(s) and then make sure that we only call
>> those within kernel_fpu_begin()/end() blocks.
> Can you make the build system stick all those .o files in a single
> archive? That's the only way I can do call validation; external
> relocatoin records do not contain the section.

Need to double check that with the display team responsible for the 
code, but I think that shouldn't be much of a problem.

>> Annotating those function with __fpu or even saying to gcc that all code of
>> those files should go into a special text.fpu segment shouldn't be much of a
>> problem.
> Guess what the __fpu attribute does ;-)

Good to know that my suspicion how this is implemented was correct :)

> With the below patch (which is on to of newer versions of the objtool
> patches send earlier, let me know if you want a full set

Getting a branch somewhere would be perfect.

> ) that only
> converts a few files, but fully converts:
>
>    drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c
>
> But building it (and this is an absolute pain; when you're reworking
> this, can you pretty please also fix the Makefiles?), we get:
>
>    drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.o: warning: objtool: dcn_validate_bandwidth()+0x34fa: FPU instruction outside of kernel_fpu_{begin,end}()
>
> $ ./scripts/faddr2line defconfig-build/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.o dcn_validate_bandwidth+0x34fa
> dcn_validate_bandwidth+0x34fa/0x57ce:
> dcn_validate_bandwidth at /usr/src/linux-2.6/defconfig-build/../drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:1293 (discriminator 5)
>
> # ./objdump-func.sh defconfig-build/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.o dcn_validate_bandwidth | grep 34fa
> 34fa     50fa:  f2 0f 10 b5 60 ff ff    movsd  -0xa0(%rbp),%xmm6
>
> Which seems to indicate there's still problms with the current code.

Making an educated guess I would say the compiler has no idea that it 
shouldn't use instructions which touch fp registers outside of 
kernel_fpu_{begin,end}().

Going to talk with the display team about this whole topic internally 
once more. Since this discussion already raised attention in our 
technical management it shouldn't be to much of a problem to get 
manpower to get this fixed properly.

Can we put this new automated check will be behind a configuration flag 
initially? Or at least make it a warning and not a hard error.

Thanks,
Christian.
