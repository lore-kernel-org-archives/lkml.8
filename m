Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6388BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4259920786
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="roh64oPA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgHQNos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 09:44:48 -0400
Received: from mail-vi1eur05on2049.outbound.protection.outlook.com ([40.107.21.49]:47670
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728588AbgHQNoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 09:44:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebrYNN5NNAVzn3Apk9BswLV50smSxovJQcwOlQmh82rnE8RN2BmK+cbdg0OhY3/WvpZZVtF6xBihvjv+5Li5F/QST3iZKW4mdb3fqYdyzLf3OrPOZuN7U/gp6X0CCasYXnnu/IZYtGNGUvoP6C7i+2FdzsQSWOiunQLjzjVdXFN2JHkFr4/Ko11iOd2MrSi0bqC+P5UM16RZ2DlCZ9S6VmCGcAXAhzGmZUG8upAkN2KlNJkyfm9DUdnBNwhbnWDg+eT5qwH4vwbMz7kRVUpS6IJ+pmZULW5F7slFiHrqECmItb3FVJUiy5w6FeKq50/f7uN9Yf0GGvYWxv+HgPkPUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWTGhFA9DJ+idcpI4wdhpwqIvT/5X6BPJEodIHsPS2M=;
 b=B0U/Q3F/wspvpgHk+eO5Ym/pfzFV2aNBOLRg8IWzKJ447rLfFReB9JFvGcEtswUtH34NenU8N0O3yLVFCh9Nacfiz7gQILE7s9/2q2Wjkie9vVRKxoFPD/wWiMPTDwu1cmTVuWp2Rp31PNY6lmx3PryZctcF8Mwxi/7TSVqsZGWRM5geutp83zJLcpQ46P8QqbJVcrd/LQpRVdjltwwYjAL0eBkxJCFeC5o7B/WgFXxufcCHZo0Df+1GcxSGHnG4FpxQ78sKUBavB+ZZ4czOdbq5nRdxI8GwVgMKY9/7w7Zg8aotUPI/of4ZMh0dQ/OsjpJkqQpWPVCP5QHxIGcYXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWTGhFA9DJ+idcpI4wdhpwqIvT/5X6BPJEodIHsPS2M=;
 b=roh64oPASeLh2ZnkHOZC6u8Qtsd2UHQy5bK/sHA6+Aq9QVaAQL7mq8mfNFzsydUpiqPYYvDhk3XIxGsIeD6qdzwWFPgvAZXnhF+voD1yLKClf+8XBIOZSdKfqEhxT7xcrtbOCX0pLb2ABi64aDL5GVMMq7MWjge0GfcBAREaHkc=
Received: from VI1PR0402MB3342.eurprd04.prod.outlook.com
 (2603:10a6:803:11::14) by VI1PR04MB4174.eurprd04.prod.outlook.com
 (2603:10a6:803:3d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Mon, 17 Aug
 2020 13:44:42 +0000
Received: from VI1PR0402MB3342.eurprd04.prod.outlook.com
 ([fe80::c1a:39dd:a2d5:3d2f]) by VI1PR0402MB3342.eurprd04.prod.outlook.com
 ([fe80::c1a:39dd:a2d5:3d2f%7]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 13:44:42 +0000
From:   "S.j. Wang" <shengjiu.wang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: dts: imx7d-sdb: Add notes for audio sound card
Thread-Topic: [PATCH] ARM: dts: imx7d-sdb: Add notes for audio sound card
Thread-Index: AdZ0nG79T94FsqlQSjOjVmae9L0DEA==
Date:   Mon, 17 Aug 2020 13:44:41 +0000
Message-ID: <VI1PR0402MB3342CA1812DF86434FABE918E35F0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0b581c09-6b0e-440c-c679-08d842b3b1ba
x-ms-traffictypediagnostic: VI1PR04MB4174:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB417456C0BDCF55211FAC05ABE35F0@VI1PR04MB4174.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3od7XLFWfx0ygVS0UezRVQvxrpqdWOXh8vX/DkCfTu92/utqTLBLesUMOweacHloAkHaSUCoetp+mfOfRAoIIoAzYa7N9sGCycQjMNSf3KennDyPQAe0ckDpCEaFGvFtT3HXwvO+Q4BmbGzZtIoWrFncA7LObN4KuMwJScrCwCBEoJJUv2gZi3EYHPSEGKqTd3ceBplrXkZhpoR4R/B/LXI2QZ8KqLG8Em33xajnaIZTYS2UJR4AUU2g8qlWsOKORa70CAH8BDTPVnQySAuTcyJYXKiZdmMO0IdePsiMvNsY9RGb8IX2sNDeZqIslOoQ0fQDgE8hr61q9kzhu2iwrg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3342.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(186003)(33656002)(26005)(76116006)(52536014)(2906002)(6506007)(71200400001)(478600001)(4326008)(54906003)(83380400001)(8676002)(558084003)(55016002)(6916009)(9686003)(86362001)(7696005)(66946007)(66476007)(64756008)(66446008)(66556008)(5660300002)(316002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: brj1bJUqgSLp63k9jH5Uk/wP91ipsl22aVdJCQ3fkh5kE7wePefcXTpZmNVES8F+u5ASsAMKIXXWUXd1oGBkJlWxYuNNZyssxIO85EWrZC8Fizr8XeiZjjTvTezZ/vybX9sLbrPIrR9kVFEyGQr+IsLtlzSFG2sAVvbkBRKu0I+pepsH23ELlZo6M8T4JYM2vpCVBYUWrSuR5nrzUDOKoX4Aknzgl4z+oMXv7mkHOOZonXAGNpjM4/6bAqhy0iec3nrAuo/CLvGnojAFZOSjib6Bk9+jG63IRPArvjl1sEIo6ht8u9DYZ739EfBpNfWyTu9G0Aw8sek/1IiYVCI2ThOrN6H0MCcJpHsAMCg+GHuCTeEGMHTGx/eXYK/Or4Lt4qRFbvDEHrJNwhXHvcKdNhx9Dm3Y785sQjty+5I+DGE7XSKV9Jv2a1lABPbYhKiMeli6DrW8LnfH8rk36bsCGn8A4OA8QN9YsrpPZCBhmNa/PZKNa3rwz9iLkJSCSuGF6qbUV9kIRKqRQozrNmf9UQr99AFDYqXtkV27CZ1abMJY3KKHvzOAzuvczTKTE+eqflKY11pmGKOQdxZG4yf4LisQuzRnpe0DzIfQChwXvelcdIVI34/tJgsu6LYwip1YKEhKzaKrhP67zLjxDkpm4A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3342.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b581c09-6b0e-440c-c679-08d842b3b1ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2020 13:44:41.9313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C9xwmXyQzhShOyf7E7NqvtyMGg+rJBC43tOwD8a15kMUrwc3GQFhd0EwkmXZW/3SAHOTU75/2BbwTlkYwDGslQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > Configure the SAI device node, configure audio clock and pinctrl.
> >
> > Enable the audio sound card, which use the SAI1 and wm8960, and enable
> > headphone detection.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
>=20
> s/notes/nodes in subject?

Yes.  Thanks for fixing it.

Best regards
Wang shengjiu
