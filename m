Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2506AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BFE92071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388968AbgEYG6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 02:58:16 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:55106 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388630AbgEYG6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 02:58:12 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04P6vujB7007015, This message is accepted by code: ctloc85258
Received: from RS-CAS02.realsil.com.cn (doc.realsil.com.cn[172.29.17.3])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04P6vujB7007015
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 25 May 2020 14:57:59 +0800
Received: from RS-MBS01.realsil.com.cn ([::1]) by RS-CAS02.realsil.com.cn
 ([::1]) with mapi id 14.03.0439.000; Mon, 25 May 2020 14:57:56 +0800
From:   =?utf-8?B?5Yav6ZSQ?= <rui_feng@realsil.com.cn>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIFtWMl0gbW1jOiBydHN4OiBBZGQgU0QgRXhwcmVz?= =?utf-8?Q?s_mode_support_for_RTS5261?=
Thread-Topic: [PATCH] [V2] mmc: rtsx: Add SD Express mode support for RTS5261
Thread-Index: AQHWLbNp9MwhKj9p/EOP51J51uncK6izUesAgAAVIICABPHGMA==
Date:   Mon, 25 May 2020 06:57:56 +0000
Message-ID: <2A308283684ECD4B896628E09AF5361E59ACF600@RS-MBS01.realsil.com.cn>
References: <1589875163-3367-1-git-send-email-rui_feng@realsil.com.cn>
 <20200522091646.GA1201234@kroah.com>
 <CAK8P3a3Uk_fmJ3UA1nuChHLC6w3p_wZfkqqRLvB01W0uLEE3-w@mail.gmail.com>
In-Reply-To: <CAK8P3a3Uk_fmJ3UA1nuChHLC6w3p_wZfkqqRLvB01W0uLEE3-w@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.29.40.150]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBGcmksIE1heSAyMiwgMjAyMCBhdCAxMToxNiBBTSBHcmVnIEtIIDxncmVna2hAbGludXhm
b3VuZGF0aW9uLm9yZz4NCj4gd3JvdGU6DQo+ID4NCj4gPiBPbiBUdWUsIE1heSAxOSwgMjAyMCBh
dCAwMzo1OToyM1BNICswODAwLCBydWlfZmVuZ0ByZWFsc2lsLmNvbS5jbiB3cm90ZToNCj4gPiA+
IEZyb206IHJ1aV9mZW5nIDxydWlfZmVuZ0ByZWFsc2lsLmNvbS5jbj4NCj4gPiA+DQo+ID4gPiBS
VFM1MjYxIHN1cHBvcnQgbGVnYWN5IFNEIG1vZGUgYW5kIFNEIEV4cHJlc3MgbW9kZS4NCj4gPiA+
IEluIFNENy54LCBTRCBhc3NvY2lhdGlvbiBpbnRyb2R1Y2UgU0QgRXhwcmVzcyBhcyBhIG5ldyBt
b2RlLg0KPiA+ID4gU0QgRXhwcmVzcyBtb2RlIGlzIGRpc3Rpbmd1aXNoZWQgYnkgQ01EOC4NCj4g
PiA+IFRoZXJlZm9yZSwgQ01EOCBoYXMgbmV3IGJpdCBmb3IgU0QgRXhwcmVzcy4NCj4gPiA+IFNE
IEV4cHJlc3MgaXMgYmFzZWQgb24gUENJZS9OVk1lLg0KPiA+ID4gUlRTNTI2MSB1c2VzIENNRDgg
dG8gc3dpdGNoIHRvIFNEIEV4cHJlc3MgbW9kZS4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBydWlfZmVuZyA8cnVpX2ZlbmdAcmVhbHNpbC5jb20uY24+DQo+ID4gPiAtLS0NCj4gPiA+IHYy
OiByZW1vdmUgY29uZmlnIG9wdGlvbiBNSVNDX1JUU1hfUENJX1NEX0VYUFJFU1MNCj4gPiA+IC0t
LQ0KPiA+ID4NCj4gPiA+ICBkcml2ZXJzL21pc2MvY2FyZHJlYWRlci9ydHM1MjYxLmMgIHwgIDUg
KysrKw0KPiA+ID4gZHJpdmVycy9taXNjL2NhcmRyZWFkZXIvcnRzNTI2MS5oICB8IDIzIC0tLS0t
LS0tLS0tLS0tLS0NCj4gPiA+IGRyaXZlcnMvbWlzYy9jYXJkcmVhZGVyL3J0c3hfcGNyLmMgfCAg
NSArKysrDQo+ID4gPiAgZHJpdmVycy9tbWMvY29yZS9zZF9vcHMuYyAgICAgICAgICB8ICA5ICsr
KysrKy0NCj4gPiA+ICBkcml2ZXJzL21tYy9ob3N0L3J0c3hfcGNpX3NkbW1jLmMgIHwgNDMNCj4g
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiAgaW5jbHVkZS9saW51eC9tbWMv
aG9zdC5oICAgICAgICAgICB8ICAxICsNCj4gPiA+ICBpbmNsdWRlL2xpbnV4L3J0c3hfcGNpLmgg
ICAgICAgICAgIHwgMjcgKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gIDcgZmlsZXMgY2hhbmdl
ZCwgODkgaW5zZXJ0aW9ucygrKSwgMjQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBJZiBJIGNhbiBn
ZXQgYW4gYWNrIGZyb20gdGhlIE1NQyBtYWludGFpbmVyLCBJIGNhbiB0YWtlIHRoaXMgaW4gbXkN
Cj4gPiB0cmVlLi4uDQo+ID4NCj4gPiB7aGludH0NCj4gDQo+IEkgdGhpbmsgdGhpcyBmZWF0dXJl
IG5lZWRzIG11Y2ggbW9yZSBkaXNjdXNzaW9uIHRvIG1ha2Ugc3VyZSB3ZSBnZXQgYSBnb29kDQo+
IHVzZXIgZXhwZXJpZW5jZSB3aGVuIGl0IGdldHMgYWRkZWQgdG8gYWxsIG1tYyBjb250cm9sbGVy
cy4NCj4gDQpPbmx5IFJUUzUyNjEgaXMgYWZmZWN0ZWQgYnkgdGhpcyBwYXRjaC4gT3RoZXIgdmVu
ZG9yJ3MgcmVhZGVyIHdvbid0IGJlIGFmZmVjdGVkLg0KDQo+IHJ0c3ggaXMgYSBiaXQgb2YgYSBz
cGVjaWFsIGNhc2UgZm9yIG1tYyBjb250cm9sbGVycyBhbHJlYWR5LCBidXQgd2Ugd2lsbCBsaWtl
bHkgc2VlDQo+IHRoZSBzYW1lIHJlcXVpcmVtZW50cyBmb3IgYSBsb3QgbW9yZSBtbWMgaG9zdCBk
cml2ZXJzLg0KPiANClRoZSBtb2RpZmljYXRpb24gaW4gbW1jIGNvcmUgaW4gdGhpcyBwYXRjaCBp
cyBhY2NvcmRpbmcgdG8gY2hhcHRlciA0LjMuMTMgaW4gdGhlIHNwZWMgIlBoeXNpY2FsIExheWVy
IFNpbXBsaWZpZWQgU3BlY2lmaWNhdGlvbiBWZXJzaW9uIDcuMTAiIHJlbGVhc2VkIGJ5IFNEIEFz
c29jaWF0aW9uLA0KYW55b25lIGNhbiBnZXQgaXQgb24gaHR0cHM6Ly93d3cuc2RjYXJkLm9yZy9k
b3dubG9hZHMvcGxzL2luZGV4Lmh0bWwuIEFueSBvdGhlciB2ZW5kb3Igd2hpY2ggd2FudCB0byBz
dXBwb3J0IFNENy54IG11c3Qgb2JleSB0aGUgc3BlYy4NCg0KPiBJIHN1c3BlY3Qgd2UgbmVlZCB0
byB0aWUgaW4gYm90aCB0aGUgbW1jIGJsb2NrIGFuZCBudm1lIGRldmljZSBkcml2ZXJzIHRvDQo+
IHByb3Blcmx5IGRvIGEgaGFuZG92ZXIsIHRvIGVuc3VyZSB0aGF0IHRoZXJlIGlzIGEgd2F5IHRv
IGlkZW50aWZ5IHRoZSBibG9jaw0KPiBkZXZpY2UgYXMgcmVsaWFibHkgZ2V0dGluZyBwcm9iZWQg
YXMgYXQgbGVhc3Qgb25lIG9mIHRoZSB0d28gKHNkIG9yIG52bWUpIGFuZCB0bw0KPiBnZXQgaWRl
bnRpZmllZCBhcyB0aGUgc2FtZSBkZXZpY2UgZHVyaW5nIHRoZSBoYW5kb3ZlciwgaW4gcGFydGlj
dWxhciBhY3Jvc3MgYQ0KPiBzdXNwZW5kIG9yIGhpYmVybmF0ZSBldmVudC4NCj4gDQpPdXIgY2Fy
ZCByZWFkZXIgd2lsbCBiZSB0ZXN0ZWQgYnkgT0RNL09FTSBiZWZvcmUgdXNlZCBieSBlbmQgdXNl
cnMuDQoNCktpbmQgcmVnYXJkcw0K
