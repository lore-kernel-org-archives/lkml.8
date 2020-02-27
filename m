Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB05DC4BA06
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 06:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E87B24656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 06:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IdRx2Km3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgB0GJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 01:09:44 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:59856 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725790AbgB0GJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 01:09:43 -0500
X-UUID: 090e36d2203c48729c8b76f2daca3830-20200227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=8hObMDkCZhI/DRnWGjAJpxpuzXkK7SPUl3OhA8dm39o=;
        b=IdRx2Km31sN0fY3wFTEotJ/PWfrQ+GfiQdnfHck4R92x/7fk5b3SmddFlVXYUnJh5uUkCTTqNxgMTiXyMsfkKmPDPDD4/ZCGudXlhUpvOFVttzeccpdVabIs1ESzVgfnSwHHuuk/j5TXRAZv4jbu1RF3lFPCCFcXKjJz938M+3o=;
X-UUID: 090e36d2203c48729c8b76f2daca3830-20200227
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 180435795; Thu, 27 Feb 2020 14:09:37 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 27 Feb 2020 14:08:39 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by mtkcas08.mediatek.inc
 (172.21.101.126) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 27 Feb
 2020 14:09:40 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 27 Feb 2020 14:09:25 +0800
Message-ID: <1582783776.30808.1.camel@mtksdaap41>
Subject: Re: [PATCH] drm/mediatek: Remove debug messages for function calls
From:   CK Hu <ck.hu@mediatek.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
CC:     <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 27 Feb 2020 14:09:36 +0800
In-Reply-To: <20200226112723.649954-1-enric.balletbo@collabora.com>
References: <20200226112723.649954-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEVucmljOg0KDQpPbiBXZWQsIDIwMjAtMDItMjYgYXQgMTI6MjcgKzAxMDAsIEVucmljIEJh
bGxldGJvIGkgU2VycmEgd3JvdGU6DQo+IEVxdWl2YWxlbnQgaW5mb3JtYXRpb24gY2FuIGJlIG5v
d2FkYXlzIG9idGFpbmVkIHVzaW5nIGZ1bmN0aW9uIHRyYWNlci4NCj4gDQoNClJldmlld2VkLWJ5
OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IFNpZ25lZC1vZmYtYnk6IEVucmljIEJh
bGxldGJvIGkgU2VycmEgPGVucmljLmJhbGxldGJvQGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KPiAN
Cj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyB8IDUgLS0tLS0NCj4g
IGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jICB8IDIgLS0NCj4gIDIgZmls
ZXMgY2hhbmdlZCwgNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RybV9jcnRjLmMNCj4gaW5kZXggYTIzNjQ5OTEyM2FhLi44ODJjNjkwZDNmMTMgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gQEAgLTE5Miw3ICsx
OTIsNiBAQCBzdGF0aWMgaW50IG10a19jcnRjX2RkcF9jbGtfZW5hYmxlKHN0cnVjdCBtdGtfZHJt
X2NydGMgKm10a19jcnRjKQ0KPiAgCWludCByZXQ7DQo+ICAJaW50IGk7DQo+ICANCj4gLQlEUk1f
REVCVUdfRFJJVkVSKCIlc1xuIiwgX19mdW5jX18pOw0KPiAgCWZvciAoaSA9IDA7IGkgPCBtdGtf
Y3J0Yy0+ZGRwX2NvbXBfbnI7IGkrKykgew0KPiAgCQlyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUo
bXRrX2NydGMtPmRkcF9jb21wW2ldLT5jbGspOw0KPiAgCQlpZiAocmV0KSB7DQo+IEBAIC0yMTIs
NyArMjExLDYgQEAgc3RhdGljIHZvaWQgbXRrX2NydGNfZGRwX2Nsa19kaXNhYmxlKHN0cnVjdCBt
dGtfZHJtX2NydGMgKm10a19jcnRjKQ0KPiAgew0KPiAgCWludCBpOw0KPiAgDQo+IC0JRFJNX0RF
QlVHX0RSSVZFUigiJXNcbiIsIF9fZnVuY19fKTsNCj4gIAlmb3IgKGkgPSAwOyBpIDwgbXRrX2Ny
dGMtPmRkcF9jb21wX25yOyBpKyspDQo+ICAJCWNsa19kaXNhYmxlX3VucHJlcGFyZShtdGtfY3J0
Yy0+ZGRwX2NvbXBbaV0tPmNsayk7DQo+ICB9DQo+IEBAIC0yNTcsNyArMjU1LDYgQEAgc3RhdGlj
IGludCBtdGtfY3J0Y19kZHBfaHdfaW5pdChzdHJ1Y3QgbXRrX2RybV9jcnRjICptdGtfY3J0YykN
Cj4gIAlpbnQgcmV0Ow0KPiAgCWludCBpOw0KPiAgDQo+IC0JRFJNX0RFQlVHX0RSSVZFUigiJXNc
biIsIF9fZnVuY19fKTsNCj4gIAlpZiAoV0FSTl9PTighY3J0Yy0+c3RhdGUpKQ0KPiAgCQlyZXR1
cm4gLUVJTlZBTDsNCj4gIA0KPiBAQCAtMjk4LDcgKzI5NSw2IEBAIHN0YXRpYyBpbnQgbXRrX2Ny
dGNfZGRwX2h3X2luaXQoc3RydWN0IG10a19kcm1fY3J0YyAqbXRrX2NydGMpDQo+ICAJCWdvdG8g
ZXJyX211dGV4X3VucHJlcGFyZTsNCj4gIAl9DQo+ICANCj4gLQlEUk1fREVCVUdfRFJJVkVSKCJt
ZWRpYXRla19kZHBfZGRwX3BhdGhfc2V0dXBcbiIpOw0KPiAgCWZvciAoaSA9IDA7IGkgPCBtdGtf
Y3J0Yy0+ZGRwX2NvbXBfbnIgLSAxOyBpKyspIHsNCj4gIAkJbXRrX2RkcF9hZGRfY29tcF90b19w
YXRoKG10a19jcnRjLT5jb25maWdfcmVncywNCj4gIAkJCQkJIG10a19jcnRjLT5kZHBfY29tcFtp
XS0+aWQsDQo+IEBAIC0zNDgsNyArMzQ0LDYgQEAgc3RhdGljIHZvaWQgbXRrX2NydGNfZGRwX2h3
X2Zpbmkoc3RydWN0IG10a19kcm1fY3J0YyAqbXRrX2NydGMpDQo+ICAJc3RydWN0IGRybV9jcnRj
ICpjcnRjID0gJm10a19jcnRjLT5iYXNlOw0KPiAgCWludCBpOw0KPiAgDQo+IC0JRFJNX0RFQlVH
X0RSSVZFUigiJXNcbiIsIF9fZnVuY19fKTsNCj4gIAlmb3IgKGkgPSAwOyBpIDwgbXRrX2NydGMt
PmRkcF9jb21wX25yOyBpKyspIHsNCj4gIAkJbXRrX2RkcF9jb21wX3N0b3AobXRrX2NydGMtPmRk
cF9jb21wW2ldKTsNCj4gIAkJaWYgKGkgPT0gMSkNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcm1fZHJ2LmMNCj4gaW5kZXggMTdmMTE4ZWUwZTU3Li40OTM0ODM0OTc3YjMgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+IEBAIC01NzAsNyArNTcwLDYg
QEAgc3RhdGljIGludCBtdGtfZHJtX3N5c19zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikNCj4g
IAlpbnQgcmV0Ow0KPiAgDQo+ICAJcmV0ID0gZHJtX21vZGVfY29uZmlnX2hlbHBlcl9zdXNwZW5k
KGRybSk7DQo+IC0JRFJNX0RFQlVHX0RSSVZFUigibXRrX2RybV9zeXNfc3VzcGVuZFxuIik7DQo+
ICANCj4gIAlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiBAQCAtNTgyLDcgKzU4MSw2IEBAIHN0YXRpYyBp
bnQgbXRrX2RybV9zeXNfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIAlpbnQgcmV0Ow0K
PiAgDQo+ICAJcmV0ID0gZHJtX21vZGVfY29uZmlnX2hlbHBlcl9yZXN1bWUoZHJtKTsNCj4gLQlE
Uk1fREVCVUdfRFJJVkVSKCJtdGtfZHJtX3N5c19yZXN1bWVcbiIpOw0KPiAgDQo+ICAJcmV0dXJu
IHJldDsNCj4gIH0NCg0K

