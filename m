Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E86EC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D662073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404115AbgDCPJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 11:09:14 -0400
Received: from mail-oln040092064018.outbound.protection.outlook.com ([40.92.64.18]:11076
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404051AbgDCPJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 11:09:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZSW+P/A2GBxJoHmN1Lbf78nzDdKKbzgu0IL+67jvIe+Mr4nsCEW9TGiDb8b6auTahlt7UjTeAxf3TAmrQhzzETwYY+3xShxaNZ7pU9ihb3EB9xzzvO7JHSYcIDFxS4PsRNOnf9vpOfPc212ErZFzhEbNXuPxZ4q+vbdk4xjtWOfox+wihuuK/frRL77bF2pXJ/75WJ8VK4zq7woKWRSZPQJn7opv3qglieGj8VvpOgrgEouiTPoaDAYpfOZyyhL2rnAkA2/TlwpvJrxM7x16GyK8GGHITFqnz8pQn/XH+QcTRBDl+W/y/1ro35MLtfpLDGWELWdFlOamEub45xXXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqrX44XB1yOARvoXhMXk5yLBeA2+FTYw4EWKcIaRlSQ=;
 b=KTm6XMaA7SQ6WD+cVIBupLaBNPuXZyK+30+VLsNqAzGLvzaAasCYDxOV/0keqlCSOjvw5xJzqCYacmcb6mJ4Vr8DJma2bv5liHsUzoWsq+Rkr+88Xu074rmj9a8VajUTmNLYDe89oiRp8RyU3IpvtcaPboOO3Ec3/RHVKXLBLcsCj3dtLOCn7Ckoac4CjPuFZWt/0Sl+D5B8+chF1nLWTwlhb/xAK45mujCbCWeMER3r9QWtVSvnp3Olwa2CJWso677CL4GDoYLM0nhtPwqSey1J++fR8ijSal8ZaK1/6vz8+KcfP/rQSNogiVCV7dog95jfd5WsYnyHWv/+p0oWtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from VE1EUR01FT050.eop-EUR01.prod.protection.outlook.com
 (2a01:111:e400:7e19::4c) by
 VE1EUR01HT009.eop-EUR01.prod.protection.outlook.com (2a01:111:e400:7e19::211)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Fri, 3 Apr
 2020 15:09:09 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:7e19::49) by VE1EUR01FT050.mail.protection.outlook.com
 (2a01:111:e400:7e19::288) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Fri, 3 Apr 2020 15:09:09 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:F02954AB5EC6262C12526CD4B65B5AE8789F9FDB84C3E2F1623D275B71D9D68F;UpperCasedChecksum:F86FBB3EFD19658BE32E7ABDAE43BE77FF69A0E7F70C0EEE97B9488FC353D806;SizeAsReceived:8993;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2878.018; Fri, 3 Apr 2020
 15:09:09 +0000
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
 <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Message-ID: <AM6PR03MB517026CDE64EC57DE37C6080E4C70@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Fri, 3 Apr 2020 17:09:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0902CA0022.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::32) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <0b287702-5143-41c3-f115-7e06c184c53b@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (92.77.140.102) by AM4PR0902CA0022.eurprd09.prod.outlook.com (2603:10a6:200:9b::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend Transport; Fri, 3 Apr 2020 15:09:08 +0000
X-Microsoft-Original-Message-ID: <0b287702-5143-41c3-f115-7e06c184c53b@hotmail.de>
X-TMN:  [2dKKv6YOmQrTdCVitwEGHpDlmhgsCq/v]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: fb7da353-804d-40a9-8237-08d7d7e0f548
X-MS-TrafficTypeDiagnostic: VE1EUR01HT009:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CnKGV0Ynv6joLG3jArpNCRxt5EEMtoNWBFYomGTacG7X4CGI95vb2OIwPFFwZn4XyPNc1jpxqeCA2LeHr8/tSkfgbGMPiwCZgoYE+rm/QrjSocstZRbpa/1XjlfvsvW10mc9ay8OJAsRnQ1P700059q2bQBKhVrCe/PPVxU/YIxUOS4YYW4rp6qEjKl2SMRu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB5170.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: 01BhgUrF/uqHELBAewEQd3BystxXG48Nr3G4pY24F00tAVahcigEaIqJZed9eRhCq4VYjpWQjpPK3C0iOUQZDm9L/E9SU53Oc4Ol98Kyc5kWyjP7mLP98aSB2HFX75eH4Eiqur7GmtuUgTWAYG4kWQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7da353-804d-40a9-8237-08d7d7e0f548
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 15:09:08.9927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR01HT009
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

Can we still edit the change logs, maybe that is a clear indication
that they are not sufficiently clear, when one don't understand the
patch without following the whole email thread.


> A real explanation would have absolutely *nothing* to do with
> "reading" or "same value of credentials". Both of those are entirely
> immaterial, since - as mentioned - you could just get a snapshot of
> the creds instead.
> 

The problem we have here is that *another* thread can change no_new_privs
of the execve thread, that is a write.  I think that must be avoided
whatever it costs.  Those are the hard issues,
and reading another thread's credentials, an taking a reference of the
vm need to be consistent, so should just not happen while the vm
is updated, but the credentials not yet.

Or am I missing something here?

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

:-)

> Ok, enough about the explanations. The actual _code_ is kind of odd
> too. For example, you have that "bprm->called_exec_mmap" flag to say
> "I've taken the exec_update_mutex, and need to drop it".
> 

previously that was bprm->mm == NULL, that is even more hacky.

> But that flag is not set anywhere _near_ actually taking the lock.
> Sure, it is taken after exec_mmap() returns successfully, and that
> makes sense from a naming standpoint, but wouldn't it have been a
> _lot_ more obvious if you just set the flag when you took that lock,
> and instead of naming it by some magical code sequence, you named it
> for what it does?
> 

Linus, I take full responsibility for this part of the patch.
In this case, I just did not want to change the name again.
That name was in a previous version of my patch, that I merged
with Eric's and at the same time had to fix the mutex-lock-order
issue in Eric's original patch.  But if anybody would have
suggested a better name, and advised me to pass a parameter to
exec_mmap that would have happened.
So a kind of laziness on my side, and unfortunately I forgot to
point to all the changes in a revision log, I usually do that,
but this time I forgot it somehow.  This was a 16-part patch
series at that time, so I just was really busy with following
each mail of the previous patch version, and also get the latest
revision of the change log (I use the mail maybe I should have
pulled Eric's tree, but I am still a newbie here ... :-) ).
Anyhow I was surprised that Eric did not see my changes by
looking at them, but that is the human nature, nothing to be
blamed for.


> Again, this looks all technically correct, but it's written in a way
> that doesn't seem to make a lot of sense. Why is the code literally
> written with a magical assumption of "calling exec_mmap takes this
> lock, so if the flag named called_exec_mmap is set, I have to free
> that lock that is not named that at all".
> 

Names can be changed.  In the peer review everybody was happy with it.
But that is not set in stone.

Initially I only wanted to address the ptrace attach, but Eric
came up with the user mode page fault handler, that made the patch
a lot more complicated, if that goal is dropped, also the place
where the mutex need to be taken could be a different one.


> I hate conditional locking in the first place, but if it has to exist,
> then the conditional should be named after the lock, and the lock
> getting should be very very explicitly tied to it.
> 
> Wouldn't it have been much clearer if you called that flag
> "exec_update_mutex_taken", and set it WHEN YOU TAKE IT?
> 

Can be done.  I don't care.  It is one additional register taken
with a parameter to exec_mmap and it is probably inlined, nothing
more nothing less.


> In fact, then you could drop the
> 
>                         mutex_unlock(&tsk->signal->exec_update_mutex);
> 
> in the error case of exec_mmap(), because now the error handling in
> free_bprm() would do the cleanup automatically.
> 

The error handling is sometimes called when the exec_update_mutex is
not taken, in fact even de_thread not called.

Can you say how you would suggest that to be done?


> See what I'm saying? You've made the locking more complex and subtle
> than it needed to be. And since the whole point of the *new* lock is
> that it should replace an old lock that was really complex and subtle,
> that's a problem.
> 
>                    Linus
> 
