Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00482C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9B172078B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389740AbgEYKLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 06:11:55 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:46027 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389356AbgEYKLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 06:11:54 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04PABiTT2029022, This message is accepted by code: ctloc85258
Received: from RS-CAS02.realsil.com.cn (ms1.realsil.com.cn[172.29.17.3])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04PABiTT2029022
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 25 May 2020 18:11:45 +0800
Received: from RS-MBS01.realsil.com.cn ([::1]) by RS-CAS02.realsil.com.cn
 ([::1]) with mapi id 14.03.0439.000; Mon, 25 May 2020 18:11:45 +0800
From:   =?utf-8?B?5Yav6ZSQ?= <rui_feng@realsil.com.cn>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIFtWMl0gbW1jOiBydHN4OiBBZGQgU0QgRXhwcmVz?= =?utf-8?Q?s_mode_support_for_RTS5261?=
Thread-Topic: [PATCH] [V2] mmc: rtsx: Add SD Express mode support for RTS5261
Thread-Index: AQHWLbNp9MwhKj9p/EOP51J51uncK6izUesAgAAVIICABPHGMP//tYyAgACKUyA=
Date:   Mon, 25 May 2020 10:11:44 +0000
Message-ID: <2A308283684ECD4B896628E09AF5361E59ACF71F@RS-MBS01.realsil.com.cn>
References: <1589875163-3367-1-git-send-email-rui_feng@realsil.com.cn>
 <20200522091646.GA1201234@kroah.com>
 <CAK8P3a3Uk_fmJ3UA1nuChHLC6w3p_wZfkqqRLvB01W0uLEE3-w@mail.gmail.com>
 <2A308283684ECD4B896628E09AF5361E59ACF600@RS-MBS01.realsil.com.cn>
 <CAK8P3a13P0NuogaQtvSAZRbJb5OaccVxegvqKpynWO65Ye3iKA@mail.gmail.com>
In-Reply-To: <CAK8P3a13P0NuogaQtvSAZRbJb5OaccVxegvqKpynWO65Ye3iKA@mail.gmail.com>
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

PiBPbiBNb24sIE1heSAyNSwgMjAyMCBhdCA4OjU4IEFNIOWGr+mUkCA8cnVpX2ZlbmdAcmVhbHNp
bC5jb20uY24+IHdyb3RlOg0KPiA+ID4gT24gRnJpLCBNYXkgMjIsIDIwMjAgYXQgMTE6MTYgQU0g
R3JlZyBLSCA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+IHdyb3RlOg0KPiA+ID4gPg0K
PiA+ID4gPiBJZiBJIGNhbiBnZXQgYW4gYWNrIGZyb20gdGhlIE1NQyBtYWludGFpbmVyLCBJIGNh
biB0YWtlIHRoaXMgaW4gbXkNCj4gPiA+ID4gdHJlZS4uLg0KPiA+ID4gPg0KPiA+ID4gPiB7aGlu
dH0NCj4gPiA+DQo+ID4gPiBJIHRoaW5rIHRoaXMgZmVhdHVyZSBuZWVkcyBtdWNoIG1vcmUgZGlz
Y3Vzc2lvbiB0byBtYWtlIHN1cmUgd2UgZ2V0DQo+ID4gPiBhIGdvb2QgdXNlciBleHBlcmllbmNl
IHdoZW4gaXQgZ2V0cyBhZGRlZCB0byBhbGwgbW1jIGNvbnRyb2xsZXJzLg0KPiA+ID4NCj4gPiBP
bmx5IFJUUzUyNjEgaXMgYWZmZWN0ZWQgYnkgdGhpcyBwYXRjaC4gT3RoZXIgdmVuZG9yJ3MgcmVh
ZGVyIHdvbid0IGJlDQo+IGFmZmVjdGVkLg0KPiANCj4gVGhhdCBzb3VuZHMgbGlrZSBhbm90aGVy
IHByb2JsZW0gd2l0aCB0aGlzIHBhdGNoOg0KPiANCj4gVGhlIHRyYW5zaXRpb24gc2hvdWxkIHBy
b2JhYmx5IGJlIGhhbmRsZWQgYnkgdGhlIE1NQyBjb3JlIGNoZWNraW5nIHdoZXRoZXINCj4gdGhl
IGtlcm5lbCwgdGhlIG1tYyBob3N0IGFuZCBhbmQgdGhlIGNhcmQgYWxsIHN1cHBvcnQgU0QgZXhw
cmVzcyBtb2RlLCBhbmQNCj4gdGhlbiBzdGFydCB0aGUgdHJhbnNpdGlvbiBhcyB3ZWxsIGFzIGZh
bGxpbmcgYmFjayB0byBTRCBtb2RlIGlmIGl0IGRvZXNuJ3QgY29tZSB1cA0KPiBwcm9wZXJseS4N
Cj4gDQpUaGUgcHVycG9zZSBvZiB0aGUgbW9kaWZpY2F0aW9uIGluIG1tYyBjb3JlIG9mIHRoaXMg
cGF0Y2ggaXMgdG8gbGV0IHRoZSBrZXJuZWwgaGFzIHRoZSBhYmlsaXR5DQp0byBjaGVjayB3aGV0
aGVyIHRoZSBjYXJkIHN1cHBvcnQgU0QgZXhwcmVzcyBtb2RlIGFjY29yZGluZyB0byBTRCBzcGVj
aWZpY2F0aW9uLg0KSWYgUlRTNTI2MSBzd2l0Y2ggdG8gU0QgZXhwcmVzcyBtb2RlIGZhaWxlZCwg
UlRTNTI2MSB3aWxsIGZhbGwgYmFjayB0byBTRCBtb2RlIGJ5IGl0c2VsZg0KYW5kIEl0IGRvZXNu
J3QgbmVlZCBtbWMgZHJpdmVyIHRvIGRvIGFueXRoaW5nLiBBZnRlciBmYWxsaW5nIGJhY2sgdG8g
U0QgbW9kZSwgbW1jIGRyaXZlcg0Kd2lsbCBoYW5kbGUgdGhlIFNEIGNhcmQgaW4gU0QgbW9kZSBh
cyBiZWZvcmUgd2l0aG91dCB0aGlzIHBhdGNoLg0KDQpLaW5kIHJlZ2FyZHMNCg==
