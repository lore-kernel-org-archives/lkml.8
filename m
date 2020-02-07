Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D795C352A4
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FCA20838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="vJHPrnO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgBGJfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 04:35:39 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:29394 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726451AbgBGJfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 04:35:39 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0179T9jD000507;
        Fri, 7 Feb 2020 10:35:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=vKgnaX5bjo09jVxPTqlOy1rgK6nH+2B8BLsuyDClUl8=;
 b=vJHPrnO0gHy5W/LwCsmxpAI6LNzrUHtxsQrn5Sf10NoLdXkV1IHddDDQ0eLTt5dwRgKx
 NNG75Uieu+LTkdqtwSg3SUrrAYAuQh8u/eCGiWSYxTgRchArBEfYp97bmmtu3X5uZ8kG
 jUd7K0lQ4MBaHWNmB82TYVrUcLRkvyNo4VL+TPTE0EC3xNmSSFM+/OguveWM+Q8SkBsm
 02skcAZj3O90+FhJ2uJjGL07fxzywZXa1S0X3hFPRpYB5V2E/SFN2XMooGoie/bHFx9K
 dyGqnqhnbQ7Wce9BDJWGU6Cwa/tRdLBlIwbm0O+cwPI25S0BIuuFZD2QoktHM7HU+BSq WA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xyhku9r14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Feb 2020 10:35:28 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9E98310002A;
        Fri,  7 Feb 2020 10:35:27 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8CBAC2A8FA3;
        Fri,  7 Feb 2020 10:35:27 +0100 (CET)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Feb
 2020 10:35:27 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1473.003; Fri, 7 Feb 2020 10:35:26 +0100
From:   Philippe CORNU <philippe.cornu@st.com>
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: panel: Convert raydium,rm68200 to
 json-schema
Thread-Topic: [PATCH v4 2/3] dt-bindings: panel: Convert raydium,rm68200 to
 json-schema
Thread-Index: AQHV3PIRbsEXfpNCKEe93LIMHMYazKgPaTMA
Date:   Fri, 7 Feb 2020 09:35:26 +0000
Message-ID: <2939457c-0d76-caa9-7f12-8befbc5b96f2@st.com>
References: <20200206133344.724-1-benjamin.gaignard@st.com>
 <20200206133344.724-3-benjamin.gaignard@st.com>
In-Reply-To: <20200206133344.724-3-benjamin.gaignard@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <73E242B49A240944830717037FB39E19@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-07_01:2020-02-07,2020-02-06 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmVuamFtaW4sDQoNCk9uIDIvNi8yMCAyOjMzIFBNLCBCZW5qYW1pbiBHYWlnbmFyZCB3cm90
ZToNCj4gQ29udmVydCByYXlkaXVtLHJtNjgyMDAgdG8ganNvbi1zY2hlbWEuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBCZW5qYW1pbiBHYWlnbmFyZCA8YmVuamFtaW4uZ2FpZ25hcmRAc3QuY29tPg0K
PiAtLS0NCj4gICAuLi4vYmluZGluZ3MvZGlzcGxheS9wYW5lbC9yYXlkaXVtLHJtNjgyMDAudHh0
ICAgICB8IDI1IC0tLS0tLS0tLS0NCj4gICAuLi4vYmluZGluZ3MvZGlzcGxheS9wYW5lbC9yYXlk
aXVtLHJtNjgyMDAueWFtbCAgICB8IDU2ICsrKysrKysrKysrKysrKysrKysrKysNCj4gICAyIGZp
bGVzIGNoYW5nZWQsIDU2IGluc2VydGlvbnMoKyksIDI1IGRlbGV0aW9ucygtKQ0KPiAgIGRlbGV0
ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9w
YW5lbC9yYXlkaXVtLHJtNjgyMDAudHh0DQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L3BhbmVsL3JheWRpdW0scm02ODIwMC55
YW1sDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2Rpc3BsYXkvcGFuZWwvcmF5ZGl1bSxybTY4MjAwLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9kaXNwbGF5L3BhbmVsL3JheWRpdW0scm02ODIwMC50eHQNCj4gZGVsZXRl
ZCBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IGNiYjc5ZWYzYmZjOS4uMDAwMDAwMDAwMDAwDQo+
IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L3BhbmVsL3Jh
eWRpdW0scm02ODIwMC50eHQNCj4gKysrIC9kZXYvbnVsbA0KPiBAQCAtMSwyNSArMCwwIEBADQo+
IC1SYXlkaXVtIFNlbWljb25kdWN0b3IgQ29ycG9yYXRpb24gUk02ODIwMCA1LjUiIDcyMHAgTUlQ
SS1EU0kgVEZUIExDRCBwYW5lbA0KPiAtDQo+IC1UaGUgUmF5ZGl1bSBTZW1pY29uZHVjdG9yIENv
cnBvcmF0aW9uIFJNNjgyMDAgaXMgYSA1LjUiIDcyMHgxMjgwIFRGVCBMQ0QNCj4gLXBhbmVsIGNv
bm5lY3RlZCB1c2luZyBhIE1JUEktRFNJIHZpZGVvIGludGVyZmFjZS4NCj4gLQ0KPiAtUmVxdWly
ZWQgcHJvcGVydGllczoNCj4gLSAgLSBjb21wYXRpYmxlOiAicmF5ZGl1bSxybTY4MjAwIg0KPiAt
ICAtIHJlZzogdGhlIHZpcnR1YWwgY2hhbm5lbCBudW1iZXIgb2YgYSBEU0kgcGVyaXBoZXJhbA0K
PiAtDQo+IC1PcHRpb25hbCBwcm9wZXJ0aWVzOg0KPiAtICAtIHJlc2V0LWdwaW9zOiBhIEdQSU8g
c3BlYyBmb3IgdGhlIHJlc2V0IHBpbiAoYWN0aXZlIGxvdykuDQo+IC0gIC0gcG93ZXItc3VwcGx5
OiBwaGFuZGxlIG9mIHRoZSByZWd1bGF0b3IgdGhhdCBwcm92aWRlcyB0aGUgc3VwcGx5IHZvbHRh
Z2UuDQo+IC0gIC0gYmFja2xpZ2h0OiBwaGFuZGxlIG9mIHRoZSBiYWNrbGlnaHQgZGV2aWNlIGF0
dGFjaGVkIHRvIHRoZSBwYW5lbC4NCj4gLQ0KPiAtRXhhbXBsZToNCj4gLSZkc2kgew0KPiAtCS4u
Lg0KPiAtCXBhbmVsQDAgew0KPiAtCQljb21wYXRpYmxlID0gInJheWRpdW0scm02ODIwMCI7DQo+
IC0JCXJlZyA9IDwwPjsNCj4gLQkJcmVzZXQtZ3Bpb3MgPSA8JmdwaW9mIDE1IEdQSU9fQUNUSVZF
X0xPVz47DQo+IC0JCXBvd2VyLXN1cHBseSA9IDwmdjF2OD47DQo+IC0JCWJhY2tsaWdodCA9IDwm
cHdtX2JhY2tsaWdodD47DQo+IC0JfTsNCj4gLX07DQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9wYW5lbC9yYXlkaXVtLHJtNjgyMDAueWFt
bCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L3BhbmVsL3JheWRp
dW0scm02ODIwMC55YW1sDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAw
MDAwMC4uMDkxNDlmMTQwZDVmDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvcGFuZWwvcmF5ZGl1bSxybTY4MjAwLnlhbWwN
Cj4gQEAgLTAsMCArMSw1NiBAQA0KPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0y
LjAtb25seSBvciBCU0QtMi1DbGF1c2UpDQo+ICslWUFNTCAxLjINCj4gKy0tLQ0KPiArJGlkOiBo
dHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9kaXNwbGF5L3BhbmVsL3JheWRpdW0scm02ODIw
MC55YW1sIw0KPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9j
b3JlLnlhbWwjDQo+ICsNCj4gK3RpdGxlOiBSYXlkaXVtIFNlbWljb25kdWN0b3IgQ29ycG9yYXRp
b24gUk02ODIwMCA1LjUiIDcyMHAgTUlQSS1EU0kgVEZUIExDRCBwYW5lbA0KPiArDQo+ICttYWlu
dGFpbmVyczoNCj4gKyAgLSBQaGlsaXBwZSBDT1JOVSA8cGhpbGlwcGUuY29ybnVAc3QuY29tPg0K
PiArDQo+ICtkZXNjcmlwdGlvbjogfA0KPiArICAgICAgICAgICAgIFRoZSBSYXlkaXVtIFNlbWlj
b25kdWN0b3IgQ29ycG9yYXRpb24gUk02ODIwMCBpcyBhIDUuNSIgNzIweDEyODAgVEZUIExDRA0K
PiArICAgICAgICAgICAgIHBhbmVsIGNvbm5lY3RlZCB1c2luZyBhIE1JUEktRFNJIHZpZGVvIGlu
dGVyZmFjZS4NCj4gKw0KPiArYWxsT2Y6DQo+ICsgIC0gJHJlZjogcGFuZWwtY29tbW9uLnlhbWwj
DQo+ICsNCj4gK3Byb3BlcnRpZXM6DQo+ICsNCj4gKyAgY29tcGF0aWJsZToNCj4gKyAgICBjb25z
dDogcmF5ZGl1bSxybTY4MjAwDQo+ICsNCj4gKyAgcmVnOg0KPiArICAgIG1heEl0ZW1zOiAxDQo+
ICsgICAgZGVzY3JpcHRpb246IERTSSB2aXJ0dWFsIGNoYW5uZWwNCj4gKw0KPiArICBiYWNrbGln
aHQ6IHRydWUNCj4gKyAgZW5hYmxlLWdwaW9zOiB0cnVlDQo+ICsgIHBvcnQ6IHRydWUNCj4gKyAg
cG93ZXItc3VwcGx5OiB0cnVlDQo+ICsNCj4gKyAgcmVzZXQtZ3Bpb3M6DQo+ICsgICAgbWF4SXRl
bXM6IDENCj4gKw0KPiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ICsNCj4gK3JlcXVp
cmVkOg0KPiArICAtIGNvbXBhdGlibGUNCj4gKyAgLSBwb3dlci1zdXBwbHkNCj4gKyAgLSByZWcN
Cj4gKw0KPiArZXhhbXBsZXM6DQo+ICsgIC0gfA0KPiArICAgIGRzaUAwIHsNCj4gKyAgICAgICNh
ZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiArICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQo+ICsgICAg
ICBwYW5lbEAwIHsNCj4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJyYXlkaXVtLHJtNjgyMDAiOw0K
PiArICAgICAgICByZWcgPSA8MD47DQo+ICsgICAgICAgIHJlc2V0LWdwaW9zID0gPCZncGlvZiAx
NSAwPjsNCj4gKyAgICAgICAgcG93ZXItc3VwcGx5ID0gPCZ2MXY4PjsNCj4gKyAgICAgICAgYmFj
a2xpZ2h0ID0gPCZwd21fYmFja2xpZ2h0PjsNCj4gKyAgICAgIH07DQo+ICsgICAgfTsNCj4gKy4u
Lg0KPiANCg0KUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIENvcm51IDxwaGlsaXBwZS5jb3JudUBzdC5j
b20+DQpUaGFuayB5b3UNClBoaWxpcHBlIDotKQ==
