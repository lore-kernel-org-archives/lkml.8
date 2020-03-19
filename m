Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA21C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 10:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A90206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 10:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="bkBlNCmU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgCSK2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 06:28:47 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55772 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726802AbgCSK2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 06:28:47 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02JAR7eY032209;
        Thu, 19 Mar 2020 11:28:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=a8IUIDV/simADAYkwM+Njnv3lTBx4k59GizTkWNN6Ss=;
 b=bkBlNCmUITsQYwAIxDnXxiof6dfStcMQbxGYnOstUEFFI+V/ja+pfnndlQ3ZN8hLH0B3
 b+QUBAtxCj5IBu9RWXHrpB26PYPUXuwmSsNqlJ0vJPFIMC3aTdGOm8K0qDGsC+pmPEtG
 +bHO3dOG9podOt62m+JmVlBu4y/NdkbfPyzjTPxFmIj9dc5ff3ShkYAqCHLc90RrWQ98
 EKW3VeunwewQVQWDDkyE+/ZLYcZPzfQdsyVdZX7tZQRwedRHYkD6IElxfdceTVH/iu/k
 EfgP2ECx8WZiBoSrWIexJtYkgZw1zVGEexLxS/quRrB1UkYUrakRbQwdSYfSmosiKuIb YA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yu95us066-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Mar 2020 11:28:28 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 996FB100034;
        Thu, 19 Mar 2020 11:28:23 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 80D312A5810;
        Thu, 19 Mar 2020 11:28:23 +0100 (CET)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 19 Mar
 2020 11:28:23 +0100
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Thu, 19 Mar 2020 11:28:23 +0100
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Fabrice GASNIER <fabrice.gasnier@st.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] mfd: stm32: Add defines to be used for clkevent
 purpose
Thread-Topic: [PATCH v4 2/3] mfd: stm32: Add defines to be used for clkevent
 purpose
Thread-Index: AQHV5ZiQaom2ANb1fkS0EaDa85E9JagjxuwAgCwKSQCAAAURAA==
Date:   Thu, 19 Mar 2020 10:28:23 +0000
Message-ID: <b21ac320-080d-3995-1c63-ca5c187224c6@st.com>
References: <20200217134546.14562-1-benjamin.gaignard@st.com>
 <20200217134546.14562-3-benjamin.gaignard@st.com>
 <e9f7eaac-5b61-1662-2ae1-924d126e6a97@linaro.org>
 <20200319101014.GA5477@dell>
In-Reply-To: <20200319101014.GA5477@dell>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <85765BABAB3113468E684283C64674E7@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-19_02:2020-03-18,2020-03-19 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDMvMTkvMjAgMTE6MTAgQU0sIExlZSBKb25lcyB3cm90ZToNCj4gT24gVGh1LCAyMCBG
ZWIgMjAyMCwgRGFuaWVsIExlemNhbm8gd3JvdGU6DQo+PiBPbiAxNy8wMi8yMDIwIDE0OjQ1LCBC
ZW5qYW1pbiBHYWlnbmFyZCB3cm90ZToNCj4+PiBBZGQgZGVmaW5lcyB0byBiZSBhYmxlIHRvIGVu
YWJsZS9jbGVhciBpcnEgYW5kIGNvbmZpZ3VyZSBvbmUgc2hvdCBtb2RlLg0KPj4+DQo+Pj4gU2ln
bmVkLW9mZi1ieTogQmVuamFtaW4gR2FpZ25hcmQgPGJlbmphbWluLmdhaWduYXJkQHN0LmNvbT4N
Cj4+IEFyZSB5b3UgZmluZSBpZiBJIHBpY2sgdGhpcyBwYXRjaCB3aXRoIHRoZSBzZXJpZXM/DQo+
IE5vdGhpbmcgaGVhcmQgZnJvbSB5b3Ugc2luY2UgSSBBY2tlZCB0aGlzLg0KPg0KPiBBcmUgeW91
IHN0aWxsIHBsYW5uaW5nIG9uIHRha2luZyB0aGlzIHBhdGNoPw0KPg0KPiBJZiBzbywgY2FuIHlv
dSBhbHNvIHRha2UgcGF0Y2ggMSBwbGVhc2U/DQpJIHdpbGwgc2VuZCBhIHY1Lg0KRGFuaWVsIGNv
dWxkIHlvdSB3YWl0IHVudGlsIHRoYXQgdG8gbWVyZ2UgYWxsIHRoZSBwYXRjaGVzIChldmVuIGlm
IHRoaXMgDQpvbmUgd29uJ3QgY2hhbmdlKSA/DQoNCkJlbmphbWluDQo+DQo=
