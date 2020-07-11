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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36C0C433E5
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D87A20720
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VisFGClx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgGKGvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 02:51:38 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:31159 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728012AbgGKGvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 02:51:37 -0400
X-UUID: 5bb257ab688b4e8aa8520fa8ce059720-20200711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5/pL7myJ2O26iScT4MuJ72d6p8fz2vqbi3T8r9cOzPA=;
        b=VisFGClxawoD8yWFdbpA87mhmf380eOk3GihNf9USealmf+LWGacao9lhDg4zfXS0QwyLIn7HcLVloHnZLpQMoI74XuHvmVvRppcmRTmLqUS8V8RlixbkyxEFfcFn9ELY1Kac56RvLoWUw3vL87HSQdZW9e2BjDAVVIHNhFxCkg=;
X-UUID: 5bb257ab688b4e8aa8520fa8ce059720-20200711
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2023529905; Sat, 11 Jul 2020 14:51:33 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Jul 2020 14:51:24 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Jul 2020 14:51:23 +0800
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
Subject: [PATCH 11/21] iommu/mediatek: Add power-domain operation
Date:   Sat, 11 Jul 2020 14:48:36 +0800
Message-ID: <20200711064846.16007-12-yong.wu@mediatek.com>
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

SW4gdGhlIHByZXZpb3VzIFNvQywgdGhlIE00VSBIVyBpcyBpbiB0aGUgRU1JIHBvd2VyIGRvbWFp
biB3aGljaCBpcw0KYWx3YXlzIG9uLiB0aGUgbGF0ZXN0IE00VSBpcyBpbiB0aGUgZGlzcGxheSBw
b3dlciBkb21haW4gd2hpY2ggbWF5IGJlDQp0dXJuZWQgb24vb2ZmLCB0aHVzIHdlIGhhdmUgdG8g
YWRkIHBtX3J1bnRpbWUgaW50ZXJmYWNlIGZvciBpdC4NCg0Kd2Ugc2hvdWxkIGVuYWJsZSBpdHMg
cG93ZXIgYmVmb3JlIE00VSBodyBpbml0aWFsLiBhbmQgZGlzYWJsZSBpdCBhZnRlciBIVw0KaW5p
dGlhbGl6ZS4NCg0KV2hlbiB0aGUgZW5naW5lIHdvcmssIHRoZSBlbmdpbmUgYWx3YXlzIGVuYWJs
ZSB0aGUgcG93ZXIgYW5kIGNsb2NrcyBmb3INCnNtaS1sYXJiL3NtaS1jb21tb24sIHRoZW4gdGhl
IE00VSdzIHBvd2VyIHdpbGwgYWx3YXlzIGJlIHBvd2VyZWQgb24NCmF1dG9tYXRpY2FsbHkgdmlh
IHRoZSBkZXZpY2UgbGluayB3aXRoIHNtaS1jb21tb24uDQoNCk5vdGU6IHdlIGRvbid0IGVuYWJs
ZSB0aGUgTTRVIHBvd2VyIGluIGlvbW11X21hcC91bm1hcCBmb3IgdGxiIGZsdXNoLg0KSWYgaXRz
IHBvd2VyIGFscmVhZHkgaXMgb24sIG9mIGNvdXJzZSBpdCBpcyBvay4gaWYgdGhlIHBvd2VyIGlz
IG9mZiwNCnRoZSBtYWluIHRsYiB3aWxsIGJlIHJlc2V0IHdoaWxlIE00VSBwb3dlciBvbiwgdGh1
cyB0aGUgdGxiIGZsdXNoIHdoaWxlDQptNHUgcG93ZXIgb2ZmIGlzIHVubmVjZXNzYXJ5LCBqdXN0
IHNraXAgaXQuDQoNClNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29t
Pg0KLS0tDQogZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyB8IDU0ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0NyBpbnNlcnRpb25zKCsp
LCA3IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUu
YyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCmluZGV4IDkzMWZkZDE5YzhmMy4uMDNhNmQ2
NmY0YmVmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KKysrIGIvZHJp
dmVycy9pb21tdS9tdGtfaW9tbXUuYw0KQEAgLTIwLDYgKzIwLDcgQEANCiAjaW5jbHVkZSA8bGlu
dXgvb2ZfaXJxLmg+DQogI2luY2x1ZGUgPGxpbnV4L29mX3BsYXRmb3JtLmg+DQogI2luY2x1ZGUg
PGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KKyNpbmNsdWRlIDxsaW51eC9wbV9ydW50aW1lLmg+
DQogI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCiAjaW5jbHVkZSA8bGludXgvc3BpbmxvY2suaD4N
CiAjaW5jbHVkZSA8YXNtL2JhcnJpZXIuaD4NCkBAIC0xNzIsNiArMTczLDE5IEBAIHN0YXRpYyBz
dHJ1Y3QgbXRrX2lvbW11X2RvbWFpbiAqdG9fbXRrX2RvbWFpbihzdHJ1Y3QgaW9tbXVfZG9tYWlu
ICpkb20pDQogCXJldHVybiBjb250YWluZXJfb2YoZG9tLCBzdHJ1Y3QgbXRrX2lvbW11X2RvbWFp
biwgZG9tYWluKTsNCiB9DQogDQorc3RhdGljIGludCBtdGtfaW9tbXVfcnBtX2dldChzdHJ1Y3Qg
ZGV2aWNlICpkZXYpDQorew0KKwlpZiAocG1fcnVudGltZV9lbmFibGVkKGRldikpDQorCQlyZXR1
cm4gcG1fcnVudGltZV9nZXRfc3luYyhkZXYpOw0KKwlyZXR1cm4gMDsNCit9DQorDQorc3RhdGlj
IHZvaWQgbXRrX2lvbW11X3JwbV9wdXQoc3RydWN0IGRldmljZSAqZGV2KQ0KK3sNCisJaWYgKHBt
X3J1bnRpbWVfZW5hYmxlZChkZXYpKQ0KKwkJcG1fcnVudGltZV9wdXRfYXV0b3N1c3BlbmQoZGV2
KTsNCit9DQorDQogc3RhdGljIHZvaWQgbXRrX2lvbW11X3RsYl9mbHVzaF9hbGwodm9pZCAqY29v
a2llKQ0KIHsNCiAJc3RydWN0IG10a19pb21tdV9kYXRhICpkYXRhID0gY29va2llOw0KQEAgLTE5
Myw2ICsyMDcsMTEgQEAgc3RhdGljIHZvaWQgbXRrX2lvbW11X3RsYl9mbHVzaF9yYW5nZV9zeW5j
KHVuc2lnbmVkIGxvbmcgaW92YSwgc2l6ZV90IHNpemUsDQogCXUzMiB0bXA7DQogDQogCWZvcl9l
YWNoX200dShkYXRhKSB7DQorCQkvKiBza2lwIHRsYiBmbHVzaCB3aGVuIHBtIGlzIG5vdCBhY3Rp
dmUgKi8NCisJCWlmIChwbV9ydW50aW1lX2VuYWJsZWQoZGF0YS0+ZGV2KSAmJg0KKwkJICAgICFw
bV9ydW50aW1lX2FjdGl2ZShkYXRhLT5kZXYpKQ0KKwkJCWNvbnRpbnVlOw0KKw0KIAkJc3Bpbl9s
b2NrX2lycXNhdmUoJmRhdGEtPnRsYl9sb2NrLCBmbGFncyk7DQogCQl3cml0ZWxfcmVsYXhlZChG
X0lOVkxEX0VOMSB8IEZfSU5WTERfRU4wLA0KIAkJCSAgICAgICBkYXRhLT5iYXNlICsgZGF0YS0+
cGxhdF9kYXRhLT5pbnZfc2VsX3JlZyk7DQpAQCAtMzc3LDE1ICszOTYsMjAgQEAgc3RhdGljIGlu
dCBtdGtfaW9tbXVfYXR0YWNoX2RldmljZShzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4sDQog
ew0KIAlzdHJ1Y3QgbXRrX2lvbW11X2RhdGEgKmRhdGEgPSBkZXZfaW9tbXVfcHJpdl9nZXQoZGV2
KTsNCiAJc3RydWN0IG10a19pb21tdV9kb21haW4gKmRvbSA9IHRvX210a19kb21haW4oZG9tYWlu
KTsNCisJaW50IHJldDsNCiANCiAJaWYgKCFkYXRhKQ0KIAkJcmV0dXJuIC1FTk9ERVY7DQogDQog
CS8qIFVwZGF0ZSB0aGUgcGd0YWJsZSBiYXNlIGFkZHJlc3MgcmVnaXN0ZXIgb2YgdGhlIE00VSBI
VyAqLw0KIAlpZiAoIWRhdGEtPm00dV9kb20pIHsNCisJCXJldCA9IG10a19pb21tdV9ycG1fZ2V0
KGRldik7DQorCQlpZiAocmV0IDwgMCkNCisJCQlyZXR1cm4gcmV0Ow0KIAkJZGF0YS0+bTR1X2Rv
bSA9IGRvbTsNCiAJCXdyaXRlbChkb20tPmNmZy5hcm1fdjdzX2NmZy50dGJyICYgTU1VX1BUX0FE
RFJfTUFTSywNCiAJCSAgICAgICBkYXRhLT5iYXNlICsgUkVHX01NVV9QVF9CQVNFX0FERFIpOw0K
KwkJbXRrX2lvbW11X3JwbV9wdXQoZGV2KTsNCiAJfQ0KIA0KIAltdGtfaW9tbXVfY29uZmlnKGRh
dGEsIGRldiwgdHJ1ZSk7DQpAQCAtNTQzLDEwICs1NjcsMTQgQEAgc3RhdGljIGludCBtdGtfaW9t
bXVfaHdfaW5pdChjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X2RhdGEgKmRhdGEpDQogCXUzMiByZWd2
YWw7DQogCWludCByZXQ7DQogDQotCXJldCA9IGNsa19wcmVwYXJlX2VuYWJsZShkYXRhLT5iY2xr
KTsNCi0JaWYgKHJldCkgew0KLQkJZGV2X2VycihkYXRhLT5kZXYsICJGYWlsZWQgdG8gZW5hYmxl
IGlvbW11IGJjbGsoJWQpXG4iLCByZXQpOw0KLQkJcmV0dXJuIHJldDsNCisJLyogYmNsayB3aWxs
IGJlIGVuYWJsZWQgaW4gcG0gY2FsbGJhY2sgaW4gcG93ZXItZG9tYWluIGNhc2UuICovDQorCWlm
ICghcG1fcnVudGltZV9lbmFibGVkKGRhdGEtPmRldikpIHsNCisJCXJldCA9IGNsa19wcmVwYXJl
X2VuYWJsZShkYXRhLT5iY2xrKTsNCisJCWlmIChyZXQpIHsNCisJCQlkZXZfZXJyKGRhdGEtPmRl
diwgIkZhaWxlZCB0byBlbmFibGUgaW9tbXUgYmNsayglZClcbiIsDQorCQkJCXJldCk7DQorCQkJ
cmV0dXJuIHJldDsNCisJCX0NCiAJfQ0KIA0KIAlpZiAoZGF0YS0+cGxhdF9kYXRhLT5tNHVfcGxh
dCA9PSBNNFVfTVQ4MTczKSB7DQpAQCAtNzI4LDcgKzc1NiwxNSBAQCBzdGF0aWMgaW50IG10a19p
b21tdV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIA0KIAlwbGF0Zm9ybV9z
ZXRfZHJ2ZGF0YShwZGV2LCBkYXRhKTsNCiANCisJaWYgKGRldi0+cG1fZG9tYWluKQ0KKwkJcG1f
cnVudGltZV9lbmFibGUoZGV2KTsNCisNCisJcmV0ID0gbXRrX2lvbW11X3JwbV9nZXQoZGV2KTsN
CisJaWYgKHJldCA8IDApDQorCQlyZXR1cm4gcmV0Ow0KKw0KIAlyZXQgPSBtdGtfaW9tbXVfaHdf
aW5pdChkYXRhKTsNCisJbXRrX2lvbW11X3JwbV9wdXQoZGV2KTsNCiAJaWYgKHJldCkNCiAJCXJl
dHVybiByZXQ7DQogDQpAQCAtODAxLDYgKzgzNywxMCBAQCBzdGF0aWMgaW50IF9fbWF5YmVfdW51
c2VkIG10a19pb21tdV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KIAkJZGV2X2VycihkYXRh
LT5kZXYsICJGYWlsZWQgdG8gZW5hYmxlIGNsayglZCkgaW4gcmVzdW1lXG4iLCByZXQpOw0KIAkJ
cmV0dXJuIHJldDsNCiAJfQ0KKw0KKwkvKiBBdm9pZCBmaXJzdCByZXN1bWUgdG8gYWZmZWN0IHRo
ZSBkZWZhdWx0IHZhbHVlIG9mIHJlZ2lzdGVycyBiZWxvdy4gKi8NCisJaWYgKCFtNHVfZG9tKQ0K
KwkJcmV0dXJuIDA7DQogCXdyaXRlbF9yZWxheGVkKHJlZy0+d3JfbGVuX2N0cmwsIGJhc2UgKyBS
RUdfTU1VX1dSX0xFTl9DVFJMKTsNCiAJd3JpdGVsX3JlbGF4ZWQocmVnLT5taXNjX2N0cmwsIGJh
c2UgKyBSRUdfTU1VX01JU0NfQ1RSTCk7DQogCXdyaXRlbF9yZWxheGVkKHJlZy0+ZGNtX2Rpcywg
YmFzZSArIFJFR19NTVVfRENNX0RJUyk7DQpAQCAtODA5LDEzICs4NDksMTMgQEAgc3RhdGljIGlu
dCBfX21heWJlX3VudXNlZCBtdGtfaW9tbXVfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCiAJ
d3JpdGVsX3JlbGF4ZWQocmVnLT5pbnRfbWFpbl9jb250cm9sLCBiYXNlICsgUkVHX01NVV9JTlRf
TUFJTl9DT05UUk9MKTsNCiAJd3JpdGVsX3JlbGF4ZWQocmVnLT5pdnJwX3BhZGRyLCBiYXNlICsg
UkVHX01NVV9JVlJQX1BBRERSKTsNCiAJd3JpdGVsX3JlbGF4ZWQocmVnLT52bGRfcGFfcm5nLCBi
YXNlICsgUkVHX01NVV9WTERfUEFfUk5HKTsNCi0JaWYgKG00dV9kb20pDQotCQl3cml0ZWwobTR1
X2RvbS0+Y2ZnLmFybV92N3NfY2ZnLnR0YnIgJiBNTVVfUFRfQUREUl9NQVNLLA0KLQkJICAgICAg
IGJhc2UgKyBSRUdfTU1VX1BUX0JBU0VfQUREUik7DQorCXdyaXRlbChtNHVfZG9tLT5jZmcuYXJt
X3Y3c19jZmcudHRiciAmIE1NVV9QVF9BRERSX01BU0ssDQorCSAgICAgICBiYXNlICsgUkVHX01N
VV9QVF9CQVNFX0FERFIpOw0KIAlyZXR1cm4gMDsNCiB9DQogDQogc3RhdGljIGNvbnN0IHN0cnVj
dCBkZXZfcG1fb3BzIG10a19pb21tdV9wbV9vcHMgPSB7DQorCVNFVF9SVU5USU1FX1BNX09QUyht
dGtfaW9tbXVfc3VzcGVuZCwgbXRrX2lvbW11X3Jlc3VtZSwgTlVMTCkNCiAJU0VUX05PSVJRX1NZ
U1RFTV9TTEVFUF9QTV9PUFMobXRrX2lvbW11X3N1c3BlbmQsIG10a19pb21tdV9yZXN1bWUpDQog
fTsNCiANCi0tIA0KMi4xOC4wDQo=

