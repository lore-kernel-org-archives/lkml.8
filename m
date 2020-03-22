Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B434C4332E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 05:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5461020724
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 05:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dKGLxWTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgCVFKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 01:10:48 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:21526 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgCVFKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 01:10:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1584853847; x=1616389847;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=PV6KYFeVnmstLw8roPdI+/D3tpcTHK2VCOwAUhB6pDU=;
  b=dKGLxWTO8EWTmIkqt7ZI5k1+CWGKm+VbmT5rFsLO3nuGqA7X08RdbMrX
   mKtOcT7fOsBpxuolzNyfzxY0WBoBLPPlYL5ZG/8YP/1kLOVhbcsBE8Ajj
   uVOP0rV0MOG4Ry9ebJ/YdL/zGulb2xbTkKRofPFEeW3m37qpfMegElJkk
   A=;
IronPort-SDR: T/CdMhn+cVgER0l9iQISzUgY7XuNnwdqybo+GYjpFxLOFU0KWjmKcykDqK7+HrqHslhCNEn0Yt
 I3GeMxlXtnLw==
X-IronPort-AV: E=Sophos;i="5.72,291,1580774400"; 
   d="scan'208";a="22620519"
Subject: Re: [RFC PATCH] arch/x86: Optionally flush L1D on context switch
Thread-Topic: [RFC PATCH] arch/x86: Optionally flush L1D on context switch
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-9ec21598.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 22 Mar 2020 05:10:46 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-9ec21598.us-east-1.amazon.com (Postfix) with ESMTPS id BC811A2069;
        Sun, 22 Mar 2020 05:10:44 +0000 (UTC)
Received: from EX13D01UWB003.ant.amazon.com (10.43.161.94) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 22 Mar 2020 05:10:43 +0000
Received: from EX13D21UWB003.ant.amazon.com (10.43.161.212) by
 EX13d01UWB003.ant.amazon.com (10.43.161.94) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 22 Mar 2020 05:10:43 +0000
Received: from EX13D21UWB003.ant.amazon.com ([10.43.161.212]) by
 EX13D21UWB003.ant.amazon.com ([10.43.161.212]) with mapi id 15.00.1497.006;
 Sun, 22 Mar 2020 05:10:43 +0000
From:   "Herrenschmidt, Benjamin" <benh@amazon.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Singh, Balbir" <sblbir@amazon.com>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>
Thread-Index: AQHV+YNf0XL+89Yus02bM+oWtkWm5qhPGnoAgAGi3QCAAKrMAIAA6NIAgACMhwCAAT/2gA==
Date:   Sun, 22 Mar 2020 05:10:43 +0000
Message-ID: <d2a091cde8f26ab9c994c1ebc8059873d3524e11.camel@amazon.com>
References: <20200313220415.856-1-sblbir@amazon.com>
         <87imj19o13.fsf@nanos.tec.linutronix.de>
         <97b2bffc16257e70b8aa98ee86622dc4178154c4.camel@amazon.com>
         <8736a3456r.fsf@nanos.tec.linutronix.de>
         <034a2c0e2cc1bb0f4f7ff9a2c5cbdc269a483a71.camel@amazon.com>
         <87d096rpjn.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87d096rpjn.fsf@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.180]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC689244CB399F428E452285D6FC7E1F@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIwLTAzLTIxIGF0IDExOjA1ICswMTAwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IHZpY3RpbTENCj4gIHN0b3JlIHNlY3JpdA0KPiAgICAgICAgICAgICAgICAgICAgICAgICB2
aWN0aW0yDQo+IGF0dGFja2VyICAgICAgICAgICAgICAgICAgcmVhZCBzZWNyaXQNCj4gDQo+IE5v
dyBpZiBMMUQgaXMgZmx1c2hlZCBvbiBDUFUwIGJlZm9yZSBhdHRhY2tlciByZWFjaGVzIHVzZXIg
c3BhY2UsDQo+IGkuZS4gcmVhY2hlcyB0aGUgYXR0YWNrIGNvZGUsIHRoZW4gdGhlcmUgaXMgbm90
aGluZyB0byBzZWUuIEZyb20gdGhlDQo+IGxpbms6DQo+IA0KPiAgIFNpbWlsYXIgdG8gdGhlIEwx
VEYgVk1NIG1pdGlnYXRpb25zLCBzbm9vcC1hc3Npc3RlZCBMMUQgc2FtcGxpbmcgY2FuIGJlDQo+
ICAgbWl0aWdhdGVkIGJ5IGZsdXNoaW5nIHRoZSBMMUQgY2FjaGUgYmV0d2VlbiB3aGVuIHNlY3Jl
dHMgYXJlIGFjY2Vzc2VkDQo+ICAgYW5kIHdoZW4gcG9zc2libHkgbWFsaWNpb3VzIHNvZnR3YXJl
IHJ1bnMgb24gdGhlIHNhbWUgY29yZS4NCj4gDQo+IFNvIHRoZSBpbXBvcnRhbnQgcG9pbnQgaXMg
dG8gZmx1c2ggX2JlZm9yZV8gdGhlIGF0dGFjayBjb2RlIHJ1bnMgd2hpY2gNCj4gaW52b2x2ZXMg
Z29pbmcgYmFjayB0byB1c2VyIHNwYWNlIG9yIGd1ZXN0IG1vZGUuDQoNClNvIHlvdSBtZWFuIHN3
aXRjaGluZyBmcm9tIHZpY3RpbSB0byBhdHRhY2tlciBpbiB0aGUga2VybmVsLCBhbmQgZ29pbmcN
CmJhY2sgdG8gdmljdGltIGJlZm9yZSB0aGUgYXR0YWNrZXIgaGFzIGEgY2hhbmNlIHRvIGFjdHVh
bGx5IGV4ZWN1dGUgYW55DQp1c2Vyc3BhY2UgY29kZSA/DQoNCkkgY2FuIHNlZSB3aHkgdGhpcyBk
b2Vzbid0IHJlcXVpcmUgYSBmbHVzaCwgYnV0IGlzIGl0IGEgY2FzZSB3b3J0aA0Kb3B0aW1pemlu
ZyBmb3IgZWl0aGVyID8NCg0KSUUuIFRoZSBmbHVzaCBpbiBzd2l0Y2hfbW0gaXMgcmF0aGVyIHRy
aXZpYWwsIGlzIGxvd2VyIG92ZXJoZWFkIHRoYW4NCmFkZGluZyBjb2RlIHRvIHRoZSB1c2Vyc3Bh
Y2UgcmV0dXJuIGNvZGUsIGFuZCBhdm9pZHMga2VybmVsIHRocmVhZHMNCmxpa2VseSwgSSBwcmVm
ZXIgaXQgZm9yIGl0cyBzaW1wbGljaXR5IFRCSC4uLg0KDQpDaGVlcnMsDQpCZW4uDQoNCg==
