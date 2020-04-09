Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372D0C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075902084D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgDIT5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:57:38 -0400
Received: from mail-db8eur05olkn2040.outbound.protection.outlook.com ([40.92.89.40]:44257
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725970AbgDIT5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:57:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2iR1F6CngUF0wzb0Mcg8Uwd5bxk1NkU0eC86y1NkjubbVDEsUHWAiXaen/x6o7MwzMOqCbmWDPdptRKODc7FTpnrs16mYVqhl9Fyj5KdUn+wGaI0YvFYKlOW4tS3EAuiE8WfvPuUsE6gBF1YLVH6fxu8rrX9BZINLFpTHUZL7s4ng6eOd4tPJgsAOHeUZvCambrL15jL4VeGTiu2j63ZKNYxGl9KpVDh+V4okOPBO3l4zv35T+xkr5xnxa71OonfLfXRSIoo4rkhckFm2jcMS1Tu/GLxbXnRHQ6LNTeFvRv5/TZfKO8Yd/2hSTTnYTY51QiSGh+kq9bg3yLRDDaOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujilNj+xQAricJA6P/3LpKeAdVz/8sqxfl3SRYLILKE=;
 b=D6MAjtBTcVyUgdpEHV/ZKTVf+dwCtQgNo1hNrd41euA0Y6mY/pYAUFtbSJ4fg1xF4ZOTQ5qx2DozuidkG/PrzvqliTyx1Gy19vRa82vwLqGpJcJhWUlrdPEwOCl5R7kSarywYVxox/WHfGpUIt16tQ5MTit4hqso7pHAMPhqc93qHHc/IaryLj/TYkWQc5SP4gnvFnJ38oNBCyKRvZulKgQlD+9/fZdY9VqsCvwEJrnUn5q1UO/zFVmub7mS3LQWLirE2Ojr+O/g0nfHjHJ2s8YH3UScvxK3pxfTX/S23/gJFA40YnQ4inpSDiIxQZ4dZPNIKXJCrYXHi/HQtep/qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from AM6EUR05FT066.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc11::51) by
 AM6EUR05HT216.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc11::200)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 9 Apr
 2020 19:57:35 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:fc11::40) by AM6EUR05FT066.mail.protection.outlook.com
 (2a01:111:e400:fc11::108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Thu, 9 Apr 2020 19:57:35 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:7FA4B0336A9E5EC65D4A3B74675D1C47A82B8B17AC7BEC06ACF65DF99DAE4F7B;UpperCasedChecksum:25C76B282F54B76AEA786D46396B16EEF4E4A2E0DD83C6A56C3DF1657AB64ECF;SizeAsReceived:9994;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2878.022; Thu, 9 Apr 2020
 19:57:35 +0000
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
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
 <AM6PR03MB5170F924EA69A81D79BD0929E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whMKC5F-=QQP=fCNRuTF+ZGiNtLEKvx7KekpK1JtrwDhw@mail.gmail.com>
 <CAHk-=whJ8khGBqfqh6ZmHsKjcyyBLm5xgkgLW_AC_=82iFBWoQ@mail.gmail.com>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Message-ID: <AM6PR03MB51700B243E34BF4A59FF33CFE4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Thu, 9 Apr 2020 21:57:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <CAHk-=whJ8khGBqfqh6ZmHsKjcyyBLm5xgkgLW_AC_=82iFBWoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0081.eurprd02.prod.outlook.com
 (2603:10a6:208:154::22) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <604d1868-d302-30a0-9a65-94206cb5849f@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (92.77.140.102) by AM0PR02CA0081.eurprd02.prod.outlook.com (2603:10a6:208:154::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 19:57:35 +0000
X-Microsoft-Original-Message-ID: <604d1868-d302-30a0-9a65-94206cb5849f@hotmail.de>
X-TMN:  [2zh8pSd0Bu2fH+OIlwRWQsyHjIG9f8x/]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: fc526039-5eb9-462d-54cf-08d7dcc03f81
X-MS-TrafficTypeDiagnostic: AM6EUR05HT216:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JIb1LTPi2xVNJ/N8aao/Puf/b1le6Vmhn8tySlQGgE0S4NDaMuBu3oFHpbKVNQ+YG9V6wBU9s6l/EJ1+Rjc3bOqcXL8BNlVblzMazTQ51xgbrCr0f5qjYLBU2J4rVx/0sESS5MkSTvss6tRZuEZgiPPUXFodqPG87YyaOGzjE+9k4/VW+ZSQR9mcUi9efOos
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB5170.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: X2ggqLg5fVMwm0CCTG/c/WmV22VvaLIiZTV6NK8bHp+eTHQyjdbXdpQJ2i/DtEPaNS/yStCJk/90+noPx+tzPOoN9iRaNCE9nt8daai1JGDNUmg3NnqLCXLnf0VM2lag1b+ESwKUkiGUzfE5APxZJw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc526039-5eb9-462d-54cf-08d7dcc03f81
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 19:57:35.7584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6EUR05HT216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/20 9:42 PM, Linus Torvalds wrote:
> On Thu, Apr 9, 2020 at 11:36 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> I guess I need to look at what that test is actually testing, because
>> it wasn't what I thought.
> 
> Ahh.
> 
> The problem is that zap_other_threads() counts all threads.
> 
> But it doesn't bother notifying already dead threads, even if it counts them.
> 
> And then it waits for the threads to go away, but didn't do anything
> to make that dead thread go away.
> 
> And the test case has an already dead thread that is just waiting to
> be reaped by the same person who is now waiting for it to go away.
> 
> So it just stays around.
> 
> Honestly, I'm not entirely sure this is worth worrying about, since
> it's all killable anyway and only happens if you do something stupid.
> 

The use case where this may happen with strace
when you call strace with lots of -p <pid> arguments,
and one of them is a bomb. strace stuck.

So when that happens in the beginning, it is not much
work lost, but if you traced a megabyte of data to analyze
and then that happens, you are not really amused.

Also slightly different things happen with PTRACE_O_TRACEEXIT
then the tracer is supposed to continue the exit, and then
to wait for the thread to die.  Which is twice as ugly...


Bernd.


> I mean, you can get two threads to wait for each other more easily other ways.
> 
> Or maybe we just shouldn't count already dead threads? Yeah, they'd
> share that current signal struct, but they're dead and can't do
> anything about it, they can only be reaped.
> 
> But that would mean that we should also move the signal->notify_count
> update to when we mark the EXIT_ZOMBIE or EXIT_DEAD in exit_state.
> 
>           Linus
> 
