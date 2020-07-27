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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFB8C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6876D20672
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="V7YgE5Ne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgG0HQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 03:16:46 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52175 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727033AbgG0HQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 03:16:44 -0400
X-UUID: 80b9a423517e4aa9a639366fe86a34df-20200727
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=x6c9apllsraX6rv/6S+rjbkHnvqPnQsJAwjR+kPcEbE=;
        b=V7YgE5NepMNABOjRneQAGmqaJSLYTMzm9BCgDDnyMqx9bR2AD/ji6+nD1PaHqdgIz81g6YamgS897siqayAtWJ6j3sA3D7iKRrYchh0d9E5IXBDWXcBQ+gg9/ZH4bLt0OPOHzndTJE1NG8Ksupou6c9tQyqPYgisckqau+6sLuM=;
X-UUID: 80b9a423517e4aa9a639366fe86a34df-20200727
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2117605699; Mon, 27 Jul 2020 15:16:38 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 27 Jul 2020 15:16:35 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 27 Jul 2020 15:16:35 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH 04/11] usb: mtu3: clear interrupts status when disable interrupts
Date:   Mon, 27 Jul 2020 15:14:53 +0800
Message-ID: <1595834101-13094-4-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1595834101-13094-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1595834101-13094-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A8C7A88285639417D4FD77E1C46961D26AEA72226E43EB7A31F8065F0DED3D7E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2hlbiBkaXNhYmxlIGludGVycnVwdHMsIHdpbGwgYWxzbyB3YW50IHRvIGNsZWFyIHRoZWlyIHN0
YXR1cywNCmVuc3VyZSBpdCBieSBjYWxsaW5nIG10dTNfaW50cl9zdGF0dXNfY2xlYXIoKSBpbg0K
bXR1M19pbnRyX2Rpc2FibGUoKS4NCg0KU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVu
ZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy91c2IvbXR1My9tdHUzX2NvcmUu
YyB8IDI1ICsrKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTIgaW5z
ZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9t
dHUzL210dTNfY29yZS5jIGIvZHJpdmVycy91c2IvbXR1My9tdHUzX2NvcmUuYw0KaW5kZXggZjNh
ZDFjYy4uZWNlNWIzZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL210dTMvbXR1M19jb3JlLmMN
CisrKyBiL2RyaXZlcnMvdXNiL210dTMvbXR1M19jb3JlLmMNCkBAIC0xNDcsMTcgKzE0Nyw2IEBA
IHN0YXRpYyB2b2lkIG10dTNfZGV2aWNlX3Jlc2V0KHN0cnVjdCBtdHUzICptdHUpDQogCW10dTNf
Y2xyYml0cyhpYmFzZSwgVTNEX1NTVVNCX0RFVl9SU1RfQ1RSTCwgU1NVU0JfREVWX1NXX1JTVCk7
DQogfQ0KIA0KLS8qIGRpc2FibGUgYWxsIGludGVycnVwdHMgKi8NCi1zdGF0aWMgdm9pZCBtdHUz
X2ludHJfZGlzYWJsZShzdHJ1Y3QgbXR1MyAqbXR1KQ0KLXsNCi0Jdm9pZCBfX2lvbWVtICptYmFz
ZSA9IG10dS0+bWFjX2Jhc2U7DQotDQotCS8qIERpc2FibGUgbGV2ZWwgMSBpbnRlcnJ1cHRzICov
DQotCW10dTNfd3JpdGVsKG1iYXNlLCBVM0RfTFYxSUVDUiwgfjB4MCk7DQotCS8qIERpc2FibGUg
ZW5kcG9pbnQgaW50ZXJydXB0cyAqLw0KLQltdHUzX3dyaXRlbChtYmFzZSwgVTNEX0VQSUVDUiwg
fjB4MCk7DQotfQ0KLQ0KIHN0YXRpYyB2b2lkIG10dTNfaW50cl9zdGF0dXNfY2xlYXIoc3RydWN0
IG10dTMgKm10dSkNCiB7DQogCXZvaWQgX19pb21lbSAqbWJhc2UgPSBtdHUtPm1hY19iYXNlOw0K
QEAgLTE3MCw2ICsxNTksMTggQEAgc3RhdGljIHZvaWQgbXR1M19pbnRyX3N0YXR1c19jbGVhcihz
dHJ1Y3QgbXR1MyAqbXR1KQ0KIAltdHUzX3dyaXRlbChtYmFzZSwgVTNEX0xUU1NNX0lOVFIsIH4w
eDApOw0KIAkvKiBDbGVhciBzcGVlZCBjaGFuZ2UgaW50ZXJydXB0IHN0YXR1cyAqLw0KIAltdHUz
X3dyaXRlbChtYmFzZSwgVTNEX0RFVl9MSU5LX0lOVFIsIH4weDApOw0KKwkvKiBDbGVhciBRTVUg
aW50ZXJydXB0IHN0YXR1cyAqLw0KKwltdHUzX3dyaXRlbChtYmFzZSwgVTNEX1FJU0FSMCwgfjB4
MCk7DQorfQ0KKw0KKy8qIGRpc2FibGUgYWxsIGludGVycnVwdHMgKi8NCitzdGF0aWMgdm9pZCBt
dHUzX2ludHJfZGlzYWJsZShzdHJ1Y3QgbXR1MyAqbXR1KQ0KK3sNCisJLyogRGlzYWJsZSBsZXZl
bCAxIGludGVycnVwdHMgKi8NCisJbXR1M193cml0ZWwobXR1LT5tYWNfYmFzZSwgVTNEX0xWMUlF
Q1IsIH4weDApOw0KKwkvKiBEaXNhYmxlIGVuZHBvaW50IGludGVycnVwdHMgKi8NCisJbXR1M193
cml0ZWwobXR1LT5tYWNfYmFzZSwgVTNEX0VQSUVDUiwgfjB4MCk7DQorCW10dTNfaW50cl9zdGF0
dXNfY2xlYXIobXR1KTsNCiB9DQogDQogLyogZW5hYmxlIHN5c3RlbSBnbG9iYWwgaW50ZXJydXB0
ICovDQpAQCAtMzEyLDcgKzMxMyw2IEBAIHZvaWQgbXR1M19zdG9wKHN0cnVjdCBtdHUzICptdHUp
DQogCWRldl9kYmcobXR1LT5kZXYsICIlc1xuIiwgX19mdW5jX18pOw0KIA0KIAltdHUzX2ludHJf
ZGlzYWJsZShtdHUpOw0KLQltdHUzX2ludHJfc3RhdHVzX2NsZWFyKG10dSk7DQogDQogCWlmICht
dHUtPnNvZnRjb25uZWN0KQ0KIAkJbXR1M19kZXZfb25fb2ZmKG10dSwgMCk7DQpAQCAtNjAwLDcg
KzYwMCw2IEBAIHN0YXRpYyB2b2lkIG10dTNfcmVnc19pbml0KHN0cnVjdCBtdHUzICptdHUpDQog
DQogCS8qIGJlIHN1cmUgaW50ZXJydXB0cyBhcmUgZGlzYWJsZWQgYmVmb3JlIHJlZ2lzdHJhdGlv
biBvZiBJU1IgKi8NCiAJbXR1M19pbnRyX2Rpc2FibGUobXR1KTsNCi0JbXR1M19pbnRyX3N0YXR1
c19jbGVhcihtdHUpOw0KIA0KIAltdHUzX2Nzcl9pbml0KG10dSk7DQogDQotLSANCjEuOS4xDQo=

