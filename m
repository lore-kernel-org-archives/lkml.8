Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A2DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 09:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53B26206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 09:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="usF3Ok2t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgGIJMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 05:12:32 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:29850 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726211AbgGIJMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 05:12:30 -0400
X-UUID: b6be88484c1a4597abb2f51f1f0c3ffd-20200709
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=5IFnrClxea+W0uhCfZ9UPEzqQzIug9UzC95zh8SU5JQ=;
        b=usF3Ok2tHqAwGjKUhhzk1fSPCATIsuT6dCZnfXHFZ/J3BcV/z6LsdGyRZJrawV3u6HojJbICp7/S79IrAq2I5bnlSQyJKpfMKely+Z0h1+6jd5plewC0uIE9INpyHkIB+i+UMLqXePAVZGwjpG91w2sKORJk66DCfqELwcFdaPM=;
X-UUID: b6be88484c1a4597abb2f51f1f0c3ffd-20200709
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 513061605; Thu, 09 Jul 2020 17:12:26 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 9 Jul 2020 17:12:15 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 9 Jul 2020 17:12:18 +0800
From:   Neal Liu <neal.liu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Neal Liu <neal.liu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Subject: [PATCH v2] Add MediaTek MT6779 devapc driver
Date:   Thu, 9 Jul 2020 17:12:05 +0800
Message-ID: <1594285927-1840-1-git-send-email-neal.liu@mediatek.com>
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
dXBwb3J0IGFuZCBkYXRhIHByb3RlY3Rpb24NCnRvIHByZXZlbnQgc2xhdmVzIGZyb20gYmVpbmcg
YWNjZXNzZWQgYnkgdW5leHBlY3RlZCBtYXN0ZXJzLg0KVGhlIHNlY3VyaXR5IHZpb2xhdGlvbiBp
cyBsb2dnZWQgYW5kIHNlbnQgdG8gdGhlIHByb2Nlc3NvciBmb3IgZnVydGhlcg0KYW5hbHlzaXMg
b3IgY291bnRlcm1lYXN1cmVzLg0KDQpBbnkgb2NjdXJyZW5jZSBvZiBzZWN1cml0eSB2aW9sYXRp
b24gd291bGQgcmFpc2UgYW4gaW50ZXJydXB0LCBhbmQgaXQgd2lsbA0KYmUgaGFuZGxlZCBieSBt
dGstZGV2YXBjIGRyaXZlci4NClRoZSB2aW9sYXRpb24gaW5mb3JtYXRpb24gaXMgcHJpbnRlZCBp
biBvcmRlciB0byBmaW5kIHRoZSBtdXJkZXJlci4NCg0KY2hhbmdlcyBzaW5jZSB2MToNCi0gbW92
ZSBTb0Mgc3BlY2lmaWMgcGFydCB0byBEVCBkYXRhLg0KLSByZW1vdmUgdW5uZWNlc3NhcnkgYm91
bmRhcnkgY2hlY2suDQotIHJlbW92ZSB1bm5lY2Vzc2FyeSBkYXRhIHR5cGUgZGVjbGFyYXRpb24u
DQotIHVzZSByZWFkX3BvbGxfdGltZW91dCgpIGluc3RyZWFkIG9mIGZvciBsb29wIHBvbGxpbmcu
DQotIHJldmlzZSBjb2Rpbmcgc3R5bGUgZWxlZ2FudGx5Lg0KDQoqKiogQkxVUkIgSEVSRSAqKioN
Cg0KTmVhbCBMaXUgKDIpOg0KICBkdC1iaW5kaW5nczogZGV2YXBjOiBhZGQgYmluZGluZ3MgZm9y
IG10ay1kZXZhcGMNCiAgc29jOiBtZWRpYXRlazogYWRkIG10ay1kZXZhcGMgZHJpdmVyDQoNCiAu
Li4vYmluZGluZ3Mvc29jL21lZGlhdGVrL2RldmFwYy55YW1sICAgICAgICAgfCAgODIgKysrDQog
ZHJpdmVycy9zb2MvbWVkaWF0ZWsvS2NvbmZpZyAgICAgICAgICAgICAgICAgIHwgICA5ICsNCiBk
cml2ZXJzL3NvYy9tZWRpYXRlay9NYWtlZmlsZSAgICAgICAgICAgICAgICAgfCAgIDEgKw0KIGRy
aXZlcnMvc29jL21lZGlhdGVrL210ay1kZXZhcGMuYyAgICAgICAgICAgICB8IDQ2NiArKysrKysr
KysrKysNCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstZGV2YXBjLmggICAgICAgICAgICAgfCA2
NzAgKysrKysrKysrKysrKysrKysrDQogNSBmaWxlcyBjaGFuZ2VkLCAxMjI4IGluc2VydGlvbnMo
KykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3NvYy9tZWRpYXRlay9kZXZhcGMueWFtbA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3Nv
Yy9tZWRpYXRlay9tdGstZGV2YXBjLmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zb2Mv
bWVkaWF0ZWsvbXRrLWRldmFwYy5oDQoNCi0tIA0KMi4xOC4wDQo=

