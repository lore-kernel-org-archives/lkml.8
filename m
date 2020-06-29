Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9504C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB5A220663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JM6yyRe1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387820AbgF2UvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731420AbgF2TNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:33 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-ve1eur03on0630.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe09::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423B2C006957
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 04:37:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnWbQFpbZuX6VNzxfw5Q6YCO4o9EgrFidI3xGlGrlZVoj1se2lT6BFKxheMLAzI+fHAgL8mhn1A4i0x4rbc5YNHFWeeXGmDxzbP1i/N4Ly7aPYnM05EmarWElFzk9uizDU2d0pQUbTD39X6TXRn44ec7EAuFDTwPlZ4zSsc9z96GH4qU9bAACGiF/EEDxrVKplyvglQo+L6HuYiHpIOKRaashAtdZMMqlyAdg1xZymUKZ16kcqK9Qnqeu8XTyjkj+atyyB/pHmeNl22rc/MzUydeJlot+bHVROKbC7++sn9om6Vftx1U0vSNlKGBpOWZ699aAdCyxt+XyzyHiL2WKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COTYx1Br3inMGtRmYc0rgawL60TUb2GmC5v0+C9g8Xw=;
 b=nEvabg14Ir2BLJhN459d42z1DPXjwAmpSHtzQU/gZ1V3cIjcCJylOHjYhCVsatMyGTIOPx1rN9tDqbM05A5K7lpOEhbAFq8G+oRXtdlNyXQg7UKr8gknWo0/cAtBHtQOhvHtKU/9tpJdma2uZFU8ByYLZtLwH5bcykfp6a5a6QSXYCSr7DUk5kx/00BWrQiz6rGQp4LcjuTLOo9og21OaWXaUajw/z0FlmpsTU+4Alk2qwwqtZxVgl8iy1Omc5wXwJAb/VUUFumtz9DY0m5mgN8WNPU2YJx+mLom5Mi0yG8aUASlpY4ko3PS5lybyZ/YaSfgMiglnkYYVSH0z/1hrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COTYx1Br3inMGtRmYc0rgawL60TUb2GmC5v0+C9g8Xw=;
 b=JM6yyRe1BAmF8mmV5hYMf2WSFjHEd/TiFVyePyrwk7zvZdUUyKz1sE8ZRbDJiPMneIN6ufTJt93ituwXOg9y0qHlEoj0jZzs1Hw8WrsaX0y5yqDLAHLWqceeHtqEFi6KYNTQJ8BwGtQslZbxx/UNh98acSmNvd4qHZIAih8gCYM=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB8PR04MB5803.eurprd04.prod.outlook.com (2603:10a6:10:a9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Mon, 29 Jun
 2020 11:36:56 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3131.027; Mon, 29 Jun 2020
 11:36:56 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stefan Agner <stefan.agner@toradex.com>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leo Li <leoyang.li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 3/3] ARM: imx: Select RESET_IMX7 for i.MX7D
Thread-Topic: [PATCH 3/3] ARM: imx: Select RESET_IMX7 for i.MX7D
Thread-Index: AQHWTf+izjw19ytbhUGNPMq0Gpgef6jvdYuAgAABJSA=
Date:   Mon, 29 Jun 2020 11:36:56 +0000
Message-ID: <DB3PR0402MB3916E7A184549BF302C7401FF56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1593425623-31810-1-git-send-email-Anson.Huang@nxp.com>
 <1593425623-31810-3-git-send-email-Anson.Huang@nxp.com>
 <CAK8P3a2wsaS9i9BrV6o845Qx4TJrZM=+13C1haqBLg17HKVgXw@mail.gmail.com>
In-Reply-To: <CAK8P3a2wsaS9i9BrV6o845Qx4TJrZM=+13C1haqBLg17HKVgXw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3be2878d-e1db-4b4a-26ec-08d81c20ba64
x-ms-traffictypediagnostic: DB8PR04MB5803:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB5803A3F925D7E6744218FA53F56E0@DB8PR04MB5803.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hsgRc6YO1/PBPBipw5Z5OeOq9nPfiLoZFKgraFJGq0mdKq2cSTEoIf9KodAc51fjK0LVhwUM50msUl+y6stub7yJmfjyOXKUhb8+Cow0ePGqHNFkqEiwvlxZl7MTGkULGMcgbysEO1Ua3qfoBvagaNeRi3l1nzH9WxDNvTrg40t+VVwcuvXztuWL4bM6EJf03OlrIohymN1rRo1ohNWI7ddaxn2oKZ9tO94egwbPQkeYfckq5ek6kxpKuGdrr6UDpkmNG1WkbRAZkQJFdL6Ux2vKTxAn43RhjTaqTcrnmyJIkgyWA+x5EeQS0I2xXPovtCDFCgPfFjCb4boa517Okg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(5660300002)(33656002)(71200400001)(478600001)(76116006)(64756008)(66446008)(66946007)(7696005)(66476007)(66556008)(4326008)(26005)(2906002)(9686003)(52536014)(55016002)(8676002)(86362001)(8936002)(186003)(6916009)(54906003)(53546011)(44832011)(6506007)(316002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: wZqDdl1+q7TwwCsNQuZdhkL/NSGj4rwLya/L5EbMfzK5B/WUAPaVNZzGs10LRBHOCfA6C2+9DAt34lHcfdC49K+uX6AkzjtvzUmMR060/oukHGIkwmIWl6JdHcs5KjcO8eau0QbcJrIUT53GLBgEerDzTMYAvmKfZk5e32tQhth/ojBsniobjuoD8gvli8XyJq0ulMDH7OjnjExGqCgXbC0FHlpVI8wrsJwajbQsx/BKF4W5zvign4xkhzBYqNUHR6XBsN0qgtixQOgJDQBP0wBhw4ZpDiZU3mpaoOPlzqj5LqG1CxUtDiEYv9xw6cTxSw9h6nDkJcdniojMftqDz9xU35dBgNQg7gneK19RveVsjRXAz8a5s2N/eBwYuh9teXdpYnY1gGS2DCooSr0p3MzC7xtK5VqOoHdkdgDcpcpCeGIGn1PHtB5I/bSPWwqvXLdWx2WIWzCAbP2uex9WJfZxmkZQHs2m03yBOb2opmEq/ZhMHygSMK1ZSOuW403t
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be2878d-e1db-4b4a-26ec-08d81c20ba64
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 11:36:56.2783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fUcT0ik6hBJNQ6oDtIE24dn6dv//k26yWBE8+RtEvagGg+lwSf/s5tBMdoSXyNZz+vbo3Q5NeH37iSBUbJUmbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5803
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFybmQNCg0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMy8zXSBBUk06IGlteDogU2VsZWN0
IFJFU0VUX0lNWDcgZm9yIGkuTVg3RA0KPiANCj4gT24gTW9uLCBKdW4gMjksIDIwMjAgYXQgMTI6
MjUgUE0gQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+
ID4gaS5NWDcgcmVzZXQgZHJpdmVyIG5vdyBzdXBwb3J0cyBtb2R1bGUgYnVpbGQsIGl0IGlzIG5v
IGxvbmdlciBidWlsdCBpbg0KPiA+IGJ5IGRlZmF1bHQsIG5lZWQgdG8gc2VsZWN0IGl0IGV4cGxp
Y2l0bHkgZm9yIGkuTVg3RC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5nIDxB
bnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL2FybS9tYWNoLWlteC9LY29u
ZmlnIHwgMSArDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtaW14L0tjb25maWcgYi9hcmNoL2FybS9tYWNoLWlt
eC9LY29uZmlnDQo+ID4gaW5kZXggZTdkN2I5MC4uMzU0MDQ4MyAxMDA2NDQNCj4gPiAtLS0gYS9h
cmNoL2FybS9tYWNoLWlteC9LY29uZmlnDQo+ID4gKysrIGIvYXJjaC9hcm0vbWFjaC1pbXgvS2Nv
bmZpZw0KPiA+IEBAIC01NjEsNiArNTYxLDcgQEAgY29uZmlnIFNPQ19JTVg3RF9DTTQgIGNvbmZp
ZyBTT0NfSU1YN0QNCj4gPiAgICAgICAgIGJvb2wgImkuTVg3IER1YWwgc3VwcG9ydCINCj4gPiAg
ICAgICAgIHNlbGVjdCBQSU5DVFJMX0lNWDdEDQo+ID4gKyAgICAgICBzZWxlY3QgUkVTRVRfSU1Y
Nw0KPiANCj4gUGxlYXNlIGRyb3AgdGhpcyBwYXRjaCwgaXQgYnJlYWtzIHRoZSBpbnRlbnQgb2Yg
dGhlIGZpcnN0IG9uZSBieSBmb3JjaW5nIHRoZSBkcml2ZXINCj4gdG8gYmUgYnVpbHQtaW4gYWdh
aW4gcmF0aGVyIHRoYW4gYSBsb2FkYWJsZSBtb2R1bGUuDQo+IA0KDQpPbmUgdGhpbmcgdG8gY2xh
cmlmeSBpcywgdGhlIGxvYWRhYmxlIG1vZHVsZSBzdXBwb3J0IGlzIE9OTFkgZm9yIGkuTVggQVJN
djggU29DcywNCkFSTXY3IFNvQ3MgaXMgTk9UIGluIHRoZSBwbGFuLCB0aGF0IGlzIHdoeSBJIGFk
ZCB0aGlzIHBhdGNoIHRvIG1ha2UgaXQgc2FtZSBhcyBwcmV2aW91c2x5DQp3aGVuIHRoaXMgcmVz
ZXQgZHJpdmVyIGlzID15IGJ5IGRlZmF1bHQuIFdpdGhvdXQgdGhpcyBwYXRjaCwgdGhpcyByZXNl
dCBkcml2ZXIgd2lsbCBOT1QgYmUNCmVuYWJsZWQgYnkgZGVmYXVsdCBmb3IgaS5NWCBBUk12NyBT
b0NzLCBmdW5jdGlvbiB3aWxsIGJlIGJyb2tlbi4NCg0KVGhhbmtzLA0KQW5zb24NCg==
