Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34045C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 03:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DA05207DA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 03:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jyhh3iR2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgHMDcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 23:32:54 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:7438 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726578AbgHMDcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 23:32:52 -0400
X-UUID: 6cf0ec8961014ac19540170ac67b094d-20200813
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=GXyvs9gvhHEWr1UkIPbeOiv49/Wc3S/k2qDEZ2S1xYI=;
        b=jyhh3iR2ZpSIvxNkbT9EcJ8oZk9lkvrhSnqVbAz2nTpsrmyo0AdyGz8XOa6gjpmWFPBwbLhfUQmL/6D89scfB0FegeG7vogccqO3Uu4g/zAlOnC+eqnE0WjugKD1Gdza8BHM1IessAxGw9zoFvijMivs2AK90ZKRiHZU/xudcOE=;
X-UUID: 6cf0ec8961014ac19540170ac67b094d-20200813
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1170510967; Thu, 13 Aug 2020 11:32:47 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 13 Aug 2020 11:32:45 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 13 Aug 2020 11:32:45 +0800
From:   Neal Liu <neal.liu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Neal Liu <neal.liu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Subject: [PATCH v6] Add MediaTek MT6779 devapc driver
Date:   Thu, 13 Aug 2020 11:32:42 +0800
Message-ID: <1597289564-17030-1-git-send-email-neal.liu@mediatek.com>
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
cmRlciB0byBmaW5kIHRoZSBtdXJkZXJlci4NCg0KY2hhbmdlcyBzaW5jZSB2NToNCi0gcmVtb3Zl
IHJlZHVuZGFudCB3cml0ZSByZWcgb3BlcmF0aW9uLg0KLSB1c2Ugc3RhdGljIHZhcmlhYmxlIG9m
IHZpb19kYmdzIGluc3RlYWQuDQotIGFkZCBzdG9wX2RldmFwYygpIGlmIGRyaXZlciBpcyByZW1v
dmVkLg0KDQpjaGFuZ2VzIHNpbmNlIHY0Og0KLSByZWZhY3RvciBkYXRhIHN0cnVjdHVyZS4NCi0g
bWVyZ2UgdHdvIHNpbXBsZSBmdW5jdGlvbnMgaW50byBvbmUuDQotIHJlZmFjdG9yIHJlZ2lzdGVy
IHNldHRpbmcgdG8gcHJldmVudCB0b28gbWFueSBmdW5jdGlvbiBjYWxsIG92ZXJoZWFkLg0KDQpj
aGFuZ2VzIHNpbmNlIHYzOg0KLSByZXZpc2UgdmlvbGF0aW9uIGhhbmRsaW5nIGZsb3cgdG8gbWFr
ZSBpdCBtb3JlIGVhc2lseSB0byB1bmRlcnN0YW5kDQogIGhhcmR3YXJlIGJlaGF2aW9yLg0KLSBh
ZGQgbW9yZSBjb21tZW50cyB0byB1bmRlcnN0YW5kIGhvdyBoYXJkd2FyZSB3b3Jrcy4NCg0KY2hh
bmdlcyBzaW5jZSB2MjoNCi0gcGFzcyBwbGF0Zm9ybSBpbmZvIHRocm91Z2ggRFQgZGF0YS4NCi0g
cmVtb3ZlIHVubmVjZXNzYXJ5IGZ1bmN0aW9uLg0KLSByZW1vdmUgc2xhdmVfdHlwZSBiZWNhdXNl
IGl0IGFsd2F5cyBlcXVhbHMgdG8gMSBpbiBjdXJyZW50IHN1cHBvcnQgU29DLg0KLSB1c2Ugdmlv
X2lkeF9udW0gaW5zdHJlYWQgb2YgbGlzdCBhbGwgZGV2aWNlcycgaW5kZXguDQotIGFkZCBtb3Jl
IGNvbW1lbnRzIHRvIGRlc2NyaWJlIGhhcmR3YXJlIGJlaGF2aW9yLg0KDQpjaGFuZ2VzIHNpbmNl
IHYxOg0KLSBtb3ZlIFNvQyBzcGVjaWZpYyBwYXJ0IHRvIERUIGRhdGEuDQotIHJlbW92ZSB1bm5l
Y2Vzc2FyeSBib3VuZGFyeSBjaGVjay4NCi0gcmVtb3ZlIHVubmVjZXNzYXJ5IGRhdGEgdHlwZSBk
ZWNsYXJhdGlvbi4NCi0gdXNlIHJlYWRfcG9sbF90aW1lb3V0KCkgaW5zdHJlYWQgb2YgZm9yIGxv
b3AgcG9sbGluZy4NCi0gcmV2aXNlIGNvZGluZyBzdHlsZSBlbGVnYW50bHkuDQoNCg0KKioqIEJM
VVJCIEhFUkUgKioqDQoNCk5lYWwgTGl1ICgyKToNCiAgZHQtYmluZGluZ3M6IGRldmFwYzogYWRk
IGJpbmRpbmdzIGZvciBtdGstZGV2YXBjDQogIHNvYzogbWVkaWF0ZWs6IGFkZCBtdDY3NzkgZGV2
YXBjIGRyaXZlcg0KDQogLi4uL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9kZXZhcGMueWFtbCAgICAg
ICAgIHwgIDU4ICsrKysNCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9LY29uZmlnICAgICAgICAgICAg
ICAgICAgfCAgIDkgKw0KIGRyaXZlcnMvc29jL21lZGlhdGVrL01ha2VmaWxlICAgICAgICAgICAg
ICAgICB8ICAgMSArDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWRldmFwYy5jICAgICAgICAg
ICAgIHwgMzIwICsrKysrKysrKysrKysrKysrKw0KIDQgZmlsZXMgY2hhbmdlZCwgMzg4IGluc2Vy
dGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3NvYy9tZWRpYXRlay9kZXZhcGMueWFtbA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2
ZXJzL3NvYy9tZWRpYXRlay9tdGstZGV2YXBjLmMNCg0KLS0gDQoyLjE4LjANCg==

