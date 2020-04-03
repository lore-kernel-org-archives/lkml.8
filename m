Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF2FC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFBA21655
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390719AbgDCQAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:00:19 -0400
Received: from mail-am6eur05olkn2016.outbound.protection.outlook.com ([40.92.91.16]:25600
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727998AbgDCQAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:00:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=On9RlpDctuof1ZAJJ74O3uKFGnv47MzPoRmcCbZRJks9fXnkJ5DYirLeiIMx0AwIgn/gqpk14Mz33Qg5H9KF6VpWbYD/1RhW4dUQHEvyIfv1cVasaN2fy2pMi9kf58xi28RjYNwl9Sqg9H4zHdNLYiVHVjTzujeZl/KhkpLiRPCKtaOXXqcRUaq/T8zKLI0F3OGc5h3lx6AYVWYD8ZH5dSYpPTwH3z0LDZqP+4X48A8Z+gGyESwuwouKnZnuRH2lkvxjcgDTA73eaLSVm8Wsyc6xicZmnbhisuocUfAlVEHcWac4k6nLSexRaYcNgCrVN7UATI8EXnhtcsgkjUby6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ti5p5tI2iE7szPj7jXma3WK/4GSQgnnNv6i7W1sj1ko=;
 b=YgAZ6pX54Uc7wa9pUmbg9T7wo5x4TFmKXdG/UAqyjFkdpLyRdNZIFe5TozFK3gi/gA60jJtXOY7IF1d0xNDisqTzJxWEI/tMe17a8go9TV2gFp6ki80B0OKfNZ5KzqvHJeHaaiuYeE7NtNd0DmHyAZuAIAka5T1/ga1o9xCN/S9OKZjLUiNWBBF6FYBd0oZ19F8aXsbiLFiZMniaRqq0xzUTsX0Ax6MqaPA+mc+Ir890zAPIuQBWSIONyJW8vW1rgYqn1P3PGRTPIPV/oGFx70hSncRn8+autuOZLWZeMbyhFIa6W7OsZsdMAMmy37Wz/4ztQOacZ+/1T7hE1o8pJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from AM6EUR05FT057.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc11::44) by
 AM6EUR05HT045.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc11::365)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Fri, 3 Apr
 2020 16:00:14 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:fc11::48) by AM6EUR05FT057.mail.protection.outlook.com
 (2a01:111:e400:fc11::78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Fri, 3 Apr 2020 16:00:13 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:693CFDB8977EF894EF2BE985D5AFABEA57B3697CAEF8657DB0919B68C0940238;UpperCasedChecksum:157273154DB50C800D4769FCDA5D7DDF00C1FB80F23EAA559FABF89490686D32;SizeAsReceived:9137;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2878.018; Fri, 3 Apr 2020
 16:00:14 +0000
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
 <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Message-ID: <AM6PR03MB5170EA00F0BB243010B7BFE5E4C70@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Fri, 3 Apr 2020 18:00:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR04CA0135.eurprd04.prod.outlook.com (2603:10a6:207::19)
 To AM6PR03MB5170.eurprd03.prod.outlook.com (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <4f811bbb-2ea1-f35e-b136-70fc6bdc5675@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (92.77.140.102) by AM3PR04CA0135.eurprd04.prod.outlook.com (2603:10a6:207::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend Transport; Fri, 3 Apr 2020 16:00:13 +0000
X-Microsoft-Original-Message-ID: <4f811bbb-2ea1-f35e-b136-70fc6bdc5675@hotmail.de>
X-TMN:  [TmgqZf7PDF/MYU1WV3RjvQHlJOlxHpxw]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: d3d46c75-7dae-4c03-14af-08d7d7e81840
X-MS-TrafficTypeDiagnostic: AM6EUR05HT045:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +BeQp/4FXIRsNqfzCpTd10KJv1anAlLXyO445eOy4s5rlxjlz3Rqsocsou2W/DaouuBSAWFu8+Y8mW3IWJCFTPiFRAgC7/p7nw5ZHGaDCDEwZYl4dLo3pXgj/5W0tnmkAPKtvFsIXh0WZsORcmPtnYWLDbS9zS+GTg31jyTVziFm6ShV3w1m1GZh3uLgwvAO5BApv1PX5OZgLVCbG3K6hPziiaUH/qUf82BlvfT4mjU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB5170.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: PqYLfrJv58SAjjNKRDFPIQc4Infnqe6V97hl65e/Ggi83G2xXfJduaSbzcSKEuLoL2+C0VXm26RZ03mUIACzVexd5I3jTmydiP3CNej+Puirumucz6AAvykviKJ5yYgbXEieb0+08LNFWOJdH4E3HQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d46c75-7dae-4c03-14af-08d7d7e81840
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 16:00:13.9309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6EUR05HT045
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/20 9:52 PM, Linus Torvalds wrote:
> On Thu, Apr 2, 2020 at 12:31 PM Bernd Edlinger
> <bernd.edlinger@hotmail.de> wrote:
>>
>> This is at least what is my impression how the existing mutexes are used,
>> a mutex called "cred_guard_mutex" is a not very good self explaining name,
>> in my opinion, it is totally unclear what it does "guard", and why.
> 
> Oh, I absolutely agree that cred_guard_mutex is a horrible lock.
> 
> It actually _used_ to be a lot more understandable, and the name used
> to make more sense in the context it was used.
> 
> See commit
> 
>   a2a8474c3fff ("exec: do not sleep in TASK_TRACED under ->cred_guard_mutex")
> > for when it changed from "somewhat understandable" to "really hard to follow".
> 

Ah, yes, there it was introduced.

That fixed only the case of a single-threaded process doing execve,
but missed to fix the case of a multi-threaded process doing execve,
and the other threads racing with the execve.  That is what happened
on my laptop, again and again, when I tried to fix a bug in the
gcc testsuite, that is while I wanted to track down another bug,
that is why the gcc testsuite left loads of temp-files in /tmp,
until I decided to go on a little bug-hunt in the linux kernel
instead :-/

And I had no idea what was happening at all.  But that way this bug
bit me again and again, until I realized the nature of the strace
problem, when I was really baffled.

Before I considered a linux patch for that I tried to fix it in the
strace code instead, and in fact I had tried two approaches,
one is wait in a signal handler, that did not work.
The second one is use another thread that does the wait, and that
did only work when I disable the PTRACE_O_TRACEEXIT flags.

I posted the two patches on lkml, just for reference.
Maybe you are amused by those patches. I consider that a craziness myself,
but it was indeed able to avoid the deadlock, with a user space change alone:

https://lore.kernel.org/lkml/AM6PR03MB5170D68B5010FCA627A603F8E4E60@AM6PR03MB5170.eurprd03.prod.outlook.com/


so that is more or less for your amusement, sincerely I would not propose
that as the way to fix the strace deadlock.


Bernd.

> Don't get me wrong - that commit has a very good reason for it, but it
> does make the locking really hard to understand.
> 
> It all used to be in one function - do_execve() - and it was holding
> the lock over a fairly obvious range, starting at
> 
>     bprm->cred = prepare_exec_creds();
> 
> and ending at basically "we're done with execve()".
> 
> So basically, cred_guard_mutex ends up being the thing that is held
> all the way from the "before execve looks at the old creds" to "execve
> is done, and has changed the creds".
> 
> The reason it's needed is exactly that there are some nasty situations
> where execve() itself does things with creds to determine that the new
> creds are ok. And it uses the old creds to do that, but it also uses
> the task->flags and task->ptrace.
> 
> So think of cred_guard_mutex as a lock around not just the creds, but
> the combination of creds and the task flags/ptrace.
> 
> Anybody who changes the task ptrace setting needs to serialize with
> execve(). Or anybody who tests for "dumpable()", for example.
> 
> If *all* you care about is just the creds, then you don't need it.
> It's really only users that do more checks than just credentials.
> "dumpable()" is I think the common one.
> 
> And that's why cred_guard_mutex has that big range - it starts when we
> read the original creds (because it will use those creds to determine
> how the *new* creds will affect dumpability etc), and it ends when it
> has updated not only to the new creds, but it has set all those other
> flags too.
> 
> So I'm not at all against splitting the lock up, and trying to make it
> more directed and specific.
> 
> My complaints were about how the new lock wasn't much better. It was
> still completely incomprehensible, the conditional unlocking was hard
> to follow, and it really wasn't obvious that the converted users were
> fine.
> 
> See?
> 
>                Linus
> 
