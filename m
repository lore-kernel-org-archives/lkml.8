Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFB2C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 07:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54065206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 07:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RZBoUhX3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgFNHat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 03:30:49 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:27760 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725265AbgFNHat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 03:30:49 -0400
X-UUID: 3bc1a341b00542dfb52cf5ddf64727f4-20200614
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=L4w1BxuPEuaolAl73lyLpZak7tmL/oTsWS9Ew8XXxXE=;
        b=RZBoUhX3c7O133L0zkcaymSsylEgXeymaK/OdhgmQIYSpmkVcnkuWh+lDI4Y4p9cTGptptDLE9nDeANKdxHWprvaLF1luXLytLBN8pHjRX/z7hzGAmcmISfDa7+NK4zhlbzj87Mu35I/xVV5omD/3JyVITWgju0NvNgAoN4DMKc=;
X-UUID: 3bc1a341b00542dfb52cf5ddf64727f4-20200614
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1197687010; Sun, 14 Jun 2020 15:30:40 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 14 Jun
 2020 15:30:37 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sun, 14 Jun 2020 15:30:35 +0800
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
Subject: [PATCH v16 0/1] mt8183 dpi support pin mode swap
Date:   Sun, 14 Jun 2020 15:30:35 +0800
Message-ID: <20200614073036.63969-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E1923E3E3C51486693955F8F978D504463E5922E9982C95200D291053619C5292000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB2MTU6DQogLSBGaXggWUFNTCBMaWNlbnNlIHRvIChHUEwtMi4wLW9ubHkg
T1IgQlNELTItQ2xhdXNlKS4NCiAtICJkdC1iaW5kaW5nczogZGlzcGxheTogbWVkaWF0ZWs6IGNv
bnRyb2wgZHBpIHBpbnMgbW9kZSB0byBhdm9pZCBsZWFrYWdlIg0KICAgImRybS9tZWRpYXRlazog
c2V0IGRwaSBwaW4gbW9kZSB0byBncGlvIGxvdyB0byBhdm9pZCBsZWFrYWdlIGN1cnJlbnQiDQog
ICBhcHBsaWVkIHYxNS4gVGhlIGxpbmtzIGFyZSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3Jn
L3BhdGNoLzExNDg5NTQ1Lw0KICAgaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8x
MTQ4OTU3Ny8NCg0KQ2hhbmdlcyBzaW5jZSB2MTQ6DQogLSBhZGQgIkFja2VkLWJ5IiBhbmQgIlJl
dmlld2VkLWJ5Ig0KIC0gY2hhbmdlIHBvcnRAMCB0byBwb3J0IGluIHlhbWwNCg0KQ2hhbmdlcyBz
aW5jZSB2MTM6DQogLSBtb3ZlIGRwaSBkdWFsIGVkZ2UgcGF0Y2hlcyB0byBhbm90aGVyIHNlcmll
cyBiZWNhdXNlIGl0IHdpbGwgaGF2ZSBsb25nIHRpbWUNCiAgIHRvIGltcGxlbWVudCB0aGUgZHVh
bCBlZGdlIGNoYW5nZSBiYXNlIGJvcmlzIHBhdGNoZXMuDQogICBodHRwczovL3BhdGNod29yay5r
ZXJuZWwub3JnL2NvdmVyLzExMzU0Mjc5Lw0KDQpDaGFuZ2VzIHNpbmNlIHYxMjoNCiAtIGZpeCBt
ZWRpYXRlayxkcGkueWFtbCBtYWtlX2R0X2JpbmRpbmdfY2hlY2sgZXJyb3JzLg0KDQpDaGFuZ2Ug
c2luY2UgdjExOg0KIC0gZmluZSB0dW5lIG1lZGlhdGVrLGRwaS55YW1sLg0KIC0gYWRkIEFja2Vk
LWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPi4NCg0KQ2hhbmdlIHNpbmNlIHYxMDoN
CiAtIGNvbnZlcnQgdGhlIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5
L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQNCiAgIHRvIHlhbWwgZm9ybWF0Lg0KIC0gcmVhZCB0
aGUgcGNsay1zYW1wbGUgaW4gZW5kcG9pbnQuDQoNCkNoYW5nZXMgc2luY2Ugdjk6DQogLSByZW5h
bWUgcGluY3RybC1uYW1lcyA9ICJncGlvbW9kZSIsICJkcGltb2RlIiB0byAiYWN0aXZlIiwgImlk
bGUiLg0KIC0gZml4IHNvbWUgdHlwby4NCg0KQ2hhbmdlcyBzaW5jZSB2ODoNCiAtIGRyb3AgcGNs
ay1zYW1wbGUgcmVkZWZpbmUgaW4gbWVkaWF0ZWssZHBpLnR4dA0KIC0gb25seSBnZXQgdGhlIGdw
aW9tb2RlIGFuZCBkcGltb2RlIHdoZW4gZHBpLT5waW5jdHJsIGlzIHN1Y2Nlc3NmdWwuDQoNCkNo
YW5nZXMgc2luY2Ugdjc6DQogLSBzZXBhcmF0ZSBkdC1iaW5kaW5ncyB0byBpbmRlcGVuZGVudCBw
YXRjaGVzLg0KIC0gbW92ZSBkcGkgZHVhbCBlZGdlIHRvIG9uZSBwYXRjaC4NCg0KQ2hhbmdlcyBz
aW5jZSB2NjoNCiAtIGNoYW5nZSBkdWFsX2VkZ2UgdG8gcGNsay1zYW1wbGUNCiAtIHJlbW92ZSBk
cGlfcGluX21vZGVfc3dhcCBhbmQNCg0KQ2hhbmdlcyBzaW5jZSB2NToNCiAtIGZpbmUgdHVuZSB0
aGUgZHQtYmluZGluZ3MgY29tbWl0IG1lc3NhZ2UuDQoNCkNoYW5nZXMgc2luY2UgdjQ6DQogLSBt
b3ZlIHBpbiBtb2RlIGNvbnRyb2wgYW5kIGR1YWwgZWRnZSBjb250cm9sIHRvIGRldmVpY2UgdHJl
ZS4NCiAtIHVwZGF0ZSBkdC1iaW5kaW5ncyBkb2N1bWVudCBmb3IgcGluIG1vZGUgc3dhcCBhbmQg
ZHVhbCBlZGdlIGNvbnRyb2wuDQoNCkNoYW5nZXMgc2luY2UgdjM6DQogLSBhZGQgZHBpIHBpbiBt
b2RlIGNvbnRyb2wgd2hlbiBkcGkgb24gb3Igb2ZmLg0KIC0gdXBkYXRlIGRwaSBkdWFsIGVkZ2Ug
Y29tbWVudC4NCg0KQ2hhbmdlcyBzaW5jZSB2MjoNCiAtIHVwZGF0ZSBkdC1iaW5kaW5ncyBkb2N1
bWVudCBmb3IgbXQ4MTgzIGRwaS4NCiAtIHNlcGFyYXRlIGR1YWwgZWRnZSBtb2RmaWNhdGlvbiBh
cyBpbmRlcGVuZGVudCBwYXRjaC4NCg0KSml0YW8gU2hpICgxKToNCiAgZHQtYmluZGluZ3M6IGRp
c3BsYXk6IG1lZGlhdGVrOiBjb252ZXJ0IHRoZSBkcGkgYmluZGluZ3MgdG8geWFtbA0KDQogLi4u
L2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnR4dCAgICAgICAgIHwgNDIgLS0tLS0tLS0N
CiAuLi4vZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGkueWFtbCAgICAgICAgfCA5NyArKysr
KysrKysrKysrKysrKysrDQogMiBmaWxlcyBjaGFuZ2VkLCA5NyBpbnNlcnRpb25zKCspLCA0MiBk
ZWxldGlvbnMoLSkNCiBkZWxldGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnR4dA0KIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRl
ay9tZWRpYXRlayxkcGkueWFtbA0KDQotLSANCjIuMjUuMQ0K

