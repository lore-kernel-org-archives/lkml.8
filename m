Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E048AC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B15B22072E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qbyOrizf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgG0GvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 02:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgG0GvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 02:51:17 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-he1eur02on0601.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe05::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E465C0619D2;
        Sun, 26 Jul 2020 23:51:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAQBqVckhSAM3QEhyhuSV9vxLj9wHO+oP7BS2Ey6Tci8D/mO3z16YnEtFHrYx+90XSvz589fXEsM3Z5H3vcdbItFc6hrdpSi0+TuGWulbH1XndXIpD1ud3mKxEXVQvVKG2aUYfHe0JfYOuI/XVeIiE2zYLYAPJmPx6PnMThF98uEZtmCHIzpXMyCQ3TmKYNGw/eEUSVgv1MEVnOdiHuVnCD72gs71O63y3WNRLzH7k65vIP0+H+FVJdlrfJeVR3+gXoiLxhCgn2dlS2v6JhKMHt6kGqzUNg1VG7RpxO8XrGWcrLXW5OAqUQl+NdOuwaX9VxmuSiifSHW8rf/1V14Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzyPnayaZv4AY3niK2lA8lplw0sXk7O6b2wnW+WLEDg=;
 b=Fx1+sN113hBaieRAGkQfIt9Zifm57XlJLQLrYStq2ZMmZKxl5jCwgOA8pOFoIGpH/Hr8MENmL3ED59SFjSgnOEL8k2AILC/PexxoxJ6/BVdFZ81oGeV7i07EvAL0ISRjW77iN51/t6bmzU7Tf6JY6cyEpQlDT7msTVnhKveSTFphNzwpNxPkbfWcv/GvVSOOea802KG1O/DRzfB5peAlPg64du9tE/y8wZewiuFHP547QEBmN75qS8ZtNvf0hBljZpnHK54yLn8GIaxY3OgSz2R2Adpaoi9mTYXxqwpqiu+HsNR5y89Ewx4OXwkKX6EHsams8XWUym5//4Raz8CF5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzyPnayaZv4AY3niK2lA8lplw0sXk7O6b2wnW+WLEDg=;
 b=qbyOrizf4/337/EDA1pUxZXwx1OX5HdJLlRjEX3ZYYZSYUZpqAKmnycVj+/Jk5pmA2o1Wx5JwO48Vf1TDbEDeoGx7adQIr98LWNy41k6alV0lQL0sO69VwxQlTgjsVgui3LOQrOYYTPQ+u05k1fmdraa6l9frnIANyr2MitorE4=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB7051.eurprd04.prod.outlook.com (2603:10a6:10:fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 06:51:00 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 06:51:00 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
CC:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 03/10] remoteproc: imx: use devm_ioremap
Thread-Topic: [PATCH 03/10] remoteproc: imx: use devm_ioremap
Thread-Index: AQHWYY4mj2fkhyJv70m2EtieoGp7X6ka+c2AgAAA2pCAAARBgIAAAZOA
Date:   Mon, 27 Jul 2020 06:51:00 +0000
Message-ID: <DB6PR0402MB276063FBE74FCF222CB00F8588720@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20200724080813.24884-1-peng.fan@nxp.com>
 <20200724080813.24884-4-peng.fan@nxp.com>
 <20200727062335.v2pxgu6kr6ao2qmh@pengutronix.de>
 <DB6PR0402MB27601C875FF5F1E02DBF5C6488720@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200727064151.767kc7622tcqmqfs@pengutronix.de>
In-Reply-To: <20200727064151.767kc7622tcqmqfs@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 35724989-c4bf-450f-5ade-08d831f96c52
x-ms-traffictypediagnostic: DB8PR04MB7051:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB70517F8CBFED5822928F73DF88720@DB8PR04MB7051.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eiWw+O0cOZBRTkBB+Ydw8bl9tztcboHSGiTmfaP+c/NmqM3WXygQpxIsu2R/FLQ3DRYZEzsWcaD1ZGkdFRQr0UaWGBVabVCc6fSNmhA6ibrCAUxo0V/HMrpqlDDl+3AUKkvdDyhoBcmFb69C7LCN2XdPc08wl/6zNEHDpUeDFJyxK50Ufes25q8BWDwSU5K079NH/5i9umKS7EBuTZetcyph9EibsjFx9Zy4PHGGV5jK0IkG0+DOTF93AYMxjsZIZRvzqs1xmip0UFoh4ZetfwbL0Z5GdPOrTwXRkJoIQB7XbqffsWajKUdVb/q72jE4qghSAN2j8si4hFv86epb4glBcxct8jIHC0QEWrdFOmI6qYQnQjyr97NC2lzszfoz988p5uZeG4WrQYfrncclFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(26005)(2906002)(7696005)(66446008)(52536014)(8936002)(4326008)(64756008)(86362001)(33656002)(71200400001)(8676002)(966005)(186003)(7416002)(6916009)(66946007)(54906003)(66556008)(6506007)(83380400001)(66476007)(5660300002)(478600001)(76116006)(44832011)(316002)(55016002)(83080400001)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: HUOsVvtRk1KKaaLVfL7ELsbfEz8qxs9ygidnCvnsDCCfZvCNRlX7++LcPW8lCrGnKDgTkAZfkds4hdzGA6iKIxJjq3qZ1Ow+grB2YOL3GYqRnNhWaIvfUxgIsHcN9ePLDkVhz4hFJ8pvl66XLluvunBw5UxmWTlnTQzye75sKkYwxMx3EJnP+2LU1C+xbua6o0wxG68LNCETKpCd32mbywkP40AlIAqz1P9lFfzmn5n5wRC9dqSP3sCaUE8LWEdiiF3+x6LrrlYWk7Lqq9iPNOzyJB2RKF8TlItHicwBGSkEbWfIe0iUvZcc5K9wr5aWUT8Ww+yDWnrnYEPC67w6MmQF4Eeto8Y3DAeo80u5a4NnVRxhywDP0KKkEvILpLdc6e6rMdcWASNWGRVY80zebnP//NsOF5uQAh6OBn2sSsDJZ3FbQ5CCRb1coh+0j6U0Ga9U3sxtesnvRAyNM/LtZQt5Qbqqu52vYfxxfSheCKE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35724989-c4bf-450f-5ade-08d831f96c52
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2020 06:51:00.6359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j5x7GZzzE9bpwK/ZLxCZJiwsFzsrKLfoWw6GdJXMubkahJKCOjUfAogRD3FrflYv25ZO6zXf6Hbd3rpWRhR1/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDAzLzEwXSByZW1vdGVwcm9jOiBpbXg6IHVzZSBkZXZtX2lv
cmVtYXANCj4gDQo+IE9uIE1vbiwgSnVsIDI3LCAyMDIwIGF0IDA2OjI4OjIwQU0gKzAwMDAsIFBl
bmcgRmFuIHdyb3RlOg0KPiA+IEhpIE9sZWtzaWosDQo+ID4NCj4gPiA+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggMDMvMTBdIHJlbW90ZXByb2M6IGlteDogdXNlIGRldm1faW9yZW1hcA0KPiA+ID4NCj4g
PiA+IE9uIEZyaSwgSnVsIDI0LCAyMDIwIGF0IDA0OjA4OjA2UE0gKzA4MDAsIFBlbmcgRmFuIHdy
b3RlOg0KPiA+ID4gPiBXZSBtaWdodCBuZWVkIHRvIG1hcCBhbiByZWdpb24gbXVsdGlwbGUgdGlt
ZXMsIGJlY2F1ZSB0aGUgcmVnaW9uDQo+ID4gPiA+IG1pZ2h0IGJlIHNoYXJlZCBiZXR3ZWVuIHJl
bW90ZSBwcm9jZXNzb3JzLCBzdWNoIGkuTVg4UU0gd2l0aCBkdWFsDQo+IE00IGNvcmVzLg0KPiA+
ID4gPiBTbyB1c2UgZGV2bV9pb3JlbWFwLCBub3QgZGV2bV9pb3JlbWFwX3Jlc291cmNlLg0KPiA+
ID4NCj4gPiA+IENhbiB5b3UgcGxlYXNlIGdpdmUgYW4gZXhhbXBsZSBvZiB0aGlzIGtpbmQgb2Yg
c2hhcmVkIHJlc291cmNlcyBhbmQNCj4gPiA+IGhvdyB0aGV5IHNob3VsZCBiZSBoYW5kbGVkIGJ5
IHR3byBzZXBhcmF0ZSBkZXZpY2VzPw0KPiA+DQo+ID4gVGhpcyBpcyB0byBzaGFyZSB2ZGV2YnVm
ZmVyIHNwYWNlLCB0aGVyZSBpcyBhIHZkZXZidWZmZXIgaW4gZGV2aWNlDQo+ID4gdHJlZSwgaXQg
d2lsbCBiZSBzaGFyZWQgYmV0d2VlbiBNNF8wIGFuZCBNNF8xLg0KPiA+DQo+ID4gRm9yIHRoZSBi
dWZmZXIsIGl0IGlzIExpbnV4IERNQSBBUEkgd2lsbCBoYW5kbGUgdGhlIHNwYWNlLg0KPiANCj4g
V2h5IHJlbW90ZXByb2MgbmVlZCB0byBjYXJlIGFib3V0IGl0PyBJZiBJIHNlZSBpdCBjb3JyZWN0
bHksIGZyb20gdGhlIGxpbnV4DQo+IHBlcnNwZWN0aXZlLCBpdCBpcyBvbmUgYnVmZmVyIGFuZCBv
bmUgZHJpdmVyIGlzIHJlc3BvbnNpYmxlIGZvciBpdC4gT3IgZG8gSSBtaXNzaW5nDQo+IHNvbWUg
dGhpbmc/DQoNCldlIG5vdCBoYXZlIHRoZSB2ZGV2IGJ1ZmZlciBpbiByZXNvdXJjZSB0YWJsZSwg
c28gSSBhZGRlZCBpbiBkZXZpY2UgdHJlZSwgc2VlIGJlbG93Og0KDQogICAgICAgIGlteDhxbV9j
bTQwOiBpbXg4cW1fY200QDAgew0KICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiZnNsLGlt
eDhxbS1jbTQiOw0KICAgICAgICAgICAgICAgIHJzYy1kYSA9IDwweDkwMDAwMDAwPjsNCiAgICAg
ICAgICAgICAgICBtYm94LW5hbWVzID0gInR4IiwgInJ4IiwgInJ4ZGIiOw0KICAgICAgICAgICAg
ICAgIG1ib3hlcyA9IDwmbHNpb19tdTUgMCAxDQogICAgICAgICAgICAgICAgICAgICAgICAgICZs
c2lvX211NSAxIDENCiAgICAgICAgICAgICAgICAgICAgICAgICAgJmxzaW9fbXU1IDMgMT47DQog
ICAgICAgICAgICAgICAgbXViLXBhcnRpdGlvbiA9IDwzPjsNCiAgICAgICAgICAgICAgICBtZW1v
cnktcmVnaW9uID0gPCZ2ZGV2MHZyaW5nMD4sIDwmdmRldjB2cmluZzE+LCA8JnZkZXZidWZmZXI+
LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8JnZkZXYxdnJpbmcwPiwgPCZ2ZGV2
MXZyaW5nMT47DQogICAgICAgICAgICAgICAgY29yZS1pbmRleCA9IDwwPjsNCiAgICAgICAgICAg
ICAgICBjb3JlLWlkID0gPElNWF9TQ19SX000XzBfUElEMD47DQogICAgICAgICAgICAgICAgc3Rh
dHVzID0gIm9rYXkiOw0KICAgICAgICAgICAgICAgIHBvd2VyLWRvbWFpbnMgPSA8JnBkIElNWF9T
Q19SX000XzBfUElEMD4sDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwmcGQgSU1Y
X1NDX1JfTTRfMF9NVV8xQT47DQogICAgICAgIH07DQoNCiAgICAgICAgaW14OHFtX2NtNDE6IGlt
eDh4X2NtNEAxIHsNCiAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImZzbCxpbXg4cW0tY200
IjsNCiAgICAgICAgICAgICAgICByc2MtZGEgPSA8MHg5MDEwMDAwMD47DQogICAgICAgICAgICAg
ICAgbWJveC1uYW1lcyA9ICJ0eCIsICJyeCIsICJyeGRiIjsNCiAgICAgICAgICAgICAgICBtYm94
ZXMgPSA8JmxzaW9fbXU2IDAgMQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAmbHNpb19tdTYg
MSAxDQogICAgICAgICAgICAgICAgICAgICAgICAgICZsc2lvX211NiAzIDE+Ow0KICAgICAgICAg
ICAgICAgIG11Yi1wYXJ0aXRpb24gPSA8ND47DQogICAgICAgICAgICAgICAgbWVtb3J5LXJlZ2lv
biA9IDwmdmRldjJ2cmluZzA+LCA8JnZkZXYydnJpbmcxPiwgPCZ2ZGV2YnVmZmVyPiwNCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgPCZ2ZGV2M3ZyaW5nMD4sIDwmdmRldjN2cmluZzE+
Ow0KICAgICAgICAgICAgICAgIGNvcmUtaW5kZXggPSA8MT47DQogICAgICAgICAgICAgICAgY29y
ZS1pZCA9IDxJTVhfU0NfUl9NNF8xX1BJRDA+Ow0KICAgICAgICAgICAgICAgIHN0YXR1cyA9ICJv
a2F5IjsNCiAgICAgICAgICAgICAgICBwb3dlci1kb21haW5zID0gPCZwZCBJTVhfU0NfUl9NNF8x
X1BJRDA+LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8JnBkIElNWF9TQ19SX000
XzFfTVVfMUE+Ow0KICAgICAgICB9Ow0KDQogICAgICAgICAgICAgICAgdmRldmJ1ZmZlcjogdmRl
dmJ1ZmZlciB7DQogICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gInNoYXJlZC1k
bWEtcG9vbCI7DQogICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MCAweDkwNDAwMDAwIDAg
MHgxMDAwMDA+Ow0KICAgICAgICAgICAgICAgICAgICAgICAgbm8tbWFwOw0KICAgICAgICAgICAg
ICAgIH07DQoNCkkgaGF2ZSB0aGUgdXBwZXIgdmRldmJ1ZmZlciBub2RlIHNoYXJlZCBiZXR3ZWVu
IE00MCBhbmQgTTQxIG5vZGUuDQpUaGUgdmRldmJ1ZmZlciB3aWxsIGJlIHVzZWQgYXMgdmlydGlv
IGRhdGEgYnVmZmVyLg0KDQpBbmQgSSBoYXZlIHRoZSBmb2xsb3dpbmcgaW4gcnByb2NfYWRkX3Zp
cnRpb19kZXYgdG8gc2hhcmUgdmRldmJ1ZmZlcjoNCiAgICAgICAgLyogVHJ5IHRvIGZpbmQgZGVk
aWNhdGVkIHZkZXYgYnVmZmVyIGNhcnZlb3V0ICovDQogICAgICAgIG1lbSA9IHJwcm9jX2ZpbmRf
Y2FydmVvdXRfYnlfbmFtZShycHJvYywgInZkZXYlZGJ1ZmZlciIsIHJ2ZGV2LT5pbmRleCk7DQog
ICAgICAgIGlmICghbWVtKQ0KICAgICAgICAgICAgICAgIG1lbSA9IHJwcm9jX2ZpbmRfY2FydmVv
dXRfYnlfbmFtZShycHJvYywgInZkZXZidWZmZXIiKTsNCg0KDQpIb3BlIHRoaXMgaXMgY2xlYXIu
DQoNCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiANCj4gPiBUaGFua3MsDQo+ID4gUGVuZy4NCj4gPg0K
PiA+ID4NCj4gPiA+ID4gUmV2aWV3ZWQtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhw
LmNvbT4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+
DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgZHJpdmVycy9yZW1vdGVwcm9jL2lteF9ycHJvYy5jIHwg
NSArKystLQ0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVtb3RlcHJv
Yy9pbXhfcnByb2MuYw0KPiA+ID4gPiBiL2RyaXZlcnMvcmVtb3RlcHJvYy9pbXhfcnByb2MuYyBp
bmRleCAzYjM5MDRlYmFjNzUuLjgyNTk0YTgwMGExYg0KPiA+ID4gPiAxMDA2NDQNCj4gPiA+ID4g
LS0tIGEvZHJpdmVycy9yZW1vdGVwcm9jL2lteF9ycHJvYy5jDQo+ID4gPiA+ICsrKyBiL2RyaXZl
cnMvcmVtb3RlcHJvYy9pbXhfcnByb2MuYw0KPiA+ID4gPiBAQCAtMjk2LDkgKzI5NiwxMCBAQCBz
dGF0aWMgaW50IGlteF9ycHJvY19hZGRyX2luaXQoc3RydWN0DQo+ID4gPiA+IGlteF9ycHJvYw0K
PiA+ID4gKnByaXYsDQo+ID4gPiA+ICAJCWlmIChiID49IElNWDdEX1JQUk9DX01FTV9NQVgpDQo+
ID4gPiA+ICAJCQlicmVhazsNCj4gPiA+ID4NCj4gPiA+ID4gLQkJcHJpdi0+bWVtW2JdLmNwdV9h
ZGRyID0NCj4gZGV2bV9pb3JlbWFwX3Jlc291cmNlKCZwZGV2LT5kZXYsDQo+ID4gPiAmcmVzKTsN
Cj4gPiA+ID4gKwkJLyogTm90IHVzZSByZXNvdXJjZSB2ZXJzaW9uLCBiZWNhdXNlIHdlIG1pZ2h0
IHNoYXJlIHJlZ2lvbiovDQo+ID4gPiA+ICsJCXByaXYtPm1lbVtiXS5jcHVfYWRkciA9IGRldm1f
aW9yZW1hcCgmcGRldi0+ZGV2LA0KPiByZXMuc3RhcnQsDQo+ID4gPiA+ICtyZXNvdXJjZV9zaXpl
KCZyZXMpKTsNCj4gPiA+ID4gIAkJaWYgKElTX0VSUihwcml2LT5tZW1bYl0uY3B1X2FkZHIpKSB7
DQo+ID4gPiA+IC0JCQlkZXZfZXJyKGRldiwgImRldm1faW9yZW1hcF9yZXNvdXJjZSBmYWlsZWRc
biIpOw0KPiA+ID4gPiArCQkJZGV2X2VycihkZXYsICJkZXZtX2lvcmVtYXAgJXBSIGZhaWxlZFxu
IiwgJnJlcyk7DQo+ID4gPiA+ICAJCQllcnIgPSBQVFJfRVJSKHByaXYtPm1lbVtiXS5jcHVfYWRk
cik7DQo+ID4gPiA+ICAJCQlyZXR1cm4gZXJyOw0KPiA+ID4gPiAgCQl9DQo+ID4gPiA+IC0tDQo+
ID4gPiA+IDIuMTYuNA0KPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IC0tDQo+ID4gPiBQ
ZW5ndXRyb25peCBlLksuICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiA+ID4gfA0KPiA+
ID4gU3RldWVyd2FsZGVyIFN0ci4gMjEgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gPiA+IGh0
dHA6Ly93d3cucGVuZ3V0cm9uaXguZGUvICB8DQo+ID4gPiAzMTEzNyBIaWxkZXNoZWltLCBHZXJt
YW55ICAgICAgICAgICAgICAgICAgfCBQaG9uZToNCj4gPiA+ICs0OS01MTIxLTIwNjkxNy0wICAg
IHwNCj4gPiA+IEFtdHNnZXJpY2h0IEhpbGRlc2hlaW0sIEhSQSAyNjg2ICAgICAgICAgICB8IEZh
eDoNCj4gPiA+ICs0OS01MTIxLTIwNjkxNy01NTU1IHwNCj4gDQo+IC0tDQo+IFBlbmd1dHJvbml4
IGUuSy4gICAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+IHwNCj4gU3RldWVyd2FsZGVyIFN0
ci4gMjEgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gaHR0cDovL3d3dy5wZW5ndXRyb25peC5k
ZS8gIHwNCj4gMzExMzcgSGlsZGVzaGVpbSwgR2VybWFueSAgICAgICAgICAgICAgICAgIHwgUGhv
bmU6DQo+ICs0OS01MTIxLTIwNjkxNy0wICAgIHwNCj4gQW10c2dlcmljaHQgSGlsZGVzaGVpbSwg
SFJBIDI2ODYgICAgICAgICAgIHwgRmF4Og0KPiArNDktNTEyMS0yMDY5MTctNTU1NSB8DQo=
