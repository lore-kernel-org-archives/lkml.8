Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EA4C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C59220767
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="maMIpUM5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgGJNrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:47:23 -0400
Received: from mail-eopbgr30099.outbound.protection.outlook.com ([40.107.3.99]:47325
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726896AbgGJNrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:47:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWt31MgvOojLJw1SmdI3T3qmKtCFCF/dh9/1ZoXM9Bo+XYMD2yRcScQw6SAzHSa8ZCnY+rjbQfnohR//wlFQvIQ3BiPA0aIlIsepqSQsPMfaPTP67AmP5szqMaV7MrRCh0qxE079opL5shcSWFGO1qSN3b++RGfno9mesDnK3/jv6Du5dmUpgcj1DE2e2XoTK2Otre8Uh3fu5CsMA/XlR6NaliTVr7tCFik9OJ+JVFuwi445UvCcYinjdO3Ay3YHJ12nfNiIdX1PUNHs8R5HuOEYpnJ+c86RNTYv7Z3Ug77doi4W/CQKV1sLqRCJAhqX3ETsuWCKExp61rSVncOtvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+d4LwhP5QGoKirMIFk26YcXQYavfLOPw9IlkScDylg=;
 b=Dx5ypg6YYJGi9T9bw0rYMC47Ln7lJQDV77URcxV+KcCw8pzJMKgo3Cri6d1TidDEBmTzNMZDU/yPt2C0cj03s2X+BSXVPks33OaDDVa4IKXUzXl3qRcaW75stffAOWeM4fRTM206W5VgzDbBa7vTyxLu8Jk+jt4OJV6HTOqFOD9v9x1NBPDcvbAjUhzIzbeDsSZ22FOEUh5VC5vuhCSfBwD5oq6kAF2U/UNye4+mbb+acwXaTdjTS5crRWwqABkfmlNAsgf5MrgoX6c+XtoQArf4X0asILILVXe5DZuqXKO6BVPFsMIK89PMhUb4JkTqXl5hnaSFYrNNBEho3/vFSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+d4LwhP5QGoKirMIFk26YcXQYavfLOPw9IlkScDylg=;
 b=maMIpUM5mWd+y95jvT5YPc/rJCTbqq1XdJJAUeYFG7kOGueGmP+TATZBBkXo+kBRAxfamo64z1povYsi0iIUpIvVI4Am3ZDrkQpNtlHdWXxYPGQnAGrlcYTsj1ydVpMOJk97JqJBSt/kpFs60oOs6EE2p3W84vEw/RPNog30TsU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=toradex.com;
Received: from AM0PR05MB6002.eurprd05.prod.outlook.com (2603:10a6:208:129::19)
 by AM4PR05MB3363.eurprd05.prod.outlook.com (2603:10a6:205:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 10 Jul
 2020 13:47:19 +0000
Received: from AM0PR05MB6002.eurprd05.prod.outlook.com
 ([fe80::343d:a818:80a7:3e6]) by AM0PR05MB6002.eurprd05.prod.outlook.com
 ([fe80::343d:a818:80a7:3e6%7]) with mapi id 15.20.3174.022; Fri, 10 Jul 2020
 13:47:18 +0000
X-Gm-Message-State: AOAM5328hUBw0cX9B+aDsq9EOwaOyQGy7szfIvDqGJ+HOaJUVgjhCCsF
        4NVV99uWoLUL6wdo3Szx+sOpU9lLi6iSrezA++A=
X-Google-Smtp-Source: ABdhPJy8w2hdy4zeLBvr7C2h5s4yVGQOvTjEHye1jjC9ZXFSKxzZShiR8q+O0RWbTQc581Q7mNvms9ideJEtYdYoOCE=
X-Received: by 2002:a0c:e847:: with SMTP id l7mr70366995qvo.232.1594388835437;
 Fri, 10 Jul 2020 06:47:15 -0700 (PDT)
References: <20200710132423.497230-1-philippe.schenker@toradex.com> <20200710132423.497230-3-philippe.schenker@toradex.com>
In-Reply-To: <20200710132423.497230-3-philippe.schenker@toradex.com>
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Date:   Fri, 10 Jul 2020 16:47:04 +0300
X-Gmail-Original-Message-ID: <CAGgjyvHAqbdrwHpP1gkV=FHhmE6y0bGxpsX=gHAhDja420f3TQ@mail.gmail.com>
Message-ID: <CAGgjyvHAqbdrwHpP1gkV=FHhmE6y0bGxpsX=gHAhDja420f3TQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: colibri-imx7: add usb dual-role switch capability
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: MN2PR22CA0025.namprd22.prod.outlook.com
 (2603:10b6:208:238::30) To AM0PR05MB6002.eurprd05.prod.outlook.com
 (2603:10a6:208:129::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mail-qv1-f47.google.com (209.85.219.47) by MN2PR22CA0025.namprd22.prod.outlook.com (2603:10b6:208:238::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend Transport; Fri, 10 Jul 2020 13:47:18 +0000
Received: by mail-qv1-f47.google.com with SMTP id h17so2577273qvr.0;        Fri, 10 Jul 2020 06:47:18 -0700 (PDT)
X-Gm-Message-State: AOAM5328hUBw0cX9B+aDsq9EOwaOyQGy7szfIvDqGJ+HOaJUVgjhCCsF
        4NVV99uWoLUL6wdo3Szx+sOpU9lLi6iSrezA++A=
X-Google-Smtp-Source: ABdhPJy8w2hdy4zeLBvr7C2h5s4yVGQOvTjEHye1jjC9ZXFSKxzZShiR8q+O0RWbTQc581Q7mNvms9ideJEtYdYoOCE=
X-Received: by 2002:a0c:e847:: with SMTP id l7mr70366995qvo.232.1594388835437;
 Fri, 10 Jul 2020 06:47:15 -0700 (PDT)
X-Gmail-Original-Message-ID: <CAGgjyvHAqbdrwHpP1gkV=FHhmE6y0bGxpsX=gHAhDja420f3TQ@mail.gmail.com>
X-Originating-IP: [209.85.219.47]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0a5e047-6fd2-4e78-1f83-08d824d7c35d
X-MS-TrafficTypeDiagnostic: AM4PR05MB3363:
X-Microsoft-Antispam-PRVS: <AM4PR05MB3363D121D3A9AB3BC14BD40CF9650@AM4PR05MB3363.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pqJV01S91X/sjd3Yki4lS5agCCZGHtLr0CCaI2/aIMFsN4uJi/PCD0wEVXPaqi4/tramO2b3mnxo6rhr0d99/THIccAHKFWP1MPoZxZowEiAgepUgagqkhMngmO9b8W+/yRc3eham0IW0/tGYlgLnGncDl2qoWoYxCSZL8pqTFTXiBExHewm1faOtbDdLLPe71RBCh6H7LvBzaG9cgaLpLPRPXGFmFXpkQXKZaueGTE7uPpYF1h5YShi1zgPlH0fST6t1dEQFvuzEfaO/xAgN4I1yjIoFEb0IkEcC1znS+1LxYwRtMYacrR9iOk8/PeTpKogCqsvNeZF6K9V/gqqhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB6002.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39850400004)(346002)(366004)(136003)(376002)(450100002)(8936002)(8676002)(5660300002)(4326008)(9686003)(83380400001)(6862004)(6666004)(6636002)(66556008)(66476007)(66946007)(86362001)(44832011)(53546011)(2906002)(478600001)(55446002)(26005)(52116002)(42186006)(55236004)(54906003)(186003)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: v+sp/78ZmRJgBVis/1JNmuEco+5rGFhAPMJtcdNZOLuQ0ijVyAKmw8eArLS21AAFjDvBl1DhJiQ9R5in7KugIje6bljHjpVQN+Gc5hT+AgIdlXgrKZuULDvzqzb76cfwQA8kVxHu3cHYqtskKUge1y4MtLHiwABv+mB/yo5Qtj6nX2yOe9vwc981xhZPI83tIMxCJbo/xx4jQf0F+lZrC19V3RJuShuRAWBC6vZIK2YMvOwPlBkVmBaUXDQ0sKtrj7MlCelTX32IETY3g69K0/M5EAXV1iZDvsUkzru+qteQOINjUroUBGhWx3dJ5g1ZUlMILIQsnuOhnynLQKvmNFCmgXMraDiQa/cNVIcbjg3vRj/02p116BMyN6GZm6zZeRZyFMY0L92U5NbdIR+CCPgnxHOL67qOIaSJCgr4iBuetdw63Vz5Onlx7bgS+5T2JsNLVtXldoITCenagM+K/6oQj+cz2U3bPAIDskIip+k=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a5e047-6fd2-4e78-1f83-08d824d7c35d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB6002.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 13:47:18.9002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4cR4A/iQlheHb8Ne0URXSTiXQqJ/oXhG8UIOa/0Qex/libtL9OoUuEURLxvR6zys4uV1vPPvp34PtQdVcbJUICNVK2jVyIFvhFU+O7L3pfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3363
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 4:26 PM Philippe Schenker
<philippe.schenker@toradex.com> wrote:
>
> Since the runtime-pm wakeup bug was fixed in
> drivers/usb/chipidea/core.c usb dual-role host/device switching is
> working. So make use of it.
>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

Reviewed-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

>
> ---
>
>  arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi | 9 +++++++++
>  arch/arm/boot/dts/imx7-colibri.dtsi         | 4 ++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
> index 97601375f264..db56a532a34a 100644
> --- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
> +++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
> @@ -20,6 +20,14 @@ clk16m: clk16m {
>                 clock-frequency = <16000000>;
>         };
>
> +       extcon_usbc_det: usbc_det {
> +               compatible = "linux,extcon-usb-gpio";
> +               id-gpio = <&gpio7 14 GPIO_ACTIVE_HIGH>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_usbc_det>;
> +       };
> +
> +
>         gpio-keys {
>                 compatible = "gpio-keys";
>                 pinctrl-names = "default";
> @@ -174,6 +182,7 @@ &uart3 {
>  };
>
>  &usbotg1 {
> +       extcon = <0>, <&extcon_usbc_det>;
>         status = "okay";
>  };
>
> diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
> index e18e89dec879..caea90d2421f 100644
> --- a/arch/arm/boot/dts/imx7-colibri.dtsi
> +++ b/arch/arm/boot/dts/imx7-colibri.dtsi
> @@ -457,7 +457,7 @@ &uart3 {
>  };
>
>  &usbotg1 {
> -       dr_mode = "host";
> +       dr_mode = "otg";
>  };
>
>  &usdhc1 {
> @@ -486,7 +486,7 @@ &usdhc3 {
>  &iomuxc {
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_gpio1 &pinctrl_gpio2 &pinctrl_gpio3 &pinctrl_gpio4
> -                    &pinctrl_gpio7 &pinctrl_usbc_det>;
> +                    &pinctrl_gpio7>;
>
>         pinctrl_gpio1: gpio1-grp {
>                 fsl,pins = <
> --
> 2.27.0
>


-- 
Best regards

Oleksandr Suvorov
cryosay@gmail.com

-- 
Best regards
Oleksandr Suvorov

Toradex AG
Ebenaustrasse 10 | 6048 Horw | Switzerland | T: +41 41 500 48 00
