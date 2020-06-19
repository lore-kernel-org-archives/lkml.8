Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3543C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9316C2080C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QswppJNE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732194AbgFSJmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 05:42:15 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:2520 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732134AbgFSJmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 05:42:10 -0400
X-UUID: 0120e8fd4428446bb1d8bf22c0c4fbbe-20200619
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=h/UQEjXf6uvMc+oxKD1tqte0usDqTFwha7l55rvLaKo=;
        b=QswppJNE8Ds+KTlNb4GTUjbx8Mwd1ZIxbpmoFoyOHYUXyHOIIwYqL8ynRW3GxH8zBjnuM1YgwGjf2KhNut+MBfyImRbeDnJ+Nu4q3pXCydo/Qn8JShmRu1SXVeq8e7lY5vcKREp3tjDwhWm4UpXbkVuHh53LoF+F7EkzZwf1AmA=;
X-UUID: 0120e8fd4428446bb1d8bf22c0c4fbbe-20200619
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 372175436; Fri, 19 Jun 2020 17:42:04 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 19 Jun 2020 17:42:01 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 19 Jun 2020 17:42:01 +0800
From:   Neal Liu <neal.liu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Neal Liu <neal.liu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Subject: [PATCH v2 1/2] dt-bindings: devapc: add bindings for devapc-mt6873
Date:   Fri, 19 Jun 2020 17:41:59 +0800
Message-ID: <1592559720-8482-2-git-send-email-neal.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1592559720-8482-1-git-send-email-neal.liu@mediatek.com>
References: <1592559720-8482-1-git-send-email-neal.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
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
LnlhbWwNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwLi4xZGViN2Y2DQotLS0g
L2Rldi9udWxsDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21l
ZGlhdGVrL2RldmFwYy9kZXZhcGMtbXQ2ODczLnlhbWwNCkBAIC0wLDAgKzEsNjEgQEANCisjIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMCBPUiBCU0QtMi1DbGF1c2UpDQorIyAjIENv
cHlyaWdodCAyMDIwIE1lZGlhVGVrIEluYy4NCislWUFNTCAxLjINCistLS0NCiskaWQ6ICJodHRw
Oi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9zb2MvbWVkaWF0ZWsvZGV2YXBjL2RldmFwYy1tdDY4
NzMueWFtbCMiDQorJHNjaGVtYTogImh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMv
Y29yZS55YW1sIyINCisNCit0aXRsZTogTWVkaWFUZWsgTVQ2ODczIERldmljZSBBY2Nlc3MgUGVy
bWlzc2lvbiBDb250cm9sIGRyaXZlcg0KKw0KK2Rlc2NyaXB0aW9uOiB8DQorICBNZWRpYVRlayBN
VDY4NzMgYnVzIGZyYWJyaWMgcHJvdmlkZXMgVHJ1c3Rab25lIHNlY3VyaXR5IHN1cHBvcnQgYW5k
IGRhdGENCisgIHByb3RlY3Rpb24gdG8gcHJldmVudCBzbGF2ZXMgZnJvbSBiZWluZyBhY2Nlc3Nl
ZCBieSB1bmV4cGVjdGVkIG1hc3RlcnMuDQorICBUaGUgc2VjdXJpdHkgdmlvbGF0aW9ucyBhcmUg
bG9nZ2VkIGFuZCBzZW50IHRvIHRoZSBwcm9jZXNzb3IgZm9yIGZ1cnRoZXINCisgIGFuYWx5c2lz
IGFuZCBjb3VudGVybWVhc3VyZXMuDQorDQorbWFpbnRhaW5lcnM6DQorICAtIE5lYWwgTGl1IDxu
ZWFsLmxpdUBtZWRpYXRlay5jb20+DQorDQorcHJvcGVydGllczoNCisgIGNvbXBhdGlibGU6DQor
ICAgIGVudW06DQorICAgICAgLSBtZWRpYXRlayxtdDY4NzMtZGV2YXBjDQorDQorICByZWc6DQor
ICAgIGRlc2NyaXB0aW9uOiBUaGUgYmFzZSBhZGRyZXNzIG9mIGRldmFwYyByZWdpc3RlciBiYW5r
DQorICAgIG1heEl0ZW1zOiA1DQorDQorICBpbnRlcnJ1cHRzOg0KKyAgICBkZXNjcmlwdGlvbjog
QSBzaW5nbGUgaW50ZXJydXB0IHNwZWNpZmllcg0KKyAgICBtYXhJdGVtczogMQ0KKw0KKyAgY2xv
Y2tzOg0KKyAgICBkZXNjcmlwdGlvbjogQ29udGFpbnMgbW9kdWxlIGNsb2NrIHNvdXJjZSBhbmQg
Y2xvY2sgbmFtZXMNCisgICAgbWF4SXRlbXM6IDENCisNCisgIGNsb2NrLW5hbWVzOg0KKyAgICBk
ZXNjcmlwdGlvbjogTmFtZXMgb2YgdGhlIGNsb2NrcyBsaXN0IGluIGNsb2NrcyBwcm9wZXJ0eQ0K
KyAgICBtYXhJdGVtczogMQ0KKw0KK3JlcXVpcmVkOg0KKyAgLSBjb21wYXRpYmxlDQorICAtIHJl
Zw0KKyAgLSBpbnRlcnJ1cHRzDQorICAtIGNsb2Nrcw0KKyAgLSBjbG9jay1uYW1lcw0KKw0KK2V4
YW1wbGVzOg0KKyAgLSB8DQorICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29u
dHJvbGxlci9hcm0tZ2ljLmg+DQorICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9jbG9jay9tdDgx
ODMtY2xrLmg+DQorICAgIGRldmFwYzogZGV2YXBjQDEwMjA3MDAwIHsNCisgICAgICAgICAgICBj
b21wYXRpYmxlID0gIm1lZGlhdGVrLG10Njg3My1kZXZhcGMiOw0KKyAgICAgICAgICAgIHJlZyA9
IDwwIDB4MTAyMDcwMDAgMCAweDEwMDA+LA0KKyAgICAgICAgICAgICAgICAgIDwwIDB4MTAyNzQw
MDAgMCAweDEwMDA+LA0KKyAgICAgICAgICAgICAgICAgIDwwIDB4MTAyNzUwMDAgMCAweDEwMDA+
LA0KKyAgICAgICAgICAgICAgICAgIDwwIDB4MTEwMjAwMDAgMCAweDEwMDA+LA0KKyAgICAgICAg
ICAgICAgICAgIDwwIDB4MTAyMGUwMDAgMCAweDEwMDA+Ow0KKyAgICAgICAgICAgIGludGVycnVw
dHMgPSA8R0lDX1NQSSAxODcgSVJRX1RZUEVfTEVWRUxfSElHSD47DQorICAgICAgICAgICAgY2xv
Y2tzID0gPCZpbmZyYWNmZyBDTEtfSU5GUkFfREVWSUNFX0FQQz47DQorICAgICAgICAgICAgY2xv
Y2stbmFtZXMgPSAiZGV2YXBjLWluZnJhLWNsb2NrIjsNCisgICAgfTsNCi0tIA0KMS43LjkuNQ0K

