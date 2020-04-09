Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AF1C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A604206F5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgDIRqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 13:46:22 -0400
Received: from mail-oln040092066100.outbound.protection.outlook.com ([40.92.66.100]:60727
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726477AbgDIRqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 13:46:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMZCjUyJfX+zK69xaecGcjcwlDo/D9ViF87z9UZmmKOav2W2HIHlShdd5+ZlnFbmC3JPCxB3t6b1ZcTmjt1dxndMsfHFcXoFVrf6XJcjywM7PgnwBvKDRyGmLYUcOpsC8J6fDMhoR3D75OO8C+h0HE5xsUOpvatbijWWyIj6C4k7GmWmDMgCBQCZ+eekT610Nu8om8YkJhLqMN1uGWtHTdLqIPTej303QsyE8GkuUgmMF632O1WJFZA9y+q39LgEnVf8SPslKyZKQjLrM/jHHrIpmqpsf6Feef6f/RS+6KxJqufSLqkCQLCiSMzrpx3AZBJbwU6zTLL7F5drQqbRIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2l5LTsMD4XpDDcVgUR1B/tKE9oaXuLAQ+HA6P1o6HoA=;
 b=FUXrp8Vw2wsNVJ6LWn2gMcteZI/SDyapa7lGPc2v3ZB9d/6G9yagLplPVNbum+nB5GAt/30i0R4KplOgiObNrRFznr9hPS1/5WM8B3XE8gjoC8D90i4exyQ+H7QXSIe4O+5W1vu+fXqY9PGJ0V1+P0uEiV8ea832JrfyPTltYGiGX5Jb2026RpP5Y5unLIShLrurHNVd1Djq+MtrYIc900oIdx8ivkMXNFsMdW/nS7wqit3FXlPQnQUFGKVlLGoocwXq5S8XQR5HBEWUjvvyJrNqmRplJb6UgmdqUej7cbd3I70GXJxbmZ8X1sAtrUqnkU1G+WyKY6RaQs1JObxfSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from HE1EUR01FT059.eop-EUR01.prod.protection.outlook.com
 (2a01:111:e400:7e18::42) by
 HE1EUR01HT191.eop-EUR01.prod.protection.outlook.com (2a01:111:e400:7e18::366)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 9 Apr
 2020 17:46:19 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:7e18::51) by HE1EUR01FT059.mail.protection.outlook.com
 (2a01:111:e400:7e18::241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Thu, 9 Apr 2020 17:46:19 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:568466D9C345ED6227EA499E06FB595ED461CF1CF00E190DAE702D88B5702EB4;UpperCasedChecksum:5AEE68381C373F80A89D727F0EB51A0FE02FF0662E18D1C14DA22FE455FF8B8C;SizeAsReceived:10004;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2878.022; Thu, 9 Apr 2020
 17:46:19 +0000
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
 <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
 <87lfnda3w3.fsf@x220.int.ebiederm.org>
 <CAHk-=wjxyGCj9675mf31uhoJCyHn74ON_+O6SjSqBSSvqWxC1Q@mail.gmail.com>
 <87blo45keg.fsf@x220.int.ebiederm.org>
 <CAHk-=whES-KCO6Bs93-QBK1tS5CfiWSi+v5D1a7Sc1TD5RFoaA@mail.gmail.com>
 <87v9maxb5q.fsf@x220.int.ebiederm.org>
 <CAHk-=wih4BqW7GTLaYxewynuT-iFHrXroip0wNo0CyPtmYGUow@mail.gmail.com>
 <87y2r4so3i.fsf@x220.int.ebiederm.org>
 <CAHk-=wjhAvv6s_7OVeZJiHaY7bBrHyiPTkSpq-TLr6qxYqxUUw@mail.gmail.com>
 <CAHk-=wi0jrKv9x6vJ9FDgTrSUbdbZYDX-79T-E87C48MGSn5=g@mail.gmail.com>
 <87wo6or3pg.fsf@x220.int.ebiederm.org>
 <AM6PR03MB51708FD4226E07AB7CB0D6A7E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wjaoYM4gXdAyYY=u8PaYj2LXUvcfp=8DKum8f1DM+Ws0A@mail.gmail.com>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Message-ID: <AM6PR03MB5170F924EA69A81D79BD0929E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Thu, 9 Apr 2020 19:46:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <CAHk-=wjaoYM4gXdAyYY=u8PaYj2LXUvcfp=8DKum8f1DM+Ws0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0040.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::20) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <f0296542-99a5-8531-a937-763055d5c24d@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (92.77.140.102) by AM0PR10CA0040.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 17:46:18 +0000
X-Microsoft-Original-Message-ID: <f0296542-99a5-8531-a937-763055d5c24d@hotmail.de>
X-TMN:  [PwQ427BBSdoau6FBIR/Y3GcGAXPiL244]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 58abf788-263a-4f8f-ce47-08d7dcade8cc
X-MS-TrafficTypeDiagnostic: HE1EUR01HT191:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DD3p4u4lnO9nfBpbXV8g5zMYqAK0fFcNYafg9EXkLpnmBhbg37qf2TleweTACXD8fUkj4H0C+f6mmQ0GGse/b1Dq8ur2DuUA88OvtHc8fQOyQN4flAvNRvoAmE1S+ysUmVdQsq8hHTuyPntaK+f26kup0fn7yLXE+ms8tnqJN5tQLXuTmLFwPNM1JGYZuzND
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB5170.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: k6GBsDu+NeJUmXqr6XdgKsleIythXt5tOmGKcVZp6dQnSm8I8Ni4X0N9H30xTXJTMxi7fJ7VmiVxdSMawUATjze49jge02yQqje0d5AM1RREZtzr0XQz0pG/xojZ/Kd/o6QPk4WX72Fe3ji+TC/HBg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58abf788-263a-4f8f-ce47-08d7dcade8cc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 17:46:19.2661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1EUR01HT191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/9/20 7:37 PM, Linus Torvalds wrote:
> On Thu, Apr 9, 2020 at 10:17 AM Bernd Edlinger
> <bernd.edlinger@hotmail.de> wrote:
>>
>> Just for reference, I used Oleg's test case,
>> and improved it a bit.
> 
> I'm sure the test-case got posted somewhere, but mind sending it to me
> (or just pointing me at it?)
> 


No problem looks like you already swallowed the hook :-)
look at the following commit in your tree:

commit 2de4e82318c7f9d34f4b08599a612cd4cd10bf0b
Author: Bernd Edlinger <bernd.edlinger@hotmail.de>
Date:   Fri Mar 20 21:26:19 2020 +0100

    selftests/ptrace: add test cases for dead-locks
    
    This adds test cases for ptrace deadlocks.
    
    Additionally fixes a compile problem in get_syscall_info.c,
    observed with gcc-4.8.4:
    
    get_syscall_info.c: In function 'get_syscall_info':
    get_syscall_info.c:93:3: error: 'for' loop initial declarations are only
                                     allowed in C99 mode
       for (unsigned int i = 0; i < ARRAY_SIZE(args); ++i) {
       ^
    get_syscall_info.c:93:3: note: use option -std=c99 or -std=gnu99 to compile
                                   your code
    
    Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
    Reviewed-by: Kees Cook <keescook@chromium.org>
    Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


Test case 1/2 is working 2/2 is failing, deadlocking,
I think even the time-out handler does not kill the dead-lock
if I remember correctly.

And sorry, I anticipated part 15/16 and 16/16 would be pulled at the
same time, so the glitch would not be visible by now.


Bernd.

>              Linus
> 
