Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD10C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F5C02076E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hw9t9DIJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgG2ISR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 04:18:17 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:18683 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726336AbgG2ISQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 04:18:16 -0400
X-UUID: 92742cb7d6034be5bd4cd683b13ac811-20200729
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=zqAS3nqWwaOf1gLGTu7eXkZFRUc9KnRMoBc8x/BNB/Q=;
        b=hw9t9DIJBI+WRbeCFfS7aeTceU1YYHlEiVQeo4BSahSyIaI7Q9s7eQ+EunQi6R5cEmKfNEMZHlimgn7Vp98MAfQlDBNsXzUG87BWNfKMqszR9Vx32pWhRtZkEUzV+BGJFTvX6FH8iThKSKEgFu5+NEJ2cVvbuQW6LZW0kVJhiiQ=;
X-UUID: 92742cb7d6034be5bd4cd683b13ac811-20200729
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1222048983; Wed, 29 Jul 2020 16:18:13 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 29 Jul 2020 16:18:10 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 29 Jul 2020 16:18:10 +0800
From:   Neal Liu <neal.liu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Neal Liu <neal.liu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Subject: [PATCH v4] Add MediaTek MT6779 devapc driver
Date:   Wed, 29 Jul 2020 16:18:08 +0800
Message-ID: <1596010690-13178-1-git-send-email-neal.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 573D8C7EE0780E84BDFC8EEBE19C98008274176CD6A0AF13C469C2C807706FB52000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlc2UgcGF0Y2ggc2VyaWVzIGludHJvZHVjZSBhIE1lZGlhVGVrIE1UNjc3OSBkZXZhcGMgZHJp
dmVyLg0KDQpNZWRpYVRlayBidXMgZmFicmljIHByb3ZpZGVzIFRydXN0Wm9uZSBzZWN1cml0eSBz
dXBwb3J0IGFuZCBkYXRhIHByb3RlY3Rpb24gdG8gcHJldmVudCBzbGF2ZXMgZnJvbSBiZWluZyBh
Y2Nlc3NlZCBieSB1bmV4cGVjdGVkIG1hc3RlcnMuDQpUaGUgc2VjdXJpdHkgdmlvbGF0aW9uIGlz
IGxvZ2dlZCBhbmQgc2VudCB0byB0aGUgcHJvY2Vzc29yIGZvciBmdXJ0aGVyIGFuYWx5c2lzIG9y
IGNvdW50ZXJtZWFzdXJlcy4NCg0KQW55IG9jY3VycmVuY2Ugb2Ygc2VjdXJpdHkgdmlvbGF0aW9u
IHdvdWxkIHJhaXNlIGFuIGludGVycnVwdCwgYW5kIGl0IHdpbGwgYmUgaGFuZGxlZCBieSBtdGst
ZGV2YXBjIGRyaXZlci4NClRoZSB2aW9sYXRpb24gaW5mb3JtYXRpb24gaXMgcHJpbnRlZCBpbiBv
cmRlciB0byBmaW5kIHRoZSBtdXJkZXJlci4NCg0KY2hhbmdlcyBzaW5jZSB2MzoNCi0gcmV2aXNl
IHZpb2xhdGlvbiBoYW5kbGluZyBmbG93IHRvIG1ha2UgaXQgbW9yZSBlYXNpbHkgdG8gdW5kZXJz
dGFuZA0KICBoYXJkd2FyZSBiZWhhdmlvci4NCi0gYWRkIG1vcmUgY29tbWVudHMgdG8gdW5kZXJz
dGFuZCBob3cgaGFyZHdhcmUgd29ya3MuDQoNCmNoYW5nZXMgc2luY2UgdjI6DQotIHBhc3MgcGxh
dGZvcm0gaW5mbyB0aHJvdWdoIERUIGRhdGEuDQotIHJlbW92ZSB1bm5lY2Vzc2FyeSBmdW5jdGlv
bi4NCi0gcmVtb3ZlIHNsYXZlX3R5cGUgYmVjYXVzZSBpdCBhbHdheXMgZXF1YWxzIHRvIDEgaW4g
Y3VycmVudCBzdXBwb3J0IFNvQy4NCi0gdXNlIHZpb19pZHhfbnVtIGluc3RyZWFkIG9mIGxpc3Qg
YWxsIGRldmljZXMnIGluZGV4Lg0KLSBhZGQgbW9yZSBjb21tZW50cyB0byBkZXNjcmliZSBoYXJk
d2FyZSBiZWhhdmlvci4NCg0KY2hhbmdlcyBzaW5jZSB2MToNCi0gbW92ZSBTb0Mgc3BlY2lmaWMg
cGFydCB0byBEVCBkYXRhLg0KLSByZW1vdmUgdW5uZWNlc3NhcnkgYm91bmRhcnkgY2hlY2suDQot
IHJlbW92ZSB1bm5lY2Vzc2FyeSBkYXRhIHR5cGUgZGVjbGFyYXRpb24uDQotIHVzZSByZWFkX3Bv
bGxfdGltZW91dCgpIGluc3RyZWFkIG9mIGZvciBsb29wIHBvbGxpbmcuDQotIHJldmlzZSBjb2Rp
bmcgc3R5bGUgZWxlZ2FudGx5Lg0KDQoNCioqKiBCTFVSQiBIRVJFICoqKg0KDQpOZWFsIExpdSAo
Mik6DQogIGR0LWJpbmRpbmdzOiBkZXZhcGM6IGFkZCBiaW5kaW5ncyBmb3IgbXRrLWRldmFwYw0K
ICBzb2M6IG1lZGlhdGVrOiBhZGQgbXRrLWRldmFwYyBkcml2ZXINCg0KIC4uLi9iaW5kaW5ncy9z
b2MvbWVkaWF0ZWsvZGV2YXBjLnlhbWwgICAgICAgICB8ICA1OCArKysrDQogZHJpdmVycy9zb2Mv
bWVkaWF0ZWsvS2NvbmZpZyAgICAgICAgICAgICAgICAgIHwgICA5ICsNCiBkcml2ZXJzL3NvYy9t
ZWRpYXRlay9NYWtlZmlsZSAgICAgICAgICAgICAgICAgfCAgIDEgKw0KIGRyaXZlcnMvc29jL21l
ZGlhdGVrL210ay1kZXZhcGMuYyAgICAgICAgICAgICB8IDMyMyArKysrKysrKysrKysrKysrKysN
CiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstZGV2YXBjLmggICAgICAgICAgICAgfCAgNTQgKysr
DQogNSBmaWxlcyBjaGFuZ2VkLCA0NDUgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0
NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21lZGlhdGVrL2RldmFwYy55
YW1sDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1kZXZhcGMu
Yw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstZGV2YXBjLmgN
Cg0KLS0gDQoyLjE4LjANCg==

