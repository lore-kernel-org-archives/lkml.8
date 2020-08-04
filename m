Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F96C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 625292076E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 08:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbgHDIIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 04:08:44 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:57742 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgHDIIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 04:08:44 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 07488BP00017074, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 07488BP00017074
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 4 Aug 2020 16:08:11 +0800
Received: from RTEXMB05.realtek.com.tw (172.21.6.98) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 4 Aug 2020 16:08:11 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 4 Aug 2020 16:08:10 +0800
Received: from RTEXMB01.realtek.com.tw ([fe80::d53a:d9a5:318:7cd8]) by
 RTEXMB01.realtek.com.tw ([fe80::d53a:d9a5:318:7cd8%5]) with mapi id
 15.01.1779.005; Tue, 4 Aug 2020 16:08:10 +0800
From:   =?utf-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Chris Clayton <chris2553@googlemail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "philquadra@gmail.com" <philquadra@gmail.com>,
        "Arnd Bergmann" <arnd@arndb.de>
Subject: RE: PATCH: rtsx_pci driver - don't disable the rts5229 card reader on Intel NUC boxes
Thread-Topic: PATCH: rtsx_pci driver - don't disable the rts5229 card reader
 on Intel NUC boxes
Thread-Index: AQHWaQXnJbf1udfgtku7UiOjY+d5jakktnGAgAKFU9D//9NfgIAAiHfA
Date:   Tue, 4 Aug 2020 08:08:10 +0000
Message-ID: <11e224ca299b48f1bea07082f2ff7c00@realtek.com>
References: <862172f0-cd23-800c-27b1-27cb49e99099@googlemail.com>
 <a9a94d7f-4873-7a10-4911-f3c760257c5c@googlemail.com>
 <5729c72bbc2740d3917619c85e2fde58@realtek.com>
 <20200804074831.GB1761483@kroah.com>
In-Reply-To: <20200804074831.GB1761483@kroah.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.88.99]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBncmVna2hAbGludXhmb3VuZGF0
aW9uLm9yZyBbbWFpbHRvOmdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnXQ0KPiBTZW50OiBUdWVz
ZGF5LCBBdWd1c3QgMDQsIDIwMjAgMzo0OSBQTQ0KPiBUbzog5ZCz5piK5r6EIFJpY2t5DQo+IENj
OiBDaHJpcyBDbGF5dG9uOyBMS01MOyByZHVubGFwQGluZnJhZGVhZC5vcmc7IHBoaWxxdWFkcmFA
Z21haWwuY29tOyBBcm5kDQo+IEJlcmdtYW5uDQo+IFN1YmplY3Q6IFJlOiBQQVRDSDogcnRzeF9w
Y2kgZHJpdmVyIC0gZG9uJ3QgZGlzYWJsZSB0aGUgcnRzNTIyOSBjYXJkIHJlYWRlciBvbg0KPiBJ
bnRlbCBOVUMgYm94ZXMNCj4gDQo+IE9uIFR1ZSwgQXVnIDA0LCAyMDIwIGF0IDAyOjQ0OjQxQU0g
KzAwMDAsIOWQs+aYiua+hCBSaWNreSB3cm90ZToNCj4gPiBIaSBDaHJpcywNCj4gPg0KPiA+IHJ0
c3hfcGNpX3dyaXRlX3JlZ2lzdGVyKHBjciwgRlBEVEwsIE9DX1BPV0VSX0RPV04sIE9DX1BPV0VS
X0RPV04pOw0KPiA+IFRoaXMgcmVnaXN0ZXIgb3BlcmF0aW9uIHNhdmVkIHBvd2VyIHVuZGVyIDFt
QSwgc28gaWYgZG8gbm90IGNhcmUgdGhlIDFtQQ0KPiBwb3dlciB3ZSBjYW4gaGF2ZSBhIHBhdGNo
IHRvIHJlbW92ZSBpdCwgbWFrZSBjb21wYXRpYmxlIHdpdGggTlVDNg0KPiA+IFdlIHRlc3RlZCBv
dGhlcnMgb3VyIGNhcmQgcmVhZGVyIHRoYXQgcmVtb3ZlIGl0LCB3ZSBkaWQgbm90IHNlZSBhbnkg
c2lkZSBlZmZlY3QNCj4gPg0KPiA+IEhpIEdyZWcgay1oLA0KPiA+DQo+ID4gRG8geW91IGhhdmUg
YW55IGNvbW1lbnRzPw0KPiANCj4gY29tbWVudHMgb24gd2hhdD8gIEkgZG9uJ3Qga25vdyB3aGF0
IHlvdSBhcmUgcmVzcG9uZGluZyB0byBoZXJlLCBzb3JyeS4NCj4gDQpDYW4gd2UgaGF2ZSBhIHBh
dGNoIHRvIGtlcm5lbCBmb3IgTlVDNj8gSXQgbWF5IGNhdXNlIG1vcmUgcG93ZXIoMW1BKSBidXQg
aXQgd2lsbCBoYXZlIG1vcmUgY29tcGF0aWJpbGl0eQ0KDQo+IGdyZWcgay1oDQo+IA0KPiAtLS0t
LS1QbGVhc2UgY29uc2lkZXIgdGhlIGVudmlyb25tZW50IGJlZm9yZSBwcmludGluZyB0aGlzIGUt
bWFpbC4NCg==
