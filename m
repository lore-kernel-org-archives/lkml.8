Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02329C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 18:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B1A20753
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 18:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jV/bfpvv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgDISQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 14:16:11 -0400
Received: from mail-dm6nam12on2089.outbound.protection.outlook.com ([40.107.243.89]:6233
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725970AbgDISQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 14:16:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNM75pZyCUwQ6N1uS+iHRjsRNmjfewWlqIaiehou1rTsmnwy8liFuGVdwk0VzP+Kl38Gn/rOEx4ndld/LcIDDw2r+g7ZDpfWiwn9MiqnifiDHCgU/EhSS5Ei9MiUracNSQCZz6kKReDEl3PbaRurg/0wemKbYm2nwuURwbsH7/WQDsosv6h0IoeIsAUPUc7NR04QzkhMNTzfHrCdygoY51kBTFYjM8+I2qnhFUFMaeYmTw4R7WhR0OavfwmOfwG8PckXoWlHat9JviRbr5C0756OdLcLYOSfgjsElLI2RFazn+PZYXF4q6DGr40NzRG9m3AjbJfIgte1dEg1hDLG3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XC608SPjh/qCs2rVchcDTLKP2krF6sZZARVRRszhzMU=;
 b=LxiLeBlfUBNaB2jwd/hDh06yX4gWwrz41RZKeIEvlDOah95I4px1PW+cLVJD/OYwQt/8ku4Apj/Io8U0xkgQXQM6rJu207wR6kq23hc/1uxiv44bpXmPBKVwvjezSk/LulNPtgaHB0i9ajv8gg3iIjvWcWHg+D40L+Nv01GSybQCFSIXXQ4c/8y9gYhHeal4loPqJ4wV/lmCu2NWjP2vlCvoSzfJo56FOcA1qLT0ObTw99xD+jPNcxXeuMGhLuPCSUDrf2qTHs2NxT4tt+HoMLdSKRE6Fd8WiXWDprqRNOUnWlOjrULkphTnFGVdaJ/qavEtfkxdCaKvBDq3pxX73g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XC608SPjh/qCs2rVchcDTLKP2krF6sZZARVRRszhzMU=;
 b=jV/bfpvv8FyPmIkcFdYKUZptsyM+SvxOQLRjLcpDsKrTphJi6zyh6tjLnuut4Vq7uqSnBzL2PcjwWDvn4/9dKZD/QUpiiM7THgiXdAFeIR9tIFQzlRRtFw/JYx14xTCxr/ToTfKzsqr3MiHhUYCNWZ1QNICXl4FuK1MdJ5Sz55w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Thu, 9 Apr
 2020 18:16:07 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::f164:85c4:1b51:14d2]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::f164:85c4:1b51:14d2%4]) with mapi id 15.20.2878.022; Thu, 9 Apr 2020
 18:16:07 +0000
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
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <87a2f2fc-972d-ab9b-a29d-72f02d94e60e@amd.com>
Date:   Thu, 9 Apr 2020 20:15:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200409170916.GR20760@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0099.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::40) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR06CA0099.eurprd06.prod.outlook.com (2603:10a6:208:fa::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.16 via Frontend Transport; Thu, 9 Apr 2020 18:16:02 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5f32cc5a-6d09-446a-4573-08d7dcb212a6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4466:|DM6PR12MB4466:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB446638BA8DD16B528CD4E19683C10@DM6PR12MB4466.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0368E78B5B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(52116002)(8676002)(478600001)(86362001)(6916009)(66946007)(16526019)(5660300002)(66476007)(7416002)(186003)(66556008)(31686004)(316002)(6486002)(31696002)(54906003)(2616005)(36756003)(8936002)(4326008)(81166007)(81156014)(2906002)(6666004);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rdkpDusV0g2HgNlvnNOtZ4cKM9xx8+3RMjZKZcI0dp+BMKmXComMNN3ttWzfuA/zbktA8U0Q/uEPb+VqYZxnLd2jIDxQQ1GNoyIlUClJh05z/vU5ESA11o6ml5XiWwj7nShT8VqQUX3qfbRZVAo1ooFlir0ZsT05BBz6PRFclJbDZob+y3FbgNOqzwDF8fQay4n2hsECxNn48c3oeAQNxg8sRCDQO9G4GsxUDiDSoDaKWMYd7DQkU/UJWkO6Jauid2ra2Eiuqs5ZUMnkAcHQonfOtuG0+Kg0HH6YhhfNaevd5klS76Uf1ZZq4m7u+Y9z7zt2OzSAvqJ32NZOgsVD/eHscP5c3TRMBml5X+rgVFcL/QBvlwyau+9v2lJ4Tg+AeCdKZLIYsc3KeqYM1yOCdQeC60qex1Bi832hUEbfS3qMG6Cp9uBdFs5UaNbwRZvp
X-MS-Exchange-AntiSpam-MessageData: bppcPA3BWUMMMlgAKgkLhMygxHe6i/AZRoiacTJh/YYSgc7mlbpXcSrdJ25FIGuL+jwM2zjJjdmGZ6+0KXnyNgzEYciU8nDVGiM3yA2JHr8gTK3aKg35sh+YdAvWh+PrRILLhU1eiXDo39U/1JsZ3hVDnmaR18VO925H3EjkBjLDuHEGwCWAJMfcK1ulBVm2AD0wo3uPlX/MlQEVU+aDEg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f32cc5a-6d09-446a-4573-08d7dcb212a6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 18:16:07.4208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KHwy+qQltxj+HPyf886R2deNEQbSkpO7cz/WuL/QnopNoTS3RV93GDXL5v21BTdh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 09.04.20 um 19:09 schrieb Peter Zijlstra:
> On Thu, Apr 09, 2020 at 05:59:56PM +0200, Peter Zijlstra wrote:
> [SNIP]
>> I'll need another approach, let me consider.
> Christian; it says these files are generated, does that generator know
> which functions are wholly in FPU context and which are not?

Well that "generator" is still a human being :)

It's just that the formulae for the calculation come from the hardware 
team and we are not able to easily transcript them to fixed point 
calculations.

> My current thinking is that if I annotate all functions that are wholly
> inside kernel_fpu_start() with an __fpu function attribute, then I can
> verify that any call from regular text to fpu text only happens inside
> kernel_fpu_begin()/end(). And I can ensure that all !__fpu annotation
> fuctions only contain !fpu instructions.

Yeah, that sounds like a good idea to me and should be easily doable.

> Can that generator add the __fpu function attribute or is that something
> that would need to be done manually (which seems like it would be
> painful, since it is quite a bit of code) ?

We are currently in the process of moving all the stuff which requires 
floating point into a single C file(s) and then make sure that we only 
call those within kernel_fpu_begin()/end() blocks.

Annotating those function with __fpu or even saying to gcc that all code 
of those files should go into a special text.fpu segment shouldn't be 
much of a problem.

Regards,
Christian.
