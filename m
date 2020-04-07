Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FORGED_MUA_MOZILLA,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9811FC2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6443E20BED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgDGU3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 16:29:48 -0400
Received: from mail-oln040092073099.outbound.protection.outlook.com ([40.92.73.99]:39779
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726277AbgDGU3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 16:29:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JrvHjL0FuRtXw9S8sRWwIw69Zc3XVX+K6C3WjtDb4RUMVIrdmcUXdI3/SFECQ89NirtcHZRI9B8sqDLIvRhBbH5IW3enl10oeFDCjfFlxXeOQk9oWO9POPmk3igLhFZmI2/Xvl2ly+j1R4XVQuP6waWGMUBqexIUGs2oSb16b25FH3GGVntFz/cvoTBmx29PgAqr2eOA4fOrO6vfOmqqi0M5SksO5mPPQB1BjiWJ8VwbD4lz88pbIEvuCPetfpdgIUt6WglrkEC9lgDaHDajKgnpiNVmHE8JmcvjHaDSFzC3DPILk9vVrvPe+84xxUtQnT89vfJFBiXCkzDqBU9D/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROtOSOGLIwJACWLPJPXSopqTC99UdVIul97VvcXgXtY=;
 b=SUlD9P4GdatIuPBRUOmcyNr/b1d76gDNsribFwDFiyYt+9ryA10E1xCE2S57/8b/j/qYPAS3Xnsi3bPgDstfydRAtE30l4iR14WVfyhGUneSiEKS+9zbUAGrMClivV9rZub8t66j4Aut1J7nL+SJwhrUGMgs8xITc7eBmhcD2OmY2Uig2B3sbwkLxMPBH3Z4XpOVNOZwJeTz0+AFnJuk807+G0q24mY/blovrXseKh6YA3amCY/L7Haa+PYn99D9T27A1bZIgCjE3B8je0DFRvm1vCSwlziskTnFX4DDHwLrQKSXYA0lDvB9jizGkJ3pfcEX2GOniu5HjdvbhFmKHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hotmail.de; dmarc=pass action=none header.from=hotmail.de;
 dkim=pass header.d=hotmail.de; arc=none
Received: from HE1EUR04FT063.eop-eur04.prod.protection.outlook.com
 (2a01:111:e400:7e0d::53) by
 HE1EUR04HT166.eop-eur04.prod.protection.outlook.com (2a01:111:e400:7e0d::227)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Tue, 7 Apr
 2020 20:29:44 +0000
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 (2a01:111:e400:7e0d::48) by HE1EUR04FT063.mail.protection.outlook.com
 (2a01:111:e400:7e0d::308) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Tue, 7 Apr 2020 20:29:44 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:9034E2FAE3C6A0AF064040DAC0AC749C8B529CC06BA4F0E9A39FE20D0342FDD5;UpperCasedChecksum:C6FE3EE06C121C990969EC77CC1EBCDA06321D1AE0E4F4225D3A5D7870E9C871;SizeAsReceived:9646;Count:50
Received: from AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d]) by AM6PR03MB5170.eurprd03.prod.outlook.com
 ([fe80::d57:5853:a396:969d%7]) with mapi id 15.20.2878.018; Tue, 7 Apr 2020
 20:29:44 +0000
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
 <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
 <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
 <87lfnda3w3.fsf@x220.int.ebiederm.org>
 <CAHk-=wjxyGCj9675mf31uhoJCyHn74ON_+O6SjSqBSSvqWxC1Q@mail.gmail.com>
 <87blo45keg.fsf@x220.int.ebiederm.org>
 <CAHk-=whES-KCO6Bs93-QBK1tS5CfiWSi+v5D1a7Sc1TD5RFoaA@mail.gmail.com>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Message-ID: <AM6PR03MB5170FA8CACA7A1BB2026F55EE4C30@AM6PR03MB5170.eurprd03.prod.outlook.com>
Date:   Tue, 7 Apr 2020 22:29:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
In-Reply-To: <CAHk-=whES-KCO6Bs93-QBK1tS5CfiWSi+v5D1a7Sc1TD5RFoaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0025.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::35) To AM6PR03MB5170.eurprd03.prod.outlook.com
 (2603:10a6:20b:ca::23)
X-Microsoft-Original-Message-ID: <408a5daf-5da4-b0a5-41b1-5d5f4f21aa53@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (92.77.140.102) by AM0PR10CA0025.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Tue, 7 Apr 2020 20:29:43 +0000
X-Microsoft-Original-Message-ID: <408a5daf-5da4-b0a5-41b1-5d5f4f21aa53@hotmail.de>
X-TMN:  [+ZsJmrhexmOMsFHUPmvlvMUf1Gxmomls]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: da0d6ee5-6d9e-49b7-a165-08d7db32684c
X-MS-TrafficTypeDiagnostic: HE1EUR04HT166:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vXK3+KePT2Euw3Svh1a+Navn8ciYaYsn38QoiDtA+hZeDf6D8kKhAY5Ndw78lWIHxvqw5VWsRkrFmk9uDmgJSy1iKHfbNJ/sS6gm9GdPPFnl+Zi76IS75WpiLOsLmvQ8cu5PE2CrMdaTIN93zFDwqkcvbxzz0iiYUOfcze1zkSlYcbozxbR+RAwmAmFukJJB
X-MS-Exchange-AntiSpam-MessageData: DIs3qFgF16dzcsPFyVHkY5j6PecD+AORoCF3vxDC8whrkM1OM1CLMeNlnnsTJvsS7rzhI0+ovZtArGogIoku2juk6C5c7KhtIUbIw8qJA421eH8MFYs48qd0srLKgJMaqJ0b8IjQchwmiQLF6ywPVg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da0d6ee5-6d9e-49b7-a165-08d7db32684c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 20:29:44.4662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1EUR04HT166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/7/20 9:50 PM, Linus Torvalds wrote:
> On Mon, Apr 6, 2020 at 3:20 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> But fundamentally the only reason we need this information stable
>> before the point of no return is so that we can return a nice error
>> code to the process calling exec.  Instead of terminating the
>> process with SIGSEGV.
> 
> I'd suggest doing it the other way around instead: let the thread that
> does the security_setprocattr() die, since execve() is terminating
> other threads anyway.
> 
> And the easy way to do that is to just make the rule be that anybody
> who waits for this thing for write needs to use a killable wait.
> 
> So if the execve() got started earlier, and already took the cred lock
> (whatever we'll call it) for reading, then zap_other_threads() will
> take care of another thread doing setprocattr().
> 
> That sounds like a really simple model, no?
> 

Maybe, actually I considered this, but I was anxious that making something
that is so far not killable suddenly killable might break other things.

But I am a wimp :-)


Bernd.




>                 Linus
> 
