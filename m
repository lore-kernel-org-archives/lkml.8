Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48923C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22CC0208A9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="n16wVzQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgHTGHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 02:07:08 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:8823 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726741AbgHTGFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 02:05:43 -0400
X-UUID: 538db9ae8369492ba90a149167f7d305-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=IcBVGjhMM93U59Zg6sn4+HR2/5ZarY0qGfZCNPtkXU4=;
        b=n16wVzQvIZ8xr/9/I/L1Of79g5XbgyiER0Ae05+2idOHX+Vq19z30JE3ObKC2J4dgZOk1qNsKqXnFqZcTOO+FQ/LPcp1LEGxfxFQfshX+ITyetXEpLQ9QVbwgShEZ6LTEO2fp5d5QUz3YuDVvGJEFtigYB6qCWXdMC8BwX/AUdw=;
X-UUID: 538db9ae8369492ba90a149167f7d305-20200820
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1468991654; Thu, 20 Aug 2020 14:05:39 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 14:05:37 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 14:05:36 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v1 06/21] drm/mediatek: add disp config and mm 26mhz clock into mutex device
Date:   Thu, 20 Aug 2020 14:04:03 +0800
Message-ID: <1597903458-8055-7-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597903458-8055-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1597903458-8055-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dGhlcmUgYXJlIDIgbW9yZSBjbG9jayBuZWVkIGVuYWJsZSBmb3IgZGlzcGxheS4NCnBhcnNlciB0
aGVzZSBjbG9jayB3aGVuIG11dGV4IGRldmljZSBwcm9iZSwNCmVuYWJsZSBhbmQgZGlzYWJsZSB3
aGVuIG11dGV4IG9uL29mZg0KDQpTaWduZWQtb2ZmLWJ5OiBZb25ncWlhbmcgTml1IDx5b25ncWlh
bmcubml1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2RkcC5jIHwgNDkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KIDEgZmls
ZSBjaGFuZ2VkLCA0MSBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwLmMgYi9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAuYw0KaW5kZXggNjA3ODhjMS4uZGU2MThhMSAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcC5jDQorKysgYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAuYw0KQEAgLTExOCw3ICsxMTgsNyBAQCBz
dHJ1Y3QgbXRrX2RkcF9kYXRhIHsNCiANCiBzdHJ1Y3QgbXRrX2RkcCB7DQogCXN0cnVjdCBkZXZp
Y2UJCQkqZGV2Ow0KLQlzdHJ1Y3QgY2xrCQkJKmNsazsNCisJc3RydWN0IGNsawkJCSpjbGtbM107
DQogCXZvaWQgX19pb21lbQkJCSpyZWdzOw0KIAlzdHJ1Y3QgbXRrX2Rpc3BfbXV0ZXgJCW11dGV4
WzEwXTsNCiAJY29uc3Qgc3RydWN0IG10a19kZHBfZGF0YQkqZGF0YTsNCkBAIC0yNTcsMTQgKzI1
NywzOSBAQCBpbnQgbXRrX2Rpc3BfbXV0ZXhfcHJlcGFyZShzdHJ1Y3QgbXRrX2Rpc3BfbXV0ZXgg
Km11dGV4KQ0KIHsNCiAJc3RydWN0IG10a19kZHAgKmRkcCA9IGNvbnRhaW5lcl9vZihtdXRleCwg
c3RydWN0IG10a19kZHAsDQogCQkJCQkgICBtdXRleFttdXRleC0+aWRdKTsNCi0JcmV0dXJuIGNs
a19wcmVwYXJlX2VuYWJsZShkZHAtPmNsayk7DQorCWludCByZXQ7DQorCWludCBpOw0KKw0KKwlm
b3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShkZHAtPmNsayk7IGkrKykgew0KKwkJaWYgKElTX0VS
UihkZHAtPmNsa1tpXSkpDQorCQkJY29udGludWU7DQorCQlyZXQgPSBjbGtfcHJlcGFyZV9lbmFi
bGUoZGRwLT5jbGtbaV0pOw0KKwkJaWYgKHJldCkgew0KKwkJCXByX2VycigiZmFpbGVkIHRvIGVu
YWJsZSBjbG9jaywgZXJyICVkLiBpOiVkXG4iLA0KKwkJCQlyZXQsIGkpOw0KKwkJCWdvdG8gZXJy
Ow0KKwkJfQ0KKwl9DQorDQorCXJldHVybiAwOw0KKw0KK2VycjoNCisJd2hpbGUgKC0taSA+PSAw
KQ0KKwkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGRkcC0+Y2xrW2ldKTsNCisJcmV0dXJuIHJldDsN
CiB9DQogDQogdm9pZCBtdGtfZGlzcF9tdXRleF91bnByZXBhcmUoc3RydWN0IG10a19kaXNwX211
dGV4ICptdXRleCkNCiB7DQogCXN0cnVjdCBtdGtfZGRwICpkZHAgPSBjb250YWluZXJfb2YobXV0
ZXgsIHN0cnVjdCBtdGtfZGRwLA0KIAkJCQkJICAgbXV0ZXhbbXV0ZXgtPmlkXSk7DQotCWNsa19k
aXNhYmxlX3VucHJlcGFyZShkZHAtPmNsayk7DQorCWludCBpOw0KKw0KKwkgZm9yIChpID0gMDsg
aSA8IEFSUkFZX1NJWkUoZGRwLT5jbGspOyBpKyspIHsNCisJCWlmIChJU19FUlIoZGRwLT5jbGtb
aV0pKQ0KKwkJCWNvbnRpbnVlOw0KKwkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGRkcC0+Y2xrW2ld
KTsNCisJfQ0KIH0NCiANCiB2b2lkIG10a19kaXNwX211dGV4X2FkZF9jb21wKHN0cnVjdCBtdGtf
ZGlzcF9tdXRleCAqbXV0ZXgsDQpAQCAtNDE1LDExICs0NDAsMTkgQEAgc3RhdGljIGludCBtdGtf
ZGRwX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCWRkcC0+ZGF0YSA9IG9m
X2RldmljZV9nZXRfbWF0Y2hfZGF0YShkZXYpOw0KIA0KIAlpZiAoIWRkcC0+ZGF0YS0+bm9fY2xr
KSB7DQotCQlkZHAtPmNsayA9IGRldm1fY2xrX2dldChkZXYsIE5VTEwpOw0KLQkJaWYgKElTX0VS
UihkZHAtPmNsaykpIHsNCi0JCQlpZiAoUFRSX0VSUihkZHAtPmNsaykgIT0gLUVQUk9CRV9ERUZF
UikNCi0JCQkJZGV2X2VycihkZXYsICJGYWlsZWQgdG8gZ2V0IGNsb2NrXG4iKTsNCi0JCQlyZXR1
cm4gUFRSX0VSUihkZHAtPmNsayk7DQorCQlpbnQgcmV0Ow0KKw0KKwkJZm9yIChpID0gMDsgaSA8
IEFSUkFZX1NJWkUoZGRwLT5jbGspOyBpKyspIHsNCisJCQlkZHAtPmNsa1tpXSA9IG9mX2Nsa19n
ZXQoZGV2LT5vZl9ub2RlLCBpKTsNCisNCisJCQlpZiAoSVNfRVJSKGRkcC0+Y2xrW2ldKSkgew0K
KwkJCQlyZXQgPSBQVFJfRVJSKGRkcC0+Y2xrW2ldKTsNCisJCQkJaWYgKHJldCAhPSBFUFJPQkVf
REVGRVIpDQorCQkJCQlkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBnZXQgY2xvY2sgJWRcbiIsDQor
CQkJCQkJcmV0KTsNCisNCisJCQkJcmV0dXJuIHJldDsNCisJCQl9DQogCQl9DQogCX0NCiANCi0t
IA0KMS44LjEuMS5kaXJ0eQ0K

