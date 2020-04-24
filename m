Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D166C2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 09:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03E932076C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 09:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PoyY3WiZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgDXJ4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 05:56:55 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:37624 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgDXJ4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 05:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1587722214; x=1619258214;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=RCYAT3eCPrO0l7QcYkxQyQGM1Nkx1oengszxg2gUfps=;
  b=PoyY3WiZ+l5nWB2CiCDOUVXnGJjhikd4BOf/skwCNL7+ccUNGFaWrIUu
   YKQXAocBMdbfREH4PrghZtaF1SAK+wNDM+neFLwzk2lX2nK4jcfQNr4OO
   oNSfwBpk1rBl8/NSGyEft+I9+S2DbGTrT2hTIyCabpSnq9rDRUAZFTUur
   8=;
IronPort-SDR: d9ycl9mSBKVFyEsPylr1himH6lIWdBnVHgyDzBMr/UUuBTPOeihlMEmvx0dpWglHlFpUIQTiQU
 KwgjgPeuXEVg==
X-IronPort-AV: E=Sophos;i="5.73,311,1583193600"; 
   d="scan'208";a="27445645"
Subject: Re: [PATCH v4 5/6] Optionally flush L1D on context switch
Thread-Topic: [PATCH v4 5/6] Optionally flush L1D on context switch
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 24 Apr 2020 09:56:40 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (Postfix) with ESMTPS id D9888A21F3;
        Fri, 24 Apr 2020 09:56:39 +0000 (UTC)
Received: from EX13D01UWB004.ant.amazon.com (10.43.161.157) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 24 Apr 2020 09:56:39 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13d01UWB004.ant.amazon.com (10.43.161.157) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 24 Apr 2020 09:56:39 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Fri, 24 Apr 2020 09:56:39 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "keescook@chromium.org" <keescook@chromium.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>
Thread-Index: AQHWGXe3cUmOwWoImkqS1xmlEcVBgKiHFWEAgAD0+gA=
Date:   Fri, 24 Apr 2020 09:56:39 +0000
Message-ID: <5ee183ddd5fd9413353190fe95058a8be74c7d55.camel@amazon.com>
References: <20200423140125.7332-1-sblbir@amazon.com>
         <20200423140125.7332-6-sblbir@amazon.com> <202004231219.9D614F5@keescook>
In-Reply-To: <202004231219.9D614F5@keescook>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.203]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC5379AC12652549AC91B59C76A261BA@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA0LTIzIGF0IDEyOjE5IC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IENB
VVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9yZ2FuaXph
dGlvbi4gRG8gbm90DQo+IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlv
dSBjYW4gY29uZmlybSB0aGUgc2VuZGVyIGFuZCBrbm93DQo+IHRoZSBjb250ZW50IGlzIHNhZmUu
DQo+IA0KPiANCj4gDQo+IE9uIEZyaSwgQXByIDI0LCAyMDIwIGF0IDEyOjAxOjI0QU0gKzEwMDAs
IEJhbGJpciBTaW5naCB3cm90ZToNCj4gPiBJbXBsZW1lbnQgYSBtZWNoYW5pc20gdG8gc2VsZWN0
aXZlbHkgZmx1c2ggdGhlIEwxRCBjYWNoZS4gVGhlIGdvYWwgaXMgdG8NCj4gPiBhbGxvdyB0YXNr
cyB0aGF0IGFyZSBwYXJhbm9pZCBkdWUgdG8gdGhlIHJlY2VudCBzbm9vcCBhc3Npc3RlZCBkYXRh
DQo+ID4gc2FtcGxpbmcNCj4gPiB2dWxuZXJhYmlsaXRlcywgdG8gZmx1c2ggdGhlaXIgTDFEIG9u
IGJlaW5nIHN3aXRjaGVkIG91dC4gIFRoaXMgcHJvdGVjdHMNCj4gPiB0aGVpciBkYXRhIGZyb20g
YmVpbmcgc25vb3BlZCBvciBsZWFrZWQgdmlhIHNpZGUgY2hhbm5lbHMgYWZ0ZXIgdGhlIHRhc2sN
Cj4gPiBoYXMgY29udGV4dCBzd2l0Y2hlZCBvdXQuDQo+ID4gDQo+ID4gVGhlcmUgYXJlIHR3byBz
Y2VuYXJpb3Mgd2UgbWlnaHQgd2FudCB0byBwcm90ZWN0IGFnYWluc3QsIGEgdGFzayBsZWF2aW5n
DQo+ID4gdGhlIENQVSB3aXRoIGRhdGEgc3RpbGwgaW4gTDFEICh3aGljaCBpcyB0aGUgbWFpbiBj
b25jZXJuIG9mIHRoaXMgcGF0Y2gpLA0KPiA+IHRoZSBzZWNvbmQgc2NlbmFyaW8gaXMgYSBtYWxp
Y2lvdXMgdGFzayBjb21pbmcgaW4gKG5vdCBzbyB3ZWxsIHRydXN0ZWQpDQo+ID4gZm9yIHdoaWNo
IHdlIHdhbnQgdG8gY2xlYW4gdXAgdGhlIGNhY2hlIGJlZm9yZSBpdCBzdGFydHMuIE9ubHkgdGhl
IGNhc2UNCj4gPiBmb3IgdGhlIGZvcm1lciBpcyBhZGRyZXNzZWQuDQo+ID4gDQo+ID4gQSBuZXcg
dGhyZWFkX2luZm8gZmxhZyBUSUZfU1BFQ19GTFVTSF9MMUQgaXMgYWRkZWQgdG8gdHJhY2sgdGFz
a3Mgd2hpY2gNCj4gPiBvcHQtaW50byBMMUQgZmx1c2hpbmcuIGNwdV90bGJzdGF0ZS5sYXN0X3Vz
ZXJfbW1fc3BlYyBpcyB1c2VkIHRvIGNvbnZlcnQNCj4gPiB0aGUgVElGIGZsYWdzIGludG8gbW0g
c3RhdGUgKHBlciBjcHUgdmlhIGxhc3RfdXNlcl9tbV9zcGVjKSBpbg0KPiA+IGNvbmRfbWl0aWdh
dGlvbigpLCB3aGljaCB0aGVuIHVzZWQgdG8gZG8gZGVjaWRlIHdoZW4gdG8gY2FsbCBmbHVzaF9s
MWQoKS4NCj4gPiANCj4gPiBBZGQgcHJjdGwoKSdzIHRvIG9wdC1pbiB0byB0aGUgTDFEIGNhY2hl
IG9uIGNvbnRleHQgc3dpdGNoIG91dCwgdGhlDQo+ID4gZXhpc3RpbmcgbWVjaGFuaXNtcyBvZiB0
cmFja2luZyBwcmV2X21tIHZpYSBjcHVfdGxic3RhdGUgaXMNCj4gPiByZXVzZWQgdG8gdHJhY2sg
c3RhdGUgb2YgdGhlIHRhc2tzIGFuZCB0byBmbHVzaCB0aGUgTDFEIGNhY2hlLg0KPiA+IFRoZSBw
cmN0bCBpbnRlcmZhY2UgaXMgZ2VuZXJpYyBhbmQgY2FuIGJlIHBvcnRlZCBvdmVyIHRvIG90aGVy
DQo+ID4gYXJjaGl0ZWN0dXJlcy4NCj4gPiANCj4gPiBTdWdnZXN0ZWQtYnk6IFRob21hcyBHbGVp
eG5lciA8dGdseEBsaW51dHJvbml4LmRlPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJhbGJpciBTaW5n
aCA8c2JsYmlyQGFtYXpvbi5jb20+DQo+IA0KPiBJJ20gbm90IGEgaHVnZSBmYW4gb2YgX193ZWFr
IChJIGxpa2UgQ09ORklHcyBiZXR0ZXIpLCBidXQgdGhhdCdzIG5vDQo+IGVub3VnaCB0byBOQUsg
dGhpcy4gOykgVGhhbmtzIGZvciB0aGUgcHJjdGwoKSBjaGFuZ2UhDQo+IA0KPiBSZXZpZXdlZC1i
eTogS2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5vcmc+DQo+IA0KDQpUaGFua3MsIHRoZSBD
T05GSUdfKiBzZWVtZWQgYSBiaXQgbXVjaCBmb3IgdHdvIGZ1bmN0aW9ucy4NCg0KQmFsYmlyIFNp
bmdoLg0K
