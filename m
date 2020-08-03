Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A159FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7491A206D4
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 14:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fFYFvccD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgHCO1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 10:27:01 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:22471 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726358AbgHCO05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 10:26:57 -0400
X-UUID: 7193e7c75086493c8a7fb88a8c40c227-20200803
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=nsGyLTdk49+hu3aL4BVtR/HEa0bcGywBTHa+PUZ1YqE=;
        b=fFYFvccDWrq7Lije/hVzXNWnFd6YGcDWHPY0/P2f8vXN3JtHTBA5DRvH6VxVpr6/m7sKXczUtWUb+oJfZS9g0PFeL0hh4YmGDgWCtf3Hj3nEHWOwcVh1aaAWCjI3SlnE7JLd3QICaB+qjrFap0+uN+xXQfQaB6HvG8Hjan36fJ8=;
X-UUID: 7193e7c75086493c8a7fb88a8c40c227-20200803
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <phil.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 208211624; Mon, 03 Aug 2020 22:26:52 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 3 Aug 2020 22:26:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 3 Aug 2020 22:26:49 +0800
From:   Phil Chang <phil.chang@mediatek.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Chang <phil.chang@mediatek.com>,
        Alix Wu <alix.wu@mediatek.com>,
        YJ Chiang <yj.chiang@mediatek.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] ARM64: Setup DMA32 zone size by bootargs
Date:   Mon, 3 Aug 2020 22:26:47 +0800
Message-ID: <20200803142647.16737-1-phil.chang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 62935B82062BCF856BA87E395D17F26700271321499917426F984D3EA0F62E462000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dGhpcyBwYXRjaCBhbGxvd2luZyB0aGUgYXJtNjQgRE1BIHpvbmUgYmUgY29uZmlndXJhYmxlLg0K
DQpTaWduZWQtb2ZmLWJ5OiBBbGl4IFd1IDxhbGl4Lnd1QG1lZGlhdGVrLmNvbT4NClNpZ25lZC1v
ZmYtYnk6IFlKIENoaWFuZyA8eWouY2hpYW5nQG1lZGlhdGVrLmNvbT4NClNpZ25lZC1vZmYtYnk6
IFBoaWwgQ2hhbmcgPHBoaWwuY2hhbmdAbWVkaWF0ZWsuY29tPg0KLS0tDQpIaQ0KDQpGb3Igc29t
ZSBkZXZpY2VzLCB0aGUgbWFpbiBtZW1vcnkgc3BsaXQgaW50byAyIHBhcnQgZHVlIHRvIHRoZSBt
ZW1vcnkgYXJjaGl0ZWN0dXJlLA0KdGhlIGVmZmljaWVudCBhbmQgbGVzcyBpbmVmZmljaWVudCBw
YXJ0Lg0KT25lIG9mIHRoZSB1c2UgY2FzZSBpcyBmaW5lLXR1bmUgdGhlIGRtYTMyIHNpemUgdG8g
Y29udGFpbiBhbGwgdGhlDQplZmZpY2llbnQgcGFydCBvZiBtZW1vcnkgYmxvY2sgb24gdGhpcyBr
aW5kIG9mIGFyY2hpdGVjdHVyZSwNCmJ1dCBpbiBnZW5lcmFsLCB0aGUgRE1BMzIgem9uZSBzaXpl
IGlzIGhhcmRjb2RlIHRvIDRHLg0KDQogLi4uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJz
LnR4dCAgICAgICAgIHwgIDMgKysNCiBhcmNoL2FybTY0L2luY2x1ZGUvYXNtL21lbW9yeS5oICAg
ICAgICAgICAgICAgfCAgMiArKw0KIGFyY2gvYXJtNjQvbW0vaW5pdC5jICAgICAgICAgICAgICAg
ICAgICAgICAgICB8IDMzICsrKysrKysrKysrKysrKysrLS0NCiAzIGZpbGVzIGNoYW5nZWQsIDM1
IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dCBiL0RvY3VtZW50YXRpb24vYWRt
aW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0DQppbmRleCBmYjk1ZmFkODFjNzkuLjQ0MWFk
M2NiOGVlOCAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2VybmVsLXBh
cmFtZXRlcnMudHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJh
bWV0ZXJzLnR4dA0KQEAgLTk1Niw2ICs5NTYsOSBAQA0KIAkJCVRoZSBmaWx0ZXIgY2FuIGJlIGRp
c2FibGVkIG9yIGNoYW5nZWQgdG8gYW5vdGhlcg0KIAkJCWRyaXZlciBsYXRlciB1c2luZyBzeXNm
cy4NCiANCisJZG1hMzJfem9uZT1ubglbS01HXSBbS05MLEJPT1RdDQorCQkJRm9yY2VzIHRoZSBE
TUEzMiB6b25lIHNpemUgb2YgPG5uPiBpbiBtYiwgYXJtNjQgb25seS4NCisNCiAJZHJpdmVyX2Fz
eW5jX3Byb2JlPSAgW0tOTF0NCiAJCQlMaXN0IG9mIGRyaXZlciBuYW1lcyB0byBiZSBwcm9iZWQg
YXN5bmNocm9ub3VzbHkuDQogCQkJRm9ybWF0OiA8ZHJpdmVyX25hbWUxPiw8ZHJpdmVyX25hbWUy
Pi4uLg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vbWVtb3J5LmggYi9hcmNo
L2FybTY0L2luY2x1ZGUvYXNtL21lbW9yeS5oDQppbmRleCBhMTg3MWJiMzJiYjEuLjM3N2YyMjUy
NjE4YSAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vbWVtb3J5LmgNCisrKyBi
L2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vbWVtb3J5LmgNCkBAIC0xNzQsNiArMTc0LDggQEAgZXh0
ZXJuIHU2NAkJCWtpbWFnZV92YWRkcjsNCiAvKiB0aGUgb2Zmc2V0IGJldHdlZW4gdGhlIGtlcm5l
bCB2aXJ0dWFsIGFuZCBwaHlzaWNhbCBtYXBwaW5ncyAqLw0KIGV4dGVybiB1NjQJCQlraW1hZ2Vf
dm9mZnNldDsNCiANCitleHRlcm4gcGh5c19hZGRyX3QJCWFybV9kbWFfem9uZV9zaXplOw0KKw0K
IHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZyBrYXNscl9vZmZzZXQodm9pZCkNCiB7DQogCXJl
dHVybiBraW1hZ2VfdmFkZHIgLSBLSU1BR0VfVkFERFI7DQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02
NC9tbS9pbml0LmMgYi9hcmNoL2FybTY0L21tL2luaXQuYw0KaW5kZXggMWU5M2NmYzdjNDdhLi42
NDJhYjMyMzM5MmMgMTAwNjQ0DQotLS0gYS9hcmNoL2FybTY0L21tL2luaXQuYw0KKysrIGIvYXJj
aC9hcm02NC9tbS9pbml0LmMNCkBAIC02MCw2ICs2MCw5IEBAIEVYUE9SVF9TWU1CT0wocGh5c3Zp
cnRfb2Zmc2V0KTsNCiBzdHJ1Y3QgcGFnZSAqdm1lbW1hcCBfX3JvX2FmdGVyX2luaXQ7DQogRVhQ
T1JUX1NZTUJPTCh2bWVtbWFwKTsNCiANCitwaHlzX2FkZHJfdCBhcm1fZG1hX3pvbmVfc2l6ZSBf
X3JvX2FmdGVyX2luaXQ7DQorRVhQT1JUX1NZTUJPTChhcm1fZG1hX3pvbmVfc2l6ZSk7DQorDQog
LyoNCiAgKiBXZSBjcmVhdGUgYm90aCBaT05FX0RNQSBhbmQgWk9ORV9ETUEzMi4gWk9ORV9ETUEg
Y292ZXJzIHRoZSBmaXJzdCAxRyBvZg0KICAqIG1lbW9yeSBhcyBzb21lIGRldmljZXMsIG5hbWVs
eSB0aGUgUmFzcGJlcnJ5IFBpIDQsIGhhdmUgcGVyaXBoZXJhbHMgd2l0aA0KQEAgLTI0Miw2ICsy
NDUsMjUgQEAgc3RhdGljIGludCBfX2luaXQgZWFybHlfbWVtKGNoYXIgKnApDQogfQ0KIGVhcmx5
X3BhcmFtKCJtZW0iLCBlYXJseV9tZW0pOw0KIA0KKy8qDQorICogU2V0dXAgdGhlIGRtYTMyIHpv
bmUgc2l6ZQ0KKyAqLw0KK3N0YXRpYyBpbnQgX19pbml0IHNldHVwX2RtYTMyX3pvbmUoY2hhciAq
cCkNCit7DQorCWlmICghcCkNCisJCXJldHVybiAtRUlOVkFMOw0KKw0KKwlpZiAoa3N0cnRvdWxs
KHAsIDAsICZhcm1fZG1hX3pvbmVfc2l6ZSkpDQorCQlyZXR1cm4gLUVJTlZBTDsNCisNCisJYXJt
X2RtYV96b25lX3NpemUgKj0gU1pfMU07DQorCXByX25vdGljZSgiU2V0dXAgZG1hMzIgem9uZSBz
aXplIHRvICVsbHUgTWJcbiIsIGFybV9kbWFfem9uZV9zaXplKTsNCisNCisJcmV0dXJuIDA7DQor
fQ0KKw0KK2Vhcmx5X3BhcmFtKCJkbWEzMl96b25lIiwgc2V0dXBfZG1hMzJfem9uZSk7DQorDQog
c3RhdGljIGludCBfX2luaXQgZWFybHlfaW5pdF9kdF9zY2FuX3VzYWJsZW1lbSh1bnNpZ25lZCBs
b25nIG5vZGUsDQogCQljb25zdCBjaGFyICp1bmFtZSwgaW50IGRlcHRoLCB2b2lkICpkYXRhKQ0K
IHsNCkBAIC0zOTIsMTAgKzQxNCwxNSBAQCB2b2lkIF9faW5pdCBhcm02NF9tZW1ibG9ja19pbml0
KHZvaWQpDQogCQlhcm02NF9kbWFfcGh5c19saW1pdCA9IG1heF96b25lX3BoeXMoQVJNNjRfWk9O
RV9ETUFfQklUUyk7DQogCX0NCiANCi0JaWYgKElTX0VOQUJMRUQoQ09ORklHX1pPTkVfRE1BMzIp
KQ0KLQkJYXJtNjRfZG1hMzJfcGh5c19saW1pdCA9IG1heF96b25lX3BoeXMoMzIpOw0KLQllbHNl
DQorCWlmIChJU19FTkFCTEVEKENPTkZJR19aT05FX0RNQTMyKSkgew0KKwkJaWYgKGFybV9kbWFf
em9uZV9zaXplKQ0KKwkJCWFybTY0X2RtYTMyX3BoeXNfbGltaXQgPSBhcm1fZG1hX3pvbmVfc2l6
ZSArDQorCQkJCQkJbWVtYmxvY2tfc3RhcnRfb2ZfRFJBTSgpOw0KKwkJZWxzZQ0KKwkJCWFybTY0
X2RtYTMyX3BoeXNfbGltaXQgPSBtYXhfem9uZV9waHlzKDMyKTsNCisJfSBlbHNlIHsNCiAJCWFy
bTY0X2RtYTMyX3BoeXNfbGltaXQgPSBQSFlTX01BU0sgKyAxOw0KKwl9DQogDQogCXJlc2VydmVf
Y3Jhc2hrZXJuZWwoKTsNCiANCi0tIA0KMi4xOC4wDQo=

