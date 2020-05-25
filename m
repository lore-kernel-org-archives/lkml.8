Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1C5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E6C62078B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="A/B18SGB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388630AbgEYG2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 02:28:54 -0400
Received: from mail-bn7nam10on2040.outbound.protection.outlook.com ([40.107.92.40]:26273
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730113AbgEYG2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 02:28:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQdsbpQ2UHGdkOh59r6glEhshGyusqLcmu37NXXS4onxdxX9YjtXhfecSBiPeBz9TVuZXapBihPlQfMKTqVH4ZoxPgjuomi4Tdr1Hqq80drX8jCCUdYM/A1o9KEme4u1xsE9aQOazT6tfmDBWUYwUG/QxJpOOL77op+ser357Yxx8mGj/ajl4uzujsRR1hrXuFTBcLpSGntfrx0TeWQqbzn9QNtopV4yL28mPxI0+ji2SzpElNeH1dxiweftdInOG/9spTwvUOTG7QcwtWGOjHJIQ4vjeuX7VEL1/qRFesH7k9otXsGnhQZ+yYXYGZ/krUTiWAjkCAxxSbgHbnCF0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44ETfCzMO2uG6HiMRKAwSTLcNoVE6oQydn0GVvJF0JA=;
 b=KdK1ZgrfkjcajNp88TxLkACO8zhd3ru95YKvaM++NEksB234H+MRdOpeiYLkJgsvtU0vWkIZHv/uB49GCOs/G5ZXFQ0jITA3lzlBbSohaejzkfzRW5ieNSdFfWIxMAarx0sZVPYRwJldWxstf3GtA06LkVUlKV1AHEaO8tO7HoDPCrDb7uS5yAr+f5JObySNoSctdYfwc61RKcyRUbiyefbcEVxmwe1jejKUUkGdqQaETijuWok41S2+LYSjSzTeZCsjuia+pwQHAaxeHT5hyhMoj8GtQawc2PihK1xrZdYempmJVHP4fzNismj08PzIrT37IkBY2hpha+h6vo9fpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44ETfCzMO2uG6HiMRKAwSTLcNoVE6oQydn0GVvJF0JA=;
 b=A/B18SGBa+XH/2/m4ncZ9QamK7nqVCwUyGHJT6Taht96Q2YedY/fzNywhNbsY2X9VepiJiyLr/DGM0aK4TXI3PRzLFGTNd0916Bn41R5EMlmrzVAKSEAIHNnH3RqrnCYgPrTvhY0MyUp2+bHSjirQlyDDyD1z24lSeDL9hD/68M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BN6PR11MB3954.namprd11.prod.outlook.com (2603:10b6:405:79::35)
 by BN6PR11MB1921.namprd11.prod.outlook.com (2603:10b6:404:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.26; Mon, 25 May
 2020 06:28:48 +0000
Received: from BN6PR11MB3954.namprd11.prod.outlook.com
 ([fe80::c05b:5a81:29d8:6b7f]) by BN6PR11MB3954.namprd11.prod.outlook.com
 ([fe80::c05b:5a81:29d8:6b7f%6]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 06:28:48 +0000
Subject: Re: [PATCH] workqueue: Fix double kfree(rescuer) in
 destroy_workqueue()
To:     Markus Elfring <Markus.Elfring@web.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <96b49f22-50a7-9c8f-7c9d-f178195de717@web.de>
From:   qzhang2 <qiang.zhang@windriver.com>
Message-ID: <d9dd0dc2-e169-6a63-9a79-d692994324f1@windriver.com>
Date:   Mon, 25 May 2020 14:28:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <96b49f22-50a7-9c8f-7c9d-f178195de717@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR02CA0133.apcprd02.prod.outlook.com
 (2603:1096:202:16::17) To BN6PR11MB3954.namprd11.prod.outlook.com
 (2603:10b6:405:79::35)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.183] (60.247.85.82) by HK2PR02CA0133.apcprd02.prod.outlook.com (2603:1096:202:16::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24 via Frontend Transport; Mon, 25 May 2020 06:28:46 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44aad4aa-dc63-4f77-bd0f-08d80074e211
X-MS-TrafficTypeDiagnostic: BN6PR11MB1921:
X-Microsoft-Antispam-PRVS: <BN6PR11MB19216E8D02661D5A22FE296BFFB30@BN6PR11MB1921.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rnu+EnCOv0zQ4B6pF/uF3aoJxYYNqKZYA/p9eMaSg/fRnGWoPskoY4+/CUuoDRgZgD7/GyhHnPpW/cd8yAlzDYYOBtuqGRbz+C7RgdWwdmA1ASsx59YHQhPIi7diOX8r5la5fL336fdzwUUcwWHu8dEfBOM3LZD0UCYgIl31PDMPLUltudN1F2NVzGrrYr98YZxXsP9IoF3APXQqNCWHPsAcADzDAEYdocMCy4HLvpeNhGCj/clsnDwzAJlawE2Najxa/SAsD4WUn72ylcabOokdzStTtQEAkYgiljal6hTd7dO8mCfMRQPMNVMskLSy1b7awOThUVgysW5iaY/YzZvUFF/RPFq2KVGZaL6Qza4Z5Ym8A8xAMyNvhzOWfz+WVVXA/nOj/6rxQsuM+xf1rw7SMQ/y4jrByH4MvFJn8PcNh5SbvBSAreiE/cEfbktEUqo5RzPhqef4Wmxric1yBah+ZAD8aHIAshPSqS3H33c3Th+cyluRWmJ0vUxl2GxtwP9rUcuZ1AOHz2wunxmmWeWRAIEE1huvDwRXmFUGJgk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB3954.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(396003)(366004)(39840400004)(346002)(6706004)(6666004)(8676002)(2616005)(956004)(8936002)(31696002)(5660300002)(16576012)(478600001)(966005)(86362001)(4326008)(316002)(110136005)(31686004)(186003)(16526019)(36756003)(53546011)(52116002)(66556008)(66476007)(6486002)(66946007)(26005)(2906002)(78286006)(43062003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: AApfSbzYdwQV5g87E6RkS6eSaVlTNUW61OhX507VI3DR8ERJos5VgmdzGWBHrctZbs3lNmVygKToFCZUagJVINp33woZJgSs0G3baFiNNBJrQjOO6PSZeIb36xSRCt1pEyVcCXBVnhk369DUbWMJKNqBkAmicUM7dKZfy056ErTZYA4HIA2Ks0iwRxAaM8wYuBcmpIg4gqoHFMiug+GyX0ixfSR1S8UnSmTfJWm/Lkae3JToah1IU9xzPKJtmOU1QDxMSa8oiCvzW0mZ4jrm9YZgj5pXIHdVvXK7H/jR9w2veHFVVio358Wp4YduQ+I5D55T3eA62VOuk3d7Q+EB6Bw85xiGQ5BK+PSvJH3Rs6jYVyY//ihum7MyDmdzzHLVRKb4ftodzEKqRpBRNjA7vrQ1Kb9F3tFLlmE9YbovMtFdvHYqVYWPAMMU0m4WZuuiXM32wZUS87YAyvunQRdCQ/AWHQfeJewuX3M1MqCXwmM=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44aad4aa-dc63-4f77-bd0f-08d80074e211
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 06:28:48.4353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lAePpH2QrhvmLJpgcUPwhF3VzRhBWBW88oA8C6iGjp64Aj7eq4St91FtXHPApVQYZo+dI4IiMO2cCELV8zNVyi9/nlYOU+0LElNfEYbDW5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1921
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry I didn't describe clearly

I describe the meaning as follows:

	destroy_workqueue
		if(wq->rescuer)
			struct worker *rescuer = wq->rescuer
			kfree(rescuer)
		..................
                 if (!(wq->flags & WQ_UNBOUND))
			call_rcu(&wq->rcu, rcu_free_wq)
			......................
			rcu_free_wq
				kfree(wq->rescuer)

there are double free.

On 5/24/20 11:33 PM, Markus Elfring wrote:
>> When destroy_workqueue if rescuer worker exist,wq->rescuer pointer be
>> kfree. if sanity checks passed. the func call_rcu(&wq->rcu, rcu_free_wq)
>> will be called if the wq->flags & WQ_UNBOUND is false,in rcu_free_wq
>> func wq->rescuer pointer was kfree again.
> 
> 1. I suggest to improve also this change description.
>     Do you try to explain here that a call of the function “free_workqueue_attrs”
>     (or “free_percpu”) would perform sufficient clean-up of system resources
>     in this use case?
> 
> 2. You proposed to delete the function call “kfree(wq->rescuer)” from
>     the implementation of the function “rcu_free_wq”.
>     https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/kernel/workqueue.c?id=c11d28ab4a691736e30b49813fb801847bd44e83#n3482
>     https://elixir.bootlin.com/linux/v5.7-rc6/source/kernel/workqueue.c#L3482
> 
>     This function name should be specified also in the patch subject,
>     shouldn't it?
> 
> 3. Would you like to add the tag “Fixes” to the commit message?
> 
> Regards,
> Markus
> 
