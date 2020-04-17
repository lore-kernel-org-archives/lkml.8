Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E914C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 23:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28695214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 23:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nSXAQWrK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgDQXCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 19:02:30 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:61305 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgDQXC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 19:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1587164548; x=1618700548;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=Ih+jlxV8V/YeiawHs8+BibSIuYKqK0v/dfpekPCSovA=;
  b=nSXAQWrKwoMAJGAKBSK9M9gYmJuXA2u+q/6DlRfHd1GkrBXrZQ9WVZKX
   McTG7EwU57juYE5LA5CxlX802I+Fw3PDZutb7is/ETqmcZ0aMh/Qv6RnE
   V4rVzcC7hg2D7CyZGwGOsU/KyXEmE7xMAvl0GBV8IQRtCDHVzFkw18oSP
   Q=;
IronPort-SDR: LgZorR9/HOhY5UGkoC8URUtXxTLqhuBmgR6jySm/4vMrQghyRMO9XH8cAPKhJJ4K28GZP69q0W
 vrEmGiP/Aaig==
X-IronPort-AV: E=Sophos;i="5.72,395,1580774400"; 
   d="scan'208";a="29466861"
Subject: Re: [PATCH v3 3/5] arch/x86/mm: Refactor cond_ibpb() to support other use
 cases
Thread-Topic: [PATCH v3 3/5] arch/x86/mm: Refactor cond_ibpb() to support other use cases
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 17 Apr 2020 23:02:26 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS id 71B58A2554;
        Fri, 17 Apr 2020 23:02:23 +0000 (UTC)
Received: from EX13D01UWB001.ant.amazon.com (10.43.161.75) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 17 Apr 2020 23:02:22 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB001.ant.amazon.com (10.43.161.75) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 17 Apr 2020 23:02:22 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Fri, 17 Apr 2020 23:02:22 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>
Thread-Index: AQHWDYR7nJnYqlkTfUah7gQhUeso0Kh9V0WAgACmMAA=
Date:   Fri, 17 Apr 2020 23:02:22 +0000
Message-ID: <12023cc73a6344ed7499e09492a6934c1dfaf044.camel@amazon.com>
References: <20200408090229.16467-1-sblbir@amazon.com>
         <20200408090229.16467-4-sblbir@amazon.com>
         <87sgh2l0q4.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87sgh2l0q4.fsf@nanos.tec.linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.52]
Content-Type: text/plain; charset="utf-8"
Content-ID: <62794DA7E655C54A8F58E120A4C10A62@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTA0LTE3IGF0IDE1OjA3ICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IA0KPiBCYWxiaXIgU2luZ2ggPHNibGJpckBhbWF6b24uY29tPiB3cml0ZXM6DQo+ID4gDQo+
ID4gIC8qDQo+ID4gLSAqIFVzZSBiaXQgMCB0byBtYW5nbGUgdGhlIFRJRl9TUEVDX0lCIHN0YXRl
IGludG8gdGhlIG1tIHBvaW50ZXIgd2hpY2ggaXMNCj4gPiAtICogc3RvcmVkIGluIGNwdV90bGJf
c3RhdGUubGFzdF91c2VyX21tX2licGIuDQo+ID4gKyAqIEJpdHMgdG8gbWFuZ2xlIHRoZSBUSUZf
U1BFQ19JQiBzdGF0ZSBpbnRvIHRoZSBtbSBwb2ludGVyIHdoaWNoIGlzDQo+ID4gKyAqIHN0b3Jl
ZCBpbiBjcHVfdGxiX3N0YXRlLmxhc3RfdXNlcl9tbV9zcGVjLg0KPiA+ICAgKi8NCj4gPiAgI2Rl
ZmluZSBMQVNUX1VTRVJfTU1fSUJQQiAgICAweDFVTA0KPiA+ICsjZGVmaW5lIExBU1RfVVNFUl9N
TV9TUEVDX01BU0sgICAgICAgKExBU1RfVVNFUl9NTV9JQlBCKQ0KPiA+IA0KPiA+ICAgICAgIC8q
IFJlaW5pdGlhbGl6ZSB0bGJzdGF0ZS4gKi8NCj4gPiAtICAgICB0aGlzX2NwdV93cml0ZShjcHVf
dGxic3RhdGUubGFzdF91c2VyX21tX2licGIsIExBU1RfVVNFUl9NTV9JQlBCKTsNCj4gPiArICAg
ICB0aGlzX2NwdV93cml0ZShjcHVfdGxic3RhdGUubGFzdF91c2VyX21tX3NwZWMsIExBU1RfVVNF
Ul9NTV9JQlBCKTsNCj4gDQo+IFNob3VsZG4ndCB0aGF0IGJlIExBU1RfVVNFUl9NTV9NQVNLPw0K
PiANCj4gDQoNCk5vLCB0aGF0IGNyYXNoZXMgdGhlIHN5c3RlbSBmb3IgU1cgZmx1c2hlcywgYmVj
YXVzZSBpdCB0cmllcyB0byBmbHVzaCB0aGUgTDFEDQp2aWEgdGhlIHNvZnR3YXJlIGxvb3AgYW5k
IGVhcmx5IGVub3VnaCB3ZSBkb24ndCBoYXZlIHRoZSBsMWRfZmx1c2hfcGFnZXMNCmFsbG9jYXRl
ZC4gTEFTVF9VU0VSX01NX01BU0sgaGFzIExBU1RfVVNFUl9NTV9GTFVTSF9MMUQgYml0IHNldC4N
Cg0KQmFsYmlyIFNpbmdoLg0K
