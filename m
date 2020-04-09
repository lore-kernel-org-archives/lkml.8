Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42C5C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841D720753
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgDIUg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 16:36:28 -0400
Received: from mail-db8eur05olkn2031.outbound.protection.outlook.com ([40.92.89.31]:3456
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726623AbgDIUg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 16:36:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+hqzsOcsPNSqd3jcCb+ZTestW1QcqIAYdT6KfWw5Tx9dFz2knW3Kw/DMHcZm81VBEXXqMSpumUYFE+D9x04AZ9mtOt/Bv4q1KS4mSnpBDUhsUkQ4vV4MrJrMDP6Oh6krkso4Q+39EZyc41FD6OxX5/KXB+qhMHiLnlASY3P9fTNh8CGPaHNE7p6kFgiJ4u3eaGmaC/+Vy2JaGdkSx4Kh+KCmiRUDIPsh0SHV8CkV/73wSLFcKv69qLHM5TNvM/iOeLOB5334iPeuNz3826ZcwOaTuP+mMrKOsxrL/if47XKy/MgZZ26EwZ7ElugSiONyHPuIf/WpRgvni/vvakQBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjgOdk/XLN4/zWKrIP5EI/CbXAwhJ8jakWruGG3/YHo=;
 b=YlkAAD3r+KkcpGmgbhQf3WScJFBy0fu3Q9AwWbTukMZaPvFstXlclR7MBfcbCad2luGlwbMDis5OCuAc+Wd1pcKz5PfBCRRRDNvMe2wEkcv/0wz1ucjtxiHttAWFJSJdulaF9xXekN+Faxs2w+U/oACl9PXTPkoTy6xSO0ag8HTBzf+xvKG+6AGs9SAFbt2+48RemWi4n5U6FCbAYbDIwAd7PlDJlflhgPCCEokllZrXBFSQHfv1qgF2J9MGw3GDzFDlCU8qpUGAbe+0xZMzeIqgDMWg0+SbFiT4JC96slMpAVvozLwJ0xkiWvRdxiw0tgI4gloMnl3xHd+k2404tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from DB8EUR05FT042.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc0f::52) by
 DB8EUR05HT148.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc0f::175)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 9 Apr
 2020 20:36:26 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:fc0f::4b) by DB8EUR05FT042.mail.protection.outlook.com
 (2a01:111:e400:fc0f::328) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Thu, 9 Apr 2020 20:36:26 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:D22402EA3F5027C3C4274605A6EC12483B73E052BCCCB8128B5868BB038DF3C7;UpperCasedChecksum:2ECADAD848B11E248AF783765E384E5E980FF23B7858055FD656D3168884EC64;SizeAsReceived:10015;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2878.022; Thu, 9 Apr 2020
 20:36:26 +0000
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
 <CAHk-=whES-KCO6Bs93-QBK1tS5CfiWSi+v5D1a7Sc1TD5RFoaA@mail.gmail.com>
 <87v9maxb5q.fsf@x220.int.ebiederm.org>
 <CAHk-=wih4BqW7GTLaYxewynuT-iFHrXroip0wNo0CyPtmYGUow@mail.gmail.com>
 <87y2r4so3i.fsf@x220.int.ebiederm.org>
 <CAHk-=wjhAvv6s_7OVeZJiHaY7bBrHyiPTkSpq-TLr6qxYqxUUw@mail.gmail.com>
 <CAHk-=wi0jrKv9x6vJ9FDgTrSUbdbZYDX-79T-E87C48MGSn5=g@mail.gmail.com>
 <87wo6or3pg.fsf@x220.int.ebiederm.org>
 <AM6PR03MB51708FD4226E07AB7CB0D6A7E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wjaoYM4gXdAyYY=u8PaYj2LXUvcfp=8DKum8f1DM+Ws0A@mail.gmail.com>
 <AM6PR03MB5170F924EA69A81D79BD0929E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whMKC5F-=QQP=fCNRuTF+ZGiNtLEKvx7KekpK1JtrwDhw@mail.gmail.com>
 <CAHk-=whJ8khGBqfqh6ZmHsKjcyyBLm5xgkgLW_AC_=82iFBWoQ@mail.gmail.com>
 <AM6PR03MB51700B243E34BF4A59FF33CFE4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Message-ID: <AM6PR03MB51708E5625468251BC75C799E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Thu, 9 Apr 2020 22:36:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0140.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::45) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <e0f2ce75-c01d-320c-40b0-7baf70ae23e7@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (92.77.140.102) by AM0PR01CA0140.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 20:36:25 +0000
X-Microsoft-Original-Message-ID: <e0f2ce75-c01d-320c-40b0-7baf70ae23e7@hotmail.de>
X-TMN:  [3sOWdNKmVyUGjKP31fwW+zSD1r55U0cJ]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 09810bb4-03fa-4b30-60a8-08d7dcc5acb7
X-MS-TrafficTypeDiagnostic: DB8EUR05HT148:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZwEWBzCz+0DnqTn/RaZrwrfxRmlZ7JEQHRZcmYfFFDX8Jq92bhIe+ZyFUYXvRow0A7+7x0pA3nEXrKt6U1ijV9bzXS489G27ELWWzQneW+yKCMvh7y+zNKYKGpW3QjCC746GkEpddnvqv3OZ0iTHEA+Me9hESFwDAQlY75P6Muc6obuUJIV7ym48At5fIzWv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB5170.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: s8SNnUH7N1h4LS9tuFX14OVztd2bM5aMGVYKfzjpHBzWniraiSS3uMpi9wk5mOuTKy6FE8eg1YeboQRYYOk9cRPlYJEgPT8k2ntwfhO/+oX+x8D0oxw6OvQvpz3ACjZByjY10hCG4+OEV9pUjLsojw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09810bb4-03fa-4b30-60a8-08d7dcc5acb7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 20:36:26.3769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8EUR05HT148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/20 10:04 PM, Linus Torvalds wrote:
> On Thu, Apr 9, 2020 at 12:57 PM Bernd Edlinger
> <bernd.edlinger@hotmail.de> wrote:
>>
>> The use case where this may happen with strace
>> when you call strace with lots of -p <pid> arguments,
>> and one of them is a bomb. strace stuck.
> 
> Yeah, so from a convenience angle I do agree that it would be nicer to
> just not count dead threads.
> 
> You can test that by just moving the
> 
>                 /* Don't bother with already dead threads */
>                 if (t->exit_state)
>                         continue;
> 
> test in zap_other_threads() to above the
> 
>                 count++;
> 
> line instead.
> 
> NOTE! That is *NOT* the correct true fix. I'm just suggesting that you

Eric, I think he means you, I am too busy with other work ;-) right now.

> try if it fixes that particular test-case (I did not try it myself -
> because .. lazy)
> 
> If Oleg agrees that we could take the approach that we can share a
> signal struct with dead threads, we'd also need to change the
> accounting to do that notify_count not when the signal struct is
> unlinked, but when exit_state is first set.
> 
> I'm not convinced that's the right solution, but I do agree that it's
> annoying how easily strace can get stuck, since one of the main uses
> for strace is for debugging nasty situations.
> 
>                 Linus
> 
