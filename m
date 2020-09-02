Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D03CC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 03:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B7962068F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 03:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sI9UiaMF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgIBDFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 23:05:34 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:56280 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726174AbgIBDFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 23:05:31 -0400
X-UUID: 112333ac71ac4379aae85c4ceb33100c-20200902
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=jfIIm6tENvdGpct6biW2eJvqIKrDoiDyyQ/L8G7febQ=;
        b=sI9UiaMFAQPk/hDkzx6OoBhhmTyvH3FkyKIfJlhYYx0raHtlUOHOHSE1avsyeK2uxM9fyGDrnA8gz37fJtT9mIjxNiJ+wm0HOCRnNO0+okMvZaB7y0+zP70sgwAnfb4GndH5e3b4Uid+a8g1GmORs3g8DsIbKvJ49921yPxRKno=;
X-UUID: 112333ac71ac4379aae85c4ceb33100c-20200902
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1352025062; Wed, 02 Sep 2020 11:05:26 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Sep
 2020 11:05:25 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 2 Sep 2020 11:05:24 +0800
Message-ID: <1599015827.30048.22.camel@mhfsdcap03>
Subject: Re: [v4,0/4] introduce TI reset controller for MT8192 SoC
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     Rob Herring <robh@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "s-anna@ti.com" <s-anna@ti.com>, "afd@ti.com" <afd@ti.com>
CC:     srv_heupstream <srv_heupstream@mediatek.com>,
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
Date:   Wed, 2 Sep 2020 11:03:47 +0800
In-Reply-To: <5065a23627a34212aa62df646dbf00ee@mtkmbs05n1.mediatek.inc>
References: <20200817030324.5690-1-crystal.guo@mediatek.com>
         <5065a23627a34212aa62df646dbf00ee@mtkmbs05n1.mediatek.inc>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 8812CB25358BC3F220BEE59098E36044C2C506DE8C77D12AA6E5A2061D7E66462000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLCBQaGlsaXBwLCBNYXR0aGlhcyBhbmQgYWxsDQoNCkdlbnRsZSBwaW5nIGZvciB0aGlz
IHBhdGNoIHNldC4NCg0KVGhhbmtzDQpDcnlzdGFsDQoNCj4gDQo+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+IEZyb206IENyeXN0YWwgR3VvIFttYWlsdG86Y3J5c3RhbC5ndW9AbWVkaWF0
ZWsuY29tXQ0KPiBTZW50OiBNb25kYXksIEF1Z3VzdCAxNywgMjAyMCAxMTowMyBBTQ0KPiBUbzog
cC56YWJlbEBwZW5ndXRyb25peC5kZTsgcm9iaCtkdEBrZXJuZWwub3JnOyBtYXR0aGlhcy5iZ2dA
Z21haWwuY29tDQo+IENjOiBzcnZfaGV1cHN0cmVhbTsgbGludXgtbWVkaWF0ZWtAbGlzdHMuaW5m
cmFkZWFkLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgcy1hbm5h
QHRpLmNvbTsgYWZkQHRpLmNvbTsgU2VpeWEgV2FuZyAo546L6L+65ZCbKTsgU3RhbmxleSBDaHUg
KOacseWOn+mZnik7IFlpbmdqb2UgQ2hlbiAo6Zmz6Iux5rSyKTsgRmFuIENoZW4gKOmZs+WHoSk7
IFlvbmcgTGlhbmcgKOaigeWLhykNCj4gU3ViamVjdDogW3Y0LDAvNF0gaW50cm9kdWNlIFRJIHJl
c2V0IGNvbnRyb2xsZXIgZm9yIE1UODE5MiBTb0MNCj4gDQo+IHY0Og0KPiBmaXggdHlwb3Mgb24g
djMgY29tbWl0IG1lc3NhZ2UuDQo+IA0KPiB2MzoNCj4gMS4gcmV2ZXJ0IHYyIGNoYW5nZXMuDQo+
IDIuIGFkZCAncmVzZXQtZHVyYXRpb24tdXMnIHByb3BlcnR5IHRvIGRlY2xhcmUgYSBtaW5pbXVt
IGRlbGF5LCB3aGljaCBuZWVkcyB0byBiZSB3YWl0ZWQgYmV0d2VlbiBhc3NlcnQgYW5kIGRlYXNz
ZXJ0Lg0KPiAzLiBhZGQgJ21lZGlhdGVrLGluZnJhLXJlc2V0JyB0byBjb21wYXRpYmxlLg0KPiAN
Cj4gDQo+IHYyIGNoYW5nZXM6DQo+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gv
MTE2OTczNzEvDQo+IDEuIGFkZCAnYXNzZXJ0LWRlYXNzZXJ0LXRvZ2V0aGVyJyBwcm9wZXJ0eSB0
byBpbnRyb2R1Y2UgYSBuZXcgcmVzZXQgaGFuZGxlciwgd2hpY2ggYWxsb3dzIGRldmljZSB0byBk
byBzZXJpYWxpemVkIGFzc2VydCBhbmQgZGVhc3NlcnQgb3BlcmF0aW9ucyBpbiBhIHNpbmdsZSBz
dGVwIGJ5ICdyZXNldCcgbWV0aG9kLg0KPiAyLiBhZGQgJ3VwZGF0ZS1mb3JjZScgcHJvcGVydHkg
dG8gaW50cm9kdWNlIGZvcmNlLXVwZGF0ZSBtZXRob2QsIHdoaWNoIGZvcmNlcyB0aGUgd3JpdGUg
b3BlcmF0aW9uIGluIGNhc2UgdGhlIHJlYWQgYWxyZWFkeSBoYXBwZW5zIHRvIHJldHVybiB0aGUg
Y29ycmVjdCB2YWx1ZS4NCj4gMy4gYWRkICdnZW5lcmljLXJlc2V0JyB0byBjb21wYXRpYmxlDQo+
IA0KPiB2MSBjaGFuZ2VzOg0KPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEx
NjkwNTIzLw0KPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzExNjkwNTI3Lw0K
PiANCj4gQ3J5c3RhbCBHdW8gKDQpOg0KPiAgIGR0LWJpbmRpbmc6IHJlc2V0LWNvbnRyb2xsZXI6
IHRpOiBhZGQgcmVzZXQtZHVyYXRpb24tdXMgcHJvcGVydHkNCj4gICBkdC1iaW5kaW5nOiByZXNl
dC1jb250cm9sbGVyOiB0aTogYWRkICdtZWRpYXRlayxpbmZyYS1yZXNldCcgdG8NCj4gICAgIGNv
bXBhdGlibGUNCj4gICByZXNldC1jb250cm9sbGVyOiB0aTogaW50cm9kdWNlIGEgbmV3IHJlc2V0
IGhhbmRsZXINCj4gICBhcm02NDogZHRzOiBtdDgxOTI6IGFkZCBpbmZyYWNmZ19yc3Qgbm9kZQ0K
PiANCj4gIC4uLi9iaW5kaW5ncy9yZXNldC90aS1zeXNjb24tcmVzZXQudHh0ICAgICAgICB8ICA2
ICsrKysrDQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi5kdHNpICAgICAg
fCAxMSArKysrKysrLQ0KPiAgZHJpdmVycy9yZXNldC9yZXNldC10aS1zeXNjb24uYyAgICAgICAg
ICAgICAgIHwgMjYgKysrKysrKysrKysrKysrKystLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA0MCBp
bnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gDQo+ICoqKioqKioqKioqKioqKioq
KioqKk1FRElBVEVLIENvbmZpZGVudGlhbC9JbnRlcm5hbCBVc2UqKioqKioqKioqKioqKioqKioq
KioNCg0K

