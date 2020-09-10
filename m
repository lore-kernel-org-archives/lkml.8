Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C74C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 11:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E49ED20684
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 11:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="moojp1eN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbgIJLNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 07:13:30 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:16511 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729911AbgIJLIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 07:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1599736131; x=1631272131;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:mime-version:content-transfer-encoding:subject;
  bh=54BPerVazK5WnpwsLXibvnjNI0Jf8BfTNa7s15jKeQc=;
  b=moojp1eNwyHhY83gMtYV3xCpW9vLd6pli2HGiBhOPpSEnPz01xVS7+xS
   8d3/8+lBExso94o5MOaWFfO2D44HiZnYMIf0jkte803+MdLK2JIhZ+Dq5
   ExE35YKo3foqnSYS0IEhEVvyUgjzqVpB88hfEOzbpM6sIDAwRVV5Z3Uk1
   U=;
X-IronPort-AV: E=Sophos;i="5.76,412,1592870400"; 
   d="scan'208";a="66910466"
Subject: Re: [PATCH 3/3] ipmi: Add timeout waiting for channel information
Thread-Topic: [PATCH 3/3] ipmi: Add timeout waiting for channel information
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 10 Sep 2020 11:08:43 +0000
Received: from EX13D13EUB004.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id B731FA036C;
        Thu, 10 Sep 2020 11:08:41 +0000 (UTC)
Received: from EX13D13EUB001.ant.amazon.com (10.43.166.101) by
 EX13D13EUB004.ant.amazon.com (10.43.166.84) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 10 Sep 2020 11:08:40 +0000
Received: from EX13D13EUB001.ant.amazon.com ([10.43.166.101]) by
 EX13D13EUB001.ant.amazon.com ([10.43.166.101]) with mapi id 15.00.1497.006;
 Thu, 10 Sep 2020 11:08:40 +0000
From:   "Boehme, Markus" <markubo@amazon.de>
To:     "Boehme, Markus" <markubo@amazon.de>,
        "minyard@acm.org" <minyard@acm.org>
CC:     "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Shah, Amit" <aams@amazon.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Park, Seongjae" <sjpark@amazon.com>,
        "Nuernberger, Stefan" <snu@amazon.de>
Thread-Index: AQHWhTO2nKm8oufFy0+MtM8/mgZyfKld5SQAgAPV7gA=
Date:   Thu, 10 Sep 2020 11:08:40 +0000
Message-ID: <1599736120.29234.12.camel@amazon.de>
References: <1599495937-10654-1-git-send-email-markubo@amazon.com>
         <1599495937-10654-3-git-send-email-markubo@amazon.com>
         <20200908003412.GD15602@minyard.net>
In-Reply-To: <20200908003412.GD15602@minyard.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.78]
Content-Type: text/plain; charset="utf-8"
Content-ID: <35456D384B964743B6BFF12D20AAF3B3@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IENvcmV5LCB0aGFua3MgZm9yIHRha2luZyBhIGxvb2shDQoNCk9uIE1vbiwgMjAyMC0wOS0w
NyBhdCAxOTozNCAtMDUwMCwgQ29yZXkgTWlueWFyZCB3cm90ZToNCj4gT24gTW9uLCBTZXAgMDcs
IDIwMjAgYXQgMDY6MjU6MzdQTSArMDIwMCwgTWFya3VzIEJvZWhtZSB3cm90ZToNCj4gPiANCj4g
PiBXZSBoYXZlIG9ic2VydmVkIGhvc3RzIHdpdGggbWlzYmVoYXZpbmcgQk1DcyB0aGF0IHJlY2Vp
dmUgYSBHZXQgQ2hhbm5lbA0KPiA+IEluZm8gY29tbWFuZCBidXQgZG9uJ3QgcmVzcG9uZC4gVGhp
cyBsZWFkcyB0byBhbiBpbmRlZmluaXRlIHdhaXQgaW4gdGhlDQo+ID4gaXBtaV9tc2doYW5kbGVy
J3MgX19zY2FuX2NoYW5uZWxzIGZ1bmN0aW9uLCBzaG93aW5nIHVwIGFzIGh1bmcgdGFzaw0KPiA+
IG1lc3NhZ2VzIGZvciBtb2Rwcm9iZS4NCj4gPiANCj4gPiBBZGQgYSB0aW1lb3V0IHdhaXRpbmcg
Zm9yIHRoZSBjaGFubmVsIHNjYW4gdG8gY29tcGxldGUuIElmIHRoZSBzY2FuDQo+ID4gZmFpbHMg
dG8gY29tcGxldGUgd2l0aGluIHRoYXQgdGltZSwgdHJlYXQgdGhhdCBsaWtlIElQTUkgMS4wIGFu
ZCBvbmx5DQo+ID4gYXNzdW1lIHRoZSBwcmVzZW5jZSBvZiB0aGUgcHJpbWFyeSBJUE1CIGNoYW5u
ZWwgYXQgY2hhbm5lbCBudW1iZXIgMC4NCj4gWy4uLl0NCj4gV2hpbGUgdGhpbmtpbmcgYWJvdXQg
dGhpcywgSSByZWFsaXplZCBhbiBpc3N1ZSB3aXRoIHRoZXNlIHBhdGNoZXMuDQo+IFRoZXJlIHNo
b3VsZCBiZSB0aW1lcnMgaW4gdGhlIGxvd2VyIGxheWVycyB0aGF0IGRldGVjdCB0aGF0IHRoZSBC
TUMgZG9lcw0KPiBub3QgcmVzcG9uZCBhbmQgc2hvdWxkIHJldHVybiBhbiBlcnJvciByZXNwb25z
ZS7CoMKgVGhpcyBpcyBzdXBwb3NlZCB0byBiZQ0KPiBndWFyYW50ZWVkIGJ5IHRoZSBsb3dlciBs
YXllciwgeW91IHNob3VsZG4ndCBuZWVkIHRpbWVycyBoZXJlLsKgwqBJbiBmYWN0LA0KPiBpZiB5
b3UgYWJvcnQgd2l0aCBhIHRpbWVyIGhlcmUsIHlvdSBzaG91bGQgZ2V0IGEgbG93ZXIgbGF5ZXIg
cmVwb25kcw0KPiBsYXRlciwgY2F1c2luZyBvdGhlciBpc3N1ZXMuDQo+IA0KPiBTbywgdGhpcyBp
cyB3cm9uZy7CoMKgSWYgeW91IGFyZSBuZXZlciBnZXR0aW5nIGEgcmVzcG9uc2UsIHRoZXJlIGlz
IGEgYnVnDQo+IGluIHRoZSBsb3dlciBsYXllci7CoMKgSWYgeW91IGFyZSBub3QgZ2V0dGluZyB0
aGUgZXJyb3IgcmVzcG9uc2UgYXMNCj4gcXVpY2tseSBhcyB5b3Ugd291bGQgbGlrZSwgSSdtIG5v
dCBzdXJlIHdoYXQgdG8gZG8gYWJvdXQgdGhhdC4NCj4gDQoNCkkgc2VlLiBJIG1pZ2h0IG5vdCBi
ZSBhYmxlIHRvIGdldCBob2xkIG9mIG1vcmUgaG9zdHMgYmVoYXZpbmcgdGhpcyB3YXksDQpidXQg
aWYgSSBkbywgSSdsbCBkaWcgZGVlcGVyIGludG8gd2h5IHRoZSBsb3dlciBsYXllciB0aW1lb3V0
cyBkaWRuJ3QNCnNhdmUgdXMgaGVyZS4gVGhhbmtzIGZvciB0aGUgcG9pbnRlci4NCg0KDQoNCj4g
PiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gTnVlcm5iZXJnZXIgPHNudUBhbWF6b24uY29tPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IE1hcmt1cyBCb2VobWUgPG1hcmt1Ym9AYW1hem9uLmNvbT4NCj4gPiAt
LS0NCj4gPiDCoGRyaXZlcnMvY2hhci9pcG1pL2lwbWlfbXNnaGFuZGxlci5jIHwgNzIgKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLQ0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDM5
IGluc2VydGlvbnMoKyksIDMzIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2NoYXIvaXBtaS9pcG1pX21zZ2hhbmRsZXIuYyBiL2RyaXZlcnMvY2hhci9pcG1pL2lw
bWlfbXNnaGFuZGxlci5jDQo+ID4gaW5kZXggMmEyZThiMi4uOWRlOWJhNiAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2NoYXIvaXBtaS9pcG1pX21zZ2hhbmRsZXIuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvY2hhci9pcG1pL2lwbWlfbXNnaGFuZGxlci5jDQo+ID4gQEAgLTMzMTUsNDYgKzMzMTUsNTIg
QEAgY2hhbm5lbF9oYW5kbGVyKHN0cnVjdCBpcG1pX3NtaSAqaW50Ziwgc3RydWN0IGlwbWlfcmVj
dl9tc2cgKm1zZykNCj4gPiDCoCAqLw0KPiA+IMKgc3RhdGljIGludCBfX3NjYW5fY2hhbm5lbHMo
c3RydWN0IGlwbWlfc21pICppbnRmLCBzdHJ1Y3QgaXBtaV9kZXZpY2VfaWQgKmlkKQ0KPiA+IMKg
ew0KPiA+IC3CoMKgwqDCoMKgaW50IHJ2Ow0KPiA+ICvCoMKgwqDCoMKgbG9uZyBydjsNCj4gPiAr
wqDCoMKgwqDCoHVuc2lnbmVkIGludCBzZXQ7DQo+ID4gDQo+ID4gLcKgwqDCoMKgwqBpZiAoaXBt
aV92ZXJzaW9uX21ham9yKGlkKSA+IDENCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgfHwgKGlwbWlfdmVyc2lvbl9tYWpvcihpZCkgPT0gMQ0KPiA+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCYmIGlwbWlfdmVy
c2lvbl9taW5vcihpZCkgPj0gNSkpIHsNCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB1
bnNpZ25lZCBpbnQgc2V0Ow0KPiA+ICvCoMKgwqDCoMKgaWYgKGlwbWlfdmVyc2lvbl9tYWpvcihp
ZCkgPT0gMSAmJiBpcG1pX3ZlcnNpb25fbWlub3IoaWQpIDwgNSkgew0KPiBUaGlzIGlzIGluY29y
cmVjdCwgaXQgd2lsbCBub3QgY29ycmVjdGx5IGhhbmRsZSBJUE1JIDAueCBCTUNzLsKgwqBZZXMs
DQo+IHRoZXkgZXhpc3QuDQoNCkludGVyZXN0aW5nISBJIHdhc24ndCBhd2FyZSBvZiB0aG9zZS4g
U2VhcmNoaW5nIHRoZSB3ZWIgZG9lc24ndCB0dXJuIHVwDQptdWNoIGFuZCB0aGUgc3BlYyBkb2Vz
bid0IG1lbnRpb24gdGhlbSBlaXRoZXIuIEFyZSB0aGVzZSBwcmUtcmVsZWFzZQ0KaW1wbGVtZW50
YXRpb25zIG9mIHRoZSBJUE1JIDEuMCBzcGVjIG9yIHNvbWUga2luZCBvZiAiSVBNSSBsaWdodCI/
DQoNCk1hcmt1cwoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1
c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2No
bGFlZ2VyLCBKb25hdGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90
dGVuYnVyZyB1bnRlciBIUkIgMTQ5MTczIEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMjg5IDIz
NyA4NzkKCgo=

