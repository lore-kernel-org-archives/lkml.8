Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C753FC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 05:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994DE20721
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 05:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731568AbgDCFJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 01:09:41 -0400
Received: from mail-oln040092074071.outbound.protection.outlook.com ([40.92.74.71]:65255
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730236AbgDCFJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 01:09:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CD5atENJwbY/rVFmP8o3ZXyUIpHhR41RIQo+1PboyaARHsSqfiNSBMACjI8TBIkgdFwbU6Dr2wIAqIBvq4Xk6J/iG08OlRtdIYxXupDjJvvsf57yeDzQoltpynp/ds9ayKmo5MPTlctTWFAvilKc77H34MUVppAbj2C/hEyY+leUss1/HQcG+umzkJniA44mKQIKU3jnuMS38N3xA3c3MGWsGGbAkg05+RCUbYTn9oq74Jxq8y6L79uaS1P8NWKV2QCy165hLliz447qfX0vVn0G6g9fIRj/y92yr+G2HpAFNGMFSA6OF5oUEfXZtsOwX9lri8NMFuFPAHR110gIaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+h3kbGVoI03DAJsLjGX5WHQ5eaEQGOlED5N9j6fOa24=;
 b=CSNTnS5+ZKl4a0Sa/aiwbY7om01VATtcQaDF5dHpQ6LeEO0m8ZAEJjPjn1J1W+sNJpXgatVAdVHUEWfWJeouDsLMsQHZufwwlwhTozV1HUkgB+TjU3xQe7jnhaKXqspLgu5ERO3UIzMqn4iDj5rKbQlc1w406lupoABoknl3+ZvxJesAP+ngEGJHdlgW7aiGC3g+jKXe+KJK6Q9nWc36Kj3xYgqXDUAbmIFxH4O4nMKAX7e3MWVrBwv3FTgtBrvjQ1KwTe/jzEgxjVo45LXtAlqYI2m2ChDWuOpp/EPC/LTz1Zac83jAJ8s/7qntstsGVQTAeLHQ3c9TD18OiwurBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from VI1EUR04FT047.eop-eur04.prod.protection.outlook.com
 (2a01:111:e400:7e0e::42) by
 VI1EUR04HT247.eop-eur04.prod.protection.outlook.com (2a01:111:e400:7e0e::304)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Fri, 3 Apr
 2020 05:09:36 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:7e0e::4f) by VI1EUR04FT047.mail.protection.outlook.com
 (2a01:111:e400:7e0e::81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Fri, 3 Apr 2020 05:09:36 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:BB9B821BEC1E9F2E95B30F1D9158B9BEF33CF2B28FD1A1DF0814E7C1E723FC9E;UpperCasedChecksum:F28A6E2484970651FA2FA494D9E7A8316501E8584FFA1633A2A65C80FAD8D84C;SizeAsReceived:8490;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2878.018; Fri, 3 Apr 2020
 05:09:36 +0000
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
 <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
 <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
 <87lfnda3w3.fsf@x220.int.ebiederm.org>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Message-ID: <AM6PR03MB5170C36112DA316517464683E4C70@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Fri, 3 Apr 2020 07:09:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <87lfnda3w3.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0902CA0016.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::26) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <a2952a09-a2f4-b142-7636-2a6fdc2c7710@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (92.77.140.102) by AM4PR0902CA0016.eurprd09.prod.outlook.com (2603:10a6:200:9b::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend Transport; Fri, 3 Apr 2020 05:09:35 +0000
X-Microsoft-Original-Message-ID: <a2952a09-a2f4-b142-7636-2a6fdc2c7710@hotmail.de>
X-TMN:  [sbA0gSpdEo4gnA54OlVzLpmVoXQN3uSN]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: d5735eec-c9d4-49ae-ac33-08d7d78d341e
X-MS-TrafficTypeDiagnostic: VI1EUR04HT247:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hOG7NFajuMENaVEOIdxifHhA4RFEM1ubXcI6zrJ2B23wup3zNhX8Hds1u7rJk07N+Bk1GEt7w4Pll0LFfX0iLoXkqg2JjCArAuqduxwd8hmtSXKYAsiIw/zptYSXXorcFD1Fnwj5CllJjz592igBVncELxtSscLnwUbi/8vRV3g8S6TJsj+zaIT6I6x2Q3WI1Yyfp1B9KST+h466YK4Q2Cv4zsOkQxYAbqLO/p7xQQ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB5170.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: 4QXWdIV/YNe4gRgOwajkRNhjtKnopi7ca1JOhYcKPxdUBCdeowyX4ZLGOIFDoKntL+10qXcZLmS7PJJvD/dsYglPYHZPRRLXsajt8m1RzNBk/msTNG5XZfDeiWPEWw03cO5VDDD5XcR+Phi33p9Clw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5735eec-c9d4-49ae-ac33-08d7d78d341e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 05:09:36.3778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1EUR04HT247
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/20 1:01 AM, Eric W. Biederman wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
>> On Thu, Apr 2, 2020 at 2:00 PM Bernd Edlinger <bernd.edlinger@hotmail.de> wrote:
>>>
>>> There are two more patches, which might be of interest for you, just to
>>> make the picture complete.
>>> It is not clear if we go that way, or if Eric has a yet better idea.
>>>
>>> [PATCH v7 15/16] exec: Fix dead-lock in de_thread with ptrace_attach
>>> https://www.spinics.net/lists/kernel/msg3459067.html
>>
>> There is no way I would ever take that patch.
>>
>> The amount of confusion in that patch is not acceptable. Randomly
>> unlocking the new lock?
>>
>> That code makes everything worse, it's completely incomprehensible,
>> the locking rules make no sense ahwt-so-ever.
>>
>> I'm seriously starting to feel like I should not have pulled this
>> code, because the future looks _worse_ than what we used to have.
>>
>> No. No no no. Eric, this is not an acceptable direction.
> 
> That is not the direction I intend to take either.
> 
> I was hoping I could put off replying to this thread for a bit because
> I only managed to get 4 hours of sleep last night and I am not as alert
> to technical details as I would like to be.
> 
> Long story short:
> 
> The exec_update_mutex is to be a strict subset of today's
> cred_guard_mutex.  I tried to copy cred_guard_mutex's unlock style so
> that was obvious and that turns out was messier than I intended.
> 
> I thought the changes to the individual locking changes were
> sufficiently unsubtle that they did not need my personal attention.
> Especially as they are just a substitution of one lock for another
> with a slightly smaller scope.
> 
> I started working on the the series of changes that reorganizes
> the changes in exec.
> 
> It was reported that something had gone wrong with my introduction
> of exec_update_mutex and I pulled it from linux-next.
> 
> By the time I was ready to start putting humpty dumpty back together
> again Bernd had collected everything up and had it working.  I had seen
> that he had been given the feedback about better change descriptions.
> 

Sorry, I did it as slowly as I could possibly do.
I wanted to wait for you, but....


> I had looked at the code of his patches earlier and the basic changes
> were trivial.
> 
> Since I thought I already knew what was in the patches and the worst
> problem was the missing unlock of cred_guard_mutex, and I know Bernd's
> patches had been tested I applied them.  I missed that Bernd had added
> the exec_mmap_called flag into my patch.  I thought he had only added
> the missing unlock.
> 
> I spotted the weirdness in unlocking exec_update_mutex, and because it
> does fix a real world deadlock with ptrace I did not back it out from my
> tree.
> 
> I have been much laxer on the details than I like to be my apologies.
> 
> The plan is:
> 	exec_udpate_mutex will cover just the subset of cred_guard_mutex
>         after the point of no return, and after we do any actions that
> 	might block waiting for userspace to do anything.
> 
> 	So exec_update_mutex will just cover those things that exec
>         is updating, so if you want an atomic snapshot of them
>         plus the appropriate struct cred you can grab exec_update_mutex.
>         
> 	I added a new mutex instead of just fixing cred_guard_mutex so
>         that we can update or revert the individual code paths if it
>         is found that something is wrong.
> 
> 	The cred_guard_mutex also prevents other tasks from starting
>         to ptrace the task that is exec'ing, and other tasks from
>         setting no_new_privs on the task that is exec'ing.
> 
>         My plan is to carefully refactor the code so it can perform
>         both the ptrace and no_new_privs checks after the point of
>         no return.
> 
> I have uncovered all kinds of surprises while working in that direction
> and I realize it is going to take a very delicate and careful touch to
> achieve my goal.
> 

That worries me a bit.
Could you please share details of the failed attempts with us,
Leaning from failures could help us better understand the issue.



> There are silly things like normal linux exec when you are ptraced and
> exec changes the credentials the ordinary code will continue with the
> old credentials, but the an LSM enabled your process is likely to be
> killed instead.
> 

Please elaborate on the details.

> There is the personal mind blowing scenario where selinux will increase
> your credentials upon exec but if a magic directive is supplied in it's
> rules will avoid setting AT_SECURE, so that userspace won't protect
> itself from hostile takeover from the pre credential change environment.
> Much to my surprise "noatsecure" is a known and documented feature of
> selinux.  I am not certain but I think I even spotted it in use on
> production.
> 

Also here, it might help to make us aware of the problems you face.

I also considered moving all the credentials to the inner block,
but had the impression that is probably a really tough problem instead.

I wondered what happens if a ptraced execve process executes a
suid program that is.  Don't you need different credentials
when you are pthraced, I mean, doesn't that override the suid bit,
while when not ptraced, you be root user, and have all the root
powers to load the image in the new vm?

Isn't there a race when execve starts, and ptrace attach happens later?


Thanks
Bernd.

> I will catch up on my sleep before I allow any more changes, and I will
> see replacing the called_exec_mmap flag with something saner.
> 
> Eric
> 
