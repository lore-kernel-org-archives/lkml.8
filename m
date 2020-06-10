Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FBBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEDBE2078D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="akUzNeGf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgFJIn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 04:43:26 -0400
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:6080
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726424AbgFJInZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 04:43:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fj5zwNd8bzhOePPWJ63i2rWEMaQgE9gq8Vi8JCyGO8Ha50gpwfDy9/6JCdxMVrtyAQV4zlE+oYr+451r1wa2QyK6ac4Lqs7QPblSCFZwRf71CSaAhQRzdxky+z0qE+NW9lVWoFoo23cGal8I6g9yzWhcWVBtWXA8I9qksNniPb+huijMQyVbJrfgO6BZtEO16OZsDHdCJghXHBy5H/VY2s1qTMv8zu4y90WtlJBeLIVoDmE1xo3O8CFRPFz3bjOCY6uhTCsF8dpFuIlq9fIrnJE5yJoTyQFwXnkOtYDf8VFospV3GbxwEE2yJ2gsSVdLiOGjcpAroI2KllNDcJnBhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGRV2Hzk57GxMcCyW8+C449RRZKbfl8hoLiQa3GHiSE=;
 b=N3bxD2UFCjcZxQktBRVzU82ILPVd/qLQBY77h/XGQC8J2yibgGTwcB1tdtYr8yXMj10/K+11P3gbzpb8MUymU+uGADmJRcKIFWADvyQgMji5IWccIBLcQO2i37Ee041Pg7SsqrL8hCn0bX8Gj38Uir75AdiYzQaRip0Ks01zI/PQae0L0t4HDyO1h2H191+xRH+pbABMJWv++2VP5MrXur6SlCWZ+oBB+q6LLB2AvMYs+kK4sVLqTBZ41WCu3Jz+gFjlhoZ1PePc8k6lJX7SBRyA5oOKg0aKG0+dB2ZgCKeekHufu6cWr1ljuNpNrREtkM4HxD7IidqSv2IqDzdA3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGRV2Hzk57GxMcCyW8+C449RRZKbfl8hoLiQa3GHiSE=;
 b=akUzNeGf2DrrZos2s9pglMj9bqOz3K7cZl1qESYyJykbv7aLLXGFKvZ5c9/pJnmzZ6JwFS1fsTka7rvLISQdRBk7X/4veFeEpElSwe6VD4Qcpb2otV3yS6iUr0oonET13qgrYoZopJnXWtJ6aTKOadjWIFFU6kEM9Ns9m5BObo0=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3712.eurprd04.prod.outlook.com
 (2603:10a6:803:1c::25) by VI1PR0402MB2862.eurprd04.prod.outlook.com
 (2603:10a6:800:b6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Wed, 10 Jun
 2020 08:43:20 +0000
Received: from VI1PR0402MB3712.eurprd04.prod.outlook.com
 ([fe80::c8c0:bf87:1424:88ae]) by VI1PR0402MB3712.eurprd04.prod.outlook.com
 ([fe80::c8c0:bf87:1424:88ae%6]) with mapi id 15.20.3088.019; Wed, 10 Jun 2020
 08:43:19 +0000
Subject: Re: [PATCH V2] soc: imx8m: Correct i.MX8MP UID fuse offset
To:     Anson Huang <anson.huang@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1591742515-7108-1-git-send-email-Anson.Huang@nxp.com>
 <DB7PR04MB4972E7B649B935B1EFE6469880830@DB7PR04MB4972.eurprd04.prod.outlook.com>
 <DB3PR0402MB3916F5F4C797595437D5FBE5F5830@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
Message-ID: <552e1ae9-8b28-a462-5ee8-3e5bd6821c90@nxp.com>
Date:   Wed, 10 Jun 2020 11:43:17 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <DB3PR0402MB3916F5F4C797595437D5FBE5F5830@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0501CA0025.eurprd05.prod.outlook.com
 (2603:10a6:800:60::11) To VI1PR0402MB3712.eurprd04.prod.outlook.com
 (2603:10a6:803:1c::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.6] (86.121.160.118) by VI1PR0501CA0025.eurprd05.prod.outlook.com (2603:10a6:800:60::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19 via Frontend Transport; Wed, 10 Jun 2020 08:43:19 +0000
X-Originating-IP: [86.121.160.118]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d504dcb5-3008-45f7-6af6-08d80d1a53ae
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2862:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB28628C4F07AD738BBC1706198C830@VI1PR0402MB2862.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 521VJWBoV72fcCWAL2Y4cYP6Zp/vaoAh/dvtkMkuTyJ9S2MXKAZVlPQAK5iUmAQuf6S5FBrWk0TyfWJkl9uu4FeK+YGNnS6IdMTMAAgOBnrRP3wFpqg7I6JFIv86N1w/9icb+jYZzWBU4/86D/69QELvl2R1l8DP2ztdkQV++xmgHhWtaMAaR7wcaiIBIMkRuNaMYzvo5aW6m/Wrdhivmte2P7fr4P6jM6vO8MKVUz44+CLYrYVaKyrSQySksrUgzETNSj64AVUbUCiOsndqzd60qBAHd8aIUS5FnCihKeuY6bLuJXD2DLAkk0l0ZrfrHv0nfoBND4eWfr04BNrb5Z2S/QyUqsouYmeWURgAoybCwi0RLnVt6VkcEseJRssw9KG+zebzfO7XXc5c5FpKc+QCrcChfEpUd5H+k7gJ6UM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3712.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(4326008)(52116002)(16576012)(2906002)(86362001)(478600001)(31696002)(110136005)(316002)(66946007)(66556008)(66476007)(53546011)(6486002)(31686004)(8676002)(956004)(2616005)(16526019)(44832011)(26005)(36756003)(186003)(5660300002)(4744005)(8936002)(921003)(32563001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: SHtmdFMVGn4K6F9RTGoto8lrYHdfIjmf7gVpSWCm1eMjT3cpJXyC+IHmnZ1cF8BRzTJG32eZKiZzEu0NT2qH0E+LN6fupFSZyUei+9G7/Jh1Vk4mPnGHTlYQuiGOKJR7PXFP44tVNnpULq0+7i9Ocl20gbZBaZciek2+xrGKvLg0FIDFf5jqBqqBvkxXhTK2hfNihfbf6Ha7xv6AZfFUKoDSub8WbyV872ZuQSg8nT5LwjSzH5lLvdcsmeCoyvSyCGLg7Apkb4WH5RQbemCBAbLc2j5OsHiy7hx60vitwnFHr8N8+XoyvN7AqMy7rOQeWQsHZFKBxo9uhHSw20uGZ2hEumSJoxYsGPROlpWzI9d3eJn51Nf9IUqHE4GLUJBTQO93TJVQyDvCSzX8ZXIUsQlvxNo2+4OSe/rwfHG5Z8nt0YXtdboOBV9kHOY7XLQGH3M/4Nze3qymaUut1XjwQZPeKm6AHAAnnZ9QKu0blZoySSZ2AxXg8jtkjC/EEw8f
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d504dcb5-3008-45f7-6af6-08d80d1a53ae
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 08:43:19.8874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xg2Tro1BNDcao1DXmJn5UTL/H6jBPYgpRV/1/3LVW+HZNjUJ0et1zWQ/5k6PilOpzS+yek4On+09ZWYdZ1Q+bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2862
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/10/2020 10:57 AM, Anson Huang wrote:
> 
>> Subject: RE: [PATCH V2] soc: imx8m: Correct i.MX8MP UID fuse offset
>>
>>> From: Anson Huang <Anson.Huang@nxp.com>
>>> Sent: Wednesday, June 10, 2020 6:42 AM
>>>
>>> Correct i.MX8MP UID fuse offset according to fuse map:
>>>
>>> UID_LOW: 0x420
>>> UID_HIGH: 0x430
>>>
>>> Fixes: fc40200ebf82 ("soc: imx: increase build coverage for imx8m soc
>>> driver")
>>
>> AFAIK "Fixes:" should point to the original patch which introduced the issue.
>> Not the one changing file name.
> 
> But the patch can NOT be applied to the kernel version with original file, how to
> fix it?
> 
I believe you can add two "Fixes:" with the two commits: the one 
introducing the issue and the one changing the file name.

Iulia
