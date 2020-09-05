Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D99C43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C0A02074D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KeYKBBiZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgIEILg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 04:11:36 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:28763 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725818AbgIEILc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 04:11:32 -0400
X-UUID: 113e40659580488ab5136c06989e6f1f-20200905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=gtR2LkYO0KLOhvo1ozezWqVLOaBl17wQ1j3LTpLY/+U=;
        b=KeYKBBiZ7X48TxDdf+177fW9Rir6Xt+guhOy92/zSQfnU13pMnbdfS0XiApufno41wThkvAoSrNN8YwNE9a6IgzcJ8VxP2wsTgF/b9rVZoCK9vku00KJc2oVllnR19GmKNsLpbOBvdx6OjDtTXwPk0Q5jSV6Hjj3LzdrQ9CK7rs=;
X-UUID: 113e40659580488ab5136c06989e6f1f-20200905
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1107935372; Sat, 05 Sep 2020 16:11:21 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 5 Sep 2020 16:11:19 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 5 Sep 2020 16:11:18 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Will Deacon <will@kernel.org>, Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>
Subject: [PATCH v2 00/23] MT8192 IOMMU support
Date:   Sat, 5 Sep 2020 16:08:57 +0800
Message-ID: <20200905080920.13396-1-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
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
Lg0KDQpDb21wYXJpbmcgd2l0aCB0aGUgcHJldmlldyBTb0MsIHRoaXMgcGF0Y2hzZXQgbWFpbmx5
IGFkZHMgdHdvIG5ldyBmdW5jdGlvbnM6DQphKSBhZGQgaW92YSAzNCBiaXRzIHN1cHBvcnQuDQpi
KSBhZGQgbXVsdGkgZG9tYWlucyBzdXBwb3J0IHNpbmNlIHNldmVyYWwgSFcgaGFzIHRoZSBzcGVj
aWFsIGlvdmENCnJlZ2lvbiByZXF1aXJlbWVudC4NCg0KdGhpcyBwYXRjaHNldCBkZXBlbmQgb24g
djUuOS1yYzEuDQoNCmNoYW5nZSBub3RlOg0KdjI6DQogIGEpIENvbnZlcnQgSU9NTVUvU01JIGR0
LWJpbmRpbmcgdG8gRFQgc2NoZW1hLg0KICBiKSBGaXggc29tZSBjb21tZW50IGZyb20gUGktSHN1
biBhbmQgTmljb2xhcy4gbGlrZSB1c2UNCiAgZ2VuZXJpY19pb21tdV9wdXRfcmVzdl9yZWdpb25z
Lg0KICBjKSBSZXdvcmQgc29tZSBjb21tZW50LCBsaWtlIGFkZCBob3cgdG8gdXNlIGRvbWFpbi1p
ZC4NCiAgDQp2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaW9tbXUvMjAyMDA3MTEw
NjQ4NDYuMTYwMDctMS15b25nLnd1QG1lZGlhdGVrLmNvbS8NCg0KWW9uZyBXdSAoMjMpOg0KICBk
dC1iaW5kaW5nczogaW9tbXU6IG1lZGlhdGVrOiBDb252ZXJ0IElPTU1VIHRvIERUIHNjaGVtYQ0K
ICBkdC1iaW5kaW5nczogbWVtb3J5OiBtZWRpYXRlazogQ29udmVydCBTTUkgdG8gRFQgc2NoZW1h
DQogIGR0LWJpbmRpbmdzOiBtZW1vcnk6IG1lZGlhdGVrOiBBZGQgYSBjb21tb24gbGFyYi1wb3J0
IGhlYWRlciBmaWxlDQogIGR0LWJpbmRpbmdzOiBtZW1vcnk6IG1lZGlhdGVrOiBFeHRlbmQgTEFS
Ql9OUl9NQVggdG8gMzINCiAgZHQtYmluZGluZ3M6IG1lbW9yeTogbWVkaWF0ZWs6IEFkZCBkb21h
aW4gZGVmaW5pdGlvbg0KICBkdC1iaW5kaW5nczogbWVkaWF0ZWs6IEFkZCBiaW5kaW5nIGZvciBt
dDgxOTIgSU9NTVUgYW5kIFNNSQ0KICBpb21tdS9tZWRpYXRlazogVXNlIHRoZSBjb21tb24gbXRr
LXNtaS1sYXJiLXBvcnQuaA0KICBpb21tdS9pby1wZ3RhYmxlLWFybS12N3M6IFVzZSBpYXMgdG8g
Y2hlY2sgdGhlIHZhbGlkIGlvdmEgaW4gdW5tYXANCiAgaW9tbXUvaW8tcGd0YWJsZS1hcm0tdjdz
OiBFeHRlbmQgUEEzNCBmb3IgTWVkaWFUZWsNCiAgaW9tbXUvaW8tcGd0YWJsZS1hcm0tdjdzOiBB
ZGQgY2ZnIGFzIGEgcGFyYW0gaW4gc29tZSBtYWNyb3MNCiAgaW9tbXUvaW8tcGd0YWJsZS1hcm0t
djdzOiBRdWFkIGx2bDEgcGd0YWJsZSBmb3IgTWVkaWFUZWsNCiAgaW9tbXUvbWVkaWF0ZWs6IE1v
dmUgaHdfaW5pdCBpbnRvIGF0dGFjaF9kZXZpY2UNCiAgaW9tbXUvbWVkaWF0ZWs6IEFkZCBkZXZp
Y2UgbGluayBmb3Igc21pLWNvbW1vbiBhbmQgbTR1DQogIGlvbW11L21lZGlhdGVrOiBBZGQgcG93
ZXItZG9tYWluIG9wZXJhdGlvbg0KICBpb21tdS9tZWRpYXRlazogQWRkIGlvdmEgcmVzZXJ2ZWQg
ZnVuY3Rpb24NCiAgaW9tbXUvbWVkaWF0ZWs6IEFkZCBzaW5nbGUgZG9tYWluDQogIGlvbW11L21l
ZGlhdGVrOiBTdXBwb3J0IG1hc3RlciB1c2UgaW92YSBvdmVyIDMyYml0DQogIGlvbW11L21lZGlh
dGVrOiBTdXBwb3J0IHVwIHRvIDM0Yml0IGlvdmEgaW4gdGxiIGZsdXNoDQogIGlvbW11L21lZGlh
dGVrOiBTdXBwb3J0IHJlcG9ydCBpb3ZhIDM0Yml0IHRyYW5zbGF0aW9uIGZhdWx0IGluIElTUg0K
ICBpb21tdS9tZWRpYXRlazogQWRkIHN1cHBvcnQgZm9yIG11bHRpIGRvbWFpbg0KICBpb21tdS9t
ZWRpYXRlazogQWRqdXN0IHRoZSBzdHJ1Y3R1cmUNCiAgaW9tbXUvbWVkaWF0ZWs6IEFkZCBtdDgx
OTIgc3VwcG9ydA0KICBtZW1vcnk6IG10ay1zbWk6IEFkZCBtdDgxOTIgc3VwcG9ydA0KDQogLi4u
L2JpbmRpbmdzL2lvbW11L21lZGlhdGVrLGlvbW11LnR4dCAgICAgICAgIHwgMTAzIC0tLS0tLS0t
DQogLi4uL2JpbmRpbmdzL2lvbW11L21lZGlhdGVrLGlvbW11LnlhbWwgICAgICAgIHwgMTU1ICsr
KysrKysrKysrDQogLi4uL21lZGlhdGVrLHNtaS1jb21tb24udHh0ICAgICAgICAgICAgICAgICAg
IHwgIDQ5IC0tLS0NCiAuLi4vbWVkaWF0ZWssc21pLWNvbW1vbi55YW1sICAgICAgICAgICAgICAg
ICAgfCAgOTcgKysrKysrKw0KIC4uLi9tZW1vcnktY29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWxh
cmIudHh0ICB8ICA0OSAtLS0tDQogLi4uL21lbW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxzbWkt
bGFyYi55YW1sIHwgIDg2ICsrKysrKw0KIGRyaXZlcnMvaW9tbXUvaW8tcGd0YWJsZS1hcm0tdjdz
LmMgICAgICAgICAgICB8ICA1NyArKy0tDQogZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyAgICAg
ICAgICAgICAgICAgICAgIHwgMjQ3ICsrKysrKysrKysrKysrLS0tLQ0KIGRyaXZlcnMvaW9tbXUv
bXRrX2lvbW11LmggICAgICAgICAgICAgICAgICAgICB8ICAxMSArLQ0KIGRyaXZlcnMvbWVtb3J5
L210ay1zbWkuYyAgICAgICAgICAgICAgICAgICAgICB8ICAyNyArKw0KIGluY2x1ZGUvZHQtYmlu
ZGluZ3MvbWVtb3J5L210MjcxMi1sYXJiLXBvcnQuaCB8ICAgMiArLQ0KIGluY2x1ZGUvZHQtYmlu
ZGluZ3MvbWVtb3J5L210Njc3OS1sYXJiLXBvcnQuaCB8ICAgMiArLQ0KIGluY2x1ZGUvZHQtYmlu
ZGluZ3MvbWVtb3J5L210ODE3My1sYXJiLXBvcnQuaCB8ICAgMiArLQ0KIGluY2x1ZGUvZHQtYmlu
ZGluZ3MvbWVtb3J5L210ODE4My1sYXJiLXBvcnQuaCB8ICAgMiArLQ0KIGluY2x1ZGUvZHQtYmlu
ZGluZ3MvbWVtb3J5L210ODE5Mi1sYXJiLXBvcnQuaCB8IDIzOSArKysrKysrKysrKysrKysrKw0K
IC4uLi9kdC1iaW5kaW5ncy9tZW1vcnkvbXRrLXNtaS1sYXJiLXBvcnQuaCAgICB8ICAyMiArKw0K
IGluY2x1ZGUvbGludXgvaW8tcGd0YWJsZS5oICAgICAgICAgICAgICAgICAgICB8ICAgNCArLQ0K
IGluY2x1ZGUvc29jL21lZGlhdGVrL3NtaS5oICAgICAgICAgICAgICAgICAgICB8ICAgMyArLQ0K
IDE4IGZpbGVzIGNoYW5nZWQsIDg4MCBpbnNlcnRpb25zKCspLCAyNzcgZGVsZXRpb25zKC0pDQog
ZGVsZXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pb21t
dS9tZWRpYXRlayxpb21tdS50eHQNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2lvbW11L21lZGlhdGVrLGlvbW11LnlhbWwNCiBkZWxldGUgbW9k
ZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lbW9yeS1jb250cm9s
bGVycy9tZWRpYXRlayxzbWktY29tbW9uLnR4dA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LWNvbnRyb2xsZXJzL21lZGlhdGVrLHNt
aS1jb21tb24ueWFtbA0KIGRlbGV0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbWVtb3J5LWNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1sYXJiLnR4dA0KIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5
LWNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1sYXJiLnlhbWwNCiBjcmVhdGUgbW9kZSAxMDA2NDQg
aW5jbHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXQ4MTkyLWxhcmItcG9ydC5oDQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IGluY2x1ZGUvZHQtYmluZGluZ3MvbWVtb3J5L210ay1zbWktbGFyYi1wb3J0LmgN
Cg0KLS0gDQoyLjE4LjANCg0K

