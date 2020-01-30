Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97612C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 04:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF3B20707
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 04:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgA3Ebb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 23:31:31 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:55811 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgA3Ebb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 23:31:31 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 00U4UvjT019749, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 00U4UvjT019749
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jan 2020 12:30:57 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 30 Jan 2020 12:30:57 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 30 Jan 2020 12:30:57 +0800
Received: from RTEXMB01.realtek.com.tw ([fe80::1832:8abc:ec2d:974f]) by
 RTEXMB01.realtek.com.tw ([fe80::1832:8abc:ec2d:974f%6]) with mapi id
 15.01.1779.005; Thu, 30 Jan 2020 12:30:57 +0800
From:   Oder Chiou <oder_chiou@realtek.com>
To:     Sameer Pujar <spujar@nvidia.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "perex@perex.cz" <perex@perex.cz>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: rt5659: add S32_LE format
Thread-Topic: [PATCH] ASoC: rt5659: add S32_LE format
Thread-Index: AQHVz1lcdsPxKVEECkqlysxhWjZRR6fyj7wAgANoewCADLS34A==
Date:   Thu, 30 Jan 2020 04:30:57 +0000
Message-ID: <67328e51035e4eb5a6a78c3156e5d11f@realtek.com>
References: <1579501059-27936-1-git-send-email-spujar@nvidia.com>
 <74a42452-f19c-1175-9928-da12ccad621d@nvidia.com>
 <c700f22c-a053-7f39-dddf-41abe52cad77@nvidia.com>
In-Reply-To: <c700f22c-a053-7f39-dddf-41abe52cad77@nvidia.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [60.250.204.174]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWNrZWQtYnk6IE9kZXIgQ2hpb3UgPG9kZXJfY2hpb3VAcmVhbHRlay5jb20+DQoNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2FtZWVyIFB1amFyIFttYWlsdG86c3B1amFy
QG52aWRpYS5jb21dDQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAyMiwgMjAyMCA2OjI3IFBN
DQo+IFRvOiBPZGVyIENoaW91OyB0aXdhaUBzdXNlLmNvbTsgcGVyZXhAcGVyZXguY3oNCj4gQ2M6
IGFsc2EtZGV2ZWxAYWxzYS1wcm9qZWN0Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBBU29DOiBydDU2NTk6IGFkZCBTMzJfTEUgZm9ybWF0
DQo+IA0KPiBIaSBSZXZpZXdlcnMsDQo+IA0KPiBLaW5kbHkgcmV2aWV3LiBUaGFua3MuDQo+IA0K
PiBPbiAxLzIwLzIwMjAgMTE6NTQgQU0sIFNhbWVlciBQdWphciB3cm90ZToNCj4gPiBSZW1vdmlu
ZyBCYXJkKGJhcmRsaWFvQHJlYWx0ZWsuY29tKSBmcm9tICJ0byIgbGlzdCBzaW5jZSBJIGFtIGdl
dHRpbmcNCj4gPiB1bmRlbGl2ZXJlZCBtZXNzYWdlLg0KPiA+DQo+ID4gT2RlciwNCj4gPiBQbGVh
c2UgYWRkIHJpZ2h0IGZvbGtzIGFzIHlvdSBmZWVsIG5lY2Vzc2FyeS4gVGhhbmtzLg0KPiA+DQo+
ID4gT24gMS8yMC8yMDIwIDExOjQ3IEFNLCBTYW1lZXIgUHVqYXIgd3JvdGU6DQo+ID4+IEFMQzU2
NTkgc3VwcG9ydHMgbWF4aW11bSBkYXRhIGxlbmd0aCBvZiAyNC1iaXQuIEN1cnJlbnRseSBkcml2
ZXINCj4gPj4gc3VwcG9ydHMNCj4gPj4gUzI0X0xFIHdoaWNoIGlzIGEgMzItYml0IGNvbnRhaW5l
ciB3aXRoIHZhbGlkIGRhdGEgaW4gWzIzOjBdIGFuZCAwcw0KPiA+PiBpbiBNU0IuDQo+ID4+IFMy
NF8zTEUgaXMgbm90IGNvbW1vbmx5IHVzZWQgYW5kIGlzIGhhcmQgdG8gZmluZCBhdWRpbyBzdHJl
YW1zIHdpdGggdGhpcw0KPiA+PiBmb3JtYXQuIEFsc28gbWFueSBTb0MgSFcgZG8gbm90IHN1cHBv
cnQgUzI0X0xFIGFuZCBTMzJfTEUgaXMgdXNlZCBpbg0KPiA+PiBnZW5lcmFsLiBUaGUgMjQtYml0
IGRhdGEgY2FuIGJlIHJlcHJlc2VudGVkIGluIFMzMl9MRSBbMzE6OF0gYW5kIDBzIGFyZQ0KPiA+
PiBwYWRkZWQgaW4gTFNCLg0KPiA+Pg0KPiA+PiBUaGlzIHBhdGNoIGFkZHMgUzMyX0xFIHRvIEFM
QzU2NTkgZHJpdmVyIGFuZCBkYXRhIGxlbmd0aCBmb3IgdGhpcyBpcyBzZXQNCj4gPj4gdG8gMjQg
YXMgcGVyIGNvZGVjJ3MgbWF4aW11bSBkYXRhIGxlbmd0aCBzdXBwb3J0LiBUaGlzIGhlbHBzIHRv
IHBsYXkNCj4gPj4gMjQtYml0IGF1ZGlvLCBwYWNrZWQgaW4gUzMyX0xFLCBvbiBIVyB3aGljaCBk
byBub3Qgc3VwcG9ydCBTMjRfTEUuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IFNhbWVlciBQ
dWphciA8c3B1amFyQG52aWRpYS5jb20+DQo+ID4+IC0tLQ0KPiA+PiDCoCBzb3VuZC9zb2MvY29k
ZWNzL3J0NTY1OS5jIHwgNCArKystDQo+ID4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9j
b2RlY3MvcnQ1NjU5LmMgYi9zb3VuZC9zb2MvY29kZWNzL3J0NTY1OS5jDQo+ID4+IGluZGV4IGZj
NzRkZDYzLi5mOTEwZGRmIDEwMDY0NA0KPiA+PiAtLS0gYS9zb3VuZC9zb2MvY29kZWNzL3J0NTY1
OS5jDQo+ID4+ICsrKyBiL3NvdW5kL3NvYy9jb2RlY3MvcnQ1NjU5LmMNCj4gPj4gQEAgLTMzMzks
NiArMzMzOSw3IEBAIHN0YXRpYyBpbnQgcnQ1NjU5X2h3X3BhcmFtcyhzdHJ1Y3QNCj4gPj4gc25k
X3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSwNCj4gPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHZhbF9s
ZW4gfD0gUlQ1NjU5X0kyU19ETF8yMDsNCj4gPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOw0K
PiA+PiDCoMKgwqDCoMKgIGNhc2UgMjQ6DQo+ID4+ICvCoMKgwqAgY2FzZSAzMjoNCj4gPj4gwqDC
oMKgwqDCoMKgwqDCoMKgIHZhbF9sZW4gfD0gUlQ1NjU5X0kyU19ETF8yNDsNCj4gPj4gwqDCoMKg
wqDCoMKgwqDCoMKgIGJyZWFrOw0KPiA+PiDCoMKgwqDCoMKgIGNhc2UgODoNCj4gPj4gQEAgLTM3
MzMsNyArMzczNCw4IEBAIHN0YXRpYyBpbnQgcnQ1NjU5X3Jlc3VtZShzdHJ1Y3QNCj4gPj4gc25k
X3NvY19jb21wb25lbnQgKmNvbXBvbmVudCkNCj4gPj4gwqAgwqAgI2RlZmluZSBSVDU2NTlfU1RF
UkVPX1JBVEVTIFNORFJWX1BDTV9SQVRFXzgwMDBfMTkyMDAwDQo+ID4+IMKgICNkZWZpbmUgUlQ1
NjU5X0ZPUk1BVFMgKFNORFJWX1BDTV9GTVRCSVRfUzE2X0xFIHwNCj4gPj4gU05EUlZfUENNX0ZN
VEJJVF9TMjBfM0xFIHwgXA0KPiA+PiAtwqDCoMKgwqDCoMKgwqAgU05EUlZfUENNX0ZNVEJJVF9T
MjRfTEUgfCBTTkRSVl9QQ01fRk1UQklUX1M4KQ0KPiA+PiArwqDCoMKgwqDCoMKgwqAgU05EUlZf
UENNX0ZNVEJJVF9TMjRfTEUgfCBTTkRSVl9QQ01fRk1UQklUX1MzMl9MRSB8IFwNCj4gPj4gK8Kg
wqDCoMKgwqDCoMKgIFNORFJWX1BDTV9GTVRCSVRfUzgpDQo+ID4+IMKgIMKgIHN0YXRpYyBjb25z
dCBzdHJ1Y3Qgc25kX3NvY19kYWlfb3BzIHJ0NTY1OV9haWZfZGFpX29wcyA9IHsNCj4gPj4gwqDC
oMKgwqDCoCAuaHdfcGFyYW1zID0gcnQ1NjU5X2h3X3BhcmFtcywNCj4gDQo+IA0KPiAtLS0tLS1Q
bGVhc2UgY29uc2lkZXIgdGhlIGVudmlyb25tZW50IGJlZm9yZSBwcmludGluZyB0aGlzIGUtbWFp
bC4NCg==
