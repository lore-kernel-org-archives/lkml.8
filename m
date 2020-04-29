Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73365C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AC4320775
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FZ/IsT1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgD2JvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 05:51:08 -0400
Received: from mail-eopbgr130082.outbound.protection.outlook.com ([40.107.13.82]:48260
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726811AbgD2JvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 05:51:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUhjkJzVpYXHKIhvTEfrzcT4nhwVHz3kZD6yk/8KrizRy+ePCb9AQlNI1DrHZ/FB0h7+NXj5obWA3nF5HRDm8fmYaaTZ1fRn2GTUJbcLESQbW8eQzGe9dOYn995wAh1yOEAVAC24tYRAt6ZzyLOGwJm0qdslTo4JccYM8VaGpGEB41StnH9D79jxaFXOoU0zsFG7zrN/3pBOaKvUKXJ9ZFRAOhkDPKIjpVbtL5X5ahc5LNJ9PxOVOctRFeKd0TI5RarvYLvAgPdwCMw46ds2LNvRH3vlZzFGPt0uz9dXoZ7DKcOOLTc/z+8mr91jWUJ7Xwgcef+U2xQh0MWO1UsP2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x07Zfcew70iSspPeSv+R+1IQUSnOo7DvWfcYrQZvJ3Y=;
 b=erLPzVXieBOaNAOROAQ2W0zkOwzw0I+WnKNwD0ScMRFlDPdkH5AWupVTrdmT5ztwLgAKug+nmg9kIuw08dTtWzsIouGkR2DzyDZIwMl1tjbo8ZsshvFW5IcCiLKvMskjBkRn4NlZLzwzKrrWpFmpc/NK2SHmJaxW21REY1Yc8teXf8RyFIaY3G6xQrmPppyzaHsn5Hp/2bUuW2CIR/bs4XfZUvyvYFWZe/PqD9Zlgyat4nWbqA8Y6HhgphaoxJEaIMbTkAmvUllH2T4S3TYGZFLfgwCOKQ7LYBPxDbwxrwh24aLN0jxgH5d0kjbEiSgebjtCY2EqsPHWjKuKmuGiBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x07Zfcew70iSspPeSv+R+1IQUSnOo7DvWfcYrQZvJ3Y=;
 b=FZ/IsT1IV5hYAUE7fzj/QvRb/JtElen+QZDpnaDHqlZFtbbIbINXLujEMaFNSiyNp05hKQBqpeM7HYHKyvpfXojshvnfPipGEUW8LLrA+/WQdMZYyG6XLL/QSSWgS7OtL7trKf5MgdrZDfeF7+LWZIPtqwVxuJpPMnetwm0OuDE=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2744.eurprd04.prod.outlook.com (2603:10a6:4:94::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Wed, 29 Apr
 2020 09:51:02 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d17b:d767:19c3:b871%6]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 09:51:02 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] soc: imx: select ARM_GIC_V3 for i.MX8M
Thread-Topic: [PATCH] soc: imx: select ARM_GIC_V3 for i.MX8M
Thread-Index: AQHWHgtrbOPFN34OUkSD4Duf25RuPaiP2uvg
Date:   Wed, 29 Apr 2020 09:51:02 +0000
Message-ID: <DB6PR0402MB2760A8B8622129C856EE170988AD0@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1588153215-2435-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1588153215-2435-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7882dc99-fe0a-478a-4fad-08d7ec22d420
x-ms-traffictypediagnostic: DB6PR0402MB2744:|DB6PR0402MB2744:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB27446907297366175475ED8D88AD0@DB6PR0402MB2744.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 03883BD916
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h++yIc/YXubT5oTN7we0Mgqc+P+I1LcJGkZiJGz0nD52bH3d7X2BQPnahz6Jgoi55HpSaqnaA/zgnKBnDhDUzDleoeRpaF0gUO7RH87TZWdfi21CmSDDogVj8Z7pHM1DpBh2gNNSlujP+PYUSnNYUWkLjvS40ksQSIuzpQ1+VxQBGwvqKOLdL2GabnUN9B+Cv5Og4kYHdfs/LrfSsgB4gdVAr2EG7rllgWnToW93ZaIy4C7qlooN43M0AQAkDYvvaE3P6m7d9txl3wGq3j/nTPlyPBmJ2/L8j6xoLGfRoU7TfRTi0/jMYZ4MWErjIQTgzqd+SpFdA/FubzFwtU134ukAGorxtgK2+b+2dvtI6bbnSvMVSfLxYVzyxIjf0pjre8jjTv3TYkI1FrhKy32EMIzNtgrTCuV+061d1eIb4kHiswG2XXGaoHwApaJ1nmxVOG7oBF/hsQ/B3+YPy81MEdwDP48p/evVr7mEtPtKByKGSh0yFRl1MbKab0bcQj9kZGec22q/4+/pNbJzcv++BA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(54906003)(6506007)(8936002)(44832011)(52536014)(33656002)(7696005)(478600001)(110136005)(5660300002)(8676002)(86362001)(316002)(186003)(71200400001)(66446008)(66476007)(64756008)(66556008)(4326008)(66946007)(55016002)(26005)(2906002)(76116006)(9686003)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: IptbIWl8UuN1XYIYFtNckle1c3Uvy0c3F0IbDfdwKfEeCz3kFvr0r5vCSX+n9kszj7OuGPnTZSF0oxhx/s3Qxv2OOOuayizalnh+TMLhzt2bGdqdq+mnNjucNUT//rWwHFPibzgNvxaH/wK9+tI3AjWqGxIgzgt1FQCiL44FceusWGWUTcyyaCl8XFENGDYjAUB3B4RauB6wEVYIN+Gd0rVY2XxY7dXbnEZ8lnyYom0BlPlq6tMvaGAB1u35d4+64yUDp6YQI22RAKmfJ5ubYcn8tPZgdPGzJI/0nTeRYykQc5T3Iy0V0ATJVXrPxs62AjjJLUXDReg9k69Kwfq5DBtGtaqHSaRx2PMVB7DqOit2XuYV4NLSmsOX68rW+v2vN0ETJgTNHTxEGURzHzjxqalEgDYeQ1jmGL7fuiR20tJScVOKJjmf1joMldsJzmTZ/Qa5SkRdR7OZPGCUXtJlTAZ1GS9rTV6vcRaIqX3f1to2huSvlQUkyrG1rYwiiFZyOxayr4wwzb9Pv38hFntyzWtt8kfXCO2xnVQDTfiydgBNNFNv9wQwYsGm24WzQnrYIU1gXsQfv2rG3M37S5UuDfjY+7LZ1+p/vYgE1PokxxULtkNLnoT8TWR6Sq8o5SJlr2ksejneqJZHhzDzDn/IIw8bopul+fHW05/xdO+8KR4A99lZn4I/6oiNtQJ/AU4Fv++DIu3QiwFWeWStUhNzZQpJCDSleV38l9A54zxZ/7899ZZo/EfY/SgmoNgOwrLGJHUS54M4yIjta4pzX9PanNSIdNJTWK+ETV4ZDP9FHTw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7882dc99-fe0a-478a-4fad-08d7ec22d420
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 09:51:02.6415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EQTeiHZv8L4hNaJWxBNdjRNpcT8MvhD1tcCOEm3A2EA8VqJcK8UXClmob644A3LnggTrVHzhslhcKF74FswcCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

> Subject: [PATCH] soc: imx: select ARM_GIC_V3 for i.MX8M

Forget to use v2 and mention that this is resend
https://patchwork.kernel.org/patch/11435941/

If you need v2, I could resend with v2.

Thanks,
Peng.

>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Select ARM_GIC_V3, then it is able to use gic v3 driver in aarch32 mode l=
inux
> on aarch64 hardware. For aarch64 mode, it not hurts to select ARM_GIC_V3.
>=20
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/soc/imx/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig index
> 67aa94b2481b..f4006b784312 100644
> --- a/drivers/soc/imx/Kconfig
> +++ b/drivers/soc/imx/Kconfig
> @@ -20,7 +20,8 @@ config IMX_SCU_SOC
>  config SOC_IMX8M
>  	bool "i.MX8M SoC family support"
>  	depends on ARCH_MXC || COMPILE_TEST
> -	default ARCH_MXC && ARM64
> +	default ARCH_MXC
> +	select ARM_GIC_V3
>  	help
>  	  If you say yes here you get support for the NXP i.MX8M family
>  	  support, it will provide the SoC info like SoC family,
> --
> 2.16.4

