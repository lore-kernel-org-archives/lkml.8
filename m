Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FA0C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 21:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F9A52068E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 21:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="RQRm8VGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgEEVB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 17:01:28 -0400
Received: from mail-am6eur05on2138.outbound.protection.outlook.com ([40.107.22.138]:31841
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729011AbgEEVB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 17:01:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgeCLFfLbP90QPy9l43jQ1PDMDT/uWRHyKIHQmPBOPZEYXal8iJMMQTKkUFOV5/qB2QwkyXamDrdYYevsRuNEBhP1J+LbLTdvKv5Z15M9Tj1hbugQBSskAtGOM99lDQOGXRJbThqn3DJMiOBIz3vm3gXq60PLQHPvx6BgsnffYa30/uw4DU6W7N+AN/UR7IjOAbbgQFrwSNwPtXJ03ISnoACiWTV/440CK8n9WqaaO2o/nFN/TJqeN36ya6PuXd0cjkO0emE4Q+a7aroJy4GE+GeBww9CzABfod4c/jpIy2q35vx5+yNVMBcQlEPwSyrxRw0XXYg4TarrrJAB+IBBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUgyGKWvN7TT6GoRPQD/nbQkg45ryrDZoEEKiCH+Leg=;
 b=oSyyKflcExVxRJoZ9RkPa3Dm+Ha9eTbEfC1gNmHAfUTPorcy6EUJFICLsGIPqpI3U8nCIBhJAlSLcSVUV0EYeN1uF5mbvdWumg7AxOJ6JxbhquYu8EsAF1PsnwZiBNr4XHFDk73yEDVntbwd3k/lEL6wDzpBFoDc5mTsNZbfgjzMFEDtveQ40AtWmCQQDABgoav/wBZZuG3UIDDpOem+d9bpDZsiogjJ5RLV9f1jfWkDEUiERmoQYhXKNWkTRk/klK18ykvSXxnzU9iAt2YzfAzA32k8d5xVEObUNA0JR5ESfkKt4gQaLWQOM6JLHS8WpjI/+I5O+R9dkVCVTLIrWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUgyGKWvN7TT6GoRPQD/nbQkg45ryrDZoEEKiCH+Leg=;
 b=RQRm8VGZJwh4BN3ADWYFZhS4kGhkWq/bK5lx2+WNoogDoesMQ/3ijDyvtfVqGv4yEB2h4k0ntBvNTFRwoCnZJbMIWtV6zsSeq6bKsSCnZT9cudep7dUAlX9cH0j5o6B+dueur8tP437EPGdSzDr9lXyzfIryiUk4UvTjSRnocv0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=prevas.dk;
Received: from VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:e1::21)
 by VI1PR10MB3534.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:136::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Tue, 5 May
 2020 21:01:22 +0000
Received: from VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f0ac:4e97:2536:faa]) by VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f0ac:4e97:2536:faa%7]) with mapi id 15.20.2958.030; Tue, 5 May 2020
 21:01:22 +0000
Subject: Re: battery switch-over detection on pcf2127
To:     Bruno Thomsen <bruno.thomsen@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     =?UTF-8?Q?Per_N=c3=b8rgaard_Christensen?= 
        <per.christensen@prevas.dk>, LKML <linux-kernel@vger.kernel.org>
References: <a0ed6b56-33b1-b5ab-00d1-268fcd61b754@prevas.dk>
 <20200505200744.GV34497@piout.net>
 <CAH+2xPB7LJSxsr1vYhc=u+Qweu6_-S5oEQETUVZSVu1ATW=BYw@mail.gmail.com>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <62944a2d-f593-5a98-34be-f1f86ac6111c@prevas.dk>
Date:   Tue, 5 May 2020 23:01:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <CAH+2xPB7LJSxsr1vYhc=u+Qweu6_-S5oEQETUVZSVu1ATW=BYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0202CA0016.eurprd02.prod.outlook.com
 (2603:10a6:203:69::26) To VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e1::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.149] (5.186.116.45) by AM5PR0202CA0016.eurprd02.prod.outlook.com (2603:10a6:203:69::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend Transport; Tue, 5 May 2020 21:01:20 +0000
X-Originating-IP: [5.186.116.45]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1aa82fe0-1b18-44e1-8ffa-08d7f137768e
X-MS-TrafficTypeDiagnostic: VI1PR10MB3534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR10MB3534C0AC3178C71F253B550093A70@VI1PR10MB3534.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0394259C80
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eJ/HMBVRe8MyMi6UKwcDp9FsEjy6+laPCnq7BIGMZyNzChgmTC+Udx9QAQqQ6/nvAnmtNAoRMV6Ibcdsj+ySY80dInR7NaDxopMRFTazztdNSaRbc6VoX0q2/hcqkj+1CrcS0QFSPOEF9D0f2U19y0n11vNsG5rBjyD7T53cyWKR358iAq93KPHAltPH5bKzWP0/9SvO8B+9Sv8g/Uge5vA2GZit48bWSD6+87rkf92Vpackcwc8JnDZuBb1tH3uTSTYSHyKDOEcHzrW60zdsUbTRe24fATTzXOpveklfcaf9zanJBbi/Y+iKE/p5BKP1BndzlrSIm5YubuHZ8c26kL5JV8B2qSc7yqNuPLQZes6rgXwhR9acfwShyReEUwX298Bm9nv+e3Al9kwjHQCyojSOEyoR2oP0+G8Q26yQXWNAOnBOCkVTOmqbTRvCU3Dp88AXzObs0gvLMYCsbwhoGtkkr8ULIM9L/gxEVTMcKRou0/XBJoMNLQTgX7x+mr35rkImEuzvYt8TCJ5C0RYDoFMvxoc1aaJgazA/E70jEdAiHBA4zZA498Z9BwTuym/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(376002)(39850400004)(136003)(366004)(33430700001)(110136005)(31696002)(8936002)(16576012)(31686004)(52116002)(5660300002)(86362001)(8976002)(16526019)(44832011)(2616005)(186003)(8676002)(26005)(4326008)(316002)(956004)(66476007)(2906002)(36756003)(54906003)(478600001)(33440700001)(6486002)(66946007)(66556008)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: IP6OCLmDy+mIJSMdgZdzuSBTuY/sEyBH9rSHKb8mOicrJ6eUSHt9fyetvSR1qklT+84WUFyxEEzJwkLNvQOYwiqr5jJa1il1o/l6UPr4dgHKT4jKKzYlRNbuvhwVQqKeRpai7P2wujXDzLKI3/xFQMbaIiKh2UN0MvW+C3ia1jJ6dSL0jswNQmJCFYhnr76j9VesoxuN4lLSaBkTeM8eru3tN4mPKecPNy0DRe8V0huIHT/hJ933reWLLQQzMMT9R04T430ZpDB9zVMN4eC+iScn1t1vA3AB2vsjUfPZt97TTafvvSY4m560Xx+U0A4jUWU6ToQIba71CuA+KB/QMUF9K+lOvufK6R7RCTydmoYAIR4GyodQfXaWTGTbUpw7Z/PzW0j6C9VqZddanAN2Wl7zMbXkMtykrORRGBEdMqzKyefzi+uqOPbHwDqti6Zsx73EMSNAO80lKWW8xoQQ3TPMksXNKpO2C083fXtjaOiNby0Ia33CkEng6/4VxtcotW5zWZUFnpSF2PDYdkWb/Ra4Gc2JShYrzWb8eP9eH0lvyDj7YMCbuhbq77DGsbE+5E4A7TX74QhwZZXiNPzofnFeOIZz4aXYLljzfq47secJsurptJUDPGTwWLnuTP3m3hgp6DYh3+8gsy4ccyUkxUvuxKH5TJbxoCO2JjVJx8G3u+KECN4rloZ+dEXv7U9ZPt1FHZSVI1ohNB0Plj+YLOhZpGgEmlHC5BjrRlDXnphjlL3Un/CtWcqwSJTVlhsuhrT0VMviJbs6wcZF4n01ux/we2v7aTVUvZtMAmrSeP0=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa82fe0-1b18-44e1-8ffa-08d7f137768e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2020 21:01:22.2787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0btnCyfb6gmzyXH+auvcJa8meSzGsfFWPnbNOf0aBUBv6nvwe5yMcX92Wb253afOBtC1oMhUrEbK+9Yaw4mBkb5BIJVOdf/Bc5Hjl1XDBWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3534
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2020 22.38, Bruno Thomsen wrote:
> Hi Rasmus
> 
> Den tir. 5. maj 2020 kl. 22.07 skrev Alexandre Belloni
> <alexandre.belloni@bootlin.com>:
>>
>> On 05/05/2020 21:54:47+0200, Rasmus Villemoes wrote:
>>> Hi Bruno
>>>
>>> I just noticed your "rtc: pcf2127: add tamper detection support"
>>> (03623b4b04) from 5.4. Unfortunately, clearing the BTSE bit breaks a use
>>> case of ours:
>>>
>>> We rely on the battery switch-over detection to distinguish a powerfail
>>> during boot from a PORESET by the external watchdog (in the latter case,
>>> the RTC is still powered throughout, meaning there is no battery
>>> switch-over event). OTOH, we do not use the tamper detection - in fact,
>>> the TS signal is unconnected on our board.
>>>
>>> We're currently still on 4.19, but we will eventually upgrade to a
>>> kernel containing the above commit. So I was wondering if we could
>>> figure out a way that would work for both of us - either some CONFIG
>>> knob, or perhaps something in the device-tree. Any ideas?
>>>
>>
>> Yes, I was working on a patch series last week allowing to read BF. I'm
>> not sure clearing BTSE is your issue but clearing BF is.
>>
>> I'm going to send it tonight, I'll copy you, let me now if that works
>> for you. You can then read BF using the RTC_VL_READ ioctl. The
>> RTC_VL_BACKUP_SWITCH flag will be set if a switchover happened.
>> The RTC_VL_CLR ioctl can be used to clear the flag.
>>
>> I think clearing BTSE is still the right thing to do.
> 
> I think your use case is valid and it sounds like Alexandre solution will
> solve it as you just need to know if a battery switch-over has happened
> not when exactly it happened.
> 
> I can help test the patches too.

Thanks for the quick replies, both. Unfortunately, being able to read BF
from linux is not relevant to us - all the handling happens early in the
bootloader (including clearing BF, so that we can detect that the
previous boot failed only because of power fail - hence whether the
linux driver clears BF or not is not relevant). We really just want
linux to not touch the bits in CTRL3 at all.

Hm, wait. Re-reading the above suggests that BF can get set even if BTSE
is not, and a quick experiment shows that is true - I must have misread
the data sheet. While I think that's fine for now (currently I only
print the time of last switch-over as a diagnostic), I did have some use
case in mind for comparing that timestamp to the current time and make
decisions based on that. But until I figure out exactly what I want to
use it for, and until we actually upgrade to 5.4+, there's no rush.

Thanks,
Rasmus
