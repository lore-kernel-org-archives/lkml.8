Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F19CC2BA15
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 08:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CB5206F8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 08:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oL8Mdra5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390448AbgDCIEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 04:04:47 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:27177 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390429AbgDCIEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 04:04:47 -0400
X-UUID: 8ad81e07233c4fd5b126b77d49c9a5c4-20200403
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=/tNfCDVWSqk4IVMjxJ9nlCJvvc7wNHdJw2VAzY+GTVM=;
        b=oL8Mdra5KDYeM84M6nEjyusnYgtFZeOCwhhD4NOsVrbnD83uKenURKplpBOG6Yl8T/jm9hqjFgvXjGDIOzqaBXXdhO0NZUXajN5qc8OeM0BqhcyEBc3dbkT428efD3Tc+fWN/vbFQVm9GMWfPTyv1V1SQL/vGY7ECNEj1Qjcgeg=;
X-UUID: 8ad81e07233c4fd5b126b77d49c9a5c4-20200403
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1010775145; Fri, 03 Apr 2020 16:03:54 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 3 Apr
 2020 16:03:54 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Fri, 3 Apr 2020 16:03:51 +0800
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
Subject: [PATCH v14 0/3] mt8183 dpi support pin mode swap
Date:   Fri, 3 Apr 2020 16:03:47 +0800
Message-ID: <20200403080350.95826-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C006CC23FD734C8AEA7ABD8875244E0B4BFFE8BDA5A90A17D1C60270B95C53F52000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB2MTM6DQogLSBtb3ZlIGRwaSBkdWFsIGVkZ2UgcGF0Y2hlcyB0byBhbm90
aGVyIHNlcmllcyBiZWNhdXNlIGl0IHdpbGwgaGF2ZSBsb25nIHRpbWUNCiAgIHRvIGltcGxlbWVu
dCB0aGUgZHVhbCBlZGdlIGNoYW5nZSBiYXNlIGJvcmlzIHBhdGNoZXMuDQogICBodHRwczovL3Bh
dGNod29yay5rZXJuZWwub3JnL2NvdmVyLzExMzU0Mjc5Lw0KDQpDaGFuZ2VzIHNpbmNlIHYxMjoN
CiAtIGZpeCBtZWRpYXRlayxkcGkueWFtbCBtYWtlX2R0X2JpbmRpbmdfY2hlY2sgZXJyb3JzLg0K
DQpDaGFuZ2Ugc2luY2UgdjExOg0KIC0gZmluZSB0dW5lIG1lZGlhdGVrLGRwaS55YW1sLg0KIC0g
YWRkIEFja2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPi4NCg0KQ2hhbmdlIHNp
bmNlIHYxMDoNCiAtIGNvbnZlcnQgdGhlIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQNCiAgIHRvIHlhbWwgZm9ybWF0Lg0K
IC0gcmVhZCB0aGUgcGNsay1zYW1wbGUgaW4gZW5kcG9pbnQuDQoNCkNoYW5nZXMgc2luY2Ugdjk6
DQogLSByZW5hbWUgcGluY3RybC1uYW1lcyA9ICJncGlvbW9kZSIsICJkcGltb2RlIiB0byAiYWN0
aXZlIiwgImlkbGUiLg0KIC0gZml4IHNvbWUgdHlwby4NCg0KQ2hhbmdlcyBzaW5jZSB2ODoNCiAt
IGRyb3AgcGNsay1zYW1wbGUgcmVkZWZpbmUgaW4gbWVkaWF0ZWssZHBpLnR4dA0KIC0gb25seSBn
ZXQgdGhlIGdwaW9tb2RlIGFuZCBkcGltb2RlIHdoZW4gZHBpLT5waW5jdHJsIGlzIHN1Y2Nlc3Nm
dWwuDQoNCkNoYW5nZXMgc2luY2Ugdjc6DQogLSBzZXBhcmF0ZSBkdC1iaW5kaW5ncyB0byBpbmRl
cGVuZGVudCBwYXRjaGVzLg0KIC0gbW92ZSBkcGkgZHVhbCBlZGdlIHRvIG9uZSBwYXRjaC4NCg0K
Q2hhbmdlcyBzaW5jZSB2NjoNCiAtIGNoYW5nZSBkdWFsX2VkZ2UgdG8gcGNsay1zYW1wbGUNCiAt
IHJlbW92ZSBkcGlfcGluX21vZGVfc3dhcCBhbmQNCg0KQ2hhbmdlcyBzaW5jZSB2NToNCiAtIGZp
bmUgdHVuZSB0aGUgZHQtYmluZGluZ3MgY29tbWl0IG1lc3NhZ2UuDQoNCkNoYW5nZXMgc2luY2Ug
djQ6DQogLSBtb3ZlIHBpbiBtb2RlIGNvbnRyb2wgYW5kIGR1YWwgZWRnZSBjb250cm9sIHRvIGRl
dmVpY2UgdHJlZS4NCiAtIHVwZGF0ZSBkdC1iaW5kaW5ncyBkb2N1bWVudCBmb3IgcGluIG1vZGUg
c3dhcCBhbmQgZHVhbCBlZGdlIGNvbnRyb2wuDQoNCkNoYW5nZXMgc2luY2UgdjM6DQogLSBhZGQg
ZHBpIHBpbiBtb2RlIGNvbnRyb2wgd2hlbiBkcGkgb24gb3Igb2ZmLg0KIC0gdXBkYXRlIGRwaSBk
dWFsIGVkZ2UgY29tbWVudC4NCg0KQ2hhbmdlcyBzaW5jZSB2MjoNCiAtIHVwZGF0ZSBkdC1iaW5k
aW5ncyBkb2N1bWVudCBmb3IgbXQ4MTgzIGRwaS4NCiAtIHNlcGFyYXRlIGR1YWwgZWRnZSBtb2Rm
aWNhdGlvbiBhcyBpbmRlcGVuZGVudCBwYXRjaC4NCg0KSml0YW8gU2hpICgzKToNCiAgZHQtYmlu
ZGluZ3M6IGRpc3BsYXk6IG1lZGlhdGVrOiBjb250cm9sIGRwaSBwaW5zIG1vZGUgdG8gYXZvaWQg
bGVha2FnZQ0KICBkdC1iaW5kaW5nczogZGlzcGxheTogbWVkaWF0ZWs6IGNvbnZlcnQgdGhlIGRv
Y3VtZW50IGZvcm1hdCBmcm9tIHR4dA0KICAgIHRvIHlhbWwNCiAgZHJtL21lZGlhdGVrOiBzZXQg
ZHBpIHBpbiBtb2RlIHRvIGdwaW8gbG93IHRvIGF2b2lkIGxlYWthZ2UgY3VycmVudA0KDQogLi4u
L2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnR4dCAgICAgICAgIHwgMzYgLS0tLS0tLQ0K
IC4uLi9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS55YW1sICAgICAgICB8IDk3ICsrKysr
KysrKysrKysrKysrKysNCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jICAgICAg
ICAgICAgfCAzMSArKysrKysNCiAzIGZpbGVzIGNoYW5nZWQsIDEyOCBpbnNlcnRpb25zKCspLCAz
NiBkZWxldGlvbnMoLSkNCiBkZWxldGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnR4dA0KIGNyZWF0ZSBt
b2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRp
YXRlay9tZWRpYXRlayxkcGkueWFtbA0KDQotLSANCjIuMjEuMA0K

