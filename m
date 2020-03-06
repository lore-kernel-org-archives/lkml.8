Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A377C3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 03:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFC6E206E2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 03:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Pt9qHsl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgCFD4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 22:56:01 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:15514 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726300AbgCFD4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 22:56:01 -0500
X-UUID: 4dfc0d7054d4428a975660398e013419-20200306
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=HbvwGK3+J6EJNiSbZ0JadzfJDjJt686R95a2GVph8QM=;
        b=Pt9qHsl3RzuWTINl1JAmLkik/Uw15ZlDNd/4tPte5SF/FCpz7oxVFWPHDmqs3SrfbQTb8oNfu9wztXl2a28HYOIitRAOlA7PDy1spu1k29e381ORdupWegTfX7Hz0/5W6I3qoSoYPUjtsyRMYnrBPc82YZyUmvVGaN86GwU+9ms=;
X-UUID: 4dfc0d7054d4428a975660398e013419-20200306
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1715054070; Fri, 06 Mar 2020 11:55:50 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 6 Mar 2020 11:54:29 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 6 Mar 2020 11:53:06 +0800
Message-ID: <1583466941.18586.1.camel@mtksdaap41>
Subject: Re: [PATCH v1 2/3] mailbox: mediatek: implement flush function
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     CK Hu <ck.hu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        "Nicolas Boichat" <drinkcat@chromium.org>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>
Date:   Fri, 6 Mar 2020 11:55:41 +0800
In-Reply-To: <1581931765.12547.0.camel@mtksdaap41>
References: <20200217090532.16019-1-bibby.hsieh@mediatek.com>
         <20200217090532.16019-3-bibby.hsieh@mediatek.com>
         <1581931765.12547.0.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 269D5AFE256631CE763A7BA8ECC2A47A2B9957979F165F20397039FB87C414FF2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEphc3NpLA0KDQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL2NvdmVyLzExMzg1ODM5
Lw0KDQpJIHB1c2ggYSBzZXJpZXMgb2YgcGF0Y2hlcyBhYm91dCByZW1vdmUgYXRvbWljX2V4ZWMg
ZmVhdHVyZSBpbiBNZWRpYXRlaw0KQ01EUSBkcml2ZXIuIENvdWxkIHlvdSBwbGVhc2UgcmV2aWV3
IHRoZW0gaWYgeW91IGFyZSBmcmVlPw0KDQpUaGFua3MNCg0KT24gTW9uLCAyMDIwLTAyLTE3IGF0
IDE3OjI5ICswODAwLCBDSyBIdSB3cm90ZToNCj4gSGksIEJpYmJ5Og0KPiANCj4gT24gTW9uLCAy
MDIwLTAyLTE3IGF0IDE3OjA1ICswODAwLCBCaWJieSBIc2llaCB3cm90ZToNCj4gPiBGb3IgY2xp
ZW50IGRyaXZlciB3aGljaCBuZWVkIHRvIHJlb3JnYW5pemUgdGhlIGNvbW1hbmQgYnVmZmVyLCBp
dCBjb3VsZA0KPiA+IHVzZSB0aGlzIGZ1bmN0aW9uIHRvIGZsdXNoIHRoZSBzZW5kIGNvbW1hbmQg
YnVmZmVyLg0KPiA+IElmIHRoZSBjaGFubmVsIGRvZXNuJ3QgYmUgc3RhcnRlZCAodXN1YWxseSBp
biB3YWl0aW5nIGZvciBldmVudCksIHRoaXMNCj4gPiBmdW5jdGlvbiB3aWxsIGFib3J0IGl0IGRp
cmVjdGx5Lg0KPiA+IA0KPiANCj4gUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5j
b20+DQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEJpYmJ5IEhzaWVoIDxiaWJieS5oc2llaEBtZWRp
YXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94
LmMgfCA1MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDUyIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tYWls
Ym94L210ay1jbWRxLW1haWxib3guYyBiL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94
LmMNCj4gPiBpbmRleCA5YTZjZTlmNWE3ZGIuLjBkYTVlMmRjMmMwZSAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+ID4gKysrIGIvZHJpdmVycy9t
YWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiA+IEBAIC00MzIsMTAgKzQzMiw2MiBAQCBzdGF0
aWMgdm9pZCBjbWRxX21ib3hfc2h1dGRvd24oc3RydWN0IG1ib3hfY2hhbiAqY2hhbikNCj4gPiAg
ew0KPiA+ICB9DQo+ID4gIA0KPiA+ICtzdGF0aWMgaW50IGNtZHFfbWJveF9mbHVzaChzdHJ1Y3Qg
bWJveF9jaGFuICpjaGFuLCB1bnNpZ25lZCBsb25nIHRpbWVvdXQpDQo+ID4gK3sNCj4gPiArCXN0
cnVjdCBjbWRxX3RocmVhZCAqdGhyZWFkID0gKHN0cnVjdCBjbWRxX3RocmVhZCAqKWNoYW4tPmNv
bl9wcml2Ow0KPiA+ICsJc3RydWN0IGNtZHFfdGFza19jYiAqY2I7DQo+ID4gKwlzdHJ1Y3QgY21k
cV9jYl9kYXRhIGRhdGE7DQo+ID4gKwlzdHJ1Y3QgY21kcSAqY21kcSA9IGRldl9nZXRfZHJ2ZGF0
YShjaGFuLT5tYm94LT5kZXYpOw0KPiA+ICsJc3RydWN0IGNtZHFfdGFzayAqdGFzaywgKnRtcDsN
Cj4gPiArCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ID4gKwl1MzIgZW5hYmxlOw0KPiA+ICsNCj4g
PiArCXNwaW5fbG9ja19pcnFzYXZlKCZ0aHJlYWQtPmNoYW4tPmxvY2ssIGZsYWdzKTsNCj4gPiAr
CWlmIChsaXN0X2VtcHR5KCZ0aHJlYWQtPnRhc2tfYnVzeV9saXN0KSkNCj4gPiArCQlnb3RvIG91
dDsNCj4gPiArDQo+ID4gKwlXQVJOX09OKGNtZHFfdGhyZWFkX3N1c3BlbmQoY21kcSwgdGhyZWFk
KSA8IDApOw0KPiA+ICsJaWYgKCFjbWRxX3RocmVhZF9pc19pbl93ZmUodGhyZWFkKSkNCj4gPiAr
CQlnb3RvIHdhaXQ7DQo+ID4gKw0KPiA+ICsJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKHRhc2ss
IHRtcCwgJnRocmVhZC0+dGFza19idXN5X2xpc3QsDQo+ID4gKwkJCQkgbGlzdF9lbnRyeSkgew0K
PiA+ICsJCWNiID0gJnRhc2stPnBrdC0+YXN5bmNfY2I7DQo+ID4gKwkJaWYgKGNiLT5jYikgew0K
PiA+ICsJCQlkYXRhLnN0YSA9IENNRFFfQ0JfRVJST1I7DQo+ID4gKwkJCWRhdGEuZGF0YSA9IGNi
LT5kYXRhOw0KPiA+ICsJCQljYi0+Y2IoZGF0YSk7DQo+ID4gKwkJfQ0KPiA+ICsJCWxpc3RfZGVs
KCZ0YXNrLT5saXN0X2VudHJ5KTsNCj4gPiArCQlrZnJlZSh0YXNrKTsNCj4gPiArCX0NCj4gPiAr
DQo+ID4gKwljbWRxX3RocmVhZF9yZXN1bWUodGhyZWFkKTsNCj4gPiArCWNtZHFfdGhyZWFkX2Rp
c2FibGUoY21kcSwgdGhyZWFkKTsNCj4gPiArCWNsa19kaXNhYmxlKGNtZHEtPmNsb2NrKTsNCj4g
PiArDQo+ID4gK291dDoNCj4gPiArCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJnRocmVhZC0+Y2hh
bi0+bG9jaywgZmxhZ3MpOw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gKw0KPiA+ICt3YWl0Og0KPiA+
ICsJY21kcV90aHJlYWRfcmVzdW1lKHRocmVhZCk7DQo+ID4gKwlzcGluX3VubG9ja19pcnFyZXN0
b3JlKCZ0aHJlYWQtPmNoYW4tPmxvY2ssIGZsYWdzKTsNCj4gPiArCWlmIChyZWFkbF9wb2xsX3Rp
bWVvdXRfYXRvbWljKHRocmVhZC0+YmFzZSArIENNRFFfVEhSX0VOQUJMRV9UQVNLLA0KPiA+ICsJ
CQkJICAgICAgZW5hYmxlLCBlbmFibGUgPT0gMCwgMSwgdGltZW91dCkpIHsNCj4gPiArCQlkZXZf
ZXJyKGNtZHEtPm1ib3guZGV2LCAiRmFpbCB0byB3YWl0IEdDRSB0aHJlYWQgMHgleCBkb25lXG4i
LA0KPiA+ICsJCQkodTMyKSh0aHJlYWQtPmJhc2UgLSBjbWRxLT5iYXNlKSk7DQo+ID4gKw0KPiA+
ICsJCXJldHVybiAtRUZBVUxUOw0KPiA+ICsJfQ0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4g
PiArDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbWJveF9jaGFuX29wcyBjbWRxX21ib3hfY2hh
bl9vcHMgPSB7DQo+ID4gIAkuc2VuZF9kYXRhID0gY21kcV9tYm94X3NlbmRfZGF0YSwNCj4gPiAg
CS5zdGFydHVwID0gY21kcV9tYm94X3N0YXJ0dXAsDQo+ID4gIAkuc2h1dGRvd24gPSBjbWRxX21i
b3hfc2h1dGRvd24sDQo+ID4gKwkuZmx1c2ggPSBjbWRxX21ib3hfZmx1c2gsDQo+ID4gIH07DQo+
ID4gIA0KPiA+ICBzdGF0aWMgc3RydWN0IG1ib3hfY2hhbiAqY21kcV94bGF0ZShzdHJ1Y3QgbWJv
eF9jb250cm9sbGVyICptYm94LA0KPiANCj4gDQoNCg==

