Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E9BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C850320679
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=topicbv.onmicrosoft.com header.i=@topicbv.onmicrosoft.com header.b="a77W+8o5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgFCLep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 07:34:45 -0400
Received: from mail-eopbgr20062.outbound.protection.outlook.com ([40.107.2.62]:52582
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725855AbgFCLeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 07:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryPX3MFfe9iSndf/udF6YzbSmay8VgeL3G2M+KLYxdU=;
 b=a77W+8o5r4nnF4QfeTWEU/WdO8Rn33ZvRBlmcMwmAIgtY6Cvap3Sx+M+Zc0D8ALDk3NT2slLzRIMT1soH9EiJYE+8I4WrDPYWzi6yMjWGGW/v1ZhuTy6rJM/gHUbKXJOoiteXFDMkKRoAJsKs3qL2frB1oFZXQFmf+IkVxzRUTw=
Received: from AM6P192CA0061.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:82::38)
 by AM6PR04MB4309.eurprd04.prod.outlook.com (2603:10a6:209:50::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Wed, 3 Jun
 2020 11:34:37 +0000
Received: from HE1EUR01FT013.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:209:82:cafe::2c) by AM6P192CA0061.outlook.office365.com
 (2603:10a6:209:82::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Wed, 3 Jun 2020 11:34:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.68.112.65)
 smtp.mailfrom=topicproducts.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 40.68.112.65 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.68.112.65; helo=westeu12-emailsignatures-cloud.codetwo.com;
Received: from westeu12-emailsignatures-cloud.codetwo.com (40.68.112.65) by
 HE1EUR01FT013.mail.protection.outlook.com (10.152.0.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.17 via Frontend Transport; Wed, 3 Jun 2020 11:34:36 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (104.47.6.52) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 03 Jun 2020 11:34:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYr7eDBWcEQDrhi8DEeBlbgHbnTMCq0F9jhEagAk3n3nI9gNK8UsDaHHng3thNoXmKR0VK43dFhP6k+TiUDZtUZOMR1hDy7wjqKsVZs7EWrEsu7q35pi2dxDhhjUrBaMyi/uH2GD1/ZYDGHNSmNoNqJOSD+Fm/wHzvHant9UHfv/JFFN5WeqLDwMr4M3uNOL+7vNx1Jo9j6vnr1aD9UZZjv84R8+ep8QxhSYjzZNQ+uC35amMKFM8bxJmvZ8px1uhR5xgTTLeM4ZVHQp5iyi5H4vM7UgpGDWxcIvVuVH1h6gVYBVbkb1Wd0XDTSKJWPWHxrbyVltMOnpjqJkAFni2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBg2pAhsqTEwrpg3SFI66C5g+6xaXOImnz9I/uxWnk4=;
 b=RFQimBdhVFxVfLp69IjHiTrxFG0fB62zZksoMlGxFTsozb9s5yFv+o+gRpFg4CDB9LunKFcxuZRAZYE0W8SJ2ELWDKBBe3YKcZsln+6CDCDutxWt8T6nTGchTrJiy6maBtASoFAsr0MMc0OSPQQC+BcniB3LhXWbMTFjKc1U5+D6PD96nFDM1VFXmjkb+n5hKAcT1khkaQ8JUOfgvdhZxeI0Z2LnujzVlRwpYPOQe8kfmId/b7GFydbMhOHzJ+WwgrSnlQKSfe8RwvTfVvPusPUnfhxFYbmVsZb4oSpgd4I31qNGQMKCL2WsxhMDjTQ02UdgjmMUGWJZzWp0U2OcTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by DB8PR04MB6715.eurprd04.prod.outlook.com (2603:10a6:10:10d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21; Wed, 3 Jun
 2020 11:34:31 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::6cf6:7323:7395:eec9]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::6cf6:7323:7395:eec9%7]) with mapi id 15.20.3045.024; Wed, 3 Jun 2020
 11:34:31 +0000
Subject: Re: [PATCH] usb: dwc3: Add support for VBUS power control
To:     linux-usb@vger.kernel.org
CC:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org, balbi@kernel.org
References: <20200603085932.31746-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.4820e9d3-dc82-459a-873d-80ec5efbefff@emailsignatures365.codetwo.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.0d2bd5fa-15cc-4b27-b94e-83614f9e5b38.7aa77c8d-2984-4b57-ac0e-a1a6c3a49faf@emailsignatures365.codetwo.com>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: Topic
Message-ID: <aabce60f-caca-9381-84ce-4c2fdbe1b307@topic.nl>
Date:   Wed, 3 Jun 2020 13:34:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200603085932.31746-1-mike.looijmans@topic.nl>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: AM4PR07CA0009.eurprd07.prod.outlook.com
 (2603:10a6:205:1::22) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.130] (83.128.90.119) by AM4PR07CA0009.eurprd07.prod.outlook.com (2603:10a6:205:1::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.8 via Frontend Transport; Wed, 3 Jun 2020 11:34:31 +0000
X-Originating-IP: [83.128.90.119]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80ff1ee3-b424-4f21-344e-08d807b2186a
X-MS-TrafficTypeDiagnostic: DB8PR04MB6715:|AM6PR04MB4309:
X-Microsoft-Antispam-PRVS: <AM6PR04MB430952E8B9BFEDCA85C486E296880@AM6PR04MB4309.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;OLM:6430;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: l50ZJC64rzJgewFlz+R06E5tBTPJfIuzFxhw5C2/kw/SbCJal7O/lwWlqkX9UguJNEalkAkRtvr56nF/BnJesR8iDNtAmNbO95UzaZr98gJiA1n1x4cKYt1rfSkHUeYAT4BFBy+Uth7AmOmL3oSIaoxUOZ3+5gXXWSNWWnjRc4qQrSJYi6gJz8Ik4Mp/4e6yaFa/u1MHujIsF8k/BT2KmEhJ1BOsjMtx3UJIQGWOZXslqS2u7yIeydPQAaqD38mQZdEUGGppkMbhQRvsxB9kPmn7r4scN8W1PMSNl2p36p05NEic1U5RVPzUw0W1OlgM+3IOq22lksZMiWa9vFn4M92e7IftxLdpVd4fh7TQgIl6zwI2nTlv4xwCbWPEsn1J
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(346002)(396003)(39840400004)(366004)(31696002)(66476007)(83170400001)(6916009)(8936002)(5660300002)(508600001)(52116002)(36756003)(36916002)(42882007)(6486002)(83380400001)(66556008)(956004)(44832011)(2616005)(66946007)(53546011)(2906002)(186003)(316002)(8676002)(16526019)(31686004)(4326008)(26005)(16576012)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: HwUMTz2VeqjD90x8VfRpjNllEzE42RuXLp7M2a6OygdlvoqzGqkibiTilyNVnLJPc0Fj5jqbWFXyB2UCCgnTJoqhyT20//mSgp834d0j9nGM4JP8wbss58hbRiPKzm6luYLNSEuZlJRcX/M/gLdqRtlo3PmKIx8wNZtHoDk/q/Fj7bFwk9hQg/a++ZR9cjEcayE04UKnqU2e2AXN4tejb0dAGFZfnnb9/32KRYDCz+uJ2Vy3G17kw6UUN1D7Y2qsCveDo4tGeIo8Tc0mQhUDY44JxP0dPSs+hJ/GvBxbd3BIROsgsmB0xmFnUMK03h5+UzsuGAR/BCtyDrjA5n1x4LsyacGCG6NO+7wOmLJZE+e/mLMbxzpKjEK9rTqUb/PJLTQn7+HO41274crI0YQH6UgK+JhBQ53WUPJKUmkkFFYsjkeGc4pOuaH6cVRbOA121v8XtdBrxSO1mSKoWK7PJoPSYBSb9T9SH1q/AnqpQu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6715
X-CodeTwo-MessageID: 6b9a321e-43fa-4cdd-9690-d7658a667e7e.20200603113434@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT013.eop-EUR01.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:40.68.112.65;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFTY:;SFS:(136003)(346002)(376002)(39840400004)(396003)(46966005)(956004)(2616005)(7596003)(44832011)(7636003)(70206006)(31686004)(16526019)(70586007)(83380400001)(356005)(6486002)(186003)(26005)(83170400001)(36756003)(36916002)(31696002)(53546011)(82310400002)(8676002)(15974865002)(4326008)(47076004)(336012)(16576012)(508600001)(42882007)(6916009)(2906002)(5660300002)(316002)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1eafad6a-5d04-4262-25d3-08d807b2152c
X-Forefront-PRVS: 04238CD941
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v01bZtsMQSy6noWBXbNgtWObOxPiv+CJejUw5fIAGJsxD9ENdD1r4TqAD9DVFvfTjb6aSk7eyewa7BtnJBBkNb9zPl4BcCmh5+MP98/FvMg95w7jVlKcJP5GllwG0HYDFGzdf/gFGw9CvpJHyslCYmBsMkveX65CiXOjwSyO70+lIMDBEManu6XjqJTc/TYPsIWbhj4UaA1qYKgdBpuD6glnh4IJFGanCb7dZGLiuvCFKV3JqcN2eMRpRdnJYoO323xLJ/iJreaVCbLjpJLWQpyzOjm/u/KlTgYt3rFx01IhWyjR+uuJ+FbnRjbpEBZEkCgG5lOjEcgZFAL5iz4Kedwbv8iUylRsVsa2+WCszYF+kk1nlC74VYwMchM37Hq8wtfCFXAo4pog515y1tLAnbM6c3Rfja3Mug88ZuTcUTF9jDQUSN6azKizZPZDvJcCKlQNe6BblSraws+Tnmjg+vAJBTDCN+2GWy3+ZHoB/liCjtZc/ySduW+MJQohWbWK
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 11:34:36.5631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ff1ee3-b424-4f21-344e-08d807b2186a
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.68.112.65];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4309
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh darn, the "devm_get_regulator..." call in probe got lost in the=20
rebase+merge. I'll add that in v2.



Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topicproducts.com=0A=
W: www.topicproducts.com=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
On 03-06-2020 10:59, Mike Looijmans wrote:
> Support VBUS power control using regulator framework. Enables the regulat=
or
> while the port is in host mode.
>
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
>   .../devicetree/bindings/usb/dwc3.txt          |  1 +
>   drivers/usb/dwc3/core.c                       | 30 ++++++++++++++-----
>   drivers/usb/dwc3/core.h                       |  4 +++
>   drivers/usb/dwc3/drd.c                        |  6 ++--
>   4 files changed, 29 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentati=
on/devicetree/bindings/usb/dwc3.txt
> index 9946ff9ba735..56bc3f238e2d 100644
> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
> @@ -37,6 +37,7 @@ Optional properties:
>    - phys: from the *Generic PHY* bindings
>    - phy-names: from the *Generic PHY* bindings; supported names are "usb=
2-phy"
>   	or "usb3-phy".
> + - vbus-supply: Regulator handle that provides the VBUS power.
>    - resets: set of phandle and reset specifier pairs
>    - snps,usb2-lpm-disable: indicate if we don't want to enable USB2 HW L=
PM
>    - snps,usb3_lpm_capable: determines if platform is USB3 LPM capable
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index edc17155cb2b..a9e58a301446 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -25,6 +25,7 @@
>   #include <linux/of.h>
>   #include <linux/acpi.h>
>   #include <linux/pinctrl/consumer.h>
> +#include <linux/regulator/consumer.h>
>   #include <linux/reset.h>
>  =20
>   #include <linux/usb/ch9.h>
> @@ -112,6 +113,23 @@ void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
>   	dwc->current_dr_role =3D mode;
>   }
>  =20
> +void dwc3_set_vbus(struct dwc3 *dwc, bool enable)
> +{
> +	int ret;
> +
> +	if (enable !=3D dwc->vbus_reg_enabled) {
> +		if (enable)
> +			ret =3D regulator_enable(dwc->vbus_reg);
> +		else
> +			ret =3D regulator_disable(dwc->vbus_reg);
> +		if (!ret)
> +			dwc->vbus_reg_enabled =3D enable;
> +	}
> +
> +	if (dwc->usb2_phy)
> +		otg_set_vbus(dwc->usb2_phy->otg, enable);
> +}
> +
>   static void __dwc3_set_mode(struct work_struct *work)
>   {
>   	struct dwc3 *dwc =3D work_to_dwc(work);
> @@ -164,8 +182,7 @@ static void __dwc3_set_mode(struct work_struct *work)
>   		if (ret) {
>   			dev_err(dwc->dev, "failed to initialize host\n");
>   		} else {
> -			if (dwc->usb2_phy)
> -				otg_set_vbus(dwc->usb2_phy->otg, true);
> +			dwc3_set_vbus(dwc, true);
>   			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
>   			phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
>   		}
> @@ -173,8 +190,7 @@ static void __dwc3_set_mode(struct work_struct *work)
>   	case DWC3_GCTL_PRTCAP_DEVICE:
>   		dwc3_event_buffers_setup(dwc);
>  =20
> -		if (dwc->usb2_phy)
> -			otg_set_vbus(dwc->usb2_phy->otg, false);
> +		dwc3_set_vbus(dwc, false);
>   		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
>   		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
>  =20
> @@ -1183,8 +1199,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>   	case USB_DR_MODE_PERIPHERAL:
>   		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
>  =20
> -		if (dwc->usb2_phy)
> -			otg_set_vbus(dwc->usb2_phy->otg, false);
> +		dwc3_set_vbus(dwc, false);
>   		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
>   		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_DEVICE);
>  =20
> @@ -1198,8 +1213,7 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>   	case USB_DR_MODE_HOST:
>   		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
>  =20
> -		if (dwc->usb2_phy)
> -			otg_set_vbus(dwc->usb2_phy->otg, true);
> +		dwc3_set_vbus(dwc, true);
>   		phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
>   		phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
>  =20
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 4c171a8e215f..cee2574d7bf4 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -1085,6 +1085,9 @@ struct dwc3 {
>  =20
>   	bool			phys_ready;
>  =20
> +	struct regulator	*vbus_reg;
> +	bool			vbus_reg_enabled;
> +
>   	struct ulpi		*ulpi;
>   	bool			ulpi_ready;
>  =20
> @@ -1397,6 +1400,7 @@ struct dwc3_gadget_ep_cmd_params {
>  =20
>   /* prototypes */
>   void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode);
> +void dwc3_set_vbus(struct dwc3 *dwc, bool enable);
>   void dwc3_set_mode(struct dwc3 *dwc, u32 mode);
>   u32 dwc3_core_fifo_space(struct dwc3_ep *dep, u8 type);
>  =20
> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
> index 7db1ffc92bbd..45fdec2d128d 100644
> --- a/drivers/usb/dwc3/drd.c
> +++ b/drivers/usb/dwc3/drd.c
> @@ -384,8 +384,7 @@ void dwc3_otg_update(struct dwc3 *dwc, bool ignore_id=
status)
>   		if (ret) {
>   			dev_err(dwc->dev, "failed to initialize host\n");
>   		} else {
> -			if (dwc->usb2_phy)
> -				otg_set_vbus(dwc->usb2_phy->otg, true);
> +			dwc3_set_vbus(dwc, true);
>   			if (dwc->usb2_generic_phy)
>   				phy_set_mode(dwc->usb2_generic_phy,
>   					     PHY_MODE_USB_HOST);
> @@ -398,8 +397,7 @@ void dwc3_otg_update(struct dwc3 *dwc, bool ignore_id=
status)
>   		dwc3_event_buffers_setup(dwc);
>   		spin_unlock_irqrestore(&dwc->lock, flags);
>  =20
> -		if (dwc->usb2_phy)
> -			otg_set_vbus(dwc->usb2_phy->otg, false);
> +		dwc3_set_vbus(dwc, false);
>   		if (dwc->usb2_generic_phy)
>   			phy_set_mode(dwc->usb2_generic_phy,
>   				     PHY_MODE_USB_DEVICE);


--=20
Mike Looijmans

