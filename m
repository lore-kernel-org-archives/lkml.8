Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF260C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 14:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA512082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 14:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbgBDOFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 09:05:18 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:28339 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727210AbgBDOFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 09:05:18 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-106-YUBZHsDKNUyB9PJhEj0dag-1; Tue, 04 Feb 2020 14:05:12 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 4 Feb 2020 14:05:12 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 4 Feb 2020 14:05:12 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jens Axboe' <axboe@kernel.dk>
CC:     LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Fix io_read() and io_write() when io_import_fixed() is
 used.
Thread-Topic: [PATCH] Fix io_read() and io_write() when io_import_fixed() is
 used.
Thread-Index: AdXbTP+YLQmyIuo6Sk+vDwZErsD4XwAFopYAAAAFVxA=
Date:   Tue, 4 Feb 2020 14:05:12 +0000
Message-ID: <3d5daf51252846cb851bf37d18842c4c@AcuMS.aculab.com>
References: <0cf51853bebe4c889e4d00e4bbc61fb3@AcuMS.aculab.com>
 <bd164f90-f464-6c40-cb0c-9fd6e1ca98da@kernel.dk>
In-Reply-To: <bd164f90-f464-6c40-cb0c-9fd6e1ca98da@kernel.dk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: YUBZHsDKNUyB9PJhEj0dag-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSmVucyBBeGJvZQ0KPiBTZW50OiAwNCBGZWJydWFyeSAyMDIwIDE0OjAxDQo+IE9uIDIv
NC8yMCA0OjIwIEFNLCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+ID4gaW9faW1wb3J0X2ZpeGVkKCkg
cmV0dXJucyAwIG9uIHN1Y2Nlc3Mgc28gaW9faW1wb3J0X2lvdmVjKCkgbWF5DQo+ID4gbm90IHJl
dHVybiB0aGUgbGVuZ3RoIG9mIHRoZSB0cmFuc2Zlci4NCj4gPg0KPiA+IEluc3RlYWQgYWx3YXlz
IHVzZSB0aGUgdmFsdWUgZnJvbSBpb3ZfaXRlcl9jb3VudCgpDQo+ID4gKFdoaWNoIGlzIGNhbGxl
ZCBhdCB0aGUgc2FtZSBwbGFjZS4pDQo+ID4NCj4gPiBGaXhlcyA5ZDkzYTNmNWEgKG1vZGRlZCBi
eSA0OTEzODFjZTApIGFuZCA5ZTY0NWUxMTAuDQo+IA0KPiBXaGF0IGtlcm5lbCBpcyB0aGlzIGFn
YWluc3Q/IFRoaXMgc2hvdWxkbid0IGJlIGFuIGlzc3VlDQo+IGluIGFueXRoaW5nIG5ld2VyIHRo
YW4gNS4zLXN0YWJsZS4NCg0KU291cmNlcyBhcmUgNS40LjAtcmM3Lg0KU28gbm90IGVudGlyZWx5
ICd0aGUgbGF0ZXN0Jy4NCkkgZGlkbid0IHVwZGF0ZSBsYXRlIGluIHRoZSA1LjUgY3ljbGUgYW5k
IHdvbid0IHVudGlsDQp3ZSBnZXQgdG8gcmM0IChvciBzbykuDQoNCglEYXZpZA0KDQotDQpSZWdp
c3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9u
IEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

