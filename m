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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F29EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 06:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F25720672
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 06:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="e1yeVrtc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgHCGRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 02:17:18 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:26863 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728308AbgHCGRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 02:17:16 -0400
X-UUID: 94d591465c1c47f08c5a371fb3fdfdc5-20200803
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=fKJAJQVfxmdAr8Fx0IAfMXtGgSuSubjw5SgTjtIYFEc=;
        b=e1yeVrtcOVvjTgTLTcXp0p0KP6uQqyFoHvMg5beo0YAFijG3dB7JpTgdH0ni0PBPHptE/n3rTvHZnjS70qbcSJaDVeHq6Kr8fDzBJX0LN8W1ZniyIwxvBDzFvpUX9Lz+B9U4ciWWbb3XP5TmtaARFqEnKqDvEBfsZYxVN0x9PnY=;
X-UUID: 94d591465c1c47f08c5a371fb3fdfdc5-20200803
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1591615903; Mon, 03 Aug 2020 14:17:14 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 3 Aug 2020 14:17:11 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 3 Aug 2020 14:17:12 +0800
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <seiya.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <fan.chen@mediatek.com>, <yong.liang@mediatek.com>,
        Crystal Guo <crystal.guo@mediatek.com>
Subject: [v2,5/6] reset-controller: ti: Introduce force-update method
Date:   Mon, 3 Aug 2020 14:15:10 +0800
Message-ID: <20200803061511.29555-6-crystal.guo@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200803061511.29555-1-crystal.guo@mediatek.com>
References: <20200803061511.29555-1-crystal.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW50cm9kdWNlIGZvcmNlLXVwZGF0ZSBtZXRob2QgZm9yIGFzc2VydCBhbmQgZGVhc3NlcnQgaW50
ZXJmYWNlLA0Kd2hpY2ggZm9yY2UgdGhlIHdyaXRlIG9wZXJhdGlvbiBpbiBjYXNlIHRoZSByZWFk
IGFscmVhZHkgaGFwcGVucw0KdG8gcmV0dXJuIHRoZSBjb3JyZWN0IHZhbHVlLg0KDQpTaWduZWQt
b2ZmLWJ5OiBDcnlzdGFsIEd1byA8Y3J5c3RhbC5ndW9AbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJp
dmVycy9yZXNldC9yZXNldC10aS1zeXNjb24uYyB8IDE1ICsrKysrKysrKysrKystLQ0KIDEgZmls
ZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9yZXNldC9yZXNldC10aS1zeXNjb24uYyBiL2RyaXZlcnMvcmVzZXQvcmVzZXQt
dGktc3lzY29uLmMNCmluZGV4IDFjNzRiY2I5YTZjMy4uZjRiYWY3OGFmZDE0IDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9yZXNldC9yZXNldC10aS1zeXNjb24uYw0KKysrIGIvZHJpdmVycy9yZXNldC9y
ZXNldC10aS1zeXNjb24uYw0KQEAgLTU3LDYgKzU3LDcgQEAgc3RydWN0IHRpX3N5c2Nvbl9yZXNl
dF9kYXRhIHsNCiAJc3RydWN0IHRpX3N5c2Nvbl9yZXNldF9jb250cm9sICpjb250cm9sczsNCiAJ
dW5zaWduZWQgaW50IG5yX2NvbnRyb2xzOw0KIAlib29sIGFzc2VydF9kZWFzc2VydF90b2dldGhl
cjsNCisJYm9vbCB1cGRhdGVfZm9yY2U7DQogfTsNCiANCiAjZGVmaW5lIHRvX3RpX3N5c2Nvbl9y
ZXNldF9kYXRhKHJjZGV2KQlcDQpAQCAtOTAsNyArOTEsMTAgQEAgc3RhdGljIGludCB0aV9zeXNj
b25fcmVzZXRfYXNzZXJ0KHN0cnVjdCByZXNldF9jb250cm9sbGVyX2RldiAqcmNkZXYsDQogCW1h
c2sgPSBCSVQoY29udHJvbC0+YXNzZXJ0X2JpdCk7DQogCXZhbHVlID0gKGNvbnRyb2wtPmZsYWdz
ICYgQVNTRVJUX1NFVCkgPyBtYXNrIDogMHgwOw0KIA0KLQlyZXR1cm4gcmVnbWFwX3VwZGF0ZV9i
aXRzKGRhdGEtPnJlZ21hcCwgY29udHJvbC0+YXNzZXJ0X29mZnNldCwgbWFzaywgdmFsdWUpOw0K
KwlpZiAoZGF0YS0+dXBkYXRlX2ZvcmNlKQ0KKwkJcmV0dXJuIHJlZ21hcF93cml0ZV9iaXRzKGRh
dGEtPnJlZ21hcCwgY29udHJvbC0+YXNzZXJ0X29mZnNldCwgbWFzaywgdmFsdWUpOw0KKwllbHNl
DQorCQlyZXR1cm4gcmVnbWFwX3VwZGF0ZV9iaXRzKGRhdGEtPnJlZ21hcCwgY29udHJvbC0+YXNz
ZXJ0X29mZnNldCwgbWFzaywgdmFsdWUpOw0KIH0NCiANCiAvKioNCkBAIC0xMjEsNyArMTI1LDEw
IEBAIHN0YXRpYyBpbnQgdGlfc3lzY29uX3Jlc2V0X2RlYXNzZXJ0KHN0cnVjdCByZXNldF9jb250
cm9sbGVyX2RldiAqcmNkZXYsDQogCW1hc2sgPSBCSVQoY29udHJvbC0+ZGVhc3NlcnRfYml0KTsN
CiAJdmFsdWUgPSAoY29udHJvbC0+ZmxhZ3MgJiBERUFTU0VSVF9TRVQpID8gbWFzayA6IDB4MDsN
CiANCi0JcmV0dXJuIHJlZ21hcF91cGRhdGVfYml0cyhkYXRhLT5yZWdtYXAsIGNvbnRyb2wtPmRl
YXNzZXJ0X29mZnNldCwgbWFzaywgdmFsdWUpOw0KKwlpZiAoZGF0YS0+dXBkYXRlX2ZvcmNlKQ0K
KwkJcmV0dXJuIHJlZ21hcF93cml0ZV9iaXRzKGRhdGEtPnJlZ21hcCwgY29udHJvbC0+ZGVhc3Nl
cnRfb2Zmc2V0LCBtYXNrLCB2YWx1ZSk7DQorCWVsc2UNCisJCXJldHVybiByZWdtYXBfdXBkYXRl
X2JpdHMoZGF0YS0+cmVnbWFwLCBjb250cm9sLT5kZWFzc2VydF9vZmZzZXQsIG1hc2ssIHZhbHVl
KTsNCiB9DQogDQogLyoqDQpAQCAtMjIzLDYgKzIzMCwxMCBAQCBzdGF0aWMgaW50IHRpX3N5c2Nv
bl9yZXNldF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAkJZGF0YS0+YXNz
ZXJ0X2RlYXNzZXJ0X3RvZ2V0aGVyID0gdHJ1ZTsNCiAJZWxzZQ0KIAkJZGF0YS0+YXNzZXJ0X2Rl
YXNzZXJ0X3RvZ2V0aGVyID0gZmFsc2U7DQorCWlmIChvZl9wcm9wZXJ0eV9yZWFkX2Jvb2wobnAs
ICJ1cGRhdGUtZm9yY2UiKSkNCisJCWRhdGEtPnVwZGF0ZV9mb3JjZSA9IHRydWU7DQorCWVsc2UN
CisJCWRhdGEtPnVwZGF0ZV9mb3JjZSA9IGZhbHNlOw0KIA0KIAlkYXRhLT5yY2Rldi5vcHMgPSAm
dGlfc3lzY29uX3Jlc2V0X29wczsNCiAJZGF0YS0+cmNkZXYub3duZXIgPSBUSElTX01PRFVMRTsN
Ci0tIA0KMi4xOC4wDQo=

