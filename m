Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058B9C3F2D8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 02:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43A42073D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 02:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="b8h3XU70"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387523AbgCDClH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 21:41:07 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:21963 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387397AbgCDClG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 21:41:06 -0500
X-UUID: 804602366f134ddfb09bf3b2940cae11-20200304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=mwCceAp0UE9DP1V1oSslAhzkGTPBm2qHepKguK+CBVs=;
        b=b8h3XU705L8I67ozIIDv1hw4ls4Mzu6TOah08CH+8hm1iyvhZlur8ZnpypnYQQ3TNCNM50dsaSEWyy/tZzyp7zll9Ow0B96v7fAjUtx13uf+IXIWeIEF6odBi8cEqH0VkiBGcwRzl39fXCw/dI82utaIV61OdYCuR5KKspb6jGk=;
X-UUID: 804602366f134ddfb09bf3b2940cae11-20200304
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2121261097; Wed, 04 Mar 2020 10:41:01 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 4 Mar 2020 10:39:59 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 4 Mar 2020 10:40:20 +0800
Message-ID: <1583289660.32049.4.camel@mtksdaap41>
Subject: Re: [PATCH v4 10/13] soc: mediatek: cmdq: export finalize function
From:   CK Hu <ck.hu@mediatek.com>
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        HS Liao <hs.liao@mediatek.com>
Date:   Wed, 4 Mar 2020 10:41:00 +0800
In-Reply-To: <1583233125-7827-11-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1583233125-7827-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1583233125-7827-11-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERlbm5pczoNCg0KT24gVHVlLCAyMDIwLTAzLTAzIGF0IDE4OjU4ICswODAwLCBEZW5uaXMg
WUMgSHNpZWggd3JvdGU6DQo+IEV4cG9ydCBmaW5hbGl6ZSBmdW5jdGlvbiB0byBjbGllbnQgd2hp
Y2ggaGVscHMgYXBwZW5kIGVvYyBhbmQganVtcA0KPiBjb21tYW5kIHRvIHBrdC4gTGV0IGNsaWVu
dCBkZWNpZGUgY2FsbCBmaW5hbGl6ZSBvciBub3QuDQo+IA0KDQpSZXZpZXdlZC1ieTogQ0sgSHUg
PGNrLmh1QG1lZGlhdGVrLmNvbT4NCg0KPiBTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMgSHNpZWgg
PGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcm1fY3J0Yy5jIHwgMSArDQo+ICBkcml2ZXJzL3NvYy9tZWRpYXRlay9t
dGstY21kcS1oZWxwZXIuYyAgfCA3ICsrLS0tLS0NCj4gIGluY2x1ZGUvbGludXgvc29jL21lZGlh
dGVrL210ay1jbWRxLmggICB8IDggKysrKysrKysNCj4gIDMgZmlsZXMgY2hhbmdlZCwgMTEgaW5z
ZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RybV9jcnRjLmMNCj4gaW5kZXggMGRmY2QxNzg3ZTY1Li43ZGFhYWJjMjZlYjEgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gQEAgLTQ5MCw2ICs0
OTAsNyBAQCBzdGF0aWMgdm9pZCBtdGtfZHJtX2NydGNfaHdfY29uZmlnKHN0cnVjdCBtdGtfZHJt
X2NydGMgKm10a19jcnRjKQ0KPiAgCQljbWRxX3BrdF9jbGVhcl9ldmVudChjbWRxX2hhbmRsZSwg
bXRrX2NydGMtPmNtZHFfZXZlbnQpOw0KPiAgCQljbWRxX3BrdF93ZmUoY21kcV9oYW5kbGUsIG10
a19jcnRjLT5jbWRxX2V2ZW50KTsNCj4gIAkJbXRrX2NydGNfZGRwX2NvbmZpZyhjcnRjLCBjbWRx
X2hhbmRsZSk7DQo+ICsJCWNtZHFfcGt0X2ZpbmFsaXplKGNtZHFfaGFuZGxlKTsNCj4gIAkJY21k
cV9wa3RfZmx1c2hfYXN5bmMoY21kcV9oYW5kbGUsIGRkcF9jbWRxX2NiLCBjbWRxX2hhbmRsZSk7
DQo+ICAJfQ0KPiAgI2VuZGlmDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9t
dGstY21kcS1oZWxwZXIuYyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5j
DQo+IGluZGV4IGE5ZWJiYWJiNzQzOS4uNTliYzExNjRiNDExIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiArKysgYi9kcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiBAQCAtMzcyLDcgKzM3Miw3IEBAIGludCBjbWRx
X3BrdF9hc3NpZ24oc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiByZWdfaWR4LCB1MzIgdmFsdWUp
DQo+ICB9DQo+ICBFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X2Fzc2lnbik7DQo+ICANCj4gLXN0YXRp
YyBpbnQgY21kcV9wa3RfZmluYWxpemUoc3RydWN0IGNtZHFfcGt0ICpwa3QpDQo+ICtpbnQgY21k
cV9wa3RfZmluYWxpemUoc3RydWN0IGNtZHFfcGt0ICpwa3QpDQo+ICB7DQo+ICAJc3RydWN0IGNt
ZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHsgezB9IH07DQo+ICAJaW50IGVycjsNCj4gQEAgLTM5Miw2
ICszOTIsNyBAQCBzdGF0aWMgaW50IGNtZHFfcGt0X2ZpbmFsaXplKHN0cnVjdCBjbWRxX3BrdCAq
cGt0KQ0KPiAgDQo+ICAJcmV0dXJuIGVycjsNCj4gIH0NCj4gK0VYUE9SVF9TWU1CT0woY21kcV9w
a3RfZmluYWxpemUpOw0KPiAgDQo+ICBzdGF0aWMgdm9pZCBjbWRxX3BrdF9mbHVzaF9hc3luY19j
YihzdHJ1Y3QgY21kcV9jYl9kYXRhIGRhdGEpDQo+ICB7DQo+IEBAIC00MjYsMTAgKzQyNyw2IEBA
IGludCBjbWRxX3BrdF9mbHVzaF9hc3luYyhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgY21kcV9hc3lu
Y19mbHVzaF9jYiBjYiwNCj4gIAl1bnNpZ25lZCBsb25nIGZsYWdzID0gMDsNCj4gIAlzdHJ1Y3Qg
Y21kcV9jbGllbnQgKmNsaWVudCA9IChzdHJ1Y3QgY21kcV9jbGllbnQgKilwa3QtPmNsOw0KPiAg
DQo+IC0JZXJyID0gY21kcV9wa3RfZmluYWxpemUocGt0KTsNCj4gLQlpZiAoZXJyIDwgMCkNCj4g
LQkJcmV0dXJuIGVycjsNCj4gLQ0KPiAgCXBrdC0+Y2IuY2IgPSBjYjsNCj4gIAlwa3QtPmNiLmRh
dGEgPSBkYXRhOw0KPiAgCXBrdC0+YXN5bmNfY2IuY2IgPSBjbWRxX3BrdF9mbHVzaF9hc3luY19j
YjsNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgg
Yi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQo+IGluZGV4IGZlYzI5MmFh
YzgzYy4uOTllNzcxNTVmOTY3IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRp
YXRlay9tdGstY21kcS5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1j
bWRxLmgNCj4gQEAgLTIxMyw2ICsyMTMsMTQgQEAgaW50IGNtZHFfcGt0X3BvbGxfbWFzayhzdHJ1
Y3QgY21kcV9wa3QgKnBrdCwgdTggc3Vic3lzLA0KPiAgICovDQo+ICBpbnQgY21kcV9wa3RfYXNz
aWduKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgcmVnX2lkeCwgdTMyIHZhbHVlKTsNCj4gIA0K
PiArLyoqDQo+ICsgKiBjbWRxX3BrdF9maW5hbGl6ZSgpIC0gQXBwZW5kIEVPQyBhbmQganVtcCBj
b21tYW5kIHRvIHBrdC4NCj4gKyAqIEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KPiArICoNCj4gKyAq
IFJldHVybjogMCBmb3Igc3VjY2VzczsgZWxzZSB0aGUgZXJyb3IgY29kZSBpcyByZXR1cm5lZA0K
PiArICovDQo+ICtpbnQgY21kcV9wa3RfZmluYWxpemUoc3RydWN0IGNtZHFfcGt0ICpwa3QpOw0K
PiArDQo+ICAvKioNCj4gICAqIGNtZHFfcGt0X2ZsdXNoX2FzeW5jKCkgLSB0cmlnZ2VyIENNRFEg
dG8gYXN5bmNocm9ub3VzbHkgZXhlY3V0ZSB0aGUgQ01EUQ0KPiAgICogICAgICAgICAgICAgICAg
ICAgICAgICAgIHBhY2tldCBhbmQgY2FsbCBiYWNrIGF0IHRoZSBlbmQgb2YgZG9uZSBwYWNrZXQN
Cg0K

