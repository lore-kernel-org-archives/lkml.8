Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314C6C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 07:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0498B2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 07:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="IY0qLiUK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgDTHWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 03:22:53 -0400
Received: from mail-eopbgr1400093.outbound.protection.outlook.com ([40.107.140.93]:21504
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbgDTHWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 03:22:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zl0VuETeCzuoLab9+NwliYUCwUnKhaZr0UdfEn02sD+HL5Ung24rK4yY/kapm1heTby/XMz6cyAKlDHxSNRYmDFUvR54kckOyKB8FCCnI4uU6g8Vw3avncg6H7BOuBI3ZAmstc7uX6QUnstAD55WhUgl2RIdU9pU8B6pGTvflA9nbrkYE92hT9q6DVLozqvYZuU9WOPesRwVxLA6pfSkx1fyDYmP7wTmYg1DOQ8KyoY+azX6NfaWeZp4j7cDL/eEl7I3hillDk7zgFwI/OUMMsDYTqH3G5yhSs6jdgizhE9hBUwE6o/9jsg20Zh4bU8Pn7Aoe6M0LsxEr7AjCivF9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izE7d4ebI8p/AVjlfYCYgAT69TJ4Zqy/IHHlBpf97SQ=;
 b=hLfd0cuhJKROLFVPFKnUSfuGs6CARZiJ7QseCjfR2RydVGV9Fvxppi1mAWZILLV3vVCDrzXrcfQbCdK3Sb7M1AfJ7ew+tbnlyks+mLKmZeo/qesDYYxswFXzujVoA3qu2DQl22IFfqHKa80f1VAQ2NclLEXXqS8ItCDpo96QiP2bRdeqmlTflx5DaJkFiOIIBUOin25tqfDLtRcoMC53bOolfK4o/NBuq46By6CkT1HqLbaj8Pnj99yF/Q1tdfeEplWZ/X9v0Vvunr25F5b+xIfcP5iS8wLZ11O0TmPcXl35CBMInY+Rd05Y5QVBU5g+sPlugRqgDLpK2O//LPJ0hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izE7d4ebI8p/AVjlfYCYgAT69TJ4Zqy/IHHlBpf97SQ=;
 b=IY0qLiUKvftnrZCiK115QcU6KPhWosTtJmW4d+lgIZWX6x2x6PyAw6eeY5B/vm3WJF+ykkp4klXHpg/ZYspxk3whkv18T328u+4GtgH8fScsHfrDSSvEm17tQCzTI0Q84E7YOvo2U/Z7ySApQmqjk8h+l4jqJx57/u09wVO5KN0=
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com (20.179.175.203) by
 TYAPR01MB4686.jpnprd01.prod.outlook.com (20.179.175.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.29; Mon, 20 Apr 2020 07:22:50 +0000
Received: from TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06]) by TYAPR01MB4544.jpnprd01.prod.outlook.com
 ([fe80::ed7f:1268:55a9:fc06%4]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 07:22:49 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Nishad Kamdar <nishadkamdar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Joe Perches <joe@perches.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: renesas_usbhs: Use the correct style for SPDX
 License Identifier
Thread-Topic: [PATCH] usb: renesas_usbhs: Use the correct style for SPDX
 License Identifier
Thread-Index: AQHWFkoR6/STDNNI5kWpjekRx0czv6iBmPrw
Date:   Mon, 20 Apr 2020 07:22:49 +0000
Message-ID: <TYAPR01MB45443DA5ED70B06628785D6AD8D40@TYAPR01MB4544.jpnprd01.prod.outlook.com>
References: <20200419125705.GA5172@nishad>
In-Reply-To: <20200419125705.GA5172@nishad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 02ed71a0-0081-418e-b3f8-08d7e4fba1dc
x-ms-traffictypediagnostic: TYAPR01MB4686:
x-microsoft-antispam-prvs: <TYAPR01MB4686DD824FC2128DF9242CC3D8D40@TYAPR01MB4686.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB4544.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(66556008)(8676002)(66946007)(8936002)(55236004)(71200400001)(66446008)(6506007)(7696005)(81156014)(55016002)(66476007)(9686003)(186003)(4326008)(64756008)(76116006)(4744005)(86362001)(52536014)(966005)(26005)(478600001)(54906003)(110136005)(5660300002)(33656002)(316002)(2906002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7M1pyeoxNZkFETHbJ56/r+e8hZZBT4YWJZnLagVrUIcjQ5vKPn2tCt/+kDYiTlvB2PohKAw2c/IZVN1yz7Ynttp1lXtT1VsoXdq85ZrqjLZScNfuFIoYBLcAfIOjOgGh6fWbynBiTtfbdsUh5NMDr2/XuBeXNidWLbF1MRAb0T+lKYBygQtNxqsryHaayT6G3vT2ZEEq5a2rR3ZkcGNZtph8hNJ2epuDXnfO/0nvUH7UDLul605ogflOdUTb607GW0RMWMQIZO48BzBk8+S4wvgWeUeY3RIL1Q00BYXgZyMLxaWoJFrOTb/TLUkIDzLFsYQ0ikxftFZtaLpDREVf7KFidkQnoADJoed+oR+1hYG98LU0l+OEGlbqB3r26bNK4Ih6frIJgsREFIEy5F6hY+UHW5Mve8EK3MbBQ+MJGqupIGivl7FCdrTjjKtEiSayCJes1rcgMc+dJ/yWFnK42FSHFH7m6ICHVVH7nOPxpZADpDzJX0GMx7EG9uvH3dtphXddCFLZ1TA85x9GnKadRg==
x-ms-exchange-antispam-messagedata: fs1c6KkbTthXAW3bfFy6O5GqGM/4YjHLslry/tg5quAChB9flsGXBj9pTfNs7J5uJkwaJ03QN+hkwbusSBQmt/DN25onoSGwSN9IlHNddwayKkqe3ikg5DwfMHw6SN76jYTK/XzXRHrqd62VvBIEZQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ed71a0-0081-418e-b3f8-08d7e4fba1dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 07:22:49.8235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xYHZVBSH+izLjCm6T0l14i9ZdxG72NnMOJGqy/yvuMnk3GvKyeGneXOZJaJgzeuTC7OC7kJj1mvIhUoF9euzei8eEJaz6tezkrgWcsTl7qkl/q27iM15Tmzc32JStHqv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4686
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishad,

> From: Nishad Kamdar, Sent: Sunday, April 19, 2020 9:57 PM
>=20
> This patch corrects the SPDX License Identifier style in
> header files related to Renesas USBHS Controller Drivers.
> For C header files Documentation/process/license-rules.rst
> mandates C-like comments (opposed to C source files where
> C++ style should be used).
>=20
> Changes made by using a script provided by Joe Perches here:
> https://lkml.org/lkml/2019/2/7/46.
>=20
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>

Thank you for the patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

