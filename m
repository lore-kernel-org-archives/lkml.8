Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E29C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 19:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6951220709
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 19:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgDKTPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 15:15:16 -0400
Received: from mail-db8eur05olkn2014.outbound.protection.outlook.com ([40.92.89.14]:33792
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726129AbgDKTPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 15:15:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSSYOTIiajy4hMpiHtCmcqDYemLEmQ0Cdee5JWsixEU6456e4Vmqf9x/HscpgIpn1BrkoCoS9qbbskF5x2oDkmsB3XNq6vJCQM8Sbo47YSJNlQo+CTjK+y74RWGLsYgSi4zgdfm5x/k4opzsXPuq3lqBp8AuFpgQZuG5RmYMrRPnCktu6TiEP0tDGs7EuJk+zbb8NkXjbwskd8SPKcAuJK3xw9ouyU8dZ3Z6zMCmgUXSGtezXjEiaMSdbpauI2D41vAB5uUk/0DwCmu7DESSFVV//wbA8aTmYtyjwlPzSIaP3Ge3ttyH51GilItwLsjBzCsQ51YrMEL15UOXJhPjfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgw5cGUTQYABehzIE+Ng3Pf9aIBCQV/MFF5UTdQXAH8=;
 b=NEFP5laDaj4ynHgm8r/i5Hu//whZQouHMTepT50+lLhwtMOUSrtFYHZUB5+/AOlk7nsJcZo1dYGZLnEN/xErbJiihlFkGqESIDg3nElNZIn/W+1z6hZGhZPlRIr6fbI/yWH5qmCzBv1Nney5s4ATlT2YFWKLsZVike4Caw0dMy3fLVEblTt3DygbXIqEeTMtJNchU20CTBSzLWfja+n8mXoAhdn25B8crr9v4Y1aeMP1jBbY+t+rHG6JpXaHapH2RUc/dtbLTq/iB6ELP+562QWRq9BB9A++svLJ4ekQIhbVRT+TQvAbMloVq46gtGVVkok29GY+j5HWlyrl9lB7cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from DB8EUR05FT044.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc0f::4a) by
 DB8EUR05HT157.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc0f::73)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Sat, 11 Apr
 2020 19:15:13 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:fc0f::43) by DB8EUR05FT044.mail.protection.outlook.com
 (2a01:111:e400:fc0f::225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Sat, 11 Apr 2020 19:15:13 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:0F07663C374A591FC983CF8A60BDFC578EB320C786A2DD91170756D4861772FE;UpperCasedChecksum:A94949A8F4003641CBE8BC812FAFB826370C8A84BAFC22CB96052FE889565FD3;SizeAsReceived:9863;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2900.026; Sat, 11 Apr 2020
 19:15:13 +0000
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <AM6PR03MB51708FD4226E07AB7CB0D6A7E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wjaoYM4gXdAyYY=u8PaYj2LXUvcfp=8DKum8f1DM+Ws0A@mail.gmail.com>
 <AM6PR03MB5170F924EA69A81D79BD0929E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whMKC5F-=QQP=fCNRuTF+ZGiNtLEKvx7KekpK1JtrwDhw@mail.gmail.com>
 <CAHk-=whJ8khGBqfqh6ZmHsKjcyyBLm5xgkgLW_AC_=82iFBWoQ@mail.gmail.com>
 <AM6PR03MB51700B243E34BF4A59FF33CFE4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <87imi8nzlw.fsf@x220.int.ebiederm.org>
 <CAHk-=wgh4zts+3hdkGzHLJ6pBGumcJ=23gRbMfubDrLstis2Bg@mail.gmail.com>
 <CAHk-=whKHpERyVv2-C+kxq9KV_mJPW3hkGDpn6f4yOvs+au8SA@mail.gmail.com>
 <20200411182043.GA3136@redhat.com>
 <CAHk-=wgwXpKepChGi4ZhQVxZxD0ic8s2CDXvUmqBTMaKGz-fjg@mail.gmail.com>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Message-ID: <AM6PR03MB5170660DA597EAAAC0AC1B5BE4DF0@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Sat, 11 Apr 2020 21:15:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <CAHk-=wgwXpKepChGi4ZhQVxZxD0ic8s2CDXvUmqBTMaKGz-fjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0101CA0055.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::23) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <b831e601-cd32-8cc7-84c9-18cdee490fe0@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (92.77.140.102) by AM4PR0101CA0055.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Sat, 11 Apr 2020 19:15:12 +0000
X-Microsoft-Original-Message-ID: <b831e601-cd32-8cc7-84c9-18cdee490fe0@hotmail.de>
X-TMN:  [QxvFPkz8Rfjpp5PBNOCS1AyR/tWJj7gA]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 288e018c-d0be-4ac1-ed18-08d7de4ca928
X-MS-TrafficTypeDiagnostic: DB8EUR05HT157:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jliJ+j4uEW3aMgGWDHYY2lFMa8oXLIH8uEo9yfyeBqYKWU44WPinhhhRc/U7BNWsu1MqOR+7zfE4V/Qi4OqZqTlB3Dama5CFHn4ogciDin36gQb03MLm46wUeJzVt0b6uT0LRnNV8sGrzy4DSi4iJkPv3PF8i97CPriPnu/tRIeMMkuQky+0rTJUvAUy8Rp5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB5170.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: m/UHKUkZarDzTEhEKaNGOtlAdv852PRf3aqwhip13xaWKOFxOpnLAb689FXccuKWcnua8ZzZ8dT4UbqWOAkcKn6u4lO7zH2DENqYuDOc8hPw5AWMRuVx6iLaM23VGyYvxhtW3jL923EnGDLW6oRaqw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 288e018c-d0be-4ac1-ed18-08d7de4ca928
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2020 19:15:13.6654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8EUR05HT157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/20 8:29 PM, Linus Torvalds wrote:
> On Sat, Apr 11, 2020 at 11:21 AM Oleg Nesterov <oleg@redhat.com> wrote:
>>
>> On 04/09, Linus Torvalds wrote:
>>>
>>>  (1) have execve() not wait for dead threads while holding the cred
>>> mutex
>>
>> This is what I tried to do 3 years ago, see
> 
> Well, you did it differently - by moving the "wait for dead threads"
> logic to after releasing the lock.
> 
> My simpler patch was lazier - just don't wait for dead threads at all,
> since they are dead and not interesting.

But won't the dead thread's lifetime overlap the new thread's lifetime
from the tracer's POV?


Bernd.

> 
> Because even if it's Easter weekend, those threads are not coming back
> to life ;)
> 
> You do say in that old patch that we can't just share the signal
> state, but I wonder how true that is. Sharing it with a TASK_ZOMBIE
> doesn't seem all that problematic to me. The only thing that can do is
> getting reaped by a later wait.
> 
> That said, I actually am starting to think that maybe execve() should
> just try to reap those threads instead, and avoid the whole issue that
> way. Basically my "option (2)" thing.
> 
> Sure, that's basically stealing them from the parent, but 'execve()'
> really is special wrt threads, and the parent still has the execve()
> thread itself. And it's not so different from SIGKILL, which also
> forcibly breaks off any ptracer etc without anybody being able to say
> anything about it.
> 
>                 Linus
> 
