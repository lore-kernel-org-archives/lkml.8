Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEA5C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D48A2077D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390003AbgDBTb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 15:31:26 -0400
Received: from mail-oln040092066091.outbound.protection.outlook.com ([40.92.66.91]:36268
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389108AbgDBTb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 15:31:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8NwLIbcfzCS0kyBpyv0mX8de4UdqDSyyq2dNdPP8eEOTV00dKg0F5V5ITwZdrseSM3nvQExtb2fizMG84iYEaAMDTWScu2LUq9IrldouenE1JrBEbV4HT7x1qu4tssjxPJFV2uTcy2BNkxVd84HVJvqfkW4iE0E7pdjag0ptOb5qgkE9X7LZLjz5a6z12OaYDDyZdpdanPz6rgJd6MbotsW406lhQekWmUqUyDP/E2kx9jU7t7/crO1ipRtidgNuAutV5xZAtbAZvcvfXG/WJnM4e/0PeKcUo4G8LAgRZeFL3e+T62kH9l4M8o5jFaE837I0+yOoPsuQgCF7TfKSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utPLiztr7RM+aXnQ784rgRdaHXbvOgye5Pmx8TWFxwc=;
 b=JmG1D1lvbZpvytXUsnQhGflvBAwso/JK6aVP4L28Ot19jNldqFMtJhWx7lef3XWFFaImO5PJGY/AOcF280QHAOaKfBpk+QxWM8LTGaPJ7w3eY7YfLfTkKHrbY9U51cVVSGaCiiWtR2C+UlWE6KPPLTp/TQoA6rgkEAKb2tLxe9+PHWF1mTADAm73TUcFpZZmyfrEOTDrOtUQl6BeEyccE5JKszAKITmNSioGrzTGSCZLjsqY0W4TcCrPc4woaq0TY5adH0W25SSmMbXj2wa3Z6ISRG2ypLpglirK215BF3Q8TZJAhSl4fVszLkXMma1jFMHXoKnA0Qae7EsfdXB6BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from VE1EUR01FT026.eop-EUR01.prod.protection.outlook.com
 (2a01:111:e400:7e19::51) by
 VE1EUR01HT043.eop-EUR01.prod.protection.outlook.com (2a01:111:e400:7e19::268)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Thu, 2 Apr
 2020 19:31:22 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:7e19::4a) by VE1EUR01FT026.mail.protection.outlook.com
 (2a01:111:e400:7e19::212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Thu, 2 Apr 2020 19:31:21 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:FE322B888A0485DBA9679DD00763300E7DE49CC0C92A24F3998C01D92FCF0E10;UpperCasedChecksum:65EC6181DB2DC3B4C16441A56ED39D6C14B714A43FEB6FDF81F2756F500D481F;SizeAsReceived:9008;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 19:31:21 +0000
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
 <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Message-ID: <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Thu, 2 Apr 2020 21:31:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::19) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <aacc688b-25d4-2162-b558-ff0ec7aae25b@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (92.77.140.102) by AM0PR01CA0006.eurprd01.prod.exchangelabs.com (2603:10a6:208:69::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend Transport; Thu, 2 Apr 2020 19:31:21 +0000
X-Microsoft-Original-Message-ID: <aacc688b-25d4-2162-b558-ff0ec7aae25b@hotmail.de>
X-TMN:  [ZfXDzZxllyB24z+ZmLYTu4KNxuBQtwjF]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: c5018108-db57-48f3-b98a-08d7d73c6c8a
X-MS-TrafficTypeDiagnostic: VE1EUR01HT043:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IY1wOw5k5UMYv9ZPBwIm9m0SQflyh4yqrhzSBz1NFVFztp9NvLwGZhSTPEq7vQjNQskNV0wS6474Z9X8qY4jbjD/nE4LyGObKL7j3ElkIX4Jh7vxdl9ziMxwIbEGyDBQgPTizJ4bgHwzAgi6jb4Dbksh36w6aDDR98uiMbC6hTuAe4/vi7f3jX2u4tWU19vF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB5170.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: xfHDc1NomokTHZDyxBCNcsgFH7y8sLYitVKKSGrk8hWJlyXP1pO4WOJoz0BAd7zM9LZ5IUiDP72LN2zqgOj0D89Jqek4j3c8K9RBreN+SiZYy6SdGs8yPl2GtplsAqWaBExvm5ZoWhaDksvQtuSqOg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5018108-db57-48f3-b98a-08d7d73c6c8a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2020 19:31:21.8932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR01HT043
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/20 9:04 PM, Linus Torvalds wrote:
> On Wed, Apr 1, 2020 at 9:16 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> The work on exec starts solving a long standing issue with exec that
>> it takes mutexes of blocking userspace applications, which makes exec
>> extremely deadlock prone.  For the moment this adds a second mutex
>> with a narrower scope that handles all of the easy cases.  Which
>> makes the tricky cases easy to spot.  With a little luck the code to
>> solve those deadlocks will be ready by next merge window.
> 
> So this worries me.
> 
> I've pulled it, but I'm not entirely happy about some of it.
> 
> For example, the "rationale" for some of the changes is
> 
>     This should be safe, as the credentials are only used for reading.
> 

What I meant, but did probably not find a good way to say it.

There are places where credentials of other threads are written,
e.g. set no new privs on a thread, that already started to execve
a setuid process.

You always have the right to change the credentials of the own thread,
you dont need a mutex for it.

This is at least what is my impression how the existing mutexes are used,
a mutex called "cred_guard_mutex" is a not very good self explaining name,
in my opinion, it is totally unclear what it does "guard", and why.


Bernd.

> which is just nonsensical. "Only used for reading" is immaterial, and
> there's no explanation for why that would matter at all. Most of the
> credentials are ever used for reading, and the worry about execve() is
> that the credentials can change, and people race with them and use the
> new 'suid' credentials and allow things that shouldn't be allowed. So
> the rationale makes no sense at all.
> 
> Btw, if "this only takes it for reading" is such a big deal, why is
> that mutex not an rw-semaphore?
> 
> The pidfd change at least has a rationale that makes sense:
> 
>     This should be safe, as the credentials do not change
>     before exec_update_mutex is locked.  Therefore whatever
>     file access is possible with holding the cred_guard_mutex
>     here is also possbile with the exec_update_mutex.
> 
> so now you at least have an explanation of why that particular lock
> makes sense and works and is equivalent.
> 
> It's still not a *great* explanation for why it would be equivalent,
> because cred_guard_mutex ends up not just guarding the write of the
> credentials, but makes it atomic wrt *other* data. That's the same
> problem as "I'm only reading".
> 
> Locking is not about *one* value being consistent - if that was the
> case, then you could just do a "get refcount on the credentials, now I
> have a stable set of creds I can read forever". No lock needed.
> 
> So locking is about *multiple* values being consistent, which is why
> that "I'm only reading" is not an explanation for why you can change
> the lock.
> 
> It's also why that second one is questionable: it's a _better_ attempt
> at explaining things, but the point is really that cred_guard_mutex
> protects *other* things too.
> 
> A real explanation would have absolutely *nothing* to do with
> "reading" or "same value of credentials". Both of those are entirely
> immaterial, since - as mentioned - you could just get a snapshot of
> the creds instead.
> 
> A real explanation would be about how there is no other state that
> cred_guard_mutex protects that matters.
> 
> See what I'm saying?
> 
> This code is subtle as h*ll, and we've had bugs in it, and it has a
> series of tens of patches to fix them. But that also means that the
> explanations for the patches should take the subtleties into account,
> and not gloss over them with things like this.
> 
> Ok, enough about the explanations. The actual _code_ is kind of odd
> too. For example, you have that "bprm->called_exec_mmap" flag to say
> "I've taken the exec_update_mutex, and need to drop it".
> 
> But that flag is not set anywhere _near_ actually taking the lock.
> Sure, it is taken after exec_mmap() returns successfully, and that
> makes sense from a naming standpoint, but wouldn't it have been a
> _lot_ more obvious if you just set the flag when you took that lock,
> and instead of naming it by some magical code sequence, you named it
> for what it does?
> 
> Again, this looks all technically correct, but it's written in a way
> that doesn't seem to make a lot of sense. Why is the code literally
> written with a magical assumption of "calling exec_mmap takes this
> lock, so if the flag named called_exec_mmap is set, I have to free
> that lock that is not named that at all".
> 
> I hate conditional locking in the first place, but if it has to exist,
> then the conditional should be named after the lock, and the lock
> getting should be very very explicitly tied to it.
> 
> Wouldn't it have been much clearer if you called that flag
> "exec_update_mutex_taken", and set it WHEN YOU TAKE IT?
> 
> In fact, then you could drop the
> 
>                         mutex_unlock(&tsk->signal->exec_update_mutex);
> 
> in the error case of exec_mmap(), because now the error handling in
> free_bprm() would do the cleanup automatically.
> 
> See what I'm saying? You've made the locking more complex and subtle
> than it needed to be. And since the whole point of the *new* lock is
> that it should replace an old lock that was really complex and subtle,
> that's a problem.
> 
>                    Linus
> 
