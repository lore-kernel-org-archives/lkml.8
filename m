Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FC4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 06:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06A1A208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 06:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SEgxChRf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgFQGjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 02:39:17 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:57366 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725929AbgFQGjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 02:39:16 -0400
X-UUID: 7f818db80e15441b99f7a3d522cb58f9-20200617
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Yi8qckVCoc/BpINGsirl4HLvfSQpKF4ywGxOTUuDyXs=;
        b=SEgxChRfS3LDVMAH8o9E5uWCg9fLjKKTSOErgn2Nj2djudDtMkh4zDkU8uJX0nPmQS6NEBwXHv2ChHZbeOUu8K7LK0FFvc6fOeMThRxRH/QQIjZ4/aeuPNQz/jC/uFUPYP2YcpGAaQnH/e2DRLpCjC9Ob3Dk6t6bo9lEd/5Rvek=;
X-UUID: 7f818db80e15441b99f7a3d522cb58f9-20200617
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1088638800; Wed, 17 Jun 2020 14:39:12 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 17 Jun 2020 14:39:10 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 17 Jun 2020 14:39:09 +0800
Message-ID: <1592375950.27894.0.camel@mtksdaap41>
Subject: Re: [PATCH v15 06/11] soc: mediatek: Add subsys clock control for
 bus protection
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Date:   Wed, 17 Jun 2020 14:39:10 +0800
In-Reply-To: <CANMq1KBRe81Sa4A6sCM2egOVRWCJbUNPsXHpfzkT33XGVZXBhg@mail.gmail.com>
References: <1590051985-29149-1-git-send-email-weiyi.lu@mediatek.com>
         <1590051985-29149-7-git-send-email-weiyi.lu@mediatek.com>
         <CANMq1KBRe81Sa4A6sCM2egOVRWCJbUNPsXHpfzkT33XGVZXBhg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: FDDAF576199A3C79306B7E064DC94874A65BB2656A13F2F45D65F88AF7F8449F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA2LTA0IGF0IDEwOjI5ICswODAwLCBOaWNvbGFzIEJvaWNoYXQgd3JvdGU6
DQo+IE9uIFRodSwgTWF5IDIxLCAyMDIwIGF0IDU6MDYgUE0gV2VpeWkgTHUgPHdlaXlpLmx1QG1l
ZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGb3IgdGhlIGJ1cyBwcm90ZWN0aW9uIG9wZXJh
dGlvbnMsIHNvbWUgc3Vic3lzIGNsb2NrcyBuZWVkIHRvIGJlIGVuYWJsZWQNCj4gPiBiZWZvcmUg
cmVsZWFzaW5nIHRoZSBwcm90ZWN0aW9uLCBhbmQgdmljZSB2ZXJzYS4NCj4gPiBCdXQgdGhvc2Ug
c3Vic3lzIGNsb2NrcyBjb3VsZCBvbmx5IGJlIGNvbnRyb2xsZWQgb25jZSBpdHMgY29ycmVzcG9u
ZGluZw0KPiA+IHBvd2VyIGRvbWFpbiBpcyB0dXJuZWQgb24gZmlyc3QuDQo+ID4gSW4gdGhpcyBw
YXRjaCwgd2UgYWRkIHRoZSBzdWJzeXMgY2xvY2sgY29udHJvbCBpbnRvIGl0cyByZWxldmFudCBz
dGVwcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFdlaXlpIEx1IDx3ZWl5aS5sdUBtZWRpYXRl
ay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1zY3BzeXMuYyB8
IDYyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgNjAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMgYi9kcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstc2Nwc3lzLmMNCj4gPiBpbmRleCA1OWE1MjVhLi5lZjJjNjY4IDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1zY3BzeXMuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvc29jL21lZGlhdGVrL210ay1zY3BzeXMuYw0KPiA+IFtzbmlwXQ0KPiA+ICAgICAgICAg
dmFsIHw9IFBXUl9JU09fQklUOw0KPiA+IEBAIC00OTgsNiArNTExLDM5IEBAIHN0YXRpYyBpbnQg
c2Nwc3lzX3Bvd2VyX29mZihzdHJ1Y3QgZ2VuZXJpY19wbV9kb21haW4gKmdlbnBkKQ0KPiA+ICAg
ICAgICAgcmV0dXJuIHJldDsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbnQgaW5pdF9zdWJz
eXNfY2xrcyhzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KPiA+ICsgICAgICAgICAgICAg
ICBjb25zdCBjaGFyICpwcmVmaXgsIHN0cnVjdCBjbGsgKipjbGspDQo+ID4gK3sNCj4gPiArICAg
ICAgIHN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZSA9IHBkZXYtPmRldi5vZl9ub2RlOw0KPiA+ICsg
ICAgICAgdTMyIHByZWZpeF9sZW4sIHN1Yl9jbGtfY250ID0gMDsNCj4gPiArICAgICAgIHN0cnVj
dCBwcm9wZXJ0eSAqcHJvcDsNCj4gPiArICAgICAgIGNvbnN0IGNoYXIgKmNsa19uYW1lOw0KPiA+
ICsNCj4gPiArICAgICAgIHByZWZpeF9sZW4gPSBzdHJsZW4ocHJlZml4KTsNCj4gPiArDQo+ID4g
KyAgICAgICBvZl9wcm9wZXJ0eV9mb3JfZWFjaF9zdHJpbmcobm9kZSwgImNsb2NrLW5hbWVzIiwg
cHJvcCwgY2xrX25hbWUpIHsNCj4gPiArICAgICAgICAgICAgICAgaWYgKCFzdHJuY21wKGNsa19u
YW1lLCBwcmVmaXgsIHByZWZpeF9sZW4pICYmDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAoY2xrX25hbWVbcHJlZml4X2xlbl0gPT0gJy0nKSkgew0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGlmIChzdWJfY2xrX2NudCA+PSBNQVhfU1VCU1lTX0NMS1MpIHsNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoJnBkZXYtPmRldiwNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgInN1YnN5cyBjbGsgb3V0IG9m
IHJhbmdlICVkXG4iLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBzdWJfY2xrX2NudCk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1
cm4gLUVJTlZBTDsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICB9DQo+ID4gKw0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgIGNsa1tzdWJfY2xrX2NudF0gPSBkZXZtX2Nsa19nZXQoJnBk
ZXYtPmRldiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBjbGtfbmFtZSk7DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmIChJ
U19FUlIoY2xrW3N1Yl9jbGtfY250XSkpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICByZXR1cm4gUFRSX0VSUihjbGtbc3ViX2Nsa19jbnRdKTsNCj4gPiArDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgc3ViX2Nsa19jbnQrKzsNCj4gPiArICAgICAgICAgICAgICAgfQ0K
PiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiBzdWJfY2xrX2NudDsNCj4g
PiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGludCBpbml0X2Jhc2ljX2Nsa3Moc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldiwgc3RydWN0IGNsayAqKmNsaywNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICBjb25zdCBjaGFyICogY29uc3QgKm5hbWUpDQo+ID4gIHsNCj4gPiBAQCAtNTk2LDYg
KzY0MiwxOCBAQCBzdGF0aWMgc3RydWN0IHNjcCAqaW5pdF9zY3Aoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldiwNCj4gPiAgICAgICAgICAgICAgICAgaWYgKHJldCkNCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUihyZXQpOw0KPiA+DQo+ID4gKyAgICAgICAgICAg
ICAgIGlmIChkYXRhLT5zdWJzeXNfY2xrX3ByZWZpeCkgew0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIHJldCA9IGluaXRfc3Vic3lzX2Nsa3MocGRldiwNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZGF0YS0+c3Vic3lzX2Nsa19wcmVmaXgsDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNjcGQtPnN1YnN5c19jbGspOw0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmIChyZXQgPCAwKSB7DQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJyKCZwZGV2LT5kZXYsDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICIlczogc3Vic3lzIGNsayB1bmF2YWlsYWJs
ZVxuIiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGF0YS0+
bmFtZSk7DQo+IA0KPiBpbml0X3N1YnN5c19jbGtzIHNob3VsZCBhbHJlYWR5IGhhdmUgcHJpbnRl
ZCBhbiBlcnJvciAoZGlyZWN0bHkgb3INCj4gaW5kaXJlY3RseSksIHNvIHRoaXMgaXMgbm90IG5l
ZWRlZC4NCj4gDQoNCllvdSdyZSByaWdodC4gSSdsbCByZW1vdmUgaXQgaW4gbmV4dCB2ZXJzaW9u
IHYxNi4NCg0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIEVSUl9Q
VFIocmV0KTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICB9DQo+ID4gKyAgICAgICAgICAg
ICAgIH0NCj4gPiArDQo+ID4gICAgICAgICAgICAgICAgIGdlbnBkLT5uYW1lID0gZGF0YS0+bmFt
ZTsNCj4gPiAgICAgICAgICAgICAgICAgZ2VucGQtPnBvd2VyX29mZiA9IHNjcHN5c19wb3dlcl9v
ZmY7DQo+ID4gICAgICAgICAgICAgICAgIGdlbnBkLT5wb3dlcl9vbiA9IHNjcHN5c19wb3dlcl9v
bjsNCj4gPiAtLQ0KPiA+IDEuOC4xLjEuZGlydHkNCg0K

