Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690D8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35C90214F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qUKAnWVU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391150AbgF2V2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbgF2Smo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:42:44 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on0626.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0c::626])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23802C00F825
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:46:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ja47IZu9KDpVUnSkAFFh+38J+ad0/gU4Z+y2ZwmWaWMtlct7huPp+OztlBm8VuJd5sFtJ0QNZJlxRT9Eyseh9xPJYkx6uS2OvLsoIrtbNcdIoqM6xrZZ3iIAikypr/OehprCBCE1wfyJ5zYM29izgSfeEF84hrG2nopKfd68sKRRhKbtQittQnXEfiZr0oAaNpLiyMboQiVLphUv8lUW8TA/QwHS/HQpapnRORNbX/6XzxUpQffe45qfwljxz57yEc2BTuNYdTEv7NUs084Hw1HzGfKg7Bj9+jmn0D0AGoMbbB2Bx6pgzc5x+z1vS4nx8+rgHdy8+gfY0ptRPhzojQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8cdwMFoRlKOj47TeeZy6z8D6mbAjAkAexETl2poQ+0=;
 b=KYSeZ5pUTrmKPLLIa1Ea5rXWNkTcGjtF6kOcMgEYE40I5C84JF/lrs/8pTskEfm2xiRDIcdbmPDxDPtGTgRKtteSyguRdBJUxes/YPRyklcgahd8SG8fGNv2/xUoD9Z+pBPKcAvLw7lzmJXjqFigW5gijO4sZcYt0rV2Z7tzNFaFdO2BUe9iKPffSL1e4tHfnsYEi0htQyTCZbeoxji6dGUzQqvY7d3coX3zn/9seM9sl6qZ8WYQrZnrxryM7Wq/TmSdyY9WlZmM9w6P1hNFDLWPt1zHJfDYRiOl3jBXWBE1YWfXa8J+24fxcfb1o8BL7gAAUcK0YMFLw4LcxKKBRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8cdwMFoRlKOj47TeeZy6z8D6mbAjAkAexETl2poQ+0=;
 b=qUKAnWVUNFmQlunfBFB/2HNtPoCfRXduV4nXTJs5PRADFTV7CosTj6L+DQXtuTjCKB8AVyfhWSfron3JvRnKYFtpKnS2LtcHXPr0aVhbQboQXURjIEhCUkEleqioSIJ4x9E2te0B53kECr/w1bYmpX9+GqQVdk7SI7vqHABIy6w=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB6PR04MB3127.eurprd04.prod.outlook.com (2603:10a6:6:c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.26; Mon, 29 Jun 2020 12:46:18 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1dab:b68c:e028:acb3%6]) with mapi id 15.20.3131.027; Mon, 29 Jun 2020
 12:46:17 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>, Richard Zhu <hongxing.zhu@nxp.com>
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
Subject: RE: [PATCH 2/3] arm64: defconfig: Select CONFIG_RESET_IMX7 by default
Thread-Topic: [PATCH 2/3] arm64: defconfig: Select CONFIG_RESET_IMX7 by
 default
Thread-Index: AQHWTf+gaUMc2TSOQkGGQmWO3bqF1KjvdP0AgAAA96CAAAXtAIAAAtMggAAHhYCAAANTMA==
Date:   Mon, 29 Jun 2020 12:46:17 +0000
Message-ID: <DB3PR0402MB39162138624705E5A296A047F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1593425623-31810-1-git-send-email-Anson.Huang@nxp.com>
 <1593425623-31810-2-git-send-email-Anson.Huang@nxp.com>
 <CAK8P3a31coESQTssW1mndGuZ1pvxXSRRpY=XT1ZO+pkj9aabxg@mail.gmail.com>
 <DB3PR0402MB3916987E13C37013ACF59EB1F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a3Ar3TnSuxpUUMj4NjCK0Qb0pD9cVbcFUcdeGa85m2fUQ@mail.gmail.com>
 <DB3PR0402MB3916192607A09C7061740087F56E0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAK8P3a1NoyMGNK90WzbgJ7opPbiVL8vwnMEuBeeNPNyvB+5sqQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1NoyMGNK90WzbgJ7opPbiVL8vwnMEuBeeNPNyvB+5sqQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 015bb9e2-36e0-4757-70db-08d81c2a6acc
x-ms-traffictypediagnostic: DB6PR04MB3127:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR04MB31276E2DF710836E5B1B4A7FF56E0@DB6PR04MB3127.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vjlA1muqV8EarOZmWIB1SOYmX8zLmM5ejWrt8CIlumWifJQJ0JALziFQ6/eH3X+4BOFwWQ4kNV49T3qMCBA+3g+splPpKqGh8mZVZorDD5fIJKM8TZiGI0qMIEBqusv7RC46y7JgFY2ZGxarozxIjNHhKLBFmmRGrUtd62KSltMTkgIlHk4f7a5Kp8RESbQii1KYJloptk/jIHHHEDZHlpCpa0vUVn+cej1F9QPk9MaHPZm/obxkOiFU4jo5ssj4t0Gz3aY9cBOfFNoymQJk43V+4B+QhYPWn1YNCdqiBGrghlHlYFbucnFvq5aqe9Pyb4C+ugS7FZTuasO1+3btlw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(83380400001)(86362001)(4326008)(478600001)(52536014)(55016002)(33656002)(66446008)(64756008)(66946007)(9686003)(66476007)(76116006)(66556008)(71200400001)(6636002)(316002)(7416002)(7696005)(110136005)(54906003)(26005)(5660300002)(8676002)(44832011)(6506007)(53546011)(186003)(2906002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 06DnJQkxyykWx6SdNnTMsnW0gFdDUA6ATiuRDn0ONWxs2OSG2g/GoF1GN6571DdRHo83aRSqEuz2Pv8MtIJfBIdLRAY369rUHCxrU9WGXO1bZNTzTc4XWEuhkvoFyCyW53E7hTBeeWQGrauKss2Eo+rEMg54CNw+YUp6mGBU2s99slxYjMNvZc0/6mfgAUaaCv5AmJ4t8jKVQPPD6jtz4CLChbHo/AF/CynfI8BOpN7T6P1gwNkERAsaz7uPRbPkyztMCtkdxwX8OHm4mH7h8WXIqwaA71f5z5KtvfAM+dVe5ffLeLsWLHgq+ZdWdVRDCyikiWVHRdDFiQSt9TqoRVrSR5e/NIhko6rpQLH2k7sTxDALLp71ogzYcnj8Kb2JBhk6r1x64/MzqjI2J2NiHgk3diyoeco89V9vG5e+4v2kM7jL5h/3BWHZumgEa5+GYzvjKPymyBrK3K9czV3g8JFP76dyEvI4Me7MwFZeDbO78mg3zlHelTiBoCeWfIeQ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 015bb9e2-36e0-4757-70db-08d81c2a6acc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 12:46:17.7823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GqSqm4InZ5Q3y+YGHdz0idU8RCkbP2M49NTpPerMlSs+p8P396asatnhWyctqJHrl33hqhWuqc2QyLrMSJShzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFybmQNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvM10gYXJtNjQ6IGRlZmNvbmZpZzog
U2VsZWN0IENPTkZJR19SRVNFVF9JTVg3IGJ5DQo+IGRlZmF1bHQNCj4gDQo+IE9uIE1vbiwgSnVu
IDI5LCAyMDIwIGF0IDI6MDkgUE0gQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+
IHdyb3RlOg0KPiA+ID4NCj4gPiA+IEl0IHNvdW5kcyBsaWtlIHlvdXIgcGF0Y2ggMS8zIGlzIG5v
dCByZWFkeSB0byBiZSBtZXJnZWQgdGhlbi4NCj4gPiA+DQo+ID4gPiBQbGVhc2UgbWFrZSBzdXJl
IHRoYXQgbG9hZGluZyBpdCBsYXRlciBkb2VzIG5vdCBicmVhayBvdGhlciBkcml2ZXJzDQo+ID4g
PiB0aGF0IGRlcGVuZCBvbiBpdC4gT3RoZXIgZHJpdmVycyBkb24ndCBoYXZlIHRvIGJlIGFibGUg
dG8gZGVhbCB3aXRoDQo+ID4gPiBtaXNzaW5nIGRlcGVuZGVuY2llcyBpZiB0aGlzIG9uZSBpcyBu
ZXZlciBsb2FkZWQgb3IgZGlzYWJsZWQgYXQNCj4gPiA+IGNvbXBpbGUtdGltZS4gSG93ZXZlciBi
ZWZvcmUgeW91IG1ha2UgaXQgcG9zc2libGUgdG8gdHVybiB0aGlzIGludG8NCj4gPiA+IGEgbG9h
ZGFibGUgbW9kdWxlLCBhbnl0aGluZyB0aGF0IGRlcGVuZHMgb24gaXQgbXVzdCBiZSBhYmxlIHRv
IGRlYWwNCj4gPiA+IHdpdGggdGhlIG1vZHVsZXMgZ2V0dGluZyBsb2FkZWQgaW4gYSByYW5kb20g
b3JkZXIgZmlyc3QuDQo+ID4gPg0KPiA+IEkgc2VhcmNoZWQgYWxsIGRyaXZlciB3aGljaCB1c2Vz
IHRoaXMgcmVzZXQgZHJpdmVyLCBsb29rcyBsaWtlIE9OTFkNCj4gPiBpLk1YNiBQQ0llIGlzIHVz
aW5nIGl0IGFuZCBpdCBPTkxZIHN1cHBvcnRzIGJ1aWx0LWluLg0KPiANCj4gT2ssIHRoYW5rcyBm
b3IgcmVzZWFyY2hpbmcgdGhpcy4NCj4gDQo+ID4gYW5kIGluc2lkZSB0aGlzIGRyaXZlciwgaXQg
ZG9lcyBOT1Qgc3VwcG9ydCBkZWZlciBwcm9iZSBldGMuLCBzaW5jZSBJDQo+ID4gYW0gTk9UIHN1
cmUgd2hlbiB0aGlzIFBDSWUgZHJpdmVyIHdpbGwgYWRkIG1vZHVsZSBzdXBwb3J0LCBzbyBkbyB5
b3UNCj4gPiB0aGluayBpZiBJIGNhbiBtYWtlIFBDSV9JTVg2IHNlbGVjdCBSRVNFVF9JTVg3LCB0
aGVuIGl0IHdvbid0IGJyZWFrDQo+ID4gdGhlIFBDSWUgZnVuY3Rpb24gZXZlbg0KPiA+IFJFU0VU
X0lNWDcgaXMgc2V0IHRvID1tIGluIGRlZmNvbmZpZywgYXMgd2hlbiBQQ0lfSU1YNiBpcyBlbmFi
bGVkIGFzDQo+ID4gPXksIFJFU0VUX0lNWDcgd2lsbCBiZSBhbHNvID15Lg0KPiANCj4gWWVzLCBJ
IHRoaW5rIHRoaXMgY2FuIHdvcmsgYXMgYSBzaG9ydC10ZXJtIHdvcmthcm91bmQsIHRob3VnaCBp
ZGVhbGx5IHRoZSBQQ0llDQo+IGRyaXZlciB3b3VsZCBhbHNvIGJlY29tZSBhIGxvYWRhYmxlIG1v
ZHVsZSBhbmQgYWxzbyBzdXBwb3J0IGRlZmVycmVkDQo+IHByb2JpbmcuDQo+IA0KPiBIYXZpbmcg
bG9hZGFibGUgUENJZSBkcml2ZXJzIGhhcyB0cmFkaXRpb25hbGx5IGJlZW4gcHJvYmxlbWF0aWMg
aW4gTGludXgsIGJ1dA0KPiBSb2IgSGVycmluZyBoYXMgcmVjZW50bHkgaW1wcm92ZWQgdGhpcyBp
biB0aGUgc2VyaWVzIGNvbnRhaW5pbmcgcGF0Y2gNCj4gMGM1OWMwNmE3YzkwICgiUENJOiBob3N0
LWdlbmVyaWM6IFN1cHBvcnQgYnVpbGRpbmcgYXMgbW9kdWxlcyIpLCB3aGljaCB3YXMNCj4gYWxz
byBpbnRlbmRlZCB0byBoZWxwIHdpdGggQW5kcm9pZCBHS0kuDQo+IA0KPiBBcyBpLk1YIHVzZXMg
dGhlIGRlc2lnbndhcmUgUENJIGNvcmUgc3VwcG9ydCwgdGhpcyBtYXkgcmVxdWlyZSBzb21lIG1v
cmUNCj4gY2hhbmdlcyBpbiBQQ0lFX0RXIGJlZm9yZSB0aGUgaS5NWCBzcGVjaWZpYyBwYXJ0IGNh
biBiZSBhIGxvYWRhYmxlIG1vZHVsZSwNCj4gYnV0IGl0IHNob3VsZCBubyBsb25nZXIgcmVxdWly
ZSBjaGFuZ2VzIHRvIHRoZSBQQ0kgY29yZSBjb2RlLiBUdXJuaW5nIHRoZSBkcml2ZXINCj4gaW50
byBhIGxvYWRhYmxlIG1vZHVsZSBpcyBwcm9iYWJseSBub3QgZXZlbiB0aGF0IGhhcmQsIGJ1dCBt
YWtpbmcgaXQgcG9zc2libGUNCj4gdG8gdW5sb2FkIGRlZmluaXRlbHkgcmVxdWlyZXMgYWRkaW5n
IGEgcHJvcGVyIC5yZW1vdmUgY2FsbGJhY2sgdG8gcHJvcGVybHkNCj4gdW5yZWdpc3RlciB0aGUg
UENJZSBob3N0IGJyaWRnZS4NCj4gDQo+IEkgYWxzbyBzZWUgYSBERUNMQVJFX1BDSV9GSVhVUCgp
IGFuZCBhIGZhdWx0IGhhbmRsZXIgaG9vayBpbiB0aGUgcGNpLWlteDYuYw0KPiBkcml2ZXIsIHdo
aWNoIHByb2JhYmx5IG5lZWQgdG8gZ2V0IG1vdmVkIGludG8gYSBzZXBhcmF0ZSBidWlsdC1pbiBm
aWxlIHdpdGggYQ0KPiBmZXcgY2hhbmdlcy4NCj4gDQo+IEFuZCB0aGVuIEkgbm90aWNlZCBhIGJ1
ZyBpbiB0aGUgZHJpdmVyOiBpdCBob29rcyB0aGUgYWJvcnQgaGFuZGxlciBmcm9tIGFuDQo+IGlu
aXRjYWxsIHdoZW5ldmVyIHRoZSBkcml2ZXIgaXMgYnVpbHQgaW50byB0aGUga2VybmVsLCByZWdh
cmRsZXNzIG9mIHdoaWNoDQo+IG1hY2hpbmUgaXQgaXMgYWN0dWFsbHkgcnVubmluZyBvbiENCj4g
DQo+IFJlZ2FyZGluZyBkZWZlcnJlciBwcm9iaW5nLCB0aGUgUENJZSBob3N0IGN1cnJlbnRseSBy
ZWxpZXMgb24gdGhlIGNsayBjb250cm9sbGVyLA0KPiB0aGUgcmVndWxhdG9yIGFuZCAob24gaW14
N2QpIHRoZSByZXNldCBkcml2ZXIgdG8gYmUgcHJvYmVkIGZpcnN0LiBJIHRoaW5rIG1ha2luZw0K
PiBpdCBzdXBwb3J0IGRlZmVycmVkIHByb2JpbmcgZm9yIGFsbCB0aHJlZSBzaG91bGQgYmUgc3Ry
YWlnaHRmb3J3YXJkLCBtb3N0DQo+IGltcG9ydGFudGx5IHRoaXMgbWVhbnMgbm90IHByaW50aW5n
IGFuIGVycm9yIGFuZCByZXR1cm5pbmcgLUVQUk9CRV9ERUZFUg0KPiB3aGVuIG5vdCBhbGwgZGVw
ZW5kZW5jaWVzIGFyZSB0aGVyZSB5ZXQuDQo+IA0KDQpUaGFua3MgZm9yIGRldGFpbGVkIGluZm8g
YWJvdXQgUENJIGxvYWRhYmxlIG1vZHVsZSBzdXBwb3J0LCBJIGNvcHkgb3VyIFBDSSBvd25lcg0K
aGVyZSB0byBoZWxwIG9uIHRoZSBzdXBwb3J0IG9mIGkuTVg2IFBDSWUgZHJpdmVyIHRvIHN1cHBv
cnQgbG9hZGFibGUgbW9kdWxlLiBNZWFud2hpbGUsDQppbiB0aGlzIHBhdGNoIHNlcmllcywgSSB3
aWxsIGFkZCB0aGUgc2hvcnQtdGVybSB3b3JrYXJvdW5kIGFzIEkgZGVzY3JpYmVkIHVwcGVyLCBh
bmQgdGhlbiByZW1vdmUNCnRoaXMgc2hvcnQtdGVybSB3b3JrYXJvdW5kIGVpdGhlciBpbiB0aGUg
aS5NWDYgUENJIGRyaXZlcidzIGxvYWRhYmxlIG1vZHVsZSBzdXBwb3J0IHBhdGNoIGxhdGVyDQpv
ciBhZGRpbmcgYSBuZXcgcGF0Y2ggaWYgbmVjZXNzYXJ5Lg0KDQpUaGFua3MsDQpBbnNvbg0K
