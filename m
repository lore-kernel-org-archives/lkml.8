Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45508C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 03:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B01F2065D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 03:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Oo4P5+db"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgHJDRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 23:17:12 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:15752 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726335AbgHJDRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 23:17:12 -0400
X-UUID: 37a15448a78a4f3f8b24bba867dd4d8e-20200810
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Z4K8Bg/d3lhf7ivZYNBcutHvTqaH5vB2AWGS7QPOWDs=;
        b=Oo4P5+db221PlU9fSRJrW4XhdqVoOi6Nu9wGFkP1l3aHHo0WxWIKGfiAvP+O/5MUa0a3R4/GpJYBZDdSwQJBMoyd2Ubc0h/n5RokrjF7S9/psipx7Ov97rxXX7B4vDyE77w3XacVdbF32s538STmI8zI6jWMQH/oy7+EKQ1N4S4=;
X-UUID: 37a15448a78a4f3f8b24bba867dd4d8e-20200810
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1057242102; Mon, 10 Aug 2020 11:06:50 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 10 Aug 2020 11:06:48 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 10 Aug 2020 11:06:47 +0800
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     <broonie@kernel.org>, <matthias.bgg@gmail.com>,
        <robh+dt@kernel.org>, <tiwai@suse.com>,
        <linux-kernel@vger.kernel.org>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <howie.huang@mediatek.com>,
        <tzungbi@google.com>, <eason.yen@mediatek.com>,
        <shane.chien@mediatek.com>, Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: [PATCH v2 0/2] Add mediatek codec mt6359 driver
Date:   Mon, 10 Aug 2020 11:05:52 +0800
Message-ID: <1597028754-7732-1-git-send-email-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIG1lZGlhdGVrIGNvZGVjIChNVDYzNTkpIGRyaXZlcg0KDQpNVDYzNTkgc3VwcG9ydCBwbGF5
YmFjayBhbmQgY2FwdHVyZSBmZWF0dXJlLg0KDQpPbiBkb3dubGluayBwYXRoLCBpdCBpbmNsdWRl
cyB0aHJlZSBEQUNzIGZvciBoYW5kc2V0LCBoZWFkc2V0LA0KYW5kIGxpbmVvdXQgcGF0aC4gT24g
dW5saW5rIHBhdGgsIGl0IGluY2x1ZGVkcyB0aHJlZSBBRENzIGZvcg0KbWFpbiBtaWMsIHNlY29u
ZCBtaWMsIDNyZCBtaWMsIGFuZCBoZWFkc2V0IG1pYy4NCg0KQnkgc2NlbmFyaW8sIHNlbGVjdCAq
X01VWCB3aWRnZXQgdG8gY3JlYXRlIGRhbXAgcGF0aC4NCkFuZCBieSBzZWxlY3QgbWljX3R5cGVf
bXV4IHRvIGNob29zZSBETUlDL0FNSUMvLi4uLg0KDQpGb3IgZXhhbXBsZSwgc2VsZWN0IHRoZXNl
IE1VWCB3aWRnZXQgdG8gY3JlYXRlIGhlYWRzZXQgcGF0aA0KKDEpIERBQyBJbiBNdXggLS0+ICJO
b3JtYWwgUGF0aCINCigyKSBIUEwgTXV4IC0tPiAiQXVkaW8gUGxheWJhY2siDQooMykgSFBSIE11
eCAtLT4gIkF1ZGlvIFBsYXliYWNrIg0KDQp2MiBjaGFuZ2VzOg0KCTEuIE1vdmUgcGxheWJhY2tf
Z3Bpby9jYXB0dXJlX2dwaW8gdG8gdGhlIG1hY2hpbmUgZHJpdmVyLg0KCTIuIEZpeCBtaWNfdHlw
ZShBQ0MvRE1JQy9EQ0MvRENDXyopIGF0IGluaXQgc3RhZ2UuDQoJMy4gTW92ZSBkZXZtX3JlZ3Vs
b3JfZ2V0IHRvIG10NjM1OV9wbGF0Zm9ybV9kcml2ZXJfcHJvYmUuDQoJNC4gQWRkIHJlbHVsYXRv
cl9kaXNhYmxlIGluIHJlbW92ZSBmdW5jdGlvbi4NCgk1LiBVc2Ugc3RlcmVvIGNvbnRyb2xzIHRv
IHRoZSB2b2x1bWUgY29udHJvbC4NCgk2LiBVc2UgU09DX0VOVU1fU0lOR0xFX0RFQ0wgaW5zdGVh
ZCBvZiBTT0NfVkFMVUVfRU5VTV9TSU5HTEVfREVDTC4NCgk3LiBDbGVhbnVwIHVudXNlZCBjb2Rl
Lg0KDQp2MSBjaGFuZ2VzOg0KCTEubGttbCBsaW5rOg0KCQlodHRwczovL2xrbWwub3JnL2xrbWwv
MjAyMC8zLzUvMTI1Nw0KDQpKaWF4aW4gWXUgKDIpOg0KICBBU29DOiBtZWRpYXRlazogbXQ2MzU5
OiBhZGQgY29kZWMgZHJpdmVyDQogIGR0LWJpbmRpbmdzOiBtZWRpYXRlazogbXQ2MzU5OiBhZGQg
Y29kZWMgZG9jdW1lbnQNCg0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL210NjM1OS55
YW1sICAgICAgICAgIHwgICA2OCArDQogc291bmQvc29jL2NvZGVjcy9LY29uZmlnICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgICA4ICsNCiBzb3VuZC9zb2MvY29kZWNzL01ha2VmaWxlICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDIgKw0KIHNvdW5kL3NvYy9jb2RlY3MvbXQ2MzU5
LmMgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMjk2NiArKysrKysrKysrKysrKysrKysrKw0K
IHNvdW5kL3NvYy9jb2RlY3MvbXQ2MzU5LmggICAgICAgICAgICAgICAgICAgICAgICAgIHwgMjY1
MyArKysrKysrKysrKysrKysrKw0KIDUgZmlsZXMgY2hhbmdlZCwgNTY5NyBpbnNlcnRpb25zKCsp
DQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9z
b3VuZC9tdDYzNTkueWFtbA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBzb3VuZC9zb2MvY29kZWNzL210
NjM1OS5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IHNvdW5kL3NvYy9jb2RlY3MvbXQ2MzU5LmgNCg0K
LS0gDQoxLjguMS4xLmRpcnR5DQo=

