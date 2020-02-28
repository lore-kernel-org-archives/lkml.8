Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3DCC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340512072A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bE7OuYGy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgB1NpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:45:22 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:3103 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727168AbgB1NpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:45:21 -0500
X-UUID: 307f37c30b464ff985f8b41ad03a2667-20200228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=V7rjjdGPaGIo71CRHrYBci2AlddPz1yKHLbHWKcAbso=;
        b=bE7OuYGyFnORdFNntUExbivh/VjaU5tHSNFPy7xpBx7mabRyji9Glc80MbeBuJIo/EOBeZi2oxRWieZ+24PDO1UqWjZbpq4ud1Lm+Ldvin5amq9FWTuRfNqi85KCHnJSCLIjPwkntqKPKLk46WfkUB4t4KEuC7NahVY4OZkwipw=;
X-UUID: 307f37c30b464ff985f8b41ad03a2667-20200228
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 692356981; Fri, 28 Feb 2020 21:45:07 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 28 Feb 2020 21:44:07 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Feb 2020 21:45:04 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Ming-Fan Chen <ming-fan.chen@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v3 06/13] soc: mediatek: cmdq: add assign function
Date:   Fri, 28 Feb 2020 21:44:14 +0800
Message-ID: <1582897461-15105-8-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1582897461-15105-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1582897461-15105-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGFzc2lnbiBmdW5jdGlvbiBpbiBjbWRxIGhlbHBlciB3aGljaCBhc3NpZ24gY29uc3RhbnQg
dmFsdWUgaW50bw0KaW50ZXJuYWwgcmVnaXN0ZXIgYnkgaW5kZXguDQoNClNpZ25lZC1vZmYtYnk6
IERlbm5pcyBZQyBIc2llaCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRy
aXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jICAgfCAyNCArKysrKysrKysrKysr
KysrKysrKysrKy0NCiBpbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIHwg
IDEgKw0KIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggICAgfCAxNCArKysr
KysrKysrKysrKw0KIDMgZmlsZXMgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVy
LmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KaW5kZXggMDY5ODYx
MmRlNWFkLi44MzQyYTVjOTRiYzcgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9t
dGstY21kcS1oZWxwZXIuYw0KKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVs
cGVyLmMNCkBAIC0xMiw2ICsxMiw3IEBADQogI2RlZmluZSBDTURRX1dSSVRFX0VOQUJMRV9NQVNL
CUJJVCgwKQ0KICNkZWZpbmUgQ01EUV9QT0xMX0VOQUJMRV9NQVNLCUJJVCgwKQ0KICNkZWZpbmUg
Q01EUV9FT0NfSVJRX0VOCQlCSVQoMCkNCisjZGVmaW5lIENNRFFfUkVHX1RZUEUJCTENCiANCiBz
dHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiB7DQogCXVuaW9uIHsNCkBAIC0yMSw4ICsyMiwxNyBAQCBz
dHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiB7DQogCXVuaW9uIHsNCiAJCXUxNiBvZmZzZXQ7DQogCQl1
MTYgZXZlbnQ7DQorCQl1MTYgcmVnX2RzdDsNCisJfTsNCisJdW5pb24gew0KKwkJdTggc3Vic3lz
Ow0KKwkJc3RydWN0IHsNCisJCQl1OCBzb3A6NTsNCisJCQl1OCBhcmdfY190OjE7DQorCQkJdTgg
YXJnX2JfdDoxOw0KKwkJCXU4IGRzdF90OjE7DQorCQl9Ow0KIAl9Ow0KLQl1OCBzdWJzeXM7DQog
CXU4IG9wOw0KIH07DQogDQpAQCAtMjc3LDYgKzI4NywxOCBAQCBpbnQgY21kcV9wa3RfcG9sbF9t
YXNrKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBzdWJzeXMsDQogfQ0KIEVYUE9SVF9TWU1CT0wo
Y21kcV9wa3RfcG9sbF9tYXNrKTsNCiANCitpbnQgY21kcV9wa3RfYXNzaWduKHN0cnVjdCBjbWRx
X3BrdCAqcGt0LCB1MTYgcmVnX2lkeCwgdTMyIHZhbHVlKQ0KK3sNCisJc3RydWN0IGNtZHFfaW5z
dHJ1Y3Rpb24gaW5zdCA9IHsgezB9IH07DQorDQorCWluc3Qub3AgPSBDTURRX0NPREVfTE9HSUM7
DQorCWluc3QuZHN0X3QgPSBDTURRX1JFR19UWVBFOw0KKwlpbnN0LnJlZ19kc3QgPSByZWdfaWR4
Ow0KKwlpbnN0LnZhbHVlID0gdmFsdWU7DQorCXJldHVybiBjbWRxX3BrdF9hcHBlbmRfY29tbWFu
ZChwa3QsIGluc3QpOw0KK30NCitFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X2Fzc2lnbik7DQorDQog
c3RhdGljIGludCBjbWRxX3BrdF9maW5hbGl6ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCkNCiB7DQog
CXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0KZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmggYi9pbmNsdWRlL2xpbnV4L21h
aWxib3gvbXRrLWNtZHEtbWFpbGJveC5oDQppbmRleCBkZmU1YjJlYjg1Y2MuLjEyMWMzYmI2ZDNk
ZSAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgN
CisrKyBiL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCkBAIC01OSw2
ICs1OSw3IEBAIGVudW0gY21kcV9jb2RlIHsNCiAJQ01EUV9DT0RFX0pVTVAgPSAweDEwLA0KIAlD
TURRX0NPREVfV0ZFID0gMHgyMCwNCiAJQ01EUV9DT0RFX0VPQyA9IDB4NDAsDQorCUNNRFFfQ09E
RV9MT0dJQyA9IDB4YTAsDQogfTsNCiANCiBlbnVtIGNtZHFfY2Jfc3RhdHVzIHsNCmRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oIGIvaW5jbHVkZS9saW51
eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KaW5kZXggYTc0YzFkNWFjZGYzLi44MzM0MDIxMWUx
ZDMgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQor
KysgYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQpAQCAtMTUyLDYgKzE1
MiwyMCBAQCBpbnQgY21kcV9wa3RfcG9sbChzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTggc3Vic3lz
LA0KICAqLw0KIGludCBjbWRxX3BrdF9wb2xsX21hc2soc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4
IHN1YnN5cywNCiAJCSAgICAgICB1MTYgb2Zmc2V0LCB1MzIgdmFsdWUsIHUzMiBtYXNrKTsNCisN
CisvKioNCisgKiBjbWRxX3BrdF9hc3NpZ24oKSAtIEFwcGVuZCBsb2dpYyBhc3NpZ24gY29tbWFu
ZCB0byB0aGUgQ01EUSBwYWNrZXQsIGFzayBHQ0UNCisgKgkJICAgICAgIHRvIGV4ZWN1dGUgYW4g
aW5zdHJ1Y3Rpb24gdGhhdCBzZXQgYSBjb25zdGFudCB2YWx1ZSBpbnRvDQorICoJCSAgICAgICBp
bnRlcm5hbCByZWdpc3RlciBhbmQgdXNlIGFzIHZhbHVlLCBtYXNrIG9yIGFkZHJlc3MgaW4NCisg
KgkJICAgICAgIHJlYWQvd3JpdGUgaW5zdHJ1Y3Rpb24uDQorICogQHBrdDoJdGhlIENNRFEgcGFj
a2V0DQorICogQHJlZ19pZHg6CXRoZSBDTURRIGludGVybmFsIHJlZ2lzdGVyIElEDQorICogQHZh
bHVlOgl0aGUgc3BlY2lmaWVkIHZhbHVlDQorICoNCisgKiBSZXR1cm46IDAgZm9yIHN1Y2Nlc3M7
IGVsc2UgdGhlIGVycm9yIGNvZGUgaXMgcmV0dXJuZWQNCisgKi8NCitpbnQgY21kcV9wa3RfYXNz
aWduKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgcmVnX2lkeCwgdTMyIHZhbHVlKTsNCisNCiAv
KioNCiAgKiBjbWRxX3BrdF9mbHVzaF9hc3luYygpIC0gdHJpZ2dlciBDTURRIHRvIGFzeW5jaHJv
bm91c2x5IGV4ZWN1dGUgdGhlIENNRFENCiAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgcGFj
a2V0IGFuZCBjYWxsIGJhY2sgYXQgdGhlIGVuZCBvZiBkb25lIHBhY2tldA0KLS0gDQoyLjE4LjAN
Cg==

