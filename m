Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC34C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C15A206F0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GO7g6B/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgGKGtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 02:49:55 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:5635 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726963AbgGKGtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 02:49:55 -0400
X-UUID: a85c8e28014d457aad26db829a44d154-20200711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=al19z6H/YaqTz2BTaMdhxJZ6fCtCLvOHwFXYnTxISm0=;
        b=GO7g6B/kOkkGsZfD3lyhcSjE9E0c4xiJ4tXs5ubjYKhFZYeqM+VHiivXJgJ/4uuMSLeNvvfv+TEqudFdskMizfO3yI5ngRw9NV+ZM21mAcECuebhcdUrVk5prdizxRStfOFHI6/8b75sDZwu0eVXaHBk+k+cO+oupYTiGZP1ljg=;
X-UUID: a85c8e28014d457aad26db829a44d154-20200711
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1686050325; Sat, 11 Jul 2020 14:49:51 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Jul 2020 14:49:47 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Jul 2020 14:49:46 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Will Deacon <will@kernel.org>, Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <cui.zhang@mediatek.com>,
        <chao.hao@mediatek.com>, <ming-fan.chen@mediatek.com>
Subject: [PATCH 01/21] dt-binding: memory: mediatek: Add a common larb-port header file
Date:   Sat, 11 Jul 2020 14:48:26 +0800
Message-ID: <20200711064846.16007-2-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200711064846.16007-1-yong.wu@mediatek.com>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B97F24F9EE4D61C0789D119FFDC457957A99B8B58BF659875E97995F26A574632000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UHV0IGFsbCB0aGUgbWFjcm9zIGFib3V0IHNtaSBsYXJiL3BvcnQgdG9nZXRoZXJzLCB0aGlzIGlz
IGEgcHJlcGFyaW5nDQpwYXRjaCBmb3IgZXh0ZW5kaW5nIExBUkJfTlIgYW5kIGFkZGluZyBuZXcg
ZG9tLWlkIHN1cHBvcnQuDQoNClNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0
ZWsuY29tPg0KLS0tDQogaW5jbHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXQyNzEyLWxhcmItcG9y
dC5oICB8ICAyICstDQogaW5jbHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXQ2Nzc5LWxhcmItcG9y
dC5oICB8ICAyICstDQogaW5jbHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXQ4MTczLWxhcmItcG9y
dC5oICB8ICAyICstDQogaW5jbHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXQ4MTgzLWxhcmItcG9y
dC5oICB8ICAyICstDQogaW5jbHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXRrLXNtaS1sYXJiLXBv
cnQuaCB8IDE1ICsrKysrKysrKysrKysrKw0KIDUgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9kdC1iaW5k
aW5ncy9tZW1vcnkvbXRrLXNtaS1sYXJiLXBvcnQuaA0KDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9k
dC1iaW5kaW5ncy9tZW1vcnkvbXQyNzEyLWxhcmItcG9ydC5oIGIvaW5jbHVkZS9kdC1iaW5kaW5n
cy9tZW1vcnkvbXQyNzEyLWxhcmItcG9ydC5oDQppbmRleCA2ZjlhYTczNDljZWYuLmI2YjJjNmJm
NDQ1OSAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvZHQtYmluZGluZ3MvbWVtb3J5L210MjcxMi1sYXJi
LXBvcnQuaA0KKysrIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXQyNzEyLWxhcmItcG9y
dC5oDQpAQCAtNiw3ICs2LDcgQEANCiAjaWZuZGVmIF9fRFRTX0lPTU1VX1BPUlRfTVQyNzEyX0gN
CiAjZGVmaW5lIF9fRFRTX0lPTU1VX1BPUlRfTVQyNzEyX0gNCiANCi0jZGVmaW5lIE1US19NNFVf
SUQobGFyYiwgcG9ydCkJCSgoKGxhcmIpIDw8IDUpIHwgKHBvcnQpKQ0KKyNpbmNsdWRlIDxkdC1i
aW5kaW5ncy9tZW1vcnkvbXRrLXNtaS1sYXJiLXBvcnQuaD4NCiANCiAjZGVmaW5lIE00VV9MQVJC
MF9JRAkJCTANCiAjZGVmaW5lIE00VV9MQVJCMV9JRAkJCTENCmRpZmYgLS1naXQgYS9pbmNsdWRl
L2R0LWJpbmRpbmdzL21lbW9yeS9tdDY3NzktbGFyYi1wb3J0LmggYi9pbmNsdWRlL2R0LWJpbmRp
bmdzL21lbW9yeS9tdDY3NzktbGFyYi1wb3J0LmgNCmluZGV4IDJhZDA4OTlmYmYyZi4uNjBmNTdm
NTQzOTNlIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXQ2Nzc5LWxh
cmItcG9ydC5oDQorKysgYi9pbmNsdWRlL2R0LWJpbmRpbmdzL21lbW9yeS9tdDY3NzktbGFyYi1w
b3J0LmgNCkBAIC03LDcgKzcsNyBAQA0KICNpZm5kZWYgX0RUU19JT01NVV9QT1JUX01UNjc3OV9I
Xw0KICNkZWZpbmUgX0RUU19JT01NVV9QT1JUX01UNjc3OV9IXw0KIA0KLSNkZWZpbmUgTVRLX000
VV9JRChsYXJiLCBwb3J0KQkJICgoKGxhcmIpIDw8IDUpIHwgKHBvcnQpKQ0KKyNpbmNsdWRlIDxk
dC1iaW5kaW5ncy9tZW1vcnkvbXRrLXNtaS1sYXJiLXBvcnQuaD4NCiANCiAjZGVmaW5lIE00VV9M
QVJCMF9JRAkJCSAwDQogI2RlZmluZSBNNFVfTEFSQjFfSUQJCQkgMQ0KZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvZHQtYmluZGluZ3MvbWVtb3J5L210ODE3My1sYXJiLXBvcnQuaCBiL2luY2x1ZGUvZHQt
YmluZGluZ3MvbWVtb3J5L210ODE3My1sYXJiLXBvcnQuaA0KaW5kZXggOWYzMWNjZmVjYTIxLi5k
OGM5OWM5NDYwNTMgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL2R0LWJpbmRpbmdzL21lbW9yeS9tdDgx
NzMtbGFyYi1wb3J0LmgNCisrKyBiL2luY2x1ZGUvZHQtYmluZGluZ3MvbWVtb3J5L210ODE3My1s
YXJiLXBvcnQuaA0KQEAgLTYsNyArNiw3IEBADQogI2lmbmRlZiBfX0RUU19JT01NVV9QT1JUX01U
ODE3M19IDQogI2RlZmluZSBfX0RUU19JT01NVV9QT1JUX01UODE3M19IDQogDQotI2RlZmluZSBN
VEtfTTRVX0lEKGxhcmIsIHBvcnQpCQkoKChsYXJiKSA8PCA1KSB8IChwb3J0KSkNCisjaW5jbHVk
ZSA8ZHQtYmluZGluZ3MvbWVtb3J5L210ay1zbWktbGFyYi1wb3J0Lmg+DQogDQogI2RlZmluZSBN
NFVfTEFSQjBfSUQJCQkwDQogI2RlZmluZSBNNFVfTEFSQjFfSUQJCQkxDQpkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXQ4MTgzLWxhcmItcG9ydC5oIGIvaW5jbHVkZS9k
dC1iaW5kaW5ncy9tZW1vcnkvbXQ4MTgzLWxhcmItcG9ydC5oDQppbmRleCAyYzU3OWYzMDUxNjIu
LjI3NWMwOTVhNmZkNiAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvZHQtYmluZGluZ3MvbWVtb3J5L210
ODE4My1sYXJiLXBvcnQuaA0KKysrIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXQ4MTgz
LWxhcmItcG9ydC5oDQpAQCAtNiw3ICs2LDcgQEANCiAjaWZuZGVmIF9fRFRTX0lPTU1VX1BPUlRf
TVQ4MTgzX0gNCiAjZGVmaW5lIF9fRFRTX0lPTU1VX1BPUlRfTVQ4MTgzX0gNCiANCi0jZGVmaW5l
IE1US19NNFVfSUQobGFyYiwgcG9ydCkJCSgoKGxhcmIpIDw8IDUpIHwgKHBvcnQpKQ0KKyNpbmNs
dWRlIDxkdC1iaW5kaW5ncy9tZW1vcnkvbXRrLXNtaS1sYXJiLXBvcnQuaD4NCiANCiAjZGVmaW5l
IE00VV9MQVJCMF9JRAkJCTANCiAjZGVmaW5lIE00VV9MQVJCMV9JRAkJCTENCmRpZmYgLS1naXQg
YS9pbmNsdWRlL2R0LWJpbmRpbmdzL21lbW9yeS9tdGstc21pLWxhcmItcG9ydC5oIGIvaW5jbHVk
ZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXRrLXNtaS1sYXJiLXBvcnQuaA0KbmV3IGZpbGUgbW9kZSAx
MDA2NDQNCmluZGV4IDAwMDAwMDAwMDAwMC4uMmVjN2ZlNWNlNGU5DQotLS0gL2Rldi9udWxsDQor
KysgYi9pbmNsdWRlL2R0LWJpbmRpbmdzL21lbW9yeS9tdGstc21pLWxhcmItcG9ydC5oDQpAQCAt
MCwwICsxLDE1IEBADQorLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seSAq
Lw0KKy8qDQorICogQ29weXJpZ2h0IChjKSAyMDIwIE1lZGlhVGVrIEluYy4NCisgKiBBdXRob3I6
IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KKyAqLw0KKyNpZm5kZWYgX19EVFNfTVRL
X0lPTU1VX1BPUlRfSF8NCisjZGVmaW5lIF9fRFRTX01US19JT01NVV9QT1JUX0hfDQorDQorI2Rl
ZmluZSBNVEtfTEFSQl9OUl9NQVgJCQkxNg0KKw0KKyNkZWZpbmUgTVRLX000VV9JRChsYXJiLCBw
b3J0KQkJKCgobGFyYikgPDwgNSkgfCAocG9ydCkpDQorI2RlZmluZSBNVEtfTTRVX1RPX0xBUkIo
aWQpCQkoKChpZCkgPj4gNSkgJiAweGYpDQorI2RlZmluZSBNVEtfTTRVX1RPX1BPUlQoaWQpCQko
KGlkKSAmIDB4MWYpDQorDQorI2VuZGlmDQotLSANCjIuMTguMA0K

