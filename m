Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB75C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 22:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D03720732
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 22:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="hwyNFcwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgDQWem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 18:34:42 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:13043 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbgDQWem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 18:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1587162882; x=1618698882;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=DchYnK60MuDOpyabckS1zOOUOwoNX3zqRvAqlA6xKLs=;
  b=hwyNFcwAF5A7yx9Nt3PQSaCUlQLdx+hoV7yCauSJdWE5fov1+V+BYHfF
   kvg1j7GmNAfRF1OfEQpflueW7AVt/7Txi2yFRO8iu0V3jDaNkzsdZ0Lby
   rSrj4ifB5o6eKQLT3/0XsyE56JnNydCIBhsOsAUvi7TVUom1aVnbLQu3W
   o=;
IronPort-SDR: qr3LCvGKD5xFoSyBmPpyPxVW0GTD9IFJU9aUIWACQ/HoqcnrbxTJ2F7vYcTNqto8FR2qPyVNZu
 Tj8/lHVhFXuw==
X-IronPort-AV: E=Sophos;i="5.72,395,1580774400"; 
   d="scan'208";a="26128144"
Subject: Re: [PATCH v3 1/5] arch/x86/kvm: Refactor l1d flush lifecycle management
Thread-Topic: [PATCH v3 1/5] arch/x86/kvm: Refactor l1d flush lifecycle management
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 17 Apr 2020 22:34:29 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (Postfix) with ESMTPS id 093E9A1881;
        Fri, 17 Apr 2020 22:34:27 +0000 (UTC)
Received: from EX13D01UWB003.ant.amazon.com (10.43.161.94) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 17 Apr 2020 22:34:27 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB003.ant.amazon.com (10.43.161.94) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 17 Apr 2020 22:34:27 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Fri, 17 Apr 2020 22:34:27 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>
Thread-Index: AQHWDYR4Y2yZsvGAI0C/KC6gPxKwqKh9VFcAgAChUwA=
Date:   Fri, 17 Apr 2020 22:34:27 +0000
Message-ID: <8c0cbcbd6270f333699bb1b9db113bbe99c98396.camel@amazon.com>
References: <20200408090229.16467-1-sblbir@amazon.com>
         <20200408090229.16467-2-sblbir@amazon.com>
         <871rommfs1.fsf@nanos.tec.linutronix.de>
In-Reply-To: <871rommfs1.fsf@nanos.tec.linutronix.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.52]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9959C8B6682174FB0DC63996403BE45@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTA0LTE3IGF0IDE0OjU3ICswMjAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9y
Z2FuaXphdGlvbi4gRG8gbm90DQo+IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdSBjYW4gY29uZmlybSB0aGUgc2VuZGVyIGFuZCBrbm93DQo+IHRoZSBjb250ZW50IGlz
IHNhZmUuDQo+IA0KPiANCj4gDQo+IEJhbGJpciBTaW5naCA8c2JsYmlyQGFtYXpvbi5jb20+IHdy
aXRlczoNCj4gPiAgI2luY2x1ZGUgPGFzbS1nZW5lcmljL2NhY2hlZmx1c2guaD4NCj4gPiAgI2lu
Y2x1ZGUgPGFzbS9zcGVjaWFsX2luc25zLmg+DQo+ID4gDQo+ID4gKyNkZWZpbmUgTDFEX0NBQ0hF
X09SREVSIDQNCj4gDQo+IE5ld2xpbmUgYmV0d2VlbiBjb25zdGFudHMgYW5kIGRlY2xhcmF0aW9u
cyBwbGVhc2UNCj4gDQo+ID4gIHZvaWQgY2xmbHVzaF9jYWNoZV9yYW5nZSh2b2lkICphZGRyLCB1
bnNpZ25lZCBpbnQgc2l6ZSk7DQo+ID4gK3ZvaWQgKmFsbG9jX2wxZF9mbHVzaF9wYWdlcyh2b2lk
KTsNCj4gPiArdm9pZCBjbGVhbnVwX2wxZF9mbHVzaF9wYWdlcyh2b2lkICpsMWRfZmx1c2hfcGFn
ZXMpOw0KPiANCj4gQ2FuIHdlIHBsZWFzZSBoYXZlIGEgY29uc2lzdGVudCBuYW1lIHNwYWNlIHBy
ZWZpeD8NCj4gDQo+IGwxZF9mbHVzaF8qKCkNCj4gDQoNCkkgdXNlZCBsMWRfZmx1c2hfcGFnZXMg
YXMgYSBub3VuIGFuZCB0aGVuIGEgdmVyYiBpbiBmcm9udCBvZiBpdCB0byBkZW5vdGUNCmFjdGlv
biBhbGxvY19sMWRfZmx1c2hfcGFnZXMoKSwgaGFwcHkgdG8gY2hhbmdlIGl0IG92ZXIsIGRvbid0
IGZlZWwgdG8NCnN0cm9uZ2x5IGFib3V0IGl0Lg0KDQpCYWxiaXINCg0K
