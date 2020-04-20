Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACF4C38A29
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 00:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DF602073A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 00:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="r50rseoP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgDTAZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 20:25:02 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:61290 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgDTAZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 20:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1587342301; x=1618878301;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UiXmySEE4fmKmlBwL5TZvWRbRqz0Y2gQVVz8hMwxlX8=;
  b=r50rseoPnk4v9N7a4evcZlFpX3pZuI6mpOVB5F6jybP9G9FIOSwqb9hJ
   DD3LSLmXCEZI+vLRQ6b3v0EdnQldxsPFuknl3cGL81u/Q+AwM62hFC9/V
   EffBetCDljTld7wnu2kUpFAgPhXaJshW6DaBteiwRZmEPrDT+Sgamn3TQ
   0=;
IronPort-SDR: /NWEc1llBZCb/WoDMBbxRXDLWtDmnKktqeKY8qI6TzYmYfMgV3lfdDqzO2JkjO2Iu+RQnvKPDr
 Ix0aJbO2vpWQ==
X-IronPort-AV: E=Sophos;i="5.72,405,1580774400"; 
   d="scan'208";a="39364790"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-c5104f52.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 20 Apr 2020 00:24:59 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-c5104f52.us-west-2.amazon.com (Postfix) with ESMTPS id E9872A1C0D;
        Mon, 20 Apr 2020 00:24:58 +0000 (UTC)
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 20 Apr 2020 00:24:58 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB002.ant.amazon.com (10.43.161.136) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 20 Apr 2020 00:24:58 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Mon, 20 Apr 2020 00:24:58 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>
Subject: Re:  [PATCH v3 4/5] arch/x86: Optionally flush L1D on context switch
Thread-Topic: [PATCH v3 4/5] arch/x86: Optionally flush L1D on context switch
Thread-Index: AQHWFqofl1vpjX8ZE0eLMm0vby50Xw==
Date:   Mon, 20 Apr 2020 00:24:57 +0000
Message-ID: <eb69188fead8b96a4a7cfbfe4c586c19ca233819.camel@amazon.com>
References: <20200408090229.16467-1-sblbir@amazon.com>
         <20200408090229.16467-5-sblbir@amazon.com>
         <87mu7akwdx.fsf@nanos.tec.linutronix.de>
         <bdf950167b86a01db93a9633b708c17a66ad73d0.camel@amazon.com>
         <87mu79xflj.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87mu79xflj.fsf@nanos.tec.linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.27]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9774ED1CA65FEF40A392DFA33C391C1F@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIwLTA0LTE4IGF0IDEyOjE3ICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IA0KPiANCj4gIlNpbmdoLCBCYWxiaXIiIDxzYmxiaXJAYW1hem9uLmNvbT4gd3JpdGVzOg0K
PiA+IE9uIEZyaSwgMjAyMC0wNC0xNyBhdCAxNjo0MSArMDIwMCwgVGhvbWFzIEdsZWl4bmVyIHdy
b3RlOg0KPiA+ID4gQmFsYmlyIFNpbmdoIDxzYmxiaXJAYW1hem9uLmNvbT4gd3JpdGVzOg0KPiA+
ID4gc3RhdGljIHZvaWQgKmwxZF9mbHVzaF9wYWdlczsNCj4gPiA+IHN0YXRpYyBERUZJTkVfTVVU
RVgobDFkX2ZsdXNoX211dGV4KTsNCj4gPiA+IA0KPiA+ID4gaW50IGwxZF9mbHVzaF9pbml0KHZv
aWQpDQo+ID4gPiB7DQo+ID4gPiAgICAgICAgIGludCByZXQ7DQo+ID4gPiANCj4gPiA+ICAgICAg
ICAgaWYgKHN0YXRpY19jcHVfaGFzKFg4Nl9GRUFUVVJFX0ZMVVNIX0wxRCkgfHwgbDFkX2ZsdXNo
X3BhZ2VzKQ0KPiA+ID4gICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+ID4gDQo+ID4gPiAg
ICAgICAgIG11dGV4X2xvY2soJmwxZF9mbHVzaF9tdXRleCk7DQo+ID4gPiAgICAgICAgIGlmICgh
bDFkX2ZsdXNoX3BhZ2VzKQ0KPiA+ID4gICAgICAgICAgICAgICAgIGwxZF9mbHVzaF9wYWdlcyA9
IGwxZF9mbHVzaF9hbGxvY19wYWdlcygpOw0KPiA+ID4gICAgICAgICByZXQgPSBsMWRfZmx1c2hf
cGFnZXMgPyAwIDogLUVOT01FTTsNCj4gPiA+ICAgICAgICAgbXV0ZXhfdW5sb2NrKCZsMWRfZmx1
c2hfbXV0ZXgpOw0KPiA+ID4gICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ID4gfQ0KPiA+ID4gRVhQ
T1JUX1NZTUJPTF9HUEwobDFkX2ZsdXNoX2luaXQpOw0KPiA+ID4gDQo+ID4gPiB3aGljaCByZW1v
dmVzIHRoZSBleHBvcnQgb2YgbDFkX2ZsdXNoX2FsbG9jX3BhZ2VzKCkgYW5kIGdldHMgcmlkIG9m
IHRoZQ0KPiA+ID4gY2xlYW51cCBjb3VudGVycGFydC4gSW4gYSByZWFsIHdvcmxkIGRlcGxveW1l
bnQgdW5sb2FkaW5nIG9mIFZNWCBpZiB1c2VkDQo+ID4gPiBvbmNlIGlzIHVubGlrZWx5IGFuZCB3
aXRoIHRoZSB0YXNrIGJhc2VkIG9uZSB5b3UgZW5kIHVwIHdpdGggdGhlc2UgcGFnZXMNCj4gPiA+
ICdsZWFrZWQnIGFueXdheSBpZiB1c2VkIG9uY2UuDQo+ID4gPiANCj4gPiANCj4gPiBJIGRvbid0
IHdhbnQgdGhlIHBhdGNoZXMgdG8gYmUgZW5mb3JjZSB0aGF0IG9uZSBjYW5ub3QgdW5sb2FkIHRo
ZSBrdm0NCj4gPiBtb2R1bGUsDQo+ID4gYnV0IEkgY2FuIHJlZmFjdG9yIHRob3NlIGJpdHMgYSBi
aXQgbW9yZQ0KPiANCj4gTm90IGZyZWVpbmcgdGhlIGwxZCBmbHVzaCBwYWdlcyBkb2VzIG5vdCBw
cmV2ZW50IHVubG9hZGluZyB0aGUga3ZtDQo+IG1vZHVsZS4gSXQganVzdCBrZWVwcyB0aGUgYXJv
dW5kLiBJdCdzIHRoZSBzYW1lIHByb2JsZW0gd2l0aCB5b3VyIEwxRA0KPiBmbHVzaCBmb3IgdGFz
a3MuIElmIG9uZSB0YXNrcyB1c2VzIGl0IHRoZW4gdGhlIHBhZ2VzIHN0YXkgYXJvdW5kIHVudGls
DQo+IHRoZSBzeXN0ZW0gcmVib290cy4NCg0KWWVzLCBGYWlyIGVub3VnaCwgeW91IGFsc28gc2Vl
bSB0byBzdWdnZXN0IHRoYXQgdGhlIHNhbWUgc2V0IG9mIHBhZ2VzIGNhbiBiZQ0Kc2hhcmVkIGFj
cm9zcyBWTVggYW5kIEwxRCBmbHVzaGVzICh3aGljaCBpcyBmaW5lIGJ5IG1lKSwgSSBzdXNwZWN0
IGF0IHNvbWUNCnBvaW50IHdlJ2QgbmVlZCB0byB0byBwZXIgTlVNQSBub2RlIGFsbG9jYXRpb25z
LCBidXQgbGV0cyBub3QgcHJlbWF0dXJlbHkNCm9wdGltaXplLg0KDQo+IA0KPiA+ID4gSWYgYW55
IG90aGVyIGFyY2hpdGVjdHVyZSBlbmFibGVzIHRoaXMsIHRoZW4gaXQgd2lsbCBoYXZlIF9BTExf
IG9mIHRoaXMNCj4gPiA+IGNvZGUgZHVwbGljYXRlZC4gU28gd2Ugc2hvdWxkIHJhdGhlciBoYXZl
Og0KPiA+IA0KPiA+IEJ1dCB0aGF0IGlzIGJlaW5nIGEgYml0IHByZXNjcmlwdGl2ZSB0byBhcmNo
J3MgdG8gaW1wbGVtZW50IHRoZWlyIEwxRA0KPiA+IGZsdXNoaW5nDQo+ID4gdXNpbmcgVElGIGZs
YWdzLCBhcmNoJ3Mgc2hvdWxkIGJlIGZyZWUgdG8gdXNlIGJpdHMgaW4gc3RydWN0X21tIGZvciB0
aGVpcg0KPiA+IGFyY2gNCj4gPiBpZiB0aGV5IGZlZWwgc28uDQo+ID4gPiAgIC0gQWxsIGFyY2hp
dGVjdHVyZXMgaGF2ZSB0byB1c2UgVElGX1NQRUNfRkxVU0hfTDFEIGlmIHRoZXkgd2FudCB0bw0K
PiA+ID4gICAgIHN1cHBvcnQgdGhlIHByY3RsLg0KPiA+ID4gDQo+ID4gDQo+ID4gVGhhdCBpcyBh
IGNvbmNlcm4gKHNlZSBhYm92ZSksIHNob3VsZCB3ZSBlbmZvcmNlIHRoaXM/DQo+IA0KPiBGYWly
IGVub3VnaCwgYnV0IGl0J3MgdHJpdmlhbCBlbm91Z2ggdG8gaGF2ZToNCj4gDQo+ICAgc3RhdGlj
IGlubGluZSB2b2lkIGFyY2hfdGFza19sMWRfZmx1c2hfdXBkYXRlKGJvb2wgZW5hYmxlKQ0KPiAg
IHN0YXRpYyBpbmxpbmUgYm9vbCBhcmNoX3Rhc2tfbDFkX2ZsdXNoX3N0YXRlKHZvaWQpDQo+IA0K
PiBhbmQgdGhlIHJlc3Qgb2YgdGhlIGxvZ2ljIGlzIGp1c3QgaWRlbnRpY2FsLg0KPiANCg0KT0ss
IHNvIHlvdSdkIHN0aWxsIGxpa2UgdG8gc2VlIHRoZSBsb2dpYyBtb3ZlIHRvIGxpYi9sMWRfZmx1
c2guYz8gTGV0IG1lIGdldA0Kd29ya2luZyBvbiB0aGF0IGFuZCBzZWUgd2hhdCB0aGUgY2hhbmdl
cyBsb29rIGxpa2UNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3LA0KQmFsYmlyIFNpbmdoDQo=
