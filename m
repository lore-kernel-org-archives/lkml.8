Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C40DC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 19:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5AC214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 19:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="FnMs/gJ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgA1T6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 14:58:18 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:40805 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726066AbgA1T6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 14:58:18 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00SJr8rU027386;
        Tue, 28 Jan 2020 20:57:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=/3y9knNrUPLx512U90lYgx5LJxtb0nFcRVZF9G4dV7c=;
 b=FnMs/gJ8hgBaG2vAVoOms5/1hq/D+pCgZg+mjhbd2W5LHTtKji+hbnYRG9phqnDVQFuy
 H9Ji10Sw953VP5TMQId4ScB/WYb9kv20FnvA9aS4AGNB+SZ/KgJDUd87ckHsIysuOdtO
 xWUd9v66gAGBEjM2G0WKXb6KeMK9UldCX2Kf/ks7mZo3L0jUpbZzZT7gHMext3C7G7Lk
 7ckx4nyNrqtj+WocwS9vfzE3EXAxwtvQGPcqThXTPc6RhFVrotiAZfK3EXt8t0zLaYx4
 67fLhxvg/O/I4ICwssZOUI7xrUmhN6t1TuP0mMyK4AxIuP2cJZuwQBDIQAPsIppofswT rA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xrcaxyjt8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jan 2020 20:57:56 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C668D10002A;
        Tue, 28 Jan 2020 20:57:55 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A90192B187B;
        Tue, 28 Jan 2020 20:57:55 +0100 (CET)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 28 Jan
 2020 20:57:55 +0100
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Tue, 28 Jan 2020 20:57:55 +0100
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Maxime Ripard <maxime@cerno.tech>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux+etnaviv@armlinux.org.uk" <linux+etnaviv@armlinux.org.uk>,
        "christian.gmeiner@gmail.com" <christian.gmeiner@gmail.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philippe CORNU <philippe.cornu@st.com>,
        Pierre Yves MORDRET <pierre-yves.mordret@st.com>
Subject: Re: [PATCH v2] dt-bindings: display: Convert etnaviv to json-schema
Thread-Topic: [PATCH v2] dt-bindings: display: Convert etnaviv to json-schema
Thread-Index: AQHV1bPEp8nzC2t1RkuTxNot9B0yK6f/6nAAgAAHBgCAAHaWAIAABj0A
Date:   Tue, 28 Jan 2020 19:57:54 +0000
Message-ID: <676d7e79-c129-c13c-b804-25d41afdbef9@st.com>
References: <20200128082013.15951-1-benjamin.gaignard@st.com>
 <20200128120600.oagnindklixjyieo@gilmour.lan>
 <a7fa1b43-a188-9d06-73ec-16bcd4012207@st.com>
 <CAL_JsqJ80kSU7bHJt0_SeX5FVfxxjN5-ZKxt+tOfGy2cV62cbQ@mail.gmail.com>
In-Reply-To: <CAL_JsqJ80kSU7bHJt0_SeX5FVfxxjN5-ZKxt+tOfGy2cV62cbQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B7144722ED05A40BD7357561F980001@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_07:2020-01-28,2020-01-28 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxLzI4LzIwIDg6MzUgUE0sIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBPbiBUdWUsIEphbiAy
OCwgMjAyMCBhdCA2OjMxIEFNIEJlbmphbWluIEdBSUdOQVJEDQo+IDxiZW5qYW1pbi5nYWlnbmFy
ZEBzdC5jb20+IHdyb3RlOg0KPj4NCj4+IE9uIDEvMjgvMjAgMTowNiBQTSwgTWF4aW1lIFJpcGFy
ZCB3cm90ZToNCj4+PiBIaSBCZW5qYW1pbiwNCj4+Pg0KPj4+IE9uIFR1ZSwgSmFuIDI4LCAyMDIw
IGF0IDA5OjIwOjEzQU0gKzAxMDAsIEJlbmphbWluIEdhaWduYXJkIHdyb3RlOg0KPj4+PiBDb252
ZXJ0IGV0bmF2aXYgYmluZGluZ3MgdG8geWFtbCBmb3JtYXQuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1v
ZmYtYnk6IEJlbmphbWluIEdhaWduYXJkIDxiZW5qYW1pbi5nYWlnbmFyZEBzdC5jb20+DQo+Pj4+
IC0tLQ0KPj4+PiAgICAuLi4vYmluZGluZ3MvZGlzcGxheS9ldG5hdml2L2V0bmF2aXYtZHJtLnR4
dCAgICAgICB8IDM2IC0tLS0tLS0tLS0tDQo+Pj4+ICAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2dwdS92aXZhbnRlLGdjLnlhbWwgICAgICAgIHwgNzIgKysrKysrKysrKysrKysrKysrKysrKw0K
Pj4+PiAgICAyIGZpbGVzIGNoYW5nZWQsIDcyIGluc2VydGlvbnMoKyksIDM2IGRlbGV0aW9ucygt
KQ0KPj4+PiAgICBkZWxldGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2Rpc3BsYXkvZXRuYXZpdi9ldG5hdml2LWRybS50eHQNCj4+Pj4gICAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncHUvdml2YW50ZSxn
Yy55YW1sDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvZGlzcGxheS9ldG5hdml2L2V0bmF2aXYtZHJtLnR4dCBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L2V0bmF2aXYvZXRuYXZpdi1kcm0udHh0DQo+Pj4+
IGRlbGV0ZWQgZmlsZSBtb2RlIDEwMDY0NA0KPj4+PiBpbmRleCA4ZGVmMTFiMTZhMjQuLjAwMDAw
MDAwMDAwMA0KPj4+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlz
cGxheS9ldG5hdml2L2V0bmF2aXYtZHJtLnR4dA0KPj4+PiArKysgL2Rldi9udWxsDQo+Pj4+IEBA
IC0xLDM2ICswLDAgQEANCj4+Pj4gLVZpdmFudGUgR1BVIGNvcmUgZGV2aWNlcw0KPj4+PiAtPT09
PT09PT09PT09PT09PT09PT09PT09DQo+Pj4+IC0NCj4+Pj4gLVJlcXVpcmVkIHByb3BlcnRpZXM6
DQo+Pj4+IC0tIGNvbXBhdGlibGU6IFNob3VsZCBiZSAidml2YW50ZSxnYyINCj4+Pj4gLSAgQSBt
b3JlIHNwZWNpZmljIGNvbXBhdGlibGUgaXMgbm90IG5lZWRlZCwgYXMgdGhlIGNvcmVzIGNvbnRh
aW4gY2hpcA0KPj4+PiAtICBpZGVudGlmaWNhdGlvbiByZWdpc3RlcnMgYXQgZml4ZWQgbG9jYXRp
b25zLCB3aGljaCBwcm92aWRlIGFsbCB0aGUNCj4+Pj4gLSAgbmVjZXNzYXJ5IGluZm9ybWF0aW9u
IHRvIHRoZSBkcml2ZXIuDQo+Pj4+IC0tIHJlZzogc2hvdWxkIGJlIHJlZ2lzdGVyIGJhc2UgYW5k
IGxlbmd0aCBhcyBkb2N1bWVudGVkIGluIHRoZQ0KPj4+PiAtICBkYXRhc2hlZXQNCj4+Pj4gLS0g
aW50ZXJydXB0czogU2hvdWxkIGNvbnRhaW4gdGhlIGNvcmVzIGludGVycnVwdCBsaW5lDQo+Pj4+
IC0tIGNsb2Nrczogc2hvdWxkIGNvbnRhaW4gb25lIGNsb2NrIGZvciBlbnRyeSBpbiBjbG9jay1u
YW1lcw0KPj4+PiAtICBzZWUgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2Nr
L2Nsb2NrLWJpbmRpbmdzLnR4dA0KPj4+PiAtLSBjbG9jay1uYW1lczoNCj4+Pj4gLSAgIC0gImJ1
cyI6ICAgIEFYSS9tYXN0ZXIgaW50ZXJmYWNlIGNsb2NrDQo+Pj4+IC0gICAtICJyZWciOiAgICBB
SEIvc2xhdmUgaW50ZXJmYWNlIGNsb2NrDQo+Pj4+IC0gICAgICAgICAgICAgICAob25seSByZXF1
aXJlZCBpZiBHUFUgY2FuIGdhdGUgc2xhdmUgaW50ZXJmYWNlIGluZGVwZW5kZW50bHkpDQo+Pj4+
IC0gICAtICJjb3JlIjogICBHUFUgY29yZSBjbG9jaw0KPj4+PiAtICAgLSAic2hhZGVyIjogU2hh
ZGVyIGNsb2NrIChvbmx5IHJlcXVpcmVkIGlmIEdQVSBoYXMgZmVhdHVyZSBQSVBFXzNEKQ0KPj4+
PiAtDQo+Pj4+IC1PcHRpb25hbCBwcm9wZXJ0aWVzOg0KPj4+PiAtLSBwb3dlci1kb21haW5zOiBh
IHBvd2VyIGRvbWFpbiBjb25zdW1lciBzcGVjaWZpZXIgYWNjb3JkaW5nIHRvDQo+Pj4+IC0gIERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dlci9wb3dlcl9kb21haW4udHh0DQo+
Pj4+IC0NCj4+Pj4gLWV4YW1wbGU6DQo+Pj4+IC0NCj4+Pj4gLWdwdV8zZDogZ3B1QDEzMDAwMCB7
DQo+Pj4+IC0gICAgY29tcGF0aWJsZSA9ICJ2aXZhbnRlLGdjIjsNCj4+Pj4gLSAgICByZWcgPSA8
MHgwMDEzMDAwMCAweDQwMDA+Ow0KPj4+PiAtICAgIGludGVycnVwdHMgPSA8MCA5IElSUV9UWVBF
X0xFVkVMX0hJR0g+Ow0KPj4+PiAtICAgIGNsb2NrcyA9IDwmY2xrcyBJTVg2UURMX0NMS19HUFUz
RF9BWEk+LA0KPj4+PiAtICAgICAgICAgICAgIDwmY2xrcyBJTVg2UURMX0NMS19HUFUzRF9DT1JF
PiwNCj4+Pj4gLSAgICAgICAgICAgICA8JmNsa3MgSU1YNlFETF9DTEtfR1BVM0RfU0hBREVSPjsN
Cj4+Pj4gLSAgICBjbG9jay1uYW1lcyA9ICJidXMiLCAiY29yZSIsICJzaGFkZXIiOw0KPj4+PiAt
ICAgIHBvd2VyLWRvbWFpbnMgPSA8JmdwYyAxPjsNCj4+Pj4gLX07DQo+Pj4+IGRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZ3B1L3ZpdmFudGUsZ2MueWFtbCBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ncHUvdml2YW50ZSxnYy55YW1sDQo+
Pj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+Pj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uYzRmNTQ5
YzBkNzUwDQo+Pj4+IC0tLSAvZGV2L251bGwNCj4+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2dwdS92aXZhbnRlLGdjLnlhbWwNCj4+Pj4gQEAgLTAsMCArMSw3MiBA
QA0KPj4+PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPj4+PiArJVlBTUwg
MS4yDQo+Pj4+ICstLS0NCj4+Pj4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMv
Z3B1L3ZpdmFudGUsZ2MueWFtbCMNCj4+Pj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9y
Zy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPj4+PiArDQo+Pj4+ICt0aXRsZTogVml2YW50ZSBH
UFUgQmluZGluZ3MNCj4+Pj4gKw0KPj4+PiArZGVzY3JpcHRpb246IFZpdmFudGUgR1BVIGNvcmUg
ZGV2aWNlcw0KPj4+PiArDQo+Pj4+ICttYWludGFpbmVyczoNCj4+Pj4gKyAgLSAgTHVjYXMgU3Rh
Y2ggPGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU+DQo+Pj4+ICsNCj4+Pj4gK3Byb3BlcnRpZXM6DQo+
Pj4+ICsgIGNvbXBhdGlibGU6DQo+Pj4+ICsgICAgY29uc3Q6IHZpdmFudGUsZ2MNCj4+Pj4gKw0K
Pj4+PiArICByZWc6DQo+Pj4+ICsgICAgbWF4SXRlbXM6IDENCj4+Pj4gKw0KPj4+PiArICBpbnRl
cnJ1cHRzOg0KPj4+PiArICAgIG1heEl0ZW1zOiAxDQo+Pj4+ICsNCj4+Pj4gKyAgY2xvY2tzOg0K
Pj4+PiArICAgIGl0ZW1zOg0KPj4+PiArICAgICAgLSBkZXNjcmlwdGlvbjogQVhJL21hc3RlciBp
bnRlcmZhY2UgY2xvY2sNCj4+Pj4gKyAgICAgIC0gZGVzY3JpcHRpb246IEdQVSBjb3JlIGNsb2Nr
DQo+Pj4+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBTaGFkZXIgY2xvY2sgKG9ubHkgcmVxdWlyZWQg
aWYgR1BVIGhhcyBmZWF0dXJlIFBJUEVfM0QpDQo+Pj4+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBB
SEIvc2xhdmUgaW50ZXJmYWNlIGNsb2NrIChvbmx5IHJlcXVpcmVkIGlmIEdQVSBjYW4gZ2F0ZSBz
bGF2ZSBpbnRlcmZhY2UgaW5kZXBlbmRlbnRseSkNCj4+PiBDYW4geW91IGhhdmUgYW4gQUhCIHNs
YXZlIGludGVyZmFjZSBjbG9jayB3aXRob3V0IGEgc2hhZGVyIGNsb2NrPw0KPj4gTm8gYmVjYXVz
ZSB0aGUgaXRlbXMgaW4gdGhlIGxpc3QgYXJlIG9yZGVyZWQgc28geW91IG5lZWQgdG8gaGF2ZSwg
aW4NCj4+IG9yZGVyOiAiYnVzIiwgImNvcmUiLCAic2hhZGVyIiwgInJlZyINCj4+DQo+PiBJZiBp
dCBpcyBuZWVkZWQgdG8gYWxsb3cgYW55IG51bWJlciBvZiBjbG9jayBpbiBhbnkgb3JkZXIgSSBj
b3VsZCB3cml0ZQ0KPj4gaXQgbGlrZSB0aGlzOg0KPiBZZXMsIGJ1dCBJIHByZWZlciB3ZSBkb24n
dCBhbGxvdyBhbnkgb3JkZXIgaWYgd2UgZG9uJ3QgaGF2ZSB0by4gRGlkDQo+IHlvdSBydW4gdGhp
cyBzY2hlbWEgYWdhaW5zdCBkdGJzX2NoZWNrIG9yIGp1c3QgYXVkaXQgdGhlIGR0cyBmaWxlcw0K
PiB3aXRoIHZpdmFudGU/DQoNCkJvdGgsIEkgZm91bmQgdGhlc2UgbWl4IG9mIHJlZy1uYW1lczoN
Cg0KImNvcmUiDQoNCiJidXMiLCJjb3JlIg0KDQoiYnVzIiwiY29yZSIsInNoYWRlciINCg0KVGhh
dCBub3QgcmVhbGx5IG1hdGNoIHdpdGggb3JpZ2luYWwgYmluZGluZ3MgZGVzY3JpcHRpb24uLi4N
Cg0KDQo+DQo+IFJvYg==
