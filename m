Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5DFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 02:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78C66207F5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 02:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aLSG1kWm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgGBCxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 22:53:25 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:40039 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726146AbgGBCxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 22:53:25 -0400
X-UUID: dee14df25634404982d404beca267926-20200702
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=afpaC7qRGVZ6JRFynQgro+7OJFSDdHfSPLeLJ/lq7kQ=;
        b=aLSG1kWmHRehrrGQ3rqzjfigMarWaiFUhQ7v78o07HneYshjxm0TtsjxlfDJ93oVg48TrHNcYz/mTSwKXH2FX3xrwX0W8pO9A89pAl6spVO2XB7nXm8UocNMJ6AfRRU1t1SHBFdrmGxJHPd54OoLXPkaB+PsXp4NdKb2UAlrIFQ=;
X-UUID: dee14df25634404982d404beca267926-20200702
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 290555990; Thu, 02 Jul 2020 10:53:16 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 2 Jul
 2020 10:53:14 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Jul 2020 10:53:09 +0800
Message-ID: <1593658371.23885.16.camel@mhfsdcap03>
Subject: Re: [V2 PATCH] usb: mtu3: fix NULL pointer dereference
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Thu, 2 Jul 2020 10:52:51 +0800
In-Reply-To: <20200701115821.GA2184169@kroah.com>
References: <1593502942-24455-1-git-send-email-chunfeng.yun@mediatek.com>
         <20200701115821.GA2184169@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 9F8CFEA6CEBAFB7D9D5D9DF806B368CC530AA52FD6E6FE9C3269E92BF6BF031F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA3LTAxIGF0IDEzOjU4ICswMjAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IE9uIFR1ZSwgSnVuIDMwLCAyMDIwIGF0IDAzOjQyOjIyUE0gKzA4MDAsIENodW5mZW5n
IFl1biB3cm90ZToNCj4gPiBTb21lIHBvaW50ZXJzIGFyZSBkZXJlZmVyZW5jZWQgYmVmb3JlIHN1
Y2Nlc3NmdWwgY2hlY2tzLg0KPiA+IA0KPiA+IFJlcG9ydGVkLWJ5OiBNYXJrdXMgRWxmcmluZyA8
TWFya3VzLkVsZnJpbmdAd2ViLmRlPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8
Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiB2Mjogbm90aGluZyBjaGFu
Z2VkLCBidXQgYWJhbmRvbiBhbm90aGVyIHBhdGNoDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvdXNi
L210dTMvbXR1M19nYWRnZXQuYyB8IDI1ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0NCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+ID4gDQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL210dTMvbXR1M19nYWRnZXQuYyBiL2RyaXZlcnMv
dXNiL210dTMvbXR1M19nYWRnZXQuYw0KPiA+IGluZGV4IGY5MzczMmUuLjE2ODljYTggMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy91c2IvbXR1My9tdHUzX2dhZGdldC5jDQo+ID4gKysrIGIvZHJp
dmVycy91c2IvbXR1My9tdHUzX2dhZGdldC5jDQo+ID4gQEAgLTMzMiwxNCArMzMyLDIxIEBAIHN0
YXRpYyBpbnQgbXR1M19nYWRnZXRfcXVldWUoc3RydWN0IHVzYl9lcCAqZXAsDQo+ID4gIA0KPiA+
ICBzdGF0aWMgaW50IG10dTNfZ2FkZ2V0X2RlcXVldWUoc3RydWN0IHVzYl9lcCAqZXAsIHN0cnVj
dCB1c2JfcmVxdWVzdCAqcmVxKQ0KPiA+ICB7DQo+ID4gLQlzdHJ1Y3QgbXR1M19lcCAqbWVwID0g
dG9fbXR1M19lcChlcCk7DQo+ID4gLQlzdHJ1Y3QgbXR1M19yZXF1ZXN0ICptcmVxID0gdG9fbXR1
M19yZXF1ZXN0KHJlcSk7DQo+ID4gKwlzdHJ1Y3QgbXR1M19lcCAqbWVwOw0KPiA+ICsJc3RydWN0
IG10dTNfcmVxdWVzdCAqbXJlcTsNCj4gPiAgCXN0cnVjdCBtdHUzX3JlcXVlc3QgKnI7DQo+ID4g
KwlzdHJ1Y3QgbXR1MyAqbXR1Ow0KPiA+ICAJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gPiAgCWlu
dCByZXQgPSAwOw0KPiA+IC0Jc3RydWN0IG10dTMgKm10dSA9IG1lcC0+bXR1Ow0KPiA+ICANCj4g
PiAtCWlmICghZXAgfHwgIXJlcSB8fCBtcmVxLT5tZXAgIT0gbWVwKQ0KPiA+ICsJaWYgKCFlcCB8
fCAhcmVxKQ0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiANCj4gSG93IHdpbGwgZWl0aGVyIG9m
IHRob3NlIGV2ZXIgYmUgTlVMTD8gIFRoZSBrZXJuZWwgd2lsbCBub3QgY2FsbCB0aGlzDQo+IGZ1
bmN0aW9uIHdpdGggZWl0aGVyIG9mIHRoZW0gYmVpbmcgTlVMTCwgcmlnaHQ/DQpZZXMsIEkgZmlu
ZCBhbGwgY2xhc3MgZHJpdmVycyBhbHJlYWR5IGVuc3VyZSB0aGV5IGFyZSBub3QgTlVMTC4NCg0K
PiANCj4gPiArDQo+ID4gKwltZXAgPSB0b19tdHUzX2VwKGVwKTsNCj4gPiArCW10dSA9IG1lcC0+
bXR1Ow0KPiA+ICsNCj4gPiArCW1yZXEgPSB0b19tdHUzX3JlcXVlc3QocmVxKTsNCj4gPiArCWlm
IChtcmVxLT5tZXAgIT0gbWVwKQ0KPiA+ICAJCXJldHVybiAtRUlOVkFMOw0KPiA+ICANCj4gPiAg
CWRldl9kYmcobXR1LT5kZXYsICIlcyA6IHJlcT0lcFxuIiwgX19mdW5jX18sIHJlcSk7DQo+ID4g
QEAgLTM3Myw4ICszODAsOCBAQCBzdGF0aWMgaW50IG10dTNfZ2FkZ2V0X2RlcXVldWUoc3RydWN0
IHVzYl9lcCAqZXAsIHN0cnVjdCB1c2JfcmVxdWVzdCAqcmVxKQ0KPiA+ICAgKi8NCj4gPiAgc3Rh
dGljIGludCBtdHUzX2dhZGdldF9lcF9zZXRfaGFsdChzdHJ1Y3QgdXNiX2VwICplcCwgaW50IHZh
bHVlKQ0KPiA+ICB7DQo+ID4gLQlzdHJ1Y3QgbXR1M19lcCAqbWVwID0gdG9fbXR1M19lcChlcCk7
DQo+ID4gLQlzdHJ1Y3QgbXR1MyAqbXR1ID0gbWVwLT5tdHU7DQo+ID4gKwlzdHJ1Y3QgbXR1M19l
cCAqbWVwOw0KPiA+ICsJc3RydWN0IG10dTMgKm10dTsNCj4gPiAgCXN0cnVjdCBtdHUzX3JlcXVl
c3QgKm1yZXE7DQo+ID4gIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiA+ICAJaW50IHJldCA9IDA7
DQo+ID4gQEAgLTM4Miw2ICszODksOSBAQCBzdGF0aWMgaW50IG10dTNfZ2FkZ2V0X2VwX3NldF9o
YWx0KHN0cnVjdCB1c2JfZXAgKmVwLCBpbnQgdmFsdWUpDQo+ID4gIAlpZiAoIWVwKQ0KPiA+ICAJ
CXJldHVybiAtRUlOVkFMOw0KPiANCj4gU2FtZSBoZXJlLCBob3cgY2FuIHRoYXQgZXZlciBoYXBw
ZW4/DQpNYXliZSB3aGVuIHRoZSBjbGFzcyBkcml2ZXIgaGFzIHNvbWV0aGluZyB3cm9uZzopDQoN
CllvdSBtZWFuIGl0J3MgYmV0dGVyIHRvIHJlbW92ZSB0aGVzZSB1bm5lY2Vzc2FyeSBjaGVja3M/
DQoNClRoYW5rcw0KDQo+IA0KPiA+ICANCj4gPiArCW1lcCA9IHRvX210dTNfZXAoZXApOw0KPiA+
ICsJbXR1ID0gbWVwLT5tdHU7DQo+ID4gKw0KPiA+ICAJZGV2X2RiZyhtdHUtPmRldiwgIiVzIDog
JXMuLi4iLCBfX2Z1bmNfXywgZXAtPm5hbWUpOw0KPiA+ICANCj4gPiAgCXNwaW5fbG9ja19pcnFz
YXZlKCZtdHUtPmxvY2ssIGZsYWdzKTsNCj4gPiBAQCAtNDIyLDExICs0MzIsMTIgQEAgc3RhdGlj
IGludCBtdHUzX2dhZGdldF9lcF9zZXRfaGFsdChzdHJ1Y3QgdXNiX2VwICplcCwgaW50IHZhbHVl
KQ0KPiA+ICAvKiBTZXRzIHRoZSBoYWx0IGZlYXR1cmUgd2l0aCB0aGUgY2xlYXIgcmVxdWVzdHMg
aWdub3JlZCAqLw0KPiA+ICBzdGF0aWMgaW50IG10dTNfZ2FkZ2V0X2VwX3NldF93ZWRnZShzdHJ1
Y3QgdXNiX2VwICplcCkNCj4gPiAgew0KPiA+IC0Jc3RydWN0IG10dTNfZXAgKm1lcCA9IHRvX210
dTNfZXAoZXApOw0KPiA+ICsJc3RydWN0IG10dTNfZXAgKm1lcDsNCj4gPiAgDQo+ID4gIAlpZiAo
IWVwKQ0KPiA+ICAJCXJldHVybiAtRUlOVkFMOw0KPiANCj4gQWdhaW4sIHNhbWUgaGVyZS4NCj4g
DQo+IHRoYW5rcywNCj4gDQo+IGdyZWcgay1oDQoNCg==

