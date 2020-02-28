Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF42C3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB1ED2467B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="foDq4EQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgB1QyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:54:08 -0500
Received: from mail-am6eur05on2119.outbound.protection.outlook.com ([40.107.22.119]:45504
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725876AbgB1QyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:54:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3YjzOR5Q4INYx6cPpUt2hYc653bHzWJy6SERWNov/5M4HAa34zMZs2+u8MDk2Gdt+oIqV2Ne8WNVCIowg8OQLtb4nxkV8Q/7kLbvRiuVmK04yuKy4PTVv6porkV4Ot3m9/mrKmidKShPneqpXSEZFKuTA72WECpoTzrt3F6LsfJ1/Uq7wolc3qr7stlWjiz6kENepaw3cuP0RPKvP/NWaG/RFwaJ5oXGiOgXsrrXbii2CnbjYpAr8BQYO62FbXIaSbDsgtj3CKmD6S3/UGbwdE61bvIP+wh9Ooy7kgn4Bo+5Vo/Yn/QUC4Pvlhqd25RXULsflPiADMjOU9RpGvXPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zm2Bt4HY0tGEGNq2Zl4Eg8vnRPkwX8HI7/6pzyn070I=;
 b=IfvMBNFkiTVOpi0TAuXQo6peXO24F7TDtV8mPudk04M4ycoWr86dS8v7uDPCjpNftMMjbx+70z9dbMD9MZW+2OL6HZWMVjjVr/NhnLCrpVvbnWm8Y9SGfWn/vglTk2rX8p5TM3WhXttK6L6jmkB8PJFciZnp4YDESf+t8PTVObzEyrWFJxAlwAZ6k8zlGBAhBqj4hNLHCdicj2IQ4bmUJCc/aUO+QJ9NclwEW4X0IBP1QFkDXY2Itw5dy39gX2jZZ2ZZkgunq3XdxNjwG9lmIh27wf1+npDZ5aIa903MHKtRDMsR/9fPh0RzUvc6Bua3GqlN8HgGFnNhMTdg4wB8xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zm2Bt4HY0tGEGNq2Zl4Eg8vnRPkwX8HI7/6pzyn070I=;
 b=foDq4EQ6kRCp0+aKVKw+T16O4u8U/3uJyK9QSd47ODMekZWgHAmduiS11VJYsPz21bbXKodcpzOQF1vF6QahjgAnTY2qHfsE9ORs+k77zTh/fJC8Xz8PM2Q9tjDSzQp4poIviY1NI5jXLf+qxxom8BlRKlIg0GnQmZuJvzHFKqU=
Received: from VI1PR05MB6845.eurprd05.prod.outlook.com (10.186.163.80) by
 VI1PR05MB6654.eurprd05.prod.outlook.com (10.141.128.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Fri, 28 Feb 2020 16:54:04 +0000
Received: from VI1PR05MB6845.eurprd05.prod.outlook.com
 ([fe80::c13:1d07:fa02:6eeb]) by VI1PR05MB6845.eurprd05.prod.outlook.com
 ([fe80::c13:1d07:fa02:6eeb%7]) with mapi id 15.20.2772.018; Fri, 28 Feb 2020
 16:54:04 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "igor.opaniuk@gmail.com" <igor.opaniuk@gmail.com>
CC:     Max Krummenacher <max.krummenacher@toradex.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Igor Opanyuk <igor.opanyuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Stefan Agner <stefan.agner@toradex.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 4/5] arm: dts: vf: toradex: re-license GPL-2.0+ to
 GPL-2.0
Thread-Topic: [PATCH v1 4/5] arm: dts: vf: toradex: re-license GPL-2.0+ to
 GPL-2.0
Thread-Index: AQHV6zhuycY8bEapckKLdhHNGMkfl6gw2OwA
Date:   Fri, 28 Feb 2020 16:54:04 +0000
Message-ID: <5f38ae95378debf708924392c88a7723c1e702c4.camel@toradex.com>
References: <1582565548-20627-1-git-send-email-igor.opaniuk@gmail.com>
         <1582565548-20627-4-git-send-email-igor.opaniuk@gmail.com>
In-Reply-To: <1582565548-20627-4-git-send-email-igor.opaniuk@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [81.221.74.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4098016-0e53-4704-afb2-08d7bc6ed1b9
x-ms-traffictypediagnostic: VI1PR05MB6654:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB6654D8C4ECE039A2C0533A42FBE80@VI1PR05MB6654.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0327618309
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39850400004)(396003)(346002)(376002)(136003)(199004)(189003)(91956017)(6512007)(26005)(8936002)(81156014)(186003)(4326008)(81166006)(6486002)(4744005)(86362001)(8676002)(66556008)(64756008)(44832011)(66946007)(54906003)(36756003)(6506007)(71200400001)(76116006)(316002)(66446008)(7416002)(2906002)(478600001)(5660300002)(110136005)(2616005)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB6654;H:VI1PR05MB6845.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e3cOF+XQ4wv7tnNlotAWX+Iug8xQQc/B4vvqALdgtmouaDC5kTwhXUyD037vG7M/oi8n3cZ6KfdMhinRrs2f/825aDroNawkZAgUWMoZj8KsXl2wC6tNaAoQ/1hW5b8M0PecQqcFTM9fqQ/qhx6enc/q6EsLDiNrXTAgAgc5/Q/QpDnrzRwmsLm8RMHIGA0CwcRHjpUaraPr+lh0D8S+krrD8E9e36eghn6M1y+QGEAXJqYYiaB3Z249e5GKYGb4Le2U8MbMHq5Z+/jE+d4uF2Jx0VlspnqICYDm2C6pjSvdGctXJzp76FzmOsO0jH7cFeDULFxWUC35G08FLAf+/iApJkxHh/jY4OG44x+OmcNkqatC88zz5zoEvnLD9t/wU77oAmNO295oelEu38ces9wQYmySqbzAqdUrOEH6t+ULp3r3lwKnsKAilbhpZJk4
x-ms-exchange-antispam-messagedata: DIL6gTBQPwsuym67LPqjSCmmaeRiH0QEFTvS9zgrAG94gDeyPQyggyErgyu4rupcDXkflwTnD3G4lXJl4yV6XEjb00EYPs25IUyADIaTRZj1W57ttxAdvNZzd+9z1k2uQddP1490zsVkjqBIcMR5vg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0B09B358ECF314782B19FAEAF1037AD@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4098016-0e53-4704-afb2-08d7bc6ed1b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2020 16:54:04.5981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vs+v5shEPHo4K3FqyA0o1OcNYpGQg/RtkZRTu5JEMoqEeE3DH6EgS/mdYp/WWEclNDUPrrXWusKT1cMtibzdadGCTm9DcTDxCplb/4K6da8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6654
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSWdvcg0KDQpPbiBNb24sIDIwMjAtMDItMjQgYXQgMTk6MzIgKzAyMDAsIElnb3IgT3Bhbml1
ayB3cm90ZToNCj4gRnJvbTogSWdvciBPcGFuaXVrIDxpZ29yLm9wYW5pdWtAdG9yYWRleC5jb20+
DQo+IA0KPiBTcGVjaWZ5IGV4cGxpY2l0bHkgdGhhdCBHUEwtMi4wIGxpY2Vuc2UgY2FuIGJlIHVz
ZWQgYW5kIG5vdA0KPiBHUEwtMi4wKyAod2hpY2ggYWxzbyBpbmNsdWRlcyBuZXh0IGxlc3MgcGVy
bWlzc2l2ZSB2ZXJzaW9ucyBvZiBHUEwpDQo+IGluIFRvcmFkZXggaS5NWDctYmFzZWQgU29NIGRl
dmljZSB0cmVlcy4NCg0KTkFLLCBwbGVhc2UgZHJvcCB0aGlzIG9uZS4gRHVlIHRvIGR1YWwgbGlj
ZW5zaW5nIHBlcm1pc3NpdmVuZXNzIG9mIEdQTA0KcmVhbGx5IHNob3VsZCBub3QgbWF0dGVyLg0K
DQpUaGFua3MhDQoNCkNoZWVycw0KDQpNYXJjZWwNCg==
