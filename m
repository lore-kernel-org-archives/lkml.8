Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7878C4361B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F085F22DA7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LVKhvWwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgHFJYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 05:24:33 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38463 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729132AbgHFJXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 05:23:33 -0400
X-UUID: c90b4b5441d24288acb143bcc4e49656-20200806
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=mvtOpKmyyI86lc99yfomx8qPrFB6iHZgh3PjEqxrAa8=;
        b=LVKhvWwaCXgo4L207xNBvICumCDrgPHVMHW7ggfgSgE53vSODWPAWrxeejSHKOI7Mh7GVJv4BpaAawiPr2LWV2E0g6BcKVNDFEDgWYkAEUST+Cj7AnOvPpGH11GMDY/uOsLuWHa6sMOCzgh/myWGYW7t1VBL1djIhY5L/rG993o=;
X-UUID: c90b4b5441d24288acb143bcc4e49656-20200806
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 550916183; Thu, 06 Aug 2020 17:22:01 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 6 Aug 2020 17:21:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 6 Aug 2020 17:21:58 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v17 00/12] Mediatek MT8183 scpsys support 
Date:   Thu, 6 Aug 2020 17:21:43 +0800
Message-ID: <1596705715-15320-1-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBzZXJpZXMgaXMgYmFzZWQgb24gdjUuOC1yYzENCg0KY2hhbmdlIHNpbmNlIHYxNjoNCi0g
SW50cm9kdWNlIGhpZXJhcmNoaWNhbCBzY3BzeXMgZGV2aWNlIG5vZGUgdG8gc2hvdyB0aGUgZGVw
ZW5kZW5jeSBiZXR3ZWVuIGVhY2ggcG93ZXIgZG9tYWluLg0KICBBbmQgY291bGQgYmUgbW9yZSBj
bGVhcmx5IHRvIGdyb3VwIHN1YnN5cyBjbG9ja3MgaW50byBwb3dlciBkb21haW4gc3ViIG5vZGUu
DQoNCmNoYW5nZSBzaW5jZSB2MTU6DQotIHJlbW92ZSB1bm5lZWRlZCBlcnJvciBsb2cgaW4gW1BB
VENIIDA2LzExXQ0KDQpjaGFuZ2VzIHNpbmNlIHYxNDoNCi0gZml4IGNvbW1pdCBtZXNzYWdlIHR5
cG8NCi0gdXNlIHByb3BlcnR5IG5hbWUgIm1lZGlhdGVrLHNtaSIgZm9yIHNtaSBwaGFuZGxlDQoN
CmNoYW5nZXMgc2luY2UgdjEzOg0KLSBkb2N1bWVudCBvcHRpb25hbCBwcm9wZXJ0eSAic21pLWNv
bW0iDQotIG1vdmUgZGVmaW5lcyBpbiBzY3BzeWMuaCB0byBtdGstc2Nwc3lzLmMgZGlyZWN0bHkN
Ci0gbWlub3IgY29kaW5nIHN5dGxlIGZpeGVzDQoNCmNoYW5nZSBzaW5jZSB2MTI6DQotIHNlcGFy
YXRlIHRoZSBmaXggb2YgY29tbWEgYXQgdGhlIGVuZCBpbnRvIGEgbmV3IHBhdGNoIFtQQVRDSCAw
OS8xMV0NCg0KY2hhbmdlcyBzaW5jZSB2MTE6DQotIHJlLW9yZGVyIHBhdGNoZXMgIlJlbW92ZSBp
bmZyYWNmZyBtaXNjIGRyaXZlciBzdXBwb3J0IiBhbmQgIkFkZCBtdWx0aXBsZSBzdGVwIGJ1cyBw
cm90ZWN0aW9uIg0KLSBhZGQgY2FwIE1US19TQ1BEX1NSQU1fSVNPIGZvciBleHRyYSBzcmFtIGNv
bnRyb2wNCi0gbWlub3IgY29kaW5nIHN5dGxlIGZpeGVzIGFuZCByZXdvcmQgY29tbWl0IG1lc3Nh
Z2VzDQoNCmNoYW5nZXMgc2luY2UgdjEwOg0KLSBzcXVhc2ggUEFUQ0ggMDQgYW5kIFBBVENIIDA2
IGluIHY5IGludG8gaXRzIHByZXZpb3VzIHBhdGNoDQotIGFkZCAiaWdub3JlX2Nscl9hY2siIGZv
ciBtdWx0aXBsZSBzdGVwIGJ1cyBwcm90ZWN0aW9uIGNvbnRyb2wgdG8gaGF2ZSBhIGNsZWFuIGRl
ZmluaXRpb24gb2YgcG93ZXIgZG9tYWluIGRhdGENCi0ga2VlcCB0aGUgbWFzayByZWdpc3RlciBi
aXQgZGVmaW5pdGlvbnMgYW5kIGRvIHRoZSBzYW1lIGZvciBNVDgxODMNCg0KY2hhbmdlcyBzaW5j
ZSB2OToNCi0gYWRkIG5ldyBQQVRDSCAwNCBhbmQgUEFUQ0ggMDYgdG8gcmVwbGFjZSBieSBuZXcg
bWV0aG9kIGZvciBhbGwgY29tcGF0aWJsZXMNCi0gYWRkIG5ldyBQQVRDSCAwNyB0byByZW1vdmUg
aW5mcmFjZmcgbWlzYyBkcml2ZXINCi0gbWlub3IgY29kaW5nIHN5dGxlIGZpeA0KDQpjaGFuZ2Vz
IHNpbmNlIHY3Og0KLSByZXdvcmQgaW4gYmluZGluZyBkb2N1bWVudCBbUEFUQ0ggMDIvMTRdDQot
IGZpeCBlcnJvciByZXR1cm4gY2hlY2tpbmcgYnVnIGluIHN1YnN5cyBjbG9jayBjb250cm9sIFtQ
QVRDSCAxMC8xNF0NCi0gYWRkIHBvd2VyIGRvbWFpbnMgcHJvcGVyaXR5IHRvIG1mZ2NmZyBwYXRj
aCBbUEFUQ0ggMTQvMTRdIGZyb20NCiAgaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRj
aC8xMTEyNjE5OS8NCg0KY2hhbmdlcyBzaW5jZSB2NjoNCi0gcmVtb3ZlIHRoZSBwYXRjaCBvZiBT
UERYIGxpY2Vuc2UgaWRlbnRpZmllciBiZWNhdXNlIGl0J3MgYWxyZWFkeSBmaXhlZA0KDQpjaGFu
Z2VzIHNpbmNlIHY1Og0KLSBmaXggZG9jdW1lbnRhdGlvbiBpbiBbUEFUQ0ggMDQvMTRdDQotIHJl
bW92ZSB1c2VsZXNzIHZhcmlhYmxlIGNoZWNraW5nIGFuZCByZXVzZSBBUEkgb2YgY2xvY2sgY29u
dHJvbCBpbiBbUEFUQ0ggMDYvMTRdDQotIGNvZGluZyBzdHlsZSBmaXggb2YgYnVzIHByb3RlY3Rp
b24gY29udHJvbCBpbiBbUEFUQ0ggMDgvMTRdDQotIGZpeCBuYW1pbmcgb2YgbmV3IGFkZGVkIGRh
dGEgaW4gW1BBVENIIDA5LzE0XQ0KLSBzbWFsbCByZWZhY3RvciBvZiBtdWx0aXBsZSBzdGVwIGJ1
cyBwcm90ZWN0aW9uIGNvbnRyb2wgaW4gW1BBVENIIDEwLzE0XQ0KDQpjaGFuZ2VzIHNpbmNlIHY0
Og0KLSBhZGQgcHJvcGVydHkgdG8gbXQ4MTgzIHNtaS1jb21tb24NCi0gc2VwZXJhdGUgcmVmYWN0
b3IgcGF0Y2hlcyBhbmQgbmV3IGFkZCBmdW5jdGlvbg0KLSBhZGQgcG93ZXIgY29udHJvbGxlciBk
ZXZpY2Ugbm9kZQ0KDQoNCldlaXlpIEx1ICgxMik6DQogIGR0LWJpbmRpbmdzOiBtZWRpYXRlazog
QWRkIHByb3BlcnR5IHRvIG10ODE4MyBzbWktY29tbW9uDQogIHNvYzogbWVkaWF0ZWs6IEFkZCBi
YXNpY19jbGtfbmFtZSB0byBzY3BfcG93ZXJfZGF0YQ0KICBzb2M6IG1lZGlhdGVrOiBSZW1vdmUg
aW5mcmFjZmcgbWlzYyBkcml2ZXIgc3VwcG9ydA0KICBzb2M6IG1lZGlhdGVrOiBBZGQgbXVsdGlw
bGUgc3RlcCBidXMgcHJvdGVjdGlvbiBjb250cm9sDQogIGR0LWJpbmRpbmdzOiBzb2M6IEFkZCBN
VDgxODMgcG93ZXIgZHQtYmluZGluZ3MNCiAgc29jOiBtZWRpYXRlazogQWRkIHN1cHBvcnQgZm9y
IGhpZXJhcmNoaWNhbCBzY3BzeXMgZGV2aWNlIG5vZGUNCiAgc29jOiBtZWRpYXRlazogQWRkIHN1
YnN5cyBjbG9jayBjb250cm9sIGZvciBidXMgcHJvdGVjdGlvbg0KICBzb2M6IG1lZGlhdGVrOiBB
ZGQgZXh0cmEgc3JhbSBjb250cm9sDQogIHNvYzogbWVkaWF0ZWs6IEFkZCBNVDgxODMgc2Nwc3lz
IHN1cHBvcnQNCiAgc29jOiBtZWRpYXRlazogQWRkIGEgY29tbWEgYXQgdGhlIGVuZA0KICBhcm02
NDogZHRzOiBBZGQgcG93ZXIgY29udHJvbGxlciBkZXZpY2Ugbm9kZSBvZiBNVDgxODMNCiAgYXJt
NjQ6IGR0czogQWRkIHBvd2VyLWRvbWFpbnMgcHJvcGVydHkgdG8gbWZnY2ZnDQoNCiAuLi4vbWVk
aWF0ZWssc21pLWNvbW1vbi50eHQgICAgICAgICAgICAgICAgICAgfCAgIDIgKy0NCiAuLi4vYmlu
ZGluZ3Mvc29jL21lZGlhdGVrL3NjcHN5cy50eHQgICAgICAgICAgfCAgODEgKy0NCiBhcmNoL2Fy
bTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4My5kdHNpICAgICAgfCAxMjQgKysrDQogZHJpdmVy
cy9zb2MvbWVkaWF0ZWsvS2NvbmZpZyAgICAgICAgICAgICAgICAgIHwgIDEwIC0NCiBkcml2ZXJz
L3NvYy9tZWRpYXRlay9NYWtlZmlsZSAgICAgICAgICAgICAgICAgfCAgIDEgLQ0KIGRyaXZlcnMv
c29jL21lZGlhdGVrL210ay1pbmZyYWNmZy5jICAgICAgICAgICB8ICA3OSAtLQ0KIGRyaXZlcnMv
c29jL21lZGlhdGVrL210ay1zY3BzeXMuYyAgICAgICAgICAgICB8IDc3MCArKysrKysrKysrKysr
Ky0tLS0NCiBpbmNsdWRlL2R0LWJpbmRpbmdzL3Bvd2VyL210ODE4My1wb3dlci5oICAgICAgfCAg
MjYgKw0KIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL2luZnJhY2ZnLmggICAgICAgICB8ICAz
OSAtDQogOSBmaWxlcyBjaGFuZ2VkLCA4NDUgaW5zZXJ0aW9ucygrKSwgMjg3IGRlbGV0aW9ucygt
KQ0KIGRlbGV0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstaW5mcmFjZmcu
Yw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2R0LWJpbmRpbmdzL3Bvd2VyL210ODE4My1w
b3dlci5oDQogZGVsZXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL2lu
ZnJhY2ZnLmgNCg==

