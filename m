Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74646C2D0E8
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45976207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KpdNB/QG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgCaI2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 04:28:30 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:51101 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729795AbgCaI23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 04:28:29 -0400
X-UUID: 12613cb0211e47778dd9565e692788fb-20200331
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=YQ57/0uYu8e2rMbWbbfkX9m+q6kPZQyOhAzfeLnK1/g=;
        b=KpdNB/QGALXWhAauazNBulgahq8crIoinuziaDxhTgfvtR3rUq+YdCIXDDM/nQbM14Ts0n96xFg6Tukv9IT7bGRB46M8XkxwLmNsH7+te5arUBJ5s9pVCUh6ZZzxZlzPBL25YK4LQ2i9nLI9mZxsKfx0mpF6lFn9G8SK2qky79g=;
X-UUID: 12613cb0211e47778dd9565e692788fb-20200331
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1445999765; Tue, 31 Mar 2020 16:27:59 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 31 Mar
 2020 16:27:59 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Tue, 31 Mar 2020 16:27:56 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, <huijuan.xie@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v4 4/4] drm/mediatek: config mipitx impedance with calibration data
Date:   Tue, 31 Mar 2020 16:27:25 +0800
Message-ID: <20200331082725.81048-5-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200331082725.81048-1-jitao.shi@mediatek.com>
References: <20200331082725.81048-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: AE94F9B996E80ACF14AC902A5CF3432598D7C8C9E609F120D86AFFCA9479468E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmVhZCBjYWxpYnJhdGlvbiBkYXRhIGZyb20gbnZtZW0sIGFuZCBjb25maWcgbWlwaXR4IGltcGVk
YW5jZSB3aXRoDQpjYWxpYnJhdGlvbiBkYXRhIHRvIG1ha2Ugc3VyZSB0aGVpciBpbXBlZGFuY2Ug
YXJlIDEwMG9obS4NCg0KU2lnbmVkLW9mZi1ieTogSml0YW8gU2hpIDxqaXRhby5zaGlAbWVkaWF0
ZWsuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19tdDgxODNfbWlwaV90
eC5jIHwgNTcgKysrKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA1NyBpbnNlcnRp
b25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX210ODE4
M19taXBpX3R4LmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX210ODE4M19taXBpX3R4
LmMNCmluZGV4IGU0Y2M5Njc3NTBjYi4uMGY4N2NkM2QxZDdkIDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19tdDgxODNfbWlwaV90eC5jDQorKysgYi9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX210ODE4M19taXBpX3R4LmMNCkBAIC01LDYgKzUsOCBAQA0KICAq
Lw0KIA0KICNpbmNsdWRlICJtdGtfbWlwaV90eC5oIg0KKyNpbmNsdWRlIDxsaW51eC9udm1lbS1j
b25zdW1lci5oPg0KKyNpbmNsdWRlIDxsaW51eC9zbGFiLmg+DQogDQogI2RlZmluZSBNSVBJVFhf
TEFORV9DT04JCTB4MDAwYw0KICNkZWZpbmUgUkdfRFNJX0NQSFlfVDFEUlZfRU4JCUJJVCgwKQ0K
QEAgLTI4LDYgKzMwLDcgQEANCiAjZGVmaW5lIE1JUElUWF9QTExfQ09ONAkJMHgwMDNjDQogI2Rl
ZmluZSBSR19EU0lfUExMX0lCSUFTCQkoMyA8PCAxMCkNCiANCisjZGVmaW5lIE1JUElUWF9EMlBf
UlRDT0RFCTB4MDEwMA0KICNkZWZpbmUgTUlQSVRYX0QyX1NXX0NUTF9FTgkweDAxNDQNCiAjZGVm
aW5lIE1JUElUWF9EMF9TV19DVExfRU4JMHgwMjQ0DQogI2RlZmluZSBNSVBJVFhfQ0tfQ0tNT0RF
X0VOCTB4MDMyOA0KQEAgLTEwOCw2ICsxMTEsNTggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBjbGtf
b3BzIG10a19taXBpX3R4X3BsbF9vcHMgPSB7DQogCS5yZWNhbGNfcmF0ZSA9IG10a19taXBpX3R4
X3BsbF9yZWNhbGNfcmF0ZSwNCiB9Ow0KIA0KK3N0YXRpYyB2b2lkIG10a19taXBpX3R4X2NvbmZp
Z19jYWxpYnJhdGlvbl9kYXRhKHN0cnVjdCBtdGtfbWlwaV90eCAqbWlwaV90eCkNCit7DQorCXUz
MiAqYnVmOw0KKwl1MzIgcnRfY29kZVs1XTsNCisJaW50IGksIGo7DQorCXN0cnVjdCBudm1lbV9j
ZWxsICpjZWxsOw0KKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBtaXBpX3R4LT5kZXY7DQorCXNpemVf
dCBsZW47DQorDQorCWNlbGwgPSBudm1lbV9jZWxsX2dldChkZXYsICJjYWxpYnJhdGlvbi1kYXRh
Iik7DQorCWlmIChJU19FUlIoY2VsbCkpIHsNCisJCWRldl9pbmZvKGRldiwgIm52bWVtX2NlbGxf
Z2V0IGZhaWxcbiIpOw0KKwkJcmV0dXJuOw0KKwl9DQorDQorCWJ1ZiA9ICh1MzIgKiludm1lbV9j
ZWxsX3JlYWQoY2VsbCwgJmxlbik7DQorDQorCW52bWVtX2NlbGxfcHV0KGNlbGwpOw0KKw0KKwlp
ZiAoSVNfRVJSKGJ1ZikpIHsNCisJCWRldl9pbmZvKGRldiwgImNhbid0IGdldCBkYXRhXG4iKTsN
CisJCXJldHVybjsNCisJfQ0KKw0KKwlpZiAobGVuIDwgMyAqIHNpemVvZih1MzIpKSB7DQorCQlk
ZXZfaW5mbyhkZXYsICJpbnZhbGlkIGNhbGlicmF0aW9uIGRhdGFcbiIpOw0KKwkJa2ZyZWUoYnVm
KTsNCisJCXJldHVybjsNCisJfQ0KKw0KKwlydF9jb2RlWzBdID0gKChidWZbMF0gPj4gNiAmIDB4
MWYpIDw8IDUpIHwgKGJ1ZlswXSA+PiAxMSAmIDB4MWYpOw0KKwlydF9jb2RlWzFdID0gKChidWZb
MV0gPj4gMjcgJiAweDFmKSA8PCA1KSB8IChidWZbMF0gPj4gMSAmIDB4MWYpOw0KKwlydF9jb2Rl
WzJdID0gKChidWZbMV0gPj4gMTcgJiAweDFmKSA8PCA1KSB8IChidWZbMV0gPj4gMjIgJiAweDFm
KTsNCisJcnRfY29kZVszXSA9ICgoYnVmWzFdID4+IDcgJiAweDFmKSA8PCA1KSB8IChidWZbMV0g
Pj4gMTIgJiAweDFmKTsNCisJcnRfY29kZVs0XSA9ICgoYnVmWzJdID4+IDI3ICYgMHgxZikgPDwg
NSkgfCAoYnVmWzFdID4+IDIgJiAweDFmKTsNCisNCisJZm9yIChpID0gMDsgaSA8IDU7IGkrKykg
ew0KKwkJaWYgKChydF9jb2RlW2ldICYgMHgxZikgPT0gMCkNCisJCQlydF9jb2RlW2ldIHw9IDB4
MTA7DQorDQorCQlpZiAoKHJ0X2NvZGVbaV0gPj4gNSAmIDB4MWYpID09IDApDQorCQkJcnRfY29k
ZVtpXSB8PSAweDEwIDw8IDU7DQorDQorCQlmb3IgKGogPSAwOyBqIDwgMTA7IGorKykNCisJCQlt
dGtfbWlwaV90eF91cGRhdGVfYml0cyhtaXBpX3R4LA0KKwkJCQlNSVBJVFhfRDJQX1JUQ09ERSAq
IChpICsgMSkgKyBqICogNCwNCisJCQkJMSwgcnRfY29kZVtpXSA+PiBqICYgMSk7DQorCX0NCisN
CisJa2ZyZWUoYnVmKTsNCit9DQorDQogc3RhdGljIHZvaWQgbXRrX21pcGlfdHhfcG93ZXJfb25f
c2lnbmFsKHN0cnVjdCBwaHkgKnBoeSkNCiB7DQogCXN0cnVjdCBtdGtfbWlwaV90eCAqbWlwaV90
eCA9IHBoeV9nZXRfZHJ2ZGF0YShwaHkpOw0KQEAgLTEzMCw2ICsxODUsOCBAQCBzdGF0aWMgdm9p
ZCBtdGtfbWlwaV90eF9wb3dlcl9vbl9zaWduYWwoc3RydWN0IHBoeSAqcGh5KQ0KIAkJCQlSR19E
U0lfSFNUWF9MRE9fUkVGX1NFTCwNCiAJCQkJKG1pcGlfdHgtPm1pcGl0eF9kcml2ZSAtIDMwMDAp
IC8gMjAwIDw8IDYpOw0KIA0KKwltdGtfbWlwaV90eF9jb25maWdfY2FsaWJyYXRpb25fZGF0YSht
aXBpX3R4KTsNCisNCiAJbXRrX21pcGlfdHhfc2V0X2JpdHMobWlwaV90eCwgTUlQSVRYX0NLX0NL
TU9ERV9FTiwgRFNJX0NLX0NLTU9ERV9FTik7DQogfQ0KIA0KLS0gDQoyLjIxLjANCg==

