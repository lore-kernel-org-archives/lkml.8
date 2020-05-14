Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA10C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 20:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10C11206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 20:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="b29ebIXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgENUln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 16:41:43 -0400
Received: from mail-bn8nam11on2045.outbound.protection.outlook.com ([40.107.236.45]:55776
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726090AbgENUlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 16:41:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1LY5ihje+JhTN2q9z913nl95V+M1ksIwkc59uujD/gi6fpREiQlsAqJ2EkL7bc2QERRWZFyTp/0u0wB/DUi++L7EaCOITti/yuEOj43eMadklHGPNP04FpAMfcr1cXOJhW2mTB7cgbwuSx+nYblsrDmjZO1r9vmnG95UDnA/kyJ+C0AvPw8M3im0eLls/0qgGYdJL5vmAMcenG2XLXCwuT9Vm0XZsakWX2Ws1OCGnBWKEPvxcPeluBP8yZu2S3wyzxad0s2DplbZmJtkd8PsIMQKP5USedBSNVQSCeyWH9a9OuGvpCrXxzOuNPk+V6qJDVnIAj7SZvtpUzybtPgZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PzCuGy2DNjU5F7Pp5gDUdTKqkmk0njUJ3eCNBBW04c=;
 b=oaPyDHjD+J/1dLdarNxsnz+irpW3UCQJ4CoVEEcVCvMMd5or42Pl4XaJyfuvsFSYYIjNH/oNiB+0v32xRmWI5SIIoWQhBDWIcOnY8zl/7P2wJxjrqqraT9dAs/ifxkLQr2yuIt0AU7mAYKhbL68Tg9/2OKRNN5fd3o/JgvNp5qNFSYyMxiwPS7zEJFvexO+cFXIavFrsefKTlePRwF97dKi6ligIPthhTPl4M0F/hgDg+QcDfI7la6eBIqHyqQm+PSWC43gkcLtaEmiAguPKOzkN1lIaFKpKWT5CZaw6CXqLf5+8dqDsrMBimIYrVmJP7QerilHvFCpYB17lMxyfzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PzCuGy2DNjU5F7Pp5gDUdTKqkmk0njUJ3eCNBBW04c=;
 b=b29ebIXfhVui7bdyLVVB0O6DaBOu2JPURNlu3d1Xu6vekemj+Hinx1qIzmB6NkY8pxyFTIkdxBGvgss0CoihYWCw2b2VQgiBbDTZk03JpIYO0wVKVVoSv6j+KfHoX78CaChfVpoF9Mq4W8ql2vl48hXT5ThI8La64eW9o8KOHaA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2445.namprd12.prod.outlook.com (2603:10b6:802:31::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Thu, 14 May
 2020 20:41:39 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::c0f:2938:784f:ed8d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::c0f:2938:784f:ed8d%7]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 20:41:39 +0000
Subject: RE: [PATCH V3 2/4] x86/resctrl: Enumerate per-thread MBA
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
 <3a9c21e1b8108094d9132ca0c0271e8c7b93c847.1588808538.git.reinette.chatre@intel.com>
 <eefd2231-cdbe-1250-3069-bb9204c940c1@amd.com>
 <e8b35231-f94e-ba25-125d-12819478bb24@intel.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <90198198-4ab9-867e-e14f-ecede9035e98@amd.com>
Date:   Thu, 14 May 2020 15:41:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <e8b35231-f94e-ba25-125d-12819478bb24@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR17CA0005.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::18) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by DM6PR17CA0005.namprd17.prod.outlook.com (2603:10b6:5:1b3::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Thu, 14 May 2020 20:41:37 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0865d191-ddb2-417c-85fc-08d7f84733cc
X-MS-TrafficTypeDiagnostic: SN1PR12MB2445:
X-Microsoft-Antispam-PRVS: <SN1PR12MB244575F4901176A29EF40DC095BC0@SN1PR12MB2445.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hi8bZNlARye5lrYqFnVv+4F510Zc8Ol/0BynuFaWd+BeTiCIpqQBRaM9VP39bCsT0krbUvdXgqtRhX/34XccZH46E7uFS+WTBoLnrM13GqyOTj5UqCkcF9Fn/Ibz4WgNbN00+JUTtBfyIq5EXwyLOUIzJt8R0bmlP1bsJgX80wKI1+cJCmuN/ml+Giv6ivH1r1AGplTHW4NBKY7RGm7LSkrlfjO6ldBb45klMVzLHQYKABjsCLWw6GNBaW2UDxztVriQWMpr/eKd3uBukZrcDB+pMvuCKQUToWZEgg/REJ4t1+DqM5CLn654Kgni+7rEFGvFQ055sle4GzXgPT1o7OCGeaL/bpDbgXcfePQ84W2O68muZI3Pyu1+JlriKgun5VEeONLYPGRfj6M/e5JknJ/fgLqpfj8HFrmuwnqsXEr3w+8GZZOEMvVF64pwGWk5uoOzNYZDc4dbX7vrYSwNfyQTMOADsjScRmwYSshJZzkya/FUWWxOTpzMm/8JwVaU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(2906002)(186003)(26005)(66476007)(5660300002)(54906003)(66946007)(7416002)(956004)(44832011)(16526019)(86362001)(2616005)(66556008)(31696002)(36756003)(6486002)(52116002)(16576012)(110136005)(53546011)(316002)(31686004)(8936002)(8676002)(4326008)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: qIzfLBdqz0qpFjdtY7fSsRIkwKW8u+KU2ZS8ZWftVOcjLmJcLPE4Na/KoMoHdeuesdRv++xVyfEMcIeGQc/ZVz7x+D5w8pTrGV5GX0Y7unpexzsd8dCL0sVV5EvgGr4WH90+3ypomTVuwOfnMmUza8/XVNYsya7W7fiR6+CMNVOlZjeV2QKZcZE3M7ImbxxTxOUqc8lu9EnZcYvaER0gX7TsjwLSsMftmpDppl9YAYthBHgJqrJ+JO6Kmur/JEzw7qgkTapKU88cvodPD9Lepp8/KEg3CnC9TAAOQes2n4DcUbj0m1g2e0M6wJ74/3ynEi7lT//tMkIay+Oh1fHgmbHL7vuLC+LQpxH6TipipRsRpG7SwkE6MNTt6ZPc7Qz3QraPfQMtf30O9ovtMmLFgFHqSnajHhwyWe7lwYWHm8fHeKnfq+gm1u0ooZAZMC66/G0uu7GWHxMQYA5PTYay4gVgqYAJGtDG95PFDbVACfI=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0865d191-ddb2-417c-85fc-08d7f84733cc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 20:41:39.3751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TSe2sWC29f5wuTZRSPuasjyXY5LFSwArCgp8lmKCbyKIhz6krIrcAgbD54ygFCbo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2445
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Reinette Chatre <reinette.chatre@intel.com>
> Sent: Thursday, May 14, 2020 3:12 PM
> To: Moger, Babu <Babu.Moger@amd.com>; tglx@linutronix.de;
> fenghua.yu@intel.com; bp@alien8.de; tony.luck@intel.com
> Cc: kuo-lang.tseng@intel.com; ravi.v.shankar@intel.com; mingo@redhat.com;
> hpa@zytor.com; x86@kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH V3 2/4] x86/resctrl: Enumerate per-thread MBA
> 
> Hi Babu,
> 
> On 5/14/2020 12:04 PM, Babu Moger wrote:
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
> >> Subject: [PATCH V3 2/4] x86/resctrl: Enumerate per-thread MBA
> >>
> >> From: Fenghua Yu <fenghua.yu@intel.com>
> >>
> 
> ...
> 
> >> diff --git a/arch/x86/kernel/cpu/scattered.c
> b/arch/x86/kernel/cpu/scattered.c
> >> index 62b137c3c97a..bccfc9ff3cc1 100644
> >> --- a/arch/x86/kernel/cpu/scattered.c
> >> +++ b/arch/x86/kernel/cpu/scattered.c
> >> @@ -35,6 +35,7 @@ static const struct cpuid_bit cpuid_bits[] = {
> >>  	{ X86_FEATURE_CDP_L3,		CPUID_ECX,  2, 0x00000010, 1
> >> },
> >>  	{ X86_FEATURE_CDP_L2,		CPUID_ECX,  2, 0x00000010, 2
> >> },
> >>  	{ X86_FEATURE_MBA,		CPUID_EBX,  3, 0x00000010, 0 },
> >> +	{ X86_FEATURE_PER_THREAD_MBA,	CPUID_ECX,  0, 0x00000010, 3
> >> },
> >
> > This is a CPUID feature. You can actually detect this feature without
> > checking vendor model in patch @1. This patch looks good to me.
> >
> 
> This feature is different from the feature introduced in patch 1.

Ok.  I mis-understood that.
