Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752E2C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 02:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DFF9206D7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 02:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="e6ayxYvJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgCFCeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 21:34:20 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:7777 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726191AbgCFCeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 21:34:20 -0500
X-UUID: 0bcd69818ec44aa19b87aa0671e71ffa-20200306
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=lw7Z2hh6lxCttqw2IBWx1RQ1VaA6UHtHaJjaKiScxsU=;
        b=e6ayxYvJPghsOeTmMKrxd+rDVv0LvxracPf2u1WBaq49Z7bf7awGJRY7Z9RXTt8/QyLyOp6nBUPB/iuIuHDkxt80A9kyPZ9ZMmjB8bJs6tJlqhBxcfDfOxmyxMltr6TCrFy6XOwb04o6zTxdOMyGNUjxdVoXWcum5c0B1+qgdZg=;
X-UUID: 0bcd69818ec44aa19b87aa0671e71ffa-20200306
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <nick.fan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1834358050; Fri, 06 Mar 2020 10:34:16 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 6 Mar 2020 10:33:05 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 6 Mar 2020 10:34:16 +0800
Message-ID: <1583462055.4947.6.camel@mtksdaap41>
Subject: Re: [PATCH v4 1/7] dt-bindings: gpu: mali-bifrost: Add Mediatek
 MT8183
From:   Nick Fan <nick.fan@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Rob Herring <robh@kernel.org>, Sj Huang <sj.huang@mediatek.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Tomeu Vizoso" <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 6 Mar 2020 10:34:15 +0800
In-Reply-To: <CANMq1KAVX4o5yC7c_88Wq_O=F+MaSN_V4uNcs1nzS3wBS6A5AA@mail.gmail.com>
References: <20200207052627.130118-1-drinkcat@chromium.org>
         <20200207052627.130118-2-drinkcat@chromium.org>
         <20200225171613.GA7063@bogus>
         <CANMq1KAVX4o5yC7c_88Wq_O=F+MaSN_V4uNcs1nzS3wBS6A5AA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnkgZm9yIG15IGxhdGUgcmVwbHkuDQpJIGhhdmUgY2hlY2tlZCBpbnRlcm5hbGx5Lg0KVGhl
IE1UODE4M19QT1dFUl9ET01BSU5fTUZHXzJEIGlzIGp1c3QgYSBsZWdhY3kgbmFtZSwgbm90IHJl
YWxseSAyRA0KZG9tYWluLg0KDQpJZiB0aGUgbmFtaW5nIHRvbyBjb25mdXNpbmcsIHdlIGNhbiBj
aGFuZ2UgdGhpcyBuYW1lIHRvDQpNVDgxODNfUE9XRVJfRE9NQUlOX01GR19DT1JFMiBmb3IgY29u
c2lzdGVuY3kuDQoNClRoYW5rcw0KDQpOaWNrIEZhbg0KDQpPbiBXZWQsIDIwMjAtMDItMjYgYXQg
MDg6NTUgKzA4MDAsIE5pY29sYXMgQm9pY2hhdCB3cm90ZToNCg0KPiArTmljayBGYW4gK1NqIEh1
YW5nIEAgTVRLDQo+IA0KPiBPbiBXZWQsIEZlYiAyNiwgMjAyMCBhdCAxOjE2IEFNIFJvYiBIZXJy
aW5nIDxyb2JoQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gT24gRnJpLCBGZWIgMDcsIDIw
MjAgYXQgMDE6MjY6MjFQTSArMDgwMCwgTmljb2xhcyBCb2ljaGF0IHdyb3RlOg0KPiA+ID4gRGVm
aW5lIGEgY29tcGF0aWJsZSBzdHJpbmcgZm9yIHRoZSBNYWxpIEJpZnJvc3QgR1BVIGZvdW5kIGlu
DQo+ID4gPiBNZWRpYXRlaydzIE1UODE4MyBTb0NzLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYt
Ynk6IE5pY29sYXMgQm9pY2hhdCA8ZHJpbmtjYXRAY2hyb21pdW0ub3JnPg0KPiA+ID4gUmV2aWV3
ZWQtYnk6IEFseXNzYSBSb3Nlbnp3ZWlnIDxhbHlzc2Eucm9zZW56d2VpZ0Bjb2xsYWJvcmEuY29t
Pg0KPiA+ID4gLS0tDQo+ID4gPg0KPiA+ID4gdjQ6DQo+ID4gPiAgLSBBZGQgcG93ZXItZG9tYWlu
LW5hbWVzIGRlc2NyaXB0aW9uDQo+ID4gPiAgICAoa2VwdCBBbHlzc2EncyByZXZpZXdlZC1ieSBh
cyB0aGUgY2hhbmdlIGlzIG1pbm9yKQ0KPiA+ID4gdjM6DQo+ID4gPiAgLSBObyBjaGFuZ2UNCj4g
PiA+DQo+ID4gPiAgLi4uL2JpbmRpbmdzL2dwdS9hcm0sbWFsaS1iaWZyb3N0LnlhbWwgICAgICAg
IHwgMjUgKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNl
cnRpb25zKCspDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9ncHUvYXJtLG1hbGktYmlmcm9zdC55YW1sIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2dwdS9hcm0sbWFsaS1iaWZyb3N0LnlhbWwNCj4gPiA+IGluZGV4
IDRlYTZhODc4OTY5OTcwOS4uMGQ5M2IzOTgxNDQ1OTc3IDEwMDY0NA0KPiA+ID4gLS0tIGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dwdS9hcm0sbWFsaS1iaWZyb3N0LnlhbWwN
Cj4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncHUvYXJtLG1h
bGktYmlmcm9zdC55YW1sDQo+ID4gPiBAQCAtMTcsNiArMTcsNyBAQCBwcm9wZXJ0aWVzOg0KPiA+
ID4gICAgICBpdGVtczoNCj4gPiA+ICAgICAgICAtIGVudW06DQo+ID4gPiAgICAgICAgICAgIC0g
YW1sb2dpYyxtZXNvbi1nMTJhLW1hbGkNCj4gPiA+ICsgICAgICAgICAgLSBtZWRpYXRlayxtdDgx
ODMtbWFsaQ0KPiA+ID4gICAgICAgICAgICAtIHJlYWx0ZWsscnRkMTYxOS1tYWxpDQo+ID4gPiAg
ICAgICAgICAgIC0gcm9ja2NoaXAscHgzMC1tYWxpDQo+ID4gPiAgICAgICAgLSBjb25zdDogYXJt
LG1hbGktYmlmcm9zdCAjIE1hbGkgQmlmcm9zdCBHUFUgbW9kZWwvcmV2aXNpb24gaXMgZnVsbHkg
ZGlzY292ZXJhYmxlDQo+ID4gPiBAQCAtNjIsNiArNjMsMzAgQEAgYWxsT2Y6DQo+ID4gPiAgICAg
ICAgICAgIG1pbkl0ZW1zOiAyDQo+ID4gPiAgICAgICAgcmVxdWlyZWQ6DQo+ID4gPiAgICAgICAg
ICAtIHJlc2V0cw0KPiA+ID4gKyAgLSBpZjoNCj4gPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+
ID4gKyAgICAgICAgY29tcGF0aWJsZToNCj4gPiA+ICsgICAgICAgICAgY29udGFpbnM6DQo+ID4g
PiArICAgICAgICAgICAgY29uc3Q6IG1lZGlhdGVrLG10ODE4My1tYWxpDQo+ID4gPiArICAgIHRo
ZW46DQo+ID4gPiArICAgICAgcHJvcGVydGllczoNCj4gPiA+ICsgICAgICAgIHNyYW0tc3VwcGx5
OiB0cnVlDQo+ID4gPiArICAgICAgICBwb3dlci1kb21haW5zOg0KPiA+ID4gKyAgICAgICAgICBk
ZXNjcmlwdGlvbjoNCj4gPiA+ICsgICAgICAgICAgICBMaXN0IG9mIHBoYW5kbGUgYW5kIFBNIGRv
bWFpbiBzcGVjaWZpZXIgYXMgZG9jdW1lbnRlZCBpbg0KPiA+ID4gKyAgICAgICAgICAgIERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dlci9wb3dlcl9kb21haW4udHh0DQo+ID4g
PiArICAgICAgICAgIG1pbkl0ZW1zOiAzDQo+ID4gPiArICAgICAgICAgIG1heEl0ZW1zOiAzDQo+
ID4gPiArICAgICAgICBwb3dlci1kb21haW4tbmFtZXM6DQo+ID4gPiArICAgICAgICAgIGl0ZW1z
Og0KPiA+ID4gKyAgICAgICAgICAgIC0gY29uc3Q6IGNvcmUwDQo+ID4gPiArICAgICAgICAgICAg
LSBjb25zdDogY29yZTENCj4gPiA+ICsgICAgICAgICAgICAtIGNvbnN0OiAyZA0KPiA+DQo+ID4g
QUZBSUssIHRoZXJlJ3Mgbm8gJzJkJyBibG9jayBpbiBiaWZyb3N0IEdQVXMuIEEgcG93ZXIgZG9t
YWluIGZvciBlYWNoDQo+ID4gY29yZSBncm91cCBpcyBjb3JyZWN0IHRob3VnaC4NCj4gDQo+IEdv
b2QgcXVlc3Rpb24uLi4gSG9wZWZ1bGx5IE5pY2svU0pATVRLIGNhbiBjb21tZW50LCB0aGUgbm9u
LXVwc3RyZWFtIERUUyBoYXM6DQo+IGdwdTogbWFsaUAxMzA0MDAwMCB7DQo+IGNvbXBhdGlibGUg
PSAibWVkaWF0ZWssbXQ4MTgzLW1hbGkiLCAiYXJtLG1hbGktYmlmcm9zdCI7DQo+IHBvd2VyLWRv
bWFpbnMgPSA8JnNjcHN5cyBNVDgxODNfUE9XRVJfRE9NQUlOX01GR19DT1JFMD47DQo+IC4uLg0K
PiB9DQo+IA0KPiBncHVfY29yZTE6IG1hbGlfZ3B1X2NvcmUxIHsNCj4gY29tcGF0aWJsZSA9ICJt
ZWRpYXRlayxncHVfY29yZTEiOw0KPiBwb3dlci1kb21haW5zID0gPCZzY3BzeXMgTVQ4MTgzX1BP
V0VSX0RPTUFJTl9NRkdfQ09SRTE+Ow0KPiB9Ow0KPiANCj4gZ3B1X2NvcmUyOiBtYWxpX2dwdV9j
b3JlMiB7DQo+IGNvbXBhdGlibGUgPSAibWVkaWF0ZWssZ3B1X2NvcmUyIjsNCj4gcG93ZXItZG9t
YWlucyA9IDwmc2Nwc3lzIE1UODE4M19QT1dFUl9ET01BSU5fTUZHXzJEPjsNCj4gfTsNCj4gDQo+
IFNvIEkgcGlja2VkIGNvcmUwL2NvcmUxLzJkIGFzIG5hbWVzLCBidXQgbG9va2luZyBhdCB0aGlz
LCBpdCdzIGxpa2VseQ0KPiBjb3JlMiBpcyBtb3JlIGFwcHJvcHJpYXRlIChhbmQgTVQ4MTgzX1BP
V0VSX0RPTUFJTl9NRkdfMkQgbWlnaHQganVzdA0KPiBiZSBhIGludGVybmFsL2xlZ2FjeSBuYW1l
LCBpZiB0aGVyZSBpcyBubyByZWFsIDJkIGRvbWFpbikuDQo+IA0KPiBUaGFua3MuDQo+IA0KPiA+
IFJvYg0KDQo=

