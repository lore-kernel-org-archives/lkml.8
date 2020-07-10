Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B01C433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19893207D0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="Vl8XVPAr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgGJNpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:45:23 -0400
Received: from mail-eopbgr30125.outbound.protection.outlook.com ([40.107.3.125]:50564
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728256AbgGJNpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:45:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZI/ORH2CYU8q1lk95q/06d7ZBlIf3Sh2H9zwna+gCmCNjeEMzHNnw6WPXOuwHfuyhQ7OoNUOKmCRUBWHpj+tiNuQyGMdgPeKKR5vao4L0OFli+pmuI35Mo5XZnWAXVDHrEbrlNdf1LF7lr3Iqmtb7jbWN+7ZMt6NGYZjGlGwJlSq/gxD+kqgV+SMoTPwDaNQxVTwXvWOWY2s1l21O5nmDYHZhrlxQ7aoqXQ/ZL7xo4bKzDzAImETMBe8FLrxfiXyStz4KHQLNgrh1VsyQ/l3SAvDP9y0EU0fcr84UtZi3wt6BD2kn/tyC4XdAQ70NIwnX8KSAcnQjEzFHwac6MQk4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qpd2uUPaqSozCmyeKhLS97Zygta7MdhckfKU9sl//Cw=;
 b=goaczf3lur0KkDlpLiE3e6qYY0qwRPkDWOT8OHTZFJ6mMsQ27ILuAggUvEiQSzdZ5FPr2PBaZf20ettUFubsqLbgVNvno6N2ZOMn9hnvFUNvlCvPnp9EoyPLVkmx6tdyL2xx5iLk/fJpFVv7y+lQ7uKJO5GZCxNOrssXrdv7RX1+MEiPusqBeNddyitq8ZzryePnjw6h2k4HpDMOFvEgGVDdTHr4wc2j76g6157Lg96SXaRuflfjU53RtzhAj/6qIhCuBgqf3NV4N9KN9jOAQAZ4i8x9936VT2/xQOA2tTo0NNWbVN17ErQkETrfegm0Fe00tmznSgWFLNEDEgltfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qpd2uUPaqSozCmyeKhLS97Zygta7MdhckfKU9sl//Cw=;
 b=Vl8XVPArPuMVTBoEmhLo7GvHx0UBYKT1pKUVHd5rqxoUPyeP4sqgEYfOTjfH8K0+zQy9ONViVN+nrHj3RjW5+fpzYh/uXkg367Svut91uPq2RSSI0sLpWe5kWNTngPEiRx2SFLb9shV+CioZGP6xsy8ykesxX5/Ed24NlhpQPLU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=toradex.com;
Received: from AM0PR05MB6002.eurprd05.prod.outlook.com (2603:10a6:208:129::19)
 by AM4PR05MB3363.eurprd05.prod.outlook.com (2603:10a6:205:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 10 Jul
 2020 13:45:15 +0000
Received: from AM0PR05MB6002.eurprd05.prod.outlook.com
 ([fe80::343d:a818:80a7:3e6]) by AM0PR05MB6002.eurprd05.prod.outlook.com
 ([fe80::343d:a818:80a7:3e6%7]) with mapi id 15.20.3174.022; Fri, 10 Jul 2020
 13:45:15 +0000
X-Gm-Message-State: AOAM532P03WdI2WDjcKr5RMNJ44/lV8XuuQAoEYfioR/5ftYfKX9RJj/
        8nKETKCYW22nKZHzvY4wjAM7Dpte2Oeu3rbAv00=
X-Google-Smtp-Source: ABdhPJzrVZzrQQ3IreQoVEx9rLcjQ0aExSWAX3ApSKTQcIwqwcSYN1KQaIzIn3gNdGu2IzP5JfEDnDDPguLD1Phr5FA=
X-Received: by 2002:ac8:4b4f:: with SMTP id e15mr74159750qts.305.1594388711736;
 Fri, 10 Jul 2020 06:45:11 -0700 (PDT)
References: <20200710132423.497230-1-philippe.schenker@toradex.com> <20200710132423.497230-2-philippe.schenker@toradex.com>
In-Reply-To: <20200710132423.497230-2-philippe.schenker@toradex.com>
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Date:   Fri, 10 Jul 2020 16:45:00 +0300
X-Gmail-Original-Message-ID: <CAGgjyvE2DX0ntVDtM0_dDRE1j-VWofNXNkoccuDXuk1Q6A7ytw@mail.gmail.com>
Message-ID: <CAGgjyvE2DX0ntVDtM0_dDRE1j-VWofNXNkoccuDXuk1Q6A7ytw@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: dts: colibri-imx6: add usb dual-role switch capability
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: MN2PR19CA0009.namprd19.prod.outlook.com
 (2603:10b6:208:178::22) To AM0PR05MB6002.eurprd05.prod.outlook.com
 (2603:10a6:208:129::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mail-qt1-f178.google.com (209.85.160.178) by MN2PR19CA0009.namprd19.prod.outlook.com (2603:10b6:208:178::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend Transport; Fri, 10 Jul 2020 13:45:15 +0000
Received: by mail-qt1-f178.google.com with SMTP id e12so4379253qtr.9;        Fri, 10 Jul 2020 06:45:15 -0700 (PDT)
X-Gm-Message-State: AOAM532P03WdI2WDjcKr5RMNJ44/lV8XuuQAoEYfioR/5ftYfKX9RJj/
        8nKETKCYW22nKZHzvY4wjAM7Dpte2Oeu3rbAv00=
X-Google-Smtp-Source: ABdhPJzrVZzrQQ3IreQoVEx9rLcjQ0aExSWAX3ApSKTQcIwqwcSYN1KQaIzIn3gNdGu2IzP5JfEDnDDPguLD1Phr5FA=
X-Received: by 2002:ac8:4b4f:: with SMTP id
 e15mr74159750qts.305.1594388711736; Fri, 10 Jul 2020 06:45:11 -0700 (PDT)
X-Gmail-Original-Message-ID: <CAGgjyvE2DX0ntVDtM0_dDRE1j-VWofNXNkoccuDXuk1Q6A7ytw@mail.gmail.com>
X-Originating-IP: [209.85.160.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2d85eb8-a256-459f-e523-08d824d779cd
X-MS-TrafficTypeDiagnostic: AM4PR05MB3363:
X-Microsoft-Antispam-PRVS: <AM4PR05MB336348B002C41BF3342B01E0F9650@AM4PR05MB3363.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3m6jKf3Rxsnmw+ftRgTSVdU/MZ2DUpf3hVuC7xzIveCV9t9of3MxEBfBWAzoZtEWzN8Ay99jy5nltYuxY2AQdmo/RWIVWFFTUJC0RSL4cZ/CIisEm2xIH1qHbsK4PDc86v4aMjKXAms7xemFc7ZM2U1RD6j5l7ArvtQd7EcNHIH9Xy5nFGleUg8+nR+s/We89tab4bEe9+O98BBREq9JfYJZaw1BpmwQGea3DNGkK49JHhRDklf/e0YHwol7/RfqNkM2twqtRrbrXuOroJUhtI0Gvf8k33Mlqr0HnvCddA3rDT9lU69Nu0wz3C83QWqA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB6002.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39850400004)(346002)(366004)(136003)(376002)(450100002)(8936002)(8676002)(5660300002)(4326008)(9686003)(83380400001)(6862004)(6666004)(6636002)(66556008)(66476007)(66946007)(86362001)(44832011)(53546011)(2906002)(478600001)(55446002)(26005)(52116002)(42186006)(55236004)(54906003)(186003)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 5V0n1qkI6ItKaq/qgEN7tJLJUaEZ5tXlZxdCNfDnR0sE22RCAtcn/WmYkG4dZBsEFkAD8MnQWzXsktBgCBwVsxeTWBGe2FKK1NT1XVoQMc6+po84IeqFdw4F2SPrS1tVa32hxMuODWY5g6Li2QqpQcNvIIQo9cB4xZIb5aC+J5kovOXWbOGtN2ZmwUjlkpm5IYXMYkXREPGw5638wz3zd6lqUurzyxte0Av78fZHa1p2ookC3y4QGyDqZEbaP+F2ZLnB+gPQyGg0H+dL7KZ6gjB6hIy7OSo8rDviNDYQiGk8fnrpO6Nb2jJymmAbLNe5yuTjJ4Ig5A1uY5NIYG+7m3YqSa/DI6TMxOUzNZzJj62GI938wY0Q16MGRfILWLdzts50f+FuCd8YWM+UwOU4P3wRfZ9BmxXsvQYRngGbMjpR3WmVsLFvjQT7L2SdbH5D648RBYWGk27bLVkOBNB58/PWqlu637xrDw/TSD73H/E=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d85eb8-a256-459f-e523-08d824d779cd
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB6002.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 13:45:15.4449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kem6mo+twIM22dm3+VtY2I06Ww7a7YDcg96YArnf8Wmmsnch1pMyC3CXvCn5rcpgSlm2vvqEhKNjc/hgFNQP1IlCNFbNWWKAFQiVGsT4AQg=
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

> ---
>
>  arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts | 8 ++++++++
>  arch/arm/boot/dts/imx6qdl-colibri.dtsi       | 2 +-
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
> index 65359aece950..c978b3f19a2d 100644
> --- a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
> +++ b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
> @@ -45,6 +45,13 @@ clk16m: clock-16m {
>                 clock-output-names = "clk16m";
>         };
>
> +       extcon_usbc_det: usbc_det {
> +               compatible = "linux,extcon-usb-gpio";
> +               id-gpio = <&gpio7 12 GPIO_ACTIVE_HIGH>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_usbc_det>;
> +       };
> +
>         gpio-keys {
>                 compatible = "gpio-keys";
>                 pinctrl-names = "default";
> @@ -220,6 +227,7 @@ &usbh1 {
>  };
>
>  &usbotg {
> +       extcon = <0>, <&extcon_usbc_det>;
>         status = "okay";
>  };
>
> diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> index a4a54c82e28f..de49f9faa426 100644
> --- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> @@ -363,7 +363,7 @@ &uart3 {
>
>  &usbotg {
>         disable-over-current;
> -       dr_mode = "peripheral";
> +       dr_mode = "otg";
>         status = "disabled";
>  };
>
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
