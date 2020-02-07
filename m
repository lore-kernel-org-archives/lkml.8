Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A64C352A4
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB38A20838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NppQX57f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgBGJXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 04:23:38 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:39177 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726417AbgBGJXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 04:23:37 -0500
X-UUID: 48944d527b0e4c689738fe6c9b65d3ad-20200207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=U8FRwP71b/QLr9XY8BWqKkhHb2z9q2xa/koQUBK/dBI=;
        b=NppQX57femOoZqrCThFU6mK3Iez7kVuIQh+bFga/JdK7FMGBlnK3f7iA0EB8C4EDy7mmeZrhzKI4f7oUvhJ1B73RCRyk/1x5chgiM0XZVO7GK3bj3ZtgMjooHqbl0CENrhtRWC1Uwfp1TFflZ3TwmJuYYvH08aGIqK+tHmEaP74=;
X-UUID: 48944d527b0e4c689738fe6c9b65d3ad-20200207
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2137306294; Fri, 07 Feb 2020 17:23:32 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 7 Feb 2020 17:24:18 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 7 Feb 2020 17:22:49 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        mtk01761 <wendell.lin@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "Evan Green" <evgreen@chromium.org>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <jroedel@suse.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>
CC:     Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
Subject: [PATCH v7 0/7] Add basic SoC support for mt6765
Date:   Fri, 7 Feb 2020 17:20:43 +0800
Message-ID: <1581067250-12744-1-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGRzIGJhc2ljIFNvQyBzdXBwb3J0IGZvciBNZWRpYXRlaydzIG5ldyA4LWNv
cmUgU29DLA0KTVQ2NzY1LCB3aGljaCBpcyBtYWlubHkgZm9yIHNtYXJ0cGhvbmUgYXBwbGljYXRp
b24uDQoNCkNoYW5nZXMgaW4gVjc6DQoxLiBBZGFwdCBWNidzIHBhdGNoc2V0IHRvIGxhdGVzdCBr
ZXJuZWwgdHJlZSA1LjUtcmMxLg0KICAgT3JpZ2luIFY2IHBhdGNoc2V0Og0KICAgaHR0cHM6Ly9w
YXRjaHdvcmsua2VybmVsLm9yZy9jb3Zlci8xMTA0MTk2My8NCjIuIENvcnJlY3QgMiBjbG9jay1j
b250cm9sbGVyIHR5cGUgaW4gZG9jdW1lbnRhdGlvbjoNCiAgIG1pcGkwIGFuZCB2ZW5jX2djb24u
DQogICBbdjcgMS83XSBkdC1iaW5kaW5nczogY2xvY2s6IG1lZGlhdGVrOiBkb2N1bWVudCBjbGsg
YmluZGluZ3MNCjMuIFJlbW92ZSBWNidzIHBhdGNoIDAzIGJlY2F1c2UgaXQgaGFzIGJlZW4gdGFr
ZW4gaW50byA1LjUtbmV4dC1zb2MNCiAgIFt2NiwgMDMvMDhdIGR0LWJpbmRpbmdzOiBtZWRpYXRl
azogYWRkIE1UNjc2NSBwb3dlciBkdC1iaW5kaW5ncw0KMy4gVXBkYXRlIFJldmlld2VkLWJ5OiBS
b2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPiBmb3INCiAgIFt2NiwgMDQvMDhdIGNsazogbWVk
aWF0ZWs6IGFkZCBtdDY3NjUgY2xvY2sgSURzDQogICAtLT4gW3Y3LCAwMy8wN10gY2xrOiBtZWRp
YXRlazogYWRkIG10Njc2NSBjbG9jayBJRHMNCjQuIFVwZGF0ZSBTUERYIHRhZyBmb3INCiAgIFt2
NiwgMDUvMDhdIGNsazogbWVkaWF0ZWs6IEFkZCBNVDY3NjUgY2xvY2sgc3VwcG9ydA0KICAgLS0+
IFt2NywgMDQvMDddIGNsazogbWVkaWF0ZWs6IEFkZCBNVDY3NjUgY2xvY2sgc3VwcG9ydA0KDQpD
aGFuZ2VzIGluIFY2Og0KMS4gQWRhcHQgVjUncyBwYXRjaHNldCB0byBsYXRlc3Qga2VybmVsIHRy
ZWUuDQogICBPcmlnaW4gVjUgcGF0Y2hzZXQuDQogICBodHRwczovL2xvcmUua2VybmVsLm9yZy9w
YXRjaHdvcmsvY292ZXIvOTYzNjEyLw0KMi4gRHVlIHRvIGNsaydzIGNvbW1vbiBjb2RlIGhhcyBi
ZWVuIHN1Ym1pdCBieSBvdGhlciBwbGF0Zm9ybSwNCiAgIHRoaXMgcGF0Y2ggc2V0IHdpbGwgaGF2
ZSBkZXBlbmRlbmNpZXMgd2l0aCB0aGUgZm9sbG93aW5nIHBhdGNoc2V0cw0KICAgYXMgdGhlIGZv
bGxvd2luZyBvcmRlcnMuDQogICAyLmEuIFt2OCwwMC8yMV0gTVQ4MTgzIElPTU1VIFNVUFBPUlQN
CiAgICAgICAgaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9jb3Zlci8xMTAyMzU4NS8NCiAg
IDIuYi4gW3YxMSwwLzZdIEFkZCBiYXNpYyBub2RlIHN1cHBvcnQgZm9yIE1lZGlhdGVrIE1UODE4
MyBTb0MNCiAgICAgICAgaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9jb3Zlci8xMDk2MjM4
NS8NCiAgIDIuYy4gW3Y2LDAwLzE0XSBNZWRpYXRlayBNVDgxODMgc2Nwc3lzIHN1cHBvcnQNCiAg
ICAgICAgaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9jb3Zlci8xMTAwNTc1MS8NCjMuIENv
cnJlY3QgcG93ZXIgcmVsYXRlZCBwYXRjaGVzIGludG8gZHQtYmluZGluZyBwYXRjaGVzLg0KNC4g
UmUtb3JkZXIgVjUncyA0LzExLCA2LzExLCBhbmQgNy8xMSBkdWUgY2xrIGNvbW1vbiBjb2RlIGNo
YW5nZQ0KICAgYW5kIG1ha2UgZGVwZW5kZW5jaWVzIGluIG9yZGVyLg0KNS4gVXBkYXRlIHNvbWUg
Y29tbWl0IG1lc3NhZ2UgaW4gY2xrIHJlbGF0ZWQgcGF0Y2hlcy4NCg0KQ2hhbmdlcyBpbiBWNToN
CjEuIGFkZCBjbGsgc3VwcG9ydA0KDQpDaGFuZ2VzIGluIFY0Og0KMS4gYWRkIGdpYydzIHNldHRp
bmdzIGluIHJlZyBwcm9wZXJ0aWVzDQoyLiByZW1vdmUgc29tZSBwYXRjaGVzIGFib3V0IGR0LWJp
bmRpbmdzIHNpbmNlIEdLSCBhbHJlYWR5IHRvb2sgdGhlbQ0KDQpDaGFuZ2VzIGluIFYzOg0KMS4g
c3BsaXQgZHQtYmluZGluZyBkb2N1bWVudCBwYXRjaHMNCjIuIGZpeCBtdDY3NjUuZHRzaSB3YXJu
aW5ncyB3aXRoIFc9MTINCjMuIHJlbW92ZSB1bmNlc3NhcnkgUFBJIGFmZmluaXR5IGZvciB0aW1l
cg0KNC4gYWRkIGdpY2MgYmFzZSBmb3IgZ2ljIGR0IG5vZGUNCg0KQ2hhbmdlcyBpbiBWMjoNCjEu
IGZpeCBjbGsgcHJvcGVydGllcyBpbiB1YXJ0IGR0cyBub2RlDQoyLiBmaXggdHlwbyBpbiBzdWJt
aXQgdGl0bGUNCjMuIGFkZCBzaW1wbGUtYnVzIGluIG10Njc2NS5kdHNpDQo0LiB1c2UgY29ycmVj
dCBTUERYIGxpY2Vuc2UgZm9ybWF0DQoNCk1hcnMgQ2hlbmcgKDUpOg0KICBkdC1iaW5kaW5nczog
Y2xvY2s6IG1lZGlhdGVrOiBkb2N1bWVudCBjbGsgYmluZGluZ3MgZm9yIE1lZGlhdGVrDQogICAg
TVQ2NzY1IFNvQw0KICBkdC1iaW5kaW5nczogbWVkaWF0ZWs6IEFkZCBzbWkgZHRzIGJpbmRpbmcg
Zm9yIE1lZGlhdGVrIE1UNjc2NSBTb0MNCiAgY2xrOiBtZWRpYXRlazogYWRkIG10Njc2NSBjbG9j
ayBJRHMNCiAgc29jOiBtZWRpYXRlazogYWRkIE1UNjc2NSBzY3BzeXMgYW5kIHN1YmRvbWFpbiBz
dXBwb3J0DQogIGFybTY0OiBkdHM6IG1lZGlhdGVrOiBhZGQgbXQ2NzY1IHN1cHBvcnQNCg0KT3dl
biBDaGVuICgyKToNCiAgY2xrOiBtZWRpYXRlazogQWRkIE1UNjc2NSBjbG9jayBzdXBwb3J0DQog
IGFybTY0OiBkZWZjb25maWc6IGFkZCBDT05GSUdfQ09NTU9OX0NMS19NVDY3NjVfWFhYIGNsb2Nr
cw0KDQogLi4uL2FybS9tZWRpYXRlay9tZWRpYXRlayxhcG1peGVkc3lzLnR4dCAgICAgIHwgICAx
ICsNCiAuLi4vYmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLGF1ZHN5cy50eHQgfCAgIDEg
Kw0KIC4uLi9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssY2Ftc3lzLnR4dCB8ICAgMSAr
DQogLi4uL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxpbWdzeXMudHh0IHwgICAxICsN
CiAuLi4vYXJtL21lZGlhdGVrL21lZGlhdGVrLGluZnJhY2ZnLnR4dCAgICAgICAgfCAgIDEgKw0K
IC4uLi9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssbWlwaTBhLnR4dCB8ICAyOCArDQog
Li4uL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxtbXN5cy50eHQgIHwgICAxICsNCiAu
Li4vYXJtL21lZGlhdGVrL21lZGlhdGVrLHBlcmljZmcudHh0ICAgICAgICAgfCAgIDEgKw0KIC4u
Li9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssdG9wY2tnZW4udHh0ICAgICAgICB8ICAgMSArDQogLi4u
L2FybS9tZWRpYXRlay9tZWRpYXRlayx2Y29kZWNzeXMudHh0ICAgICAgIHwgIDI3ICsNCiAuLi4v
bWVkaWF0ZWssc21pLWNvbW1vbi50eHQgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KIGFyY2gv
YXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvTWFrZWZpbGUgICAgICAgICB8ICAgMSArDQogYXJjaC9h
cm02NC9ib290L2R0cy9tZWRpYXRlay9tdDY3NjUtZXZiLmR0cyAgIHwgIDMzICsNCiBhcmNoL2Fy
bTY0L2Jvb3QvZHRzL21lZGlhdGVrL210Njc2NS5kdHNpICAgICAgfCAyNTMgKysrKysNCiBhcmNo
L2FybTY0L2NvbmZpZ3MvZGVmY29uZmlnICAgICAgICAgICAgICAgICAgfCAgIDYgKw0KIGRyaXZl
cnMvY2xrL21lZGlhdGVrL0tjb25maWcgICAgICAgICAgICAgICAgICB8ICA4NiArKw0KIGRyaXZl
cnMvY2xrL21lZGlhdGVrL01ha2VmaWxlICAgICAgICAgICAgICAgICB8ICAgNyArDQogZHJpdmVy
cy9jbGsvbWVkaWF0ZWsvY2xrLW10Njc2NS1hdWRpby5jICAgICAgIHwgMTAwICsrDQogZHJpdmVy
cy9jbGsvbWVkaWF0ZWsvY2xrLW10Njc2NS1jYW0uYyAgICAgICAgIHwgIDc0ICsrDQogZHJpdmVy
cy9jbGsvbWVkaWF0ZWsvY2xrLW10Njc2NS1pbWcuYyAgICAgICAgIHwgIDcwICsrDQogZHJpdmVy
cy9jbGsvbWVkaWF0ZWsvY2xrLW10Njc2NS1taXBpMGEuYyAgICAgIHwgIDY4ICsrDQogZHJpdmVy
cy9jbGsvbWVkaWF0ZWsvY2xrLW10Njc2NS1tbS5jICAgICAgICAgIHwgIDk2ICsrDQogZHJpdmVy
cy9jbGsvbWVkaWF0ZWsvY2xrLW10Njc2NS12Y29kZWMuYyAgICAgIHwgIDcwICsrDQogZHJpdmVy
cy9jbGsvbWVkaWF0ZWsvY2xrLW10Njc2NS5jICAgICAgICAgICAgIHwgOTUyICsrKysrKysrKysr
KysrKysrKw0KIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1zY3BzeXMuYyAgICAgICAgICAgICB8
IDEzMCArKysNCiBpbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL210Njc2NS1jbGsuaCAgICAgICAg
fCAzMTMgKysrKysrDQogMjYgZmlsZXMgY2hhbmdlZCwgMjMyMyBpbnNlcnRpb25zKCspDQogY3Jl
YXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVk
aWF0ZWsvbWVkaWF0ZWssbWlwaTBhLnR4dA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLHZjb2RlY3N5cy50
eHQNCiBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDY3
NjUtZXZiLmR0cw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlh
dGVrL210Njc2NS5kdHNpDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvY2xrL21lZGlhdGVr
L2Nsay1tdDY3NjUtYXVkaW8uYw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2Nsay9tZWRp
YXRlay9jbGstbXQ2NzY1LWNhbS5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvY2xrL21l
ZGlhdGVrL2Nsay1tdDY3NjUtaW1nLmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9jbGsv
bWVkaWF0ZWsvY2xrLW10Njc2NS1taXBpMGEuYw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJz
L2Nsay9tZWRpYXRlay9jbGstbXQ2NzY1LW1tLmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVy
cy9jbGsvbWVkaWF0ZWsvY2xrLW10Njc2NS12Y29kZWMuYw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBk
cml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ2NzY1LmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5j
bHVkZS9kdC1iaW5kaW5ncy9jbG9jay9tdDY3NjUtY2xrLmgNCg0KLS0gDQoyLjE4LjANCg==

