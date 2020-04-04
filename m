Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4203AC2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 06:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CECC206CC
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 06:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgDDGeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 02:34:46 -0400
Received: from mail-am6eur05olkn2064.outbound.protection.outlook.com ([40.92.91.64]:11605
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbgDDGeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 02:34:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFWX9docF2p9djNGIMQvOVUgY4HfsOxqN6rqtjbHpJUjn4v+rGRwPeYmJTV/HxS6Gahhx2+7YgX0O4Hi3YcEzDjtpA5d7cebkaz/yA203sdCEV1ERNNTcXg9SPs3W/9uQZxSkfwc9uYJu/YWag1n+GbN1Xc845hLA215t4qFNU0kRi0WFN9CXfffqfgzb+TBYsSH5G0ua7Wt8nKLe8jWu/BzttJ1ffFzkfok6bYbmSaHTxw2HZyi64CbLWB7Kzzffxn1nQ3GyIJzi8WrRFjNOwvZM3+w/RoSu+LGY8i7JTvJ4sMvBlhUT4F42dppQ1LH9Lp4m9LgqYrdEfAYGGjO9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPOQocE9jY8LXBOt5UFpLLKpPiwLsEyhLpF0ZYFXG8U=;
 b=Ov/h722r5E/ByxgPtt8As86sJBeVNozDR5Ril5PyPGJs3Ofc9xoqcVlgpYd92ju4b3zcEQ/HR/ubdkDmCJn8Ia1xjvpkuqlq3SW2gupK7QtSWFBnnuTo6bYznypXhZVpTnpuYeHV0XNxEvf9doK+OS3io4hJQzA6wqNNQVgZz9kLADY4bXXO8iClzOnkefW5wiVPn5cMcli9ykKecNVx0YkWj+9068L6czqIYcBnJ/Bvnilq9VZ/gGjMlI8F6MCQ7paJD1F3np0rk9DxKejEFZnk9s/xCsMtp/JaRV20k1wAiIEtqDbvN0S7s70ZrgaWw01H5bkD4uItlO97QPiRgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from VI1EUR05FT004.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc12::51) by
 VI1EUR05HT009.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc12::149)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sat, 4 Apr
 2020 06:34:07 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:fc12::49) by VI1EUR05FT004.mail.protection.outlook.com
 (2a01:111:e400:fc12::283) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Sat, 4 Apr 2020 06:34:07 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:B8DE07D334CB59A30263E02B859C395EE80C2935F930A2B7724C92DBA9015873;UpperCasedChecksum:12C12BE6BBB6FDB8A24135CE11CA928227E24047F8DECD019265B2F5BA81D87A;SizeAsReceived:9965;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2878.018; Sat, 4 Apr 2020
 06:34:07 +0000
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Waiman Long <longman@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
 <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
 <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
 <87lfnda3w3.fsf@x220.int.ebiederm.org>
 <CAHk-=wjxyGCj9675mf31uhoJCyHn74ON_+O6SjSqBSSvqWxC1Q@mail.gmail.com>
 <328f5ad3-f8b3-09b9-f2f7-b6dae0137542@redhat.com>
 <CAHk-=wgww8LFqUenUtNV7hzYSxAemjbOVYfZMXqOxK7DGRrZaw@mail.gmail.com>
 <c7c770c9-2c5c-4878-a224-d115720068f3@redhat.com>
 <86aa9fc6-6ac9-a0c2-3e1d-a602ef16d873@redhat.com>
 <CAHk-=wgOykL7cM34NraiNGsjJC5Uq6H0ybYHWhdXDSn-wzVXDQ@mail.gmail.com>
 <5c04cc6d-ec44-b840-071d-248ac81a0f91@redhat.com>
 <CAHk-=wgkE=qT6CSUJHfXNsyhW+=j4SVgxh2jEc8nWY_n3SFZ=w@mail.gmail.com>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Message-ID: <AM6PR03MB517044AE8D005BB0BBB1EC98E4C40@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Sat, 4 Apr 2020 08:34:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <CAHk-=wgkE=qT6CSUJHfXNsyhW+=j4SVgxh2jEc8nWY_n3SFZ=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0074.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::15) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <ad1cc886-af87-e0fa-6d2d-9f1030f71409@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (92.77.140.102) by AM0PR01CA0074.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend Transport; Sat, 4 Apr 2020 06:34:06 +0000
X-Microsoft-Original-Message-ID: <ad1cc886-af87-e0fa-6d2d-9f1030f71409@hotmail.de>
X-TMN:  [JZvvj/WMT1WA/+8bVLA/WY5dVluiRud9]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 5bde8e06-0adc-45db-51b9-08d7d8622ccc
X-MS-TrafficTypeDiagnostic: VI1EUR05HT009:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fc2SfhNRH7hqzXPf7oEFP5IM1e+mtXbQrR5+bQw3yCHdgUCDeT7pZgB/k5ym7lVViij7vQWr2zkb0tGUOnQFLODmNRLqWAHvHcKnLHs8vJ+FkRU/LD5ibMMPnh1tKF5biS8QqdE3EuIzgL4VCZ8LjBkgVppplFF5xgNxth1jtuQbw5FJOxkgFihGu77IuMvO
X-MS-Exchange-AntiSpam-MessageData: T/tTWK5JzBgZufgHwiSQ6zdvX8ASa2e0bsSUeRdaKvAhePhMbacBQlrLpLRiM6aF6J0U40v5f84Sd1CVTUgTziw+jHKeVI3ls6I2F/CQCwcIeKJsWrZZxz2RUW5JM6jMbdZOa8V3lGEbLOA4vD27bA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bde8e06-0adc-45db-51b9-08d7d8622ccc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2020 06:34:07.0224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1EUR05HT009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/4/20 4:28 AM, Linus Torvalds wrote:
> On Fri, Apr 3, 2020 at 7:02 PM Waiman Long <longman@redhat.com> wrote:
>>
>> So in term of priority, my current thinking is
>>
>>     upgrading unfair reader > unfair reader > reader/writer
>>
>> A higher priority locker will block other lockers from acquiring the lock.
> 
> An alternative option might be to have readers normally be 100% normal
> (ie with fairness wrt writers), and not really introduce any special
> "unfair reader" lock.
> 
> Instead, all the unfairness would come into play only when the special
> case - execve() - does it's special "lock for reading with intent to
> upgrade".
> 
> But when it enters that kind of "intent to upgrade" lock state, it
> would not only block all subsequent writers, it would also guarantee
> that all other readers can continue to go).
> 
> So then the new rwsem operations would be
> 
>  - read_with_write_intent_lock_interruptible()
> 
>    This is the beginning of "execve()", and waits for all writers to
> exit, and puts the lock into "all readers can go" mode.
> 
>    You could think of it as a "I'm queuing myself for a write lock,
> but I'm allowing readers to go ahead" state.
> 
>  - read_lock_to_write_upgrade()
> 
>    This is the "now this turns into a regular write lock". It needs to
> wait for all other readers to exit, of course.
> 
>  - read_with_write_intent_unlock()
> 
>    This is the "I'm unqueuing myself, I aborted and will not become a
> write lock after all" operation.
> 
> NOTE! In this model, there may be multiple threads that do that
> initial queuing thing. We only guarantee that only one of them will
> get to the actual write lock stage, and the others will abort before
> that happens.

One of the problems that add to the current situation, is that sometimes
the cred_guard_mutex is locked killable, so can be killed by de_thread.
But in other places cred_guard_mutex is not killable. So cannot be
locked and cannot be killed either -> dead-lock.


But Fear Not!

Overall we are pretty much in a good position to defeat the
enemy now, once an forever.

- We have my ugly-crazy patch that just works.

- We will have Eric's patch that is even better.

- We can try to put something togeter with creative new rw-type semaphores.

- We can merge ideas from one of the patches to another.


So it is impossible we not succeed to fix it this time :-)


Bernd.

> 
> If that is a more natural state machine, then that should work fine
> too. And it has some advantages, in that it keeps the readers normally
> fair, and only turns them unfair when we get to that special
> read-for-write stage.
> 
> But whatever it most natural for the rwsem code. Entirely up to you.
> 
>                Linus
> 
