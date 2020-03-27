Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC64C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 13:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185002082D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 13:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="cI9Tws62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgC0N0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 09:26:04 -0400
Received: from mail-vi1eur05on2115.outbound.protection.outlook.com ([40.107.21.115]:10816
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726758AbgC0N0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 09:26:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUbZCiU5hp1uTbEmLM6zhGVjasPlvrLBiWWeLw6nk1+LTz02eggAdbfCMSAx+RTdcgLyoD2aFYmeipvqe1BKwvsVXfoq1LAKcisqNc1NgMGD3fmonEd3mp4EO1G+I/KT5l2kXSB2oVUpiRr5yAYnYpwWZbSsVr6yHS8XsWIWUZasKyYXMzznT443oK6bwbJN6AJf3pEZVzNhU9Ix9qkOHsN+HWRsjGDV7c5s5fSY94uNyVyXltLyIUOE8z8Y8ppL8Y8ijs3F8p2jrHE0z7Oe8qhl8SyICge3yK93XQanKyco0TkJExViGhm11Dkq+s0vDQRnhlKqbtny3z+8RHUB7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOQrgOUh+wswO4kHSUDZ+SNQg0rWdGyzE/ZEO+qeK1s=;
 b=ZesZ2b7F03zOazbxaFhSyFoxpNwS5BhE0Wt+Frabxnz0J76OYf0p2FZA72bIGc+rnxwcViLscU8FGYDIABlnfgqj0Qb51S0OnriMklQHXuk+RjWi/6ItSWuiLflVJJ5C2GxIVB626WyDhTr1RlIqH0IyfaqfpEB6R42/hWik0yR9SIsygnFVPAlQFU+997Px5xPg5C2R4AATBFRYRYpk1bK++0dW5sEbLgUIXMXUu6LmaAUwbb75VC2Q4gFSvPzvU5nnEMeh9gmfEVn2HZY7zqIPMynvI6oXKv2ryJEPF10souvd3BRfXdRaeCdMy3jWOkzBsUT+Cyw8ZoMLqgLz2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOQrgOUh+wswO4kHSUDZ+SNQg0rWdGyzE/ZEO+qeK1s=;
 b=cI9Tws62YtZ4rGVbIgnKNlH+pFBn02fzKJW0m7gUduTjiQ5fj2mdRNUN6xHwj325Hr4jqB2aMi8LeyW6tkBsomOvQotcyCOul82jhuQTGwDvFNTyr43XXVSW7yn8HqZEaf66D4alnyWGhVJ0Ml4FRbdugCgOb5hSnKB8/8S7FT4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rasmus.villemoes@prevas.dk; 
Received: from VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM (20.178.126.85) by
 VI1PR10MB3168.EURPRD10.PROD.OUTLOOK.COM (52.133.245.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19; Fri, 27 Mar 2020 13:25:22 +0000
Received: from VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e58f:1097:b71d:32c7]) by VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e58f:1097:b71d:32c7%5]) with mapi id 15.20.2835.025; Fri, 27 Mar 2020
 13:25:22 +0000
Subject: Re: [RESEND][PATCH v3 14/17] static_call: Add static_cond_call()
To:     Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
References: <20200324135603.483964896@infradead.org>
 <20200324142246.127013582@infradead.org>
 <10ef25bf-87df-6917-1d50-c29ece442766@rasmusvillemoes.dk>
 <20200327100831.GT20713@hirez.programming.kicks-ass.net>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <e1d7797a-6794-92bc-925a-8129ac6c3f86@prevas.dk>
Date:   Fri, 27 Mar 2020 14:25:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200327100831.GT20713@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0601CA0033.eurprd06.prod.outlook.com
 (2603:10a6:203:68::19) To VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e1::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.149] (5.186.116.45) by AM5PR0601CA0033.eurprd06.prod.outlook.com (2603:10a6:203:68::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19 via Frontend Transport; Fri, 27 Mar 2020 13:25:21 +0000
X-Originating-IP: [5.186.116.45]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57a0abb0-86a9-438b-3a80-08d7d2524d4b
X-MS-TrafficTypeDiagnostic: VI1PR10MB3168:
X-Microsoft-Antispam-PRVS: <VI1PR10MB31686E9DBD1AC30DE1299FD093CC0@VI1PR10MB3168.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(136003)(396003)(376002)(39850400004)(346002)(366004)(16526019)(81156014)(186003)(8676002)(31696002)(86362001)(44832011)(7416002)(316002)(52116002)(6486002)(81166006)(36756003)(4326008)(31686004)(2906002)(956004)(478600001)(16576012)(8936002)(66476007)(66946007)(5660300002)(26005)(8976002)(66556008)(110136005)(2616005);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: prevas.dk does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1S0RQf1Vkbnv9pBAjnLzS7LViCweONFXN3ZFa4qKUo4GXS7fhnZikKzxqoqh2gLjW6E663HKqedjxHORpr1E9ujEQR/2Ol68AcsHs3ePFHF/zQyG079+Y65rcTyRCsRYcq0wbC63rPeTLZ546JKCXyuqLzCzqF2Tn7kOnYC/tFPM7d/Rzq7U7PsJBZwohiicnaKiq2t9dOtmoR6yxA+G44vNTmrsV66Jqgt6AKorVSrKFozZ22+/Eha/6dt3qViHtviKNTnaBYSy/XIPa+ZR2j0dMxVbKR+OJsg13cfjddoxFdo7Qij7kglktvta4IJWgF9i3Q4d/QWvoNVGbD9yUUZfJHzRkr5gDvrJxEm/419kK1X9Uasgvzmv9YjcdIqF1TLBgSqEDyTHpyjZHf6KmYeLThfFisMpzSvRW2cT4l12Ww5qXjje4XBfgFWW43ns
X-MS-Exchange-AntiSpam-MessageData: LmqeSELNORxVSbj8a7wcdL6AbDm7WWv/oZemY/R6BskNhNvAGrYc5wjRaIxq6I3xGF0S4cVvr0s1382mxNcC02pvLq7SGz3hfEhWepa6wu1p/c6+DG2GkLXz46bL7UxUAbFoXHR9KsEJ5maiEQx5xA==
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a0abb0-86a9-438b-3a80-08d7d2524d4b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 13:25:22.4690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZHufHVe5AbV1MfihyZ6+vPm7innzMqBUlqhmKICqZZhjYQl0qCM7/DnsUv+i3/UJ1SE0YvqBBp1qlHWI0w7YRq1oq8FlU/p2/+09VdJQ6Rw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2020 11.08, Peter Zijlstra wrote:
> On Fri, Mar 27, 2020 at 12:37:35AM +0100, Rasmus Villemoes wrote:
>> On 24/03/2020 14.56, Peter Zijlstra wrote:
>>> Extend the static_call infrastructure to optimize the following common
>>> pattern:
>>>
>>> 	if (func_ptr)
>>> 		func_ptr(args...)
>>>
>>
>>> +#define DEFINE_STATIC_COND_CALL(name, _func)				\
>>> +	DECLARE_STATIC_CALL(name, _func);				\
>>> +	struct static_call_key STATIC_CALL_NAME(name) = {		\
>>> +		.func = NULL,						\
>>> +	}
>>> +
>>>  #define static_call(name)						\
>>>  	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_NAME(name).func))
>>>  
>>> +#define static_cond_call(name)						\
>>> +	if (STATIC_CALL_NAME(name).func)				\
>>> +		((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_NAME(name).func))
>>> +
>>
>> What, apart from fear of being ridiculed by kernel folks, prevents the
>> compiler from reloading STATIC_CALL_NAME(name).func ? IOW, doesn't this
>> want a READ_ONCE somewhere?
> 
> Hurmph.. I suspect you're quite right, but at the same time I can't seem
> to write a macro that does that :/ Let me try harder.

Hm, yeah, essentially one wants some macro magic that turns

foo(a)(b, c, d)

into

bar(a, b, c, d)

and then bar() can do the right thing.

One option is to give up on the nice syntax and just make it

static_cond_call(func, ...)

But, here's another few things that makes me wonder if the cond_call
variant is worth it, at least in its current form: In the case where
!ARCH_HAVE_STATIC_CALL, so static_cond_call(foo)(a, b, c) is just syntax
sugar for

if (foo)
  foo(a, b, c)

gcc can choose to wait with computing the argument expressions a, b, c
until after the test - they may be somewhat expensive, but at the very
least there's some register shuffling to do to prepare for the call, and
probably also some restoring afterwards. In the ARCH_HAVE_STATIC_CALL
case, whether inline or not, it becomes an unconditional call from gcc's
perspective, so all the arguments must be computed and stuffed in the
right registers. That price may be higher than the load+test. Not to
mention the fact that side-effects in the arguments happen
unconditionally for ARCH_HAVE_STATIC_CALL but only if func is non-null
for !ARCH_HAVE_STATIC_CALL.

Perhaps associating a static_key with each STATIC_COND_CALL could solve
these. But that of course makes the update procedure somewhat more
complicated.

Rasmus
