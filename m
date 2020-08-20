Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749D9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 300E0207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jujAYSZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbgHTQbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 12:31:01 -0400
Received: from mail-dm6nam10on2045.outbound.protection.outlook.com ([40.107.93.45]:52833
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727946AbgHTQaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 12:30:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i60IgpHrmeN4E/yGyqwLOOpzkKonlnV6DTJ8GXuJMm1w1cDTMB5/XK/FypscYxWd6PgXA/VE8Ejt2hSAqeiU6osV066WQp85qYBwZxxdDHYGQCL/Dqq0/LfdOI7PvYcc3R8v62mlSW3hFeY7JN068JQo510oVOekkPiXyW08MwYtI780BkHhn8Je0k7pgr5kBexG9HJ00+iJpny8fbwGMwkC8DpaOGCaB0pNjqlz3sdqmhejXlnGmME89aQPgOPRzJsoaY7jOnqpJI98WnEOofbOxv5gUHbG7lESGHLvRDNR2fu91QjE+QNxvBVfkYH3Kdbs8rtBWzgCaKg7R/HCYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEQgzzWB3hG9qAAGy+Hjx4mvmV29QsinaFJWEbt/SU8=;
 b=fIMxwq89eqG5w7J+9EMqqiXytHhkzsuTgeIVRRRtRdZJix1It2yL65y8LXS0b0O55eKfhPNLg6XoVZTeQ2Z6ReOtaj2gjn1wlWGLcoUnbzDOv+ypMcBQqAr1K6suUXk/VDPGJxKHBDrvyNaudc3ApT+AffDcVb15su14NNAOLTv7NhmJqmVP+MIebjjfxRNoqxNR5P+K62Ya8/bQfrbGU5Pnw+Osxq5wGNbJ+NQyBi8BT8yt71Dnksv2hzshEUEXeK/a4iRMUqvFPIt3wSz7eADd3Hvm9URyD6cMWmQ1qnosobBlQpqeoFugnn73DhmVAEYlX9qcbuyAPW4+SDBTLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEQgzzWB3hG9qAAGy+Hjx4mvmV29QsinaFJWEbt/SU8=;
 b=jujAYSZUMY6Prbb3tuF8IabG53Qc3E36ZXnu+boFHuTEooMqXhyZMsjwzoXXdzt4P3Q42UeRDnuGv6ojT2L+XhOTwIrzFjGf6pPeHC0gQT8U565QMldjZrjrvVVklwhRILRnMocOCkpMC02A3MsuxzYZQdz3NcteaywU6Aeyk+8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Thu, 20 Aug 2020 16:30:52 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346%3]) with mapi id 15.20.3305.026; Thu, 20 Aug 2020
 16:30:52 +0000
Subject: Re: FSGSBASE causing panic on 5.9-rc1
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
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
 <362f5a45-b808-25ad-b99b-449e05717c4a@amd.com>
 <CALCETrW8SWgWxDdMXuMPD-A1avztvNcpwLAKKRQ4ojmcz07B6A@mail.gmail.com>
 <45e16c5c-ce99-33da-99c8-ea52ef0945db@amd.com>
Message-ID: <c7f65dbc-316b-efb9-d2c3-c7c212289dce@amd.com>
Date:   Thu, 20 Aug 2020 11:30:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <45e16c5c-ce99-33da-99c8-ea52ef0945db@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR04CA0076.namprd04.prod.outlook.com
 (2603:10b6:805:f2::17) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by SN6PR04CA0076.namprd04.prod.outlook.com (2603:10b6:805:f2::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 16:30:51 +0000
X-Originating-IP: [67.79.209.213]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 04d61a52-61a1-4585-3bd0-08d8452667d5
X-MS-TrafficTypeDiagnostic: DM6PR12MB4433:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4433C63F9BFE2EA174BB596EEC5A0@DM6PR12MB4433.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rHxlLDpQTwIBPmSzNzm5zAOSAC5ASYH/jCTr8qcqEHViINOBMelfmI16MYxgzfgKIyeI9bfvkWHbjCnBpEvCN8lZXfkeqfpmhkZMgHBlihqdowdFbZ6ZkOOoePRFyi7H7RnRcKo3eF+0qQ3euBzFqyC1QcRBP/dCOuQEt1KY6OPG9XSolYGcfBKkQ8PRWfaj9f4WoX1fCfUHgx9BmZ4DurBQHgeXmGOXn5OXEsXdYBLiLP3xi2wmQ8mZ1BgYCGNivniFMFC1izAf0+WN0Oh8HvrENppylbkTNSYGL3CxgfLleI4DsIgzU2HUPj6stNbsC0vW6v08bpzQwIgdOp8v+ArFSO02HQmsMlPeHd9TVviYbvHITd0Ox5VoQT9VJCMptSXw4cccLLt15G3qwVmvO+v2+r6anmplE/eLNV5lpxU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(6916009)(54906003)(66556008)(5660300002)(66476007)(16576012)(316002)(7416002)(2906002)(478600001)(36756003)(66946007)(31696002)(110011004)(956004)(26005)(8676002)(52116002)(8936002)(86362001)(53546011)(31686004)(4326008)(186003)(6486002)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: sBbjJv0cWjQOa/N/U4kBHtlxbTgWLBAtkPwKILg+vrRPAlZC/FhytBxmFzUZreETyN1mrzeBcNRTN87uU2fG7BN8jxMB3DG+gqy32QYcLU2oK1rLSMS0nX17RFYGbxSaBJEFKQaGZmEvnEQ2lu39kVz35fl0Ph8IUbzXEiK1LDUHof8slys7lJOcfUiW32L8Y+hXMr+zAzo9SnmxU9pRaMRmy9+mt2bAyZffJPYV9OjYUwgnYglOI6cnr1D7pLGihOmq2AXjmd+nM6Z2BlBy+IVFbTwyJXEfD2REuKJYV6mzUBvnVKSDwP0suTN1TM3Y3Fb3C2yJ18w+Wz4pre5EUf6vB1r6pYK4OGRsJPILr8e5I5yi8Z5OTQ7IfDyhPhSasVmCanvgQgNFB1TCXUgf2aJc/Be20xXVNxHWLnn8shxRBfoTT5lujC3th1x9rSgA7RpLZmFLj5wavtBic2iZWr7UBfwGkGiyqqUuC6ggIwUo2f0wc1IcsWkkj2n94eusa/ph1huHCdULjL+Wt8rO12RIAM0hwLBsZPV/U9hKFuW+Cmzx5B8vlXXbnlzWgPBjJcS9W8oJFK6R4QR4+FeJ4LRTIu2HsDNEHia9eCv0q/SDc6M14frW03yoFgu8sW6+qoHqyjN6T/hB3clkhVsMsQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d61a52-61a1-4585-3bd0-08d8452667d5
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 16:30:52.7306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1YwF+gPVsoaVfGGpodRzankItTRXIULIfZFfR1SYIMhutnzaEV39UH5NJKvv2wAe90kQ25QE9hm4OMwjs7L5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/20 11:17 AM, Tom Lendacky wrote:
> On 8/20/20 10:55 AM, Andy Lutomirski wrote:
>> On Thu, Aug 20, 2020 at 8:21 AM Tom Lendacky <thomas.lendacky@amd.com> 
>> wrote:
>>>
>>> On 8/20/20 10:10 AM, Sean Christopherson wrote:
>>>> On Wed, Aug 19, 2020 at 05:21:33PM -0700, Andy Lutomirski wrote:
>>>>> On Wed, Aug 19, 2020 at 2:25 PM Andy Lutomirski <luto@kernel.org> wrote:
>>>>>>
>>>>>> On Wed, Aug 19, 2020 at 11:19 AM Tom Lendacky 
>>>>>> <thomas.lendacky@amd.com> wrote:
>>>>>>>
>>>>>>> On 8/19/20 1:07 PM, Tom Lendacky wrote:
>>>>>>>> It looks like the FSGSBASE support is crashing my second 
>>>>>>>> generation EPYC
>>>>>>>> system. I was able to bisect it to:
>>>>>>>>
>>>>>>>> b745cfba44c1 ("x86/cpu: Enable FSGSBASE on 64bit by default and 
>>>>>>>> add a chicken bit")
>>>>>>>>
>>>>>>>> The panic only happens when using KVM. Doing kernel builds or stress
>>>>>>>> on bare-metal appears fine. But if I fire up, in this case, a 64-vCPU
>>>>>>>> guest and do a kernel build within the guest, I get the following:
>>>>>>>
>>>>>>> I should clarify that this panic is on the bare-metal system, not 
>>>>>>> in the
>>>>>>> guest. And that specifying nofsgsbase on the bare-metal command 
>>>>>>> line fixes
>>>>>>> the issue.
>>>>>>
>>>>>> I certainly see some oddities:
>>>>>>
>>>>>> We have this code:
>>>>>>
>>>>>> static void svm_vcpu_put(struct kvm_vcpu *vcpu)
>>>>>> {
>>>>>>           struct vcpu_svm *svm = to_svm(vcpu);
>>>>>>           int i;
>>>>>>
>>>>>>           avic_vcpu_put(vcpu);
>>>>>>
>>>>>>           ++vcpu->stat.host_state_reload;
>>>>>>           kvm_load_ldt(svm->host.ldt);
>>>>>> #ifdef CONFIG_X86_64
>>>>>>           loadsegment(fs, svm->host.fs);
>>>>>>           wrmsrl(MSR_KERNEL_GS_BASE, current->thread.gsbase);
>>>>
>>>> Pretty sure current->thread.gsbase can be stale, i.e. this needs:
>>>>
>>>>        current_save_fsgs();
>>>
>>> I did try adding current_save_fsgs() in svm_vcpu_load(), saving the
>>> current->thread.gsbase value to a new variable in the svm struct. I then
>>> used that variable in the wrmsrl below, but it still crashed.
>>
>> Can you try bisecting all the way back to:
>>
>> commit dd649bd0b3aa012740059b1ba31ecad28a408f7f
>> Author: Andy Lutomirski <luto@kernel.org>
>> Date:   Thu May 28 16:13:48 2020 -0400
>>
>>      x86/cpu: Add 'unsafe_fsgsbase' to enable CR4.FSGSBASE
>>
>> and adding the unsafe_fsgsbase command line option while you bisect.
> 
> I'll give that a try.
> 
>>
>> Also, you're crashing when you run a guest, right?  Can you try
> 
> Right, when the guest is running. The guest boots fine and only when I put 
> some stress on it (kernel build) does it cause the issue. It might be 
> worth trying to pin all the vCPUs and see if the crash still happens.
> 
>> running the x86 sefltests on a bad kernel without running any guests?
> 
> I'll give that a try.

All the selftests passed.

Thanks,
Tom

> 
> Thanks,
> Tom
> 
>>
>> --Andy
>>
