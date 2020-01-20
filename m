Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B33FC33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37AE722464
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgATPHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 10:07:24 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:44991 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726860AbgATPHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 10:07:24 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-181-lviwv2PpPtqQgvwmkaJWJw-1; Mon, 20 Jan 2020 15:07:20 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 20 Jan 2020 15:07:20 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 20 Jan 2020 15:07:20 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     =?utf-8?B?J1BhbGkgUm9ow6FyJw==?= <pali.rohar@gmail.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Namjae Jeon <linkinjeon@gmail.com>,
        "Gabriel Krisman Bertazi" <krisman@collabora.com>
Subject: RE: vfat: Broken case-insensitive support for UTF-8
Thread-Topic: vfat: Broken case-insensitive support for UTF-8
Thread-Index: AQHVz4FsiOVqsS4Qp0SucuDN4afIhKfzph4w
Date:   Mon, 20 Jan 2020 15:07:20 +0000
Message-ID: <89eba9906011446f8441090f496278d2@AcuMS.aculab.com>
References: <20200119221455.bac7dc55g56q2l4r@pali>
 <87sgkan57p.fsf@mail.parknet.co.jp> <20200120110438.ak7jpyy66clx5v6x@pali>
In-Reply-To: <20200120110438.ak7jpyy66clx5v6x@pali>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: lviwv2PpPtqQgvwmkaJWJw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUGFsaSBSb2jDoXINCj4gU2VudDogMjAgSmFudWFyeSAyMDIwIDExOjA1DQo+IE9uIE1v
bmRheSAyMCBKYW51YXJ5IDIwMjAgMTM6MDQ6NDIgT0dBV0EgSGlyb2Z1bWkgd3JvdGU6DQo+ID4g
UGFsaSBSb2jDoXIgPHBhbGkucm9oYXJAZ21haWwuY29tPiB3cml0ZXM6DQo+ID4NCj4gPiA+IFdo
aWNoIG1lYW5zIHRoYXQgZmF0X25hbWVfbWF0Y2goKSwgdmZhdF9oYXNoaSgpIGFuZCB2ZmF0X2Nt
cGkoKSBhcmUNCj4gPiA+IGJyb2tlbiBmb3IgdmZhdCBpbiBVVEYtOCBtb2RlLg0KPiA+DQo+ID4g
UmlnaHQuIEl0IGlzIGEga25vd24gaXNzdWUuDQo+IA0KPiBDb3VsZCBiZSB0aGlzIGlzc3VlIGJl
dHRlciBkb2N1bWVudGVkPyBFLmcuIGluIG1vdW50KDgpIG1hbnBhZ2Ugd2hlcmUNCj4gYXJlIHdy
aXR0ZW4gbW91bnQgb3B0aW9ucyBmb3IgdmZhdD8gSSB0aGluayB0aGF0IHBlb3BsZSBzaG91bGQg
YmUgYXdhcmUNCj4gb2YgdGhpcyBpc3N1ZSB3aGVuIHRoZXkgdXNlICJ1dGY4PTEiIG1vdW50IG9w
dGlvbi4NCg0KV2hhdCBoYXBwZW5zIGlmIHRoZSBmaWxlc3lzdGVtIGhhcyBmaWxlbmFtZXMgdGhh
dCBpbnZhbGlkIFVURjggc2VxdWVuY2VzDQpvciBtdWx0aXBsZSBmaWxlbmFtZXMgdGhhdCBkZWNv
ZGUgZnJvbSBVVEY4IHRvIHRoZSBzYW1lICd3Y2hhcicgdmFsdWUuDQpOZXZlciBtaW5kIG9uZXMg
dGhhdCBhcmUganVzdCBjYXNlLWRpZmZlcmVuY2VzIGZvciB0aGUgc2FtZSBmaWxlbmFtZS4NCg0K
VVRGOCBpcyBqdXN0IHNvIGJyb2tlbiBpdCBzaG91bGQgbmV2ZXIgaGF2ZSBiZWVuIGFsbG93ZWQg
dG8gYmVjb21lDQphIHN0YW5kYXJkLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNz
IExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAx
UFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

