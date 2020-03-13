Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B06CC5ACBF
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624852074B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="C0AKIxz6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgCMNpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:45:31 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:7244 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726327AbgCMNpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 09:45:31 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02DDhImK025110;
        Fri, 13 Mar 2020 14:45:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=BzB5x9BXZs8Iatgp2DsUFoNfkqOLF0WtU1RaDu8c6yo=;
 b=C0AKIxz6AMmzFUGv9Ii97U25jySGU0BnwGzQ1zblOatfce7HuFpUZody8thgAtC7M9sE
 Fsh3hBpyeuZVrZkEpNNWaYv+UWLrG0g05Awhspf7EEsNfOP2dXpFh8i+xJUsNpGXrhS2
 sNmAE7AaSztqUOSXVevUOdVz+PARM22UcC2cWR3jCoykZzlKyA0uGpAsC//8RuT3WsUh
 9/EwwsD93SK3hTfF1ayQ8+/2yToB6s+/+gypbo+9PSigH5zalfWtE8Zl/6CDjr+DlUWy
 bhSt56ZmNlA38r1MyF4jZDLk+ef/cRTJd1AYDWn8NWviV1v8lzsXqhsnxE9RsvutAAMu +A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yqt8196eb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Mar 2020 14:45:10 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A212A100038;
        Fri, 13 Mar 2020 14:45:09 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8C28C2A906E;
        Fri, 13 Mar 2020 14:45:09 +0100 (CET)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 13 Mar
 2020 14:45:08 +0100
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Fri, 13 Mar 2020 14:45:09 +0100
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Fabrice GASNIER <fabrice.gasnier@st.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Pascal PAILLET-LME <p.paillet@st.com>
Subject: Re: [PATCH v4 3/3] clocksource: Add Low Power STM32 timers driver
Thread-Topic: [PATCH v4 3/3] clocksource: Add Low Power STM32 timers driver
Thread-Index: AQHV59mpsik/WRqXdUuknFgx3rC1tqgj1SiAgAAFrQCAIr0VgIAAAtYA
Date:   Fri, 13 Mar 2020 13:45:09 +0000
Message-ID: <1cd9e136-ebdd-f604-9ed8-1f21d4c70adb@st.com>
References: <20200217134546.14562-1-benjamin.gaignard@st.com>
 <20200217134546.14562-4-benjamin.gaignard@st.com>
 <687ab83c-6381-57aa-3bc1-3628e27644b5@linaro.org>
 <9cc4af9e-27d0-96c3-b3f1-20c88f89b70a@st.com>
 <ee131515-cd4c-00b2-5e1f-3abefb634bdd@linaro.org>
 <4f21f3db-50dd-f412-35dc-1fde7a139c52@linaro.org>
In-Reply-To: <4f21f3db-50dd-f412-35dc-1fde7a139c52@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <845C408BCC80DC4391DEC3D041AB6476@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-13_05:2020-03-12,2020-03-13 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDMvMTMvMjAgMjozNCBQTSwgRGFuaWVsIExlemNhbm8gd3JvdGU6DQo+IEhpIEJlbmph
bWluLA0KPg0KPiBPbiAyMC8wMi8yMDIwIDEyOjA1LCBEYW5pZWwgTGV6Y2FubyB3cm90ZToNCj4N
Cj4gWyAuLi4gXQ0KPg0KPj4+IEl0IGhhcyBiZSBleGNsdXNpdmUgYW5kIHRoYXQgZXhjbHVkZSB0
aGUgcHJvYmxlbSB5b3UgZGVzY3JpYmUgYWJvdmUuDQo+PiBPaywgdGhlIHJlZ21hcF93cml0ZSBp
cyBub3QgYSBmcmVlIG9wZXJhdGlvbiBhbmQgaW4gdGhpcyBjYXNlIHlvdSBjYW4NCj4+IGdldCBy
aWQgb2YgYWxsIHRoZSByZWdtYXAtaXNoIGluIHRoaXMgZHJpdmVyLg0KPiBBcmUgeW91IHBsYW5u
aW5nIHRvIHNlbmQgdGhlIG5vbi1yZWdtYXAgdmVyc2lvbj8NCk5vIGJlY2F1c2UgdGhlIHJlZ21h
cCBpcyBpbmhlcml0ZWQgZnJvbSB0aGUgbWZkIHBhcmVudC4NCkkgY291bGQgdXNlIGZhc3QtaW8g
dG8gaW1wcm92ZSB0aGF0Lg0KDQpCZW5qYW1pbg0KPg0KPg0KPg0K
