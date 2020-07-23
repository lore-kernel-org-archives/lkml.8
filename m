Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89978C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 23:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A02020792
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 23:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="dLtzfZnP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgGWXqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 19:46:36 -0400
Received: from mail-dm6nam10on2043.outbound.protection.outlook.com ([40.107.93.43]:46561
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727778AbgGWXqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 19:46:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OonqxU92mAX4HBHIPcYn6Y97oHVHo/ifgx1AhNL4Vc4cFRasFnVSjWKeQzMJObwJSuQWfK9SeQtE9pfv+sxOiPPR+/AiY1SlDx/CV85ENaINcxqtHFO9ZeA2BUwI3atzU9F/28AOhKmIw3sOY7Gv/IyKs2kQa1QKaPy3r5i3F5GTWQdznypGPcqEqHvzYDt5Ls1vhiv+Q+lnl7CFWGBmmQIzSh5yfIOqqbAsSNeV0wm5HtG4Y26EOosPNAXJ95cyj98y3So/QoNfhabqdBpiy/7kIUpdCZZGkIrvCn+3IQuGS+Hldym8Fzs0xagUOYWJvD1wt+kL2eAKltM/eX1g8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uT6O2q2u53t4awbbhx99an3EAe/5r3WhYBV4yD4E7BI=;
 b=BCMkjlqtWVp0R08mJSSPt9szDIIB6O7oFOlPU1TubwCxy3Mj+8QQPwHLVBuBtSlqMGrpBE+o+a4HT6mvJbTZZ4QxdgvfKkJ7HVajU+hw4I5qfuSSZBEEuQTyXMxc2QxPOGp+r5tR+qT5gaxksfUW3bjnd4uRS/caQZm4bbWVDXq7vIun+BRi/8RJer+uxs9KGLUvs9FvN2SjUbPC/njNu3prTA5k7P9FJ0L/s1nB4lunO91/tQlNlF07VeIMVBwWB+yktOWXifLiT/jOWC05A9JB7Q5/YBorOb0mrPeVGwf1d2T5lybzQrJlDMaW+vzgVJViwbgDdZzuX0N2z9wKfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uT6O2q2u53t4awbbhx99an3EAe/5r3WhYBV4yD4E7BI=;
 b=dLtzfZnPHhBlob/5M6roYSUKdTEB+L8cJY4WdTotN0f63cGXE8s7lsEmNyzUD9D4t/4WGvmvHq9JvHsgXHbya01/yeZ/gPAW+TR6khOkIFRiBlUK1s87RBwBnXSLCxGuM6ZSl/7NT9EdZ3ohj5zNPot5xj2NETuVgNcwGEsgPjs=
Received: from BYAPR02MB5622.namprd02.prod.outlook.com (2603:10b6:a03:9b::32)
 by BYAPR02MB5208.namprd02.prod.outlook.com (2603:10b6:a03:64::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Thu, 23 Jul
 2020 23:46:32 +0000
Received: from BYAPR02MB5622.namprd02.prod.outlook.com
 ([fe80::9d9e:6608:a5e1:3f8b]) by BYAPR02MB5622.namprd02.prod.outlook.com
 ([fe80::9d9e:6608:a5e1:3f8b%5]) with mapi id 15.20.3216.020; Thu, 23 Jul 2020
 23:46:31 +0000
From:   Amit Sunil Dhamne <amitsuni@xilinx.com>
To:     Michael Tretter <m.tretter@pengutronix.de>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>, Jolly Shah <JOLLYS@xilinx.com>,
        Tejas Patel <TEJASP@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>, Tejas Patel <TEJASP@xilinx.com>
Subject: RE: [PATCH v2 1/3] clk: zynqmp: Use firmware specific common clock
 flags
Thread-Topic: [PATCH v2 1/3] clk: zynqmp: Use firmware specific common clock
 flags
Thread-Index: AQHWX/Ufal6gmd2WkUuaOz1yFmVslqkTlmUAgAI/3vA=
Date:   Thu, 23 Jul 2020 23:46:31 +0000
Message-ID: <BYAPR02MB5622DEA1F08F74407EA796D0A7760@BYAPR02MB5622.namprd02.prod.outlook.com>
References: <1595400932-303612-1-git-send-email-amit.sunil.dhamne@xilinx.com>
 <1595400932-303612-2-git-send-email-amit.sunil.dhamne@xilinx.com>
 <20200722132232.GC21264@pengutronix.de>
In-Reply-To: <20200722132232.GC21264@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 128f9bfe-cbd8-4a5c-8f06-08d82f62a081
x-ms-traffictypediagnostic: BYAPR02MB5208:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB5208F6CBCAD608A0383A4D50A7760@BYAPR02MB5208.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:935;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UADWUNdb096KZtJbDK/kWD4lNb8SWgP519qCLgkTqiWX6t/GO12OKL0qoiJ+/dYIanUn7cSaSbY8EmEe+9mtB+AbcKnnRe8P+QCRUeTZoGK7nvgewtxSBmFskF1FvOpEasXWZmbW7ohIsrOaXvIUuUltJ5J5lhelsd1wlZ8dfi58iFOoECJMW5neVMmzAhTnCur6n5SmnwY0hi172CTpKxLhZxmdlkTNzwGZ0KCVvL+G209Vbg0dZqL+rLj7R1PUC65MnWBFNRR7GryNuzUB7SMmZhFXrMgKRUuwftPKSIgrMO+ILdgndyvVqGtM0lt5hAiRi6JpQeqzpqDiBrIZJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5622.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39860400002)(376002)(346002)(366004)(396003)(33656002)(83380400001)(4326008)(66476007)(478600001)(64756008)(66446008)(66556008)(107886003)(66946007)(86362001)(76116006)(8936002)(7696005)(53546011)(316002)(54906003)(8676002)(9686003)(6916009)(5660300002)(26005)(55016002)(186003)(71200400001)(52536014)(6506007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: qTmNo5EDWy7EEZI10KbKYF7WlMvxzCoeVU10L+SAbVMI/GAM8IBV08l42+Z+WlAceKCVeTVjCk3V3/3/S3g6ViFLvr7p4kdwojKL4ebmX11EOItaU9isFXGxwc30AoHzg3FDs+MGPo4DeUlKJ8R4Q4ns84dGmO+UgKzJUoo0QqawV4twkOAoJKQePr9wunWrNoSDiQjUAgROBiw1olFAHVUBUa+fGMOhNk9v10uA/iDu0j41kGNDL6ASPWqStdHwpqJe0SYfHCHiO+PthTbc9F5ayLAnYPjFfyzRugs3B3e62gRz4hFxVIqDjmVqdkKZ7uGy0woAunMauo7Fm/BWyoycKxPrMJVLXZNXvBizMLXzaF7swOvfxWqS1dJ9fYPdeby6FExxSO8iVWh6sQd65K1UyyDhuJxF8zJy6+fqDZy0RWXm9Po9wacCmWv3rVNH4dAUSOBQhQn4uebe7AoF49N+L4INtShFQPbtDvawhO4ukuIPHUEf7qlugpLCk69l
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5622.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 128f9bfe-cbd8-4a5c-8f06-08d82f62a081
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 23:46:31.7591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mKGyneHM/S1fyOKy2xrGuvPDzH8uF3jmpswnETlX1OcJ6wKtlTju/IQqIlo9Tk6AZojtREIGeaImEGzLL4SW8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5208
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWljaGFlbCwNClRoYW5rcyBmb3IgdGhlIHJldmlldy4gUmVwbGllcyBpbmxpbmUuDQoNClRo
YW5rcywNCkFtaXQNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWNo
YWVsIFRyZXR0ZXIgPG0udHJldHRlckBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogV2VkbmVzZGF5
LCBKdWx5IDIyLCAyMDIwIDY6MjMgQU0NCj4gVG86IEFtaXQgU3VuaWwgRGhhbW5lIDxhbWl0c3Vu
aUB4aWxpbnguY29tPg0KPiBDYzogbXR1cnF1ZXR0ZUBiYXlsaWJyZS5jb207IHNib3lkQGNvZGVh
dXJvcmEub3JnOyBzYm95ZEBrZXJuZWwub3JnOw0KPiBNaWNoYWwgU2ltZWsgPG1pY2hhbHNAeGls
aW54LmNvbT47IG1hcmsucnV0bGFuZEBhcm0uY29tOyBsaW51eC0NCj4gY2xrQHZnZXIua2VybmVs
Lm9yZzsgUmFqYW4gVmFqYSA8UkFKQU5WQHhpbGlueC5jb20+OyBKb2xseSBTaGFoDQo+IDxKT0xM
WVNAeGlsaW54LmNvbT47IFRlamFzIFBhdGVsIDxURUpBU1BAeGlsaW54LmNvbT47IGxpbnV4LWFy
bS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IFJhamFuIFZhamENCj4gPFJBSkFOVkB4aWxpbnguY29tPjsgVGVqYXMgUGF0ZWwgPFRF
SkFTUEB4aWxpbnguY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvM10gY2xrOiB6eW5x
bXA6IFVzZSBmaXJtd2FyZSBzcGVjaWZpYyBjb21tb24gY2xvY2sNCj4gZmxhZ3MNCj4gDQo+IE9u
IFR1ZSwgMjEgSnVsIDIwMjAgMjM6NTU6MzAgLTA3MDAsIEFtaXQgU3VuaWwgRGhhbW5lIHdyb3Rl
Og0KPiA+IEZyb206IFJhamFuIFZhamEgPHJhamFuLnZhamFAeGlsaW54LmNvbT4NCj4gPg0KPiA+
IEN1cnJlbnRseSBmaXJtd2FyZSBwYXNzZXMgQ0NGIHNwZWNpZmljIGZsYWdzIHRvIFp5bnFNUCBj
bG9jayBkcml2ZXIuDQo+ID4gU28gZmlybXdhcmUgbmVlZHMgdG8gYmUgdXBkYXRlZCBpZiBDQ0Yg
ZmxhZ3MgYXJlIGNoYW5nZWQuIFRoZSBmaXJtd2FyZQ0KPiA+IHNob3VsZCBoYXZlIGl0cyBvd24g
J2ZsYWcgbnVtYmVyIHNwYWNlJyB0aGF0IGlzIGRpc3RpbmN0IGZyb20gdGhlDQo+ID4gY29tbW9u
IGNsayBmcmFtZXdvcmsncyAnZmxhZyBudW1iZXIgc3BhY2UnLiBTbyBkZWZpbmUgYW5kIHVzZSBa
eW5xTVANCj4gPiBzcGVjaWZpYyBjb21tb24gY2xvY2sgZmxhZ3MgaW5zdGVhZCBvZiB1c2luZyBD
Q0YgZmxhZ3MuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSYWphbiBWYWphIDxyYWphbi52YWph
QHhpbGlueC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogVGVqYXMgUGF0ZWwgPHRlamFzLnBhdGVs
QHhpbGlueC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW1pdCBTdW5pbCBEaGFtbmUgPGFtaXQu
c3VuaWwuZGhhbW5lQHhpbGlueC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvY2xrL3p5bnFt
cC9jbGstZ2F0ZS16eW5xbXAuYyB8ICA0ICsrKy0NCj4gPiAgZHJpdmVycy9jbGsvenlucW1wL2Ns
ay1tdXgtenlucW1wLmMgIHwgIDQgKysrLQ0KPiA+ICBkcml2ZXJzL2Nsay96eW5xbXAvY2xrLXp5
bnFtcC5oICAgICAgfCAyNSArKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIGRyaXZlcnMv
Y2xrL3p5bnFtcC9jbGtjLmMgICAgICAgICAgICB8IDMxICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0NCj4gPiAgZHJpdmVycy9jbGsvenlucW1wL2RpdmlkZXIuYyAgICAgICAgIHwgIDUg
KysrLS0NCj4gPiAgZHJpdmVycy9jbGsvenlucW1wL3BsbC5jICAgICAgICAgICAgIHwgIDQgKysr
LQ0KPiA+ICA2IGZpbGVzIGNoYW5nZWQsIDY3IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0p
DQo+ID4NCj4gW3NuaXBdDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL3p5bnFtcC9jbGtj
LmMgYi9kcml2ZXJzL2Nsay96eW5xbXAvY2xrYy5jDQo+ID4gaW5kZXggZGI4ZDBkNy4uMTEzNTFm
NiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Nsay96eW5xbXAvY2xrYy5jDQo+ID4gKysrIGIv
ZHJpdmVycy9jbGsvenlucW1wL2Nsa2MuYw0KPiA+IEBAIC0yNzEsNiArMjcxLDMyIEBAIHN0YXRp
YyBpbnQgenlucW1wX3BtX2Nsb2NrX2dldF90b3BvbG9neSh1MzINCj4gY2xvY2tfaWQsIHUzMiBp
bmRleCwNCj4gPiAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gIH0NCj4gPg0KPiA+ICt2b2lkIHp5
bnFtcF9jbGtfbWFwX2NvbW1vbl9jY2ZfZmxhZ3MoY29uc3QgdTMyIHp5bnFtcF9mbGFnLA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nICpjY2Zf
ZmxhZykNCj4gPiArew0KPiA+ICsgICAgICAgKmNjZl9mbGFnID0gMDsNCj4gPiArICAgICAgICpj
Y2ZfZmxhZyB8PSAoenlucW1wX2ZsYWcgJiBaWU5RTVBfQ0xLX1NFVF9SQVRFX0dBVEUpID8NCj4g
PiArICAgICAgICAgICAgICAgICAgICAgQ0xLX1NFVF9SQVRFX0dBVEUgOiAwOw0KPiA+ICsgICAg
ICAgKmNjZl9mbGFnIHw9ICh6eW5xbXBfZmxhZyAmIFpZTlFNUF9DTEtfU0VUX1BBUkVOVF9HQVRF
KSA/DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIENMS19TRVRfUEFSRU5UX0dBVEUgOiAwOw0K
PiA+ICsgICAgICAgKmNjZl9mbGFnIHw9ICh6eW5xbXBfZmxhZyAmIFpZTlFNUF9DTEtfU0VUX1JB
VEVfUEFSRU5UKSA/DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIENMS19TRVRfUkFURV9QQVJF
TlQgOiAwOw0KPiA+ICsgICAgICAgKmNjZl9mbGFnIHw9ICh6eW5xbXBfZmxhZyAmIFpZTlFNUF9D
TEtfSUdOT1JFX1VOVVNFRCkgPw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBDTEtfSUdOT1JF
X1VOVVNFRCA6IDA7DQo+ID4gKyAgICAgICAqY2NmX2ZsYWcgfD0gKHp5bnFtcF9mbGFnICYgWllO
UU1QX0NMS19HRVRfUkFURV9OT0NBQ0hFKSA/DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIENM
S19HRVRfUkFURV9OT0NBQ0hFIDogMDsNCj4gPiArICAgICAgICpjY2ZfZmxhZyB8PSAoenlucW1w
X2ZsYWcgJiBaWU5RTVBfQ0xLX1NFVF9SQVRFX05PX1JFUEFSRU5UKQ0KPiA/DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgIENMS19TRVRfUkFURV9OT19SRVBBUkVOVCA6IDA7DQo+ID4gKyAgICAg
ICAqY2NmX2ZsYWcgfD0gKHp5bnFtcF9mbGFnICYNCj4gWllOUU1QX0NMS19HRVRfQUNDVVJBQ1lf
Tk9DQUNIRSkgPw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBDTEtfR0VUX0FDQ1VSQUNZX05P
Q0FDSEUgOiAwOw0KPiA+ICsgICAgICAgKmNjZl9mbGFnIHw9ICh6eW5xbXBfZmxhZyAmIFpZTlFN
UF9DTEtfUkVDQUxDX05FV19SQVRFUykgPw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBDTEtf
UkVDQUxDX05FV19SQVRFUyA6IDA7DQo+ID4gKyAgICAgICAqY2NmX2ZsYWcgfD0gKHp5bnFtcF9m
bGFnICYgWllOUU1QX0NMS19TRVRfUkFURV9VTkdBVEUpID8NCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgQ0xLX1NFVF9SQVRFX1VOR0FURSA6IDA7DQo+ID4gKyAgICAgICAqY2NmX2ZsYWcgfD0g
KHp5bnFtcF9mbGFnICYgWllOUU1QX0NMS19JU19DUklUSUNBTCkgPw0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICBDTEtfSVNfQ1JJVElDQUwgOiAwOw0KPiA+ICt9DQo+IA0KPiBXaGF0IGlzIHRo
ZSByZWFzb24gZm9yIHJldHVybmluZyB0aGUgcmVzdWx0aW5nIGZsYWdzIHZpYSBwb2ludGVyPyBJ
IHdvdWxkIGhhdmUNCj4gZXhwZWN0ZWQgc29tZXRoaW5nIGxpa2UgdGhlIGZvbGxvd2luZyBmdW5j
dGlvbjoNCj4gDQo+IHVuc2lnbmVkIGxvbmcgenlucW1wX2Nsa19mbGFnc190b19jbGtfZmxhZ3Mo
Y29uc3QgdTMyIHp5cW5tcF9mbGFncykNCj4gew0KPiAJdW5zaWduZWQgbG9uZyBmbGFncyA9IDA7
DQo+IA0KPiAJaWYgKHp5bnFtcF9mbGFnICYgWllOUU1QX0NMS19TRVRfUkFURV9HQVRFKQ0KPiAJ
CWZsYWdzIHw9IENMS19TRVRfUkFURV9HQVRFOw0KPiAJLyogLi4uICovDQo+IA0KPiAJcmV0dXJu
IGZsYWdzOw0KPiB9DQo+IA0KPiBNaWNoYWVsDQo+IA0KW0FtaXRdIFRoZXJlJ3Mgbm8gcGFydGlj
dWxhciByZWFzb24gZm9yIHJldHVybmluZyB2YWx1ZXMgdGhyb3VnaCBwb2ludGVyLiBJIHdpbGwg
c2VuZCBhIG5leHQgdmVyc2lvbiBvZiBwYXRjaCB3aXRoIHRoZSBmb3JtYXQgeW91IHN1Z2dlc3Rl
ZC4NCj4gPiArDQo+ID4gIC8qKg0KPiA+ICAgKiB6eW5xbXBfY2xrX3JlZ2lzdGVyX2ZpeGVkX2Zh
Y3RvcigpIC0gUmVnaXN0ZXIgZml4ZWQgZmFjdG9yIHdpdGggdGhlDQo+ID4gICAqICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNsb2NrIGZyYW1ld29yaw0KPiA+IEBAIC0yOTIs
NiArMzE4LDcgQEAgc3RydWN0IGNsa19odw0KPiAqenlucW1wX2Nsa19yZWdpc3Rlcl9maXhlZF9m
YWN0b3IoY29uc3QgY2hhciAqbmFtZSwgdTMyIGNsa19pZCwNCj4gPiAgICAgICAgIHN0cnVjdCB6
eW5xbXBfcG1fcXVlcnlfZGF0YSBxZGF0YSA9IHswfTsNCj4gPiAgICAgICAgIHUzMiByZXRfcGF5
bG9hZFtQQVlMT0FEX0FSR19DTlRdOw0KPiA+ICAgICAgICAgaW50IHJldDsNCj4gPiArICAgICAg
IHVuc2lnbmVkIGxvbmcgZmxhZzsNCj4gPg0KPiA+ICAgICAgICAgcWRhdGEucWlkID0gUE1fUUlE
X0NMT0NLX0dFVF9GSVhFREZBQ1RPUl9QQVJBTVM7DQo+ID4gICAgICAgICBxZGF0YS5hcmcxID0g
Y2xrX2lkOw0KPiA+IEBAIC0zMDMsOSArMzMwLDExIEBAIHN0cnVjdCBjbGtfaHcNCj4gKnp5bnFt
cF9jbGtfcmVnaXN0ZXJfZml4ZWRfZmFjdG9yKGNvbnN0IGNoYXIgKm5hbWUsIHUzMiBjbGtfaWQs
DQo+ID4gICAgICAgICBtdWx0ID0gcmV0X3BheWxvYWRbMV07DQo+ID4gICAgICAgICBkaXYgPSBy
ZXRfcGF5bG9hZFsyXTsNCj4gPg0KPiA+ICsgICAgICAgenlucW1wX2Nsa19tYXBfY29tbW9uX2Nj
Zl9mbGFncyhub2Rlcy0+ZmxhZywgJmZsYWcpOw0KPiA+ICsNCj4gPiAgICAgICAgIGh3ID0gY2xr
X2h3X3JlZ2lzdGVyX2ZpeGVkX2ZhY3RvcihOVUxMLCBuYW1lLA0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBhcmVudHNbMF0sDQo+ID4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbm9kZXMtPmZsYWcsIG11bHQsDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZmxhZywgbXVsdCwNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkaXYpOw0KPiA+DQo+ID4g
ICAgICAgICByZXR1cm4gaHc7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL3p5bnFtcC9k
aXZpZGVyLmMgYi9kcml2ZXJzL2Nsay96eW5xbXAvZGl2aWRlci5jDQo+ID4gaW5kZXggNjZkYTAy
Yi4uM2FiNTdkOSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Nsay96eW5xbXAvZGl2aWRlci5j
DQo+ID4gKysrIGIvZHJpdmVycy9jbGsvenlucW1wL2RpdmlkZXIuYw0KPiA+IEBAIC0zMTEsOCAr
MzExLDkgQEAgc3RydWN0IGNsa19odyAqenlucW1wX2Nsa19yZWdpc3Rlcl9kaXZpZGVyKGNvbnN0
DQo+IGNoYXIgKm5hbWUsDQo+ID4NCj4gPiAgICAgICAgIGluaXQubmFtZSA9IG5hbWU7DQo+ID4g
ICAgICAgICBpbml0Lm9wcyA9ICZ6eW5xbXBfY2xrX2RpdmlkZXJfb3BzOw0KPiA+IC0gICAgICAg
LyogQ0xLX0ZSQUMgaXMgbm90IGRlZmluZWQgaW4gdGhlIGNvbW1vbiBjbGsgZnJhbWV3b3JrICov
DQo+ID4gLSAgICAgICBpbml0LmZsYWdzID0gbm9kZXMtPmZsYWcgJiB+Q0xLX0ZSQUM7DQo+ID4g
Kw0KPiA+ICsgICAgICAgenlucW1wX2Nsa19tYXBfY29tbW9uX2NjZl9mbGFncyhub2Rlcy0+Zmxh
ZywgJmluaXQuZmxhZ3MpOw0KPiA+ICsNCj4gPiAgICAgICAgIGluaXQucGFyZW50X25hbWVzID0g
cGFyZW50czsNCj4gPiAgICAgICAgIGluaXQubnVtX3BhcmVudHMgPSAxOw0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvY2xrL3p5bnFtcC9wbGwuYyBiL2RyaXZlcnMvY2xrL3p5bnFtcC9w
bGwuYw0KPiA+IGluZGV4IDkyZjQ0OWUuLjFiN2UyMzEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9jbGsvenlucW1wL3BsbC5jDQo+ID4gKysrIGIvZHJpdmVycy9jbGsvenlucW1wL3BsbC5jDQo+
ID4gQEAgLTMwMiw3ICszMDIsOSBAQCBzdHJ1Y3QgY2xrX2h3ICp6eW5xbXBfY2xrX3JlZ2lzdGVy
X3BsbChjb25zdCBjaGFyDQo+ICpuYW1lLCB1MzIgY2xrX2lkLA0KPiA+DQo+ID4gICAgICAgICBp
bml0Lm5hbWUgPSBuYW1lOw0KPiA+ICAgICAgICAgaW5pdC5vcHMgPSAmenlucW1wX3BsbF9vcHM7
DQo+ID4gLSAgICAgICBpbml0LmZsYWdzID0gbm9kZXMtPmZsYWc7DQo+ID4gKw0KPiA+ICsgICAg
ICAgenlucW1wX2Nsa19tYXBfY29tbW9uX2NjZl9mbGFncyhub2Rlcy0+ZmxhZywgJmluaXQuZmxh
Z3MpOw0KPiA+ICsNCj4gPiAgICAgICAgIGluaXQucGFyZW50X25hbWVzID0gcGFyZW50czsNCj4g
PiAgICAgICAgIGluaXQubnVtX3BhcmVudHMgPSAxOw0KPiA+DQo+ID4gLS0NCj4gPiAyLjcuNA0K
PiA+DQo+ID4gVGhpcyBlbWFpbCBhbmQgYW55IGF0dGFjaG1lbnRzIGFyZSBpbnRlbmRlZCBmb3Ig
dGhlIHNvbGUgdXNlIG9mIHRoZSBuYW1lZA0KPiByZWNpcGllbnQocykgYW5kIGNvbnRhaW4ocykg
Y29uZmlkZW50aWFsIGluZm9ybWF0aW9uIHRoYXQgbWF5IGJlIHByb3ByaWV0YXJ5LA0KPiBwcml2
aWxlZ2VkIG9yIGNvcHlyaWdodGVkIHVuZGVyIGFwcGxpY2FibGUgbGF3LiBJZiB5b3UgYXJlIG5v
dCB0aGUgaW50ZW5kZWQNCj4gcmVjaXBpZW50LCBkbyBub3QgcmVhZCwgY29weSwgb3IgZm9yd2Fy
ZCB0aGlzIGVtYWlsIG1lc3NhZ2Ugb3IgYW55DQo+IGF0dGFjaG1lbnRzLiBEZWxldGUgdGhpcyBl
bWFpbCBtZXNzYWdlIGFuZCBhbnkgYXR0YWNobWVudHMgaW1tZWRpYXRlbHkuDQo+ID4NCg==
