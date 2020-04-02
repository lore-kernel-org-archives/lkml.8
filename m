Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F194CC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 21:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFDA42064A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 21:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389642AbgDBVAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 17:00:04 -0400
Received: from mail-oln040092075045.outbound.protection.outlook.com ([40.92.75.45]:63811
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730837AbgDBVAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 17:00:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNreO0ADYDlwQLyTYvOLJbOVLuflhipC6wpHEb4oH9CcRihGviKYjBPPY7BFnAaQgua6HMmdQSePzjre119dK0kmkeffd23/w38EDVbOALQF63ulc6A/CPBe5HbUGsMbaeIRzrRIQa7bMobq5i6z2KfwZxVsDBZ3QZmrO/OviOm5JmskoN3Zi4/FKeeOBxu3T4NLdnzJ2PjiO/rDwEDcAGOE3FocG+iq6molH0Q16898bkWk3WiuwS9bYBd3m3V6WM4HaY+hjoOMsqgI67YsrKkoBe1/n44JpNiu9RfXXGKaRle4ZsffVWbhYTGEW8JQAJHBM5en1tS2fjd0ZmGcfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAVMN8loQCwplrllgHKojroKw8IX7q5nZkcE6y7aLsk=;
 b=XKx6n38bBefha+J9Opbt1/8LJiCs5X3osxXQ6xcsu6lCuLUBeCjVb/b95K5qZWMR/J4KxI/25anpLL8PjBsXW3MrSN4gQdbUzly0rBwbaSek79l+vQR3p35IOP7D4ghxY/JF+Ur9wI97Tpq0Q770Y3IfYNueEgLW5ebt5jZ//UJcnN/LTI7zHLpqh3nIZ3W1Ksut0OeIjL6TJQBjpuorRfOlh/Dp31jmcyIxoasxInP/ktsgzYoBqQycorBfuQTVBmzZ8QHxG9/ruGBn390zgmgxcxDsD9baPt1ejWlzheVMdVvssfees9S8cr/58puWOKgSXj2oYYWl2XIG+vVQIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from DB3EUR04FT047.eop-eur04.prod.protection.outlook.com
 (2a01:111:e400:7e0c::4f) by
 DB3EUR04HT123.eop-eur04.prod.protection.outlook.com (2a01:111:e400:7e0c::161)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Thu, 2 Apr
 2020 21:00:00 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:7e0c::40) by DB3EUR04FT047.mail.protection.outlook.com
 (2a01:111:e400:7e0c::293) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Thu, 2 Apr 2020 21:00:00 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:0EF2452AF26EE9812BCC337641DC2250446EB40302B113299F8C189ED0088693;UpperCasedChecksum:5DAE5EB5496F37433A30A1A591E5187A12A1A189DC932AC81EA8AF14144B255B;SizeAsReceived:9154;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 21:00:00 +0000
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
Message-ID: <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Thu, 2 Apr 2020 22:59:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::29) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <5f9851de-925d-fd1c-4150-438484c28c0c@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (92.77.140.102) by AM0P190CA0019.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend Transport; Thu, 2 Apr 2020 20:59:59 +0000
X-Microsoft-Original-Message-ID: <5f9851de-925d-fd1c-4150-438484c28c0c@hotmail.de>
X-TMN:  [t+82VckFnFTHryLcSmieufNxJcHAgR05]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 40246abb-ace8-4898-74ed-08d7d748cea3
X-MS-TrafficTypeDiagnostic: DB3EUR04HT123:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3VtokXfdFPTHzbrqc7eY6iZ6XM6HRR6rVEJAwOzX0p8axRFC8OkkStAgR1ROeO8gu/FIcYhkEBjIIj1hhEkkfjbgQEe4F/GaNjpGuavPZAzRX2murQRihFnDXPj0kq+gwPYv+9QB2FZxME9kKHsvS3199Xo/nxDDZL77QVOloslu3UhGbUhaUNIYXNSIXzkAQwRZIOJdiC+nYTAcyjk5FAVc2dmAqzNp9e+TXdhqS7A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB5170.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: bz5yBvtGP5NnDiendGtpm7T2O5TfRRsLr1lz6IAMbj1sKjDvlU7EDg0+gkp2nNjuoB2iQcP0ln1m4lvO35YtIfGNrFobzopvGgaYkH9tdSnxd28sabocEFaLyUDQn19NhdHOebePujKBrbxk5UbRkQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40246abb-ace8-4898-74ed-08d7d748cea3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2020 21:00:00.3738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3EUR04HT123
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
> 
> for when it changed from "somewhat understandable" to "really hard to follow".
> 
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

Understand completely.  The change is in a way mechanic, that is we
have the following sequence:

1 execve starts
     |
     |    access args, may fault, deadlock in user mode fault handler
     |    de_thread, may block waiting for strace to call wait and so
     |
     |    exec_mm_release, may also falut, deadlock un user mode fault handler
     v
2 process update begins
     |
     |    should not block, to our current knowledge (except when loading a nfs image probably ?)
     |    credentials may change at any time.
     |
     v
3 process update done
     |
     v
4 execve done


So we have functions that access the process memory map. they use the credentials
and need to access the correct image, not to reveal secrets of the new about to be
loaded image.  they need the inner mutex from 2 .. 3

Also when you want to read credentials of another thread, it is probably better
to have a consistent state of the credentials, and no new privs for instance.
That also needs the inner mutex from 2 .. 3

And then we have things that change the credentials or no new privs, in general
all ptrace_attach and security modules are of that kind.  They need the
mutex from 1 .. 4, but I want to change the name, in the two patches below, and
I want to break the dead-lock from ptrace in a API-incompatible way, but in a
very limited breaking change, that only breaks what is already broken.


There are two more patches, which might be of interest for you, just to
make the picture complete.
It is not clear if we go that way, or if Eric has a yet better idea.

[PATCH v7 15/16] exec: Fix dead-lock in de_thread with ptrace_attach
https://www.spinics.net/lists/kernel/msg3459067.html

[PATCH v6 16/16] doc: Update documentation of ->exec_*_mutex
https://www.spinics.net/lists/kernel/msg3449539.html



Thanks
Bernd.



>                Linus
> 
