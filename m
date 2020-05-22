Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FCDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 02:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA774207F7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 02:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KN5yg70M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgEVC05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 22:26:57 -0400
Received: from mail-db8eur05on2076.outbound.protection.outlook.com ([40.107.20.76]:60993
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727080AbgEVC04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 22:26:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jusOtUTWZ3QJXbRBH/PnDD3BjZQgDuGHzPIu+v6JNgCFavRYSpQm2tbtw2QUDz7pEHU3f/2trf+f/yUTnluthvHhUwjdCctYZyip/0tXSLpvnyQ12azMYvlFMgs46SO5rXEigSQR/YiuRkiPElDgXOJue+BLCz/BvQ0irVm61s7c12bpEZxx8QvI1IEo1b+EZyWY26u8+hY0s9PNolHspibloglYjuv41kqKPbzzZfihitbc5aWE5gEc17tZXHxsGrUlglDrckm2CiMhOzyiRLsWAJRyqIBWeHu0z1IPitKBCYqb/eLoOf1NkA0yay8HHahvuOIoK4NvardwB36tmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTBg3aDNI0TSldielWxWe9MzhxO6B0rW5MAUcitFCKo=;
 b=cS7/ZDSmKNtanVVE9u7zPqz1T3A/93rEUmcc6XCwqNMxRrZBTBRDCelWiYinzCok9vZt0SspSfePOTvFdOqwu8JWEuRxl8iThuxtoAjHyQJ1efCABA5WsmW1FRHr76KLrB/bt/BCvgS2VRBPffQ6cPkUv0Uqw+VdrCpJLDHHp7gLUo7Pcj5FI97nwDaA4ngWIupjFT28o9sbLjOymUdSHDJY/ttiulBXmk+VzEuQGPh8bBZP/qYKKns24fwoxzw9WRlQqTgAeLYyrhkn/erxkLIsR5jgk1oSRwPIrChANT68AG6iGU4e0A9PrH5zD2DHAiVpj6QP3hAPA/Vb/XbD/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTBg3aDNI0TSldielWxWe9MzhxO6B0rW5MAUcitFCKo=;
 b=KN5yg70M9UnEflU8AfdQTBnZHmpQfvNaDCbJKwSeKknpZ8uImx+tUzXEb7ZztNozk/0hllMYgGNjJkL+q7K7mRwfTw+eLG5hhloq/uVRrJJuMa7I3e1YgpBg1V5dryu8VwY0ZoUfkGWacFcLiV8y6SeR+px7yuHjAtpT0SNj9OY=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VE1PR04MB6493.eurprd04.prod.outlook.com (2603:10a6:803:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Fri, 22 May
 2020 02:26:53 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::5cc4:23a5:ca17:da7d%6]) with mapi id 15.20.3021.020; Fri, 22 May 2020
 02:26:52 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v2 2/2] arm64: dts: imx8mn-ddr4-evk: correct ldo1/ldo2
 voltage range
Thread-Topic: [PATCH v2 2/2] arm64: dts: imx8mn-ddr4-evk: correct ldo1/ldo2
 voltage range
Thread-Index: AQHWLzeGwEoS7avMqUe1/PurAPoV06izVHOAgAANc/A=
Date:   Fri, 22 May 2020 02:26:52 +0000
Message-ID: <VE1PR04MB66388D5243509C8EBF4DE9EB89B40@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1590070674-23027-1-git-send-email-yibin.gong@nxp.com>
 <1590070674-23027-2-git-send-email-yibin.gong@nxp.com>
 <CAOMZO5AsCREw1OT5zzFH+pC6uyw+MOSKJFZ3_-HvDva65A2cKQ@mail.gmail.com>
In-Reply-To: <CAOMZO5AsCREw1OT5zzFH+pC6uyw+MOSKJFZ3_-HvDva65A2cKQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fb35a2d2-ee19-4e85-65e3-08d7fdf79717
x-ms-traffictypediagnostic: VE1PR04MB6493:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB6493257F8CDB03F4A73C686389B40@VE1PR04MB6493.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9/vZ6cvNJi4aZKN4LDFvXl9QvBhYVGj5R45InKqe8xFVQkx92lRbvYyRaSnkl1PAGYKOb8mvPuV0C3w1kPWf8fEfGf8kiJOm7+550hibwck1yGb63/3F7b6JXPOkSiUztgOy3txpr92MmJIAQhL8L7JR1CNgdW5/NPdfvZWCtTod8jjZfUxte3ot/aKKvPvvLRMhTVuckTBkmtxcESJ5OzzrWcvwIxPuGHCKLS4aFdqy5d6pff8lka+BaCYg9YSMOnUgf5ZRAqjJborTa8Dhvv4xlGx8r+AFEYa2Knoi/GRqJtyjnJxALfXjfNWVfTFEBWaHB2nFE2qxqZl7Yv0Fph2VRSGgtK/ASpoiinq7tWStZ1Fd6vBcEe4RR4b4FsI8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(53546011)(86362001)(4326008)(6916009)(8676002)(8936002)(478600001)(186003)(26005)(6506007)(54906003)(33656002)(55016002)(9686003)(2906002)(316002)(52536014)(5660300002)(7696005)(4744005)(66446008)(66556008)(71200400001)(66946007)(76116006)(66476007)(64756008)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: WYQtOONKgXBSLaWBXRNSKPEdEFaF9Xm/nFMpukHCLO3PB2mcPRNl01rvpbjxp0CnR+m2CNb3GHIlmTdW0xZ0tIdEu7XdBRJByQRq7R1JgLOgjONNzXX6Xsmecs3oEqF+y29Li/I72utfh0E1CcCH8WzIW7Rmi8YFCasjhxe9Q3T7QaAOli4Wcyx9o/97Phny3Xn1FXa48sc4LWnHeoJiJeqVY7JfSc1HWELdBmQXnRfxWx9mPlg3L/8+D86jyNvIcSRx1pbLTsXs+15hBSYFpLwnY8jrInvaLMG0/sHM1q+uUAeEXfPvr+YogahWFsM1wAuVPalaR7RMQAb8vVzCQa8lCZKSJPQyazs2jC0HnIlpJKOzsIuYleRH0QqIKKReRrN5w2mXKajBJTnx5KB9AudXOiRz7zSsezrF1hbDNU3Oll4v9++Cj6BnWJtvNPDnB8X3quglt4zK+vo14bJ5KufiKrvHGzb+AQCu0RI2zgo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb35a2d2-ee19-4e85-65e3-08d7fdf79717
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 02:26:52.8587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: paRbwBOgiqHZ9ulUj4ryT6eZd1/+pj3ZhyyoGYBhFBvtaAIWyLIxcyTEsMCf/HQWdBXOKNBW+78AwCPzVgf7zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6493
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMC8wNS8yMiBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+IHdyb3RlOg0K
PiBIaSBSb2JpbiwNCj4gDQo+IE9uIFRodSwgTWF5IDIxLCAyMDIwIGF0IDM6MTcgQU0gUm9iaW4g
R29uZyA8eWliaW4uZ29uZ0BueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+IENvcnJlY3QgbGRvMSB2
b2x0YWdlIHJhbmdlIGZyb20gd3JvbmcgaGlnaCBncm91cCgzLjB2fjMuM3YpIHRvIGxvdw0KPiA+
IGdyb3VwDQo+IA0KPiBQbGVhc2UgdXNlIGNhcGl0YWwgbGV0dGVyIFYgZm9yIFZvbHQuDQo+IA0K
PiA+ICgxLjZ2fjEuOXYpIGJlY2F1c2UgdGhlIGxkbzEgc2hvdWxkIGJlIDEuOHYuIEFjdHVhbGx5
LCB0d28gdm9sdGFnZQ0KPiA+IGdyb3VwcyBoYXZlIGJlZW4gc3VwcG9ydGVkIGF0IGJkNzE4eDct
cmVndWxhdG9yIGRyaXZlciwgaGVuY2UsIGp1c3QNCj4gPiBjb3JycmVjdCB0aGUgdm9sdGFnZSBy
YW5nZSB0byAxLjZ2fjMuM3YuIEZvciBsZG8yQDAuOHYsIGNvcnJlY3Qgdm9sdGFnZSByYW5nZQ0K
PiB0b28uDQo+ID4gT3RoZXJ3aXNlLCBsZG8xIHdvdWxkIGJlIGtlcHQgQDMuMHYgYW5kIGxkbzJA
MC45diB3aGljaCB2aW9sYXRlDQo+ID4gaS5teDhtbiBkYXRhc2hlZXQgYXMgdGhlIGJlbG93IHdh
cm5pbmcgbG9nIGluIGtlcm5lbDoNCj4gPg0KPiA+IFsgICAgMC45OTU1MjRdIExETzE6IEJyaW5n
aW5nIDE4MDAwMDB1ViBpbnRvIDMwMDAwMDAtMzAwMDAwMHVWDQo+ID4gWyAgICAwLjk5OTE5Nl0g
TERPMjogQnJpbmdpbmcgODAwMDAwdVYgaW50byA5MDAwMDAtOTAwMDAwdVYNCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT4NCj4gDQo+IFlvdSBz
aG91bGQgYWRkIGEgRml4ZXMgdGFnIGFuZCBDYyBzdGFibGUgb24gdGhpcyBvbmUuDQpPa2F5LCB3
aWxsIGFkZHJlc3MgeW91ciBjb21tZW50cyBpbiB2MywgdGhhbmtzLg0K
