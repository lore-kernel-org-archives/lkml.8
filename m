Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068FBC35642
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C80D220801
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cO+t8xvp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgBUHJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:09:02 -0500
Received: from mail-eopbgr140081.outbound.protection.outlook.com ([40.107.14.81]:16974
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726201AbgBUHJB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:09:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dW4/dPi+XSk2fESGDLBnCIcWmMOEZgyZM2LQ9wYsJImkLP/Mb5zorAX3FZK9uiew3Zm7e7QGQqpVMhZFYpkI3M6Pa42utWlMnO/KeA5QP9cF+RlTMZslt+6EiDR0BrINOoNBVN7WY287l7tis+3E5eX47UV6Lj6Dy4F7zNFcm9ihDbQzbEdSNbDGfC+PC3QklfHe7XRNqA0w0y9H/pQfUZ5g7uskEjEmaEA47JtDc+Us7cT4Ksj2bUCXv288vesll9R4q9tSTt6MjW4hMERRenR8SSrDYk8gUaZWdAKr0yF6cfY8h9iyBWsx1FXJqg31CiCprsiXEyQyoKbBHChqiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vcwqgm+Gu4rKE3VBkf2FJQXbKYYmoaTnj4Qe/cGhAU=;
 b=RIgWD/7SXoRXXAK6sJ88RLMYoCL2hhWzdPo3ygC6EswxocIsZdb2Q8IlmEV4qhiCeiqgxBrmG8HE7tNtV1/Q+Ec4FlSZOfGi7yMcH3/vx5LCGEE201NEk39S0KGVEz8xKeoR1UMmXWRMucO+WVvEs35QBGJXw1Hcrpki3psD/lfCSnM2K/Cy5nVnUmBo0Qq36OK1EbbTlk0hZ9CWRevAmu1nGSWSQaw5lJjqBFHwjkzplg/YqDRPqElUTgOKoTQuQHhyj0cBqkM46hwDZaGwI/LxfP4cRGOHX9purQBcFpVrNUgbyiCZFVaTPQvrWr3z2l8oyaGTddZjLT69lxld0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vcwqgm+Gu4rKE3VBkf2FJQXbKYYmoaTnj4Qe/cGhAU=;
 b=cO+t8xvpF/x/61zdXRbP0XojIl8L0O2T2PlRzuMma0m/Tg1P+NFr0FPJM8DkBOkPQegVzRiLPLEj8l7iYkysAF3dGep2WmkXVwWvuiPMfIXp997kPTzK+MgojC2J0AgsTXvUsBUJ3H9SQYMUYKCxQxbF9UkNJkneNr11+JhZD1A=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5715.eurprd04.prod.outlook.com (20.178.117.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Fri, 21 Feb 2020 07:08:58 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 07:08:58 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Oleksij Rempel <o.rempel@pengutronix.de>,
        "ohad@wizery.com" <ohad@wizery.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 0/9] remoteproc: imx_rproc: support i.MX8/8M/7ULP
Thread-Topic: [PATCH 0/9] remoteproc: imx_rproc: support i.MX8/8M/7ULP
Thread-Index: AQHV5vbmWntOo1W/0E+zZvFdhH2I6KglOM8AgAAASJCAAALmgIAAAW/A
Date:   Fri, 21 Feb 2020 07:08:57 +0000
Message-ID: <AM0PR04MB4481DFEF5C53E3B749496FDB88120@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1582097265-20170-1-git-send-email-peng.fan@nxp.com>
 <20200221065140.mn4wxk5c2xayqwan@pengutronix.de>
 <AM0PR04MB4481C4C811F139665AB1C54088120@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200221070303.kndekskjj6cvwtkb@pengutronix.de>
In-Reply-To: <20200221070303.kndekskjj6cvwtkb@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fe100c76-1faa-41df-30bd-08d7b69ceba1
x-ms-traffictypediagnostic: AM0PR04MB5715:|AM0PR04MB5715:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB57150D942809955623E9470A88120@AM0PR04MB5715.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:298;
x-forefront-prvs: 0320B28BE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(189003)(199004)(9686003)(5660300002)(33656002)(6506007)(316002)(966005)(45080400002)(26005)(71200400001)(54906003)(478600001)(186003)(2906002)(81156014)(81166006)(44832011)(4326008)(8676002)(8936002)(76116006)(7416002)(66446008)(64756008)(66476007)(55016002)(52536014)(66556008)(7696005)(86362001)(6916009)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5715;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IbwRjma45FA5UkQxfKD17AysQcjZEbV6ZWyMF/FXQ8wHNW9GJpowRQOZhgx+NoBHlOkGwP5Xtx/BybIJUuF0ydxamEIhF29LpCwjRvhMUnUBd4kErz5YM+gbVEvvRmh6czxsy1Ya2It3hmyJEUA3Tid71t6aEZoGimrZtAu1cJDQ+hImKZgPRtnVvHbNh1vqC6LhzPEXVwHoiscpwTB87GT5c0ZodpkcAEj1YRUzUhEuAEwhYoz+IGGvi0w/RCYHJyV565KNEdpDbq3CnIn2RKMrwJAdTu/BtWDRrNv+sBTc+XX3PSbAk1vWA2DAwXEuRf9qh8YrBOqzkBHiymwhBzaSr2GadbfGgISEuVOuJUkCWz+/qUXVNkK788wGk42Idr77VC0CleyAAPdrRzMWAubZC50fcdKSFhSV7/wIy4tfBER1BWalmChYabGvMFb2qdK0zHG9QKiqSaV7876cpWmpDVQe34bJyYhn+7rarx6gSYshyNj3G6WwxnVIOkhcJUQH2BSK3tNwxKkSXPiq04uWyCFFWYAiiCV+KCU9WxITS6W9UuvV8Yim0K0WmAPg2UeGoyx+CLMzJ+QnUeIQ/4IIIbt2k6HASsiA2hl9/BIENIZbJote6DSN66tf0FDg
x-ms-exchange-antispam-messagedata: c61kTO9hpGP05WC4Ua7J30BlZZ34FZoJQHGuTjMOq3F/xs24bh5+noYXM0k5t5OMXPCuBIS6vy0PvgOCPBr3QcUuKp5SxfmYf4iuL2hACpSqHzfTjbSl6OqMNItgqukOMs3/LqbIuU8FyaMd6jAFNA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe100c76-1faa-41df-30bd-08d7b69ceba1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2020 07:08:57.9368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wlXsr/mxM3MV/IS3bX6q9v6QqTcrMO6lj2ZL0phUDxfxtm2LML5CeUISiHPS3Y5XGgkD3CyYhEa1VF+ru9A0Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5715
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 0/9] remoteproc: imx_rproc: support i.MX8/8M/7ULP
>=20
> Hello,
>=20
> On Fri, Feb 21, 2020 at 06:56:02AM +0000, Peng Fan wrote:
> > > Subject: Re: [PATCH 0/9] remoteproc: imx_rproc: support
> > > i.MX8/8M/7ULP i can't apply your patches on kernel master HEAD. Do I
> need some extras?
> >
> > The patchset is based on Shawn's for-next branch. With Loic' V4 patch
> > applied as showed in cover-letter.
>=20
> BTW, the generic approach to formalize that is using --base to
> git-format-patch (or git-send-email). See

Thanks for tips. I'll follow when do new patches.

Thanks,
Peng.

> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpeopl=
e
> .kernel.org%2Fmonsieuricon%2Fall-patches-must-include-base-commit-info&
> amp;data=3D02%7C01%7Cpeng.fan%40nxp.com%7C9cd4c63fe8974353439408
> d7b69c1b2f%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63717
> 8653890207488&amp;sdata=3D6fvjPjemWlSzZVcDMqWPtjuyEFdOBOttGcO7bS
> uxsyY%3D&amp;reserved=3D0
>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig
> |
> Industrial Linux Solutions                 |
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.
> pengutronix.de%2F&amp;data=3D02%7C01%7Cpeng.fan%40nxp.com%7C9cd4c
> 63fe8974353439408d7b69c1b2f%7C686ea1d3bc2b4c6fa92cd99c5c301635%
> 7C0%7C0%7C637178653890207488&amp;sdata=3D1XRpT97ML%2FLpYjdbZb%
> 2BTdp6DfW6FSMq0Jnxv%2B7%2BX59Y%3D&amp;reserved=3D0 |
