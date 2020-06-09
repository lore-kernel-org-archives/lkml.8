Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFADFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB5A3207ED
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="G6XwXEti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgFIKZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 06:25:57 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:18439 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728621AbgFIKYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 06:24:47 -0400
X-UUID: 623349c8f7b64ef59f86239c271b8de0-20200609
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=27GaRRMJgI8jXomyewf9EjW3IGOTuWZHXBF43R7U3x8=;
        b=G6XwXEti9LgKFhiMGH4u4AWjtlbSdrPhFOpaBWZjexEoz1S1qZonWg9E02aEW17gUUIIjRcsWNJLlbbTraFQx0kfrNc9JtJ/wTpnX9s7j5+HLeYz7zAnR+Qw5/KsCZob+2TAUxwlEkU2Usikm0K9gER5ccN3oBPEGMCrpJP/glc=;
X-UUID: 623349c8f7b64ef59f86239c271b8de0-20200609
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1834220365; Tue, 09 Jun 2020 18:24:33 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 9 Jun 2020 18:24:31 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 9 Jun 2020 18:24:30 +0800
From:   Neal Liu <neal.liu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Neal Liu <neal.liu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Subject: Add MediaTek MT6873 devapc driver
Date:   Tue, 9 Jun 2020 18:24:19 +0800
Message-ID: <1591698261-22639-1-git-send-email-neal.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlc2UgcGF0Y2ggc2VyaWVzIGludHJvZHVjZSBhIE1lZGlhVGVrIE1UNjg3MyBkZXZhcGMgZHJp
dmVyLg0KDQpNVDY4NzMgYnVzIGZyYWJyaWMgcHJvdmlkZXMgVHJ1c3Rab25lIHNlY3VyaXR5IHN1
cHBvcnQgYW5kIGRhdGENCnByb3RlY3Rpb24gdG8gcHJldmVudCBzbGF2ZXMgZnJvbSBiZWluZyBh
Y2Nlc3NlZCBieSB1bmV4cGVjdGVkDQptYXN0ZXJzLg0KVGhlIHNlY3VyaXR5IHZpb2xhdGlvbnMg
YXJlIGxvZ2dlZCBhbmQgc2VudCB0byB0aGUgcHJvY2Vzc29yIGZvcg0KZnVydGhlciBhbmFseXNp
cyBvciBjb3VudGVybWVhc3VyZXMuDQoNCkFueSBvY2N1cnJlbmNlIG9mIHNlY3VyaXR5IHZpb2xh
dGlvbiB3b3VsZCByYWlzZSBhbiBpbnRlcnJ1cHQsIGFuZA0KaXQgd2lsbCBiZSBoYW5kbGVkIGJ5
IGRldmFwYy1tdDY4NzMgZHJpdmVyLiBUaGUgdmlvbGF0aW9uDQppbmZvcm1hdGlvbiBpcyBwcmlu
dGVkIGluIG9yZGVyIHRvIGZpbmQgdGhlIG11cmRlcmVyLg0KDQoqKiogQkxVUkIgSEVSRSAqKioN
Cg0KTmVhbCBMaXUgKDIpOg0KICBkdC1iaW5kaW5nczogZGV2YXBjOiBhZGQgYmluZGluZ3MgZm9y
IGRldmFwYy1tdDY4NzMNCiAgc29jOiBtZWRpYXRlazogZGV2YXBjOiBhZGQgZGV2YXBjLW10Njg3
MyBkcml2ZXINCg0KIC4uLi9zb2MvbWVkaWF0ZWsvZGV2YXBjL2RldmFwYy1tdDY4NzMueWFtbCAg
ICB8ICAgNjEgKw0KIGRyaXZlcnMvc29jL21lZGlhdGVrL0tjb25maWcgICAgICAgICAgICAgICAg
ICB8ICAgIDYgKw0KIGRyaXZlcnMvc29jL21lZGlhdGVrL01ha2VmaWxlICAgICAgICAgICAgICAg
ICB8ICAgIDEgKw0KIGRyaXZlcnMvc29jL21lZGlhdGVrL2RldmFwYy9LY29uZmlnICAgICAgICAg
ICB8ICAgMjUgKw0KIGRyaXZlcnMvc29jL21lZGlhdGVrL2RldmFwYy9NYWtlZmlsZSAgICAgICAg
ICB8ICAgMTMgKw0KIGRyaXZlcnMvc29jL21lZGlhdGVrL2RldmFwYy9kZXZhcGMtbXQ2ODczLmMg
ICB8IDE3MzMgKysrKysrKysrKysrKysrKysNCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9kZXZhcGMv
ZGV2YXBjLW10Njg3My5oICAgfCAgMTMwICsrDQogLi4uL3NvYy9tZWRpYXRlay9kZXZhcGMvZGV2
YXBjLW10ay1tdWx0aS1hby5jIHwgMTAxOSArKysrKysrKysrDQogLi4uL3NvYy9tZWRpYXRlay9k
ZXZhcGMvZGV2YXBjLW10ay1tdWx0aS1hby5oIHwgIDE4MyArKw0KIGluY2x1ZGUvbGludXgvc29j
L21lZGlhdGVrL2RldmFwY19wdWJsaWMuaCAgICB8ICAgNDEgKw0KIDEwIGZpbGVzIGNoYW5nZWQs
IDMyMTIgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvc29jL21lZGlhdGVrL2RldmFwYy9kZXZhcGMtbXQ2ODczLnlhbWwN
CiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zb2MvbWVkaWF0ZWsvZGV2YXBjL0tjb25maWcN
CiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zb2MvbWVkaWF0ZWsvZGV2YXBjL01ha2VmaWxl
DQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc29jL21lZGlhdGVrL2RldmFwYy9kZXZhcGMt
bXQ2ODczLmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zb2MvbWVkaWF0ZWsvZGV2YXBj
L2RldmFwYy1tdDY4NzMuaA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3NvYy9tZWRpYXRl
ay9kZXZhcGMvZGV2YXBjLW10ay1tdWx0aS1hby5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZl
cnMvc29jL21lZGlhdGVrL2RldmFwYy9kZXZhcGMtbXRrLW11bHRpLWFvLmgNCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvZGV2YXBjX3B1YmxpYy5oDQoNCi0t
IA0KMi4xOC4wDQo=

