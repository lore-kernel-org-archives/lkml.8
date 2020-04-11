Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3A9C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 21:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A552020787
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 21:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgDKVQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 17:16:20 -0400
Received: from mail-am6eur05olkn2095.outbound.protection.outlook.com ([40.92.91.95]:17345
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726167AbgDKVQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 17:16:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nv1PTjDMm9YR4qwbeCUgrIk/qiH5lFwseDxYRYc32qRhE/on3be25ONFENOGauOYVc6ybGpHCrZz6KAQasOALIJ7Z+bjtR2gWeqXfjeiUNd64pboNFzfKWWwo83gPkCTBAgAB7v8hYdmTPdiUJl+ApSt2dVtf2o6QR+qQb24SsQjKN0uHz1ooE6/I3XUo+tku8VEQoE+R10es5hqf9io7DUQjxUwUraGdhVnXW9xg+WITQ8PJnNA11/DZpueeImDt7xWLu7jqmxRnTSumBg0nigpSq7OCVsWpEFKOrI6FN8m0JYQmP1Sf4qZY1/6DkBW5OiIB1BttOFIAo9nzT7Ifg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+526F/Mam6XrOHF+8r60r8/sMkvdjPjCGeICRbtLfY=;
 b=BSB6PlylQOxLinX0bEJVKfETYi8zXdA/GfsPhlj3bzJaILryyMsTEuukG4Vf6KT2TUupPwuPVV8eeJ9Z3O29kTarRs7giPP2NWiihcYz8+Fti+PwohOM9tNAXArDWME0r7ZlzdUysDq70XPB8Dh6XWYzfU3mLFiUDcoEh8cJ2DoJ4JEp2iRfE9IYZ8D8a72wd9Bj6UteO9L/DWyprULl5oIGVUzyMqwBlhmcTGubUQPrjC2dDEzTfFdSgtUvhoXCqDeYfbUfSTBUnmAdZ9ZLmrCMvmRh72HqwzPiF29fXU3GqDZKFY8TTcoqZFAMXetrkWd1f6VsewwCh9LT76bfrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from VI1EUR05FT057.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc12::4c) by
 VI1EUR05HT023.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc12::311)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.18; Sat, 11 Apr
 2020 21:16:13 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:fc12::4b) by VI1EUR05FT057.mail.protection.outlook.com
 (2a01:111:e400:fc12::213) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Sat, 11 Apr 2020 21:16:13 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:2EF9E1D8ED41CEA16694497FFDAA41182B72D2F6722073219D54A612C007258B;UpperCasedChecksum:2C52760A10AB5FDAC21863ED04DF63C2D1A1CF06646D1814F4834C8165EB0E45;SizeAsReceived:10005;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2900.026; Sat, 11 Apr 2020
 21:16:13 +0000
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <AM6PR03MB51708FD4226E07AB7CB0D6A7E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wjaoYM4gXdAyYY=u8PaYj2LXUvcfp=8DKum8f1DM+Ws0A@mail.gmail.com>
 <AM6PR03MB5170F924EA69A81D79BD0929E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whMKC5F-=QQP=fCNRuTF+ZGiNtLEKvx7KekpK1JtrwDhw@mail.gmail.com>
 <CAHk-=whJ8khGBqfqh6ZmHsKjcyyBLm5xgkgLW_AC_=82iFBWoQ@mail.gmail.com>
 <AM6PR03MB51700B243E34BF4A59FF33CFE4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <87imi8nzlw.fsf@x220.int.ebiederm.org>
 <CAHk-=wgh4zts+3hdkGzHLJ6pBGumcJ=23gRbMfubDrLstis2Bg@mail.gmail.com>
 <CAHk-=whKHpERyVv2-C+kxq9KV_mJPW3hkGDpn6f4yOvs+au8SA@mail.gmail.com>
 <20200411182043.GA3136@redhat.com>
 <CAHk-=wgwXpKepChGi4ZhQVxZxD0ic8s2CDXvUmqBTMaKGz-fjg@mail.gmail.com>
 <AM6PR03MB5170660DA597EAAAC0AC1B5BE4DF0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wjXxM0VnLN6iwVeORwxED5QgXS_AXUJ4+Af3jUeFY21gw@mail.gmail.com>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Message-ID: <AM6PR03MB5170E360AE2E27F632874DAEE4DF0@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Sat, 11 Apr 2020 23:16:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <CAHk-=wjXxM0VnLN6iwVeORwxED5QgXS_AXUJ4+Af3jUeFY21gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR05CA0090.eurprd05.prod.outlook.com
 (2603:10a6:208:136::30) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <0c03f5a1-a552-26ba-8b62-27c26c51b88b@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (92.77.140.102) by AM0PR05CA0090.eurprd05.prod.outlook.com (2603:10a6:208:136::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Sat, 11 Apr 2020 21:16:12 +0000
X-Microsoft-Original-Message-ID: <0c03f5a1-a552-26ba-8b62-27c26c51b88b@hotmail.de>
X-TMN:  [FXjs14peoAjOBTAwmUpkVr/QFMzHnr2I]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 3a8cd20c-0347-4cde-5842-08d7de5d904e
X-MS-TrafficTypeDiagnostic: VI1EUR05HT023:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wt5z7mwx516lCqMa5ZKiX6PcGua5absV/Ne+Nc5WNLuAZXj/mkc8YzS98WJfRyElgBtCBp9vJk34XGnl69wIcS4db7W5EPDRitAa1GqjVwxWsupy2uREt1rVK/2GgR06xOa8WgUJuKF140jegbm2s36Zc/khjxqDTVxuEBhV0H6DmMc29SPiPzZZJXkDwQeg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB5170.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: fTIbw18qb2HY8N/Noam7IDpjULd3Sv8T14XGSXTk8IfVBiDFzMiCEKGVM6rIH2336a1hzhYoyw8l9Xep7SR3uWs4v6gVfCDlBnbWAA+A1SqC212UfhQVDHkIMFS9NBeTsTl480nHIWzvPek5z830vw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8cd20c-0347-4cde-5842-08d7de5d904e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2020 21:16:13.3751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1EUR05HT023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/20 10:07 PM, Linus Torvalds wrote:
> On Sat, Apr 11, 2020 at 12:15 PM Bernd Edlinger
> <bernd.edlinger@hotmail.de> wrote:
>>
>> But won't the dead thread's lifetime overlap the new thread's lifetime
>> from the tracer's POV?
> 
> What new thread?
> 
> execve() doesn't create any new thread.
> 
> But yes, an external tracer could see the (old) thread that did
> execve() do new system calls before it sees the (other old) thread
> that was a zombie.
> 

That is an api change.  Previously the strace could rely that there
is a callback at the end of the execve and that all previous threads
are de-zombiefied and waited for.

Then there is a execve done event.

And then the old thread continues to run but executing the new program.

I'd bet the strace test suite has tests for that order of events,
or at least it should.


> But that is already somethign that can happen, simply because the
> events aren't ordered. The whole issue is that the zombie thread
> already died, but the tracer just didn't bother to read that state
> change.

What causes the deadlock is that de_thread waits for the tracer to
wait on the threads.  If that changes something will break in the
user space.  Of course you could say, I did not say "Simon says".


Bernd.

> 
> So it's not that the dead thread somehow _dies_ after the execve(). It
> already died.
> 
> It's just that whoever is to reap it (or traces it) just hasn't cared
> to read the status of that thing yet.
> 
>              Linus
> 
