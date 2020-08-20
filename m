Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEC7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C36D206B5
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LZGfn6o1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgHTSeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 14:34:09 -0400
Received: from mail-bn8nam12on2061.outbound.protection.outlook.com ([40.107.237.61]:61644
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726701AbgHTSeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 14:34:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Csqcu8cClkN4IqyYTGGMwvoP/ctEEBuTMJES0qL/TLZMcKDzVEMvZpPlrNpq38/RgF07PJnM9+AGt9j+cegmlSwLZaR4XCidvo6DEg2TEHkUqsNU2zFKaIYml2J+K2f+PZOE1KT/TdEPy4BjJxLAVdethtLLcnk94LbE9uVP4doJ5ri2/hzCmtw3Piuz519+AtyHZ+WRR+M7X6+uNGx0fapsIZOVSypE85PAYGg40oVsxJZVBHTDnHixUky+UgSD2hL6FkuNYrRTDU6x1YiUGPtmH8EogC5Mh0+oSoShfOnc+EnBOkoYvVEZlOnQqs4VHPPZG4D4oBRbTe2HISnwaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWMnk7ndQxYT3Pa6wu9c8YL+T0ILc0x9XdbpMP+xF8w=;
 b=Ww2J1zCDVlnwpgWB6wF9ZvFDBaARG7NoRuiBbM41pSaDUXmLkTtVMygzcZyb8vDAYGN1uhHaubm38akNUQH+M6ZAX9JzNen8Ww+9VWUxu2EkkdBNriPs/xz2yxE0rkqggLA/PCuT8WFfVU6BlssURT4/TxYbbzONnNFeQ5E4fZNzOKWT+V6WqHjdyAnp8/aP2exrXgcp63Ur7Ef1Zd4YYb/lQVy6UCB1MSUomBga13e0r/XQdCt58STndNHuCM19/rw4eE1MakWiEg5HYKBzmALSJxZE34gtsVoLKLXkP52Zw2PtbqgDmXR27TFL4vzz5VvhWRFeNNZ3oTVVJKi4bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWMnk7ndQxYT3Pa6wu9c8YL+T0ILc0x9XdbpMP+xF8w=;
 b=LZGfn6o1Ij1EHhHx+dWdjEDOD8i86Mv7FNoFSTE04GGCUqGusgUi+jJhw5bFPIELACW52UZQXphfSVDoQBBIbuAvRGXK9iv9WjyZ4QISefcvDYKOPMaZyAqRehEajzvW/RvrdAzQ6YXpK3pg779kwKmqgBJ4BeozbA3qV/s50C8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Thu, 20 Aug 2020 18:34:03 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346%3]) with mapi id 15.20.3305.026; Thu, 20 Aug 2020
 18:34:03 +0000
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
 <c7f65dbc-316b-efb9-d2c3-c7c212289dce@amd.com>
Message-ID: <68478297-ff21-fa38-a37b-2e1e515fdc5e@amd.com>
Date:   Thu, 20 Aug 2020 13:34:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <c7f65dbc-316b-efb9-d2c3-c7c212289dce@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0501CA0074.namprd05.prod.outlook.com
 (2603:10b6:803:22::12) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by SN4PR0501CA0074.namprd05.prod.outlook.com (2603:10b6:803:22::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10 via Frontend Transport; Thu, 20 Aug 2020 18:34:02 +0000
X-Originating-IP: [67.79.209.213]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3af23eb7-1850-4797-643f-08d845379d14
X-MS-TrafficTypeDiagnostic: DM6PR12MB4484:
X-Microsoft-Antispam-PRVS: <DM6PR12MB44848E694ED513D65CD39EE1EC5A0@DM6PR12MB4484.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: elYdRxQo7yZTXCfWoFiR/Vj81T23DNmBZHoJ3mtUulR/rXcaS57SjLfcNAQO/mH+RosiuHbvXPXnhpIGJ0fYxok3Yb/1ArkxLD/HK9YwQrQfJ03jIYCBCJQaEnvtvTWFmYJCNLCgiibaU0BCevjRr36Bcsf2Y/uwIwhybQ7iazLb24WedeHFsmR2uSG8zCSkipxPFyEnVRU9iidFWkF1t+B4uAtyimeV2Hfb3NCSoi9U/9iWtAFK7tHZsIAJmdgZ19Gkfj5CgVxqjahtiLkVLbWOGKjXq2eDAk6WAoL9G0gACDZMURl0as30tMJBXnQe7wvZ9nLJGInjJ2ADVl7G9hGnzlpCSAP5XHfWvzd1PzZ6VtsOoH0vUjDK9cY9iBIRwd3w0/2tga9IU7eLbrcTk2uxmYYv9WSva5sr6bsLdtg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(66476007)(66946007)(5660300002)(6916009)(7416002)(66556008)(36756003)(86362001)(31696002)(26005)(478600001)(52116002)(53546011)(186003)(316002)(2616005)(16576012)(4326008)(6486002)(2906002)(956004)(31686004)(8936002)(54906003)(8676002)(110011004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: CJlooDAl4vb8/yYLhZjYrShq6+CGwncGFJDpm7R1PzC10+DIb0yzQPK8NZtlIoBT1+0+C12QmAFGsqbeqwFTsxdDEpxkWJO2sWL+yTYZqqjwoSWT2+zO9luUjRpUxum35hyTJpT/jpAoeGCIWi+D9MVHYsq5EnDdvmKNxfx2i0R05FZnLDlJX25jID4b3kdHm2gXKMOwuvB3K5+gnPzS2uh4QyXvO+pSsylZuSBVgtp8Hih1Qrokeawws+dvt/OaEJxpO7UAm6KCK9meXmtKJX5tzOEwc3pQyS28kFIaVXmF/DphSZbVXm8KjaIv8aQtiBgNrnBBFO+Uw/qeVn2/DZKjGGXURicRlIurwnSAZpOqdnc4Tl0Rx1/0dc4XPCWwCB0lI9zWoxKyMvVaUIr6Ziiyb+JMwzB/4r7JXW89m0TtsXsVJQ+L9QlxK0cEVCPGS0Vg+ItttNnJ5IQkZFbCme8yEfpxUCzlx21RFO+GXv90lRKcpOMDaiacbsfPEZD0eOI4kqtDKdjrXpYmEFDf53yn8+PcmoHjr79fFhXm8Fvq8tk3i57+kLu+L7jsGMOtLPeB2BKq4hNqS9OAPO/mZ1N75cyaLFauXMH+g6jhC+SjbjtWIUT2suCSL7VIWPlvlbixkFABk86P2yVYUG5aiw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3af23eb7-1850-4797-643f-08d845379d14
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 18:34:03.5211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHAiQ1Q72mAHPe1k9bcecP12uI3DV4xCoArOmltfOd/uoLDPL4n+k+rLAYyx3bt8gDcef3zJqxTsuGpan6DNgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/20 11:30 AM, Tom Lendacky wrote:
> On 8/20/20 11:17 AM, Tom Lendacky wrote:
>> On 8/20/20 10:55 AM, Andy Lutomirski wrote:
>>> On Thu, Aug 20, 2020 at 8:21 AM Tom Lendacky <thomas.lendacky@amd.com> 
>>> wrote:
>>>>
>>>> On 8/20/20 10:10 AM, Sean Christopherson wrote:
>>>>> On Wed, Aug 19, 2020 at 05:21:33PM -0700, Andy Lutomirski wrote:
>>>>>> On Wed, Aug 19, 2020 at 2:25 PM Andy Lutomirski <luto@kernel.org> 
>>>>>> wrote:
>>>>>>>
>>>>>>> On Wed, Aug 19, 2020 at 11:19 AM Tom Lendacky 
>>>>>>> <thomas.lendacky@amd.com> wrote:
>>>>>>>>
>>>>>>>> On 8/19/20 1:07 PM, Tom Lendacky wrote:
>>>>>>>>> It looks like the FSGSBASE support is crashing my second 
>>>>>>>>> generation EPYC
>>>>>>>>> system. I was able to bisect it to:
>>>>>>>>>
>>>>>>>>> b745cfba44c1 ("x86/cpu: Enable FSGSBASE on 64bit by default and 
>>>>>>>>> add a chicken bit")
>>>>>>>>>
>>>>>>>>> The panic only happens when using KVM. Doing kernel builds or stress
>>>>>>>>> on bare-metal appears fine. But if I fire up, in this case, a 
>>>>>>>>> 64-vCPU
>>>>>>>>> guest and do a kernel build within the guest, I get the following:
>>>>>>>>
>>>>>>>> I should clarify that this panic is on the bare-metal system, not 
>>>>>>>> in the
>>>>>>>> guest. And that specifying nofsgsbase on the bare-metal command 
>>>>>>>> line fixes
>>>>>>>> the issue.
>>>>>>>
>>>>>>> I certainly see some oddities:
>>>>>>>
>>>>>>> We have this code:
>>>>>>>
>>>>>>> static void svm_vcpu_put(struct kvm_vcpu *vcpu)
>>>>>>> {
>>>>>>>           struct vcpu_svm *svm = to_svm(vcpu);
>>>>>>>           int i;
>>>>>>>
>>>>>>>           avic_vcpu_put(vcpu);
>>>>>>>
>>>>>>>           ++vcpu->stat.host_state_reload;
>>>>>>>           kvm_load_ldt(svm->host.ldt);
>>>>>>> #ifdef CONFIG_X86_64
>>>>>>>           loadsegment(fs, svm->host.fs);
>>>>>>>           wrmsrl(MSR_KERNEL_GS_BASE, current->thread.gsbase);
>>>>>
>>>>> Pretty sure current->thread.gsbase can be stale, i.e. this needs:
>>>>>
>>>>>        current_save_fsgs();
>>>>
>>>> I did try adding current_save_fsgs() in svm_vcpu_load(), saving the
>>>> current->thread.gsbase value to a new variable in the svm struct. I then
>>>> used that variable in the wrmsrl below, but it still crashed.
>>>
>>> Can you try bisecting all the way back to:
>>>
>>> commit dd649bd0b3aa012740059b1ba31ecad28a408f7f
>>> Author: Andy Lutomirski <luto@kernel.org>
>>> Date:   Thu May 28 16:13:48 2020 -0400
>>>
>>>      x86/cpu: Add 'unsafe_fsgsbase' to enable CR4.FSGSBASE
>>>
>>> and adding the unsafe_fsgsbase command line option while you bisect.
>>
>> I'll give that a try.

Bisecting with unsafe_fsgsbase identified:

c82965f9e530 ("x86/entry/64: Handle FSGSBASE enabled paranoid entry/exit")

But I'm thinking that could be because it starts using GET_PERCPU_BASE, 
which on Rome would use RDPID. So is SVM restoring TSC_AUX_MSR too late? 
That would explain why I don't see the issue on Naples, which doesn't 
support RDPID.

Thanks,
Tom

>>
>>>
>>> Also, you're crashing when you run a guest, right?  Can you try
>>
>> Right, when the guest is running. The guest boots fine and only when I 
>> put some stress on it (kernel build) does it cause the issue. It might 
>> be worth trying to pin all the vCPUs and see if the crash still happens.
>>
>>> running the x86 sefltests on a bad kernel without running any guests?
>>
>> I'll give that a try.
> 
> All the selftests passed.
> 
> Thanks,
> Tom
> 
>>
>> Thanks,
>> Tom
>>
>>>
>>> --Andy
>>>
