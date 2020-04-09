Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCC0C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 23:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E512072F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 23:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgDIXw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 19:52:58 -0400
Received: from mail-oln040092073024.outbound.protection.outlook.com ([40.92.73.24]:9270
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726779AbgDIXw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 19:52:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LguFHqlr3Eybk7OWJei8FzHwLHBK7NezTRd/226bRbBw5FitBCfNIIIFuzC2ubmXb220ud8qUIEHIK6vSk7sH1apfd8AqaaHBiNL1iQArI9bS/mxYuBGbrFHY62VRhegCqGN8dqNwab8Wa6rRrKYNZx15X1X/jd6JnKpeWekVzfyPEP7kfQdzPQLPDovAMJjhaCnhmmLvsotr+cNkVKfmOJFKVie7+DDD6m1hW8JCTY68kI3RR4pMGa9BnYgwRKkNXTQtBGpK99sijv01TpiEVvTWn5p27Z5qHkDvzJ8p1hM5oKTFvnuYPA0M4GI6/qBhyMv9qvVqtu9Wy1+5AVYiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1E9TKUrBl3MG6Ff1TYslQFY4v4uCho1ojwGC6cjmRI=;
 b=broP2CGw/uwbEC/heJyFlPi5OjQngA4zDcT7tXQ6OVkYKaIQSepr15rdLD82N6XjMe/9550nXhJimd3YVWYy9fj2lV4WFZHQRuUG1RSs5gn7V+nKTj53s1i1mcRBpVQKnNilFBz7Brf1y+WlWJzFOc/rYrheATASas3jgKH1bzu5bebOScqTXQuIqfmEnpMA6GZ9xA9rd3enjtG93sDq1mzWXzy9HSi+XPBORqvf2q1U5zeKXtfaKyQDV3Kj61S+AKhiZ74FOoh1NA5PYjaeMr1SQZn4yj9t2nju2ySaPi2mI33VIn0nuAQnWGAqyP4Z2Z7ZyRWKbL8MIvfnL4WAAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from VI1EUR04FT028.eop-eur04.prod.protection.outlook.com
 (2a01:111:e400:7e0e::42) by
 VI1EUR04HT237.eop-eur04.prod.protection.outlook.com (2a01:111:e400:7e0e::153)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.18; Thu, 9 Apr
 2020 23:52:54 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:7e0e::50) by VI1EUR04FT028.mail.protection.outlook.com
 (2a01:111:e400:7e0e::316) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Thu, 9 Apr 2020 23:52:54 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:ED6FA3CE22724CEEE08AB0B89B25D9330267CDC88B90E003CCF1B9714DF1FCAA;UpperCasedChecksum:2CDF8FDEBE5BD2B000C511AD3930E4B6A9D93D8B877EB93A992870456D61A78F;SizeAsReceived:10006;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2878.022; Thu, 9 Apr 2020
 23:52:54 +0000
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
 <CAHk-=wih4BqW7GTLaYxewynuT-iFHrXroip0wNo0CyPtmYGUow@mail.gmail.com>
 <87y2r4so3i.fsf@x220.int.ebiederm.org>
 <CAHk-=wjhAvv6s_7OVeZJiHaY7bBrHyiPTkSpq-TLr6qxYqxUUw@mail.gmail.com>
 <CAHk-=wi0jrKv9x6vJ9FDgTrSUbdbZYDX-79T-E87C48MGSn5=g@mail.gmail.com>
 <87wo6or3pg.fsf@x220.int.ebiederm.org>
 <AM6PR03MB51708FD4226E07AB7CB0D6A7E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wjaoYM4gXdAyYY=u8PaYj2LXUvcfp=8DKum8f1DM+Ws0A@mail.gmail.com>
 <AM6PR03MB5170F924EA69A81D79BD0929E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whMKC5F-=QQP=fCNRuTF+ZGiNtLEKvx7KekpK1JtrwDhw@mail.gmail.com>
 <CAHk-=whJ8khGBqfqh6ZmHsKjcyyBLm5xgkgLW_AC_=82iFBWoQ@mail.gmail.com>
 <AM6PR03MB51700B243E34BF4A59FF33CFE4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <87imi8nzlw.fsf@x220.int.ebiederm.org>
 <CAHk-=wgh4zts+3hdkGzHLJ6pBGumcJ=23gRbMfubDrLstis2Bg@mail.gmail.com>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Message-ID: <AM6PR03MB5170ACF14523C7C41F960D92E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Fri, 10 Apr 2020 01:52:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <CAHk-=wgh4zts+3hdkGzHLJ6pBGumcJ=23gRbMfubDrLstis2Bg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR05CA0093.eurprd05.prod.outlook.com
 (2603:10a6:208:136::33) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <af75c554-105b-ba7f-acc3-88306bf19865@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (92.77.140.102) by AM0PR05CA0093.eurprd05.prod.outlook.com (2603:10a6:208:136::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 23:52:53 +0000
X-Microsoft-Original-Message-ID: <af75c554-105b-ba7f-acc3-88306bf19865@hotmail.de>
X-TMN:  [i2R2kHUeCCshoaamkEqpvVbAWUa7huXp]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: eb06d137-46bb-45bf-ef72-08d7dce11ea4
X-MS-TrafficTypeDiagnostic: VI1EUR04HT237:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TSe/5mYxuX05FUtbEqvA54kHD016CEcQOwKfUaGYxlizZcmlbTRy0Ym/J+hytyyh/Fewk56/bg3Vm+Abilat56NENxBUdNALS1KdkFxzIkt0JACPdugjFk6qM+Tzm4D8OsnuwjLNOnkiXm7VlMAYf/ER5zKNlKaxnX2Y7OnRPOsUjfUwZeWX3JXE2G6N6wOX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB5170.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: z4q47PFkPaYI1H7aDrje2mKRa+L/GhV8B7BhGWP7+xniAwAouCiMHZaN2yAJQSIV6MbiD8pxtRg7v3/ZF4Q6irQCFQZLiZzjKvQBd1CQfjrFWxNpFjOgFvwenvmiyF9gasgO7dX1LzjHyI5Hs/x9FQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb06d137-46bb-45bf-ef72-08d7dce11ea4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 23:52:54.3768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1EUR04HT237
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/9/20 11:17 PM, Linus Torvalds wrote:
> On Thu, Apr 9, 2020 at 2:03 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> But no.  While you are goind a good job at spotting odd corner
>> cases that need to be fixed.  This also is not the cause of the
>> deadlock.  It is nothing that subtle.
> 
> So Eric, I'm now going to stop wasting my time on arguing with you.
> 
> Since both you and Bernd claimed to be too busy to even bother testing
> that thing, I just built it and booted it.
> 
> And guess what? That thing makes your non-deadlock thing go away.
> 
> So it's _literally_ that simple.
> 

You known I was right from the beginning :-) :-) (-: (-:,
I said you would have to adjust the test.  I only thought of the
second part, so that is were I was wrong.

Yeah Thanks.  My real problem is called OpenSSL 3.0 + FIPS and it feels
like a very big pain in the ass......

But please tell nobody.  That is a secret :-)


Thanks
Bernd.

> Now, does it make the tests "pass"? No.
> 
> Because the "vmaccess" test fails because the open() now fails -
> because we simply don't wait for that dead thread any more, so the
> /proc/<pid>/mem thing doesn't exist.
> 
> And for the same reason that "attach" test now no longer returns
> EAGAIN, it just attaches to the remaining execlp thing instead.
> 
> So I'm not just good at "spotting odd corner cases". I told you why
> that bogus deadlock of yours failed - the execve was pointlessly
> waiting for a dead thread that had marked itself ptraced, and nobody
> was reaping it.
> 
> And it appears you were too lazy to even try it out.
> 
> Yes, that whole "notify_dead" count vs "tsk->exit_state" test is
> fundamentally racy. But that race happens to be irrelevant for the
> test case in question.
> 
> So until you can actually add something to the discussion, I'm done
> with this thread.
> 
>            Linus
> 
