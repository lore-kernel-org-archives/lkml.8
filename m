Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107CBC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA585206D7
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kTymQ+L9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgCHKxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 06:53:12 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:47671 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726336AbgCHKxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 06:53:11 -0400
X-UUID: 8810286e56194621b429b9cdd83716b5-20200308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=GxTjmEm049B3GShhfkpoy+9dkylx+QGAxLN83d+jIDk=;
        b=kTymQ+L9EBf+fY2ch0yxLzKdQtoeYDu5kBBT0wFPqIT9y/uxN1MzaAGpUtl0/hbMPOSIENZm9NCk5Is0HSvYCSPW1ZYsriKiSOuxIdssgU2CEX2n5TH+wLWQ14VRWKpzQBryAtLfsSSkRTi8k872iWKTHjj/Jhh1woX3S93n5ew=;
X-UUID: 8810286e56194621b429b9cdd83716b5-20200308
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1927958431; Sun, 08 Mar 2020 18:52:59 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 8 Mar 2020 18:51:55 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 8 Mar 2020 18:52:58 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        HS Liao <hs.liao@mediatek.com>
Subject: [PATCH v5 00/13] support gce on mt6779 platform 
Date:   Sun, 8 Mar 2020 18:52:42 +0800
Message-ID: <1583664775-19382-1-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBzdXBwb3J0IGdjZSBvbiBtdDY3NzkgcGxhdGZvcm0uDQoNCkNoYW5nZSBzaW5j
ZSB2NDoNCi0gZG8gbm90IGNsZWFyIGRpc3AgZXZlbnQgYWdhaW4gaW4gZHJtIGRyaXZlcg0KLSBz
eW1ib2xpemUgdmFsdWUgMSB0byBqdW1wIHJlbGF0aXZlDQoNCkNoYW5nZSBzaW5jZSB2MzoNCi0g
cmVmaW5lIGNvZGUgZm9yIGxvY2FsIHZhcmlhYmxlIHVzYWdlDQotIHVzZSBjbWRxIGVycm9yIGNv
ZGUgdG8gY29uc2lzdGVudCB3aXRoIGN1cnJlbnQgZGVzaWduDQotIHJldHVybiBlcnJvciBkaXJl
Y3RseSBhZnRlciBzZW5kIGlmIGVycm9yIGNvZGUgcmV0dXJuDQotIGFsc28gbW9kaWZ5IGRybSBk
cml2ZXIgd2hpY2ggdXNlcyBjbWRxX3BrdF93ZmUgYXBpDQotIGFkZCBmaW5hbGl6ZSBpbiBkcm0g
ZHJpdmVyDQoNClsuLi4gc25pcCAuLi5dDQoNCg0KDQpEZW5uaXMgWUMgSHNpZWggKDEzKToNCiAg
ZHQtYmluZGluZzogZ2NlOiBhZGQgZ2NlIGhlYWRlciBmaWxlIGZvciBtdDY3NzkNCiAgbWFpbGJv
eDogY21kcTogdmFyaWFibGl6ZSBhZGRyZXNzIHNoaWZ0IGluIHBsYXRmb3JtDQogIG1haWxib3g6
IGNtZHE6IHN1cHBvcnQgbXQ2Nzc5IGdjZSBwbGF0Zm9ybSBkZWZpbml0aW9uDQogIG1haWxib3g6
IG1lZGlhdGVrOiBjbWRxOiBjbGVhciB0YXNrIGluIGNoYW5uZWwgYmVmb3JlIHNodXRkb3duDQog
IHNvYzogbWVkaWF0ZWs6IGNtZHE6IHJldHVybiBzZW5kIG1zZyBlcnJvciBjb2RlDQogIHNvYzog
bWVkaWF0ZWs6IGNtZHE6IGFkZCBhc3NpZ24gZnVuY3Rpb24NCiAgc29jOiBtZWRpYXRlazogY21k
cTogYWRkIHdyaXRlX3MgZnVuY3Rpb24NCiAgc29jOiBtZWRpYXRlazogY21kcTogYWRkIHJlYWRf
cyBmdW5jdGlvbg0KICBzb2M6IG1lZGlhdGVrOiBjbWRxOiBhZGQgd3JpdGVfcyB2YWx1ZSBmdW5j
dGlvbg0KICBzb2M6IG1lZGlhdGVrOiBjbWRxOiBleHBvcnQgZmluYWxpemUgZnVuY3Rpb24NCiAg
c29jOiBtZWRpYXRlazogY21kcTogYWRkIGp1bXAgZnVuY3Rpb24NCiAgc29jOiBtZWRpYXRlazog
Y21kcTogYWRkIGNsZWFyIG9wdGlvbiBpbiBjbWRxX3BrdF93ZmUgYXBpDQogIHNvYzogbWVkaWF0
ZWs6IGNtZHE6IGFkZCBzZXQgZXZlbnQgZnVuY3Rpb24NCg0KIC4uLi9kZXZpY2V0cmVlL2JpbmRp
bmdzL21haWxib3gvbXRrLWdjZS50eHQgICB8ICAgOCArLQ0KIGRyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHJtX2NydGMuYyAgICAgICB8ICAgMyArLQ0KIGRyaXZlcnMvbWFpbGJveC9tdGst
Y21kcS1tYWlsYm94LmMgICAgICAgICAgICB8IDEwMSArKysrKystLQ0KIGRyaXZlcnMvc29jL21l
ZGlhdGVrL210ay1jbWRxLWhlbHBlci5jICAgICAgICB8IDE0NCArKysrKysrKysrKy0NCiBpbmNs
dWRlL2R0LWJpbmRpbmdzL2djZS9tdDY3NzktZ2NlLmggICAgICAgICAgfCAyMjIgKysrKysrKysr
KysrKysrKysrDQogaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaCAgICAg
IHwgIDEwICstDQogaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCAgICAgICAg
IHwgIDk0ICsrKysrKystDQogNyBmaWxlcyBjaGFuZ2VkLCA1NDkgaW5zZXJ0aW9ucygrKSwgMzMg
ZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvZHQtYmluZGluZ3MvZ2Nl
L210Njc3OS1nY2UuaA0KDQotLSANCjIuMTguMA==

