Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB0EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71FE12080D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgGWIga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 04:36:30 -0400
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:9145 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725858AbgGWIga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 04:36:30 -0400
Received: from zxbjmbx3.zhaoxin.com (10.29.252.165) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 23 Jul
 2020 16:36:26 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx3.zhaoxin.com
 (10.29.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 23 Jul
 2020 16:36:25 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416]) by
 zxbjmbx1.zhaoxin.com ([fe80::290a:f538:51e7:1416%16]) with mapi id
 15.01.1979.003; Thu, 23 Jul 2020 16:36:25 +0800
From:   WeitaoWang-oc <WeitaoWang-oc@zhaoxin.com>
To:     Alex Williamson <alex.williamson@redhat.com>,
        WeitaoWang-oc <WeitaoWang-oc@zhaoxin.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "hslester96@gmail.com" <hslester96@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Carsten_Schmid@mentor.com" <Carsten_Schmid@mentor.com>,
        "efremov@linux.com" <efremov@linux.com>,
        "Tony W. Wang(XA-RD)" <TonyWWang@zhaoxin.com>,
        "Cobe Chen(BJ-RD)" <CobeChen@zhaoxin.com>,
        "Tim Guo(BJ-RD)" <TimGuo@zhaoxin.com>,
        "wwt8723@163.com" <wwt8723@163.com>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIFVTQjpGaXgga2VybmVsIE5VTEwgcG9pbnRlciB3?=
 =?utf-8?Q?hen_unbind_UHCI_form_vfio-pci?=
Thread-Topic: [PATCH] USB:Fix kernel NULL pointer when unbind UHCI form
 vfio-pci
Thread-Index: AQHWYB9U257QN8g5QkeL/njIDTUWtqkUAziAgABPH2A=
Date:   Thu, 23 Jul 2020 08:36:25 +0000
Message-ID: <371b3697614e4034aed8e9f340a7dbf1@zhaoxin.com>
References: <1595419068-4812-1-git-send-email-WeitaoWang-oc@zhaoxin.com>
 <20200722215313.5a842b93@x1.home>
In-Reply-To: <20200722215313.5a842b93@x1.home>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.29.8.32]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBUaHUsMjMgSnVseSAyMDIwIDA0OjE4OjAwICswMDAwIEFsZXggd3JvdGU6DQo+IE9uIFdl
ZCwgMjIgSnVsIDIwMjAgMTk6NTc6NDggKzA4MDANCj4gV2VpdGFvV2FuZ29jIDxXZWl0YW9XYW5n
LW9jQHpoYW94aW4uY29tPiB3cm90ZToNCj4gDQo+ID4gIGRyaXZlcnMvdXNiL2NvcmUvaGNkLXBj
aS5jIHwgNSArKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvY29yZS9oY2QtcGNpLmMgYi9kcml2ZXJzL3Vz
Yi9jb3JlL2hjZC1wY2kuYw0KPiA+IGluZGV4IDE1NDdhYTYuLjQ4NGYyYTAgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy91c2IvY29yZS9oY2QtcGNpLmMNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9j
b3JlL2hjZC1wY2kuYw0KPiA+IEBAIC0zNCw2ICszNCw3IEBAIHN0YXRpYyBERUNMQVJFX1JXU0VN
KGNvbXBhbmlvbnNfcndzZW0pOw0KPiA+ICAjZGVmaW5lIENMX09IQ0kgICAgICAgICAgICAgICAg
UENJX0NMQVNTX1NFUklBTF9VU0JfT0hDSQ0KPiA+ICAjZGVmaW5lIENMX0VIQ0kgICAgICAgICAg
ICAgICAgUENJX0NMQVNTX1NFUklBTF9VU0JfRUhDSQ0KPiA+DQo+ID4gKyNkZWZpbmUgUENJX0RF
Vl9EUlZfRkxBRyAgICAgICAyDQo+ID4gIHN0YXRpYyBpbmxpbmUgaW50IGlzX29oY2lfb3JfdWhj
aShzdHJ1Y3QgcGNpX2RldiAqcGRldikgIHsNCj4gPiAgICAgICAgIHJldHVybiBwZGV2LT5jbGFz
cyA9PSBDTF9PSENJIHx8IHBkZXYtPmNsYXNzID09IENMX1VIQ0k7IEBADQo+ID4gLTY4LDYgKzY5
LDggQEAgc3RhdGljIHZvaWQgZm9yX2VhY2hfY29tcGFuaW9uKHN0cnVjdCBwY2lfZGV2ICpwZGV2
LCBzdHJ1Y3QNCj4gdXNiX2hjZCAqaGNkLA0KPiA+ICAgICAgICAgICAgICAgICBpZiAoY29tcGFu
aW9uLT5jbGFzcyAhPSBDTF9VSENJICYmIGNvbXBhbmlvbi0+Y2xhc3MgIT0NCj4gQ0xfT0hDSSAm
Jg0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29tcGFuaW9uLT5jbGFzcyAh
PSBDTF9FSENJKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiA+ICsg
ICAgICAgICAgICAgICBpZiAoIShjb21wYW5pb24tPnByaXZfZmxhZ3MgJiBQQ0lfREVWX0RSVl9G
TEFHKSkNCj4gDQo+IEJ1dCBwY2lfZGV2LnByaXZfZmxhZ3MgaXMgcHJpdmF0ZSBkYXRhIGZvciB0
aGUgZHJpdmVyIHRoYXQgY3VycmVudGx5DQo+IG93bnMgdGhlIGRldmljZSwgd2hpY2ggY291bGQg
YmUgdmZpby1wY2kuICBUaGlzIGlzIHJlYWxseSBubyBkaWZmZXJlbnQNCj4gdGhhbiBhc3N1bWlu
ZyB0aGUgc3RydWN0dXJlIGF0IGRldmljZS5kcml2ZXJfZGF0YS4gIElmIHZmaW8tcGNpIHdlcmUg
dG8NCj4gbWFrZSBsZWdpdGltYXRlIHVzZSBvZiBwY2lfZGV2LnByaXZfZmxhZ3MsIHRoaXMgY291
bGQgc2ltcGx5IGJsb3cgdXANCj4gYWdhaW4uICBTaG91bGQgdGhlcmUgaW5zdGVhZCBiZSBzb21l
IHNvcnQgb2YgcmVnaXN0cmF0aW9uIGludGVyZmFjZQ0KPiB3aGVyZSBoY2QgY29tcGxhaW50IGRy
aXZlcnMgcmVnaXN0ZXIgdGhlaXIgZGV2aWNlcyBhbmQgb25seSB0aG9zZQ0KPiByZWdpc3RlcmVk
IGRldmljZXMgY2FuIGhhdmUgdGhlaXIgZHJpdmVyIHByaXZhdGUgZGF0YSBhcmJpdHJhcmlseSBw
b2tlZA0KPiBieSBhbm90aGVyIGRyaXZlcj8gIFRoYW5rcywNCg0KVGhhbmtzIGZvciB5b3VyIGV4
cGxhbmF0aW9uLiBTZXQgcGNpX2Rldi5wcml2X2ZsYWdzIGlzIHJlYWxseSBub3QgYSANCnJlYXNv
bmFibGUgYXBwcm9hY2guIEFyZSB0aGVyZSBhbnkgbW9yZSBkZXRhaWxlZCBzdWdnZXN0aW9ucyAN
CnRvIHBhdGNoIHRoaXMgaXNzdWU/DQoNClRoYW5rcw0KV2VpdGFvd2FuZw0K
