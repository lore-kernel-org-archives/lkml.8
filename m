Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD02C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67D83206F0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ogxD5nZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgGKGtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 02:49:49 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:5766 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726963AbgGKGtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 02:49:49 -0400
X-UUID: 16e9aa3a37264cdeb66c1b05d55a8ea9-20200711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=vwYwfmBuQ9EeaF9o2hLTJCCqrK2cnovh37RuGZvptlA=;
        b=ogxD5nZ5xaqn2O6DU45WGIt10Ix+cItMJ86xGrFDF1nd1rk3bSmJV7Dm6rkoSd0Ln+jd8bkZjOydmYdEvMESb7BiKiW7i9KbDp/NmDZscGbqpwlForPAcrpKJ8aUf7Ae9n9dapZ1t5BZyiDzroljpMmSBbStKRra7aZ1hq91BhA=;
X-UUID: 16e9aa3a37264cdeb66c1b05d55a8ea9-20200711
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 979733848; Sat, 11 Jul 2020 14:49:45 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Jul 2020 14:49:35 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Jul 2020 14:49:34 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Will Deacon <will@kernel.org>, Evan Green <evgreen@chromium.org>,
        "Tomasz Figa" <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <cui.zhang@mediatek.com>,
        <chao.hao@mediatek.com>, <ming-fan.chen@mediatek.com>
Subject: [PATCH 00/21] MT8192 IOMMU support
Date:   Sat, 11 Jul 2020 14:48:25 +0800
Message-ID: <20200711064846.16007-1-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A82A830F0FA76FCD9B4AB531CB0600E0FA50BF41F1516541BB4CA6E4B4AA79502000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBtYWlubHkgYWRkcyBzdXBwb3J0IGZvciBtdDgxOTIgSU9NTVUgYW5kIFNNSS4N
Cg0KbXQ4MTkyIGFsc28gaXMgTVRLIElPTU1VIGdlbjIgd2hpY2ggdXNlcyBBUk0gU2hvcnQtRGVz
Y3JpcHRvciB0cmFuc2xhdGlvbg0KdGFibGUgZm9ybWF0LiBUaGUgTTRVLVNNSSBIVyBkaWFncmFt
IGlzIGFzIGJlbG93Og0KDQogICAgICAgICAgICAgICAgICAgICAgICAgIEVNSQ0KICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfA0KICAgICAgICAgICAgICAgICAgICAgICAgICBNNFUNCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwNCiAgICAgICAgICAgICAgICAgICAgICAtLS0tLS0tLS0t
LS0NCiAgICAgICAgICAgICAgICAgICAgICAgU01JIENvbW1vbg0KICAgICAgICAgICAgICAgICAg
ICAgIC0tLS0tLS0tLS0tLQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KICArLS0tLS0t
LSstLS0tLS0rLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLSsNCiAgfCAgICAg
ICB8ICAgICAgfCAgICAgIHwgICAgICAgLi4uLi4uICAgICAgICAgfCAgICAgICB8DQogIHwgICAg
ICAgfCAgICAgIHwgICAgICB8ICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgfA0KbGFyYjAg
ICBsYXJiMSAgbGFyYjIgIGxhcmI0ICAgICAuLi4uLi4gICAgICBsYXJiMTkgICBsYXJiMjANCmRp
c3AwICAgZGlzcDEgICBtZHAgICAgdmRlYyAgICAgICAgICAgICAgICAgICBJUEUgICAgICBJUEUN
Cg0KQWxsIHRoZSBjb25uZWN0aW9ucyBhcmUgSFcgZml4ZWQsIFNXIGNhbiBOT1QgYWRqdXN0IGl0
Lg0KDQpDb21wYXJpbmcgd2l0aCB0aGUgcHJldmlldyBTb0MsIHRoaXMgcGF0Y2hzZXQgYWxzbyBh
ZGRzIHR3byBmdW5jdGlvbnM6DQphKSBhZGQgaW92YSAzNCBiaXRzIHN1cHBvcnQuDQpiKSBhZGQg
bXVsdGkgZG9tYWlucyBzdXBwb3J0IHNpbmNlIHNldmVyYWwgSFcgaGFzIHRoZSBzcGVjaWFsIGlv
dmENCnJlZ2lvbiByZXF1aXJlbWVudC4NCg0KdGhpcyBwYXRjaHNldCBkZXBlbmQgb24gdjUuOC1y
YzEgYW5kIG10Njc3OSBpb21tdVsxXS4NCg0KWzFdaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGlu
dXgtaW9tbXUvMjAyMDA3MDMwNDQxMjcuMjc0MzgtMS1jaGFvLmhhb0BtZWRpYXRlay5jb20vDQoN
CllvbmcgV3UgKDIxKToNCiAgZHQtYmluZGluZzogbWVtb3J5OiBtZWRpYXRlazogQWRkIGEgY29t
bW9uIGxhcmItcG9ydCBoZWFkZXIgZmlsZQ0KICBkdC1iaW5kaW5nOiBtZW1vcnk6IG1lZGlhdGVr
OiBFeHRlbmQgTEFSQl9OUl9NQVggdG8gMzINCiAgZHQtYmluZGluZzogbWVtb3J5OiBtZWRpYXRl
azogQWRkIGRvbWFpbiBkZWZpbml0aW9uDQogIGR0LWJpbmRpbmc6IG1lZGlhdGVrOiBBZGQgYmlu
ZGluZyBmb3IgbXQ4MTkyIElPTU1VIGFuZCBTTUkNCiAgaW9tbXUvbWVkaWF0ZWs6IFVzZSB0aGUg
Y29tbW9uIG10ay1zbWktbGFyYi1wb3J0LmgNCiAgaW9tbXUvaW8tcGd0YWJsZS1hcm0tdjdzOiBV
c2UgaWFzIHRvIGNoZWNrIHRoZSB2YWxpZCBpb3ZhIGluIHVubWFwDQogIGlvbW11L2lvLXBndGFi
bGUtYXJtLXY3czogRXh0ZW5kIFBBMzQgZm9yIE1lZGlhVGVrDQogIGlvbW11L2lvLXBndGFibGUt
YXJtLXY3czogQWRkIGNmZyBhcyBhIHBhcmFtIGluIHNvbWUgbWFjcm9zDQogIGlvbW11L2lvLXBn
dGFibGUtYXJtLXY3czogUXVhZCBsdmwxIHBndGFibGUgZm9yIE1lZGlhVGVrDQogIGlvbW11L21l
ZGlhdGVrOiBBZGQgZGV2aWNlIGxpbmsgZm9yIHNtaS1jb21tb24gYW5kIG00dQ0KICBpb21tdS9t
ZWRpYXRlazogQWRkIHBvd2VyLWRvbWFpbiBvcGVyYXRpb24NCiAgaW9tbXUvbWVkaWF0ZWs6IEFk
ZCBpb3ZhIHJlc2VydmVkIGZ1bmN0aW9uDQogIGlvbW11L21lZGlhdGVrOiBNYWtlIE1US19JT01N
VSBkZXBlbmQgb24gQVJNNjQNCiAgaW9tbXUvbWVkaWF0ZWs6IEFkZCBzaW5nbGUgZG9tYWluDQog
IGlvbW11L21lZGlhdGVrOiBTdXBwb3J0IG1hc3RlciB1c2UgaW92YSBvdmVyIDMyYml0DQogIGlv
bW11L21lZGlhdGVrOiBTdXBwb3J0IHVwIHRvIDM0Yml0IGlvdmEgaW4gdGxiIGludmFsaWQNCiAg
aW9tbXUvbWVkaWF0ZWs6IFN1cHBvcnQgcmVwb3J0IGlvdmEgMzRiaXQgdHJhbnNsYXRpb24gZmF1
bHQgaW4gSVNSDQogIGlvbW11L21lZGlhdGVrOiBBZGQgc3VwcG9ydCBmb3IgbXVsdGkgZG9tYWlu
DQogIGlvbW11L21lZGlhdGVrOiBBZGp1c3QgdGhlIHN0cnVjdHVyZQ0KICBpb21tdS9tZWRpYXRl
azogQWRkIG10ODE5MiBzdXBwb3J0DQogIG1lbW9yeTogbXRrLXNtaTogQWRkIG10ODE5MiBzdXBw
b3J0DQoNCiAuLi4vYmluZGluZ3MvaW9tbXUvbWVkaWF0ZWssaW9tbXUudHh0ICAgICAgICAgfCAg
IDggKy0NCiAuLi4vbWVkaWF0ZWssc21pLWNvbW1vbi50eHQgICAgICAgICAgICAgICAgICAgfCAg
IDUgKy0NCiAuLi4vbWVtb3J5LWNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1sYXJiLnR4dCAgfCAg
IDMgKy0NCiBkcml2ZXJzL2lvbW11L0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
IDEgKw0KIGRyaXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0tdjdzLmMgICAgICAgICAgICB8ICA1
MSArKy0tDQogZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyAgICAgICAgICAgICAgICAgICAgIHwg
MjY1ICsrKysrKysrKysrKysrKy0tLQ0KIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmggICAgICAg
ICAgICAgICAgICAgICB8ICAxMSArLQ0KIGRyaXZlcnMvbWVtb3J5L210ay1zbWkuYyAgICAgICAg
ICAgICAgICAgICAgICB8ICAyNSArKw0KIGluY2x1ZGUvZHQtYmluZGluZ3MvbWVtb3J5L210Mjcx
Mi1sYXJiLXBvcnQuaCB8ICAgMiArLQ0KIGluY2x1ZGUvZHQtYmluZGluZ3MvbWVtb3J5L210Njc3
OS1sYXJiLXBvcnQuaCB8ICAgMiArLQ0KIGluY2x1ZGUvZHQtYmluZGluZ3MvbWVtb3J5L210ODE3
My1sYXJiLXBvcnQuaCB8ICAgMiArLQ0KIGluY2x1ZGUvZHQtYmluZGluZ3MvbWVtb3J5L210ODE4
My1sYXJiLXBvcnQuaCB8ICAgMiArLQ0KIGluY2x1ZGUvZHQtYmluZGluZ3MvbWVtb3J5L210ODE5
Mi1sYXJiLXBvcnQuaCB8IDIzNyArKysrKysrKysrKysrKysrDQogLi4uL2R0LWJpbmRpbmdzL21l
bW9yeS9tdGstc21pLWxhcmItcG9ydC5oICAgIHwgIDIyICsrDQogaW5jbHVkZS9saW51eC9pby1w
Z3RhYmxlLmggICAgICAgICAgICAgICAgICAgIHwgICA0ICstDQogaW5jbHVkZS9zb2MvbWVkaWF0
ZWsvc21pLmggICAgICAgICAgICAgICAgICAgIHwgICAzICstDQogMTYgZmlsZXMgY2hhbmdlZCwg
NTY1IGluc2VydGlvbnMoKyksIDc4IGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBp
bmNsdWRlL2R0LWJpbmRpbmdzL21lbW9yeS9tdDgxOTItbGFyYi1wb3J0LmgNCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgaW5jbHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXRrLXNtaS1sYXJiLXBvcnQuaA0K
DQotLSANCjIuMTguMCANCg0K

