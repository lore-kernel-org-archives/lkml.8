Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899D8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 19:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 637A02087D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 19:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hBNkqa/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgHTTEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 15:04:48 -0400
Received: from mail-eopbgr760058.outbound.protection.outlook.com ([40.107.76.58]:2044
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725819AbgHTTEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 15:04:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQxmdM23O7Y8+tRu+hxGXEy2GIJuUV2HAG9q4JJgyZW89HG6CAsiFmWBkKyQUWclrWKsp/bvPC6gYefvLNuO33CPqozgmW+4oX23xS2znvb1pBH62m9mvWfdooYJTJr8t8avmIaIsDTDEJF1bALcB2hkit1xmm/gZjUMUU6BwkY3ymUQzmN2rP07EjZcgSJj+eQHHfi4xsw6wumyKmps4FyJeOc6X3P0eSKmeEzPFMN1rcXCkciq9b6LF9sQoHVDd/DY2LL9edCG7t2eMkoEQZDw7CnLr3NEzodHyt3eLBXRfm4nS7+jIHQWCCmzmP9+xDD1AGbhsGGZum3yZ4CeBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJKqiACWbYIbJygdkWXo/QqaPnEU6xvMQ0IE9eqKDGQ=;
 b=fmQZGKIhVf5VVjuCXc2wyu3OANWvEM34wnCzIzhpRN5VZZPAvRWJZ951oiJ9R75k/dutkZvINIEXJdjGaadSmqJuzsy6niwd1xQ9TYvxQ/TZvxSL9OXJHPNtIJ9NMCGXIAw1QYxJBEVQ2GFfJyA+0HFLNJ5c+R+2QMLPvavHqRltclSCSNfhDPZL6iA6Xq6VMMXIOcAfKMdZuWKPccQQfYEW+3WQr01NrOntkeG9Tb8qpud8LyubdUQ7oZ2UoxPifh181KcHps7G5jdlODtKA862B+I1P3QFXC93qwZmfM3sUZpUPbF31d36Di4O7+ZfL0oA0Hf5fUi2izfhXQdTuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJKqiACWbYIbJygdkWXo/QqaPnEU6xvMQ0IE9eqKDGQ=;
 b=hBNkqa/n03E5gRvMsqn9Bum3lpTPX1Hf/9ofnyTlNLgD+Xl8Cn2qufdPqJBkJhCGTzVDehn+9Ije6ZHXei76963Opz5VcLxA1ps4+4CuK0iyRf6TO4Aju4SWbThMaNwV52F1YCFQIj/czTfH8YI80wLwnrU45us7VHz3b5hXl8k=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM5PR12MB1259.namprd12.prod.outlook.com (2603:10b6:3:75::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25; Thu, 20 Aug 2020 19:04:44 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346%3]) with mapi id 15.20.3305.026; Thu, 20 Aug 2020
 19:04:44 +0000
Subject: Re: FSGSBASE causing panic on 5.9-rc1
From:   Tom Lendacky <thomas.lendacky@amd.com>
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
 <50e7c7f6-d212-4e90-09b7-2c568087084e@amd.com>
Message-ID: <c4cc63b5-2861-5370-781f-5d664b6ffed5@amd.com>
Date:   Thu, 20 Aug 2020 14:04:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <50e7c7f6-d212-4e90-09b7-2c568087084e@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0201CA0056.namprd02.prod.outlook.com
 (2603:10b6:803:20::18) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by SN4PR0201CA0056.namprd02.prod.outlook.com (2603:10b6:803:20::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 19:04:42 +0000
X-Originating-IP: [67.79.209.213]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7e17d05f-e353-4bbb-ed3f-08d8453be60a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1259:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1259FDB41A43CCC5CAC8F4C6EC5A0@DM5PR12MB1259.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oux8Q+VzeF2mNWoxQtUYT4WRKoSceSq8yECyLE2uIR+D6Hvky/R+qejsr20dP1jtvdjf9XDhZZjhPmISbfWLUcg02sCQvXkMhhYAOGKwdqCt2rf0U2cdaWfyJ/t9M2m7BVQiBK/iMD1KoRJu9yLCkfMwJcw+NRZ+ax8RyPy8sFlzcCfvgKiAzVEkAKNH2c255QqOM0ho/hcx7EtwtW2Wb6Ju0Cjxg57ougwwsnNei/EUOIprxMo+v72cvjYKeB4CM3GZyCWQp/de5qmyNOg3BsjI/ceHMjVNiiJFpDSMzT2gpQ4nN0NSuE5xZLArljUBQLJHzFc5mM0ygpAUdya7YZJa7KvMeMBPXu3my13ZxQ5ccqW8Og6LDH6T0nzJiX+VYaalOC92D4TzFRo+fpES88new/n/1lxXuZNCZUDQ5/8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(31696002)(110011004)(7416002)(8676002)(86362001)(316002)(83380400001)(186003)(26005)(5660300002)(52116002)(6486002)(478600001)(2906002)(53546011)(4326008)(6916009)(2616005)(956004)(66946007)(36756003)(8936002)(16576012)(66556008)(31686004)(66476007)(54906003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: r0+Vn2CaasLq5H9FjoE1k40oqT89Va/8kMNLxMH2bccS5ieK32NVN14QIepRbpPZq2hwpdku6T40beoxmgNip0HeZeVhSSHhpKyM16iOwpgsc6mBLx6m46PS/H1y29Fa5ZhW2yNTc3xFJRgG5Y7KTWfgulYFP1IirjYV9ZOPbvr/ee4HgPtD79g3LRBlEr+cQ/p4ji8z9uKEZKmmpZJLZ3bryCkaMJ3C88vmOuWjxTQXX9W2MDvTdKrGnpqcjeeNunhn98JacPqTEhbiScYsm93GHRzsa6k3aoRZlxcCxjtBlHFXFNIFWeznnqa5bXhA4uSjshcKZCqxeT1DCTOC+JitWIzZ/smnMPtVRJJBQedboU0CK7yHvVlzO9a/jypYRHXviI7N+obvPb07pGmODqBqmjDIxTag3nY6VhSnLtwIAXYBam8jPZasIx5Qhm52bfUnkBJYLe/IYLkvfdVXsu9mrBozca8Z1BLbTemvcG5sqyyJ7nVbpgEV2z9qfdFcm80AN3hRMWiuTMl4w6hIAxVz7by+LuXHhajq4LtiPVB4FKyk/7/3aF7ohUZk/7gnm9/8peu52V0NvmysxyHGfMlwSyCkcctGFlBjyt5QkQmoCYvkOWYNFKHU4gZMy6EOPZ1q+ri6T1U8wnkgfbJxMA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e17d05f-e353-4bbb-ed3f-08d8453be60a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 19:04:43.9227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCJWsxnyU21sRmusC4GhYZdCJqBpyx2B7JMdeunAlXxz+OICnlGEUbbi1IhYa1kkpToAj1NjfrTrgiy2Ww3szQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1259
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/20 1:41 PM, Tom Lendacky wrote:
> On 8/20/20 1:39 PM, Jim Mattson wrote:
>> On Thu, Aug 20, 2020 at 11:38 AM Jim Mattson <jmattson@google.com> wrote:
>>>
>>> On Thu, Aug 20, 2020 at 11:34 AM Tom Lendacky <thomas.lendacky@amd.com> 
>>> wrote:
>>>>
>>>>
>>>> Bisecting with unsafe_fsgsbase identified:
>>>>
>>>> c82965f9e530 ("x86/entry/64: Handle FSGSBASE enabled paranoid 
>>>> entry/exit")
>>>>
>>>> But I'm thinking that could be because it starts using GET_PERCPU_BASE,
>>>> which on Rome would use RDPID. So is SVM restoring TSC_AUX_MSR too late?
>>>> That would explain why I don't see the issue on Naples, which doesn't
>>>> support RDPID.
>>>
>>> It looks to me like SVM loads the guest TSC_AUX from vcpu_load to
>>> vcpu_put, with this comment:
>>>
>>> /* This assumes that the kernel never uses MSR_TSC_AUX */
>>> if (static_cpu_has(X86_FEATURE_RDTSCP))
>>>          wrmsrl(MSR_TSC_AUX, svm->tsc_aux);
>>
>> Correction: It never restores TSC_AUX, AFAICT.
> 
> It does, it's in the host_save_user_msrs array.

I added a quick hack to save TSC_AUX to a new variable in the SVM struct 
and then restore it right after VMEXIT (just after where GS is restored in 
svm_vcpu_enter_exit()) and my guest is no longer crashing.

Thanks,
Tom

> 
> Thanks,
> Tom
> 
>>
