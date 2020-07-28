Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F376AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C002920759
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Jc2W9zzM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgG1GFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 02:05:25 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:24158 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726299AbgG1GFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 02:05:25 -0400
X-UUID: aa1603cb9da14371ba43930da6e229b0-20200728
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=AADhamlj39RN1HLMjk0Vd+a3ULVjb3Y/W/BXe2Dhrbo=;
        b=Jc2W9zzMWeaQDwqgekP8xAWsHw346+dMPO5EUuAicpIAK5m2OclwoooIVzMNy//6JVG/WHbXOxM+8GOOB6dwkqIGoR8+L4YcYjlN9P5cohmsi28maKzqGST1pFiYIjcTnJvU3E0lQ2MIvNMNI6A4y3ZIEdv2EWC6uO+6a4vuHFo=;
X-UUID: aa1603cb9da14371ba43930da6e229b0-20200728
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 796666277; Tue, 28 Jul 2020 14:05:12 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 28 Jul
 2020 14:05:04 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 28 Jul 2020 14:05:06 +0800
Message-ID: <1595916283.21478.3.camel@mhfsdcap03>
Subject: Re: [RESEND PATCH] usb: common: usb-conn-gpio: Register optional
 charger
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, <od@zcrc.me>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 28 Jul 2020 14:04:43 +0800
In-Reply-To: <Z4V4EQ.I8UQ5TF3SBJ61@crapouillou.net>
References: <20200621224807.882184-1-paul@crapouillou.net>
         <CAHp75VcfhDncqP_hSVvRNc_vY0fOYaoxm-tiCm2G92Xrisb9hA@mail.gmail.com>
         <FPN2EQ.RC89XKRQDKRN3@crapouillou.net>
         <1595828558.23885.90.camel@mhfsdcap03>
         <Z4V4EQ.I8UQ5TF3SBJ61@crapouillou.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 6ABC9B290E16A3EF990DFC966CA70D04FD107373D83DCB7A2955348E43ECF2402000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA3LTI3IGF0IDE3OjAyICswMjAwLCBQYXVsIENlcmN1ZWlsIHdyb3RlOg0K
PiANCj4gTGUgbHVuLiAyNyBqdWlsLiAyMDIwIMOgIDEzOjQyLCBDaHVuZmVuZyBZdW4gDQo+IDxj
aHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPiBhIMOpY3JpdCA6DQo+ID4gT24gU3VuLCAyMDIwLTA3
LTI2IGF0IDEyOjI3ICswMjAwLCBQYXVsIENlcmN1ZWlsIHdyb3RlOg0KPiA+PiANCj4gPj4gIExl
IGRpbS4gMjYganVpbC4gMjAyMCDDoCAxMzoxNCwgQW5keSBTaGV2Y2hlbmtvDQo+ID4+ICA8YW5k
eS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4gYSDDqWNyaXQgOg0KPiA+PiAgPiBPbiBNb24sIEp1biAy
MiwgMjAyMCBhdCAxOjUxIEFNIFBhdWwgQ2VyY3VlaWwgDQo+ID4+IDxwYXVsQGNyYXBvdWlsbG91
Lm5ldD4NCj4gPj4gID4gd3JvdGU6DQo+ID4+ICA+Pg0KPiA+PiAgPj4gIFJlZ2lzdGVyIGEgcG93
ZXIgc3VwcGx5IGNoYXJnZXIsIGlmIHRoZSBLY29uZmlnIG9wdGlvbg0KPiA+PiAgPj4gIFVTQl9D
T05OX0dQSU9fQ0hBUkdFUiBpcyBzZXQsIHdob3NlIG9ubGluZSBzdGF0ZSBkZXBlbmRzIG9uIA0K
PiA+PiB3aGV0aGVyDQo+ID4+ICA+PiAgdGhlIFVTQiByb2xlIGlzIHNldCB0byBkZXZpY2Ugb3Ig
bm90Lg0KPiA+PiAgPj4NCj4gPj4gID4+ICBUaGlzIGlzIHVzZWZ1bCB3aGVuIHRoZSBVU0Igcm9s
ZSBpcyB0aGUgb25seSB3YXkgdG8ga25vdyBpZiB0aGUNCj4gPj4gID4+IGRldmljZQ0KPiA+PiAg
Pj4gIGlzIGNoYXJnaW5nIGZyb20gVVNCLiBUaGUgQVBJIGlzIHRoZSBzdGFuZGFyZCBwb3dlciBz
dXBwbHkgDQo+ID4+IGNoYXJnZXINCj4gPj4gID4+IEFQSSwNCj4gPj4gID4+ICB5b3UgZ2V0IGEg
L3N5cy9jbGFzcy9wb3dlcl9zdXBwbHkveHh4L29ubGluZSBub2RlIHdoaWNoIHRlbGxzIA0KPiA+
PiB5b3UNCj4gPj4gID4+IHRoZQ0KPiA+PiAgPj4gIHN0YXRlIG9mIHRoZSBjaGFyZ2VyLg0KPiA+
PiAgPj4NCj4gPj4gID4+ICBUaGUgc29sZSBwdXJwb3NlIG9mIHRoaXMgaXMgdG8gZ2l2ZSB1c2Vy
c3BhY2UgYXBwbGljYXRpb25zIGEgDQo+ID4+IHdheSB0bw0KPiA+PiAgPj4gIGtub3cgd2hldGhl
ciBvciBub3QgdGhlIGNoYXJnZXIgaXMgcGx1Z2dlZC4NClsuLi5dDQo+ID4+ICA+PiAgKyAgICAg
ICBzd2l0Y2ggKHBzcCkgew0KPiA+PiAgPj4gICsgICAgICAgY2FzZSBQT1dFUl9TVVBQTFlfUFJP
UF9PTkxJTkU6DQo+ID4+ICA+PiAgKyAgICAgICAgICAgICAgIHZhbC0+aW50dmFsID0gaW5mby0+
bGFzdF9yb2xlID09IA0KPiA+PiBVU0JfUk9MRV9ERVZJQ0U7DQo+ID4gV2hhdCB3aWxsIGhhcHBl
biBpZiB5b3Ugbm90IGNoYW5nZSBpbmZvLT5sYXN0X3JvbGUgaGVyZT8NCj4gPiBJIHByZWZlciBp
dCdzIG9ubHkgY2hhbmdlZCBieSB1c2JfY29ubl9pc3IoKSwgaWYgaXQncyBjaGFuZ2VkIGJ5IG90
aGVyDQo+ID4gZHJpdmVycywgZm9yIGV4YW1wbGUsIHRocm91Z2ggcG93ZXJfc3VwcGx5X2dldF9w
cm9wZXJ0eSgpLCBtYXkgc2tpcCANCj4gPiByb2xlDQo+ID4gc3dpdGNoLg0KPiANCj4gSWYgeW91
IHJlYWQgY2FyZWZ1bGx5LCBpbmZvLT5sYXN0X3JvbGUgaXMgbm90IG1vZGlmaWVkIGhlcmUgOikN
ClNvcnJ5LCBteSBiYWQNCg0KPiANCj4gLVBhdWwNCj4gDQo+ID4gDQo+ID4+ICA+PiAgKyAgICAg
ICAgICAgICAgIGJyZWFrOw0KPiA+PiAgPj4gICsgICAgICAgZGVmYXVsdDoNCj4gPj4gID4+ICAr
ICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4+ICA+PiAgKyAgICAgICB9DQo+ID4+
ICA+PiAgKw0KPiA+PiAgPj4gICsgICAgICAgcmV0dXJuIDA7DQo+ID4+ICA+PiAgK30NCj4gPj4g
ID4+ICArDQo+ID4+ICA+PiAgIHN0YXRpYyBpbnQgdXNiX2Nvbm5fcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikNCj4gPj4gID4+ICAgew0KPiA+PiAgPj4gICAgICAgICAgc3RydWN0
IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gPj4gID4+ICArICAgICAgIHN0cnVjdCBwb3dl
cl9zdXBwbHlfZGVzYyAqZGVzYzsNCj4gPj4gID4+ICAgICAgICAgIHN0cnVjdCB1c2JfY29ubl9p
bmZvICppbmZvOw0KPiA+PiAgPj4gICsgICAgICAgc3RydWN0IHBvd2VyX3N1cHBseV9jb25maWcg
Y2ZnID0gew0KPiA+PiAgPj4gICsgICAgICAgICAgICAgICAub2Zfbm9kZSA9IGRldi0+b2Zfbm9k
ZSwNCj4gPj4gID4+ICArICAgICAgIH07DQo+ID4+ICA+PiAgICAgICAgICBpbnQgcmV0ID0gMDsN
Cj4gPj4gID4+DQo+ID4+ICA+PiAgICAgICAgICBpbmZvID0gZGV2bV9remFsbG9jKGRldiwgc2l6
ZW9mKCppbmZvKSwgR0ZQX0tFUk5FTCk7DQo+ID4+ICA+PiAgQEAgLTIwMyw2ICsyMzQsMjIgQEAg
c3RhdGljIGludCB1c2JfY29ubl9wcm9iZShzdHJ1Y3QNCj4gPj4gID4+IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikNCj4gPj4gID4+ICAgICAgICAgICAgICAgICAgfQ0KPiA+PiAgPj4gICAgICAgICAg
fQ0KPiA+PiAgPj4NCj4gPj4gID4+ICArICAgICAgIGlmIChJU19FTkFCTEVEKENPTkZJR19VU0Jf
Q09OTl9HUElPX0NIQVJHRVIpKSB7DQo+ID4+ICA+PiAgKyAgICAgICAgICAgICAgIGRlc2MgPSAm
aW5mby0+ZGVzYzsNCj4gPj4gID4+ICArICAgICAgICAgICAgICAgZGVzYy0+bmFtZSA9ICJ1c2It
Y2hhcmdlciI7DQo+ID4+ICA+PiAgKyAgICAgICAgICAgICAgIGRlc2MtPnByb3BlcnRpZXMgPSB1
c2JfY2hhcmdlcl9wcm9wZXJ0aWVzOw0KPiA+PiAgPj4gICsgICAgICAgICAgICAgICBkZXNjLT5u
dW1fcHJvcGVydGllcyA9DQo+ID4+ICA+PiBBUlJBWV9TSVpFKHVzYl9jaGFyZ2VyX3Byb3BlcnRp
ZXMpOw0KPiA+PiAgPj4gICsgICAgICAgICAgICAgICBkZXNjLT5nZXRfcHJvcGVydHkgPSB1c2Jf
Y2hhcmdlcl9nZXRfcHJvcGVydHk7DQo+ID4+ICA+PiAgKyAgICAgICAgICAgICAgIGRlc2MtPnR5
cGUgPSBQT1dFUl9TVVBQTFlfVFlQRV9VU0I7DQo+ID4+ICA+PiAgKyAgICAgICAgICAgICAgIGNm
Zy5kcnZfZGF0YSA9IGluZm87DQo+ID4+ICA+PiAgKw0KPiA+PiAgPj4gICsgICAgICAgICAgICAg
ICBpbmZvLT5jaGFyZ2VyID0gZGV2bV9wb3dlcl9zdXBwbHlfcmVnaXN0ZXIoZGV2LA0KPiA+PiAg
Pj4gZGVzYywgJmNmZyk7DQo+ID4+ICA+PiAgKyAgICAgICAgICAgICAgIGlmIChJU19FUlIoaW5m
by0+Y2hhcmdlcikpIHsNCj4gPj4gID4+ICArICAgICAgICAgICAgICAgICAgICAgICBkZXZfZXJy
KGRldiwgIlVuYWJsZSB0byByZWdpc3Rlcg0KPiA+PiAgPj4gY2hhcmdlclxuIik7DQo+ID4+ICA+
PiAgKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIoaW5mby0+Y2hhcmdlcik7
DQo+ID4+ICA+PiAgKyAgICAgICAgICAgICAgIH0NCj4gPj4gID4+ICArICAgICAgIH0NCj4gPj4g
ID4+ICArDQo+ID4+ICA+PiAgICAgICAgICBwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBpbmZv
KTsNCj4gPj4gID4+DQo+ID4+ICA+PiAgICAgICAgICAvKiBQZXJmb3JtIGluaXRpYWwgZGV0ZWN0
aW9uICovDQo+ID4+ICA+PiAgLS0NCj4gPj4gID4+ICAyLjI3LjANCj4gPj4gID4+DQo+ID4+ICA+
DQo+ID4+ICA+DQo+ID4+ICA+IC0tDQo+ID4+ICA+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiA+PiAg
PiBBbmR5IFNoZXZjaGVua28NCj4gPj4gDQo+ID4+IA0KPiA+IA0KPiANCj4gDQoNCg==

