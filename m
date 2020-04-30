Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DDAC28CBC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 486352074A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgD3Nj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:39:29 -0400
Received: from mail-oln040092072082.outbound.protection.outlook.com ([40.92.72.82]:31514
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726809AbgD3Nj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:39:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXNlBvf2h24FO6uYFg9AXtj3hX6Fc6a0vRXBehZ5yhFR0/KSTGWw/HoBF0/NAqbTRSuh1iAH/wSPkKLNpuvjmOoaG2BMsqBYlAr2yQoB2d9iu5X8arZ6X3yDrtLpkghuwdYMklRFAxNfvl3qub+D6y3q0Jr32GQxf2h1uO8QdpU6zAO5j2ieUJglllESodzEDddKveWTAgD0V6umvzKD/xCxTL1FeoTXLCVkPhHfKo+SKqgVxkZvdgp2PolGZjVt/j+U4h3+t0Xya8CFmcj5g56unEQSRdAyp60qw1zOtlIqNdMR7nV66GWMIO/0zIXWxsUGybTEVofRb6UlwJcFEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMU5XsSberkXpZeuJ1JPAgEfAms9XaCh9X1Ck6UtX2g=;
 b=YWg6HdXUyqK1LYsoEoU6a+CFZ+EdMErChoBpRLLf+23NJnO6pwSUKTTGPTZhrOQk+XKtX/Ydk2F056N+70R7/qk9MqTHkH5Q4m8Bkr5BWBm7QsBEULQGEyIr8KfgPB+G7Xux4PYXiq4PdEKiXzlh9r3JOTJWJbhNcYZ33K9CCKwCxCmfYIVSL44HNuQlRDaT1cWVF71+dJHA3tioISwaFJP7T8sU+fPH1reI8eGvxYBH3cslxL4lsIpkjmqrZjqcGtas0DmCxp4Wgb/r6OmvQQ78ZAMpdLVtfSYycF4cOat/OMKmbVEtSoWh48yywtoRtCLZm2kjYoBnGlc16cBhZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from VE1EUR03FT047.eop-EUR03.prod.protection.outlook.com
 (2a01:111:e400:7e09::41) by
 VE1EUR03HT154.eop-EUR03.prod.protection.outlook.com (2a01:111:e400:7e09::315)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.19; Thu, 30 Apr
 2020 13:39:25 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:7e09::44) by VE1EUR03FT047.mail.protection.outlook.com
 (2a01:111:e400:7e09::474) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Thu, 30 Apr 2020 13:39:25 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:0B8753FDC9238C80C40FC1DB4969620CBEC59B6CA7D3EE1E658CBBEA9502C6FC;UpperCasedChecksum:45E114EFC0B33536A462182860C7A9440D2CCFD2C28B700743EDDBBDCC7F17F6;SizeAsReceived:10019;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2958.019; Thu, 30 Apr 2020
 13:39:25 +0000
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
 <20200428190836.GC29960@redhat.com>
 <CAHk-=wi03QRcUR1DfbEr+Pw-DAMENzY-FuRcGawtj9p597=p2w@mail.gmail.com>
 <CAG48ez03ABTa-KbCtFHqB1hOT7dgAM96c3kiw-e80B+utSEwYw@mail.gmail.com>
 <CAHk-=wjTLnMuZmBO2foeHhsLAoUTpUi7oBVJ67F4XKB+tdEDbQ@mail.gmail.com>
 <CAG48ez3EQOvdbzu9aO-cEAJwF_=fJzn1Cg0LMs3ruc=5r1ie5w@mail.gmail.com>
 <CAHk-=whTgFbjGTP=CqMWs_LOkY7bWvLQGYKwKx86amdbMovAkw@mail.gmail.com>
 <CAG48ez2-Nu2ALN6VEUZL-prtR_Kk8QYBHcnvuh0aU2e4zf37RA@mail.gmail.com>
 <CAHk-=wh=G47oD2F1CgOrvGFbEPh2ddMKLV4_wV_bs6S=98aZ5A@mail.gmail.com>
 <AM6PR03MB5170A6AA240D2E8F5E88B911E4AD0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wguiKq8yf11WJjgSL4ADKZ5sLe_Qbd7vHEqAkTvZJ+d+Q@mail.gmail.com>
 <CAHk-=wjUZLybZBJgOtD2gng=FS7USrbQQ1-tn5M+UP5DbCWdzw@mail.gmail.com>
 <CAG48ez0FL3i4eGFYryOwG2nnS+JigfKYAVSV9ogVHjmjOWzsrA@mail.gmail.com>
 <CAHk-=wgcvn1_1kCkyourNCKeH+KrzSMRvc-ai_NLU4RGZT_XBg@mail.gmail.com>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Message-ID: <AM6PR03MB5170CCB8D9D41904066DAFD5E4AA0@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Thu, 30 Apr 2020 15:39:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <CAHk-=wgcvn1_1kCkyourNCKeH+KrzSMRvc-ai_NLU4RGZT_XBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR07CA0027.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::40) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <9dc2a7f8-d7e0-a8fc-7457-610934a297c6@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (84.57.60.225) by AM0PR07CA0027.eurprd07.prod.outlook.com (2603:10a6:208:ac::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.16 via Frontend Transport; Thu, 30 Apr 2020 13:39:24 +0000
X-Microsoft-Original-Message-ID: <9dc2a7f8-d7e0-a8fc-7457-610934a297c6@hotmail.de>
X-TMN:  [/OoXc6tcW1uHCxkH62kbzDtaVhiT99Xv]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: d2d9a64c-3920-40ba-f1f1-08d7ed0be5c3
X-MS-TrafficTypeDiagnostic: VE1EUR03HT154:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mdhLTR8e6lEktJycq0A+DSr69begC3mdKmiue7AoMV/c/xEEv+r2CeEz6JAMkiGD3RRGXG74t5W2ok/sqzA+Lnw/6mi6D2gROj/qvcFNFzHiWmfd5xIxW0Op/J4njhV1DB+qssjbK6Gl11AIXycOSGgLHdNcDNbCtYTg8f/kHEZEsHym0WfWUGK/cQZhgbktrLvIHmHDbClKClWpKCfx+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB5170.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: QL/J+onD810hzOolRk3oh3153GDPdz6L2bUMz8MZhajlFjaZvIyjsV01RDrbn+0s4G/2sdnDO10xS9DLggt663V3O43UeyH+WYdYUXBuJ7J7sXJ2fvOgQDxQ9THPW5Up6vlY8AZ5Q3HjEX9Hd65j2w==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d9a64c-3920-40ba-f1f1-08d7ed0be5c3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 13:39:25.5839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR03HT154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/30/20 4:16 AM, Linus Torvalds wrote:
> On Wed, Apr 29, 2020 at 5:00 PM Jann Horn <jannh@google.com> wrote:
>>
>> Wouldn't you end up livelocked in the scenario that currently deadlocks?
> 
> The test case that we already know is broken, and any fix will have to
> change anyway?
> 

The purpose of the test case was only to test the behaviour of my
later patch.  The test case _must_ be adjusted to the follow-up
patch, I have no problem with that.  Anybody may change the test case
when we know how to fix the API.  I did just not anticipate that Eric
would only apply 14 of 16 patches = 87.5% of the patch series. Now that
causes some tension, but it is not really a problem IMHO.

> Let's just say that I don't care in the least.
> 
> But Bernd's patch as-is breaks a test-case that currently *works*,
> namely something as simple as
> 
>   echo xyz > /proc/<pid>/attr/something
> 

Excuse me, but what in my /proc folder there is no attr/something
is there a procfs equivalent of pthread_attach ?

What exactly is "attr/something" ?

> and honestly, breaking something that _works_ and may be used in
> reality, in orderf to make a known buggy user testcase work?
> 
> Because no, "write()" returning -EAGAIN isn't ok.
> 

write can return -EAGAIN if the file is non-blocking, it is
never the case for a disk file, but for a NFS that is not at all
clear, depends on a mount option, and once I had a deadlock in
one of my test systems after OOM-stress, but I never was able
to reproduce, the umount deadlocked, then I was not able to
reboot, could be an alpha-particle of course, who knows...


Hmmm.. maybe a stupid idea:

We could keep the old deadlock-capable API,
and add a new _flag_ somewhere to the PTHREAD_ATTACH call,
that _enables_ the non-blocking behavior, how about that.



Thanks
Bernd.

>             Linus
> 
