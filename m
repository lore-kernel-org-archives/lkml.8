Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDC2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 05:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36CEE207F7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 05:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kNYQIaTx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgFLFdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 01:33:00 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:60208 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725763AbgFLFc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 01:32:59 -0400
X-UUID: 239d2498b3b74fe9acfc7227611e421b-20200612
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=bDIpgkDQG7YLT+F0rsdng9S3ADGmLirI0hK3z/BZOuY=;
        b=kNYQIaTxVSeR2OoLWSPVuYo5ny3mIuwEwPFcqRNW1L6Cme2nqtm44PF8niJRfA/vZJsHqos5PzR8Bde6+6hjDU1rMQFJj784KxD92LC2v7llcZQMTw4jhQvxxkbmVwp+ilox0FbKzAfNrTr3DEyRAevgvYytmAykm7XDnnJdUPQ=;
X-UUID: 239d2498b3b74fe9acfc7227611e421b-20200612
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1990203046; Fri, 12 Jun 2020 13:32:54 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 12 Jun 2020 13:32:51 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 12 Jun 2020 13:32:46 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, Jim Lin <jilin@nvidia.com>,
        Siqi Lin <siqilin@google.com>
CC:     Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>
Subject: [PATCH] usb: replace hardcoded maximum usb string length by definition
Date:   Fri, 12 Jun 2020 13:32:47 +0800
Message-ID: <1591939967-29943-1-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <y>
References: <y>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmVwbGFjZSBoYXJkY29kZWQgbWF4aW11bSB1c2Igc3RyaW5nIGxlbmd0aCAoMTI2IGJ5dGVzKSBi
eSBkZWZpbml0aW9uDQoiTUFYX1VTQl9TVFJJTkdfTEVOIi4NCg0KU2lnbmVkLW9mZi1ieTogTWFj
cGF1bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvdXNiL2dh
ZGdldC9jb21wb3NpdGUuYyB8ICAgIDQgKystLQ0KIGRyaXZlcnMvdXNiL2dhZGdldC9jb25maWdm
cy5jICB8ICAgIDMgKystDQogZHJpdmVycy91c2IvZ2FkZ2V0L3VzYnN0cmluZy5jIHwgICAgNSAr
KystLQ0KIGluY2x1ZGUvbGludXgvdXNiLmggICAgICAgICAgICB8ICAgIDIgKysNCiA0IGZpbGVz
IGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdXNiL2dhZGdldC9jb21wb3NpdGUuYyBiL2RyaXZlcnMvdXNiL2dhZGdldC9jb21w
b3NpdGUuYw0KaW5kZXggY2I0OTUwYy4uZDBkZTAxNiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNi
L2dhZGdldC9jb21wb3NpdGUuYw0KKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2NvbXBvc2l0ZS5j
DQpAQCAtMTA0MSw3ICsxMDQxLDcgQEAgc3RhdGljIHZvaWQgY29sbGVjdF9sYW5ncyhzdHJ1Y3Qg
dXNiX2dhZGdldF9zdHJpbmdzICoqc3AsIF9fbGUxNiAqYnVmKQ0KIAl3aGlsZSAoKnNwKSB7DQog
CQlzID0gKnNwOw0KIAkJbGFuZ3VhZ2UgPSBjcHVfdG9fbGUxNihzLT5sYW5ndWFnZSk7DQotCQlm
b3IgKHRtcCA9IGJ1ZjsgKnRtcCAmJiB0bXAgPCAmYnVmWzEyNl07IHRtcCsrKSB7DQorCQlmb3Ig
KHRtcCA9IGJ1ZjsgKnRtcCAmJiB0bXAgPCAmYnVmW01BWF9VU0JfU1RSSU5HX0xFTl07IHRtcCsr
KSB7DQogCQkJaWYgKCp0bXAgPT0gbGFuZ3VhZ2UpDQogCQkJCWdvdG8gcmVwZWF0Ow0KIAkJfQ0K
QEAgLTExMTYsNyArMTExNiw3IEBAIHN0YXRpYyBpbnQgZ2V0X3N0cmluZyhzdHJ1Y3QgdXNiX2Nv
bXBvc2l0ZV9kZXYgKmNkZXYsDQogCQkJY29sbGVjdF9sYW5ncyhzcCwgcy0+d0RhdGEpOw0KIAkJ
fQ0KIA0KLQkJZm9yIChsZW4gPSAwOyBsZW4gPD0gMTI2ICYmIHMtPndEYXRhW2xlbl07IGxlbisr
KQ0KKwkJZm9yIChsZW4gPSAwOyBsZW4gPD0gTUFYX1VTQl9TVFJJTkdfTEVOICYmIHMtPndEYXRh
W2xlbl07IGxlbisrKQ0KIAkJCWNvbnRpbnVlOw0KIAkJaWYgKCFsZW4pDQogCQkJcmV0dXJuIC1F
SU5WQUw7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L2NvbmZpZ2ZzLmMgYi9kcml2
ZXJzL3VzYi9nYWRnZXQvY29uZmlnZnMuYw0KaW5kZXggMzJiNjM3ZS4uYzlkNjFhYyAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC9jb25maWdmcy5jDQorKysgYi9kcml2ZXJzL3VzYi9n
YWRnZXQvY29uZmlnZnMuYw0KQEAgLTQsNiArNCw3IEBADQogI2luY2x1ZGUgPGxpbnV4L3NsYWIu
aD4NCiAjaW5jbHVkZSA8bGludXgvZGV2aWNlLmg+DQogI2luY2x1ZGUgPGxpbnV4L25scy5oPg0K
KyNpbmNsdWRlIDxsaW51eC91c2IuaD4NCiAjaW5jbHVkZSA8bGludXgvdXNiL2NvbXBvc2l0ZS5o
Pg0KICNpbmNsdWRlIDxsaW51eC91c2IvZ2FkZ2V0X2NvbmZpZ2ZzLmg+DQogI2luY2x1ZGUgImNv
bmZpZ2ZzLmgiDQpAQCAtMTE1LDcgKzExNiw3IEBAIHN0YXRpYyBpbnQgdXNiX3N0cmluZ19jb3B5
KGNvbnN0IGNoYXIgKnMsIGNoYXIgKipzX2NvcHkpDQogCWNoYXIgKnN0cjsNCiAJY2hhciAqY29w
eSA9ICpzX2NvcHk7DQogCXJldCA9IHN0cmxlbihzKTsNCi0JaWYgKHJldCA+IDEyNikNCisJaWYg
KHJldCA+IE1BWF9VU0JfU1RSSU5HX0xFTikNCiAJCXJldHVybiAtRU9WRVJGTE9XOw0KIA0KIAlz
dHIgPSBrc3RyZHVwKHMsIEdGUF9LRVJORUwpOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dh
ZGdldC91c2JzdHJpbmcuYyBiL2RyaXZlcnMvdXNiL2dhZGdldC91c2JzdHJpbmcuYw0KaW5kZXgg
N2MyNGQxYy4uYzEyNWQ1OSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC91c2JzdHJp
bmcuYw0KKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VzYnN0cmluZy5jDQpAQCAtMTEsNiArMTEs
NyBAQA0KICNpbmNsdWRlIDxsaW51eC9kZXZpY2UuaD4NCiAjaW5jbHVkZSA8bGludXgvbmxzLmg+
DQogDQorI2luY2x1ZGUgPGxpbnV4L3VzYi5oPg0KICNpbmNsdWRlIDxsaW51eC91c2IvY2g5Lmg+
DQogI2luY2x1ZGUgPGxpbnV4L3VzYi9nYWRnZXQuaD4NCiANCkBAIC01NSw5ICs1Niw5IEBADQog
CQlyZXR1cm4gLUVJTlZBTDsNCiANCiAJLyogc3RyaW5nIGRlc2NyaXB0b3JzIGhhdmUgbGVuZ3Ro
LCB0YWcsIHRoZW4gVVRGMTYtTEUgdGV4dCAqLw0KLQlsZW4gPSBtaW4gKChzaXplX3QpIDEyNiwg
c3RybGVuIChzLT5zKSk7DQorCWxlbiA9IG1pbigoc2l6ZV90KU1BWF9VU0JfU1RSSU5HX0xFTiwg
c3RybGVuKHMtPnMpKTsNCiAJbGVuID0gdXRmOHNfdG9fdXRmMTZzKHMtPnMsIGxlbiwgVVRGMTZf
TElUVExFX0VORElBTiwNCi0JCQkod2NoYXJfdCAqKSAmYnVmWzJdLCAxMjYpOw0KKwkJCSh3Y2hh
cl90ICopICZidWZbMl0sIE1BWF9VU0JfU1RSSU5HX0xFTik7DQogCWlmIChsZW4gPCAwKQ0KIAkJ
cmV0dXJuIC1FSU5WQUw7DQogCWJ1ZiBbMF0gPSAobGVuICsgMSkgKiAyOw0KZGlmZiAtLWdpdCBh
L2luY2x1ZGUvbGludXgvdXNiLmggYi9pbmNsdWRlL2xpbnV4L3VzYi5oDQppbmRleCA5ZjNjNzIx
Li5kZjRhOWNiIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC91c2IuaA0KKysrIGIvaW5jbHVk
ZS9saW51eC91c2IuaA0KQEAgLTE4MTUsNiArMTgxNSw4IEBAIHN0YXRpYyBpbmxpbmUgaW50IHVz
Yl9nZXRfcHRtX3N0YXR1cyhzdHJ1Y3QgdXNiX2RldmljZSAqZGV2LCB2b2lkICpkYXRhKQ0KIAkJ
MCwgZGF0YSk7DQogfQ0KIA0KKy8qIFVTQiBTdHJpbmcgZGVzY3JpcHRvcnMgY2FuIGNvbnRhaW4g
YXQgbW9zdCAxMjYgY2hhcmFjdGVycy4gKi8NCisjZGVmaW5lIE1BWF9VU0JfU1RSSU5HX0xFTgkx
MjYNCiBleHRlcm4gaW50IHVzYl9zdHJpbmcoc3RydWN0IHVzYl9kZXZpY2UgKmRldiwgaW50IGlu
ZGV4LA0KIAljaGFyICpidWYsIHNpemVfdCBzaXplKTsNCiANCi0tIA0KMS43LjkuNQ0K

