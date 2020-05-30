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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DD9C433E4
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D41E42070E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BtdZTpKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgE3INt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 04:13:49 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:60607 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725813AbgE3INq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 04:13:46 -0400
X-UUID: 3bef93256757426cb9f3c4254c269d07-20200530
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Fg9f1LFKGgNxd6OgKeOn+F2FgyEZvb7dw3NartpkgXk=;
        b=BtdZTpKLhSOF3SC4pJUQ2NaDUZIV/SByHHJ7Z/LTnnDzMfn2tDb69apym6j3NiYTfdZaUAJBNFI0DZvh+UhEjc3b9m0ZkHSaqxoKul7LuLg59Eje+ATBtx8iVja9tBbGqZhPMGvEfmtHpShjI1CXXi6RgQuYG7xSj0VnumK7CbE=;
X-UUID: 3bef93256757426cb9f3c4254c269d07-20200530
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1288690659; Sat, 30 May 2020 16:13:41 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 30 May 2020 16:13:38 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 30 May 2020 16:13:38 +0800
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
        <acourbot@chromium.org>, Tiffany Lin <tiffany.lin@mediatek.com>
Subject: [PATCH v4 09/17] media: mtk-vcodec: Get rid of mtk_smi_larb_get/put
Date:   Sat, 30 May 2020 16:10:10 +0800
Message-ID: <1590826218-23653-10-git-send-email-yong.wu@mediatek.com>
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
dGhlIGNvbnN1bWVyDQphbmQgc21pLWxhcmIgZGV2aWNlLiBJZiB0aGUgdmNvZGVjIGRldmljZSBj
YWxsIHRoZSBwbV9ydW50aW1lX2dldF9zeW5jLA0KdGhlIHNtaS1sYXJiJ3MgcG1fcnVudGltZV9n
ZXRfc3luYyBhbHNvIGJlIGNhbGxlZCBhdXRvbWF0aWNhbGx5Lg0KDQpDQzogVGlmZmFueSBMaW4g
PHRpZmZhbnkubGluQG1lZGlhdGVrLmNvbT4NClNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcu
d3VAbWVkaWF0ZWsuY29tPg0KUmV2aWV3ZWQtYnk6IEV2YW4gR3JlZW4gPGV2Z3JlZW5AY2hyb21p
dW0ub3JnPg0KLS0tDQogLi4uL21lZGlhL3BsYXRmb3JtL210ay12Y29kZWMvbXRrX3Zjb2RlY19k
ZWNfcG0uYyAgfCAxOSAtLS0tLS0tLS0tLS0tLS0NCiBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL210
ay12Y29kZWMvbXRrX3Zjb2RlY19kcnYuaCB8ICAzIC0tLQ0KIGRyaXZlcnMvbWVkaWEvcGxhdGZv
cm0vbXRrLXZjb2RlYy9tdGtfdmNvZGVjX2VuYy5jIHwgIDEgLQ0KIC4uLi9tZWRpYS9wbGF0Zm9y
bS9tdGstdmNvZGVjL210a192Y29kZWNfZW5jX3BtLmMgIHwgMjcgLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KIDQgZmlsZXMgY2hhbmdlZCwgNTAgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay12Y29kZWMvbXRrX3Zjb2RlY19kZWNfcG0uYyBiL2Ry
aXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRrLXZjb2RlYy9tdGtfdmNvZGVjX2RlY19wbS5jDQppbmRl
eCAzNmRmZTNmLi4xZDdkMTRkIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9t
dGstdmNvZGVjL210a192Y29kZWNfZGVjX3BtLmMNCisrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZv
cm0vbXRrLXZjb2RlYy9tdGtfdmNvZGVjX2RlY19wbS5jDQpAQCAtOCwxNCArOCwxMiBAQA0KICNp
bmNsdWRlIDxsaW51eC9vZl9hZGRyZXNzLmg+DQogI2luY2x1ZGUgPGxpbnV4L29mX3BsYXRmb3Jt
Lmg+DQogI2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCi0jaW5jbHVkZSA8c29jL21lZGlh
dGVrL3NtaS5oPg0KIA0KICNpbmNsdWRlICJtdGtfdmNvZGVjX2RlY19wbS5oIg0KICNpbmNsdWRl
ICJtdGtfdmNvZGVjX3V0aWwuaCINCiANCiBpbnQgbXRrX3Zjb2RlY19pbml0X2RlY19wbShzdHJ1
Y3QgbXRrX3Zjb2RlY19kZXYgKm10a2RldikNCiB7DQotCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9k
ZTsNCiAJc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldjsNCiAJc3RydWN0IG10a192Y29kZWNf
cG0gKnBtOw0KIAlzdHJ1Y3QgbXRrX3Zjb2RlY19jbGsgKmRlY19jbGs7DQpAQCAtMjYsMTggKzI0
LDcgQEAgaW50IG10a192Y29kZWNfaW5pdF9kZWNfcG0oc3RydWN0IG10a192Y29kZWNfZGV2ICpt
dGtkZXYpDQogCXBtID0gJm10a2Rldi0+cG07DQogCXBtLT5tdGtkZXYgPSBtdGtkZXY7DQogCWRl
Y19jbGsgPSAmcG0tPnZkZWNfY2xrOw0KLQlub2RlID0gb2ZfcGFyc2VfcGhhbmRsZShwZGV2LT5k
ZXYub2Zfbm9kZSwgIm1lZGlhdGVrLGxhcmIiLCAwKTsNCi0JaWYgKCFub2RlKSB7DQotCQltdGtf
djRsMl9lcnIoIm9mX3BhcnNlX3BoYW5kbGUgbWVkaWF0ZWssbGFyYiBmYWlsISIpOw0KLQkJcmV0
dXJuIC0xOw0KLQl9DQogDQotCXBkZXYgPSBvZl9maW5kX2RldmljZV9ieV9ub2RlKG5vZGUpOw0K
LQlvZl9ub2RlX3B1dChub2RlKTsNCi0JaWYgKFdBUk5fT04oIXBkZXYpKSB7DQotCQlyZXR1cm4g
LTE7DQotCX0NCi0JcG0tPmxhcmJ2ZGVjID0gJnBkZXYtPmRldjsNCiAJcGRldiA9IG10a2Rldi0+
cGxhdF9kZXY7DQogCXBtLT5kZXYgPSAmcGRldi0+ZGV2Ow0KIA0KQEAgLTExMywxMSArMTAwLDYg
QEAgdm9pZCBtdGtfdmNvZGVjX2RlY19jbG9ja19vbihzdHJ1Y3QgbXRrX3Zjb2RlY19wbSAqcG0p
DQogCQl9DQogCX0NCiANCi0JcmV0ID0gbXRrX3NtaV9sYXJiX2dldChwbS0+bGFyYnZkZWMpOw0K
LQlpZiAocmV0KSB7DQotCQltdGtfdjRsMl9lcnIoIm10a19zbWlfbGFyYl9nZXQgbGFyYnZkZWMg
ZmFpbCAlZCIsIHJldCk7DQotCQlnb3RvIGVycm9yOw0KLQl9DQogCXJldHVybjsNCiANCiBlcnJv
cjoNCkBAIC0xMzAsNyArMTEyLDYgQEAgdm9pZCBtdGtfdmNvZGVjX2RlY19jbG9ja19vZmYoc3Ry
dWN0IG10a192Y29kZWNfcG0gKnBtKQ0KIAlzdHJ1Y3QgbXRrX3Zjb2RlY19jbGsgKmRlY19jbGsg
PSAmcG0tPnZkZWNfY2xrOw0KIAlpbnQgaSA9IDA7DQogDQotCW10a19zbWlfbGFyYl9wdXQocG0t
PmxhcmJ2ZGVjKTsNCiAJZm9yIChpID0gZGVjX2Nsay0+Y2xrX251bSAtIDE7IGkgPj0gMDsgaS0t
KQ0KIAkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGRlY19jbGstPmNsa19pbmZvW2ldLnZjb2RlY19j
bGspOw0KIH0NCmRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay12Y29kZWMv
bXRrX3Zjb2RlY19kcnYuaCBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRrLXZjb2RlYy9tdGtf
dmNvZGVjX2Rydi5oDQppbmRleCA1MmQxY2UxLi43ZDM5NjZhIDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9tZWRpYS9wbGF0Zm9ybS9tdGstdmNvZGVjL210a192Y29kZWNfZHJ2LmgNCisrKyBiL2RyaXZl
cnMvbWVkaWEvcGxhdGZvcm0vbXRrLXZjb2RlYy9tdGtfdmNvZGVjX2Rydi5oDQpAQCAtMTkwLDEw
ICsxOTAsNyBAQCBzdHJ1Y3QgbXRrX3Zjb2RlY19jbGsgew0KICAqLw0KIHN0cnVjdCBtdGtfdmNv
ZGVjX3BtIHsNCiAJc3RydWN0IG10a192Y29kZWNfY2xrCXZkZWNfY2xrOw0KLQlzdHJ1Y3QgZGV2
aWNlCSpsYXJidmRlYzsNCi0NCiAJc3RydWN0IG10a192Y29kZWNfY2xrCXZlbmNfY2xrOw0KLQlz
dHJ1Y3QgZGV2aWNlCSpsYXJidmVuYzsNCiAJc3RydWN0IGRldmljZQkqZGV2Ow0KIAlzdHJ1Y3Qg
bXRrX3Zjb2RlY19kZXYJKm10a2RldjsNCiB9Ow0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEv
cGxhdGZvcm0vbXRrLXZjb2RlYy9tdGtfdmNvZGVjX2VuYy5jIGIvZHJpdmVycy9tZWRpYS9wbGF0
Zm9ybS9tdGstdmNvZGVjL210a192Y29kZWNfZW5jLmMNCmluZGV4IDUzMDFkY2EuLjE4MDI1Zjcg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay12Y29kZWMvbXRrX3Zjb2Rl
Y19lbmMuYw0KKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tdGstdmNvZGVjL210a192Y29k
ZWNfZW5jLmMNCkBAIC04LDcgKzgsNiBAQA0KICNpbmNsdWRlIDxtZWRpYS92NGwyLWV2ZW50Lmg+
DQogI2luY2x1ZGUgPG1lZGlhL3Y0bDItbWVtMm1lbS5oPg0KICNpbmNsdWRlIDxtZWRpYS92aWRl
b2J1ZjItZG1hLWNvbnRpZy5oPg0KLSNpbmNsdWRlIDxzb2MvbWVkaWF0ZWsvc21pLmg+DQogI2lu
Y2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCiANCiAjaW5jbHVkZSAibXRrX3Zjb2RlY19kcnYu
aCINCmRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay12Y29kZWMvbXRrX3Zj
b2RlY19lbmNfcG0uYyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRrLXZjb2RlYy9tdGtfdmNv
ZGVjX2VuY19wbS5jDQppbmRleCAwMWM2YTU1Li4wNDc5MTllIDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9tZWRpYS9wbGF0Zm9ybS9tdGstdmNvZGVjL210a192Y29kZWNfZW5jX3BtLmMNCisrKyBiL2Ry
aXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRrLXZjb2RlYy9tdGtfdmNvZGVjX2VuY19wbS5jDQpAQCAt
OCw0NCArOCwyNSBAQA0KICNpbmNsdWRlIDxsaW51eC9vZl9hZGRyZXNzLmg+DQogI2luY2x1ZGUg
PGxpbnV4L29mX3BsYXRmb3JtLmg+DQogI2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCi0j
aW5jbHVkZSA8c29jL21lZGlhdGVrL3NtaS5oPg0KIA0KICNpbmNsdWRlICJtdGtfdmNvZGVjX2Vu
Y19wbS5oIg0KICNpbmNsdWRlICJtdGtfdmNvZGVjX3V0aWwuaCINCiANCiBpbnQgbXRrX3Zjb2Rl
Y19pbml0X2VuY19wbShzdHJ1Y3QgbXRrX3Zjb2RlY19kZXYgKm10a2RldikNCiB7DQotCXN0cnVj
dCBkZXZpY2Vfbm9kZSAqbm9kZTsNCiAJc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldjsNCiAJ
c3RydWN0IG10a192Y29kZWNfcG0gKnBtOw0KIAlzdHJ1Y3QgbXRrX3Zjb2RlY19jbGsgKmVuY19j
bGs7DQogCXN0cnVjdCBtdGtfdmNvZGVjX2Nsa19pbmZvICpjbGtfaW5mbzsNCiAJaW50IHJldCA9
IDAsIGkgPSAwOw0KLQlzdHJ1Y3QgZGV2aWNlICpkZXY7DQogDQogCXBkZXYgPSBtdGtkZXYtPnBs
YXRfZGV2Ow0KIAlwbSA9ICZtdGtkZXYtPnBtOw0KIAltZW1zZXQocG0sIDAsIHNpemVvZihzdHJ1
Y3QgbXRrX3Zjb2RlY19wbSkpOw0KIAlwbS0+bXRrZGV2ID0gbXRrZGV2Ow0KIAlwbS0+ZGV2ID0g
JnBkZXYtPmRldjsNCi0JZGV2ID0gJnBkZXYtPmRldjsNCiAJZW5jX2NsayA9ICZwbS0+dmVuY19j
bGs7DQogDQotCW5vZGUgPSBvZl9wYXJzZV9waGFuZGxlKGRldi0+b2Zfbm9kZSwgIm1lZGlhdGVr
LGxhcmIiLCAwKTsNCi0JaWYgKCFub2RlKSB7DQotCQltdGtfdjRsMl9lcnIoIm5vIG1lZGlhdGVr
LGxhcmIgZm91bmQiKTsNCi0JCXJldHVybiAtRU5PREVWOw0KLQl9DQotCXBkZXYgPSBvZl9maW5k
X2RldmljZV9ieV9ub2RlKG5vZGUpOw0KLQlvZl9ub2RlX3B1dChub2RlKTsNCi0JaWYgKCFwZGV2
KSB7DQotCQltdGtfdjRsMl9lcnIoIm5vIG1lZGlhdGVrLGxhcmIgZGV2aWNlIGZvdW5kIik7DQot
CQlyZXR1cm4gLUVOT0RFVjsNCi0JfQ0KLQlwbS0+bGFyYnZlbmMgPSAmcGRldi0+ZGV2Ow0KLQlw
ZGV2ID0gbXRrZGV2LT5wbGF0X2RldjsNCi0JcG0tPmRldiA9ICZwZGV2LT5kZXY7DQotDQogCWVu
Y19jbGstPmNsa19udW0gPSBvZl9wcm9wZXJ0eV9jb3VudF9zdHJpbmdzKHBkZXYtPmRldi5vZl9u
b2RlLA0KIAkJImNsb2NrLW5hbWVzIik7DQogCWlmIChlbmNfY2xrLT5jbGtfbnVtID4gMCkgew0K
QEAgLTkzLDEzICs3NCw2IEBAIHZvaWQgbXRrX3Zjb2RlY19lbmNfY2xvY2tfb24oc3RydWN0IG10
a192Y29kZWNfcG0gKnBtKQ0KIAkJfQ0KIAl9DQogDQotCXJldCA9IG10a19zbWlfbGFyYl9nZXQo
cG0tPmxhcmJ2ZW5jKTsNCi0JaWYgKHJldCkgew0KLQkJbXRrX3Y0bDJfZXJyKCJtdGtfc21pX2xh
cmJfZ2V0IGxhcmIzIGZhaWwgJWQiLCByZXQpOw0KLQkJZ290byBjbGtlcnI7DQotCX0NCi0JcmV0
dXJuOw0KLQ0KIGNsa2VycjoNCiAJZm9yIChpIC09IDE7IGkgPj0gMDsgaS0tKQ0KIAkJY2xrX2Rp
c2FibGVfdW5wcmVwYXJlKGVuY19jbGstPmNsa19pbmZvW2ldLnZjb2RlY19jbGspOw0KQEAgLTEx
MCw3ICs4NCw2IEBAIHZvaWQgbXRrX3Zjb2RlY19lbmNfY2xvY2tfb2ZmKHN0cnVjdCBtdGtfdmNv
ZGVjX3BtICpwbSkNCiAJc3RydWN0IG10a192Y29kZWNfY2xrICplbmNfY2xrID0gJnBtLT52ZW5j
X2NsazsNCiAJaW50IGkgPSAwOw0KIA0KLQltdGtfc21pX2xhcmJfcHV0KHBtLT5sYXJidmVuYyk7
DQogCWZvciAoaSA9IGVuY19jbGstPmNsa19udW0gLSAxOyBpID49IDA7IGktLSkNCiAJCWNsa19k
aXNhYmxlX3VucHJlcGFyZShlbmNfY2xrLT5jbGtfaW5mb1tpXS52Y29kZWNfY2xrKTsNCiB9DQot
LSANCjEuOS4xDQo=

