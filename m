Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466B4C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 02:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFEA2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 02:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kUv+Q1W6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387518AbgCDCgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 21:36:48 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:8565 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387406AbgCDCgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 21:36:47 -0500
X-UUID: 4e0a777e8c7149e8b7eb90a0ce6943d3-20200304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=N8uzmfi4oZf5SjaF1khnb5BTauSzbMkMnOjjAfK7Xwg=;
        b=kUv+Q1W63A1dnmFWptEDLaQr7gyze9SehA222Fyqr7zllZKbNIHIf1F0EGqReLd6ka4+p/1Rgd3Kknmz+q33UEJoyThY6z4k9bHCjdynbyilnP58GhkJMgF49xLrDBYnlqIeIHnIbzsr+BM84pff+IG5qmD0tZrypsAxt+bV1OI=;
X-UUID: 4e0a777e8c7149e8b7eb90a0ce6943d3-20200304
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 212195843; Wed, 04 Mar 2020 10:36:43 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 4 Mar 2020 10:35:46 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 4 Mar 2020 10:36:01 +0800
Message-ID: <1583289401.32049.2.camel@mtksdaap41>
Subject: Re: [PATCH v4 04/13] mailbox: mediatek: cmdq: clear task in channel
 before shutdown
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
Date:   Wed, 4 Mar 2020 10:36:41 +0800
In-Reply-To: <1583233125-7827-5-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1583233125-7827-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1583233125-7827-5-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERlbm5pczoNCg0KT24gVHVlLCAyMDIwLTAzLTAzIGF0IDE4OjU4ICswODAwLCBEZW5uaXMg
WUMgSHNpZWggd3JvdGU6DQo+IERvIHN1Y2Nlc3MgY2FsbGJhY2sgaW4gY2hhbm5lbCB3aGVuIHNo
dXRkb3duLiBGb3IgdGhvc2UgdGFzayBub3QgZmluaXNoLA0KPiBjYWxsYmFjayB3aXRoIGVycm9y
IGNvZGUgdGh1cyBjbGllbnQgaGFzIGNoYW5jZSB0byBjbGVhbnVwIG9yIHJlc2V0Lg0KPiANCg0K
UmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gU2lnbmVkLW9mZi1i
eTogRGVubmlzIFlDIEhzaWVoIDxkZW5uaXMteWMuaHNpZWhAbWVkaWF0ZWsuY29tPg0KPiAtLS0N
Cj4gIGRyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMgfCAzOCArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYyBiL2Ry
aXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gaW5kZXggOTk5NGFjOTQyNmQ2Li5i
NTZkMzQwYzg5ODIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWls
Ym94LmMNCj4gKysrIGIvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiBAQCAt
Mzg3LDYgKzM4NywxMiBAQCBzdGF0aWMgaW50IGNtZHFfbWJveF9zZW5kX2RhdGEoc3RydWN0IG1i
b3hfY2hhbiAqY2hhbiwgdm9pZCAqZGF0YSkNCj4gIA0KPiAgCWlmIChsaXN0X2VtcHR5KCZ0aHJl
YWQtPnRhc2tfYnVzeV9saXN0KSkgew0KPiAgCQlXQVJOX09OKGNsa19lbmFibGUoY21kcS0+Y2xv
Y2spIDwgMCk7DQo+ICsJCS8qDQo+ICsJCSAqIFRoZSB0aHJlYWQgcmVzZXQgd2lsbCBjbGVhciB0
aHJlYWQgcmVsYXRlZCByZWdpc3RlciB0byAwLA0KPiArCQkgKiBpbmNsdWRpbmcgcGMsIGVuZCwg
cHJpb3JpdHksIGlycSwgc3VzcGVuZCBhbmQgZW5hYmxlLiBUaHVzDQo+ICsJCSAqIHNldCBDTURR
X1RIUl9FTkFCTEVEIHRvIENNRFFfVEhSX0VOQUJMRV9UQVNLIHdpbGwgZW5hYmxlDQo+ICsJCSAq
IHRocmVhZCBhbmQgbWFrZSBpdCBydW5uaW5nLg0KPiArCQkgKi8NCj4gIAkJV0FSTl9PTihjbWRx
X3RocmVhZF9yZXNldChjbWRxLCB0aHJlYWQpIDwgMCk7DQo+ICANCj4gIAkJd3JpdGVsKHRhc2st
PnBhX2Jhc2UgPj4gY21kcS0+c2hpZnRfcGEsDQo+IEBAIC00NTAsNiArNDU2LDM4IEBAIHN0YXRp
YyBpbnQgY21kcV9tYm94X3N0YXJ0dXAoc3RydWN0IG1ib3hfY2hhbiAqY2hhbikNCj4gIA0KPiAg
c3RhdGljIHZvaWQgY21kcV9tYm94X3NodXRkb3duKHN0cnVjdCBtYm94X2NoYW4gKmNoYW4pDQo+
ICB7DQo+ICsJc3RydWN0IGNtZHFfdGhyZWFkICp0aHJlYWQgPSAoc3RydWN0IGNtZHFfdGhyZWFk
ICopY2hhbi0+Y29uX3ByaXY7DQo+ICsJc3RydWN0IGNtZHEgKmNtZHEgPSBkZXZfZ2V0X2RydmRh
dGEoY2hhbi0+bWJveC0+ZGV2KTsNCj4gKwlzdHJ1Y3QgY21kcV90YXNrICp0YXNrLCAqdG1wOw0K
PiArCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ICsNCj4gKwlzcGluX2xvY2tfaXJxc2F2ZSgmdGhy
ZWFkLT5jaGFuLT5sb2NrLCBmbGFncyk7DQo+ICsJaWYgKGxpc3RfZW1wdHkoJnRocmVhZC0+dGFz
a19idXN5X2xpc3QpKQ0KPiArCQlnb3RvIGRvbmU7DQo+ICsNCj4gKwlXQVJOX09OKGNtZHFfdGhy
ZWFkX3N1c3BlbmQoY21kcSwgdGhyZWFkKSA8IDApOw0KPiArDQo+ICsJLyogbWFrZSBzdXJlIGV4
ZWN1dGVkIHRhc2tzIGhhdmUgc3VjY2VzcyBjYWxsYmFjayAqLw0KPiArCWNtZHFfdGhyZWFkX2ly
cV9oYW5kbGVyKGNtZHEsIHRocmVhZCk7DQo+ICsJaWYgKGxpc3RfZW1wdHkoJnRocmVhZC0+dGFz
a19idXN5X2xpc3QpKQ0KPiArCQlnb3RvIGRvbmU7DQo+ICsNCj4gKwlsaXN0X2Zvcl9lYWNoX2Vu
dHJ5X3NhZmUodGFzaywgdG1wLCAmdGhyZWFkLT50YXNrX2J1c3lfbGlzdCwNCj4gKwkJCQkgbGlz
dF9lbnRyeSkgew0KPiArCQljbWRxX3Rhc2tfZXhlY19kb25lKHRhc2ssIENNRFFfQ0JfRVJST1Ip
Ow0KPiArCQlrZnJlZSh0YXNrKTsNCj4gKwl9DQo+ICsNCj4gKwljbWRxX3RocmVhZF9kaXNhYmxl
KGNtZHEsIHRocmVhZCk7DQo+ICsJY2xrX2Rpc2FibGUoY21kcS0+Y2xvY2spOw0KPiArZG9uZToN
Cj4gKwkvKg0KPiArCSAqIFRoZSB0aHJlYWQtPnRhc2tfYnVzeV9saXN0IGVtcHR5IG1lYW5zIHRo
cmVhZCBhbHJlYWR5IGRpc2FibGUuIFRoZQ0KPiArCSAqIGNtZHFfbWJveF9zZW5kX2RhdGEoKSBh
bHdheXMgcmVzZXQgdGhyZWFkIHdoaWNoIGNsZWFyIGRpc2FibGUgYW5kDQo+ICsJICogc3VzcGVu
ZCBzdGF0dWUgd2hlbiBmaXJzdCBwa3Qgc2VuZCB0byBjaGFubmVsLCBzbyB0aGVyZSBpcyBubyBu
ZWVkDQo+ICsJICogdG8gZG8gYW55IG9wZXJhdGlvbiBoZXJlLCBvbmx5IHVubG9jayBhbmQgbGVh
dmUuDQo+ICsJICovDQo+ICsJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmdGhyZWFkLT5jaGFuLT5s
b2NrLCBmbGFncyk7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbWJveF9jaGFu
X29wcyBjbWRxX21ib3hfY2hhbl9vcHMgPSB7DQoNCg==

