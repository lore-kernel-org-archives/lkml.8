Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FA4C33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 02:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5688A24655
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 02:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LtKA1lMx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgAVCXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 21:23:31 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:6613 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726396AbgAVCXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 21:23:31 -0500
X-UUID: fcdbaeb53caa4f408e399eefad8415ba-20200122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=lN1pViJIxLnb7UBsGaWmhhbnVEIdvsVPgiy5VY3Xy3Y=;
        b=LtKA1lMx97XZv7UIK/nq3aXN6POHNFlSHf3A7TTdcuW53AvGsKjbFpJEoPrSNgOuqo7CkhKXhjyuQwFwPIM8LR6YdNs7wUiiKeV6mbdOKLiJA+v6jZKNeNe5809//Ml3vVA3iiTKVmagLo7lY35gzm11O1erNmOkMo1IRD9v+VM=;
X-UUID: fcdbaeb53caa4f408e399eefad8415ba-20200122
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <wen.su@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 861552407; Wed, 22 Jan 2020 10:23:27 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 22 Jan 2020 10:22:53 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 22 Jan 2020 10:22:09 +0800
Message-ID: <1579659806.6612.12.camel@mtkswgap22>
Subject: Re: [RESEND 3/4] regulator: mt6359: Add support for MT6359 regulator
From:   Wen Su <Wen.Su@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Wed, 22 Jan 2020 10:23:26 +0800
In-Reply-To: <20200120190427.GO6852@sirena.org.uk>
References: <1579506450-21830-1-git-send-email-Wen.Su@mediatek.com>
         <1579506450-21830-4-git-send-email-Wen.Su@mediatek.com>
         <20200120190427.GO6852@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyaywNCg0KT24gTW9uLCAyMDIwLTAxLTIwIGF0IDE5OjA0ICswMDAwLCBNYXJrIEJyb3du
IHdyb3RlOg0KPiBPbiBNb24sIEphbiAyMCwgMjAyMCBhdCAwMzo0NzoyOVBNICswODAwLCBXZW4g
U3Ugd3JvdGU6DQo+IA0KPiBUaGlzIHNlZW1zIHByZXR0eSBnb29kLCBhIGZldyBjb21tZW50cyBi
ZWxvdyBidXQgdGhleSdyZSBmYWlybHkgc21hbGwNCj4gYW5kIHNob3VsZCBiZSBlYXN5IHRvIGFk
ZHJlc3M6DQo+IA0KPiA+ICtzdGF0aWMgaW50IG10NjM1OV9zZXRfdm9sdGFnZV9zZWwoc3RydWN0
IHJlZ3VsYXRvcl9kZXYgKnJkZXYsDQo+ID4gKwkJCQkgIHVuc2lnbmVkIGludCBzZWxlY3RvcikN
Cj4gPiArew0KPiA+ICsJaW50IGlkeCwgcmV0Ow0KPiA+ICsJY29uc3QgdTMyICpwdm9sOw0KPiA+
ICsJc3RydWN0IG10NjM1OV9yZWd1bGF0b3JfaW5mbyAqaW5mbyA9IHJkZXZfZ2V0X2RydmRhdGEo
cmRldik7DQo+ID4gKw0KPiA+ICsJcHZvbCA9IGluZm8tPmluZGV4X3RhYmxlOw0KPiA+ICsNCj4g
PiArCWlkeCA9IHB2b2xbc2VsZWN0b3JdOw0KPiA+ICsJcmV0ID0gcmVnbWFwX3VwZGF0ZV9iaXRz
KHJkZXYtPnJlZ21hcCwgaW5mby0+ZGVzYy52c2VsX3JlZywNCj4gPiArCQkJCSBpbmZvLT5kZXNj
LnZzZWxfbWFzaywNCj4gPiArCQkJCSBpZHggPDwgaW5mby0+dnNlbF9zaGlmdCk7DQo+ID4gKw0K
PiA+ICsJcmV0dXJuIHJldDsNCj4gPiArfQ0KPiANCj4gVGhpcyBsb29rcyBsaWtlIHlvdSBzaG91
bGQgYmUgdXNpbmcgcmVndWxhdG9yX2xpc3Rfdm9sdGFnZV90YWJsZSgpIGFuZA0KPiBhc3NvY2lh
dGVkIGZ1bmN0aW9ucywgcHJvYmFibHkgbWFwX3ZvbHRhZ2VfYXNjZW5kKCkgb3IgX2l0ZXJhdGUo
KSBhbmQNCj4ganVzdCBhIHNpbXBsZSBzZXRfdm9sdGFnZV9zZWxfcmVnbWFwKCkuDQpUaGFua3Mg
Zm9yIHlvdXIgc3VnZ2VzdGlvbi4NCkN1cnJlbnRseSBpdCdzIHVzaW5nIHJlZ3VsYXRvcl9saXN0
X3ZvbHRhZ2VfdGFibGUoKSBhbmQNCnJlZ3VsYXRvcl9tYXBfdm9sdGFnZV9pdGVyYXRlKCkgYXMg
YmVsb3c6DQoNCnN0YXRpYyBjb25zdCBzdHJ1Y3QgcmVndWxhdG9yX29wcyBtdDYzNTlfdm9sdF90
YWJsZV9vcHMgPSB7DQoJLmxpc3Rfdm9sdGFnZSA9IHJlZ3VsYXRvcl9saXN0X3ZvbHRhZ2VfdGFi
bGUsDQoJLm1hcF92b2x0YWdlID0gcmVndWxhdG9yX21hcF92b2x0YWdlX2l0ZXJhdGUsDQoJLi4u
DQpUaGUgcmVhc29uIHRvIHVzZSBtdDYzNTlfc2V0X3ZvbHRhZ2Vfc2VsKCkgaXMgdG8gY29udmVy
dCBzZWxlY3RvciB2YWx1ZQ0KdG8gaGFyZHdhcmUgcmVnaXN0ZXIgaW5kZXggdmFsdWU6DQoJaWR4
ID0gcHZvbFtzZWxlY3Rvcl07DQoNClRvIGF2b2lkIHVzaW5nIG10NjM1OV9zZXRfdm9sdGFnZV9z
ZWwoKSwgdGhlICpfdm9sdGFnZXMgYXJyYXkgbmVlZCB0byBiZQ0KZmlsbGVkIHdpdGggemVyb3Mg
YXMgYmVsb3c6IA0KQ3VycmVudDoNCnN0YXRpYyBjb25zdCB1MzIgdmVtY192b2x0YWdlc1tdID0g
ew0KCTI5MDAwMDAsIDMwMDAwMDAsIDMzMDAwMDAsDQp9Ow0Kc3RhdGljIGNvbnN0IHUzMiB2ZW1j
X2lkeFtdID0gew0KCTEwLCAxMSwgMTMsDQp9Ow0KDQpjaGFuZ2UgdG86DQpzdGF0aWMgY29uc3Qg
dTMyIHZ4bzIyX3ZvbHRhZ2VzW10gPSB7DQoJMCwgMCwgMCwgMCwgMCwgMCwgMCwgMCwgMCwgMCwg
MjkwMDAwMCwgMzAwMDAwMCwgMCwgMzMwMDAwMCwNCn07DQo+IA0KPiA+ICtzdGF0aWMgaW50IG10
NjM1OV9nZXRfc3RhdHVzKHN0cnVjdCByZWd1bGF0b3JfZGV2ICpyZGV2KQ0KPiA+ICt7DQo+ID4g
KwlpbnQgcmV0Ow0KPiA+ICsJdTMyIHJlZ3ZhbDsNCj4gPiArCXN0cnVjdCBtdDYzNTlfcmVndWxh
dG9yX2luZm8gKmluZm8gPSByZGV2X2dldF9kcnZkYXRhKHJkZXYpOw0KPiA+ICsNCj4gPiArCXJl
dCA9IHJlZ21hcF9yZWFkKHJkZXYtPnJlZ21hcCwgaW5mby0+c3RhdHVzX3JlZywgJnJlZ3ZhbCk7
DQo+ID4gKwlpZiAocmV0ICE9IDApIHsNCj4gPiArCQlkZXZfZXJyKCZyZGV2LT5kZXYsICJGYWls
ZWQgdG8gZ2V0IGVuYWJsZSByZWc6ICVkXG4iLCByZXQpOw0KPiA+ICsJCXJldHVybiByZXQ7DQo+
ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0dXJuIChyZWd2YWwgJiBpbmZvLT5xaSkgPyBSRUdVTEFU
T1JfU1RBVFVTX09OIDogUkVHVUxBVE9SX1NUQVRVU19PRkY7DQpUaGFua3MgZm9yIHlvdXIgc3Vn
Z2VzdGlvbi4NCkkgd2lsbCB1cGRhdGUgaXQgaW4gdGhlIG5leHQgcGF0Y2guDQo+IA0KPiBQbGVh
c2Ugd3JpdGUgbm9ybWFsIGNvbmRpdGlvbmwgc3RhdGVtZW50cyByYXRoZXIgdGhhbiB1c2luZyB0
aGUgdGVybmVyeQ0KPiBvcGVyYXRvciB0byBpbXByb3ZlIGxlZ2liaWxpdHkuDQo+IA0KPiA+ICsJ
c3dpdGNoIChtb2RlKSB7DQo+ID4gKwljYXNlIFJFR1VMQVRPUl9NT0RFX0ZBU1Q6DQo+ID4gKwkJ
aWYgKGN1cnJfbW9kZSA9PSBSRUdVTEFUT1JfTU9ERV9JRExFKSB7DQo+ID4gKwkJCVdBUk5fT04o
MSk7DQo+ID4gKwkJCWRldl9ub3RpY2UoJnJkZXYtPmRldiwNCj4gPiArCQkJCSAgICJCVUNLICVz
IGlzIExQIG1vZGUsIGNhbid0IEZQV01cbiIsDQo+ID4gKwkJCQkgICByZGV2LT5kZXNjLT5uYW1l
KTsNCj4gPiArCQkJcmV0dXJuIC1FSU87DQo+IA0KPiBJJ2QgZXhwZWN0IHRoZSBkZXZpY2UgdG8g
Z28gb3V0IG9mIGxvdyBwb3dlciBtb2RlIHRoZW4gaW50byBmb3JjZSBQV00NCj4gbW9kZSBpZiBp
dCBoYXMgdG8gZG8gdGhhdCByYXRoZXIgdGhhbiByZWplY3QgdGhlIG9wZXJhdGlvbi4NClRoZSBk
ZXZpY2UgbG93IHBvd2VyIG1vZGUgbWF5IGNvbnRyb2wgYnkgaGFyZHdhcmUgcGFkLCBzbyB0aGF0
IHRoZQ0KcmVhc29uIHRvIHJlamVjdCB0aGUgb3BlcmF0aW9uIGlzIHRoZSBkZXZpY2UgbG93IHBv
d2VyIG1vZGUgY2FuIG5vdCBnbw0Kb3V0IGJ5IHNvZnR3YXJlLg0KQW5vdGhlciBzY2VuYXJpbyBp
cyBvbmUgdXNlciBzZXQgdGhlIGRldmljZSB0byBsb3cgcG93ZXIgbW9kZSwgd2UgdGhpbmsNCml0
J3Mgbm90IHN1aXRhYmxlIHRvIGNoYW5nZSBkZXZpY2UgbW9kZSB0byBfRkFTVCBtb2RlIGJ5IGFu
b3RoZXIgdXNlci4NCg0K

