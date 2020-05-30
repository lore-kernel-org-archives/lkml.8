Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8DCC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35D0920774
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="W2vucEDQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgE3IOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 04:14:08 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50614 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725813AbgE3IOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 04:14:07 -0400
X-UUID: ab71ab33588e4d61868039095faf01dc-20200530
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=qxSwZMn2syeUd7Ci/gpOqpuv4Qbe+9JTNy596S3gEt0=;
        b=W2vucEDQpjRnIPAjPiZbBtjb6Xlmt9VoZ8dCZ+V0w2A+3/YU25idHJ9CxgBlx3gkoURsHFCazOgGo0o7EEwOfSjD5iEux7Yrersxq4p/b1yftDkknyyZXNQKzy1HF2Tgl1lO1PdEm7/7guIZVUTqcynDCk2W/NP8VhZZ6y+v5BU=;
X-UUID: ab71ab33588e4d61868039095faf01dc-20200530
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 131641489; Sat, 30 May 2020 16:14:04 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 30 May 2020 16:14:00 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 30 May 2020 16:14:00 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, <anan.sun@mediatek.com>,
        <cui.zhang@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>, <eizan@chromium.org>,
        <acourbot@chromium.org>, CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v4 11/17] drm/mediatek: Get rid of mtk_smi_larb_get/put
Date:   Sat, 30 May 2020 16:10:12 +0800
Message-ID: <1590826218-23653-12-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
References: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWVkaWFUZWsgSU9NTVUgaGFzIGFscmVhZHkgYWRkZWQgdGhlIGRldmljZV9saW5rIGJldHdlZW4g
dGhlIGNvbnN1bWVyDQphbmQgc21pLWxhcmIgZGV2aWNlLiBJZiB0aGUgZHJtIGRldmljZSBjYWxs
IHRoZSBwbV9ydW50aW1lX2dldF9zeW5jLA0KdGhlIHNtaS1sYXJiJ3MgcG1fcnVudGltZV9nZXRf
c3luYyBhbHNvIGJlIGNhbGxlZCBhdXRvbWF0aWNhbGx5Lg0KDQpDQzogQ0sgSHUgPGNrLmh1QG1l
ZGlhdGVrLmNvbT4NCkNDOiBQaGlsaXBwIFphYmVsIDxwLnphYmVsQHBlbmd1dHJvbml4LmRlPg0K
U2lnbmVkLW9mZi1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQpSZXZpZXdlZC1i
eTogRXZhbiBHcmVlbiA8ZXZncmVlbkBjaHJvbWl1bS5vcmc+DQotLS0NCiBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMgICAgIHwgIDkgLS0tLS0tLS0tDQogZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYyB8IDIxIC0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmggfCAgMSAt
DQogMyBmaWxlcyBjaGFuZ2VkLCAzMSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHJtX2NydGMuYw0KaW5kZXggYzliYzg0NC4uZDRjNDA3OCAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KKysrIGIvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQpAQCAtOCw3ICs4LDYgQEANCiAjaW5jbHVk
ZSA8bGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmg+DQogDQogI2luY2x1ZGUgPGFzbS9iYXJy
aWVyLmg+DQotI2luY2x1ZGUgPHNvYy9tZWRpYXRlay9zbWkuaD4NCiANCiAjaW5jbHVkZSA8ZHJt
L2RybV9hdG9taWNfaGVscGVyLmg+DQogI2luY2x1ZGUgPGRybS9kcm1fcGxhbmVfaGVscGVyLmg+
DQpAQCAtNTMyLDEyICs1MzEsNiBAQCBzdGF0aWMgdm9pZCBtdGtfZHJtX2NydGNfYXRvbWljX2Vu
YWJsZShzdHJ1Y3QgZHJtX2NydGMgKmNydGMsDQogDQogCURSTV9ERUJVR19EUklWRVIoIiVzICVk
XG4iLCBfX2Z1bmNfXywgY3J0Yy0+YmFzZS5pZCk7DQogDQotCXJldCA9IG10a19zbWlfbGFyYl9n
ZXQoY29tcC0+bGFyYl9kZXYpOw0KLQlpZiAocmV0KSB7DQotCQlEUk1fRVJST1IoIkZhaWxlZCB0
byBnZXQgbGFyYjogJWRcbiIsIHJldCk7DQotCQlyZXR1cm47DQotCX0NCi0NCiAJcmV0ID0gcG1f
cnVudGltZV9nZXRfc3luYyhjb21wLT5kZXYpOw0KIAlpZiAocmV0IDwgMCkNCiAJCURSTV9ERVZf
RVJST1IoY29tcC0+ZGV2LCAiRmFpbGVkIHRvIGVuYWJsZSBwb3dlciBkb21haW46ICVkXG4iLA0K
QEAgLTU0NSw3ICs1MzgsNiBAQCBzdGF0aWMgdm9pZCBtdGtfZHJtX2NydGNfYXRvbWljX2VuYWJs
ZShzdHJ1Y3QgZHJtX2NydGMgKmNydGMsDQogDQogCXJldCA9IG10a19jcnRjX2RkcF9od19pbml0
KG10a19jcnRjKTsNCiAJaWYgKHJldCkgew0KLQkJbXRrX3NtaV9sYXJiX3B1dChjb21wLT5sYXJi
X2Rldik7DQogCQlwbV9ydW50aW1lX3B1dChjb21wLT5kZXYpOw0KIAkJcmV0dXJuOw0KIAl9DQpA
QCAtNTgyLDcgKzU3NCw2IEBAIHN0YXRpYyB2b2lkIG10a19kcm1fY3J0Y19hdG9taWNfZGlzYWJs
ZShzdHJ1Y3QgZHJtX2NydGMgKmNydGMsDQogDQogCWRybV9jcnRjX3ZibGFua19vZmYoY3J0Yyk7
DQogCW10a19jcnRjX2RkcF9od19maW5pKG10a19jcnRjKTsNCi0JbXRrX3NtaV9sYXJiX3B1dChj
b21wLT5sYXJiX2Rldik7DQogCXJldCA9IHBtX3J1bnRpbWVfcHV0KGNvbXAtPmRldik7DQogCWlm
IChyZXQgPCAwKQ0KIAkJRFJNX0RFVl9FUlJPUihjb21wLT5kZXYsICJGYWlsZWQgdG8gZGlzYWJs
ZSBwb3dlciBkb21haW46ICVkXG4iLA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHJtX2RkcF9jb21wLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Ry
bV9kZHBfY29tcC5jDQppbmRleCA1OTMwMjdhLi5hNmU3ZjNhIDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KKysrIGIvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KQEAgLTQzMiw4ICs0MzIsNiBAQCBpbnQg
bXRrX2RkcF9jb21wX2luaXQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX25vZGUg
Km5vZGUsDQogCQkgICAgICBjb25zdCBzdHJ1Y3QgbXRrX2RkcF9jb21wX2Z1bmNzICpmdW5jcykN
CiB7DQogCWVudW0gbXRrX2RkcF9jb21wX3R5cGUgdHlwZTsNCi0Jc3RydWN0IGRldmljZV9ub2Rl
ICpsYXJiX25vZGU7DQotCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmxhcmJfcGRldjsNCiAjaWYg
SVNfUkVBQ0hBQkxFKENPTkZJR19NVEtfQ01EUSkNCiAJc3RydWN0IHJlc291cmNlIHJlczsNCiAJ
c3RydWN0IGNtZHFfY2xpZW50X3JlZyBjbWRxX3JlZzsNCkBAIC00NjgsMzEgKzQ2NiwxMiBAQCBp
bnQgbXRrX2RkcF9jb21wX2luaXQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX25v
ZGUgKm5vZGUsDQogCWlmIChJU19FUlIoY29tcC0+Y2xrKSkNCiAJCXJldHVybiBQVFJfRVJSKGNv
bXAtPmNsayk7DQogDQotCS8qIE9ubHkgRE1BIGNhcGFibGUgY29tcG9uZW50cyBuZWVkIHRoZSBM
QVJCIHByb3BlcnR5ICovDQotCWNvbXAtPmxhcmJfZGV2ID0gTlVMTDsNCiAJaWYgKHR5cGUgIT0g
TVRLX0RJU1BfT1ZMICYmDQogCSAgICB0eXBlICE9IE1US19ESVNQX09WTF8yTCAmJg0KIAkgICAg
dHlwZSAhPSBNVEtfRElTUF9SRE1BICYmDQogCSAgICB0eXBlICE9IE1US19ESVNQX1dETUEpDQog
CQlyZXR1cm4gMDsNCiANCi0JbGFyYl9ub2RlID0gb2ZfcGFyc2VfcGhhbmRsZShub2RlLCAibWVk
aWF0ZWssbGFyYiIsIDApOw0KLQlpZiAoIWxhcmJfbm9kZSkgew0KLQkJZGV2X2VycihkZXYsDQot
CQkJIk1pc3NpbmcgbWVkaWFkZWssbGFyYiBwaGFuZGxlIGluICVwT0Ygbm9kZVxuIiwgbm9kZSk7
DQotCQlyZXR1cm4gLUVJTlZBTDsNCi0JfQ0KLQ0KLQlsYXJiX3BkZXYgPSBvZl9maW5kX2Rldmlj
ZV9ieV9ub2RlKGxhcmJfbm9kZSk7DQotCWlmICghbGFyYl9wZGV2KSB7DQotCQlkZXZfd2Fybihk
ZXYsICJXYWl0aW5nIGZvciBsYXJiIGRldmljZSAlcE9GXG4iLCBsYXJiX25vZGUpOw0KLQkJb2Zf
bm9kZV9wdXQobGFyYl9ub2RlKTsNCi0JCXJldHVybiAtRVBST0JFX0RFRkVSOw0KLQl9DQotCW9m
X25vZGVfcHV0KGxhcmJfbm9kZSk7DQotDQotCWNvbXAtPmxhcmJfZGV2ID0gJmxhcmJfcGRldi0+
ZGV2Ow0KLQ0KIAljb21wLT5kZXYgPSBkZXY7DQogDQogI2lmIElTX1JFQUNIQUJMRShDT05GSUdf
TVRLX0NNRFEpDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
ZGRwX2NvbXAuaCBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmgN
CmluZGV4IDRjMDYzZTAuLjExYzcxMjAgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RybV9kZHBfY29tcC5oDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RybV9kZHBfY29tcC5oDQpAQCAtOTgsNyArOTgsNiBAQCBzdHJ1Y3QgbXRrX2RkcF9jb21w
IHsNCiAJc3RydWN0IGNsayAqY2xrOw0KIAl2b2lkIF9faW9tZW0gKnJlZ3M7DQogCWludCBpcnE7
DQotCXN0cnVjdCBkZXZpY2UgKmxhcmJfZGV2Ow0KIAlzdHJ1Y3QgZGV2aWNlICpkZXY7DQogCWVu
dW0gbXRrX2RkcF9jb21wX2lkIGlkOw0KIAljb25zdCBzdHJ1Y3QgbXRrX2RkcF9jb21wX2Z1bmNz
ICpmdW5jczsNCi0tIA0KMS45LjENCg==

