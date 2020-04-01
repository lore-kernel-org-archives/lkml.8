Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F4BC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 12:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28CF20714
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 12:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="qWy6Ut4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732523AbgDAM1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 08:27:23 -0400
Received: from mail-bn7nam10olkn2107.outbound.protection.outlook.com ([40.92.40.107]:6307
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726920AbgDAM1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 08:27:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ei3dypfI7UieyetDod9WXYlzWdkfJgBOwosU9yCspjLuwB7n94sEMrLAKxhqJhGUS259NSwdguDEdWpdk4Aeb4//RV2uGncTVgMZStfgIjNVScI85LTbu+xqMZCTOQG2hV2lAf0L1oCfeHdM2SdYs4ooOaUVzqtNL43ubrRJ+QCc27Lj08jIR26GoI25Og+9fYooMaiav1Yngl7w7b/65fwxeBEUO1mjYwjf5FisA88j8w6l/dKMYxhnZjEVVri5a/A1CHRKb7nEcJjm3pWD9MGPeDHyL5LbZ4oexPSqe20MSqBAJnQ/IL5A4obwt/QKtZJqcz1IyTW05jjmaPhArw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2tivp2GTe3AODk37dMXfHLRzJL3WCloMRlOGkRCJxE=;
 b=hbZs8F6YQqZye1+0avLfpScbbo3ZTs5h3EXardfvHyZpl5W62Ow6IfcaoZBRwW7MBKtBpuBedC/Q/aTSk0t+jGfTagy13cW0FVUK/jbR7TUmmbkXzEJcuOfC0n9HZIHTLeaxwa9kjwK7Clm1iVVt3HnwRJ37wGc6Q6K4MVD6jL93yEbkA1IX+9trm7D6HR5ExYC8lOLvjq92htOe9w24PS8lSzsxIuECggmoZgwtuOmI4MKJUKCbK35EQfmY1LRxdZDFIhOTg8qT8PdEu8tsT3vlg5/8TydafRwxM+17g5jIkvOcMFegzSeCy8a6Sf5LSN5j0uo/CYoEzv9OGcCqEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=live.com; dmarc=pass action=none header.from=live.com;
 dkim=pass header.d=live.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2tivp2GTe3AODk37dMXfHLRzJL3WCloMRlOGkRCJxE=;
 b=qWy6Ut4u/tbHt5BE0oHaIVsVXj3ZmhCb+KoJnm3A5x//mPGXNX562kPlOz0Ln0pKf8CQwxVngbYohTAOY/FQbOpBRC6l/nal2wFQ8/peQ9V1MQCEcQnCBye0Aflkbgc9/Nal31DJRTELWkR6PyFBuuQiK88UX5z0mghyqxxa1fZXWM78zoYbqhM2sXq0mArxwQkaVD6RhyZAYy7P2NBtNcMTCNYd7XXEe5HIlD080zRnwDatmyNNWeZuutuBFFxMVOMpGLBHJ49iddaojl7iGN+F9gREiVl0AId38Qdfi4+5A/w4oI6dbwbN00U72QGBJHbepS44uQY8WhLun+TR5A==
Received: from DM6NAM10FT059.eop-nam10.prod.protection.outlook.com
 (2a01:111:e400:7e86::40) by
 DM6NAM10HT156.eop-nam10.prod.protection.outlook.com (2a01:111:e400:7e86::334)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Wed, 1 Apr
 2020 12:27:21 +0000
Received: from DM6PR11MB3531.namprd11.prod.outlook.com
 (2a01:111:e400:7e86::46) by DM6NAM10FT059.mail.protection.outlook.com
 (2a01:111:e400:7e86::327) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Wed, 1 Apr 2020 12:27:21 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:091FAC6289E42055F829E1C0ABC848AAC39A94125DC3B59C5038A909F08DE75B;UpperCasedChecksum:83BAA32EE2220F0C620C15859EFE4A75B8D0DA7CC85FFB4DB88AC501592408AD;SizeAsReceived:9117;Count:50
Received: from DM6PR11MB3531.namprd11.prod.outlook.com
 ([fe80::c844:3598:abc4:cc3c]) by DM6PR11MB3531.namprd11.prod.outlook.com
 ([fe80::c844:3598:abc4:cc3c%7]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 12:27:21 +0000
Subject: Re: [PATCH] kthread: set kthread state to TASK_IDLE.
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        liyueyi <liyueyi@xiaomi.com>
References: <DM6PR11MB3531D3B164357B2DC476102DDFC90@DM6PR11MB3531.namprd11.prod.outlook.com>
 <20200401093904.GX20713@hirez.programming.kicks-ass.net>
 <DM6PR11MB3531904888FBD86F4ED43009DFC90@DM6PR11MB3531.namprd11.prod.outlook.com>
 <20200401111217.GC20713@hirez.programming.kicks-ass.net>
From:   Yueyi Li <liyueyi@live.com>
Message-ID: <DM6PR11MB3531E5C5F509766C47CFF880DFC90@DM6PR11MB3531.namprd11.prod.outlook.com>
Date:   Wed, 1 Apr 2020 20:27:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20200401111217.GC20713@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR0401CA0012.apcprd04.prod.outlook.com
 (2603:1096:202:2::22) To DM6PR11MB3531.namprd11.prod.outlook.com
 (2603:10b6:5:61::21)
X-Microsoft-Original-Message-ID: <461a0710-6bb6-ead4-5547-9bf7d6ba1769@live.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.6] (123.123.4.113) by HK2PR0401CA0012.apcprd04.prod.outlook.com (2603:1096:202:2::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend Transport; Wed, 1 Apr 2020 12:27:18 +0000
X-Microsoft-Original-Message-ID: <461a0710-6bb6-ead4-5547-9bf7d6ba1769@live.com>
X-TMN:  [crgSFpb+6MmX2byfO7XtMQIJRdvZ8pp0]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 50
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 489820e0-ea73-45cd-013c-08d7d6380635
X-MS-TrafficTypeDiagnostic: DM6NAM10HT156:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HC7+9lJySebkLqJ95egMGB3jXbzRylzxqiTufXo4vLgRb7NMV5O2xPenN5YUZS1Edoxe0bQmYx9zMxfqxFUiAiUpRDTxUkLUfFY53Rck+QhqWbR+UcFfdAU/fM42GkWVOHZWAPlQxD0CfviqsVG5scVldPf/YQYz7/Iy60caU3pZ2s9sNH4rMq7GbBywR2fb
X-MS-Exchange-AntiSpam-MessageData: z5NYoVp1e+MEVR+tXbLH4yO/gI2d1jGx235iELTHRib4NaJ03+4TJATRqP3xpsBQmMl4t3iVsgS0+gP5KSjCdZc/gXe+Cz/zZNKlMhrgj2/1vNgGZggdR58FslCQeQ1tnIYMYcbMw+j/H2AdZQMQFQ==
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 489820e0-ea73-45cd-013c-08d7d6380635
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 12:27:21.0801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6NAM10HT156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/4/1 19:12, Peter Zijlstra wrote:
> 
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
> 
> On Wed, Apr 01, 2020 at 10:40:28AM +0000, Li Yueyi wrote:
>> I create a kthread to do some work will trigger system restart, i don`t wake it up immediately but wakeup it in a HW irq handler.
>> So this kthread sleeps in TASK_UNINTERRUPTIBLE state until the HW irq coming up.
>>
>> Did i do something wrong?
>> Should i wake it up immediately and then call wait_event_xxxx function to sleep it?
> 
> This!
> Oh~, Sorry about top-posting and....thanks for your answer!
