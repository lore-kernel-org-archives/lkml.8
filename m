Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4760C433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E22D2074D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="iwrWM31b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgIEINY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 04:13:24 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:45021 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728465AbgIEINQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 04:13:16 -0400
X-UUID: 38073dafc12747399c40f46c1441f9d4-20200905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=p4EK5vyv0eeNDaeBp35kTExdjLa8HVmmTDPCf9vXFLA=;
        b=iwrWM31bfE5jmgnnGnmTKv+zH+8J1F/iUphulhTGt3RmCpOOyfblndJbTJ51HQEWf2MW4kiyk8JCpX7QrXjOP5YsgLlJPM6raud7Qo1FcBO98dJ8JVm1uSZVGRBhAM4XVn8PWy6pgHQSm6l8ZWwW0v6BEz/aIXW/6RIiTlWFvTE=;
X-UUID: 38073dafc12747399c40f46c1441f9d4-20200905
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2081906385; Sat, 05 Sep 2020 16:13:14 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 5 Sep 2020 16:13:11 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 5 Sep 2020 16:13:05 +0800
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
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>
Subject: [PATCH v2 13/23] iommu/mediatek: Add device link for smi-common and m4u
Date:   Sat, 5 Sep 2020 16:09:10 +0800
Message-ID: <20200905080920.13396-14-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200905080920.13396-1-yong.wu@mediatek.com>
References: <20200905080920.13396-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gdGhlIGxhc3Rlc3QgU29DLCBNNFUgaGFzIGl0cyBzcGVjaWFsIHBvd2VyIGRvbWFpbi4gdGh1
cywgSWYgdGhlIGVuZ2luZQ0KYmVnaW4gdG8gd29yaywgaXQgc2hvdWxkIGhlbHAgZW5hYmxlIHRo
ZSBwb3dlciBmb3IgTTRVIGZpcnN0bHkuDQpDdXJyZW50bHkgaWYgdGhlIGVuZ2luZSB3b3JrLCBp
dCBhbHdheXMgZW5hYmxlIHRoZSBwb3dlci9jbG9ja3MgZm9yDQpzbWktbGFyYnMvc21pLWNvbW1v
bi4gVGhpcyBwYXRjaCBhZGRzIGRldmljZV9saW5rIGZvciBzbWktY29tbW9uIGFuZCBNNFUuDQp0
aGVuLCBpZiBzbWktY29tbW9uIHBvd2VyIGlzIGVuYWJsZWQsIHRoZSBNNFUgcG93ZXIgYWxzbyBp
cyBwb3dlcmVkIG9uDQphdXRvbWF0aWNhbGx5Lg0KDQpOb3JtYWxseSBNNFUgY29ubmVjdCB3aXRo
IHNldmVyYWwgc21pLWxhcmJzIGFuZCB0aGVpciBzbWktY29tbW9uIGFsd2F5cw0KYXJlIHRoZSBz
YW1lLCBJbiB0aGlzIHBhdGNoIGl0IGdldCBzbWktY29tbW9uIGRldiBmcm9tIHRoZSBmaXJzdCBz
bWktbGFyYg0KZGV2aWNlKGk9PTApLCB0aGVuIGFkZCB0aGUgZGV2aWNlX2xpbmsgb25seSB3aGls
ZSBtNHUgaGFzIHBvd2VyLWRvbWFpbi4NCg0KU2lnbmVkLW9mZi1ieTogWW9uZyBXdSA8eW9uZy53
dUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2lvbW11L210a19pb21tdS5jIHwgMzMgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tDQogZHJpdmVycy9pb21tdS9tdGtfaW9tbXUu
aCB8ICAxICsNCiAyIGZpbGVzIGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJpdmVycy9p
b21tdS9tdGtfaW9tbXUuYw0KaW5kZXggOTQwYjdhOTE5MWIyLi42OGRlNTllMGQ1MjEgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQorKysgYi9kcml2ZXJzL2lvbW11L210
a19pb21tdS5jDQpAQCAtMjAsNiArMjAsNyBAQA0KICNpbmNsdWRlIDxsaW51eC9vZl9pcnEuaD4N
CiAjaW5jbHVkZSA8bGludXgvb2ZfcGxhdGZvcm0uaD4NCiAjaW5jbHVkZSA8bGludXgvcGxhdGZv
cm1fZGV2aWNlLmg+DQorI2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCiAjaW5jbHVkZSA8
bGludXgvc2xhYi5oPg0KICNpbmNsdWRlIDxsaW51eC9zcGlubG9jay5oPg0KICNpbmNsdWRlIDxh
c20vYmFycmllci5oPg0KQEAgLTY4MSw3ICs2ODIsNyBAQCBzdGF0aWMgaW50IG10a19pb21tdV9w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAkJcmV0dXJuIGxhcmJfbnI7DQog
DQogCWZvciAoaSA9IDA7IGkgPCBsYXJiX25yOyBpKyspIHsNCi0JCXN0cnVjdCBkZXZpY2Vfbm9k
ZSAqbGFyYm5vZGU7DQorCQlzdHJ1Y3QgZGV2aWNlX25vZGUgKmxhcmJub2RlLCAqc21pY29tbV9u
b2RlOw0KIAkJc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGxhcmJkZXY7DQogCQl1MzIgaWQ7DQog
DQpAQCAtNzA3LDYgKzcwOCwyNiBAQCBzdGF0aWMgaW50IG10a19pb21tdV9wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIA0KIAkJY29tcG9uZW50X21hdGNoX2FkZF9yZWxlYXNl
KGRldiwgJm1hdGNoLCByZWxlYXNlX29mLA0KIAkJCQkJICAgIGNvbXBhcmVfb2YsIGxhcmJub2Rl
KTsNCisJCWlmICghaSkgew0KKwkJCXNtaWNvbW1fbm9kZSA9IG9mX3BhcnNlX3BoYW5kbGUobGFy
Ym5vZGUsICJtZWRpYXRlayxzbWkiLCAwKTsNCisJCQlpZiAoIXNtaWNvbW1fbm9kZSkNCisJCQkJ
cmV0dXJuIC1FSU5WQUw7DQorDQorCQkJcGxhcmJkZXYgPSBvZl9maW5kX2RldmljZV9ieV9ub2Rl
KHNtaWNvbW1fbm9kZSk7DQorCQkJb2Zfbm9kZV9wdXQoc21pY29tbV9ub2RlKTsNCisJCQlkYXRh
LT5zbWljb21tX2RldiA9ICZwbGFyYmRldi0+ZGV2Ow0KKwkJfQ0KKwl9DQorDQorCWlmIChkZXYt
PnBtX2RvbWFpbikgew0KKwkJc3RydWN0IGRldmljZV9saW5rICpsaW5rOw0KKw0KKwkJbGluayA9
IGRldmljZV9saW5rX2FkZChkYXRhLT5zbWljb21tX2RldiwgZGV2LA0KKwkJCQkgICAgICAgRExf
RkxBR19TVEFURUxFU1MgfCBETF9GTEFHX1BNX1JVTlRJTUUpOw0KKwkJaWYgKCFsaW5rKSB7DQor
CQkJZGV2X2VycihkZXYsICJVbmFibGUgbGluayAlcy5cbiIsIGRldl9uYW1lKGRhdGEtPnNtaWNv
bW1fZGV2KSk7DQorCQkJcmV0dXJuIC1FSU5WQUw7DQorCQl9DQogCX0NCiANCiAJcGxhdGZvcm1f
c2V0X2RydmRhdGEocGRldiwgZGF0YSk7DQpAQCAtNzE0LDE0ICs3MzUsMTQgQEAgc3RhdGljIGlu
dCBtdGtfaW9tbXVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJcmV0ID0g
aW9tbXVfZGV2aWNlX3N5c2ZzX2FkZCgmZGF0YS0+aW9tbXUsIGRldiwgTlVMTCwNCiAJCQkJICAg
ICAibXRrLWlvbW11LiVwYSIsICZpb2FkZHIpOw0KIAlpZiAocmV0KQ0KLQkJcmV0dXJuIHJldDsN
CisJCWdvdG8gb3V0Ow0KIA0KIAlpb21tdV9kZXZpY2Vfc2V0X29wcygmZGF0YS0+aW9tbXUsICZt
dGtfaW9tbXVfb3BzKTsNCiAJaW9tbXVfZGV2aWNlX3NldF9md25vZGUoJmRhdGEtPmlvbW11LCAm
cGRldi0+ZGV2Lm9mX25vZGUtPmZ3bm9kZSk7DQogDQogCXJldCA9IGlvbW11X2RldmljZV9yZWdp
c3RlcigmZGF0YS0+aW9tbXUpOw0KIAlpZiAocmV0KQ0KLQkJcmV0dXJuIHJldDsNCisJCWdvdG8g
b3V0Ow0KIA0KIAlzcGluX2xvY2tfaW5pdCgmZGF0YS0+dGxiX2xvY2spOw0KIAlsaXN0X2FkZF90
YWlsKCZkYXRhLT5saXN0LCAmbTR1bGlzdCk7DQpAQCAtNzMwLDYgKzc1MSwxMCBAQCBzdGF0aWMg
aW50IG10a19pb21tdV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAkJYnVz
X3NldF9pb21tdSgmcGxhdGZvcm1fYnVzX3R5cGUsICZtdGtfaW9tbXVfb3BzKTsNCiANCiAJcmV0
dXJuIGNvbXBvbmVudF9tYXN0ZXJfYWRkX3dpdGhfbWF0Y2goZGV2LCAmbXRrX2lvbW11X2NvbV9v
cHMsIG1hdGNoKTsNCitvdXQ6DQorCWlmIChkZXYtPnBtX2RvbWFpbikNCisJCWRldmljZV9saW5r
X3JlbW92ZShkYXRhLT5zbWljb21tX2RldiwgZGV2KTsNCisJcmV0dXJuIHJldDsNCiB9DQogDQog
c3RhdGljIGludCBtdGtfaW9tbXVfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQpAQCAtNzQzLDYgKzc2OCw4IEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11X3JlbW92ZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAkJYnVzX3NldF9pb21tdSgmcGxhdGZvcm1fYnVzX3R5
cGUsIE5VTEwpOw0KIA0KIAljbGtfZGlzYWJsZV91bnByZXBhcmUoZGF0YS0+YmNsayk7DQorCWlm
IChwZGV2LT5kZXYucG1fZG9tYWluKQ0KKwkJZGV2aWNlX2xpbmtfcmVtb3ZlKGRhdGEtPnNtaWNv
bW1fZGV2LCAmcGRldi0+ZGV2KTsNCiAJZGV2bV9mcmVlX2lycSgmcGRldi0+ZGV2LCBkYXRhLT5p
cnEsIGRhdGEpOw0KIAljb21wb25lbnRfbWFzdGVyX2RlbCgmcGRldi0+ZGV2LCAmbXRrX2lvbW11
X2NvbV9vcHMpOw0KIAlyZXR1cm4gMDsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19p
b21tdS5oIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0KaW5kZXggYTJlMmM4NDRiOTZlLi5h
ZTc5MDk4MTVjZGIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQorKysg
Yi9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQpAQCAtNjcsNiArNjcsNyBAQCBzdHJ1Y3QgbXRr
X2lvbW11X2RhdGEgew0KIA0KIAlzdHJ1Y3QgaW9tbXVfZGV2aWNlCQlpb21tdTsNCiAJY29uc3Qg
c3RydWN0IG10a19pb21tdV9wbGF0X2RhdGEgKnBsYXRfZGF0YTsNCisJc3RydWN0IGRldmljZQkJ
CSpzbWljb21tX2RldjsNCiANCiAJc3RydWN0IGRtYV9pb21tdV9tYXBwaW5nCSptYXBwaW5nOyAv
KiBGb3IgbXRrX2lvbW11X3YxLmMgKi8NCiANCi0tIA0KMi4xOC4wDQo=

