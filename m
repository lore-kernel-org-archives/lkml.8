Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC4AC433E8
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D327820720
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="guSC6q38"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgGKGwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 02:52:44 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:20251 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726900AbgGKGwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 02:52:42 -0400
X-UUID: be68c517f8804365b67975553d85335d-20200711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=SMQQ6cvreFHKCw1lLAb1UVMLyz1zf9fnxfMshvwqUfA=;
        b=guSC6q38+9QwXABxM65BAHlvWbYGuWwOSNjAq3gVbylThxWz8vExLcdQoqYrQx6K0v5HbutmfTtRD0CLkv3Vr4NCfga3wLDMw2XrznWXrZEW7MsGki1jlwBanHqM/c6b/EbeDW8k6EyE3LyJfJfehVAYdmsDz+fUxwztqz7XeUg=;
X-UUID: be68c517f8804365b67975553d85335d-20200711
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 475382782; Sat, 11 Jul 2020 14:52:35 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Jul 2020 14:52:25 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Jul 2020 14:52:24 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Will Deacon <will@kernel.org>, Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <cui.zhang@mediatek.com>,
        <chao.hao@mediatek.com>, <ming-fan.chen@mediatek.com>
Subject: [PATCH 18/21] iommu/mediatek: Add support for multi domain
Date:   Sat, 11 Jul 2020 14:48:43 +0800
Message-ID: <20200711064846.16007-19-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200711064846.16007-1-yong.wu@mediatek.com>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29tZSBIVyBJUChleDogQ0NVKSByZXF1aXJlIHRoZSBzcGVjaWFsIGlvdmEgcmFuZ2UuIFRoYXQg
bWVhbnMgdGhlDQppb3ZhIGdvdCBmcm9tIGRtYV9hbGxvY19hdHRycyBmb3IgdGhhdCBkZXZpY2Vz
IG11c3QgbG9jYXRlIGluIGhpcw0Kc3BlY2lhbCByYW5nZS4gSW4gdGhpcyBwYXRjaCwgd2UgYWxs
b2NhdGUgYSBzcGVjaWFsIGlvdmFfcmFuZ2UgZm9yDQplYWNoIGEgc3BlY2lhbCByZXF1aXJlbWVu
dCBhbmQgY3JlYXRlIGVhY2ggYSBpb21tdSBkb21haW4gZm9yIGVhY2gNCmEgaW92YV9yYW5nZS4N
Cg0KbWVhbndoaWxlIHdlIHN0aWxsIHVzZSBvbmUgcGFnZXRhYmxlIHdoaWNoIHN1cHBvcnQgMTZH
QiBpb3ZhLg0KDQpBZnRlciB0aGlzIHBhdGNoLCBJZiB0aGUgaW92YSByYW5nZSBvZiBhIG1hc3Rl
ciBpcyBvdmVyIDRHLCB0aGUgbWFzdGVyDQpzaG91bGQ6DQphKSBEZWNsYXJlIGl0cyBzcGVjaWFs
IGRtYV9yYW5nZXMgaW4gaXRzIGR0c2kgbm9kZS4gRm9yIGV4YW1wbGUsIElmIHdlDQpwcmVhc3Np
Z24gdGhlIGlvdmEgNEctOEcgZm9yIHZjb2RlYywgdGhlbiB0aGUgdmNvZGVjIGR0c2kgbm9kZSBz
aG91bGQ6DQoJZG1hLXJhbmdlcyA9IDwweDEgMHgwIDB4MSAweDAgMHgxIDB4MD47ICAvKiA0RyB+
IDhHICovDQpiKSBVcGRhdGUgdGhlIGRtYV9tYXNrOg0KIGRtYV9zZXRfbWFza19hbmRfY29oZXJl
bnQoZGV2LCBETUFfQklUX01BU0soMzMpKTsNCg0KU2lnbmVkLW9mZi1ieTogWW9uZyBXdSA8eW9u
Zy53dUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2lvbW11L210a19pb21tdS5jIHwgNDkg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tDQogZHJpdmVycy9pb21tdS9t
dGtfaW9tbXUuaCB8ICAzICsrLQ0KIDIgZmlsZXMgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKSwg
MTAgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5j
IGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KaW5kZXggNzY2YzllNzNkNTQxLi43ZGZkODA3
MWE4NTggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQorKysgYi9kcml2
ZXJzL2lvbW11L210a19pb21tdS5jDQpAQCAtMzYxLDYgKzM2MSwxNCBAQCBzdGF0aWMgaW50IG10
a19pb21tdV9kb21haW5fZmluYWxpc2Uoc3RydWN0IG10a19pb21tdV9kb21haW4gKmRvbSkNCiB7
DQogCXN0cnVjdCBtdGtfaW9tbXVfZGF0YSAqZGF0YSA9IG10a19pb21tdV9nZXRfbTR1X2RhdGEo
KTsNCiANCisJLyogVXNlIHRoZSBleGlzdCBkb21haW4gYXMgdGhlcmUgaXMgb25lIG00dSBwZ3Rh
YmxlIGhlcmUuICovDQorCWlmIChkYXRhLT5tNHVfZG9tKSB7DQorCQlkb20tPmlvcCA9IGRhdGEt
Pm00dV9kb20tPmlvcDsNCisJCWRvbS0+Y2ZnID0gZGF0YS0+bTR1X2RvbS0+Y2ZnOw0KKwkJZG9t
LT5kb21haW4ucGdzaXplX2JpdG1hcCA9IGRhdGEtPm00dV9kb20tPmNmZy5wZ3NpemVfYml0bWFw
Ow0KKwkJcmV0dXJuIDA7DQorCX0NCisNCiAJZG9tLT5jZmcgPSAoc3RydWN0IGlvX3BndGFibGVf
Y2ZnKSB7DQogCQkucXVpcmtzID0gSU9fUEdUQUJMRV9RVUlSS19BUk1fTlMgfA0KIAkJCUlPX1BH
VEFCTEVfUVVJUktfTk9fUEVSTVMgfA0KQEAgLTM4Niw2ICszOTQsOCBAQCBzdGF0aWMgaW50IG10
a19pb21tdV9kb21haW5fZmluYWxpc2Uoc3RydWN0IG10a19pb21tdV9kb21haW4gKmRvbSkNCiAN
CiBzdGF0aWMgc3RydWN0IGlvbW11X2RvbWFpbiAqbXRrX2lvbW11X2RvbWFpbl9hbGxvYyh1bnNp
Z25lZCB0eXBlKQ0KIHsNCisJc3RydWN0IG10a19pb21tdV9kYXRhICpkYXRhID0gbXRrX2lvbW11
X2dldF9tNHVfZGF0YSgpOw0KKwljb25zdCBzdHJ1Y3QgbXRrX2lvbW11X2lvdmFfcmVnaW9uICpy
ZWdpb247DQogCXN0cnVjdCBtdGtfaW9tbXVfZG9tYWluICpkb207DQogDQogCWlmICh0eXBlICE9
IElPTU1VX0RPTUFJTl9ETUEpDQpAQCAtNDAxLDggKzQxMSwxMCBAQCBzdGF0aWMgc3RydWN0IGlv
bW11X2RvbWFpbiAqbXRrX2lvbW11X2RvbWFpbl9hbGxvYyh1bnNpZ25lZCB0eXBlKQ0KIAlpZiAo
bXRrX2lvbW11X2RvbWFpbl9maW5hbGlzZShkb20pKQ0KIAkJZ290byAgcHV0X2RtYV9jb29raWU7
DQogDQotCWRvbS0+ZG9tYWluLmdlb21ldHJ5LmFwZXJ0dXJlX3N0YXJ0ID0gMDsNCi0JZG9tLT5k
b21haW4uZ2VvbWV0cnkuYXBlcnR1cmVfZW5kID0gRE1BX0JJVF9NQVNLKDMyKTsNCisJcmVnaW9u
ID0gZGF0YS0+cGxhdF9kYXRhLT5pb3ZhX3JlZ2lvbiArIGRhdGEtPmN1cl9kb21pZDsNCisJZG9t
LT5kb21haW4uZ2VvbWV0cnkuYXBlcnR1cmVfc3RhcnQgPSByZWdpb24tPmlvdmFfYmFzZTsNCisJ
ZG9tLT5kb21haW4uZ2VvbWV0cnkuYXBlcnR1cmVfZW5kID0gcmVnaW9uLT5pb3ZhX2Jhc2UgKw0K
KwkJCQkJCXJlZ2lvbi0+c2l6ZSAtIDE7DQogCWRvbS0+ZG9tYWluLmdlb21ldHJ5LmZvcmNlX2Fw
ZXJ0dXJlID0gdHJ1ZTsNCiANCiAJcmV0dXJuICZkb20tPmRvbWFpbjsNCkBAIC01NDAsMTkgKzU1
MiwzMSBAQCBzdGF0aWMgdm9pZCBtdGtfaW9tbXVfcmVsZWFzZV9kZXZpY2Uoc3RydWN0IGRldmlj
ZSAqZGV2KQ0KIHN0YXRpYyBzdHJ1Y3QgaW9tbXVfZ3JvdXAgKm10a19pb21tdV9kZXZpY2VfZ3Jv
dXAoc3RydWN0IGRldmljZSAqZGV2KQ0KIHsNCiAJc3RydWN0IG10a19pb21tdV9kYXRhICpkYXRh
ID0gbXRrX2lvbW11X2dldF9tNHVfZGF0YSgpOw0KKwlzdHJ1Y3QgaW9tbXVfZndzcGVjICpmd3Nw
ZWMgPSBkZXZfaW9tbXVfZndzcGVjX2dldChkZXYpOw0KKwlzdHJ1Y3QgaW9tbXVfZ3JvdXAgKmdy
b3VwOw0KKwlpbnQgZG9taWQ7DQogDQogCWlmICghZGF0YSkNCiAJCXJldHVybiBFUlJfUFRSKC1F
Tk9ERVYpOw0KIA0KLQkvKiBBbGwgdGhlIGNsaWVudCBkZXZpY2VzIGFyZSBpbiB0aGUgc2FtZSBt
NHUgaW9tbXUtZ3JvdXAgKi8NCi0JaWYgKCFkYXRhLT5tNHVfZ3JvdXApIHsNCi0JCWRhdGEtPm00
dV9ncm91cCA9IGlvbW11X2dyb3VwX2FsbG9jKCk7DQotCQlpZiAoSVNfRVJSKGRhdGEtPm00dV9n
cm91cCkpDQorCWRvbWlkID0gTVRLX000VV9UT19ET00oZndzcGVjLT5pZHNbMF0pOw0KKwlpZiAo
ZG9taWQgPj0gZGF0YS0+cGxhdF9kYXRhLT5pb3ZhX3JlZ2lvbl9ucikgew0KKwkJZGV2X2Vycihk
ZXYsICJkb21haW4gaWQoJWQvJWQpIGlzIGVycm9yLlxuIiwgZG9taWQsDQorCQkJZGF0YS0+cGxh
dF9kYXRhLT5pb3ZhX3JlZ2lvbl9ucik7DQorCQlyZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsNCisJ
fQ0KKw0KKwlncm91cCA9IGRhdGEtPm00dV9ncm91cFtkb21pZF07DQorCWlmICghZ3JvdXApIHsN
CisJCWdyb3VwID0gaW9tbXVfZ3JvdXBfYWxsb2MoKTsNCisJCWlmIChJU19FUlIoZ3JvdXApKQ0K
IAkJCWRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGFsbG9jYXRlIE00VSBJT01NVSBncm91cFxuIik7
DQorCQlkYXRhLT5tNHVfZ3JvdXBbZG9taWRdID0gZ3JvdXA7DQogCX0gZWxzZSB7DQotCQlpb21t
dV9ncm91cF9yZWZfZ2V0KGRhdGEtPm00dV9ncm91cCk7DQorCQlpb21tdV9ncm91cF9yZWZfZ2V0
KGdyb3VwKTsNCiAJfQ0KLQlyZXR1cm4gZGF0YS0+bTR1X2dyb3VwOw0KKwlkYXRhLT5jdXJfZG9t
aWQgPSBkb21pZDsNCisJcmV0dXJuIGdyb3VwOw0KIH0NCiANCiBzdGF0aWMgaW50IG10a19pb21t
dV9vZl94bGF0ZShzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBvZl9waGFuZGxlX2FyZ3MgKmFy
Z3MpDQpAQCAtNTgxLDE0ICs2MDUsMjEgQEAgc3RhdGljIHZvaWQgbXRrX2lvbW11X2dldF9yZXN2
X3JlZ2lvbnMoc3RydWN0IGRldmljZSAqZGV2LA0KIAkJCQkgICAgICAgc3RydWN0IGxpc3RfaGVh
ZCAqaGVhZCkNCiB7DQogCXN0cnVjdCBtdGtfaW9tbXVfZGF0YSAqZGF0YSA9IGRldl9pb21tdV9w
cml2X2dldChkZXYpOw0KLQljb25zdCBzdHJ1Y3QgbXRrX2lvbW11X2lvdmFfcmVnaW9uICpyZXN2
Ow0KKwljb25zdCBzdHJ1Y3QgbXRrX2lvbW11X2lvdmFfcmVnaW9uICpyZXN2LCAqY3VyZG9tOw0K
IAlzdHJ1Y3QgaW9tbXVfcmVzdl9yZWdpb24gKnJlZ2lvbjsNCiAJaW50IHByb3QgPSBJT01NVV9X
UklURSB8IElPTU1VX1JFQUQ7DQogCXVuc2lnbmVkIGludCBpOw0KIA0KKwljdXJkb20gPSBkYXRh
LT5wbGF0X2RhdGEtPmlvdmFfcmVnaW9uICsgZGF0YS0+Y3VyX2RvbWlkOw0KIAlmb3IgKGkgPSAw
OyBpIDwgZGF0YS0+cGxhdF9kYXRhLT5pb3ZhX3JlZ2lvbl9ucjsgaSsrKSB7DQogCQlyZXN2ID0g
ZGF0YS0+cGxhdF9kYXRhLT5pb3ZhX3JlZ2lvbiArIGk7DQogDQorCQkvKiBPbmx5IHJlc2VydmUg
d2hlbiB0aGUgcmVnaW9uIGlzIGluIHRoZSBjdXJyZW50IGRvbWFpbiAqLw0KKwkJaWYgKHJlc3Yt
PmlvdmFfYmFzZSA8PSBjdXJkb20tPmlvdmFfYmFzZSB8fA0KKwkJICAgIHJlc3YtPmlvdmFfYmFz
ZSArIHJlc3YtPnNpemUgPj0NCisJCQkJCWN1cmRvbS0+aW92YV9iYXNlICsgY3VyZG9tLT5zaXpl
KQ0KKwkJCWNvbnRpbnVlOw0KKw0KIAkJcmVnaW9uID0gaW9tbXVfYWxsb2NfcmVzdl9yZWdpb24o
cmVzdi0+aW92YV9iYXNlLCByZXN2LT5zaXplLA0KIAkJCQkJCSBwcm90LCBJT01NVV9SRVNWX1JF
U0VSVkVEKTsNCiAJCWlmICghcmVnaW9uKQ0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRr
X2lvbW11LmggYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQppbmRleCBiYjkyOWI4NzVkOGMu
LjExNzk1YjhkODJmZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCisr
KyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCkBAIC02NSw3ICs2NSw3IEBAIHN0cnVjdCBt
dGtfaW9tbXVfZGF0YSB7DQogCXBoeXNfYWRkcl90CQkJcHJvdGVjdF9iYXNlOyAvKiBwcm90ZWN0
IG1lbW9yeSBiYXNlICovDQogCXN0cnVjdCBtdGtfaW9tbXVfc3VzcGVuZF9yZWcJcmVnOw0KIAlz
dHJ1Y3QgbXRrX2lvbW11X2RvbWFpbgkJKm00dV9kb207DQotCXN0cnVjdCBpb21tdV9ncm91cAkJ
Km00dV9ncm91cDsNCisJc3RydWN0IGlvbW11X2dyb3VwCQkqbTR1X2dyb3VwW01US19NNFVfRE9N
X05SX01BWF07DQogCWJvb2wgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW5hYmxlXzRHQjsN
CiAJc3BpbmxvY2tfdAkJCXRsYl9sb2NrOyAvKiBsb2NrIGZvciB0bGIgcmFuZ2UgZmx1c2ggKi8N
CiANCkBAIC03Myw2ICs3Myw3IEBAIHN0cnVjdCBtdGtfaW9tbXVfZGF0YSB7DQogCWNvbnN0IHN0
cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhICpwbGF0X2RhdGE7DQogCXN0cnVjdCBkZXZpY2UJCQkq
c21pY29tbV9kZXY7DQogDQorCXVuc2lnbmVkIGludAkJCWN1cl9kb21pZDsNCiAJc3RydWN0IGxp
c3RfaGVhZAkJbGlzdDsNCiAJc3RydWN0IG10a19zbWlfbGFyYl9pb21tdQlsYXJiX2ltdVtNVEtf
TEFSQl9OUl9NQVhdOw0KIH07DQotLSANCjIuMTguMA0K

