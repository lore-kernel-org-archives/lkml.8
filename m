Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A47C433E1
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 06:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C181B20870
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 06:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="AaaUjdaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgGEGst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 02:48:49 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:23427 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725979AbgGEGsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 02:48:43 -0400
X-UUID: b1bf24e76e8d4c85afe932a46ed5b401-20200705
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=yje6qdwddpG06glHUYCMWx17eIl4zAuuOfG8FykA1os=;
        b=AaaUjdaJOMeOEyt+GmbzBu9gAlT4I0kc6/u8PHA9CKSb62ctjIrYLDqaETvYOoqGrP3dsSIDFEhGzOgZrXZtJrT0ov5E1vCs7BAdfQTPK17hkEs0CjH5MK2tQiIsGKlq7x+oSqNTZ2EkwtLO7Dazw0Jz/4fA/MSSsCYgbNAr74I=;
X-UUID: b1bf24e76e8d4c85afe932a46ed5b401-20200705
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 267403064; Sun, 05 Jul 2020 14:48:39 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 5 Jul 2020 14:48:36 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 5 Jul 2020 14:48:37 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v2 8/8] soc: mediatek: cmdq: add clear option in cmdq_pkt_wfe api
Date:   Sun, 5 Jul 2020 14:48:35 +0800
Message-ID: <1593931715-32761-9-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1593931715-32761-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1593931715-32761-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGNsZWFyIHBhcmFtZXRlciB0byBsZXQgY2xpZW50IGRlY2lkZSBpZg0KZXZlbnQgc2hvdWxk
IGJlIGNsZWFyIHRvIDAgYWZ0ZXIgR0NFIHJlY2VpdmUgaXQuDQoNCkZpeGVzOiAyZjk2NWJlN2Y5
MDA4ICgiZHJtL21lZGlhdGVrOiBhcHBseSBDTURRIGNvbnRyb2wgZmxvdyIpDQpTaWduZWQtb2Zm
LWJ5OiBEZW5uaXMgWUMgSHNpZWggPGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+DQpSZXZp
ZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyAgfCAgICAyICstDQogZHJpdmVycy9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEtaGVscGVyLmMgICB8ICAgIDUgKysrLS0NCiBpbmNsdWRlL2xpbnV4L21haWxi
b3gvbXRrLWNtZHEtbWFpbGJveC5oIHwgICAgMyArLS0NCiBpbmNsdWRlL2xpbnV4L3NvYy9tZWRp
YXRlay9tdGstY21kcS5oICAgIHwgICAgNSArKystLQ0KIDQgZmlsZXMgY2hhbmdlZCwgOCBpbnNl
cnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcm1fY3J0Yy5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fY3J0Yy5jDQppbmRleCBlYzZjOWZmYmYzNWUuLmJhNmNmOTU2YjIzOSAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KKysrIGIvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQpAQCAtNDkwLDcgKzQ5MCw3IEBAIHN0YXRp
YyB2b2lkIG10a19kcm1fY3J0Y19od19jb25maWcoc3RydWN0IG10a19kcm1fY3J0YyAqbXRrX2Ny
dGMpDQogCQltYm94X2ZsdXNoKG10a19jcnRjLT5jbWRxX2NsaWVudC0+Y2hhbiwgMjAwMCk7DQog
CQljbWRxX2hhbmRsZSA9IGNtZHFfcGt0X2NyZWF0ZShtdGtfY3J0Yy0+Y21kcV9jbGllbnQsIFBB
R0VfU0laRSk7DQogCQljbWRxX3BrdF9jbGVhcl9ldmVudChjbWRxX2hhbmRsZSwgbXRrX2NydGMt
PmNtZHFfZXZlbnQpOw0KLQkJY21kcV9wa3Rfd2ZlKGNtZHFfaGFuZGxlLCBtdGtfY3J0Yy0+Y21k
cV9ldmVudCk7DQorCQljbWRxX3BrdF93ZmUoY21kcV9oYW5kbGUsIG10a19jcnRjLT5jbWRxX2V2
ZW50LCBmYWxzZSk7DQogCQltdGtfY3J0Y19kZHBfY29uZmlnKGNydGMsIGNtZHFfaGFuZGxlKTsN
CiAJCWNtZHFfcGt0X2ZpbmFsaXplKGNtZHFfaGFuZGxlKTsNCiAJCWNtZHFfcGt0X2ZsdXNoX2Fz
eW5jKGNtZHFfaGFuZGxlLCBkZHBfY21kcV9jYiwgY21kcV9oYW5kbGUpOw0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIGIvZHJpdmVycy9zb2MvbWVk
aWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCmluZGV4IGQ1NWRjMzI5NjEwNS4uNTA1NjUxYjBkNzE1
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCisr
KyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQpAQCAtMzE2LDE1ICsz
MTYsMTYgQEAgaW50IGNtZHFfcGt0X3dyaXRlX3NfbWFza192YWx1ZShzdHJ1Y3QgY21kcV9wa3Qg
KnBrdCwgdTggaGlnaF9hZGRyX3JlZ19pZHgsDQogfQ0KIEVYUE9SVF9TWU1CT0woY21kcV9wa3Rf
d3JpdGVfc19tYXNrX3ZhbHVlKTsNCiANCi1pbnQgY21kcV9wa3Rfd2ZlKHN0cnVjdCBjbWRxX3Br
dCAqcGt0LCB1MTYgZXZlbnQpDQoraW50IGNtZHFfcGt0X3dmZShzdHJ1Y3QgY21kcV9wa3QgKnBr
dCwgdTE2IGV2ZW50LCBib29sIGNsZWFyKQ0KIHsNCiAJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24g
aW5zdCA9IHsgezB9IH07DQorCXUzMiBjbGVhcl9vcHRpb24gPSBjbGVhciA/IENNRFFfV0ZFX1VQ
REFURSA6IDA7DQogDQogCWlmIChldmVudCA+PSBDTURRX01BWF9FVkVOVCkNCiAJCXJldHVybiAt
RUlOVkFMOw0KIA0KIAlpbnN0Lm9wID0gQ01EUV9DT0RFX1dGRTsNCi0JaW5zdC52YWx1ZSA9IENN
RFFfV0ZFX09QVElPTjsNCisJaW5zdC52YWx1ZSA9IENNRFFfV0ZFX09QVElPTiB8IGNsZWFyX29w
dGlvbjsNCiAJaW5zdC5ldmVudCA9IGV2ZW50Ow0KIA0KIAlyZXR1cm4gY21kcV9wa3RfYXBwZW5k
X2NvbW1hbmQocGt0LCBpbnN0KTsNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21haWxib3gv
bXRrLWNtZHEtbWFpbGJveC5oIGIvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxi
b3guaA0KaW5kZXggZWZiZDhhOWViMmQxLi5kNWE5ODNkNjVmMDUgMTAwNjQ0DQotLS0gYS9pbmNs
dWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oDQorKysgYi9pbmNsdWRlL2xpbnV4
L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oDQpAQCAtMjgsOCArMjgsNyBAQA0KICAqIGJpdCAx
Ni0yNzogdXBkYXRlIHZhbHVlDQogICogYml0IDMxOiAxIC0gdXBkYXRlLCAwIC0gbm8gdXBkYXRl
DQogICovDQotI2RlZmluZSBDTURRX1dGRV9PUFRJT04JCQkoQ01EUV9XRkVfVVBEQVRFIHwgQ01E
UV9XRkVfV0FJVCB8IFwNCi0JCQkJCUNNRFFfV0ZFX1dBSVRfVkFMVUUpDQorI2RlZmluZSBDTURR
X1dGRV9PUFRJT04JCQkoQ01EUV9XRkVfV0FJVCB8IENNRFFfV0ZFX1dBSVRfVkFMVUUpDQogDQog
LyoqIGNtZHEgZXZlbnQgbWF4aW11bSAqLw0KICNkZWZpbmUgQ01EUV9NQVhfRVZFTlQJCQkweDNm
Zg0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggYi9p
bmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQppbmRleCAzNDM1NGU5NTJmNjAu
Ljk2MDcwNGQ3NTk5NCAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210
ay1jbWRxLmgNCisrKyBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCkBA
IC0xODIsMTEgKzE4MiwxMiBAQCBpbnQgY21kcV9wa3Rfd3JpdGVfc19tYXNrX3ZhbHVlKHN0cnVj
dCBjbWRxX3BrdCAqcGt0LCB1OCBoaWdoX2FkZHJfcmVnX2lkeCwNCiAvKioNCiAgKiBjbWRxX3Br
dF93ZmUoKSAtIGFwcGVuZCB3YWl0IGZvciBldmVudCBjb21tYW5kIHRvIHRoZSBDTURRIHBhY2tl
dA0KICAqIEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KLSAqIEBldmVudDoJdGhlIGRlc2lyZWQgZXZl
bnQgdHlwZSB0byAid2FpdCBhbmQgQ0xFQVIiDQorICogQGV2ZW50Ogl0aGUgZGVzaXJlZCBldmVu
dCB0eXBlIHRvIHdhaXQNCisgKiBAY2xlYXI6CWNsZWFyIGV2ZW50IG9yIG5vdCBhZnRlciBldmVu
dCBhcnJpdmUNCiAgKg0KICAqIFJldHVybjogMCBmb3Igc3VjY2VzczsgZWxzZSB0aGUgZXJyb3Ig
Y29kZSBpcyByZXR1cm5lZA0KICAqLw0KLWludCBjbWRxX3BrdF93ZmUoc3RydWN0IGNtZHFfcGt0
ICpwa3QsIHUxNiBldmVudCk7DQoraW50IGNtZHFfcGt0X3dmZShzdHJ1Y3QgY21kcV9wa3QgKnBr
dCwgdTE2IGV2ZW50LCBib29sIGNsZWFyKTsNCiANCiAvKioNCiAgKiBjbWRxX3BrdF9jbGVhcl9l
dmVudCgpIC0gYXBwZW5kIGNsZWFyIGV2ZW50IGNvbW1hbmQgdG8gdGhlIENNRFEgcGFja2V0DQot
LSANCjEuNy45LjUNCg==

