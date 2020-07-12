Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9BAC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 09:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DD2920720
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 09:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hL69e+GE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgGLJYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 05:24:33 -0400
Received: from mail-eopbgr70075.outbound.protection.outlook.com ([40.107.7.75]:24259
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728112AbgGLJYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 05:24:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4wwj99iqqqQ0AILVmFQZ9QBeTeUpnyit2nw8r8XLnKyQuMyWiIxNa0tiylMzcs8tD2BQMXP0B+5mTQ4EKKlXRbdyusl2UafPeCNhBH4nOzsNo2DI+3xKHK644MVICIErG/poAC9tcJEvDb0Z7R9JChtZyUde08kSQzr1hJ8f6C0LbojpyN+0OntgBw1LpmZ/ecn9Bk5/yzLJlkLxt/WyDAnef5wVdvbNmCvFzv6pEIN5S+toXhkIv5QCgoyWEWtkryePrFcKLVsFqAFvlP6YXibXH1YoDr3yfJwZkXLZG5+jFDku/fcvk0Xb+4M9E3a20Zhent+0UyZhiY+cQ2jJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QVDKfaLBLkUJEyDULJo/z0AoStod0OTxVrfGw6wWSM=;
 b=YQSak/jeUE57Ez9tBqxAJzJqmFIlfA1F5EO60gIthsjiITgr6u4F9kLjUQNiJF1QNDL/xN/fs9e6BsvFN+7GO8xj3No+nR9gMoYMGcVyLniQHaHZc8XVz11upN1cS1ztKvV3ynEY5aIH7bT60PMzcrZhlWL0wvI0Pb8bix7pdTjR4DUpEAsBq3Xg2bpsaudmurgOBiPL5Zw35KwDCWa4YARCVGd39OVyvu3fD8I7d4AMZCm1Mv8JohIpdijMLHp3OkpmKbNjUStoJVud4ZbYlX4igsogaWgwoKEWD7hM8Klq2fLKnp43R9XwXlyDSVcx258+T563otBNOj13GWmPtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QVDKfaLBLkUJEyDULJo/z0AoStod0OTxVrfGw6wWSM=;
 b=hL69e+GEcK2PQdnjhlhFH5Nqo3Bc+pKthTaVsoBewasSrPq7L6gY5QIPJOH6D+wWu76sVegdXD7AYPyr40N8kKGnCLZiR6OJopN0eto4iVqf5oUnqo5ZDXuTZBD8GYX2SdG8uD9rvaei8CpXnwnC6Z7RKA1fLR/xJGJ0zcoY5OY=
Received: from VI1PR0402MB3342.eurprd04.prod.outlook.com
 (2603:10a6:803:11::14) by VI1PR04MB5775.eurprd04.prod.outlook.com
 (2603:10a6:803:e2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Sun, 12 Jul
 2020 09:24:28 +0000
Received: from VI1PR0402MB3342.eurprd04.prod.outlook.com
 ([fe80::a16d:a719:a6f0:ee54]) by VI1PR0402MB3342.eurprd04.prod.outlook.com
 ([fe80::a16d:a719:a6f0:ee54%4]) with mapi id 15.20.3174.025; Sun, 12 Jul 2020
 09:24:27 +0000
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
Subject: Re: [PATCH 0/5] Add audio support for imx6sx platform
Thread-Topic: [PATCH 0/5] Add audio support for imx6sx platform
Thread-Index: AdZYLh0rkUIBG0AbTqK726TszQ9a3w==
Date:   Sun, 12 Jul 2020 09:24:27 +0000
Message-ID: <VI1PR0402MB3342B91438645DD0BE80E6C7E3630@VI1PR0402MB3342.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fe90286d-75f5-4e6b-3323-08d82645600e
x-ms-traffictypediagnostic: VI1PR04MB5775:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB577561EED71EFF992070CBBCE3630@VI1PR04MB5775.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1GqncsyWf3OtXpoie4p9Ex0llQSpW0V44AzWsHw4J6Rb+dDVIT/6SkVoanQ11USD4Svmnr657DSeVdarUMcRhUSSiF7x4KXITVFaX2QFljioDFpnDxQlGrrmhugGNvWJInsQdh4mqMKf92/g2vQxnF7tXX7tJLtC6cFoxzg6q1WOC6TAYJ4MuNbGjBMPrGVJA11ls+9vcJFLv3jYSxFo+dB1s7KMRFfOYzID8NXeJi30z2iz2gsyaDLoGGpX6MmZvPlVBxAVL8o+AzvYGLYmIl+WwbP4N0W5dUrJB9WzOlg1aEONSQqAtOLgZJ4h7JBgxPvVOLBl1PbnESebvscoE2OP18N1bhqYjinzS49TZVv1WA4XspmzL7XAK+Mmo+N0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3342.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39850400004)(366004)(396003)(346002)(136003)(54906003)(6916009)(86362001)(33656002)(8676002)(52536014)(55016002)(26005)(316002)(8936002)(4326008)(186003)(478600001)(66556008)(64756008)(66446008)(71200400001)(4744005)(66946007)(66476007)(7696005)(6506007)(9686003)(5660300002)(76116006)(2906002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: pOdf0pFpliAVRbGS2SVMvB8vKoar8CN5ociP3EdlI/wtAz/D+1yAGSA61GAWCLywNa2L/OeO5cknmWeuIwOgKtbRwplXtanxgiqSJBajLnKzfpiXEYanpIi2O/tb8TH+ijBCvU9MaW2X+lY8OQDP7BaQge5SWYhlwq47hv4wVFIQiUXSg8Ac7AE/4GnOFeRFy12CMuq5IS4PMjCidb9Cu/aBQV6yqK3OOnYKahsZ1NPo2JK79PygDizeSwZbFk0Pj6GxvFU5mQV7OIrNcwjTE3MfhZlDHPKBbYyCAlFri7ZzjZBRj3/dfDOGk3YmzmM4tpWRL9CvgiUwaHMzxQi9NhkdBkZY9g2JksVtaH6pl3lURuLxUcj5anhtHiHF04TzKJ1NBSLR6oFTE6T3t63U5bfhiERDTvgJT9UwAqv64QDVdjIaCCwJJbsIIJYHb/zC6BlW6SrLgXgKRS/uV5nNAcXR7mSkc7BJXecxnEWG6qk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3342.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe90286d-75f5-4e6b-3323-08d82645600e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2020 09:24:27.6736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ql3GC62wYzf1N7LSaxnmxsRSeC3tqjVtuFHX5WkPKSMFvAq/+dAD6w2MPHU0agjv9jqlGmXPbREuGFNkRZvVsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5775
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

>=20
> On Thu, Jun 18, 2020 at 02:03:44PM +0800, Shengjiu Wang wrote:
> > Add audio support for imx6sx platform.
> > Enable ASRC, ESAI, SPDIF, MQS.
> >
> > Shengjiu Wang (5):
> >   ARM: dts: imx6sx: Enable ASRC device
> >   ARM: dts: imx6sx-sdb: Add MQS support
>=20
> Applied the series, except this one which doesn't apply to my branch.

Thanks. I have resolved the conflict and resent this commit.

[RESEND PATCH] ARM: dts: imx6sx-sdb: Add MQS support

Best regards
Wang shengjiu

