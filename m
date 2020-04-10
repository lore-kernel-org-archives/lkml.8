Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DC4C38A2D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 04:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA76B21556
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 04:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sNdv4wqF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgDJEdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 00:33:12 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:37498 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725844AbgDJEdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 00:33:11 -0400
X-UUID: a5164d5f471748adaa8ab44dccc8d29b-20200410
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=C7sVVd26PpyUXemamJ7aJZN4l0qAkmHAAOQgcekYw+c=;
        b=sNdv4wqFg9uhOd0lEcLXpPid8yDYhkgrvc/vBjRULoRMnIRb2h9DhooJiZTEPQiluh/T43lHBB6uxMe4oyqjkSnv7gQ7L8lsoSX2R+NLASAaxKu8avDe6vWvHvrEEBHnjWzs1uLbzRezId24rghlmAnYJqtlOoxBm4Xs22ESCwU=;
X-UUID: a5164d5f471748adaa8ab44dccc8d29b-20200410
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 201238961; Fri, 10 Apr 2020 12:32:53 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 10 Apr
 2020 12:32:50 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 10 Apr 2020 12:32:49 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, <huijuan.xie@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v5 0/4] Config mipi tx current and impedance
Date:   Fri, 10 Apr 2020 12:32:44 +0800
Message-ID: <20200410043248.114384-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 0F6119A2BA4805AE6F0F6CED4E26971655287E7DC5310E7440F285811C225A4C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB2NDoNCiAtIGFkZCBSZXZpZXdlZC1ieToNCiAtIG1vdmUgdGhlIGdldCB0
aGUgY2FsaWJyYXRpb24gZGF0YSBjb2RlIHRvIHByb2JlLg0KDQpDaGFuZ2VzIHNpbmNlIHYzOg0K
IC0gcmVmaW5lIGRyaXZlLXN0cmVuZ3RoLW1pY3JvYW1wIGFzIGZyb20gMzAwMCB0byA2MDAwLg0K
DQpDaGFuZ2VzIHNpbmNlIHYyOg0KIC0gZml4IHRoZSB0aXRsZSBvZiBjb21taXQgbWVzc2FnZS4N
CiAtIHJlbmFtZSBtaXBpdHgtY3VycmVudC1kcml2ZSB0byBkcml2ZS1zdHJlbmd0aC1taWNyb2Ft
cA0KDQpDaGFuZ2VzIHNpbmNlIHYxOg0KIC0gZml4IGNvZGluZyBzdHlsZS4NCiAtIGNoYW5nZSBt
dGtfbWlwaV90eF9jb25maWdfY2FsaWJyYXRpb25fZGF0YSgpIHRvIHZvaWQNCg0KSml0YW8gU2hp
ICg0KToNCiAgZHQtYmluZGluZ3M6IGRpc3BsYXk6IG1lZGlhdGVrOiBhZGQgcHJvcGVydHkgdG8g
Y29udHJvbCBtaXBpIHR4IGRyaXZlDQogICAgY3VycmVudA0KICBkdC1iaW5kaW5nczogZGlzcGxh
eTogbWVkaWF0ZWs6IGdldCBtaXBpdHggY2FsaWJyYXRpb24gZGF0YSBmcm9tIG52bWVtDQogIGRy
bS9tZWRpYXRlazogYWRkIHRoZSBtaXBpdHggZHJpdmluZyBjb250cm9sDQogIGRybS9tZWRpYXRl
azogY29uZmlnIG1pcGl0eCBpbXBlZGFuY2Ugd2l0aCBjYWxpYnJhdGlvbiBkYXRhDQoNCiAuLi4v
ZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkc2kudHh0ICAgICAgICAgfCAxMCArKysrDQogZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19taXBpX3R4LmMgICAgICAgIHwgNTQgKysrKysrKysr
KysrKysrKysrKw0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfbWlwaV90eC5oICAgICAg
ICB8ICA0ICsrDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19tdDgxODNfbWlwaV90eC5j
IHwgMjggKysrKysrKysrKw0KIDQgZmlsZXMgY2hhbmdlZCwgOTYgaW5zZXJ0aW9ucygrKQ0KDQot
LSANCjIuMjEuMA0K

