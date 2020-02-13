Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCC7C352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 05:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F332420873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 05:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ycy2XHJ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbgBMFrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 00:47:45 -0500
Received: from mail-am6eur05on2081.outbound.protection.outlook.com ([40.107.22.81]:53184
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbgBMFro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 00:47:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXQ188hqPajdKeMpGG38RUTX502ugH2uLdXY5S05m1/0E2eXxaSZBlJnkMkjkHBeG3cI4CrRtwlglNNNTGl88sL7rE6OI4YsFdTd6p4TRrWdtVtwQtF9c3esryxwWGPbDDylemauAwXyQhD6HIMHpCZR2iblHOS2stU8PfgccziDfMccJsAffy4TFvccWEJqJSJWlM0Ah5yo2qafY72XxXcHLq5NlLMEcdwQxKWDTh9Vvl/kyPRbPTLmDDkEuiLmNssdrpjFWYJh4BTriMovwp/pCnrRKB9Wvh9wlBhUJIVemH6dvqAY7xLLsDoFJmNo07VGkGZzp7wezJEw3Srk0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+94hQSTQH7hkERSjsDb3B1nd2jylc7LRPIUmdcMFsHg=;
 b=XY3g29h7FZWcBneHapkQiD34OlT3byjKtypxbnakIrncdJGtV7AnyK656h+VZlseFOz2VdF/rVZoAJvdB/XxbKLVQu4KkRqxpmzyZNho7GaLY5+/e1xOfv9eni/MffyvBMJB4FNk5swCknsO5E83h30xHz6Eua/W7UXp736CYhJgfIj/TmqX3OIFrighWDazSXqHJZFCkneQ1oWMNUEd63Az2/v1eEYhyyUBsuCCdIoGNKy+CUKm8dn1XzCWBF7LzQ4/ccCjPmhy6NTCKPeGacxRon896RP/UrW7GFadjRt1tvCwYcS2MDPZVCfxpqENmi01PteDRYAc2dza/yteTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+94hQSTQH7hkERSjsDb3B1nd2jylc7LRPIUmdcMFsHg=;
 b=Ycy2XHJ3ysLjtkJ7+Uoqi/FbU/s3XF3FutW3pG63tz5XZpLr5UB7NfGKTuXS+fGT20MksPbXSj1JnCGgB7n6FkaW0AVHQW4FaupUu/SVBnNbhH2fxsTx8r46If10YJ2womv7k85S9fiPZf7nVLRYWd9XFKyr9Zrv9pazvTvX10k=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB7059.eurprd04.prod.outlook.com (10.186.128.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Thu, 13 Feb 2020 05:47:41 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.024; Thu, 13 Feb 2020
 05:47:41 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Jacky Bai <ping.bai@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "info@metux.net" <info@metux.net>,
        Anson Huang <anson.huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "git@andred.net" <git@andred.net>, Abel Vesa <abel.vesa@nxp.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC 1/4] ARM: imx: use device_initcall for imx_soc_device_init
Thread-Topic: [RFC 1/4] ARM: imx: use device_initcall for imx_soc_device_init
Thread-Index: AQHVzFB5yGe49vkt3U6MybEMHs/GuKfuHFMAgABnHtCAKkUKgIAAAEXQ
Date:   Thu, 13 Feb 2020 05:47:41 +0000
Message-ID: <AM0PR04MB448134507B4F957C06F1315A881A0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1579167145-1480-1-git-send-email-peng.fan@nxp.com>
 <1579167145-1480-2-git-send-email-peng.fan@nxp.com>
 <AM7PR04MB6981B45633536729EBEB427487310@AM7PR04MB6981.eurprd04.prod.outlook.com>
 <AM0PR04MB448103B7C47B9AA5621A731A88310@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200213054344.GM11096@dragon>
In-Reply-To: <20200213054344.GM11096@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bfd9e836-20df-4179-5b25-08d7b0483d87
x-ms-traffictypediagnostic: AM0PR04MB7059:|AM0PR04MB7059:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB70592BEACA86EF8F97E37215881A0@AM0PR04MB7059.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(199004)(189003)(7416002)(478600001)(55016002)(9686003)(8936002)(6506007)(316002)(4326008)(76116006)(8676002)(66556008)(66476007)(66946007)(66446008)(64756008)(54906003)(186003)(6916009)(5660300002)(81166006)(81156014)(2906002)(33656002)(71200400001)(7696005)(44832011)(86362001)(52536014)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB7059;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iNWSFcwMBFcwXZNiIqDE2BGl+9wi2gnccfzk4ChwAY3IL78u4VxVqnY35mlEVpK28qo+lkqkMzI5xvYvi61Be0+uaaXLhXzobHusPN4VDctZmMxQ0FRN6lmWOIue1ZxwwBNRt0cEFlw+WoOxyduzFW5ldT3LpSf3YVqMzp6gPLNffuz71B/RI2pVGiT3M7311+SLWfv9p4WCo+J6znZlGkkZ68EFdMiuidNmY0O7lb/u7uy8pj8CdZ/+F3hMeWME6dlz8gdWuDahiYZ6vYpMF6NCXaFHwACTSvFAtVFONhryoYi8upI3rRjI1tFhABx4Jrt8vDlGwshkEMBW1VKnjYBKpyUmr66RMgUU31doePeaOaAnc0H3HfxdQcreKNkWfw8qSg7C9P3Gm9RwFzYO67JBCSZ62FXHRL9uzVUVQ8E2yBTEoZlMtcVUHMITgT/c
x-ms-exchange-antispam-messagedata: s0LmqOBfSCu/tsPof4TIxgYKgAnvugV2gIVoH1XQjYVOEljwDP3pVxcRToG3kEvQo/+v/3be86tBfFNJRNgILEp4qc/4ic6YZ7j0ukPvpb6o6izpojkI3aPvLMrrsKryJOA+21xDmzjCvbiYiiZ/FQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd9e836-20df-4179-5b25-08d7b0483d87
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 05:47:41.2059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Th4zP8pZJEGGazaKfY3WYttRLYCb829KA7ThSzVK1Nis+eBCXXhLu67/YI7eD7i8TDBqxQTWhsu4io31rgOVaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [RFC 1/4] ARM: imx: use device_initcall for imx_soc_device_i=
nit
>=20
> On Fri, Jan 17, 2020 at 08:15:54AM +0000, Peng Fan wrote:
> > > > Subject: [RFC 1/4] ARM: imx: use device_initcall for
> > > > imx_soc_device_init
> > > >
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > This is preparation to move imx_soc_device_init to
> > > > drivers/soc/imx/
> > > >
> > > > There is no reason to must put dt devices under /sys/devices/soc0,
> > > > they could also be under /sys/devices/platform, so we could pass
> > > > NULL as parent when calling of_platform_default_populate.
> > > >
> > >
> > > This change will impact various internal test case & userspace lib, I=
 think.
> > > Need to ask test team & other developer to double check the impact.
> >
> > /sys/devices/soc0 is still there, the patchset only moves the platform
> > devices which under /sys/devices/soc0 to /sys/devices/platform
>=20
> Jacky's concern still stands, as there are many user spaces which will be
> broken and need update.

The soc device itself still under /sys/devices/soc0, the soc_id/revision st=
ill there.
It is just the platform devices moved to /sys/devices/platform.

When I confirm with Jacky before, his concern is soc_id/revision will be
moved. But this is not true, they are still there as before.

>=20
> > In this way, we aligned with ARM64. And simplify arch code by moving
> > the code to drivers/soc/imx. In future, considering more cleanup, we
> > could merge the code to soc-imx8.c, since they share similar silicon
> > rev ocotp logic.
>=20
> Though this is a good thing from maintenance point of view, we do not wan=
t
> to break user spaces.

Actually not break user spaces, since this is RFC, I not expect this be mer=
ged.
If you agree, I could post normal V1 patchset.

Thanks,
Peng.

>=20
> Shawn
