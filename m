Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE02C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 408B52075E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Z0lZDMfu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgFQDBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 23:01:20 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:64752 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726568AbgFQDBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 23:01:07 -0400
X-UUID: d02e977045d64f77a28e31b6a9db254d-20200617
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Wis5vDqsbbB93AdFA7XLcfdhnuaZidhnla8UOIBO0ek=;
        b=Z0lZDMfuA73ttTRjNXk5cXsLpPy7lxeqDcRx9fGKBUDMHklFmQAbR+KGEzCw+bggY4Ik7696457hhpO40ruHPMXxLLBLPIiykfDihVXe/qt/qn6K322WXCFsYmbRinGvmWgbAJHOxKiN/KvakUy4aBGhHKUnGP6iE1Ft9gE7a2I=;
X-UUID: d02e977045d64f77a28e31b6a9db254d-20200617
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 404865493; Wed, 17 Jun 2020 11:01:02 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 17 Jun 2020 11:00:50 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 17 Jun 2020 11:00:48 +0800
From:   Chao Hao <chao.hao@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, FY Yang <fy.yang@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>
Subject: [PATCH v4 00/07] MT6779 IOMMU SUPPORT
Date:   Wed, 17 Jun 2020 11:00:22 +0800
Message-ID: <20200617030029.4082-1-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: FB8C3C131B059E05A7015CC9206665E6513E2B80B0D5808ABDA7442D20A11FCC2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaHNldCBhZGRzIG10Njc3OSBpb21tdSBzdXBwb3J0Lg0KbXQ2Nzc5IGhhcyB0d28g
aW9tbXVzLCB0aGV5IGFyZSBNTV9JT01NVShNNFUpIGFuZCBBUFVfSU9NTVUgd2hpY2ggdXNlZCBB
Uk0gU2hvcnQtRGVzY3JpcHRvciB0cmFuc2xhdGlvbiBmb3JtYXQuDQpUaGUgbXQ2Nzc5J3MgTU1f
SU9NTVUtU01JIGFuZCBBUFVfSU9NTVUgSFcgZGlhZ3JhbSBpcyBhcyBiZWxvdywgaXQgaXMgb25s
eSBhIGJyaWVmIGRpYWdyYW06DQoNCgkJICAgICAgIEVNSQ0KCQkgICAgICAgIHwNCiAgICAgLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiAgICAgfCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwNCiAgTU1fSU9NTVUgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgQVBVX0lPTU1VDQogICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8DQogIFNNSV9DT01NT00tLS0tLS0tLS0tLSAgICAgICAgICAgICAgICAgQVBVX0JVUw0KICAg
ICB8ICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgfA0KICBTTUlfTEFSQigwfjEx
KSAgICAgIHwgICAgICAgICAgICAgICAgICAgfA0KICAgICB8ICAgICAgICAgICAgICAgIHwgICAg
ICAgICAgICAgICAgICAgfA0KICAgICB8ICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgLS0t
LS0tLS0tLS0tLS0NCiAgICAgfCAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgIHwgICAgIHwg
ICAgICB8DQpNdWx0aW1lZGlhIGVuZ2luZSAgICAgIENDVSAgICAgICAgICAgVlBVICAgTURMQSAg
IEVNREENCg0KQWxsIHRoZSBjb25uZWN0aW9ucyBhcmUgaGFyZHdhcmUgZml4ZWQsIHNvZnR3YXJl
IGNhbiBub3QgYWRqdXN0IGl0Lg0KQ29tcGFyZWQgd2l0aCBtdDgxODMsIFNNSV9CVVNfSUQgd2lk
dGggaGFzIGNoYW5nZWQgZnJvbSAxMCB0byAxMi4gU01JIExhcmIgbnVtYmVyIGlzIGRlc2NyaWJl
ZCBpbiBiaXRbMTE6N10sDQpQb3J0IG51bWJlciBpcyBkZXNjcmliZWQgaW4gYml0WzY6Ml0uIElu
IGFkZGl0aW9uLCB0aGVyZSBhcmUgc29tZSByZWdpc3RlcnMgaGFzIGNoYW5nZWQgaW4gbXQ2Nzc5
LCBzbyB3ZSBuZWVkDQp0byByZWRlZmluZSBhbmQgcmV1c2UgdGhlbS4NCg0KVGhlIHBhdGNoc2V0
IG9ubHkgdXNlZCBNTV9JT01NVSwgc28gd2Ugb25seSBhZGQgTU1fSU9NTVUgYmFzaWMgZnVuY3Rp
b24sIHN1Y2ggYXMgc21pX2xhcmIgcG9ydCBkZWZpbml0aW9uLCByZWdpc3RlcnMNCmRlZmluaXRp
b24gYW5kIGhhcmR3YXJlIGluaXRpYWxpemF0aW9uLg0KDQpjaGFuZ2Ugbm90ZXM6DQogdjQ6DQog
ICAxLiBSZWJhc2Ugb24gdjUuOC1yYzEuDQogICAyLiBGaXggY29kaW5nIHN0eWxlLg0KICAgMy4g
QWRkIEZfTU1VX0lOX0RSREVSX1dSX0VOIGRlZmluaXRpb24gaW4gTUlTQ19DVFJMIHRvIGltcHJv
dmUgcGVyZm9ybWFuY2UuDQoNCiB2MzoNCiAgIDEuIFJlYmFzZSBvbiB2NS43LXJjMS4NCiAgIDIu
IFJlbW92ZSB1bnVzZWQgcG9ydCBkZWZpbml0aW9uLGV4OkFQVSBhbmQgQ0NVIHBvcnQgaW4gbXQ2
Nzc5LWxhcmItcG9ydC5oLg0KICAgMy4gUmVtb3ZlICJjaGFuZ2Ugc2luZ2xlIGRvbWFpbiB0byBt
dWx0aXBsZSBkb21haW4iIHBhcnQoZnJvbSBQQVRDSCB2MiAwOS8xOSB0byBQQVRDSCB2MiAxOS8x
OSkuDQogICA0LiBSZWRlc2lnbiBtdDY3NzkgYmFzaWMgcGFydA0KICAgICAgKDEpQWRkIHNvbWUg
cmVnaXN0ZXIgZGVmaW5pdGlvbiBhbmQgcmV1c2UgdGhlbS4NCiAgICAgICgyKVJlZGVzaWduIHNt
aSBsYXJiIGJ1cyBJRCB0byBhbmFseXplIElPTU1VIHRyYW5zbGF0aW9uIGZhdWx0Lg0KICAgICAg
KDMpT25seSBpbml0IE1NX0lPTU1VIGFuZCBub3QgdXNlIEFQVV9JT01NVS4NCg0KIGh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL3BpcGVybWFpbC9saW51eC1tZWRpYXRlay8yMDIwLU1heS8wMjk4
MTEuaHRtbA0KDQogdjI6DQogICAxLiBSZWJhc2Ugb24gdjUuNS1yYzEuDQogICAyLiBEZWxldGUg
TTRVX1BPUlRfVU5LTk9XTiBkZWZpbmUgYmVjYXVzZSBvZiBub3QgdXNlIGl0Lg0KICAgMy4gQ29y
cmVjdCBjb2RpbmcgZm9ybWF0Lg0KICAgNC4gUmVuYW1lIG9mZnNldD0weDQ4IHJlZ2lzdGVyLg0K
ICAgNS4gU3BsaXQgImlvbW11L21lZGlhdGVrOiBBZGQgbXQ2Nzc5IElPTU1VIGJhc2ljIHN1cHBv
cnQocGF0Y2ggdjEpIiB0byBzZXZlcmFsIHBhdGNoZXMocGF0Y2ggdjIpLg0KDQogaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xpbnV4LW1lZGlhdGVrLzIwMjAtSmFudWFyeS8w
MjYxMzEuaHRtbA0KDQogdjE6DQogaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvcGlwZXJtYWls
L2xpbnV4LW1lZGlhdGVrLzIwMTktTm92ZW1iZXIvMDI0NTY3Lmh0bWwNCg0KQ2hhbyBIYW8gKDcp
Og0KICBkdC1iaW5kaW5nczogbWVkaWF0ZWs6IEFkZCBiaW5kaW5ncyBmb3IgTVQ2Nzc5DQogIGlv
bW11L21lZGlhdGVrOiBSZW5hbWUgdGhlIHJlZ2lzdGVyIFNUQU5EQVJEX0FYSV9NT0RFKDB4NDgp
IHRvDQogICAgICAgICAgICAgICAgICBNSVNDX0NUUkwNCiAgaW9tbXUvbWVkaWF0ZWs6IFNldCBN
SVNDX0NUUkwgcmVnaXN0ZXINCiAgaW9tbXUvbWVkaWF0ZWs6IE1vdmUgaW52X3NlbF9yZWcgaW50
byB0aGUgcGxhdF9kYXRhDQogIGlvbW11L21lZGlhdGVrOiBBZGQgc3ViX2NvbW0gaWQgaW4gdHJh
bnNsYXRpb24gZmF1bHQNCiAgaW9tbXUvbWVkaWF0ZWs6IEFkZCBSRUdfTU1VX1dSX0xFTiBkZWZp
bml0aW9uIHByZXBhcmluZyBmb3IgbXQ2Nzc5DQogIGlvbW11L21lZGlhdGVrOiBBZGQgbXQ2Nzc5
IGJhc2ljIHN1cHBvcnQNCg0KIC4uLi9iaW5kaW5ncy9pb21tdS9tZWRpYXRlayxpb21tdS50eHQg
ICAgICAgICB8ICAgMiArDQogZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyAgICAgICAgICAgICAg
ICAgICAgIHwgIDkyICsrKysrKy0tDQogZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaCAgICAgICAg
ICAgICAgICAgICAgIHwgIDEwICstDQogaW5jbHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXQ2Nzc5
LWxhcmItcG9ydC5oIHwgMjA2ICsrKysrKysrKysrKysrKysrKw0KIDQgZmlsZXMgY2hhbmdlZCwg
Mjg1IGluc2VydGlvbnMoKyksIDI1IGRlbGV0aW9ucygtKQ0KDQotLQ0KMi4xOC4wDQo=

