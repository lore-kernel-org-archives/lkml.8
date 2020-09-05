Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F61C2BBD0
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84FB920760
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NgakWH3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgIEIME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 04:12:04 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:12803 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728302AbgIEIMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 04:12:02 -0400
X-UUID: 51bc26b3de0546df992b357a045c6a4f-20200905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Mlf2GwHop96saVmabqgU5HVRCsxvQNPFbWb6Z3AQyMg=;
        b=NgakWH3NuU6/NBsP8/Tn8kwfcz2suWUXVWtZDrKDu2yfh7/ubNqQmDoO34kQ7KnpbTdb+Wsv1Jlo5x31qM0vVDrm/71sy4cNMX8YQxU2MhaaeNidwJeaSBFzdrDBVa648CK9EsWcsHtkQNX+JRWn1rQ8hXOinM3oMCrUskgKjhY=;
X-UUID: 51bc26b3de0546df992b357a045c6a4f-20200905
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 342170188; Sat, 05 Sep 2020 16:11:57 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 5 Sep 2020 16:11:53 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 5 Sep 2020 16:11:54 +0800
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
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>
Subject: [PATCH v2 03/23] dt-bindings: memory: mediatek: Add a common larb-port header file
Date:   Sat, 5 Sep 2020 16:09:00 +0800
Message-ID: <20200905080920.13396-4-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200905080920.13396-1-yong.wu@mediatek.com>
References: <20200905080920.13396-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UHV0IGFsbCB0aGUgbWFjcm9zIGFib3V0IHNtaSBsYXJiL3BvcnQgdG9nZXRoZXJzLCB0aGlzIGlz
IGEgcHJlcGFyaW5nDQpwYXRjaCBmb3IgZXh0ZW5kaW5nIExBUkJfTlIgYW5kIGFkZGluZyBuZXcg
ZG9tLWlkIHN1cHBvcnQuDQoNClNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0
ZWsuY29tPg0KQWNrZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQotLS0NCiBp
bmNsdWRlL2R0LWJpbmRpbmdzL21lbW9yeS9tdDI3MTItbGFyYi1wb3J0LmggIHwgIDIgKy0NCiBp
bmNsdWRlL2R0LWJpbmRpbmdzL21lbW9yeS9tdDY3NzktbGFyYi1wb3J0LmggIHwgIDIgKy0NCiBp
bmNsdWRlL2R0LWJpbmRpbmdzL21lbW9yeS9tdDgxNzMtbGFyYi1wb3J0LmggIHwgIDIgKy0NCiBp
bmNsdWRlL2R0LWJpbmRpbmdzL21lbW9yeS9tdDgxODMtbGFyYi1wb3J0LmggIHwgIDIgKy0NCiBp
bmNsdWRlL2R0LWJpbmRpbmdzL21lbW9yeS9tdGstc21pLWxhcmItcG9ydC5oIHwgMTUgKysrKysr
KysrKysrKysrDQogNSBmaWxlcyBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9u
cygtKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2R0LWJpbmRpbmdzL21lbW9yeS9tdGst
c21pLWxhcmItcG9ydC5oDQoNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2R0LWJpbmRpbmdzL21lbW9y
eS9tdDI3MTItbGFyYi1wb3J0LmggYi9pbmNsdWRlL2R0LWJpbmRpbmdzL21lbW9yeS9tdDI3MTIt
bGFyYi1wb3J0LmgNCmluZGV4IDZmOWFhNzM0OWNlZi4uYjZiMmM2YmY0NDU5IDEwMDY0NA0KLS0t
IGEvaW5jbHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXQyNzEyLWxhcmItcG9ydC5oDQorKysgYi9p
bmNsdWRlL2R0LWJpbmRpbmdzL21lbW9yeS9tdDI3MTItbGFyYi1wb3J0LmgNCkBAIC02LDcgKzYs
NyBAQA0KICNpZm5kZWYgX19EVFNfSU9NTVVfUE9SVF9NVDI3MTJfSA0KICNkZWZpbmUgX19EVFNf
SU9NTVVfUE9SVF9NVDI3MTJfSA0KIA0KLSNkZWZpbmUgTVRLX000VV9JRChsYXJiLCBwb3J0KQkJ
KCgobGFyYikgPDwgNSkgfCAocG9ydCkpDQorI2luY2x1ZGUgPGR0LWJpbmRpbmdzL21lbW9yeS9t
dGstc21pLWxhcmItcG9ydC5oPg0KIA0KICNkZWZpbmUgTTRVX0xBUkIwX0lECQkJMA0KICNkZWZp
bmUgTTRVX0xBUkIxX0lECQkJMQ0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHQtYmluZGluZ3MvbWVt
b3J5L210Njc3OS1sYXJiLXBvcnQuaCBiL2luY2x1ZGUvZHQtYmluZGluZ3MvbWVtb3J5L210Njc3
OS1sYXJiLXBvcnQuaA0KaW5kZXggMmFkMDg5OWZiZjJmLi42MGY1N2Y1NDM5M2UgMTAwNjQ0DQot
LS0gYS9pbmNsdWRlL2R0LWJpbmRpbmdzL21lbW9yeS9tdDY3NzktbGFyYi1wb3J0LmgNCisrKyBi
L2luY2x1ZGUvZHQtYmluZGluZ3MvbWVtb3J5L210Njc3OS1sYXJiLXBvcnQuaA0KQEAgLTcsNyAr
Nyw3IEBADQogI2lmbmRlZiBfRFRTX0lPTU1VX1BPUlRfTVQ2Nzc5X0hfDQogI2RlZmluZSBfRFRT
X0lPTU1VX1BPUlRfTVQ2Nzc5X0hfDQogDQotI2RlZmluZSBNVEtfTTRVX0lEKGxhcmIsIHBvcnQp
CQkgKCgobGFyYikgPDwgNSkgfCAocG9ydCkpDQorI2luY2x1ZGUgPGR0LWJpbmRpbmdzL21lbW9y
eS9tdGstc21pLWxhcmItcG9ydC5oPg0KIA0KICNkZWZpbmUgTTRVX0xBUkIwX0lECQkJIDANCiAj
ZGVmaW5lIE00VV9MQVJCMV9JRAkJCSAxDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kdC1iaW5kaW5n
cy9tZW1vcnkvbXQ4MTczLWxhcmItcG9ydC5oIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkv
bXQ4MTczLWxhcmItcG9ydC5oDQppbmRleCA5ZjMxY2NmZWNhMjEuLmQ4Yzk5Yzk0NjA1MyAxMDA2
NDQNCi0tLSBhL2luY2x1ZGUvZHQtYmluZGluZ3MvbWVtb3J5L210ODE3My1sYXJiLXBvcnQuaA0K
KysrIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXQ4MTczLWxhcmItcG9ydC5oDQpAQCAt
Niw3ICs2LDcgQEANCiAjaWZuZGVmIF9fRFRTX0lPTU1VX1BPUlRfTVQ4MTczX0gNCiAjZGVmaW5l
IF9fRFRTX0lPTU1VX1BPUlRfTVQ4MTczX0gNCiANCi0jZGVmaW5lIE1US19NNFVfSUQobGFyYiwg
cG9ydCkJCSgoKGxhcmIpIDw8IDUpIHwgKHBvcnQpKQ0KKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9t
ZW1vcnkvbXRrLXNtaS1sYXJiLXBvcnQuaD4NCiANCiAjZGVmaW5lIE00VV9MQVJCMF9JRAkJCTAN
CiAjZGVmaW5lIE00VV9MQVJCMV9JRAkJCTENCmRpZmYgLS1naXQgYS9pbmNsdWRlL2R0LWJpbmRp
bmdzL21lbW9yeS9tdDgxODMtbGFyYi1wb3J0LmggYi9pbmNsdWRlL2R0LWJpbmRpbmdzL21lbW9y
eS9tdDgxODMtbGFyYi1wb3J0LmgNCmluZGV4IDJjNTc5ZjMwNTE2Mi4uMjc1YzA5NWE2ZmQ2IDEw
MDY0NA0KLS0tIGEvaW5jbHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXQ4MTgzLWxhcmItcG9ydC5o
DQorKysgYi9pbmNsdWRlL2R0LWJpbmRpbmdzL21lbW9yeS9tdDgxODMtbGFyYi1wb3J0LmgNCkBA
IC02LDcgKzYsNyBAQA0KICNpZm5kZWYgX19EVFNfSU9NTVVfUE9SVF9NVDgxODNfSA0KICNkZWZp
bmUgX19EVFNfSU9NTVVfUE9SVF9NVDgxODNfSA0KIA0KLSNkZWZpbmUgTVRLX000VV9JRChsYXJi
LCBwb3J0KQkJKCgobGFyYikgPDwgNSkgfCAocG9ydCkpDQorI2luY2x1ZGUgPGR0LWJpbmRpbmdz
L21lbW9yeS9tdGstc21pLWxhcmItcG9ydC5oPg0KIA0KICNkZWZpbmUgTTRVX0xBUkIwX0lECQkJ
MA0KICNkZWZpbmUgTTRVX0xBUkIxX0lECQkJMQ0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHQtYmlu
ZGluZ3MvbWVtb3J5L210ay1zbWktbGFyYi1wb3J0LmggYi9pbmNsdWRlL2R0LWJpbmRpbmdzL21l
bW9yeS9tdGstc21pLWxhcmItcG9ydC5oDQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAw
MDAwMDAwMDAwLi4yZWM3ZmU1Y2U0ZTkNCi0tLSAvZGV2L251bGwNCisrKyBiL2luY2x1ZGUvZHQt
YmluZGluZ3MvbWVtb3J5L210ay1zbWktbGFyYi1wb3J0LmgNCkBAIC0wLDAgKzEsMTUgQEANCisv
KiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5ICovDQorLyoNCisgKiBDb3B5
cmlnaHQgKGMpIDIwMjAgTWVkaWFUZWsgSW5jLg0KKyAqIEF1dGhvcjogWW9uZyBXdSA8eW9uZy53
dUBtZWRpYXRlay5jb20+DQorICovDQorI2lmbmRlZiBfX0RUU19NVEtfSU9NTVVfUE9SVF9IXw0K
KyNkZWZpbmUgX19EVFNfTVRLX0lPTU1VX1BPUlRfSF8NCisNCisjZGVmaW5lIE1US19MQVJCX05S
X01BWAkJCTE2DQorDQorI2RlZmluZSBNVEtfTTRVX0lEKGxhcmIsIHBvcnQpCQkoKChsYXJiKSA8
PCA1KSB8IChwb3J0KSkNCisjZGVmaW5lIE1US19NNFVfVE9fTEFSQihpZCkJCSgoKGlkKSA+PiA1
KSAmIDB4ZikNCisjZGVmaW5lIE1US19NNFVfVE9fUE9SVChpZCkJCSgoaWQpICYgMHgxZikNCisN
CisjZW5kaWYNCi0tIA0KMi4xOC4wDQo=

