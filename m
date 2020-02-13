Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29CBC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 03:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C2421734
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 03:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UkKKLj5t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgBMDyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 22:54:46 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:36092 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729443AbgBMDyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 22:54:46 -0500
X-UUID: 37b24f8c41ef491abd919b4882b7a201-20200213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=AWHKi/bi0HkO6LeGddbfc6Yc3pqDeHpmuHU4Mk2li9M=;
        b=UkKKLj5tzbNwYgYlmFqEGo/YfHOL9OuvekZyN/NKtmeL5yIZY/knOWoJmxtCoQAEhPGL2AYBp5v4YGRndrp1qXOfr7BuqWA5heOJDwFJb5VbXLbhnmZCtxtfpAfvvdXu++GfNHvmqt90Sj7HnQCvAMHEDooirPzggmyFy2jcHLw=;
X-UUID: 37b24f8c41ef491abd919b4882b7a201-20200213
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 678038741; Thu, 13 Feb 2020 11:54:39 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 13 Feb 2020 11:53:55 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 13 Feb 2020 11:55:07 +0800
Message-ID: <1581566078.12071.0.camel@mtksdaap41>
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
Date:   Thu, 13 Feb 2020 11:54:38 +0800
In-Reply-To: <20200213012353.26815-1-bibby.hsieh@mediatek.com>
References: <20200213012353.26815-1-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEJpYmJ5Og0KDQpPbiBUaHUsIDIwMjAtMDItMTMgYXQgMDk6MjMgKzA4MDAsIEJpYmJ5IEhz
aWVoIHdyb3RlOg0KPiBNVEsgZG8gcm90YXRpb24gY2hlY2tpbmcgYW5kIHRyYW5zZmVycmluZyBp
biBsYXllciBjaGVjayBmdW5jdGlvbiwNCj4gYnV0IHdlIGRvIG5vdCBjaGVjayB0aGF0IGluIGF0
b21pY19jaGVjaywNCj4gc28gYWRkIGJhY2sgaW4gYXRvbWljX2NoZWNrIGZ1bmN0aW9uLg0KPiAN
Cg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gRml4ZXM6IDky
MGZmZmNjODkxMiAoImRybS9tZWRpYXRlazogdXBkYXRlIGN1cnNvcnMgYnkgdXNpbmcgYXN5bmMg
YXRvbWljIHVwZGF0ZSIpDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaWJieSBIc2llaCA8YmliYnku
aHNpZWhAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHJtX3BsYW5lLmMgfCA2ICsrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9u
cygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJt
X3BsYW5lLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jDQo+IGlu
ZGV4IDE4OTc0NGQzNGY1My4uZDMyYjQ5NGZmMWRlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHJtX3BsYW5lLmMNCj4gQEAgLTgxLDYgKzgxLDcgQEAgc3RhdGljIGludCBt
dGtfcGxhbmVfYXRvbWljX2FzeW5jX2NoZWNrKHN0cnVjdCBkcm1fcGxhbmUgKnBsYW5lLA0KPiAg
CQkJCQlzdHJ1Y3QgZHJtX3BsYW5lX3N0YXRlICpzdGF0ZSkNCj4gIHsNCj4gIAlzdHJ1Y3QgZHJt
X2NydGNfc3RhdGUgKmNydGNfc3RhdGU7DQo+ICsJaW50IHJldDsNCj4gIA0KPiAgCWlmIChwbGFu
ZSAhPSBzdGF0ZS0+Y3J0Yy0+Y3Vyc29yKQ0KPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gQEAgLTkx
LDYgKzkyLDExIEBAIHN0YXRpYyBpbnQgbXRrX3BsYW5lX2F0b21pY19hc3luY19jaGVjayhzdHJ1
Y3QgZHJtX3BsYW5lICpwbGFuZSwNCj4gIAlpZiAoIXBsYW5lLT5zdGF0ZS0+ZmIpDQo+ICAJCXJl
dHVybiAtRUlOVkFMOw0KPiAgDQo+ICsJcmV0ID0gbXRrX2RybV9jcnRjX3BsYW5lX2NoZWNrKHN0
YXRlLT5jcnRjLCBwbGFuZSwNCj4gKwkJCQkgICAgICAgdG9fbXRrX3BsYW5lX3N0YXRlKHN0YXRl
KSk7DQo+ICsJaWYgKHJldCkNCj4gKwkJcmV0dXJuIHJldDsNCj4gKw0KPiAgCWlmIChzdGF0ZS0+
c3RhdGUpDQo+ICAJCWNydGNfc3RhdGUgPSBkcm1fYXRvbWljX2dldF9leGlzdGluZ19jcnRjX3N0
YXRlKHN0YXRlLT5zdGF0ZSwNCj4gIAkJCQkJCQkJc3RhdGUtPmNydGMpOw0KDQo=

