Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CADC83000
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 01:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4D262082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 01:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgD3BII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 21:08:08 -0400
Received: from mail-db8eur05olkn2067.outbound.protection.outlook.com ([40.92.89.67]:4320
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726701AbgD3BIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 21:08:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+1N3Xw4k36IOnQAPKjugSXbC4gfxV5HAPruklnIaHaRjHoZJaB1WC+hXJ/tlfnI/QMmuhjYKtJoDUP6ssrf4DmBY9jn04UK3exUSStTVp0wb87pdXxm23R2qHIW7ZmJEr54/Y/r8s0aCiOncZNwJf0aL3Lo6QruzW469T/K8aRBr7hSLU1TUIUvxfBLznSSttbfZ1K20UBeFNKNzcouXJF9w/h7umbJIHzAajpJqQ17nEZt/OS2K2rs2+s8xg6qNxWvoG2FBQkhPQB5ipUQ26Wu1WqnDNBkATKOu+zLRKuM7psk5f7zNK0xw1UoT9o6VCQFmvqWls+1cc7CJv0dbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MThzlMeSu5wOcfqN24UoGPgoeJBv0LgVqB03IIHt/4E=;
 b=oSZYqPXf0IpMRFFYaDIGdMAaRC7cgky88+gpCYxyri1ehqsE3Q2k1SDvr3EPXLbOy0oR6dmcCKJi7w6yY/pl+T1e8T9IaETBq0EBiUJ96alOdLCIKDKTYSIx1sVbKU/3wQhLKsrCPf/lmNNa8o1wvEjHp1evAgCMCHwcwu2jA4TPFee7pbboIx/N3GTh5FPL1EkxHPjILQ2rUwEXrYu/mXYnstGcIXc3DvXDZHYFM4QwqognOQkFX3pfrDLoQyrP0vDtYmi+r2H/A7m3UmObF2/JImM9xEUlmVWLl+u51GvDJFtGUhooATQ48MHjoRAD5mv3FqhZB2c2L9ECniyesg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from AM6EUR05FT016.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc11::49) by
 AM6EUR05HT232.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc11::402)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15; Thu, 30 Apr
 2020 01:08:01 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:fc11::4e) by AM6EUR05FT016.mail.protection.outlook.com
 (2a01:111:e400:fc11::243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15 via Frontend
 Transport; Thu, 30 Apr 2020 01:08:01 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:D44750F1678A4249499A1D7941B261E431B08A9BD586D6F5D81F7717C0072638;UpperCasedChecksum:BA42373C0179848248B673CE06F166419CC38CE20ABD6017EC67F732F8AA4B25;SizeAsReceived:10037;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2958.019; Thu, 30 Apr 2020
 01:08:01 +0000
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
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
 <CAHk-=wguiKq8yf11WJjgSL4ADKZ5sLe_Qbd7vHEqAkTvZJ+d+Q@mail.gmail.com>
 <CAHk-=wjUZLybZBJgOtD2gng=FS7USrbQQ1-tn5M+UP5DbCWdzw@mail.gmail.com>
 <CAG48ez0FL3i4eGFYryOwG2nnS+JigfKYAVSV9ogVHjmjOWzsrA@mail.gmail.com>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Message-ID: <AM6PR03MB5170C5D02C6FCB6D69DFE3ADE4AA0@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Thu, 30 Apr 2020 03:08:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <CAG48ez0FL3i4eGFYryOwG2nnS+JigfKYAVSV9ogVHjmjOWzsrA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0101CA0062.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::30) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <2a213f41-0072-fbec-7ef9-15537e182327@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (88.68.1.164) by AM4PR0101CA0062.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Thu, 30 Apr 2020 01:08:00 +0000
X-Microsoft-Original-Message-ID: <2a213f41-0072-fbec-7ef9-15537e182327@hotmail.de>
X-TMN:  [X2CCMOhWxYXTb6kv45MDDPgjpLgMsOLu]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: d9e2d2f0-32dd-4ec9-1edf-08d7eca2ed6c
X-MS-TrafficTypeDiagnostic: AM6EUR05HT232:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TXe1WyKMYhWrx7lP5gum+et+R0gOCkTH5pxZn75xVJBErwowypTpdp16aVPirWNRpHhJ+ACm6BmgosQUPYkxkPM2W8eeTT7C4iGPBZq1VVeYylNRGejYhLuxhGKKB1ai7MDzH2jRMV+V2xPTqNsy0ubWQICUMpz+xNUk6FyMMIpJbfx4X11sYW4U7OXmDWYxLnVVhfSG28C0H5y46SUhTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB5170.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: pJrv2CGzyu6p47heh1Kstri+7wjWda111rC+lCesi8ISDHqADF5MXJ/ym7T2aP8A+2TKDl0N8LmaC+bgWuUAIndAYX2cZ/NXHjyfpZQvO5dCOgjdz79l1ZXtGAa5pypOWf5Gm6gSmlTwh5BAS6pA9g==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e2d2f0-32dd-4ec9-1edf-08d7eca2ed6c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 01:08:01.2075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6EUR05HT232
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/30/20 1:59 AM, Jann Horn wrote:
> On Thu, Apr 30, 2020 at 1:22 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> On Wed, Apr 29, 2020 at 3:38 PM Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>>
>>> If you do it properly, with a helper function instead of repeating
>>> that fragile nasty thing, maybe it will look better to me.

I added the BIG FAT WARNNIG comments as a mitigation for that.
Did you like those comments?

>>
>> Side note: if it has a special helper function for the "get lock,
>> repeat if it was invalid", you can do a better job than return
>> -EAGAIN.
>>
>> In particular, you can do this
>>
>>         set_thread_flag(TIF_SIGPENDING);
>>         return -RESTARTNOINTR;
>>
>> which will actually restart the system call. So a ptrace() user (or
>> somebody doing a "write()" to /proc/<pid>/attr/xyz, wouldn't even see
>> the impossible EAGAIN error.
> 
> Wouldn't you end up livelocked in the scenario that currently deadlocks? Like:
> 
>  - tracer attaches to thread A
>  - thread B goes into execve, blocks on waiting for A's death
>  - tracer tries to attach to B and hits the -EAGAIN
> 
> If we make the PTRACE_ATTACH call restart, the tracer will just end up
> looping without ever resolving the deadlock. If we want to get through
> this cleanly with this approach, userspace needs to either
> deprioritize the "I want to attach to pid X" and go back into its
> eventloop, or to just treat -EAGAIN as a fatal error and give up
> trying to attach to that task.
> 

Yes, exactly, the point is the caller is expected to call wait in that
scenario, otherwise the -EAGAIN just repeats forever, that is an API
change, yes, but something unavoidable, and the patch tries hard to
limit it to cases where the live-lock or pseudo-dead-lock is unavoidable
anyway.


Bernd.
