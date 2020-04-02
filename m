Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53539C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 22:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE572206F8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 22:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RfuZt35x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389573AbgDBWTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 18:19:02 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:19888 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgDBWTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 18:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585865941; x=1617401941;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=go/JuGKaHOod4bhA+dQw7sF/0xVz45NyR0D/yH5ioaY=;
  b=RfuZt35xZEsJ0WS7223nq1GRmwkHi/Ptdv3fUEH0hOyebSKhlTOYaEaa
   K1x3+jhZMnRYJFH0Jqe+JbSAiz8RzuJnbRkHSxQ/kuf3KHWC0bU7f6TWg
   Td2ef1aqhV4aLjW7Xpwu4PkACQPEJupEYWZZ1OtZ6QKniiSzTnwA/gWJo
   8=;
IronPort-SDR: 852IGI2ccF7rlZp21kgF7tJPvTK1iXpluB4qRjimsaR2uQ3AsLsKyhhVTlG5bJ7XJ2GnbflUZA
 0tjSgGlLDaig==
X-IronPort-AV: E=Sophos;i="5.72,337,1580774400"; 
   d="scan'208";a="26637487"
Subject: Re: [PATCH 3/3] arch/x86: Optionally flush L1D on context switch
Thread-Topic: [PATCH 3/3] arch/x86: Optionally flush L1D on context switch
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 02 Apr 2020 22:18:58 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (Postfix) with ESMTPS id 90BEBA2361;
        Thu,  2 Apr 2020 22:18:55 +0000 (UTC)
Received: from EX13D01UWB001.ant.amazon.com (10.43.161.75) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 2 Apr 2020 22:18:55 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB001.ant.amazon.com (10.43.161.75) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 2 Apr 2020 22:18:54 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Thu, 2 Apr 2020 22:18:54 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "bp@alien8.de" <bp@alien8.de>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>
Thread-Index: AQHWCLejDt1H7tG0W0uohgcqhgtMwKhmZcqAgAACKgA=
Date:   Thu, 2 Apr 2020 22:18:54 +0000
Message-ID: <b6655e68246bb19bd1dde17602c80dc4d9c9d2c8.camel@amazon.com>
References: <20200402062401.29856-1-sblbir@amazon.com>
         <20200402062401.29856-4-sblbir@amazon.com> <20200402221109.GJ9352@zn.tnic>
In-Reply-To: <20200402221109.GJ9352@zn.tnic>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.171]
Content-Type: text/plain; charset="utf-8"
Content-ID: <481516BA7F7FA54A887902A526E7BDA6@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTA0LTAzIGF0IDAwOjExICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
DQo+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9y
Z2FuaXphdGlvbi4gRG8gbm90DQo+IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdSBjYW4gY29uZmlybSB0aGUgc2VuZGVyIGFuZCBrbm93DQo+IHRoZSBjb250ZW50IGlz
IHNhZmUuDQo+IA0KPiANCj4gDQo+IE9uIFRodSwgQXByIDAyLCAyMDIwIGF0IDA1OjI0OjAxUE0g
KzExMDAsIEJhbGJpciBTaW5naCB3cm90ZToNCj4gPiAraW50IGVuYWJsZV9sMWRfZmx1c2hfZm9y
X3Rhc2soc3RydWN0IHRhc2tfc3RydWN0ICp0c2spDQo+ID4gK3sNCj4gPiArICAgICBzdHJ1Y3Qg
cGFnZSAqcGFnZTsNCj4gPiArICAgICBpbnQgcmV0ID0gMDsNCj4gPiArDQo+ID4gKyAgICAgaWYg
KHN0YXRpY19jcHVfaGFzKFg4Nl9GRUFUVVJFX0ZMVVNIX0wxRCkpDQo+ID4gKyAgICAgICAgICAg
ICBnb3RvIGRvbmU7DQo+ID4gKw0KPiA+ICsgICAgIHBhZ2UgPSBSRUFEX09OQ0UobDFkX2ZsdXNo
X3BhZ2VzKTsNCj4gPiArICAgICBpZiAodW5saWtlbHkoIXBhZ2UpKSB7DQo+ID4gKyAgICAgICAg
ICAgICBtdXRleF9sb2NrKCZsMWRfZmx1c2hfbXV0ZXgpOw0KPiA+ICsgICAgICAgICAgICAgaWYg
KCFsMWRfZmx1c2hfcGFnZXMpIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgbDFkX2ZsdXNo
X3BhZ2VzID0gYWxsb2NfbDFkX2ZsdXNoX3BhZ2VzKCk7DQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgIGlmICghbDFkX2ZsdXNoX3BhZ2VzKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHJldHVybiAtRU5PTUVNOw0KPiANCj4gRG8gSSBzZWUgaXQgY29ycmVjdGx5IHRoYXQgeW91
J2xsIHJldHVybiBoZXJlIHdpdGggbDFkX2ZsdXNoX211dGV4IHN0aWxsDQo+IGhlbGQ/DQoNCkRh
cm4uLiA6KA0KDQpJIGhhZCBnb3RvIGRvbmUgdG8gcmVsZWFzZSB0aGUgbXV0ZXggZWFybGllciwg
bGV0IG1lIGZpeCB0aGF0IDopDQoNClRoYW5rcywNCkJhbGJpciBTaW5naA0KDQo+IA0KPiA+ICsg
ICAgICAgICAgICAgfQ0KPiA+ICsgICAgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZsMWRfZmx1c2hf
bXV0ZXgpOw0KPiA+ICsgICAgIH0NCj4gPiArICAgICAvKiBJIGRvbid0IHRoaW5rIHdlIG5lZWQg
dG8gd29ycnkgYWJvdXQgS1NNICovDQo+IA0KPiBQbHMgdXNlIHBhc3NpdmUgdm9pY2U6IG5vICJ3
ZSIgb3IgIkkiLCBldGMuDQo+IA0KPiAtLQ0KPiBSZWdhcmRzL0dydXNzLA0KPiAgICAgQm9yaXMu
DQo+IA0KPiBodHRwczovL3Blb3BsZS5rZXJuZWwub3JnL3RnbHgvbm90ZXMtYWJvdXQtbmV0aXF1
ZXR0ZQ0K
