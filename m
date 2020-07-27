Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8885BC433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6486520792
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tIlI/pf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgG0HQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 03:16:44 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:32585 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726116AbgG0HQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 03:16:40 -0400
X-UUID: ee99e063e2be45469da3ed9e3f4c6bf6-20200727
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=vGu82nHZ1eK7p8zu/EU5mQ5CChjnL1RrS2qg9jkymsM=;
        b=tIlI/pf1oi7pNPi2jOT0FQSnltxH8uVxAQ9QjtA43gxlLFjAajCju7+ynQYmQbjuseVeS6cefCdgOp5p3HeOyUHHtHt3ge56BKcFsg+DznYdgzrJfsMoUsrNZPxMud2SwaCOWED8gzhkaCSgjt7OcRLSHFIIUcpfmR5tECUldvs=;
X-UUID: ee99e063e2be45469da3ed9e3f4c6bf6-20200727
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1924386713; Mon, 27 Jul 2020 15:16:36 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 27 Jul 2020 15:16:33 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 27 Jul 2020 15:16:33 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH 03/11] usb: mtu3: reinitialize CSR registers
Date:   Mon, 27 Jul 2020 15:14:52 +0800
Message-ID: <1595834101-13094-3-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1595834101-13094-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1595834101-13094-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIENTUiByZWdpc3RlcnMgd2lsbCBiZSByZXNldCBhcyBkZWZhdWx0IHZhbHVlIGlmIHRoZQ0K
cG9ydHMgYXJlIGRpc2FibGVkLCBzbyByZWluaXRpYWxpemUgdGhlbSB3aGVuIHRoZSBwb3J0cw0K
YXJlIGVuYWJsZWQgYWdhaW4uDQoNClNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZl
bmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvdXNiL210dTMvbXR1M19jb3JlLmMg
fCA2MSArKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIDEgZmls
ZSBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspLCAyOSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdXNiL210dTMvbXR1M19jb3JlLmMgYi9kcml2ZXJzL3VzYi9tdHUzL210dTNf
Y29yZS5jDQppbmRleCA5ZGQwMjE2Li5mM2FkMWNjIDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2Iv
bXR1My9tdHUzX2NvcmUuYw0KKysrIGIvZHJpdmVycy91c2IvbXR1My9tdHUzX2NvcmUuYw0KQEAg
LTIwMiw2ICsyMDIsMzYgQEAgc3RhdGljIHZvaWQgbXR1M19pbnRyX2VuYWJsZShzdHJ1Y3QgbXR1
MyAqbXR1KQ0KIAltdHUzX3dyaXRlbChtYmFzZSwgVTNEX0RFVl9MSU5LX0lOVFJfRU5BQkxFLCBT
U1VTQl9ERVZfU1BFRURfQ0hHX0lOVFIpOw0KIH0NCiANCitzdGF0aWMgdm9pZCBtdHUzX3NldF9z
cGVlZChzdHJ1Y3QgbXR1MyAqbXR1KTsNCisNCisvKiBDU1IgcmVnaXN0ZXJzIHdpbGwgYmUgcmVz
ZXQgdG8gZGVmYXVsdCB2YWx1ZSBpZiBwb3J0IGlzIGRpc2FibGVkICovDQorc3RhdGljIHZvaWQg
bXR1M19jc3JfaW5pdChzdHJ1Y3QgbXR1MyAqbXR1KQ0KK3sNCisJdm9pZCBfX2lvbWVtICptYmFz
ZSA9IG10dS0+bWFjX2Jhc2U7DQorDQorCWlmIChtdHUtPmlzX3UzX2lwKSB7DQorCQkvKiBkaXNh
YmxlIExHT19VMS9VMiBieSBkZWZhdWx0ICovDQorCQltdHUzX2NscmJpdHMobWJhc2UsIFUzRF9M
SU5LX1BPV0VSX0NPTlRST0wsDQorCQkJCVNXX1UxX1JFUVVFU1RfRU5BQkxFIHwgU1dfVTJfUkVR
VUVTVF9FTkFCTEUpOw0KKwkJLyogZW5hYmxlIGFjY2VwdCBMR09fVTEvVTIgbGluayBjb21tYW5k
IGZyb20gaG9zdCAqLw0KKwkJbXR1M19zZXRiaXRzKG1iYXNlLCBVM0RfTElOS19QT1dFUl9DT05U
Uk9MLA0KKwkJCQlTV19VMV9BQ0NFUFRfRU5BQkxFIHwgU1dfVTJfQUNDRVBUX0VOQUJMRSk7DQor
CQkvKiBkZXZpY2UgcmVzcG9uc2VzIHRvIHUzX2V4aXQgZnJvbSBob3N0IGF1dG9tYXRpY2FsbHkg
Ki8NCisJCW10dTNfY2xyYml0cyhtYmFzZSwgVTNEX0xUU1NNX0NUUkwsIFNPRlRfVTNfRVhJVF9F
Tik7DQorCQkvKiBhdXRvbWF0aWNhbGx5IGJ1aWxkIFUyIGxpbmsgd2hlbiBVMyBkZXRlY3QgZmFp
bCAqLw0KKwkJbXR1M19zZXRiaXRzKG1iYXNlLCBVM0RfVVNCMl9URVNUX01PREUsIFUyVTNfQVVU
T19TV0lUQ0gpOw0KKwkJLyogYXV0byBjbGVhciBTT0ZUX0NPTk4gd2hlbiBjbGVhciBVU0IzX0VO
IGlmIHdvcmsgYXMgSFMgKi8NCisJCW10dTNfc2V0Yml0cyhtYmFzZSwgVTNEX1UzVTJfU1dJVENI
X0NUUkwsIFNPRlRDT05fQ0xSX0FVVE9fRU4pOw0KKwl9DQorDQorCW10dTNfc2V0X3NwZWVkKG10
dSk7DQorDQorCS8qIGRlbGF5IGFib3V0IDAuMXVzIGZyb20gZGV0ZWN0aW5nIHJlc2V0IHRvIHNl
bmQgY2hpcnAtSyAqLw0KKwltdHUzX2NscmJpdHMobWJhc2UsIFUzRF9MSU5LX1JFU0VUX0lORk8s
IFdUQ0hSUF9NU0spOw0KKwkvKiBlbmFibGUgYXV0b21hdGljYWwgSFdSVyBmcm9tIEwxICovDQor
CW10dTNfc2V0Yml0cyhtYmFzZSwgVTNEX1BPV0VSX01BTkFHRU1FTlQsIExQTV9IUldFKTsNCit9
DQorDQogLyogcmVzZXQ6IHUyIC0gZGF0YSB0b2dnbGUsIHUzIC0gU2VxTiwgZmxvdyBjb250cm9s
IHN0YXR1cyBldGMgKi8NCiBzdGF0aWMgdm9pZCBtdHUzX2VwX3Jlc2V0KHN0cnVjdCBtdHUzX2Vw
ICptZXApDQogew0KQEAgLTI2NywxMyArMjk3LDcgQEAgdm9pZCBtdHUzX3N0YXJ0KHN0cnVjdCBt
dHUzICptdHUpDQogDQogCW10dTNfY2xyYml0cyhtdHUtPmlwcGNfYmFzZSwgVTNEX1NTVVNCX0lQ
X1BXX0NUUkwyLCBTU1VTQl9JUF9ERVZfUEROKTsNCiANCi0JLyoNCi0JICogV2hlbiBkaXNhYmxl
IFUyIHBvcnQsIFVTQjJfQ1NSJ3MgcmVnaXN0ZXIgd2lsbCBiZSByZXNldCB0bw0KLQkgKiBkZWZh
dWx0IHZhbHVlIGFmdGVyIHJlLWVuYWJsZSBpdCBhZ2FpbihIUyBpcyBlbmFibGVkIGJ5IGRlZmF1
bHQpLg0KLQkgKiBTbyBpZiBmb3JjZSBtYWMgdG8gd29yayBhcyBGUywgZGlzYWJsZSBIUyBmdW5j
dGlvbi4NCi0JICovDQotCWlmIChtdHUtPm1heF9zcGVlZCA9PSBVU0JfU1BFRURfRlVMTCkNCi0J
CW10dTNfY2xyYml0cyhtYmFzZSwgVTNEX1BPV0VSX01BTkFHRU1FTlQsIEhTX0VOQUJMRSk7DQor
CW10dTNfY3NyX2luaXQobXR1KTsNCiANCiAJLyogSW5pdGlhbGl6ZSB0aGUgZGVmYXVsdCBpbnRl
cnJ1cHRzICovDQogCW10dTNfaW50cl9lbmFibGUobXR1KTsNCkBAIC01NzIsMzkgKzU5NiwxOCBA
QCBzdGF0aWMgdm9pZCBtdHUzX3NldF9zcGVlZChzdHJ1Y3QgbXR1MyAqbXR1KQ0KIA0KIHN0YXRp
YyB2b2lkIG10dTNfcmVnc19pbml0KHN0cnVjdCBtdHUzICptdHUpDQogew0KLQ0KIAl2b2lkIF9f
aW9tZW0gKm1iYXNlID0gbXR1LT5tYWNfYmFzZTsNCiANCiAJLyogYmUgc3VyZSBpbnRlcnJ1cHRz
IGFyZSBkaXNhYmxlZCBiZWZvcmUgcmVnaXN0cmF0aW9uIG9mIElTUiAqLw0KIAltdHUzX2ludHJf
ZGlzYWJsZShtdHUpOw0KIAltdHUzX2ludHJfc3RhdHVzX2NsZWFyKG10dSk7DQogDQotCWlmICht
dHUtPmlzX3UzX2lwKSB7DQotCQkvKiBkaXNhYmxlIExHT19VMS9VMiBieSBkZWZhdWx0ICovDQot
CQltdHUzX2NscmJpdHMobWJhc2UsIFUzRF9MSU5LX1BPV0VSX0NPTlRST0wsDQotCQkJCVNXX1Ux
X1JFUVVFU1RfRU5BQkxFIHwgU1dfVTJfUkVRVUVTVF9FTkFCTEUpOw0KLQkJLyogZW5hYmxlIGFj
Y2VwdCBMR09fVTEvVTIgbGluayBjb21tYW5kIGZyb20gaG9zdCAqLw0KLQkJbXR1M19zZXRiaXRz
KG1iYXNlLCBVM0RfTElOS19QT1dFUl9DT05UUk9MLA0KLQkJCQlTV19VMV9BQ0NFUFRfRU5BQkxF
IHwgU1dfVTJfQUNDRVBUX0VOQUJMRSk7DQotCQkvKiBkZXZpY2UgcmVzcG9uc2VzIHRvIHUzX2V4
aXQgZnJvbSBob3N0IGF1dG9tYXRpY2FsbHkgKi8NCi0JCW10dTNfY2xyYml0cyhtYmFzZSwgVTNE
X0xUU1NNX0NUUkwsIFNPRlRfVTNfRVhJVF9FTik7DQotCQkvKiBhdXRvbWF0aWNhbGx5IGJ1aWxk
IFUyIGxpbmsgd2hlbiBVMyBkZXRlY3QgZmFpbCAqLw0KLQkJbXR1M19zZXRiaXRzKG1iYXNlLCBV
M0RfVVNCMl9URVNUX01PREUsIFUyVTNfQVVUT19TV0lUQ0gpOw0KLQkJLyogYXV0byBjbGVhciBT
T0ZUX0NPTk4gd2hlbiBjbGVhciBVU0IzX0VOIGlmIHdvcmsgYXMgSFMgKi8NCi0JCW10dTNfc2V0
Yml0cyhtYmFzZSwgVTNEX1UzVTJfU1dJVENIX0NUUkwsIFNPRlRDT05fQ0xSX0FVVE9fRU4pOw0K
LQl9DQotDQotCW10dTNfc2V0X3NwZWVkKG10dSk7DQorCW10dTNfY3NyX2luaXQobXR1KTsNCiAN
Ci0JLyogZGVsYXkgYWJvdXQgMC4xdXMgZnJvbSBkZXRlY3RpbmcgcmVzZXQgdG8gc2VuZCBjaGly
cC1LICovDQotCW10dTNfY2xyYml0cyhtYmFzZSwgVTNEX0xJTktfUkVTRVRfSU5GTywgV1RDSFJQ
X01TSyk7DQogCS8qIFUyL1UzIGRldGVjdGVkIGJ5IEhXICovDQogCW10dTNfd3JpdGVsKG1iYXNl
LCBVM0RfREVWSUNFX0NPTkYsIDApOw0KIAkvKiB2YnVzIGRldGVjdGVkIGJ5IEhXICovDQogCW10
dTNfY2xyYml0cyhtYmFzZSwgVTNEX01JU0NfQ1RSTCwgVkJVU19GUkNfRU4gfCBWQlVTX09OKTsN
Ci0JLyogZW5hYmxlIGF1dG9tYXRpY2FsIEhXUlcgZnJvbSBMMSAqLw0KLQltdHUzX3NldGJpdHMo
bWJhc2UsIFUzRF9QT1dFUl9NQU5BR0VNRU5ULCBMUE1fSFJXRSk7DQotDQogCS8qIHVzZSBuZXcg
UU1VIGZvcm1hdCB3aGVuIEhXIHZlcnNpb24gPj0gMHgxMDAzICovDQogCWlmIChtdHUtPmdlbjJj
cCkNCiAJCW10dTNfd3JpdGVsKG1iYXNlLCBVM0RfUUZDUiwgfjB4MCk7DQotLSANCjEuOS4xDQo=

