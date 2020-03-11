Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD6FC3F2D0
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344E5222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OdoZRqYe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgCKHlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:41:20 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:35193 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726198AbgCKHlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:41:19 -0400
X-UUID: fa473359c47149918de90198436f3f65-20200311
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=npWCMlNAf6vwIc/DWpZvRQRY1F0x8+HE51QC285Pl4k=;
        b=OdoZRqYeIIfHqfGz8YoRqyNfcB0Giusls61DhZdFk3ee1JOnQzAV5sqTnfW1E9aJzseZkM4eIyzEkUxdEtSm/EUJAVrFEFNho7K6M0FKfOPOlmDzgX7Q7IBeoN95E8zAk22lwIz4HwK1VG9Uq/0x4e8YPO1UNgV9ONMeius64io=;
X-UUID: fa473359c47149918de90198436f3f65-20200311
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2117756342; Wed, 11 Mar 2020 15:41:06 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 11 Mar
 2020 15:41:25 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Wed, 11 Mar 2020 15:42:06 +0800
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
Subject: [PATCH v3 4/4] drm/mediatek: config mipitx impedance with calibration data
Date:   Wed, 11 Mar 2020 15:40:32 +0800
Message-ID: <20200311074032.119481-5-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200311074032.119481-1-jitao.shi@mediatek.com>
References: <20200311074032.119481-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F58B740D8966EE329A7B198D2569BE8D1EF0981AF9706E2EFCADD53E09D0F5262000:8
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
LmMNCmluZGV4IDEyNGZkZjk1ZjFlNS4uODc4ZmVlYjdhYzZjIDEwMDY0NA0KLS0tIGEvZHJpdmVy
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
U0lfSFNUWF9MRE9fUkVGX1NFTCwNCiAJCQkJbWlwaV90eC0+bWlwaXR4X2RyaXZlIDw8IDYpOw0K
IA0KKwltdGtfbWlwaV90eF9jb25maWdfY2FsaWJyYXRpb25fZGF0YShtaXBpX3R4KTsNCisNCiAJ
bXRrX21pcGlfdHhfc2V0X2JpdHMobWlwaV90eCwgTUlQSVRYX0NLX0NLTU9ERV9FTiwgRFNJX0NL
X0NLTU9ERV9FTik7DQogfQ0KIA0KLS0gDQoyLjIxLjANCg==

