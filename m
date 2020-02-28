Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE363C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98DD62072A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SHwf7hfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgB1O7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:59:49 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:3230 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726788AbgB1O7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:59:47 -0500
X-UUID: be1125d1dec44581b285cb0689465ad5-20200228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=NL2GKs6cWZDfq31vqetafIYcn/LVSVpleZHl8l/E0rk=;
        b=SHwf7hfpS2zxYELI5+4ubreXrNJa4ZKvzA11q7RE6/S7dYdqtCf/9FWZ6bINM7qFOjQvcEJf6Dm5PXyX/RQ9T6NkYlNz30Dun5fNP0YNO04dArV/QaqYGpP9CtbMQAgo9hg2uw+u+L5PZFZ0zImaZ+ZXpcJAuRwRTQGMPk+QaL8=;
X-UUID: be1125d1dec44581b285cb0689465ad5-20200228
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 468731037; Fri, 28 Feb 2020 22:59:42 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 28 Feb 2020 22:58:36 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Feb 2020 22:59:23 +0800
Message-ID: <1582901981.14824.9.camel@mtksdaap41>
Subject: Re: [PATCH v3 11/13] soc: mediatek: cmdq: add jump function
From:   CK Hu <ck.hu@mediatek.com>
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        "Ming-Fan Chen" <ming-fan.chen@mediatek.com>
Date:   Fri, 28 Feb 2020 22:59:41 +0800
In-Reply-To: <1582897461-15105-13-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1582897461-15105-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1582897461-15105-13-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERlbm5pczoNCg0KT24gRnJpLCAyMDIwLTAyLTI4IGF0IDIxOjQ0ICswODAwLCBEZW5uaXMg
WUMgSHNpZWggd3JvdGU6DQo+IEFkZCBqdW1wIGZ1bmN0aW9uIHNvIHRoYXQgY2xpZW50IGNhbiBq
dW1wIHRvIGFueSBhZGRyZXNzIHdoaWNoDQo+IGNvbnRhaW5zIGluc3RydWN0aW9uLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogRGVubmlzIFlDIEhzaWVoIDxkZW5uaXMteWMuaHNpZWhAbWVkaWF0ZWsu
Y29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIHwg
MTIgKysrKysrKysrKysrDQo+ICBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5o
ICB8IDExICsrKysrKysrKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIu
YyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+IGluZGV4IDU4ZmVj
NjM0ZGNmMS4uYmJjNjhhN2M4MWU5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRl
ay9tdGstY21kcS1oZWxwZXIuYw0KPiArKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21k
cS1oZWxwZXIuYw0KPiBAQCAtMzcyLDYgKzM3MiwxOCBAQCBpbnQgY21kcV9wa3RfYXNzaWduKHN0
cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgcmVnX2lkeCwgdTMyIHZhbHVlKQ0KPiAgfQ0KPiAgRVhQ
T1JUX1NZTUJPTChjbWRxX3BrdF9hc3NpZ24pOw0KPiAgDQo+ICtpbnQgY21kcV9wa3RfanVtcChz
dHJ1Y3QgY21kcV9wa3QgKnBrdCwgZG1hX2FkZHJfdCBhZGRyKQ0KPiArew0KPiArCXN0cnVjdCBj
bWRxX2NsaWVudCAqY2wgPSBwa3QtPmNsOw0KPiArCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGlu
c3QgPSB7IHswfSB9Ow0KPiArDQo+ICsJaW5zdC5vcCA9IENNRFFfQ09ERV9KVU1QOw0KPiArCWlu
c3Qub2Zmc2V0ID0gMTsNCg0KU3ltYm9saXplIHRoZSB2YWx1ZSAnMScuDQoNCj4gKwlpbnN0LnZh
bHVlID0gYWRkciA+PiBjbWRxX21ib3hfc2hpZnQoY2wtPmNoYW4pOw0KDQpJZiB5b3Ugd3JpdGUg
YXMgJ2NtZHFfbWJveF9zaGlmdChwa3QtPmNsLT5jaGFuKScsIHlvdSBjb3VsZCBkcm9wIGxvY2Fs
DQp2YXJpYWJsZSAnY2wnLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiArCXJldHVybiBjbWRxX3BrdF9h
cHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KPiArfQ0KPiArRVhQT1JUX1NZTUJPTChjbWRxX3Br
dF9qdW1wKTsNCj4gKw0KPiAgaW50IGNtZHFfcGt0X2ZpbmFsaXplKHN0cnVjdCBjbWRxX3BrdCAq
cGt0KQ0KPiAgew0KPiAgCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0K
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCBiL2lu
Y2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gaW5kZXggOTllNzcxNTVmOTY3
Li4xYTZjNTZmM2JlYzEgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVr
L210ay1jbWRxLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEu
aA0KPiBAQCAtMjEzLDYgKzIxMywxNyBAQCBpbnQgY21kcV9wa3RfcG9sbF9tYXNrKHN0cnVjdCBj
bWRxX3BrdCAqcGt0LCB1OCBzdWJzeXMsDQo+ICAgKi8NCj4gIGludCBjbWRxX3BrdF9hc3NpZ24o
c3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiByZWdfaWR4LCB1MzIgdmFsdWUpOw0KPiAgDQo+ICsv
KioNCj4gKyAqIGNtZHFfcGt0X2p1bXAoKSAtIEFwcGVuZCBqdW1wIGNvbW1hbmQgdG8gdGhlIENN
RFEgcGFja2V0LCBhc2sgR0NFDQo+ICsgKgkJICAgICB0byBleGVjdXRlIGFuIGluc3RydWN0aW9u
IHRoYXQgY2hhbmdlIGN1cnJlbnQgdGhyZWFkIFBDIHRvDQo+ICsgKgkJICAgICBhIHBoeXNpY2Fs
IGFkZHJlc3Mgd2hpY2ggc2hvdWxkIGNvbnRhaW5zIG1vcmUgaW5zdHJ1Y3Rpb24uDQo+ICsgKiBA
cGt0OiAgICAgICAgdGhlIENNRFEgcGFja2V0DQo+ICsgKiBAYWRkcjogICAgICAgcGh5c2ljYWwg
YWRkcmVzcyBvZiB0YXJnZXQgaW5zdHJ1Y3Rpb24gYnVmZmVyDQo+ICsgKg0KPiArICogUmV0dXJu
OiAwIGZvciBzdWNjZXNzOyBlbHNlIHRoZSBlcnJvciBjb2RlIGlzIHJldHVybmVkDQo+ICsgKi8N
Cj4gK2ludCBjbWRxX3BrdF9qdW1wKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCBkbWFfYWRkcl90IGFk
ZHIpOw0KPiArDQo+ICAvKioNCj4gICAqIGNtZHFfcGt0X2ZpbmFsaXplKCkgLSBBcHBlbmQgRU9D
IGFuZCBqdW1wIGNvbW1hbmQgdG8gcGt0Lg0KPiAgICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQoN
Cg==

