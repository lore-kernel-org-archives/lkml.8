Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5393EC34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 07:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2897C206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 07:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FmX6aLHY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgBRHp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 02:45:58 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:45999 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726154AbgBRHp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 02:45:57 -0500
X-UUID: 4fadde57aa054d20aad8d6f7bbe5b0e5-20200218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=gXxsoIz5rNgYDJa/BekJBxJDDBHJBtuzwIcBZe8U+9w=;
        b=FmX6aLHYDs7Nl8uGTBxV8IdSnL78tk1vdeim1IE3sKkhAKqRpEjvBl8oYkpjj8Jk+CbfsCHpU9ZMDzFNWUnfbrwXwVC59j/d4Dcty8v7HMP66DPRLCvYYeMfA37v0VYEkHfDVrAyS6D+twUJZRdzvmYtQKwIHwM5iktRBwuYpk0=;
X-UUID: 4fadde57aa054d20aad8d6f7bbe5b0e5-20200218
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1359645357; Tue, 18 Feb 2020 15:45:53 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 18 Feb 2020 15:45:07 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 18 Feb 2020 15:45:28 +0800
Message-ID: <1582011952.15399.0.camel@mtksdaap41>
Subject: Re: [PATCH 1/2] drm/mediatek: add plane check in async_check
 function
From:   CK Hu <ck.hu@mediatek.com>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
CC:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        YT Shen <yt.shen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>, <tfiga@chromium.org>,
        <drinkcat@chromium.org>, <linux-kernel@vger.kernel.org>,
        <srv_heupstream@mediatek.com>
Date:   Tue, 18 Feb 2020 15:45:52 +0800
In-Reply-To: <1581566078.12071.0.camel@mtksdaap41>
References: <20200213012353.26815-1-bibby.hsieh@mediatek.com>
         <1581566078.12071.0.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEJpYmJ5Og0KDQpPbiBUaHUsIDIwMjAtMDItMTMgYXQgMTE6NTQgKzA4MDAsIENLIEh1IHdy
b3RlOg0KPiBIaSwgQmliYnk6DQo+IA0KPiBPbiBUaHUsIDIwMjAtMDItMTMgYXQgMDk6MjMgKzA4
MDAsIEJpYmJ5IEhzaWVoIHdyb3RlOg0KPiA+IE1USyBkbyByb3RhdGlvbiBjaGVja2luZyBhbmQg
dHJhbnNmZXJyaW5nIGluIGxheWVyIGNoZWNrIGZ1bmN0aW9uLA0KPiA+IGJ1dCB3ZSBkbyBub3Qg
Y2hlY2sgdGhhdCBpbiBhdG9taWNfY2hlY2ssDQo+ID4gc28gYWRkIGJhY2sgaW4gYXRvbWljX2No
ZWNrIGZ1bmN0aW9uLg0KPiA+IA0KPiANCj4gUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRp
YXRlay5jb20+DQo+IA0KDQpBcHBsaWVkIHRvIG1lZGlhdGVrLWRybS1maXhlcy01LjYgWzFdLCB0
aGFua3MuDQoNClsxXQ0KaHR0cHM6Ly9naXRodWIuY29tL2NraHUtbWVkaWF0ZWsvbGludXguZ2l0
LXRhZ3MvY29tbWl0cy9tZWRpYXRlay1kcm0tZml4ZXMtNS42DQoNCg0KUmVnYXJkcywNCkNLDQoN
Cj4gPiBGaXhlczogOTIwZmZmY2M4OTEyICgiZHJtL21lZGlhdGVrOiB1cGRhdGUgY3Vyc29ycyBi
eSB1c2luZyBhc3luYyBhdG9taWMgdXBkYXRlIikNCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBC
aWJieSBIc2llaCA8YmliYnkuaHNpZWhAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jIHwgNiArKysrKysNCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jIGIvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fcGxhbmUuYw0KPiA+IGluZGV4IDE4OTc0NGQzNGY1My4uZDMyYjQ5NGZm
MWRlIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3Bs
YW5lLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5j
DQo+ID4gQEAgLTgxLDYgKzgxLDcgQEAgc3RhdGljIGludCBtdGtfcGxhbmVfYXRvbWljX2FzeW5j
X2NoZWNrKHN0cnVjdCBkcm1fcGxhbmUgKnBsYW5lLA0KPiA+ICAJCQkJCXN0cnVjdCBkcm1fcGxh
bmVfc3RhdGUgKnN0YXRlKQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgZHJtX2NydGNfc3RhdGUgKmNy
dGNfc3RhdGU7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICANCj4gPiAgCWlmIChwbGFuZSAhPSBzdGF0
ZS0+Y3J0Yy0+Y3Vyc29yKQ0KPiA+ICAJCXJldHVybiAtRUlOVkFMOw0KPiA+IEBAIC05MSw2ICs5
MiwxMSBAQCBzdGF0aWMgaW50IG10a19wbGFuZV9hdG9taWNfYXN5bmNfY2hlY2soc3RydWN0IGRy
bV9wbGFuZSAqcGxhbmUsDQo+ID4gIAlpZiAoIXBsYW5lLT5zdGF0ZS0+ZmIpDQo+ID4gIAkJcmV0
dXJuIC1FSU5WQUw7DQo+ID4gIA0KPiA+ICsJcmV0ID0gbXRrX2RybV9jcnRjX3BsYW5lX2NoZWNr
KHN0YXRlLT5jcnRjLCBwbGFuZSwNCj4gPiArCQkJCSAgICAgICB0b19tdGtfcGxhbmVfc3RhdGUo
c3RhdGUpKTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4g
IAlpZiAoc3RhdGUtPnN0YXRlKQ0KPiA+ICAJCWNydGNfc3RhdGUgPSBkcm1fYXRvbWljX2dldF9l
eGlzdGluZ19jcnRjX3N0YXRlKHN0YXRlLT5zdGF0ZSwNCj4gPiAgCQkJCQkJCQlzdGF0ZS0+Y3J0
Yyk7DQo+IA0KDQo=

