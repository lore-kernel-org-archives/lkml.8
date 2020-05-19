Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B4AC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 01:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE78420758
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 01:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tECEhEON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgESB4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 21:56:00 -0400
Received: from mail-vi1eur05on2041.outbound.protection.outlook.com ([40.107.21.41]:6069
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726285AbgESBz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 21:55:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HaWcu8qh8TDZPQK7yvGUlf7FJb7N4oW1SpOp0xv9i6fwLHYXt45PLveQw84WclkV9sbERQy978kod5thPvQ+KXutlGPczmqkTsPL/kZ44VkSmeyDwMNiZveuzyK+xvwTAAfTWMn+oCwCk7xKqtCaRdIEx2GZtVP/HrFkPuDRGtWHo6vMPfBJ4nA1QEYJ0+KO6onb5NGYedokSGT/gD01EdcAfA4DcwR5u6zOeaAP4FUzhnISYBoEBWe7I6ivg+84nDBlG8XFrIksF5bJ9aVi2SzGEtQmZFYMJjlxVbOsirizeptFZ/B2bqjZv2sAALPq8/HwHVuy7VItLG56l8lePw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K281OByOC9Veu/4xwl1A7anoWAjqEa9JL+WyRXRpSWk=;
 b=Cq15UIm5A9XppM/f8COO5y5T8ToNgrdpgBAb3S2HpgKOFPnthODwP5+crjJ9E3bJCB/NwXWynl8ohKnD0zrJ9ehXl1hrIapTxVNoKx1bjRZtwB5ywyX8+ClwkT/jpujK/xbDd8+B1jseiyovWMzQVwXa4rcCDV87BgnBTBWP4L8lS3+CQrgLwN92GtZMVBOY+oN2iXrNKwpChdwlKhN6IYQnSOpE6OI6PJ8djG9SSGeYbt6tuYlAHFqXBfCGrAQgi2BzkP6R6xOYoPs7Bu5C0U/vZePRC+ZIs9FcGKysSn6LWLmhWRrSaOhUZLMOqOnEn6UxY8Qtpwfmi3a5bWpYKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K281OByOC9Veu/4xwl1A7anoWAjqEa9JL+WyRXRpSWk=;
 b=tECEhEONzXKwhNHDoygDzhdLFoNfMRqCakV4/0kmJ3Fbq67H1vOm38NlvFmKm5+lesQ6B7X3x+7/+Ahhja6jZdfaGvEzKLj+pjbkFvCDrk0m4Fwfw8iyeRFXScuutDw81IecHepDRwMYZV1RNOiT37wgK+VHGB1fNJU+sOCbG7g=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB6486.eurprd04.prod.outlook.com (2603:10a6:20b:f9::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Tue, 19 May
 2020 01:55:54 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 01:55:54 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/2] ARM: dts: imx50: Add src node interrupt
Thread-Topic: [PATCH 1/2] ARM: dts: imx50: Add src node interrupt
Thread-Index: AQHWLRTOXDDXY0JHIU2iJhxYM5fKLqiupvBg
Date:   Tue, 19 May 2020 01:55:54 +0000
Message-ID: <AM6PR04MB496622E779B65E16CCB7108080B90@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1589806460-19592-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1589806460-19592-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 54f3d9d6-b0bd-4613-bcb2-08d7fb97c437
x-ms-traffictypediagnostic: AM6PR04MB6486:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB6486D444179049D0ABDF5F6580B90@AM6PR04MB6486.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BE4y7F4nhe5fI9CSiHV9EJmJB7E37dM6SsQU1ATBm/nzvoteLH+TNOR99qIUloVLzf0eBSbhF0Y0Jtj+od4A7eFcvivx1fD+kmFI62GGugsxzrhPAFERaKAEEDoYNKfrpRTOAet3jD5iwzJn1GJ1Ylysscr4Rf0c6RWgB88k1nto/z1J1nBtoMXmEa1TEQcycGNuYBM146epTV2NE7+iSBtEeyiMqZX9yRgbh2dEesiROn53tx84qsXPthbYHzV7rEyOFg7eud6o6vVYiVt08cpMJWKfunY3Uo+aiQxStdrr6I95tFK+bpNNWXSZEsxwMqF3+NZ4GGV0qsSpHwEpgHuyyhtfxoHgBnxkq/t/FDcO3kSq8ZzPRQHLE8018adDtWlfKsGADYwketDFKV2IAchW95dyFD3SfbIUvBs90mGgvqBwX4oqTEAEJZbfyDEn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(2906002)(478600001)(71200400001)(110136005)(7696005)(86362001)(9686003)(5660300002)(186003)(8676002)(52536014)(76116006)(8936002)(66446008)(66476007)(66556008)(64756008)(44832011)(66946007)(26005)(55016002)(33656002)(316002)(558084003)(4326008)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 79YjQk6FN8M11zQEA8eEBoRhX5EYGf65mCTkS8woIJ1GDNEXA0PPauQydcNp1zhsz9GppccZDeyh0JjgNU9MOOZ9Tj7/IMehfYgySAVs/ehLf/nEDD25zE6PlyrcNaCnpPxsWtBvhW+ECOsnAErYxF9eNmhOXbe6k1qBCyrYZSS2Ci9J0MvGDedbldbv9K0J7fQMxceHR+3HtqrpRLHwycSgGvx67xJsNz8je0YiXT8RdDoYUOFhRHOLqWjTyhM2a8bRkgt+SOMg6W8j2UXSsSdQJhlWhHB54yLyn6LvRIn9dNbiYp9WLLgXsrtwlgVnMhcupx2hSRORkyHRdn1boDTcFKKa691klMkQDdIwzWUZzsWEXeyc5FhUtnQMih+qYPtt2im4/q7RN+WbJbstxqJSko09dXFZYKByZ3mM3HN/GeNvLKdG/93cNYrZG6hoW6EFM1KAbVjXbcXb7LEAsJ7kb4j1NnBLB0Usz8EgRWrKNNRkcric8E1BFsdhz600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f3d9d6-b0bd-4613-bcb2-08d7fb97c437
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 01:55:54.5745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6INB3qPvSknzq1sJnJxEAScelhiEeOdCBZR2anACnuq7heZ1cPCBc94Jog4uOg97iLa9AtM/95Z2jkM4UoCIMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6486
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gU2VudDogTW9uZGF5
LCBNYXkgMTgsIDIwMjAgODo1NCBQTQ0KPiANCj4gSW50ZXJydXB0IGlzIGEgcmVxdWlyZWQgcHJv
cGVydHkgYWNjb3JkaW5nIHRvIFNSQyBiaW5kaW5nLCBhZGQgaXQgZm9yIFNSQyBub2RlLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQoNClJl
dmlld2VkLWJ5OiBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KDQpSZWdhcmRz
DQpBaXNoZW5nDQo=
