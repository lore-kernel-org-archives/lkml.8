Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84C1C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD528206BE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IJFMTCU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgCMNQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:16:39 -0400
Received: from mail-vi1eur05on2048.outbound.protection.outlook.com ([40.107.21.48]:6179
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726426AbgCMNQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 09:16:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yv7EqTxHjSrGW9dSHNAiRSCxl7nCnTt2pgJcBUxpveodZOwbshio132QUTvxqJZRZgV6a0KQiH4di8KK5++yAYFyV+CkTvQP26mmr5LtdctrQlhzpuLSUyK8yNbq1Ovnuwl6Dt/mcqWd8geCRTljA0sxF7yny5kcTWu2SD4bYy+fxxznjgNvbWvvB1cEl5GUh3xfxtSwhVR4lbLbnrsuJ7QvEUrFWt85P1ZLZYXOls1+mVJILvPvlO9onzKUjzyE1CClGxHtTW0vhjRJRqmBdek6b8fLCEIo+0pJTVTDgtCn5BpVWbQfT8IzgNy0cYf2AqzauyvyvQH4e7gyRkmFtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/ef9RpHoZ22bGEIiDnPNxJd59KKYvvWLT3tTMM0peM=;
 b=UcSWtUdFT7Fz+cxIiAtBMP8gVVElSs/hrkilp256M4qjs4mhfAAZVuD4jb3keghMKKZvmaCZQ+E2tS/CGw9czlmmCteSSqeqUP/5qs6LZr4424CDRJ6C5s8R3PIfuHMmxnlRzvaWpCG24GIFdmwql4dpyXUD+UTT9cn8S16WDE6q/Ld3PUyE7Hdj4r0OlIoDyChGseBLkDwdBag19EWz8SVLN0QChPq058WD+VZP6Ecz4lr4+1CA0u3qAsRVEFDsC/EeNCfo1vn/S7ps+hWultb1u/cWJ279wERHzc4UEpVjul3DkeSuvMO1cRQcv6pczbT4c2o37xfPzAl8eKaPaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/ef9RpHoZ22bGEIiDnPNxJd59KKYvvWLT3tTMM0peM=;
 b=IJFMTCU9pirCXPHEyu9XcYYsZAzAhzgqi9ldn3I/LYZXjZOjoeac5AMenNofKW/9WTUCMN0w/GjiQn4ifx0Kvx7U/rEPrCwePlq+f05KQAOyooyCKks2KvT3oVg22PCP8oAJyNn4iMwlUoG7cW+5LUx0M31nB+KVRGNENxQZ0s8=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.51.23) by
 VI1PR04MB4495.eurprd04.prod.outlook.com (20.177.53.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.11; Fri, 13 Mar 2020 13:16:32 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::9547:9dfa:76b8:71b1]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::9547:9dfa:76b8:71b1%7]) with mapi id 15.20.2793.018; Fri, 13 Mar 2020
 13:16:32 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/1] regulator: fixed: add system pm routines for pinctrl
Thread-Topic: [PATCH 1/1] regulator: fixed: add system pm routines for pinctrl
Thread-Index: AQHV+FpZgufkrsn3KkuJmHgdNm1nAKhE1zoAgAAUhICAABsJgIAAB0wAgAABBgCAAMmjgIAAl32AgAAST4A=
Date:   Fri, 13 Mar 2020 13:16:31 +0000
Message-ID: <20200313131635.GA28281@b29397-desktop>
References: <20200312103804.24174-1-peter.chen@nxp.com>
 <20200312114712.GA4038@sirena.org.uk> <20200312130037.GG14625@b29397-desktop>
 <20200312143723.GF4038@sirena.org.uk> <20200312150330.GH14625@b29397-desktop>
 <20200312150710.GG4038@sirena.org.uk> <20200313030851.GI14625@b29397-desktop>
 <20200313121103.GD5528@sirena.org.uk>
In-Reply-To: <20200313121103.GD5528@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6fc34e44-45ee-4557-7b5f-08d7c750bf87
x-ms-traffictypediagnostic: VI1PR04MB4495:|VI1PR04MB4495:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4495F138B29BC6185CC8C0758BFA0@VI1PR04MB4495.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 034119E4F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(199004)(8676002)(71200400001)(91956017)(8936002)(6916009)(76116006)(86362001)(53546011)(81156014)(6506007)(6486002)(6512007)(81166006)(316002)(26005)(186003)(5660300002)(66556008)(66476007)(66946007)(64756008)(66446008)(2906002)(33656002)(4326008)(33716001)(478600001)(44832011)(9686003)(1076003)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4495;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j7UKhki1wOziq9Qj0dzkYlPv5cy8D3O9I6pRCi6GsQVT2pWpq34Ui9UIxRN6Wuhk8zpW58GHMCQQLCsMzTmbzW81LwWg9Y7vNHZBTTnKbbCQ6rl92LauibC0cd3ZXlAPbywtgJ6zcpPh4H1yQ4Xa0egwCMN1NZr/Moqn9OGvpy4ExPu/vXDCd1oAkJJwqSXkfwfNvlAZK1aomHe2Axaaz7iQXD1F5XbbFMghvoVKpZ77F8kkiu9acACJudu7EVdj0WBSzewedYck7vEGIaEtJMd8YJoS4BWjl6LTEjUnxKSZAQTgIwGLgMag7nIEqrteBANI8WpumD1lI1Mrd8uqoz/zU6KlcUAIidfUz9T6i5LdK5nTEYrY7kTlFSsQIfE4Do+zdqD36HZUYO3/FDBilWiqqXX2Sy1ZKtjRsIVSBGr7jt8V1NjgE9I68Bk+3BRq
x-ms-exchange-antispam-messagedata: Xjh3AgRR+6BtFDyT0eTaRPWfBJ7I+3DDQctW88WSx0kv3ZuFlYCsitjxk1Glf+3oTjNsSPmuhTymlXjVArbmU8aa0DIPDue//Koj11djeKzlvI9wPrtoEFRfQLTM4cUMfD230x8lUidvAob5znaYkw==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C3ABE5A5AD6A6647B087BE94FA16DFD9@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc34e44-45ee-4557-7b5f-08d7c750bf87
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2020 13:16:31.9663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vnQxNIESk7X0iXRgi0q+GGqI/SX6iCTPPsXzFUuUNs8TtZezWET8A+r8viqfr8ZOckiyjCTarEqhsdDvOLryEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4495
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-03-13 12:11:03, Mark Brown wrote:
> On Fri, Mar 13, 2020 at 03:08:48AM +0000, Peter Chen wrote:
> > On 20-03-12 15:07:10, Mark Brown wrote:
>=20
> > > I'd expect that this would be handled by the GPIO driver, the user
> > > shouldn't need to care.
>=20
> > GPIO function is just our case for this fixed regulator, other users fo=
r
> > this fixed regulator may set pinctrl as other functions.
>=20
> > Here, it is just save and restore pinctrl value for fixed regulator
> > driver, not related to GPIO.
>=20
> My point is that the fixed regulator doesn't have pins in pinctrl,
> whatever is providing the control signal to the fixed voltage regulator
> (if there is one) does.  I'd expect this to be being handled on the
> producer side rather than the consumer.

I am sorry I have different points.

Most of pins for controlling fixed regulator on or off is GPIO, but how
GPIO driver handles this? We usually configure pin as GPIO function at
its user's node (Eg, reset pin for most drivers), but not GPIO node,
GPIO node is usually per SoC, not per board level.

So, I am wondering why fixed regulator can't have a pin in pinctrl.
If you grep the dts, there are already several fixed regulator has
pinctrl.

--=20

Thanks,
Peter Chen=
