Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82142C2BA18
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 03:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 580D5206D4
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 03:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgDEDfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 23:35:50 -0400
Received: from mail-oln040092064012.outbound.protection.outlook.com ([40.92.64.12]:7246
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726307AbgDEDfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 23:35:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVy4aaOBmQOizaN4ohWwT0bHq6U0GUo0+IvuTTingVdYCZv4bbkRPqRaZ3VJ+f3FznQsyEgl3CSsbvQPON6mgejVKCXg6WCLOBVAKJuAlhFcNKIy3zwH3xBdMZT0JtOA2Frq54pNUWHTXqI+97YT7e2AJ1h/hqz1dMgkpYCB8raX7orDstsx68dSFxNoN1KzZv7ew4ENzlI3vgnSkrStQeJ468dqY84GL1ucluWXNeg2oJk6y6F8qwMRRMGJhHy02BM7kFRlWJoybQOeC+Yg6L5KucVzW2Qg8nP39B/Gn6iEtzMxPggLenAvWK2xsqIc4fdPL5cAnYDXgkjPvSDm4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJoKBbrvch//gCfItNC55PrtEKKJe+9nCYuf9aS6IZE=;
 b=Tvoty26WNC1bDE/7yusw2FBBqXFbNYKTt1ENeoWpJ5QSb8b9Wjcs3u0cEZ7WUFxgq40lvPpuRwM/OmsfQ2awdjiBxMuvRLW1H8t9l9dZ32HrgI7CKt08K2SVLZVysta5d4rTeQNJk1pIjTCG1T+2LlC5tqxoLAAXAKR/39bQ9i05IYx3eBttP0+H/8RTiRC6pNwvocb8cG2E8UwdMdug3EUpv76pTdQB5PqCv0/DVmRwUxhRT/AOeiVVPV1oMuUFdIjAvPX9FXIhp1XmX5wYO/NS4pwybM989+erjpKYApBGTgDWIyuEPdaVDOd6j8XYyYovy6b6M4MDq+qe1PIDig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from HE1EUR01FT010.eop-EUR01.prod.protection.outlook.com
 (2a01:111:e400:7e18::44) by
 HE1EUR01HT138.eop-EUR01.prod.protection.outlook.com (2a01:111:e400:7e18::282)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 03:35:47 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:7e18::45) by HE1EUR01FT010.mail.protection.outlook.com
 (2a01:111:e400:7e18::86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Sun, 5 Apr 2020 03:35:47 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:FA9581A416FDE9D71EF17AD4864829C61EC912C7D0FE56F72B53D0E5C6539A17;UpperCasedChecksum:74782C3E9E5EF0BA4C1B7C42923819ED1DD71F4F680CB8A72B25212B0638E0C1;SizeAsReceived:9979;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 03:35:47 +0000
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Waiman Long <longman@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
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
 <9876d04e-32c9-dcaa-545a-bfecbf07ea74@redhat.com>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Message-ID: <AM6PR03MB5170E4AA9CBA36BDC87A3F43E4C50@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Sun, 5 Apr 2020 05:35:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <9876d04e-32c9-dcaa-545a-bfecbf07ea74@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::11) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <d91160b6-e0ae-8473-2fa5-0db110b7ab38@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (92.77.140.102) by FR2P281CA0001.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend Transport; Sun, 5 Apr 2020 03:35:46 +0000
X-Microsoft-Original-Message-ID: <d91160b6-e0ae-8473-2fa5-0db110b7ab38@hotmail.de>
X-TMN:  [LDqmbWEhkTJI6kKTuYBHvIMTSYEHgM2o]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 03758535-7d6c-4ef6-be13-08d7d9126d89
X-MS-TrafficTypeDiagnostic: HE1EUR01HT138:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zf4Al81HtPmtu0W+YX2TSGCDM5fHYp8rOnM3K8mbDWOK9oP+8bwVECuD43X5nkFr+erOIF2HDntkWqEBDTkV+kQFsw2jAuEk8wscpTY7BUa/RfV+bpWodGXFPI/YtkAABlIEcfZugic2Agvk/SDzyk1TbLAcdoIo8izTYl4JBzRwxA3pNJDaDPWn5Cetu8Dv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB5170.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: JgwrFeNWYMS5vCbDCUqdlOIRC7AlRL3gx3JkLxEPFbEbISjWWyU9S3kjRIBNLBukOrUktHeBXt9FhRwf65YGJBYGEFuAR9PkjFmu2XSE2xFQuoNsBlQOWsR2wDgsZ5PMsyqUSsHGrLKnrJZCqQJsDg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03758535-7d6c-4ef6-be13-08d7d9126d89
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 03:35:46.9904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1EUR01HT138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/20 4:42 AM, Waiman Long wrote:
> On 4/3/20 10:28 PM, Linus Torvalds wrote:
>> On Fri, Apr 3, 2020 at 7:02 PM Waiman Long <longman@redhat.com> wrote:
>>> So in term of priority, my current thinking is
>>>
>>>     upgrading unfair reader > unfair reader > reader/writer
>>>
>>> A higher priority locker will block other lockers from acquiring the lock.
>> An alternative option might be to have readers normally be 100% normal
>> (ie with fairness wrt writers), and not really introduce any special
>> "unfair reader" lock.
> A regular down_read() caller will be handled normally.
>> Instead, all the unfairness would come into play only when the special
>> case - execve() - does it's special "lock for reading with intent to
>> upgrade".
>>
>> But when it enters that kind of "intent to upgrade" lock state, it
>> would not only block all subsequent writers, it would also guarantee
>> that all other readers can continue to go).
> 
> Yes, that shouldn't be hard to do. If that is what is required, we may
> only need a special upgrade function to drain the OSQ and then wake up
> all the readers in the wait queue. I will add a flags argument to that
> special upgrade function so that we may be able to select different
> behavior in the future.
> 
> The regular down_read_interruptible() can be used unless we want to
> designate only some readers are allowed to do upgrade by calling a
> special down_read() function.
>>
>> So then the new rwsem operations would be
>>
>>  - read_with_write_intent_lock_interruptible()
>>
>>    This is the beginning of "execve()", and waits for all writers to
>> exit, and puts the lock into "all readers can go" mode.
>>
>>    You could think of it as a "I'm queuing myself for a write lock,
>> but I'm allowing readers to go ahead" state.
>>
>>  - read_lock_to_write_upgrade()
>>
>>    This is the "now this turns into a regular write lock". It needs to
>> wait for all other readers to exit, of course.
>>
>>  - read_with_write_intent_unlock()
>>
>>    This is the "I'm unqueuing myself, I aborted and will not become a
>> write lock after all" operation.
>>
>> NOTE! In this model, there may be multiple threads that do that
>> initial queuing thing. We only guarantee that only one of them will
>> get to the actual write lock stage, and the others will abort before
>> that happens.
>>
>> If that is a more natural state machine, then that should work fine
>> too. And it has some advantages, in that it keeps the readers normally
>> fair, and only turns them unfair when we get to that special
>> read-for-write stage.
>>
>> But whatever it most natural for the rwsem code. Entirely up to you.
> 
> To be symmetric with the existing downgrade_write() function, I will
> choose the name upgrade_read() for the upgrade function.
> 
> Will that work for you?
> 

May I ask, if the proposed rwsem will also work for RT-linux,
or will it be a normal mutex there?


Thanks
Bernd.


> Cheers,
> Longman
> 
