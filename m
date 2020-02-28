Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20939C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA866246AC
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="U9wljsTS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgB1P5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:57:10 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:64132 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726974AbgB1P5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:57:09 -0500
X-UUID: dda641ff5eeb460aaa859fb4d8141221-20200228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=7cG0Tkp+Ug5bunGNSSGHb42Z5Rk9tRubfSu6RGs66GY=;
        b=U9wljsTS+9QA78E7tkaGPYnKRaB5orpxGtjvFBYeqcJEedZvENz3p8MuQojKtJGZ5i5DNk7F8Nmg17qHSqbVgd2CX9jOG2ZnEC8G6pzmyM5KG/h2IyM/WN35kN4zcimEoevusFKYE5JYL5ZFeddhuPP67WNJD092YvejNCEjZsw=;
X-UUID: dda641ff5eeb460aaa859fb4d8141221-20200228
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1629152953; Fri, 28 Feb 2020 23:57:04 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 28 Feb 2020 23:56:12 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Feb 2020 23:57:00 +0800
Message-ID: <1582905422.14824.22.camel@mtksdaap41>
Subject: Re: [PATCH v3 04/13] mailbox: mediatek: cmdq: clear task in channel
 before shutdown
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
Date:   Fri, 28 Feb 2020 23:57:02 +0800
In-Reply-To: <1582897461-15105-6-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1582897461-15105-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1582897461-15105-6-git-send-email-dennis-yc.hsieh@mediatek.com>
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
WUMgSHNpZWggd3JvdGU6DQo+IERvIHN1Y2Nlc3MgY2FsbGJhY2sgaW4gY2hhbm5lbCB3aGVuIHNo
dXRkb3duLiBGb3IgdGhvc2UgdGFzayBub3QgZmluaXNoLA0KPiBjYWxsYmFjayB3aXRoIGVycm9y
IGNvZGUgdGh1cyBjbGllbnQgaGFzIGNoYW5jZSB0byBjbGVhbnVwIG9yIHJlc2V0Lg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogRGVubmlzIFlDIEhzaWVoIDxkZW5uaXMteWMuaHNpZWhAbWVkaWF0ZWsu
Y29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMgfCAzOCAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAzOCBpbnNl
cnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1h
aWxib3guYyBiL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gaW5kZXggNzI0
NmI3ZTIxYTJlLi41MGRlYzAxNTU5M2YgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWFpbGJveC9t
dGstY21kcS1tYWlsYm94LmMNCj4gKysrIGIvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxi
b3guYw0KPiBAQCAtMzg3LDYgKzM4NywxMiBAQCBzdGF0aWMgaW50IGNtZHFfbWJveF9zZW5kX2Rh
dGEoc3RydWN0IG1ib3hfY2hhbiAqY2hhbiwgdm9pZCAqZGF0YSkNCj4gIA0KPiAgCWlmIChsaXN0
X2VtcHR5KCZ0aHJlYWQtPnRhc2tfYnVzeV9saXN0KSkgew0KPiAgCQlXQVJOX09OKGNsa19lbmFi
bGUoY21kcS0+Y2xvY2spIDwgMCk7DQo+ICsJCS8qDQo+ICsJCSAqIFRoZSB0aHJlYWQgcmVzZXQg
d2lsbCBjbGVhciB0aHJlYWQgcmVsYXRlZCByZWdpc3RlciB0byAwLA0KPiArCQkgKiBpbmNsdWRp
bmcgcGMsIGVuZCwgcHJpb3JpdHksIGlycSwgc3VzcGVuZCBhbmQgZW5hYmxlLiBUaHVzDQo+ICsJ
CSAqIHNldCBDTURRX1RIUl9FTkFCTEVEIHRvIENNRFFfVEhSX0VOQUJMRV9UQVNLIHdpbGwgZW5h
YmxlDQo+ICsJCSAqIHRocmVhZCBhbmQgbWFrZSBpdCBydW5uaW5nLg0KPiArCQkgKi8NCj4gIAkJ
V0FSTl9PTihjbWRxX3RocmVhZF9yZXNldChjbWRxLCB0aHJlYWQpIDwgMCk7DQo+ICANCj4gIAkJ
d3JpdGVsKHRhc2stPnBhX2Jhc2UgPj4gY21kcS0+c2hpZnRfcGEsDQo+IEBAIC00NTAsNiArNDU2
LDM4IEBAIHN0YXRpYyBpbnQgY21kcV9tYm94X3N0YXJ0dXAoc3RydWN0IG1ib3hfY2hhbiAqY2hh
bikNCj4gIA0KPiAgc3RhdGljIHZvaWQgY21kcV9tYm94X3NodXRkb3duKHN0cnVjdCBtYm94X2No
YW4gKmNoYW4pDQo+ICB7DQo+ICsJc3RydWN0IGNtZHFfdGhyZWFkICp0aHJlYWQgPSAoc3RydWN0
IGNtZHFfdGhyZWFkICopY2hhbi0+Y29uX3ByaXY7DQo+ICsJc3RydWN0IGNtZHEgKmNtZHEgPSBk
ZXZfZ2V0X2RydmRhdGEoY2hhbi0+bWJveC0+ZGV2KTsNCj4gKwlzdHJ1Y3QgY21kcV90YXNrICp0
YXNrLCAqdG1wOw0KPiArCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ICsNCj4gKwlzcGluX2xvY2tf
aXJxc2F2ZSgmdGhyZWFkLT5jaGFuLT5sb2NrLCBmbGFncyk7DQo+ICsJaWYgKGxpc3RfZW1wdHko
JnRocmVhZC0+dGFza19idXN5X2xpc3QpKQ0KPiArCQlnb3RvIGRvbmU7DQo+ICsNCj4gKwlXQVJO
X09OKGNtZHFfdGhyZWFkX3N1c3BlbmQoY21kcSwgdGhyZWFkKSA8IDApOw0KPiArDQo+ICsJLyog
bWFrZSBzdXJlIGV4ZWN1dGVkIHRhc2tzIGhhdmUgc3VjY2VzcyBjYWxsYmFjayAqLw0KPiArCWNt
ZHFfdGhyZWFkX2lycV9oYW5kbGVyKGNtZHEsIHRocmVhZCk7DQo+ICsJaWYgKGxpc3RfZW1wdHko
JnRocmVhZC0+dGFza19idXN5X2xpc3QpKQ0KPiArCQlnb3RvIGRvbmU7DQo+ICsNCj4gKwlsaXN0
X2Zvcl9lYWNoX2VudHJ5X3NhZmUodGFzaywgdG1wLCAmdGhyZWFkLT50YXNrX2J1c3lfbGlzdCwN
Cj4gKwkJCQkgbGlzdF9lbnRyeSkgew0KPiArCQljbWRxX3Rhc2tfZXhlY19kb25lKHRhc2ssIC1F
Q09OTkFCT1JURUQpOw0KDQpjbWRxX3Rhc2tfZXhlY19kb25lKHRhc2ssIENNRFFfQ0JfRVJST1Ip
ID8gSG93ZXZlciwgSSd2ZSBsaWtlIHRvIHVzZSB0aGUNCnN0YW5kYXJkIGVycm9yIGFzIHlvdSB3
cml0ZSBoZXJlLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiArCQlrZnJlZSh0YXNrKTsNCj4gKwl9DQo+
ICsNCj4gKwljbWRxX3RocmVhZF9kaXNhYmxlKGNtZHEsIHRocmVhZCk7DQo+ICsJY2xrX2Rpc2Fi
bGUoY21kcS0+Y2xvY2spOw0KPiArZG9uZToNCj4gKwkvKg0KPiArCSAqIFRoZSB0aHJlYWQtPnRh
c2tfYnVzeV9saXN0IGVtcHR5IG1lYW5zIHRocmVhZCBhbHJlYWR5IGRpc2FibGUuIFRoZQ0KPiAr
CSAqIGNtZHFfbWJveF9zZW5kX2RhdGEoKSBhbHdheXMgcmVzZXQgdGhyZWFkIHdoaWNoIGNsZWFy
IGRpc2FibGUgYW5kDQo+ICsJICogc3VzcGVuZCBzdGF0dWUgd2hlbiBmaXJzdCBwa3Qgc2VuZCB0
byBjaGFubmVsLCBzbyB0aGVyZSBpcyBubyBuZWVkDQo+ICsJICogdG8gZG8gYW55IG9wZXJhdGlv
biBoZXJlLCBvbmx5IHVubG9jayBhbmQgbGVhdmUuDQo+ICsJICovDQo+ICsJc3Bpbl91bmxvY2tf
aXJxcmVzdG9yZSgmdGhyZWFkLT5jaGFuLT5sb2NrLCBmbGFncyk7DQo+ICB9DQo+ICANCj4gIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgbWJveF9jaGFuX29wcyBjbWRxX21ib3hfY2hhbl9vcHMgPSB7DQoN
Cg==

