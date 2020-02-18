Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F09C34034
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 05:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B9E21D7D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 05:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gS5H2IhZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgBRF7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 00:59:08 -0500
Received: from mail-eopbgr150057.outbound.protection.outlook.com ([40.107.15.57]:6622
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725954AbgBRF7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 00:59:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ST1XD4Z5UXT9L0Vo/s14XlKnsZiux2kETQ4cFgz/Hq71CJ7dQ58FfklBM65gFopBnpvGc0lgU0FRTqtW4O2kpzlEstB34JlQ3556xTs3/2JUKINwczJiTZU7UvTyWqCKmD8xXJfBuK7bucw04BJtJUrL02F5L/9Ay1XQOAW6EkpHGHKYZdPzri86V/m/LQI+/og1j7neGAfWtMCI2C7rMCN3upItoxVMeYORb0XX2Ery1ZsHtdSUwoqzW9qnw3YjR7WEaunsCN5eTxSZti4N8omQnKRo4VFsT0xhm4S8Sc5TQZKCEhJG1R+NIutqVPBFBDic/EbbdTxwYpplN/yf/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yhIZ7IzKmnXbLJ1d0gJZNg6seoelNCUTg1d5AEtiV4=;
 b=W6hOWEbEXPz0HbP+bbmpaDXVc0pO4OQDYpx2n9bDAQikiFkSizI3N/JiyL9+E7WyAtjHgqgzhvLIAPIKP9Ek1o6xxxJlPBusKA6aNWIuJeERbfSE5j5NcrKQ9cB28yZpwShY0AAD5eyd11UvYsfnLnc8CMQTvGIxgz+x57+WKpEoXBTCIV5rXXpXo2A+hS+3kJup/l6tnOy2m+UN+04j3fpjTi8uoW6fr5fHNAenxxvyTg5DzXJIxRsyW11rkVbymZ7XQksXZ0uSiF3NNt4zJlA2vpP/lTuSbEEd2mfrkpDEN4C+MzOJylr/9y+utITXkaSlGyf8gYWgHLuXBdlk3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yhIZ7IzKmnXbLJ1d0gJZNg6seoelNCUTg1d5AEtiV4=;
 b=gS5H2IhZWsWiCtJ7CMCUcfn89kbIOC/iBmIy6FroceLmdBnFtKay8cfeToVT0WcOj1fGu68PDmxRQYwpgjt0XLzFhuK76ZTzGVMQBzl5pez0Aw6VaVTm79J7I4LkB7YG9uZSRqnfnMrCeA8AH3BEOXMTxq838XFhRQTm392P9Tw=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6484.eurprd04.prod.outlook.com (20.179.255.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24; Tue, 18 Feb 2020 05:59:02 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 05:59:02 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] soc: imx: Remove unused include in gpcv2.c
Thread-Topic: [PATCH] soc: imx: Remove unused include in gpcv2.c
Thread-Index: AQHV5iBRqFnrgW/qQ0yczkbDA6XARaggdHxg
Date:   Tue, 18 Feb 2020 05:59:02 +0000
Message-ID: <AM0PR04MB448194F2C0E2043661556C8588110@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1582005089-23767-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1582005089-23767-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 846c25c2-63e3-4a99-42c0-08d7b437a78b
x-ms-traffictypediagnostic: AM0PR04MB6484:|AM0PR04MB6484:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB64840E8DEE2C6F35DDB5B7E688110@AM0PR04MB6484.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 031763BCAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(189003)(199004)(52536014)(86362001)(4326008)(45080400002)(33656002)(478600001)(2906002)(6506007)(71200400001)(8936002)(966005)(44832011)(76116006)(186003)(26005)(316002)(110136005)(55016002)(64756008)(66556008)(66446008)(66946007)(9686003)(81156014)(81166006)(7696005)(5660300002)(66476007)(8676002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6484;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yHeMA2NT04OyHYncnHAo/D9czd2gQI4T5jmFaMBfc9JOTErHgnMl1EbaDUvCC+E2py50hLTxxmfRJ5u+eNA/Z0p/BArfL33j4XtzuOcGUegD+OHoygC3cL7sZgLwg6Tkf4lf8ppYpgKkfTRPB7KjgbJlmP9h4Jg93VLyj1brHlr8QEiisvbEqtZ/yFnkvgmOm6DO+ku4feeGHY8yisjvA7LLjVNQVG/l7cWo2AmtbDaxl4t1qSLIBrcyXMs9inaF0sqEdBUJq+djZ0h9Bok7DFPfJltqOw4USRYgb/5QEjB0YYIuGm/5K+QHZlinOw1xBdNHZW5n+T8TBDQb3ys4T1w3vZ7io8KdfkG3z//JlXjq4iLY0DrgTJ2RpKtzyNN5kUSIYjevhWYtV2T5/fFpYnVMnVf/dtfaWZat5B5bt38dtp/iXz9PlnxMbufufKe2goUO5M3OnXTswnHcL7m1eda1loY8GhRUl0l62tybk4wuN6LNTvhoOUFCEl2N1bnoFvPey+2nELRAVfowx+zQADlsoj/pBbkg74S80mbmvltQqClb0Mx3rJtMoo0QhlW/VF/x0B+gAhiq31N+h24xLg==
x-ms-exchange-antispam-messagedata: 9Y4uyZ6CIqkdghZobsafDJz4BdIIifaB6BJ96Je/Z0TEAvXNXylM8gFf01q/7nJhPxc6T8C39BBybCczCsC0R7yRIrct3k/+ZTCQAQDg8xoNsYM2ERBtwTeFCYaRMzqQYowMwZeTwYDEF41N8JmnCQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 846c25c2-63e3-4a99-42c0-08d7b437a78b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2020 05:59:02.2667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zxakHPlgJaODkRQ96sscN9Ts9hGA4EUq5FMvrVWvUzsq/ZKFQ2q9T1XsswXNTYOxPk8VX+O03tkRGl4XQH5L1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6484
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] soc: imx: Remove unused include in gpcv2.c
>=20
> There is nothing in use from sizes.h, remove it.

This is needed when moving to support COMPILE_TEST for
soc/imx, please keep it.

Thanks,
Peng.

>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/soc/imx/gpcv2.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c index
> 6cf8a7a..b0dffb0 100644
> --- a/drivers/soc/imx/gpcv2.c
> +++ b/drivers/soc/imx/gpcv2.c
> @@ -14,7 +14,6 @@
>  #include <linux/pm_domain.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> -#include <linux/sizes.h>
>  #include <dt-bindings/power/imx7-power.h>  #include
> <dt-bindings/power/imx8mq-power.h>
>=20
> --
> 2.7.4
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flists.=
infr
> adead.org%2Fmailman%2Flistinfo%2Flinux-arm-kernel&amp;data=3D02%7C01
> %7Cpeng.fan%40nxp.com%7C0101da7d79d34d01963008d7b43773dd%7C68
> 6ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637176022563909614&a
> mp;sdata=3DbGqSvUHqnMcnkkvYQwyFNaxUEsPFWNpxjc%2FPcAg0wl8%3D&a
> mp;reserved=3D0
