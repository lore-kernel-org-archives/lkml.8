Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A14C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 18:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 169082065C
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 18:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="f1ExUjU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgEPSvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 14:51:48 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:29316 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726298AbgEPSvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 14:51:48 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04GIlKQa019731;
        Sat, 16 May 2020 20:51:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=98PF3Cew3LuM6AYgQh1W40dQPXP7atthK4LeCf/+19E=;
 b=f1ExUjU3NRU+4fQ/2OWAUPkl6B9gIPBoQr51OjScurx0Td7hqEuOgkcBiZjcyYlchX0V
 YtDzQrw29iM1ZdJhOgjAh3GYzz8Ad/AQvyAY8JMIpB3E21MQHZrjstaGLVrEryURAdSX
 wfRWPo5/eFdyzorJIxLJqQQJWM1Oy6lAmcQI5FcqxOhrqtOYoQGN7GxH481DUoeKl1+4
 P6d6sbsHPJJNNiCfzE4mijWxTvuZaKGXbZXYM5XZR5rM6NdxV2Q/LakdoTjX/JB4HJeE
 5yjW2mCZuRPFf0c2qw3edsPaIi8LP6R68O++OfwhLUH4bAz64yyjSktkiISm7IlmzqKO 3Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3125a8uv1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 16 May 2020 20:51:29 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 29BED10002A;
        Sat, 16 May 2020 20:51:27 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag5node1.st.com [10.75.127.13])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EC7A02BBAE6;
        Sat, 16 May 2020 20:51:26 +0200 (CEST)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG5NODE1.st.com
 (10.75.127.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 16 May
 2020 20:51:26 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Sat, 16 May 2020 20:51:26 +0200
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Fabrice GASNIER <fabrice.gasnier@st.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Pascal PAILLET-LME" <p.paillet@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [Linux-stm32] [PATCH v7 5/6] clocksource: Add Low Power STM32
 timers driver
Thread-Topic: [Linux-stm32] [PATCH v7 5/6] clocksource: Add Low Power STM32
 timers driver
Thread-Index: AQHWIq5ye17eyc+P4UqbHd8uXquVx6ipMz+AgAHL3IA=
Date:   Sat, 16 May 2020 18:51:26 +0000
Message-ID: <a9c2c278-9b45-972e-c015-8235f8fe9731@st.com>
References: <20200420121620.2099-1-benjamin.gaignard@st.com>
 <20200420121620.2099-6-benjamin.gaignard@st.com>
 <bbac5aa5-1c95-456e-3141-006d4fa86095@st.com>
 <103c5558-4dc9-63c9-4994-5c8f97646eee@linaro.org>
In-Reply-To: <103c5558-4dc9-63c9-4994-5c8f97646eee@linaro.org>
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
Content-ID: <BDD34949A5A120498BAFB2CEE1F28DE1@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-16_11:2020-05-15,2020-05-16 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDUvMTUvMjAgNToyNSBQTSwgRGFuaWVsIExlemNhbm8gd3JvdGU6DQo+IEhpIEJlbmph
bWluLA0KPg0KPiBPbiAwNS8wNS8yMDIwIDA5OjI2LCBCZW5qYW1pbiBHQUlHTkFSRCB3cm90ZToN
Cj4+DQo+PiBPbiA0LzIwLzIwIDI6MTYgUE0sIEJlbmphbWluIEdhaWduYXJkIHdyb3RlOg0KPj4+
IEZyb206IEJlbmphbWluIEdhaWduYXJkIDxiZW5qYW1pbi5nYWlnbmFyZEBsaW5hcm8ub3JnPg0K
Pj4+DQo+Pj4gSW1wbGVtZW50IGNsb2NrIGV2ZW50IGRyaXZlciB1c2luZyBsb3cgcG93ZXIgU1RN
MzIgdGltZXJzLg0KPj4+IExvdyBwb3dlciB0aW1lciBjb3VudGVycyBydW5uaW5nIGV2ZW4gd2hl
biBDUFVzIGFyZSBzdG9wcGVkLg0KPj4+IEl0IGNvdWxkIGJlIHVzZWQgYXMgY2xvY2sgZXZlbnQg
YnJvYWRjYXN0ZXIgdG8gd2FrZSB1cCBDUFVzIGJ1dCBub3QgbGlrZQ0KPj4+IGEgY2xvY2tzb3Vy
Y2UgYmVjYXVzZSBlYWNoIGl0IHJpc2UgYW4gaW50ZXJydXB0IHRoZSBjb3VudGVyIHJlc3RhcnQg
ZnJvbSAwLg0KPj4+DQo+Pj4gTG93IHBvd2VyIHRpbWVycyBoYXZlIGEgMTYgYml0cyBjb3VudGVy
IGFuZCBhIHByZXNjYWxlciB3aGljaCBhbGxvdyB0bw0KPj4+IGRpdmlkZSB0aGUgY2xvY2sgcGVy
IHBvd2VyIG9mIDIgdG8gdXAgMTI4IHRvIHRhcmdldCBhIDMyS0h6IHJhdGUuDQo+PiBHZW50bGUg
cGluZyB0byByZXZpZXdlcnMgb24gdGhpcyBkcml2ZXIgcGFydCBvZiB0aGUgc2VyaWVzLg0KPj4g
VGhlIGJpbmRpbmdzIGFuZCB0aGUgTUZEIGhhdmUgYmVlbiByZXZpZXdlZCBzbyBJIGhvcGUgSSBj
YW4gcHJvZ3Jlc3MNCj4+IG9uIHRoZSBkcml2ZXIgcGFydCB0b28uDQo+IFsgLi4uIF0NCj4NCj4g
c29ycnkgZm9yIHRoZSBkZWxheS4NCj4NCj4gSG93IGRvIHlvdSB3YW50IHRoZXNlIHBhdGNoZXMg
dG8gYmUgbWVyZ2VkPw0KPg0KPiBTaGFsbCBJIHBpY2sgcGF0Y2ggNi83ID8NCklmIExlZSBhZ3Jl
ZXMgSSB0aGluayB0aGUgYmVzdCBpcyB0byBnZXQgYWxsIHRoZSBwYXRjaGVzIGluIG1mZCB0cmVl
IGJlY2F1c2UNCm9mIHRoZSBkZXBlbmRlbmNpZXMgYmV0d2VlbiB0aGVtLg0KDQpCZW5qYW1pbg0K
Pg0KPg0K
