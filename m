Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A00C47257
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7169624962
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Jte3LpSy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgEIIkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 04:40:15 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:25719 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725989AbgEIIkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 04:40:12 -0400
X-UUID: bf36ffa561524864acf14c174073ea1c-20200509
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=8cJ2Ck2ZkeoyWBaJou7BzsCQTavbcjr0MJiOjUbB1nM=;
        b=Jte3LpSy0oHGF5A97JMTTFZbahJ0bK2rPOex9c4JTQUtf2A+nUwSqCI2TULzEbpJJbxQMnDPnoZ1yKxQckwaDXrslIxB2qacx+UdXS/g/4z9CNnTh7krqg+GXMmFDWp8rTBwgVilTRk9ywoiaSTZO9oa+X67oLSwnTMZb0BYNpU=;
X-UUID: bf36ffa561524864acf14c174073ea1c-20200509
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 13579321; Sat, 09 May 2020 16:40:08 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 9 May 2020 16:39:59 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 9 May 2020 16:39:57 +0800
From:   Chao Hao <chao.hao@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, FY Yang <fy.yang@mediatek.com>,
        Jun Yan <jun.yan@mediatek.com>
Subject: [PATCH v3 00/07] MT6779 IOMMU SUPPORT
Date:   Sat, 9 May 2020 16:36:47 +0800
Message-ID: <20200509083654.5178-1-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 787C31370C7B63E58BF1FD368BE1E5CDBF48371E6A6CE604E182B13E85A5061A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaHNldCBhZGRzIG10Njc3OSBpb21tdSBzdXBwb3J0Lg0KDQptdDY3NzkgaGFzIHR3
byBpb21tdXMsIHRoZXkgYXJlIE1NX0lPTU1VKE00VSkgYW5kIEFQVV9JT01NVSB3aGljaCB1c2Vk
IEFSTSBTaG9ydC1EZXNjcmlwdG9yIHRyYW5zbGF0aW9uIGZvcm1hdC4NClRoZSBtdDY3NzkncyBN
TV9JT01NVS1TTUkgYW5kIEFQVV9JT01NVSBIVyBkaWFncmFtIGlzIGFzIGJlbG93LCBpdCBpcyBv
bmx5IGEgYnJpZWYgZGlhZ3JhbToNCg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFTUkN
CgkJCSAgICAgIHwNCgkgICAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
CSAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8DQogICAgICAgTU1fSU9N
TVUgICAgICAgICAgICAgICAgICAgICAgICAgICAgQVBVX0lPTU1VDQogICAgICAgICAgIHwgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8DQogICAgICAgU01JX0NPTU1PTS0tLS0t
LS0tLS0tICAgICAgICAgICAgICAgICBBUFVfQlVTDQogICAgICAgICAgIHwgICAgICAgICAgICAg
ICAgfCAgICAgICAgICAgICAgICAgICB8DQogICAgICBTTUlfTEFSQigwfjExKSAgICAgICAgfCAg
ICAgICAgICAgICAgICAgICB8DQogICAgICAgICAgIHwgICAgICAgICAgICAgICAgfCAgICAgICAg
ICAgICAgICAgICB8DQogICAgICAgICAgIHwgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAt
LS0tLS0tLS0tLS0tLQ0KICAgICAgICAgICB8ICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAg
fCAgICAgfCAgICAgIHwNCiAgICBNdWx0aW1lZGlhIGVuZ2luZSAgICAgIENDVSAgICAgICAgICAg
VlBVICAgTURMQSAgIEVNREENCg0KQWxsIHRoZSBjb25uZWN0aW9ucyBhcmUgaGFyZHdhcmUgZml4
ZWQsIHNvZnR3YXJlIGNhbiBub3QgYWRqdXN0IGl0Lg0KDQpDb21wYXJlZCB3aXRoIG10ODE4Mywg
U01JX0JVU19JRCB3aWR0aCBoYXMgY2hhbmdlZCBmcm9tIDEwIHRvIDEyLiBTTUkgTGFyYiBudW1i
ZXIgaXMgZGVzY3JpYmVkIGluIGJpdFsxMTo3XSwNClBvcnQgbnVtYmVyIGlzIGRlc2NyaWJlZCBp
biBiaXRbNjoyXS4gSW4gYWRkaXRpb24sIHRoZXJlIGFyZSBzb21lIHJlZ2lzdGVycyBoYXMgY2hh
bmdlZCBpbiBtdDY3NzksIHNvIHdlIG5lZWQNCnRvIHJlZGVmaW5lIGFuZCByZXVzZSB0aGVtLg0K
DQpUaGUgcGF0Y2hzZXQgb25seSB1c2VkIE1NX0lPTU1VLCBzbyB3ZSBvbmx5IGFkZCBNTV9JT01N
VSBiYXNpYyBmdW5jdGlvbiwgc3VjaCBhcyBzbWlfbGFyYiBwb3J0IGRlZmluaXRpb24sIHJlZ2lz
dGVycw0KZGVmaW5pdGlvbiBhbmQgaGFyZHdhcmUgaW5pdGlhbGl6YXRpb24uDQoNCmNoYW5nZSBu
b3RlczoNCiB2MzoNCiAgMS4gUmViYXNlIG9uIHY1LjctcmMxLg0KICAyLiBSZW1vdmUgdW51c2Vk
IHBvcnQgZGVmaW5pdGlvbixleDpBUFUgYW5kIENDVSBwb3J0IGluIG10Njc3OS1sYXJiLXBvcnQu
aC4NCiAgMy4gUmVtb3ZlICJjaGFuZ2Ugc2luZ2xlIGRvbWFpbiB0byBtdWx0aXBsZSBkb21haW4i
IHBhcnQoZnJvbSBQQVRDSCB2MiAwOS8xOSB0byBQQVRDSCB2MiAxOS8xOSkuDQogIDQuIFJlZGVz
aWduIG10Njc3OSBiYXNpYyBwYXJ0DQogICAoMSlBZGQgc29tZSByZWdpc3RlciBkZWZpbml0aW9u
IGFuZCByZXVzZSB0aGVtLg0KICAgKDIpUmVkZXNpZ24gc21pIGxhcmIgYnVzIElEIHRvIGFuYWx5
emUgSU9NTVUgdHJhbnNsYXRpb24gZmF1bHQuDQogICAoMylPbmx5IGluaXQgTU1fSU9NTVUgYW5k
IG5vdCB1c2UgQVBVX0lPTU1VLg0KDQogdjI6DQogIDEuIFJlYmFzZSBvbiB2NS41LXJjMS4NCiAg
Mi4gRGVsZXRlIE00VV9QT1JUX1VOS05PV04gZGVmaW5lIGJlY2F1c2Ugb2Ygbm90IHVzZSBpdC4N
CiAgMy4gQ29ycmVjdCBjb2RpbmcgZm9ybWF0Lg0KICA0LiBSZW5hbWUgb2Zmc2V0PTB4NDggcmVn
aXN0ZXIuDQogIDUuIFNwbGl0ICJpb21tdS9tZWRpYXRlazogQWRkIG10Njc3OSBJT01NVSBiYXNp
YyBzdXBwb3J0KHBhdGNoIHYxKSIgdG8gc2V2ZXJhbCBwYXRjaGVzKHBhdGNoIHYyKS4NCg0KICBo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwvbGludXgtbWVkaWF0ZWsvMjAyMC1K
YW51YXJ5LzAyNjEzMS5odG1sDQoNCiB2MToNCiAgaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
cGlwZXJtYWlsL2xpbnV4LW1lZGlhdGVrLzIwMTktTm92ZW1iZXIvMDI0NTY3Lmh0bWwNCg0KQ2hh
byBIYW8gKDcpOg0KICBkdC1iaW5kaW5nczogbWVkaWF0ZWs6IEFkZCBiaW5kaW5ncyBmb3IgTVQ2
Nzc5DQogIGlvbW11L21lZGlhdGVrOiBSZW5hbWUgdGhlIHJlZ2lzdGVyIFNUQU5EQVJEX0FYSV9N
T0RFKDB4NDgpIHRvDQogICAgICAgICAgICAgICAgICBNSVNDX0NUUkwNCiAgaW9tbXUvbWVkaWF0
ZWs6IERpc2FibGUgU1RBTkRBUkRfQVhJX01PREUgaW4gTUlTQ19DVFJMDQogIGlvbW11L21lZGlh
dGVrOiBNb3ZlIGludl9zZWxfcmVnIGludG8gdGhlIHBsYXRfZGF0YQ0KICBpb21tdS9tZWRpYXRl
azogQWRkIHN1Yl9jb21tIGlkIGluIHRyYW5zbGF0aW9uIGZhdWx0DQogIGlvbW11L21lZGlhdGVr
OiBBZGQgUkVHX01NVV9XUl9MRU4gZGVmaW5pdGlvbiBwcmVwYXJpbmcgZm9yIG10Njc3OQ0KICBp
b21tdS9tZWRpYXRlazogQWRkIG10Njc3OSBiYXNpYyBzdXBwb3J0DQoNCiAuLi4vYmluZGluZ3Mv
aW9tbXUvbWVkaWF0ZWssaW9tbXUudHh0ICAgICAgICAgfCAgIDIgKw0KIGRyaXZlcnMvaW9tbXUv
bXRrX2lvbW11LmMgICAgICAgICAgICAgICAgICAgICB8ICA3NyArKysrKy0tDQogZHJpdmVycy9p
b21tdS9tdGtfaW9tbXUuaCAgICAgICAgICAgICAgICAgICAgIHwgIDEwICstDQogaW5jbHVkZS9k
dC1iaW5kaW5ncy9tZW1vcnkvbXQ2Nzc5LWxhcmItcG9ydC5oIHwgMjA2ICsrKysrKysrKysrKysr
KysrKw0KIDQgZmlsZXMgY2hhbmdlZCwgMjczIGluc2VydGlvbnMoKyksIDIyIGRlbGV0aW9ucygt
KQ0KDQotLQ0KMi4xOC4wDQo=

