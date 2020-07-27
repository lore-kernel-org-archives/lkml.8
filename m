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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29E6C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAEB42177B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NhbC8WoI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgG0HQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 03:16:39 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44602 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726116AbgG0HQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 03:16:37 -0400
X-UUID: 76ed54c329814d1e8ca43fdc6ecd847a-20200727
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=CEB+Fd7Gn3H8VZZKWasR7hc+Jw+O8wMVPt6wPu9YgD4=;
        b=NhbC8WoIzbSfZfcsGRmoI/1hXw/fTejFXPXziqyJFvQJNPw+GrGIOFC1xBZ27vIOf2SdsXYwvoj/1lFstm312qnSXcYRtuI/ARn9SCgbtd2coV01Mz2g/RMK0gu1SJ3RyUHmTG2vGE17rb7MbXhaMRGgm3DQzf5ZUJBZGaod8Kw=;
X-UUID: 76ed54c329814d1e8ca43fdc6ecd847a-20200727
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 692876081; Mon, 27 Jul 2020 15:16:34 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 27 Jul 2020 15:16:31 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 27 Jul 2020 15:16:31 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH 01/11] usb: mtu3: remove unnecessary pointer checks
Date:   Mon, 27 Jul 2020 15:14:50 +0800
Message-ID: <1595834101-13094-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGNsYXNzIGRyaXZlciB3aWxsIGVuc3VyZSB0aGUgcGFyYW1ldGVycyBhcmUgdmFsaWQNCnBv
aW50ZXJzIGJlZm9yZSBjYWxsIHRoZSBob29rIGZ1bmN0aW9uIG9mIHVzYl9lcF9vcHMsDQpzbyBu
byBuZWVkIGNoZWNrIHRoZW0gYWdhaW4uDQoNClNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8
Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvdXNiL210dTMvbXR1M19n
YWRnZXQuYyB8IDI1ICsrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwg
NiBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dXNiL210dTMvbXR1M19nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL210dTMvbXR1M19nYWRnZXQuYw0K
aW5kZXggZjkzNzMyZS4uNmIyNmNiOCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL210dTMvbXR1
M19nYWRnZXQuYw0KKysrIGIvZHJpdmVycy91c2IvbXR1My9tdHUzX2dhZGdldC5jDQpAQCAtMjYz
LDIzICsyNjMsMTUgQEAgdm9pZCBtdHUzX2ZyZWVfcmVxdWVzdChzdHJ1Y3QgdXNiX2VwICplcCwg
c3RydWN0IHVzYl9yZXF1ZXN0ICpyZXEpDQogc3RhdGljIGludCBtdHUzX2dhZGdldF9xdWV1ZShz
dHJ1Y3QgdXNiX2VwICplcCwNCiAJCXN0cnVjdCB1c2JfcmVxdWVzdCAqcmVxLCBnZnBfdCBnZnBf
ZmxhZ3MpDQogew0KLQlzdHJ1Y3QgbXR1M19lcCAqbWVwOw0KLQlzdHJ1Y3QgbXR1M19yZXF1ZXN0
ICptcmVxOw0KLQlzdHJ1Y3QgbXR1MyAqbXR1Ow0KKwlzdHJ1Y3QgbXR1M19lcCAqbWVwID0gdG9f
bXR1M19lcChlcCk7DQorCXN0cnVjdCBtdHUzX3JlcXVlc3QgKm1yZXEgPSB0b19tdHUzX3JlcXVl
c3QocmVxKTsNCisJc3RydWN0IG10dTMgKm10dSA9IG1lcC0+bXR1Ow0KIAl1bnNpZ25lZCBsb25n
IGZsYWdzOw0KIAlpbnQgcmV0ID0gMDsNCiANCi0JaWYgKCFlcCB8fCAhcmVxKQ0KLQkJcmV0dXJu
IC1FSU5WQUw7DQotDQogCWlmICghcmVxLT5idWYpDQogCQlyZXR1cm4gLUVOT0RBVEE7DQogDQot
CW1lcCA9IHRvX210dTNfZXAoZXApOw0KLQltdHUgPSBtZXAtPm10dTsNCi0JbXJlcSA9IHRvX210
dTNfcmVxdWVzdChyZXEpOw0KLQltcmVxLT5tdHUgPSBtdHU7DQotDQogCWlmIChtcmVxLT5tZXAg
IT0gbWVwKQ0KIAkJcmV0dXJuIC1FSU5WQUw7DQogDQpAQCAtMzAzLDYgKzI5NSw3IEBAIHN0YXRp
YyBpbnQgbXR1M19nYWRnZXRfcXVldWUoc3RydWN0IHVzYl9lcCAqZXAsDQogCQlyZXR1cm4gLUVT
SFVURE9XTjsNCiAJfQ0KIA0KKwltcmVxLT5tdHUgPSBtdHU7DQogCW1yZXEtPnJlcXVlc3QuYWN0
dWFsID0gMDsNCiAJbXJlcS0+cmVxdWVzdC5zdGF0dXMgPSAtRUlOUFJPR1JFU1M7DQogDQpAQCAt
MzM1LDExICszMjgsMTEgQEAgc3RhdGljIGludCBtdHUzX2dhZGdldF9kZXF1ZXVlKHN0cnVjdCB1
c2JfZXAgKmVwLCBzdHJ1Y3QgdXNiX3JlcXVlc3QgKnJlcSkNCiAJc3RydWN0IG10dTNfZXAgKm1l
cCA9IHRvX210dTNfZXAoZXApOw0KIAlzdHJ1Y3QgbXR1M19yZXF1ZXN0ICptcmVxID0gdG9fbXR1
M19yZXF1ZXN0KHJlcSk7DQogCXN0cnVjdCBtdHUzX3JlcXVlc3QgKnI7DQorCXN0cnVjdCBtdHUz
ICptdHUgPSBtZXAtPm10dTsNCiAJdW5zaWduZWQgbG9uZyBmbGFnczsNCiAJaW50IHJldCA9IDA7
DQotCXN0cnVjdCBtdHUzICptdHUgPSBtZXAtPm10dTsNCiANCi0JaWYgKCFlcCB8fCAhcmVxIHx8
IG1yZXEtPm1lcCAhPSBtZXApDQorCWlmIChtcmVxLT5tZXAgIT0gbWVwKQ0KIAkJcmV0dXJuIC1F
SU5WQUw7DQogDQogCWRldl9kYmcobXR1LT5kZXYsICIlcyA6IHJlcT0lcFxuIiwgX19mdW5jX18s
IHJlcSk7DQpAQCAtMzc5LDkgKzM3Miw2IEBAIHN0YXRpYyBpbnQgbXR1M19nYWRnZXRfZXBfc2V0
X2hhbHQoc3RydWN0IHVzYl9lcCAqZXAsIGludCB2YWx1ZSkNCiAJdW5zaWduZWQgbG9uZyBmbGFn
czsNCiAJaW50IHJldCA9IDA7DQogDQotCWlmICghZXApDQotCQlyZXR1cm4gLUVJTlZBTDsNCi0N
CiAJZGV2X2RiZyhtdHUtPmRldiwgIiVzIDogJXMuLi4iLCBfX2Z1bmNfXywgZXAtPm5hbWUpOw0K
IA0KIAlzcGluX2xvY2tfaXJxc2F2ZSgmbXR1LT5sb2NrLCBmbGFncyk7DQpAQCAtNDI0LDkgKzQx
NCw2IEBAIHN0YXRpYyBpbnQgbXR1M19nYWRnZXRfZXBfc2V0X3dlZGdlKHN0cnVjdCB1c2JfZXAg
KmVwKQ0KIHsNCiAJc3RydWN0IG10dTNfZXAgKm1lcCA9IHRvX210dTNfZXAoZXApOw0KIA0KLQlp
ZiAoIWVwKQ0KLQkJcmV0dXJuIC1FSU5WQUw7DQotDQogCW1lcC0+d2VkZ2VkID0gMTsNCiANCiAJ
cmV0dXJuIHVzYl9lcF9zZXRfaGFsdChlcCk7DQotLSANCjEuOS4xDQo=

