Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBBDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC607206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YHxWXX3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgFJKae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 06:30:34 -0400
Received: from mail-db8eur05on2044.outbound.protection.outlook.com ([40.107.20.44]:6026
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728171AbgFJKab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:30:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyAPLZ7Z0FzViMMZgoIq0E/WuezJayZfLKz+jyhj4iw5lS+7SnRQE16kOQaOXQDDlz/c+3ADuF9tvqp2OTSCTCt+Sf7pn8X4a3bkzvGRuTdjTCFknttaHDm8I/PuLZCOMibx9CeuuPMlgTLN1jkKQIxCSEvCTLI7P5IsPq+rjG4rpLG2VJtasCu+YPH9i2/x1b3X0XhUbHrTqDfGFUglhHfuAgkNc0IDL5HM8BPwAObzS7rv7lsXvFUADa8tDkYxDABzMiV8IzObxTAvW+ld+ge9ESX3QEQIEOzIwD0fBxU1Eqw+Nw5mXU/Y7py/wGJM4oQKozELxhCxVX4cxyy1OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APj3supTl3oPTDQDxHCy/0PuA2cCQKB4DGNstMFAVkk=;
 b=K9QXhQOapqYzNRpPf36/j2tyzaYRKB/eWLLAaVvzhofV4FnhSKG4eZGWsq1fArQpm5povkBORCK4Cjst7fTJYMUDD29aJ2e214eMktb87UiwW4AaCL0eKn4Lz96JtxKQbWLKOrRykQX9a9xob9PPbPyZ9MZ1BZFOtz01KODQkOUIwpa3DPRq3H0+NX+BqIbB0Adki+Kaq+hXMElsGLP+G5nks06ztfIitxzxq98fXRjYRXvUOlxh2ktxEmhuGBMMgyCdWhO96D/70k+yys58W+WKIpCOKs9YBcORZQ7mqmTtPJIHMDMRiSbtHwpCPOwuwjxZ8g1lUYQwpCovntUWlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APj3supTl3oPTDQDxHCy/0PuA2cCQKB4DGNstMFAVkk=;
 b=YHxWXX3mTdHOljIQg92SVBB2p7wERVHym4GoqkF53PeZpJj3diUzErCPX60X2U/H0HiOaKMl2vV2S+DFEijGkFOKxS9H3x3M8hrM2f5I775Ct57tQY7jWKbZ+Lr0l12ni6KV/EtW/kIQSfWJsrs/PYVFgQDnSqTWDmS3d5xUOYg=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3712.eurprd04.prod.outlook.com
 (2603:10a6:803:1c::25) by VI1PR0402MB2912.eurprd04.prod.outlook.com
 (2603:10a6:800:b7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.22; Wed, 10 Jun
 2020 10:30:27 +0000
Received: from VI1PR0402MB3712.eurprd04.prod.outlook.com
 ([fe80::c8c0:bf87:1424:88ae]) by VI1PR0402MB3712.eurprd04.prod.outlook.com
 ([fe80::c8c0:bf87:1424:88ae%6]) with mapi id 15.20.3088.019; Wed, 10 Jun 2020
 10:30:27 +0000
Subject: Re: [PATCH V3] soc: imx8m: Correct i.MX8MP UID fuse offset
To:     Anson Huang <Anson.Huang@nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        leonard.crestez@nxp.com, abel.vesa@nxp.com, l.stach@pengutronix.de,
        peng.fan@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
References: <1591783382-27033-1-git-send-email-Anson.Huang@nxp.com>
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
Message-ID: <d4f3713f-15d5-e5fa-c266-f7e4592b18c4@nxp.com>
Date:   Wed, 10 Jun 2020 13:30:23 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <1591783382-27033-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0140.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::45) To VI1PR0402MB3712.eurprd04.prod.outlook.com
 (2603:10a6:803:1c::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.6] (86.121.160.118) by AM0PR01CA0140.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19 via Frontend Transport; Wed, 10 Jun 2020 10:30:25 +0000
X-Originating-IP: [86.121.160.118]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e1b84946-a6e6-4aa7-6e00-08d80d294a9c
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2912:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB29120C7D5C598418E2F63B718C830@VI1PR0402MB2912.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KpNR3chtA4GQco4Jnao7yFVqNxfumntowyxy2+Rhb9n+i2Z33MGJ+ADDfBCFeU/VcQFaMgUT+YuE1yHOkRy0GVr+QW9AAhUbrxeVjS6eSDhhJXzHt5o8YnI+pzwBzrfjBWgFH+TNYmg8ckypo5t+OZ3V1XxkLm6zk+qGHL5zd8Vbp6CrWS2nWXVdnuBOI0BrgqSXr1sb8ZWDk4JQyaS6R1onQf7r4ae6LWk0KCaOYrWErJMV4qR5O2WqYIW5X5puBBanr6KYo82UigzIkXLHPcjldweeN6/h7Udsf41OqZ78r7E/JeLD2nE0l4foaT3YyYKDLwcyTp2WToGF32omY3FUbkW01szCdzGLeN9wtGd54WTy94XTW/cwM6gA6/ZOv1VcxuBkPcbb6mfDVCFMIeCYG2iWw6T6lm97aTXHoTw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3712.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(4326008)(186003)(44832011)(83380400001)(316002)(956004)(6486002)(8676002)(478600001)(36756003)(8936002)(16576012)(16526019)(26005)(2616005)(5660300002)(31696002)(53546011)(66556008)(66476007)(52116002)(86362001)(2906002)(66946007)(31686004)(32563001)(921003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: jbu2/b8AAKTdXMKWvvSpxHeim6mIOa8OXzlQetimJDNk9+l4PdRidNyrHVZFxaLpGCpzcjMLCTOzZXVDyDa0ULPeNyA2UDECQa79ynnYk0ESIJvjljAw+TKImk2ggLaF6A5A1L1Gkk8y3j3+x09XrkP9fe7rmmFcEJTTTD6/hJyuzfrfhEDhRiqbA2Nk2TmaxPzpcz3DSOYAM49ELIWfwNekvqiU3+WYm7/c8rWMZm8t2OIWvlk4cLna2f/h2Uv/l+b720VCsdM3f+B+XS8BtA1y1/Y1A6qw7pY9L43pRj8wzWuUl5W4IP+R7YL5OLWGkciLENGzZeSjGIQ3PaGzfS5u2okUlSmmgvozAk7Git0nEDHy3onjTwtkiItBY6qsuuYqBrggtUF8gnL68I0XGC4rki9xuVzVSN+pE/DLlWyCzseoHY3VznoUS7G/OnPo28m8Bn19hAC0WtVJijnrA76sybJlWO2n+3NCzVBZHNIEIeBV6nqDl21Dnv91akHT
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b84946-a6e6-4aa7-6e00-08d80d294a9c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 10:30:27.0880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X0/4kykZlNhB4rTSPJpkADN3JMi47OCUasD0E0AbfxMzrqnRAYpyCz/eYqLefZFPOKtkXeduxGxNTJfEbXVZ/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2912
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/10/2020 1:03 PM, Anson Huang wrote:
> Correct i.MX8MP UID fuse offset according to fuse map:
> 
> UID_LOW: 0x420
> UID_HIGH: 0x430
> 
> Fixes: fc40200ebf82 ("soc: imx: increase build coverage for imx8m soc driver")
> Fixes: 18f662a73862 ("soc: imx: Add i.MX8MP SoC driver support")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>

> ---
> Changes since V2:
> 	- add one more fix tag for original patch before file name is changed.
> ---
>   drivers/soc/imx/soc-imx8m.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
> index 7b0759a..0bc8314 100644
> --- a/drivers/soc/imx/soc-imx8m.c
> +++ b/drivers/soc/imx/soc-imx8m.c
> @@ -22,6 +22,8 @@
>   #define OCOTP_UID_LOW			0x410
>   #define OCOTP_UID_HIGH			0x420
>   
> +#define IMX8MP_OCOTP_UID_OFFSET		0x10
> +
>   /* Same as ANADIG_DIGPROG_IMX7D */
>   #define ANADIG_DIGPROG_IMX8MM	0x800
>   
> @@ -87,6 +89,8 @@ static void __init imx8mm_soc_uid(void)
>   {
>   	void __iomem *ocotp_base;
>   	struct device_node *np;
> +	u32 offset = of_machine_is_compatible("fsl,imx8mp") ?
> +		     IMX8MP_OCOTP_UID_OFFSET : 0;
>   
>   	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mm-ocotp");
>   	if (!np)
> @@ -95,9 +99,9 @@ static void __init imx8mm_soc_uid(void)
>   	ocotp_base = of_iomap(np, 0);
>   	WARN_ON(!ocotp_base);
>   
> -	soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH);
> +	soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH + offset);
>   	soc_uid <<= 32;
> -	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
> +	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW + offset);
>   
>   	iounmap(ocotp_base);
>   	of_node_put(np);
> 
