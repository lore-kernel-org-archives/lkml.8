Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FF1C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 15:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0477A23D6A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 15:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uvFZrsev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbgIHPPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 11:15:37 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:3261 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730189AbgIHPOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:14:21 -0400
X-UUID: 6177d6bd5e6a4603a7295c234df2c931-20200908
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=oQzZwJh3y7+kGJk/4w1rH1iequi645UjG2KFNV11C7k=;
        b=uvFZrsevXgDGmwNjyt6oi0NaK0IJUJ/hmfn2VflP7ZXeZ4eOMGUMM9A5a2yk6fl00pS0o18v75RSOUk17I5B0kfy9Q/4oBcC360CvxIlhClbwFLgZW9c3/OS4DIhWJf9WhvvUXCSsfuKDD/DeUNbfI8WUylMtz/rGnMUDYOiUl0=;
X-UUID: 6177d6bd5e6a4603a7295c234df2c931-20200908
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1413091755; Tue, 08 Sep 2020 21:28:50 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 8 Sep
 2020 21:28:48 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Sep 2020 21:28:48 +0800
Message-ID: <1599571618.14806.7.camel@mhfsdcap03>
Subject: Re: [v4,4/4] arm64: dts: mt8192: add infracfg_rst node
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     Suman Anna <s-anna@ti.com>
CC:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Seiya Wang =?UTF-8?Q?=28=E7=8E=8B=E8=BF=BA=E5=90=9B=29?= 
        <seiya.wang@mediatek.com>,
        Stanley Chu =?UTF-8?Q?=28=E6=9C=B1=E5=8E=9F=E9=99=9E=29?= 
        <stanley.chu@mediatek.com>,
        Yingjoe Chen =?UTF-8?Q?=28=E9=99=B3=E8=8B=B1=E6=B4=B2=29?= 
        <Yingjoe.Chen@mediatek.com>,
        Fan Chen =?UTF-8?Q?=28=E9=99=B3=E5=87=A1=29?= 
        <fan.chen@mediatek.com>,
        "Yong Liang =?UTF-8?Q?=28=E6=A2=81=E5=8B=87=29?=" 
        <Yong.Liang@mediatek.com>
Date:   Tue, 8 Sep 2020 21:26:58 +0800
In-Reply-To: <211bd78f-3b70-1e65-eea9-75cc73a3dfdd@ti.com>
References: <20200817030324.5690-1-crystal.guo@mediatek.com>
         <20200817030324.5690-5-crystal.guo@mediatek.com>
         <211bd78f-3b70-1e65-eea9-75cc73a3dfdd@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: E2B71D7CF58B128302A1F43348A6FECCA6782FE097627415268B005A7ADAC0792000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA5LTAzIGF0IDA3OjI5ICswODAwLCBTdW1hbiBBbm5hIHdyb3RlOg0KPiBI
aSBDcnlzdGFsLA0KPiANCj4gT24gOC8xNi8yMCAxMDowMyBQTSwgQ3J5c3RhbCBHdW8gd3JvdGU6
DQo+ID4gYWRkIGluZnJhY2ZnX3JzdCBub2RlIHdoaWNoIGlzIGZvciBNVDgxOTIgcGxhdGZvcm0N
Cj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDcnlzdGFsIEd1byA8Y3J5c3RhbC5ndW9AbWVkaWF0
ZWsuY29tPg0KPiANCj4gSSB1bmRlcnN0YW5kIHlvdSBhcmUgcG9zdGluZyB0aGVzZSB0b2dldGhl
ciBmb3IgY29tcGxldGUgcmVmZXJlbmNlLCBidXQgZHJpdmVyDQo+IHN1YnN5c3RlbSBtYWludGFp
bmVycyB0eXBpY2FsbHkgZG9uJ3QgcGljayBkdHMgcGF0Y2hlcy4gSW4gYW55Y2FzZSwgY2FuIHlv
dQ0KPiBjbGFyaWZ5IGlmIHlvdXIgcmVnaXN0ZXJzIGFyZSBzZWxmLWNsZWFyaW5nIHJlZ2lzdGVy
cz8NCj4gDQo+IHJlZ2FyZHMNCj4gU3VtYW4NCj4gDQpIaSBTdW1hbiwNCg0KVGhhbmtzIGZvciB5
b3VyIHJlcGx5Lg0KT3VyIHJlc2V0IHJlZ2lzdGVycyBhcmUgbm90IHNlbGYtY2xlYXJpbmcsIGl0
IG5lZWRzIHRvIHNldCB0aGUgY2xlYXIgYml0DQp0byAxIHRvIGNsZWFyIHRoZSByZWxhdGVkIGJp
dC4NCkFuZCBzaG91bGQgSSBzZXBhcmF0ZSB0aGlzIGR0cyBwYXRjaCBmcm9tIHRoZSBwYXRjaCBz
ZXRzPw0KDQpyZWdhcmRzDQpDcnlzdGFsDQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtNjQvYm9vdC9k
dHMvbWVkaWF0ZWsvbXQ4MTkyLmR0c2kgfCAxMSArKysrKysrKysrLQ0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1n
aXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi5kdHNpIGIvYXJjaC9hcm02
NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTIuZHRzaQ0KPiA+IGluZGV4IDkzMWUxY2ExNzIyMC4u
YTBjYjk5MDQ3MDZiIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0
ZWsvbXQ4MTkyLmR0c2kNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210
ODE5Mi5kdHNpDQo+ID4gQEAgLTEwLDYgKzEwLDcgQEANCj4gPiAgI2luY2x1ZGUgPGR0LWJpbmRp
bmdzL2ludGVycnVwdC1jb250cm9sbGVyL2lycS5oPg0KPiA+ICAjaW5jbHVkZSA8ZHQtYmluZGlu
Z3MvcGluY3RybC9tdDgxOTItcGluZnVuYy5oPg0KPiA+ICAjaW5jbHVkZSA8ZHQtYmluZGluZ3Mv
cG93ZXIvbXQ4MTkyLXBvd2VyLmg+DQo+ID4gKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9yZXNldC90
aS1zeXNjb24uaD4NCj4gPiAgDQo+ID4gIC8gew0KPiA+ICAJY29tcGF0aWJsZSA9ICJtZWRpYXRl
ayxtdDgxOTIiOw0KPiA+IEBAIC0yMTksOSArMjIwLDE3IEBADQo+ID4gIAkJfTsNCj4gPiAgDQo+
ID4gIAkJaW5mcmFjZmc6IGluZnJhY2ZnQDEwMDAxMDAwIHsNCj4gPiAtCQkJY29tcGF0aWJsZSA9
ICJtZWRpYXRlayxtdDgxOTItaW5mcmFjZmciLCAic3lzY29uIjsNCj4gPiArCQkJY29tcGF0aWJs
ZSA9ICJtZWRpYXRlayxtdDgxOTItaW5mcmFjZmciLCAic3lzY29uIiwgInNpbXBsZS1tZmQiOw0K
PiA+ICAJCQlyZWcgPSA8MCAweDEwMDAxMDAwIDAgMHgxMDAwPjsNCj4gPiAgCQkJI2Nsb2NrLWNl
bGxzID0gPDE+Ow0KPiA+ICsNCj4gPiArCQkJaW5mcmFjZmdfcnN0OiByZXNldC1jb250cm9sbGVy
IHsNCj4gPiArCQkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssaW5mcmEtcmVzZXQiLCAidGksc3lz
Y29uLXJlc2V0IjsNCj4gPiArCQkJCSNyZXNldC1jZWxscyA9IDwxPjsNCj4gPiArCQkJCXRpLHJl
c2V0LWJpdHMgPSA8DQo+ID4gKwkJCQkJMHgxNDAgMTUgMHgxNDQgMTUgMCAwIChBU1NFUlRfU0VU
IHwgREVBU1NFUlRfU0VUIHwgU1RBVFVTX05PTkUpIC8qIDA6IHBjaWUgKi8NCj4gPiArCQkJCT47
DQo+ID4gKwkJCX07DQo+ID4gIAkJfTsNCj4gPiAgDQo+ID4gIAkJcGVyaWNmZzogcGVyaWNmZ0Ax
MDAwMzAwMCB7DQo+ID4gDQo+IA0KDQo=

