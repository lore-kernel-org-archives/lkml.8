Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F02C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1EA246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="b+FFx+LQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgB1IPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 03:15:14 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:29744 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725871AbgB1IPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 03:15:14 -0500
X-UUID: b010861dae43497983cf186aa75db92c-20200228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=HJb7/ljUwWmTqEm0PtuCt0NNxaTQhjqapiKPaumq4IQ=;
        b=b+FFx+LQHRXmEocD7j6j4I5o3OiViKZWmbVsJY9el57SfPWLuadhS+LqiRoCMUdFXRPDskHllwJhEt1nU6mfeEp0Ut9S7TQ7rMmzMzqAbiC63k3Q0CYPosn2cBpFgFEjzIE9FmIfoo34F7Iff3yEmuIQuEPxZxkvViiH4EROlSg=;
X-UUID: b010861dae43497983cf186aa75db92c-20200228
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1500844275; Fri, 28 Feb 2020 16:15:07 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 28 Feb
 2020 16:13:43 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Fri, 28 Feb 2020 16:15:15 +0800
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
Subject: [PATCH v11 0/6] mt8183 dpi supports dual edge and pin mode swap
Date:   Fri, 28 Feb 2020 16:14:35 +0800
Message-ID: <20200228081441.88179-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 61F0E04492248071CB26136A797564F618AC50112BA468E9070C92A6B70DEFD72000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlIHNpbmNlIHYxMDoNCiAtIGNvbnZlcnQgdGhlIERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQNCiAgIHRvIHlhbWwg
Zm9ybWF0Lg0KIC0gcmVhZCB0aGUgcGNsay1zYW1wbGUgaW4gZW5kcG9pbnQuDQoNCkNoYW5nZXMg
c2luY2Ugdjk6DQogLSByZW5hbWUgcGluY3RybC1uYW1lcyA9ICJncGlvbW9kZSIsICJkcGltb2Rl
IiB0byAiYWN0aXZlIiwgImlkbGUiLg0KIC0gZml4IHNvbWUgdHlwby4NCg0KQ2hhbmdlcyBzaW5j
ZSB2ODoNCiAtIGRyb3AgcGNsay1zYW1wbGUgcmVkZWZpbmUgaW4gbWVkaWF0ZWssZHBpLnR4dA0K
IC0gb25seSBnZXQgdGhlIGdwaW9tb2RlIGFuZCBkcGltb2RlIHdoZW4gZHBpLT5waW5jdHJsIGlz
IHN1Y2Nlc3NmdWwuDQoNCkNoYW5nZXMgc2luY2Ugdjc6DQogLSBzZXBhcmF0ZSBkdC1iaW5kaW5n
cyB0byBpbmRlcGVuZGVudCBwYXRjaGVzLg0KIC0gbW92ZSBkcGkgZHVhbCBlZGdlIHRvIG9uZSBw
YXRjaC4NCg0KQ2hhbmdlcyBzaW5jZSB2NjoNCiAtIGNoYW5nZSBkdWFsX2VkZ2UgdG8gcGNsay1z
YW1wbGUNCiAtIHJlbW92ZSBkcGlfcGluX21vZGVfc3dhcCBhbmQNCg0KQ2hhbmdlcyBzaW5jZSB2
NToNCiAtIGZpbmUgdHVuZSB0aGUgZHQtYmluZGluZ3MgY29tbWl0IG1lc3NhZ2UuDQoNCkNoYW5n
ZXMgc2luY2UgdjQ6DQogLSBtb3ZlIHBpbiBtb2RlIGNvbnRyb2wgYW5kIGR1YWwgZWRnZSBjb250
cm9sIHRvIGRldmVpY2UgdHJlZS4NCiAtIHVwZGF0ZSBkdC1iaW5kaW5ncyBkb2N1bWVudCBmb3Ig
cGluIG1vZGUgc3dhcCBhbmQgZHVhbCBlZGdlIGNvbnRyb2wuDQoNCkNoYW5nZXMgc2luY2UgdjM6
DQogLSBhZGQgZHBpIHBpbiBtb2RlIGNvbnRyb2wgd2hlbiBkcGkgb24gb3Igb2ZmLg0KIC0gdXBk
YXRlIGRwaSBkdWFsIGVkZ2UgY29tbWVudC4NCg0KQ2hhbmdlcyBzaW5jZSB2MjoNCiAtIHVwZGF0
ZSBkdC1iaW5kaW5ncyBkb2N1bWVudCBmb3IgbXQ4MTgzIGRwaS4NCiAtIHNlcGFyYXRlIGR1YWwg
ZWRnZSBtb2RmaWNhdGlvbiBhcyBpbmRlcGVuZGVudCBwYXRjaC4NCg0KSml0YW8gU2hpICg2KToN
CiAgZHQtYmluZGluZ3M6IG1lZGlhOiBhZGQgcGNsay1zYW1wbGUgZHVhbCBlZGdlIHByb3BlcnR5
DQogIGR0LWJpbmRpbmdzOiBkaXNwbGF5OiBtZWRpYXRlazogY29udHJvbCBkcGkgcGlucyBtb2Rl
IHRvIGF2b2lkIGxlYWthZ2UNCiAgZHQtYmluZGluZ3M6IGRpc3BsYXk6IG1lZGlhdGVrOiBkcGkg
c2FtcGxlIGRhdGEgaW4gZHVhbCBlZGdlIHN1cHBvcnQNCiAgZHQtYmluZGluZ3M6IGRpc3BsYXk6
IG1lZGlhdGVrOiBjb252ZXJ0IHRoZSBkb2N1bWVudCBmb3JtYXQgZnJvbSB0eHQNCiAgICB0byB5
YW1sDQogIGRybS9tZWRpYXRlazogZHBpIHNhbXBsZSBtb2RlIHN1cHBvcnQNCiAgZHJtL21lZGlh
dGVrOiBzZXQgZHBpIHBpbiBtb2RlIHRvIGdwaW8gbG93IHRvIGF2b2lkIGxlYWthZ2UgY3VycmVu
dA0KDQogLi4uL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnR4dCAgICAgICAgIHwgIDM2
IC0tLS0tLS0NCiAuLi4vZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGkueWFtbCAgICAgICAg
fCAxMDAgKysrKysrKysrKysrKysrKysrDQogLi4uL2JpbmRpbmdzL21lZGlhL3ZpZGVvLWludGVy
ZmFjZXMudHh0ICAgICAgIHwgICA0ICstDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cGkuYyAgICAgICAgICAgIHwgIDU4ICsrKysrKysrKy0NCiA0IGZpbGVzIGNoYW5nZWQsIDE1OCBp
bnNlcnRpb25zKCspLCA0MCBkZWxldGlvbnMoLSkNCiBkZWxldGUgbW9kZSAxMDA2NDQgRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBp
LnR4dA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGkueWFtbA0KDQotLSANCjIuMjEuMA0K

