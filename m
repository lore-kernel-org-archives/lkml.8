Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D04C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 01:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C06942075E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 01:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="FLExr5SZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgEGBKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 21:10:14 -0400
Received: from mail-mw2nam12on2078.outbound.protection.outlook.com ([40.107.244.78]:14817
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727929AbgEGBKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 21:10:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hggEtu2nO2YJvNO8mZewwzK901Vf5VIuQSAamNQO5qB8h4YGKQESIlZl/HY/oZj00AWNr70QhRf7+h9ub/5W/IuwIZ9Lq6ruvLWysmcQAEgXJeSpwSvdpHr50zqZc7gQir4b6OtExsqOw1xr5zC1x/j5lkheIxa212kKpbA3hduH9xlgK9jUHR1diP5gSp8cv2bD3yzID0douKHfYR/Gkuy1la6A+Hy6BjsNrbFAeaMTBIZVwaBb4qqYOQVsiIKDKm/ppcbm06DlknL6Zi08pgOc7WjI3StAFTfuWZH6xiMNIzwvQAspXuiK+5hN5CL05Fct9EHdvIeR4hLE4nRfag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4r3VtdGGq/6cq/fWGGHMvy7DeN6Pz/6KUYk1Yepdza4=;
 b=b9t/W5VIPel1xKUZ3e7Cx9Norhk4Ybanag9Xi8n24uZHmhN/LQwKmXtGxTsXobPacg+kBjk+QQDczByStJIdnxTXlz/tvuSqFjXeIeT+Fmyxb0fcbm/ywm8nl7fFJO6AhRqYBU0L7iQxpmDdY1z3X4CKv32/z5A5jlAGBuzZySV69/A8etkT8isK710l4djYxeppZpLc5XlVStXJ8cASW1q+9tF/i38y/nMOgdZRb/HPukBU4dYNtsbdV3FtZ6hzNWD/OyoXCj6hHolPGcI6LPywjzgIYqAdcELzMlIjBUPe4mtrPpQZ98iJJu6CGuJTfk4WlntKd5fLY2AT+As7kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4r3VtdGGq/6cq/fWGGHMvy7DeN6Pz/6KUYk1Yepdza4=;
 b=FLExr5SZBbqGdZ/LQx/NnKjq+V0qxVEpDzPRfQEMv6FBfMrP+bhvsDbCEg4PZ4aHVim+JhlaWsFeThm8Bg9I3x+eeaHyRozfgOSlSnbBK93lGNOUw9gOis3speBDPMmw1lbClTcsrXfNyvF4XB9oZ5NlvFFrJqfXaZfpG3QEwCA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from MN2PR11MB4224.namprd11.prod.outlook.com (2603:10b6:208:18f::10)
 by MN2PR11MB3757.namprd11.prod.outlook.com (2603:10b6:208:f3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Thu, 7 May
 2020 01:10:10 +0000
Received: from MN2PR11MB4224.namprd11.prod.outlook.com
 ([fe80::71ff:7131:80d7:7e10]) by MN2PR11MB4224.namprd11.prod.outlook.com
 ([fe80::71ff:7131:80d7:7e10%4]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 01:10:10 +0000
Subject: Re: [PATCH] perf: perf can not parser the backtrace of app in the
 32bit system and 64bit kernel.
From:   Jiping Ma <Jiping.Ma2@windriver.com>
To:     will.deacon@arm.com, mark.rutland@arm.com, catalin.marinas@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1588132911-64901-1-git-send-email-jiping.ma2@windriver.com>
 <32a473bb-2760-b967-5d54-a22677b8018d@windriver.com>
Message-ID: <3d84c09b-5072-0908-5df7-b1f6d19ed110@windriver.com>
Date:   Thu, 7 May 2020 09:10:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
In-Reply-To: <32a473bb-2760-b967-5d54-a22677b8018d@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: HK2PR02CA0218.apcprd02.prod.outlook.com
 (2603:1096:201:20::30) To MN2PR11MB4224.namprd11.prod.outlook.com
 (2603:10b6:208:18f::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.195] (60.247.85.82) by HK2PR02CA0218.apcprd02.prod.outlook.com (2603:1096:201:20::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28 via Frontend Transport; Thu, 7 May 2020 01:10:08 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3519c84f-16b6-4c15-118e-08d7f223638e
X-MS-TrafficTypeDiagnostic: MN2PR11MB3757:
X-Microsoft-Antispam-PRVS: <MN2PR11MB3757ADE7E693F0BDDE4CAA73D8A50@MN2PR11MB3757.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: br8A5qiNuhUdiU7XfCDvddJvMTcduuQqXbL9YujhmDuZ5rZmFWPuJG0O0bqJRETgESsc0tdClwb/wJEngZ6BodI64BqPDZF9QeyH+mGJr8jrfWA0xVa8e/2opsME4VWjXHSfOeRbmz1pmO2KE+akiQ6kIWTKbUzo9BpxCA4C6VRE12f4VDJ0xg8VmPLReYtN0ijPIWhmQ0TYjZkAtA8ShdfnEjmGb5v1MQzjehOl+Y+X6jR7IO+wZBdXuU2OCg+HgealKHhVXeL7l0vivgXHndb4Yy/6+WA7kJhuDgP2jHRha6yDDjsPgkCWrS4RuTM/PC3C2UlSa3SmvnGw7BAgsnqXDyzxH2z1wk7NdCUAAvMKIIXN8CCnQaViorgi17N12pxU0wxUWSkR5wspor/Tk91xtiyk8KGM6+RCH/hVazOSKEeUK6lounSjxh/eF55p3gWJmePE9XVM3Szjd9T2/mkyNWGbJfo4Rt87i57dOQwoJ9H03GGVGZBgZ9EUoMYmGcYrfDj71MM2W2yvdNk/LvNscmjLvrg2ZfGDRnwi/3XYi10FsoEXtxHEClQPsd+n206AF44KBpE6f6VafcuW81YLpqDNgW4sEDn48NxonitQHgbTuaZxIHF86dBlgUsC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4224.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39850400004)(346002)(376002)(136003)(366004)(33430700001)(52116002)(316002)(16576012)(956004)(31696002)(8676002)(16526019)(6706004)(31686004)(33440700001)(86362001)(4326008)(5660300002)(2616005)(26005)(186003)(8936002)(66556008)(2906002)(66476007)(6666004)(478600001)(66946007)(36756003)(6486002)(53546011)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: gL6NPRIvYUK12Euj+p3zeXjD/baPdcEVfQMp/wat/D+aJcR0hZJoYWTa47cKlEtV8nb0bMmho6kwdeA3NAY8puCdouKWCzv8/8z7eQkMNlQQo57UPwUdJq/V1GmsO6tG+O+KiquBqtogpH0V/58ljCO9NY1s54iqUTZ5AULU0x7qss3oTcTCpHGkm4BMHAfMULDSj40hcFIboEXw+Qd98w1uw6eD8vXyxwSlV1usEDhFvBgWOevdJJR0ZF/IoNy/UMcvYxBHlct49Ic7EGLO6f/EFF0BNP0L/hyoxS9y5wa3LCrtyILXOP+6bQj23BVsvr4QbEYQBaqJohdJgogxD3Or2gIAULeuWY1JNVU5p1die+Vu8UysQ0FXMfO5sojq5eE+1BhJFsv4JKIIJUJzrX+6WmMsbk8ePABeK1zsnX2deAmodd3zEhowATYYj40u6fEpuTyv8xEMwc/lfpOHppO9hXiCIyPgvK+A3XP5Xl2Fr0rvo8OOad586olu3ULc3Dmy46Ulk4HnDpNtYmu5Q/ORUG5vRow9faMiic02rTlRmaM9aViyobuMl0zZMJMcPgvgzpl6Mu3Mt+7M3ZEgbd4Ah/KlsYbcc6eVT8hXsUaA9RaYU+sKV2WvgsxEGlMwBL1Au1SkjAd2bD2cWhYaaZulAEF5h13XH+Ep1IV8PnkHqDsvNm0+DePsKdlEDSNnJA4nVr2RKd5EDirDHO7AXa+OvN9vzW1ybvfaE/s/URIQXB0NSlPPRr1GSMwqEfeyzRp4gEdND4ZNjVOT6iYL+2ycrNTM5feJKNSuj02IplU=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3519c84f-16b6-4c15-118e-08d7f223638e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 01:10:10.7264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Sys52l2pM6olPfJJFmYMwBbeYBsh/2wyX1xPd3sk3zFtKD90AXJNMeHhHg5Q4YUrl9KWWCYHQC0I0NdBvGzYLx9hUebVSkKfpFit+8URCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3757
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Will

Please help to review the patch.

Thanks,
Jiping

On 04/29/2020 12:51 PM, Jiping Ma wrote:
> We test it as the following steps.
> # gcc -g -mthumb -gdwarf -o test test.c
> # export CALLGRAPH=dwarf
> #(./perftest ./test profiling 1; cd ./profiling/; perf script)
>
> Thanks,
> Jiping
>
> On 04/29/2020 12:01 PM, Jiping Ma wrote:
>> Record PC value from regs[15], it should be regs[32], which cause perf
>> parser the backtrace failed.
>>
>> Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
>> ---
>>   arch/arm64/kernel/perf_regs.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/perf_regs.c 
>> b/arch/arm64/kernel/perf_regs.c
>> index 0bbac61..04088e6 100644
>> --- a/arch/arm64/kernel/perf_regs.c
>> +++ b/arch/arm64/kernel/perf_regs.c
>> @@ -32,6 +32,10 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
>>       if ((u32)idx == PERF_REG_ARM64_PC)
>>           return regs->pc;
>>   +    if (perf_reg_abi(current) == PERF_SAMPLE_REGS_ABI_32
>> +        && idx == 15)
>> +        return regs->regs[PERF_REG_ARM64_PC];
>> +
>>       return regs->regs[idx];
>>   }
>

