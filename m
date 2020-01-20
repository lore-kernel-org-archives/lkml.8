Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C4BC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 07:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E36D20882
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 07:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="WRUj/VEG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgATH7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 02:59:52 -0500
Received: from mail-eopbgr60112.outbound.protection.outlook.com ([40.107.6.112]:64270
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725872AbgATH7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 02:59:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLEk8JPQMxIxqwHTV9TRRZpq9JBUgXR2f0PDSbdIWeV2iaKUrx+Uxknw63oJWsNbgDRyZxDoW7EBkJS3n2QCldTJoW1Db8xRCcVU7QqW2OocHeeV8wlxOZAoUh4rUd1RjR8QCdQCFwm+KovfRpcQ763u4PpOMeoDFtgCLZc9lB43iLrYg+7mAsTPkaCeXmJCeb60Fj7Dqplgg6EXw5vE/ZQgoeyz8MUh17zz6xRqAhP8QDzXJSBnSmulrMJpNFFlYhOFz2hljwXd3pa2piBzKzY+t07+Tuv3xIHaTG5I3w4r/qoQ3Kdhx+9i36v0j27484K6p0ucAtiYcEJMSXk3KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I20ihGB+QcJLSprXuKuUDK3XggWeLGQfRMHzX7WNEdA=;
 b=gySq6j7OpnYLlBjOyuEX7CrMTNUEnQiPSJJsXJa5WK2WrITQrn/FBi+maD1fiKHCnOAYFV3+3J5OJoVbpuqzOcp6zHV5S0C9in6MJRAIQxSw8Bgit3mCQVOEqPYWbLu0WxseMHd2fo5RRY5k4XRWNjlerArAvPG/kFLEk/MLe2MoikHNu8vQfrM5ZBAhHqZ0aYEFUCNM26XahaQ+YyjHBj21MvEqjl8if3QQmsrukK8tKAhNsnYfOGDHwaYNGmgcKjc+xOGV9yAWY1M5meuJM+j0W+XNedpvBWvOtQEMsPEv5LxUMqL7Nel8get5+ggTstTETdtOGnDU4Y22t2qTWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I20ihGB+QcJLSprXuKuUDK3XggWeLGQfRMHzX7WNEdA=;
 b=WRUj/VEGweYsuzEb3lnBEylYLL1YfjPGrC2v52TcWH2xoW3D3/e3tCsSt06g3h6IGMU7u4953m26adDHaQOP0TdipCVf12CtP5/Lm/VpHRN/D4t/DAk4f6/pfy7tiaTjTs0Ysn8/xGF+JHyNfsjo6RvrQHIXqb5Um8IeX1IPCtU=
Received: from VI1PR05MB6845.eurprd05.prod.outlook.com (10.186.163.80) by
 VI1PR05MB3392.eurprd05.prod.outlook.com (10.170.237.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.24; Mon, 20 Jan 2020 07:59:46 +0000
Received: from VI1PR05MB6845.eurprd05.prod.outlook.com
 ([fe80::9192:77a8:62cf:c098]) by VI1PR05MB6845.eurprd05.prod.outlook.com
 ([fe80::9192:77a8:62cf:c098%3]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 07:59:46 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "sam@ravnborg.org" <sam@ravnborg.org>
CC:     "info@logictechno.com" <info@logictechno.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "j.bauer@endrich.com" <j.bauer@endrich.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>
Subject: Re: [PATCH v3 2/3] drm/panel: simple: add display timings for logic
 technologies displays
Thread-Topic: [PATCH v3 2/3] drm/panel: simple: add display timings for logic
 technologies displays
Thread-Index: AQHVzxQmuO2riiBZC0CHoF0hnCfH66fylqMAgACaXIA=
Date:   Mon, 20 Jan 2020 07:59:46 +0000
Message-ID: <7d4934675dee1bb4ecfbef551ea7c2e363a452de.camel@toradex.com>
References: <20200119220204.208751-1-marcel@ziswiler.com>
         <20200119220204.208751-2-marcel@ziswiler.com>
         <20200119224716.GA4703@ravnborg.org>
In-Reply-To: <20200119224716.GA4703@ravnborg.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marcel.ziswiler@toradex.com; 
x-originating-ip: [31.10.206.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7a4b58c-673b-4442-8d27-08d79d7eb77a
x-ms-traffictypediagnostic: VI1PR05MB3392:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB33924CA76191B4B8496B8103FB320@VI1PR05MB3392.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(39840400004)(376002)(346002)(136003)(396003)(199004)(189003)(6512007)(2906002)(966005)(76116006)(26005)(91956017)(6506007)(54906003)(478600001)(186003)(5660300002)(4326008)(7416002)(8936002)(6916009)(86362001)(8676002)(2616005)(81166006)(81156014)(71200400001)(66446008)(6486002)(66476007)(66556008)(64756008)(66946007)(44832011)(36756003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB3392;H:VI1PR05MB6845.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lxE43od1Y4/lCFU1JIa6c64ueGu0MgzxBeGnamuLQza5b0etTahGeJSKvdV5xKUiK8EjnLQH+r446zW+voBzPc4leI3vbPwPZQrFyAHHL5UdxPiNdik/6G2QUpn2NDvWXejeKEl3F/47YNkATtkAF6PpXKX3TQyyjCZIrudL6w784t1hOSgyaDWFX62PmcYm+4KbtbAL6exylSMMTzdKjU3fLcXL+khmjZWYT7z3BvM3jzjzXt88eXKOlYeC1MbXs/iElWyFVx/ovvOMzI8iuRwIRra7NoNbFYTIaSxuFTJEm+pOCrImsRMZCZ72JrBbT7z+aU96VRofBehuef5QuDbeJLELFXPQ3vbWKl3aLqqZ3vB/gbZZdG88NUNgVDaDJ801g/QnubNAKBFMRXXVintyNeK+ToXu5IBIiN125AV/6Z0nEXBTWqntUm6NdI40detzLfXjXUProllzXbtQzKaU+k74+Sz7lGlmCZ1Pnt/5WaMyaEdwh6y0FBxnvbWZDuyDG4oYxi6swNdj7gxu1w==
Content-Type: text/plain; charset="utf-8"
Content-ID: <76380504DE363E41B1C4126AD8F8E95A@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a4b58c-673b-4442-8d27-08d79d7eb77a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 07:59:46.3367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4kgk15Uh0vbLNt2bmcMs2nKuXB9T+s/1KE1aDofFIMoCGvueR+iG6MAVzAFv9RubgASoAQphDDP1ZQND8wJPi2LuAosr99hVe4nZuShdjcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3392
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2FtDQoNCk9uIFN1biwgMjAyMC0wMS0xOSBhdCAyMzo0NyArMDEwMCwgU2FtIFJhdm5ib3Jn
IHdyb3RlOg0KPiBIaSBNYXJjZWwuDQo+IA0KPiBPbiBTdW4sIEphbiAxOSwgMjAyMCBhdCAxMTow
MjowM1BNICswMTAwLCBNYXJjZWwgWmlzd2lsZXIgd3JvdGU6DQo+ID4gRnJvbTogTWFyY2VsIFpp
c3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQo+ID4gDQo+ID4gQWRkIGRpc3Bs
YXkgdGltaW5ncyBmb3IgdGhlIGZvbGxvd2luZyAzIGRpc3BsYXkgcGFuZWxzIG1hbnVmYWN0dXJl
ZA0KPiA+IGJ5DQo+ID4gTG9naWMgVGVjaG5vbG9naWVzIExpbWl0ZWQ6DQo+ID4gDQo+ID4gLSBM
VDE2MTAxMC0yTkhDIGUuZy4gYXMgZm91bmQgaW4gdGhlIFRvcmFkZXggQ2FwYWNpdGl2ZSBUb3Vj
aA0KPiA+IERpc3BsYXkNCj4gPiAgIDciIFBhcmFsbGVsIFsxXQ0KPiA+IC0gTFQxNjEwMTAtMk5I
UiBlLmcuIGFzIGZvdW5kIGluIHRoZSBUb3JhZGV4IFJlc2lzdGl2ZSBUb3VjaA0KPiA+IERpc3Bs
YXkgNyINCj4gPiAgIFBhcmFsbGVsIFsyXQ0KPiA+IC0gTFQxNzA0MTAtMldIQyBlLmcuIGFzIGZv
dW5kIGluIHRoZSBUb3JhZGV4IENhcGFjaXRpdmUgVG91Y2gNCj4gPiBEaXNwbGF5DQo+ID4gICAx
MC4xIiBMVkRTIFszXQ0KPiA+IA0KPiA+IFRob3NlIHBhbmVscyBtYXkgYWxzbyBiZSBkaXN0cmli
dXRlZCBieSBFbmRyaWNoIEJhdWVsZW1lbnRlDQo+ID4gVmVydHJpZWJzDQo+ID4gR21iSCBbNF0u
DQo+ID4gDQo+ID4gWzFdIA0KPiA+IGh0dHBzOi8vZG9jcy50b3JhZGV4LmNvbS8xMDQ0OTctNy1p
bmNoLXBhcmFsbGVsLWNhcGFjaXRpdmUtdG91Y2gtZGlzcGxheS04MDB4NDgwLWRhdGFzaGVldC5w
ZGYNCj4gPiBbMl0gDQo+ID4gaHR0cHM6Ly9kb2NzLnRvcmFkZXguY29tLzEwNDQ5OC03LWluY2gt
cGFyYWxsZWwtcmVzaXN0aXZlLXRvdWNoLWRpc3BsYXktODAweDQ4MC5wZGYNCj4gPiBbM10gDQo+
ID4gaHR0cHM6Ly9kb2NzLnRvcmFkZXguY29tLzEwNTk1Mi0xMC0xLWluY2gtbHZkcy1jYXBhY2l0
aXZlLXRvdWNoLWRpc3BsYXktMTI4MHg4MDAtZGF0YXNoZWV0LnBkZg0KPiA+IFs0XSANCj4gPiBo
dHRwczovL3d3dy5lbmRyaWNoLmNvbS9pc2k1MF9pc2kzMF90ZnQtZGlzcGxheXMvbHQxNzA0MTAt
MXdoY19pc2kzMA0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hcmNlbCBaaXN3aWxlciA8bWFy
Y2VsLnppc3dpbGVyQHRvcmFkZXguY29tPg0KPiA+IFJldmlld2VkLWJ5OiBQaGlsaXBwZSBTY2hl
bmtlciA8cGhpbGlwcGUuc2NoZW5rZXJAdG9yYWRleC5jb20+DQo+ID4gDQo+ID4gLS0tDQo+ID4g
DQo+ID4gQ2hhbmdlcyBpbiB2MzoNCj4gPiAtIEZpeCB0eXBvIGluIHBpeGVsY2xvY2sgZnJlcXVl
bmN5IGZvciBsdDE3MDQxMF8yd2hjIGFzIHJlY2VudGx5DQo+ID4gICBkaXNjb3ZlcmVkIGJ5IFBo
aWxpcHBlLg0KPiA+IA0KPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4gLSBBZGRlZCBQaGlsaXBwZSdz
IHJldmlld2VkLWJ5Lg0KPiA+IA0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vcGFuZWwvcGFuZWwtc2lt
cGxlLmMgfCA2NQ0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDY1IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL3BhbmVsL3BhbmVsLXNpbXBsZS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vcGFu
ZWwvcGFuZWwtc2ltcGxlLmMNCj4gPiBpbmRleCBkNmY3N2JjNDk0YzcuLjQxNDBlMGZhZmYwNiAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vcGFuZWwvcGFuZWwtc2ltcGxlLmMNCj4g
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vcGFuZWwvcGFuZWwtc2ltcGxlLmMNCj4gPiBAQCAtMjEw
Nyw2ICsyMTA3LDYyIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGFuZWxfZGVzYyBsZ19scDEyOXFl
ID0NCj4gPiB7DQo+ID4gIAl9LA0KPiA+ICB9Ow0KPiA+ICANCj4gPiArc3RhdGljIGNvbnN0IHN0
cnVjdCBkaXNwbGF5X3RpbWluZyBsb2dpY3RlY2hub19sdDE2MTAxMF8ybmhfdGltaW5nDQo+ID4g
PSB7DQo+ID4gKwkucGl4ZWxjbG9jayA9IHsgMjY0MDAwMDAsIDMzMzAwMDAwLCA0NjgwMDAwMCB9
LA0KPiA+ICsJLmhhY3RpdmUgPSB7IDgwMCwgODAwLCA4MDAgfSwNCj4gPiArCS5oZnJvbnRfcG9y
Y2ggPSB7IDE2LCAyMTAsIDM1NCB9LA0KPiA+ICsJLmhiYWNrX3BvcmNoID0geyA0NiwgNDYsIDQ2
IH0sDQo+ID4gKwkuaHN5bmNfbGVuID0geyAxLCAyMCwgNDAgfSwNCj4gPiArCS52YWN0aXZlID0g
eyA0ODAsIDQ4MCwgNDgwIH0sDQo+ID4gKwkudmZyb250X3BvcmNoID0geyA3LCAyMiwgMTQ3IH0s
DQo+ID4gKwkudmJhY2tfcG9yY2ggPSB7IDIzLCAyMywgMjMgfSwNCj4gPiArCS52c3luY19sZW4g
PSB7IDEsIDEwLCAyMCB9LA0KPiA+ICsJLmZsYWdzID0gRElTUExBWV9GTEFHU19IU1lOQ19MT1cg
fCBESVNQTEFZX0ZMQUdTX1ZTWU5DX0xPVyB8DQo+ID4gKwkJIERJU1BMQVlfRkxBR1NfREVfSElH
SCB8IERJU1BMQVlfRkxBR1NfUElYREFUQV9QT1NFREdFDQo+ID4gfA0KPiA+ICsJCSBESVNQTEFZ
X0ZMQUdTX1NZTkNfUE9TRURHRSwNCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBz
dHJ1Y3QgcGFuZWxfZGVzYyBsb2dpY3RlY2hub19sdDE2MTAxMF8ybmggPSB7DQo+ID4gKwkudGlt
aW5ncyA9ICZsb2dpY3RlY2hub19sdDE2MTAxMF8ybmhfdGltaW5nLA0KPiA+ICsJLm51bV90aW1p
bmdzID0gMSwNCj4gPiArCS5zaXplID0gew0KPiA+ICsJCS53aWR0aCA9IDE1NCwNCj4gPiArCQku
aGVpZ2h0ID0gODYsDQo+ID4gKwl9LA0KPiA+ICsJLmJ1c19mb3JtYXQgPSBNRURJQV9CVVNfRk1U
X1JHQjY2Nl8xWDE4LA0KPiA+ICsJLmJ1c19mbGFncyA9IERSTV9CVVNfRkxBR19ERV9ISUdIIHwN
Cj4gPiArCQkgICAgIERSTV9CVVNfRkxBR19QSVhEQVRBX1NBTVBMRV9ORUdFREdFIHwNCj4gPiAr
CQkgICAgIERSTV9CVVNfRkxBR19TWU5DX1NBTVBMRV9ORUdFREdFLA0KPiA+ICt9Ow0KPiBjb25u
ZWN0b3JfdHlwZSBuZWVkcyB0byBiZSBzcGVjaWZpZWQgZm9yIGFsbCBwYW5lbHMuDQo+IFRoaXMg
aXMgc29tZXRoaW5nIHdlIGhhdmUgYWRkZWQgcmVjZW50bHkgYW5kIGlzIHRvZGF5IG1hbmRhdG9y
eQ0KPiBmb3IgbmV3IHBhbmVsLXNpbXBsZSBwYW5lbHMuDQoNClNvcnJ5LCBmb3Jnb3QgYWJvdXQg
dGhhdCBvbmUuIFdpbGwgYWRkIGl0IGluIHY0Lg0KDQo+IEFsc28gcGxlYXNlIHJlLW9yZGVyIHNv
IHdlIGFkZCBiaW5kaW5ncyBiZWZvcmUgd2UgZHJpdmVyIHN1cHBvcnQgZm9yDQo+IHRoZSBwYW5l
bHMuDQo+IFRoaXMgbWFrZXMgY2hlY2twYXRjaCAoYW5kIG1lKSBtb3JlIGhhcHB5Lg0KDQpOb3Qg
dGhhdCBteSBjaGVja3BhdGNoIHdvdWxkIHdhcm4gbWUgYWJvdXQgdGhhdCBidXQga2luZGEgbWFr
ZXMgc2Vuc2UuDQoNCj4gT2hoLCBhbmQgYm9udXMgcG9pbnRzIGZvciB1c2luZyBkaXNwbGF5X3Rp
bWluZyBhbmQgc3BlY2lmeWluZw0KPiBtaW4sdHlwLG1heCB2YWx1ZXMuDQoNClRoYW5rcywgbWFu
Lg0KDQo+IAlTYW0NCg0KQ2hlZXJzDQoNCk1hcmNlbA0KDQo+ID4gKw0KPiA+ICtzdGF0aWMgY29u
c3Qgc3RydWN0IGRpc3BsYXlfdGltaW5nDQo+ID4gbG9naWN0ZWNobm9fbHQxNzA0MTBfMndoY190
aW1pbmcgPSB7DQo+ID4gKwkucGl4ZWxjbG9jayA9IHsgNjg5MDAwMDAsIDcxMTAwMDAwLCA3MzQw
MDAwMCB9LA0KPiA+ICsJLmhhY3RpdmUgPSB7IDEyODAsIDEyODAsIDEyODAgfSwNCj4gPiArCS5o
ZnJvbnRfcG9yY2ggPSB7IDIzLCA2MCwgNzEgfSwNCj4gPiArCS5oYmFja19wb3JjaCA9IHsgMjMs
IDYwLCA3MSB9LA0KPiA+ICsJLmhzeW5jX2xlbiA9IHsgMTUsIDQwLCA0NyB9LA0KPiA+ICsJLnZh
Y3RpdmUgPSB7IDgwMCwgODAwLCA4MDAgfSwNCj4gPiArCS52ZnJvbnRfcG9yY2ggPSB7IDUsIDcs
IDEwIH0sDQo+ID4gKwkudmJhY2tfcG9yY2ggPSB7IDUsIDcsIDEwIH0sDQo+ID4gKwkudnN5bmNf
bGVuID0geyA2LCA5LCAxMiB9LA0KPiA+ICsJLmZsYWdzID0gRElTUExBWV9GTEFHU19IU1lOQ19M
T1cgfCBESVNQTEFZX0ZMQUdTX1ZTWU5DX0xPVyB8DQo+ID4gKwkJIERJU1BMQVlfRkxBR1NfREVf
SElHSCB8IERJU1BMQVlfRkxBR1NfUElYREFUQV9QT1NFREdFDQo+ID4gfA0KPiA+ICsJCSBESVNQ
TEFZX0ZMQUdTX1NZTkNfUE9TRURHRSwNCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBjb25z
dCBzdHJ1Y3QgcGFuZWxfZGVzYyBsb2dpY3RlY2hub19sdDE3MDQxMF8yd2hjID0gew0KPiA+ICsJ
LnRpbWluZ3MgPSAmbG9naWN0ZWNobm9fbHQxNzA0MTBfMndoY190aW1pbmcsDQo+ID4gKwkubnVt
X3RpbWluZ3MgPSAxLA0KPiA+ICsJLnNpemUgPSB7DQo+ID4gKwkJLndpZHRoID0gMjE3LA0KPiA+
ICsJCS5oZWlnaHQgPSAxMzYsDQo+ID4gKwl9LA0KPiA+ICsJLmJ1c19mb3JtYXQgPSBNRURJQV9C
VVNfRk1UX1JHQjg4OF8xWDdYNF9TUFdHLA0KPiA+ICsJLmJ1c19mbGFncyA9IERSTV9CVVNfRkxB
R19ERV9ISUdIIHwNCj4gPiArCQkgICAgIERSTV9CVVNfRkxBR19QSVhEQVRBX1NBTVBMRV9ORUdF
REdFIHwNCj4gPiArCQkgICAgIERSTV9CVVNfRkxBR19TWU5DX1NBTVBMRV9ORUdFREdFLA0KPiA+
ICt9Ow0KPiA+ICsNCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBkcm1fZGlzcGxheV9tb2RlIG1p
dHN1YmlzaGlfYWEwNzBtYzAxX21vZGUgPSB7DQo+ID4gIAkuY2xvY2sgPSAzMDQwMCwNCj4gPiAg
CS5oZGlzcGxheSA9IDgwMCwNCj4gPiBAQCAtMzQxNyw2ICszNDczLDE1IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkDQo+ID4gcGxhdGZvcm1fb2ZfbWF0Y2hbXSA9IHsNCj4gPiAg
CX0sIHsNCj4gPiAgCQkuY29tcGF0aWJsZSA9ICJsb2dpY3BkLHR5cGUyOCIsDQo+ID4gIAkJLmRh
dGEgPSAmbG9naWNwZF90eXBlXzI4LA0KPiA+ICsJfSwgew0KPiA+ICsJCS5jb21wYXRpYmxlID0g
ImxvZ2ljdGVjaG5vLGx0MTYxMDEwLTJuaGMiLA0KPiA+ICsJCS5kYXRhID0gJmxvZ2ljdGVjaG5v
X2x0MTYxMDEwXzJuaCwNCj4gPiArCX0sIHsNCj4gPiArCQkuY29tcGF0aWJsZSA9ICJsb2dpY3Rl
Y2hubyxsdDE2MTAxMC0ybmhyIiwNCj4gPiArCQkuZGF0YSA9ICZsb2dpY3RlY2hub19sdDE2MTAx
MF8ybmgsDQo+ID4gKwl9LCB7DQo+ID4gKwkJLmNvbXBhdGlibGUgPSAibG9naWN0ZWNobm8sbHQx
NzA0MTAtMndoYyIsDQo+ID4gKwkJLmRhdGEgPSAmbG9naWN0ZWNobm9fbHQxNzA0MTBfMndoYywN
Cj4gPiAgCX0sIHsNCj4gPiAgCQkuY29tcGF0aWJsZSA9ICJtaXRzdWJpc2hpLGFhMDcwbWMwMS1j
YTEiLA0KPiA+ICAJCS5kYXRhID0gJm1pdHN1YmlzaGlfYWEwNzBtYzAxLA0KPiA+IC0tIA0KPiA+
IDIuMjQuMQ0K
