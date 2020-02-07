Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C39C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF62620838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="IuS7DkoJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgBGJfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 04:35:11 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33142 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726451AbgBGJfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 04:35:10 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0179RUDx013874;
        Fri, 7 Feb 2020 10:34:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=bUFEdxgHJ3uF5fxlnj+Oz6ttTEQRedQ3ZUNqy8lCUjU=;
 b=IuS7DkoJEon3mMJ3lk5szh26gy3yt0ZaYpUkiXVkhDScwV65SGAkmHmGfVoXq0QMBhsH
 l9rk1ZLGTQUjt31ryiQZSs+fGhNHUIDdhsBOxX1+ARrGvnC1ByGOL8+YeiLxqdHnFUES
 0pwwvmAdzmW/UCbbihnIXmMbe9/t1CH4cC8h/Vm0JR3vEuDTMES5GgDC1lVFppK8UZ9O
 /feJ68sudoOhgtaNaCWo7B2sNaOsllbabbAICEepLfAGMqjh+1O3EGk2i0m5FyFDfDhs
 I89fXriFMPsPC+he+yQEctPcJYNzKWCAKYyzz1YCgVEP8NmxmTOLCWTN0+am1dKkYwMt AA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xyhm003tt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Feb 2020 10:34:53 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 22DE2100034;
        Fri,  7 Feb 2020 10:34:48 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E81192A8FA2;
        Fri,  7 Feb 2020 10:34:47 +0100 (CET)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 7 Feb
 2020 10:34:47 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1473.003; Fri, 7 Feb 2020 10:34:47 +0100
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
Subject: Re: [PATCH v4 3/3] dt-bindings: panel: Convert orisetech,otm8009a to
 json-schema
Thread-Topic: [PATCH v4 3/3] dt-bindings: panel: Convert orisetech,otm8009a to
 json-schema
Thread-Index: AQHV3PIRgJ4AtMRmk0Ke4l0B2y5xt6gPaP+A
Date:   Fri, 7 Feb 2020 09:34:47 +0000
Message-ID: <80b5cd29-166c-f3a2-891f-762c45dd203b@st.com>
References: <20200206133344.724-1-benjamin.gaignard@st.com>
 <20200206133344.724-4-benjamin.gaignard@st.com>
In-Reply-To: <20200206133344.724-4-benjamin.gaignard@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8804B4F629350A48B86A7680318AF44E@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-07_01:2020-02-07,2020-02-06 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmVuamFtaW4sDQoNCk9uIDIvNi8yMCAyOjMzIFBNLCBCZW5qYW1pbiBHYWlnbmFyZCB3cm90
ZToNCj4gQ29udmVydCBvcmlzZXRlY2gsb3RtODAwOWEgdG8ganNvbi1zY2hlbWEuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBCZW5qYW1pbiBHYWlnbmFyZCA8YmVuamFtaW4uZ2FpZ25hcmRAc3QuY29t
Pg0KPiAtLS0NCj4gICAuLi4vYmluZGluZ3MvZGlzcGxheS9wYW5lbC9vcmlzZXRlY2gsb3RtODAw
OWEudHh0ICB8IDIzIC0tLS0tLS0tLS0NCj4gICAuLi4vYmluZGluZ3MvZGlzcGxheS9wYW5lbC9v
cmlzZXRlY2gsb3RtODAwOWEueWFtbCB8IDUzICsrKysrKysrKysrKysrKysrKysrKysNCj4gICAy
IGZpbGVzIGNoYW5nZWQsIDUzIGluc2VydGlvbnMoKyksIDIzIGRlbGV0aW9ucygtKQ0KPiAgIGRl
bGV0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxh
eS9wYW5lbC9vcmlzZXRlY2gsb3RtODAwOWEudHh0DQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L3BhbmVsL29yaXNldGVjaCxv
dG04MDA5YS55YW1sDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2Rpc3BsYXkvcGFuZWwvb3Jpc2V0ZWNoLG90bTgwMDlhLnR4dCBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L3BhbmVsL29yaXNldGVjaCxvdG04MDA5
YS50eHQNCj4gZGVsZXRlZCBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDIwM2IwM2VlZmI2OC4u
MDAwMDAwMDAwMDAwDQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9k
aXNwbGF5L3BhbmVsL29yaXNldGVjaCxvdG04MDA5YS50eHQNCj4gKysrIC9kZXYvbnVsbA0KPiBA
QCAtMSwyMyArMCwwIEBADQo+IC1PcmlzZSBUZWNoIE9UTTgwMDlBIDMuOTciIDQ4MHg4MDAgVEZU
IExDRCBwYW5lbCAoTUlQSS1EU0kgdmlkZW8gbW9kZSkNCj4gLQ0KPiAtVGhlIE9yaXNlIFRlY2gg
T1RNODAwOUEgaXMgYSAzLjk3IiA0ODB4ODAwIFRGVCBMQ0QgcGFuZWwgY29ubmVjdGVkIHVzaW5n
DQo+IC1hIE1JUEktRFNJIHZpZGVvIGludGVyZmFjZS4gSXRzIGJhY2tsaWdodCBpcyBtYW5hZ2Vk
IHRocm91Z2ggdGhlIERTSSBsaW5rLg0KPiAtDQo+IC1SZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiAt
ICAtIGNvbXBhdGlibGU6ICJvcmlzZXRlY2gsb3RtODAwOWEiDQo+IC0gIC0gcmVnOiB0aGUgdmly
dHVhbCBjaGFubmVsIG51bWJlciBvZiBhIERTSSBwZXJpcGhlcmFsDQo+IC0NCj4gLU9wdGlvbmFs
IHByb3BlcnRpZXM6DQo+IC0gIC0gcmVzZXQtZ3Bpb3M6IGEgR1BJTyBzcGVjIGZvciB0aGUgcmVz
ZXQgcGluIChhY3RpdmUgbG93KS4NCj4gLSAgLSBwb3dlci1zdXBwbHk6IHBoYW5kbGUgb2YgdGhl
IHJlZ3VsYXRvciB0aGF0IHByb3ZpZGVzIHRoZSBzdXBwbHkgdm9sdGFnZS4NCj4gLQ0KPiAtRXhh
bXBsZToNCj4gLSZkc2kgew0KPiAtCS4uLg0KPiAtCXBhbmVsQDAgew0KPiAtCQljb21wYXRpYmxl
ID0gIm9yaXNldGVjaCxvdG04MDA5YSI7DQo+IC0JCXJlZyA9IDwwPjsNCj4gLQkJcmVzZXQtZ3Bp
b3MgPSA8JmdwaW9oIDcgR1BJT19BQ1RJVkVfTE9XPjsNCj4gLQkJcG93ZXItc3VwcGx5ID0gPCZ2
MXY4PjsNCj4gLQl9Ow0KPiAtfTsNCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9kaXNwbGF5L3BhbmVsL29yaXNldGVjaCxvdG04MDA5YS55YW1sIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvcGFuZWwvb3Jpc2V0ZWNoLG90
bTgwMDlhLnlhbWwNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAw
Li42ZTZhYzk5NWMyN2INCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9wYW5lbC9vcmlzZXRlY2gsb3RtODAwOWEueWFtbA0K
PiBAQCAtMCwwICsxLDUzIEBADQo+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIu
MC1vbmx5IG9yIEJTRC0yLUNsYXVzZSkNCj4gKyVZQU1MIDEuMg0KPiArLS0tDQo+ICskaWQ6IGh0
dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2Rpc3BsYXkvcGFuZWwvb3Jpc2V0ZWNoLG90bTgw
MDlhLnlhbWwjDQo+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFz
L2NvcmUueWFtbCMNCj4gKw0KPiArdGl0bGU6IE9yaXNlIFRlY2ggT1RNODAwOUEgMy45NyIgNDgw
eDgwMCBURlQgTENEIHBhbmVsIChNSVBJLURTSSB2aWRlbyBtb2RlKQ0KPiArDQo+ICttYWludGFp
bmVyczoNCj4gKyAgLSBQaGlsaXBwZSBDT1JOVSA8cGhpbGlwcGUuY29ybnVAc3QuY29tPg0KPiAr
DQo+ICtkZXNjcmlwdGlvbjogfA0KPiArICAgICAgICAgICAgIFRoZSBPcmlzZSBUZWNoIE9UTTgw
MDlBIGlzIGEgMy45NyIgNDgweDgwMCBURlQgTENEIHBhbmVsIGNvbm5lY3RlZCB1c2luZw0KPiAr
ICAgICAgICAgICAgIGEgTUlQSS1EU0kgdmlkZW8gaW50ZXJmYWNlLiBJdHMgYmFja2xpZ2h0IGlz
IG1hbmFnZWQgdGhyb3VnaCB0aGUgRFNJIGxpbmsuDQo+ICthbGxPZjoNCj4gKyAgLSAkcmVmOiBw
YW5lbC1jb21tb24ueWFtbCMNCj4gKw0KPiArcHJvcGVydGllczoNCj4gKw0KPiArICBjb21wYXRp
YmxlOg0KPiArICAgIGNvbnN0OiBvcmlzZXRlY2gsb3RtODAwOWENCj4gKw0KPiArICByZWc6DQo+
ICsgICAgbWF4SXRlbXM6IDENCj4gKyAgICBkZXNjcmlwdGlvbjogRFNJIHZpcnR1YWwgY2hhbm5l
bA0KPiArDQo+ICsgIGVuYWJsZS1ncGlvczogdHJ1ZQ0KPiArICBwb3J0OiB0cnVlDQo+ICsgIHBv
d2VyLXN1cHBseTogdHJ1ZQ0KPiArDQo+ICsgIHJlc2V0LWdwaW9zOg0KPiArICAgIG1heEl0ZW1z
OiAxDQo+ICsNCj4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiArDQo+ICtyZXF1aXJl
ZDoNCj4gKyAgLSBjb21wYXRpYmxlDQo+ICsgIC0gcmVnDQo+ICsNCj4gK2V4YW1wbGVzOg0KPiAr
ICAtIHwNCj4gKyAgICBkc2lAMCB7DQo+ICsgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4g
KyAgICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPiArICAgICAgcGFuZWxAMCB7DQo+ICsgICAgICAg
IGNvbXBhdGlibGUgPSAib3Jpc2V0ZWNoLG90bTgwMDlhIjsNCj4gKyAgICAgICAgcmVnID0gPDA+
Ow0KPiArICAgICAgICByZXNldC1ncGlvcyA9IDwmZ3Bpb2YgMTUgMD47DQo+ICsgICAgICAgIHBv
d2VyLXN1cHBseSA9IDwmdjF2OD47DQo+ICsgICAgICB9Ow0KPiArICAgIH07DQo+ICsuLi4NCj4g
Kw0KPiANCg0KUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIENvcm51IDxwaGlsaXBwZS5jb3JudUBzdC5j
b20+DQpUaGFuayB5b3UNClBoaWxpcHBlIDotKQ==
