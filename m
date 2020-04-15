Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173E2C38A2E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 01:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D794720732
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 01:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SxsjKmj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388677AbgDOBNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 21:13:39 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:46953 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733304AbgDOBNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 21:13:32 -0400
X-UUID: b0c1da76e8594517b441178e39adde5f-20200415
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=jZzwGiXUsQiJ0c9MXSUE3/kdW7bhbG0Ige7fRWOgpLY=;
        b=SxsjKmj9s5ID3sKKvcEsCj/Jlb1GaPMBxqSeR3x4cc+bmpfHbtErPhAo0VFuDd5aY6dYbn7JIBBUdIn8reatnd3yl03OHp3DXfAh/RUhYGYhjoK+mK23LV3XkoEhwsll1vjrbSSzdnS5fMbOkwn/jJmMkEk0z3R8ifhuG2kTzFQ=;
X-UUID: b0c1da76e8594517b441178e39adde5f-20200415
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 34507685; Wed, 15 Apr 2020 09:13:23 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 15 Apr
 2020 09:13:22 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 15 Apr 2020 09:13:20 +0800
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
Subject: [PATCH v15 0/3] mt8183 dpi support pin mode swap
Date:   Wed, 15 Apr 2020 09:13:16 +0800
Message-ID: <20200415011319.25559-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.12.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 21897C5FFB277A678AE51BF96EC4A8AD5368332861C030EE93B37541AC2638C42000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB2MTQ6DQogLSBhZGQgIkFja2VkLWJ5IiBhbmQgIlJldmlld2VkLWJ5Ig0K
IC0gY2hhbmdlIHBvcnRAMCB0byBwb3J0IGluIHlhbWwNCg0KQ2hhbmdlcyBzaW5jZSB2MTM6DQog
LSBtb3ZlIGRwaSBkdWFsIGVkZ2UgcGF0Y2hlcyB0byBhbm90aGVyIHNlcmllcyBiZWNhdXNlIGl0
IHdpbGwgaGF2ZSBsb25nIHRpbWUNCiAgIHRvIGltcGxlbWVudCB0aGUgZHVhbCBlZGdlIGNoYW5n
ZSBiYXNlIGJvcmlzIHBhdGNoZXMuDQogICBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL2Nv
dmVyLzExMzU0Mjc5Lw0KDQpDaGFuZ2VzIHNpbmNlIHYxMjoNCiAtIGZpeCBtZWRpYXRlayxkcGku
eWFtbCBtYWtlX2R0X2JpbmRpbmdfY2hlY2sgZXJyb3JzLg0KDQpDaGFuZ2Ugc2luY2UgdjExOg0K
IC0gZmluZSB0dW5lIG1lZGlhdGVrLGRwaS55YW1sLg0KIC0gYWRkIEFja2VkLWJ5OiBSb2IgSGVy
cmluZyA8cm9iaEBrZXJuZWwub3JnPi4NCg0KQ2hhbmdlIHNpbmNlIHYxMDoNCiAtIGNvbnZlcnQg
dGhlIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21l
ZGlhdGVrLGRwaS50eHQNCiAgIHRvIHlhbWwgZm9ybWF0Lg0KIC0gcmVhZCB0aGUgcGNsay1zYW1w
bGUgaW4gZW5kcG9pbnQuDQoNCkNoYW5nZXMgc2luY2Ugdjk6DQogLSByZW5hbWUgcGluY3RybC1u
YW1lcyA9ICJncGlvbW9kZSIsICJkcGltb2RlIiB0byAiYWN0aXZlIiwgImlkbGUiLg0KIC0gZml4
IHNvbWUgdHlwby4NCg0KQ2hhbmdlcyBzaW5jZSB2ODoNCiAtIGRyb3AgcGNsay1zYW1wbGUgcmVk
ZWZpbmUgaW4gbWVkaWF0ZWssZHBpLnR4dA0KIC0gb25seSBnZXQgdGhlIGdwaW9tb2RlIGFuZCBk
cGltb2RlIHdoZW4gZHBpLT5waW5jdHJsIGlzIHN1Y2Nlc3NmdWwuDQoNCkNoYW5nZXMgc2luY2Ug
djc6DQogLSBzZXBhcmF0ZSBkdC1iaW5kaW5ncyB0byBpbmRlcGVuZGVudCBwYXRjaGVzLg0KIC0g
bW92ZSBkcGkgZHVhbCBlZGdlIHRvIG9uZSBwYXRjaC4NCg0KQ2hhbmdlcyBzaW5jZSB2NjoNCiAt
IGNoYW5nZSBkdWFsX2VkZ2UgdG8gcGNsay1zYW1wbGUNCiAtIHJlbW92ZSBkcGlfcGluX21vZGVf
c3dhcCBhbmQNCg0KQ2hhbmdlcyBzaW5jZSB2NToNCiAtIGZpbmUgdHVuZSB0aGUgZHQtYmluZGlu
Z3MgY29tbWl0IG1lc3NhZ2UuDQoNCkNoYW5nZXMgc2luY2UgdjQ6DQogLSBtb3ZlIHBpbiBtb2Rl
IGNvbnRyb2wgYW5kIGR1YWwgZWRnZSBjb250cm9sIHRvIGRldmVpY2UgdHJlZS4NCiAtIHVwZGF0
ZSBkdC1iaW5kaW5ncyBkb2N1bWVudCBmb3IgcGluIG1vZGUgc3dhcCBhbmQgZHVhbCBlZGdlIGNv
bnRyb2wuDQoNCkNoYW5nZXMgc2luY2UgdjM6DQogLSBhZGQgZHBpIHBpbiBtb2RlIGNvbnRyb2wg
d2hlbiBkcGkgb24gb3Igb2ZmLg0KIC0gdXBkYXRlIGRwaSBkdWFsIGVkZ2UgY29tbWVudC4NCg0K
Q2hhbmdlcyBzaW5jZSB2MjoNCiAtIHVwZGF0ZSBkdC1iaW5kaW5ncyBkb2N1bWVudCBmb3IgbXQ4
MTgzIGRwaS4NCiAtIHNlcGFyYXRlIGR1YWwgZWRnZSBtb2RmaWNhdGlvbiBhcyBpbmRlcGVuZGVu
dCBwYXRjaC4NCg0KSml0YW8gU2hpICgzKToNCiAgZHQtYmluZGluZ3M6IGRpc3BsYXk6IG1lZGlh
dGVrOiBjb250cm9sIGRwaSBwaW5zIG1vZGUgdG8gYXZvaWQgbGVha2FnZQ0KICBkdC1iaW5kaW5n
czogZGlzcGxheTogbWVkaWF0ZWs6IGNvbnZlcnQgdGhlIGRvY3VtZW50IGZvcm1hdCBmcm9tIHR4
dA0KICAgIHRvIHlhbWwNCiAgZHJtL21lZGlhdGVrOiBzZXQgZHBpIHBpbiBtb2RlIHRvIGdwaW8g
bG93IHRvIGF2b2lkIGxlYWthZ2UgY3VycmVudA0KDQogLi4uL2JpbmRpbmdzL2Rpc3BsYXkvbWVk
aWF0ZWsvbWVkaWF0ZWssZHBpLnR4dCAgICAgfCAzNiAtLS0tLS0tLQ0KIC4uLi9iaW5kaW5ncy9k
aXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS55YW1sICAgIHwgOTcgKysrKysrKysrKysrKysr
KysrKysrKw0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMgICAgICAgICAgICAg
ICAgIHwgMzEgKysrKysrKw0KIDMgZmlsZXMgY2hhbmdlZCwgMTI4IGluc2VydGlvbnMoKyksIDM2
IGRlbGV0aW9ucygtKQ0KIGRlbGV0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGkudHh0DQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlh
dGVrL21lZGlhdGVrLGRwaS55YW1sDQoNCi0tIA0KMi4xMi41DQo=

