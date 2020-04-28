Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D011C83002
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 02:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2381206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 02:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgD1C4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 22:56:54 -0400
Received: from mail-vi1eur05olkn2068.outbound.protection.outlook.com ([40.92.90.68]:20449
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726047AbgD1C4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 22:56:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NoEA/9q1843wE1QvzXBuaUoFFZ/9rOJlTERogoSjvqcZ3gr14v1xAr0EBwjwSivvfbZ9E2KVG1YoWJywtoTqW3LaeqCka++bRCh1ujwKZyOZrFSvQaPPh5ffc5Z/QHFodcSYcs9GlUKKb2BxK51IO89vDYVCX03SbFw+2tl5++eoUlBiEqgWO9bSeJF0p4e9BYLvYZ9ZrdPiHpO5Vij+Q2H7Rj6ZWNrnnzJqBpwWE5b6V3dt4YDl9sLHu9mFi6JGCDUzUIHPMgZmmlKu0BfkvA11axuB0OHCFjizWX5XkgUpfOxgA/unVqoZxM2Q86sOlpWdCQf8qKCj9R0Ob5ugiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WK9JhiI+xvpHSocxp0PozSfbpood0imNDXj+E8y36HM=;
 b=LahGjZ9eshmK83lLNcZOoWMA1BWBLBHBtZ/YxWhs8VYufNGb/SZjnjk29I/f+wj+p7h5PSj5exi4hQnIYG6dlRNcMJeXfzcvQalrOUghI6DojViF2rJAgSNuLmiRjvprWtH0oK9LH94NoCygt2H3aps9uDFQmWKyBdvgrhFsiu8A5fSPWpCJ9MbwaEHX1AFfJ4uIf9zLVIHePbfLBEnaq4huiujzghIol4LO8wPG+SiU8/u0l5as5RtlyI0edfenI0QMolwoamlX73BxAhPP9VNvqhes034bj5yAtdD8/JW/B8q6Cbs+3DzfZ3O4tGbLqGdkjHG2wKpjPgwhtixrzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from DB8EUR05FT034.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc0f::4c) by
 DB8EUR05HT119.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc0f::465)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15; Tue, 28 Apr
 2020 02:56:49 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:fc0f::53) by DB8EUR05FT034.mail.protection.outlook.com
 (2a01:111:e400:fc0f::100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15 via Frontend
 Transport; Tue, 28 Apr 2020 02:56:49 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:BDF64E6B31DD233F4A820478F80B17D30E3859DF118A5E17E83177EB2FF20EAC;UpperCasedChecksum:8F44027AA88446174B8E87F072357164B51393D432802EE23ED35B456F055FEF;SizeAsReceived:9815;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 02:56:49 +0000
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <AM6PR03MB5170F924EA69A81D79BD0929E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whMKC5F-=QQP=fCNRuTF+ZGiNtLEKvx7KekpK1JtrwDhw@mail.gmail.com>
 <CAHk-=whJ8khGBqfqh6ZmHsKjcyyBLm5xgkgLW_AC_=82iFBWoQ@mail.gmail.com>
 <AM6PR03MB51700B243E34BF4A59FF33CFE4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <87imi8nzlw.fsf@x220.int.ebiederm.org>
 <CAHk-=wgh4zts+3hdkGzHLJ6pBGumcJ=23gRbMfubDrLstis2Bg@mail.gmail.com>
 <CAHk-=whKHpERyVv2-C+kxq9KV_mJPW3hkGDpn6f4yOvs+au8SA@mail.gmail.com>
 <20200411182043.GA3136@redhat.com>
 <CAHk-=wgwXpKepChGi4ZhQVxZxD0ic8s2CDXvUmqBTMaKGz-fjg@mail.gmail.com>
 <20200412195049.GA23824@redhat.com>
 <CAHk-=wiDwR+6ugYaKEGHfYteLF+NH5xu=T7uuUTkK9y-hr6zow@mail.gmail.com>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Message-ID: <AM6PR03MB51708CF53D8A02086427DAC2E4AC0@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Tue, 28 Apr 2020 04:56:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <CAHk-=wiDwR+6ugYaKEGHfYteLF+NH5xu=T7uuUTkK9y-hr6zow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0124.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::29) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <5e8e4337-97fd-0ad9-4fc1-7e7fa55b7f4d@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.102] (92.77.141.164) by AM0PR01CA0124.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Tue, 28 Apr 2020 02:56:49 +0000
X-Microsoft-Original-Message-ID: <5e8e4337-97fd-0ad9-4fc1-7e7fa55b7f4d@hotmail.de>
X-TMN:  [wMp8BVBcp5UuQTPrtmKRyDWOafD6u+YY]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 38d30ea9-cc91-408e-180a-08d7eb1fcbe3
X-MS-TrafficTypeDiagnostic: DB8EUR05HT119:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kAvWh0T8yOHf+WVJL7LV47liHnUpv0pRsXSUXsl/s2r/+cQ14+uuOIJH8DOWTgl27+cAPRg2rSAygOnCLNkM69jbJTVw7LiKNh6r2XBMEA87UZtYvlj8/fsvXMnq4yc9qoHxtno3p2+/GyxIiISQ0ekGt0sND25sruuFSw1fuOCdaD7pHOj8Q8Ec6fB+whrz//gZJvD+fqb/S5JK7UDM7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB5170.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: rhpeV5zHfJ1drC5QMfineRA4utNmBXDcyyu7f/ftkvk964g4q+xMfMRBMVat8eh/hMfmticyrrBPjztAejhnoICWKvOWaI0pVSvcULgiigJyubAeGwFuV/ZSe9mzF7Y9LHhong2nyMj/0Lvw9c/3oA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d30ea9-cc91-408e-180a-08d7eb1fcbe3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 02:56:49.6903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8EUR05HT119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/20 10:14 PM, Linus Torvalds wrote:
> On Sun, Apr 12, 2020 at 12:51 PM Oleg Nesterov <oleg@redhat.com> wrote:
>>
>> To be honest, I don't understand it... OK, suppose that the main thread
>> M execs and zap_other_threads() finds a single (and alive) sub-thread T,
>> sig->notify_count = 1.
>>
>> If T is traced, then ->notify_count won't be decremented until the tracer
>> reaps this task, so we have the same problem.
> 
> Right you are.
> 
> I was hoping to avoid the "move notify_count update", but you're
> right, the threads that do get properly killed will never get to that
> point, so now the live ones that we're waiting for will just hit the
> same issue that the dead ones did.
> 
> Goot catch. So the optimistic simplification doesn't work.
> 
>>> You do say in that old patch that we can't just share the signal
>>> state, but I wonder how true that is.
>>
>> We can share sighand_struct with TASK_ZOMBIE's. The problem is that
>> we can not unshare ->sighand until they go away, execing thread and
>> zombies must use the same sighand->siglock to serialize the access to
>> ->thread_head/etc.
> 
> Yeah, they'll still touch the lock, and maybe look at it, but it's not
> like they'll be changing any state.
> 
>> but see above, I don't think this makes any sense.
> 
> Yeah, I think your patch is better since my simplification doesn't work.
> 

Ping...
was this resolved meanwhile?


Thanks
Bernd.

>              Linus
> 
