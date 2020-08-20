Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17EBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E24F2075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="U622t66e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbgHTQSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 12:18:36 -0400
Received: from mail-dm6nam12on2070.outbound.protection.outlook.com ([40.107.243.70]:38112
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729510AbgHTQRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 12:17:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFh5T4djClzuqlqCm+lWdlMf/SdVbI6af5UM17GHKiNXIVCw71G4hutxkGG4nfmq6aO3UyZpz7JYYO0wd/NYh91a3+JndwXIW25OO6Ob68BdqvY48Hbe9ZLM7L6kjHL5QNDNlB2pRZjuxAOc1xqs7+ZWyF8qfa97seNKiiQP8DwFs/Li/d7I0RQ4+6mIm6q51F9fWfx67QK4KwCFFdKtu+XfWkJ+svnnQiAim6sIHZZMeFJ0IOO8vJDfV4gcfhRxmFXQQvoH83QM0k/lxGH3bKDrzQor675tCdW1RxjMItKcFFGPlZ6TtwkLbtqEGHXiijMMB/vt0OkxKdSrWNWQqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5K5FIMUUOzxvEtcrRubE5v1w3htLT/AGA+GT48J8ZEg=;
 b=NCiDdLqdCC2IkWgz2v4dC+zDZxsprytKa4yVI7AdsEHkjQJnIN3zKSHT1DT+r5hrV//aKR6ccFVCNja7Lhwv1uhKHGYpc9ttGL+akmsBWEw0e+HkwJecK0VxwAdcC7CwzZs4dUdY7ahHz32jhb/W5b5B4S+vW4tIrPzWz1nJ/BU/HNFmA2OK5utQzJcLS4i56V5ZUEiqyfd8kvHOrWizPxcAR2kpShFtuhdSToQQC0/gSeooj27Iibc9+tx7o6FG2w3W69YgezH4U021MpJVHc7/9tur/gvU3zTvvlBRW7iGtypDGFMGInjW/7OWVqH7zHi8ErgcnLP3GbnKmuzOCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5K5FIMUUOzxvEtcrRubE5v1w3htLT/AGA+GT48J8ZEg=;
 b=U622t66es38XjtyT9d1iU431d1uQS9gF6KoIAaRpxSuXqnwB/PJmw6npDdGjVNHDI8y9fnOUZA42+fPFWy3Kwy4+te16M7QMuV78U+ANx1KP3SJXAS0TL6rwUTSGFkwgcNVy3XQrNzVnGa3T0lZfXuh5Si+/EHKrwk1LkDtOujg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25; Thu, 20 Aug 2020 16:17:02 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346%3]) with mapi id 15.20.3305.026; Thu, 20 Aug 2020
 16:17:02 +0000
Subject: Re: FSGSBASE causing panic on 5.9-rc1
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
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <45e16c5c-ce99-33da-99c8-ea52ef0945db@amd.com>
Date:   Thu, 20 Aug 2020 11:17:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CALCETrW8SWgWxDdMXuMPD-A1avztvNcpwLAKKRQ4ojmcz07B6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:805:de::43) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by SN6PR05CA0030.namprd05.prod.outlook.com (2603:10b6:805:de::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10 via Frontend Transport; Thu, 20 Aug 2020 16:17:01 +0000
X-Originating-IP: [67.79.209.213]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aefbc303-6b9e-4149-ef5b-08d8452478ca
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4355A5C752B25300B79E3D20EC5A0@DM6PR12MB4355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FkTyG6j7JchvqxVp0suMq9QQ52UbkN76Zb1hrQHtiQE57SQ+YJ+RcjZXXXQHi3xnXXT9P0nDyg0Ngind+kp1dqRS8YZRtRNppavlZO/5AkVkLS8empI3mODlVTUv18OkrPEKo33mfI+TeYGkw25q4og9p/K4L4ucJ+OowmVfZz7pqOzardZr27LYkRFdkiaG2vXyoInS43LcH4sQ2oIk48HQeOiPS4GRYeW7BH4PGVqGY+6BRdfMMnAAhRfObYHJvXHzEgBeNaoL2ocejsbaFO9xio2cShYqMjHxZSU9acXgNkaLji4J/t5PZagncVDXxkHOft1PwKGaYTR2glRp1AkzJWM0nPkP54j/f1fpUcJQHsGKzYxAboKVF4G8Q4wGWFouPFKsTrb15n4zTl2lFbQ5RLmHRP0uuuBgIl9G9Ec=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(956004)(2616005)(31686004)(6916009)(110011004)(2906002)(8676002)(52116002)(4326008)(26005)(54906003)(36756003)(6486002)(86362001)(478600001)(16576012)(186003)(316002)(7416002)(66556008)(66476007)(66946007)(31696002)(5660300002)(53546011)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: lQ2oiZSkxIOvx4/sGfWtyumlX5gSTZesMrr3SMrQuntnvzWQHx1YFdCB/yU4EnQZTMkgCrDygw8VCBjDRmYYvx8XgJhpbm3GUw/JdJW0Ny0hpFZB7d5cH7k3nVV9JMOV3H+LS3aWegKwMsx/4zE7gINJSWOClddPD7GLqaxVMYlAP0RybI4N+faVpogeXIxtJRCBR6imGMfcC7s82twyLQKKmfw2FEwBsEDqGmMrfImOWKfwnScvOKho/sPbn+4HwU4WXD6N820HzHIrQm8nJwwW51vm/TwifS2lbJmWYoNdPM3KQk+dbNV118fY06ro7R1Ssh6NaAHoDIe5wWIZHR+A/5FRps93s0E6/lyQo3JT+VNxVA3UPdjdnhxu/IuFEC/PHM/ZXLGXLk0CwFKY/7MDjeQpEefOsHctTnuTfmE9DQkiFlRXxEqIhVoKp87U5WeKmfs/5wDVnny3y2Rp6YbIhIqUxuV6EhOnRYk5DrEU5t8SdPfGPkKOj0QAiV2LjrKarkn+CvOWY9nDy5nqL5jjBubVap2yllKvCi8c4TOLQFh7h3F1BGBpiqfCnab5dO1rhP9NH4z84Bix1i6/7lw1+oYmijofQRLGQ5bdi0vVJ5a8lh5ZkhDDb9i/r0rvpHj3AspJrOEMqPUuxQbebA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aefbc303-6b9e-4149-ef5b-08d8452478ca
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 16:17:02.2539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZH8ubKDfyWBdr7XmxOkv4x0RTjBOjRqCTzVaxj/Hk1psBbIg8oKOqP0zuQtkxzgzPemQCuoczaMV6OcwV19TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/20 10:55 AM, Andy Lutomirski wrote:
> On Thu, Aug 20, 2020 at 8:21 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>
>> On 8/20/20 10:10 AM, Sean Christopherson wrote:
>>> On Wed, Aug 19, 2020 at 05:21:33PM -0700, Andy Lutomirski wrote:
>>>> On Wed, Aug 19, 2020 at 2:25 PM Andy Lutomirski <luto@kernel.org> wrote:
>>>>>
>>>>> On Wed, Aug 19, 2020 at 11:19 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>>>>>
>>>>>> On 8/19/20 1:07 PM, Tom Lendacky wrote:
>>>>>>> It looks like the FSGSBASE support is crashing my second generation EPYC
>>>>>>> system. I was able to bisect it to:
>>>>>>>
>>>>>>> b745cfba44c1 ("x86/cpu: Enable FSGSBASE on 64bit by default and add a chicken bit")
>>>>>>>
>>>>>>> The panic only happens when using KVM. Doing kernel builds or stress
>>>>>>> on bare-metal appears fine. But if I fire up, in this case, a 64-vCPU
>>>>>>> guest and do a kernel build within the guest, I get the following:
>>>>>>
>>>>>> I should clarify that this panic is on the bare-metal system, not in the
>>>>>> guest. And that specifying nofsgsbase on the bare-metal command line fixes
>>>>>> the issue.
>>>>>
>>>>> I certainly see some oddities:
>>>>>
>>>>> We have this code:
>>>>>
>>>>> static void svm_vcpu_put(struct kvm_vcpu *vcpu)
>>>>> {
>>>>>           struct vcpu_svm *svm = to_svm(vcpu);
>>>>>           int i;
>>>>>
>>>>>           avic_vcpu_put(vcpu);
>>>>>
>>>>>           ++vcpu->stat.host_state_reload;
>>>>>           kvm_load_ldt(svm->host.ldt);
>>>>> #ifdef CONFIG_X86_64
>>>>>           loadsegment(fs, svm->host.fs);
>>>>>           wrmsrl(MSR_KERNEL_GS_BASE, current->thread.gsbase);
>>>
>>> Pretty sure current->thread.gsbase can be stale, i.e. this needs:
>>>
>>>        current_save_fsgs();
>>
>> I did try adding current_save_fsgs() in svm_vcpu_load(), saving the
>> current->thread.gsbase value to a new variable in the svm struct. I then
>> used that variable in the wrmsrl below, but it still crashed.
> 
> Can you try bisecting all the way back to:
> 
> commit dd649bd0b3aa012740059b1ba31ecad28a408f7f
> Author: Andy Lutomirski <luto@kernel.org>
> Date:   Thu May 28 16:13:48 2020 -0400
> 
>      x86/cpu: Add 'unsafe_fsgsbase' to enable CR4.FSGSBASE
> 
> and adding the unsafe_fsgsbase command line option while you bisect.

I'll give that a try.

> 
> Also, you're crashing when you run a guest, right?  Can you try

Right, when the guest is running. The guest boots fine and only when I put 
some stress on it (kernel build) does it cause the issue. It might be 
worth trying to pin all the vCPUs and see if the crash still happens.

> running the x86 sefltests on a bad kernel without running any guests?

I'll give that a try.

Thanks,
Tom

> 
> --Andy
> 
