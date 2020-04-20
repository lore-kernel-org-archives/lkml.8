Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E351FC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFFC5206B9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="xBih1p+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgDTMPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:15:24 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:26420 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725944AbgDTMPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:15:23 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03KBrxA1020286;
        Mon, 20 Apr 2020 14:15:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=oYkfgGSvLLhJSgChHwt5UPO9noM7Sp59Wqwp6zu8gv4=;
 b=xBih1p+Xf94GO7U3gDyqAbhnTDuSjcKRCUh0HMXy7Sg8mKUp6V1ARRE8EoQblboWkmrU
 J7F0RBe2mXqle7OFFJRGr2LFpOQV5FEKCO423ZIr5KtNes15rT3uncAVsIHDJFebXiPN
 y7Alz5vs0UCPfcFgytizNp7Myt1cppjGlaCL+keYsdWN+ygy0sFZQbEgHIRHkBnrTcB+
 56EhwNoa4uMjYiCnc+g5OHRwDtRnJSqlaSeWflUY4CAylYKmHHwEnYUcKIGN3/2ej0Vb
 8feSA803iXwwZ0K1c1bg3qFjcX+K/wRUvRTDBVrKvVTNe+rwpzNsn3Svt/0Kw9ZO40kM pw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30fpp8j9xk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Apr 2020 14:15:07 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6110E100034;
        Mon, 20 Apr 2020 14:15:06 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 477C020E15C;
        Mon, 20 Apr 2020 14:15:06 +0200 (CEST)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG5NODE2.st.com
 (10.75.127.14) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Apr
 2020 14:15:05 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Mon, 20 Apr 2020 14:15:05 +0200
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Fabrice GASNIER <fabrice.gasnier@st.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND v6 1/6] dt-bindings: mfd: Document STM32 low power timer
 bindings
Thread-Topic: [RESEND v6 1/6] dt-bindings: mfd: Document STM32 low power timer
 bindings
Thread-Index: AQHWFvIDiS0rSVDAKUm6xHaRsa0yGaiBnm0AgAAszAA=
Date:   Mon, 20 Apr 2020 12:15:05 +0000
Message-ID: <83a750a8-85ec-dbc8-a429-d61af5be36b4@st.com>
References: <20200420085930.26989-1-benjamin.gaignard@st.com>
 <20200420085930.26989-2-benjamin.gaignard@st.com>
 <f9d41617-797e-15d4-a058-a0a9e6669cdc@st.com>
In-Reply-To: <f9d41617-797e-15d4-a058-a0a9e6669cdc@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D343010F4CE77A4D9449AA83278B79CA@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-20_03:2020-04-20,2020-04-20 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDQvMjAvMjAgMTE6MzQgQU0sIEZhYnJpY2UgR2FzbmllciB3cm90ZToNCj4gT24gNC8y
MC8yMCAxMDo1OSBBTSwgQmVuamFtaW4gR2FpZ25hcmQgd3JvdGU6DQo+PiBBZGQgYSBzdWJub2Rl
IHRvIFNUTSBsb3cgcG93ZXIgdGltZXIgYmluZGluZ3MgdG8gc3VwcG9ydCB0aW1lciBkcml2ZXIN
Cj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBCZW5qYW1pbiBHYWlnbmFyZCA8YmVuamFtaW4uZ2FpZ25h
cmRAc3QuY29tPg0KPj4gUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+
DQo+PiAtLS0NCj4+ICAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL3N0LHN0bTMyLWxwdGlt
ZXIueWFtbCAgICAgfCAxOSArKysrKysrKysrKysrKysrKysrDQo+PiAgIDEgZmlsZSBjaGFuZ2Vk
LCAxOSBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9tZmQvc3Qsc3RtMzItbHB0aW1lci55YW1sIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9zdCxzdG0zMi1scHRpbWVyLnlhbWwNCj4+IGluZGV4
IGRkZjE5MGNiODAwYi4uNjRiYWIxYzNiZGFjIDEwMDY0NA0KPj4gLS0tIGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9zdCxzdG0zMi1scHRpbWVyLnlhbWwNCj4+ICsrKyBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvc3Qsc3RtMzItbHB0aW1lci55
YW1sDQo+PiBAQCAtMzMsNiArMzMsOSBAQCBwcm9wZXJ0aWVzOg0KPj4gICAgICAgaXRlbXM6DQo+
PiAgICAgICAgIC0gY29uc3Q6IG11eA0KPj4gICANCj4+ICsgIGludGVycnVwdHM6DQo+PiArICAg
IG1heEl0ZW1zOiAxDQo+PiArDQo+PiAgICAgIiNhZGRyZXNzLWNlbGxzIjoNCj4+ICAgICAgIGNv
bnN0OiAxDQo+PiAgIA0KPj4gQEAgLTkzLDYgKzk2LDE2IEBAIHBhdHRlcm5Qcm9wZXJ0aWVzOg0K
Pj4gICAgICAgcmVxdWlyZWQ6DQo+PiAgICAgICAgIC0gY29tcGF0aWJsZQ0KPj4gICANCj4+ICsg
IHRpbWVyOg0KPj4gKyAgICB0eXBlOiBvYmplY3QNCj4+ICsNCj4+ICsgICAgcHJvcGVydGllczoN
Cj4+ICsgICAgICBjb21wYXRpYmxlOg0KPj4gKyAgICAgICAgY29uc3Q6IHN0LHN0bTMyLWxwdGlt
ZXItdGltZXINCj4+ICsNCj4+ICsgICAgcmVxdWlyZWQ6DQo+PiArICAgICAgLSBjb21wYXRpYmxl
DQo+PiArDQo+PiAgIHJlcXVpcmVkOg0KPj4gICAgIC0gIiNhZGRyZXNzLWNlbGxzIg0KPj4gICAg
IC0gIiNzaXplLWNlbGxzIg0KPj4gQEAgLTEwNiwxMSArMTE5LDEzIEBAIGFkZGl0aW9uYWxQcm9w
ZXJ0aWVzOiBmYWxzZQ0KPj4gICBleGFtcGxlczoNCj4+ICAgICAtIHwNCj4+ICAgICAgICNpbmNs
dWRlIDxkdC1iaW5kaW5ncy9jbG9jay9zdG0zMm1wMS1jbGtzLmg+DQo+PiArICAgICNpbmNsdWRl
IDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQo+PiAgICAgICB0
aW1lckA0MDAwMjQwMCB7DQo+PiAgICAgICAgIGNvbXBhdGlibGUgPSAic3Qsc3RtMzItbHB0aW1l
ciI7DQo+PiAgICAgICAgIHJlZyA9IDwweDQwMDAyNDAwIDB4NDAwPjsNCj4+ICAgICAgICAgY2xv
Y2tzID0gPCZ0aW1lcl9jbGs+Ow0KPj4gICAgICAgICBjbG9jay1uYW1lcyA9ICJtdXgiOw0KPj4g
KyAgICAgIGludGVycnVwdHMtZXh0ZW5kZWQgPSA8JmV4dGkgNDcgSVJRX1RZUEVfTEVWRUxfSElH
SD47DQo+PiAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPj4gICAgICAgICAjc2l6ZS1j
ZWxscyA9IDwwPjsNCj4+ICAgDQo+PiBAQCAtMTMxLDYgKzE0NiwxMCBAQCBleGFtcGxlczoNCj4+
ICAgICAgICAgdGltZXIgew0KPj4gICAgICAgICAgIGNvbXBhdGlibGUgPSAic3Qsc3RtMzItbHB0
aW1lci10aW1lciI7DQo+PiAgICAgICAgIH07DQo+PiArDQo+PiArICAgICAgdGltZXIgew0KPj4g
KyAgICAgICAgY29tcGF0aWJsZSA9ICJzdCxzdG0zMi1scHRpbWVyLXRpbWVyIjsNCj4+ICsgICAg
ICB9Ow0KPiBIaSBCZW5qYW1pbiwNCj4NCj4gSXQgbG9va3MgbGlrZSB0aGUgY29tcGF0aWJsZSBp
cyBkdXBsaWNhdGVkIGluIHRoaXMgZXhhbXBsZS4NCj4gQWxzbywgZnJvbSAiUEFUQ0ggdjYiIEkg
ZG9uJ3Qgc2VlIHRoZSB3YWtldXAtc291cmNlIGZsYWcgaW4geW91ciByZXNlbmQuDQo+IENhbiB5
b3UgZG91YmxlLWNoZWNrID8NCkkgaGF2ZSByZWJhc2VkIHRoZSBzZXJpZSBvbiB0b3Agb2YgdjUu
Ny1yYzIsIEkgaGF2ZW4ndCBzZWUgdGhhdCB0aGUgDQpiaW5kaW5ncyBnb3QgbWVyZ2VkDQphbmQs
IHVubHVja3ksIHRoZXNlIGh1bmtzIGNhbiBzdGlsbCBiZSBhcHBsaWVkIGFuZCBiZWNvbWVzIGR1
cGxpY2F0ZWQuDQpJIHdpbGwgc2VuZCBhIHY3Lg0KDQpCZW5qYW1pbg0KPg0KPiBUaGFua3MsDQo+
IEJlc3QgUmVnYXJkcywNCj4gRmFicmljZQ0KPg0KPj4gICAgICAgfTsNCj4+ICAgDQo+PiAgIC4u
Lg0KPj4NCg==
