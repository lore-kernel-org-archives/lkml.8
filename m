Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9FAC352A3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 01:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817BB217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 01:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="i/cpUyW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgBNBiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 20:38:23 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:34694 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727955AbgBNBiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 20:38:23 -0500
X-UUID: 3bebf97938a347dfbe3bb985de5a0960-20200214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=rlKuzW4diMmgRHJCFOcdYIyGjI8QXvrkxtJYUjmKrRI=;
        b=i/cpUyW2FKdLtqSDSOl1SZTdQoN61lxXUfGvYBleaKBiCevJqZntld5b+XNi1dge/c8+OUvUcsLgzuiNDHoYd7aU+M/UKQh8muNHkHO/vmzJEuk8ElaP1kBLRiDCNgF0dqBiclc3BfdETh5+ie31N/ZaqeKO9DV/ATNHeXLLucU=;
X-UUID: 3bebf97938a347dfbe3bb985de5a0960-20200214
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <nick.fan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 484479799; Fri, 14 Feb 2020 09:38:13 +0800
Received: from MTKMBS01N1.mediatek.inc (172.21.101.68) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 14 Feb 2020 09:37:23 +0800
Received: from MTKMBS01N1.mediatek.inc ([fe80::7931:498c:8d17:a7e3]) by
 mtkmbs01n1.mediatek.inc ([fe80::7931:498c:8d17:a7e3%14]) with mapi id
 15.00.1395.000; Fri, 14 Feb 2020 09:37:05 +0800
From:   =?utf-8?B?TmljayBGYW4gKOiMg+WTsue2rSk=?= <Nick.Fan@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?utf-8?B?V2VpeWkgTHUgKOWRguWogeWEgCk=?= <Weiyi.Lu@mediatek.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-arm Mailing List" <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "Hsin-Yi Wang" <hsinyi@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Viresh Kumar" <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        =?utf-8?B?SkIgVHNhaSAo6JSh5b+X5b2sKQ==?= <Jb.Tsai@mediatek.com>,
        =?utf-8?B?U2ogSHVhbmcgKOm7g+S/oeeSiyk=?= <sj.huang@mediatek.com>
Subject: RE: [PATCH v4 7/7] RFC: drm/panfrost: devfreq: Add support for 2
 regulators
Thread-Topic: [PATCH v4 7/7] RFC: drm/panfrost: devfreq: Add support for 2
 regulators
Thread-Index: AQHV4kNS333tYWdPVk+gNh7pvriDuqgZ4bGQ
Date:   Fri, 14 Feb 2020 01:37:05 +0000
Message-ID: <e4e95aa7713344e8b43fe5fad05de3ee@mtkmbs01n1.mediatek.inc>
References: <20200207052627.130118-1-drinkcat@chromium.org>
 <20200207052627.130118-8-drinkcat@chromium.org>
 <CANMq1KBL-S2DVKbCB2h_XNpfUro+pZ96-C5ft0p-8GX_tbXELQ@mail.gmail.com>
 <CAL_JsqLuo+2G2MjiwS9cwNhMV2pGBojXFGNqEfLv3fP-Y04mfA@mail.gmail.com>
 <CANMq1KCn5rrOrv2GjFh5Aau5Los4VVk=NMWAsvZiNuwoxyMVHA@mail.gmail.com>
In-Reply-To: <CANMq1KCn5rrOrv2GjFh5Aau5Los4VVk=NMWAsvZiNuwoxyMVHA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbXRrMTQ1MzNcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1hN2U0ZmNiNC00ZWNhLTExZWEtYjYwNS03MDIwODQwMTBjNWNcYW1lLXRlc3RcYTdlNGZjYjYtNGVjYS0xMWVhLWI2MDUtNzAyMDg0MDEwYzVjYm9keS50eHQiIHN6PSI0NzkzIiB0PSIxMzIyNjExNzg5MDU1Mzk5OTQiIGg9ImZtSDdQQ0ZJQTVWaVE2MkdWN0lReHFWYi9XUT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: =?utf-8?B?5IyA5r2s5pWz5LWJ5p2z5pWT542z5r2p5IGuNA==?=
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.21.101.239]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

K0pCIGFuZCBTSiBmb3IgaW5mbyBzeW5jDQoNCkhpIE5pY29sYXMsDQoNClBsZWFzZSBzZWUgbXkg
aW5saW5lIHJlcGx5Lg0KVGhhbmtzDQoNCkhpIFdlaXlpLA0KDQpDb3VsZCB5b3UgcGxlYXNlIGhl
bHAgdG8gY29tbWVudCBvbiB0aGUgc2Vjb25kIHF1ZXN0aW9uPw0KVGhhbmtzDQoNCldhcm1lc3Qg
cmVnYXJkcywNCk5pY2sgRmFuIOiMg+WTsue2rQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KRnJvbTogTmljb2xhcyBCb2ljaGF0IFttYWlsdG86ZHJpbmtjYXRAY2hyb21pdW0ub3JnXSAN
ClNlbnQ6IFRodXJzZGF5LCBGZWJydWFyeSAxMywgMjAyMCAzOjU4IFBNDQpUbzogUm9iIEhlcnJp
bmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IFdlaXlpIEx1ICjlkYLlqIHlhIApIDxXZWl5aS5MdUBt
ZWRpYXRlay5jb20+OyBOaWNrIEZhbiAo6IyD5ZOy57atKSA8Tmljay5GYW5AbWVkaWF0ZWsuY29t
Pg0KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT47IERhbmllbCBWZXR0ZXIgPGRh
bmllbEBmZndsbC5jaD47IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBNYXR0
aGlhcyBCcnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPjsgVG9tZXUgVml6b3NvIDx0b21l
dS52aXpvc29AY29sbGFib3JhLmNvbT47IFN0ZXZlbiBQcmljZSA8c3RldmVuLnByaWNlQGFybS5j
b20+OyBBbHlzc2EgUm9zZW56d2VpZyA8YWx5c3NhLnJvc2VuendlaWdAY29sbGFib3JhLmNvbT47
IExpYW0gR2lyZHdvb2QgPGxnaXJkd29vZEBnbWFpbC5jb20+OyBNYXJrIEJyb3duIDxicm9vbmll
QGtlcm5lbC5vcmc+OyBkcmktZGV2ZWwgPGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+
OyBEZXZpY2V0cmVlIExpc3QgPGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsgbGttbCA8bGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LWFybSBNYWlsaW5nIExpc3QgPGxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47IG1vZGVyYXRlZCBsaXN0OkFSTS9NZWRp
YXRlayBTb0Mgc3VwcG9ydCA8bGludXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZz47IEhz
aW4tWWkgV2FuZyA8aHNpbnlpQGNocm9taXVtLm9yZz47IFVsZiBIYW5zc29uIDx1bGYuaGFuc3Nv
bkBsaW5hcm8ub3JnPjsgVmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9yZz47IFN0
ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgNy83
XSBSRkM6IGRybS9wYW5mcm9zdDogZGV2ZnJlcTogQWRkIHN1cHBvcnQgZm9yIDIgcmVndWxhdG9y
cw0KDQorV2VpeWkgTHUgK05pY2sgRmFuIEBNVEsgd2hvIG1heSBoYXZlIG1vcmUgaWRlYXMuDQoN
Ck9uIFRodSwgRmViIDEzLCAyMDIwIGF0IDI6MTQgQU0gUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+DQo+IE9uIFdlZCwgRmViIDEyLCAyMDIwIGF0IDI6NDkgQU0gTmlj
b2xhcyBCb2ljaGF0IDxkcmlua2NhdEBjaHJvbWl1bS5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gK1Zp
cmVzaCBLdW1hciArU3RlcGhlbiBCb3lkIGZvciBjbG9jayBhZHZpY2UuDQo+ID4NCj4gPiBPbiBG
cmksIEZlYiA3LCAyMDIwIGF0IDE6MjcgUE0gTmljb2xhcyBCb2ljaGF0IDxkcmlua2NhdEBjaHJv
bWl1bS5vcmc+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IFRoZSBCaWZyb3N0IEdQVSBvbiBNVDgxODMg
dXNlcyAyIHJlZ3VsYXRvcnMgKGNvcmUgYW5kIFNSQU0pIGZvciANCj4gPiA+IGRldmZyZXEsIGFu
ZCBwcm92aWRlcyBPUFAgdGFibGUgd2l0aCAyIHNldHMgb2Ygdm9sdGFnZXMuDQo+ID4gPg0KPiA+
ID4gVE9ETzogVGhpcyBpcyBpbmNvbXBsZXRlIGFzIHdlJ2xsIG5lZWQgYWRkIHN1cHBvcnQgZm9y
IHNldHRpbmcgYSANCj4gPiA+IHBhaXIgb2Ygdm9sdGFnZXMgYXMgd2VsbC4NCj4gPg0KPiA+IFNv
IGFsbCB3ZSBuZWVkIGZvciB0aGlzIHRvIHdvcmsgKGF0IGxlYXN0IGFwcGFyZW50bHksIHRoYXQg
aXMsIEkgY2FuIA0KPiA+IGNoYW5nZSBmcmVxdWVuY3kpIGlzIHRoaXM6DQo+ID4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvcGF0Y2h3b3JrL3BhdGNoLzExOTI5NDUvDQo+ID4gKGFoIHdlbGwsIFZp
cmVzaCBqdXN0IHJlcGxpZWQsIHNvLCBwcm9iYWJseSBub3QsIEknbGwgY2hlY2sgdGhhdCBvdXQg
DQo+ID4gYW5kIHVzZSB0aGUgY29ycmVjdCBBUEkpDQo+ID4NCj4gPiBCdXQgdGhlbiB0aGVyZSdz
IGEgc2xpZ2h0IHByb2JsZW06IHBhbmZyb3N0X2RldmZyZXEgdXNlcyBhIGJ1bmNoIG9mIA0KPiA+
IGNsa19nZXRfcmF0ZSBjYWxscywgYW5kIHRoZSBjbG9jayBQTExzIChhdCBsZWFzdCBvbiBNVEsg
cGxhdGZvcm0pIA0KPiA+IGFyZSBuZXZlciBmdWxseSBwcmVjaXNlLCBzbyB3ZSBnZXQgYmFjayAy
OTk5OTk5NTUgZm9yIDMwMCBNaHogYW5kDQo+ID4gNzk5OTk5ODc4IGZvciA4MDAgTWh6LiBUaGF0
IG1lYW5zIHRoYXQgdGhlIGtlcm5lbCBpcyB1bmFibGUgdG8ga2VlcCANCj4gPiBkZXZmcmVxIHN0
YXRzIGFzIG5laXRoZXIgb2YgdGhlc2UgdmFsdWVzIGFyZSBpbiB0aGUgdGFibGU6DQo+ID4gWyA0
ODAyLjQ3MDk1Ml0gZGV2ZnJlcSBkZXZmcmVxMTogQ291bGRuJ3QgdXBkYXRlIGZyZXF1ZW5jeSAN
Cj4gPiB0cmFuc2l0aW9uIGluZm9ybWF0aW9uLg0KPiA+IFRoZSBrYmFzZSBkcml2ZXIgZml4ZXMg
dGhpcyBieSByZW1lbWJlcmluZyB0aGUgbGFzdCBzZXQgZnJlcXVlbmN5LCANCj4gPiBhbmQgcmVw
b3J0aW5nIHRoYXQgdG8gZGV2ZnJlcS4gU2hvdWxkIHdlIGRvIHRoYXQgYXMgd2VsbCBvciBpcyB0
aGVyZSANCj4gPiBhIGJldHRlciBmaXg/DQo+ID4NCj4gPiBBbm90aGVyIHRoaW5nIHRoYXQgSSdt
IG5vdCBpbXBsZW1lbnRpbmcgaXMgdGhlIGRhbmNlIHRoYXQgTWVkaWF0ZWsgDQo+ID4gZG9lcyBp
biB0aGVpciBrYmFzZSBkcml2ZXIgd2hlbiBjaGFuZ2luZyB0aGUgY2xvY2sgKGRlc2NyaWJlZCBp
biANCj4gPiBwYXRjaA0KPiA+IDIvNyk6DQo+ID4gIiINCj4gPiBUaGUgYmluZGluZyB3ZSB1c2Ug
d2l0aCBvdXQtb2YtdHJlZSBNYWxpIGRyaXZlcnMgaW5jbHVkZXMgbW9yZSANCj4gPiBjbG9ja3Ms
IHRoaXMgaXMgdXNlZCBmb3IgZGV2ZnJlcTogdGhlIG91dC1vZi10cmVlIGRyaXZlciBzd2l0Y2hl
cyANCj4gPiBjbGtfbXV4IHRvIGNsa19zdWJfcGFyZW50ICgyNk1oeiksIGFkanVzdHMgY2xrX21h
aW5fcGFyZW50LCB0aGVuIA0KPiA+IHN3aXRjaGVzIGNsa19tdXggYmFjayB0byBjbGtfbWFpbl9w
YXJlbnQ6DQo+ID4gKHNlZSANCj4gPiBodHRwczovL2Nocm9taXVtLmdvb2dsZXNvdXJjZS5jb20v
Y2hyb21pdW1vcy90aGlyZF9wYXJ0eS9rZXJuZWwvKy9jaA0KPiA+IHJvbWVvcy00LjE5L2RyaXZl
cnMvZ3B1L2FybS9taWRnYXJkL3BsYXRmb3JtL21lZGlhdGVrL21hbGlfa2Jhc2VfcnVuDQo+ID4g
dGltZV9wbS5jIzQyMykNCj4gPiBjbG9ja3MgPQ0KPiA+ICAgICAgICAgPCZ0b3Bja2dlbiBDTEtf
VE9QX01GR1BMTF9DSz4sDQo+ID4gICAgICAgICA8JnRvcGNrZ2VuIENMS19UT1BfTVVYX01GRz4s
DQo+ID4gICAgICAgICA8JmNsazI2bT4sDQo+ID4gICAgICAgICA8Jm1mZ2NmZyBDTEtfTUZHX0JH
M0Q+Ow0KPiA+IGNsb2NrLW5hbWVzID0NCj4gPiAgICAgICAgICJjbGtfbWFpbl9wYXJlbnQiLA0K
PiA+ICAgICAgICAgImNsa19tdXgiLA0KPiA+ICAgICAgICAgImNsa19zdWJfcGFyZW50IiwNCj4g
PiAgICAgICAgICJzdWJzeXNfbWZnX2NnIjsNCj4gPiAiIg0KPiA+IElzIHRoZXJlIGEgY2xlYW4v
c2ltcGxlIHdheSB0byBpbXBsZW1lbnQgdGhpcyBpbiB0aGUgY2xvY2sgDQo+ID4gZnJhbWV3b3Jr
L2RldmljZSB0cmVlPyBPciBzaG91bGQgd2UgaW1wbGVtZW50IHNvbWV0aGluZyBpbiB0aGUgDQo+
ID4gcGFuZnJvc3QgZHJpdmVyPw0KPg0KPiBQdXR0aW5nIHBhcmVudCBjbG9ja3MgaW50byAnY2xv
Y2tzJyBmb3IgYSBkZXZpY2UgaXMgYSBwcmV0dHkgY29tbW9uIA0KPiBhYnVzZS4gVGhlICdhc3Np
Z25lZC1jbG9ja3MnIGJpbmRpbmcgaXMgd2hhdCdzIHVzZWQgZm9yIHBhcmVudCBjbG9jayANCj4g
c2V0dXAuIE5vdCBzdXJlIHRoYXQncyBnb2luZyB0byBoZWxwIGhlcmUgdGhvdWdoLiBJcyB0aGlz
IGRhbmNlIA0KPiBiZWNhdXNlIHRoZSBwYXJlbnQgY2xvY2sgZnJlcXVlbmN5IGNhbid0IGJlIGNo
YW5nZWQgY2xlYW5seT8NCg0KTmljay9XZWl5aSwgYW55IGlkZWEgd2h5IHdlIGRvIHRoYXQgZGFu
Y2UgaW4gdGhlIGZpcnN0IHBsYWNlPyAobWF5YmUgdGhlIFBMTCBjbG9jayBpcyB1bnN0YWJsZSB3
aGlsZSBpdCdzIGJlaW5nIGNoYW5nZWQ/KQ0KDQpDbG9jayBzb3VyY2UgbWF5IGJlY29tZSB1bnN0
YWJsZSBkdXJpbmcgY2xvY2sgZnJlcXVlbmN5IGNoYW5nZXMsIHNvIGl0IGlzIGFsd2F5cyBzYWZl
ciB0byBzd2l0Y2ggdG8gYSBtb3JlIHJlbGlhYmxlIGNsb2NrIHNvdXJjZS4NCk90aGVyd2lzZSwg
aXQgbWF5IGNhdXNlIHNvbWUgcHJvYmxlbSBpbiBzb21lIGNvcm5lciBjYXNlLg0KSSB3b3VsZCBz
dWdnZXN0IHRvIGtlZXAgaXQuDQoNCklmIHdlIHJlYWxseSBuZWVkIGl0LCBjYW4gd2UgbW92ZSB0
aGF0IGxvZ2ljIHRvIHRoZSBjbG9jayBjb3JlPw0KDQo+IElmIHVwIHRvDQo+IG1lLCBJJ2QgcHV0
IHRoYXQgZGFuY2UgaW4gdGhlIGNsb2NrIGRyaXZlci4gVGhlIEdQVSBzaG91bGRuJ3QgaGF2ZSB0
byANCj4gY2FyZS4NCj4NCj4gUm9iDQo=
