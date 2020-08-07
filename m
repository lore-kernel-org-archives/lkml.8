Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4A2C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 02:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8585520855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 02:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GF4dRF6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgHGCWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 22:22:35 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:7755 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725947AbgHGCWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 22:22:34 -0400
X-UUID: 1973d46f6df949d78fdac95a21b9bbaa-20200807
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=BJiDnyuYO7RUiy76gfERJoEHx1JqO2dDx+agAtDeSyY=;
        b=GF4dRF6yVi1cxkbAQomtcVYHbSFjy5RiLIdpGz6GpFI2ZvQOBM5Xq2Z5wxsbcKnm1zPJDiUHnx4gwWO6m79WAB271Uj4pIH1gWZePbR68LjzjJKv4vdm4WH84DQG+3mZ2T6t5b49IDbNDct62vitC8ICn3HFxQf6D1iZZF9t4Ms=;
X-UUID: 1973d46f6df949d78fdac95a21b9bbaa-20200807
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 518054450; Fri, 07 Aug 2020 10:22:30 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 7 Aug 2020 10:22:29 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 7 Aug 2020 10:22:29 +0800
From:   Neal Liu <neal.liu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Neal Liu <neal.liu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Subject: [PATCH v5] Add MediaTek MT6779 devapc driver
Date:   Fri, 7 Aug 2020 10:22:26 +0800
Message-ID: <1596766948-29767-1-git-send-email-neal.liu@mediatek.com>
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
cmRlciB0byBmaW5kIHRoZSBtdXJkZXJlci4NCg0KY2hhbmdlcyBzaW5jZSB2NDoNCi0gcmVmYWN0
b3IgZGF0YSBzdHJ1Y3R1cmUuDQotIG1lcmdlIHR3byBzaW1wbGUgZnVuY3Rpb25zIGludG8gb25l
Lg0KLSByZWZhY3RvciByZWdpc3RlciBzZXR0aW5nIHRvIHByZXZlbnQgdG9vIG1hbnkgZnVuY3Rp
b24gY2FsbCBvdmVyaGVhZC4NCg0KY2hhbmdlcyBzaW5jZSB2MzoNCi0gcmV2aXNlIHZpb2xhdGlv
biBoYW5kbGluZyBmbG93IHRvIG1ha2UgaXQgbW9yZSBlYXNpbHkgdG8gdW5kZXJzdGFuZA0KICBo
YXJkd2FyZSBiZWhhdmlvci4NCi0gYWRkIG1vcmUgY29tbWVudHMgdG8gdW5kZXJzdGFuZCBob3cg
aGFyZHdhcmUgd29ya3MuDQoNCmNoYW5nZXMgc2luY2UgdjI6DQotIHBhc3MgcGxhdGZvcm0gaW5m
byB0aHJvdWdoIERUIGRhdGEuDQotIHJlbW92ZSB1bm5lY2Vzc2FyeSBmdW5jdGlvbi4NCi0gcmVt
b3ZlIHNsYXZlX3R5cGUgYmVjYXVzZSBpdCBhbHdheXMgZXF1YWxzIHRvIDEgaW4gY3VycmVudCBz
dXBwb3J0IFNvQy4NCi0gdXNlIHZpb19pZHhfbnVtIGluc3RyZWFkIG9mIGxpc3QgYWxsIGRldmlj
ZXMnIGluZGV4Lg0KLSBhZGQgbW9yZSBjb21tZW50cyB0byBkZXNjcmliZSBoYXJkd2FyZSBiZWhh
dmlvci4NCg0KY2hhbmdlcyBzaW5jZSB2MToNCi0gbW92ZSBTb0Mgc3BlY2lmaWMgcGFydCB0byBE
VCBkYXRhLg0KLSByZW1vdmUgdW5uZWNlc3NhcnkgYm91bmRhcnkgY2hlY2suDQotIHJlbW92ZSB1
bm5lY2Vzc2FyeSBkYXRhIHR5cGUgZGVjbGFyYXRpb24uDQotIHVzZSByZWFkX3BvbGxfdGltZW91
dCgpIGluc3RyZWFkIG9mIGZvciBsb29wIHBvbGxpbmcuDQotIHJldmlzZSBjb2Rpbmcgc3R5bGUg
ZWxlZ2FudGx5Lg0KDQoNCioqKiBCTFVSQiBIRVJFICoqKg0KDQpOZWFsIExpdSAoMik6DQogIGR0
LWJpbmRpbmdzOiBkZXZhcGM6IGFkZCBiaW5kaW5ncyBmb3IgbXRrLWRldmFwYw0KICBzb2M6IG1l
ZGlhdGVrOiBhZGQgbXQ2Nzc5IGRldmFwYyBkcml2ZXINCg0KIC4uLi9iaW5kaW5ncy9zb2MvbWVk
aWF0ZWsvZGV2YXBjLnlhbWwgICAgICAgICB8ICA1OCArKysrDQogZHJpdmVycy9zb2MvbWVkaWF0
ZWsvS2NvbmZpZyAgICAgICAgICAgICAgICAgIHwgICA5ICsNCiBkcml2ZXJzL3NvYy9tZWRpYXRl
ay9NYWtlZmlsZSAgICAgICAgICAgICAgICAgfCAgIDEgKw0KIGRyaXZlcnMvc29jL21lZGlhdGVr
L210ay1kZXZhcGMuYyAgICAgICAgICAgICB8IDMxNSArKysrKysrKysrKysrKysrKysNCiA0IGZp
bGVzIGNoYW5nZWQsIDM4MyBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvZGV2YXBjLnlhbWwNCiBj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWRldmFwYy5jDQoNCi0t
IA0KMi4xOC4wDQo=

