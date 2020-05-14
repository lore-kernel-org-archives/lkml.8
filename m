Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F7AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9185A20675
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZMpe8xQQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgENIXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 04:23:36 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:62836 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgENIXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 04:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589444616; x=1620980616;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eRDw/4/IL7g0HUieh/1u9Y5zK3LbJDluY9cF5E4S5zs=;
  b=ZMpe8xQQLyatNtaesvBrdHE7GgFePC51/Ndc3Vq3QM55sy3eZiRrUM9d
   XMyxciMUE4hLDxYV8Itq2Gd4Cggm+BqeSvxi8gMuIGJhrEXGWP9vaQOzn
   /MFK/4U+maL/qXO46iERazY0UEvFGtG+7nGsFWx3L6YVEODIo5QUfeYMW
   4=;
IronPort-SDR: ehFrTSnV93cjedzA2HIlRAo2Bjtg6no0WI0TdoB3Gnx5KHbCvJtZ17FzBmfis1WbEOCNmUJ2Ca
 nCL0lVK+lTOA==
X-IronPort-AV: E=Sophos;i="5.73,390,1583193600"; 
   d="scan'208";a="43317245"
Received: from sea32-co-svc-lb4-vlan2.sea.corp.amazon.com (HELO email-inbound-relay-2c-2225282c.us-west-2.amazon.com) ([10.47.23.34])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 14 May 2020 08:23:34 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-2225282c.us-west-2.amazon.com (Postfix) with ESMTPS id 419FAA2571;
        Thu, 14 May 2020 08:23:33 +0000 (UTC)
Received: from EX13D01UWB004.ant.amazon.com (10.43.161.157) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 14 May 2020 08:23:18 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB004.ant.amazon.com (10.43.161.157) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 14 May 2020 08:23:17 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Thu, 14 May 2020 08:23:11 +0000
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
Subject: Re:  [PATCH v6 5/6] Optionally flush L1D on context switch
Thread-Topic: [PATCH v6 5/6] Optionally flush L1D on context switch
Thread-Index: AQHWKcjnTs0udErG4EGy2A5HDpHCKA==
Date:   Thu, 14 May 2020 08:23:11 +0000
Message-ID: <e6acf54b5abe8ded46ee5fee37fb1f40f505f96b.camel@amazon.com>
References: <20200510014803.12190-1-sblbir@amazon.com>
         <20200510014803.12190-6-sblbir@amazon.com>
         <87d0773mg8.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87d0773mg8.fsf@nanos.tec.linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.215]
Content-Type: text/plain; charset="utf-8"
Content-ID: <489EA7F85D23DA45AB94430EB9362C48@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA1LTEzIGF0IDE3OjA0ICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IA0KPiANCj4gQmFsYmlyIFNpbmdoIDxzYmxiaXJAYW1hem9uLmNvbT4gd3JpdGVzOg0KPiA+
IA0KPiA+ICsgICAgIGlmIChwcmV2X21tICYgTEFTVF9VU0VSX01NX0wxRF9GTFVTSCkNCj4gPiAr
ICAgICAgICAgICAgIGFyY2hfbDFkX2ZsdXNoKDApOyAvKiBKdXN0IGZsdXNoLCBkb24ndCBwb3B1
bGF0ZSB0aGUNCj4gPiBUTEIgKi8NCj4gDQo+IEJhaC4gSSBmdW5kYW1lbnRhbGx5IGhhdGUgdGFp
bCBjb21tZW50cy4gVGhleSBhcmUganVzdCBkaXN0dXJiaW5nIHRoZQ0KPiByZWFkaW5nIGZsb3cu
IEFzaWRlIG9mIHRoYXQsIHRoaXMgc3RhdGVzIHRoZSBXSEFUIGJ1dCBub3QgdGhlIFdIWS4gQW5k
DQo+IGlmIHlvdSBhZGQgdGhhdCBleHBsYW5hdGlvbiB0aGVuIHlvdSBuZWVkIG1vcmUgdGhhbiAy
MCBjaGFyYWN0ZXJzIGFuZA0KPiBlbmQgdXAgd2l0aA0KPiANCj4gICAgICAgICBpZiAocHJldl9t
bSAmIExBU1RfVVNFUl9NTV9MMURfRkxVU0gpIHsNCj4gICAgICAgICAgICAgICAgIC8qDQo+ICAg
ICAgICAgICAgICAgICAgKiBQcm9wZXIgY29tbWVudCBleHBsYWluaW5nIHdoeSB0aGlzIGlzIGZs
dXNoaW5nDQo+ICAgICAgICAgICAgICAgICAgKiB3aXRob3V0IHByZXBvcHVsYXRpbmcgdGhlIFRM
Qi4NCj4gICAgICAgICAgICAgICAgICAqLw0KPiAgICAgICAgICAgICAgICAgYXJjaF9sMWRfZmx1
c2goMCk7DQo+ICAgICAgICAgfQ0KPiANCg0KSSBhZGRlZCBhIGNvbW1lbnQgZHVlIHRvIHRoZSB1
c2Ugb2YgMCwgMCBpcyB1c3VhbGx5IHNlZW4gYXMgdHJ1ZSBvcg0KZmFsc2UgYW5kIEkgd2FudGVk
IHRvIGFkZCBzb21lIGNvbW1lbnRzIGluIHRoZXJlIHRvIGluZGljYXRlIHdlIGRvbid0DQpwb3B1
bGF0ZSB0aGUgVExCLCB0aGUgcmVhc29uIHdlIGRvbid0IGRvIGl0IGlzLCBJIGRvbid0IHRoaW5r
IHdlIG5lZWQNCnRvLiBJIGFtIGhhcHB5IHRvIHJldmlzaXQgdGhlIHBsYWNlbWVudCBvZiB0aGUg
Y29tbWVudC4NCg0KPiBhbnl3YXkuIEFuZCBldmVuIGZvciBhIHNob3J0IGNvbW1lbnQgd2hpY2gg
Zml0cyBhZnRlciB0aGUgZnVuY3Rpb24NCj4gY2FsbA0KPiBpdCdzIHdheSBiZXR0ZXIgdG8gaGF2
ZToNCj4gDQo+ICAgICAgICAgaWYgKHByZXZfbW0gJiBMQVNUX1VTRVJfTU1fTDFEX0ZMVVNIKSB7
DQo+ICAgICAgICAgICAgICAgICAvKiBTaG9ydCBleHBsYW5hdGlvbiAqLw0KPiAgICAgICAgICAg
ICAgICAgYXJjaF9sMWRfZmx1c2goMCk7DQo+ICAgICAgICAgfQ0KPiANCj4gSG1tPw0KPiANCj4g
PiArICAgICAvKg0KPiA+ICsgICAgICAqIExlYXZlIGxhc3RfdXNlcl9tbV9zcGVjIGF0IExBU1Rf
VVNFUl9NTV9JQlBCLCB3ZSBkb24ndA0KPiA+ICsgICAgICAqIHdhbnQgdG8gc2V0IExBU1RfVVNF
Ul9NTV9MMURfRkxVU0ggYW5kIGZvcmNlIGEgZmx1c2ggYmVmb3JlDQo+ID4gKyAgICAgICogd2Un
dmUgYWxsb2NhdGVkIHRoZSBmbHVzaCBwYWdlcy4NCj4gDQo+IEFoIGhlcmUgaXMgdGhlIGNvbW1l
bnQuIEkgc3RpbGwgbGlrZSB0aGUgZXhwbGljaXQgZGVmaW5lIGZvciB0aGUgKHJlKQ0KPiBpbml0
Lg0KPiANCg0KSSBzYXcgeW91ciB0cmVlIGFuZCBpdCBzb3VuZHMgbGlrZSB5b3UgZml4ZWQgaXQg
dXAgaW4gdGhlcmUgaW4gcGF0Y2ggMy4NCg0KQmFsYmlyIFNpbmdoLg0KDQo=
