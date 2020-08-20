Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C2CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CA4B206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="W5uwn3Eu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgHTPVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 11:21:47 -0400
Received: from mail-dm6nam10on2061.outbound.protection.outlook.com ([40.107.93.61]:60385
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726852AbgHTPVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 11:21:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMrf2kvCrqv2f/w8ErPJKL/Z74YzV/tKR0m4w0yve/SfRLhkGDbDC35LjsvVoJf3OBjnTwaQg4TIodVUGyd8AHvPaGTJCcofaSPT1JXimH2tzZi7jqaH/fZj53hVMBqaSghN2Y2H6B5bwUxf2IZfKTGf8TNQR+dWxf221BL9IPDeIUs56P5d1dnBVg0/wKnG/MBbbwFdVASJnGAGM9ORFAGZqL+YewfAgoauw+DBweQY31xrNU3OkRZ71FLfZ+7rLqVJnRL/Ar+zvGy4vDHQB2PfJ07lKpm1hfCCp99Bd0fDAiiHhbYvXKOPVKeIE4WPTHSqqZMSjNq4+Kyb1N5x/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvQKYG8xxWfMUHJs1W2Q9szt8FuY0g48teUOQmgKFfA=;
 b=RGqxA1GObFS1yJj2LJ85JYehIZ+5Xk5pU76NlW7EcLqnM6JyIdyeX4OpLNXNQ8VJLk75vWeyCc1dHm+BAIoW1ht07ejOusuLLh9sary+h0LoYe1WLdZxEzlomn+SfH4TwPRZ+4FwlmaWZz6lJ8X6NTaYyaGuNTxMCFyy+l3tCGC+Vy1IhN6f4pkH0J9Ea3fhmUiefGt2Ahx1grEgph99O5KRYjTEqAQthGh2HHcUgdnJswWaOI95ycZCoaiJwhLJNgeGft3K/438QtS80Cb9hnrXiesUVGFeDpRWFQRyh1PWvcCPwZnln9pTUvZORUg9mboHm9RLbPlmlbAUqqy49Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvQKYG8xxWfMUHJs1W2Q9szt8FuY0g48teUOQmgKFfA=;
 b=W5uwn3EuAi2Fvc6Xopb81ASgbt58Acr4Hoe2pRRuALAEmQ4jf7iMUK1egSLT8PawSVYIAck18qPufcKSr3G0dyMAPbB42EszI64Mj3j/tYGQe83MqsnuCqdR5Pe1WnyGiv8XoND0iJ8Q+sdhzjK5Om0Uo/Y64aRo0g8btJleCYk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM5PR12MB2470.namprd12.prod.outlook.com (2603:10b6:4:b4::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Thu, 20 Aug 2020 15:21:34 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346%3]) with mapi id 15.20.3305.026; Thu, 20 Aug 2020
 15:21:34 +0000
Subject: Re: FSGSBASE causing panic on 5.9-rc1
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
References: <39d57e4d-5db4-f536-6f5e-6b0414c0dccc@amd.com>
 <7dedb0ab-56a6-5d96-577b-21ab1ecdad24@amd.com>
 <CALCETrUArZ04UqJjp2mEheuMpZyPwLeEgGM7mdDdmWxmx=GN4Q@mail.gmail.com>
 <CALCETrWcXgp+GzFNrOKcX740+R-57FgNu3Wt3g=_sRCMYFzbMg@mail.gmail.com>
 <20200820151049.GA26595@sjchrist-ice>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <362f5a45-b808-25ad-b99b-449e05717c4a@amd.com>
Date:   Thu, 20 Aug 2020 10:21:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200820151049.GA26595@sjchrist-ice>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:805:de::39) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by SN6PR05CA0026.namprd05.prod.outlook.com (2603:10b6:805:de::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.15 via Frontend Transport; Thu, 20 Aug 2020 15:21:32 +0000
X-Originating-IP: [67.79.209.213]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ff4ac8bd-b75a-4106-0c8c-08d8451cb911
X-MS-TrafficTypeDiagnostic: DM5PR12MB2470:
X-Microsoft-Antispam-PRVS: <DM5PR12MB24709EE5E289C9BD5607E47BEC5A0@DM5PR12MB2470.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HrKdSvG5vVRq2vAGKKMb+7S2d5QRduBhE7LaeX23vst2sHQMrCWaL39hY3pFhg/P9oZq26ZR/w1nQBU3SkGFF4pqph+3ujz5tSYwF6ETuicv+1SLzJ+eNm1ZVS3do4jJ3fgLGLDTK5MiebqQpJBayRHakTXDzKI11P2AgB7dZYmh4nRk8C+00ZnkQvuZvVCx/Ivd9gIfXTbVthrny0pqcSwIgfac3cQmLxIRIimPrBuh+eC3Lb8FDOYTV5wAcmPKSjncS/oLHKtEnCgThrlQ2G2PW2G4o2Qjcu5mX0U26hO4HL6jUVmUAr8BGzsTD2F2fYBJEVw6HHjbuqn4oAtetcibDBWkpP1QyubUoZ2YHf7k7lHfIYAak9PUrk2hOf1OQSgHtiT6SldLeoXxPE1zJQv+KdUSZ9RmzIgREvs39M4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(186003)(86362001)(4326008)(31696002)(956004)(31686004)(16576012)(478600001)(316002)(2616005)(5660300002)(53546011)(66556008)(26005)(6486002)(110136005)(7416002)(36756003)(110011004)(66476007)(8936002)(2906002)(54906003)(8676002)(52116002)(66946007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: rhibgvlgaVCLrwSF5/sIHV+n3hXN6QHroTX4RfDZGEVYXwuUAB7z9TtmGsfz5ANAXgfIAIvsKlIkRgtWuZGRRG+KL0jZR+VT32732aLM/FxokaNyOx3LL9qfQi/q/IHEiFhzu8RRp5DsgzEsWFirk4raxyyu1rHJBBc7YVAVXoJwcWGNGxzoLGj/wFobhImIQme5AdZu5q43TYZogHkhjxzMT0gGZnaJ8+zTxpo5d/4+x9E4apMEs5iXg8wlENYfZ3ryUX5lhkW7gkHJ6KLqhJSk4CVqzcaVIdHo7ZYfWxq/MtNCNkciaFZl+prCj2VO65eOJ4kQSMMPSKHeGpOdvBtE0JAv4vhcepmsRZl0eEQiRE4Xp/tUknOkxHFyP+kd67y/BGRrVe3gXpGdR/dHbaKGQseVr6QsGWkRk7CQpgStyLjtiH6OtoMGkEr3hz0W9ybOJrtwSjgqCwYEcptUf9IWFzWn7Ulg561hPF2yyWiLpVfkbKXzIVe6gkR+VbOqbrm/bsMtwuPd9/wykDxm63sHaB+3iFgotJ2l/TT2h8BDlgH3KdVvxD92GQvjq4SJOIrF7eBmWLcDjzWXd6Yl1VqzyrR342gU+VjxEolqgfmRGgTtvirP2ViwEhy4Gu++NtTTDBcRjYZPTQnS+bdiyg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4ac8bd-b75a-4106-0c8c-08d8451cb911
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 15:21:34.0617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MG6POTIsmqnren+WeCDPcylNydqKyug+UiKnO9pz639oTIaVUX/hZuzhYw6wy1cYZ6N0veLz8uTAmXqy9zFGdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/20 10:10 AM, Sean Christopherson wrote:
> On Wed, Aug 19, 2020 at 05:21:33PM -0700, Andy Lutomirski wrote:
>> On Wed, Aug 19, 2020 at 2:25 PM Andy Lutomirski <luto@kernel.org> wrote:
>>>
>>> On Wed, Aug 19, 2020 at 11:19 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>>>
>>>> On 8/19/20 1:07 PM, Tom Lendacky wrote:
>>>>> It looks like the FSGSBASE support is crashing my second generation EPYC
>>>>> system. I was able to bisect it to:
>>>>>
>>>>> b745cfba44c1 ("x86/cpu: Enable FSGSBASE on 64bit by default and add a chicken bit")
>>>>>
>>>>> The panic only happens when using KVM. Doing kernel builds or stress
>>>>> on bare-metal appears fine. But if I fire up, in this case, a 64-vCPU
>>>>> guest and do a kernel build within the guest, I get the following:
>>>>
>>>> I should clarify that this panic is on the bare-metal system, not in the
>>>> guest. And that specifying nofsgsbase on the bare-metal command line fixes
>>>> the issue.
>>>
>>> I certainly see some oddities:
>>>
>>> We have this code:
>>>
>>> static void svm_vcpu_put(struct kvm_vcpu *vcpu)
>>> {
>>>          struct vcpu_svm *svm = to_svm(vcpu);
>>>          int i;
>>>
>>>          avic_vcpu_put(vcpu);
>>>
>>>          ++vcpu->stat.host_state_reload;
>>>          kvm_load_ldt(svm->host.ldt);
>>> #ifdef CONFIG_X86_64
>>>          loadsegment(fs, svm->host.fs);
>>>          wrmsrl(MSR_KERNEL_GS_BASE, current->thread.gsbase);
> 
> Pretty sure current->thread.gsbase can be stale, i.e. this needs:
> 
> 	current_save_fsgs();

I did try adding current_save_fsgs() in svm_vcpu_load(), saving the 
current->thread.gsbase value to a new variable in the svm struct. I then 
used that variable in the wrmsrl below, but it still crashed.

Thanks,
Tom

> 	wrmsrl(MSR_KERNEL_GS_BASE, current->thread.gsbase);
> 
> On a related topic, we really should consolidate the VMX and SVM code for
> these flows, they're both ugly.
> 
>>>          load_gs_index(svm->host.gs);
>>>
>>> Surely that should do load_gs_index() *before* wrmsrl().  But that's
>>> not the problem at hand.
>>>
>>> There are also some open-coded rdmsr and wrmsrs of MSR_GS_BASE --
>>> surely these should be x86_gsbase_read_cpu() and
>>> x86_gsbase_write_cpu().  (Those functions don't actually exist, but
>>> the fsbase equivalents do, and we should add them.)  But that's also
>>> not the problem at hand.
>>
>> Make that cpu_kernelmode_gs_base(cpu).  Perf win on all CPUs.
>>
>> But I still don't see the bug.
> 
> 
