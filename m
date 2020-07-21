Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26E9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 651D02176B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RApvcY/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgGUD7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 23:59:42 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:45627 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726891AbgGUD7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 23:59:41 -0400
X-UUID: 3ef0bb19b11e4b569d01217b482781e4-20200721
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ys6ay/2EcFcP8lJaTqfWEnfQAVFGAQzaC3q8LwD4aFQ=;
        b=RApvcY/8AhUuFDvWtzebBz2VDj0OZOKtYT2I2npYhnBSkcRw6D/W/n/LLD02pX/yXT/qe9zPXo5BtBHwRkT8NdbEdZ2x0E+RVv8rbmJkL7ZdLMzObgAE193ZPXDQvnBLIOy8CZJNG+1HfJGSbod8wtoArS4kZf9igrrMAFVLDgw=;
X-UUID: 3ef0bb19b11e4b569d01217b482781e4-20200721
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 345339420; Tue, 21 Jul 2020 11:59:35 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 21 Jul 2020 11:59:33 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 21 Jul 2020 11:59:33 +0800
From:   Neal Liu <neal.liu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Neal Liu <neal.liu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Subject: [PATCH v3] Add MediaTek MT6779 devapc driver 
Date:   Tue, 21 Jul 2020 11:59:29 +0800
Message-ID: <1595303971-8793-1-git-send-email-neal.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
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
cmRlciB0byBmaW5kIHRoZSBtdXJkZXJlci4NCg0KY2hhbmdlcyBzaW5jZSB2MjoNCi0gcGFzcyBw
bGF0Zm9ybSBpbmZvIHRocm91Z2ggRFQgZGF0YS4NCi0gcmVtb3ZlIHVubmVjZXNzYXJ5IGZ1bmN0
aW9uLg0KLSByZW1vdmUgc2xhdmVfdHlwZSBiZWNhdXNlIGl0IGFsd2F5cyBlcXVhbHMgdG8gMSBp
biBjdXJyZW50IHN1cHBvcnQgU29DLg0KLSB1c2UgdmlvX2lkeF9udW0gaW5zdHJlYWQgb2YgbGlz
dCBhbGwgZGV2aWNlcycgaW5kZXguDQotIGFkZCBtb3JlIGNvbW1lbnRzIHRvIGRlc2NyaWJlIGhh
cmR3YXJlIGJlaGF2aW9yLg0KDQpjaGFuZ2VzIHNpbmNlIHYxOg0KLSBtb3ZlIFNvQyBzcGVjaWZp
YyBwYXJ0IHRvIERUIGRhdGEuDQotIHJlbW92ZSB1bm5lY2Vzc2FyeSBib3VuZGFyeSBjaGVjay4N
Ci0gcmVtb3ZlIHVubmVjZXNzYXJ5IGRhdGEgdHlwZSBkZWNsYXJhdGlvbi4NCi0gdXNlIHJlYWRf
cG9sbF90aW1lb3V0KCkgaW5zdHJlYWQgb2YgZm9yIGxvb3AgcG9sbGluZy4NCi0gcmV2aXNlIGNv
ZGluZyBzdHlsZSBlbGVnYW50bHkuDQoNCg0KKioqIEJMVVJCIEhFUkUgKioqDQoNCk5lYWwgTGl1
ICgyKToNCiAgZHQtYmluZGluZ3M6IGRldmFwYzogYWRkIGJpbmRpbmdzIGZvciBtdGstZGV2YXBj
DQogIHNvYzogbWVkaWF0ZWs6IGFkZCBtdGstZGV2YXBjIGRyaXZlcg0KDQogLi4uL2JpbmRpbmdz
L3NvYy9tZWRpYXRlay9kZXZhcGMueWFtbCAgICAgICAgIHwgIDU4ICsrKw0KIGRyaXZlcnMvc29j
L21lZGlhdGVrL0tjb25maWcgICAgICAgICAgICAgICAgICB8ICAgOSArDQogZHJpdmVycy9zb2Mv
bWVkaWF0ZWsvTWFrZWZpbGUgICAgICAgICAgICAgICAgIHwgICAxICsNCiBkcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstZGV2YXBjLmMgICAgICAgICAgICAgfCAzNzIgKysrKysrKysrKysrKysrKysr
DQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWRldmFwYy5oICAgICAgICAgICAgIHwgIDU0ICsr
Kw0KIDUgZmlsZXMgY2hhbmdlZCwgNDk0IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2
NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9kZXZhcGMu
eWFtbA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstZGV2YXBj
LmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWRldmFwYy5o
DQoNCi0tIA0KMi4xOC4wDQo=

