Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4871AC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 273512087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgAQKLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:11:14 -0500
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:64928 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgAQKLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 05:11:13 -0500
X-AuditID: c0a8fbf4-183ff70000001fa6-cc-5e2188408057
Received: from smtp.reu.rohmeu.com (will-cas001.reu.rohmeu.com [192.168.251.177])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id E9.DA.08102.048812E5; Fri, 17 Jan 2020 11:11:12 +0100 (CET)
Received: from WILL-MAIL002.REu.RohmEu.com ([fe80::e0c3:e88c:5f22:d174]) by
 WILL-CAS001.REu.RohmEu.com ([fe80::d57e:33d0:7a5d:f0a6%16]) with mapi id
 14.03.0439.000; Fri, 17 Jan 2020 11:11:07 +0100
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] mfd: bd70528: Fix hour register mask
Thread-Topic: [PATCH] mfd: bd70528: Fix hour register mask
Thread-Index: AQHVy33u6ExLp0ReyUCqWPc5BSkWM6fubBCAgAADpgCAAAKhgIAAIoKAgAAASAA=
Date:   Fri, 17 Jan 2020 10:11:06 +0000
Message-ID: <1c5c4c8bb1c6070bb98a59f008b63eeb742f5af1.camel@fi.rohmeurope.com>
References: <20200115082933.GA29117@localhost.localdomain>
         <83e8e1ecc40a58e2e6d1960bbb41c8dcfe730ce1.camel@fi.rohmeurope.com>
         <20200117075714.GA1822218@kroah.com>
         <b5835b0fe842a01888d66c07281e13fc64c2c9ef.camel@fi.rohmeurope.com>
         <20200117101009.GC15507@dell>
In-Reply-To: <20200117101009.GC15507@dell>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A7F71BB26483645B325C84A167A07AD@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42I5sOL3Rl2HDsU4g6ZdPBbt75axWzQvXs9m
        cf/rUUaLy7vmsFnMWXqCxWLTmmtsDmwe89ZUe+ycdZfdY9OqTjaPO9f2sHnsn7uG3ePzJrkA
        tihum6TEkrLgzPQ8fbsE7owJ+/uZC9YJVizunc7UwPhFoIuRk0NCwETi37MvTF2MXBxCAlcZ
        Jd4vOw3lnGCUuLrhGksXIwcHm4CNRNdNdpAGEQFDiSUnnrKA1DALLGWS6N11gxEkISxgKbH5
        314miCIriVvvHoD1igj4Sfw47A8SZhFQlbi8aD1YOS9Q+OLhB+wQu/qZJN7P3ADWyymgJTH5
        P8gCTg5GAVmJzoZ3YHFmAXGJTc++s0JcLSCxZM95ZghbVOLl439QcSWJvT8fgu1lFtCUWL9L
        H6LVQWL/9vlsELaixJTuh+wQNwhKnJz5hGUCo9gsJBtmIXTPQtI9C0n3LCTdCxhZVzFK5CZm
        5qQnlqQa6hWlluoV5WfkAqnk/NxNjJBI/bKD8f8hz0OMTByMhxglOZiURHlF9sjGCfEl5adU
        ZiQWZ8QXleakFh9ilOBgVhLhPTkDKMebklhZlVqUD5OS5mBREudVfzgxVkgAZFd2ampBahFM
        VoaDQ0mCl7dVMU5IsCg1PbUiLTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHpQ+4ouBCQQkxQO0
        174NqJ23uCAxFygK0XqKUZtjwsu5i5g5jsxduohZiCUvPy9VSpy3oQWoVACkNKM0D27RK0Zx
        DkYlYV6NdqAsDzBlw815BbSCCWjFBGc5kBUliQgpqQbG2s3TTN5wyzQ/ivTc6/KnOlTCe8W6
        X7FG+sYXfmSlOwjWF35MmDLBIkzRknOd3MSLp5ZJnlcX3HFaO75UgHVCtdOXy30MU3Y7brT3
        TXm1lmvfxPlywidVkr8wT5HgiXSbwm8x1UZn+5aShXwX5Dje/ln78YjFq5KTSZduex/cYb53
        3aNiV6HzSizFGYmGWsxFxYkAGI+k1pYDAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBGcmksIDIwMjAtMDEtMTcgYXQgMTA6MTAgKzAwMDAsIExlZSBKb25lcyB3cm90ZToNCj4g
T24gRnJpLCAxNyBKYW4gMjAyMCwgVmFpdHRpbmVuLCBNYXR0aSB3cm90ZToNCj4gDQo+ID4gT24g
RnJpLCAyMDIwLTAxLTE3IGF0IDA4OjU3ICswMTAwLCBncmVna2hAbGludXhmb3VuZGF0aW9uLm9y
Zw0KPiA+IHdyb3RlOg0KPiA+ID4gT24gRnJpLCBKYW4gMTcsIDIwMjAgYXQgMDc6NDQ6MDdBTSAr
MDAwMCwgVmFpdHRpbmVuLCBNYXR0aSB3cm90ZToNCj4gPiA+ID4gSXMgaXQgcG9zc2libGUgdG8g
Z2V0IHRoaXMgaW4gNS40IHN0YWJsZSAtIHdoaWxlIGxlYXZpbmcgdGhpcw0KPiA+ID4gPiBvdXQN
Cj4gPiA+ID4gb2YNCj4gPiA+ID4gY3VycmVudCBNRkQgdHJlZSBhbmQgYXBwbHlpbmcgdGhlIEJE
NzE4Mjggc2VyaWVzIHRvIE1GRD8NCj4gPiA+IA0KPiA+ID4gV2Ugb25seSB0YWtlIHBhdGNoZXMg
dGhhdCBhcmUgaW4gTGludXMncyB0cmVlIGZvciB0aGUgc3RhYmxlDQo+ID4gPiB0cmVlLA0KPiA+
ID4gdW5sZXNzIHRoZXJlIGFyZSB2ZXJ5IGJpZyByZWFzb25zIG5vdCB0byBkbyBzbyAoaS5lLiBp
dCBpcw0KPiA+ID4gdG90YWxseQ0KPiA+ID4gcmV3cml0dGVuIGluIGEgZGlmZmVyZW50IHdheSB0
aGVyZS4pDQo+ID4gPiANCj4gPiA+IE9uY2UgdGhlIGNoYW5nZS9maXggaXMgaW4gTGludXMncyB0
cmVlLCB0aGVuIHlvdSBjYW4gYmFja3BvcnQgaXQNCj4gPiA+IHRvDQo+ID4gPiBzdGFibGUgaW4g
YSBkaWZmZXJlbnQgd2F5IGlmIHlvdSB3YW50LCBidXQgeW91IG5lZWQgdG8gZ2l2ZSBsb3RzDQo+
ID4gPiBvZg0KPiA+ID4gcmVhc29ucyB3aHkgaXQgaXMgZG9uZSB0aGF0IHdheS4NCj4gPiANCj4g
PiBSaWdodC4gVGhhbmtzIGZvciB0aGUgZXhwbGFuYXRpb24gR3JlZy4gSSBoYXZlIG5vIF9zdHJv
bmdfIHJlYXNvbnMNCj4gPiAtDQo+ID4gd2hpY2ggbWVhbnMgSSdsbCBzcGxpdCB0aGUgUlRDIHN1
cHBvcnQgcGF0Y2ggaW4gQkQ3MTgyOCBzZXJpZXMgaW50bw0KPiA+IHR3bw0KPiA+IC0gZmlyc3Qg
b2YgdGhlIHBhdGNoZXMgYmVpbmcgdGhpcyBmaXgsIHNlY29uZCBiZWluZyB0aGUgQkQ3MTgyOA0K
PiA+IHN1cHBvcnQuIFRoZW4gdGhpcyBmaXggY2FuIGJlIHRha2VuIGluIDUuNCBhZnRlciBpdCBo
YXMgYmVlbiBtZXJnZWQNCj4gPiB0bw0KPiA+IExpbnVzJyB0cmVlIC0gdGhlIEJENzE4Mjggc3Vw
cG9ydCBjYW4gYmUgb21pdHRlZCBmcm9tIDUuNA0KPiA+IA0KPiA+IEkgaG9wZSB0aGUgQkQ3MTgy
OCBzZXJpZXMgY291bGQgc3RpbGwgbWFrZSBpdCB0byBuZXh0IHJlbGVhc2UgLSBidXQNCj4gPiBp
Zg0KPiA+IGl0IHdvbnQsIHRoZW4gaXQgbWlnaHQgYmUgaW4gbmV4dCBhZnRlciB0aGF0IDpdDQo+
ID4gDQo+ID4gTGVlLCBwbGVhc2Ugc2tpcCB0aGlzIG9uZSwgSSdsbCBkbyB2MTAgb2YgdGhlIEJE
NzE4Mjggc2VyaWVzIHdoZXJlDQo+ID4gdGhpcw0KPiA+IGZpeCBpcyBpbmNsdWRlZCBhcyBzZXBh
cmF0ZSBmaXgtcGF0Y2guDQo+IA0KPiBXaWxsIGxvb2sgb3V0IGZvciBpdC4NCj4gDQpUaGFua3Mh
IEl0IHNob3VsZCBiZSBvbiBpdCdzIHdheSB0aHJvdWdoIHRoZSBtYWlsIHNlcnZlcnMgOl0NCg0K
QnIsDQoJTWF0dGkgVmFpdHRpbmVuDQoNCg==
