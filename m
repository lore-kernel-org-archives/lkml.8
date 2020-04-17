Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15775C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 22:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0E88221EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 22:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="wCAKWkkL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgDQW7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 18:59:02 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:33677 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgDQW7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 18:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1587164341; x=1618700341;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Qp67AI0Sv/1C+D0VIma7kToD5Gl30fiIpHeu/2TOwzo=;
  b=wCAKWkkL1EffV5sB9BNJeHYBdnpqn9l45yvlqGKZDXh5PAf8p6iM2sse
   9jHxxyGHcPVHekGkampvuiVvmbzd2yZe/YGx/KlVX3IBFazgAsUp75geU
   xNvV71rOqY6iR5Nb2nUN2vbI54sCqqY36mYYEOAYWOqxKnRgM7NFLQoXC
   g=;
IronPort-SDR: oBvkBR7ILXH9wznF0ANioJnD5bLWC200b/qIjTPhlyjftdpF71OBWSQmHQm8eEvADLkalLw+am
 /nC3IyZTSCdQ==
X-IronPort-AV: E=Sophos;i="5.72,395,1580774400"; 
   d="scan'208";a="27477401"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-f273de60.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 17 Apr 2020 22:58:48 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-f273de60.us-east-1.amazon.com (Postfix) with ESMTPS id C564AA2443;
        Fri, 17 Apr 2020 22:58:45 +0000 (UTC)
Received: from EX13D01UWB004.ant.amazon.com (10.43.161.157) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 17 Apr 2020 22:58:45 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB004.ant.amazon.com (10.43.161.157) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 17 Apr 2020 22:58:44 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Fri, 17 Apr 2020 22:58:44 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>
Subject: Re: [PATCH v3 2/5] arch/x86: Refactor tlbflush and l1d flush
Thread-Topic: [PATCH v3 2/5] arch/x86: Refactor tlbflush and l1d flush
Thread-Index: AQHWFQu/E74C3HKXpEGOWXqP1jJSaw==
Date:   Fri, 17 Apr 2020 22:58:44 +0000
Message-ID: <b34460c972d7c862c2a390381ace5e689c779a38.camel@amazon.com>
References: <20200408090229.16467-1-sblbir@amazon.com>
         <20200408090229.16467-3-sblbir@amazon.com>
         <87y2qul0wx.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87y2qul0wx.fsf@nanos.tec.linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.203]
Content-Type: text/plain; charset="utf-8"
Content-ID: <56253E9FA22F9B4A806C9717A7560861@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTA0LTE3IGF0IDE1OjAzICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IA0KPiBCYWxiaXIgU2luZ2ggPHNibGJpckBhbWF6b24uY29tPiB3cml0ZXM6DQo+ID4gK3Zv
aWQgcG9wdWxhdGVfdGxiX3dpdGhfZmx1c2hfcGFnZXModm9pZCAqbDFkX2ZsdXNoX3BhZ2VzKTsN
Cj4gPiArdm9pZCBmbHVzaF9sMWRfY2FjaGVfc3codm9pZCAqbDFkX2ZsdXNoX3BhZ2VzKTsNCj4g
PiAraW50IGZsdXNoX2wxZF9jYWNoZV9odyh2b2lkKTsNCj4gDQo+IGwxZF9mbHVzaF9wb3B1bGF0
ZV9wYWdlcygpOw0KPiBsMWRfZmx1c2hfc3coKQ0KPiBsMWRfZmx1c2hfaHcoKQ0KPiANCj4gSG1t
Pw0KPiANCg0KSSBjYW4gcmVuYW1lIHRoZW0NCg0KPiA+ICt2b2lkIHBvcHVsYXRlX3RsYl93aXRo
X2ZsdXNoX3BhZ2VzKHZvaWQgKmwxZF9mbHVzaF9wYWdlcykNCj4gPiArew0KPiA+ICsgICAgIGlu
dCBzaXplID0gUEFHRV9TSVpFIDw8IEwxRF9DQUNIRV9PUkRFUjsNCj4gPiArDQo+ID4gKyAgICAg
YXNtIHZvbGF0aWxlKA0KPiA+ICsgICAgICAgICAgICAgLyogRmlyc3QgZW5zdXJlIHRoZSBwYWdl
cyBhcmUgaW4gdGhlIFRMQiAqLw0KPiA+ICsgICAgICAgICAgICAgInhvcmwgICAlJWVheCwgJSVl
YXhcbiINCj4gPiArICAgICAgICAgICAgICIuTHBvcHVsYXRlX3RsYjpcblx0Ig0KPiA+ICsgICAg
ICAgICAgICAgIm1vdnpibCAoJVtmbHVzaF9wYWdlc10sICUlIiBfQVNNX0FYICIpLCAlJWVjeFxu
XHQiDQo+ID4gKyAgICAgICAgICAgICAiYWRkbCAgICQ0MDk2LCAlJWVheFxuXHQiDQo+ID4gKyAg
ICAgICAgICAgICAiY21wbCAgICUlZWF4LCAlW3NpemVdXG5cdCINCj4gPiArICAgICAgICAgICAg
ICJqbmUgICAgLkxwb3B1bGF0ZV90bGJcblx0Ig0KPiA+ICsgICAgICAgICAgICAgInhvcmwgICAl
JWVheCwgJSVlYXhcblx0Ig0KPiA+ICsgICAgICAgICAgICAgImNwdWlkXG5cdCINCj4gPiArICAg
ICAgICAgICAgIDo6IFtmbHVzaF9wYWdlc10gInIiIChsMWRfZmx1c2hfcGFnZXMpLA0KPiA+ICsg
ICAgICAgICAgICAgICAgIFtzaXplXSAiciIgKHNpemUpDQo+ID4gKyAgICAgICAgICAgICA6ICJl
YXgiLCAiZWJ4IiwgImVjeCIsICJlZHgiKTsNCj4gPiArfQ0KPiA+ICtFWFBPUlRfU1lNQk9MX0dQ
TChwb3B1bGF0ZV90bGJfd2l0aF9mbHVzaF9wYWdlcyk7DQo+IA0KPiBJIHByb2JhYmx5IG1pc3Nl
ZCB0aGUgZmluZSBwcmludCBpbiB0aGUgY2hhbmdlIGxvZyB3aHkgdGhpcyBpcyBzZXBhcmF0ZQ0K
PiBmcm9tIHRoZSBTVyBmbHVzaCBmdW5jdGlvbi4NCg0KSW4gdGhlIFJGQyB3ZSBkaXNjdXNzZWQg
aWYgd2UgcmVhbGx5IG5lZWQgdG8gcHJlZmV0Y2ggdGhlIHBhZ2VzIGludG8gdGhlIFRMQiANCnBy
aW9yIHRvIHRoZSBmbHVzaCBhbmQgSSBwb2ludGVkIG91dCBvciB0aG91Z2h0IHRoYXQgdGhlIFRM
QiBwcmVmZXRjaCB3YXMgbm90DQpyZXF1aXJlZCBmb3IgdGhlc2UgcGF0Y2hlcyAoTDFEIGZsdXNo
KSwgc28gSSBzcGxpdCBpdCBvdXQuDQoNCj4gDQo+ID4gK2ludCBmbHVzaF9sMWRfY2FjaGVfaHco
dm9pZCkNCj4gPiArew0KPiA+ICsgICAgIGlmIChzdGF0aWNfY3B1X2hhcyhYODZfRkVBVFVSRV9G
TFVTSF9MMUQpKSB7DQo+ID4gKyAgICAgICAgICAgICB3cm1zcmwoTVNSX0lBMzJfRkxVU0hfQ01E
LCBMMURfRkxVU0gpOw0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4gKyAgICAgfQ0K
PiA+ICsgICAgIHJldHVybiAtRU5PVFNVUFA7DQo+ID4gK30NCj4gPiArRVhQT1JUX1NZTUJPTF9H
UEwoZmx1c2hfbDFkX2NhY2hlX2h3KTsNCj4gDQo+IGFsb25nIHdpdGggdGhlIGV4cGxhbmF0aW9u
IHdoeSB0aGlzIG5lZWRzIHRvIGJlIHR3byBmdW5jdGlvbnMuDQo+IA0KDQpBcmUgeW91IHN1Z2dl
c3RpbmcgSSBhYnN0cmFjdCB0aGUgaHcgYW5kIHN3IGZsdXNoZXMgaW50byBvbmUgZnVuY3Rpb24/
IEkgY2FuDQpkbyB0aGF0Lg0KDQo+ID4gLSAgICAgaWYgKHN0YXRpY19jcHVfaGFzKFg4Nl9GRUFU
VVJFX0ZMVVNIX0wxRCkpIHsNCj4gPiAtICAgICAgICAgICAgIHdybXNybChNU1JfSUEzMl9GTFVT
SF9DTUQsIEwxRF9GTFVTSCk7DQo+ID4gKyAgICAgaWYgKGZsdXNoX2wxZF9jYWNoZV9odygpID09
IDApDQo+ID4gICAgICAgICAgICAgICByZXR1cm47DQo+ID4gLSAgICAgfQ0KPiANCj4gICAgICAg
ICBpZiAoIWwxZF9mbHVzaF9odygpKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuOw0KPiANCj4g
PiAtICAgICBhc20gdm9sYXRpbGUoDQo+ID4gLSAgICAgICAgICAgICAvKiBGaXJzdCBlbnN1cmUg
dGhlIHBhZ2VzIGFyZSBpbiB0aGUgVExCICovDQo+ID4gLSAgICAgICAgICAgICAieG9ybCAgICUl
ZWF4LCAlJWVheFxuIg0KPiA+IC0gICAgICAgICAgICAgIi5McG9wdWxhdGVfdGxiOlxuXHQiDQo+
ID4gLSAgICAgICAgICAgICAibW92emJsICglW2ZsdXNoX3BhZ2VzXSwgJSUiIF9BU01fQVggIiks
ICUlZWN4XG5cdCINCj4gPiAtICAgICAgICAgICAgICJhZGRsICAgJDQwOTYsICUlZWF4XG5cdCIN
Cj4gPiAtICAgICAgICAgICAgICJjbXBsICAgJSVlYXgsICVbc2l6ZV1cblx0Ig0KPiA+IC0gICAg
ICAgICAgICAgImpuZSAgICAuTHBvcHVsYXRlX3RsYlxuXHQiDQo+ID4gLSAgICAgICAgICAgICAi
eG9ybCAgICUlZWF4LCAlJWVheFxuXHQiDQo+ID4gLSAgICAgICAgICAgICAiY3B1aWRcblx0Ig0K
PiA+IC0gICAgICAgICAgICAgLyogTm93IGZpbGwgdGhlIGNhY2hlICovDQo+ID4gLSAgICAgICAg
ICAgICAieG9ybCAgICUlZWF4LCAlJWVheFxuIg0KPiA+IC0gICAgICAgICAgICAgIi5MZmlsbF9j
YWNoZTpcbiINCj4gPiAtICAgICAgICAgICAgICJtb3Z6YmwgKCVbZmx1c2hfcGFnZXNdLCAlJSIg
X0FTTV9BWCAiKSwgJSVlY3hcblx0Ig0KPiA+IC0gICAgICAgICAgICAgImFkZGwgICAkNjQsICUl
ZWF4XG5cdCINCj4gPiAtICAgICAgICAgICAgICJjbXBsICAgJSVlYXgsICVbc2l6ZV1cblx0Ig0K
PiA+IC0gICAgICAgICAgICAgImpuZSAgICAuTGZpbGxfY2FjaGVcblx0Ig0KPiA+IC0gICAgICAg
ICAgICAgImxmZW5jZVxuIg0KPiA+IC0gICAgICAgICAgICAgOjogW2ZsdXNoX3BhZ2VzXSAiciIg
KHZteF9sMWRfZmx1c2hfcGFnZXMpLA0KPiA+IC0gICAgICAgICAgICAgICAgIFtzaXplXSAiciIg
KHNpemUpDQo+ID4gLSAgICAgICAgICAgICA6ICJlYXgiLCAiZWJ4IiwgImVjeCIsICJlZHgiKTsN
Cj4gPiArICAgICBwcmVlbXB0X2Rpc2FibGUoKTsNCj4gPiArICAgICBwb3B1bGF0ZV90bGJfd2l0
aF9mbHVzaF9wYWdlcyh2bXhfbDFkX2ZsdXNoX3BhZ2VzKTsNCj4gPiArICAgICBmbHVzaF9sMWRf
Y2FjaGVfc3codm14X2wxZF9mbHVzaF9wYWdlcyk7DQo+ID4gKyAgICAgcHJlZW1wdF9lbmFibGUo
KTsNCj4gDQo+IFRoZSBwcmVlbXB0X2Rpc2FibGUvZW5hYmxlIHdhcyBub3QgdGhlcmUgYmVmb3Jl
LCByaWdodD8gV2h5IGRvIHdlIG5lZWQNCj4gdGhhdCBub3c/IElmIHRoaXMgaXMgYSBmaXgsIHRo
ZW4gdGhhdCBzaG91bGQgYmUgYSBzZXBhcmF0ZSBwYXRjaC4NCj4gDQoNCk5vIHRoZXkgd2VyZSBu
b3QsIEkgYWRkZWQgdGhlbSBiZWNhdXNlIEkgd2FzIGNvbmNlcm5lZCBhYm91dCBwcmVlbXB0aW9u
LCBpdCdzDQphIHNwZWN1bGF0aXZlIGNoYW5nZSwgbXkgY29uY2VybiB3YXMgdGhhdCB3ZSBjb3Vs
ZCBmaWxsIHRoZSBUTEIgYW5kIHRoZW4gZ2V0DQpwcmVlbXB0ZWQuIExvb2tpbmcgYXQgdGhlIGNh
bGxlciBjb250ZXh0LCB3ZSBkbyBydW4gd2l0aCBpbnRlcnJ1cHRzIGRpc2FibGVkLA0KSSBtaWdo
dCBoYXZlIGJlZW4gdG9vIGNvbnNlcnZhdGl2ZSwgd2UgZG9uJ3QgbmVlZCB0aGlzLiBJJ2xsIHJl
bW92ZSBpdA0KDQpCYWxiaXINCg0K
