Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8918AC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 22:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13C9B2177B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 22:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="xnzJg0FS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgIGW2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 18:28:35 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:45448 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727939AbgIGW2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 18:28:33 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 15CDA80719;
        Tue,  8 Sep 2020 10:28:27 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1599517707;
        bh=hq3UBKJjR4w5dei1/EYSWkIx6PwOdHQYg/BXGe7rHOY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=xnzJg0FSSMPFQw42G0gnMIRoZScndWGdc85g5Y2xwJSNNidRxFdACeHqTyCwRPbLK
         HiFLprABCKX33TEqaYPVnD7TT5tzSHaCpbEWRIjPQQdMjd7yLJgZBrq6HEBWnfJeE1
         88fApydIvNU5H26DtVo4BPJXurTIMGu4w9kU3MJ1fQw2jefEL2ltV/96OBv+Ud9/Yw
         CBV21GXzfoXPjAsLqeasz9OpcFVETnyH+6BN0UB3LXrbeTyauluTnETcVR1aVN2VHE
         VENRlRictnQhX1wpESK9TPl6n0+AoC8Td9eEQW1gV3p5zBvELkZ+lqAv3qM4tqfzdW
         bkVnq65yTZqMw==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f56b40b0001>; Tue, 08 Sep 2020 10:28:27 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 8 Sep 2020 10:28:26 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.006; Tue, 8 Sep 2020 10:28:26 +1200
From:   Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>
To:     "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] usb: ohci: Add per-port overcurrent quirk
Thread-Topic: [PATCH 1/2] usb: ohci: Add per-port overcurrent quirk
Thread-Index: AQHWgmqw+C7I38zeeUyVpdiHcFIeNalX1saAgAPNqgCAANxmAIAAfZIA
Date:   Mon, 7 Sep 2020 22:28:26 +0000
Message-ID: <d4523ef1d68202f492fc646455d67e0d4dee4898.camel@alliedtelesis.co.nz>
References: <20200904032247.11345-1-hamish.martin@alliedtelesis.co.nz>
         <20200904032247.11345-2-hamish.martin@alliedtelesis.co.nz>
         <20200904154517.GB694058@rowland.harvard.edu>
         <9ba7b4dda9ef40e3c4c9b3f1c33075e04601ef61.camel@alliedtelesis.co.nz>
         <20200907145900.GC762136@rowland.harvard.edu>
In-Reply-To: <20200907145900.GC762136@rowland.harvard.edu>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:24:f8a2:c861:f25b:236e]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D8EAEE37611BA4D8F8FD73E0A566F06@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA5LTA3IGF0IDEwOjU5IC0wNDAwLCBzdGVybkByb3dsYW5kLmhhcnZhcmQu
ZWR1IHdyb3RlOg0KPiBPbiBNb24sIFNlcCAwNywgMjAyMCBhdCAwMTo1MDoxMEFNICswMDAwLCBI
YW1pc2ggTWFydGluIHdyb3RlOg0KPiA+IEhpIEFsYW4sDQo+ID4gDQo+ID4gVGhhbmtzIGZvciB5
b3VyIHF1aWNrIGZlZWRiYWNrLiBNeSByZXBsaWVzIGFyZSBpbmxpbmUgYmVsb3cuDQo+ID4gDQo+
ID4gT24gRnJpLCAyMDIwLTA5LTA0IGF0IDExOjQ1IC0wNDAwLCBBbGFuIFN0ZXJuIHdyb3RlOg0K
PiA+ID4gT24gRnJpLCBTZXAgMDQsIDIwMjAgYXQgMDM6MjI6NDZQTSArMTIwMCwgSGFtaXNoIE1h
cnRpbiB3cm90ZToNCj4gPiA+ID4gU29tZSBpbnRlZ3JhdGVkIE9IQ0kgY29udHJvbGxlciBodWJz
IGRvIG5vdCBleHBvc2UgYWxsIHBvcnRzIG9mDQo+ID4gPiA+IHRoZQ0KPiA+ID4gPiBodWINCj4g
PiA+ID4gdG8gcGlucyBvbiB0aGUgU29DLiBJbiBzb21lIGNhc2VzIHRoZSB1bmNvbm5lY3RlZCBw
b3J0cw0KPiA+ID4gPiBnZW5lcmF0ZQ0KPiA+ID4gPiBzcHVyaW91cyBvdmVyY3VycmVudCBldmVu
dHMuIEZvciBleGFtcGxlIHRoZSBCcm9hZGNvbQ0KPiA+ID4gPiA1NjA2MC9SYW5nZXINCj4gPiA+
ID4gMiBTb0MNCj4gPiA+ID4gY29udGFpbnMgYSBub21pbmFsbHkgMyBwb3J0IGh1YiBidXQgb25s
eSB0aGUgZmlyc3QgcG9ydCBpcw0KPiA+ID4gPiB3aXJlZC4NCj4gPiA+ID4gDQo+ID4gPiA+IERl
ZmF1bHQgYmVoYXZpb3VyIGZvciBvaGNpLXBsYXRmb3JtIGRyaXZlciBpcyB0byB1c2UgImdhbmdl
ZCINCj4gPiA+ID4gb3ZlcmN1cnJlbnQgcHJvdGVjdGlvbiBtb2RlLiBUaGlzIGxlYWRzIHRvIHRo
ZSBzcHVyaW91cw0KPiA+ID4gPiBvdmVyY3VycmVudA0KPiA+ID4gPiBldmVudHMgYWZmZWN0aW5n
IGFsbCBwb3J0cyBpbiB0aGUgaHViLg0KPiA+ID4gPiANCj4gPiA+ID4gQWxsb3cgdGhpcyB0byBi
ZSByZWN0aWZpZWQgYnkgc3BlY2lmeWluZyBwZXItcG9ydCBvdmVyY3VycmVudA0KPiA+ID4gPiBw
cm90ZWN0aW9uDQo+ID4gPiA+IG1vZGUgdmlhIHRoZSBkZXZpY2UgdHJlZS4NCj4gPiA+ID4gDQo+
ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEhhbWlzaCBNYXJ0aW4gPGhhbWlzaC5tYXJ0aW5AYWxsaWVk
dGVsZXNpcy5jby5ueg0KPiA+ID4gPiA+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgZHJpdmVycy91
c2IvaG9zdC9vaGNpLWhjZC5jICAgICAgfCA0ICsrKysNCj4gPiA+ID4gIGRyaXZlcnMvdXNiL2hv
c3Qvb2hjaS1wbGF0Zm9ybS5jIHwgMyArKysNCj4gPiA+ID4gIGRyaXZlcnMvdXNiL2hvc3Qvb2hj
aS5oICAgICAgICAgIHwgMSArDQo+ID4gPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9u
cygrKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2hvc3Qvb2hj
aS1oY2QuYw0KPiA+ID4gPiBiL2RyaXZlcnMvdXNiL2hvc3Qvb2hjaS0NCj4gPiA+ID4gaGNkLmMN
Cj4gPiA+ID4gaW5kZXggZGQzN2U3N2RhZTAwLi4wMWUzZDc1ZTI5ZDkgMTAwNjQ0DQo+ID4gPiA+
IC0tLSBhL2RyaXZlcnMvdXNiL2hvc3Qvb2hjaS1oY2QuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJz
L3VzYi9ob3N0L29oY2ktaGNkLmMNCj4gPiA+ID4gQEAgLTY4Nyw2ICs2ODcsMTAgQEAgc3RhdGlj
IGludCBvaGNpX3J1biAoc3RydWN0IG9oY2lfaGNkDQo+ID4gPiA+ICpvaGNpKQ0KPiA+ID4gPiAg
CQl2YWwgfD0gUkhfQV9OUFM7DQo+ID4gPiA+ICAJCW9oY2lfd3JpdGVsIChvaGNpLCB2YWwsICZv
aGNpLT5yZWdzLQ0KPiA+ID4gPiA+cm9vdGh1Yi5hKTsNCj4gPiA+ID4gIAl9DQo+ID4gPiA+ICsJ
aWYgKG9oY2ktPmZsYWdzICYgT0hDSV9RVUlSS19QRVJfUE9SVF9PQykgew0KPiA+ID4gPiArCQl2
YWwgfD0gUkhfQV9PQ1BNOw0KPiA+ID4gPiArCQlvaGNpX3dyaXRlbChvaGNpLCB2YWwsICZvaGNp
LT5yZWdzLT5yb290aHViLmEpOw0KPiA+ID4gPiArCX0NCj4gPiA+IA0KPiA+ID4gSSBkb24ndCB0
aGluayB0aGlzIGlzIHJpZ2h0LCBmb3IgdHdvIHJlYXNvbnMuICBGaXJzdCwgaXNuJ3QgcGVyLQ0K
PiA+ID4gcG9ydCANCj4gPiA+IG92ZXJjdXJyZW50IHByb3RlY3Rpb24gdGhlIGRlZmF1bHQ/DQo+
ID4gDQo+ID4gTm90IGFzIGZhciBhcyBJIHVuZGVyc3RhbmQgdGhlIGN1cnJlbnQgY29kZS4gSnVz
dCBhYm92ZSB3aGVyZSBteQ0KPiA+IHBhdGNoDQo+ID4gYXBwbGllcywgdGhlIFJIX0FfT0NQTSAo
YW5kIFJIX0FfUFNNKSBiaXRzIGFyZSBleHBsaWNpdGx5IGNsZWFyZWQNCj4gPiBpbg0KPiA+ICd2
YWwnIHdpdGg6DQo+ID4gICAgIHZhbCAmPSB+KFJIX0FfUFNNIHwgUkhfQV9PQ1BNKTsNCj4gPiAN
Cj4gPiBUaGlzLCBjb3VwbGVkIHdpdGggdGhlIE9IQ0lfUVVJUktfSFVCX1BPV0VSIGJlaW5nIHNl
dCBieSB2aXJ0dWUgb2YNCj4gPiB0aGUNCj4gPiAnZGlzdHJ1c3RfZmlybXdhcmUnIG1vZHVsZSBw
YXJhbSBkZWZhdWx0aW5nIHRydWUsIHJlYWRzIHRvIG1lIGxpa2UNCj4gPiB0aGUNCj4gPiBkZWZh
dWx0IGlzIGZvciBnYW5nZWQgb3Zlci1jdXJyZW50IHByb3RlY3Rpb24uIEFuZCB0aGF0IGlzIG15
DQo+ID4gZXhwZXJpZW5jZSBpbiB0aGlzIGNhc2UuIA0KPiANCj4gWW91J3JlIHJpZ2h0IGFib3V0
IHRoYXQuICBJIGhhZG4ndCBub3RpY2VkIGJlZm9yZTsgaXQgbWFrZXMgbGl0dGxlDQo+IHNlbnNl
IA0KPiB0byBoYXZlIGEgcXVpcmsgdGhhdCBkZWZhdWx0cyB0byB0cnVlLg0KPiANCj4gSXQncyBu
b3QgZWFzeSB0byB0ZWxsIHRoZSBmdWxsIHN0b3J5IGZyb20gdGhlIGtlcm5lbCBoaXN0b3J5OyB0
aGF0IA0KPiBtb2R1bGUgcGFyYW1ldGVyIHByZWRhdGVzIHRoZSBHaXQgZXJhLiAgSSBkaWQgbGVh
cm4gdGhhdCBpdCB3YXMNCj4gbW9kaWZpZWQgDQo+IGluIDIuNi4zLXJjMyBhbmQgZ29lcyBiYWNr
IGV2ZW4gZmFydGhlcjogc2VlDQo+IA0KPiAJaHR0cHM6Ly9tYXJjLmluZm8vP2w9bGludXgtdXNi
LWRldmVsJm09MTEwNjI4NDU3NDI0Njg0Jnc9Mg0KPiANCj4gPiBJZiBub25lIG9mIHRoZSBxdWly
a3MgYXJlIHNlbGVjdGVkIHRoZW4gYWxsIG9mIHRoZSBmaWRkbGluZyB3aXRoDQo+ID4gJ3ZhbCcN
Cj4gPiBuZXZlciBnZXRzIHdyaXR0ZW4gdG8gJ29oY2ktPnJlZ3MtPnJvb3RodWIuYScNCj4gPiAN
Cj4gPiBJJ2QgYXBwcmVjaWF0ZSB5b3VyIHJlYWRpbmcgb2YgdGhhdCBhbmFseXNpcyBiZWNhdXNl
IEknbSBieSBubw0KPiA+IG1lYW5zDQo+ID4gc3VyZSBvZiBpdC4NCj4gPiANCj4gPiA+IA0KPiA+
ID4gU2Vjb25kLCBSSF9BX09DUE0gZG9lc24ndCBkbyBhbnl0aGluZyB1bmxlc3MgUkhfQV9OT0NQ
IGlzIGNsZWFyLg0KPiA+IA0KPiA+IENvcnJlY3QsIGFuZCB0aGF0IGlzIG15IG1pc3Rha2UuIElm
IEkgcHJvZ3Jlc3MgdG8gYSB2MiBvZiB0aGlzDQo+ID4gcGF0Y2ggSQ0KPiA+IHdpbGwgdXBkYXRl
IGFjY29yZGluZ2x5Lg0KPiANCj4gU2hhbGwgd2UgdHJ5IGNoYW5naW5nIHRoZSBwYXJhbWV0ZXIn
cyBkZWZhdWx0IHZhbHVlPyAgVGhlIFVTQg0KPiBzdWJzeXN0ZW0gDQo+IGlzIGEgbG90IG1vcmUg
bWF0dXJlIGFuZCByZWxpYWJsZSBub3cgdGhhbiBpdCB3YXMgYmFjayBpbiAyMDA0Lg0KDQpUaGF0
IGRvZXNuJ3QgcmVhbGx5IGhlbHAgbWUgaW4gbXkgcGFydGljdWxhciBjYXNlLiBJIHRyaWVkIHR1
cm5pbmcgdGhlDQpwYXJhbSBvZmYgYW5kIHRoYXQganVzdCBsZWFkcyB0byB0aGUgcm9vdGh1Yi5h
IHJlZyBub3QgYmVpbmcgbW9kaWZpZWQNCmF0IGFsbCAoYW5kIGdhbmdlZCBvdmVyLWN1cnJlbnQg
cHJvdGVjdGlvbiBiZWluZyBsZWZ0IGluIHBsYWNlKS4NCg0KU28sIEkgZ3Vlc3MgSSdtIHN0aWxs
IGJhY2sgdG8gbXkgb3JpZ2luYWwgaWRlYSBvZiBhZGRpbmcgYSBuZXcgcXVpcmsNCihwZXJoYXBz
IHF1aXJrIGlzIG5vdCB0aGUgYmVzdCBuYW1lIGZvciBpdCBpbiB0aGlzIGNhc2UpIHRoYXQgYWxs
b3dzDQp0aGUgcGVyLXBvcnQgb3Zlci1jdXJyZW50IHRvIGJlIHNlbGVjdGVkLg0KSWYgeW91IHdv
dWxkIHJhdGhlciB0aGF0IHRoaXMgbm90IGJlIGEgcXVpcmsgYW5kIEkgcmV3b3JrIHRoZSBjb2Rl
IHN1Y2gNCnRoYXQgaWYgbm8gb3RoZXIgcXVpcmtzIGFyZSBzZWxlY3RlZCB0aGVuIHdlIGNvbmZp
Z3VyZSBmb3IgcGVyLXBvcnQNCm92ZXItY3VycmVudCBhcyB0aGUgZGVmYXVsdCB0aGVuIEkgY2Fu
IGRvIHRoYXQgdG9vLiBJZiB5b3UgZXhwZWN0IHBlci0NCnBvcnQgb3Zlci1jdXJyZW50IHRvIGJl
IHRoZSBkZWZhdWx0IHRoZW4gZXhwbGljaXQgY29kZSB0aGF0IGVuZm9yY2VzDQp0aGF0IG1pZ2h0
IGJlIGJlc3QuDQoNCldoYXQncyB0aGUgYmVzdCBhcHByb2FjaD8NCg0KVGhhbmtzLA0KSGFtaXNo
IE0NCg0KPiANCj4gQWxhbiBTdGVybg0K
