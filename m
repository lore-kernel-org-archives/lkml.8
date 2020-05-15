Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24571C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5BF020709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="tSlFRvwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgEOIcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 04:32:36 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:57810 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726730AbgEOIcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 04:32:35 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04F8RKCf008633;
        Fri, 15 May 2020 10:31:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=eJdDgRjKpklAGeIMtYx/P/MnYN9oSC9vUDGlJU7uW3M=;
 b=tSlFRvwIszSbH0n6EGhT1cOhcWrR9N2lmFcwsg/0R87FHKn48HaYPpw5Pd1UipFyXSQf
 o1WT15VZt4K04hoYJfOVeGJS0OyBw72LcR736Vyq5gavdNH19bZr8EQhYDHOa3vvq4w/
 XHHgKFeWfc2w6eTVqh35Qw27A+tji4plzvhLdiIs1gnBniHPcQ5R2u+rIZaxdSUMe3BO
 HGoaa12AGYiq2WH6HHLFbfFFZZbq0guYb3R4WaZQHPGf2yX1VuSFO07Eudozax+s4wyS
 WDQWn6+PwKlqIoLgYaB5lFQfjiJOEZwtU/+r+maXSYYGhIMdApxU38rRUoVDx3cEvGvQ bQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3100vyrw43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 May 2020 10:31:56 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DC686100034;
        Fri, 15 May 2020 10:31:54 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B664E2208D2;
        Fri, 15 May 2020 10:31:54 +0200 (CEST)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 15 May
 2020 10:31:54 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Fri, 15 May 2020 10:31:54 +0200
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     dillon min <dillon.minfei@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
CC:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Sam Ravnborg" <sam@ravnborg.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [Linux-stm32] [PATCH v3 3/5] ARM: dts: stm32: enable ltdc binding
 with ili9341 on stm32429-disco board
Thread-Topic: [Linux-stm32] [PATCH v3 3/5] ARM: dts: stm32: enable ltdc
 binding with ili9341 on stm32429-disco board
Thread-Index: AQHWKckeJCttwtJ4Q0KZXBBPInzZ9ainaAuAgAAEJgCAAUVIgA==
Date:   Fri, 15 May 2020 08:31:54 +0000
Message-ID: <818b93b4-4431-8338-cd90-ed125ecac615@st.com>
References: <1589267017-17294-1-git-send-email-dillon.minfei@gmail.com>
 <1589267017-17294-4-git-send-email-dillon.minfei@gmail.com>
 <CACRpkda5VjjBdbruXTi33QBNb=VU6vK2zDE8yyQXoWw7=NQFeg@mail.gmail.com>
 <a4ebd7cd-5756-0683-135f-0f96be8a4a7b@st.com>
 <CAL9mu0Jt_xwo5pJfcx6G3grBuOaxLXvakpEjiB4gV3=bkiq2fg@mail.gmail.com>
In-Reply-To: <CAL9mu0Jt_xwo5pJfcx6G3grBuOaxLXvakpEjiB4gV3=bkiq2fg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEC9925CAF78A046ADDC74F9DCF8557D@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-15_03:2020-05-14,2020-05-15 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDUvMTQvMjAgMzowNyBQTSwgZGlsbG9uIG1pbiB3cm90ZToNCj4gSGkgQWxleGFuZHJl
LA0KPg0KPiBPbiBUaHUsIE1heSAxNCwgMjAyMCBhdCA4OjUzIFBNIEFsZXhhbmRyZSBUb3JndWUN
Cj4gPGFsZXhhbmRyZS50b3JndWVAc3QuY29tPiB3cm90ZToNCj4+DQo+Pg0KPj4gT24gNS8xNC8y
MCAxMDoyNCBBTSwgTGludXMgV2FsbGVpaiB3cm90ZToNCj4+PiBPbiBUdWUsIE1heSAxMiwgMjAy
MCBhdCA5OjA0IEFNIDxkaWxsb24ubWluZmVpQGdtYWlsLmNvbT4gd3JvdGU6DQo+Pj4NCj4+Pj4g
RnJvbTogZGlsbG9uIG1pbiA8ZGlsbG9uLm1pbmZlaUBnbWFpbC5jb20+DQo+Pj4+DQo+Pj4+IEVu
YWJsZSB0aGUgbHRkYyAmIGlsaTkzNDEgb24gc3RtMzI0MjktZGlzY28gYm9hcmQuDQo+Pj4+DQo+
Pj4+IFNpZ25lZC1vZmYtYnk6IGRpbGxvbiBtaW4gPGRpbGxvbi5taW5mZWlAZ21haWwuY29tPg0K
Pj4+IFRoaXMgbW9zdGx5IGxvb2tzIGdvb2QgYnV0Li4uDQo+Pj4NCj4+Pj4gKyZzcGk1IHsNCj4+
Pj4gKyAgICAgICBzdGF0dXMgPSAib2theSI7DQo+Pj4+ICsgICAgICAgcGluY3RybC0wID0gPCZz
cGk1X3BpbnM+Ow0KPj4+PiArICAgICAgIHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+Pj4+
ICsgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+Pj4+ICsgICAgICAgI3NpemUtY2VsbHMg
PSA8MD47DQo+Pj4+ICsgICAgICAgY3MtZ3Bpb3MgPSA8JmdwaW9jIDIgR1BJT19BQ1RJVkVfTE9X
PjsNCj4+Pj4gKyAgICAgICBkbWFzID0gPCZkbWEyIDMgMiAweDQwMCAweDA+LA0KPj4+PiArICAg
ICAgICAgICAgICA8JmRtYTIgNCAyIDB4NDAwIDB4MD47DQo+Pj4+ICsgICAgICAgZG1hLW5hbWVz
ID0gInJ4IiwgInR4IjsNCj4+PiBUaGVzZSBETUEgYXNzaWdubWVudHMgc2VlbSB0byBiZSBTb0Mg
dGhpbmdzIGFuZCBzaG91bGQNCj4+PiByYXRoZXIgYmUgaW4gdGhlIERUUyhJKSBmaWxlIHdoZXJl
ICZzcGk1IGlzIGRlZmluZWQsIHJpZ2h0Pw0KPj4+IHN0bTMyZjQyOS5kdHNpIEkgc3VwcG9zZT8N
Cj4+IEkgYWdyZWUgd2l0aCBMaW51cywgRE1BIGhhdmUgdG8gYmUgZGVmaW5lZCBpbiBTb0MgZHRz
aS4gQW5kIGlmIGEgYm9hcmQNCj4+IGRvZXNuJ3Qgd2FudCB0byB1c2UgaXQsIHdlIHVzZSB0aGUg
ImRlbGV0ZS1wcm9wZXJ0eSIuDQo+IFllcywgd2lsbCBtb3ZlIHRvIFNvYyBkdHNpIGluIG5leHQg
c3VibWl0cy4NCj4NCj4gaSdtIHdvcmtpbmcgb24gd3JpdGUgYSB2NGwyLW0ybSBkcml2ZXIgZm9y
IGRtYTJkIG9mIHN0bTMyIHRvIHN1cHBvcnQNCj4gcGl4ZWwgY29udmVyc2lvbg0KPiBhbHBoYSBi
bGVuZGluZyBiZXR3ZWVuIGZvcmVncm91bmQgYW5kIGJhY2tncm91bmQgZ3JhcGhpY3MuDQo+DQo+
IGFzIHlvdSBrbm93LCBzb21lIHNvYydzIGVuZ2luZWVyIHRyeWluZyB0byBhZGQgdGhpcyBmdW5j
dGlvbiB0byBkcm0gc3lzdGVtLg0KPg0KPiBkbyB5b3Uga25vdyBzdCdzIHBsYW5uaW5nIGFib3V0
IHNvYydzIGhhcmR3YXJlIGFjY2VsZXJhdG9yIGRyaXZlciBvbiBzdG0zMm1wPw0KPiBzdWNoIGFz
IGNocm9tLWFydCwgd2lsbCBhZGQgdG8gZHJtIHN1YnN5c3RlbSB2aWEgaW9jdGwgdG8gYWNjZXNz
LCBvciB0byB2NGwyLA0KT24gc3RtMzJtcCB3ZSBkbyBub3QgcGxhbiB0byB1c2UgY2hyb20tYXJ0
IGluIGRybSBvciB2NGwyIGJlY2F1c2UgaXQgDQpkb2VzIGZpdA0Kd2l0aCB1c2VybGFuZCB3YXkg
b2Ygd29ya2luZy4gV2UgdXNlIHRoZSBHUFUgdG8gZG8gY29udmVyc2lvbiwgc2NhbGluZywgDQpi
bGVuZGluZw0KYW5kIGNvbXBvc2l0aW9uIGluIG9ubHkgb25lIGdvLg0KQXMgZXhwbGFpbiBoZXJl
IFsxXSBEUk0gc3Vic3l0ZW0gaXQgaXNuJ3QgYSBzb2x1dGlvbiBhbmQgdjRsMi1tMm0gaXNuJ3Qg
DQp1c2VkIGluIGFueQ0KbWFpbmxpbmUgY29tcG9zaXRvcnMgbGlrZSBXZXN0b24gb3IgYW5kcm9p
ZCBzdXJmYWNlZmxpbmdlci4NCg0KQmVuamFtaW4NCg0KWzFdIA0KaHR0cHM6Ly93d3cucGhvcm9u
aXguY29tL3NjYW4ucGhwP3BhZ2U9bmV3c19pdGVtJnB4PUxpbnV4LURSTS1Oby0yRC1BY2NlbC1B
UEkNCj4NCj4gdGhhbmtzLg0KPg0KPj4+IEl0IGlzIGxpa2VseSB0aGUgc2FtZSBubyBtYXR0ZXIg
d2hpY2ggZGV2aWNlIGlzIHVzaW5nIHNwaTUuDQo+Pj4NCj4+PiBZb3VycywNCj4+PiBMaW51cyBX
YWxsZWlqDQo+Pj4NCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18NCj4gTGludXgtc3RtMzIgbWFpbGluZyBsaXN0DQo+IExpbnV4LXN0bTMyQHN0LW1kLW1h
aWxtYW4uc3Rvcm1yZXBseS5jb20NCj4gaHR0cHM6Ly9zdC1tZC1tYWlsbWFuLnN0b3JtcmVwbHku
Y29tL21haWxtYW4vbGlzdGluZm8vbGludXgtc3RtMzINCg==
