Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE4AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 03:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31AD12065E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 03:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="E/oE4JWr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgGTDoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 23:44:39 -0400
Received: from mail-vi1eur05on2045.outbound.protection.outlook.com ([40.107.21.45]:49960
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726127AbgGTDoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 23:44:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDkSgB6zaYfAhhCeG99mpMVX7R33uWda2uoDeTtH38yX50L2v4xTWvITPXwBPWokhN+7nGYelUHhDL5sVENJazmusl5WGu9RV/Vbkmfw6qZIH6z9f+tXHTwM/8UshCW9H9WmnAB4NNBQuymaER4MD4Attlr81lqr7IeIwBGFBppbynPXMRg2kNJGyrHn53TGOfj0fUqk7eu7kLHWTVzhjwO9s5PPuVOA+oskIBj59wfLR5xc7A/UsJEyYtfo3xzDREPNuFFFEg7rFK9CJw8Ldntbm8aL/w47EKlSej4L97FGPic5Rph9yGpVuIHWCOcyna2YihDHfQO+rmRx8NcwlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81XaqxWskLIFMWzeMsB9y1VKvhvKU4zYXBbgdNvaors=;
 b=h5UuTDJyx6jSTKEBwYgQILKumRvJJJ2VJq2cuu+mDi2xEorGWVZQpH+QSLoVlqDcwxXzyqkvMzQ4ioniQMidoTq4kI6bYDgh5Jk9HDjS5HnzaNFM61fsupHW3y7Tm5hakk5jTCzp6wZ6NupwScUKGJSh/P/3PxYTrwSmGQhp9Q37r7g2TRDsymJOepeh2V/4v4ChE3pqH3zZam1H12guUMVNZGPIcGjIbO8yT8z/j8JlkOLFlOMrPXJ9SNziV/1jAud6n79WHjQtErVFN+s6CGSSvlhZLB1+ejUdJBKQ4ao00v5kft5EjvfNzlDMS/ABPfwkfljxSy2V1ul1gpDm6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81XaqxWskLIFMWzeMsB9y1VKvhvKU4zYXBbgdNvaors=;
 b=E/oE4JWrUArK4uegsaoK4nWv3NwVtCzFz50rQKR3eJYNGxlnFzPiAMdD1L3VlEHj6WSV0ygJwAJwRvTi95AzmyA+8O+ydnXYuXeqVbG0sbtg0LfJjwHf+ohu+f0EVtBVPwRV+S77gPt9rLnb1SXcW8qCCxM+sXMw6Zx428C5m+w=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB5368.eurprd04.prod.outlook.com (2603:10a6:20b:9c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Mon, 20 Jul
 2020 03:44:34 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 03:44:34 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Philippe Schenker <philippe.schenker@toradex.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Jun Li <jun.li@nxp.com>
Subject: RE: [PATCH v2 2/3] usb: chipidea: imx: support disabling runtime-pm
Thread-Topic: [PATCH v2 2/3] usb: chipidea: imx: support disabling runtime-pm
Thread-Index: AQHWWfIPNKRf0OmdJ0GCrPpelAWmTKkHzuSggAChQYCAB2sK0A==
Date:   Mon, 20 Jul 2020 03:44:34 +0000
Message-ID: <AM7PR04MB71572600CE73140FE13CB17C8B7B0@AM7PR04MB7157.eurprd04.prod.outlook.com>
References: <20200714151822.250783-1-philippe.schenker@toradex.com>
         <20200714151822.250783-2-philippe.schenker@toradex.com>
         <AM7PR04MB7157793C6395C200DF5646C98B7E0@AM7PR04MB7157.eurprd04.prod.outlook.com>
 <08251297f72fe745be43205d0a73631f009681cc.camel@toradex.com>
In-Reply-To: <08251297f72fe745be43205d0a73631f009681cc.camel@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toradex.com; dkim=none (message not signed)
 header.d=none;toradex.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [116.232.9.225]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 39d2141d-377d-404b-c440-08d82c5f37f2
x-ms-traffictypediagnostic: AM6PR04MB5368:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB5368A339C78882CB4A048F7B8B7B0@AM6PR04MB5368.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KsZZdk+5uqhvzSP9dJMd5bToRg4Vb6yTWZ4UVnkqgyBMtytP5UOUgHi3XOZ3w3EgFyHHoV0tcPqUBkaApKEr0zxWY3Kmw/J4rMuui/iGwCXZeyOlOtDwymHYvg2+/1ZHbpkJANZuJLDuo2aL7eE1Mj6/HMoG2K/i5IiZXrZ4D1Vm2nGT49yXOp7Dgoa5VKRs8hjysuFLn+wKWnp01RIIu0x7l0+ORo3leTtlL04d9O+wC8rESKprBKaTbffPxb5wmjOzitzLdRGzC0ghAqGGUDiBg3BNw8lKsp9MGOP7GmLLwFJ6+BGkL705MiIhEQLBepFYlViwVChHQImEmr5c9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(316002)(5660300002)(66446008)(44832011)(186003)(6506007)(8936002)(7696005)(8676002)(66556008)(86362001)(66476007)(66946007)(64756008)(26005)(76116006)(7416002)(33656002)(54906003)(110136005)(71200400001)(478600001)(4326008)(52536014)(2906002)(83380400001)(55016002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: mAAVKc2t2qKKG5eq2u20UcBPe1WXusQNKW0ELxrezWfyde8M5AXbqbs1WwVagKdnPwE5B8PZ7UmPaRZKI5UzUR6Rr69uzy3gFM4gtXTEeFBsCAm+VzhllwAaEJ0hWdW1DDJMCBYXtHyOhwv97McJw1DJu7ydrKQfX8XqzovQb/dw3C0tfniar5wWdbRHBwYancyDxOeibOLzX02zRvY5ckRolT4zvh4A0BrbafWzxgAFhnxbTU1qTM2DHabqo+QSpA5wGcJnbvYWFzGHeP/BhVYEDlw1rBJNULU8+tCCz5Ug0BIMg40H6jZ86uWe11SSowRSNxlyB92HA2CNUuJ3pnf9x8x09JZK+3aqmvvt3SoGjQiy/hmewzqLyuLjjubnjh1CgsxiDzvE8RCPLOJOfOzkaS5xIECYHle1ndtfD4yYtu0DjEXB9cskCIjNkkMPkv0GfcYn9zEYTSYukyckDpDF77y35EhaL87Gl8yfQY0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d2141d-377d-404b-c440-08d82c5f37f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 03:44:34.3364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qUqEroUUXk4c65DKe6Ms1PpvF/g1uwvt+8ppVo1g9cqOIdtTMCzDTETZd6Lt0gMcyln12qDLYF9pfl2mdg/yqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5368
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiBPbiBXZWQsIDIwMjAtMDctMTUgYXQgMDA6NTEgKzAwMDAsIFBldGVyIENoZW4gd3JvdGU6
DQo+ID4NCj4gPiA+IFRoZSBUb3JhZGV4IENvbGlicmkgaU1YNlVMTCBib2FyZCBoYXMgYSBzcGVj
aWFsIFVTQiBoYXJkd2FyZSBkZXNpZ24uDQo+ID4gPiBXaXRoIHJ1bnRpbWUtcG0gZW5hYmxlZCBV
U0IgcmVzZXQgaXRzZWxmIGNvbnRpbnVvdXNseS4gRnVydGhlcm1vcmUNCj4gPiA+IHRoZSBPVEcg
cG9ydCBpcyBhbHNvIG5vdCBlbnVtZXJhdGluZyBkZXZpY2VzIGlmIHRoZSBDaGlwaWRlYSBJUCBp
cw0KPiA+ID4gaW4gcnVudGltZSBzbGVlcCBtb2RlIGFuZCBhIGRldmljZSBvciBob3N0IGdldHMg
cGx1Z2dlZCBpbi4NCj4gPiA+DQo+ID4NCj4gPiBIaSBQaGlsaXBwZSwNCj4gPg0KPiA+IFlvdSBt
YXkgZGVzY3JpYmUgdGhlIGRldGFpbCB3aGF0J3MgdGhlIHNwZWNpYWwgVVNCIGhhcmR3YXJlIGRl
c2lnbiBmb3INCj4gPiB5b3VyIGJvYXJkLA0KPiANCj4gSWYgSSBvbmx5IGtuZXcgdGhlIHJvb3Qt
Y2F1c2Ugb2YgdGhhdCBwcm9ibGVtIC0gdW5mb3J0dW5hdGVseSBJIGRvbid0Lg0KPiBUaGF0J3Mg
YWxzbyB3aHkgSSBoYXZlIHN1Y2ggYSBoYXJkIHRpbWUgdG8gZGVzY3JpYmUgaXQuDQo+IA0KPiA+
IGFuZCB3aHkgaXQgY2F1c2VzIHRoZSBwcm9ibGVtLCBhbmQgd2h5IGRpc2FibGUgcnVudGltZSBw
bSBjb3VsZCBmaXgNCj4gPiB0aGlzIGlzc3VlLCB0aGVuLA0KPiANCj4gSSBjYW5ub3QgcHJvdmlk
ZSB0aGUgJ3doeScgcGFydCB5ZXQuIEknbGwgdHJ5IHNvbWV0aGluZyBtb3JlIGFuZCBob3BlIEkg
Y2FuIHByb3ZpZGUNCj4geW91IGd1eXMgd2l0aCB0aGUgZXhhY3QgZGVzY3JpcHRpb24uDQo+IA0K
PiA+IHRoZSBvdGhlciB1c2VycyBjb3VsZCBrbm93IGlmIGl0IGNvdWxkIGFwcGx5IHRvIHRoZWly
IHBsYXRmb3JtcyBvciBub3QNCj4gPiBpbiBmdXR1cmUuDQo+IA0KPiBJIG9ubHkgZm91bmQgb3V0
IGFib3V0IGl0IGJlY2F1c2UgeW91IHdlcmUgcG9pbnRpbmcgbWUgaW4gdGhhdCBkaXJlY3Rpb24u
IEkgZGVidWdnZWQNCj4gZm9yIGhvdXJzIG5vdyBhbmQgZGlkbid0IGNhbWUgdG8gdGhlIHJvb3Qt
Y2F1c2Ugb2YgdGhlIGlzc3VlLiBJIHRoaW5rIHRvIHJlYWxseQ0KPiB1bmRlcnN0YW5kIGl0IEkg
d291bGQgbmVlZCB0byBrbm93IG11Y2ggbW9yZSBhYm91dCB0aGUgQ2hpcGlkZWEgSVAuDQo+IA0K
PiBJJ2xsIGdldCBiYWNrIHRvIHlvdSBndXlzIHdpdGggYSBwcm9wb3NhbCBmb3IgYSBuZXcgZGVz
Y3JpcHRpb24uDQo+IA0KDQpQaGlsaXBwZSwgaXMgaXQgcG9zc2libGUgdG8gc2hhcmUgeW91ciBV
U0IgaGFyZHdhcmUgZGVzaWduIGF0IDZVTEw/DQpBbmQgaG93IGNpX2hkcmNfZ2FkZ2V0X2Nvbm5l
Y3QgaXMgY2FsbGVkIHdoZW4gdGhlIHJ1bnRpbWUgcG0gaXMgZGlzYWJsZWQ/DQoNClRoYW5rcywN
ClBldGVyDQogDQo=
