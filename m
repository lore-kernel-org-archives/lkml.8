Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F12C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB9D720857
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369589AbgDOMbv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:31:51 -0400
Received: from mailgate1.rohmeurope.com ([87.129.152.131]:53480 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409096AbgDOLoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:44:44 -0400
X-AuditID: c0a8fbf4-489ff70000004419-18-5e96f3aa2ce6
Received: from smtp.reu.rohmeu.com (will-cas001.reu.rohmeu.com [192.168.251.177])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 01.50.17433.AA3F69E5; Wed, 15 Apr 2020 13:44:42 +0200 (CEST)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS001.REu.RohmEu.com ([fe80::d57e:33d0:7a5d:f0a6%16]) with mapi id
 14.03.0487.000; Wed, 15 Apr 2020 13:44:37 +0200
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: rohm-bdXXX - switch to use i2c probe_new
Thread-Topic: [PATCH] mfd: rohm-bdXXX - switch to use i2c probe_new
Thread-Index: AQHWAzqhn2Sg7V5pBEqGkrHrcsfhsqh57rYAgAAQigCAAAPrgIAAC1iA
Date:   Wed, 15 Apr 2020 11:44:36 +0000
Message-ID: <abcb3356c78758cb176947fba7b2f291d63055a3.camel@fi.rohmeurope.com>
References: <20200326064852.GA23265@localhost.localdomain>
         <20200415095052.GI2167633@dell>
         <a4b45b01e78c37e23cc4e464ec07d2364e02e379.camel@fi.rohmeurope.com>
         <20200415110405.GJ2167633@dell>
In-Reply-To: <20200415110405.GJ2167633@dell>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.78.225.252]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B77ECD955AB85A4DA5A129D2BF147FC4@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsVyYMXvjbqrPk+LM7h0ztzi/tejjBaXd81h
        s5iz9ASLA7PHzll32T3uXNvD5vF5k1wAcxS3TVJiSVlwZnqevl0Cd8aWDY/YC76IVrxvnsjU
        wLhGtIuRk0NCwERi8Zfv7F2MXBxCAtcYJdZdXM0I4ZxglNgw+xhLFyMHB5uAjUTXTXaQBhEB
        Q4klJ56ygNjMAlUSd081gtnCAk4S31p3M0HUOEvc/rSWGcJ2k9i4fjEjiM0ioCoxpWc6K4jN
        K+AncavpATPErmOMEpse7QAr4hTQkXgyaQ1YM6OArERnwzsmiGXiEpuefWeFuFpAYsme88wQ
        tqjEy8f/oOKKEtu/rwO7mVlAU2L9Ln2IVgeJrq1NzBC2osSU7ofsEDcISpyc+YRlAqPYLCQb
        ZiF0z0LSPQtJ9ywk3QsYWVcxSuQmZuakJ5akGuoVpZbqFeVn5AKp5PzcTYyQePuyg/H/Ic9D
        jEwcjIcYJTmYlER5W59OixPiS8pPqcxILM6ILyrNSS0+xCjBwawkwrs+d2qcEG9KYmVValE+
        TEqag0VJnFf94cRYIQGQXdmpqQWpRTBZGQ4OJQle349AQwWLUtNTK9Iyc0oQ0kwcnCDDuaRE
        ilPzUlKLEktLMuJB6SO+GJhAQFI8QHu/vQdq5y0uSMwFikK0nmLU5pjwcu4iZo4jc5cuYhZi
        ycvPS5US59X+BFQqAFKaUZoHt+gVozgHo5Iw716QO3iAiRduziugFUxAKwp8JoOsKElESEk1
        MG6SzK0zZigs8OlyvRtq/fuklgLz1Qm7V3VMXNag66RabPVoe5uyoe32itVPlToO8N00d70V
        IKy5bsc0JmONspo1vi+8X0QYdH8UWz/xLdu9m8d3PdzutTZu2pGf+7SmZ6vd8Hhw+vYk3U1x
        6XWv/Ha4d3VUf/NeoPz17nlNsWMt3oY/Mz9PCVFiKc5INNRiLipOBACOXHfKeQMAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBXZWQsIDIwMjAtMDQtMTUgYXQgMTI6MDQgKzAxMDAsIExlZSBKb25lcyB3cm90ZToNCj4g
T24gV2VkLCAxNSBBcHIgMjAyMCwgVmFpdHRpbmVuLCBNYXR0aSB3cm90ZToNCj4gPiBIZWxsbyBM
ZWUsDQo+ID4gDQo+ID4gT24gV2VkLCAyMDIwLTA0LTE1IGF0IDEwOjUwICswMTAwLCBMZWUgSm9u
ZXMgd3JvdGU6DQo+ID4gPiBPbiBUaHUsIDI2IE1hciAyMDIwLCBNYXR0aSBWYWl0dGluZW4gd3Jv
dGU6DQo+ID4gPiANCj4gPiA+ID4gUk9ITSBCRDcwNTI4IGFuZCBCRDcxOHg3IGRyaXZlcnMgZG8g
bm90IHV0aWxpemUgdGhlIEkyQyBpZC4NCj4gPiA+ID4gRG8gdGhlIHRyaXZpYWwgY29udmVyc2lv
biBhbmQgbWFrZSB0aGVtIHRvIHVzZSBwcm9iZV9uZXcNCj4gPiA+ID4gaW5zdGVhZCBvZiBwcm9i
ZS4NCj4gPiA+IA0KPiA+ID4gTm90IHN1cmUgSSB1bmRlcnN0YW5kIHRoZSBwdXJwb3NlIG9mIHRo
ZSBwYXRjaC4NCj4gPiA+IA0KPiA+ID4gVGhlIG9ubHkgcmVhc29uIHRvIHN3aXRjaCB0byBwcm9i
ZV9uZXcgaXMgdG8gYWlkIHRoZSByZW1vdmFsIG9mDQo+ID4gPiB0aGUNCj4gPiA+IGNvbXB1bHNv
cnkgSTJDIHRhYmxlcy4gIEhvd2V2ZXIsIG5laXRoZXIgb2YgdGhlc2UgZHJpdmVycyBoYXZlDQo+
ID4gPiB0aGVtLg0KPiA+IA0KPiA+IE1heWJlIEkgaGF2ZSBtaXN1bmRlcnN0b29kIHRoZSBwcm9i
ZV9uZXcuIE15IHVuZGVyc3RhbmRpbmcgd2FzIHRoYXQNCj4gPiB0aGUNCj4gPiBwcm9iZV9uZXcg
aXMgd2hhdCBzaG91bGQgYmVjb21lIHRoZSBzdGFuZGFyZCAtIEVnLiBldmVudHVhbGx5IGFsbA0K
PiA+IEkyQw0KPiA+IGRyaXZlcnMgd291bGQgdXNlIHByb2JlIHdoaWNoIGlzIG5vdCBnZXR0aW5n
IHRoZSBJRCB0YWJsZXMgYXMNCj4gPiBhcmd1bWVudA0KPiA+IC0gYW5kIHRoZSBvbGQgcHJvYmUg
Y291bGQgYmUgcmVtb3ZlZC4gVGh1cyBJIHRob3VnaHQgY29udmVyc2lvbiBvZg0KPiA+IHByb2Jl
IHRvIHByb2JlX25ldyB3b3VsZCBiZSByZXF1aXJlZCBpbiBvcmRlciB0byBnZXQgcmlkIG9mIHRo
ZSBvbGQNCj4gPiBwcm9iZS4gSSB0aGluayBJIGdvdCB0aGlzIHVuZGVyc3RhbmRpbmcgd2hlbiBJ
IHN1Ym1pdHRlZCBkcml2ZXIgZm9yDQo+ID4gQkQ3MTgyOCAtIGFuZCBJIHRoaW5rIGl0IHdhcyB5
b3Ugd2hvIHN1Z2dlc3RlZCBtZSB0byBzd2l0Y2ggdG8NCj4gPiBwcm9iZV9uZXcgYXMgJ2lkJyB3
YXMgdW51c2VkLiBCdXQgaWYgcGxlYXNlIGp1c3QgZHJvcCB0aGlzIHBhdGNoIGlmDQo+ID4gdGhp
cyBjaGFuZ2UgaXMgbm90IG5lZWRlZCENCj4gDQo+IFNvbWUgSTJDIGRyaXZlcnMgZG8gbWFrZSB1
c2Ugb2YgJ2lkJyB0aG91Z2guICBTbyB0aGUgc3RhbmRhcmQgcHJvYmUNCj4gd2lsbCBwcm9iYWJs
eSBuZXZlciBnbyBhd2F5LiAgSSB3cm90ZSBwcm9iZV9uZXcgZm9yIGRyaXZlcnMgdGhhdA0KPiB3
aXNoZWQgdG8gb21pdCB0aGUgSTJDIHRhYmxlLiAgQSBiZXR0ZXIgdXNlIG9mIHlvdXIgdGltZSB3
b3VsZCBiZSB0bw0KPiBnbyB0aHJvdWdoIHRoZSBvcmlnaW5hbCBwcm9iZSB1c2VycyBhbmQgZmln
dXJlIG91dCB3aGljaCBJMkMgdGFibGVzDQo+IGNhbiBiZSByZW1vdmVkLg0KDQpSaWdodC4gVW5m
b3J0dW5hdGVseSBJIGRvbid0IGhhdmUgcHJvYmxlbXMgd2l0aCBleGNlc3NpdmUgYW1vdW50cyBv
Zg0KZnJlZSB0aW1lIHhEIEkgZGlkIHRoaXMgcHJvYmUtY29udmVyc2lvbiBmb3IgYmQ3MTh4NyBi
ZWNhdXNlIHRoYXQNCmRyaXZlciBpcyBvcmlnaW5hbGx5IHdyaXR0ZW4gYnkgbWUgLSBhbmQgSSB0
cnkgdG8gY29udHJpYnV0ZSBvbg0KbWFpbnRlbmFuY2Ugb2Ygc3R1ZmYgSSBoYXZlIHB1c2hlZCBv
biB5b3VyIGFuZCBvdGhlciBtYWludGFpbmVyJ3MNCnNob3VsZGVycyA6KQ0KDQpBbmQgYXMgSSBz
YWlkIC0gaWYgdGhlIHVzYWdlIG9mIHByb2JlIGlzIGp1c3QgYXMgZmluZSBhcyB1c2FnZSBvZg0K
cHJvYmVfbmV3IC0gdGhlbiBwbGVhc2UganVzdCBkcm9wIHRoaXMgcGF0Y2ggOikNCg0KVGhhbmtz
IGZvciBjbGFyaWZ5aW5nIHRoaXMhDQoNCkJlc3QgUmVnYXJkcw0KICAgIE1hdHRpDQoNCg0K
