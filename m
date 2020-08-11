Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB1EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4FBA20774
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hkhy2iK7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgHKGe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 02:34:59 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:1280 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726520AbgHKGe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 02:34:59 -0400
X-UUID: 4e83e217174340f4adcb4ff16e082455-20200811
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=HjTrZJUnmsbyXMddz+pAd0d3gGDoO/AnUi9tsFN7vvI=;
        b=hkhy2iK7bxzjN/8wI2tM41ng+0J7E90mEj3QvoZJ8bOy3RTHYqZ8BJODlt9MZP0sBg95hd3FbyNHmMVCXYRTapbv4jcDRo4iMZ3ymn3bgwQbp0EG2FS4d2SDCYP2TIhWjgMigKHt+7M3KNMZL6Qnvc16hNWa035iLOlHzuyfHjk=;
X-UUID: 4e83e217174340f4adcb4ff16e082455-20200811
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2044285616; Tue, 11 Aug 2020 14:34:54 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 11 Aug 2020 14:34:51 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 11 Aug 2020 14:34:45 +0800
Message-ID: <1597127686.20627.8.camel@mtksdaap41>
Subject: Re: [PATCH v2 3/5] clk: mediatek: Fix asymmetrical PLL enable and
 disable control
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Wendell Lin <wendell.lin@mediatek.com>
Date:   Tue, 11 Aug 2020 14:34:46 +0800
In-Reply-To: <CANMq1KAYg2+RQiF0w7-2FKZj1QwoPDsXtmak-DHfserRjX-TWA@mail.gmail.com>
References: <1596012277-8448-1-git-send-email-weiyi.lu@mediatek.com>
         <1596012277-8448-4-git-send-email-weiyi.lu@mediatek.com>
         <CANMq1KBJ3QgpZ4EuSOWYTpOatsOte5sGkqtSZQs337x3fMFFYw@mail.gmail.com>
         <CANMq1KAYg2+RQiF0w7-2FKZj1QwoPDsXtmak-DHfserRjX-TWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 2B190417C65371784B5F8095A8677560A8027995044ABD80DB753E33129969022000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA3LTI5IGF0IDE5OjAyICswODAwLCBOaWNvbGFzIEJvaWNoYXQgd3JvdGU6
DQo+IE9uIFdlZCwgSnVsIDI5LCAyMDIwIGF0IDY6NTEgUE0gTmljb2xhcyBCb2ljaGF0IDxkcmlu
a2NhdEBjaHJvbWl1bS5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gT24gV2VkLCBKdWwgMjksIDIwMjAg
YXQgNDo0NCBQTSBXZWl5aSBMdSA8d2VpeWkubHVAbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPiA+
DQo+ID4gPiBUaGUgZW5fbWFzayBhY3R1YWxseSBpcyBhIGNvbWJpbmF0aW9uIG9mIGRpdmlkZXIg
ZW5hYmxlIG1hc2sNCj4gPiA+IGFuZCBwbGwgZW5hYmxlIGJpdChiaXQwKS4NCj4gPiA+IEJlZm9y
ZSB0aGlzIHBhdGNoLCB3ZSBlbmFibGVkIGJvdGggZGl2aWRlciBtYXNrIGFuZCBiaXQwIGluIHBy
ZXBhcmUoKSwNCj4gPiA+IGJ1dCBvbmx5IGNsZWFyZWQgdGhlIGJpdDAgaW4gdW5wcmVwYXJlKCku
DQo+ID4gPiBOb3csIHNldHRpbmcgdGhlIGVuYWJsZSByZWdpc3RlcihDT04wKSBpbiAyIHN0ZXBz
OiBmaXJzdCBkaXZpZGVyIG1hc2ssDQo+ID4gPiB0aGVuIGJpdDAgZHVyaW5nIHByZXBhcmUoKSwg
dmljZSB2ZXJzYS4NCj4gPiA+IEhlbmNlLCBlbl9tYXNrIHdpbGwgb25seSBiZSB1c2VkIGFzIGRp
dmlkZXIgZW5hYmxlIG1hc2suDQo+ID4gPiBNZWFud2hpbGUsIGFsbCB0aGUgU29DIFBMTCBkYXRh
IGFyZSB1cGRhdGVkLg0KPiA+DQo+ID4gSSBsaWtlIHRoaXMgYSBsb3QgYmV0dGVyLCBtb3N0IGNo
YW5nZXMgbG9vayBmaW5lLCBqdXN0IGEgZmV3IG5pdHMuDQo+ID4NCj4gPiA+DQo+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBXZWl5aSBMdSA8d2VpeWkubHVAbWVkaWF0ZWsuY29tPg0KPiA+ID4gLS0tDQo+
ID4gPiAgZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10MjcwMS5jIHwgMjYgKysrKysrKysrKysr
LS0tLS0tLS0tLS0tDQo+ID4gPiAgZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10MjcxMi5jIHwg
MzAgKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KPiA+ID4gIGRyaXZlcnMvY2xrL21lZGlh
dGVrL2Nsay1tdDY3NjUuYyB8IDIwICsrKysrKysrKy0tLS0tLS0tLS0NCj4gPiA+ICBkcml2ZXJz
L2Nsay9tZWRpYXRlay9jbGstbXQ2Nzc5LmMgfCAyNCArKysrKysrKysrKy0tLS0tLS0tLS0tDQo+
ID4gPiAgZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10Njc5Ny5jIHwgMjAgKysrKysrKysrLS0t
LS0tLS0tLQ0KPiA+ID4gIGRyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDc2MjIuYyB8IDE4ICsr
KysrKysrLS0tLS0tLS0tDQo+ID4gPiAgZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10NzYyOS5j
IHwgMTIgKysrKystLS0tLS0NCj4gPiA+ICBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTcz
LmMgfCA0MiArKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCj4gPiA+ICBk
cml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTgzLmMgfCAyMiArKysrKysrKysrLS0tLS0tLS0t
LQ0KPiA+ID4gIGRyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1wbGwuYyAgICB8IDEwICsrKysrKysr
LS0NCj4gPiA+ICAxMCBmaWxlcyBjaGFuZ2VkLCAxMjIgaW5zZXJ0aW9ucygrKSwgMTAyIGRlbGV0
aW9ucygtKQ0KPiA+ID4NCj4gW3NuaXBdDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsv
bWVkaWF0ZWsvY2xrLXBsbC5jIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLXBsbC5jDQo+ID4g
PiBpbmRleCBmNDQwZjJjZC4uM2M3OWUxYSAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvY2xr
L21lZGlhdGVrL2Nsay1wbGwuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xr
LXBsbC5jDQo+ID4gPiBAQCAtMjQ3LDggKzI0NywxMCBAQCBzdGF0aWMgaW50IG10a19wbGxfcHJl
cGFyZShzdHJ1Y3QgY2xrX2h3ICpodykNCj4gPiA+ICAgICAgICAgd3JpdGVsKHIsIHBsbC0+cHdy
X2FkZHIpOw0KPiA+ID4gICAgICAgICB1ZGVsYXkoMSk7DQo+ID4gPg0KPiA+ID4gLSAgICAgICBy
ID0gcmVhZGwocGxsLT5iYXNlX2FkZHIgKyBSRUdfQ09OMCk7DQo+ID4gPiAtICAgICAgIHIgfD0g
cGxsLT5kYXRhLT5lbl9tYXNrOw0KPiA+ID4gKyAgICAgICByID0gcmVhZGwocGxsLT5iYXNlX2Fk
ZHIgKyBSRUdfQ09OMCkgfCBDT04wX0JBU0VfRU47DQo+ID4gPiArICAgICAgIHdyaXRlbChyLCBw
bGwtPmJhc2VfYWRkciArIFJFR19DT04wKTsNCj4gPiA+ICsNCj4gPiA+ICsgICAgICAgciA9IHJl
YWRsKHBsbC0+YmFzZV9hZGRyICsgUkVHX0NPTjApIHwgcGxsLT5kYXRhLT5lbl9tYXNrOw0KPiAN
Cj4gT25lIG1vcmUgcXVlc3Rpb24uIEkgaGF2ZSB0aGUgZmVlbGluZyB0aGF0IENPTjBfQkFTRV9F
TiBpcyB3aGF0DQo+IGVuYWJsZXMgdGhlIGNsb2NrIGZvciBnb29kIChhbmQgcGxsLT5kYXRhLT5l
bl9tYXNrIGlzIGp1c3QgYW4NCj4gYWRkaXRpb25hbCBzZXR0aW5nL21hc2ssIHNpbmNlIHlvdSBj
b3VsZCBkaXNhYmxlIHRoZSBjbG9jayBieSBzaW1wbHkNCj4gY2xlYXJpbmcgQ09OMF9CQVNFX0VO
KS4gU2hvdWxkbid0IHlvdSBzZXQgcGxsLT5kYXRhLT5lbl9tYXNrIF9maXJzdF8sDQo+IHRoZW4g
Q09OMF9CQVNFX0VOPw0KPiANCg0KSGkgTmljb2xhcywNCg0KQWN0dWFsbHkgSSBoYWQgdGhlIHNh
bWUgcXVlc3Rpb24gd2hlbiBJIGZpcnN0IHNhdyBpdC4NCkJ1dCB0aGlzIGlzIHRoZSByZWNvbW1l
bmRlZCBzZXF1ZW5jZSBpbiB0aGUgUExMIGFwcGxpY2F0aW9uIG5vdGVzLg0KDQpwcmVhcHJlDQp7
DQogICAgfCBDT04wX0JBU0VfRU47DQogICAgfCBwbGwtPmRhdGEtPmVuX21hc2s7DQp9DQoNCnVu
cHJlcGFyZQ0Kew0KICAgIH5wbGwtPmRhdGEtPmVuX21hc2s7DQogICAgfkNPTjBfQkFTRV9FTjsN
Cn0NCg0KPiA+ID4gICAgICAgICB3cml0ZWwociwgcGxsLT5iYXNlX2FkZHIgKyBSRUdfQ09OMCk7
DQo+ID4NCj4gPiBBcyBhIHNtYWxsIG9wdGltaXphdGlvbiwgeW91IGNhbiBkbzoNCj4gPg0KPiA+
IGlmIChwbGwtPmRhdGEtPmVuX21hc2spIHsNCj4gPiAgICByID0gcmVhZGwocGxsLT5iYXNlX2Fk
ZHIgKyBSRUdfQ09OMCkgfCBwbGwtPmRhdGEtPmVuX21hc2s7DQo+ID4gICAgd3JpdGVsKHIsIHBs
bC0+YmFzZV9hZGRyICsgUkVHX0NPTjApOw0KPiA+IH0NCj4gPg0KPiA+ID4NCj4gPiA+ICAgICAg
ICAgX19tdGtfcGxsX3R1bmVyX2VuYWJsZShwbGwpOw0KPiA+ID4gQEAgLTI3OCw2ICsyODAsMTAg
QEAgc3RhdGljIHZvaWQgbXRrX3BsbF91bnByZXBhcmUoc3RydWN0IGNsa19odyAqaHcpDQo+ID4g
PiAgICAgICAgIF9fbXRrX3BsbF90dW5lcl9kaXNhYmxlKHBsbCk7DQo+ID4gPg0KPiA+ID4gICAg
ICAgICByID0gcmVhZGwocGxsLT5iYXNlX2FkZHIgKyBSRUdfQ09OMCk7DQo+ID4gPiArICAgICAg
IHIgJj0gfnBsbC0+ZGF0YS0+ZW5fbWFzazsNCj4gPg0KPiA+IE1vdmUgdGhpcyB0byBvbmUgbGlu
ZT8gKHNvIHRoYXQgdGhlIGNvZGUgbG9va3Mgc3ltbWV0cmljYWwsIHRvbz8pDQo+ID4NCj4gPiA+
ICsgICAgICAgd3JpdGVsKHIsIHBsbC0+YmFzZV9hZGRyICsgUkVHX0NPTjApOw0KPiA+ID4gKw0K
PiA+ID4gKyAgICAgICByID0gcmVhZGwocGxsLT5iYXNlX2FkZHIgKyBSRUdfQ09OMCk7DQo+ID4g
PiAgICAgICAgIHIgJj0gfkNPTjBfQkFTRV9FTjsNCj4gDQo+IEFuZCBkaXR0bywgfkNPTjBfQkFT
RV9FTiB0aGVuIH5wbGwtPmRhdGEtPmVuX21hc2s/DQo+IA0KPiA+DQo+ID4gZGl0dG8/DQo+ID4N
Cj4gPiA+ICAgICAgICAgd3JpdGVsKHIsIHBsbC0+YmFzZV9hZGRyICsgUkVHX0NPTjApOw0KPiA+
ID4NCj4gPiA+IC0tDQo+ID4gPiAxLjguMS4xLmRpcnR5DQoNCg==

