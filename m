Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAFEC1975A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 07:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B16206C3
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 07:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=diehl.com header.i=@diehl.com header.b="dWuTXAdd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgCVH7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 03:59:46 -0400
Received: from enterprise01.smtp.diehl.com ([193.201.238.219]:10327 "EHLO
        enterprise01.smtp.diehl.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726137AbgCVH7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 03:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=diehl.com; i=@diehl.com; q=dns/txt; s=default;
  t=1584863985; x=1616399985;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Fem6jQ39AwpuKZSi17gx/K9tSUlr5lUCNfwzMuEveHU=;
  b=dWuTXAddRiHVX2IPX3x6Ot6uRIx7X9Dr7/Jy7SCzRZ6F8kDgKcfgm+v3
   ki0sZZJaOgFdS7drBACvM0DoqE3WqS6QHu4UIXBV0Kx2mMNiaYnmIURpt
   LO+C7M2hZ0LhlTkdV/2aSMEfd3qKLk8n3u75W8GcHGKH+NOWtnh4qR20v
   rxaaAV6bmeGSfgWpG62TnJgHILBZJLPaGol+GFzhF9pxBaVNcuD1bJ6Tb
   lUbsjPmtsC+hPP/z93fdmi93ZTby6pmX0w88P+acIPBZBGV6e6ULkSmKm
   gzstjyjnDrGRbYF4f5rqyE48Vjkkw0tUwOTNt62+u0qHK5Q86/vJou36i
   Q==;
IronPort-SDR: DWOJ//jVVO6Pxb3qeXK4BCaQrkObGw4XestxW7HLhe7XXqqw3nNAtJqmeVF+5yRsntNXZpe47b
 Vsmx1/5N5xBA==
From:   Denis Osterland-Heim <denis.osterland@diehl.com>
To:     "pavel@ucw.cz" <pavel@ucw.cz>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmurphy@ti.com" <dmurphy@ti.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jacek.anaszewski@gmail.com" <jacek.anaszewski@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
Subject: Re: [PATCH v4 5/5] leds: pwm: add reference to common leds for
 default-state
Thread-Topic: [PATCH v4 5/5] leds: pwm: add reference to common leds for
 default-state
Thread-Index: AQHV/1jv4y0tSPQJv0Wp72clTKSY2ahTF4+AgAEYqAA=
Date:   Sun, 22 Mar 2020 07:59:40 +0000
Message-ID: <00f27953c471b371243629096fabf07d3e0c8ce5.camel@diehl.com>
References: <20200321081321.15614-1-Denis.Osterland@diehl.com>
         <20200321081321.15614-6-Denis.Osterland@diehl.com>
         <20200321151509.GA8386@duo.ucw.cz>
In-Reply-To: <20200321151509.GA8386@duo.ucw.cz>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <ECA7AA20A25A6746ABCF10FC9788D7D2@diehl.internal>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TrailerSkip: 1
X-GBS-PROC: byQFdw3ukCM+zy1/poiPc47NbmZSKvzVm6VGx3H/zlNNCUcwGW8lN756jMVRlTdb
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGF2ZWwsDQoNCkkgZm9yZ290IHRvIGFkZCB0aGUgQWNrZWQtYnk6IEphY2VrIEFuYXN6
ZXdza2kgPGphY2VrLmFuYXN6ZXdza2lAZ21haWwuY29tPg0KZ2l2ZW4gaW4gaHR0cHM6Ly93
d3cuc3Bpbmljcy5uZXQvbGlzdHMvbGludXgtbGVkcy9tc2cxNTE0OS5odG1sDQp3aGljaCBp
cyBvbmx5IHZhbGlkIGZvciB0aGlzIHBhdGNoLCBiZWNhdXNlIEkgaGF2ZSBjaGFuZ2VkIHRo
ZSBvdGhlciB0d28uDQoNClJlZ2FyZHMgRGVuaXMNCg0KQW0gU2Ftc3RhZywgZGVuIDIxLjAz
LjIwMjAsIDE2OjE1ICswMTAwIHNjaHJpZWIgUGF2ZWwgTWFjaGVrOg0KPiBPbiBTYXQgMjAy
MC0wMy0yMSAwODoxNTo1MSwgRGVuaXMgT3N0ZXJsYW5kLUhlaW0gd3JvdGU6DQo+ID4gVGhl
IGRlZmF1bHQtc3RhdGUgaXMgbm93IHN1cHBvcnRlZCBmb3IgUFdNIGxlZHMuDQo+ID4gDQo+
ID4gU2lnbmVkLW9mZi1ieTogRGVuaXMgT3N0ZXJsYW5kLUhlaW0gPERlbmlzLk9zdGVybGFu
ZEBkaWVobC5jb20+DQo+IA0KPiBBY2tlZC1ieTogUGF2ZWwgTWFjaGVrIDxwYXZlbEB1Y3cu
Y3o+DQo+IA0KDQoNCkRpZWhsIENvbm5lY3Rpdml0eSBTb2x1dGlvbnMgR21iSA0KR2VzY2jD
pGZ0c2bDvGhydW5nOiBIb3JzdCBMZW9uYmVyZ2VyDQpTaXR6IGRlciBHZXNlbGxzY2hhZnQ6
IE7DvHJuYmVyZyAtIFJlZ2lzdGVyZ2VyaWNodDogQW10c2dlcmljaHQNCk7DvHJuYmVyZzog
SFJCIDMyMzE1DQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18NCg0KRGVyIEluaGFsdCBkZXIgdm9yc3RlaGVuZGVuIEUtTWFpbCBpc3QgbmljaHQgcmVj
aHRsaWNoIGJpbmRlbmQuIERpZXNlIEUtTWFpbCBlbnRoYWVsdCB2ZXJ0cmF1bGljaGUgdW5k
L29kZXIgcmVjaHRsaWNoIGdlc2NodWV0enRlIEluZm9ybWF0aW9uZW4uDQpJbmZvcm1pZXJl
biBTaWUgdW5zIGJpdHRlLCB3ZW5uIFNpZSBkaWVzZSBFLU1haWwgZmFlbHNjaGxpY2hlcndl
aXNlIGVyaGFsdGVuIGhhYmVuLiBCaXR0ZSBsb2VzY2hlbiBTaWUgaW4gZGllc2VtIEZhbGwg
ZGllIE5hY2hyaWNodC4NCkplZGUgdW5lcmxhdWJ0ZSBGb3JtIGRlciBSZXByb2R1a3Rpb24s
IEJla2FubnRnYWJlLCBBZW5kZXJ1bmcsIFZlcnRlaWx1bmcgdW5kL29kZXIgUHVibGlrYXRp
b24gZGllc2VyIEUtTWFpbCBpc3Qgc3RyZW5nc3RlbnMgdW50ZXJzYWd0Lg0KLSBJbmZvcm1h
dGlvbmVuIHp1bSBEYXRlbnNjaHV0eiwgaW5zYmVzb25kZXJlIHp1IElocmVuIFJlY2h0ZW4s
IGVyaGFsdGVuIFNpZSB1bnRlciBodHRwczovL3d3dy5kaWVobC5jb20vZ3JvdXAvZGUvdHJh
bnNwYXJlbnotdW5kLWluZm9ybWF0aW9uc3BmbGljaHRlbi8NCg0KVGhlIGNvbnRlbnRzIG9m
IHRoZSBhYm92ZSBtZW50aW9uZWQgZS1tYWlsIGlzIG5vdCBsZWdhbGx5IGJpbmRpbmcuIFRo
aXMgZS1tYWlsIGNvbnRhaW5zIGNvbmZpZGVudGlhbCBhbmQvb3IgbGVnYWxseSBwcm90ZWN0
ZWQgaW5mb3JtYXRpb24uIFBsZWFzZSBpbmZvcm0gdXMgaWYgeW91IGhhdmUgcmVjZWl2ZWQg
dGhpcyBlLW1haWwgYnkNCm1pc3Rha2UgYW5kIGRlbGV0ZSBpdCBpbiBzdWNoIGEgY2FzZS4g
RWFjaCB1bmF1dGhvcml6ZWQgcmVwcm9kdWN0aW9uLCBkaXNjbG9zdXJlLCBhbHRlcmF0aW9u
LCBkaXN0cmlidXRpb24gYW5kL29yIHB1YmxpY2F0aW9uIG9mIHRoaXMgZS1tYWlsIGlzIHN0
cmljdGx5IHByb2hpYml0ZWQuIA0KLSBGb3IgZ2VuZXJhbCBpbmZvcm1hdGlvbiBvbiBkYXRh
IHByb3RlY3Rpb24gYW5kIHlvdXIgcmVzcGVjdGl2ZSByaWdodHMgcGxlYXNlIHZpc2l0IGh0
dHBzOi8vd3d3LmRpZWhsLmNvbS9ncm91cC9lbi90cmFuc3BhcmVuY3ktYW5kLWluZm9ybWF0
aW9uLW9ibGlnYXRpb25zLw0K
