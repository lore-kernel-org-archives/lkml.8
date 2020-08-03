Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C2DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97817206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JEo04xjD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgHCI3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 04:29:44 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:44166 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725884AbgHCI3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 04:29:43 -0400
X-UUID: 05924b868abd422788d1adf1fe4eaeab-20200803
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=EuuyH2OVGmIhL/U3X6SY1BLzxNovAUS15W1lABzBFs0=;
        b=JEo04xjD0JDyd4pfKxqCnA10Gh276qX9+c+0J29zY6ug5ZRwjeOGJPdq8rnw45o3qGSG7o9cnA6mi2T+T+K1IXGtgQW79E63Q26z4voGvtd/RASfsdg/jBhMrqKZUVpxqY6Cje02zeZPo92TgekHdQe8dy9DVPZYYpyKeI7pHsE=;
X-UUID: 05924b868abd422788d1adf1fe4eaeab-20200803
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1692457246; Mon, 03 Aug 2020 16:29:40 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 3 Aug 2020 16:29:37 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 3 Aug 2020 16:29:37 +0800
Message-ID: <1596443379.31084.3.camel@mtksdaap41>
Subject: Re: [PATCH 1/8] mfd: mt6358: refine interrupt code
From:   Hsin-hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        "Josef Friedl" <josef.friedl@speed.at>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        <hsin-hsiung.wang@mediatek.com>
Date:   Mon, 3 Aug 2020 16:29:39 +0800
In-Reply-To: <20200727154840.GY1850026@dell>
References: <1595509133-5358-1-git-send-email-hsin-hsiung.wang@mediatek.com>
         <1595509133-5358-2-git-send-email-hsin-hsiung.wang@mediatek.com>
         <20200727154840.GY1850026@dell>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIE1vbiwgMjAyMC0wNy0yNyBhdCAxNjo0OCArMDEwMCwgTGVlIEpvbmVzIHdyb3Rl
Og0KPiBPbiBUaHUsIDIzIEp1bCAyMDIwLCBIc2luLUhzaXVuZyBXYW5nIHdyb3RlOg0KPiANCj4g
PiBUaGlzIHBhdGNoIHJlZmluZXMgdGhlIGludGVycnVwdCByZWxhdGVkIGNvZGUgdG8gc3VwcG9y
dCBuZXcgY2hpcHMuDQo+IA0KPiBSZWZpbmVzIGluIHdoYXQgd2F5Pw0KPiANCj4gV2hhdCBtYWtl
cyB0aGlzIGJldHRlcj8NCj4gDQoNClRoYW5rcyBmb3IgdGhlIGNvbW1lbnQuIEkgd2lsbCBhZGQg
bW9yZSBpbmZvcm1hdGlvbiBpbnRvIGNvbW1lbnQgbWVzc2FnZQ0KYmFzZWQgb24gbXkgYmVsb3cg
ZXhwbGFuYXRpb24uDQoNCj4gPiBTaWduZWQtb2ZmLWJ5OiBIc2luLUhzaXVuZyBXYW5nIDxoc2lu
LWhzaXVuZy53YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9tZmQvbXQ2
MzU4LWlycS5jICAgICAgICB8IDY1ICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0t
LS0tLS0tDQo+ID4gIGluY2x1ZGUvbGludXgvbWZkL210NjM1OC9jb3JlLmggfCAgOCArKy0tLQ0K
PiA+ICAyIGZpbGVzIGNoYW5nZWQsIDQxIGluc2VydGlvbnMoKyksIDMyIGRlbGV0aW9ucygtKQ0K
PiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21mZC9tdDYzNTgtaXJxLmMgYi9kcml2ZXJz
L21mZC9tdDYzNTgtaXJxLmMNCj4gPiBpbmRleCBkYjczNGYyLi40YjA5NGU1IDEwMDY0NA0KPiA+
IC0tLSBhL2RyaXZlcnMvbWZkL210NjM1OC1pcnEuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbWZkL210
NjM1OC1pcnEuYw0KPiA+IEBAIC0xMyw3ICsxMyw5IEBADQo+ID4gICNpbmNsdWRlIDxsaW51eC9w
bGF0Zm9ybV9kZXZpY2UuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3JlZ21hcC5oPg0KPiA+ICAN
Cj4gPiAtc3RhdGljIHN0cnVjdCBpcnFfdG9wX3QgbXQ2MzU4X2ludHNbXSA9IHsNCj4gPiArI2Rl
ZmluZSBNVEtfUE1JQ19SRUdfV0lEVEggMTYNCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1
Y3QgaXJxX3RvcF90IG10NjM1OF9pbnRzW10gPSB7DQo+ID4gIAlNVDYzNThfVE9QX0dFTihCVUNL
KSwNCj4gPiAgCU1UNjM1OF9UT1BfR0VOKExETyksDQo+ID4gIAlNVDYzNThfVE9QX0dFTihQU0Mp
LA0KPiA+IEBAIC0yNCw2ICsyNiwxMyBAQCBzdGF0aWMgc3RydWN0IGlycV90b3BfdCBtdDYzNThf
aW50c1tdID0gew0KPiA+ICAJTVQ2MzU4X1RPUF9HRU4oTUlTQyksDQo+ID4gIH07DQo+ID4gIA0K
PiA+ICtzdGF0aWMgc3RydWN0IHBtaWNfaXJxX2RhdGEgbXQ2MzU4X2lycWQgPSB7DQo+ID4gKwku
bnVtX3RvcCA9IEFSUkFZX1NJWkUobXQ2MzU4X2ludHMpLA0KPiA+ICsJLm51bV9wbWljX2lycXMg
PSBNVDYzNThfSVJRX05SLA0KPiA+ICsJLnRvcF9pbnRfc3RhdHVzX3JlZyA9IE1UNjM1OF9UT1Bf
SU5UX1NUQVRVUzAsDQo+ID4gKwkucG1pY19pbnRzID0gbXQ2MzU4X2ludHMsDQo+ID4gK307DQo+
IA0KPiBEeW5hbWljYWxseSBhc3NpZ25lZCBkcml2ZXIgZGF0YSBpcyB1c3VhbGx5IHByZWZlcnJl
ZC4NCj4gDQo+IFdoeSBoYXZlIHlvdSBnb25lIHN0YXRpYz8NCj4gDQoNCkRvIHlvdSBjb25zaWRl
ciB0aGUgbWVtb3J5IGFsbG9jYXRpb24/DQpCZWxvdyBtb2RpZmljYXRpb24gaXMgdG8gYXNzaWdu
IG5lY2Vzc2FyeSBkYXRhIGR5bmFtaWNhbGx5IGFuZCB0aGUgY29kZQ0Kd2lsbCBiZWNvbWUgbG9u
Z2VyIHdpdGggbW9yZSBjaGlwcyBpZiB3ZSBhc3NpZ24gZXZlcnkgbWVtYmVyIG9mIHRoZQ0Kc3Ry
dWN0dXJlLg0KDQpAQCAtMTgwLDE3ICsxOTAsMTggQEAgIGludCBtdDYzNThfaXJxX2luaXQoc3Ry
dWN0IG10NjM5N19jaGlwICpjaGlwKQ0KICAgICAgICAgICAgICAgaW50IGksIGosIHJldDsNCiAg
ICAgICAgICAgICAgIHN0cnVjdCBwbWljX2lycV9kYXRhICppcnFkOw0KDQotICAgICAgICAgICAg
ICBpcnFkID0gZGV2bV9remFsbG9jKGNoaXAtPmRldiwgc2l6ZW9mKCppcnFkKSwNCkdGUF9LRVJO
RUwpOw0KLSAgICAgICAgICAgICAgaWYgKCFpcnFkKQ0KLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHJldHVybiAtRU5PTUVNOw0KKyAgICAgICAgICAgICBzd2l0Y2ggKGNoaXAtPmNoaXBf
aWQpIHsNCisgICAgICAgICAgICAgY2FzZSBNVDYzNThfQ0hJUF9JRDoNCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGNoaXAtPmlycV9kYXRhID0gJm10NjM1OF9pcnFkOw0KKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQoNCi0gICAgICAgICAgICAgIGNoaXAtPmlycV9k
YXRhID0gaXJxZDsNCisgICAgICAgICAgICAgZGVmYXVsdDoNCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGRldl9lcnIoY2hpcC0+ZGV2LCAidW5zdXBwb3J0ZWQgY2hpcDogMHgleA0KXG4i
LCBjaGlwLT5jaGlwX2lkKTsNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAt
RU5PREVWOw0KKyAgICAgICAgICAgICB9DQoNCiAgICAgICAgICAgICAgICBtdXRleF9pbml0KCZj
aGlwLT5pcnFsb2NrKTsNCi0gICAgICAgICAgICAgIGlycWQtPnRvcF9pbnRfc3RhdHVzX3JlZyA9
IE1UNjM1OF9UT1BfSU5UX1NUQVRVUzA7DQotICAgICAgICAgICAgICBpcnFkLT5udW1fcG1pY19p
cnFzID0gTVQ2MzU4X0lSUV9OUjsNCi0gICAgICAgICAgICAgIGlycWQtPm51bV90b3AgPSBBUlJB
WV9TSVpFKG10NjM1OF9pbnRzKTsNCi0NCisgICAgICAgICAgICAgaXJxZCA9IGNoaXAtPmlycV9k
YXRhOw0KICAgICAgICAgICAgICAgaXJxZC0+ZW5hYmxlX2h3aXJxID0gZGV2bV9rY2FsbG9jKGNo
aXAtPmRldiwNCg0KaXJxZC0+bnVtX3BtaWNfaXJxcywNCg0Kc2l6ZW9mKCppcnFkLT5lbmFibGVf
aHdpcnEpLA0KDQo=

