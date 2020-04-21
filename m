Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE234C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 03:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDE852071E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 03:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="B1FyKoS8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgDUDrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 23:47:06 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:50081 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgDUDrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 23:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1587440825; x=1618976825;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pT4ehHT/Gya7eiIlqUxl+JlsqzDx2FVDAu4HZIrBjY8=;
  b=B1FyKoS8jBKSInOxAXyQk0N1VXJrC7DnARRs7HaqKd2qPEkhrRzvYecF
   xy0nZ58Gtvb7hSKxgA4mgo3OabQNM90iS8b4mXjqX+NHT6kEbSQ202LXH
   wJyAkiRmbpBdc5j/RYnZtXgotevOdvmhVjyH15/Wk4Uo7k6GLgQhYj+T2
   I=;
IronPort-SDR: PGw4DOxkkhoNarGYS/8HgBeQ5z6ZKUIIFmZKoY8wm8PL+k/l0sg63BT/YGQR8NoY9NgxiHFwb3
 E4a2eWv+/9KQ==
X-IronPort-AV: E=Sophos;i="5.72,408,1580774400"; 
   d="scan'208";a="38385253"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-22cc717f.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 21 Apr 2020 03:47:01 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-22cc717f.us-west-2.amazon.com (Postfix) with ESMTPS id 13958A1E5A;
        Tue, 21 Apr 2020 03:47:00 +0000 (UTC)
Received: from EX13D01UWB003.ant.amazon.com (10.43.161.94) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 21 Apr 2020 03:46:59 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB003.ant.amazon.com (10.43.161.94) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 21 Apr 2020 03:46:59 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Tue, 21 Apr 2020 03:46:59 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>
Subject: Re:  [PATCH v3 3/5] arch/x86/mm: Refactor cond_ibpb() to support
 other use cases
Thread-Topic: [PATCH v3 3/5] arch/x86/mm: Refactor cond_ibpb() to support
 other use cases
Thread-Index: AQHWF4+CrdiQ0H/ugE+EG6G+uj3LHQ==
Date:   Tue, 21 Apr 2020 03:46:59 +0000
Message-ID: <9cbabf58e0a6fe3775c268d1fa4517d02ad7e617.camel@amazon.com>
References: <20200408090229.16467-1-sblbir@amazon.com>
         <20200408090229.16467-4-sblbir@amazon.com>
         <87sgh2l0q4.fsf@nanos.tec.linutronix.de>
         <12023cc73a6344ed7499e09492a6934c1dfaf044.camel@amazon.com>
         <87pnc5xgff.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87pnc5xgff.fsf@nanos.tec.linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.193]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B849F9263E7BE840AF5D6B90F5BB71A0@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIwLTA0LTE4IGF0IDExOjU5ICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IA0KPiAiU2luZ2gsIEJhbGJpciIgPHNibGJpckBhbWF6b24uY29tPiB3cml0ZXM6DQo+ID4g
T24gRnJpLCAyMDIwLTA0LTE3IGF0IDE1OjA3ICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+ID4gPiANCj4gPiA+IEJhbGJpciBTaW5naCA8c2JsYmlyQGFtYXpvbi5jb20+IHdyaXRlczoN
Cj4gPiA+ID4gDQo+ID4gPiA+ICAvKg0KPiA+ID4gPiAtICogVXNlIGJpdCAwIHRvIG1hbmdsZSB0
aGUgVElGX1NQRUNfSUIgc3RhdGUgaW50byB0aGUgbW0gcG9pbnRlcg0KPiA+ID4gPiB3aGljaCBp
cw0KPiA+ID4gPiAtICogc3RvcmVkIGluIGNwdV90bGJfc3RhdGUubGFzdF91c2VyX21tX2licGIu
DQo+ID4gPiA+ICsgKiBCaXRzIHRvIG1hbmdsZSB0aGUgVElGX1NQRUNfSUIgc3RhdGUgaW50byB0
aGUgbW0gcG9pbnRlciB3aGljaCBpcw0KPiA+ID4gPiArICogc3RvcmVkIGluIGNwdV90bGJfc3Rh
dGUubGFzdF91c2VyX21tX3NwZWMuDQo+ID4gPiA+ICAgKi8NCj4gPiA+ID4gICNkZWZpbmUgTEFT
VF9VU0VSX01NX0lCUEIgICAgMHgxVUwNCj4gPiA+ID4gKyNkZWZpbmUgTEFTVF9VU0VSX01NX1NQ
RUNfTUFTSyAgICAgICAoTEFTVF9VU0VSX01NX0lCUEIpDQo+ID4gPiA+IA0KPiA+ID4gPiAgICAg
ICAvKiBSZWluaXRpYWxpemUgdGxic3RhdGUuICovDQo+ID4gPiA+IC0gICAgIHRoaXNfY3B1X3dy
aXRlKGNwdV90bGJzdGF0ZS5sYXN0X3VzZXJfbW1faWJwYiwNCj4gPiA+ID4gTEFTVF9VU0VSX01N
X0lCUEIpOw0KPiA+ID4gPiArICAgICB0aGlzX2NwdV93cml0ZShjcHVfdGxic3RhdGUubGFzdF91
c2VyX21tX3NwZWMsDQo+ID4gPiA+IExBU1RfVVNFUl9NTV9JQlBCKTsNCj4gPiA+IA0KPiA+ID4g
U2hvdWxkbid0IHRoYXQgYmUgTEFTVF9VU0VSX01NX01BU0s/DQo+ID4gPiANCj4gPiANCj4gPiBO
bywgdGhhdCBjcmFzaGVzIHRoZSBzeXN0ZW0gZm9yIFNXIGZsdXNoZXMsIGJlY2F1c2UgaXQgdHJp
ZXMgdG8gZmx1c2ggdGhlDQo+ID4gTDFEDQo+ID4gdmlhIHRoZSBzb2Z0d2FyZSBsb29wIGFuZCBl
YXJseSBlbm91Z2ggd2UgZG9uJ3QgaGF2ZSB0aGUgbDFkX2ZsdXNoX3BhZ2VzDQo+ID4gYWxsb2Nh
dGVkLiBMQVNUX1VTRVJfTU1fTUFTSyBoYXMgTEFTVF9VU0VSX01NX0ZMVVNIX0wxRCBiaXQgc2V0
Lg0KPiANCj4gWW91IGNhbiB0cml2aWFsbHkgcHJldmVudCB0aGlzIGJ5IGNoZWNraW5nIGwxZF9m
bHVzaF9wYWdlcyAhPSBOVUxMLg0KPiANCg0KQnV0IHdoeSB3b3VsZCB3ZSB3YW50IHRvIGZsdXNo
IG9uIHJlaW5pdD8gSXQgaXMgZWl0aGVyIGNvbWluZyBiYWNrIGZyb20gYSBsb3cNCnBvd2VyIHN0
YXRlIG9yIGluaXRpYWxpc2luZywgaXMgaXQgd29ydGggYWRkaW5nIGEgY2hlY2sgZm9yICE9IE5V
TEwgZXZlcnl0aW1lDQp3ZSBmbHVzaCB0byBoYW5kbGUgdGhpcyBjYXNlPw0KDQpUaGFua3MsDQpC
YWxiaXINCg0K
