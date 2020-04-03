Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730EAC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F4E206F8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404585AbgDCQgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:36:48 -0400
Received: from mail-oln040092069092.outbound.protection.outlook.com ([40.92.69.92]:61201
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728338AbgDCQgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:36:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4+twurKisog2SUs5DaOnkKVFkqc46eMolqGAbcoK8B4QTHktLb3egHzdVpiP4jF8V6IWf59e7MgzibhI34rGt9u1ClD04ZfmhmldW8YnM/hhw6h2VvefY9i+/8VlcYwbmGxhWffJdGyYMkN2E8KLMbNv8zwb9HOM4iZtzbhLBWH0ujoKF/wz+/1oHLHa9TapahHy0U44/5tlezyG2uRq5Ja3bnCNyB4cbYhGPoota1G4TtTmvAUlfT2tTwiSbUe+yaZeo723QDbZbn02g9ginkqtJj7lYVM/t5NL67gnqlJzqmpztmBLKBEdVAGbtTmCWu9Ur9h/ZxMRt/oRLXirw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+E2d6KD2qKeCW6pUvX4z9vrgjp7jlX14lFHuzvN6BF0=;
 b=HyTpYBks03B/uDotNZr2cxyRscggbnkn8W7nYGYysJSbZaiwJeNf2Y4ZDSX37iY8W+0ROBnvhhWnmjPdj0YZGcb1aFpqoZQIKJ2hXktYw0ApHKUbZTRc7tin1+NK4UIQxwvl4XriV/XOeinJxPN4zyOAwtegxLX79LsuaQ1Uapzqm7xfUuDYOUOqsYX9n/qKOHZj1gBfoY/MEAav39q9gVjHysp1jkJ1ntuuYWS0u7YNHXl8xhFvVTeHl2/mtFjSTpzxdBRIehAegJ8tA0P1KstgVXLG5L8Jd66KHyQbV+w5Pg5cpg7LJeo1GdiyY88XYH9yPP3qJZJQiMM2ldLZAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from AM5EUR02FT064.eop-EUR02.prod.protection.outlook.com
 (2a01:111:e400:7e1c::46) by
 AM5EUR02HT084.eop-EUR02.prod.protection.outlook.com (2a01:111:e400:7e1c::293)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Fri, 3 Apr
 2020 16:36:44 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:7e1c::53) by AM5EUR02FT064.mail.protection.outlook.com
 (2a01:111:e400:7e1c::307) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Fri, 3 Apr 2020 16:36:44 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:3197DE4390BC6A71EF52A4B04F5CED52F68BD42B0C153AE06EFF47E915453A72;UpperCasedChecksum:535BB95C6634EE0692316C3AAD68398664E0B4216A63C6CD1655DC2D66551355;SizeAsReceived:9152;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2878.018; Fri, 3 Apr 2020
 16:36:44 +0000
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
 <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB517026CDE64EC57DE37C6080E4C70@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wjqNnpsBJR1xM_Ce91cNh=24CDt6ibpL2G=vDUbSFGR8g@mail.gmail.com>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Message-ID: <AM6PR03MB5170147F396B3F40D093C499E4C70@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Fri, 3 Apr 2020 18:36:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <CAHk-=wjqNnpsBJR1xM_Ce91cNh=24CDt6ibpL2G=vDUbSFGR8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0029.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::42) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <b84f7c97-8e65-1559-baab-af8fbbabb85d@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (92.77.140.102) by AM0PR01CA0029.eurprd01.prod.exchangelabs.com (2603:10a6:208:69::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend Transport; Fri, 3 Apr 2020 16:36:44 +0000
X-Microsoft-Original-Message-ID: <b84f7c97-8e65-1559-baab-af8fbbabb85d@hotmail.de>
X-TMN:  [AKlBEVzCpQWq5bT1OUDkn9WUj7aaOUBm]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 41e33b85-6506-4b5e-3765-08d7d7ed3221
X-MS-TrafficTypeDiagnostic: AM5EUR02HT084:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Txy65VvLASkzmO8x0UwaL+n8jdcQaH0+YBfPbXRu9D6LWHnhWX+AcL+78BwazZkIWIsjQSTn/2rgTdvX/AMcIlxc7eMJkr65UyQZY37iQG24KZNgjYxFXtLPpgMXOg46Wg1NMsc52nwBOAiA4RoKf0VIO788H4l2wZUO5IgO58+M6LM5E2qfqNHME4rUkRR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB5170.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: Jf4lzunqRdOI0YumC17tKSkkfM/p3ztCrYltO0AWSjOB7Q+Rdy7dxqpMZ6XBdn/ZLqtq1Bod+s1ouraMkEPDfJ/ltEl9S7xg5fNV3O8UJvaw5wfZMidGUmCE5TVzzp5wVPeTpy2pkh4PicjtvojDxw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e33b85-6506-4b5e-3765-08d7d7ed3221
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 16:36:44.7871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR02HT084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/3/20 6:23 PM, Linus Torvalds wrote:
> On Fri, Apr 3, 2020 at 8:09 AM Bernd Edlinger <bernd.edlinger@hotmail.de> wrote:
>>
>> On 4/2/20 9:04 PM, Linus Torvalds wrote:
>>> In fact, then you could drop the
>>>
>>>                         mutex_unlock(&tsk->signal->exec_update_mutex);
>>>
>>> in the error case of exec_mmap(), because now the error handling in
>>> free_bprm() would do the cleanup automatically.
>>>
>>
>> The error handling is sometimes called when the exec_update_mutex is
>> not taken, in fact even de_thread not called.
> 
> But that's the whole point of the flag. Make the flag be about "do I
> hold the mutex", and then the error handling does the right thing
> regardless.
> 
>> Can you say how you would suggest that to be done?
> 
> I think the easiest thing to do to explain is to just write the patch.
> 
> This is entirely untested, but see what the difference is? I make the
> flag be about exactly where I take the lock, not about some "I have
> called exec_mmap".
> 
> Which means that now exec_mmap() doesn't even need to unlock it in the
> error case, because the unlocking will happen properly in the
> bprm_exit regardless.
> 
> This makes that unconditional unlocking logic much more obvious.
> 
> That said, Eric says he can make it all properly static so that it
> doesn't need that kind of dynamic "if (x) unlock()" logic at all,
> which is much better.
> 
> So this patch is not for consumption, it's purely for "look, something
> like this"
> 

Works for me.  But I also want to wait for Eric, I am curious.
I have a lot of time.


Bernd.

>               Linus
> 
