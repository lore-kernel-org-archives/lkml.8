Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E809EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 03:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C67932076C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 03:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gx5ZakSe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgH0DH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 23:07:26 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:7663 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726798AbgH0DHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 23:07:25 -0400
X-UUID: 6ec58657da8a460d8763c7421fca6234-20200827
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=FtU44mDEUdVSDcs8ksi9dkzgI0uzEvYCzf0R73J3rdQ=;
        b=gx5ZakSeYZ98h1tHYnWx59z8ewgvoSOATHv+dbhE+b0dTNHFVVjhRE0lItt0BZxUWB2SQkdppCY21nqyOaLBDy+ulUxla0wkQScbtHAMDOylOrz5yq9tFajkcA1VH9epqw+x4AL5Ld9J6csM09VT1TRTLEVsZWaZDF7eZCeLDHI=;
X-UUID: 6ec58657da8a460d8763c7421fca6234-20200827
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1939479459; Thu, 27 Aug 2020 11:07:22 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 27 Aug 2020 11:06:38 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 27 Aug 2020 11:06:34 +0800
From:   Neal Liu <neal.liu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Neal Liu <neal.liu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Subject: [PATCH v7] Add MediaTek MT6779 devapc driver
Date:   Thu, 27 Aug 2020 11:06:31 +0800
Message-ID: <1598497593-15781-1-git-send-email-neal.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 42DE1FA7C2D2CBDD32C793D8FCED04030561614808926235ED5937E19CD7B4E92000:8
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
cmRlciB0byBmaW5kIHRoZSBtdXJkZXJlci4NCg0KY2hhbmdlcyBzaW5jZSB2NjoNCi0gcmVtb3Zl
IHVubmVjZXNzYXJ5IG1hc2svdW5tYXNrIG1vZHVsZSBpcnEgZHVyaW5nIElTUi4NCg0KY2hhbmdl
cyBzaW5jZSB2NToNCi0gcmVtb3ZlIHJlZHVuZGFudCB3cml0ZSByZWcgb3BlcmF0aW9uLg0KLSB1
c2Ugc3RhdGljIHZhcmlhYmxlIG9mIHZpb19kYmdzIGluc3RlYWQuDQotIGFkZCBzdG9wX2RldmFw
YygpIGlmIGRyaXZlciBpcyByZW1vdmVkLg0KDQpjaGFuZ2VzIHNpbmNlIHY0Og0KLSByZWZhY3Rv
ciBkYXRhIHN0cnVjdHVyZS4NCi0gbWVyZ2UgdHdvIHNpbXBsZSBmdW5jdGlvbnMgaW50byBvbmUu
DQotIHJlZmFjdG9yIHJlZ2lzdGVyIHNldHRpbmcgdG8gcHJldmVudCB0b28gbWFueSBmdW5jdGlv
biBjYWxsIG92ZXJoZWFkLg0KDQpjaGFuZ2VzIHNpbmNlIHYzOg0KLSByZXZpc2UgdmlvbGF0aW9u
IGhhbmRsaW5nIGZsb3cgdG8gbWFrZSBpdCBtb3JlIGVhc2lseSB0byB1bmRlcnN0YW5kDQogIGhh
cmR3YXJlIGJlaGF2aW9yLg0KLSBhZGQgbW9yZSBjb21tZW50cyB0byB1bmRlcnN0YW5kIGhvdyBo
YXJkd2FyZSB3b3Jrcy4NCg0KY2hhbmdlcyBzaW5jZSB2MjoNCi0gcGFzcyBwbGF0Zm9ybSBpbmZv
IHRocm91Z2ggRFQgZGF0YS4NCi0gcmVtb3ZlIHVubmVjZXNzYXJ5IGZ1bmN0aW9uLg0KLSByZW1v
dmUgc2xhdmVfdHlwZSBiZWNhdXNlIGl0IGFsd2F5cyBlcXVhbHMgdG8gMSBpbiBjdXJyZW50IHN1
cHBvcnQgU29DLg0KLSB1c2UgdmlvX2lkeF9udW0gaW5zdHJlYWQgb2YgbGlzdCBhbGwgZGV2aWNl
cycgaW5kZXguDQotIGFkZCBtb3JlIGNvbW1lbnRzIHRvIGRlc2NyaWJlIGhhcmR3YXJlIGJlaGF2
aW9yLg0KDQpjaGFuZ2VzIHNpbmNlIHYxOg0KLSBtb3ZlIFNvQyBzcGVjaWZpYyBwYXJ0IHRvIERU
IGRhdGEuDQotIHJlbW92ZSB1bm5lY2Vzc2FyeSBib3VuZGFyeSBjaGVjay4NCi0gcmVtb3ZlIHVu
bmVjZXNzYXJ5IGRhdGEgdHlwZSBkZWNsYXJhdGlvbi4NCi0gdXNlIHJlYWRfcG9sbF90aW1lb3V0
KCkgaW5zdHJlYWQgb2YgZm9yIGxvb3AgcG9sbGluZy4NCi0gcmV2aXNlIGNvZGluZyBzdHlsZSBl
bGVnYW50bHkuDQoNCg0KKioqIEJMVVJCIEhFUkUgKioqDQoNCk5lYWwgTGl1ICgyKToNCiAgZHQt
YmluZGluZ3M6IGRldmFwYzogYWRkIGJpbmRpbmdzIGZvciBtdGstZGV2YXBjDQogIHNvYzogbWVk
aWF0ZWs6IGFkZCBtdDY3NzkgZGV2YXBjIGRyaXZlcg0KDQogLi4uL2JpbmRpbmdzL3NvYy9tZWRp
YXRlay9kZXZhcGMueWFtbCAgICAgICAgIHwgIDU4ICsrKysNCiBkcml2ZXJzL3NvYy9tZWRpYXRl
ay9LY29uZmlnICAgICAgICAgICAgICAgICAgfCAgIDkgKw0KIGRyaXZlcnMvc29jL21lZGlhdGVr
L01ha2VmaWxlICAgICAgICAgICAgICAgICB8ICAgMSArDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsv
bXRrLWRldmFwYy5jICAgICAgICAgICAgIHwgMzA1ICsrKysrKysrKysrKysrKysrKw0KIDQgZmls
ZXMgY2hhbmdlZCwgMzczIGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9kZXZhcGMueWFtbA0KIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstZGV2YXBjLmMNCg0KLS0g
DQoyLjE4LjANCg==

