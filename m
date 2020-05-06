Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBABC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 08:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 561CF20714
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 08:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="frgQcoMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgEFIQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 04:16:46 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:55491 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728371AbgEFIQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 04:16:10 -0400
X-UUID: 066c20606c9f4b2bae9d1154b51791b1-20200506
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=dQ3adS1R6v5Zhh8k4ubaG3dFg785IaheB/Dm6qnyvTk=;
        b=frgQcoMejWx1+nJOwQd5o99qWSOUx6nW0tkXEQBp6lbjSLZB9r5lN0T+lvONc3Fx9+7ASF8p8SSc58mb0U4QCDYAKOGhRpTaP0otambjVAPft2IJf835IdKwYm5j8lI3l++VVizPNt1YZKTlr3vNaIuagpuDsRaHoFI40AhV/Fc=;
X-UUID: 066c20606c9f4b2bae9d1154b51791b1-20200506
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 444435114; Wed, 06 May 2020 16:16:06 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 6 May 2020 16:16:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 6 May 2020 16:16:04 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v14 00/11] Mediatek MT8183 scpsys support 
Date:   Wed, 6 May 2020 16:15:52 +0800
Message-ID: <1588752963-19934-1-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBzZXJpZXMgaXMgYmFzZWQgb24gdjUuNy1yYzENCg0KY2hhbmdlcyBzaW5jZSB2MTM6DQot
IGRvY3VtZW50IG9wdGlvbmFsIHByb3BlcnR5ICJzbWktY29tbSINCi0gbW92ZSBkZWZpbmVzIGlu
IHNjcHN5Yy5oIHRvIG10ay1zY3BzeXMuYyBkaXJlY3RseQ0KLSBtaW5vciBjb2Rpbmcgc3l0bGUg
Zml4ZXMNCg0KY2hhbmdlIHNpbmNlIHYxMjoNCi0gc2VwYXJhdGUgdGhlIGZpeCBvZiBjb21tYSBh
dCB0aGUgZW5kIGludG8gYSBuZXcgcGF0Y2ggW1BBVENIIDA5LzExXQ0KDQpjaGFuZ2VzIHNpbmNl
IHYxMToNCi0gcmUtb3JkZXIgcGF0Y2hlcyAiUmVtb3ZlIGluZnJhY2ZnIG1pc2MgZHJpdmVyIHN1
cHBvcnQiIGFuZCAiQWRkIG11bHRpcGxlIHN0ZXAgYnVzIHByb3RlY3Rpb24iDQotIGFkZCBjYXAg
TVRLX1NDUERfU1JBTV9JU08gZm9yIGV4dHJhIHNyYW0gY29udHJvbA0KLSBtaW5vciBjb2Rpbmcg
c3l0bGUgZml4ZXMgYW5kIHJld29yZCBjb21taXQgbWVzc2FnZXMNCg0KY2hhbmdlcyBzaW5jZSB2
MTA6DQotIHNxdWFzaCBQQVRDSCAwNCBhbmQgUEFUQ0ggMDYgaW4gdjkgaW50byBpdHMgcHJldmlv
dXMgcGF0Y2gNCi0gYWRkICJpZ25vcmVfY2xyX2FjayIgZm9yIG11bHRpcGxlIHN0ZXAgYnVzIHBy
b3RlY3Rpb24gY29udHJvbCB0byBoYXZlIGEgY2xlYW4gZGVmaW5pdGlvbiBvZiBwb3dlciBkb21h
aW4gZGF0YQ0KLSBrZWVwIHRoZSBtYXNrIHJlZ2lzdGVyIGJpdCBkZWZpbml0aW9ucyBhbmQgZG8g
dGhlIHNhbWUgZm9yIE1UODE4Mw0KDQpjaGFuZ2VzIHNpbmNlIHY5Og0KLSBhZGQgbmV3IFBBVENI
IDA0IGFuZCBQQVRDSCAwNiB0byByZXBsYWNlIGJ5IG5ldyBtZXRob2QgZm9yIGFsbCBjb21wYXRp
Ymxlcw0KLSBhZGQgbmV3IFBBVENIIDA3IHRvIHJlbW92ZSBpbmZyYWNmZyBtaXNjIGRyaXZlcg0K
LSBtaW5vciBjb2Rpbmcgc3l0bGUgZml4DQoNCmNoYW5nZXMgc2luY2Ugdjc6DQotIHJld29yZCBp
biBiaW5kaW5nIGRvY3VtZW50IFtQQVRDSCAwMi8xNF0NCi0gZml4IGVycm9yIHJldHVybiBjaGVj
a2luZyBidWcgaW4gc3Vic3lzIGNsb2NrIGNvbnRyb2wgW1BBVENIIDEwLzE0XQ0KLSBhZGQgcG93
ZXIgZG9tYWlucyBwcm9wZXJpdHkgdG8gbWZnY2ZnIHBhdGNoIFtQQVRDSCAxNC8xNF0gZnJvbQ0K
ICBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzExMTI2MTk5Lw0KDQpjaGFuZ2Vz
IHNpbmNlIHY2Og0KLSByZW1vdmUgdGhlIHBhdGNoIG9mIFNQRFggbGljZW5zZSBpZGVudGlmaWVy
IGJlY2F1c2UgaXQncyBhbHJlYWR5IGZpeGVkDQoNCmNoYW5nZXMgc2luY2UgdjU6DQotIGZpeCBk
b2N1bWVudGF0aW9uIGluIFtQQVRDSCAwNC8xNF0NCi0gcmVtb3ZlIHVzZWxlc3MgdmFyaWFibGUg
Y2hlY2tpbmcgYW5kIHJldXNlIEFQSSBvZiBjbG9jayBjb250cm9sIGluIFtQQVRDSCAwNi8xNF0N
Ci0gY29kaW5nIHN0eWxlIGZpeCBvZiBidXMgcHJvdGVjdGlvbiBjb250cm9sIGluIFtQQVRDSCAw
OC8xNF0NCi0gZml4IG5hbWluZyBvZiBuZXcgYWRkZWQgZGF0YSBpbiBbUEFUQ0ggMDkvMTRdDQot
IHNtYWxsIHJlZmFjdG9yIG9mIG11bHRpcGxlIHN0ZXAgYnVzIHByb3RlY3Rpb24gY29udHJvbCBp
biBbUEFUQ0ggMTAvMTRdDQoNCmNoYW5nZXMgc2luY2UgdjQ6DQotIGFkZCBwcm9wZXJ0eSB0byBt
dDgxODMgc21pLWNvbW1vbg0KLSBzZXBlcmF0ZSByZWZhY3RvciBwYXRjaGVzIGFuZCBuZXcgYWRk
IGZ1bmN0aW9uDQotIGFkZCBwb3dlciBjb250cm9sbGVyIGRldmljZSBub2RlDQoNCg0KV2VpeWkg
THUgKDExKToNCiAgZHQtYmluZGluZ3M6IG1lZGlhdGVrOiBBZGQgcHJvcGVydHkgdG8gbXQ4MTgz
IHNtaS1jb21tb24NCiAgZHQtYmluZGluZ3M6IHNvYzogQWRkIE1UODE4MyBwb3dlciBkdC1iaW5k
aW5ncw0KICBzb2M6IG1lZGlhdGVrOiBBZGQgYmFzaWNfY2xrX25hbWUgdG8gc2NwX3Bvd2VyX2Rh
dGENCiAgc29jOiBtZWRpYXRlazogUmVtb3ZlIGluZnJhY2ZnIG1pc2MgZHJpdmVyIHN1cHBvcnQN
CiAgc29jOiBtZWRpYXRlazogQWRkIG11bHRpcGxlIHN0ZXAgYnVzIHByb3RlY3Rpb24gY29udHJv
bA0KICBzb2M6IG1lZGlhdGVrOiBBZGQgc3Vic3lzIGNsb2NrIGNvbnRyb2wgZm9yIGJ1cyBwcm90
ZWN0aW9uDQogIHNvYzogbWVkaWF0ZWs6IEFkZCBleHRyYSBzcmFtIGNvbnRyb2wNCiAgc29jOiBt
ZWRpYXRlazogQWRkIE1UODE4MyBzY3BzeXMgc3VwcG9ydA0KICBzb2M6IG1lZGlhdGVrOiBBZGQg
YSBjb21tYSBhdCB0aGUgZW5kDQogIGFybTY0OiBkdHM6IEFkZCBwb3dlciBjb250cm9sbGVyIGRl
dmljZSBub2RlIG9mIE1UODE4Mw0KICBhcm02NDogZHRzOiBBZGQgcG93ZXItZG9tYWlucyBwcm9w
ZXJ0eSB0byBtZmdjZmcNCg0KIC4uLi9tZWRpYXRlayxzbWktY29tbW9uLnR4dCAgICAgICAgICAg
ICAgICAgICB8ICAgMiArLQ0KIC4uLi9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvc2Nwc3lzLnR4dCAg
ICAgICAgICB8ICAyMSArLQ0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0
c2kgICAgICB8ICA2MyArKw0KIGRyaXZlcnMvc29jL21lZGlhdGVrL0tjb25maWcgICAgICAgICAg
ICAgICAgICB8ICAxMCAtDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvTWFrZWZpbGUgICAgICAgICAg
ICAgICAgIHwgICAxIC0NCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstaW5mcmFjZmcuYyAgICAg
ICAgICAgfCAgNzkgLS0NCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMgICAgICAg
ICAgICAgfCA3MDYgKysrKysrKysrKysrKystLS0tDQogaW5jbHVkZS9kdC1iaW5kaW5ncy9wb3dl
ci9tdDgxODMtcG93ZXIuaCAgICAgIHwgIDI2ICsNCiBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRl
ay9pbmZyYWNmZy5oICAgICAgICAgfCAgMzkgLQ0KIDkgZmlsZXMgY2hhbmdlZCwgNjcyIGluc2Vy
dGlvbnMoKyksIDI3NSBkZWxldGlvbnMoLSkNCiBkZWxldGUgbW9kZSAxMDA2NDQgZHJpdmVycy9z
b2MvbWVkaWF0ZWsvbXRrLWluZnJhY2ZnLmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9k
dC1iaW5kaW5ncy9wb3dlci9tdDgxODMtcG93ZXIuaA0KIGRlbGV0ZSBtb2RlIDEwMDY0NCBpbmNs
dWRlL2xpbnV4L3NvYy9tZWRpYXRlay9pbmZyYWNmZy5oDQo=

