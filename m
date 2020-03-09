Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D3AC10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 01:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87DD0206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 01:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gjOLEitI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgCIBsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 21:48:24 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:28167 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726875AbgCIBsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 21:48:24 -0400
X-UUID: ed99637e9f564bcc8bc0e65f8c9787cb-20200309
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=lji2RDfjYiKO0JLX1yRMYaI2Rm6gbe1z5aG0az/wNdo=;
        b=gjOLEitIurGZfl1wvPLfp7ggzS59GLiZHk8RZuNQKQ0b0GULsvKPS4CeSnIBsDS5m9nYxFfohwwNVy3C84Fmceo94BXePwla9bt6naF1eMNBKVJ9nZP1VSm7Afw4vRQA+UjzMtW9oOHda/LZkn1y+0/WuIMOUY5v7O9HwPWxxgo=;
X-UUID: ed99637e9f564bcc8bc0e65f8c9787cb-20200309
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1109298110; Mon, 09 Mar 2020 09:48:18 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 9 Mar 2020 09:47:20 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 9 Mar 2020 09:48:35 +0800
Message-ID: <1583718497.28331.0.camel@mtksdaap41>
Subject: Re: [PATCH v5 11/13] soc: mediatek: cmdq: add jump function
From:   CK Hu <ck.hu@mediatek.com>
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        HS Liao <hs.liao@mediatek.com>
Date:   Mon, 9 Mar 2020 09:48:17 +0800
In-Reply-To: <1583664775-19382-12-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1583664775-19382-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1583664775-19382-12-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERlbm5pczoNCg0KT24gU3VuLCAyMDIwLTAzLTA4IGF0IDE4OjUyICswODAwLCBEZW5uaXMg
WUMgSHNpZWggd3JvdGU6DQo+IEFkZCBqdW1wIGZ1bmN0aW9uIHNvIHRoYXQgY2xpZW50IGNhbiBq
dW1wIHRvIGFueSBhZGRyZXNzIHdoaWNoDQo+IGNvbnRhaW5zIGluc3RydWN0aW9uLg0KPiANCg0K
UmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gU2lnbmVkLW9mZi1i
eTogRGVubmlzIFlDIEhzaWVoIDxkZW5uaXMteWMuaHNpZWhAbWVkaWF0ZWsuY29tPg0KPiAtLS0N
Cj4gIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIHwgMTMgKysrKysrKysr
KysrKw0KPiAgaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCAgfCAxMSArKysr
KysrKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMgYi9kcml2ZXJz
L3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiBpbmRleCA1OWJjMTE2NGI0MTEuLmJi
NWJlMjBmYzcwYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEt
aGVscGVyLmMNCj4gKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMN
Cj4gQEAgLTEzLDYgKzEzLDcgQEANCj4gICNkZWZpbmUgQ01EUV9QT0xMX0VOQUJMRV9NQVNLCUJJ
VCgwKQ0KPiAgI2RlZmluZSBDTURRX0VPQ19JUlFfRU4JCUJJVCgwKQ0KPiAgI2RlZmluZSBDTURR
X1JFR19UWVBFCQkxDQo+ICsjZGVmaW5lIENNRFFfSlVNUF9SRUxBVElWRQkxDQo+ICANCj4gIHN0
cnVjdCBjbWRxX2luc3RydWN0aW9uIHsNCj4gIAl1bmlvbiB7DQo+IEBAIC0zNzIsNiArMzczLDE4
IEBAIGludCBjbWRxX3BrdF9hc3NpZ24oc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiByZWdfaWR4
LCB1MzIgdmFsdWUpDQo+ICB9DQo+ICBFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X2Fzc2lnbik7DQo+
ICANCj4gK2ludCBjbWRxX3BrdF9qdW1wKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCBkbWFfYWRkcl90
IGFkZHIpDQo+ICt7DQo+ICsJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHsgezB9IH07
DQo+ICsNCj4gKwlpbnN0Lm9wID0gQ01EUV9DT0RFX0pVTVA7DQo+ICsJaW5zdC5vZmZzZXQgPSBD
TURRX0pVTVBfUkVMQVRJVkU7DQo+ICsJaW5zdC52YWx1ZSA9IGFkZHIgPj4NCj4gKwkJY21kcV9t
Ym94X3NoaWZ0KCgoc3RydWN0IGNtZHFfY2xpZW50ICopcGt0LT5jbCktPmNoYW4pOw0KPiArCXJl
dHVybiBjbWRxX3BrdF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KPiArfQ0KPiArRVhQT1JU
X1NZTUJPTChjbWRxX3BrdF9qdW1wKTsNCj4gKw0KPiAgaW50IGNtZHFfcGt0X2ZpbmFsaXplKHN0
cnVjdCBjbWRxX3BrdCAqcGt0KQ0KPiAgew0KPiAgCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGlu
c3QgPSB7IHswfSB9Ow0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsv
bXRrLWNtZHEuaCBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gaW5k
ZXggOTllNzcxNTVmOTY3Li4xYTZjNTZmM2JlYzEgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGlu
dXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVk
aWF0ZWsvbXRrLWNtZHEuaA0KPiBAQCAtMjEzLDYgKzIxMywxNyBAQCBpbnQgY21kcV9wa3RfcG9s
bF9tYXNrKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBzdWJzeXMsDQo+ICAgKi8NCj4gIGludCBj
bWRxX3BrdF9hc3NpZ24oc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiByZWdfaWR4LCB1MzIgdmFs
dWUpOw0KPiAgDQo+ICsvKioNCj4gKyAqIGNtZHFfcGt0X2p1bXAoKSAtIEFwcGVuZCBqdW1wIGNv
bW1hbmQgdG8gdGhlIENNRFEgcGFja2V0LCBhc2sgR0NFDQo+ICsgKgkJICAgICB0byBleGVjdXRl
IGFuIGluc3RydWN0aW9uIHRoYXQgY2hhbmdlIGN1cnJlbnQgdGhyZWFkIFBDIHRvDQo+ICsgKgkJ
ICAgICBhIHBoeXNpY2FsIGFkZHJlc3Mgd2hpY2ggc2hvdWxkIGNvbnRhaW5zIG1vcmUgaW5zdHJ1
Y3Rpb24uDQo+ICsgKiBAcGt0OiAgICAgICAgdGhlIENNRFEgcGFja2V0DQo+ICsgKiBAYWRkcjog
ICAgICAgcGh5c2ljYWwgYWRkcmVzcyBvZiB0YXJnZXQgaW5zdHJ1Y3Rpb24gYnVmZmVyDQo+ICsg
Kg0KPiArICogUmV0dXJuOiAwIGZvciBzdWNjZXNzOyBlbHNlIHRoZSBlcnJvciBjb2RlIGlzIHJl
dHVybmVkDQo+ICsgKi8NCj4gK2ludCBjbWRxX3BrdF9qdW1wKHN0cnVjdCBjbWRxX3BrdCAqcGt0
LCBkbWFfYWRkcl90IGFkZHIpOw0KPiArDQo+ICAvKioNCj4gICAqIGNtZHFfcGt0X2ZpbmFsaXpl
KCkgLSBBcHBlbmQgRU9DIGFuZCBqdW1wIGNvbW1hbmQgdG8gcGt0Lg0KPiAgICogQHBrdDoJdGhl
IENNRFEgcGFja2V0DQoNCg==

