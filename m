Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF7FC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F32206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbgDHPVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:21:10 -0400
Received: from mail-db8eur05olkn2091.outbound.protection.outlook.com ([40.92.89.91]:36398
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726663AbgDHPVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:21:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJxUoCCiv5bGBtxklFDyEYzVdz4gXWJ6xSiuA1RbSXqgFWQRlW7skoiN3zz5diBpvQEzjWBeu2hDoUEYWAXCzgPCM9/g5pahlYHHJVm259zOgTnLoX6i7wUKikScIQEW3c7DevApIlMuig9EkNjF1w4UvLhaPH/6c/iDjbNW1loDukxgbNffgE2kl2603e1m2tejbpZK2dRa4rIqKedxaIFcpzqz0G8V3v8gPK/lvHBazSFoztMVHOEohTcYOFC8v6RZTnw8enejuN9CkAGfmZZHo9FZJO98Z1cUNTRspyiKxtruvZPS1a9c/Mx2zrY1CvevFgczrJvGHl57pYqcLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2wSNqV2FCfnJLEenmVM1ywH3Y1Mw2I5Pu2jFlkE5/U=;
 b=ZZvDbLEq01ss+IzL9Dtx/49YUgAsPktu4eeelMZ9wzs/ODfmi9cJkw4YdLmUSH1ShqQOnKlbwBpVUHGZzgJ6U3crYc4ef1r0QCpn6fRs0ugLVy7qk8ga9IL4WbedHpsVoxGB4MXa5ABpb6c7Pw5vvkAUfPCRDx1Y6sPMvH5b37SxNhAX+Q/tvsYt1qXW0ljdoVzmL4OkGcSzWDyi/WBsZuKpAK+grsjfGbXdAzc3jWdfQan58gP3rqF4hVBqiq8Z+N5gmax7w0fFUVdtjn8xh14zetOVbh3vjRqwl6PA+LTJJ9VsX16E0mspy41c6snhM98thUdfuOgXI1FYDBI1SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from DB8EUR05FT019.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc0f::53) by
 DB8EUR05HT193.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc0f::131)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Wed, 8 Apr
 2020 15:21:07 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:fc0f::53) by DB8EUR05FT019.mail.protection.outlook.com
 (2a01:111:e400:fc0f::290) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Wed, 8 Apr 2020 15:21:06 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:24A67598201204E72D5F33CCF1AE63ABDD6B871DD43DE4A0B1E817A38E9C8877;UpperCasedChecksum:3C3164BE561EF0134F2A5CD56B6BED168978B6DA5A560C788AA0037C4BF34FA4;SizeAsReceived:8833;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2878.022; Wed, 8 Apr 2020
 15:21:06 +0000
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will@kernel.org>,
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
 <87blo45keg.fsf@x220.int.ebiederm.org>
 <CAHk-=whES-KCO6Bs93-QBK1tS5CfiWSi+v5D1a7Sc1TD5RFoaA@mail.gmail.com>
 <87v9maxb5q.fsf@x220.int.ebiederm.org>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Message-ID: <AM6PR03MB517015F585466ED40113FDEEE4C00@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Wed, 8 Apr 2020 17:21:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <87v9maxb5q.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0038.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::18) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <d061bb3f-8110-436f-9584-646444ebc00f@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (92.77.140.102) by AM0PR10CA0038.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Wed, 8 Apr 2020 15:21:06 +0000
X-Microsoft-Original-Message-ID: <d061bb3f-8110-436f-9584-646444ebc00f@hotmail.de>
X-TMN:  [aaXTtLPw6OfTFCNntz9zaDmeQ5LLVuYx]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: cc9daaa0-f829-4412-afff-08d7dbd07564
X-MS-TrafficTypeDiagnostic: DB8EUR05HT193:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eHLi18qWQW/OrEVCWSNTO6T6PpEuAbNgzwHksxw1qRxkncUrAFc9Jl/HzeYkEZLp0eNU38wfL17JXt3obRQ3UdVnqIXmnYTdTOB9aDYJ0dIKL7z1myBiQiNy6UilGcEf3pT5AlyXdjQhNlSaI0t3Hq6Oe62YzCkk4OxnsMZORy1n1eP7XGiOrUUTv9v3iDF8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB5170.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: mlE0bnHtK+/fSidlT/sp0xovsR73YwbLo+QFDzEmPSolavxiCgHkXBxD+9PXf6m0Uja8mxi5z7dv0sWc1uV4rM1XASI97RlJUuSbrn9KDEGgX93x+v4o6hAzE4vmNTdHjRDKxJORix7O3SA8EYECtw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9daaa0-f829-4412-afff-08d7dbd07564
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2020 15:21:06.8796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8EUR05HT193
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/20 5:14 PM, Eric W. Biederman wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
>> On Mon, Apr 6, 2020 at 3:20 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>>
>>> But fundamentally the only reason we need this information stable
>>> before the point of no return is so that we can return a nice error
>>> code to the process calling exec.  Instead of terminating the
>>> process with SIGSEGV.
>>
>> I'd suggest doing it the other way around instead: let the thread that
>> does the security_setprocattr() die, since execve() is terminating
>> other threads anyway.
>>
>> And the easy way to do that is to just make the rule be that anybody
>> who waits for this thing for write needs to use a killable wait.
>>
>> So if the execve() got started earlier, and already took the cred lock
>> (whatever we'll call it) for reading, then zap_other_threads() will
>> take care of another thread doing setprocattr().
>>
>> That sounds like a really simple model, no?
> 
> Yes.  I missed the fact that we could take the lock killable.
> We still unfortunately have the deadlock with ptrace.
> 
> It might be simpler to make whichever lock we are dealing with per
> task_struct instead of per signal_struct.  Then we don't even have to
> think about what de_thread does or if the lock is taken killable.
> 

I think you said that already, but I did not understand the difference,
could you please give some more details about your idea?


Thanks
Bernd.

> 
> Looking at the code in binfmt_elf.c there are about 11 other places
> after install_exec_creds where we can fail and would be forced to
> terminate the application with SIGSEGV instead of causing fork to fail.
> 
> 
> 
> 
> I keep wondering if we could do something similar to vfork.  That is
> allocate an new task_struct and fully set it up for the post exec
> process, and then make it visible under tasklist_lock.  Finally we could
> free the old process.
> 
> That would appear as if everything happened atomically from
> the point of view of the rest of the kernel.
> 
> As well as fixing all of the deadlocks and making it easy
> to ensure we don't have any more weird failures in the future.
> 
> Eric
> 
> p.s. For tasklist_lock I suspect we can put a lock in struct pid
> and use that to guard the task lists in struct pid.  Which would
> allow for tasklist_lock to be take much less.  Then we would
> just need a solution for task->parent and task->real_parent and
> I think all of the major users of tasklist_lock would be gone.
> 
> 
