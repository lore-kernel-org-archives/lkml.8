Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC32C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5677D24699
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JWDzfXCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgB1Np7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:45:59 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:40660 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726940AbgB1NpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:45:13 -0500
X-UUID: e6586fd5c03e4648a7ef90df9ce93362-20200228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=KZfobTIsb3uca4K8D79VwtQH5mbyTjn+lOiOglWGnDo=;
        b=JWDzfXCo5bY01DtI2sslXCrkMhOGm4gAEb2kWEqkI9ukChkrCkturME/St3KeFMDVxUZ9TiwnKH6TCGsjoSVQ3y33ra9HC12NUXBxBVeXdE09NBOd7KOfn5UNqCpFoF6p+KWBbAXu8N47mq5faWTJ6m8oSZCPFCqDS5fb+HCL8U=;
X-UUID: e6586fd5c03e4648a7ef90df9ce93362-20200228
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 43070881; Fri, 28 Feb 2020 21:45:08 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 28 Feb 2020 21:44:16 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Feb 2020 21:45:04 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Ming-Fan Chen <ming-fan.chen@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v3 11/13] soc: mediatek: cmdq: add jump function
Date:   Fri, 28 Feb 2020 21:44:19 +0800
Message-ID: <1582897461-15105-13-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1582897461-15105-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1582897461-15105-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGp1bXAgZnVuY3Rpb24gc28gdGhhdCBjbGllbnQgY2FuIGp1bXAgdG8gYW55IGFkZHJlc3Mg
d2hpY2gNCmNvbnRhaW5zIGluc3RydWN0aW9uLg0KDQpTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMg
SHNpZWggPGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyB8IDEyICsrKysrKysrKysrKw0KIGluY2x1ZGUvbGlu
dXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggIHwgMTEgKysrKysrKysrKysNCiAyIGZpbGVzIGNo
YW5nZWQsIDIzIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlh
dGVrL210ay1jbWRxLWhlbHBlci5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVs
cGVyLmMNCmluZGV4IDU4ZmVjNjM0ZGNmMS4uYmJjNjhhN2M4MWU5IDEwMDY0NA0KLS0tIGEvZHJp
dmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCisrKyBiL2RyaXZlcnMvc29jL21l
ZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQpAQCAtMzcyLDYgKzM3MiwxOCBAQCBpbnQgY21kcV9w
a3RfYXNzaWduKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgcmVnX2lkeCwgdTMyIHZhbHVlKQ0K
IH0NCiBFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X2Fzc2lnbik7DQogDQoraW50IGNtZHFfcGt0X2p1
bXAoc3RydWN0IGNtZHFfcGt0ICpwa3QsIGRtYV9hZGRyX3QgYWRkcikNCit7DQorCXN0cnVjdCBj
bWRxX2NsaWVudCAqY2wgPSBwa3QtPmNsOw0KKwlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0
ID0geyB7MH0gfTsNCisNCisJaW5zdC5vcCA9IENNRFFfQ09ERV9KVU1QOw0KKwlpbnN0Lm9mZnNl
dCA9IDE7DQorCWluc3QudmFsdWUgPSBhZGRyID4+IGNtZHFfbWJveF9zaGlmdChjbC0+Y2hhbik7
DQorCXJldHVybiBjbWRxX3BrdF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KK30NCitFWFBP
UlRfU1lNQk9MKGNtZHFfcGt0X2p1bXApOw0KKw0KIGludCBjbWRxX3BrdF9maW5hbGl6ZShzdHJ1
Y3QgY21kcV9wa3QgKnBrdCkNCiB7DQogCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7
IHswfSB9Ow0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRx
LmggYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQppbmRleCA5OWU3NzE1
NWY5NjcuLjFhNmM1NmYzYmVjMSAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlh
dGVrL210ay1jbWRxLmgNCisrKyBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRx
LmgNCkBAIC0yMTMsNiArMjEzLDE3IEBAIGludCBjbWRxX3BrdF9wb2xsX21hc2soc3RydWN0IGNt
ZHFfcGt0ICpwa3QsIHU4IHN1YnN5cywNCiAgKi8NCiBpbnQgY21kcV9wa3RfYXNzaWduKHN0cnVj
dCBjbWRxX3BrdCAqcGt0LCB1MTYgcmVnX2lkeCwgdTMyIHZhbHVlKTsNCiANCisvKioNCisgKiBj
bWRxX3BrdF9qdW1wKCkgLSBBcHBlbmQganVtcCBjb21tYW5kIHRvIHRoZSBDTURRIHBhY2tldCwg
YXNrIEdDRQ0KKyAqCQkgICAgIHRvIGV4ZWN1dGUgYW4gaW5zdHJ1Y3Rpb24gdGhhdCBjaGFuZ2Ug
Y3VycmVudCB0aHJlYWQgUEMgdG8NCisgKgkJICAgICBhIHBoeXNpY2FsIGFkZHJlc3Mgd2hpY2gg
c2hvdWxkIGNvbnRhaW5zIG1vcmUgaW5zdHJ1Y3Rpb24uDQorICogQHBrdDogICAgICAgIHRoZSBD
TURRIHBhY2tldA0KKyAqIEBhZGRyOiAgICAgICBwaHlzaWNhbCBhZGRyZXNzIG9mIHRhcmdldCBp
bnN0cnVjdGlvbiBidWZmZXINCisgKg0KKyAqIFJldHVybjogMCBmb3Igc3VjY2VzczsgZWxzZSB0
aGUgZXJyb3IgY29kZSBpcyByZXR1cm5lZA0KKyAqLw0KK2ludCBjbWRxX3BrdF9qdW1wKHN0cnVj
dCBjbWRxX3BrdCAqcGt0LCBkbWFfYWRkcl90IGFkZHIpOw0KKw0KIC8qKg0KICAqIGNtZHFfcGt0
X2ZpbmFsaXplKCkgLSBBcHBlbmQgRU9DIGFuZCBqdW1wIGNvbW1hbmQgdG8gcGt0Lg0KICAqIEBw
a3Q6CXRoZSBDTURRIHBhY2tldA0KLS0gDQoyLjE4LjANCg==

