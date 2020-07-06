Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81894C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DBAE206CD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NOOB/lDx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbgGFPMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:12:32 -0400
Received: from mail-am6eur05on2084.outbound.protection.outlook.com ([40.107.22.84]:6160
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729368AbgGFPM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:12:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4fVzWYMOij+PbjU/yzyf22ddrTXT605U8yUQSe9KG7tt+37/Es96PHCAlHkB+N5jMTdCrJqwtRx8OqHsWBGlzhAJ4Z0DjvgUidfTUQkm/sH8quw8AhBA7/REdnAb2VWkWYdUXQjQzmwak15tedpmLHXGPJr+/VP+9KR4zBN2CVo+VH4KDZA6QNQFhpcfPM7uv44wRA4gFosN1oL8TI5AJs8t5I0vhaulUfx0u1Y6SbBbpe478xNmEvrCQ458BdSVODni6TbK3wNOElD+Z9MvDmib6jgHzEDIRtuMIPJ3f0PYcieXAdiogUGz48HyVYJlgqu9vm8L3y2Eyjugnid/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0j4C7KquqH7hVhVRtb9Qith75aRopwO/h76ym5yXtM=;
 b=RRAZfl9UV5/HGMgbw0LCzdGgRJPvLaWmbvV60HHAs91hB0JNma0HJBtNxyXFloWZHutXD/jwcMNogrmaNDlGMVZ3OTd7RZ4noHJp6n+YIoDKjcuSvRxaK8PweaCmi6chZxuNtywPiyaj6jbBcp9SzzWW/Y/3P93oZH0vUo2dQFMyAesv2pvRvFRSl+n4fZf71XLYUTExMVlFzCs6QV90PYuAjy3kdfMRtyXXdcPJEtC+kf+gh8+TprbMpBwAPFrQ6d3UGEQy/sa9mH4bJhQtcI8zcJcxt2F10l6I6YY5gu/xtMNbl4DAUX0ZL/lhArPRRhM48ZPTj60SqDxE1A2LIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0j4C7KquqH7hVhVRtb9Qith75aRopwO/h76ym5yXtM=;
 b=NOOB/lDxUuJvVLpKYHGq91qBkDry76bZJvGJS8ieWOmzngyr8PIHxAFjLluukNgQtDevTNszERKsUkVq7Z7IQKDlz6iIqfxsJw398QQnWEkT7URWsafGFBumEHqYkbYuE06TGUSbWwYmfi9kN5Ju8BCBVc/e850ZAOzjWFybudQ=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19) by VI1PR04MB6799.eurprd04.prod.outlook.com
 (2603:10a6:803:130::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Mon, 6 Jul
 2020 15:12:25 +0000
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::9d5c:685e:4b51:fa60]) by VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::9d5c:685e:4b51:fa60%3]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 15:12:25 +0000
Subject: Re: [PATCH] drivers: soc: Fix mailbox suspend/resume no irq for IMX
 SCU
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
References: <20200706150013.35326-1-vincenzo.frascino@arm.com>
From:   Daniel Baluta <daniel.baluta@nxp.com>
Message-ID: <519cf3c2-7b48-5318-3a58-f51202aac6d9@nxp.com>
Date:   Mon, 6 Jul 2020 18:12:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200706150013.35326-1-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR03CA0051.eurprd03.prod.outlook.com (2603:10a6:208::28)
 To VI1PR0401MB2287.eurprd04.prod.outlook.com (2603:10a6:800:2e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:2f08:5905:e800:50a7:a613:429b:9846] (2a02:2f08:5905:e800:50a7:a613:429b:9846) by AM0PR03CA0051.eurprd03.prod.outlook.com (2603:10a6:208::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend Transport; Mon, 6 Jul 2020 15:12:23 +0000
X-Originating-IP: [2a02:2f08:5905:e800:50a7:a613:429b:9846]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2b3da8ee-9234-4731-5fb2-08d821befd10
X-MS-TrafficTypeDiagnostic: VI1PR04MB6799:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB6799C85F814D1EAB9291FA1FF9690@VI1PR04MB6799.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h559i7y86vI0koXTGygkXZg84KbD9NzBb4uSGIiFRqT+UO0VCw3f2TnnNpiO3VusqHFrW0gMOOUpwNQcdDnO0nJzOA2j5xD7fm+EJqp96QTs4c6h/0FqHwYOm7EPhyIvVIGuTBACM2w+NR09nMX+rkyjltjr0Ne4Pse6g1q3bqqC7/NpqBxExbgXGOKgLLzs90dgVBLAOB6z7P0ykWciqxCPcogAJPdpKa7wXQd5JHNEzqublkBASW5KZvXWg1GqiMkGEmMEpQunofovy8g6zvM7BfMgAUs8UT0yXVjRPTj1OOTYx1EeGGVUQzZMEozC0sqe5aUlhjSU7e4VkMYNIq6Q0cotq9DYy3IAgvdS8g3y8jGerlMa8VeCoGRNyTYh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2287.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(5660300002)(83380400001)(2906002)(66476007)(66946007)(8936002)(66556008)(8676002)(15650500001)(4326008)(31696002)(186003)(16526019)(44832011)(53546011)(316002)(478600001)(52116002)(36756003)(6486002)(31686004)(54906003)(86362001)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: iQpIYC5z0l6sY0lFIGKNz7tBxwS9+p23TCBENCeUukT86tauE45/E2C8/8Hyyle7rd3sRMvwuOrgPJz03KQCBSPVX0yhd9wj64nOO0T2piALSXZgIbdLNTG3UiLvpzqwOZVlUw0HPlwAGuHcT5vRSuIRFGBKAXlOJtE7AOxEMuWUwJGo33qJaKfu60t0p0By7dGYwjTY2WishxBV2SrAsxEfPgGcNHKCdQsT3+/IZAcrh3Eq98wGVild+asxXlxIw4BHR9wg+iLdTUcovPMhB/VmCq0m9kc2nMnYLFnt1qG+BEYTDLpZfW29l2U1E6RVEeeuFGUGG2/Mos2lSAoZ7k82D0t+7r+lKTCFzVB28ZSbadgCG8NTw5d0WaqnKOk012BylQKgREo2EflYHCv6Odzt6PKtQJf6q8mJ6SCqbzYpFWRGwTOkVZyS4ZF78euQ0JAV2IVjGTgnfMfXF7asaRd043tlGigWc+3vmDLxEsF6oDpw6SPaji8n5y3JKSAB+fh9TT9sG0Y9CqhyuIXeqV9u0yGGDfjtEomANhK7dQ7BrgxL2PxMQh8mYTWl97Ur
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3da8ee-9234-4731-5fb2-08d821befd10
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 15:12:24.9445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5iR0qD4j010EriGilp+9tnWaeAAQpZS8Z+IQNhCA8Fro9YVqljqaMRAtwWG10AE/HLyhhRM4YosOlbHS34JLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6799
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.07.2020 18:00, Vincenzo Frascino wrote:
> imx_mu_suspend_noirq()/imx_mu_resume_noirq() are currently used only
> when CONFIG_PM_SLEEP configuration options is enabled. Having it
> disabled triggers the following warning at compile time:
>
> drivers/mailbox/imx-mailbox.c:611:12: warning: ‘imx_mu_resume_noirq’
> defined but not used [-Wunused-function]
>    static int imx_mu_resume_noirq(struct device *dev)
>
> drivers/mailbox/imx-mailbox.c:601:12: warning: ‘imx_mu_suspend_noirq’
> defined but not used [-Wunused-function]
>    static int imx_mu_suspend_noirq(struct device *dev)
>
> Make imx_mu_suspend_noirq()/imx_mu_resume_noirq() __maybe_unused to
> address the issue.
>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>


