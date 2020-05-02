Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1959C47247
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 04:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9067C21924
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 04:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgEBELz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 00:11:55 -0400
Received: from mail-oln040092073024.outbound.protection.outlook.com ([40.92.73.24]:42715
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726435AbgEBELy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 00:11:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBVk7xCDw8WyLn1oEQZ0enanb8df/aJ3u3Ejs/faJkJCqUThFmZ4XTe26UqOBTzzzxIax1bJckZ765EXyPY1kMgJojN1Ebu2wsTeN4osk1bzKhlkR/H5vCqPFRDNSU0QH5yIlo+cHT6lZ2cJTNzWdxd0nvJWMuRhSDFFHSRvg8WVYf5N3zvj8OXBV4rt9YFPVDHMQ62X8qmKQVpNQ2Gr61lKZM7xRdsQfxYHbi6RlN5MwEF9fwF0uxQ9DSSDc62Q1cn3xC62UgJWMioiR1TBPwjl9H2c5mWNSWXRd2eiCVibaCtcuatjzLoHzx1mNGhLSwM+zU2xPdQOa24Tk5ENgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9GaaAWokBKd0BGK3Mhz3ce6Z1NdsKvNSEBzS6OSZ8k=;
 b=Sm1hgn7pyiNxPt5R7yibolP6Pz3UpYJ6XvgT4URYjfyr74nWMh99+ZC6k2Cd4q00wFuzLjOJlSURcmxYw7KGVzwfafxFEMOS24nHK8aj9v+cixk88AJldXAgwh2TQ00oyyATZYCc0X98o5pNdSYeX4hRP3DhGgPjek5OhuA0Z43B0qcrkATD796az6WAddHa1crzXcy6WQYDJpQ3CAIfHzIvcNHM0iudkXYpGiJhfFavukgVWIozVrECKvgfZqWW3PIEVKB0bAODtI/kOVeUIDfCbPZnc1lEAw7XA2fyh2QpiLy/vzZjDS3vTLkdeKjPlmIBFeRS52hQIqiwnh8gTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from DB3EUR04FT025.eop-eur04.prod.protection.outlook.com
 (2a01:111:e400:7e0c::4b) by
 DB3EUR04HT154.eop-eur04.prod.protection.outlook.com (2a01:111:e400:7e0c::147)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Sat, 2 May
 2020 04:11:50 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:7e0c::46) by DB3EUR04FT025.mail.protection.outlook.com
 (2a01:111:e400:7e0c::144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Sat, 2 May 2020 04:11:50 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:8A558AF297BCE602CD47BF71877AD57AD7547AF79784E9B5D650E9512DA9BA7E;UpperCasedChecksum:A23292D7BA8917051238E8DB504AA5A30153F71844D4281F3936DD9467F74A2B;SizeAsReceived:10008;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2958.027; Sat, 2 May 2020
 04:11:50 +0000
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <CAHk-=whTgFbjGTP=CqMWs_LOkY7bWvLQGYKwKx86amdbMovAkw@mail.gmail.com>
 <CAG48ez2-Nu2ALN6VEUZL-prtR_Kk8QYBHcnvuh0aU2e4zf37RA@mail.gmail.com>
 <CAHk-=wh=G47oD2F1CgOrvGFbEPh2ddMKLV4_wV_bs6S=98aZ5A@mail.gmail.com>
 <AM6PR03MB5170A6AA240D2E8F5E88B911E4AD0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wguiKq8yf11WJjgSL4ADKZ5sLe_Qbd7vHEqAkTvZJ+d+Q@mail.gmail.com>
 <CAHk-=wjUZLybZBJgOtD2gng=FS7USrbQQ1-tn5M+UP5DbCWdzw@mail.gmail.com>
 <CAG48ez0FL3i4eGFYryOwG2nnS+JigfKYAVSV9ogVHjmjOWzsrA@mail.gmail.com>
 <CAHk-=wgcvn1_1kCkyourNCKeH+KrzSMRvc-ai_NLU4RGZT_XBg@mail.gmail.com>
 <AM6PR03MB5170CCB8D9D41904066DAFD5E4AA0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wiOdXfMa35bwCNfCNSsAndO-hFmsSNRWEEDziA1iDYGjg@mail.gmail.com>
 <AM6PR03MB5170BC4A276D72EA54398C58E4AA0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wjhZ4uS6XKxJdV0MZO1AN-vhvVmeSeGFSntk1GjpyPwjg@mail.gmail.com>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Message-ID: <AM6PR03MB5170567B6E74DC8DA73CDC67E4A80@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Sat, 2 May 2020 06:11:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <CAHk-=wjhZ4uS6XKxJdV0MZO1AN-vhvVmeSeGFSntk1GjpyPwjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0073.eurprd02.prod.outlook.com
 (2603:10a6:208:154::14) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <47682826-dc1e-dc05-cf6e-bfe08cfa7756@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (88.68.2.53) by AM0PR02CA0073.eurprd02.prod.outlook.com (2603:10a6:208:154::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend Transport; Sat, 2 May 2020 04:11:49 +0000
X-Microsoft-Original-Message-ID: <47682826-dc1e-dc05-cf6e-bfe08cfa7756@hotmail.de>
X-TMN:  [+CJv+uvUjEPRbacAbAhpgStHYxP/UV0T]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 47c67542-1f8b-40f1-1b2a-08d7ee4ef02a
X-MS-TrafficTypeDiagnostic: DB3EUR04HT154:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z0bo49d3/ItCLadZM7HVYHIyEGGhuhBT3gTdouIfeyT0Qq1zahcyup0JeuN1ebKUADBKejgaphfBvAq+JBxSneiszt/jo4HEutee9o7PmACCMxFbInUdYuN48Wmf7hSlCW3UngRpaN/FWFd9lb5PZu/PfXF1XFkn++tG/JltXVSRy60/iXeSiJFhii6BD3KWFSsA8owHbN+litCWXdNO7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB5170.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: qnJ40cnlVhOLzlEsWouHg1ZQWQjDF+AVuoboXMdu/iUTRTuq2RfJ02LAzvwoN4Xs7kTCrekVSI1FhC8oBHioHyprapysVN5LtVDuzYKm7Db9deYufezuRMwt3EycrPYij6iz4IHqrTS0htCCW4Oqew==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c67542-1f8b-40f1-1b2a-08d7ee4ef02a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2020 04:11:50.3863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3EUR04HT154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/30/20 6:40 PM, Linus Torvalds wrote:
> On Thu, Apr 30, 2020 at 7:29 AM Bernd Edlinger
> <bernd.edlinger@hotmail.de> wrote:
>>
>> Ah, now I see, that was of course not the intended effect,
>> but that is not where the pseudo-deadlock happens at all,
>> would returning -RESTARTNOINTR in this function make this
>> patch acceptable, it will not have an effect on the test case?
> 
> So that was why I suggested doing it all with a helper function, and
> also doing that
> 
>         set_thread_flag(TIF_SIGPENDING);
> 
> because without going through the "check-for-signals" code at return
> to user space, -ERESTARTNOINTR doesn't actually _do_ any restart.
> 
> However, the more I looked at it, the less I actually liked that hack.
> 
> Part of it is simply because it can cause the exact same problem that
> ptrace() does (at least in theory). And even if you don't get the
> livelock thing, you can get the "use 100% CPU time" thing, because if
> that case ever triggers, and we re-try, it will generally just _keep_
> on triggering (think "execve is waiting for a zombie, nobody is
> reaping it").
> 
> IOW, restarting doesn't really fix the problem, or guarantee any
> forward progress.
> 

Right, if it is a real time process it will result in priority-inversion.
Correct.

If it is a virus checker it will be real time priority and it will be
very aggressive ;-) I can feel its aggressiveness already :-) shiver...

And this little zombie-process will paralyze it immediately, nice try.

You see what I mean?

> So I'd have been ok with your "unsafe_exec_flag" if
> 
>  (a) it had been done in one place with a helper function.
> 
>  (b) it would _only_ trigger for ptrace (and perhaps seccomp).
> 
> but I don't think it works for that write() case.
> 
> That said, I'm not 100% convinced that that write() case really even
> needs that cred_guard_mutex (renamed or not).
> 
> Maybe we can introduce a new mutex just against concurrent ptrace
> (which is what at least the _comment_ says_ that
> security_setprocattr() wants - I didn't check the actual low-level
> security code).
> 
> So maybe that proc_pid_attr_write() case could be done some other way entirely.
> 
> Th emore we go through all this, the more I really think that Oleg's
> patch to just delay the waiting for things until after dropping the
> mutex in execve() is the way to go.
> 
> Is it a "simple" and small patch? No. But it really addresses the core
> issue, without introducing new odd rules or special cases, or making a
> lock that doesn't reliably work as a lock.
> 

Hmm.  I think I can agree, that this problem deserves to be solved
really slowly.

Oleg where was your last patch, does it still work or does it
need to be re-based?

And I almost forgot about Eric, are you still with us?


Thanks
Bernd.
