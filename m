Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDBFC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91DB324671
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LWjHoDhy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbgAOOBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:01:24 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:13381 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728884AbgAOOBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:01:19 -0500
X-UUID: 84e03eedd14d40068ec299080c9132be-20200115
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=iqI0/BExz5+Ja7rS3jk0iIZb9us1L2XdgWD3khlwGTc=;
        b=LWjHoDhyXr0y9XU2gzGe72pGrxYp8ZrRRXLFa+62qWdBtL7esNLE/JgWYwEFgTWo0aIueIpiwqRTrVDFk4tnevdwnFecproMmHrTf4e+5JYiB/ETcw0Z7dB5IxbuVCk2A7RRfz5aU/HcGs3+q7NA/pFQZwSavkUIoMGhHvVBZNQ=;
X-UUID: 84e03eedd14d40068ec299080c9132be-20200115
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 63424230; Wed, 15 Jan 2020 22:00:49 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 15 Jan
 2020 22:01:15 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Wed, 15 Jan 2020 22:00:58 +0800
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
Subject: [PATCH v8 0/8] add driver for "boe, tv101wum-nl6", "boe, tv101wum-n53", "auo, kd101n80-45na" and "auo, b101uan08.3" panels
Date:   Wed, 15 Jan 2020 21:59:50 +0800
Message-ID: <20200115135958.126303-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E5D42284C1FC6913D7CA8B057FD34836D64D46B9D57845A57AD5644DF877DD162000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB2NzoNCiAtIGJhc2UgZHJtLW1pc2MtbmV4dCBicmFuY2gNCiAtIGZpeCBk
b2N1bWVudCBwYXNzIGR0X2JpbmRpbmdfY2hlY2sNCiAtIHJlbW92ZSBiYWNrbGlnaHQgZnJvbSBw
YW5lbCBkcml2ZXINCg0KQ2hhbmdlcyBzaW5jZSB2NjoNCiAtIGZpeCBib2VfcGFuZWxfaW5pdCBl
cnIgdW5pbml0Lg0KIC0gYWRqdXN0IHRoZSBkZWxheSBvZiBiYWNrbGlnaHQgb24uDQoNCkNoYW5n
ZXMgc2luY2UgdjU6DQogLSBjb3ZlcnQgdGhlIGRvY3VtZW50cyB0byB5YW1sDQogLSBmaW5lIHR1
bmUgYm9lLCB0djEwMXd1bS1uNTMgcGFuZWwgdmlkZW8gdGltaW5lDQoNCkNoYW5nZXMgc2luY2Ug
djQ6DQogLSBhZGQgYXVvLGIxMDF1YW4wOC4zIHBhbmVsIGZvciB0aGlzIGRyaXZlci4NCiAtIGFk
ZCBib2UsdHYxMDF3dW0tbjUzIHBhbmVsIGZvciB0aGlzIGRyaXZlci4NCg0KQ2hhbmdlcyBzaW5j
ZSB2MzoNCiAtIHJlbW92ZSBjaGVjayBlbmFibGVfZ3Bpby4NCiAtIGZpbmUgdHVuZSB0aGUgYXVv
LGtkMTAxbjgwLTQ1bmEgcGFuZWwncyBwb3dlciBvbiB0aW1pbmcuDQoNCkNoYW5nZXMgc2luY2Ug
djI6DQogLSBjb3JyZWN0IHRoZSBwYW5lbCBzaXplDQogLSByZW1vdmUgYmxhbmsgbGluZSBpbiBL
Y29uZmlnDQogLSBtb3ZlIGF1byxrZDEwMW44MC00NW5hIHBhbmVsIGRyaXZlciBpbiB0aGlzIHNl
cmllcy4NCg0KQ2hhbmdlcyBzaW5jZSB2MToNCiAtIHVwZGF0ZSB0eXBvIG5sNiAtPiBuMTYuDQog
LSB1cGRhdGUgbmV3IHBhbmVsIGNvbmZpZyBhbmQgbWFrZWZpbGUgYXJlIGFkZGVkIGluIGFscGhh
YmV0aWNhbGx5IG9yZGVyLg0KIC0gYWRkIHRoZSBwYW5lbCBtb2RlIGFuZCBwYW5lbCBpbmZvIGlu
IGRyaXZlciBkYXRhLg0KIC0gbWVyZ2UgYXVvLGtkMTAxbjgwLTQ1YSBhbmQgYm9lLHR2MTAxd3Vt
LW5sNiBpbiBvbmUgZHJpdmVyDQoNCkppdGFvIFNoaSAoOCk6DQogIGR0LWJpbmRpbmdzOiBkaXNw
bGF5OiBwYW5lbDogQWRkIEJPRSB0djEwMXd1bS1uMTYgcGFuZWwgYmluZGluZ3MNCiAgZHJtL3Bh
bmVsOiBzdXBwb3J0IGZvciBCT0UgdHYxMDF3dW0tbmw2IHd1eGdhIGRzaSB2aWRlbyBtb2RlIHBh
bmVsDQogIGR0LWJpbmRpbmdzOiBkaXNwbGF5OiBwYW5lbDogYWRkIGF1byBrZDEwMW44MC00NW5h
IHBhbmVsIGJpbmRpbmdzDQogIGRybS9wYW5lbDogc3VwcG9ydCBmb3IgYXVvLGtkMTAxbjgwLTQ1
bmEgd3V4Z2EgZHNpIHZpZGVvIG1vZGUgcGFuZWwNCiAgZHQtYmluZGluZ3M6IGRpc3BsYXk6IHBh
bmVsOiBhZGQgYm9lIHR2MTAxd3VtLW41MyBwYW5lbCBkb2N1bWVudGF0aW9uDQogIGRybS9wYW5l
bDogc3VwcG9ydCBmb3IgYm9lLHR2MTAxd3VtLW41MyB3dXhnYSBkc2kgdmlkZW8gbW9kZSBwYW5l
bA0KICBkdC1iaW5kaW5nczogZGlzcGxheTogcGFuZWw6IGFkZCBBVU8gYXVvLCBiMTAxdWFuMDgu
MyBwYW5lbA0KICAgIGRvY3VtZW50YXRpb24NCiAgZHJtL3BhbmVsOiBzdXBwb3J0IGZvciBhdW8s
YjEwMXVhbjA4LjMgd3V4Z2EgZHNpIHZpZGVvIG1vZGUgcGFuZWwNCg0KIC4uLi9kaXNwbGF5L3Bh
bmVsL2F1byxiMTAxdWFuMDguMy55YW1sICAgICAgICB8ICA3NCArKw0KIC4uLi9kaXNwbGF5L3Bh
bmVsL2F1byxrZDEwMW44MC00NW5hLnlhbWwgICAgICB8ICA3NCArKw0KIC4uLi9kaXNwbGF5L3Bh
bmVsL2JvZSx0djEwMXd1bS1uNTMueWFtbCAgICAgICB8ICA3NCArKw0KIC4uLi9kaXNwbGF5L3Bh
bmVsL2JvZSx0djEwMXd1bS1ubDYueWFtbCAgICAgICB8ICA3NCArKw0KIGRyaXZlcnMvZ3B1L2Ry
bS9wYW5lbC9LY29uZmlnICAgICAgICAgICAgICAgICB8ICAgOSArDQogZHJpdmVycy9ncHUvZHJt
L3BhbmVsL01ha2VmaWxlICAgICAgICAgICAgICAgIHwgICAxICsNCiAuLi4vZ3B1L2RybS9wYW5l
bC9wYW5lbC1ib2UtdHYxMDF3dW0tbmw2LmMgICAgfCA4NTQgKysrKysrKysrKysrKysrKysrDQog
NyBmaWxlcyBjaGFuZ2VkLCAxMTYwIGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQg
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvcGFuZWwvYXVvLGIxMDF1
YW4wOC4zLnlhbWwNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2Rpc3BsYXkvcGFuZWwvYXVvLGtkMTAxbjgwLTQ1bmEueWFtbA0KIGNyZWF0ZSBt
b2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9wYW5l
bC9ib2UsdHYxMDF3dW0tbjUzLnlhbWwNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvcGFuZWwvYm9lLHR2MTAxd3VtLW5sNi55YW1s
DQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9wYW5lbC9wYW5lbC1ib2UtdHYx
MDF3dW0tbmw2LmMNCg0KLS0gDQoyLjIxLjANCg==

