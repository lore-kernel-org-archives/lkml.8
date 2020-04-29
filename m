Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F1FC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 20:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37C162082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 20:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgD2UUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 16:20:06 -0400
Received: from mail-oln040092073049.outbound.protection.outlook.com ([40.92.73.49]:50659
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726456AbgD2UUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 16:20:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAmZtuHXPuyTasg5SR6BO87M+l6sQKCE4OmrdkClKSDyLo6IUtGch2BYjFqKx9YHl2vnHTPQPGeRCB0kwznVhqFIg9n+cvYS6iai99vDH0rNi6ZoHxfL5TEWu/m4wGlF02lxSvq1odDi0wKueHAwrjG1LMzKRwYqrIuAOC4Mho8fDOoCnMThg+GSSaBDI9NLMqyhID7QbpNQCBY+A5Dyxiexla1661qWegN/Gw+SALfMnklJc05brQflNfRgBlLPH+Af4nsGQrbMHwqj6emuc1BwvrLpqY5pVL92xgEV//JeUgChSUsSyUCw0IJ6ShaZK9EmJ7sQ/AYFHbEh/1pCmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRYfsjuFEmLo8/iLCq0/RFSVNA6hVEqFh60uuB3ZzWg=;
 b=Q2J9q7awo7bN7jh1Wx1lpCpIEsVk0tA8A3aj+kXN18m+Wssa21o9uZ8ldvpfaEQfbmizbRLXw4GtHb6LauZUwZIQ9SggD+hQu9hRsInS7wyjyKsJMfTdDMwPB4TvTra0d45D00LnVbAV9eZB82+0EVHxNQPMLD+5pRs7kVtt2Ge7lnYxjhgzHjzFdnOsZSmSNN7skCrdaeYqmH2xOnVkWSjUT/anCjIHGZ5t2uuyydlCadq6+hgzQqQUpSNblOnPFF6Vt2wXfzYSbjeLUISh1Mdc8vtgWdMxKcfNtQJj/V3cEKNVYRNkzKF5PbE5KmUTc71LsPWQgafhkk33e1plcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from VI1EUR04FT030.eop-eur04.prod.protection.outlook.com
 (2a01:111:e400:7e0e::48) by
 VI1EUR04HT097.eop-eur04.prod.protection.outlook.com (2a01:111:e400:7e0e::104)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Wed, 29 Apr
 2020 20:20:01 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:7e0e::51) by VI1EUR04FT030.mail.protection.outlook.com
 (2a01:111:e400:7e0e::366) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Wed, 29 Apr 2020 20:20:01 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:D389AC14EE82456E4AE157679DDD21B7A91C5FA8143F5DB9A7288DCB8235CFFC;UpperCasedChecksum:35E9FD169ECF6651F9D2C0FBAE1ECB3B79773954E22C294E4ABA64F64D858059;SizeAsReceived:10047;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2958.019; Wed, 29 Apr 2020
 20:20:01 +0000
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Jann Horn <jannh@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <CAHk-=wiDwR+6ugYaKEGHfYteLF+NH5xu=T7uuUTkK9y-hr6zow@mail.gmail.com>
 <AM6PR03MB51708CF53D8A02086427DAC2E4AC0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wi_zr9dwX3UBYvgkmm6eVQfRP50orryJ6ZVAxuFqdSG5A@mail.gmail.com>
 <20200428190836.GC29960@redhat.com>
 <CAHk-=wi03QRcUR1DfbEr+Pw-DAMENzY-FuRcGawtj9p597=p2w@mail.gmail.com>
 <CAG48ez03ABTa-KbCtFHqB1hOT7dgAM96c3kiw-e80B+utSEwYw@mail.gmail.com>
 <CAHk-=wjTLnMuZmBO2foeHhsLAoUTpUi7oBVJ67F4XKB+tdEDbQ@mail.gmail.com>
 <CAG48ez3EQOvdbzu9aO-cEAJwF_=fJzn1Cg0LMs3ruc=5r1ie5w@mail.gmail.com>
 <CAHk-=whTgFbjGTP=CqMWs_LOkY7bWvLQGYKwKx86amdbMovAkw@mail.gmail.com>
 <CAG48ez2-Nu2ALN6VEUZL-prtR_Kk8QYBHcnvuh0aU2e4zf37RA@mail.gmail.com>
 <CAHk-=wh=G47oD2F1CgOrvGFbEPh2ddMKLV4_wV_bs6S=98aZ5A@mail.gmail.com>
 <AM6PR03MB5170A6AA240D2E8F5E88B911E4AD0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAG48ez07GSXAvqv03-1w=CqedgwmUis5=8oaQsfnFXkPpuN4_g@mail.gmail.com>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Message-ID: <AM6PR03MB517073AD67CB8C6518F94436E4AD0@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Wed, 29 Apr 2020 22:19:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <CAG48ez07GSXAvqv03-1w=CqedgwmUis5=8oaQsfnFXkPpuN4_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0501CA0043.eurprd05.prod.outlook.com
 (2603:10a6:200:68::11) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <e34b484b-9e9c-a374-f4e6-f175fdc033ed@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (88.65.136.207) by AM4PR0501CA0043.eurprd05.prod.outlook.com (2603:10a6:200:68::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend Transport; Wed, 29 Apr 2020 20:20:00 +0000
X-Microsoft-Original-Message-ID: <e34b484b-9e9c-a374-f4e6-f175fdc033ed@hotmail.de>
X-TMN:  [UySMWKUC4376Vk0fk1/CoAJ8HYuINtTJ]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: b3ce589e-6ac9-4ed8-1829-08d7ec7ab17b
X-MS-TrafficTypeDiagnostic: VI1EUR04HT097:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rjHwap/wucorrrkdHs3FDo02ptzCW2CZMFEY7RkMtipEQIBjlzseBxWY6Srxfq7k23fVT3I4ei8qV+Eg67MNnw69dcM/eYWFZCyDeMtSTS4NKQ9VRGOMYQH9tepHhKgSa2iceutCYQxz8LcM/JjJhSPtZ0/6w6K0RxB+J92G48wsXMfn9X+ReZpiIG1rGsxw+MOF2DharWV8NyGcfxsUxLDTQLLNZ1olfrjwEQvIMDPAwv8EUY66daP0EwC9eDof
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB5170.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: GjMpDNcGu2dkdKtqV4nf7AGROUL3fOBUphkKXCVYlNhl+YSA3E7TB0MJCD0FgPeqzwcBBr2j77yUOHJZ7sgm76cADgRzU0HQluGFHmcNvCc+Dk+sFYpYt0WigpQ9mFqf3KCQcES5cGgBnxyLoLlxlQ==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ce589e-6ac9-4ed8-1829-08d7ec7ab17b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 20:20:01.0950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1EUR04HT097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/20 9:26 PM, Jann Horn wrote:
> On Wed, Apr 29, 2020 at 9:23 PM Bernd Edlinger
> <bernd.edlinger@hotmail.de> wrote:
>> On 4/29/20 7:58 PM, Linus Torvalds wrote:
>>> On Tue, Apr 28, 2020 at 4:36 PM Jann Horn <jannh@google.com> wrote:
>>>>
>>>> On Wed, Apr 29, 2020 at 12:14 AM Linus Torvalds
>>>> <torvalds@linux-foundation.org> wrote:
>>>>>
>>>>>  - we move check_unsafe_exec() down. As far as I can tell, there's no
>>>>> reason it's that early - the flags it sets aren't actually used until
>>>>> when we actually do that final set_creds..
>>>>
>>>> Right, we should be able to do that stuff quite a bit later than it happens now.
>>>
>>> Actually, looking at it, this looks painful for multiple reasons.
>>>
>>> The LSM_UNSAFE_xyz flags are used by security_bprm_set_creds(), which
>>> when I traced it through, happened much earlier than I thought. Making
>>> things worse, it's done by prepare_binprm(), which also potentially
>>> gets called from random points by the low-level binfmt handlers too.
>>>
>>> And we also have that odd "fs->in_exec" flag, which is used by thread
>>> cloning and io_uring, and I'm not sure what the exact semantics are.
>>>
>>> I'm _almost_ inclined to say that we should just abort the execve()
>>> entirely if somebody tries to attach in the middle.
>>>
>>> IOW, get rid of the locking, and replace it all just with a sequence
>>> count. Make execve() abort if the sequence count has changed between
>>> loading the original creds, and having installed the new creds.
>>>
>>> You can ptrace _over_ an execve, and you can ptrace _after_ an
>>> execve(), but trying to attach just as we execve() would just cause
>>> the execve() to fail.
>>>
>>> We could maybe make it conditional on the credentials actually having
>>> changed at all (set another flag in bprm_fill_uid()). So it would only
>>> fail for the suid exec case.
>>>
>>> Because honestly, trying to ptrace in the middle of a suid execve()
>>> sounds like an attack, not a useful thing.
>>>
>>
>> I think the use case where a program attaches and detaches many
>> processes at a high rate, is either an attack or a very aggressive
>> virus checker, fixing a bug that prevents an attack is not a good
>> idea, but fixing a bug that would otherwise break a virus checker
>> would be a good thing.
>>
>> By the way, all other attempts to fix it look much more dangerous
>> than my initially proposed patch, you know the one you hated, but
>> it does work and does not look overly complicated either.
>>
>> What was the reason why that cannot be done this way?
> 
> I'm not sure which patch you're talking about - I assume you don't
> mean <https://lore.kernel.org/lkml/AM6PR03MB5170B06F3A2B75EFB98D071AE4E60@AM6PR03MB5170.eurprd03.prod.outlook.com/>?
> 

No, I meant:

[PATCH v7 15/16] exec: Fix dead-lock in de_thread with ptrace_attach
https://marc.info/?l=linux-kernel&m=158559277631548&w=2

and

[PATCH v6 16/16] doc: Update documentation of ->exec_*_mutex
https://marc.info/?l=linux-kernel&m=158559277631548&w=2


I think that was the latest version, but this had several iterations already.

Thanks
Bernd.
