Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162BEC35242
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 02:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37B4206DB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 02:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ijjN9Etd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgBLC4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 21:56:07 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:44506 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727565AbgBLC4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 21:56:06 -0500
X-UUID: f15504b7c94b4922a93d396c68286bf8-20200212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=QdBTe7gC7JKil+2UQTfobpCtMYtklWuvZOCuYuWCF58=;
        b=ijjN9EtdiE3PCggNx3sotA+exutjRy8H6hFdUmOsLIUuRM7nh2HVMp3r0dbOTUp2c7J8QiX/p2aB3v2uSg2vZhEjOGmGdlvJiPeT3CQCFA4edw6AZTtpvZ3saikPg6UwpDhR0Uvp51b/stl8VhCWpgsZbecaE7uYvNY8K4gn628=;
X-UUID: f15504b7c94b4922a93d396c68286bf8-20200212
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 721817637; Wed, 12 Feb 2020 10:56:02 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 12 Feb 2020 10:54:24 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 12 Feb 2020 10:55:02 +0800
Message-ID: <1581476161.22901.36.camel@mtksdaap41>
Subject: Re: [PATCH v11 07/10] soc: mediatek: Add extra sram control
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        James Liao <jamesjj.liao@mediatek.com>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 12 Feb 2020 10:56:01 +0800
In-Reply-To: <28fcf690-74cb-b7cd-a53b-e54be71457b9@gmail.com>
References: <1576813564-23927-1-git-send-email-weiyi.lu@mediatek.com>
         <1576813564-23927-8-git-send-email-weiyi.lu@mediatek.com>
         <28fcf690-74cb-b7cd-a53b-e54be71457b9@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTAyLTExIGF0IDE4OjA0ICswMTAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMjAvMTIvMjAxOSAwNDo0NiwgV2VpeWkgTHUgd3JvdGU6DQo+ID4gRm9yIHNv
bWUgcG93ZXIgZG9tYWlucyBsaWtlIHZwdV9jb3JlIG9uIE1UODE4MyB3aG9zZSBzcmFtIG5lZWQg
dG8NCj4gPiBkbyBjbG9jayBhbmQgaW50ZXJuYWwgaXNvbGF0aW9uIHdoaWxlIHBvd2VyIG9uL29m
ZiBzcmFtLg0KPiA+IFdlIGFkZCBhIGZsYWcgInNyYW1faXNvX2N0cmwiIGluIHNjcF9kb21haW5f
ZGF0YSB0byBqdWRnZSBpZiB3ZQ0KPiA+IG5lZWQgdG8gZG8gdGhlIGV4dHJhIHNyYW0gaXNvbGF0
aW9uIGNvbnRyb2wgb3Igbm90Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFdlaXlpIEx1IDx3
ZWl5aS5sdUBtZWRpYXRlay5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IE5pY29sYXMgQm9pY2hhdCA8
ZHJpbmtjYXRAY2hyb21pdW0ub3JnPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3NvYy9tZWRpYXRl
ay9tdGstc2Nwc3lzLmMgfCAyNCArKysrKysrKysrKysrKysrKysrKysrLS0NCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1zY3BzeXMuYyBiL2RyaXZlcnMvc29j
L21lZGlhdGVrL210ay1zY3BzeXMuYw0KPiA+IGluZGV4IDMyYmU0YjMuLjE5NzI3MjYgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXNjcHN5cy5jDQo+ID4gKysrIGIv
ZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXNjcHN5cy5jDQo+ID4gQEAgLTU2LDYgKzU2LDggQEAN
Cj4gPiAgI2RlZmluZSBQV1JfT05fQklUCQkJQklUKDIpDQo+ID4gICNkZWZpbmUgUFdSX09OXzJO
RF9CSVQJCQlCSVQoMykNCj4gPiAgI2RlZmluZSBQV1JfQ0xLX0RJU19CSVQJCQlCSVQoNCkNCj4g
PiArI2RlZmluZSBQV1JfU1JBTV9DTEtJU09fQklUCQlCSVQoNSkNCj4gPiArI2RlZmluZSBQV1Jf
U1JBTV9JU09JTlRfQl9CSVQJCUJJVCg2KQ0KPiA+ICANCj4gPiAgI2RlZmluZSBQV1JfU1RBVFVT
X0NPTk4JCQlCSVQoMSkNCj4gPiAgI2RlZmluZSBQV1JfU1RBVFVTX0RJU1AJCQlCSVQoMykNCj4g
PiBAQCAtODYsNiArODgsOCBAQA0KPiA+ICAgKiBAbmFtZTogVGhlIGRvbWFpbiBuYW1lLg0KPiA+
ICAgKiBAc3RhX21hc2s6IFRoZSBtYXNrIGZvciBwb3dlciBvbi9vZmYgc3RhdHVzIGJpdC4NCj4g
PiAgICogQGN0bF9vZmZzOiBUaGUgb2Zmc2V0IGZvciBtYWluIHBvd2VyIGNvbnRyb2wgcmVnaXN0
ZXIuDQo+ID4gKyAqIEBzcmFtX2lzb19jdHJsOiBUaGUgZmxhZyB0byBqdWRnZSBpZiB0aGUgcG93
ZXIgZG9tYWluIG5lZWQgdG8gZG8NCj4gPiArICogICAgICAgICAgICAgICAgIHRoZSBleHRyYSBz
cmFtIGlzb2xhdGlvbiBjb250cm9sLg0KPiA+ICAgKiBAc3JhbV9wZG5fYml0czogVGhlIG1hc2sg
Zm9yIHNyYW0gcG93ZXIgY29udHJvbCBiaXRzLg0KPiA+ICAgKiBAc3JhbV9wZG5fYWNrX2JpdHM6
IFRoZSBtYXNrIGZvciBzcmFtIHBvd2VyIGNvbnRyb2wgYWNrZWQgYml0cy4NCj4gPiAgICogQGJh
c2ljX2Nsa19uYW1lOiBUaGUgYmFzaWMgY2xvY2tzIHJlcXVpcmVkIGJ5IHRoaXMgcG93ZXIgZG9t
YWluLg0KPiA+IEBAIC05OCw2ICsxMDIsNyBAQCBzdHJ1Y3Qgc2NwX2RvbWFpbl9kYXRhIHsNCj4g
PiAgCWNvbnN0IGNoYXIgKm5hbWU7DQo+ID4gIAl1MzIgc3RhX21hc2s7DQo+ID4gIAlpbnQgY3Rs
X29mZnM7DQo+ID4gKwlib29sIHNyYW1faXNvX2N0cmw7DQo+IA0KPiBXaHkgZG9uJ3Qgd2UgcHV0
IHRoYXQgaW50byB0aGUgY2FwcyB2YXJpYWJsZT8gV2UgaGF2ZSBwbGVudHkgb2Ygc3BhY2UgbGVm
dCB0aGVyZQ0KPiBhbmQgaWYgbmVlZGVkIHdlIGNhbiBidW1wIHVwIGl0cyB2YWx1ZSBmcm9tIHU4
IHRvIHUzMi4NCj4gDQoNClRoYW5rcyBmb3IgcmVtaW5kaW5nLCBJJ2xsIHB1dCBpbnRvIGNhcHMg
aW4gbmV4dCB2ZXJzaW9uLg0KDQo+ID4gIAl1MzIgc3JhbV9wZG5fYml0czsNCj4gPiAgCXUzMiBz
cmFtX3Bkbl9hY2tfYml0czsNCj4gPiAgCWNvbnN0IGNoYXIgKmJhc2ljX2Nsa19uYW1lW01BWF9D
TEtTXTsNCj4gPiBAQCAtMjMzLDYgKzIzOCwxNCBAQCBzdGF0aWMgaW50IHNjcHN5c19zcmFtX2Vu
YWJsZShzdHJ1Y3Qgc2NwX2RvbWFpbiAqc2NwZCwgdm9pZCBfX2lvbWVtICpjdGxfYWRkcikNCj4g
PiAgCQkJcmV0dXJuIHJldDsNCj4gPiAgCX0NCj4gPiAgDQo+ID4gKwlpZiAoc2NwZC0+ZGF0YS0+
c3JhbV9pc29fY3RybCkJew0KPiA+ICsJCXZhbCA9IHJlYWRsKGN0bF9hZGRyKSB8IFBXUl9TUkFN
X0lTT0lOVF9CX0JJVDsNCj4gPiArCQl3cml0ZWwodmFsLCBjdGxfYWRkcik7DQo+ID4gKwkJdWRl
bGF5KDEpOw0KPiA+ICsJCXZhbCAmPSB+UFdSX1NSQU1fQ0xLSVNPX0JJVDsNCj4gPiArCQl3cml0
ZWwodmFsLCBjdGxfYWRkcik7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICAJcmV0dXJuIDA7DQo+ID4g
IH0NCj4gPiAgDQo+ID4gQEAgLTI0Miw4ICsyNTUsMTUgQEAgc3RhdGljIGludCBzY3BzeXNfc3Jh
bV9kaXNhYmxlKHN0cnVjdCBzY3BfZG9tYWluICpzY3BkLCB2b2lkIF9faW9tZW0gKmN0bF9hZGRy
KQ0KPiA+ICAJdTMyIHBkbl9hY2sgPSBzY3BkLT5kYXRhLT5zcmFtX3Bkbl9hY2tfYml0czsNCj4g
PiAgCWludCB0bXA7DQo+ID4gIA0KPiA+IC0JdmFsID0gcmVhZGwoY3RsX2FkZHIpOw0KPiA+IC0J
dmFsIHw9IHNjcGQtPmRhdGEtPnNyYW1fcGRuX2JpdHM7DQo+ID4gKwlpZiAoc2NwZC0+ZGF0YS0+
c3JhbV9pc29fY3RybCkJew0KPiA+ICsJCXZhbCA9IHJlYWRsKGN0bF9hZGRyKSB8IFBXUl9TUkFN
X0NMS0lTT19CSVQ7DQo+ID4gKwkJd3JpdGVsKHZhbCwgY3RsX2FkZHIpOw0KPiA+ICsJCXZhbCAm
PSB+UFdSX1NSQU1fSVNPSU5UX0JfQklUOw0KPiA+ICsJCXdyaXRlbCh2YWwsIGN0bF9hZGRyKTsN
Cj4gPiArCQl1ZGVsYXkoMSk7DQo+IA0KPiBXaHkgZG8gd2UgbmVlZCB0byB3YWl0IGhlcmU/DQo+
IA0KDQpJdCdzIHRoZSByZXN0cmljdGlvbiBvZiBzcmFtIGlzb2xhdGlvbiBmb3IgYm90aCBlbmFi
bGUgYW5kIGRpc2FibGUgc3RhZ2UNCmFuZCB3ZSd2ZSBjb25maXJtZWQgMXVzIGlzIHNhZmUuDQoN
Cj4gPiArCX0NCj4gPiArDQo+ID4gKwl2YWwgPSByZWFkbChjdGxfYWRkcikgfCBzY3BkLT5kYXRh
LT5zcmFtX3Bkbl9iaXRzOw0KPiA+ICAJd3JpdGVsKHZhbCwgY3RsX2FkZHIpOw0KPiA+ICANCj4g
PiAgCS8qIEVpdGhlciB3YWl0IHVudGlsIFNSQU1fUEROX0FDSyBhbGwgMSBvciAwICovDQo+ID4g
DQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K
PiBMaW51eC1tZWRpYXRlayBtYWlsaW5nIGxpc3QNCj4gTGludXgtbWVkaWF0ZWtAbGlzdHMuaW5m
cmFkZWFkLm9yZw0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LW1lZGlhdGVrDQoNCg==

