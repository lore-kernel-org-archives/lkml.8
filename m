Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331F1C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4F2246B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GT93fBR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgB1NpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:45:18 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:59345 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727048AbgB1NpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:45:15 -0500
X-UUID: 7c65038df8954186812dddb68116d8da-20200228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=1rbM0FjWVbn4A7ZOtndn2GAuRV64Pvgtb7WDKwh/rZ4=;
        b=GT93fBR0xmDQAYsp6l/VbDrfvqfAAi2LJldc2OgUMzDceyQuwQaubZubLCwAiUlTMBwf+3ybmduLhlN2ZMlh9R3KjhiJIgsV/2qgjBZqJRPf1iJMwoMXss1CxFzvv9/Y78O+W5Y++Lwt8k011PtIhZoZ5XR1zsJFQj2k2cBKb18=;
X-UUID: 7c65038df8954186812dddb68116d8da-20200228
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 392299191; Fri, 28 Feb 2020 21:45:07 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 28 Feb 2020 21:44:08 +0800
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
Subject: [PATCH v3 09/13] soc: mediatek: cmdq: add write_s value function
Date:   Fri, 28 Feb 2020 21:44:17 +0800
Message-ID: <1582897461-15105-11-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1582897461-15105-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1582897461-15105-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 1C8DF74F6D1ECA49C6F7FF1CC6C1E97C1910ED5E88E7FD03DA95DF2D1656A31A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YWRkIHdyaXRlX3MgZnVuY3Rpb24gaW4gY21kcSBoZWxwZXIgZnVuY3Rpb25zIHdoaWNoDQp3cml0
ZXMgYSBjb25zdGFudCB2YWx1ZSB0byBhZGRyZXNzIHdpdGggbGFyZ2UgZG1hDQphY2Nlc3Mgc3Vw
cG9ydC4NCg0KU2lnbmVkLW9mZi1ieTogRGVubmlzIFlDIEhzaWVoIDxkZW5uaXMteWMuaHNpZWhA
bWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVy
LmMgfCAyNiArKysrKysrKysrKysrKysrKysrKysrKysrKw0KIGluY2x1ZGUvbGludXgvc29jL21l
ZGlhdGVrL210ay1jbWRxLmggIHwgMTQgKysrKysrKysrKysrKysNCiAyIGZpbGVzIGNoYW5nZWQs
IDQwIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210
ay1jbWRxLWhlbHBlci5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMN
CmluZGV4IDQyOGY5OTI4OGNhNi4uMTMzNjUyM2ViN2Q0IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9z
b2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCisrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVr
L210ay1jbWRxLWhlbHBlci5jDQpAQCAtMjY5LDYgKzI2OSwzMiBAQCBpbnQgY21kcV9wa3Rfd3Jp
dGVfcyhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGhpZ2hfYWRkcl9yZWdfaWR4LA0KIH0NCiBF
WFBPUlRfU1lNQk9MKGNtZHFfcGt0X3dyaXRlX3MpOw0KIA0KK2ludCBjbWRxX3BrdF93cml0ZV9z
X3ZhbHVlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgaGlnaF9hZGRyX3JlZ19pZHgsDQorCQkJ
ICAgdTE2IGFkZHJfbG93LCB1MzIgdmFsdWUsIHUzMiBtYXNrKQ0KK3sNCisJc3RydWN0IGNtZHFf
aW5zdHJ1Y3Rpb24gaW5zdCA9IHsgezB9IH07DQorCWludCBlcnI7DQorDQorCWlmIChtYXNrICE9
IFUzMl9NQVgpIHsNCisJCWluc3Qub3AgPSBDTURRX0NPREVfTUFTSzsNCisJCWluc3QubWFzayA9
IH5tYXNrOw0KKwkJZXJyID0gY21kcV9wa3RfYXBwZW5kX2NvbW1hbmQocGt0LCBpbnN0KTsNCisJ
CWlmIChlcnIgPCAwKQ0KKwkJCXJldHVybiBlcnI7DQorDQorCQlpbnN0Lm9wID0gQ01EUV9DT0RF
X1dSSVRFX1NfTUFTSzsNCisJfSBlbHNlIHsNCisJCWluc3Qub3AgPSBDTURRX0NPREVfV1JJVEVf
UzsNCisJfQ0KKw0KKwlpbnN0LnNvcCA9IGhpZ2hfYWRkcl9yZWdfaWR4Ow0KKwlpbnN0Lm9mZnNl
dCA9IGFkZHJfbG93Ow0KKwlpbnN0LnZhbHVlID0gdmFsdWU7DQorDQorCXJldHVybiBjbWRxX3Br
dF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KK30NCitFWFBPUlRfU1lNQk9MKGNtZHFfcGt0
X3dyaXRlX3NfdmFsdWUpOw0KKw0KIGludCBjbWRxX3BrdF93ZmUoc3RydWN0IGNtZHFfcGt0ICpw
a3QsIHUxNiBldmVudCkNCiB7DQogCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHsw
fSB9Ow0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgg
Yi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQppbmRleCAwMWI0MTg0YWYz
MTAuLmZlYzI5MmFhYzgzYyAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVr
L210ay1jbWRxLmgNCisrKyBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgN
CkBAIC0xMzUsNiArMTM1LDIwIEBAIGludCBjbWRxX3BrdF9yZWFkX3Moc3RydWN0IGNtZHFfcGt0
ICpwa3QsIHUxNiBoaWdoX2FkZHJfcmVnX2lkeCwgdTE2IGFkZHJfbG93LA0KIGludCBjbWRxX3Br
dF93cml0ZV9zKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgaGlnaF9hZGRyX3JlZ19pZHgsDQog
CQkgICAgIHUxNiBhZGRyX2xvdywgdTE2IHNyY19yZWdfaWR4LCB1MzIgbWFzayk7DQogDQorLyoq
DQorICogY21kcV9wa3Rfd3JpdGVfc192YWx1ZSgpIC0gYXBwZW5kIHdyaXRlX3MgY29tbWFuZCB3
aXRoIG1hc2sgdG8gdGhlIENNRFENCisgKgkJCSAgICAgIHBhY2tldCB3aGljaCB3cml0ZSB2YWx1
ZSB0byBhIHBoeXNpY2FsIGFkZHJlc3MNCisgKiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQNCisgKiBA
aGlnaF9hZGRyX3JlZ19pZHg6CWludGVybmFsIHJlZ2lzZ2VyIElEIHdoaWNoIGNvbnRhaW5zIGhp
Z2ggYWRkcmVzcyBvZiBwYQ0KKyAqIEBhZGRyX2xvdzoJbG93IGFkZHJlc3Mgb2YgcGENCisgKiBA
dmFsdWU6CXRoZSBzcGVjaWZpZWQgdGFyZ2V0IHZhbHVlDQorICogQG1hc2s6CXRoZSBzcGVjaWZp
ZWQgdGFyZ2V0IG1hc2sNCisgKg0KKyAqIFJldHVybjogMCBmb3Igc3VjY2VzczsgZWxzZSB0aGUg
ZXJyb3IgY29kZSBpcyByZXR1cm5lZA0KKyAqLw0KK2ludCBjbWRxX3BrdF93cml0ZV9zX3ZhbHVl
KHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgaGlnaF9hZGRyX3JlZ19pZHgsDQorCQkJICAgdTE2
IGFkZHJfbG93LCB1MzIgdmFsdWUsIHUzMiBtYXNrKTsNCisNCiAvKioNCiAgKiBjbWRxX3BrdF93
ZmUoKSAtIGFwcGVuZCB3YWl0IGZvciBldmVudCBjb21tYW5kIHRvIHRoZSBDTURRIHBhY2tldA0K
ICAqIEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KLS0gDQoyLjE4LjANCg==

