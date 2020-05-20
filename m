Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C390EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A046B20671
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DVj0nkZ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgETIGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 04:06:30 -0400
Received: from mail-eopbgr00049.outbound.protection.outlook.com ([40.107.0.49]:20014
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726436AbgETIG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 04:06:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdcFJeonoiGoS0iTJQ1lmoSzd+oKL+WJWvM+GNmJr2RTo3TScylqpgWLZe354FZtUaLfARfxXGC5bRZY0Elzt/6Xwn9/MY+icGPvUbqYGyg8/H8/Kmgn829nCbmt+/QHEbssQ+qXm9b46DJHBz3o5o9M42bfwQi6O1rkNkTLiaVDAQWvn2TRtzKxLcoJ15VxoSobxCK4xFDMyKTQxlq9RNeg5Z+7k6LhUfnqCyHA4I5Y/byHJiaofI2YTMVtt746edlJ63SnI1XATTt7NAO9Y/+a0+F9N6A52RRDc7NSlRG1OTmeqInljiHtfvEFsjm3cdmLxBUPLr756MY76eARyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZaM9KIvbTZMAFXnRSAzRkrCr+uDwriaL1bHOM35y5k=;
 b=PoONAaBAM/oxh1BH5TlvVtcbIRSRaH2SjPwGkqnoIiMQv4I5BbyBfhCZ11AwTJbHbayJA27HNZmnD+R0NVPzNwdqx9CYYVaywXXREd/MWVV7JTtIjcr9RHbySEQrUGRGNNxDPi06yZg8adscgsP3WiM/tZ31tPSfomhU14LI0PY5H3OO/MskMl1Zm4cHL3LnPVB0vXU/hM4Moamk32MzShfsvq/sPrV36NQBGe8ZqoK6KWTqOkdrLp8dbMEJ1WzyIGKK3JPcb8r1EJlCNY3IKNgXcZrZ+q3VlBCZkXwNbb4CyCFvNeAd6KEbA92zPKzyY71j1jzJIAkINKggyw0FHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uZaM9KIvbTZMAFXnRSAzRkrCr+uDwriaL1bHOM35y5k=;
 b=DVj0nkZ2wX/E1tRlgr25O50v6hOf++ICjNDoOi0bYgCBJFUunPftAqezhhtztjoNGtvPFs/W8Y/AHv3nQ3pqdyLGkNi1VrYbxZXTT0afRLCh1VjP30YUTmmpAlug4iUdQnuft090+4T6wBjHcYTFNrWUryHs+ZsDUuGN+KpcTMU=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5637.eurprd04.prod.outlook.com (2603:10a6:20b:ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Wed, 20 May
 2020 08:06:25 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3c6c:a0e9:9a4e:c51d%7]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 08:06:25 +0000
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
Subject: RE: [PATCH] ARM: dts: imx: Make tempmon node as child of anatop node
Thread-Topic: [PATCH] ARM: dts: imx: Make tempmon node as child of anatop node
Thread-Index: AQHWLnGKahSSyBKEm0SO3VgjiRIl16iwl6BQgAABCwCAAASd8A==
Date:   Wed, 20 May 2020 08:06:25 +0000
Message-ID: <AM6PR04MB496661BDF6B5F966A218092380B60@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1589956216-22499-1-git-send-email-Anson.Huang@nxp.com>
 <AM6PR04MB49663B517C218072B2845DBF80B60@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <DB3PR0402MB39167A0961963B73758F6CA9F5B60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39167A0961963B73758F6CA9F5B60@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eb958955-d4e0-4407-2c98-08d7fc94b10e
x-ms-traffictypediagnostic: AM6PR04MB5637:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB5637FB3821A673EB6EDA8F7E80B60@AM6PR04MB5637.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EoXeCz4jlnnierrDoRANxM3kFITQz3hkuErjv0MNGJ2UkzEjyJOR4cWcDrxwvDtYjG8hrWATYRFq/GbIFwNH4v0uxIoyEstsmLsd8c7FiOaPiiut2CfdEM1+9JNEDAQjiIsPHBZMR4URmEjBDyCaAtJxCG/c679iK3cU5G57wXBlZgoUAC8nsp5q11fa/9/Cm2LiuTERTxFABdFkrJfqDeHKjS3qalgHVWTNKYQafw900QAyN69c2Emdi4fTzj3o6hRJxxvAlnRE+cn2bOEWfQxL1CUG+EBtCLDcBLGbqGNJ3C1Zj+Cvv9xnC2H4ESXAIK6X7MEIwhm1pOtm64CszUREQD9wX858bO2HR5y73GFRclmpM9UXsAnSFHmQzZZIDwrvXvCNwHYryuH36amAm0diV4MC6utzWOe21ikAQKwoJVnkdcz9bYdPamdaJuJ5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(55016002)(44832011)(8676002)(53546011)(4326008)(6506007)(7696005)(9686003)(33656002)(2906002)(52536014)(8936002)(5660300002)(26005)(110136005)(316002)(71200400001)(66446008)(478600001)(64756008)(86362001)(66556008)(66476007)(66946007)(186003)(4744005)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: b1mO4bxormPF3h6KKFLiCd1eTIh+aaMt3d2s6yHyhfS4ILpwa4zQo/HpP9/EKQfk1tdhJzig05YYXHdlCA31C8cphF3dyyGXieaBpWDLFk6vghdnqE64ubFJ97ZDuUpa26ohRqSRXxUl9ho4mVLpOtEC+o+fMewM9yiuReT1SpunNMN42RA6IXsCgzd7S94IjGTmMldPwuOjJqfm1WYVSkRbujioyUXdjWrKJHLUWtj0C6bcKNhuCI2uP3tmVawaE2pRj1U230GtQ1Yb1sCgF8PmdJANX0vVGV7zi8nKVyGMY/lffb4DYCMgIeySI97i/yvAFBe0k45XwDy6TxmMw88RhSiJg2AbNmImr4HlKTT5BOLOSDpeMzgm+BozhuR1/3dh12Uay3ligezaK7ndGeDmiEHy0EyV+iT43YabO9tUWlO/sRH82kjf6TUfVSWlEMtdOu1AmiC+Ozev5zUt5V0DZ0lfRKEq5q/BwbzXAiZAkH7mDFv2Idhpby62v44e
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb958955-d4e0-4407-2c98-08d7fc94b10e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 08:06:25.0441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6CRgIOypIo5XuDuLJmn8uLiteu+eTa5e/5IAeeTsoa0RKLZ6JJXjevSc4dY3YIVZnt3uthTdo3SAB5z+ElXbww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5637
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT4NCj4gU2VudDogV2VkbmVz
ZGF5LCBNYXkgMjAsIDIwMjAgMzo0NyBQTQ0KPiANCj4gPiBTdWJqZWN0OiBSRTogW1BBVENIXSBB
Uk06IGR0czogaW14OiBNYWtlIHRlbXBtb24gbm9kZSBhcyBjaGlsZCBvZg0KPiA+IGFuYXRvcCBu
b2RlDQo+ID4NCj4gPiA+IEZyb206IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0K
PiA+ID4gU2VudDogV2VkbmVzZGF5LCBNYXkgMjAsIDIwMjAgMjozMCBQTQ0KPiA+ID4NCj4gPiA+
IGkuTVg2LzcgU29DcycgdGVtcGVyYXR1cmUgc2Vuc29yIGlzIGluc2lkZSBhbmF0b3AgbW9kdWxl
IGZyb20gSFcNCj4gPiA+IHBlcnNwZWN0aXZlLCBzbyBpdCBzaG91bGQgYmUgYSBjaGlsZCBub2Rl
IG9mIGFuYXRvcC4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5z
b24uSHVhbmdAbnhwLmNvbT4NCj4gPg0KPiA+IFJldmlld2VkLWJ5OiBEb25nIEFpc2hlbmcgPGFp
c2hlbmcuZG9uZ0BueHAuY29tPg0KPiA+DQo+ID4gQlRXLCBJIHRoaW5rIHlvdSBhbHNvIG5lZWQg
YSBiaW5kaW5nIGRvYyBmb3IgdGhpcyBjaGFuZ2UuDQo+IA0KPiBUaGUgYmluZGluZyBkb2MgaXMg
dGhlIGlteC10aGVybWFsLnlhbWwgSSBzZW50IG91dCwgaXQgaXMgc3VnZ2VzdGVkIGJ5IFJvYiB0
bw0KPiBtb3ZlIHRlbXBtb24gaW50byBhbmF0b3Agbm9kZSwgdGhhdCBpcyB3aHkgSSBkaWQgdGhp
cyBwYXRjaCB0byBhbGlnbiB3aXRoIHRoZQ0KPiBiaW5kaW5nIGRvYy4NCg0KVGhhdCdzIHRoZXJt
YWwgYmluZGluZyBkb2MuDQpXZSBuZWVkIGEgYmluZGluZyBkb2MgdG8gZGVzY3JpYmUgdGhlIGNv
bnN0cmFpbnRzIGZvciBhbmF0b3AgYXMgd2VsbC4NCg0KUmVnYXJkcw0KQWlzaGVuZw0KDQo+IEFu
c29uDQo=
