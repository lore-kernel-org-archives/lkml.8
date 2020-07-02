Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F538C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7589220748
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 07:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgGBHze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 03:55:34 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:47423 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725287AbgGBHzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 03:55:33 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-119-yl_OAD0oOpipGC1tkdZXrg-1; Thu, 02 Jul 2020 08:55:28 +0100
X-MC-Unique: yl_OAD0oOpipGC1tkdZXrg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 2 Jul 2020 08:55:28 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 2 Jul 2020 08:55:28 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kars Mulder' <kerneldev@karsmulder.nl>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: RE: Writing to a const pointer: is this  supposed to happen?
Thread-Topic: Writing to a const pointer: is this  supposed to happen?
Thread-Index: AQHWSju/rqA8ozob6UepcWuq3RM2GKjsP5LwgAcSxwCAAKR74A==
Date:   Thu, 2 Jul 2020 07:55:27 +0000
Message-ID: <32182d4126fd49dabac4091b7a6c89e7@AcuMS.aculab.com>
References: <0ceda3b41fe446e792fce5ff2634c48f@AcuMS.aculab.com>
 <1f2d-5efd1600-b3-caae120@315006>
In-Reply-To: <1f2d-5efd1600-b3-caae120@315006>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogS2FycyBNdWxkZXINCj4gU2VudDogMDIgSnVseSAyMDIwIDAwOjAzDQo+IE9uIFNhdHVy
ZGF5LCBKdW5lIDI3LCAyMDIwIDEyOjI0IENFU1QsIERhdmlkIExhaWdodCB3cm90ZToNCj4gPiBU
aGUgY29kZSBxdW90ZWQgKHVzaW5nIHN0cnNldCgpKSBpcyBhbG1vc3QgY2VydGFpbmx5IHdyb25n
Lg0KPiA+IFRoZSBjYWxsZXIgaXMgdW5saWtlbHkgdG8gZXhwZWN0IHRoZSBpbnB1dCBiZSBtb2Rp
ZmllZC4NCj4gPiBTaW5jZSBpdCBkb2Vzbid0IGZhdWx0IHRoZSBzdHJpbmcgbXVzdCBiZSBpbiBy
ZWFkLXdyaXRlIG1lbW9yeS4NCj4gDQo+IEkgdHJpZWQgd3JpdGluZyBhIHBhdGNoIHRoYXQgYXZv
aWRzIHRoZSB3cml0aW5nLXRvLWNvbnN0LXBvaW50ZXIgaXNzdWUNCj4gYnkgdXNpbmcgdGhlIGxl
c3MgaW50cnVzaXZlIHNzY2FuZiBmdW5jdGlvbiBpbnN0ZWFkIG9mIHN0cnNlcC4gSXQgbWlnaHQN
Cj4gYXZvaWQgYSBwb3RlbnRpYWwgYnVnIHdoZW4gc29tZWJvZHkgd3JvbmdseSBhc3N1bWVzIHRo
YXQgYQ0KPiBrZXJuZWxfcGFyYW1fb3BzLnNldCBmdW5jdGlvbiB3aWxsIG5vdCB3cml0ZSB0byBp
dHMgY29uc3QgY2hhciogYXJndW1lbnQuDQoNCkhtbS4uLiBzc2NhbmYoKSBpcyBhbHNvIGhvcnJp
ZC4NClN1cnByaXNpbmdseSBkaWZmaWN1bHQgdG8gdXNlIGNvcnJlY3RseS4NCg0KSXQgaXMgdXN1
YWxseSBiZXN0IHRvIHVzZSBzdHJjaHIoKSAoYW5kIG1heWJlIHN0cltjXXNjbigpKQ0KdG8gcGFy
c2Ugc3RyaW5ncy4NCkZvciBudW1iZXJzIHVzZSB3aGF0ZXZlciB0aGUga2VybmVscyBjdXJyZW50
ICdmYXZvdXJpdGUnIGltcGxlbWVudGF0aW9uDQpvZiBzdHJ0b3VsKCkgaXMgY2FsbGVkLg0KDQoJ
RGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1v
dW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEz
OTczODYgKFdhbGVzKQ0K

