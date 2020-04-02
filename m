Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92D7C2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C27520784
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390012AbgDBXCb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 19:02:31 -0400
Received: from mail-oln040092072011.outbound.protection.outlook.com ([40.92.72.11]:34774
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388951AbgDBXCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 19:02:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uv7PGPDguNkwgGhYvFSa+/qHlmZselCIjPE5iOKfMMxe/GVCugotOII1i7kRTtIbtaeUfbK1jgr65g0lsanTGMdea/WxasiV5iLA0ZOGOj0I4vALPgW9aHEMasGybJT9VyAywws7KKk5RG6y8kwMi9xosEDY20Cu+pNzrWe7mNlwyV2Gq7lxysEAICSNIgqt+oq4E3troEBhnoxFwEEnMssSLYnBy0KWlnJAEzHjwBZWTIssvrodrmzq0kLtmqQcwF91v9l+rIHVvv7IBE7c9fHk/gEJWTw5ljynogudrFnNY/kYsWJHVhV80ytrrGjwTWT6NMjuHS2xActiQP4rkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCNvbYROYt2n/Vz3Y67GH2XBEf10c5/QrsRFniUA34s=;
 b=Mn0FiW9tg18asm6/SPt53SQvZztIVKlAJomOf6PcAIlq//1dILRoFBeVSYyq99CSFfeAmeqi6JjIPVfqFQnMdeCSBYrw/7PWfUhdie/IAXaPG0Ni/ikSa54euKn0dbqXsYMqdkNXhbRxxdl8ICr4mC+LgG+CIoevs4gm6+d/nBJQwgwDvqC4IKljBZwJkPRIhfMG0Vw6EwXtdJOoifZq92HqcvkDV25e+hoYTZzsKXJhZQ33U3l2/nOUcSpf5zxaaG3A/rUcbAgZlNPNW68P5rIQcC9t+WntiFmqpbCRoRupRiOTZ+Oif/k/djTQKtL9lgH8bnEQTRwVbycTwXaMsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from AM5EUR03FT044.eop-EUR03.prod.protection.outlook.com
 (2a01:111:e400:7e08::41) by
 AM5EUR03HT099.eop-EUR03.prod.protection.outlook.com (2a01:111:e400:7e08::185)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.17; Thu, 2 Apr
 2020 23:02:28 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:7e08::49) by AM5EUR03FT044.mail.protection.outlook.com
 (2a01:111:e400:7e08::312) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.17 via Frontend
 Transport; Thu, 2 Apr 2020 23:02:28 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:5D107FB9DF66D2B1F7131AE1D56ED5CDC56A2DEA08DE6C9B89FC7BE68FBA1A23;UpperCasedChecksum:34DF72D537227377FAF41BDAD0C8C09EB581864A8ED2D7675D5DD67BD9E321CB;SizeAsReceived:9300;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 23:02:28 +0000
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
 <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
 <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Message-ID: <AM6PR03MB517096287D21F58C194991F5E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Fri, 3 Apr 2020 01:02:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0081.eurprd07.prod.outlook.com
 (2603:10a6:207:6::15) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <ffea9843-6a13-c1a0-6018-0a91efb27584@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (92.77.140.102) by AM3PR07CA0081.eurprd07.prod.outlook.com (2603:10a6:207:6::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.5 via Frontend Transport; Thu, 2 Apr 2020 23:02:27 +0000
X-Microsoft-Original-Message-ID: <ffea9843-6a13-c1a0-6018-0a91efb27584@hotmail.de>
X-TMN:  [kyNpswq0L5JsEKUOYAR8bz2wrA9jRecs]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: ed75f605-ec53-4f09-d9aa-08d7d759ea40
X-MS-TrafficTypeDiagnostic: AM5EUR03HT099:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MszJuW74BcQgoz8xLoLCvKGXAvQqns4XeV8Fc7OVwdUv0ErLB9Q99WGTBk/DXoLqm9q0MyaTGmznyraEVI/WpqK507tU4ke36lqU+LPIIoAwgdEMrLMB4PWGZdH9NCMxJq7pY5xVKAG5KmuP3YGPQHvW1mZ6LwEqMBZvo3R1NWht7dl78Uu1W6o1wP17sFTLtMp+BNOkfphRggKJDnUWbhe+WDQQFxOUXEWubOiz3wI=
X-MS-Exchange-AntiSpam-MessageData: pdUPXX/cJno+WgvR6ssh4cL0Qkk8SVSb2DsKj2eax5QizH2b5ioKYyj6tx0vCPeC0nNFoU/l4TqVl62jMVUQqZAXGH4J9BXpzkN6cx1AjbpSVtrfi7dPsfcxJ1o9ZLq0UhLF56JsDwvhZ1FToIP5YA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed75f605-ec53-4f09-d9aa-08d7d759ea40
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2020 23:02:28.3451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR03HT099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/20 11:46 PM, Linus Torvalds wrote:
> On Thu, Apr 2, 2020 at 2:00 PM Bernd Edlinger <bernd.edlinger@hotmail.de> wrote:
>>
>> There are two more patches, which might be of interest for you, just to
>> make the picture complete.
>> It is not clear if we go that way, or if Eric has a yet better idea.
>>
>> [PATCH v7 15/16] exec: Fix dead-lock in de_thread with ptrace_attach
>> https://www.spinics.net/lists/kernel/msg3459067.html
> 
> There is no way I would ever take that patch.
> 
> The amount of confusion in that patch is not acceptable. Randomly
> unlocking the new lock?
> 
> That code makes everything worse, it's completely incomprehensible,
> the locking rules make no sense ahwt-so-ever.
> 
> I'm seriously starting to feel like I should not have pulled this
> code, because the future looks _worse_ than what we used to have.
> 
> No. No no no. Eric, this is not an acceptable direction.
> 

Seriously, Linus,

nobody is forcing anything on you.

That would be quite a stupid idea (to try to force you per e-mail :-) )

The future is not yet written.

I think Eric has an alternative idea for the next step (he did not tell
me more but I am curious).  Maybe that will be better, maybe not. And of
course I do not try to win a battle here, and I am willing to take advice.
So I am sure, we can work together to understand the problem better when
we take the time to analyze the problem better (I have not
yet read everything in your last mail completely, and followed
every link you have given, so what I write is just preliminary.

I just would like to know one thing,
how did you like my "big fat warning" comments?

If it turns out to be the wrong direction,
is it too late to turn back now?



Thanks
Bernd.


>              Linus
> 
