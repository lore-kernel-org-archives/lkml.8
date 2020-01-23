Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2763C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73DDF2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 13:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="XjJ5vS4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgAWNdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 08:33:45 -0500
Received: from mail-eopbgr50125.outbound.protection.outlook.com ([40.107.5.125]:14133
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726232AbgAWNdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 08:33:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpIb1Rj0KoJvsQSMvDlcHV/sPoOFKolIZShqhUHGnmpZZSILJI0UnCltI5LBup8oIeB/H7D1I3CSGOzrJeT+b9ZAlJME/8iv6D7mF8JEwP8fhQuq1iH1MI8vXfzghur/Z7rQ003CIC/8vv7OHKjxCzQbgc/6VJCjFOS2hHjLh91lZ0MYGz+XVdBihBZF/laKHPozdoyFfIx2UEEl+SkU1zT/2xsf83L2jagTgzdMzS3N9lVRruNYZvq1c/sw7txWEHDFV4PJ8gvIa3d2ftT/1vDdSPi7cm8TbNLd9RC1QQjHovAAGoEJbOVVZmziwWIDlnmwCEq2+uyDRZKNnPAWOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyGYRwUAdl76/dnRq7nb6vRVMIRVtsTopT3zpbP2Hoo=;
 b=KBA0KmegoK3JmgU2SBd8mjAxNId0Hf0DWIu7uyjiAg3pYr5W7SjCAhtoag5BVqSS/EotYH8EzurMAdtrsXUuKfMoPWd7ymdGVqmPvM8RBqkQPHzp87HunAXTQOa0wA0WKnIOXzQjHoN0MmuEBUmf0z/Ax/L2qlMyKZpRFKOBWlyIKcFU665uwSQEtr1Tg24zIM2nlfRrnvUeKVJ+UiyeDFS15Eg4RtIXY6VIep59lYAyqN0UvRwb4iQZBZI5T6wIgfJ5kq6lCisppC/s4GQRYwyRlQIgZle25F3suX4FCNSp2uL7V7KG9XoWxfmakRQ7ig9/vt4Xx6agyRcHd4ezXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyGYRwUAdl76/dnRq7nb6vRVMIRVtsTopT3zpbP2Hoo=;
 b=XjJ5vS4Sg9oX86kUAIDn3/RpC5tJ9yaAnekWBnDU0a/n6AA6/MtbprtZ9UKPXNUjJV47fiVuG4a9NGTkVFNDBgQ3QEt+nb6kUFcTT+xcGfx4/+/ZENsfxHJokxDRzbib8dHWaVco1M1Pdc3AD6Aa3QtDtGV3ZAWZ+oEHuUBsNnc=
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB6768.eurprd05.prod.outlook.com (10.186.163.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.28; Thu, 23 Jan 2020 13:33:38 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52%7]) with mapi id 15.20.2644.027; Thu, 23 Jan 2020
 13:33:37 +0000
Received: from mail-qk1-f175.google.com (209.85.222.175) by MN2PR01CA0008.prod.exchangelabs.com (2603:10b6:208:10c::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.19 via Frontend Transport; Thu, 23 Jan 2020 13:33:35 +0000
Received: by mail-qk1-f175.google.com with SMTP id c16so3381802qko.6;        Thu, 23 Jan 2020 05:33:34 -0800 (PST)
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     Marcel Ziswiler <marcel@ziswiler.com>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "info@logictechno.com" <info@logictechno.com>,
        "j.bauer@endrich.com" <j.bauer@endrich.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Subject: Re: [PATCH v4 3/3] drm/panel: simple: add display timings for logic
 technologies displays
Thread-Topic: [PATCH v4 3/3] drm/panel: simple: add display timings for logic
 technologies displays
Thread-Index: AQHV0fGspUwBsIOC+UqtQgRpcBDVdg==
Date:   Thu, 23 Jan 2020 13:33:35 +0000
Message-ID: <CAGgjyvH1TPgVevuXyjY-m-+gxokTZHf84bHLRxtm=v4gDnz2xQ@mail.gmail.com>
References: <20200120080100.170294-1-marcel@ziswiler.com>
 <20200120080100.170294-3-marcel@ziswiler.com>
In-Reply-To: <20200120080100.170294-3-marcel@ziswiler.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR01CA0008.prod.exchangelabs.com (2603:10b6:208:10c::21)
 To VI1PR05MB3279.eurprd05.prod.outlook.com (2603:10a6:802:1c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-gm-message-state: APjAAAXocjX3Lq8TW1wTaENSEa/oh9Dny3r53hr0KdRa3N2JJ2f+/zN4
        B5M3aas2LxGv2sqeAdhlSOPcltPKXNtXhln3s4s=
x-google-smtp-source: APXvYqzXleXgx8VP42yU4MjCDPR0mp2ou+BKiHP60Ca9SQfsUq2Yh11AaCQGH7/c7GbRFGHccrzRgt4kRsho3OmaGcw=
x-received: by 2002:a37:8ac4:: with SMTP id
 m187mr15707564qkd.277.1579786410499; Thu, 23 Jan 2020 05:33:30 -0800 (PST)
x-gmail-original-message-id: <CAGgjyvH1TPgVevuXyjY-m-+gxokTZHf84bHLRxtm=v4gDnz2xQ@mail.gmail.com>
x-originating-ip: [209.85.222.175]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5de98825-7d11-48d1-886e-08d7a008d895
x-ms-traffictypediagnostic: VI1PR05MB6768:
x-microsoft-antispam-prvs: <VI1PR05MB6768ADD570A2BB28DA2D4551F90F0@VI1PR05MB6768.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39840400004)(396003)(136003)(346002)(366004)(376002)(199004)(189003)(8936002)(26005)(52116002)(186003)(53546011)(54906003)(42186006)(71200400001)(8676002)(316002)(44832011)(6862004)(107886003)(9686003)(4326008)(450100002)(66446008)(66476007)(66556008)(64756008)(86362001)(55446002)(966005)(81166006)(81156014)(2906002)(66946007)(478600001)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB6768;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1f64N4JpWM9v8QbDoPZ0b/RrAr7Dh9gBoKw16bQQTubyj1hjgf4dWSL3KoDcRNe/F5J8BnmYWE+0hVyKn4+C6gYdXD953Gnr6U0SOVh9eYI60wthEP4XDHdaPoQVx/BhrfjZG7JBFIo+akLWfdTZjf7SSyJA77yHLAf/er6y+j+cKhv3xBF9U3KBsA5cSBKoOz9Prj37ICc1y48tbjOqDSaYx4h4FA2BubAaXfixcEDYB9y5wVPzhvCyiP8x8jyu9QfgapO5ZR4avPcpGTDEI2xsjtLZyXtANLjiLfg2zFMbJLUf+rSPk9H6EEl9/2/fYyjF2tcQNXmknFORrnTujg+tClzqBvfcNEwx3GhNPLrEWG/+Ss+BJCSS0RTeJ7ZWu83YMF3qro/U+13X9Bi6BWDv8JFnYuhCK8L0MtXMrYMO/7809yrYJS5mFQhZvClN6xN0/cRLFu1tsEobQ6+DKUX+cXqOTwZKsof2DwYww50=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9DD465BEB3D5A45A993C2D00849BCDC@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de98825-7d11-48d1-886e-08d7a008d895
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 13:33:35.2124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y5Xtc3s1aLQZAJIo82UqP0egS9k8zUJtAoecUgsHbTPiuT46IWra3e/OmaMd8lNVmTiVYfC6/p9hog1rPx1ERhQvtxP96SN+aV7hvV7x/lE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6768
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBKYW4gMjAsIDIwMjAgYXQgMTA6MDIgQU0gTWFyY2VsIFppc3dpbGVyIDxtYXJjZWxA
emlzd2lsZXIuY29tPiB3cm90ZToNCj4NCj4gRnJvbTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwu
emlzd2lsZXJAdG9yYWRleC5jb20+DQo+DQo+IEFkZCBkaXNwbGF5IHRpbWluZ3MgZm9yIHRoZSBm
b2xsb3dpbmcgMyBkaXNwbGF5IHBhbmVscyBtYW51ZmFjdHVyZWQgYnkNCj4gTG9naWMgVGVjaG5v
bG9naWVzIExpbWl0ZWQ6DQo+DQo+IC0gTFQxNjEwMTAtMk5IQyBlLmcuIGFzIGZvdW5kIGluIHRo
ZSBUb3JhZGV4IENhcGFjaXRpdmUgVG91Y2ggRGlzcGxheQ0KPiAgIDciIFBhcmFsbGVsIFsxXQ0K
PiAtIExUMTYxMDEwLTJOSFIgZS5nLiBhcyBmb3VuZCBpbiB0aGUgVG9yYWRleCBSZXNpc3RpdmUg
VG91Y2ggRGlzcGxheSA3Ig0KPiAgIFBhcmFsbGVsIFsyXQ0KPiAtIExUMTcwNDEwLTJXSEMgZS5n
LiBhcyBmb3VuZCBpbiB0aGUgVG9yYWRleCBDYXBhY2l0aXZlIFRvdWNoIERpc3BsYXkNCj4gICAx
MC4xIiBMVkRTIFszXQ0KPg0KPiBUaG9zZSBwYW5lbHMgbWF5IGFsc28gYmUgZGlzdHJpYnV0ZWQg
YnkgRW5kcmljaCBCYXVlbGVtZW50ZSBWZXJ0cmllYnMNCj4gR21iSCBbNF0uDQo+DQo+IFsxXSBo
dHRwczovL2RvY3MudG9yYWRleC5jb20vMTA0NDk3LTctaW5jaC1wYXJhbGxlbC1jYXBhY2l0aXZl
LXRvdWNoLWRpc3BsYXktODAweDQ4MC1kYXRhc2hlZXQucGRmDQo+IFsyXSBodHRwczovL2RvY3Mu
dG9yYWRleC5jb20vMTA0NDk4LTctaW5jaC1wYXJhbGxlbC1yZXNpc3RpdmUtdG91Y2gtZGlzcGxh
eS04MDB4NDgwLnBkZg0KPiBbM10gaHR0cHM6Ly9kb2NzLnRvcmFkZXguY29tLzEwNTk1Mi0xMC0x
LWluY2gtbHZkcy1jYXBhY2l0aXZlLXRvdWNoLWRpc3BsYXktMTI4MHg4MDAtZGF0YXNoZWV0LnBk
Zg0KPiBbNF0gaHR0cHM6Ly93d3cuZW5kcmljaC5jb20vaXNpNTBfaXNpMzBfdGZ0LWRpc3BsYXlz
L2x0MTcwNDEwLTF3aGNfaXNpMzANCj4NCj4gU2lnbmVkLW9mZi1ieTogTWFyY2VsIFppc3dpbGVy
IDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQo+IFJldmlld2VkLWJ5OiBQaGlsaXBwZSBT
Y2hlbmtlciA8cGhpbGlwcGUuc2NoZW5rZXJAdG9yYWRleC5jb20+DQoNClJldmlld2VkLWJ5OiBP
bGVrc2FuZHIgU3V2b3JvdiA8b2xla3NhbmRyLnN1dm9yb3ZAdG9yYWRleC5jb20+DQoNCj4NCj4g
LS0tDQo+DQo+IENoYW5nZXMgaW4gdjQ6DQo+IC0gQWRkZWQgcmVjZW50bHkgbWFkZSBtYW5kYXRv
cnkgY29ubmVjdG9yX3R5cGUgaW5mb3JtYXRpb24gYXMgcG9pbnRlZA0KPiAgIG91dCBieSBTYW0u
DQo+DQo+IENoYW5nZXMgaW4gdjM6DQo+IC0gRml4IHR5cG8gaW4gcGl4ZWxjbG9jayBmcmVxdWVu
Y3kgZm9yIGx0MTcwNDEwXzJ3aGMgYXMgcmVjZW50bHkNCj4gICBkaXNjb3ZlcmVkIGJ5IFBoaWxp
cHBlLg0KPg0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIEFkZGVkIFBoaWxpcHBlJ3MgcmV2aWV3ZWQt
YnkuDQo+DQo+ICBkcml2ZXJzL2dwdS9kcm0vcGFuZWwvcGFuZWwtc2ltcGxlLmMgfCA2NyArKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNjcgaW5zZXJ0aW9u
cygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3BhbmVsL3BhbmVsLXNpbXBs
ZS5jIGIvZHJpdmVycy9ncHUvZHJtL3BhbmVsL3BhbmVsLXNpbXBsZS5jDQo+IGluZGV4IGQ2Zjc3
YmM0OTRjNy4uYTBkZDg0ZTExZGI3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcGFu
ZWwvcGFuZWwtc2ltcGxlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3BhbmVsL3BhbmVsLXNp
bXBsZS5jDQo+IEBAIC0yMTA3LDYgKzIxMDcsNjQgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwYW5l
bF9kZXNjIGxnX2xwMTI5cWUgPSB7DQo+ICAgICAgICAgfSwNCj4gIH07DQo+DQo+ICtzdGF0aWMg
Y29uc3Qgc3RydWN0IGRpc3BsYXlfdGltaW5nIGxvZ2ljdGVjaG5vX2x0MTYxMDEwXzJuaF90aW1p
bmcgPSB7DQo+ICsgICAgICAgLnBpeGVsY2xvY2sgPSB7IDI2NDAwMDAwLCAzMzMwMDAwMCwgNDY4
MDAwMDAgfSwNCj4gKyAgICAgICAuaGFjdGl2ZSA9IHsgODAwLCA4MDAsIDgwMCB9LA0KPiArICAg
ICAgIC5oZnJvbnRfcG9yY2ggPSB7IDE2LCAyMTAsIDM1NCB9LA0KPiArICAgICAgIC5oYmFja19w
b3JjaCA9IHsgNDYsIDQ2LCA0NiB9LA0KPiArICAgICAgIC5oc3luY19sZW4gPSB7IDEsIDIwLCA0
MCB9LA0KPiArICAgICAgIC52YWN0aXZlID0geyA0ODAsIDQ4MCwgNDgwIH0sDQo+ICsgICAgICAg
LnZmcm9udF9wb3JjaCA9IHsgNywgMjIsIDE0NyB9LA0KPiArICAgICAgIC52YmFja19wb3JjaCA9
IHsgMjMsIDIzLCAyMyB9LA0KPiArICAgICAgIC52c3luY19sZW4gPSB7IDEsIDEwLCAyMCB9LA0K
PiArICAgICAgIC5mbGFncyA9IERJU1BMQVlfRkxBR1NfSFNZTkNfTE9XIHwgRElTUExBWV9GTEFH
U19WU1lOQ19MT1cgfA0KPiArICAgICAgICAgICAgICAgIERJU1BMQVlfRkxBR1NfREVfSElHSCB8
IERJU1BMQVlfRkxBR1NfUElYREFUQV9QT1NFREdFIHwNCj4gKyAgICAgICAgICAgICAgICBESVNQ
TEFZX0ZMQUdTX1NZTkNfUE9TRURHRSwNCj4gK307DQo+ICsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1
Y3QgcGFuZWxfZGVzYyBsb2dpY3RlY2hub19sdDE2MTAxMF8ybmggPSB7DQo+ICsgICAgICAgLnRp
bWluZ3MgPSAmbG9naWN0ZWNobm9fbHQxNjEwMTBfMm5oX3RpbWluZywNCj4gKyAgICAgICAubnVt
X3RpbWluZ3MgPSAxLA0KPiArICAgICAgIC5zaXplID0gew0KPiArICAgICAgICAgICAgICAgLndp
ZHRoID0gMTU0LA0KPiArICAgICAgICAgICAgICAgLmhlaWdodCA9IDg2LA0KPiArICAgICAgIH0s
DQo+ICsgICAgICAgLmJ1c19mb3JtYXQgPSBNRURJQV9CVVNfRk1UX1JHQjY2Nl8xWDE4LA0KPiAr
ICAgICAgIC5idXNfZmxhZ3MgPSBEUk1fQlVTX0ZMQUdfREVfSElHSCB8DQo+ICsgICAgICAgICAg
ICAgICAgICAgIERSTV9CVVNfRkxBR19QSVhEQVRBX1NBTVBMRV9ORUdFREdFIHwNCj4gKyAgICAg
ICAgICAgICAgICAgICAgRFJNX0JVU19GTEFHX1NZTkNfU0FNUExFX05FR0VER0UsDQo+ICsgICAg
ICAgLmNvbm5lY3Rvcl90eXBlID0gRFJNX01PREVfQ09OTkVDVE9SX0RQSSwNCj4gK307DQo+ICsN
Cj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZGlzcGxheV90aW1pbmcgbG9naWN0ZWNobm9fbHQxNzA0
MTBfMndoY190aW1pbmcgPSB7DQo+ICsgICAgICAgLnBpeGVsY2xvY2sgPSB7IDY4OTAwMDAwLCA3
MTEwMDAwMCwgNzM0MDAwMDAgfSwNCj4gKyAgICAgICAuaGFjdGl2ZSA9IHsgMTI4MCwgMTI4MCwg
MTI4MCB9LA0KPiArICAgICAgIC5oZnJvbnRfcG9yY2ggPSB7IDIzLCA2MCwgNzEgfSwNCj4gKyAg
ICAgICAuaGJhY2tfcG9yY2ggPSB7IDIzLCA2MCwgNzEgfSwNCj4gKyAgICAgICAuaHN5bmNfbGVu
ID0geyAxNSwgNDAsIDQ3IH0sDQo+ICsgICAgICAgLnZhY3RpdmUgPSB7IDgwMCwgODAwLCA4MDAg
fSwNCj4gKyAgICAgICAudmZyb250X3BvcmNoID0geyA1LCA3LCAxMCB9LA0KPiArICAgICAgIC52
YmFja19wb3JjaCA9IHsgNSwgNywgMTAgfSwNCj4gKyAgICAgICAudnN5bmNfbGVuID0geyA2LCA5
LCAxMiB9LA0KPiArICAgICAgIC5mbGFncyA9IERJU1BMQVlfRkxBR1NfSFNZTkNfTE9XIHwgRElT
UExBWV9GTEFHU19WU1lOQ19MT1cgfA0KPiArICAgICAgICAgICAgICAgIERJU1BMQVlfRkxBR1Nf
REVfSElHSCB8IERJU1BMQVlfRkxBR1NfUElYREFUQV9QT1NFREdFIHwNCj4gKyAgICAgICAgICAg
ICAgICBESVNQTEFZX0ZMQUdTX1NZTkNfUE9TRURHRSwNCj4gK307DQo+ICsNCj4gK3N0YXRpYyBj
b25zdCBzdHJ1Y3QgcGFuZWxfZGVzYyBsb2dpY3RlY2hub19sdDE3MDQxMF8yd2hjID0gew0KPiAr
ICAgICAgIC50aW1pbmdzID0gJmxvZ2ljdGVjaG5vX2x0MTcwNDEwXzJ3aGNfdGltaW5nLA0KPiAr
ICAgICAgIC5udW1fdGltaW5ncyA9IDEsDQo+ICsgICAgICAgLnNpemUgPSB7DQo+ICsgICAgICAg
ICAgICAgICAud2lkdGggPSAyMTcsDQo+ICsgICAgICAgICAgICAgICAuaGVpZ2h0ID0gMTM2LA0K
PiArICAgICAgIH0sDQo+ICsgICAgICAgLmJ1c19mb3JtYXQgPSBNRURJQV9CVVNfRk1UX1JHQjg4
OF8xWDdYNF9TUFdHLA0KPiArICAgICAgIC5idXNfZmxhZ3MgPSBEUk1fQlVTX0ZMQUdfREVfSElH
SCB8DQo+ICsgICAgICAgICAgICAgICAgICAgIERSTV9CVVNfRkxBR19QSVhEQVRBX1NBTVBMRV9O
RUdFREdFIHwNCj4gKyAgICAgICAgICAgICAgICAgICAgRFJNX0JVU19GTEFHX1NZTkNfU0FNUExF
X05FR0VER0UsDQo+ICsgICAgICAgLmNvbm5lY3Rvcl90eXBlID0gRFJNX01PREVfQ09OTkVDVE9S
X0xWRFMsDQo+ICt9Ow0KPiArDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGRybV9kaXNwbGF5X21v
ZGUgbWl0c3ViaXNoaV9hYTA3MG1jMDFfbW9kZSA9IHsNCj4gICAgICAgICAuY2xvY2sgPSAzMDQw
MCwNCj4gICAgICAgICAuaGRpc3BsYXkgPSA4MDAsDQo+IEBAIC0zNDE3LDYgKzM0NzUsMTUgQEAg
c3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgcGxhdGZvcm1fb2ZfbWF0Y2hbXSA9IHsN
Cj4gICAgICAgICB9LCB7DQo+ICAgICAgICAgICAgICAgICAuY29tcGF0aWJsZSA9ICJsb2dpY3Bk
LHR5cGUyOCIsDQo+ICAgICAgICAgICAgICAgICAuZGF0YSA9ICZsb2dpY3BkX3R5cGVfMjgsDQo+
ICsgICAgICAgfSwgew0KPiArICAgICAgICAgICAgICAgLmNvbXBhdGlibGUgPSAibG9naWN0ZWNo
bm8sbHQxNjEwMTAtMm5oYyIsDQo+ICsgICAgICAgICAgICAgICAuZGF0YSA9ICZsb2dpY3RlY2hu
b19sdDE2MTAxMF8ybmgsDQo+ICsgICAgICAgfSwgew0KPiArICAgICAgICAgICAgICAgLmNvbXBh
dGlibGUgPSAibG9naWN0ZWNobm8sbHQxNjEwMTAtMm5ociIsDQo+ICsgICAgICAgICAgICAgICAu
ZGF0YSA9ICZsb2dpY3RlY2hub19sdDE2MTAxMF8ybmgsDQo+ICsgICAgICAgfSwgew0KPiArICAg
ICAgICAgICAgICAgLmNvbXBhdGlibGUgPSAibG9naWN0ZWNobm8sbHQxNzA0MTAtMndoYyIsDQo+
ICsgICAgICAgICAgICAgICAuZGF0YSA9ICZsb2dpY3RlY2hub19sdDE3MDQxMF8yd2hjLA0KPiAg
ICAgICAgIH0sIHsNCj4gICAgICAgICAgICAgICAgIC5jb21wYXRpYmxlID0gIm1pdHN1YmlzaGks
YWEwNzBtYzAxLWNhMSIsDQo+ICAgICAgICAgICAgICAgICAuZGF0YSA9ICZtaXRzdWJpc2hpX2Fh
MDcwbWMwMSwNCj4gLS0NCj4gMi4yNC4xDQo+DQoNCg0KLS0gDQpCZXN0IHJlZ2FyZHMNCk9sZWtz
YW5kciBTdXZvcm92DQoNClRvcmFkZXggQUcNCkFsdHNhZ2Vuc3RyYXNzZSA1IHwgNjA0OCBIb3J3
L0x1emVybiB8IFN3aXR6ZXJsYW5kIHwgVDogKzQxIDQxIDUwMA0KNDgwMCAobWFpbiBsaW5lKQ0K
