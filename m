Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80D3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D4FE206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="qv0C9Up+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgEOJe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 05:34:59 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:46344 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727803AbgEOJe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 05:34:59 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04F9XUpx013573;
        Fri, 15 May 2020 11:34:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=kIbCUmvZzrGEvYKM2nyNwIpvOBCS9R6qDI14SIm99HY=;
 b=qv0C9Up+c497UY6N2ziLJc3ApOSQNAM75XtYD6T2/6y8Jlakdsu/EmVRaprMU8ITFnE1
 3MuALblx7smSCoTAhEEq15RncLzSd9yve0IxzlPoTlhWV4O+1/Fs7Zy8CucXZ3HqKOvf
 EX7hUPNGGl9G8FYFnAFBXYNFZCZsKkE9HET5bjYbaOgCW1EBHeMKhWSxmUK1wid5a+xt
 1XzB36ug1w7ZY6kDnhYXF1X7+ppYyTX3ckP0f2pBQVOUjVzrfmlsn9/GkoHtBuE8fdp8
 C+KOPb7c2TaN74ITOg2935FP9dzjXPl+ImNM/ttnN78xZ9t7DfInkOIddd9OJtOvQLJl eA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3100vys8ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 May 2020 11:34:17 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7128F100034;
        Fri, 15 May 2020 11:34:16 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 55B332AF960;
        Fri, 15 May 2020 11:34:16 +0200 (CEST)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 15 May
 2020 11:34:15 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Fri, 15 May 2020 11:34:15 +0200
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     dillon min <dillon.minfei@gmail.com>
CC:     Alexandre TORGUE <alexandre.torgue@st.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
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
Thread-Index: AQHWKckeJCttwtJ4Q0KZXBBPInzZ9ainaAuAgAAEJgCAAUVIgIAADrKAgAACuQA=
Date:   Fri, 15 May 2020 09:34:15 +0000
Message-ID: <2afd2853-e3bc-0c69-a0e5-8d4aa631a634@st.com>
References: <1589267017-17294-1-git-send-email-dillon.minfei@gmail.com>
 <1589267017-17294-4-git-send-email-dillon.minfei@gmail.com>
 <CACRpkda5VjjBdbruXTi33QBNb=VU6vK2zDE8yyQXoWw7=NQFeg@mail.gmail.com>
 <a4ebd7cd-5756-0683-135f-0f96be8a4a7b@st.com>
 <CAL9mu0Jt_xwo5pJfcx6G3grBuOaxLXvakpEjiB4gV3=bkiq2fg@mail.gmail.com>
 <818b93b4-4431-8338-cd90-ed125ecac615@st.com>
 <CAL9mu0L6d2V5qypPfOSeMdhc=DdHkcsaF4GysNG-vfDe5npkhw@mail.gmail.com>
In-Reply-To: <CAL9mu0L6d2V5qypPfOSeMdhc=DdHkcsaF4GysNG-vfDe5npkhw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <26620BBF7B05D942A1AF671AA1D5FAE6@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-15_03:2020-05-14,2020-05-15 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDUvMTUvMjAgMTE6MjQgQU0sIGRpbGxvbiBtaW4gd3JvdGU6DQo+IEhpIEJlbmphbWlu
LA0KPg0KPiB0aGFua3MgZm9yIHJlcGx5Lg0KPg0KPiBPbiBGcmksIE1heSAxNSwgMjAyMCBhdCA0
OjMxIFBNIEJlbmphbWluIEdBSUdOQVJEDQo+IDxiZW5qYW1pbi5nYWlnbmFyZEBzdC5jb20+IHdy
b3RlOg0KPj4NCj4+DQo+PiBPbiA1LzE0LzIwIDM6MDcgUE0sIGRpbGxvbiBtaW4gd3JvdGU6DQo+
Pj4gSGkgQWxleGFuZHJlLA0KPj4+DQo+Pj4gT24gVGh1LCBNYXkgMTQsIDIwMjAgYXQgODo1MyBQ
TSBBbGV4YW5kcmUgVG9yZ3VlDQo+Pj4gPGFsZXhhbmRyZS50b3JndWVAc3QuY29tPiB3cm90ZToN
Cj4+Pj4NCj4+Pj4gT24gNS8xNC8yMCAxMDoyNCBBTSwgTGludXMgV2FsbGVpaiB3cm90ZToNCj4+
Pj4+IE9uIFR1ZSwgTWF5IDEyLCAyMDIwIGF0IDk6MDQgQU0gPGRpbGxvbi5taW5mZWlAZ21haWwu
Y29tPiB3cm90ZToNCj4+Pj4+DQo+Pj4+Pj4gRnJvbTogZGlsbG9uIG1pbiA8ZGlsbG9uLm1pbmZl
aUBnbWFpbC5jb20+DQo+Pj4+Pj4NCj4+Pj4+PiBFbmFibGUgdGhlIGx0ZGMgJiBpbGk5MzQxIG9u
IHN0bTMyNDI5LWRpc2NvIGJvYXJkLg0KPj4+Pj4+DQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogZGls
bG9uIG1pbiA8ZGlsbG9uLm1pbmZlaUBnbWFpbC5jb20+DQo+Pj4+PiBUaGlzIG1vc3RseSBsb29r
cyBnb29kIGJ1dC4uLg0KPj4+Pj4NCj4+Pj4+PiArJnNwaTUgew0KPj4+Pj4+ICsgICAgICAgc3Rh
dHVzID0gIm9rYXkiOw0KPj4+Pj4+ICsgICAgICAgcGluY3RybC0wID0gPCZzcGk1X3BpbnM+Ow0K
Pj4+Pj4+ICsgICAgICAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4+Pj4+PiArICAgICAg
ICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPj4+Pj4+ICsgICAgICAgI3NpemUtY2VsbHMgPSA8MD47
DQo+Pj4+Pj4gKyAgICAgICBjcy1ncGlvcyA9IDwmZ3Bpb2MgMiBHUElPX0FDVElWRV9MT1c+Ow0K
Pj4+Pj4+ICsgICAgICAgZG1hcyA9IDwmZG1hMiAzIDIgMHg0MDAgMHgwPiwNCj4+Pj4+PiArICAg
ICAgICAgICAgICA8JmRtYTIgNCAyIDB4NDAwIDB4MD47DQo+Pj4+Pj4gKyAgICAgICBkbWEtbmFt
ZXMgPSAicngiLCAidHgiOw0KPj4+Pj4gVGhlc2UgRE1BIGFzc2lnbm1lbnRzIHNlZW0gdG8gYmUg
U29DIHRoaW5ncyBhbmQgc2hvdWxkDQo+Pj4+PiByYXRoZXIgYmUgaW4gdGhlIERUUyhJKSBmaWxl
IHdoZXJlICZzcGk1IGlzIGRlZmluZWQsIHJpZ2h0Pw0KPj4+Pj4gc3RtMzJmNDI5LmR0c2kgSSBz
dXBwb3NlPw0KPj4+PiBJIGFncmVlIHdpdGggTGludXMsIERNQSBoYXZlIHRvIGJlIGRlZmluZWQg
aW4gU29DIGR0c2kuIEFuZCBpZiBhIGJvYXJkDQo+Pj4+IGRvZXNuJ3Qgd2FudCB0byB1c2UgaXQs
IHdlIHVzZSB0aGUgImRlbGV0ZS1wcm9wZXJ0eSIuDQo+Pj4gWWVzLCB3aWxsIG1vdmUgdG8gU29j
IGR0c2kgaW4gbmV4dCBzdWJtaXRzLg0KPj4+DQo+Pj4gaSdtIHdvcmtpbmcgb24gd3JpdGUgYSB2
NGwyLW0ybSBkcml2ZXIgZm9yIGRtYTJkIG9mIHN0bTMyIHRvIHN1cHBvcnQNCj4+PiBwaXhlbCBj
b252ZXJzaW9uDQo+Pj4gYWxwaGEgYmxlbmRpbmcgYmV0d2VlbiBmb3JlZ3JvdW5kIGFuZCBiYWNr
Z3JvdW5kIGdyYXBoaWNzLg0KPj4+DQo+Pj4gYXMgeW91IGtub3csIHNvbWUgc29jJ3MgZW5naW5l
ZXIgdHJ5aW5nIHRvIGFkZCB0aGlzIGZ1bmN0aW9uIHRvIGRybSBzeXN0ZW0uDQo+Pj4NCj4+PiBk
byB5b3Uga25vdyBzdCdzIHBsYW5uaW5nIGFib3V0IHNvYydzIGhhcmR3YXJlIGFjY2VsZXJhdG9y
IGRyaXZlciBvbiBzdG0zMm1wPw0KPj4+IHN1Y2ggYXMgY2hyb20tYXJ0LCB3aWxsIGFkZCB0byBk
cm0gc3Vic3lzdGVtIHZpYSBpb2N0bCB0byBhY2Nlc3MsIG9yIHRvIHY0bDIsDQo+PiBPbiBzdG0z
Mm1wIHdlIGRvIG5vdCBwbGFuIHRvIHVzZSBjaHJvbS1hcnQgaW4gZHJtIG9yIHY0bDIgYmVjYXVz
ZSBpdA0KPj4gZG9lcyBmaXQNCj4+IHdpdGggdXNlcmxhbmQgd2F5IG9mIHdvcmtpbmcuIFdlIHVz
ZSB0aGUgR1BVIHRvIGRvIGNvbnZlcnNpb24sIHNjYWxpbmcsDQo+PiBibGVuZGluZw0KPj4gYW5k
IGNvbXBvc2l0aW9uIGluIG9ubHkgb25lIGdvLg0KPj4gQXMgZXhwbGFpbiBoZXJlIFsxXSBEUk0g
c3Vic3l0ZW0gaXQgaXNuJ3QgYSBzb2x1dGlvbiBhbmQgdjRsMi1tMm0gaXNuJ3QNCj4+IHVzZWQg
aW4gYW55DQo+PiBtYWlubGluZSBjb21wb3NpdG9ycyBsaWtlIFdlc3RvbiBvciBhbmRyb2lkIHN1
cmZhY2VmbGluZ2VyLg0KPj4NCj4+IEJlbmphbWluDQo+Pg0KPiBBZnRlciBjaGVjayBzdG0zMm1w
J3MgZGF0YXNoZWV0cywgdGhleSBkb24ndCBoYXZlIGNocm9tLWFydCBpcCBpbnNpZGUuIHNvcnJ5
IGZvcg0KPiBkaWRuJ3QgY2hlY2sgaXQgeWV0Lg0KPg0KPiBmb3Igc3RtMzJoNyBzZXJpZXMgd2l0
aCBjaHJvbS1hcnQsIGpwZWcgaGFyZHdhcmUgYWNjZWxlcmF0b3IgaW5zaWRlLg0KPiBkb2VzIHN0
IGhhcyBwbGFuIHRvDQo+IHNldHVwIGEgZHJpdmVyIHRvIHN1cHBvcnQgaXQgPyBpIHByZWZlciB2
NGwyLW0ybSBzaG91bGQgYmUgZWFzaWVyIHRvDQo+IGltcGxlbWVudCBpdC4NCj4gY28gd29yayB3
aXRoIGRjbWksIGZiZGV2Lg0KU1QgZG9lc24ndCBwbGFuIHRvIGNyZWF0ZSBhIGRyaXZlciBmb3Ig
Y2hyb20tYXJ0IGJlY2F1c2Ugbm90aGluZyBpbiANCm1haW5saW5lDQp1c2VybGFuZCBjb3VsZCB1
c2UgaXQuDQoNCkJlbmphbWluDQo+DQo+IHRoYW5rcy4NCj4NCj4gYmVzdCByZWdhcmRzLg0KPg0K
PiBEaWxsb24NCj4+IFsxXQ0KPj4gaHR0cHM6Ly93d3cucGhvcm9uaXguY29tL3NjYW4ucGhwP3Bh
Z2U9bmV3c19pdGVtJnB4PUxpbnV4LURSTS1Oby0yRC1BY2NlbC1BUEkNCj4+PiB0aGFua3MuDQo+
Pj4NCj4+Pj4+IEl0IGlzIGxpa2VseSB0aGUgc2FtZSBubyBtYXR0ZXIgd2hpY2ggZGV2aWNlIGlz
IHVzaW5nIHNwaTUuDQo+Pj4+Pg0KPj4+Pj4gWW91cnMsDQo+Pj4+PiBMaW51cyBXYWxsZWlqDQo+
Pj4+Pg0KPj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
DQo+Pj4gTGludXgtc3RtMzIgbWFpbGluZyBsaXN0DQo+Pj4gTGludXgtc3RtMzJAc3QtbWQtbWFp
bG1hbi5zdG9ybXJlcGx5LmNvbQ0KPj4+IGh0dHBzOi8vc3QtbWQtbWFpbG1hbi5zdG9ybXJlcGx5
LmNvbS9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXN0bTMyDQo=
