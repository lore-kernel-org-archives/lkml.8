Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F329FC2D0E8
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 23:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB4020737
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 23:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="r8lv1lYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgCYXAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 19:00:36 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:11297 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727358AbgCYXAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 19:00:36 -0400
X-UUID: 912b85233133436b97f8670a161a9b7c-20200326
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=zRMHb+7lQ/kxPsZpJcKWipHS7+03jckwS7Gwba6WOEM=;
        b=r8lv1lYlGPHABlJA5/YvzkJB1hF9pK/v1LICPxxSO5nZCcv32OHDOmvHfEUd+znkTB995rws7hJHYTPnlQWT66hkirsOEUbpu6uo/53tSXJAnbFi1jeFk6/PbpDCO4Wf0oNaFpj8AaxKx8TQ4lQM+ym1wlIa1AHmIXg9f2JoVyc=;
X-UUID: 912b85233133436b97f8670a161a9b7c-20200326
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1687820606; Thu, 26 Mar 2020 07:00:31 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 26 Mar 2020 07:00:28 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 26 Mar 2020 07:00:21 +0800
Message-ID: <1585177223.26117.1.camel@mtksdaap41>
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
Date:   Thu, 26 Mar 2020 07:00:23 +0800
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
d2FkYXlzIG9idGFpbmVkIHVzaW5nIGZ1bmN0aW9uIHRyYWNlci4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEVucmljIEJhbGxldGJvIGkgU2VycmEgPGVucmljLmJhbGxldGJvQGNvbGxhYm9yYS5jb20+
DQo+IC0tLQ0KDQpBY2tlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0KPiANCj4g
IGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyB8IDUgLS0tLS0NCj4gIGRy
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jICB8IDIgLS0NCj4gIDIgZmlsZXMg
Y2hhbmdlZCwgNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RybV9jcnRjLmMNCj4gaW5kZXggYTIzNjQ5OTEyM2FhLi44ODJjNjkwZDNmMTMgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gQEAgLTE5Miw3ICsxOTIs
NiBAQCBzdGF0aWMgaW50IG10a19jcnRjX2RkcF9jbGtfZW5hYmxlKHN0cnVjdCBtdGtfZHJtX2Ny
dGMgKm10a19jcnRjKQ0KPiAgCWludCByZXQ7DQo+ICAJaW50IGk7DQo+ICANCj4gLQlEUk1fREVC
VUdfRFJJVkVSKCIlc1xuIiwgX19mdW5jX18pOw0KPiAgCWZvciAoaSA9IDA7IGkgPCBtdGtfY3J0
Yy0+ZGRwX2NvbXBfbnI7IGkrKykgew0KPiAgCQlyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUobXRr
X2NydGMtPmRkcF9jb21wW2ldLT5jbGspOw0KPiAgCQlpZiAocmV0KSB7DQo+IEBAIC0yMTIsNyAr
MjExLDYgQEAgc3RhdGljIHZvaWQgbXRrX2NydGNfZGRwX2Nsa19kaXNhYmxlKHN0cnVjdCBtdGtf
ZHJtX2NydGMgKm10a19jcnRjKQ0KPiAgew0KPiAgCWludCBpOw0KPiAgDQo+IC0JRFJNX0RFQlVH
X0RSSVZFUigiJXNcbiIsIF9fZnVuY19fKTsNCj4gIAlmb3IgKGkgPSAwOyBpIDwgbXRrX2NydGMt
PmRkcF9jb21wX25yOyBpKyspDQo+ICAJCWNsa19kaXNhYmxlX3VucHJlcGFyZShtdGtfY3J0Yy0+
ZGRwX2NvbXBbaV0tPmNsayk7DQo+ICB9DQo+IEBAIC0yNTcsNyArMjU1LDYgQEAgc3RhdGljIGlu
dCBtdGtfY3J0Y19kZHBfaHdfaW5pdChzdHJ1Y3QgbXRrX2RybV9jcnRjICptdGtfY3J0YykNCj4g
IAlpbnQgcmV0Ow0KPiAgCWludCBpOw0KPiAgDQo+IC0JRFJNX0RFQlVHX0RSSVZFUigiJXNcbiIs
IF9fZnVuY19fKTsNCj4gIAlpZiAoV0FSTl9PTighY3J0Yy0+c3RhdGUpKQ0KPiAgCQlyZXR1cm4g
LUVJTlZBTDsNCj4gIA0KPiBAQCAtMjk4LDcgKzI5NSw2IEBAIHN0YXRpYyBpbnQgbXRrX2NydGNf
ZGRwX2h3X2luaXQoc3RydWN0IG10a19kcm1fY3J0YyAqbXRrX2NydGMpDQo+ICAJCWdvdG8gZXJy
X211dGV4X3VucHJlcGFyZTsNCj4gIAl9DQo+ICANCj4gLQlEUk1fREVCVUdfRFJJVkVSKCJtZWRp
YXRla19kZHBfZGRwX3BhdGhfc2V0dXBcbiIpOw0KPiAgCWZvciAoaSA9IDA7IGkgPCBtdGtfY3J0
Yy0+ZGRwX2NvbXBfbnIgLSAxOyBpKyspIHsNCj4gIAkJbXRrX2RkcF9hZGRfY29tcF90b19wYXRo
KG10a19jcnRjLT5jb25maWdfcmVncywNCj4gIAkJCQkJIG10a19jcnRjLT5kZHBfY29tcFtpXS0+
aWQsDQo+IEBAIC0zNDgsNyArMzQ0LDYgQEAgc3RhdGljIHZvaWQgbXRrX2NydGNfZGRwX2h3X2Zp
bmkoc3RydWN0IG10a19kcm1fY3J0YyAqbXRrX2NydGMpDQo+ICAJc3RydWN0IGRybV9jcnRjICpj
cnRjID0gJm10a19jcnRjLT5iYXNlOw0KPiAgCWludCBpOw0KPiAgDQo+IC0JRFJNX0RFQlVHX0RS
SVZFUigiJXNcbiIsIF9fZnVuY19fKTsNCj4gIAlmb3IgKGkgPSAwOyBpIDwgbXRrX2NydGMtPmRk
cF9jb21wX25yOyBpKyspIHsNCj4gIAkJbXRrX2RkcF9jb21wX3N0b3AobXRrX2NydGMtPmRkcF9j
b21wW2ldKTsNCj4gIAkJaWYgKGkgPT0gMSkNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fZHJ2LmMNCj4gaW5kZXggMTdmMTE4ZWUwZTU3Li40OTM0ODM0OTc3YjMgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+IEBAIC01NzAsNyArNTcwLDYgQEAg
c3RhdGljIGludCBtdGtfZHJtX3N5c19zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIAlp
bnQgcmV0Ow0KPiAgDQo+ICAJcmV0ID0gZHJtX21vZGVfY29uZmlnX2hlbHBlcl9zdXNwZW5kKGRy
bSk7DQo+IC0JRFJNX0RFQlVHX0RSSVZFUigibXRrX2RybV9zeXNfc3VzcGVuZFxuIik7DQo+ICAN
Cj4gIAlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiBAQCAtNTgyLDcgKzU4MSw2IEBAIHN0YXRpYyBpbnQg
bXRrX2RybV9zeXNfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIAlpbnQgcmV0Ow0KPiAg
DQo+ICAJcmV0ID0gZHJtX21vZGVfY29uZmlnX2hlbHBlcl9yZXN1bWUoZHJtKTsNCj4gLQlEUk1f
REVCVUdfRFJJVkVSKCJtdGtfZHJtX3N5c19yZXN1bWVcbiIpOw0KPiAgDQo+ICAJcmV0dXJuIHJl
dDsNCj4gIH0NCg0K

