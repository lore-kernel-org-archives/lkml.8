Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BE1C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 04:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C4120753
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 04:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgDKEH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 00:07:56 -0400
Received: from mail-oln040092069088.outbound.protection.outlook.com ([40.92.69.88]:23982
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725847AbgDKEH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 00:07:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSM4tUe5dR9psexG0ixcSfE4JqMqpnTfWA5e2SlIiNZ8cvMKeAKODvrV4k9QOWCN4mIEQx6PVc2KeDZKomYY//n5a7NZp7F+dv6jCV3QyOZMVH1oPsKIZ21ZDZHJuLp633c0t+dIKhzsdRi1BlEQqS9mkFV9SQF5gSle8wIo14HfFvmaN3d9sTb9vEg3eZBny0j22HeYIxqq2Lh2jKdpUo5QJakrclnqABEkNFRN7AVJB2de6tCiV+cQCO+hbh3Zon9qY/DhaVwc/Gjp2DKMk/nAvddo8iNEKBIepJDckrJpik4vaachlh9SqJ9ae7NmHlQOdA4C5toz5GGC52VKyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CVlM3+nr4ib42WseD8asH8eCMh7KnLh3nM117zAT/A=;
 b=IwCocVy0Tk/Z/dsf2PJfAG87dv3yz50zjObXWU6AU59SnQeFov4pBVyJsU+SJIol5pvfGXkwgleLoKlWzjCeKAacm6CMF2duWH17ILg9n1siIS5Va33NxXi5wMcNWoWtzub18zfgXIe2yCSgznMnraf56XvmW1+LZlAUS5QKRoZjE95KOLYMkYs8qcGcCEOlAGqvX8TWo3D6t0jvMsueQqMA3duXeS3OaYzN9TGMF7u4Z/XqNu1GQaCZ0RI2iQNpoKIkmwH47RTGuG5+0r1/pav+oOHDJ4JcFLI28bFMhFqgdSDSYoZypt2bMOIBSxWdIFYbE7L01PMvrrmsp3rfBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from VE1EUR02FT026.eop-EUR02.prod.protection.outlook.com
 (2a01:111:e400:7e1e::44) by
 VE1EUR02HT127.eop-EUR02.prod.protection.outlook.com (2a01:111:e400:7e1e::356)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.18; Sat, 11 Apr
 2020 04:07:49 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:7e1e::47) by VE1EUR02FT026.mail.protection.outlook.com
 (2a01:111:e400:7e1e::77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Sat, 11 Apr 2020 04:07:49 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:817416C312856FA78D3C597E2003B48B9F7D4118F45A93CCBC4B4BB9195E861B;UpperCasedChecksum:80EC4C266AAB70BFB255EE9709518F425BE5D111BA8FDAD50C3ED0F363956B57;SizeAsReceived:10029;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2878.023; Sat, 11 Apr 2020
 04:07:49 +0000
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
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
 <CAHk-=whKHpERyVv2-C+kxq9KV_mJPW3hkGDpn6f4yOvs+au8SA@mail.gmail.com>
 <CAHk-=wjmQREQzDa8LEoA2L=v=nWASk4n9R=G8SuAZ-1NK4FGPA@mail.gmail.com>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Message-ID: <AM6PR03MB5170714861EE813BF3EE51DEE4DF0@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Sat, 11 Apr 2020 06:07:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <CAHk-=wjmQREQzDa8LEoA2L=v=nWASk4n9R=G8SuAZ-1NK4FGPA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0107.eurprd07.prod.outlook.com
 (2603:10a6:207:7::17) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <7ca8b273-3222-b13f-51a5-53e70bba4074@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (92.77.140.102) by AM3PR07CA0107.eurprd07.prod.outlook.com (2603:10a6:207:7::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.20 via Frontend Transport; Sat, 11 Apr 2020 04:07:48 +0000
X-Microsoft-Original-Message-ID: <7ca8b273-3222-b13f-51a5-53e70bba4074@hotmail.de>
X-TMN:  [bD67wqo8RC7fxLaBVOHOYug3Oq8KXNpF]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: d8931ce9-20a8-4975-b29a-08d7ddcde601
X-MS-TrafficTypeDiagnostic: VE1EUR02HT127:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NNg9YWaKu0eZCfE4BxcH6qpMmuwwMseLeIJCCucsOBzVfytZTQ9kBphIRhIhkzWfL4pCGMnJuIKkAB5A+j2H+i0HPU1oWd/FcK4/z8SliCS519eM/ExIsryuXGzCAuflU4HfNLltKCcmmUHv5dryo/hd+fuy5UYB1tM4xdodyFY6gK7FJL/r6RFPWYy/sjUD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB5170.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: yChoIlmXTVKsZzDse2wULXMFmWbPb2DKUVep6uuReiIBhgNBY2E91t57rdGYolzmJI2sOEu1TRfFlOwZW9sQgK+dSzXl/v8lMq6Io3n6CwEcnH6Pvft8DXuhBCRPVj9ezQYDFKc9f9R6JjOUZXQUNA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8931ce9-20a8-4975-b29a-08d7ddcde601
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2020 04:07:49.7297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR02HT127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/20 2:32 AM, Linus Torvalds wrote:
> On Thu, Apr 9, 2020 at 5:30 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Instead of trying to change how notify_count gets decremented, we
>> could do something like the attached patch: wait for it to go down to
>> zero, yes, but go back and re-check until you don't have to wait any
>> more. That should fix the underflow situation. The comment says it
>> all.
> 
> The "attached" patch wasn't.
> 
> Blush.
> 
> Here it is. Still entirely and utterly untested.
> 

Okay, if this works, please do not only make sure that our own test case
works, but also that the strace-5.5 test suite does not regress.

So currently at least one of the test cases was failing
before my totally crazy patch.
After my patch exactly the same test was failing.

So please make sure you don't break their tests.


Thanks
Bernd.

>            Linus
> 
