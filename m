Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A945C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5D6120757
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XViIvWpR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgEAOQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 10:16:42 -0400
Received: from mail-bn8nam11on2060.outbound.protection.outlook.com ([40.107.236.60]:6174
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728887AbgEAOQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 10:16:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gm8pkG6ptP4t4GuKeTJ6gNBqtt15OSfxejSIYSkPXVVml1z/6WkURLPMLWyt6gtYOFMmWCmxGCuGSgiDBwmy+UuyIU+RwFTVMwSmf4jteCPymQrVLdmCpQnlU0m/n2M4MPNoCgsmQdJeP4HyeoiMjTD0dyhytdSXuzh43+oj4BE6KkNoCV9EMJ7t/sKCvLFvt43lu08m+Ble7Hsi7rlvarCMSEf6E1Sfma8tUUv4105w+UFD0Y0ygOXvTc2Dz5IT2cYZxdd6zYrdW/zljEPWs73iiY4YzAl7n/fffOsvn8AFO8qhZG6A7bmKDovPuy8G9gKT6hU5aDujCqCFEP2Rjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMkiPUEkzun4w20OVj7d5boWW5NzfaTjuTvIoFp+Bb8=;
 b=InH9WNSsnMMXr0ksYwRwwIuJy6WZgWPbeabdpJSTgOTewVzjobJ1txKh2SPv/OnbXxHQNkIOWxEEUADGg8+apghXxiqy0R3LWkXZex/hjSNRY2n02ziwANc7NN54kWoCiylKrKA8boLK79rcMsVq3UF39Qz4DakqPL4ayp1JzgnqpMWN5WL7FjBXnGLbEJsmFsORq1cqRnf5l0Epz0AjYLOEAU9tDsYS2bRbyE1AiZpDvxRbOxGuEWD1tN67jXAooAXR6d80USS8/UgF6zv2MtRYnOfWZYtIRspyIo8459FSSR9zNKVMqwZzWIjmg7LCEm9JRISoiSBTDpUD/FOOMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMkiPUEkzun4w20OVj7d5boWW5NzfaTjuTvIoFp+Bb8=;
 b=XViIvWpRrF3Sl1zi8pD8E/lqf44SJLJrX2bIySUHWKK/njBKYh4TFJTSfwxy68J1xDFrrmzJjpQO59f081tVjAlRbg2ckbD0KJX8WPs49S6XSh9iNybJT2iXxg1s8VOmjVk3RmQZDvJzEltv6RCy09aLm6i3iPUQtv//iNqrGOg=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM5PR12MB1787.namprd12.prod.outlook.com (2603:10b6:3:113::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.22; Fri, 1 May 2020 14:16:37 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::4ce1:9947:9681:c8b1]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::4ce1:9947:9681:c8b1%10]) with mapi id 15.20.2937.028; Fri, 1 May 2020
 14:16:37 +0000
Subject: Re: [PATCH v4 1/6] arch/x86/kvm: Refactor l1d flush lifecycle
 management
To:     "Singh, Balbir" <sblbir@amazon.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "keescook@chromium.org" <keescook@chromium.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>
References: <20200423140125.7332-1-sblbir@amazon.com>
 <20200423140125.7332-2-sblbir@amazon.com>
 <c45c0539-dd48-0e6c-5bb4-22d905b778aa@amd.com>
 <dc40ceb1e6ff29f90b2579deba5ad107fe1fe905.camel@amazon.com>
 <c6a8fa86551357005a6421159ba628049eade129.camel@amazon.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <2cf3ae4b-b623-1489-0700-20ac3c24d5a1@amd.com>
Date:   Fri, 1 May 2020 09:16:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <c6a8fa86551357005a6421159ba628049eade129.camel@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0201CA0012.namprd02.prod.outlook.com
 (2603:10b6:803:2b::22) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SN4PR0201CA0012.namprd02.prod.outlook.com (2603:10b6:803:2b::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Fri, 1 May 2020 14:16:37 +0000
X-Originating-IP: [67.79.209.213]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4c0ae6d8-46be-4f8d-8502-08d7edda42d4
X-MS-TrafficTypeDiagnostic: DM5PR12MB1787:
X-Microsoft-Antispam-PRVS: <DM5PR12MB178792EDE3ED54BFA0C1EFA9ECAB0@DM5PR12MB1787.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0390DB4BDA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(66556008)(316002)(8676002)(66946007)(8936002)(16526019)(6486002)(31686004)(2616005)(956004)(86362001)(54906003)(6512007)(4326008)(31696002)(186003)(66476007)(52116002)(26005)(110136005)(53546011)(2906002)(478600001)(6506007)(36756003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pNKpSpVWB4wyfmjoSxelJh70jlZiWo8DqH+GZxRL7wpWH6sdhf6PFwYEZo9siMP7liA7AouC/NBGfHcjj/6kcBUQTNLkIxHjMCvbCTIFbVs9XjqhAM3rThQjFR+1yWbtZwMQbKJDu8zlVR/0fQ8MkK/I56umEpi8wkWqvDdBVyrK2Xe7uoWxU6ELWguE+iBNZMEioa4HG0yfmotVUwuxa2pZcjOXzmDYX924A9BMoEGLD09daKm4Wnu1ciofR3nyhGnegxyjj95WxDG2VMAKGwlgGzN0saHX82sx1Smo62ko++CXiZb7A3CJj8J1MDufgQpRkYDwjmptiW2PDRnshWVdboz20CDD5iwdu7jRieiKOIRrllw82HZLn/kooZrVXeE4XYjYpY4/3Y+0Ssf4VCjfBPROKCfXjGYGpSNyLpqkq5CCpYfIGhRqSktsBajj
X-MS-Exchange-AntiSpam-MessageData: FtqWaguHT+YDbdPZuoLFxdBcmudZ3xbut8gU/FKbd6RycWl4BUUmPxJGOdb8j0MzaPINFuBS0UXfV3QLBu2h1t3UjJWEIzvIn4I2yDuHFu47u9HZpCzZatYvDx8qrRYauHINRB7ETzPUBLQUp+eSQGqNDKlP8BJFSJ+nRdT60HOT5f5aF2a4aRPa7IN/G43mDtFbdvBTq4yqgrrwGCbLKaJtq5KP0wOcoX0MgsXKNI050rqWwqP5wsvTjFzVL4KhRA9gu5Pmakwd7vda9xZKlJnUe74Al0MtvlVId5AC7+phlv7barR2WEBZ4zW4IZCe+KnRpxaWkyEJZmw+WrFV9aLOvpN9r72AMwK+f8egFzjuo0wSSX344UPGpKMoTPRdGb8I4Ba44WkNOFMn0Ky2RVOhlXFVROV6xbC0PODcXemuQeX40WEuOLqzxYknsnIA8thvnI20ee6KCOhb1LVFpf89tMtCQRuU/gOXrXa3+N1QkfApuuGyacfHxDyM2MC8oFwlqEoJElERMCRGmtWvHoHAUE8gvjfY+JgQZhOISTG2eXURps8eesBHu8P1p9yvVjuVvkiPnagICmlEoOFIzgAe/T7eX+oO5Xil89VEKwERe5hH49lk78YYsJxaE8PvXpjNCT4rGGXo6SwULYo++Hw0u96soiAHl9wFezjRvXEOufN79MeBrFru2Ffop0Kqq3i0o65gFsL+bkDmawI3darVlewj9U5DkIzlhGtczt/St2hQ1f5Ds69bkhSoQAxGUwiuVccAyWgJFo04BEqqkkNIO8PwTOqCIQpUgMZ/tdw=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0ae6d8-46be-4f8d-8502-08d7edda42d4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2020 14:16:37.8310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUQy1HUaRSS9hoFRh6iAAXF+1Qa2y/r6lQ8iuhLVkyWkNd5kU+2S0MfUgUYVVRjDe3mcZIoJCQ/bpe1z/K2qVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1787
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/30/20 10:48 PM, Singh, Balbir wrote:
> On Sat, 2020-04-25 at 11:49 +1000, Balbir Singh wrote:
>> On Fri, 2020-04-24 at 13:59 -0500, Tom Lendacky wrote:
>>>
>>> On 4/23/20 9:01 AM, Balbir Singh wrote:
>>>> Split out the allocation and free routines to be used in a follow
>>>> up set of patches (to reuse for L1D flushing).
>>>>
>>>> Signed-off-by: Balbir Singh <sblbir@amazon.com>
>>>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>>> ---
>>>>    arch/x86/include/asm/cacheflush.h |  3 +++
>>>>    arch/x86/kernel/Makefile          |  1 +
>>>>    arch/x86/kernel/l1d_flush.c       | 36 +++++++++++++++++++++++++++++++
>>>>    arch/x86/kvm/vmx/vmx.c            | 25 +++------------------
>>>>    4 files changed, 43 insertions(+), 22 deletions(-)
>>>>    create mode 100644 arch/x86/kernel/l1d_flush.c
>>>>
>>>> diff --git a/arch/x86/include/asm/cacheflush.h
>>>> b/arch/x86/include/asm/cacheflush.h
>>>> index 63feaf2a5f93..bac56fcd9790 100644
>>>> --- a/arch/x86/include/asm/cacheflush.h
>>>> +++ b/arch/x86/include/asm/cacheflush.h
>>>> @@ -6,6 +6,9 @@
>>>>    #include <asm-generic/cacheflush.h>
>>>>    #include <asm/special_insns.h>
>>>>
>>>> +#define L1D_CACHE_ORDER 4
>>>
>>> Since this is becoming a generic function now, shouldn't this value be
>>> based on the actual L1D cache size? Is this value based on a 32KB data
>>> cache and the idea is to write twice the size of the cache to be sure that
>>> every entry has been replaced - with the second 32KB to catch the odd line
>>> that might not have been pulled in?
>>>
>>
>> Currently the only users are VMX L1TF and optional prctl(). It should be
>> based
>> on actual L1D cache size, I checked a little bit and the largest L1D cache
>> size across various x86 bits is 64K. so there are three options here:
>>
>> 1. We refactor the code, we would need to save the L1D cache size and use
>> cpu_dev callbacks for L1D flush
>> 2. We can make the current code depend on L1D_FLUSH MSR and enable it only
>> when that feature is available. There would be no software fallback. Then
>> follow it up with #1
>> 3. We keep the code as is on the assumption that all of L1D <= 64K across
>> the
>> current platforms and we do #1 in a followup (since the prctl is optional
>> and
>> the only other user is the VMX code).
>>
>> Thanks for the review,
>> Balbir Singh.
>>
> 
> Tom,
> 
> I have the following changes that I think will suffice for now (these are not
> properly formatted, but you get the idea)
> 
> diff --git a/arch/x86/kernel/l1d_flush.c b/arch/x86/kernel/l1d_flush.c
> index a754b6c288a9..7fec0cc8f85c 100644
> --- a/arch/x86/kernel/l1d_flush.c
> +++ b/arch/x86/kernel/l1d_flush.c
> @@ -92,6 +92,9 @@ int l1d_flush_init_once(void)
>   {
>          int ret = 0;
>   
> +       if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
> +               return -ENOTSUPP;
> +
>          if (static_cpu_has(X86_FEATURE_FLUSH_L1D) || l1d_flush_pages)
>                  return ret;
> 
> 
> Does that satisfy your comments about patch 1/6 and 2/6 in the series?

Yes, that works.

Thanks,
Tom

> 
> Balbir Singh.
> 
