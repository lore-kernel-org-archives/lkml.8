Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD5FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 06:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E490206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 06:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XB3tJsIE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgHJGU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 02:20:27 -0400
Received: from mail-am6eur05on2040.outbound.protection.outlook.com ([40.107.22.40]:9825
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725763AbgHJGUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 02:20:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWSq+dc80UMP/InHYpOVsjlGGsphgfA4UWXwVlPWSHDHhCg0OkrPlqvOebSHf86f+rQMbn6yWHPbeufBhYVLZYRhQxkd1IOawwCcGmkMl8N8gsWuVwxxUG7Ow/H59Le7Nmb/wSNtgLsw29Ael1FqnjOqg/t3XXGTTYulEbDDTV8Hwea3hGWg9hwE6S07N7u5ama3mrG6CmHj5+LfWWjEDYQbl1uLzfCUTqdX/Ebyx3L73bxSe/uQ5KYCvXZyzPFhugUjM3C8W433QVCBLB7f7HOy/r19BXK+ewrlvRGT5jNu0LbsmyI2IbkEAcqYOR7KtBkP/JadoRTi++mndVpAxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSm7k20HOZpmr1tZrO2W1rqBeo9usfX8VtLs99TRYE0=;
 b=Tj7eOzBe0IyyzR+EhT3sD2oqshsNOPttOaSbbkd/dFUGvZCglBpCywpH9HmblyFZJs+uWCpYHiLcK1qWZ9A+byJAGNKbKlAEVjdyMezGdK/ElQwH4QgjdYbOXUXr06PWigXUpPmQelAf1v8aGxxL6Y3pzvOsHN9yHTpR1AKPgrT4lT83eqbnYzg/dH9NYcUL1KZA1oTm/fWgeWU9BLD1bUm5qTq0K2GFa/yM77qXfzmDq/SbcUuAC3LruOJGELJCcYrb3Rziz8ngGaK75RG8HaXDaD6pqcHNiFU0EDAYoayMkxVRA5+YK8fjy+mQUy+YTajLGGzve/a+NZm/uw0SGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hSm7k20HOZpmr1tZrO2W1rqBeo9usfX8VtLs99TRYE0=;
 b=XB3tJsIE/BPeh3qeY3t8nUbc2Vz5OVeKjbogexmcZs5rsnEXer15lZJdN5OjqaWt4E04F9T2sBhpec9WtYjOzkjKUeclC+5oZwXNu6/P5ug9hM+zmwIGPLXwJdJLncM/N91iXzxQORFoqiaxZ6TnY2lUqj0RSfM1lPMpHrj5NVE=
Received: from AM0PR0402MB3809.eurprd04.prod.outlook.com
 (2603:10a6:208:10::30) by AM0PR04MB7042.eurprd04.prod.outlook.com
 (2603:10a6:208:1a2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.17; Mon, 10 Aug
 2020 06:20:22 +0000
Received: from AM0PR0402MB3809.eurprd04.prod.outlook.com
 ([fe80::156f:d82d:35d4:4f02]) by AM0PR0402MB3809.eurprd04.prod.outlook.com
 ([fe80::156f:d82d:35d4:4f02%2]) with mapi id 15.20.3261.022; Mon, 10 Aug 2020
 06:20:22 +0000
From:   Jason Liu <jason.hui.liu@nxp.com>
To:     Oliver Graute <oliver.graute@gmail.com>
CC:     Anson Huang <anson.huang@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: arm64: imx8qm: tlb SW workaround for IMX8QM
Thread-Topic: arm64: imx8qm: tlb SW workaround for IMX8QM
Thread-Index: AQHWHJJL3sMk5DuHM0ub5NdDHp2bnKiM71gAgKSSOACAAAECAA==
Date:   Mon, 10 Aug 2020 06:20:22 +0000
Message-ID: <AM0PR0402MB3809CD2049E4B97ECC8A362CAE440@AM0PR0402MB3809.eurprd04.prod.outlook.com>
References: <20200427082348.GA98329@archlinux.localdomain>
 <20200427130328.GA101181@archlinux.localdomain>
 <20200810061324.GA66637@archlinux.localdomain>
In-Reply-To: <20200810061324.GA66637@archlinux.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c3ef980b-7bfa-49f2-d35d-08d83cf57674
x-ms-traffictypediagnostic: AM0PR04MB7042:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB704286E695AA3706125599D4AE440@AM0PR04MB7042.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IpFGA++QZnrFJqy1DFdLDru5hXFJYbOnS2Z3NIlNvMUvlGzZV3y/oKgCJD3kKYqWHrsWPh81D7QOw04xm8XaV7v3v+wyh/HkWtttF3Sw1rr9J2L5tF9r8bJo/Cru9dYHYkDdfQWrIdDMXxFfmCo+V3PVRvGJmakD0/BRMP1Ef6CT0QMEW/lj1S9W6ncEuNnKKJTkT5EHTuGQ6UxCjE9PfNqyzGNIDF4IndyK75fInuQ35aGQDEMNhSOsFZ+/LlJ97O8seNQsL/BG3PFCl6lPxAebrAFXgLi+tk1txArc2h3N8vCvEUvZuONCtVzJdgfAC6kpTSXS6vgckD1VS8avEd807nydtuXzj0nMKfFIZ7lXBZY91JP7gNf6dp8Wl/PpLVy7kNFNGqH53jwSKEdOoja6jBH9LjLLCYhwtTHHyOJLz/IaR93Pj42xZSJPz6r1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3809.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(5660300002)(52536014)(2906002)(316002)(83080400001)(54906003)(8936002)(478600001)(9686003)(6506007)(4326008)(53546011)(45080400002)(26005)(83380400001)(33656002)(186003)(7696005)(71200400001)(66946007)(966005)(8676002)(64756008)(76116006)(66446008)(66556008)(66476007)(6916009)(86362001)(55016002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 4kBPip3N9KKbrN91Niv4E4DGPpAk6STTulCS7+qGKSrr2saACrbEmA1qPQtQWk17kmDDObk2vbnbw9DsY6Y3ZpOaHELwuUErVOmb+MELGiS281HVfPY+KmvO6EOJs1ZtM2Gs9Dzft7cPKpROr+rH6nrEhrWXbuHCMDAfKZ2sPqqCCWc3sQYQ41HIMzgIYAeZcfASaWRPp7DrN2Ve96PWGB6DrWvzJSohr+FBIyDHbiJbJUDczO/dnIbtRtxuAIHQG8ALrb+NILhl6zvIwXy1H/EFzeHLUne1vFJFhmtLbIQA09AQkP00YkGLUUj8yRiPNG6qe4twrAI/ZepoXAAeKeUrkcmg+ezJJIoNRR9j5Vdgo/b+dRpqlyL3BPUlfydI2THlVT+jPpnRKD22upfUvjqdRUFUBEMR1Y7q1MbL2ByxvY6bZ9xp/XsVMLfyYsgP7ZNa7Zb0O1kq7U3kH5ZcFFlcHK0LY/2vu6Pu9DMJ/zSlRcbiZJfwnd2RIIvF0XwhJQeZqZlFd4rho1WFVCMVFZejXfSK3hByvwg0J0dPx8ai+vQ6/AXvkZeROGpLHNKC6Q1VhXtAQHMYD6gFrXx/xmrwCbcuDUJUh0gE+jhFkQus2DOfUWW9RaCnzQ4dGXzisT//ON9hyeBC5aA9bNKQbA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3809.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ef980b-7bfa-49f2-d35d-08d83cf57674
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2020 06:20:22.4247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wYw55Qfvy2ZKgFhWfkCpvZJIdP/sgjnTZOQEUYz6kcIvi+bGbbhGKTzQzWsMjHNg7gQuYHc4laeXk7QB70F1lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7042
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Oliver Graute <oliver.graute@gmail.com>
> Sent: Monday, August 10, 2020 2:13 PM
> To: Jason Liu <jason.hui.liu@nxp.com>
> Cc: Anson Huang <anson.huang@nxp.com>; Aisheng Dong
> <aisheng.dong@nxp.com>; catalin.marinas@arm.com; will@kernel.org;
> dl-linux-imx <linux-imx@nxp.com>; linux-kernel@vger.kernel.org
> Subject: Re: arm64: imx8qm: tlb SW workaround for IMX8QM
>=20
> On 27/04/20, Oliver Graute wrote:
> > On 27/04/20, Oliver Graute wrote:
> > > Hello,
> > >
> > > is this nxp software workaround already proposed to linux community?
> > > can someone point me to the discussion if available.
> > >
> > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fs=
o
> > >
> urce.codeaurora.org%2Fexternal%2Fimx%2Flinux-imx%2Fcommit%2F%3Fh%3
> D3
> > >
> Dimx_5.4.3_%3D&amp;data=3D02%7C01%7Cjason.hui.liu%40nxp.com%7Cef51bf
> 7d
> > >
> 704f4b7439f808d83cf48290%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> 7C0%
> > >
> 7C637326368154132369&amp;sdata=3DGrMP8XdoYETWiFdHTHStYv7CEZjRx%2F
> mkygA
> > > prGckrus%3D&amp;reserved=3D0
> > > 2.0.0&id=3D3D593bea4e36d8c8a4fd65ef4f07fb8144dab2de1c
> >
> > sry for the broken link. Here the right one:
> >
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fsou=
r
> >
> ce.codeaurora.org%2Fexternal%2Fimx%2Flinux-imx%2Fcommit%2F%3Fh%3Di
> mx_5
> > .4.3_2.0.0%26id%3D593bea4e36d8c8a4fd65ef4f07fb8144dab2de1c&amp;da
> ta=3D02
> > %7C01%7Cjason.hui.liu%40nxp.com%7Cef51bf7d704f4b7439f808d83cf4829
> 0%7C6
> >
> 86ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637326368154142361&a
> mp;sdata
> >
> =3DUS2Pu6eOo3vLLNBH7Y1zZM5LACrnhLWGmx7bOc5fNg4%3D&amp;reserved=3D
> 0
>=20
> this patch is not applicable anymore since next-20200713. Is there an upd=
ated
> one?

The patch has been updated a little bit according to latest ERRATA. The pat=
ch not
sent upstream yet.

>=20
> Best Regards,
>=20
> Oliver
