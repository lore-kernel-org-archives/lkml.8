Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09153C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D61B7206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="L+0FGQXW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389549AbgF2VBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731205AbgF2TM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:58 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02on0616.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe06::616])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B722C014AC5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 03:45:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khbgQ4O5JEH7Dhc5bj3UDqVhgwNWJfjNCdJnDR6BaxfFqPcIvwghT9tRcYlTn524DPQQlXmaStT4xapFj1S/af/so+UJoieb7iqwuRdKYXdhLcGE18wdo1q9cdFqqMKsoAJZr/L9toldirWUWx7LJK5vcP7jZrKhrsF3Hc1wIwF+5Ygpk6jo96wJtB8w6d5KzIBY0CR+uCmvTNLxEOfjdf33d8bujnNrUHcHbrAhuRG2zLSOZonAn7lpMTasujz1fL4H8+VqDp0NSecyaw4FpH8NZAsozVVyuHG1sVs8e4O0kaXl7HP4K96CkPp1s6OyNGeza/yv5Iidq0oQyGVFoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CF/oA4hF9nhQlOufwm1QIM6oQFHmnIfWYFHxXFWWQvw=;
 b=JhjT825Dj9ASQGPxmLKY8TbWIc60D5UXwNfeDpnCbMw6j3//c1kmh+KEp9jXvANi3CReGumoEJIgLk1kMAZBkJpAGTT3Qy5X2mAbT3zmyKZcJ7hpSxu8H9IybRsHBt1no7nVmle5W/ApAJq4LPdK7BlxLnqFxFQt4WRdrTfxOkfAWfwOu48eYnkmoyEPlNH0N/cQ86OFm8og9bRPKVZtG2sPML1lhnWcweTJzH2w1YeImSsB8ygvHIVpzxwTY0BGojwO4bM2AVWRd6zCDMS2r37u4zZgAJALH8f+gPmVyq+6Sg/lBHpPQMtcx6pEAZr+VKVKiCRJzpqgN6dpos8fBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CF/oA4hF9nhQlOufwm1QIM6oQFHmnIfWYFHxXFWWQvw=;
 b=L+0FGQXWThdMzzr4lsU/kecmLMzl2Wv28Qurw2OSKPEUdCu00HtBZzwl1orugl+6fMtbNFok7k3xLfzIhX93AENkdiVDE4CIc7f0qKtGHrWy997sJDjRf1i9MZQfYMX4+dAYj8m6b0nR6S05DpTTwnEFsV8qgLHVJinH5GnPHio=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB8PR04MB5801.eurprd04.prod.outlook.com (2603:10a6:10:a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Mon, 29 Jun
 2020 10:45:07 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3131.027; Mon, 29 Jun 2020
 10:45:07 +0000
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
Subject: RE: [PATCH 1/3] reset: imx7: Support module build
Thread-Topic: [PATCH 1/3] reset: imx7: Support module build
Thread-Index: AQHWTf+gVil33+KDPEOiQKx/rvC/xajvZ8CAgAAAWbA=
Date:   Mon, 29 Jun 2020 10:45:07 +0000
Message-ID: <DB3PR0402MB3916292FC3FDE4F28AFEB5EBF56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1593425623-31810-1-git-send-email-Anson.Huang@nxp.com>
 <CAK8P3a1pr8YbZMpSXg6o_UeDvaU=dDqfo45DudTASNcsxeg3kg@mail.gmail.com>
In-Reply-To: <CAK8P3a1pr8YbZMpSXg6o_UeDvaU=dDqfo45DudTASNcsxeg3kg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6bf23ae4-7313-45d0-48a2-08d81c197d71
x-ms-traffictypediagnostic: DB8PR04MB5801:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB5801E07E7617D1DC008C99BCF56E0@DB8PR04MB5801.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c+/Y2NLookdSJcEdsESIA5syihS5Ss5XEH9ex/0P2rmo4GS89YLBO36FjQhIAVWZVTIOseUhdD67S5mqdCaU2JJRJ5+XSqPp5T0NlxjuEHypJfsCRQ+dUjxY5ppR2qXC3Wh0QkGEwgnCXWUqAH5VwKe21WsQT8LgOEYgb/+2+BR7aI9ki2cDsNumjFfPjdw6NQGppPQPonzj+k3UxOsKlvXBBplq7Dko7euCdMhq98v1fYHhmhMo/Bxud2L7wRdD3o42oe1ja3v1cO2Rw9gtdek73vItpsSsuAuXMgJMzLb2yUXTIarY2wEFYiVyePuk3j29piw0hIWMVNLxPZ0Z5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(6916009)(44832011)(7696005)(4326008)(54906003)(6506007)(53546011)(66446008)(66556008)(64756008)(66476007)(66946007)(55016002)(76116006)(7416002)(71200400001)(33656002)(9686003)(2906002)(83380400001)(316002)(478600001)(8936002)(52536014)(86362001)(5660300002)(8676002)(26005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: lZxTYlEAw+sk85o562FMNz7lUBc5HCd0SZXHG0b95NDx22UkCfUXAD4+jKs5qRSFWoVPlK59MlKiOpbUhbOT6TUYEeRq1q6nGj58Uh5Nw5kOKR+zydWAyiw44kt8CPCLHjg8/pBJakv1Bre53fXIaVfhCGwvvsnuCB1n7MMd8kOyux0X3MRl8cKHMr3Ka9lJk3TmGt9IivlROqPbMK1SZI8SlHdLncWyIf7Mq7IxyLI3aqp59YYtImRqjBf1RPLwYXvIjxN5jZv2r1Ksv4zp6qKjJUsS22zuXXCWyWFjM1ETvv9PI0jVboOi7aSQ+5cHLT6xTGDdUbzY/Yt48pJfsLdxYZbeQsJcUhDkXvqVzEMUAvKEXpSBw14zDuXKpWL2usfxBAdUNQMo82CNizpXsOb51+qsfH+lzdrLjGPeJI8vtvY7A9ALlhYYq6hoeA912ywUWSvJAgzWbMsEwrSBK3w67o1HeRtHurNyftwUD0EGPf+NEovpZ6KRylcfgtPe
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf23ae4-7313-45d0-48a2-08d81c197d71
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 10:45:07.6951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +CMUpVTfEcr14T5cXbIs2XjFrXuloFNSvV/jcg905cBKzr8mJW+aeYLbGN8oRODrAus9SF1+ZLtagH4DNRYTPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5801
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzNdIHJlc2V0OiBpbXg3OiBTdXBwb3J0IG1vZHVs
ZSBidWlsZA0KPiANCj4gT24gTW9uLCBKdW4gMjksIDIwMjAgYXQgMTI6MjUgUE0gQW5zb24gSHVh
bmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gQWRkIG1vZHVsZSBk
ZXZpY2UgdGFibGUsIG1vZHVsZSBsaWNlbnNlIHRvIHN1cHBvcnQgbW9kdWxlIGJ1aWxkLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+
ID4gLS0tDQo+ID4gIGRyaXZlcnMvcmVzZXQvS2NvbmZpZyAgICAgIHwgNCArKy0tDQo+ID4gIGRy
aXZlcnMvcmVzZXQvcmVzZXQtaW14Ny5jIHwgNCArKystDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcmVzZXQvS2NvbmZpZyBiL2RyaXZlcnMvcmVzZXQvS2NvbmZpZyBpbmRleA0KPiA+IGQ5
ZWZiZmQuLjAzM2FiNjAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9yZXNldC9LY29uZmlnDQo+
ID4gKysrIGIvZHJpdmVycy9yZXNldC9LY29uZmlnDQo+ID4gQEAgLTY1LDkgKzY1LDkgQEAgY29u
ZmlnIFJFU0VUX0hTREsNCj4gPiAgICAgICAgICAgVGhpcyBlbmFibGVzIHRoZSByZXNldCBjb250
cm9sbGVyIGRyaXZlciBmb3IgSFNESyBib2FyZC4NCj4gPg0KPiA+ICBjb25maWcgUkVTRVRfSU1Y
Nw0KPiA+IC0gICAgICAgYm9vbCAiaS5NWDcvOCBSZXNldCBEcml2ZXIiIGlmIENPTVBJTEVfVEVT
VA0KPiA+ICsgICAgICAgdHJpc3RhdGUgImkuTVg3LzggUmVzZXQgRHJpdmVyIg0KPiA+ICAgICAg
ICAgZGVwZW5kcyBvbiBIQVNfSU9NRU0NCj4gPiAtICAgICAgIGRlZmF1bHQgU09DX0lNWDdEIHx8
IChBUk02NCAmJiBBUkNIX01YQykNCj4gPiArICAgICAgIGRlcGVuZHMgb24gU09DX0lNWDdEIHx8
IChBUk02NCAmJiBBUkNIX01YQykgfHwNCj4gQ09NUElMRV9URVNUDQo+ID4gICAgICAgICBzZWxl
Y3QgTUZEX1NZU0NPTg0KPiANCj4gWW91IGFyZSBkcm9wcGluZyB0aGUgJ2RlZmF1bHQnIGxpbmUs
IHNvIHRoZSBkcml2ZXIgaXMgbm93IGRpc2FibGVkIGluIGEgZGVmY29uZmlnDQo+IGJ1aWxkLCB3
aGljaCBpcyBub3QgbWVudGlvbmVkIGluIHRoZSBwYXRjaCBkZXNjcmlwdGlvbi4NCj4gDQo+IE1h
eWJlIG1ha2UgaXQgJ2RlZmF1bHQgbSc/DQo+IA0KPiBjb25maWcgUkVTRVRfSU1YNw0KPiAgICAg
ICAgdHJpc3RhdGUgImkuTVg3LzggUmVzZXQgRHJpdmVyIg0KPiAgICAgICAgZGVwZW5kcyBvbiBI
QVNfSU9NRU0NCj4gICAgICAgIGRlcGVuZHMgb24gU09DX0lNWDdEIHx8IChBUk02NCAmJiBBUkNI
X01YQykgfHwNCj4gQ09NUElMRV9URVNUDQo+ICAgICAgICBkZWZhdWx0IG0gaWYgKFNPQ19JTVg3
RCB8fCAoQVJNNjQgJiYgQVJDSF9NWEMpKQ0KPiAgICAgICAgc2VsZWN0IE1GRF9TWVNDT04NCj4g
DQo+ID4gQEAgLTM5NSwzICszOTYsNCBAQCBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBp
bXg3X3Jlc2V0X2RyaXZlciA9IHsNCj4gPiAgICAgICAgIH0sDQo+ID4gIH07DQo+ID4gIGJ1aWx0
aW5fcGxhdGZvcm1fZHJpdmVyKGlteDdfcmVzZXRfZHJpdmVyKTsNCj4gPiArTU9EVUxFX0xJQ0VO
U0UoIkdQTCB2MiIpOw0KPiANCj4gR2VuZXJhbGx5IHNwZWFraW5nOiB3aGVuIHlvdSBhZGQgYSBN
T0RVTEVfTElDRU5TRSB0YWcsIHBsZWFzZSBhbHNvIGFkZA0KPiBNT0RVTEVfQVVUSE9SIGFuZCBN
T0RVTEVfREVTQ1JJUFRJT04uDQo+IA0KDQpPSywgd2lsbCBhZGQgdGhlbSBpbiBWMi4NCg0KPiBU
aGUgJ2J1aWx0aW5fcGxhdGZvcm1fZHJpdmVyKCknIHNob3VsZCB3b3JrIGNvcnJlY3RseSBidXQg
cHJldmVudCB1bmxvYWRpbmcNCj4gdGhlIG1vZHVsZS4gSWRlYWxseSBwbGVhc2UgY2hhbmdlZCB0
byAnbW9kdWxlX3BsYXRmb3JtX2RyaXZlcigpJyBhbmQgYWRkDQo+IGEgLnJlbW92ZSBmdW5jdGlv
biBmb3IgdGhlIHBsYXRmb3JtX2RyaXZlci4NCj4gDQoNClRoZSByZXNldCBkcml2ZXIgbm9ybWFs
bHkgd29uJ3QgYmUgcmVtb3ZlZCBzaW5jZSBpdCBpcyBuZWNlc3NhcnkgZm9yIGRyaXZlcnMgd2hp
Y2gNCm5lZWQgaXQsIGl0IGlzIGp1c3QgZm9yIEFuZHJvaWQgR0tJIHN1cHBvcnQsIGluIHRoaXMg
Y2FzZSwgZG8gd2UgbmVlZCB0byBjaGFuZ2UgaXQgdG8NCm1vZHVsZV9wbGF0Zm9ybV9kcml2ZXIo
KT8gDQoNClRoYW5rcywNCkFuc29uDQo=
