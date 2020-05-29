Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE371C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 05:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A38B52100A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 05:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="BIQyHVj/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgE2F5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 01:57:20 -0400
Received: from mail-mw2nam10on2056.outbound.protection.outlook.com ([40.107.94.56]:6017
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725355AbgE2F5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 01:57:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmoBkzwpmR+t7Wgv6TeiY1OZLw3VrIWBFDK6rFW3yAIIJqFZVkgQm8gNLcEox9uncpAUdnnx7mC9zX8snU1SAhMA2eDqUW8XSn1hXg7GvfAB8YywUuKdFyN+zEixb2LuT33DE49Qr1URxffaJzpUZJIKbodfjLK9HhFibqZoPlIHc0TbfrFo5vmMAJ6rrDq/jhAv86988JMuqYwBJOn1K8djePhbOymGUMzLdb07Nse/yzEwZYapp66ZdtucOZvzKlNN3PYLF5rs53KP5r0WPp/ObuqV/+gaK1LaD2Kd6rg4hZOfaSKRKwUZvC7l3XoUAh1+pT3X2UFKaLwr2YyZAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DI3PzH7WGDvXK6XmJ83W6yx2iBhCrAgoVhy//stPaVs=;
 b=j9qB54DdJSFOuwPIZpLSnG4t7zX2TfEJZH0otzLW5cunAvcXuRjvmWDvBdkFrBIxcrpOmvTVpy9Rr8l3v1ZyGc2Ewa5Lh8lWgjcIiP6ijeocP/38kBR9odl9li+2g/3GtQ5NbRSKl8Q+EBLMDMt8Rf1XQ/xgHuvcYgfJ4O6ZN4jHj4ECNr1wZfV8jzZDKaKDnctesuMlwr2jS6NF8vnkjSad1vYvPSgVWyUkY88PM/TBpVl+pAHqsXnGjDgfAYA3Dn6hDMNvbvt5LJEp4DE0WkjQ7LbLFNS053QtGrHq4HJnqsguoc9n9rHPtE9RvfT1e7Qh+x2KgfvpQOXrWf4woQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DI3PzH7WGDvXK6XmJ83W6yx2iBhCrAgoVhy//stPaVs=;
 b=BIQyHVj/IqlDBevbPI72kOnwswpq9SQ6VvOf8wmoh7O+KxvZvzS/Ayby6az62HP4fSqbhWiANyJcu7//EKDEOfCP5M7fLEVbroYHrefvGngFVfylCCwWU6YgVX50jXpO/yN75UrFWnrHQbhcmaX1nc6njSrJ5TK2gZ+mz3Wuk2A=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB2747.namprd11.prod.outlook.com (2603:10b6:5:c6::22) by
 DM6PR11MB3756.namprd11.prod.outlook.com (2603:10b6:5:136::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Fri, 29 May 2020 05:57:16 +0000
Received: from DM6PR11MB2747.namprd11.prod.outlook.com
 ([fe80::ad7f:84a9:35bd:edf8]) by DM6PR11MB2747.namprd11.prod.outlook.com
 ([fe80::ad7f:84a9:35bd:edf8%4]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 05:57:16 +0000
Subject: Re: [PATCH][V3] arm64: perf: Get the wrong PC value in REGS_ABI_32
 mode
To:     Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, zhe.he@windriver.com,
        bruce.ashfield@gmail.com, yue.tao@windriver.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        paul.gortmaker@windriver.com, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org
References: <1589165527-188401-1-git-send-email-jiping.ma2@windriver.com>
 <20200526102611.GA1363@C02TD0UTHF1T.local>
 <1e57ec27-1d54-c7cd-5e5b-6c0cc47f9891@windriver.com>
 <20200527151928.GC59947@C02TD0UTHF1T.local>
 <cd66a2e4-c953-8b09-b775-d982bb1be47a@windriver.com>
 <20200528075418.GB22156@willie-the-truck>
From:   Jiping Ma <Jiping.Ma2@windriver.com>
Message-ID: <f870a6ad-c238-9f6b-f4ad-88fff948a4e5@windriver.com>
Date:   Fri, 29 May 2020 13:57:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
In-Reply-To: <20200528075418.GB22156@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HK2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:202:2e::21) To DM6PR11MB2747.namprd11.prod.outlook.com
 (2603:10b6:5:c6::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.195] (60.247.85.82) by HK2PR06CA0009.apcprd06.prod.outlook.com (2603:1096:202:2e::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18 via Frontend Transport; Fri, 29 May 2020 05:57:12 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9285f58a-8821-485b-b1b3-08d8039523e3
X-MS-TrafficTypeDiagnostic: DM6PR11MB3756:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB3756101297AAF21237452BEDD88F0@DM6PR11MB3756.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ssR5CaCsCtLD6iPfMrrO+Eq38NMS+CR5EGUdLQ6mfb8M3qsV7h7k94ajf4oRd+kAJFozsrsAHKkddkeBzBRL+Y63gYWxAd87kWR/0WApABRrPf1td+Yz+1noxTlvRnJilqhYWj9gcsJUDZnINLPg9T1JT7c76V0O65sqSKFkqcgdSU5FMC9EvsZ7Jl2gTQayzj6EO7K1wJE4E8VPWwjyWEOXBlnhOFLnEbcWid9NCgiMv0nYhGoaq4z+AtJeEVAXkl14INvDC6DCVXwcxP0IYMwDnVzX6JE4sBJ4kBxK2YiKZhkb7cZM9bJdIEeCVx4MA3Jxx/1eC7pQAS3ABcy2L3lQ8GvrpSj3/oiCoUbDrMDHvTaOz5s8KlcLTws5CazbJW9UaeRNrYWs4gP/wl8i737ywAB1KwH/SLFk9dDj9MvJ+z2sSKv0P7p8IQo4z191YBJIYd80wKVUMeJmENVS0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2747.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(376002)(346002)(136003)(39850400004)(4326008)(16576012)(186003)(2906002)(86362001)(478600001)(8936002)(36756003)(6486002)(6916009)(316002)(16526019)(6706004)(66476007)(31686004)(2616005)(66946007)(52116002)(66556008)(26005)(6666004)(31696002)(8676002)(53546011)(956004)(5660300002)(78286006)(15583001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: AQqwNREGuMNLtdiCiqmdsuRIb4uA96rOxcSZS0R0pu+QA7vcVA+0D/Gh6tARPsKFIPy1DsxJEna46FHMQWuMR6U3qHp9BPVm/PvmJ8Tmuq0NdSsskbOLYd0wUYY/x8/SBkw1bLxibJZ5byQgLA4x8p4OszDTPd/1h/OfYn6RKHFh7me3gt8Piaqz4CT26fJig+GniFSDXs7eGHdnvPZzhkzBsEBCIaKZ/Skfb+xuJYDrNrAk2/H706BFC8k8k8DJUkuaXlRVIRfpl7TXUpCwUR7EWxcU3mG0icyGWGIh017FKI5/cTBK8mYILJ/949OnptNu1vGttV3SGHB5iqkfnwaJK3nfONQv0ZnVtMtOrEEEunOkSCuPOyAvIexUIUVaKuWubYFg2EVglJR1UdkH+q96OtKggPFvPhuS7yTvfstbKvRtghPGj3u8uEryaSVtGFADBMhRBvl07/33BQKfDbw92MZnXf6tGY+8FKteOcc=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9285f58a-8821-485b-b1b3-08d8039523e3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 05:57:16.3648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVjr2kIoezV1HdCuxuK90av9/gJCK+AiJaulvD0INOOgKhKjgWQPUF2QEeHyU35lMliw0L7HoIUzUHVfCwBp3yXOAwV3B135xY16h27iUZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3756
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/28/2020 03:54 PM, Will Deacon wrote:
> On Thu, May 28, 2020 at 09:06:07AM +0800, Jiping Ma wrote:
>> On 05/27/2020 11:19 PM, Mark Rutland wrote:
>>> On Wed, May 27, 2020 at 09:33:00AM +0800, Jiping Ma wrote:
>>>> On 05/26/2020 06:26 PM, Mark Rutland wrote:
>>>>> On Mon, May 11, 2020 at 10:52:07AM +0800, Jiping Ma wrote:
>>>> This modification can not fix our issue,  we need
>>>> perf_reg_abi(current) == PERF_SAMPLE_REGS_ABI_32 to judge if it is 32-bit
>>>> task or not,
>>>> then return the correct PC value.
>>> I must be missing something here.
>>>
>>> The core code perf_reg_abi(task) is called with the task being sampled,
>>> and the regs are from the task being sampled. For a userspace sample for
>>> a compat task, compat_user_mode(regs) should be equivalent to the
>>> is_compat_thread(task_thread_info(task)) check.
>>>
>>> What am I missing?
>> This issue caused by PC value is not correct. regs are sampled in function
>> perf_output_sample_regs, that call perf_reg_value(regs, bit) to get PC
>> value.
>> PC value is regs[15] in perf_reg_value() function. it should be regs[32].
>>
>> perf_output_sample_regs(struct perf_output_handle *handle,
>>                          struct pt_regs *regs, u64 mask)
>> {
>>          int bit;
>>          DECLARE_BITMAP(_mask, 64);
>>
>>          bitmap_from_u64(_mask, mask);
>>          for_each_set_bit(bit, _mask, sizeof(mask) * BITS_PER_BYTE) {
>>                  u64 val;
>>
>>                  val = perf_reg_value(regs, bit);
>>                  perf_output_put(handle, val);
>>          }
>> }
> Yes, but Mark's point is that checking 'compat_user_mode(regs)' should be
> exactly the same as checking 'perf_reg_abi(current) == PERF_SAMPLE_REGS_ABI_32'.
> Are you saying that's not the case? If so, please can you provide an example
> of when they are different?
Yes, compat_user_mode(regs) is same with 'perf_reg_abi(current) == 
PERF_SAMPLE_REGS_ABI_32'.
I tested it.

Jiping
>
> Leaving that aside for a second, I also think it's reasonable to question
> whether this whole interface is busted or not. I looked at it last night but
> struggled to work out what it's supposed to do. Consider these three
> scenarios, all under an arm64 kernel:
>
>    1. 64-bit perf + 64-bit application being profiled
>    2. 64-bit perf + 32-bit application being profiled
>    3. 32-bit perf + 32-bit application being profiled
>
> It looks like the current code is a bodge to try to handle both (2) and
> (3) at the same time:
>
>    - In case (3), userspace only asks about registers 0-15
>    - In case (2), we fudge the higher registers so that 64-bit SP and LR
>      hold the 32-bit values as a bodge to allow a 64-bit dwarf unwinder
>      to unwind the stack
>
> So the idea behind the patch looks fine because case (3) is expecting the PC
> in register 15 and instead gets 0, but the temptation is to clean this up so
> that cases (2) and (3) report the same data to userspace (along the lines of
> Mark's patch), namely only the first 16 registers with the PC moved down. We
> can only do that if the unwinder is happy, which it might be if it only ever
> looks up dwarf register numbers based on the unwind tables in the binary.
> Somebody would need to dig into that. Otherwise, if it generates unconditional
> references to things like register 30 to grab the link register, then we're
> stuck with the bodge and need to special-case the PC.
>
> Thoughts?
>
> Will
>

