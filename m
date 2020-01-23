Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74166C32771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 02:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B89B2465A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 02:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgAWCGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 21:06:21 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2935 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725911AbgAWCGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 21:06:21 -0500
Received: from DGGEMA402-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 399ACD2DDBA25D13C153;
        Thu, 23 Jan 2020 10:06:17 +0800 (CST)
Received: from DGGEMA503-MBX.china.huawei.com ([169.254.1.134]) by
 DGGEMA402-HUB.china.huawei.com ([10.3.20.43]) with mapi id 14.03.0439.000;
 Thu, 23 Jan 2020 10:06:09 +0800
From:   "liuchao (CR)" <liuchao173@huawei.com>
To:     Neil Horman <nhorman@tuxdriver.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     linfeilong <linfeilong@huawei.com>,
        Hushiyuan <hushiyuan@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PJ Waskiewicz <peter.waskiewicz.jr@intel.com>
Subject: =?gb2312?B?tPC4tDogW1JGQ10gaXJxOiBTa2lwIHByaW50aW5nIGlycSB3aGVuIGRlc2Mt?=
 =?gb2312?Q?>action_is_null_even_if_any=5Fcount_is_not_zero?=
Thread-Topic: [RFC] irq: Skip printing irq when desc->action is null even if
 any_count is not zero
Thread-Index: AQHV0FhHQpMSk+bBcEmPq7VEdHLSsqf2HBoAgABxeQCAAO8zkA==
Date:   Thu, 23 Jan 2020 02:06:09 +0000
Message-ID: <7966953BB2EC794AA37DF0A21FAD8A34021318DA@DGGEMA503-MBX.china.huawei.com>
References: <20200121130959.22589-1-liuchao173@huawei.com>
 <87k15jek6v.fsf@nanos.tec.linutronix.de>
 <20200122192856.GA2852@localhost.localdomain>
In-Reply-To: <20200122192856.GA2852@localhost.localdomain>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.220.102]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBKYW4gMjMsIDIwMjAgYXQgMDM6MjlBTSArMDgwMCwgTmVpbCBIb3JtYW4gd3JvdGU6
DQo+IE9uIFdlZCwgSmFuIDIyLCAyMDIwIGF0IDAxOjQyOjQ4UE0gKzAxMDAsIFRob21hcyBHbGVp
eG5lciB3cm90ZToNCj4gPiBDaGFvLA0KPiA+DQo+ID4gbDAwNTIwOTY1IDxsaXVjaGFvMTczQGh1
YXdlaS5jb20+IHdyaXRlczoNCj4gPg0KPiA+ID4gV2hlbiBkZXNjLT5hY3Rpb24gaXMgZW1wdHks
IHRoZXJlIGlzIG5vIG5lZWQgdG8gcHJpbnQgb3V0IHRoZSBpcnEgYW5kIGl0cycNCj4gPiA+IGNv
dW50IGluIGVhY2ggY3B1LiBUaGUgZGVzYyBpcyBub3QgYWxsb2NlZCBpbiByZXF1ZXN0X2lycSBv
ciBmcmVlZA0KPiA+ID4gaW4gZnJlZV9pcnEuDQo+ID4NCj4gPiByZXF1ZXN0L2ZyZWVfaXJxKCkg
bmV2ZXIgYWxsb2NhdGUvZnJlZSBpcnEgZGVzY3JpcHRvcnMuDQo+ID4NCj4gPiA+IFNvIHNvbWUg
UENJIGRldmljZXMsIHN1Y2ggYXMgcnRsODEzOSwgdXNlcyByZXF1ZXN0X2lycSBhbmQgZnJlZV9p
cnEsDQo+ID4NCj4gPiBBbGwgUENJIGRldmljZXMgdXNlIHNvbWUgdmFyaWFudCBvZiByZXF1ZXN0
X2lycSgpL2ZyZWVfaXJxKCkuIFRoZQ0KPiA+IGludGVycnVwdCBkZXNjcmlwdG9ycyBhcmUgYWxs
b2NhdGVkIGJ5IHRoZSB1bmRlcmx5aW5nIFBDSSBtYWNoaW5lcnkuDQo+ID4gVGhleSBhcmUgb25s
eSBhbGxvY2F0ZWQvZnJlZWQgd2hlbiB0aGUgZGV2aWNlIGRyaXZlciBpcw0KPiA+IGxvYWRlZC9y
ZW1vdmVkLg0KPiA+DQo+ID4gQW5kIHRoaXMgcHJvcGVydHkgZXhpc3RzIGZvciBfQUxMXyBpbnRl
cnJ1cHRzIGluZGVwZW5kZW50IG9mIFBDSS4NCj4gPg0KPiA+ID4gd2hpY2ggb25seSBtb2RpZnkg
dGhlIGFjdGlvbiBvZiBkZXNjLiBTbyAvcHJvYy9pbnRlcnJ1cHRzIGNvdWxkIGJlDQo+ID4gPiBs
aWtlIHRoaXM6DQo+ID4NCj4gPiBJIHRoaW5rIHlvdSB3YW50IHRvIGV4cGxhaW46DQo+ID4NCj4g
PiAgIElmIGFuIGludGVycnVwdCBpcyByZWxlYXNlZCB2aWEgZnJlZV9pcnEoKSB3aXRob3V0IHJl
bW92aW5nIHRoZQ0KPiA+ICAgdW5kZXJseWluZyBpcnEgZGVzY3JpcHRvciwgdGhlIGludGVycnVw
dCBjb3VudCBvZiB0aGUgaXJxIGRlc2NyaXB0b3INCj4gPiAgIGlzIG5vdCByZXNldC4gL3Byb2Mv
aW50ZXJydXB0IHNob3dzIHN1Y2ggaW50ZXJydXB0cyB3aXRoIGFuIGVtcHR5DQo+ID4gICBhY3Rp
b24gaGFuZGxlciBuYW1lOg0KPiA+DQo+ID4gPiAgICAgICAgICAgIENQVTAgICAgICAgQ1BVMQ0K
PiA+ID4gIDM4OiAgICAgICAgIDQ2ICAgICAgICAgIDAgICAgIEdJQ3YzICAzNiBMZXZlbCAgICAg
ZWhjaV9oY2Q6dXNiMQ0KPiA+ID4gIDM5OiAgICAgICAgIDY2ICAgICAgICAgIDAgICAgIEdJQ3Yz
ICAzNyBMZXZlbA0KPiA+DQo+ID4gICBpcnFiYWxhbmNlIGZhaWxzIHRvIGRldGVjdCB0aGF0IHRo
aXMgaW50ZXJydXB0IGlzIG5vdCBsb25nZXIgaW4gdXNlDQo+ID4gICBhbmQgcGFyc2VzIHRoZSBs
YXN0IHdvcmQgaW4gdGhlIGxpbmUgJ0xldmVsJyBhcyB0aGUgYWN0aW9uIGhhbmRsZXINCj4gPiAg
IG5hbWUuDQo+ID4NCj4gPiA+IElycWJhbGFuY2UgZ2V0cyB0aGUgbGlzdCBvZiBpbnRlcnJ1cHRz
IGFjY29yZGluZyB0bw0KPiA+ID4gL3Byb2MvaW50ZXJydXB0cy4gSW4gdGhpcyBjYXNlLCBpcnFi
YWxhbmNlIGRvZXMgbm90IHJlbW92ZSB0aGUNCj4gPiA+IGludGVycnVwdCBmcm9tIHRoZSBiYWxh
bmNlIGxpc3QsIGFuZCB0aGUgbGFzdCBzdHJpbmcgaW4gdGhpcyBsaW5lLHdoaWNoIGlzIExldmVs
LA0KPiBpcyB1c2VkIGFzIGlycV9uYW1lLg0KPiA+DQo+ID4gUmlnaHQsIHRoaXMgaXMgaGlzdG9y
aWMgYmVoYXZpb3VyIGFuZCBJIGRvbid0IGtub3cgaG93IGlycWJhbGFuY2UNCj4gPiBkZWFsdCB3
aXRoIHRoYXQgaW4gdGhlIHBhc3QgMjArIHllYXJzLiBBdCBsZWFzdCBJIGhhdmVuJ3Qgc2VlbiBh
bnkgY29tcGxhaW50cy4NCj4gPg0KPiA+IEknbSBub3Qgb3Bwb3NlZCB0byBzdXBwcmVzcyB0aGUg
b3V0cHV0LCBidXQgSSByZWFsbHkgd2FudCB0aGUgb3Bpbmlvbg0KPiA+IG9mIHRoZSBpcnFiYWxh
bmNlIG1haW50YWluZXJzIG9uIHRoYXQuDQoNCklycWJhbGFuY2UgaXMgYW4gZXhhbXBsZS4gSSBt
ZWFuLCB3aGVuIHRoaXMgaGFwcGVucywgdXNlcnMgd2hvIGNhdCAvcHJvYy9pbnRlcnJ1cHRzIA0K
bWF5IGJlIGNvbmZ1c2VkIGFib3V0IHdoZXJlIHRoZSBpbnRlcnJ1cHQgY2FtZSBmcm9tIGFuZCB3
aGF0IGl0IHdhcyB1c2VkIGZvci4gDQpQZW9wbGUgd2hvIHVzZSBMaW51eCBtYXkgbm90IHVuZGVy
c3RhbmQgdGhlIHByaW5jaXBsZSBvZiB0aGlzLiBUaGV5IGFyZSBub3Qgc3VyZSANCndoZXRoZXIg
dGhpcyBpcyBhIHByb2JsZW0gb2YgdGhlIHN5c3RlbSBvciBub3QuDQoNCj4gPg0KPiBBY3R1YWxs
eSwgaXJxYmFsYW5jZSBpZ25vcmVzIHRoZSB0cmFpbGluZyBpcnEgbmFtZSAob3IgaXQgc2hvdWxk
IGF0IGxlYXN0KSwgc28geW91DQo+IHNob3VsZCBiZSBhYmxlIHRvIGRyb3AgdGhhdCBwb3J0aW9u
IG9mIC9wcm9jL2lycWJhbGFuY2UsIHRob3VnaCBJIGNhbnQgc3BlYWsgZm9yDQo+IGFueSBvdGhl
ciB1c2VycyBvZiBpdC4NCg0KSWYgaXJxIGlzbid0IHJlbW92ZWQgZnJvbSAvcHJvYy9pbnRlcnJ1
cHMsIGl0IHdpbGwgc3RpbGwgYmUgcGFyc2VkIGluIGNvbGxlY3RfZnVsbF9pcnFfbGlzdCANCmFu
ZCBwYXJzZV9wcm9jX2ludGVycnVwdHMuIGlycV9uYW1lIGlzIHVzZWQgaW4gZ3Vlc3NfYXJtX2ly
cV9oaW50cy4NCg0KPiANCj4gPiA+IE9yIHdlIGNhbiBjbGVhciBkZXNjLT5rc3RhdF9pcnFzIGlu
IGVhY2ggY3B1IGluIGZyZWVfaXJxIHdoZW4NCj4gPiA+IGRlc2MtPmFjdGlvbiBpcyBudWxsPw0K
PiA+DQo+ID4gTm8sIHdlIGNhbid0LiBUaGUgaGlzdG9yaWMgYmVoYXZpb3VyIGlzIHRoYXQgdGhl
IHRvdGFsIGludGVycnVwdCBjb3VudA0KPiA+IGZvciBhIGRldmljZSBpcyBtYWludGFpbmVkIGlu
ZGVwZW5kZW50IG9mIHRoZSBudW1iZXIgb2YNCj4gPiByZXF1ZXN0L2ZyZWVfaXJxKCkgcGFpcnMu
DQo+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IExpdUNoYW8gPGxpdWNoYW8xNzNAaHVhd2VpLmNv
bT4NCj4gPiA+IFJldmlld2VkLWJ5OiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5k
ZT4NCj4gPg0KPiA+IEkgcmVhbGx5IGNhbid0IHJlbWVtYmVyIHRoYXQgSSBoYXZlIHJldmlld2Vk
IHRoaXMgcGF0Y2ggYWxyZWFkeS4NCj4gPiBQbGVhc2UgZG9uJ3QgYWRkIHRhZ3Mgd2hpY2ggY2xh
aW0gdGhhdCBzb21lIG9uZSBoYXMgcmV2aWV3ZWQgb3IgYWNrZWQNCj4gPiB5b3VyIHBhdGNoIHVu
bGVzcyB5b3UgcmVhbGx5IGdvdCB0aGF0IFJldmlld2VkLWJ5IG9yIEFja2VkLWJ5IGZyb20NCj4g
PiB0aGF0IHBlcnNvbi4NCj4gPg0KPiA+IFRoYW5rcywNCj4gPg0KPiA+ICAgICAgICAgdGdseA0K
PiA+DQoNClRoYW5rcywNCg0KCQlMaXVDaGFvDQo=
