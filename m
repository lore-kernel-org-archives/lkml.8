Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF5AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 00:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B436206DA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 00:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cV/eEI/M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgHUAA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 20:00:29 -0400
Received: from mail-mw2nam10on2061.outbound.protection.outlook.com ([40.107.94.61]:34240
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbgHUAAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 20:00:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gg3n25gtjM5xlYBwKQjvSQm162hR+bEQO0g/aDD6l/ri6wpmi715WAhBQmSEfryYorhlyOiuWJZVJq4bqqHJ/THYg51KkB3pafQpSDUSvFHWAj0qo1B/X19XGpgFEwmiZ5FGLnEyjGbPd+AoqC1wpJXOqjiDIMSuiDa/Tr9apPvfJ26ylcrydyzzOpwfVv1kGEf9jDcqU1c0ucr1wdINMKrbT84jy1rEKbWl2mfdMdeaJ/ESENWpyMWqC/fJDG+apCZQmxwuHCqGAEtw0J20fr4BMpHy3omUOYcMdp4wpw1hLLy0HT3bXSJZpUvgIO6dttrc7pwgA10u146cz5E1qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxvoZnudPbSblCF5kS5hJje+iA+piT2/6CiA+t5xRR4=;
 b=R939ZO0eFvmhURS4VBbyq2s4wY1YpbN+H/np+wMwsqjdD/nm40H+5SDmbZ/eX3PPp30qJx0XCBrjEj+p93+EYO4GEeXjn36jv/c6PbZZUw3xlHCNI89PGbLkWZTwdOx1F+zOLZGfJI3pww3QKkBXHjCKOK9Zyx8imH6TAa05ou2++qOasEn1Cvp2CrHN6aXc48dfqkD9ZsAPwywX61YTu3i1G6OdMuGNPKx04TCn1RfLM+jeoICRvxQE9kXzkbvYYWE2MNelsPZyL/zC9winvC441B386qbxS0sbReCMjGR9kNwbz1qTyq/omZkeNaqwCllW/C1Otxjj50qBquAeKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxvoZnudPbSblCF5kS5hJje+iA+piT2/6CiA+t5xRR4=;
 b=cV/eEI/MTu1a7nYrmdQwA0ooEvXpYgUPQRTZ6fcg2umdJj4Of2oiKuNUe4FD/ffm1sgAYI+JhUYV0iMBYHO1oyH09byEZp12gXPaRrava5hkqQYQ0zmsh28/QUsuoZiLRz+MxODfjk+rAn0u2VFYN09uZrF7jN9pJH1bgCERQTg=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB3081.namprd12.prod.outlook.com (2603:10b6:5:38::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Fri, 21 Aug 2020 00:00:20 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346%3]) with mapi id 15.20.3305.026; Fri, 21 Aug 2020
 00:00:19 +0000
Subject: Re: FSGSBASE causing panic on 5.9-rc1
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Jim Mattson <jmattson@google.com>,
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
References: <f6694ee6-d672-1cf9-deaf-4d600bc4e9eb@amd.com>
 <5756198D-C8BD-4290-BFCA-04424EB230A6@amacapital.net>
 <20200820220507.GA10269@sjchrist-ice>
 <CALCETrXxfZtLSPx+QFMRdnvDE6+zT=Jy8CYX03Va7o8M0VvKng@mail.gmail.com>
 <20200820223431.GB10269@sjchrist-ice>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <30eb9d62-a883-2630-c51f-6f5ee4def07a@amd.com>
Date:   Thu, 20 Aug 2020 19:00:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200820223431.GB10269@sjchrist-ice>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0201CA0027.namprd02.prod.outlook.com
 (2603:10b6:803:2e::13) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by SN4PR0201CA0027.namprd02.prod.outlook.com (2603:10b6:803:2e::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Fri, 21 Aug 2020 00:00:18 +0000
X-Originating-IP: [67.79.209.213]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: be79dd8a-a863-4539-0ee9-08d845653157
X-MS-TrafficTypeDiagnostic: DM6PR12MB3081:
X-Microsoft-Antispam-PRVS: <DM6PR12MB308193AFE4D7C8AF41467DDFEC5B0@DM6PR12MB3081.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/JlpqrFL7mr2+5Sct6C7pJlGkXhj9J7veKLBM/eNIyUuPe02phj4ERrg0NvhS0y38e/gcFFxNbVFfDifZtbheruGGlDPYojgjf4nv4W8YOI8LRRTQtDCDF/TH+/5vFE5ir73aeTeeSKd8N78YblqxBvhXfzqhx85Xmnz0G9wi1kq4EZe6H3kFoJmMTWIy4MIz9upTJ9r5/SdTvRkihZT2EuJprlGS/HUdiiN3kn+4B9HgaL/MNXYz/XhZoNf1P6KpZ33z4HY6NpjEftebwpm/HefuKHguRs+zf0rvlJYz9chGBbsj/NQqHBkG9FpPD7o47+kkspDBU3GNVoyTbF/WvwDB8iu5nRKtHAStQKYOVIxODtgi3yB84yxvDehtjgZBfvTQDBXZpz8qhN8v61avb3uv1UxQ1znnlN06ls5zA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(83380400001)(478600001)(54906003)(5660300002)(53546011)(26005)(66946007)(66556008)(8676002)(36756003)(52116002)(8936002)(2906002)(7416002)(66476007)(186003)(110011004)(31686004)(31696002)(110136005)(6486002)(2616005)(16576012)(86362001)(956004)(316002)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 8i1NFypTcdLt7hizpdeHnICIXh7RFw+mzko/N16UgCz2qrh4XhlKid+xX2J7KbMLWiPYeuUySPx6RAZgw5wC5d3yVeIbJlv0bbyo2ePg8/ggStaGnuKTbNturjDuRsW6hWWGsr9UwswoRzkqscl+JzR0l6R++xKNzV+dA7Ucea6h6G5IkBfziAaF5CSSQ5a9w53u9aoFSIBW+ThSFUdJS0x9x+qTQAePVMsN1z3us2XC2RQzoyAWvPlLQIUGUnsHOpoV4fG70Lm4Q6BRYwxxc8gR3F2HzmMjR3wn275nEas5yq3E4bvVyBw/IJyfFHWzTxl+6OIrujxria+A8EdyB19FNPZ/g+Qu6Gf79DOSnpiBbglhE6pKMZSDrrarrNWEazza34RcXnxap6oe6qmwfjMxZpAbuCJ7gn9gVMQI+VS2+I5MAVqy39hk7Su1rRpTyKV7SwOkfTixMAVh2cgATtB0cEdKsya432e7M0bVIsB5R89GNgS2sCPSfTsahaZpfkujCHnyEU9fXeHfN6U5R14UL/tQ3vVVa4oVrJ3NGp99C/echf6lwW+J65ZEeq2rmlfvuThWuTDw1KcAPmGRS9hils8UiCI/2bN9GQyTWxYvr7FleZ68yr/1A3hAPDyqIxcorIQfBL+5eMDIMoC5iA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be79dd8a-a863-4539-0ee9-08d845653157
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 00:00:19.7646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkS6oGhK1+PsuPnVCyWAJ86JpdZSgK531Y3Vwzrbv3mSV35V/RlyS2UIjULZc67wudDDMKdKILL8KFYc/Wx90w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/20 5:34 PM, Sean Christopherson wrote:
> On Thu, Aug 20, 2020 at 03:07:10PM -0700, Andy Lutomirski wrote:
>> On Thu, Aug 20, 2020 at 3:05 PM Sean Christopherson
>> <sean.j.christopherson@intel.com> wrote:
>>>
>>> On Thu, Aug 20, 2020 at 01:36:46PM -0700, Andy Lutomirski wrote:
>>>>
>>>>
>>>>> On Aug 20, 2020, at 1:15 PM, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>>>>>
>>>>> ﻿On 8/20/20 3:07 PM, Dave Hansen wrote:
>>>>>> On 8/20/20 12:05 PM, Tom Lendacky wrote:
>>>>>>>> I added a quick hack to save TSC_AUX to a new variable in the SVM
>>>>>>>> struct and then restore it right after VMEXIT (just after where GS is
>>>>>>>> restored in svm_vcpu_enter_exit()) and my guest is no longer crashing.
>>>>>>>
>>>>>>> Sorry, I mean my host is no longer crashing.
>>>>>> Just to make sure I've got this:
>>>>>> 1. Older CPUs didn't have X86_FEATURE_RDPID
>>>>>> 2. FSGSBASE patches started using RDPID in the NMI entry path when
>>>>>>     supported *AND* FSGSBASE was enabled
>>>>>> 3. There was a latent SVM bug which did not restore the RDPID data
>>>>>>     before NMIs were reenabled after VMEXIT
>>>>>> 4. If an NMI comes in the window between VMEXIT and the
>>>>>>     wrmsr(TSC_AUX)... boom
>>>>>
>>>>> Right, which means that the setting of TSC_AUX to the guest value needs to be moved, too.
>>>>>
>>>>
>>>> Depending on how much of a perf hit this is, we could also skip using RDPID
>>>> in the paranoid path on SVM-capable CPUs.
>>>
>>> Doesn't this affect VMX as well?  KVM+VMX doesn't restore TSC_AUX until the
>>> kernel returns to userspace.  I don't see anything that prevents the NMI
>>> RDPID path from affecting Intel CPUs.
>>>
>>> Assuming that's the case, I would strongly prefer this be handled in the
>>> paranoid path.  NMIs are unblocked immediately on VMX VM-Exit, which means
>>> using the MSR load lists in the VMCS, and I hate those with a vengeance.
>>>
>>> Perf overhead on VMX would be 8-10% for VM-Exits that would normally stay
>>> in KVM's run loop, e.g. ~125 cycles for the WMRSR, ~1300-1500 cycles to
>>> handle the most common VM-Exits.  It'd be even higher overhead for the
>>> VMX preemption timer, which is handled without even enabling IRQs and is
>>> a hot path as it's used to emulate the TSC deadline timer for the guest.
>>
>> I'm fine with that -- let's get rid of RDPID unconditionally in the
>> paranoid path.  Want to send a patch that also adds as comment
>> explaining why we're not using RDPID?
> 
> Sure, though I won't object if Tom beats me to the punch :-)

I can do it, but won't be able to get to it until sometime tomorrow.

Thanks,
Tom

> 
