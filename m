Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3152C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B9620787
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="0HnG5uLo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbgCZQ1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:27:05 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:37333 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726330AbgCZQ1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 12:27:05 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02QGNFlJ025185;
        Thu, 26 Mar 2020 17:26:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=1xKLuh0CMGGeFs0L/qRqkwlJw3iv6JDUdN6d2APZlR0=;
 b=0HnG5uLoeEsbI+fFw2vsqkwtWLxAo/KD2pzJPg1na3rYU9vLfKQQ1Ip0pXY9NCwdyku+
 Q31RwCI4B2X/GlZkoDdkduJbdqsHjy/42Qxbg3ogxPDA+U7vf786hhrgLJT8jLLdmNN7
 bDcJDsVxgDzdkqARlQX12b1gkTJRaasnd5dKlK5q29JE135Jl+ZecwDjsT//zNH6KC5y
 wuIxewifITzYpJUobLNUA7f1vl96y3YhGJsEIbyhCeaoTDTL1IkXvpeA6k4uwqZYVzz4
 soC/I8nIaFYynYxe+ziVLCFBbMf5Haf87V1UtPUuWUnsCj04KufyQ4jhbla9EYZr+cRS fA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yw9k0ctc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Mar 2020 17:26:55 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0F8A210002A;
        Thu, 26 Mar 2020 17:26:48 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EB6C52B9067;
        Thu, 26 Mar 2020 17:26:47 +0100 (CET)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 26 Mar
 2020 17:26:47 +0100
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Thu, 26 Mar 2020 17:26:47 +0100
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: usb: dwc2: fix bindings for
 amlogic,meson-gxbb-usb
Thread-Topic: [PATCH] dt-bindings: usb: dwc2: fix bindings for
 amlogic,meson-gxbb-usb
Thread-Index: AQHWA4kfrKmvM7C2NESne7Y0qff0Aqha/tkA
Date:   Thu, 26 Mar 2020 16:26:47 +0000
Message-ID: <e7820b83-670d-f619-c5fa-8c97379a6471@st.com>
References: <20200326161046.12111-1-narmstrong@baylibre.com>
In-Reply-To: <20200326161046.12111-1-narmstrong@baylibre.com>
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
Content-ID: <8C128BFFBE124340B62493BB8102458F@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-26_08:2020-03-26,2020-03-26 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDMvMjYvMjAgNToxMCBQTSwgTmVpbCBBcm1zdHJvbmcgd3JvdGU6DQo+IFRoZSBhbWxv
Z2ljLG1lc29uLWd4YmItdXNiIGNvbXBhdGlibGUgbmVlZHMgc25wcyxkd2MyIGFzd2VsbCBsaWtl
IG90aGVyDQo+IEFtbG9naWMgU29DLg0KPg0KPiBGaXhlczogZjNjYTc0NWQ4YTBlICgiZHQtYmlu
ZGluZ3M6IHVzYjogQ29udmVydCBEV0MyIGJpbmRpbmdzIHRvIGpzb24tc2NoZW1hIikNCj4gU2ln
bmVkLW9mZi1ieTogTmVpbCBBcm1zdHJvbmcgPG5hcm1zdHJvbmdAYmF5bGlicmUuY29tPg0KUmV2
aWV3ZWQtYnk6IEJlbmphbWluIEdhaWduYXJkIDxiZW5qYW1pbi5nYWlnbmFyZEBzdC5jb20+DQo+
IC0tLQ0KPiAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvZHdjMi55YW1s
IHwgNCArKystDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3VzYi9kd2MyLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL2R3
YzIueWFtbA0KPiBpbmRleCA3MWNmN2JhMzIyMzcuLmI3YjlkZGNiYzYzNyAxMDA2NDQNCj4gLS0t
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9kd2MyLnlhbWwNCj4gKysr
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9kd2MyLnlhbWwNCj4gQEAg
LTQ5LDcgKzQ5LDkgQEAgcHJvcGVydGllczoNCj4gICAgICAgICAtIGl0ZW1zOg0KPiAgICAgICAg
ICAgICAtIGNvbnN0OiBhbWxvZ2ljLG1lc29uOGItdXNiDQo+ICAgICAgICAgICAgIC0gY29uc3Q6
IHNucHMsZHdjMg0KPiAtICAgICAgLSBjb25zdDogYW1sb2dpYyxtZXNvbi1neGJiLXVzYg0KPiAr
ICAgICAgLSBpdGVtczoNCj4gKyAgICAgICAgICAtIGNvbnN0OiBhbWxvZ2ljLG1lc29uLWd4YmIt
dXNiDQo+ICsgICAgICAgICAgLSBjb25zdDogc25wcyxkd2MyDQo+ICAgICAgICAgLSBpdGVtczoN
Cj4gICAgICAgICAgICAgLSBjb25zdDogYW1sb2dpYyxtZXNvbi1nMTJhLXVzYg0KPiAgICAgICAg
ICAgICAtIGNvbnN0OiBzbnBzLGR3YzINCg==
