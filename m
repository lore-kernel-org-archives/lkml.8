Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3BCC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7387E205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgD2TX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:23:27 -0400
Received: from mail-vi1eur05olkn2099.outbound.protection.outlook.com ([40.92.90.99]:64865
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726456AbgD2TX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 15:23:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pqx5RvrF/0nScJHmc0LCJPmUDZ6iE4VIoSbOIAp65Pjy/vCSGB9z48N1SEcQnDkOTTCzbt9onbNEAHQfL0Om0LwpD4chQmDv4X11nrrtjtDQE5J4FAOXXfXo26RVM0//XTMuOkvx9sLCSLlJ2OlMoKq7AfxtaijpY4RNmOMvZkjH0yvEcrwuW5/5iU/nKIDsdG8uiOOnn/QLhZlGjlT1FGUd1XSKMU5J8u92rZ3dRJbbYC9f93YVHkrQYlfvlIXQUSroHIHgcWSVCi/eRb3zyWJdI8opZoln0LGejD6Z2neyG+w/Nf7SkreQ0klTyhkchwckyqwkf01FC68PatOE7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7m0Gl5SRWdryvDPRYA/2a0EYfi2iGirkLxzMzJkASc=;
 b=NaNnEocisgGMkX8jFYBIt/5LI+3TvRzZHxtL/8qcvZPS0popNM+7TyetKeRDBcyK22xZGSZdcWEizLyWeCDUsKU8c+bRTUVzPktwfmnDp+pEPGrEy+uEeXsAAMzKX+LxTbo/8HEGVqyFBm8AkHuCo6FbQV4q787BwTlmKaON+ANwEVGkDD4HuoMxN0KfuGcplZlCOhYNPyvFa8zfzB3GGh1vEPG+u+5z7Q4KrbXwTHpcap+U5P1P5DcJNDG9cQJxAUjsSd5TaUHIsi3HDV9Vgu/v8yNxzqaSPSrSGy3eoy6e8Z899YJOHF9n1252kKFe5CzWrM0huPHNtYM7Ou87ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from VI1EUR05FT060.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc12::48) by
 VI1EUR05HT025.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc12::451)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15; Wed, 29 Apr
 2020 19:23:24 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:fc12::52) by VI1EUR05FT060.mail.protection.outlook.com
 (2a01:111:e400:fc12::87) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15 via Frontend
 Transport; Wed, 29 Apr 2020 19:23:23 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:60E202992F80BCA272066EC7B43822D2165905D458F321268A752393F01CF51A;UpperCasedChecksum:FECE66CF1FA561EDB2246445311C7155983F246849688D07B196DD006E0B74BC;SizeAsReceived:10021;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2958.019; Wed, 29 Apr 2020
 19:23:23 +0000
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <20200411182043.GA3136@redhat.com>
 <CAHk-=wgwXpKepChGi4ZhQVxZxD0ic8s2CDXvUmqBTMaKGz-fjg@mail.gmail.com>
 <20200412195049.GA23824@redhat.com>
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
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Message-ID: <AM6PR03MB5170A6AA240D2E8F5E88B911E4AD0@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Wed, 29 Apr 2020 21:23:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <CAHk-=wh=G47oD2F1CgOrvGFbEPh2ddMKLV4_wV_bs6S=98aZ5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR04CA0150.eurprd04.prod.outlook.com (2603:10a6:207::34)
 To AM6PR03MB5170.eurprd03.prod.outlook.com (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <cf8917a5-00f0-9777-1c0f-735a16a992f7@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (88.65.136.207) by AM3PR04CA0150.eurprd04.prod.outlook.com (2603:10a6:207::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend Transport; Wed, 29 Apr 2020 19:23:23 +0000
X-Microsoft-Original-Message-ID: <cf8917a5-00f0-9777-1c0f-735a16a992f7@hotmail.de>
X-TMN:  [JP/Ib0FRRkTRjl4HlzwlZ0LnAeLmeoEI]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: a01afb74-d286-44d0-1d29-08d7ec72c8cd
X-MS-TrafficTypeDiagnostic: VI1EUR05HT025:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O9dp+xicr7suLr51GWtkUubdkXwNYiPEpqOq6bFX6IC//Gh/VFUBJnfX5iWoZyJHHxhwnZUBGM7ojGr1L2H45qOa2GxOoSVD6USEsUFZ8AQvaZuei2vCXu9VbYVSYFp4TS+NWor2m3Wf6rRxjuUI+2MmGbQiUVyuVGWPXTSe6lwQuZpNXC7P234xo2wqgKjBBVWPbbgV6zY8fExJSIKxww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB5170.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: nwjzPQwyMLPBeDE3Qr9RNYEBq77DmVNdTMgSJI/QAhSrAX8IYxfl2SRsoDYqlhW9lWUfKLCJjyOwRZwEFvufSEFw3jTpfDKTDFVkQrZorL6BZ/tZAMf5lNsd7LLtZC3aTWkrdmTaSISzVS7kjkgpug==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a01afb74-d286-44d0-1d29-08d7ec72c8cd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 19:23:23.8944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1EUR05HT025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/20 7:58 PM, Linus Torvalds wrote:
> On Tue, Apr 28, 2020 at 4:36 PM Jann Horn <jannh@google.com> wrote:
>>
>> On Wed, Apr 29, 2020 at 12:14 AM Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>>
>>>  - we move check_unsafe_exec() down. As far as I can tell, there's no
>>> reason it's that early - the flags it sets aren't actually used until
>>> when we actually do that final set_creds..
>>
>> Right, we should be able to do that stuff quite a bit later than it happens now.
> 
> Actually, looking at it, this looks painful for multiple reasons.
> 
> The LSM_UNSAFE_xyz flags are used by security_bprm_set_creds(), which
> when I traced it through, happened much earlier than I thought. Making
> things worse, it's done by prepare_binprm(), which also potentially
> gets called from random points by the low-level binfmt handlers too.
> 
> And we also have that odd "fs->in_exec" flag, which is used by thread
> cloning and io_uring, and I'm not sure what the exact semantics are.
> 
> I'm _almost_ inclined to say that we should just abort the execve()
> entirely if somebody tries to attach in the middle.
> 
> IOW, get rid of the locking, and replace it all just with a sequence
> count. Make execve() abort if the sequence count has changed between
> loading the original creds, and having installed the new creds.
> 
> You can ptrace _over_ an execve, and you can ptrace _after_ an
> execve(), but trying to attach just as we execve() would just cause
> the execve() to fail.
> 
> We could maybe make it conditional on the credentials actually having
> changed at all (set another flag in bprm_fill_uid()). So it would only
> fail for the suid exec case.
> 
> Because honestly, trying to ptrace in the middle of a suid execve()
> sounds like an attack, not a useful thing.
> 

I think the use case where a program attaches and detaches many
processes at a high rate, is either an attack or a very aggressive
virus checker, fixing a bug that prevents an attack is not a good
idea, but fixing a bug that would otherwise break a virus checker
would be a good thing.

By the way, all other attempts to fix it look much more dangerous
than my initially proposed patch, you know the one you hated, but
it does work and does not look overly complicated either.

What was the reason why that cannot be done this way?


Thanks,
Bernd.

