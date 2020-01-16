Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B8FC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 02:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4B52081E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 02:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NDcmPLeS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbgAPCPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 21:15:20 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:40560 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729598AbgAPCPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 21:15:19 -0500
X-UUID: 28bcea15ec5743cebd1b0ef9dc5f3cc6-20200116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=itebPIuvSzJr5GaEJLbLuiRcsXbtJlr3jeWCPIKouLg=;
        b=NDcmPLeS4vxiBV+bNnaiIBLIyDooLmRfENmSdE0L2PHK0a66PMABxDUrq4ZcBMEaD2oaFT4G0uUfsIHmoomZn50LLzxikwL3l8zWBJkNYU6YWs9LBljXXT77VkJFvhtJWQomm1h2+L7cRhrzSX1a4i48B0TENV9x0C1VI5BzMbk=;
X-UUID: 28bcea15ec5743cebd1b0ef9dc5f3cc6-20200116
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 387514652; Thu, 16 Jan 2020 10:15:13 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 16 Jan
 2020 10:14:05 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Thu, 16 Jan 2020 10:14:17 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v9 0/5] add driver for "boe, tv101wum-nl6", "boe, tv101wum-n53", "auo, kd101n80-45na" and "auo, b101uan08.3" panels
Date:   Thu, 16 Jan 2020 10:15:06 +0800
Message-ID: <20200116021511.22675-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A0E5360FFACF32C65E5C1E5739A8C19C64DF2CF0A8C3537E6D2C6A9245318FA22000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB2ODoNCiAtIG1lcmdlIHRoZSBwYW5lbCBkb2N1bWVudHMgdG8gb25lLg0K
IC0gZGVsYXkgbW92ZSB0aGUgZHJtX3BhbmVsX29mX2JhY2tsaWdodCBhZnRlciBkcm1fcGFuZWxf
aW5pdA0KDQpDaGFuZ2VzIHNpbmNlIHY3Og0KIC0gYmFzZSBkcm0tbWlzYy1uZXh0IGJyYW5jaA0K
IC0gZml4IGRvY3VtZW50IHBhc3MgZHRfYmluZGluZ19jaGVjaw0KIC0gcmVtb3ZlIGJhY2tsaWdo
dCBmcm9tIHBhbmVsIGRyaXZlcg0KDQpDaGFuZ2VzIHNpbmNlIHY2Og0KIC0gZml4IGJvZV9wYW5l
bF9pbml0IGVyciB1bmluaXQuDQogLSBhZGp1c3QgdGhlIGRlbGF5IG9mIGJhY2tsaWdodCBvbi4N
Cg0KQ2hhbmdlcyBzaW5jZSB2NToNCiAtIGNvdmVydCB0aGUgZG9jdW1lbnRzIHRvIHlhbWwNCiAt
IGZpbmUgdHVuZSBib2UsIHR2MTAxd3VtLW41MyBwYW5lbCB2aWRlbyB0aW1pbmUNCg0KQ2hhbmdl
cyBzaW5jZSB2NDoNCiAtIGFkZCBhdW8sYjEwMXVhbjA4LjMgcGFuZWwgZm9yIHRoaXMgZHJpdmVy
Lg0KIC0gYWRkIGJvZSx0djEwMXd1bS1uNTMgcGFuZWwgZm9yIHRoaXMgZHJpdmVyLg0KDQpDaGFu
Z2VzIHNpbmNlIHYzOg0KIC0gcmVtb3ZlIGNoZWNrIGVuYWJsZV9ncGlvLg0KIC0gZmluZSB0dW5l
IHRoZSBhdW8sa2QxMDFuODAtNDVuYSBwYW5lbCdzIHBvd2VyIG9uIHRpbWluZy4NCg0KQ2hhbmdl
cyBzaW5jZSB2MjoNCiAtIGNvcnJlY3QgdGhlIHBhbmVsIHNpemUNCiAtIHJlbW92ZSBibGFuayBs
aW5lIGluIEtjb25maWcNCiAtIG1vdmUgYXVvLGtkMTAxbjgwLTQ1bmEgcGFuZWwgZHJpdmVyIGlu
IHRoaXMgc2VyaWVzLg0KDQpDaGFuZ2VzIHNpbmNlIHYxOg0KIC0gdXBkYXRlIHR5cG8gbmw2IC0+
IG4xNi4NCiAtIHVwZGF0ZSBuZXcgcGFuZWwgY29uZmlnIGFuZCBtYWtlZmlsZSBhcmUgYWRkZWQg
aW4gYWxwaGFiZXRpY2FsbHkgb3JkZXIuDQogLSBhZGQgdGhlIHBhbmVsIG1vZGUgYW5kIHBhbmVs
IGluZm8gaW4gZHJpdmVyIGRhdGEuDQogLSBtZXJnZSBhdW8sa2QxMDFuODAtNDVhIGFuZCBib2Us
dHYxMDF3dW0tbmw2IGluIG9uZSBkcml2ZXINCg0KSml0YW8gU2hpICg1KToNCiAgZHQtYmluZGlu
Z3M6IGRpc3BsYXk6IHBhbmVsOiBBZGQgYm9lIHR2MTAxd3VtLW4xNiBwYW5lbCBiaW5kaW5ncw0K
ICBkcm0vcGFuZWw6IHN1cHBvcnQgZm9yIGJvZSB0djEwMXd1bS1ubDYgd3V4Z2EgZHNpIHZpZGVv
IG1vZGUgcGFuZWwNCiAgZHJtL3BhbmVsOiBzdXBwb3J0IGZvciBhdW8sa2QxMDFuODAtNDVuYSB3
dXhnYSBkc2kgdmlkZW8gbW9kZSBwYW5lbA0KICBkcm0vcGFuZWw6IHN1cHBvcnQgZm9yIGJvZSx0
djEwMXd1bS1uNTMgd3V4Z2EgZHNpIHZpZGVvIG1vZGUgcGFuZWwNCiAgZHJtL3BhbmVsOiBzdXBw
b3J0IGZvciBhdW8sYjEwMXVhbjA4LjMgd3V4Z2EgZHNpIHZpZGVvIG1vZGUgcGFuZWwNCg0KIC4u
Li9kaXNwbGF5L3BhbmVsL2JvZSx0djEwMXd1bS1ubDYueWFtbCAgICAgICB8ICA4MSArKw0KIGRy
aXZlcnMvZ3B1L2RybS9wYW5lbC9LY29uZmlnICAgICAgICAgICAgICAgICB8ICAgOSArDQogZHJp
dmVycy9ncHUvZHJtL3BhbmVsL01ha2VmaWxlICAgICAgICAgICAgICAgIHwgICAxICsNCiAuLi4v
Z3B1L2RybS9wYW5lbC9wYW5lbC1ib2UtdHYxMDF3dW0tbmw2LmMgICAgfCA4NTQgKysrKysrKysr
KysrKysrKysrDQogNCBmaWxlcyBjaGFuZ2VkLCA5NDUgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBt
b2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9wYW5l
bC9ib2UsdHYxMDF3dW0tbmw2LnlhbWwNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUv
ZHJtL3BhbmVsL3BhbmVsLWJvZS10djEwMXd1bS1ubDYuYw0KDQotLSANCjIuMjEuMA0K

