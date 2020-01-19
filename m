Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A84DC32771
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 01:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169FC20728
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 01:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oqdNAKTT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgASBp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 20:45:59 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:9492 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727083AbgASBp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 20:45:59 -0500
X-UUID: 2603842213334575b64d4aa0de63fb04-20200119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=4JlHLg4Phwr6WsYV0dJ5DBcmz6cLa0xtV+qgrOrXuPg=;
        b=oqdNAKTTdVvnStiT7bJGTsw176l+poq7cYOCgsoTTU7HcKdBtsk8dWQOEmONzwy8fbrJIZc3TlYeSy9M9ZGpP+MgaMhy4txpXhFTGcf+n9Y5NXtxOa48WmxjH8f7vzooUAgqqL6Y47vsqjNG0HpT9+IR/z5adIS3jJmeMnke/nk=;
X-UUID: 2603842213334575b64d4aa0de63fb04-20200119
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1085176361; Sun, 19 Jan 2020 09:45:53 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sun, 19 Jan
 2020 09:42:19 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Sun, 19 Jan 2020 09:44:42 +0800
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
Subject: [PATCH v10 0/5] add driver for "boe, tv101wum-nl6", "boe, tv101wum-n53", "auo, kd101n80-45na" and "auo, b101uan08.3" panels
Date:   Sun, 19 Jan 2020 09:45:36 +0800
Message-ID: <20200119014541.64273-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 6ADEAF3004F9CA4334575EEC18EA85205F17AA9B5373BADE705233881CABA7832000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB2OToNCiAtIHJlbW92ZSBSb2IgZnJvbSBtYWludGFpbmVycyBpbiBib2Us
dHYxMDF3dW0tbmw2LnlhbWwNCg0KQ2hhbmdlcyBzaW5jZSB2ODoNCiAtIG1lcmdlIHRoZSBwYW5l
bCBkb2N1bWVudHMgdG8gb25lLg0KIC0gZGVsYXkgbW92ZSB0aGUgZHJtX3BhbmVsX29mX2JhY2ts
aWdodCBhZnRlciBkcm1fcGFuZWxfaW5pdA0KDQpDaGFuZ2VzIHNpbmNlIHY3Og0KIC0gYmFzZSBk
cm0tbWlzYy1uZXh0IGJyYW5jaA0KIC0gZml4IGRvY3VtZW50IHBhc3MgZHRfYmluZGluZ19jaGVj
aw0KIC0gcmVtb3ZlIGJhY2tsaWdodCBmcm9tIHBhbmVsIGRyaXZlcg0KDQpDaGFuZ2VzIHNpbmNl
IHY2Og0KIC0gZml4IGJvZV9wYW5lbF9pbml0IGVyciB1bmluaXQuDQogLSBhZGp1c3QgdGhlIGRl
bGF5IG9mIGJhY2tsaWdodCBvbi4NCg0KQ2hhbmdlcyBzaW5jZSB2NToNCiAtIGNvdmVydCB0aGUg
ZG9jdW1lbnRzIHRvIHlhbWwNCiAtIGZpbmUgdHVuZSBib2UsIHR2MTAxd3VtLW41MyBwYW5lbCB2
aWRlbyB0aW1pbmUNCg0KQ2hhbmdlcyBzaW5jZSB2NDoNCiAtIGFkZCBhdW8sYjEwMXVhbjA4LjMg
cGFuZWwgZm9yIHRoaXMgZHJpdmVyLg0KIC0gYWRkIGJvZSx0djEwMXd1bS1uNTMgcGFuZWwgZm9y
IHRoaXMgZHJpdmVyLg0KDQpDaGFuZ2VzIHNpbmNlIHYzOg0KIC0gcmVtb3ZlIGNoZWNrIGVuYWJs
ZV9ncGlvLg0KIC0gZmluZSB0dW5lIHRoZSBhdW8sa2QxMDFuODAtNDVuYSBwYW5lbCdzIHBvd2Vy
IG9uIHRpbWluZy4NCg0KQ2hhbmdlcyBzaW5jZSB2MjoNCiAtIGNvcnJlY3QgdGhlIHBhbmVsIHNp
emUNCiAtIHJlbW92ZSBibGFuayBsaW5lIGluIEtjb25maWcNCiAtIG1vdmUgYXVvLGtkMTAxbjgw
LTQ1bmEgcGFuZWwgZHJpdmVyIGluIHRoaXMgc2VyaWVzLg0KDQpDaGFuZ2VzIHNpbmNlIHYxOg0K
IC0gdXBkYXRlIHR5cG8gbmw2IC0+IG4xNi4NCiAtIHVwZGF0ZSBuZXcgcGFuZWwgY29uZmlnIGFu
ZCBtYWtlZmlsZSBhcmUgYWRkZWQgaW4gYWxwaGFiZXRpY2FsbHkgb3JkZXIuDQogLSBhZGQgdGhl
IHBhbmVsIG1vZGUgYW5kIHBhbmVsIGluZm8gaW4gZHJpdmVyIGRhdGEuDQogLSBtZXJnZSBhdW8s
a2QxMDFuODAtNDVhIGFuZCBib2UsdHYxMDF3dW0tbmw2IGluIG9uZSBkcml2ZXINCg0KSml0YW8g
U2hpICg1KToNCiAgZHQtYmluZGluZ3M6IGRpc3BsYXk6IHBhbmVsOiBBZGQgYm9lIHR2MTAxd3Vt
LW4xNiBwYW5lbCBiaW5kaW5ncw0KICBkcm0vcGFuZWw6IHN1cHBvcnQgZm9yIGJvZSB0djEwMXd1
bS1ubDYgd3V4Z2EgZHNpIHZpZGVvIG1vZGUgcGFuZWwNCiAgZHJtL3BhbmVsOiBzdXBwb3J0IGZv
ciBhdW8sIGtkMTAxbjgwLTQ1bmEgd3V4Z2EgZHNpIHZpZGVvIG1vZGUgcGFuZWwNCiAgZHJtL3Bh
bmVsOiBzdXBwb3J0IGZvciBib2UsIHR2MTAxd3VtLW41MyB3dXhnYSBkc2kgdmlkZW8gbW9kZSBw
YW5lbA0KICBkcm0vcGFuZWw6IHN1cHBvcnQgZm9yIGF1bywgYjEwMXVhbjA4LjMgd3V4Z2EgZHNp
IHZpZGVvIG1vZGUgcGFuZWwNCg0KIC4uLi9kaXNwbGF5L3BhbmVsL2JvZSx0djEwMXd1bS1ubDYu
eWFtbCAgICAgICB8ICA4MCArKw0KIGRyaXZlcnMvZ3B1L2RybS9wYW5lbC9LY29uZmlnICAgICAg
ICAgICAgICAgICB8ICAgOSArDQogZHJpdmVycy9ncHUvZHJtL3BhbmVsL01ha2VmaWxlICAgICAg
ICAgICAgICAgIHwgICAxICsNCiAuLi4vZ3B1L2RybS9wYW5lbC9wYW5lbC1ib2UtdHYxMDF3dW0t
bmw2LmMgICAgfCA4NTQgKysrKysrKysrKysrKysrKysrDQogNCBmaWxlcyBjaGFuZ2VkLCA5NDQg
aW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvZGlzcGxheS9wYW5lbC9ib2UsdHYxMDF3dW0tbmw2LnlhbWwNCiBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL3BhbmVsL3BhbmVsLWJvZS10djEwMXd1bS1ubDYu
Yw0KDQotLSANCjIuMjEuMA0K

