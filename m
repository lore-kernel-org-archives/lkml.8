Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0250C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DBC2207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mYGSf1IR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgFQHFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 03:05:30 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48341 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725536AbgFQHF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 03:05:28 -0400
X-UUID: 23b19076638946138ae6580fd018c808-20200617
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=gkAfTQ6LXNQUT6avn+z4zRQbIwl9KPfbe41nK8IyoMc=;
        b=mYGSf1IREzBi5YPYHm4nsq8fMb2Ju3pek1fbAwr4fHOGpkzHaAWrJk2MbdvubyS3+jwG8NYqHvaRWOq8RYaXIQJsdDkvb7b+CyguDhHmON6uJMTL6351OqF0O4leRygHGqWpS3WMltjfM8BEjBkmPkVKrvofGCYCWlJJUi79t3E=;
X-UUID: 23b19076638946138ae6580fd018c808-20200617
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 844726162; Wed, 17 Jun 2020 15:05:24 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 17 Jun 2020 15:05:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 17 Jun 2020 15:05:22 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
        Wendell Lin <wendell.lin@mediatek.com>
Subject: [PATCH v16 00/11] Mediatek MT8183 scpsys support 
Date:   Wed, 17 Jun 2020 15:05:06 +0800
Message-ID: <1592377517-14817-1-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBzZXJpZXMgaXMgYmFzZWQgb24gdjUuOC1yYzENCg0KY2hhbmdlIHNpbmNlIHYxNToNCi0g
cmVtb3ZlIHVubmVlZGVkIGVycm9yIGxvZyBpbiBbUEFUQ0ggMDYvMTFdDQoNCmNoYW5nZXMgc2lu
Y2UgdjE0Og0KLSBmaXggY29tbWl0IG1lc3NhZ2UgdHlwbw0KLSB1c2UgcHJvcGVydHkgbmFtZSAi
bWVkaWF0ZWssc21pIiBmb3Igc21pIHBoYW5kbGUNCg0KY2hhbmdlcyBzaW5jZSB2MTM6DQotIGRv
Y3VtZW50IG9wdGlvbmFsIHByb3BlcnR5ICJzbWktY29tbSINCi0gbW92ZSBkZWZpbmVzIGluIHNj
cHN5Yy5oIHRvIG10ay1zY3BzeXMuYyBkaXJlY3RseQ0KLSBtaW5vciBjb2Rpbmcgc3l0bGUgZml4
ZXMNCg0KY2hhbmdlIHNpbmNlIHYxMjoNCi0gc2VwYXJhdGUgdGhlIGZpeCBvZiBjb21tYSBhdCB0
aGUgZW5kIGludG8gYSBuZXcgcGF0Y2ggW1BBVENIIDA5LzExXQ0KDQpjaGFuZ2VzIHNpbmNlIHYx
MToNCi0gcmUtb3JkZXIgcGF0Y2hlcyAiUmVtb3ZlIGluZnJhY2ZnIG1pc2MgZHJpdmVyIHN1cHBv
cnQiIGFuZCAiQWRkIG11bHRpcGxlIHN0ZXAgYnVzIHByb3RlY3Rpb24iDQotIGFkZCBjYXAgTVRL
X1NDUERfU1JBTV9JU08gZm9yIGV4dHJhIHNyYW0gY29udHJvbA0KLSBtaW5vciBjb2Rpbmcgc3l0
bGUgZml4ZXMgYW5kIHJld29yZCBjb21taXQgbWVzc2FnZXMNCg0KY2hhbmdlcyBzaW5jZSB2MTA6
DQotIHNxdWFzaCBQQVRDSCAwNCBhbmQgUEFUQ0ggMDYgaW4gdjkgaW50byBpdHMgcHJldmlvdXMg
cGF0Y2gNCi0gYWRkICJpZ25vcmVfY2xyX2FjayIgZm9yIG11bHRpcGxlIHN0ZXAgYnVzIHByb3Rl
Y3Rpb24gY29udHJvbCB0byBoYXZlIGEgY2xlYW4gZGVmaW5pdGlvbiBvZiBwb3dlciBkb21haW4g
ZGF0YQ0KLSBrZWVwIHRoZSBtYXNrIHJlZ2lzdGVyIGJpdCBkZWZpbml0aW9ucyBhbmQgZG8gdGhl
IHNhbWUgZm9yIE1UODE4Mw0KDQpjaGFuZ2VzIHNpbmNlIHY5Og0KLSBhZGQgbmV3IFBBVENIIDA0
IGFuZCBQQVRDSCAwNiB0byByZXBsYWNlIGJ5IG5ldyBtZXRob2QgZm9yIGFsbCBjb21wYXRpYmxl
cw0KLSBhZGQgbmV3IFBBVENIIDA3IHRvIHJlbW92ZSBpbmZyYWNmZyBtaXNjIGRyaXZlcg0KLSBt
aW5vciBjb2Rpbmcgc3l0bGUgZml4DQoNCmNoYW5nZXMgc2luY2Ugdjc6DQotIHJld29yZCBpbiBi
aW5kaW5nIGRvY3VtZW50IFtQQVRDSCAwMi8xNF0NCi0gZml4IGVycm9yIHJldHVybiBjaGVja2lu
ZyBidWcgaW4gc3Vic3lzIGNsb2NrIGNvbnRyb2wgW1BBVENIIDEwLzE0XQ0KLSBhZGQgcG93ZXIg
ZG9tYWlucyBwcm9wZXJpdHkgdG8gbWZnY2ZnIHBhdGNoIFtQQVRDSCAxNC8xNF0gZnJvbQ0KICBo
dHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzExMTI2MTk5Lw0KDQpjaGFuZ2VzIHNp
bmNlIHY2Og0KLSByZW1vdmUgdGhlIHBhdGNoIG9mIFNQRFggbGljZW5zZSBpZGVudGlmaWVyIGJl
Y2F1c2UgaXQncyBhbHJlYWR5IGZpeGVkDQoNCmNoYW5nZXMgc2luY2UgdjU6DQotIGZpeCBkb2N1
bWVudGF0aW9uIGluIFtQQVRDSCAwNC8xNF0NCi0gcmVtb3ZlIHVzZWxlc3MgdmFyaWFibGUgY2hl
Y2tpbmcgYW5kIHJldXNlIEFQSSBvZiBjbG9jayBjb250cm9sIGluIFtQQVRDSCAwNi8xNF0NCi0g
Y29kaW5nIHN0eWxlIGZpeCBvZiBidXMgcHJvdGVjdGlvbiBjb250cm9sIGluIFtQQVRDSCAwOC8x
NF0NCi0gZml4IG5hbWluZyBvZiBuZXcgYWRkZWQgZGF0YSBpbiBbUEFUQ0ggMDkvMTRdDQotIHNt
YWxsIHJlZmFjdG9yIG9mIG11bHRpcGxlIHN0ZXAgYnVzIHByb3RlY3Rpb24gY29udHJvbCBpbiBb
UEFUQ0ggMTAvMTRdDQoNCmNoYW5nZXMgc2luY2UgdjQ6DQotIGFkZCBwcm9wZXJ0eSB0byBtdDgx
ODMgc21pLWNvbW1vbg0KLSBzZXBlcmF0ZSByZWZhY3RvciBwYXRjaGVzIGFuZCBuZXcgYWRkIGZ1
bmN0aW9uDQotIGFkZCBwb3dlciBjb250cm9sbGVyIGRldmljZSBub2RlDQoNCg0KV2VpeWkgTHUg
KDExKToNCiAgZHQtYmluZGluZ3M6IG1lZGlhdGVrOiBBZGQgcHJvcGVydHkgdG8gbXQ4MTgzIHNt
aS1jb21tb24NCiAgZHQtYmluZGluZ3M6IHNvYzogQWRkIE1UODE4MyBwb3dlciBkdC1iaW5kaW5n
cw0KICBzb2M6IG1lZGlhdGVrOiBBZGQgYmFzaWNfY2xrX25hbWUgdG8gc2NwX3Bvd2VyX2RhdGEN
CiAgc29jOiBtZWRpYXRlazogUmVtb3ZlIGluZnJhY2ZnIG1pc2MgZHJpdmVyIHN1cHBvcnQNCiAg
c29jOiBtZWRpYXRlazogQWRkIG11bHRpcGxlIHN0ZXAgYnVzIHByb3RlY3Rpb24gY29udHJvbA0K
ICBzb2M6IG1lZGlhdGVrOiBBZGQgc3Vic3lzIGNsb2NrIGNvbnRyb2wgZm9yIGJ1cyBwcm90ZWN0
aW9uDQogIHNvYzogbWVkaWF0ZWs6IEFkZCBleHRyYSBzcmFtIGNvbnRyb2wNCiAgc29jOiBtZWRp
YXRlazogQWRkIE1UODE4MyBzY3BzeXMgc3VwcG9ydA0KICBzb2M6IG1lZGlhdGVrOiBBZGQgYSBj
b21tYSBhdCB0aGUgZW5kDQogIGFybTY0OiBkdHM6IEFkZCBwb3dlciBjb250cm9sbGVyIGRldmlj
ZSBub2RlIG9mIE1UODE4Mw0KICBhcm02NDogZHRzOiBBZGQgcG93ZXItZG9tYWlucyBwcm9wZXJ0
eSB0byBtZmdjZmcNCg0KIC4uLi9tZWRpYXRlayxzbWktY29tbW9uLnR4dCAgICAgICAgICAgICAg
ICAgICB8ICAgMiArLQ0KIC4uLi9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvc2Nwc3lzLnR4dCAgICAg
ICAgICB8ICAyMSArLQ0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kg
ICAgICB8ICA2MyArKw0KIGRyaXZlcnMvc29jL21lZGlhdGVrL0tjb25maWcgICAgICAgICAgICAg
ICAgICB8ICAxMCAtDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvTWFrZWZpbGUgICAgICAgICAgICAg
ICAgIHwgICAxIC0NCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstaW5mcmFjZmcuYyAgICAgICAg
ICAgfCAgNzkgLS0NCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMgICAgICAgICAg
ICAgfCA3MDQgKysrKysrKysrKysrKystLS0tDQogaW5jbHVkZS9kdC1iaW5kaW5ncy9wb3dlci9t
dDgxODMtcG93ZXIuaCAgICAgIHwgIDI2ICsNCiBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9p
bmZyYWNmZy5oICAgICAgICAgfCAgMzkgLQ0KIDkgZmlsZXMgY2hhbmdlZCwgNjY5IGluc2VydGlv
bnMoKyksIDI3NiBkZWxldGlvbnMoLSkNCiBkZWxldGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zb2Mv
bWVkaWF0ZWsvbXRrLWluZnJhY2ZnLmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9kdC1i
aW5kaW5ncy9wb3dlci9tdDgxODMtcG93ZXIuaA0KIGRlbGV0ZSBtb2RlIDEwMDY0NCBpbmNsdWRl
L2xpbnV4L3NvYy9tZWRpYXRlay9pbmZyYWNmZy5oDQo=

