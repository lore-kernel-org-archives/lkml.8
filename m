Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B74C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 01:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C84E7205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 01:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mGhbNN9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgENBM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 21:12:57 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:17945 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgENBM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 21:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589418775; x=1620954775;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4fBYzCS2UO9rwSG5GAVk4/7EIonRP8ZVwheWWyI3P6c=;
  b=mGhbNN9bnoOsprjW2hJuXxQfLA0N+F+0Od4+rjymYEdKCNXPlVgdNexF
   i6Gc5eFXNL75RaqAYxX0fg+XDc8jF+5cCXy7u0Z6WSi9QLzjFYteJHy/I
   MFCOldtsRmGp2n51vjx+6T6fyfgQ00in7uGsZQj71owLKjVT5iVV0FPQX
   U=;
IronPort-SDR: pE+593aa4fmk7CP/Vfsa88BosBe3+og0FjKNXeT0vYOh7ztPW+bGgfk9qhvQ/eLKveepOWrCOa
 OtOudOyB15JA==
X-IronPort-AV: E=Sophos;i="5.73,389,1583193600"; 
   d="scan'208";a="30353644"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 14 May 2020 01:12:41 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-5bdc5131.us-west-2.amazon.com (Postfix) with ESMTPS id B8FB9A2388;
        Thu, 14 May 2020 01:12:39 +0000 (UTC)
Received: from EX13D01UWB003.ant.amazon.com (10.43.161.94) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 14 May 2020 01:12:39 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB003.ant.amazon.com (10.43.161.94) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 14 May 2020 01:12:37 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Thu, 14 May 2020 01:12:37 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>
Subject: Re:  [PATCH v6 6/6] Documentation: Add L1D flushing Documentation
Thread-Topic: [PATCH v6 6/6] Documentation: Add L1D flushing Documentation
Thread-Index: AQHWKYzBQOrPwSsOc0ysCQMmj/tgQA==
Date:   Thu, 14 May 2020 01:12:37 +0000
Message-ID: <42c535fd9d147033372369726df97edbbfa65070.camel@amazon.com>
References: <20200510014803.12190-1-sblbir@amazon.com>
         <20200510014803.12190-7-sblbir@amazon.com>
         <87r1vo2c46.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87r1vo2c46.fsf@nanos.tec.linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.200]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E349A7B253D89A40BA6E90F1A2E87E6D@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA1LTEzIGF0IDE1OjMzICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IA0KPiANCj4gQmFsYmlyIFNpbmdoIDxzYmxiaXJAYW1hem9uLmNvbT4gd3JpdGVzOg0KPiA+
ICtXaXRoIGFuIGluY3JlYXNpbmcgbnVtYmVyIG9mIHZ1bG5lcmFiaWxpdGllcyBiZWluZyByZXBv
cnRlZCBhcm91bmQNCj4gPiBkYXRhDQo+ID4gK2xlYWtzIGZyb20gTDFELCBhIG5ldyB1c2VyIHNw
YWNlIG1lY2hhbmlzbSB0byBmbHVzaCB0aGUgTDFEIGNhY2hlDQo+ID4gb24NCj4gPiArY29udGV4
dCBzd2l0Y2ggaXMgYWRkZWQgdG8gdGhlIGtlcm5lbC4gVGhpcyBzaG91bGQgaGVscCBhZGRyZXNz
DQo+IA0KPiBpcyBhZGRlZCB0byB0aGUga2VybmVsPyBUaGlzIGlzIGRvY3VtZW50YXRpb24gb2Yg
YW4gZXhpc3RpbmcNCj4gZmVhdHVyZS4uLg0KPiANCg0KR29vZCBjYXRjaCEgVGhhbmtzDQoNCj4g
PiArTWl0aWdhdGlvbg0KPiA+ICstLS0tLS0tLS0tDQo+ID4gK1doZW4gUFJfU0VUX0wxRF9GTFVT
SCBpcyBlbmFibGVkIGZvciBhIHRhc2ssIG9uIHN3aXRjaGluZyB0YXNrcw0KPiA+ICh3aGVuDQo+
ID4gK3RoZSBhZGRyZXNzIHNwYWNlIGNoYW5nZXMpLCBhIGZsdXNoIG9mIHRoZSBMMUQgY2FjaGUg
aXMgcGVyZm9ybWVkDQo+ID4gZm9yDQo+ID4gK3RoZSB0YXNrIHdoZW4gaXQgbGVhdmVzIHRoZSBD
UFUuIElmIHRoZSB1bmRlcmx5aW5nIENQVSBzdXBwb3J0cyBMMUQNCj4gPiArZmx1c2hpbmcgaW4g
aGFyZHdhcmUsIHRoZSBoYXJkd2FyZSBtZWNoYW5pc20gaXMgdXNlZCwgb3RoZXJ3aXNlIGENCj4g
PiBzb2Z0d2FyZQ0KPiA+ICtmYWxsYmFjaywgc2ltaWxhciB0byB0aGUgbWVjaGFuaXNtIHVzZWQg
YnkgTDFURiBpcyB1c2VkLg0KPiANCj4gVGhpcyBsYWNrcyBkb2N1bWVudGF0aW9uIG9mIHRoZSBs
aW1pdGF0aW9ucywgZXNwZWNpYWxseSB0aGF0IHRoaXMgZG9lcw0KPiBub3QgaGVscCBhZ2FpbnN0
IGNyb3NzIEh5cGVydGhyZWFkIGF0dGFja3MuDQo+IA0KDQpZZXMsIHRydWUNCg0KPiBJJ3ZlIG1h
c3NhZ2VkIHRoZSB3aG9sZSB0aGluZyBhIGJpdC4gU2VlIGJlbG93Lg0KPiANCj4gVGhhbmtzLA0K
PiANCj4gICAgICAgICB0Z2x4DQo+IDg8LS0tLS0tLS0tLS0tLS0tLS0NCj4gDQo+IC0tLSBhL0Rv
Y3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvaHctdnVsbi9pbmRleC5yc3QNCj4gKysrIGIvRG9jdW1l
bnRhdGlvbi9hZG1pbi1ndWlkZS9ody12dWxuL2luZGV4LnJzdA0KPiBAQCAtMTQsMyArMTQsNCBA
QCBhcmUgY29uZmlndXJhYmxlIGF0IGNvbXBpbGUsIGJvb3Qgb3IgcnVuDQo+ICAgICBtZHMNCj4g
ICAgIHRzeF9hc3luY19hYm9ydA0KPiAgICAgbXVsdGloaXQucnN0DQo+ICsgICBsMWRfZmx1c2gN
Cj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2h3LXZ1
bG4vbDFkX2ZsdXNoLnJzdA0KPiBAQCAtMCwwICsxLDUzIEBADQo+ICtMMUQgRmx1c2hpbmcgZm9y
IHRoZSBwYXJhbm9pZA0KPiArPT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gKw0KPiAr
V2l0aCBhbiBpbmNyZWFzaW5nIG51bWJlciBvZiB2dWxuZXJhYmlsaXRpZXMgYmVpbmcgcmVwb3J0
ZWQgYXJvdW5kDQo+IGRhdGENCj4gK2xlYWtzIGZyb20gdGhlIExldmVsIDEgRGF0YSBjYWNoZSAo
TDFEKSB0aGUga2VybmVsIHByb3ZpZGVzIGFuIG9wdC1pbg0KPiArbWVjaGFuaXNtIHRvIGZsdXNo
IHRoZSBMMUQgY2FjaGUgb24gY29udGV4dCBzd2l0Y2guDQo+ICsNCj4gK1RoaXMgbWVjaGFuaXNt
IGNhbiBiZSB1c2VkIHRvIGFkZHJlc3MgZS5nLiBDVkUtMjAyMC0wNTUwLiBGb3INCj4gcGFyYW5v
aWQNCj4gK2FwcGxpY2F0aW9ucyB0aGUgbWVjaGFuaXNtIGtlZXBzIHRoZW0gc2FmZSBmcm9tIGFu
eSB5ZXQgdG8gYmUNCj4gZGlzY292ZXJlZA0KPiArdnVsbmVyYWJpbGl0aWVzLCByZWxhdGVkIHRv
IGxlYWtzIGZyb20gdGhlIEwxRCBjYWNoZS4NCj4gKw0KPiArDQo+ICtSZWxhdGVkIENWRXMNCj4g
Ky0tLS0tLS0tLS0tLQ0KPiArQXQgdGhlIHByZXNlbnQgbW9tZW50LCB0aGUgZm9sbG93aW5nIENW
RXMgY2FuIGJlIGFkZHJlc3NlZCBieSB0aGlzDQo+ICttZWNoYW5pc20NCj4gKw0KPiArICAgID09
PT09PT09PT09PT0gICAgICAgPT09PT09PT09PT09PT09PT09PT09PT09ICAgICA9PT09PT09PT09
PT09PT09DQo+ID09DQo+ICsgICAgQ1ZFLTIwMjAtMDU1MCAgICAgICBJbXByb3BlciBEYXRhIEZv
cndhcmRpbmcgICAgIE9TIHJlbGF0ZWQNCj4gYXNwZWN0cw0KPiArICAgID09PT09PT09PT09PT0g
ICAgICAgPT09PT09PT09PT09PT09PT09PT09PT09ICAgICA9PT09PT09PT09PT09PT09DQo+ID09
DQo+ICsNCj4gK1VzYWdlIEd1aWRlbGluZXMNCj4gKy0tLS0tLS0tLS0tLS0tLS0NCj4gK0FwcGxp
Y2F0aW9ucyBjYW4gY2FsbCBgYHByY3RsKDIpYGAgd2l0aCBvbmUgb2YgdGhlc2UgdHdvIGFyZ3Vt
ZW50cw0KPiArDQo+ICsxLiBQUl9TRVRfTDFEX0ZMVVNIIC0gZmx1c2ggdGhlIEwxRCBjYWNoZSBv
biBjb250ZXh0IHN3aXRjaCAob3V0KQ0KPiArMi4gUFJfR0VUX0wxRF9GTFVTSCAtIGdldCB0aGUg
Y3VycmVudCBzdGF0ZSBvZiB0aGUgTDFEIGNhY2hlIGZsdXNoLA0KPiByZXR1cm5zIDENCj4gKyAg
IGlmIHNldCBhbmQgMCBpZiBub3Qgc2V0Lg0KPiArDQo+ICsqKk5PVEUqKjogVGhlIGZlYXR1cmUg
aXMgZGlzYWJsZWQgYnkgZGVmYXVsdCwgYXBwbGljYXRpb25zIG5lZWQgdG8NCj4gK3NwZWNpZmlj
YWxseSBvcHQgaW50byB0aGUgZmVhdHVyZSB0byBlbmFibGUgaXQuDQo+ICsNCj4gK01pdGlnYXRp
b24NCj4gKy0tLS0tLS0tLS0NCj4gKw0KPiArV2hlbiBQUl9TRVRfTDFEX0ZMVVNIIGlzIGVuYWJs
ZWQgZm9yIGEgdGFzayBhIGZsdXNoIG9mIHRoZSBMMUQgY2FjaGUNCj4gaXMNCj4gK3BlcmZvcm1l
ZCB3aGVuIHRoZSB0YXNrIGlzIHNjaGVkdWxlZCBvdXQgYW5kIHRoZSBpbmNvbWluZyB0YXNrDQo+
IGJlbG9uZ3MgdG8gYQ0KPiArZGlmZmVyZW50IHByb2Nlc3MgYW5kIHRoZXJlZm9yZSB0byBhIGRp
ZmZlcmVudCBhZGRyZXNzIHNwYWNlLg0KPiArDQo+ICtJZiB0aGUgdW5kZXJseWluZyBDUFUgc3Vw
cG9ydHMgTDFEIGZsdXNoaW5nIGluIGhhcmR3YXJlLCB0aGUgaGFyZHdhcmUNCj4gK21lY2hhbmlz
bSBpcyB1c2VkLCBvdGhlcndpc2UgYSBzb2Z0d2FyZSBmYWxsYmFjaywgc2ltaWxhciB0byB0aGUg
TDFURg0KPiArbWl0aWdhdGlvbiwgaXMgaW52b2tlZC4NCj4gKw0KPiArTGltaXRhdGlvbnMNCj4g
Ky0tLS0tLS0tLS0tDQo+ICsNCj4gK1RoZSBtZWNoYW5pc20gZG9lcyBub3QgbWl0aWdhdGUgTDFE
IGRhdGEgbGVha3MgYmV0d2VlbiB0YXNrcw0KPiBiZWxvbmdpbmcgdG8NCj4gK2RpZmZlcmVudCBw
cm9jZXNzZXMgd2hpY2ggYXJlIGNvbmN1cnJlbnRseSBleGVjdXRpbmcgb24gc2libGluZw0KPiB0
aHJlYWRzIG9mDQo+ICthIHBoeXNpY2FsIENQVSBjb3JlIHdoZW4gU01UIGlzIGVuYWJsZWQgb24g
dGhlIHN5c3RlbS4NCj4gKw0KPiArVGhpcyBjYW4gYmUgYWRkcmVzc2VkIGJ5IGNvbnRyb2xsZWQg
cGxhY2VtZW50IG9mIHByb2Nlc3NlcyBvbg0KPiBwaHlzaWNhbCBDUFUNCj4gK2NvcmVzIG9yIGJ5
IGRpc2FibGluZyBTTVQuIFNlZSB0aGUgcmVsZXZhbnQgY2hhcHRlciBpbiB0aGUgTDFURg0KPiBt
aXRpZ2F0aW9uDQo+ICtkb2N1bWVudDogOnJlZjpgRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9o
dy12dWxuL2wxdGYucnN0DQo+IDxzbXRfY29udHJvbD5gLg0KDQpJIGxpa2UgeW91ciBhZGRpdGlv
biBhYm92ZQ0KDQpUaGFua3MsDQpCYWxiaXIgU2luZ2guDQoNCg==
