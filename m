Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48427C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 04:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2403120760
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 04:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QVBAAvvG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgGCEnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 00:43:15 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:61471 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726338AbgGCEnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 00:43:02 -0400
X-UUID: 1e56999a3aa64cda8dfcab172a941c5f-20200703
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=bFqhdCEFHxkA9BDKvdFV8c0wonzKEvyXeaUj1A2ESm8=;
        b=QVBAAvvGWXSOpB9bY5G/HG0IqTwGJYg+DQqbKVYguekmveVTh2ANvRWNH716NbT9vdAxhucHQY6m698DrTPK7bkfH2J+27nQ+VWlBntB659rPJQnG7yKGRXsRyVaTh4DFSpwafHgo1xw3g6EHt4lG8zZ/8bnWq0FO2KPzvqjXf0=;
X-UUID: 1e56999a3aa64cda8dfcab172a941c5f-20200703
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 985944469; Fri, 03 Jul 2020 12:42:58 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 3 Jul 2020 12:42:55 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 3 Jul 2020 12:42:50 +0800
From:   Chao Hao <chao.hao@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>,
        FY Yang <fy.yang@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
        TH Yang <th.yang@mediatek.com>
Subject: [PATCH v6 10/10] iommu/mediatek: Add mt6779 basic support
Date:   Fri, 3 Jul 2020 12:41:27 +0800
Message-ID: <20200703044127.27438-11-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200703044127.27438-1-chao.hao@mediatek.com>
References: <20200703044127.27438-1-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F133EF2A5C1FDC6746AFE8F98A49AE6448359913DAF5042E5AA3F203A20E76882000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MS4gU3RhcnQgZnJvbSBtdDY3NzksIElOVkxEVF9TRUwgbW92ZSB0byBvZmZzZXQ9MHgyYywgc28g
d2UgYWRkDQogICBSRUdfTU1VX0lOVl9TRUxfR0VOMiBkZWZpbml0aW9uIGFuZCBtdDY3NzkgdXNl
cyBpdC4NCjIuIEFkZCBtdDY3NzlfZGF0YSB0byBzdXBwb3J0IG1tX2lvbW11IEhXIGluaXQuDQoN
CkNjOiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NClNpZ25lZC1vZmYtYnk6IENoYW8g
SGFvIDxjaGFvLmhhb0BtZWRpYXRlay5jb20+DQpSZXZpZXdlZC1ieTogTWF0dGhpYXMgQnJ1Z2dl
ciA8bWF0dGhpYXMuYmdnQGdtYWlsLmNvbT4NCi0tLQ0KIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11
LmMgfCA5ICsrKysrKysrKw0KIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmggfCAxICsNCiAyIGZp
bGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9t
bXUvbXRrX2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQppbmRleCBhODE2MDMw
ZDAwZjEuLjU5ZTVhNjJhMzRkYiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11
LmMNCisrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCkBAIC0zNyw2ICszNyw3IEBADQog
I2RlZmluZSBSRUdfTU1VX0lOVkxEX1NUQVJUX0EJCQkweDAyNA0KICNkZWZpbmUgUkVHX01NVV9J
TlZMRF9FTkRfQQkJCTB4MDI4DQogDQorI2RlZmluZSBSRUdfTU1VX0lOVl9TRUxfR0VOMgkJCTB4
MDJjDQogI2RlZmluZSBSRUdfTU1VX0lOVl9TRUxfR0VOMQkJCTB4MDM4DQogI2RlZmluZSBGX0lO
VkxEX0VOMAkJCQlCSVQoMCkNCiAjZGVmaW5lIEZfSU5WTERfRU4xCQkJCUJJVCgxKQ0KQEAgLTgw
OCw2ICs4MDksMTMgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10
MjcxMl9kYXRhID0gew0KIAkubGFyYmlkX3JlbWFwID0ge3swfSwgezF9LCB7Mn0sIHszfSwgezR9
LCB7NX0sIHs2fSwgezd9fSwNCiB9Ow0KIA0KK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11
X3BsYXRfZGF0YSBtdDY3NzlfZGF0YSA9IHsNCisJLm00dV9wbGF0ICAgICAgPSBNNFVfTVQ2Nzc5
LA0KKwkuZmxhZ3MgICAgICAgICA9IEhBU19TVUJfQ09NTSB8IE9VVF9PUkRFUl9XUl9FTiB8IFdS
X1RIUk9UX0VOLA0KKwkuaW52X3NlbF9yZWcgICA9IFJFR19NTVVfSU5WX1NFTF9HRU4yLA0KKwku
bGFyYmlkX3JlbWFwICA9IHt7MH0sIHsxfSwgezJ9LCB7M30sIHs1fSwgezcsIDh9LCB7MTB9LCB7
OX19LA0KK307DQorDQogc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10
ODE3M19kYXRhID0gew0KIAkubTR1X3BsYXQgICAgID0gTTRVX01UODE3MywNCiAJLmZsYWdzCSAg
ICAgID0gSEFTXzRHQl9NT0RFIHwgSEFTX0JDTEsgfCBSRVNFVF9BWEksDQpAQCAtODI0LDYgKzgz
Miw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBtdDgxODNfZGF0
YSA9IHsNCiANCiBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdGtfaW9tbXVfb2Zf
aWRzW10gPSB7DQogCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQyNzEyLW00dSIsIC5kYXRh
ID0gJm10MjcxMl9kYXRhfSwNCisJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDY3NzktbTR1
IiwgLmRhdGEgPSAmbXQ2Nzc5X2RhdGF9LA0KIAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10
ODE3My1tNHUiLCAuZGF0YSA9ICZtdDgxNzNfZGF0YX0sDQogCXsgLmNvbXBhdGlibGUgPSAibWVk
aWF0ZWssbXQ4MTgzLW00dSIsIC5kYXRhID0gJm10ODE4M19kYXRhfSwNCiAJe30NCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5oIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUu
aA0KaW5kZXggMzFlZGQwNWUyZWIxLi4yMTQ4OTg1NzgwMjYgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L2lvbW11L210a19pb21tdS5oDQorKysgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQpAQCAt
MzcsNiArMzcsNyBAQCBzdHJ1Y3QgbXRrX2lvbW11X3N1c3BlbmRfcmVnIHsNCiBlbnVtIG10a19p
b21tdV9wbGF0IHsNCiAJTTRVX01UMjcwMSwNCiAJTTRVX01UMjcxMiwNCisJTTRVX01UNjc3OSwN
CiAJTTRVX01UODE3MywNCiAJTTRVX01UODE4MywNCiB9Ow0KLS0gDQoyLjE4LjANCg==

