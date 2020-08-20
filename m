Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89645C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52D15206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="crVt546v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgHTSld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 14:41:33 -0400
Received: from mail-dm6nam12on2067.outbound.protection.outlook.com ([40.107.243.67]:50016
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727068AbgHTSl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 14:41:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lv7UAKpAWZxeLlfeMY2tDPeZJ78zCs1Ymk4N7PLHtOdoihUlFNSa7qSr2kN8+hAJ8kdhOFf8EryA1UzsqEKJxE7YqBFlyj3DvZUDyItElh/11qNuWJF2G1zsjpubb8Uo9ZKwkThZ1ObM25XU9K1hXjXoJqRKTHhFL5Q3rHihQxfggX15fGD7szvUuaSzkXu2xtCklYm9iS9LmB8yR8+xzpIgEOKnD1Qg2wdJ2PSaN1IwiwJrSvFOfpKxWCFb5yvxwSJY4AN7Ow6UxZ2CCXsjnK9g4KgSmeCWwK4aGVQvGcaBQGoCXikRWHyZC483TDubdRBHmma9fjQ88LxLFL0ofg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ta5/5TtGlX9zsCCd6OHLtnqkvyGfwdaDlNOm3OhivOU=;
 b=D30nNL/rUEvuocbFYAHl7i3CDUua5FIcIXH9GIhPZ30fVXtjSwJ62CGxDdTodt/+Xy3Bis8s3KOL22f16u2gBCPrdN3ReBwQWcdl4OZwp/Vj8Uk18po3ZrxDsFnHv323C6qSjDlbFSfpdxGCYfpvzO4maRS1muAb+gUKnkDl0dzLKpHy5OgZQUs+rA/6erC7aKa9b8CMI+zY/tb8OTViT0ZYjKmly6NDoUh3NZuq06BJ8DdyGm1hCfGHQ6s2V+Z9DAegRb5sfWoq+DDvlXw7cn3NrnwIrWrpFH4BL8XIhQJeEMtPyS3fWtSr2mKNRatkKFsPB8PbcO7Ccm2aG/ubWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ta5/5TtGlX9zsCCd6OHLtnqkvyGfwdaDlNOm3OhivOU=;
 b=crVt546v654ticYtgl+a+5SnUemI2G30w0q9L8WjH0Sc6h8jZJ0CkGnAUyMlQz+qU/i+IRdR6q67CeEpk6sLTIgf8de+jhLj3jYG4NsDYfLaryMHa3hRa8WdfP4eUUFMDKIlwZOy2XLIROQVhKUrd631lBKc/Iv/Y9Fbuj1zk4Y=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Thu, 20 Aug 2020 18:41:27 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346%3]) with mapi id 15.20.3305.026; Thu, 20 Aug 2020
 18:41:26 +0000
Subject: Re: FSGSBASE causing panic on 5.9-rc1
To:     Jim Mattson <jmattson@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
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
 <c7f65dbc-316b-efb9-d2c3-c7c212289dce@amd.com>
 <68478297-ff21-fa38-a37b-2e1e515fdc5e@amd.com>
 <CALMp9eQDuwzxdLXndnq9FZfDXaNS7U36WDW7CqixjVBareYAwQ@mail.gmail.com>
 <CALMp9eRXvM9un1LVsuMZqE6aKSzdxp+UXAMrZS1RD-jxEdZqZg@mail.gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <50e7c7f6-d212-4e90-09b7-2c568087084e@amd.com>
Date:   Thu, 20 Aug 2020 13:41:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CALMp9eRXvM9un1LVsuMZqE6aKSzdxp+UXAMrZS1RD-jxEdZqZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR08CA0015.namprd08.prod.outlook.com
 (2603:10b6:805:66::28) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by SN6PR08CA0015.namprd08.prod.outlook.com (2603:10b6:805:66::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 18:41:25 +0000
X-Originating-IP: [67.79.209.213]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 84d9d1a4-5d5d-480c-56b3-08d84538a55a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4484:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4484F64D21CBD52C64640E01EC5A0@DM6PR12MB4484.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VpPnOUO6DVDcoeIQYH5xk5HvOYKpoR+dM1lfr89nrR5IV9NyMz1PyPh8K6r55VnLzdiI1t5WLhEuMEx6dMfhzk7mimtPnKx6hBeMjdsV+22/1Gq2tpNAm9htmtj0HjTBOeHk5tMgQfmtvFpKhGDXOu22shMCtDdfVTkB/Cv1BaTvCCbSZsCUmD35J1AqyVMwwq8J5o+fj2GGvBnXW+oDTDFN50EpHHAbGGP8ymibHIzvK4TdmLRuGgdguzYVR8/KEfJTOFfdXUkTdh1qGnP5krLed6oxSDw7YiU6cX7f50fqckD0pTCTzodYBpGL0jvo4ecC1lVOwhXadVhaa8pT1g2WOmxhG59dzCTZOluGXUFSq9a8uNa9DZeNveuapUED0dOLU/KV0q4qgE8SP9AuTHkvIvQaDrv4V05NrFGCJoQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(66476007)(66946007)(5660300002)(6916009)(7416002)(83380400001)(66556008)(36756003)(86362001)(31696002)(26005)(478600001)(52116002)(53546011)(186003)(316002)(2616005)(16576012)(4326008)(6486002)(2906002)(956004)(31686004)(8936002)(54906003)(8676002)(110011004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: TvQymLU0E1QdRLzEzE05/dzxeKltSaeJPqRCW30sR3KXrEwn7ilMxDN4JHQAFDvZAjsRoeDBD3hDUDMV6rSVPluGaaILIbHyY+rQ+6C6XXVNQ0RRfH74hI35Ay5/Sg1aw5r6qyO88RB7dD0ARE3d6LsPBwtfUQaZmi6aAr658PT4695vXv7E5AOZrc1SPGgU7N2sQexfQRTG1JdgN2kEgMpESbHQE9qfIjgUr36efZiIIDdBRtAeZ4Ekexwj5FSxZmhtOJbk5ybwcmFJwX1FOas1fW2aL4nFpgHut3GSllUzhOrfr9sLSwaTjLMj+RurTa9OnG5wr/8WpqGpe033qfHSxx7Y7yHI/9atsd17T9jaNzZN7ueoFBahlYRVz+Gjb44EzNKGX1p09/UJgmQ0WPVDRPMZ+O7X6jyOlqF1uScwice5ZxZSqCbD9eXLFakgTVnvyWKhUM9e4oJ6Dl1z7G66p94bO2Aczu1V21AbyDzIrg/u7NhQOYE2jhO9/QLay5cWxnJqhb5rdmFPJBZ6JdjZhe73io62FuIdoPOl7vEw1PjtZHGrF/8uA3kFma3LUbXPfJKBcvDE4F159QKBW1ND0NDtFBpHxMOy5OSlIO26x1isy9qAKZQksPfVOWyi7Iz7am7ySMZbAtL42dTM2g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d9d1a4-5d5d-480c-56b3-08d84538a55a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 18:41:26.8780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UnSUPxlsFLygSUvS4AJP9Qo/sI/FzfsNegnvgU/l0TXliftdBUjetpRfMqsJq8kLKQem9syMELfbW2g2ru1OoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/20 1:39 PM, Jim Mattson wrote:
> On Thu, Aug 20, 2020 at 11:38 AM Jim Mattson <jmattson@google.com> wrote:
>>
>> On Thu, Aug 20, 2020 at 11:34 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>>
>>> On 8/20/20 11:30 AM, Tom Lendacky wrote:
>>>> On 8/20/20 11:17 AM, Tom Lendacky wrote:
>>>>> On 8/20/20 10:55 AM, Andy Lutomirski wrote:
>>>>>> On Thu, Aug 20, 2020 at 8:21 AM Tom Lendacky <thomas.lendacky@amd.com>
>>>>>> wrote:
>>>>>>>
>>>>>>> On 8/20/20 10:10 AM, Sean Christopherson wrote:
>>>>>>>> On Wed, Aug 19, 2020 at 05:21:33PM -0700, Andy Lutomirski wrote:
>>>>>>>>> On Wed, Aug 19, 2020 at 2:25 PM Andy Lutomirski <luto@kernel.org>
>>>>>>>>> wrote:
>>>>>>>>>>
>>>>>>>>>> On Wed, Aug 19, 2020 at 11:19 AM Tom Lendacky
>>>>>>>>>> <thomas.lendacky@amd.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> On 8/19/20 1:07 PM, Tom Lendacky wrote:
>>>>>>>>>>>> It looks like the FSGSBASE support is crashing my second
>>>>>>>>>>>> generation EPYC
>>>>>>>>>>>> system. I was able to bisect it to:
>>>>>>>>>>>>
>>>>>>>>>>>> b745cfba44c1 ("x86/cpu: Enable FSGSBASE on 64bit by default and
>>>>>>>>>>>> add a chicken bit")
>>>>>>>>>>>>
>>>>>>>>>>>> The panic only happens when using KVM. Doing kernel builds or stress
>>>>>>>>>>>> on bare-metal appears fine. But if I fire up, in this case, a
>>>>>>>>>>>> 64-vCPU
>>>>>>>>>>>> guest and do a kernel build within the guest, I get the following:
>>>>>>>>>>>
>>>>>>>>>>> I should clarify that this panic is on the bare-metal system, not
>>>>>>>>>>> in the
>>>>>>>>>>> guest. And that specifying nofsgsbase on the bare-metal command
>>>>>>>>>>> line fixes
>>>>>>>>>>> the issue.
>>>>>>>>>>
>>>>>>>>>> I certainly see some oddities:
>>>>>>>>>>
>>>>>>>>>> We have this code:
>>>>>>>>>>
>>>>>>>>>> static void svm_vcpu_put(struct kvm_vcpu *vcpu)
>>>>>>>>>> {
>>>>>>>>>>            struct vcpu_svm *svm = to_svm(vcpu);
>>>>>>>>>>            int i;
>>>>>>>>>>
>>>>>>>>>>            avic_vcpu_put(vcpu);
>>>>>>>>>>
>>>>>>>>>>            ++vcpu->stat.host_state_reload;
>>>>>>>>>>            kvm_load_ldt(svm->host.ldt);
>>>>>>>>>> #ifdef CONFIG_X86_64
>>>>>>>>>>            loadsegment(fs, svm->host.fs);
>>>>>>>>>>            wrmsrl(MSR_KERNEL_GS_BASE, current->thread.gsbase);
>>>>>>>>
>>>>>>>> Pretty sure current->thread.gsbase can be stale, i.e. this needs:
>>>>>>>>
>>>>>>>>         current_save_fsgs();
>>>>>>>
>>>>>>> I did try adding current_save_fsgs() in svm_vcpu_load(), saving the
>>>>>>> current->thread.gsbase value to a new variable in the svm struct. I then
>>>>>>> used that variable in the wrmsrl below, but it still crashed.
>>>>>>
>>>>>> Can you try bisecting all the way back to:
>>>>>>
>>>>>> commit dd649bd0b3aa012740059b1ba31ecad28a408f7f
>>>>>> Author: Andy Lutomirski <luto@kernel.org>
>>>>>> Date:   Thu May 28 16:13:48 2020 -0400
>>>>>>
>>>>>>       x86/cpu: Add 'unsafe_fsgsbase' to enable CR4.FSGSBASE
>>>>>>
>>>>>> and adding the unsafe_fsgsbase command line option while you bisect.
>>>>>
>>>>> I'll give that a try.
>>>
>>> Bisecting with unsafe_fsgsbase identified:
>>>
>>> c82965f9e530 ("x86/entry/64: Handle FSGSBASE enabled paranoid entry/exit")
>>>
>>> But I'm thinking that could be because it starts using GET_PERCPU_BASE,
>>> which on Rome would use RDPID. So is SVM restoring TSC_AUX_MSR too late?
>>> That would explain why I don't see the issue on Naples, which doesn't
>>> support RDPID.
>>
>> It looks to me like SVM loads the guest TSC_AUX from vcpu_load to
>> vcpu_put, with this comment:
>>
>> /* This assumes that the kernel never uses MSR_TSC_AUX */
>> if (static_cpu_has(X86_FEATURE_RDTSCP))
>>          wrmsrl(MSR_TSC_AUX, svm->tsc_aux);
> 
> Correction: It never restores TSC_AUX, AFAICT.

It does, it's in the host_save_user_msrs array.

Thanks,
Tom

> 
