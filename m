Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF31C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 19:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39E212075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 19:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="E1lE2T48"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgHTTF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 15:05:26 -0400
Received: from mail-eopbgr760047.outbound.protection.outlook.com ([40.107.76.47]:17734
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727833AbgHTTFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 15:05:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blLa2R+W0qEUNUwHv5d9RZIHb1tsbtRN4sK3pae1BSz7eBT3QJQdW9hBcBGmOyl3hZT3LLZ7HoT4ViUBV/J+HPmEQKBbMN/IX9SDpbIlNe/Rj6VwyMhTp6hTwUQts4kdBQPK1hufkw9xTNCqXsed72SnZQgR9QlO6RBg5L4Nvg849JA1/jfP8bva5E9j4aXn3W6L3p/gLQxyDCrk9zMyR/tngx9O7up9xV3VHHFwQonAaI7Xinp8+/1A40tiJUOw1eA+cbe7a7Te1f6gfZrwJ5gYDo2nHXXBeRKOcu5O6D67jQfP+NsYFQb+fhZnKLhblsv3nTy8qkSE7aiUAomRxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xar6asnS+zcXajgEfcDSPCFK/4WWBEKpgdm1pVRqPL0=;
 b=gbTIhYr4Q1uXNEKbH3+QzWwyLXErKm/GVlpXqBvK8oxWYEwEo8ayJL2/T8BYjVTTJQcbZ08XZjKCLADofxXMQP0A3sMH9Eqhhyv0uFz11BpMcpU8S1i7+6a/U7WrEsFvwptxw+c7XZriJxgN6iXbC8uT3nUmbKjWiG/aSdYuY/BbNfiILRe88PxmRW/01Z69g4BJCIwH1JrmQZbX02xd6tOQJyhugaNVAt8HrgTgBuxWuV6b8cIHcWsiIFY+sNsnUpuVmQA6e/8iEpDamd97Ro2s+86tH+5OlzWgG7UiVDPvBi+8n+t6aL140kHfKFZkI71FpymkINAxCB6VunnqQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xar6asnS+zcXajgEfcDSPCFK/4WWBEKpgdm1pVRqPL0=;
 b=E1lE2T48UgZUn0ycHrcYgbDUpWfV5/J2cv0evNCUG3iWBfZ0ZWc/wSIJzPTR0nRqK0sZyQL4nGUfUc2eAd3NCKs6s1Fe9qPKh4c6GMBui9s4hubyJ3drPH0nodht1iikedlDF2K6Ni6wHhNxzeLbK4JVD5a2MIOYYVBnbJVmYyU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM5PR12MB1259.namprd12.prod.outlook.com (2603:10b6:3:75::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25; Thu, 20 Aug 2020 19:05:18 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346%3]) with mapi id 15.20.3305.026; Thu, 20 Aug 2020
 19:05:18 +0000
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
 <c4cc63b5-2861-5370-781f-5d664b6ffed5@amd.com>
Message-ID: <e8b3f80e-3c5a-7a03-97f9-75cbdbbb023c@amd.com>
Date:   Thu, 20 Aug 2020 14:05:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <c4cc63b5-2861-5370-781f-5d664b6ffed5@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0201CA0062.namprd02.prod.outlook.com
 (2603:10b6:803:20::24) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by SN4PR0201CA0062.namprd02.prod.outlook.com (2603:10b6:803:20::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Thu, 20 Aug 2020 19:05:17 +0000
X-Originating-IP: [67.79.209.213]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 97ddd89a-29a1-40f8-c178-08d8453bfa96
X-MS-TrafficTypeDiagnostic: DM5PR12MB1259:
X-Microsoft-Antispam-PRVS: <DM5PR12MB12599DC5E693AB470193CBC4EC5A0@DM5PR12MB1259.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g6a6iOMUzlF/yUBQ+IpazLm7+zAVPycH32r1qmezo7p2kibOW5SWP7ndZBmpxzcnvqESyxT8eVdpFgu9Q2YAwD7OatGeaEkOLybMLpntmeVlEuFM5CcWjyGheRdb+rWhX9MVBmW5JGb2Mf9AEodwzoys7yIo04iixzXPfgqEsw2jqR/Yu7awqpot0HH38chpYJGxFuT89upynQSGTqPsXd148oV+auhaavG3zSA5lZZjTLfAhKnNXpJX7hrFskRPWBg1aVHm86AdkXeMgiBXTmW8vdqCLYA2F33pt136OWoUtwZHUpmTTpL36bKEK+1+a65ETLaKFTgT5WUZ4Y0wMuZMMFfIJctRsSWGB2jV/KBs1GO5vc35dKpmwZKYr45KI4WiFwSqiUEwNSaBgqUWUttgdf1frBSsaJn3UAFme2o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(36756003)(8936002)(956004)(2616005)(66946007)(31686004)(54906003)(66476007)(16576012)(66556008)(186003)(316002)(83380400001)(5660300002)(26005)(86362001)(7416002)(8676002)(31696002)(110011004)(53546011)(4326008)(6916009)(6486002)(52116002)(2906002)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: XWsHeNH+VwwbcOzSF4gq3ltdCYRpJSuynM+QGtiBuWuKvq5BCpapgj9f8FUtNYmNwoS+L2yZcyUuTbFFI9PjgMH+kAhoEtAw4LMCzjdmGZHykJF81xhXmvK5Psf5Bpedb/uwRxtFU6vZI4Q3DMF29bXkJ1AnHrSZBdrlaWTZqDEUha2oIL+aK74F9MpIaQoAcdoDX2DMGnynJrmLyCLvoXa/kSLddxMHTJs4pVgmt2bxwZkwV9Sgxl15kYFDl8Ai3cyqaZI8vPJ+eCgcIQLDXOJ50LWbYwCG8pIsZHIjpV0UQJGHqSfGOl87uiUeKLSNXsrxnIYoNUQRPNlR/XYLpg9tifIfYfNt3EiKEcTvXCErjIel41rjl3l5gFsGed9whceGl2N9jNcz2u0F0TBtysQPrPHVZAeZ5/PvezZZYnxm4Gaze2kWftANj08VrtUFQZ/BQq2wMSopZUHxAB72za1Tmu9ZjU8xPJEDzp96z62hSJAi9mfHJ36ZoiaN97dLsOQc2WsPLMJmuccCbwizEKPXOZEWOjBdoeBzM3HyzXj/HHAgnOPdMhbsJGsgM04nME55SvcnxudV+oqVa9Inw9s6bHkTjeOpNGef3OwacUe4WfnC1f9aMkWy5lOJ2Ksm8JkrLOSSV3nUQL84Mlct8w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ddd89a-29a1-40f8-c178-08d8453bfa96
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 19:05:18.4525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ExxgQ3P9fUnzBPbMj60jA9tealnvlfoVany2WR6I1ukY2MD5NZxm6yj5P3r7h9209z1MWLmhzx9QeVQZeejmcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1259
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/20/20 2:04 PM, Tom Lendacky wrote:
> On 8/20/20 1:41 PM, Tom Lendacky wrote:
>> On 8/20/20 1:39 PM, Jim Mattson wrote:
>>> On Thu, Aug 20, 2020 at 11:38 AM Jim Mattson <jmattson@google.com> wrote:
>>>>
>>>> On Thu, Aug 20, 2020 at 11:34 AM Tom Lendacky 
>>>> <thomas.lendacky@amd.com> wrote:
>>>>>
>>>>>
>>>>> Bisecting with unsafe_fsgsbase identified:
>>>>>
>>>>> c82965f9e530 ("x86/entry/64: Handle FSGSBASE enabled paranoid 
>>>>> entry/exit")
>>>>>
>>>>> But I'm thinking that could be because it starts using GET_PERCPU_BASE,
>>>>> which on Rome would use RDPID. So is SVM restoring TSC_AUX_MSR too late?
>>>>> That would explain why I don't see the issue on Naples, which doesn't
>>>>> support RDPID.
>>>>
>>>> It looks to me like SVM loads the guest TSC_AUX from vcpu_load to
>>>> vcpu_put, with this comment:
>>>>
>>>> /* This assumes that the kernel never uses MSR_TSC_AUX */
>>>> if (static_cpu_has(X86_FEATURE_RDTSCP))
>>>>          wrmsrl(MSR_TSC_AUX, svm->tsc_aux);
>>>
>>> Correction: It never restores TSC_AUX, AFAICT.
>>
>> It does, it's in the host_save_user_msrs array.
> 
> I added a quick hack to save TSC_AUX to a new variable in the SVM struct 
> and then restore it right after VMEXIT (just after where GS is restored in 
> svm_vcpu_enter_exit()) and my guest is no longer crashing.

Sorry, I mean my host is no longer crashing.

Thanks,
Tom

> 
> Thanks,
> Tom
> 
>>
>> Thanks,
>> Tom
>>
>>>
