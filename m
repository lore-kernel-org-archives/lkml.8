Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECCDC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7100B2083E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uH9RnuDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgCCK65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:58:57 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:59889 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727830AbgCCK6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:58:55 -0500
X-UUID: de6f326cf8bc4e319d70b38bb07cb12c-20200303
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=oaM/XIwHpF2f+ZEVvauAU9iZcPI0MXco1jk8DKXGPQE=;
        b=uH9RnuDljqzEZCf6EFkSMMVWDNEwOXaN7Rg+1k07A4jpS2HUdFLggbcbaqR3ukTPNQ3oBxSOGmANYV522lLrBa+wY8kXkt7/LjcStB//ixMp9JiZA2exvp0aQtt5mRiEprf+hw1yP+UBTeGLFZ45oDj8v5H4PtQJwOP/b4VwJcU=;
X-UUID: de6f326cf8bc4e319d70b38bb07cb12c-20200303
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2038546423; Tue, 03 Mar 2020 18:58:50 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 3 Mar 2020 18:57:54 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 3 Mar 2020 18:58:12 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        HS Liao <hs.liao@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v4 12/13] soc: mediatek: cmdq: add clear option in cmdq_pkt_wfe api
Date:   Tue, 3 Mar 2020 18:58:44 +0800
Message-ID: <1583233125-7827-13-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1583233125-7827-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1583233125-7827-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGNsZWFyIHBhcmFtZXRlciB0byBsZXQgY2xpZW50IGRlY2lkZSBpZg0KZXZlbnQgc2hvdWxk
IGJlIGNsZWFyIHRvIDAgYWZ0ZXIgR0NFIHJlY2VpdmUgaXQuDQoNClNpZ25lZC1vZmYtYnk6IERl
bm5pcyBZQyBIc2llaCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyAgfCAyICstDQogZHJpdmVycy9zb2Mv
bWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgICB8IDUgKysrLS0NCiBpbmNsdWRlL2xpbnV4L21h
aWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIHwgMyArLS0NCiBpbmNsdWRlL2xpbnV4L3NvYy9tZWRp
YXRlay9tdGstY21kcS5oICAgIHwgNSArKystLQ0KIDQgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRp
b25zKCspLCA3IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fY3J0Yy5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
Y3J0Yy5jDQppbmRleCA3ZGFhYWJjMjZlYjEuLjQ5MTZhN2Y3NWQyMyAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KKysrIGIvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQpAQCAtNDg4LDcgKzQ4OCw3IEBAIHN0YXRpYyB2
b2lkIG10a19kcm1fY3J0Y19od19jb25maWcoc3RydWN0IG10a19kcm1fY3J0YyAqbXRrX2NydGMp
DQogCWlmIChtdGtfY3J0Yy0+Y21kcV9jbGllbnQpIHsNCiAJCWNtZHFfaGFuZGxlID0gY21kcV9w
a3RfY3JlYXRlKG10a19jcnRjLT5jbWRxX2NsaWVudCwgUEFHRV9TSVpFKTsNCiAJCWNtZHFfcGt0
X2NsZWFyX2V2ZW50KGNtZHFfaGFuZGxlLCBtdGtfY3J0Yy0+Y21kcV9ldmVudCk7DQotCQljbWRx
X3BrdF93ZmUoY21kcV9oYW5kbGUsIG10a19jcnRjLT5jbWRxX2V2ZW50KTsNCisJCWNtZHFfcGt0
X3dmZShjbWRxX2hhbmRsZSwgbXRrX2NydGMtPmNtZHFfZXZlbnQsIHRydWUpOw0KIAkJbXRrX2Ny
dGNfZGRwX2NvbmZpZyhjcnRjLCBjbWRxX2hhbmRsZSk7DQogCQljbWRxX3BrdF9maW5hbGl6ZShj
bWRxX2hhbmRsZSk7DQogCQljbWRxX3BrdF9mbHVzaF9hc3luYyhjbWRxX2hhbmRsZSwgZGRwX2Nt
ZHFfY2IsIGNtZHFfaGFuZGxlKTsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9t
dGstY21kcS1oZWxwZXIuYyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5j
DQppbmRleCBmMjdjNjcwMzQ4ODAuLjRmNzY3MTk4ZDBmYyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
c29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQorKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRl
ay9tdGstY21kcS1oZWxwZXIuYw0KQEAgLTI5NSwxNSArMjk1LDE2IEBAIGludCBjbWRxX3BrdF93
cml0ZV9zX3ZhbHVlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgaGlnaF9hZGRyX3JlZ19pZHgs
DQogfQ0KIEVYUE9SVF9TWU1CT0woY21kcV9wa3Rfd3JpdGVfc192YWx1ZSk7DQogDQotaW50IGNt
ZHFfcGt0X3dmZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGV2ZW50KQ0KK2ludCBjbWRxX3Br
dF93ZmUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBldmVudCwgYm9vbCBjbGVhcikNCiB7DQog
CXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0KKwl1MzIgY2xlYXJfb3B0
aW9uID0gY2xlYXIgPyBDTURRX1dGRV9VUERBVEUgOiAwOw0KIA0KIAlpZiAoZXZlbnQgPj0gQ01E
UV9NQVhfRVZFTlQpDQogCQlyZXR1cm4gLUVJTlZBTDsNCiANCiAJaW5zdC5vcCA9IENNRFFfQ09E
RV9XRkU7DQotCWluc3QudmFsdWUgPSBDTURRX1dGRV9PUFRJT047DQorCWluc3QudmFsdWUgPSBD
TURRX1dGRV9PUFRJT04gfCBjbGVhcl9vcHRpb247DQogCWluc3QuZXZlbnQgPSBldmVudDsNCiAN
CiAJcmV0dXJuIGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQpkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaCBiL2luY2x1ZGUvbGlu
dXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCmluZGV4IDNmNmJjMGRmZDVkYS4uNDJkMmEz
MGU2YTcwIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxi
b3guaA0KKysrIGIvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KQEAg
LTI3LDggKzI3LDcgQEANCiAgKiBiaXQgMTYtMjc6IHVwZGF0ZSB2YWx1ZQ0KICAqIGJpdCAzMTog
MSAtIHVwZGF0ZSwgMCAtIG5vIHVwZGF0ZQ0KICAqLw0KLSNkZWZpbmUgQ01EUV9XRkVfT1BUSU9O
CQkJKENNRFFfV0ZFX1VQREFURSB8IENNRFFfV0ZFX1dBSVQgfCBcDQotCQkJCQlDTURRX1dGRV9X
QUlUX1ZBTFVFKQ0KKyNkZWZpbmUgQ01EUV9XRkVfT1BUSU9OCQkJKENNRFFfV0ZFX1dBSVQgfCBD
TURRX1dGRV9XQUlUX1ZBTFVFKQ0KIA0KIC8qKiBjbWRxIGV2ZW50IG1heGltdW0gKi8NCiAjZGVm
aW5lIENNRFFfTUFYX0VWRU5UCQkJMHgzZmYNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3Nv
Yy9tZWRpYXRlay9tdGstY21kcS5oIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNt
ZHEuaA0KaW5kZXggMWE2YzU2ZjNiZWMxLi5kNjM3NDk0NDA2OTcgMTAwNjQ0DQotLS0gYS9pbmNs
dWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQorKysgYi9pbmNsdWRlL2xpbnV4L3Nv
Yy9tZWRpYXRlay9tdGstY21kcS5oDQpAQCAtMTUyLDExICsxNTIsMTIgQEAgaW50IGNtZHFfcGt0
X3dyaXRlX3NfdmFsdWUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBoaWdoX2FkZHJfcmVnX2lk
eCwNCiAvKioNCiAgKiBjbWRxX3BrdF93ZmUoKSAtIGFwcGVuZCB3YWl0IGZvciBldmVudCBjb21t
YW5kIHRvIHRoZSBDTURRIHBhY2tldA0KICAqIEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KLSAqIEBl
dmVudDoJdGhlIGRlc2lyZWQgZXZlbnQgdHlwZSB0byAid2FpdCBhbmQgQ0xFQVIiDQorICogQGV2
ZW50Ogl0aGUgZGVzaXJlZCBldmVudCB0eXBlIHRvIHdhaXQNCisgKiBAY2xlYXI6CWNsZWFyIGV2
ZW50IG9yIG5vdCBhZnRlciBldmVudCBhcnJpdmUNCiAgKg0KICAqIFJldHVybjogMCBmb3Igc3Vj
Y2VzczsgZWxzZSB0aGUgZXJyb3IgY29kZSBpcyByZXR1cm5lZA0KICAqLw0KLWludCBjbWRxX3Br
dF93ZmUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBldmVudCk7DQoraW50IGNtZHFfcGt0X3dm
ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGV2ZW50LCBib29sIGNsZWFyKTsNCiANCiAvKioN
CiAgKiBjbWRxX3BrdF9jbGVhcl9ldmVudCgpIC0gYXBwZW5kIGNsZWFyIGV2ZW50IGNvbW1hbmQg
dG8gdGhlIENNRFEgcGFja2V0DQotLSANCjIuMTguMA0K

