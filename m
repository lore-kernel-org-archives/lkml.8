Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0031C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 01:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D59720708
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 01:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="h/gG0S98"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgIGBu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 21:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgIGBu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 21:50:26 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E634C061574
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 18:50:25 -0700 (PDT)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 58F46891B0;
        Mon,  7 Sep 2020 13:50:14 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1599443414;
        bh=HaJSV/JZqCspnyNj8zH+yoo1VQmuoQY74/gtMgoAgNQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=h/gG0S98yHoeXto/fR4Hwd5AQd0EAD6TzxRfCNNS3ob9UzvE6MfXY4n0N4j5sDGPz
         AHzn2bSGREZexZwFeBFBeRagRRQAkP0GxrcxZcQy7y5Kwl51bizjPlGfRgq02mc2KA
         fYGtCm4bdHi5dh3c8AtmMPu5IJXNMVUzxJNNhulA4zp/X4xzl25EuxJHDj+Jl7p+08
         zrKcBMTRd0h95Z1ANDjYkiz3MzRkJxsgT+5NiAyz8tmBYXDEUTLdIXJKTwjowJinGh
         NBz7QHoraZ2gZi24frK+EOaA63BMZMAezqGP1/DBrL0p+DjKgdD4ElDcDS9Kg1wuWB
         fHhLftl38Uk9w==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f5591d60000>; Mon, 07 Sep 2020 13:50:14 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 7 Sep 2020 13:50:10 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.006; Mon, 7 Sep 2020 13:50:10 +1200
From:   Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>
To:     "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] usb: ohci: Add per-port overcurrent quirk
Thread-Topic: [PATCH 1/2] usb: ohci: Add per-port overcurrent quirk
Thread-Index: AQHWgmqw+C7I38zeeUyVpdiHcFIeNalX1saAgAPNqgA=
Date:   Mon, 7 Sep 2020 01:50:10 +0000
Message-ID: <9ba7b4dda9ef40e3c4c9b3f1c33075e04601ef61.camel@alliedtelesis.co.nz>
References: <20200904032247.11345-1-hamish.martin@alliedtelesis.co.nz>
         <20200904032247.11345-2-hamish.martin@alliedtelesis.co.nz>
         <20200904154517.GB694058@rowland.harvard.edu>
In-Reply-To: <20200904154517.GB694058@rowland.harvard.edu>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:24:f8a2:c861:f25b:236e]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1984D23B95FD2943BBE9AF67343ED460@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxhbiwNCg0KVGhhbmtzIGZvciB5b3VyIHF1aWNrIGZlZWRiYWNrLiBNeSByZXBsaWVzIGFy
ZSBpbmxpbmUgYmVsb3cuDQoNCk9uIEZyaSwgMjAyMC0wOS0wNCBhdCAxMTo0NSAtMDQwMCwgQWxh
biBTdGVybiB3cm90ZToNCj4gT24gRnJpLCBTZXAgMDQsIDIwMjAgYXQgMDM6MjI6NDZQTSArMTIw
MCwgSGFtaXNoIE1hcnRpbiB3cm90ZToNCj4gPiBTb21lIGludGVncmF0ZWQgT0hDSSBjb250cm9s
bGVyIGh1YnMgZG8gbm90IGV4cG9zZSBhbGwgcG9ydHMgb2YgdGhlDQo+ID4gaHViDQo+ID4gdG8g
cGlucyBvbiB0aGUgU29DLiBJbiBzb21lIGNhc2VzIHRoZSB1bmNvbm5lY3RlZCBwb3J0cyBnZW5l
cmF0ZQ0KPiA+IHNwdXJpb3VzIG92ZXJjdXJyZW50IGV2ZW50cy4gRm9yIGV4YW1wbGUgdGhlIEJy
b2FkY29tIDU2MDYwL1Jhbmdlcg0KPiA+IDIgU29DDQo+ID4gY29udGFpbnMgYSBub21pbmFsbHkg
MyBwb3J0IGh1YiBidXQgb25seSB0aGUgZmlyc3QgcG9ydCBpcyB3aXJlZC4NCj4gPiANCj4gPiBE
ZWZhdWx0IGJlaGF2aW91ciBmb3Igb2hjaS1wbGF0Zm9ybSBkcml2ZXIgaXMgdG8gdXNlICJnYW5n
ZWQiDQo+ID4gb3ZlcmN1cnJlbnQgcHJvdGVjdGlvbiBtb2RlLiBUaGlzIGxlYWRzIHRvIHRoZSBz
cHVyaW91cyBvdmVyY3VycmVudA0KPiA+IGV2ZW50cyBhZmZlY3RpbmcgYWxsIHBvcnRzIGluIHRo
ZSBodWIuDQo+ID4gDQo+ID4gQWxsb3cgdGhpcyB0byBiZSByZWN0aWZpZWQgYnkgc3BlY2lmeWlu
ZyBwZXItcG9ydCBvdmVyY3VycmVudA0KPiA+IHByb3RlY3Rpb24NCj4gPiBtb2RlIHZpYSB0aGUg
ZGV2aWNlIHRyZWUuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSGFtaXNoIE1hcnRpbiA8aGFt
aXNoLm1hcnRpbkBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3Vz
Yi9ob3N0L29oY2ktaGNkLmMgICAgICB8IDQgKysrKw0KPiA+ICBkcml2ZXJzL3VzYi9ob3N0L29o
Y2ktcGxhdGZvcm0uYyB8IDMgKysrDQo+ID4gIGRyaXZlcnMvdXNiL2hvc3Qvb2hjaS5oICAgICAg
ICAgIHwgMSArDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+ID4gDQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2hvc3Qvb2hjaS1oY2QuYyBiL2RyaXZlcnMvdXNi
L2hvc3Qvb2hjaS0NCj4gPiBoY2QuYw0KPiA+IGluZGV4IGRkMzdlNzdkYWUwMC4uMDFlM2Q3NWUy
OWQ5IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2hvc3Qvb2hjaS1oY2QuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvdXNiL2hvc3Qvb2hjaS1oY2QuYw0KPiA+IEBAIC02ODcsNiArNjg3LDEwIEBA
IHN0YXRpYyBpbnQgb2hjaV9ydW4gKHN0cnVjdCBvaGNpX2hjZCAqb2hjaSkNCj4gPiAgCQl2YWwg
fD0gUkhfQV9OUFM7DQo+ID4gIAkJb2hjaV93cml0ZWwgKG9oY2ksIHZhbCwgJm9oY2ktPnJlZ3Mt
PnJvb3RodWIuYSk7DQo+ID4gIAl9DQo+ID4gKwlpZiAob2hjaS0+ZmxhZ3MgJiBPSENJX1FVSVJL
X1BFUl9QT1JUX09DKSB7DQo+ID4gKwkJdmFsIHw9IFJIX0FfT0NQTTsNCj4gPiArCQlvaGNpX3dy
aXRlbChvaGNpLCB2YWwsICZvaGNpLT5yZWdzLT5yb290aHViLmEpOw0KPiA+ICsJfQ0KPiANCj4g
SSBkb24ndCB0aGluayB0aGlzIGlzIHJpZ2h0LCBmb3IgdHdvIHJlYXNvbnMuICBGaXJzdCwgaXNu
J3QgcGVyLXBvcnQgDQo+IG92ZXJjdXJyZW50IHByb3RlY3Rpb24gdGhlIGRlZmF1bHQ/DQoNCk5v
dCBhcyBmYXIgYXMgSSB1bmRlcnN0YW5kIHRoZSBjdXJyZW50IGNvZGUuIEp1c3QgYWJvdmUgd2hl
cmUgbXkgcGF0Y2gNCmFwcGxpZXMsIHRoZSBSSF9BX09DUE0gKGFuZCBSSF9BX1BTTSkgYml0cyBh
cmUgZXhwbGljaXRseSBjbGVhcmVkIGluDQondmFsJyB3aXRoOg0KICAgIHZhbCAmPSB+KFJIX0Ff
UFNNIHwgUkhfQV9PQ1BNKTsNCg0KVGhpcywgY291cGxlZCB3aXRoIHRoZSBPSENJX1FVSVJLX0hV
Ql9QT1dFUiBiZWluZyBzZXQgYnkgdmlydHVlIG9mIHRoZQ0KJ2Rpc3RydXN0X2Zpcm13YXJlJyBt
b2R1bGUgcGFyYW0gZGVmYXVsdGluZyB0cnVlLCByZWFkcyB0byBtZSBsaWtlIHRoZQ0KZGVmYXVs
dCBpcyBmb3IgZ2FuZ2VkIG92ZXItY3VycmVudCBwcm90ZWN0aW9uLiBBbmQgdGhhdCBpcyBteQ0K
ZXhwZXJpZW5jZSBpbiB0aGlzIGNhc2UuIA0KSWYgbm9uZSBvZiB0aGUgcXVpcmtzIGFyZSBzZWxl
Y3RlZCB0aGVuIGFsbCBvZiB0aGUgZmlkZGxpbmcgd2l0aCAndmFsJw0KbmV2ZXIgZ2V0cyB3cml0
dGVuIHRvICdvaGNpLT5yZWdzLT5yb290aHViLmEnDQoNCkknZCBhcHByZWNpYXRlIHlvdXIgcmVh
ZGluZyBvZiB0aGF0IGFuYWx5c2lzIGJlY2F1c2UgSSdtIGJ5IG5vIG1lYW5zDQpzdXJlIG9mIGl0
Lg0KDQo+IA0KPiBTZWNvbmQsIFJIX0FfT0NQTSBkb2Vzbid0IGRvIGFueXRoaW5nIHVubGVzcyBS
SF9BX05PQ1AgaXMgY2xlYXIuDQoNCkNvcnJlY3QsIGFuZCB0aGF0IGlzIG15IG1pc3Rha2UuIElm
IEkgcHJvZ3Jlc3MgdG8gYSB2MiBvZiB0aGlzIHBhdGNoIEkNCndpbGwgdXBkYXRlIGFjY29yZGlu
Z2x5Lg0KDQpUaGFua3MsDQpIYW1pc2ggTWFydGluDQoNCj4gDQo+IEFsYW4gU3Rlcm4NCj4gDQo+
ID4gIAlvaGNpX3dyaXRlbCAob2hjaSwgUkhfSFNfTFBTQywgJm9oY2ktPnJlZ3MtPnJvb3RodWIu
c3RhdHVzKTsNCj4gPiAgCW9oY2lfd3JpdGVsIChvaGNpLCAodmFsICYgUkhfQV9OUFMpID8gMCA6
IFJIX0JfUFBDTSwNCj4gPiAgCQkJCQkJJm9oY2ktPnJlZ3MtDQo+ID4gPnJvb3RodWIuYik7DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2hvc3Qvb2hjaS1wbGF0Zm9ybS5jDQo+ID4gYi9k
cml2ZXJzL3VzYi9ob3N0L29oY2ktcGxhdGZvcm0uYw0KPiA+IGluZGV4IDRhODQ1NmYxMmE3My4u
NDVlNjljZTRlZjg2IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2hvc3Qvb2hjaS1wbGF0
Zm9ybS5jDQo+ID4gKysrIGIvZHJpdmVycy91c2IvaG9zdC9vaGNpLXBsYXRmb3JtLmMNCj4gPiBA
QCAtMTM3LDYgKzEzNyw5IEBAIHN0YXRpYyBpbnQgb2hjaV9wbGF0Zm9ybV9wcm9iZShzdHJ1Y3QN
Cj4gPiBwbGF0Zm9ybV9kZXZpY2UgKmRldikNCj4gPiAgCQlpZiAob2ZfcHJvcGVydHlfcmVhZF9i
b29sKGRldi0+ZGV2Lm9mX25vZGUsICJuby1iaWctDQo+ID4gZnJhbWUtbm8iKSkNCj4gPiAgCQkJ
b2hjaS0+ZmxhZ3MgfD0gT0hDSV9RVUlSS19GUkFNRV9OTzsNCj4gPiAgDQo+ID4gKwkJaWYgKG9m
X3Byb3BlcnR5X3JlYWRfYm9vbChkZXYtPmRldi5vZl9ub2RlLCAicGVyLXBvcnQtDQo+ID4gb3Zl
cmN1cnJlbnQiKSkNCj4gPiArCQkJb2hjaS0+ZmxhZ3MgfD0gT0hDSV9RVUlSS19QRVJfUE9SVF9P
QzsNCj4gPiArDQo+ID4gIAkJaWYgKG9mX3Byb3BlcnR5X3JlYWRfYm9vbChkZXYtPmRldi5vZl9u
b2RlLA0KPiA+ICAJCQkJCSAgInJlbW90ZS13YWtldXAtY29ubmVjdGVkIikpDQo+ID4gIAkJCW9o
Y2ktPmhjX2NvbnRyb2wgPSBPSENJX0NUUkxfUldDOw0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3VzYi9ob3N0L29oY2kuaCBiL2RyaXZlcnMvdXNiL2hvc3Qvb2hjaS5oDQo+ID4gaW5kZXggYWFj
NjI4NWIzN2Y4Li45YzJiYzgxNjI0NmMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy91c2IvaG9z
dC9vaGNpLmgNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9ob3N0L29oY2kuaA0KPiA+IEBAIC00MjIs
NiArNDIyLDcgQEAgc3RydWN0IG9oY2lfaGNkIHsNCj4gPiAgI2RlZmluZQlPSENJX1FVSVJLX0FN
RF9QUkVGRVRDSAkweDQwMAkJCS8qDQo+ID4gcHJlLWZldGNoIGZvciBJU08gdHJhbnNmZXIgKi8N
Cj4gPiAgI2RlZmluZQlPSENJX1FVSVJLX0dMT0JBTF9TVVNQRU5ECTB4ODAwCQkvKiBtdXN0DQo+
ID4gc3VzcGVuZCBwb3J0cyAqLw0KPiA+ICAjZGVmaW5lCU9IQ0lfUVVJUktfUUVNVQkJMHgxMDAw
CQkJLyoNCj4gPiByZWxheCB0aW1pbmcgZXhwZWN0YXRpb25zICovDQo+ID4gKyNkZWZpbmUJT0hD
SV9RVUlSS19QRVJfUE9SVF9PQwkweDIwMDAJCQkvKg0KPiA+IHBlci1wb3J0IG92ZXJjdXJyZW50
IHByb3RlY3Rpb24gKi8NCj4gPiAgDQo+ID4gIAkvLyB0aGVyZSBhcmUgYWxzbyBjaGlwIHF1aXJr
cy9idWdzIGluIGluaXQgbG9naWMNCj4gPiAgDQo+ID4gLS0gDQo+ID4gMi4yOC4wDQo+ID4gDQo=
