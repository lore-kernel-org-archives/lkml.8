Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C53C3B196
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 04:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2412168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 04:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tl+bmU9u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgBNEdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 23:33:35 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:18727 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728699AbgBNEde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 23:33:34 -0500
X-UUID: 79d930b9468c46ba9824c0adc7f76de2-20200214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=pXdRTGlO/UWEDb7GkCFHAFd4vtjwvmu6YVdID32AlX0=;
        b=tl+bmU9u6C0nN/qAd9VtIJhb4WJiRKPCX1UiJDxSLzrGwzuVWqyvX9ph/cpaBTQjMqJmx/fIn6VLDc9Sj1h4LJUYrOdxD2d/FOLkXPGScQV6uyW2qBOjvGr+k5H6RFi6n3U8GwpvKyYqKLtvPXSfOf4mk8UXzUvAqVeitqlpZEI=;
X-UUID: 79d930b9468c46ba9824c0adc7f76de2-20200214
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1156326796; Fri, 14 Feb 2020 12:33:28 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 14 Feb 2020 12:32:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Feb 2020 12:33:18 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, CK HU <ck.hu@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH 1/3] mailbox: mediatek: implement flush function
Date:   Fri, 14 Feb 2020 12:33:23 +0800
Message-ID: <20200214043325.16618-2-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200214043325.16618-1-bibby.hsieh@mediatek.com>
References: <20200214043325.16618-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rm9yIGNsaWVudCBkcml2ZXIgd2hpY2ggbmVlZCB0byByZW9yZ2FuaXplIHRoZSBjb21tYW5kIGJ1
ZmZlciwgaXQgY291bGQNCnVzZSB0aGlzIGZ1bmN0aW9uIHRvIGZsdXNoIHRoZSBzZW5kIGNvbW1h
bmQgYnVmZmVyLg0KSWYgdGhlIGNoYW5uZWwgZG9lc24ndCBiZSBzdGFydGVkICh1c3VhbGx5IGlu
IHdhaXRpbmcgZm9yIGV2ZW50KSwgdGhpcw0KZnVuY3Rpb24gd2lsbCBhYm9ydCBpdCBkaXJlY3Rs
eS4NCg0KU2lnbmVkLW9mZi1ieTogQmliYnkgSHNpZWggPGJpYmJ5LmhzaWVoQG1lZGlhdGVrLmNv
bT4NCi0tLQ0KIGRyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMgfCA1MCArKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0NCiAxIGZpbGUgY2hhbmdlZCwgNDggaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWFpbGJveC9tdGstY21k
cS1tYWlsYm94LmMgYi9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQppbmRleCA5
YTZjZTlmNWE3ZGIuLjAzZTU4ZmY2MjAwNyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbWFpbGJveC9t
dGstY21kcS1tYWlsYm94LmMNCisrKyBiL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94
LmMNCkBAIC01LDYgKzUsNyBAQA0KICNpbmNsdWRlIDxsaW51eC9iaXRvcHMuaD4NCiAjaW5jbHVk
ZSA8bGludXgvY2xrLmg+DQogI2luY2x1ZGUgPGxpbnV4L2Nsay1wcm92aWRlci5oPg0KKyNpbmNs
dWRlIDxsaW51eC9jb21wbGV0aW9uLmg+DQogI2luY2x1ZGUgPGxpbnV4L2RtYS1tYXBwaW5nLmg+
DQogI2luY2x1ZGUgPGxpbnV4L2Vycm5vLmg+DQogI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5o
Pg0KQEAgLTQyOCwxNCArNDI5LDU5IEBAIHN0YXRpYyBpbnQgY21kcV9tYm94X3N0YXJ0dXAoc3Ry
dWN0IG1ib3hfY2hhbiAqY2hhbikNCiAJcmV0dXJuIDA7DQogfQ0KIA0KLXN0YXRpYyB2b2lkIGNt
ZHFfbWJveF9zaHV0ZG93bihzdHJ1Y3QgbWJveF9jaGFuICpjaGFuKQ0KK3N0YXRpYyBpbnQgY21k
cV9tYm94X2ZsdXNoKHN0cnVjdCBtYm94X2NoYW4gKmNoYW4sIHVuc2lnbmVkIGxvbmcgdGltZW91
dCkNCiB7DQorCXN0cnVjdCBjbWRxX3RocmVhZCAqdGhyZWFkID0gKHN0cnVjdCBjbWRxX3RocmVh
ZCAqKWNoYW4tPmNvbl9wcml2Ow0KKwlzdHJ1Y3QgY21kcV90YXNrX2NiICpjYjsNCisJc3RydWN0
IGNtZHFfY2JfZGF0YSBkYXRhOw0KKwlzdHJ1Y3QgY21kcSAqY21kcSA9IGRldl9nZXRfZHJ2ZGF0
YShjaGFuLT5tYm94LT5kZXYpOw0KKwlzdHJ1Y3QgY21kcV90YXNrICp0YXNrLCAqdG1wOw0KKwl1
bnNpZ25lZCBsb25nIGZsYWdzOw0KKwl1MzIgZW5hYmxlOw0KKw0KKwlzcGluX2xvY2tfaXJxc2F2
ZSgmdGhyZWFkLT5jaGFuLT5sb2NrLCBmbGFncyk7DQorCWlmIChsaXN0X2VtcHR5KCZ0aHJlYWQt
PnRhc2tfYnVzeV9saXN0KSkNCisJCWdvdG8gb3V0Ow0KKw0KKwlXQVJOX09OKGNtZHFfdGhyZWFk
X3N1c3BlbmQoY21kcSwgdGhyZWFkKSA8IDApOw0KKwlpZiAoIWNtZHFfdGhyZWFkX2lzX2luX3dm
ZSh0aHJlYWQpKQ0KKwkJZ290byB3YWl0Ow0KKw0KKwlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUo
dGFzaywgdG1wLCAmdGhyZWFkLT50YXNrX2J1c3lfbGlzdCwNCisJCQkJIGxpc3RfZW50cnkpIHsN
CisJCWNiID0gJnRhc2stPnBrdC0+YXN5bmNfY2I7DQorCQlsaXN0X2RlbCgmdGFzay0+bGlzdF9l
bnRyeSk7DQorCQlrZnJlZSh0YXNrKTsNCisJfQ0KKw0KKwlpZiAoY2ItPmNiKSB7DQorCQlkYXRh
LnN0YSA9IC1FTk9CVUZTOw0KKwkJZGF0YS5kYXRhID0gY2ItPmRhdGE7DQorCQljYi0+Y2IoZGF0
YSk7DQorCX0NCisNCisJY21kcV90aHJlYWRfcmVzdW1lKHRocmVhZCk7DQorCWNtZHFfdGhyZWFk
X2Rpc2FibGUoY21kcSwgdGhyZWFkKTsNCisJY2xrX2Rpc2FibGUoY21kcS0+Y2xvY2spOw0KKw0K
K291dDoNCisJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmdGhyZWFkLT5jaGFuLT5sb2NrLCBmbGFn
cyk7DQorCXJldHVybiAwOw0KKw0KK3dhaXQ6DQorCWNtZHFfdGhyZWFkX3Jlc3VtZSh0aHJlYWQp
Ow0KKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZ0aHJlYWQtPmNoYW4tPmxvY2ssIGZsYWdzKTsN
CisJaWYgKHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWModGhyZWFkLT5iYXNlICsgQ01EUV9USFJf
RU5BQkxFX1RBU0ssDQorCQkJCSAgICAgIGVuYWJsZSwgZW5hYmxlID09IDAsIDEsIHRpbWVvdXQp
KQ0KKwkJZGV2X2VycihjbWRxLT5tYm94LmRldiwgIkZhaWwgdG8gd2FpdCBHQ0UgdGhyZWFkIDB4
JXggZG9uZVxuIiwNCisJCQkodTMyKSh0aHJlYWQtPmJhc2UgLSBjbWRxLT5iYXNlKSk7DQorCXJl
dHVybiAwOw0KIH0NCiANCiBzdGF0aWMgY29uc3Qgc3RydWN0IG1ib3hfY2hhbl9vcHMgY21kcV9t
Ym94X2NoYW5fb3BzID0gew0KIAkuc2VuZF9kYXRhID0gY21kcV9tYm94X3NlbmRfZGF0YSwNCiAJ
LnN0YXJ0dXAgPSBjbWRxX21ib3hfc3RhcnR1cCwNCi0JLnNodXRkb3duID0gY21kcV9tYm94X3No
dXRkb3duLA0KKwkuZmx1c2ggPSBjbWRxX21ib3hfZmx1c2gsDQogfTsNCiANCiBzdGF0aWMgc3Ry
dWN0IG1ib3hfY2hhbiAqY21kcV94bGF0ZShzdHJ1Y3QgbWJveF9jb250cm9sbGVyICptYm94LA0K
LS0gDQoyLjE4LjANCg==

