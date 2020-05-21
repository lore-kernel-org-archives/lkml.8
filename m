Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F1BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A15502070A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="U6V+YesH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgEUJGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 05:06:40 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:40843 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728735AbgEUJGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 05:06:35 -0400
X-UUID: c915ebb3d8ac487488439fe24f0d9230-20200521
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=7jb495E0gp5iA5G5xPrOIXGz/+nrJXvmp3hVaXHcEPo=;
        b=U6V+YesHXiNf+uU0SymuhNNYNGXaXkMrr9hJ0rNb8M3zJJ5ETlAF5aTFn+yxSeYJOfZQOCrVYpHCmu4kAd/DpWHR3Mvh9x/jg8MogyjikoGRJWKXtQMefPNhL4v1HqFse2BtX7NVdnxILr8ZAu4gs1lKUqgCXmYNhu1JtBIJcE4=;
X-UUID: c915ebb3d8ac487488439fe24f0d9230-20200521
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 930137302; Thu, 21 May 2020 17:06:31 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 17:06:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 21 May 2020 17:06:28 +0800
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
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v15 00/11] Mediatek MT8183 scpsys support  
Date:   Thu, 21 May 2020 17:06:13 +0800
Message-ID: <1590051985-29149-1-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBzZXJpZXMgaXMgYmFzZWQgb24gdjUuNy1yYzENCg0KY2hhbmdlcyBzaW5jZSB2MTQ6DQot
IGZpeCBjb21taXQgbWVzc2FnZSB0eXBvDQotIHVzZSBwcm9wZXJ0eSBuYW1lICJtZWRpYXRlayxz
bWkiIGZvciBzbWkgcGhhbmRsZQ0KDQpjaGFuZ2VzIHNpbmNlIHYxMzoNCi0gZG9jdW1lbnQgb3B0
aW9uYWwgcHJvcGVydHkgInNtaS1jb21tIg0KLSBtb3ZlIGRlZmluZXMgaW4gc2Nwc3ljLmggdG8g
bXRrLXNjcHN5cy5jIGRpcmVjdGx5DQotIG1pbm9yIGNvZGluZyBzeXRsZSBmaXhlcw0KDQpjaGFu
Z2Ugc2luY2UgdjEyOg0KLSBzZXBhcmF0ZSB0aGUgZml4IG9mIGNvbW1hIGF0IHRoZSBlbmQgaW50
byBhIG5ldyBwYXRjaCBbUEFUQ0ggMDkvMTFdDQoNCmNoYW5nZXMgc2luY2UgdjExOg0KLSByZS1v
cmRlciBwYXRjaGVzICJSZW1vdmUgaW5mcmFjZmcgbWlzYyBkcml2ZXIgc3VwcG9ydCIgYW5kICJB
ZGQgbXVsdGlwbGUgc3RlcCBidXMgcHJvdGVjdGlvbiINCi0gYWRkIGNhcCBNVEtfU0NQRF9TUkFN
X0lTTyBmb3IgZXh0cmEgc3JhbSBjb250cm9sDQotIG1pbm9yIGNvZGluZyBzeXRsZSBmaXhlcyBh
bmQgcmV3b3JkIGNvbW1pdCBtZXNzYWdlcw0KDQpjaGFuZ2VzIHNpbmNlIHYxMDoNCi0gc3F1YXNo
IFBBVENIIDA0IGFuZCBQQVRDSCAwNiBpbiB2OSBpbnRvIGl0cyBwcmV2aW91cyBwYXRjaA0KLSBh
ZGQgImlnbm9yZV9jbHJfYWNrIiBmb3IgbXVsdGlwbGUgc3RlcCBidXMgcHJvdGVjdGlvbiBjb250
cm9sIHRvIGhhdmUgYSBjbGVhbiBkZWZpbml0aW9uIG9mIHBvd2VyIGRvbWFpbiBkYXRhDQotIGtl
ZXAgdGhlIG1hc2sgcmVnaXN0ZXIgYml0IGRlZmluaXRpb25zIGFuZCBkbyB0aGUgc2FtZSBmb3Ig
TVQ4MTgzDQoNCmNoYW5nZXMgc2luY2Ugdjk6DQotIGFkZCBuZXcgUEFUQ0ggMDQgYW5kIFBBVENI
IDA2IHRvIHJlcGxhY2UgYnkgbmV3IG1ldGhvZCBmb3IgYWxsIGNvbXBhdGlibGVzDQotIGFkZCBu
ZXcgUEFUQ0ggMDcgdG8gcmVtb3ZlIGluZnJhY2ZnIG1pc2MgZHJpdmVyDQotIG1pbm9yIGNvZGlu
ZyBzeXRsZSBmaXgNCg0KY2hhbmdlcyBzaW5jZSB2NzoNCi0gcmV3b3JkIGluIGJpbmRpbmcgZG9j
dW1lbnQgW1BBVENIIDAyLzE0XQ0KLSBmaXggZXJyb3IgcmV0dXJuIGNoZWNraW5nIGJ1ZyBpbiBz
dWJzeXMgY2xvY2sgY29udHJvbCBbUEFUQ0ggMTAvMTRdDQotIGFkZCBwb3dlciBkb21haW5zIHBy
b3Blcml0eSB0byBtZmdjZmcgcGF0Y2ggW1BBVENIIDE0LzE0XSBmcm9tDQogIGh0dHBzOi8vcGF0
Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTExMjYxOTkvDQoNCmNoYW5nZXMgc2luY2UgdjY6DQot
IHJlbW92ZSB0aGUgcGF0Y2ggb2YgU1BEWCBsaWNlbnNlIGlkZW50aWZpZXIgYmVjYXVzZSBpdCdz
IGFscmVhZHkgZml4ZWQNCg0KY2hhbmdlcyBzaW5jZSB2NToNCi0gZml4IGRvY3VtZW50YXRpb24g
aW4gW1BBVENIIDA0LzE0XQ0KLSByZW1vdmUgdXNlbGVzcyB2YXJpYWJsZSBjaGVja2luZyBhbmQg
cmV1c2UgQVBJIG9mIGNsb2NrIGNvbnRyb2wgaW4gW1BBVENIIDA2LzE0XQ0KLSBjb2Rpbmcgc3R5
bGUgZml4IG9mIGJ1cyBwcm90ZWN0aW9uIGNvbnRyb2wgaW4gW1BBVENIIDA4LzE0XQ0KLSBmaXgg
bmFtaW5nIG9mIG5ldyBhZGRlZCBkYXRhIGluIFtQQVRDSCAwOS8xNF0NCi0gc21hbGwgcmVmYWN0
b3Igb2YgbXVsdGlwbGUgc3RlcCBidXMgcHJvdGVjdGlvbiBjb250cm9sIGluIFtQQVRDSCAxMC8x
NF0NCg0KY2hhbmdlcyBzaW5jZSB2NDoNCi0gYWRkIHByb3BlcnR5IHRvIG10ODE4MyBzbWktY29t
bW9uDQotIHNlcGVyYXRlIHJlZmFjdG9yIHBhdGNoZXMgYW5kIG5ldyBhZGQgZnVuY3Rpb24NCi0g
YWRkIHBvd2VyIGNvbnRyb2xsZXIgZGV2aWNlIG5vZGUNCg0KDQpXZWl5aSBMdSAoMTEpOg0KICBk
dC1iaW5kaW5nczogbWVkaWF0ZWs6IEFkZCBwcm9wZXJ0eSB0byBtdDgxODMgc21pLWNvbW1vbg0K
ICBkdC1iaW5kaW5nczogc29jOiBBZGQgTVQ4MTgzIHBvd2VyIGR0LWJpbmRpbmdzDQogIHNvYzog
bWVkaWF0ZWs6IEFkZCBiYXNpY19jbGtfbmFtZSB0byBzY3BfcG93ZXJfZGF0YQ0KICBzb2M6IG1l
ZGlhdGVrOiBSZW1vdmUgaW5mcmFjZmcgbWlzYyBkcml2ZXIgc3VwcG9ydA0KICBzb2M6IG1lZGlh
dGVrOiBBZGQgbXVsdGlwbGUgc3RlcCBidXMgcHJvdGVjdGlvbiBjb250cm9sDQogIHNvYzogbWVk
aWF0ZWs6IEFkZCBzdWJzeXMgY2xvY2sgY29udHJvbCBmb3IgYnVzIHByb3RlY3Rpb24NCiAgc29j
OiBtZWRpYXRlazogQWRkIGV4dHJhIHNyYW0gY29udHJvbA0KICBzb2M6IG1lZGlhdGVrOiBBZGQg
TVQ4MTgzIHNjcHN5cyBzdXBwb3J0DQogIHNvYzogbWVkaWF0ZWs6IEFkZCBhIGNvbW1hIGF0IHRo
ZSBlbmQNCiAgYXJtNjQ6IGR0czogQWRkIHBvd2VyIGNvbnRyb2xsZXIgZGV2aWNlIG5vZGUgb2Yg
TVQ4MTgzDQogIGFybTY0OiBkdHM6IEFkZCBwb3dlci1kb21haW5zIHByb3BlcnR5IHRvIG1mZ2Nm
Zw0KDQogLi4uL21lZGlhdGVrLHNtaS1jb21tb24udHh0ICAgICAgICAgICAgICAgICAgIHwgICAy
ICstDQogLi4uL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9zY3BzeXMudHh0ICAgICAgICAgIHwgIDIx
ICstDQogYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaSAgICAgIHwgIDYz
ICsrDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvS2NvbmZpZyAgICAgICAgICAgICAgICAgIHwgIDEw
IC0NCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9NYWtlZmlsZSAgICAgICAgICAgICAgICAgfCAgIDEg
LQ0KIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1pbmZyYWNmZy5jICAgICAgICAgICB8ICA3OSAt
LQ0KIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1zY3BzeXMuYyAgICAgICAgICAgICB8IDcwNiAr
KysrKysrKysrKysrKy0tLS0NCiBpbmNsdWRlL2R0LWJpbmRpbmdzL3Bvd2VyL210ODE4My1wb3dl
ci5oICAgICAgfCAgMjYgKw0KIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL2luZnJhY2ZnLmgg
ICAgICAgICB8ICAzOSAtDQogOSBmaWxlcyBjaGFuZ2VkLCA2NzIgaW5zZXJ0aW9ucygrKSwgMjc1
IGRlbGV0aW9ucygtKQ0KIGRlbGV0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3NvYy9tZWRpYXRlay9t
dGstaW5mcmFjZmcuYw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2R0LWJpbmRpbmdzL3Bv
d2VyL210ODE4My1wb3dlci5oDQogZGVsZXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGludXgvc29j
L21lZGlhdGVrL2luZnJhY2ZnLmgNCg==

