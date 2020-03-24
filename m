Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE0FC54EEB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1960205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="u5P74aun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgCXUHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 16:07:02 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:51139 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbgCXUHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 16:07:01 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id F381E8364E
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 09:06:56 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1585080416;
        bh=9WZO0YII+yE1jpC1rDt5VNtWaDHFbuem8lhAdXMMyGs=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=u5P74aunSnA1vulQx557yJbviS1KV6wOdFBxlNbAtiYtqGIXoJJlX6nGY7Zd6bvVL
         0HapXq5PG7pFE7nZFQqiS0VGSZqR4tq63A3ZcaPA7tjXdTuScAceuCXB+IzL+MSVvs
         5tBHR+sr1xUL+zxFTGPeXnNFC6X3S82oqdIy6z2cQ1pkMnA68sW0MIg6AzxJ1dJzLI
         S6o61ACUsJbN4uIb6eBJFGrpye2Ekq0/uGFxfjXHwhmn4pbFnvP4mkK+Rec7yffroE
         JsIzzE/lcGwSBl15Hllgp4FhvgRSek4W3iS3Q1P3lpmmDOxXgx31c+HXCczeGT4rWk
         0+ExFWim3YkJg==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e7a68610001>; Wed, 25 Mar 2020 09:06:57 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 25 Mar 2020 09:06:56 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.006; Wed, 25 Mar 2020 09:06:56 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "christophe.leroy@c-s.fr" <christophe.leroy@c-s.fr>,
        "paulus@samba.org" <paulus@samba.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "cai@lca.pw" <cai@lca.pw>
CC:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>
Subject: Re: Argh, can't find dcache properties !
Thread-Topic: Argh, can't find dcache properties !
Thread-Index: AQHWALpiXt3RJnRHvUCUrPyClavMpahWU00AgAEA2QA=
Date:   Tue, 24 Mar 2020 20:06:56 +0000
Message-ID: <876a5938fbad9d9e176e5f22f12e6b472d0dc4f7.camel@alliedtelesis.co.nz>
References: <be8c123a90f6d1664a902b6ad6c754b9f3d9e567.camel@alliedtelesis.co.nz>
         <87tv2exst1.fsf@mpe.ellerman.id.au>
In-Reply-To: <87tv2exst1.fsf@mpe.ellerman.id.au>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.14.96]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF071371F606CD40ADC6A9539C5E1070@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTAzLTI0IGF0IDE1OjQ3ICsxMTAwLCBNaWNoYWVsIEVsbGVybWFuIHdyb3Rl
Og0KPiBDaHJpcyBQYWNraGFtIDxDaHJpcy5QYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+IHdy
aXRlczoNCj4gPiBIaSBBbGwsDQo+ID4gDQo+ID4gSnVzdCBib290aW5nIHVwIHY1LjUuMTEgb24g
YSBGcmVlc2NhbGUgVDIwODBSREIgYW5kIEknbSBzZWVpbmcgdGhlDQo+ID4gZm9sbG93aW5nIG1l
c2FnZS4NCj4gPiANCj4gPiBrZXJuLndhcm5pbmcgbGludXhib3gga2VybmVsOiBBcmdoLCBjYW4n
dCBmaW5kIGRjYWNoZSBwcm9wZXJ0aWVzICENCj4gPiBrZXJuLndhcm5pbmcgbGludXhib3gga2Vy
bmVsOiBBcmdoLCBjYW4ndCBmaW5kIGljYWNoZSBwcm9wZXJ0aWVzICENCj4gPiANCj4gPiBUaGlz
IHdhcyBjaGFuZ2VkIGZyb20gREJHKCkgdG8gcHJfd2FybigpIGluIGNvbW1pdCAzYjkxNzZlOWE4
NzQNCj4gPiAoInBvd2VycGMvc2V0dXBfNjQ6IGZpeCAtV2VtcHR5LWJvZHkgd2FybmluZ3MiKSBi
dXQgdGhlIG1lc3NhZ2UNCj4gPiBzZWVtcw0KPiA+IHRvIGJlIG11Y2ggb2xkZXIgdGhhbiB0aGF0
LiBTbyBpdCdzIHByb2JhYmx5IGJlZW4gYW4gaXNzdWUgb24gdGhlDQo+ID4gVDIwODANCj4gPiAo
YW5kIG90aGVyIFFvcklRIFNvQ3MpIGZvciBhIHdoaWxlLg0KPiANCj4gVGhhdCdzIGFuIGU2NTAw
IEkgdGhpbms/IFNvIDY0LWJpdCBCb29rM0UuDQo+IA0KDQpZZXMgdGhhdCdzIGNvcnJlY3QuDQoN
Cj4gWW91J2xsIGJlIGdldHRpbmcgdGhlIGRlZmF1bHQgdmFsdWVzLCB3aGljaCBpcyA2NCBieXRl
cyBzbyBJIGd1ZXNzDQo+IHRoYXQNCj4gd29ya3MgaW4gcHJhY3RpY2UuDQo+IA0KPiA+IExvb2tp
bmcgYXQgdGhlIGNvZGUgdGhlIHQyMDh4IGRvZXNuJ3Qgc3BlY2lmaXkgYW55IG9mIHRoZSBkLWNh
Y2hlLQ0KPiA+IHNpemUvaS1jYWNoZS1zaXplIHByb3BlcnRpZXMuIFNob3VsZCBJIGFkZCB0aGVt
IHRvIHNpbGVuY2UgdGhlDQo+ID4gd2FybmluZw0KPiA+IG9yIHN3aXRjaCBpdCB0byBwcl9kZWJ1
ZygpL3ByX2luZm8oKT8NCj4gDQo+IFllYWggaWRlYWxseSB5b3UnZCBhZGQgdGhlbSB0byB0aGUg
ZGV2aWNlIHRyZWUocykgZm9yIHRob3NlIGJvYXJkcy4NCj4gDQoNCkkgdGhpbmsgdGhlIGluZm8g
SSBuZWVkIGlzIGluIHRoZSBibG9jayBkaWFncmFtWzBdLiBJJ2xsIHdoaXAgdXANCmEgcGF0Y2gu
DQoNCi0tDQpbMV0gLSBodHRwczovL3d3dy5ueHAuY29tL3Byb2R1Y3RzL3Byb2Nlc3NvcnMtYW5k
LW1pY3JvY29udHJvbGxlcnMvcG93ZXItYXJjaGl0ZWN0dXJlL3FvcmlxLWNvbW11bmljYXRpb24t
cHJvY2Vzc29ycy90LXNlcmllcy9xb3JpcS10MjA4MC1hbmQtdDIwODEtbXVsdGljb3JlLWNvbW11
bmljYXRpb25zLXByb2Nlc3NvcnM6VDIwODANCg==
