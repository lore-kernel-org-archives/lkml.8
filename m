Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0441C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7532B21582
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="jxgt4+g0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgBEAsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 19:48:08 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:56457 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbgBEAsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 19:48:07 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 04CF5891AC;
        Wed,  5 Feb 2020 13:48:02 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1580863682;
        bh=YxaM9B6U71dDZTqUpdY/y2wYP3mw7nippBqDGx1ZrZ0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=jxgt4+g0doCZav7KWHwLXeamBho/5GnGJACwvuIs8EFh0kzyYz3t4J7+ni1fcIU6f
         k/Sj/Ghx8PcnaarY5bGjyTgP6xFTb9wg/QXIDdQCuhH3B+JOEhgBYaWNbszcaGTvUE
         M5Z7GAuoLIj+WiXyDgOZ5ppZdvjaLHOq/aD+qyG87aOGotV8yQRiITCQ8P+4F1MHU7
         Qrg8HyapjCB1/4YnC5upNPaABbUeYUT27Dz7FJgys7EssFPMo8VOIiIpYbJ9M+iefC
         fdp/oQ4vb1DmSvQ8+TgYe9EuEWALzrj1YyC1owzepMTIRV9WlzsFthEqajh2scTr8S
         fSsyHan82hzbg==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e3a10c20001>; Wed, 05 Feb 2020 13:48:02 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 5 Feb 2020 13:48:02 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1473.005; Wed, 5 Feb 2020 13:48:02 +1300
From:   Logan Shaw <Logan.Shaw@alliedtelesis.co.nz>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joshua Scott <Joshua.Scott@alliedtelesis.co.nz>,
        Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] dt-bindings: hwmon: (adt7475) Added missing
 adt7475 documentation
Thread-Topic: [PATCH v6 2/2] dt-bindings: hwmon: (adt7475) Added missing
 adt7475 documentation
Thread-Index: AQHV1JVtwGwHv/A/qEeLHCGfFZLcOaf9zzQAgAPiowCACUbkAA==
Date:   Wed, 5 Feb 2020 00:48:01 +0000
Message-ID: <a3c4d78c7c454287aea91f70fa8de1f259561cc0.camel@alliedtelesis.co.nz>
References: <20200126221014.2978-1-logan.shaw@alliedtelesis.co.nz>
         <20200126221014.2978-3-logan.shaw@alliedtelesis.co.nz>
         <20200127154800.GA7023@bogus>
         <9d4afb3f77e1dea7f050fe32616ca955fb95eaa9.camel@alliedtelesis.co.nz>
In-Reply-To: <9d4afb3f77e1dea7f050fe32616ca955fb95eaa9.camel@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:25:ae22:bff:fe77:dd09]
Content-Type: text/plain; charset="utf-8"
Content-ID: <49912492BB4A4C458AE04DAF57CD5D57@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SnVzdCBhIGdlbnRsZSByZW1pbmRlciBhcyB0aGlzIHRocmVhZCBoYXMgYmVlbiBxdWlldCBmb3Ig
YSB3aGlsZS4gUm9iLA0KSSB3b3VsZCBhcHByZWNpYXRlIHNvbWUgZmVlZGJhY2sgb24gbXkgcXVl
c3Rpb24gZnJvbSBteSBwcmV2aW91cyBlbWFpbC4gDQoNClRvIGFkZCBhIGxpdHRsZSBtb3JlIGRl
dGFpbDogSSB3YW50IHRvIGF2b2lkIHNpbXBseSBjaGVja2luZyBmb3IgdGhlDQpleGlzdGVuY2Ug
b2YgYSBwcm9wZXJ0eSBpbiB0aGUgRFRTIGFzIHRoYXQgY291bGQgYnJlYWsgY29tcGF0aWJpbGl0
eQ0Kd2l0aCBjb2RlYmFzZXMgaW1wbGVtZW50aW5nIHRoZWlyIG93biBtZXRob2Qgb2YgaGFuZGxp
bmcgdGhlIGF0dGVudWF0b3INCmJ5cGFzcy4NCg0KT24gVGh1LCAyMDIwLTAxLTMwIGF0IDAzOjA3
ICswMDAwLCBMb2dhbiBTaGF3IHdyb3RlOg0KPiBPbiBNb24sIDIwMjAtMDEtMjcgYXQgMDk6NDgg
LTA2MDAsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiA+IE9uIE1vbiwgSmFuIDI3LCAyMDIwIGF0IDEx
OjEwOjE0QU0gKzEzMDAsIExvZ2FuIFNoYXcgd3JvdGU6DQo+ID4gPiBBZGRlZCBhIG5ldyBmaWxl
IGRvY3VtZW50aW5nIHRoZSBhZHQ3NDc1IGRldmljZXRyZWUgYW5kIGFkZGVkIHRoZQ0KPiA+ID4g
Zm91cg0KPiA+ID4gbmV3IHByb3BlcnRpZXMgdG8gaXQuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1v
ZmYtYnk6IExvZ2FuIFNoYXcgPGxvZ2FuLnNoYXdAYWxsaWVkdGVsZXNpcy5jby5uej4NCj4gPiA+
IC0tLQ0KPiA+ID4gLS0tDQo+ID4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvaHdtb24vYWR0
NzQ3NS55YW1sICAgIHwgOTUNCj4gPiA+ICsrKysrKysrKysrKysrKysrKysNCj4gPiA+ICAxIGZp
bGUgY2hhbmdlZCwgOTUgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0K
PiA+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2h3bW9uL2FkdDc0NzUueWFt
bA0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2h3bW9uL2FkdDc0NzUueWFtbA0KPiA+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvaHdtb24vYWR0NzQ3NS55YW1sDQo+ID4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0
NA0KPiA+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi40NTBkYTVlNjZlMDcNCj4gPiA+IC0tLSAvZGV2
L251bGwNCj4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9od21v
bi9hZHQ3NDc1LnlhbWwNCj4gPiA+IEBAIC0wLDAgKzEsOTUgQEANCj4gPiA+ICsjIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ID4gDQo+ID4gRHVhbCBsaWNlbnNlIG5ldyBiaW5k
aW5ncyBwbGVhc2U6DQo+ID4gDQo+ID4gKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+
ID4gDQo+ID4gPiArJVlBTUwgMS4yDQo+ID4gPiArLS0tDQo+ID4gPiArJGlkOiBodHRwOi8vZGV2
aWNldHJlZS5vcmcvc2NoZW1hcy9hZHQ3NDc1LnlhbWwjDQo+ID4gPiArJHNjaGVtYTogaHR0cDov
L2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4gPiArDQo+ID4gPiAr
dGl0bGU6IEFEVDc0NzUgaHdtb24gc2Vuc29yDQo+ID4gPiArDQo+ID4gPiArbWFpbnRhaW5lcnM6
DQo+ID4gPiArICAtIEplYW4gRGVsdmFyZSA8amRlbHZhcmVAc3VzZS5jb20+DQo+ID4gPiArDQo+
ID4gPiArZGVzY3JpcHRpb246IHwNCj4gPiA+ICsgIFRoZSBBRFQ3NDczLCBBRFQ3NDc1LCBBRFQ3
NDc2LCBhbmQgQURUNzQ5MCBhcmUgdGhlcm1hbA0KPiA+ID4gbW9uaXRvcnMNCj4gPiA+IGFuZCBt
dWx0aXBsZQ0KPiA+ID4gKyAgUFdOIGZhbiBjb250cm9sbGVycy4NCj4gPiA+ICsNCj4gPiA+ICsg
IFRoZXkgc3VwcG9ydCBtb25pdG9yaW5nIGFuZCBjb250cm9sbGluZyB1cCB0byBmb3VyIGZhbnMg
KHRoZQ0KPiA+ID4gQURUNzQ5MCBjYW4gb25seQ0KPiA+ID4gKyAgY29udHJvbCB1cCB0byB0aHJl
ZSkuIFRoZXkgc3VwcG9ydCByZWFkaW5nIGEgc2luZ2xlIG9uIGNoaXANCj4gPiA+IHRlbXBlcmF0
dXJlDQo+ID4gPiArICBzZW5zb3IgYW5kIHR3byBvZmYgY2hpcCB0ZW1wZXJhdHVyZSBzZW5zb3Jz
ICh0aGUgQURUNzQ5MA0KPiA+ID4gYWRkaXRpb25hbGx5DQo+ID4gPiArICBzdXBwb3J0cyBtZWFz
dXJpbmcgdXAgdG8gdGhyZWUgY3VycmVudCBleHRlcm5hbCB0ZW1wZXJhdHVyZQ0KPiA+ID4gc2Vu
c29ycyB3aXRoDQo+ID4gPiArICBzZXJpZXMgcmVzaXN0YW5jZSBjYW5jZWxsYXRpb24gKFNSQykp
Lg0KPiA+ID4gKw0KPiA+ID4gKyAgRGF0YXNoZWV0czoNCj4gPiA+ICsgIGh0dHBzOi8vd3d3Lm9u
c2VtaS5jb20vcHViL0NvbGxhdGVyYWwvQURUNzQ3My1ELlBERg0KPiA+ID4gKyAgaHR0cHM6Ly93
d3cub25zZW1pLmNvbS9wdWIvQ29sbGF0ZXJhbC9BRFQ3NDc1LUQuUERGDQo+ID4gPiArICBodHRw
czovL3d3dy5vbnNlbWkuY29tL3B1Yi9Db2xsYXRlcmFsL0FEVDc0NzYtRC5QREYNCj4gPiA+ICsg
IGh0dHBzOi8vd3d3Lm9uc2VtaS5jb20vcHViL0NvbGxhdGVyYWwvQURUNzQ5MC1ELlBERg0KPiA+
ID4gKw0KPiA+ID4gKyAgRGVzY3JpcHRpb24gdGFrZW4gZnJvbSBvbXNlbWljb25kdWN0b3JzIHNw
ZWNpZmljYXRpb24gc2hlZXRzLA0KPiA+ID4gd2l0aCBtaW5vcg0KPiA+IA0KPiA+IG9tc2VtaT8N
Cj4gPiAgXg0KPiA+IA0KPiA+ID4gKyAgcmVwaHJhc2luZy4NCj4gPiA+ICsNCj4gPiA+ICtwcm9w
ZXJ0aWVzOg0KPiA+ID4gKyAgY29tcGF0aWJsZToNCj4gPiA+ICsgICAgZW51bToNCj4gPiA+ICsg
ICAgICAtIGFkaSxhZHQ3NDczDQo+ID4gPiArICAgICAgLSBhZGksYWR0NzQ3NQ0KPiA+ID4gKyAg
ICAgIC0gYWRpLGFkdDc0NzYNCj4gPiA+ICsgICAgICAtIGFkaSxhZHQ3NDkwDQo+ID4gPiArDQo+
ID4gPiArICByZWc6DQo+ID4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gPiArDQo+ID4gPiArICBi
eXBhc3MtYXR0ZW51YXRvci1pbjA6DQo+ID4gDQo+ID4gTmVlZHMgYSB2ZW5kb3IgcHJlZml4IGFu
ZCBhIHR5cGUgcmVmLiANCj4gPiANCj4gPiA+ICsgICAgZGVzY3JpcHRpb246IHwNCj4gPiA+ICsg
ICAgICBDb25maWd1cmVzIGJ5cGFzc2luZyB0aGUgaW5kaXZpZHVhbCB2b2x0YWdlIGlucHV0DQo+
ID4gPiArICAgICAgYXR0ZW51YXRvciwgb24gaW4wLiBUaGlzIGlzIHN1cHBvcnRlZCBvbiB0aGUg
QURUNzQ3NiBhbmQNCj4gPiA+IEFEVDc0OTAuDQo+ID4gPiArICAgICAgSWYgc2V0IHRvIGEgbm9u
LXplcm8gaW50ZWdlciB0aGUgYXR0ZW51YXRvciBpcyBieXBhc3NlZCwNCj4gPiA+IGlmDQo+ID4g
PiBzZXQgdG8NCj4gPiA+ICsgICAgICB6ZXJvIHRoZSBhdHRlbnVhdG9yIGlzIG5vdCBieXBhc3Nl
ZC4gSWYgdGhlIHByb3BlcnR5IGlzDQo+ID4gPiBhYnNlbnQgdGhlbg0KPiA+ID4gKyAgICAgIHRo
ZSBjb25maWcgcmVnaXN0ZXIgaXMgbm90IG1vZGlmaWVkLg0KPiA+IA0KPiA+IFNvdW5kcyBsaWtl
IHRoaXMgY291bGQgYmUgYm9vbGVhbj8gSWYgbm90LCBkZWZpbmUgYSBzY2hlbWEgZm9yIHdoYXQN
Cj4gPiBhcmUgDQo+ID4gdmFsaWQgdmFsdWVzLg0KPiANCj4gQnkgYm9vbGVhbiBhcmUgeW91IHJl
ZmVycmluZyB0byBhIGR0cyBwcm9wZXJ0eSB0aGF0IGlzIGV2YWx1YXRlZA0KPiAodXNpbmcNCj4g
ZnVuY3Rpb24gb2ZfcHJvcGVydHlfcmVhZF9ib29sKSBhcyB0cnVlL2ZhbHNlLCBkZXBlbmRpbmcg
b24gaXRzDQo+IHByZXNlbmNlPyBGb3IgZXhhbXBsZSAicmVndWxhdG9yLWFsd2F5cy1vbiIgaW46
DQo+IC9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVndWxhdG9yL3JlZ3VsYXRv
ci55YW1sIC4NCj4gDQo+ID4gDQo+ID4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gPiArDQo+ID4g
PiArICBieXBhc3MtYXR0ZW51YXRvci1pbjE6DQo+ID4gPiArICAgIGRlc2NyaXB0aW9uOiB8DQo+
ID4gPiArICAgICAgQ29uZmlndXJlcyBieXBhc3NpbmcgdGhlIGluZGl2aWR1YWwgdm9sdGFnZSBp
bnB1dA0KPiA+ID4gKyAgICAgIGF0dGVudWF0b3IsIG9uIGluMS4gVGhpcyBpcyBzdXBwb3J0ZWQg
b24gdGhlIEFEVDc0NzMsDQo+ID4gPiBBRFQ3NDc1LA0KPiA+ID4gKyAgICAgIEFEVDc0NzYgYW5k
IEFEVDc0OTAuIElmIHNldCB0byBhIG5vbi16ZXJvIGludGVnZXIgdGhlDQo+ID4gPiBhdHRlbnVh
dG9yDQo+ID4gPiArICAgICAgaXMgYnlwYXNzZWQsIGlmIHNldCB0byB6ZXJvIHRoZSBhdHRlbnVh
dG9yIGlzIG5vdA0KPiA+ID4gYnlwYXNzZWQuDQo+ID4gPiBJZiB0aGUNCj4gPiA+ICsgICAgICBw
cm9wZXJ0eSBpcyBhYnNlbnQgdGhlbiB0aGUgY29uZmlnIHJlZ2lzdGVyIGlzIG5vdA0KPiA+ID4g
bW9kaWZpZWQuDQo+ID4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gPiArDQo+ID4gPiArICBieXBh
c3MtYXR0ZW51YXRvci1pbjM6DQo+ID4gPiArICAgIGRlc2NyaXB0aW9uOiB8DQo+ID4gPiArICAg
ICAgQ29uZmlndXJlcyBieXBhc3NpbmcgdGhlIGluZGl2aWR1YWwgdm9sdGFnZSBpbnB1dA0KPiA+
ID4gKyAgICAgIGF0dGVudWF0b3IsIG9uIGluMy4gVGhpcyBpcyBzdXBwb3J0ZWQgb24gdGhlIEFE
VDc0NzYgYW5kDQo+ID4gPiBBRFQ3NDkwLg0KPiA+ID4gKyAgICAgIElmIHNldCB0byBhIG5vbi16
ZXJvIGludGVnZXIgdGhlIGF0dGVudWF0b3IgaXMgYnlwYXNzZWQsDQo+ID4gPiBpZg0KPiA+ID4g
c2V0IHRvDQo+ID4gPiArICAgICAgemVybyB0aGUgYXR0ZW51YXRvciBpcyBub3QgYnlwYXNzZWQu
IElmIHRoZSBwcm9wZXJ0eSBpcw0KPiA+ID4gYWJzZW50IHRoZW4NCj4gPiA+ICsgICAgICB0aGUg
Y29uZmlnIHJlZ2lzdGVyIGlzIG5vdCBtb2RpZmllZC4NCj4gPiA+ICsgICAgbWF4SXRlbXM6IDEN
Cj4gPiA+ICsNCj4gPiA+ICsgIGJ5cGFzcy1hdHRlbnVhdG9yLWluNDoNCj4gPiANCj4gPiBUaGVz
ZSA0IGNvdWxkIGJlIGEgc2luZ2xlIGVudHJ5IHVuZGVyIHBhdHRlcm5Qcm9wZXJ0aWVzLg0KPiA+
IA0KPiA+IA0KPiA+ID4gKyAgICBkZXNjcmlwdGlvbjogfA0KPiA+ID4gKyAgICAgIENvbmZpZ3Vy
ZXMgYnlwYXNzaW5nIHRoZSBpbmRpdmlkdWFsIHZvbHRhZ2UgaW5wdXQNCj4gPiA+ICsgICAgICBh
dHRlbnVhdG9yLCBvbiBpbjQuIFRoaXMgaXMgc3VwcG9ydGVkIG9uIHRoZSBBRFQ3NDc2IGFuZA0K
PiA+ID4gQURUNzQ5MC4NCj4gPiA+ICsgICAgICBJZiBzZXQgdG8gYSBub24temVybyBpbnRlZ2Vy
IHRoZSBhdHRlbnVhdG9yIGlzIGJ5cGFzc2VkLA0KPiA+ID4gaWYNCj4gPiA+IHNldCB0bw0KPiA+
ID4gKyAgICAgIHplcm8gdGhlIGF0dGVudWF0b3IgaXMgbm90IGJ5cGFzc2VkLiBJZiB0aGUgcHJv
cGVydHkgaXMNCj4gPiA+IGFic2VudCB0aGVuDQo+ID4gPiArICAgICAgdGhlIGNvbmZpZyByZWdp
c3RlciBpcyBub3QgbW9kaWZpZWQuDQo+ID4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gPiArDQo+
ID4gPiArcmVxdWlyZWQ6DQo+ID4gPiArICAtIGNvbXBhdGlibGUNCj4gPiA+ICsgIC0gcmVnDQo+
ID4gPiArDQo+ID4gPiArZXhhbXBsZXM6DQo+ID4gPiArICAtIHwNCj4gPiA+ICsgICAgaTJjIHsN
Cj4gPiA+ICsgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gPiA+ICsgICAgICAjc2l6ZS1j
ZWxscyA9IDwwPjsNCj4gPiA+ICsNCj4gPiA+ICsgICAgICBod21vbkAyZSB7DQo+ID4gPiArICAg
ICAgICBjb21wYXRpYmxlID0gImFkaSxhZHQ3NDc2IjsNCj4gPiA+ICsgICAgICAgIHJlZyA9IDww
eDJlPjsNCj4gPiA+ICsgICAgICAgIGJ5cGFzcy1hdHRlbnVhdG9yLWluMCA9IDwxPjsNCj4gPiA+
ICsgICAgICAgIGJ5cGFzcy1hdHRlbnVhdG9yLWluMSA9IDwwPjsNCj4gPiA+ICsgICAgICB9Ow0K
PiA+ID4gKyAgICB9Ow0KPiA+ID4gKy4uLg0KPiA+ID4gLS0gDQo+ID4gPiAyLjI1LjANCj4gPiA+
IA0K
