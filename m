Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4D9C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 06:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29BDB21D7E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 06:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PIfKT9f4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbgIKGJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 02:09:17 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:3230 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725768AbgIKGJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 02:09:13 -0400
X-UUID: be4aa07ed0a0401d88abf7232f04ce31-20200911
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ECQMTgBrEhrH+Bd6squDfuysRS3f/ziIyHvCiJUGjA4=;
        b=PIfKT9f4zeiyZ53+hVoSl/4mtzzSmsWe0mn4gdSqyv+PX07pWXHt/yGszcsixhpdBm8RJW+Smwo8vHUQfNXdc4rpwsns5QgTlcqR9dQMn8udwZSDJxIdBX8RRlQmsyphbfTYT+Lb5x9lCv2Q/Z4/JvRjOPJpfMHsMStO49ajcIA=;
X-UUID: be4aa07ed0a0401d88abf7232f04ce31-20200911
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1615883041; Fri, 11 Sep 2020 14:08:59 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 11 Sep
 2020 14:08:58 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Sep 2020 14:08:58 +0800
Message-ID: <1599804422.14806.27.camel@mhfsdcap03>
Subject: Re: [v4,3/4] reset-controller: ti: introduce a new reset handler
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
Date:   Fri, 11 Sep 2020 14:07:02 +0800
In-Reply-To: <9d72aaef-49fe-ebb6-215d-05ad3ab27af4@ti.com>
References: <20200817030324.5690-1-crystal.guo@mediatek.com>
         <20200817030324.5690-4-crystal.guo@mediatek.com>
         <3a5decee-5f31-e27d-a120-1f835241a87c@ti.com>
         <1599620279.14806.18.camel@mhfsdcap03>
         <096362e9-dee8-4e7a-2518-47328068c2fd@ti.com>
         <1599792140.14806.22.camel@mhfsdcap03>
         <9d72aaef-49fe-ebb6-215d-05ad3ab27af4@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 34CF4C9C89C311E5EFCE369EA719E31134CA2F740B2C05DC28FF6C9B6F1E76E32000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTA5LTExIGF0IDEwOjUyICswODAwLCBTdW1hbiBBbm5hIHdyb3RlOg0KPiBP
biA5LzEwLzIwIDk6NDIgUE0sIENyeXN0YWwgR3VvIHdyb3RlOg0KPiA+IE9uIFdlZCwgMjAyMC0w
OS0wOSBhdCAyMzozOSArMDgwMCwgU3VtYW4gQW5uYSB3cm90ZToNCj4gPj4gT24gOS84LzIwIDk6
NTcgUE0sIENyeXN0YWwgR3VvIHdyb3RlOg0KPiA+Pj4gT24gVGh1LCAyMDIwLTA5LTAzIGF0IDA3
OjQwICswODAwLCBTdW1hbiBBbm5hIHdyb3RlOg0KPiA+Pj4+IEhpIENyeXN0YWwsDQo+ID4+Pj4N
Cj4gPj4+PiBPbiA4LzE2LzIwIDEwOjAzIFBNLCBDcnlzdGFsIEd1byB3cm90ZToNCj4gPj4+Pj4g
SW50cm9kdWNlIHRpX3N5c2Nvbl9yZXNldCgpIHRvIGludGVncmF0ZSBhc3NlcnQgYW5kIGRlYXNz
ZXJ0IHRvZ2V0aGVyLg0KPiA+Pj4+PiBJZiBzb21lIG1vZHVsZXMgbmVlZCBkbyBzZXJpYWxpemVk
IGFzc2VydCBhbmQgZGVhc3NlcnQgb3BlcmF0aW9ucw0KPiA+Pj4+PiB0byByZXNldCBpdHNlbGYs
IHJlc2V0X2NvbnRyb2xfcmVzZXQgY2FuIGJlIGNhbGxlZCBmb3IgY29udmVuaWVuY2UuDQo+ID4+
Pj4NCj4gPj4+PiBUaGVyZSBhcmUgbXVsdGlwbGUgY2hhbmdlcyBpbiB0aGlzIHNhbWUgcGF0Y2gu
IEkgdGhpbmsgeW91IHNob3VsZCBzcGxpdCB0aGlzDQo+ID4+Pj4gZnVuY3Rpb25hbGl0eSBhd2F5
IGZyb20gdGhlIGNoYW5nZSBmb3IgdGhlIHJlZ21hcF91cGRhdGVfYml0cygpIHRvDQo+ID4+Pj4g
cmVnbWFwX3dyaXRlX2JpdHMoKSwgc2ltaWxhciB0byB3aGF0IHlvdSBoYXZlIGRvbmUgaW4geW91
ciB2MiBQYXRjaCA0Lg0KPiA+Pj4+DQo+ID4+Pg0KPiA+Pj4gVGhhbmtzIGZvciB5b3VyIHN1Z2dl
c3Rpb24uDQo+ID4+PiBJIHdpbGwgc3BsaXQgdGhpcyBwYXRjaCBpbiB0aGUgbmV4dCB2ZXJzaW9u
Lg0KPiA+Pj4NCj4gPj4+Pj4NCj4gPj4+Pj4gU3VjaCBhcyByZXNldC1xY29tLWFvc3MuYywgaXQg
aW50ZWdyYXRlcyBhc3NlcnQgYW5kIGRlYXNzZXJ0IHRvZ2V0aGVyDQo+ID4+Pj4+IGJ5ICdyZXNl
dCcgbWV0aG9kLiBNVEsgU29jcyBhbHNvIG5lZWQgdGhpcyBtZXRob2QgdG8gcGVyZm9ybSByZXNl
dC4NCj4gPj4+Pj4NCj4gPj4+Pj4gU2lnbmVkLW9mZi1ieTogQ3J5c3RhbCBHdW8gPGNyeXN0YWwu
Z3VvQG1lZGlhdGVrLmNvbT4NCj4gPj4+Pj4gLS0tDQo+ID4+Pj4+ICBkcml2ZXJzL3Jlc2V0L3Jl
c2V0LXRpLXN5c2Nvbi5jIHwgMjYgKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4gPj4+Pj4g
IDEgZmlsZSBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+Pj4+
Pg0KPiA+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9yZXNldC9yZXNldC10aS1zeXNjb24uYyBi
L2RyaXZlcnMvcmVzZXQvcmVzZXQtdGktc3lzY29uLmMNCj4gPj4+Pj4gaW5kZXggYTI2MzVjMjFk
YjdmLi4wODI4OTM0MmY5YWYgMTAwNjQ0DQo+ID4+Pj4+IC0tLSBhL2RyaXZlcnMvcmVzZXQvcmVz
ZXQtdGktc3lzY29uLmMNCj4gPj4+Pj4gKysrIGIvZHJpdmVycy9yZXNldC9yZXNldC10aS1zeXNj
b24uYw0KPiA+Pj4+PiBAQCAtMTUsNiArMTUsNyBAQA0KPiA+Pj4+PiAgICogR05VIEdlbmVyYWwg
UHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4NCj4gPj4+Pj4gICAqLw0KPiA+Pj4+PiAg
DQo+ID4+Pj4+ICsjaW5jbHVkZSA8bGludXgvZGVsYXkuaD4NCj4gPj4+Pj4gICNpbmNsdWRlIDxs
aW51eC9tZmQvc3lzY29uLmg+DQo+ID4+Pj4+ICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+
ID4+Pj4+ICAjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4gPj4+Pj4gQEAgLTU2LDYgKzU3LDcgQEAg
c3RydWN0IHRpX3N5c2Nvbl9yZXNldF9kYXRhIHsNCj4gPj4+Pj4gIAlzdHJ1Y3QgcmVnbWFwICpy
ZWdtYXA7DQo+ID4+Pj4+ICAJc3RydWN0IHRpX3N5c2Nvbl9yZXNldF9jb250cm9sICpjb250cm9s
czsNCj4gPj4+Pj4gIAl1bnNpZ25lZCBpbnQgbnJfY29udHJvbHM7DQo+ID4+Pj4+ICsJdW5zaWdu
ZWQgaW50IHJlc2V0X2R1cmF0aW9uX3VzOw0KPiA+Pj4+PiAgfTsNCj4gPj4+Pj4gIA0KPiA+Pj4+
PiAgI2RlZmluZSB0b190aV9zeXNjb25fcmVzZXRfZGF0YShyY2RldikJXA0KPiA+Pj4+PiBAQCAt
ODksNyArOTEsNyBAQCBzdGF0aWMgaW50IHRpX3N5c2Nvbl9yZXNldF9hc3NlcnQoc3RydWN0IHJl
c2V0X2NvbnRyb2xsZXJfZGV2ICpyY2RldiwNCj4gPj4+Pj4gIAltYXNrID0gQklUKGNvbnRyb2wt
PmFzc2VydF9iaXQpOw0KPiA+Pj4+PiAgCXZhbHVlID0gKGNvbnRyb2wtPmZsYWdzICYgQVNTRVJU
X1NFVCkgPyBtYXNrIDogMHgwOw0KPiA+Pj4+PiAgDQo+ID4+Pj4+IC0JcmV0dXJuIHJlZ21hcF91
cGRhdGVfYml0cyhkYXRhLT5yZWdtYXAsIGNvbnRyb2wtPmFzc2VydF9vZmZzZXQsIG1hc2ssIHZh
bHVlKTsNCj4gPj4+Pj4gKwlyZXR1cm4gcmVnbWFwX3dyaXRlX2JpdHMoZGF0YS0+cmVnbWFwLCBj
b250cm9sLT5hc3NlcnRfb2Zmc2V0LCBtYXNrLCB2YWx1ZSk7DQo+ID4+Pj4+ICB9DQo+ID4+Pj4+
ICANCj4gPj4+Pj4gIC8qKg0KPiA+Pj4+PiBAQCAtMTIwLDcgKzEyMiw3IEBAIHN0YXRpYyBpbnQg
dGlfc3lzY29uX3Jlc2V0X2RlYXNzZXJ0KHN0cnVjdCByZXNldF9jb250cm9sbGVyX2RldiAqcmNk
ZXYsDQo+ID4+Pj4+ICAJbWFzayA9IEJJVChjb250cm9sLT5kZWFzc2VydF9iaXQpOw0KPiA+Pj4+
PiAgCXZhbHVlID0gKGNvbnRyb2wtPmZsYWdzICYgREVBU1NFUlRfU0VUKSA/IG1hc2sgOiAweDA7
DQo+ID4+Pj4+ICANCj4gPj4+Pj4gLQlyZXR1cm4gcmVnbWFwX3VwZGF0ZV9iaXRzKGRhdGEtPnJl
Z21hcCwgY29udHJvbC0+ZGVhc3NlcnRfb2Zmc2V0LCBtYXNrLCB2YWx1ZSk7DQo+ID4+Pj4+ICsJ
cmV0dXJuIHJlZ21hcF93cml0ZV9iaXRzKGRhdGEtPnJlZ21hcCwgY29udHJvbC0+ZGVhc3NlcnRf
b2Zmc2V0LCBtYXNrLCB2YWx1ZSk7DQo+ID4+Pj4+ICB9DQo+ID4+Pj4+ICANCj4gPj4+Pj4gIC8q
Kg0KPiA+Pj4+PiBAQCAtMTU4LDkgKzE2MCwyNiBAQCBzdGF0aWMgaW50IHRpX3N5c2Nvbl9yZXNl
dF9zdGF0dXMoc3RydWN0IHJlc2V0X2NvbnRyb2xsZXJfZGV2ICpyY2RldiwNCj4gPj4+Pj4gIAkJ
IShjb250cm9sLT5mbGFncyAmIFNUQVRVU19TRVQpOw0KPiA+Pj4+PiAgfQ0KPiA+Pj4+PiAgDQo+
ID4+Pj4+ICtzdGF0aWMgaW50IHRpX3N5c2Nvbl9yZXNldChzdHJ1Y3QgcmVzZXRfY29udHJvbGxl
cl9kZXYgKnJjZGV2LA0KPiA+Pj4+PiArCQkJCSAgdW5zaWduZWQgbG9uZyBpZCkNCj4gPj4+Pj4g
K3sNCj4gPj4+Pj4gKwlzdHJ1Y3QgdGlfc3lzY29uX3Jlc2V0X2RhdGEgKmRhdGEgPSB0b190aV9z
eXNjb25fcmVzZXRfZGF0YShyY2Rldik7DQo+ID4+Pj4+ICsJaW50IHJldDsNCj4gPj4+Pj4gKw0K
PiA+Pj4+PiArCXJldCA9IHRpX3N5c2Nvbl9yZXNldF9hc3NlcnQocmNkZXYsIGlkKTsNCj4gPj4+
Pj4gKwlpZiAocmV0KQ0KPiA+Pj4+PiArCQlyZXR1cm4gcmV0Ow0KPiA+Pj4+PiArDQo+ID4+Pj4+
ICsJaWYgKGRhdGEtPnJlc2V0X2R1cmF0aW9uX3VzKQ0KPiA+Pj4+PiArCQl1c2xlZXBfcmFuZ2Uo
ZGF0YS0+cmVzZXRfZHVyYXRpb25fdXMsIGRhdGEtPnJlc2V0X2R1cmF0aW9uX3VzICogMik7DQo+
ID4+Pj4+ICsNCj4gPj4+Pj4gKwlyZXR1cm4gdGlfc3lzY29uX3Jlc2V0X2RlYXNzZXJ0KHJjZGV2
LCBpZCk7DQo+ID4+Pj4NCj4gPj4+PiBJIGVjaG8gUGhpbGlwcCdzIGNvbW1lbnRzIFsxXSBmcm9t
IHlvdXIgb3JpZ2luYWwgdjEgc2VyaWVzIGFib3V0IHRoaXMuIFdlIGRvbid0DQo+ID4+Pj4gbmVl
ZCBhIHByb3BlcnR5IHRvIGRpc3Rpbmd1aXNoIHRoaXMsIGJ1dCB5b3UgY291bGQgYWRkIGEgZmxh
ZyB1c2luZyBtYXRjaCBkYXRhDQo+ID4+Pj4gYW5kIE1lZGlhdGVrIGNvbXBhdGlibGUsIGFuZCB1
c2UgdGhhdCB3aXRoaW4gdGhpcyBmdW5jdGlvbiwgb3Igb3B0aW9uYWxseSBzZXQNCj4gPj4+PiB0
aGlzIG9wcyBiYXNlZCBvbiBjb21wYXRpYmxlICh3aGF0ZXZlciBpcyBwcmVmZXJyZWQgYnkgUGhp
bGlwcCkuDQo+ID4+Pj4NCj4gPj4+PiByZWdhcmRzDQo+ID4+Pj4gU3VtYW4NCj4gPj4+Pg0KPiA+
Pj4+IFsxXSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL2NvbW1lbnQvMjM1MTkxOTMvDQo+
ID4+Pj4NCj4gPj4+IEhpIFN1bWFuLCBQaGlsaXBwDQo+ID4+Pg0KPiA+Pj4gV2hpY2ggbWV0aG9k
IHdvdWxkIHlvdSByZWNvbW1lbmQgbW9yZT8NCj4gPj4+IDEuIGxpa2UgdjIgcGF0Y2gsIGJ1dCBh
c3NpZ24gdGhlIGZsYWcgImRhdGEtPmFzc2VydF9kZWFzc2VydF90b2dldGhlciINCj4gPj4+IGRp
cmVjdGx5IChtYXliZSByZW5hbWUgImFzc2VydF9kZWFzc2VydF90b2dldGhlciIgdG8NCj4gPj4+
ICJyZXNldF9vcF9hdmFpbGFibGUiKQ0KPiA+Pj4NCj4gPj4+IDIuIHVzZSBNZWRpYXRlayBjb21w
YXRpYmxlIHRvIGRlY2lkZSB0aGUgcmVzZXQgaGFuZGxlciBhdmFpbGFibGUgb3Igbm90Lg0KPiA+
Pg0KPiA+PiBJIHdvdWxkIGdvIHdpdGggdGhpcyBvcHRpb24uIEFueXdheSwgSSB0aGluayB5b3Ug
bWlnaHQgaGF2ZSB0byBhZGQgdGhlIHJlc2V0IFNvQw0KPiA+PiBkYXRhIGFzIHdlbGwsIGJhc2Vk
IG9uIFJvYidzIGNvbW1lbnQgb24gdGhlIGJpbmRpbmcuDQo+ID4+DQo+ID4+IHJlZ2FyZHMNCj4g
Pj4gU3VtYW4NCj4gPiANCj4gPiANCj4gPiBUaGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlvbnMNCj4g
PiBJIHdpbGwgYWRkIHRoZSBmb2xsb3dpbmcgY2hhbmdlcyBpbiB0aGUgbmV4dCB2ZXJzaW9uLCAN
Cj4gPiBwbGVhc2UgY29ycmVjdCBtZSBpZiB0aGVyZSBpcyBhbnkgbWlzdW5kZXJzdGFuZGluZy4N
Cj4gPiAxKS4gcmV2ZXJ0IHRpLXN5c2Nvbi1yZXNldC50eHQgYWRkIGEgbmV3IG1lZGlhdGVrIHJl
c2V0IGJpbmRpbmcgZG9jLg0KPiA+IDIpLiBzcGxpdCB0aGUgcGF0Y2ggW3Y0LDMvNF0gd2l0aCB0
aGUgY2hhbmdlIGZvciB0aGUNCj4gPiByZWdtYXBfdXBkYXRlX2JpdHMoKSB0byByZWdtYXBfd3Jp
dGVfYml0cygpIGFuZCB0aGUgY2hhbmdlIHRvIGludGVncmF0ZQ0KPiA+IGFzc2VydCBhbmQgZGVh
c3NlcnQgdG9nZXRoZXIuDQo+ID4gMykuIGFkZCB0aGUgcmVzZXQgU29DIGRhdGEsIHdoaWNoIGNv
bnRhaW5zIHRoZSBmbGFnICJyZXNldF9vcF9hdmFpbGFibGUiDQo+ID4gdG8gZGVjaWRlIHRoZSBy
ZXNldCBoYW5kbGVyIGF2YWlsYWJsZSBvciBub3QuDQo+IA0KPiBZb3Ugd291bGQgYWxzbyBuZWVk
IHRvIGFkZCB5b3VyIFNvQy1zcGVjaWZpYyBkYXRhIGVxdWl2YWxlbnQgb2YgdGhlIGN1cnJlbnQN
Cj4gdGkscmVzZXQtYml0cyBpbiB5b3VyIGluZnJhIG5vZGUuIFBsZWFzZSBzZWUgUm9iJ3MgY29t
bWVudHMgb24gcGF0Y2ggMi4gQWxzbywNCj4geW91ciBuZXcgTWVkaWF0ZWsgYmluZGluZyBzaG91
bGQgYmUgaW4gWUFNTCBmb3JtYXQuDQo+IA0KPiByZWdhcmRzDQo+IFN1bWFuDQo+IA0KDQpTaG91
bGQgSSBhZGQgdGhlIFNvQy1zcGVjaWZpYyBkYXRhIGFzIGZvbGxvd3M/DQpUaGlzIG1heSBhbHNv
IG1vZGlmeSB0aGUgdGkgb3JpZ2luYWwgY29kZSwgaXMgaXQgT0s/DQoNCisgICAgICAgZGF0YS0+
cmVzZXRfZGF0YSA9IG9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YSgmcGRldi0+ZGV2KTsNCisNCisg
ICAgICAgbGlzdCA9IG9mX2dldF9wcm9wZXJ0eShucCwgZGF0YS0+cmVzZXRfZGF0YS0+cmVzZXRf
Yml0cywgJnNpemUpOw0KDQorc3RhdGljIGNvbnN0IHN0cnVjdCBjb21tb25fcmVzZXRfZGF0YSB0
aV9yZXNldF9kYXRhID0gew0KKyAgICAgICAucmVzZXRfb3BfYXZhaWxhYmxlID0gZmFsc2UsDQor
ICAgICAgIC5yZXNldF9iaXRzID0gInRpLCByZXNldC1iaXRzIiwNCit9Ow0KKw0KK3N0YXRpYyBj
b25zdCBzdHJ1Y3QgY29tbW9uX3Jlc2V0X2RhdGEgbWVkaWF0ZWtfcmVzZXRfZGF0YSA9IHsNCisg
ICAgICAgLnJlc2V0X29wX2F2YWlsYWJsZSA9IHRydWUsDQorICAgICAgIC5yZXNldF9iaXRzID0g
Im1lZGlhdGVrLCByZXNldC1iaXRzIiwNCit9Ow0KKw0KIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2Zf
ZGV2aWNlX2lkIHRpX3N5c2Nvbl9yZXNldF9vZl9tYXRjaFtdID0gew0KLSAgICAgICB7IC5jb21w
YXRpYmxlID0gInRpLHN5c2Nvbi1yZXNldCIsIH0sDQorICAgICAgIHsgLmNvbXBhdGlibGUgPSAi
dGksc3lzY29uLXJlc2V0IiwgLmRhdGEgPSAmdGlfcmVzZXRfZGF0YX0sDQorICAgICAgIHsgLmNv
bXBhdGlibGUgPSAibWVkaWF0ZWssc3lzY29uLXJlc2V0IiwgLmRhdGEgPQ0KJm1lZGlhdGVrX3Jl
c2V0X2RhdGF9LA0KICAgICAgICB7IC8qIHNlbnRpbmVsICovIH0sDQogfTsNCg0KVGhhbmtzDQpD
cnlzdGFsDQoNCj4gPiA0KS4gc2VwYXJhdGUgdGhlIGR0cyBwYXRjaCBmcm9tIHRoaXMgcGF0Y2gg
c2V0cw0KPiA+IA0KPiA+Pj4NCj4gPj4+IFRoYW5rcw0KPiA+Pj4gQ3J5c3RhbA0KPiA+Pj4NCj4g
Pj4+Pj4gK30NCj4gPj4+Pj4gKw0KPiA+Pj4+PiAgc3RhdGljIGNvbnN0IHN0cnVjdCByZXNldF9j
b250cm9sX29wcyB0aV9zeXNjb25fcmVzZXRfb3BzID0gew0KPiA+Pj4+PiAgCS5hc3NlcnQJCT0g
dGlfc3lzY29uX3Jlc2V0X2Fzc2VydCwNCj4gPj4+Pj4gIAkuZGVhc3NlcnQJPSB0aV9zeXNjb25f
cmVzZXRfZGVhc3NlcnQsDQo+ID4+Pj4+ICsJLnJlc2V0CQk9IHRpX3N5c2Nvbl9yZXNldCwNCj4g
Pj4+Pj4gIAkuc3RhdHVzCQk9IHRpX3N5c2Nvbl9yZXNldF9zdGF0dXMsDQo+ID4+Pj4+ICB9Ow0K
PiA+Pj4+PiAgDQo+ID4+Pj4+IEBAIC0yMDQsNiArMjIzLDkgQEAgc3RhdGljIGludCB0aV9zeXNj
b25fcmVzZXRfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPj4+Pj4gIAkJ
Y29udHJvbHNbaV0uZmxhZ3MgPSBiZTMyX3RvX2NwdXAobGlzdCsrKTsNCj4gPj4+Pj4gIAl9DQo+
ID4+Pj4+ICANCj4gPj4+Pj4gKwlvZl9wcm9wZXJ0eV9yZWFkX3UzMihwZGV2LT5kZXYub2Zfbm9k
ZSwJInJlc2V0LWR1cmF0aW9uLXVzIiwNCj4gPj4+Pj4gKwkJCQkmZGF0YS0+cmVzZXRfZHVyYXRp
b25fdXMpOw0KPiA+Pj4+PiArDQo+ID4+Pj4+ICAJZGF0YS0+cmNkZXYub3BzID0gJnRpX3N5c2Nv
bl9yZXNldF9vcHM7DQo+ID4+Pj4+ICAJZGF0YS0+cmNkZXYub3duZXIgPSBUSElTX01PRFVMRTsN
Cj4gPj4+Pj4gIAlkYXRhLT5yY2Rldi5vZl9ub2RlID0gbnA7DQo+ID4+Pj4+DQo+ID4+Pj4NCj4g
Pj4+DQo+ID4+DQo+ID4gDQo+IA0KDQo=

