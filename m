Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852F8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 02:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6540620781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 02:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="U4GnLzzB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387680AbgGWCEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 22:04:45 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:25158 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733288AbgGWCEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 22:04:45 -0400
X-UUID: 6d44cec7ecd54cb5b98e8b01c0b0980a-20200723
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=qFRLx/+6VxdIz+jDbGtfOLe8xjP4LdN/gpj4rcMmUbQ=;
        b=U4GnLzzBYuGpVTTf5/wG2PFZ/0d/W0V305H+5hbnJWDoWbbtFP4I86ds7fSgZFGMMU2OoDti4snB0+hKFk0g/CGUSAPZHttPMb7FfJUssY3oz55DLFcmagQVe/8B6BaSBqVp/pG6YVDGf3YEOBW+HqwzjSTnUOJbjeYYK8+GLhI=;
X-UUID: 6d44cec7ecd54cb5b98e8b01c0b0980a-20200723
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 76920452; Thu, 23 Jul 2020 10:04:41 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Jul 2020 10:04:40 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Jul 2020 10:04:36 +0800
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
Subject: [v7, PATCH 0/7] add drm support for MT8183
Date:   Thu, 23 Jul 2020 10:03:11 +0800
Message-ID: <1595469798-3824-1-git-send-email-yongqiang.niu@mediatek.com>
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
ZGlmaWVycyBmb3IgbWVkaWF0ZWsgZHJtIGluIHBhdGNoIDI1DQoNCg0KWW9uZ3FpYW5nIE5pdSAo
Nyk6DQogIGRybS9tZWRpYXRlazogbW92ZSBkZHAgY29tcG9uZW50IGRlZmluZSBpbnRvIG10a19t
bXN5cy5oDQogIG10ay1tbXN5czogYWRkIG1tc3lzIHByaXZhdGUgZGF0YQ0KICBtdGstbW1zeXM6
IGFkZCBtdDgxODMgbW1zeXMgc3VwcG9ydA0KICBkdC1iaW5kaW5nczogbWVkaWF0ZWs6IGFkZCBy
ZG1hX2ZpZm9fc2l6ZSBkZXNjcmlwdGlvbiBmb3IgbXQ4MTgzDQogICAgZGlzcGxheQ0KICBhcm02
NDogZHRzOiBhZGQgZGlzcGxheSBub2RlcyBmb3IgbXQ4MTgzDQogIGRybS9tZWRpYXRlazogYWRk
IGZpZm9fc2l6ZSBpbnRvIHJkbWEgcHJpdmF0ZSBkYXRhDQogIGRybS9tZWRpYXRlazogYWRkIHN1
cHBvcnQgZm9yIG1lZGlhdGVrIFNPQyBNVDgxODMNCg0KIC4uLi9iaW5kaW5ncy9kaXNwbGF5L21l
ZGlhdGVrL21lZGlhdGVrLGRpc3AudHh0ICAgIHwgIDE0ICsrDQogYXJjaC9hcm02NC9ib290L2R0
cy9tZWRpYXRlay9tdDgxODMuZHRzaSAgICAgICAgICAgfCAgOTggKysrKysrKysNCiBkcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMgICAgICAgICAgICB8ICAxOCArKw0KIGRy
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9yZG1hLmMgICAgICAgICAgIHwgIDI1ICst
DQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwLmMgICAgICAgICAgICAgfCAg
NDcgKysrKw0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmggICAg
ICAgIHwgIDM0ICstLQ0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jICAg
ICAgICAgICAgIHwgIDQzICsrKysNCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9NYWtlZmlsZSAgICAg
ICAgICAgICAgICAgICAgICB8ICAgMSArDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvbW1zeXMvTWFr
ZWZpbGUgICAgICAgICAgICAgICAgfCAgIDMgKw0KIGRyaXZlcnMvc29jL21lZGlhdGVrL21tc3lz
L210MjcwMS1tbXN5cy5jICAgICAgICAgIHwgMjUwICsrKysrKysrKysrKysrKysrKysNCiBkcml2
ZXJzL3NvYy9tZWRpYXRlay9tbXN5cy9tdDgxODMtbW1zeXMuYyAgICAgICAgICB8IDE2MSArKysr
KysrKysrKysNCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstbW1zeXMuYyAgICAgICAgICAgICAg
ICAgICB8IDI3NiArKysrLS0tLS0tLS0tLS0tLS0tLS0NCiBpbmNsdWRlL2xpbnV4L3NvYy9tZWRp
YXRlay9tdGstbW1zeXMuaCAgICAgICAgICAgICB8ICA0OCArKysrDQogMTMgZmlsZXMgY2hhbmdl
ZCwgNzU2IGluc2VydGlvbnMoKyksIDI2MiBkZWxldGlvbnMoLSkNCiBjcmVhdGUgbW9kZSAxMDA2
NDQgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbW1zeXMvTWFrZWZpbGUNCiBjcmVhdGUgbW9kZSAxMDA2
NDQgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbW1zeXMvbXQyNzAxLW1tc3lzLmMNCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbW1zeXMvbXQ4MTgzLW1tc3lzLmMNCg0KLS0g
DQoxLjguMS4xLmRpcnR5DQo=

