Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81699C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 583F1207ED
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="g7kdY3Pz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgFIKZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 06:25:37 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:65338 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728629AbgFIKYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 06:24:47 -0400
X-UUID: ccdb7e9ef7a6440ea7d68c8ca41ac69e-20200609
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Pphig5E72pSzrTgo7laaj0FG7wdPeUVc8Qwu7DTlR6Y=;
        b=g7kdY3Pz8YBtxq3Fk1Gly9EAJn6tm83QMF2FvZwRWykYxBcTr6HmXPOEC7DHBzOMen3aeICCoJDL1hoTyolp+IH8A00DRVNMDuJwbw3cEBGC/LTpuS4yvUH9SfWcS7s1mDXFlhU3wVzuJdbMUgbYmnZgDcPn/fOnHRyNF839ROc=;
X-UUID: ccdb7e9ef7a6440ea7d68c8ca41ac69e-20200609
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1948155468; Tue, 09 Jun 2020 18:24:33 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 9 Jun 2020 18:24:30 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 9 Jun 2020 18:24:30 +0800
From:   Neal Liu <neal.liu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Neal Liu <neal.liu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Subject: [PATCH 1/2] dt-bindings: devapc: add bindings for devapc-mt6873
Date:   Tue, 9 Jun 2020 18:24:20 +0800
Message-ID: <1591698261-22639-2-git-send-email-neal.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1591698261-22639-1-git-send-email-neal.liu@mediatek.com>
References: <1591698261-22639-1-git-send-email-neal.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 90D7BBE212CB78B6A32409EBD84AF1D7145490B753E88B3BF2C71BDBC1052BBA2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGJpbmRpbmdzIGZvciBNVDY4NzMgZGV2YXBjLg0KDQpTaWduZWQtb2ZmLWJ5OiBOZWFsIExp
dSA8bmVhbC5saXVAbWVkaWF0ZWsuY29tPg0KLS0tDQogLi4uL3NvYy9tZWRpYXRlay9kZXZhcGMv
ZGV2YXBjLW10Njg3My55YW1sICAgICAgICAgfCAgIDYxICsrKysrKysrKysrKysrKysrKysrDQog
MSBmaWxlIGNoYW5nZWQsIDYxIGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9kZXZhcGMvZGV2YXBj
LW10Njg3My55YW1sDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc29jL21lZGlhdGVrL2RldmFwYy9kZXZhcGMtbXQ2ODczLnlhbWwgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21lZGlhdGVrL2RldmFwYy9kZXZhcGMtbXQ2ODcz
LnlhbWwNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwLi43M2ExNGI4ZA0KLS0t
IC9kZXYvbnVsbA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9t
ZWRpYXRlay9kZXZhcGMvZGV2YXBjLW10Njg3My55YW1sDQpAQCAtMCwwICsxLDYxIEBADQorIyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAgT1IgQlNELTItQ2xhdXNlKQ0KKyMgIyBD
b3B5cmlnaHQgMjAyMCBNZWRpYVRlayBJbmMuDQorJVlBTUwgMS4yDQorLS0tDQorJGlkOiAiaHR0
cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvc29jL21lZGlhdGVrL2RldmFwYy9kZXZhcGMtbXQ2
ODczLnlhbWwjIg0KKyRzY2hlbWE6ICJodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFz
L2NvcmUueWFtbCMiDQorDQordGl0bGU6IE1lZGlhVGVrIE1UNjg3MyBEZXZpY2UgQWNjZXNzIFBl
cm1pc3Npb24gQ29udHJvbCBkcml2ZXINCisNCitkZXNjcmlwdGlvbjogfA0KKyAgTWVkaWFUZWsg
TVQ2ODczIGJ1cyBmcmFicmljIHByb3ZpZGVzIFRydXN0Wm9uZSBzZWN1cml0eSBzdXBwb3J0IGFu
ZCBkYXRhDQorICBwcm90ZWN0aW9uIHRvIHByZXZlbnQgc2xhdmVzIGZyb20gYmVpbmcgYWNjZXNz
ZWQgYnkgdW5leHBlY3RlZCBtYXN0ZXJzLg0KKyAgVGhlIHNlY3VyaXR5IHZpb2xhdGlvbnMgYXJl
IGxvZ2dlZCBhbmQgc2VudCB0byB0aGUgcHJvY2Vzc29yIGZvciBmdXJ0aGVyDQorICBhbmFseXNp
cyBhbmQgY291bnRlcm1lYXN1cmVzLg0KKw0KK21haW50YWluZXI6DQorICAtIE5lYWwgTGl1IDxu
ZWFsLmxpdUBtZWRpYXRlay5jb20+DQorDQorcHJvcGVydGllczoNCisgIGNvbXBhdGlibGU6DQor
ICAgIGVudW06DQorICAgICAgLSBtZWRpYXRlayxtdDY4NzMtZGV2YXBjDQorDQorICByZWc6DQor
ICAgIGRlc2NyaXB0aW9uOiBUaGUgYmFzZSBhZGRyZXNzIG9mIGRldmFwYyByZWdpc3RlciBiYW5r
DQorICAgIG1heEl0ZW1zOiA1DQorDQorICBpbnRlcnJ1cHRzOg0KKyAgICBkZXNjcmlwdGlvbjog
QSBzaW5nbGUgaW50ZXJydXB0IHNwZWNpZmllcg0KKyAgICBtYXhJdGVtczogMQ0KKw0KKyAgY2xv
Y2tzOg0KKyAgICBkZXNjcmlwdGlvbjogQ29udGFpbnMgbW9kdWxlIGNsb2NrIHNvdXJjZSBhbmQg
Y2xvY2sgbmFtZXMNCisgICAgbWF4SXRlbXM6IDENCisNCisgIGNsb2NrLW5hbWVzOg0KKyAgICBk
ZXNjcmlwdGlvbjogTmFtZXMgb2YgdGhlIGNsb2NrcyBsaXN0IGluIGNsb2NrcyBwcm9wZXJ0eQ0K
KyAgICBtYXhJdGVtczogMQ0KKw0KK3JlcXVpcmVkOg0KKyAgLSBjb21wYXRpYmxlDQorICAtIHJl
Zw0KKyAgLSBpbnRlcnJ1cHRzDQorICAtIGNsb2Nrcw0KKyAgLSBjbG9jay1uYW1lcw0KKw0KK2Fk
ZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KKw0KK2V4YW1wbGVzOg0KKyAgLSB8DQorICAgIGRl
dmFwYzogZGV2YXBjQDEwMjA3MDAwIHsNCisgICAgICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlh
dGVrLG10Njg3My1kZXZhcGMiOw0KKyAgICAgICAgICAgIHJlZyA9IDwwIDB4MTAyMDcwMDAgMCAw
eDEwMDA+LA0KKyAgICAgICAgICAgICAgICAgIDwwIDB4MTAyNzQwMDAgMCAweDEwMDA+LA0KKyAg
ICAgICAgICAgICAgICAgIDwwIDB4MTAyNzUwMDAgMCAweDEwMDA+LA0KKyAgICAgICAgICAgICAg
ICAgIDwwIDB4MTEwMjAwMDAgMCAweDEwMDA+LA0KKyAgICAgICAgICAgICAgICAgIDwwIDB4MTAy
MGUwMDAgMCAweDEwMDA+Ow0KKyAgICAgICAgICAgIGludGVycnVwdHMgPSA8R0lDX1NQSSAxODcg
SVJRX1RZUEVfTEVWRUxfSElHSCAwPjsNCisgICAgICAgICAgICBjbG9ja3MgPSA8JmluZnJhY2Zn
IENMS19JTkZSQV9ERVZJQ0VfQVBDPjsNCisgICAgICAgICAgICBjbG9jay1uYW1lcyA9ICJkZXZh
cGMtaW5mcmEtY2xvY2siOw0KKyAgICB9Ow0KLS0gDQoxLjcuOS41DQo=

