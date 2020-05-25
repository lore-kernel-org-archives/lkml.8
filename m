Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C150C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04DA22075F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="Y8H8ioar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388886AbgEYGno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 02:43:44 -0400
Received: from mail-eopbgr760088.outbound.protection.outlook.com ([40.107.76.88]:35342
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbgEYGnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 02:43:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SUm8d2DrOou9YCdHSY13M9iHYESZavafGzBtm0Nuus7Eajs8cOJHmS0qKu9OEcGBgpp+4X2Q1pCu94M68TDSmQgsZLJEILlfy1bub15o09FYLMdlfkuU1lA9i3gVNE2LnUm4OvwkR1geUIEFd94WeaXtGd4jjmWEfQYpBqY4rBiepd2/pCroEL/hk2xz0Ie/tr1oRZBvV74XBLglmpwUJKAwiWiYUreT/OD8sWj9jM/0mMpr5OLNBO2idMguK7dqLyPzDiC6EzJMM4negcoQYUyTgncV38lu96sfVNMJK+TEIHcVjMEfV1WXMxdgT84V0LmWztX8OfdKcOBf/VmfCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CR1k3IYnonZ7TtHGKmv1Gec6Jm5s95480uejbVYecxw=;
 b=LlLLnzTTOqcFZklMYNLY2MBiJIN+7ECBb5t2LTUaYK0jdCZJkiDaOn1I9QeYNl1/ob0HIumV+p4nXZoKrOyaTfQGUNw2BtM0kNCwjsv3ZUPwrksZ3/uzHrCzJrRR7cyK/AlsyNsVICDdgRya4jblmBd3R0tHJyF97q/nxigTe0OGuvQZ87IeWkvGs2wOEyXioTo2cscvDIme2HPOM3A4k7QsAZHa/AR2/IpfsligxMNYMuPKzmJw/d9VutZP0Z8ZepN/cOl7OtnVgTdw64p1NEgZbEcUFD/BwFgnmtRey+7fnoknLpLIAZh0g83uyCJHA27O5H+glAZ7dYMh7ynL1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CR1k3IYnonZ7TtHGKmv1Gec6Jm5s95480uejbVYecxw=;
 b=Y8H8ioarrn/G4FXxkG3lP0/Pe/izMg88C0CT0KMCdgkOgmWNFTHi1qa8nMuqtGq5WeshVOcqpaE0oiSKobUd8vO2zfgKJDA5qqtyxnCdq6/NwGuW0LhSL+T4O39HOx8uGs8/7X0cb5Z5f11q6w4fzcUUHnw+iebM9YEgU+INsKg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BN6PR11MB3954.namprd11.prod.outlook.com (2603:10b6:405:79::35)
 by BN6PR11MB1427.namprd11.prod.outlook.com (2603:10b6:405:8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Mon, 25 May
 2020 06:43:39 +0000
Received: from BN6PR11MB3954.namprd11.prod.outlook.com
 ([fe80::c05b:5a81:29d8:6b7f]) by BN6PR11MB3954.namprd11.prod.outlook.com
 ([fe80::c05b:5a81:29d8:6b7f%6]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 06:43:39 +0000
Subject: Re: [PATCH] workqueue: Fix double kfree(rescuer) in
 destroy_workqueue()
To:     Markus Elfring <Markus.Elfring@web.de>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <96b49f22-50a7-9c8f-7c9d-f178195de717@web.de>
From:   qzhang2 <qiang.zhang@windriver.com>
Message-ID: <69170178-f149-b44b-6465-a4c6ab893d52@windriver.com>
Date:   Mon, 25 May 2020 14:43:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
In-Reply-To: <96b49f22-50a7-9c8f-7c9d-f178195de717@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK0PR03CA0111.apcprd03.prod.outlook.com
 (2603:1096:203:b0::27) To BN6PR11MB3954.namprd11.prod.outlook.com
 (2603:10b6:405:79::35)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.183] (60.247.85.82) by HK0PR03CA0111.apcprd03.prod.outlook.com (2603:1096:203:b0::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Mon, 25 May 2020 06:43:37 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fecc4d8-3cd1-4f3d-2676-08d80076f4fb
X-MS-TrafficTypeDiagnostic: BN6PR11MB1427:
X-Microsoft-Antispam-PRVS: <BN6PR11MB1427805026E27528F31324E2FFB30@BN6PR11MB1427.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0414DF926F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zuGFWhsvB2GJhPGxPgjY7PHj1uRv31OzKjo0Qyx3IgxXtPCpNj5JWbEZTuISvMU1nS1vRr7y37ueyaepUNMfas1MdR03kqW6yu1du5kHIzmJTikiry5krRnvMtlAgWmaFSY9fMa9ci2g7vOX6/+NkA5M00x0/vq7cz90j3O9q+5GAybZJB/fK9lBQ3i8fUMRfCwjFyBPYjIqThDwALph97nwS/z5Fie7vVKDGSMJ6SnBeVToxGzak1HvHFhon2q/1UCQhZx2QD6byK7hfaY72s0TCSS5YUh+1z1qxuYP7OOInsl7o8ltFrgAJcUG6xvK0ybfl4XpgzfONBeA7RjHLcgM3GeRxWIyTsfFLGaC3rFbtqhfBItQe8kvo2hRlgAoQKrSmmbf7SbdSOxy23FsKtBicwld9dRJ29GUuTZSRoEarBl03dZ/IoTTN9/MS5pcWaIPfbMnjDBOrRDFIReRdGhFMuJ1wacYnoLLvXRndDCup5HaygxEMXxCnfkJ2p+NIi+EKYF0QBzqeaJcRwSin66XI6YFdml5ew70JYXjlDg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB3954.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(366004)(39840400004)(136003)(396003)(6706004)(36756003)(66946007)(66556008)(66476007)(6666004)(31686004)(5660300002)(4326008)(6486002)(31696002)(26005)(53546011)(52116002)(316002)(86362001)(16576012)(478600001)(110136005)(966005)(2616005)(2906002)(8936002)(186003)(8676002)(956004)(16526019)(78286006)(43062003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 9ZHTYEqb9CZeBuF1Ht6OD0rDzpZRtJv74tigoBcnHrIeW60Q5M5DEfITHQgzyQ0GtblhQkQuZ8x5hvZqMR/uieIJlG7I1nxQyWdkqA1qJm2c7wW6r8duEXDkPI5mhX7I+Pi5D3/LsqB1f37QvTznsLz9UdGt6g9jgWhlGROKfcXlIBf9rXbHLbP/cVgayNafSSI4QvLhE4KYbfBo+BmV3dK/sneNMfv5QMJb3uA9oNQxzw7NcR1HffycYzR49Yj/RjsWVpfKJZ+r87Yg36HP4ZCronrfXkMjZ5r2czK04Jm2rnHQL5WGhe7mYC0wFt8cKX1PXFj3dAxaI1BXpjvRvMYOjkop1NM9t3otMvHlfWFPN4cl35JKc+bZyl/U+RdZfMjdXdy26yOxss3cupCJ/KJcx6SEq/R4jA8/DIRU9JuIz/Sad/htXbKNaCnnCk1d30yaAECbmLN1sMXMOIl88U0+YfeNcyT/rAkVungtsWM=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fecc4d8-3cd1-4f3d-2676-08d80076f4fb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2020 06:43:39.2454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xawy3WJ342o46T2kpC0Fe3oYVWRHOEsEr+Ep3Jb3hT7+lu53TZrTeXLyPPh6IocbUbFX9zI5YjTprOaS/831T8bGUMXD4Gbf2NKAIEw50S0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1427
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry I didn't describe clearly

I describe the meaning as follows:

  destroy_workqueue:
	if(wq->rescuer)
		struct worker *rescuer = wq->rescuer
		kfree(rescuer)  //first kfree
		

         if (!(wq->flags & WQ_UNBOUND))
		call_rcu(&wq->rcu, rcu_free_wq)
			
		rcu_free_wq
			kfree(wq->rescuer) //second kfree

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
