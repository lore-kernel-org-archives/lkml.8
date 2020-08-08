Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A081BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C30D2177B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="r1TRE7aG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgHHCyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 22:54:50 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:5016 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726200AbgHHCyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 22:54:50 -0400
X-UUID: 9d98cbe1fc1546d9a5d2c6c601b4cf18-20200808
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=88Oan/DCv4ZxqhgZhz72479y9BC+k/u9ZQCcKP31Pt8=;
        b=r1TRE7aGbcUUsG4ssDNgCGBnDIh7ymTfIcpGcDKKiqeL02uWfTHga8S6eCoC0g2DtrmE+/JouPrQJs8UNUxTecGyPGrdfLB8nzPMAguasMERLTyOYSqgkkyUkeonbicfev8ytMUrDan2sm8wPjka9/Z9k5XS1PzTyGJAXCEOgTo=;
X-UUID: 9d98cbe1fc1546d9a5d2c6c601b4cf18-20200808
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 21590948; Sat, 08 Aug 2020 10:54:40 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 8 Aug 2020 10:54:39 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 8 Aug 2020 10:54:38 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [RESEND v7, PATCH 0/7] add drm support for MT8183
Date:   Sat, 8 Aug 2020 10:53:44 +0800
Message-ID: <1596855231-5782-1-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBzZXJpZXMgYXJlIGJhc2VkIG9uIDUuOC1yYzEgYW5kIHByb3ZpZGUgNyBwYXRjaA0KdG8g
c3VwcG9ydCBtZWRpYXRlayBTT0MgTVQ4MTgzDQoNCkNoYW5nZSBzaW5jZSB2Ng0KLSBtb3ZlIGRk
cCBjb21wb25lbnQgZGVmaW5lIGludG8gbXRrX21tc3lzLmgNCi0gYWRkIG1tc3lzIHByaXZhdGUg
ZGF0YSB0byBzdXBwb3J0IGRpZmZlcmVudCBpYyBwYXRoIGNvbm5lY3Rpb24NCi0gYWRkIG10ODE4
My1tbXN5cy5jIHRvIHN1cHBvcnQgODE4MyBwYXRoIGNvbm5lY3Rpb24NCi0gZml4IHJldmlld2Vk
IGlzc3VlIGluIHY2DQoNCkNoYW5nZSBzaW5jZSB2NQ0KLSBmaXggcmV2aWV3ZWQgaXNzdWUgaW4g
djUNCmJhc2UgaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlh
dGVrL2xpc3QvP3Nlcmllcz0yMTMyMTkNCg0KQ2hhbmdlIHNpbmNlIHY0DQotIGZpeCByZXZpZXdl
ZCBpc3N1ZSBpbiB2NA0KDQpDaGFuZ2Ugc2luY2UgdjMNCi0gZml4IHJldmlld2VkIGlzc3VlIGlu
IHYzDQotIGZpeCB0eXBlIGVycm9yIGluIHYzDQotIGZpeCBjb25mbGljdCB3aXRoIGlvbW11IHBh
dGNoDQoNCkNoYW5nZSBzaW5jZSB2Mg0KLSBmaXggcmV2aWV3ZWQgaXNzdWUgaW4gdjINCi0gYWRk
IG11dGV4IG5vZGUgaW50byBkdHMgZmlsZQ0KDQpDaGFuZ2VzIHNpbmNlIHYxOg0KLSBmaXggcmV2
aWV3ZWQgaXNzdWUgaW4gdjENCi0gYWRkIGR0cyBmb3IgbXQ4MTgzIGRpc3BsYXkgbm9kZXMNCi0g
YWRqdXN0IGRpc3BsYXkgY2xvY2sgY29udHJvbCBmbG93IGluIHBhdGNoIDIyDQotIGFkZCB2bWFw
IHN1cHBvcnQgZm9yIG1lZGlhdGVrIGRybSBpbiBwYXRjaCAyMw0KLSBmaXggcGFnZSBvZmZzZXQg
aXNzdWUgZm9yIG1tYXAgZnVuY3Rpb24gaW4gcGF0Y2ggMjQNCi0gZW5hYmxlIGFsbG93X2ZiX21v
ZGlmaWVycyBmb3IgbWVkaWF0ZWsgZHJtIGluIHBhdGNoIDI1DQoNCllvbmdxaWFuZyBOaXUgKDcp
Og0KICBkdC1iaW5kaW5nczogbWVkaWF0ZWs6IGFkZCByZG1hX2ZpZm9fc2l6ZSBkZXNjcmlwdGlv
biBmb3IgbXQ4MTgzDQogICAgZGlzcGxheQ0KICBkcm0vbWVkaWF0ZWs6IG1vdmUgZGRwIGNvbXBv
bmVudCBkZWZpbmUgaW50byBtdGtfbW1zeXMuaA0KICBtdGstbW1zeXM6IGFkZCBtbXN5cyBwcml2
YXRlIGRhdGENCiAgbXRrLW1tc3lzOiBhZGQgbXQ4MTgzIG1tc3lzIHN1cHBvcnQNCiAgZHJtL21l
ZGlhdGVrOiBhZGQgZmlmb19zaXplIGludG8gcmRtYSBwcml2YXRlIGRhdGENCiAgZHJtL21lZGlh
dGVrOiBhZGQgc3VwcG9ydCBmb3IgbWVkaWF0ZWsgU09DIE1UODE4Mw0KICBhcm02NDogZHRzOiBh
ZGQgZGlzcGxheSBub2RlcyBmb3IgbXQ4MTgzDQoNCiAuLi4vYmluZGluZ3MvZGlzcGxheS9tZWRp
YXRlay9tZWRpYXRlayxkaXNwLnR4dCAgICB8ICAxNCArKw0KIGFyY2gvYXJtNjQvYm9vdC9kdHMv
bWVkaWF0ZWsvbXQ4MTgzLmR0c2kgICAgICAgICAgIHwgIDk4ICsrKysrKysrDQogZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jICAgICAgICAgICAgfCAgMTggKysNCiBkcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfcmRtYS5jICAgICAgICAgICB8ICAyNSArLQ0K
IGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcC5jICAgICAgICAgICAgIHwgIDQ3
ICsrKysNCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5oICAgICAg
ICB8ICAzNCArLS0NCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYyAgICAg
ICAgICAgICB8ICA0MyArKysrDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvTWFrZWZpbGUgICAgICAg
ICAgICAgICAgICAgICAgfCAgIDEgKw0KIGRyaXZlcnMvc29jL21lZGlhdGVrL21tc3lzL01ha2Vm
aWxlICAgICAgICAgICAgICAgIHwgICAzICsNCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tbXN5cy9t
dDI3MDEtbW1zeXMuYyAgICAgICAgICB8IDI1MCArKysrKysrKysrKysrKysrKysrDQogZHJpdmVy
cy9zb2MvbWVkaWF0ZWsvbW1zeXMvbXQ4MTgzLW1tc3lzLmMgICAgICAgICAgfCAxNTQgKysrKysr
KysrKysrDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLW1tc3lzLmMgICAgICAgICAgICAgICAg
ICAgfCAyNzYgKysrKy0tLS0tLS0tLS0tLS0tLS0tDQogaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0
ZWsvbXRrLW1tc3lzLmggICAgICAgICAgICAgfCAgNDggKysrKw0KIDEzIGZpbGVzIGNoYW5nZWQs
IDc0OSBpbnNlcnRpb25zKCspLCAyNjIgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0
IGRyaXZlcnMvc29jL21lZGlhdGVrL21tc3lzL01ha2VmaWxlDQogY3JlYXRlIG1vZGUgMTAwNjQ0
IGRyaXZlcnMvc29jL21lZGlhdGVrL21tc3lzL210MjcwMS1tbXN5cy5jDQogY3JlYXRlIG1vZGUg
MTAwNjQ0IGRyaXZlcnMvc29jL21lZGlhdGVrL21tc3lzL210ODE4My1tbXN5cy5jDQoNCi0tIA0K
MS44LjEuMS5kaXJ0eQ0K

