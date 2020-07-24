Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35864C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10EA0206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dmdOp0ka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgGXI3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:29:01 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:36589 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726573AbgGXI3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:29:01 -0400
X-UUID: 4aeda6988bee4ac591f3373a67961c61-20200724
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=8rc7FhONmXVK/ge9nGlAXM2K6HUrmjfmOch2/2WH7Ko=;
        b=dmdOp0kaOsFzerm6v7CamkrZdmCLcKL8X6FjsA+ryC1k0qxhUvc2shTtM8eM/8F5eK0es6appmIxaY8x8YHe5JPA2N3Ylc54LmB+JSYxJgJs7Xk8ONqfM+/QSeDVvHTURoCphxSnpSJhaHT4HfrM3MynFXFT5ZuipFhSHL1eYWE=;
X-UUID: 4aeda6988bee4ac591f3373a67961c61-20200724
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 906667876; Fri, 24 Jul 2020 16:28:54 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 24 Jul
 2020 16:28:51 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 24 Jul 2020 16:28:52 +0800
Message-ID: <1595579262.23885.65.camel@mhfsdcap03>
Subject: Re: [RFC PATCH] usb: dwc3: fix maximum_speed check for usb2.0-only
 core
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 24 Jul 2020 16:27:42 +0800
In-Reply-To: <e94e9d0c-b0d5-b2e1-e3de-0a4e85bc95b4@synopsys.com>
References: <1594282250-25544-1-git-send-email-chunfeng.yun@mediatek.com>
         <6dff8574-e649-7a5c-4d80-c3fe6ddd6645@synopsys.com>
         <e94e9d0c-b0d5-b2e1-e3de-0a4e85bc95b4@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 2ACD6F938436F48A8374B2A2EA2AC37AF59CB494D4CCBAA901C1432351B171682000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTA3LTI0IGF0IDAzOjMyICswMDAwLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+
IEhpLA0KPiANCj4gVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+IEhpLA0KPiA+DQo+ID4gQ2h1bmZl
bmcgWXVuIHdyb3RlOg0KPiA+PiBUaGUgbWF4aW11bV9zcGVlZCB3aWxsIGJlIFVTQl9TUEVFRF9T
VVBFUl9QTFVTLCBidXQgdGhlDQo+ID4+IG1heGltdW1fc3BlZWQgY2hlY2sgZm9yIHVzYjIuMC1v
bmx5IGNvcmUgZG9lc24ndCBjb25zaWRlciBpdCwNCj4gPj4gc28gZml4IGl0LCBhbmQgbW92ZSB0
aGUgY2tlY2sgaW50byBkd2MzX2NoZWNrX3BhcmFtcygpLg0KPiA+Pg0KPiA+PiBTaWduZWQtb2Zm
LWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+ID4+IC0tLQ0K
PiA+PiBOb3RlOg0KPiA+Pg0KPiA+PiBXaGVuIEkgbG9vayBhdCB0aGUgY29kZSwgZmluZCB0aGF0
IHRoaXMgbWF5IGJlIGEgcHJvYmxlbSwgYnV0IG5vDQo+ID4+IHBsYXRmb3JtIHRvIHRlc3QgaXQu
DQo+ID4+IC0tLQ0KPiA+PiAgICBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyB8IDE0ICsrKysrKyst
LS0tLS0tDQo+ID4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDcgZGVsZXRp
b25zKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBi
L2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ID4+IGluZGV4IDI1YzY4NmE3Li5mZmQ1YWIzIDEw
MDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+PiArKysgYi9kcml2
ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+PiBAQCAtOTMwLDEzICs5MzAsNiBAQCBzdGF0aWMgaW50
IGR3YzNfY29yZV9pbml0KHN0cnVjdCBkd2MzICpkd2MpDQo+ID4+ICAgIAkgKi8NCj4gPj4gICAg
CWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HVUlELCBMSU5VWF9WRVJTSU9OX0NPREUpOw0K
PiA+PiAgICANCj4gPj4gLQkvKiBIYW5kbGUgVVNCMi4wLW9ubHkgY29yZSBjb25maWd1cmF0aW9u
ICovDQo+ID4+IC0JaWYgKERXQzNfR0hXUEFSQU1TM19TU1BIWV9JRkMoZHdjLT5od3BhcmFtcy5o
d3BhcmFtczMpID09DQo+ID4+IC0JCQlEV0MzX0dIV1BBUkFNUzNfU1NQSFlfSUZDX0RJUykgew0K
PiA+PiAtCQlpZiAoZHdjLT5tYXhpbXVtX3NwZWVkID09IFVTQl9TUEVFRF9TVVBFUikNCj4gPj4g
LQkJCWR3Yy0+bWF4aW11bV9zcGVlZCA9IFVTQl9TUEVFRF9ISUdIOw0KPiA+PiAtCX0NCj4gPj4g
LQ0KPiA+PiAgICAJcmV0ID0gZHdjM19waHlfc2V0dXAoZHdjKTsNCj4gPj4gICAgCWlmIChyZXQp
DQo+ID4+ICAgIAkJZ290byBlcnIwOw0KPiA+PiBAQCAtMTQyNiw2ICsxNDE5LDEzIEBAIHN0YXRp
YyB2b2lkIGR3YzNfY2hlY2tfcGFyYW1zKHN0cnVjdCBkd2MzICpkd2MpDQo+ID4+ICAgIA0KPiA+
PiAgICAJCWJyZWFrOw0KPiA+PiAgICAJfQ0KPiA+PiArDQo+ID4+ICsJLyogSGFuZGxlIFVTQjIu
MC1vbmx5IGNvcmUgY29uZmlndXJhdGlvbiAqLw0KPiA+PiArCWlmIChEV0MzX0dIV1BBUkFNUzNf
U1NQSFlfSUZDKGR3Yy0+aHdwYXJhbXMuaHdwYXJhbXMzKSA9PQ0KPiA+PiArCQkJRFdDM19HSFdQ
QVJBTVMzX1NTUEhZX0lGQ19ESVMpIHsNCj4gPj4gKwkJaWYgKGR3Yy0+bWF4aW11bV9zcGVlZCA+
IFVTQl9TUEVFRF9ISUdIKQ0KPiA+PiArCQkJZHdjLT5tYXhpbXVtX3NwZWVkID0gVVNCX1NQRUVE
X0hJR0g7DQo+ID4+ICsJfQ0KPiA+PiAgICB9DQo+ID4+ICAgIA0KPiA+PiAgICBzdGF0aWMgaW50
IGR3YzNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiBBY3R1YWxseSwg
dGhlIGR3Yy0+bWF4aW11bV9zcGVlZCBjYXB0dXJlcyB0aGUgbWF4aW11bSBzcGVlZCBkZXZpY2UN
Cj4gPiBwcm9wZXJ0eSB2YWx1ZS4gSXQgbWF5YmUgYmUgc2V0IGJhc2VkIG9uIHRoZSBwaHkncyBj
YXBhYmlsaXR5IGlmIHRoZXJlJ3MNCj4gPiBubyBwcm9wZXJ0eSBzcGVjaWZ5aW5nIGl0IChpLmUu
IG1heGltdW1fc3BlZWQgaXMgVVNCX1NQRUVEX1VOS05PV04pLg0KPiA+DQo+ID4gU28sIHRoaXMg
Y29kZSBzaG91bGQgYmUgcmVtb3ZlZC4gVGhlIGZpeCBzaG91bGQgYmUgaW4gdGhlIGNoZWNrIG9m
DQo+ID4gZHdjM19jaGVja19wYXJhbXMoKS4gSWYgbWF4aW11bV9zcGVlZCA9IFVTQl9TUEVFRF9V
TktOT1dOIGFuZCB0aGUgcGh5J3MNCj4gPiBjYXBhYmlsaXR5IGlzIG9ubHkgdXAgdG8gaGlnaHNw
ZWVkLCB0aGVuIHNldCB0aGUgbWF4aW11bV9zcGVlZCB0bw0KPiA+IGhpZ2hzcGVlZCBvbmx5Lg0K
U29ycnkgZm9yIHRoZSBsYXRlIHJlcGx5LCBteSBvdXRsb29rIGxvc2UgeW91ciBlbWFpbC4NCj4g
Pg0KPiANCj4gQXJlIHlvdSBnb2luZyBpbnRvIHVwZGF0ZSBhbmQgcmVzZW5kIHRoaXMgcGF0Y2g/
DQpJIGRvbid0IGtub3cgaG93IHRvIGNoZWNrICJ0aGUgcGh5J3MgY2FwYWJpbGl0eSBpcyBvbmx5
IHVwIHRvIGhpZ2hzcGVlZCINCg0KPiAgSWYgbm90IEkgY2FuIGNyZWF0ZSBvbmUgDQo+IGFuZCBh
ZGQgeW91ciAiUmVwb3J0ZWQtYnkiDQpPaywgdGhhbmtzDQoNCj4gDQo+IEJSLA0KPiBUaGluaA0K
DQo=

