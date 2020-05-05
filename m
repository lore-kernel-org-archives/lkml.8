Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3C5C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06A0020675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="VtSgjuMR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgEEPBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:01:17 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:62484 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729596AbgEEPBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:01:15 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 045El9ne016435;
        Tue, 5 May 2020 17:00:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=IbLvmIr+VxgtqpaSuIKBL6LNWk+1yxMvrL3mHUlR5/g=;
 b=VtSgjuMRko+aYlOPzneie7sscr9XnTQSkMWmK01QoI3OZ7EaHWKpRlTrqXhFV7gSu/T4
 vNQuihrzJhVBbM68FXy4lx67khWj5M6vd9LFVbofc3IZ12ai1LQ7olLSMYQ9SN4g7FQV
 N2Oj1qUJZjBdq1WmaDv5bDdc4fERIKmGJRBggimnaaV2xPJqSGAIAOWdMfxbg3Et0ouD
 D+TYgsMld7vlAE2VLNBFn9Sqs+EIiBRb+1KxiMmVCBNpfXvvcGgZgBiQ5LlARKRkCxDu
 d3+AKcqG0xgyWmZus6dQNY85nOS2FCOpcvL26nsQnaV0uJMqPdN0+XEnCNtvXgElyfZI TQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30rxb20sdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 May 2020 17:00:55 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5F05210002A;
        Tue,  5 May 2020 17:00:54 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag7node2.st.com [10.75.127.20])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4BC382B0E9F;
        Tue,  5 May 2020 17:00:54 +0200 (CEST)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG7NODE2.st.com
 (10.75.127.20) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 5 May
 2020 17:00:53 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Tue, 5 May 2020 17:00:53 +0200
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "Loic PALLARDY" <loic.pallardy@st.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] bus: stm32: Introduce firewall controller helpers
Thread-Topic: [PATCH v3 2/5] bus: stm32: Introduce firewall controller helpers
Thread-Index: AQHWIq93zmKMzoYdMEeJzuj6lP5gO6iZb0WAgAAFxQA=
Date:   Tue, 5 May 2020 15:00:53 +0000
Message-ID: <3f15fefa-b70f-5d20-c19b-3c42140a104c@st.com>
References: <20200505073308.22914-1-benjamin.gaignard@st.com>
 <20200505073308.22914-3-benjamin.gaignard@st.com>
 <20200505144013.GB838641@kroah.com>
In-Reply-To: <20200505144013.GB838641@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <57CCBC245F8373439B28D87A7A5EB0EF@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-05_08:2020-05-04,2020-05-05 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDUvNS8yMCA0OjQwIFBNLCBHcmVnIEtIIHdyb3RlOg0KPiBPbiBUdWUsIE1heSAwNSwg
MjAyMCBhdCAwOTozMzowNUFNICswMjAwLCBCZW5qYW1pbiBHYWlnbmFyZCB3cm90ZToNCj4+IFRo
ZSBnb2FsIG9mIHRoZXNlIGhlbHBlcnMgYXJlIHRvIG9mZmVyIGFuIGludGVyZmFjZSBmb3IgdGhl
DQo+PiBoYXJkd2FyZSBibG9ja3MgY29udHJvbGxpbmcgYnVzIGFjY2Vzc2VzIHJpZ2h0cy4NCj4+
DQo+PiBCdXMgZmlyZXdhbGwgY29udHJvbGxlcnMgYXJlIHR5cGljYWxseSB1c2VkIHRvIGNvbnRy
b2wgaWYgYQ0KPj4gaGFyZHdhcmUgYmxvY2sgY2FuIHBlcmZvcm0gcmVhZCBvciB3cml0ZSBvcGVy
YXRpb25zIG9uIGJ1cy4NCj4+DQo+PiBTbWFydGVyIGZpcmV3YWxsIGNvbnRyb2xsZXJzIGNvdWxk
IGJlIGFibGUgdG8gZGVmaW5lIGFjY2Vzc2VzDQo+PiByaWdodHMgcGVyIGhhcmR3YXJlIGJsb2Nr
cyB0byBjb250cm9sIHdoZXJlIHRoZXkgY2FuIHJlYWQNCj4+IG9yIHdyaXRlLg0KPj4NCj4+IEZp
cmV3YWxsIGNvbnRyb2xsZXIgY29uZmlndXJhdGlvbnMgYXJlIHByb3ZpZGVkIGluIGRldmljZSBu
b2RlLA0KPj4gcGFyc2VkIGJ5IHRoZSBoZWxwZXJzIGFuZCBzZW5kIHRvIHRoZSBkcml2ZXIgdG8g
YXBwbHkgdGhlbS4NCj4+IEVhY2ggY29udHJvbGxlciBtYXkgbmVlZCBkaWZmZXJlbnQgbnVtYmVy
IGFuZCB0eXBlIG9mIGlucHV0cw0KPj4gdG8gY29uZmlndXJlIHRoZSBmaXJld2FsbCBzbyBkZXZp
Y2UtdHJlZSBwcm9wZXJ0aWVzIHNpemUgaGF2ZSB0bw0KPj4gYmUgZGVmaW5lIGJ5IHVzaW5nICIj
ZmlyZXdhbGwtY2VsbHMiLg0KPj4gRmlyZXdhbGwgY29uZmlndXJhdGlvbnMgcHJvcGVydGllcyBo
YXZlIHRvIGJlIG5hbWVkICJmaXJld2FsbC1YIg0KPj4gb24gZGV2aWNlIG5vZGUuDQo+PiAiZmly
ZXdhbGwtbmFtZXMiIGtleXdvcmQgY2FuIGFsc28gYmUgdXNlZCB0byBnaXZlIGEgbmFtZSB0bw0K
Pj4gYSBzcGVjaWZpYyBjb25maWd1cmF0aW9uLg0KPj4NCj4+IEV4YW1wbGUgb2YgZGV2aWNlLXRy
ZWU6DQo+PiBjdHJsMDogZmlyZXdhbGxAMCB7DQo+PiAJI2ZpcmV3YWxsLWNlbGxzID0gPDI+Ow0K
Pj4gICAgICAgIH07DQo+Pg0KPj4gZm9vOiBmb29AMCB7DQo+PiAJZmlyZXdhbGwtbmFtZXMgPSAi
ZGVmYXVsdCIsICJzZXR0aW5nMSI7DQo+PiAJZmlyZXdhbGwtMCA9IDwmY3RybDAgMSAyPjsNCj4+
IAlmaXJld2FsbC0xID0gPCZjdHJsMCAzIDQ+Ow0KPj4gfTsNCj4+DQo+PiBDb25maWd1cmF0aW9u
cyBjb3VsZCBiZSBhcHBsaWVkIHdpdGggZnVuY3Rpb25zIGxpa2UNCj4+IGZpcmV3YWxsX3NldF9j
b25maWdfYnlfaW5kZXgoKSBvciBmaXJld2FsbF9zZXRfY29uZmlnX2J5X25hbWUoKS4NCj4+DQo+
PiBmaXJld2FsbF9zZXRfZGVmYXVsdF9jb25maWcoKSBmdW5jdGlvbiB3aWxsIGFwcGx5IHRoZQ0K
Pj4gY29uZmlndXJhdGlvbiBuYW1lZCAiZGVmYXVsdCIgKGlmIGV4aXN0aW5nKSBvciB0aGUgY29u
ZmlndXJhdGlvbg0KPj4gd2l0aCBpbmRleCAwIChpLmUuIGZpcmV3YWxsLTApLg0KPj4NCj4+IERy
aXZlcnMgY291bGQgcmVnaXN0ZXIvdW5yZWdpc3RlciB0aGVtc2VsdmVzIGJlIGNhbGxpbmcNCj4+
IGZpcmV3YWxsX3JlZ2lzdGVyL2ZpcmV3YWxsX3VucmVnaXN0ZXIgZnVuY3Rpb25zLg0KPj4NCj4+
IFNpZ25lZC1vZmYtYnk6IEJlbmphbWluIEdhaWduYXJkIDxiZW5qYW1pbi5nYWlnbmFyZEBzdC5j
b20+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9idXMvS2NvbmZpZyAgICAgICAgICB8ICAgMiArDQo+
PiAgIGRyaXZlcnMvYnVzL01ha2VmaWxlICAgICAgICAgfCAgIDIgKw0KPj4gICBkcml2ZXJzL2J1
cy9zdG0zMi9LY29uZmlnICAgIHwgICAzICsNCj4+ICAgZHJpdmVycy9idXMvc3RtMzIvTWFrZWZp
bGUgICB8ICAgMSArDQo+PiAgIGRyaXZlcnMvYnVzL3N0bTMyL2ZpcmV3YWxsLmMgfCAyNjYgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICBkcml2ZXJzL2J1
cy9zdG0zMi9maXJld2FsbC5oIHwgIDc1ICsrKysrKysrKysrKw0KPj4gICA2IGZpbGVzIGNoYW5n
ZWQsIDM0OSBpbnNlcnRpb25zKCspDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2J1
cy9zdG0zMi9LY29uZmlnDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2J1cy9zdG0z
Mi9NYWtlZmlsZQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9idXMvc3RtMzIvZmly
ZXdhbGwuYw0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9idXMvc3RtMzIvZmlyZXdh
bGwuaA0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2J1cy9LY29uZmlnIGIvZHJpdmVycy9i
dXMvS2NvbmZpZw0KPj4gaW5kZXggNmQ0ZTQ0OTdiNTliLi44NDNiMzU2MzIyZDkgMTAwNjQ0DQo+
PiAtLS0gYS9kcml2ZXJzL2J1cy9LY29uZmlnDQo+PiArKysgYi9kcml2ZXJzL2J1cy9LY29uZmln
DQo+PiBAQCAtMjAzLDQgKzIwMyw2IEBAIGNvbmZpZyBEQThYWF9NU1RQUkkNCj4+ICAgc291cmNl
ICJkcml2ZXJzL2J1cy9mc2wtbWMvS2NvbmZpZyINCj4+ICAgc291cmNlICJkcml2ZXJzL2J1cy9t
aGkvS2NvbmZpZyINCj4+ICAgDQo+PiArc291cmNlICJkcml2ZXJzL2J1cy9zdG0zMi9LY29uZmln
Ig0KPj4gKw0KPj4gICBlbmRtZW51DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9idXMvTWFrZWZp
bGUgYi9kcml2ZXJzL2J1cy9NYWtlZmlsZQ0KPj4gaW5kZXggMDVmMzJjZDY5NGE0Li41ZTBlMzRi
MTAyMzUgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2J1cy9NYWtlZmlsZQ0KPj4gKysrIGIvZHJp
dmVycy9idXMvTWFrZWZpbGUNCj4+IEBAIC0zNywzICszNyw1IEBAIG9iai0kKENPTkZJR19EQThY
WF9NU1RQUkkpCSs9IGRhOHh4LW1zdHByaS5vDQo+PiAgIA0KPj4gICAjIE1ISQ0KPj4gICBvYmot
JChDT05GSUdfTUhJX0JVUykJCSs9IG1oaS8NCj4+ICsNCj4+ICtvYmotJChDT05GSUdfTUFDSF9T
VE0zMk1QMTU3KSAJKz0gc3RtMzIvDQo+PiBcIE5vIG5ld2xpbmUgYXQgZW5kIG9mIGZpbGUNCj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2J1cy9zdG0zMi9LY29uZmlnIGIvZHJpdmVycy9idXMvc3Rt
MzIvS2NvbmZpZw0KPj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAw
MC4uNTcyMjFlODMzZTJkDQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9kcml2ZXJzL2J1cy9z
dG0zMi9LY29uZmlnDQo+PiBAQCAtMCwwICsxLDMgQEANCj4+ICtjb25maWcgRklSRVdBTExfQ09O
VFJPTExFUlMNCj4+ICsJYm9vbCAiU3VwcG9ydCBvZiBidXMgZmlyZXdhbGwgY29udHJvbGxlcnMi
DQo+PiArCWRlcGVuZHMgb24gT0YNCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2J1cy9zdG0zMi9N
YWtlZmlsZSBiL2RyaXZlcnMvYnVzL3N0bTMyL01ha2VmaWxlDQo+PiBuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMDAwLi5lYjZiOTc4ZDY0NTANCj4+IC0tLSAvZGV2L251
bGwNCj4+ICsrKyBiL2RyaXZlcnMvYnVzL3N0bTMyL01ha2VmaWxlDQo+PiBAQCAtMCwwICsxIEBA
DQo+PiArb2JqLSQoQ09ORklHX0ZJUkVXQUxMX0NPTlRST0xMRVJTKSArPSBmaXJld2FsbC5vDQo+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9idXMvc3RtMzIvZmlyZXdhbGwuYyBiL2RyaXZlcnMvYnVz
L3N0bTMyL2ZpcmV3YWxsLmMNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAw
MDAwMDAwMDAuLjk1ZjcxNmNmOTI2Zg0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvZHJpdmVy
cy9idXMvc3RtMzIvZmlyZXdhbGwuYw0KPj4gQEAgLTAsMCArMSwyNjYgQEANCj4+ICsvLyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPj4gKy8qDQo+PiArICogQ29weXJpZ2h0IChD
KSBTVE1pY3JvZWxlY3Ryb25pY3MgMjAyMCAtIEFsbCBSaWdodHMgUmVzZXJ2ZWQNCj4+ICsgKiBB
dXRob3I6IEJlbmphbWluIEdhaWduYXJkIDxiZW5qYW1pbi5nYWlnbmFyZEBzdC5jb20+IGZvciBT
VE1pY3JvZWxlY3Ryb25pY3MuDQo+PiArICovDQo+PiArDQo+PiArI2luY2x1ZGUgPGxpbnV4L2Rl
dmljZS5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9lcnIuaD4NCj4+ICsjaW5jbHVkZSA8bGludXgv
aW5pdC5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCj4+ICsjaW5jbHVkZSA8bGlu
dXgvbGlzdC5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPj4gKyNpbmNsdWRlIDxsaW51
eC9zbGFiLmg+DQo+PiArDQo+PiArI2luY2x1ZGUgImZpcmV3YWxsLmgiDQo+PiArDQo+PiArLyog
TXV0ZXggdGFrZW4gdG8gcHJvdGVjdCBmaXJld2FsbF9saXN0ICovDQo+PiArc3RhdGljIERFRklO
RV9NVVRFWChmaXJld2FsbF9saXN0X211dGV4KTsNCj4+ICsNCj4+ICsvKiBHbG9iYWwgbGlzdCBv
ZiBmaXJld2FsbCBjb250cm9sIGRldmljZXMgKi8NCj4+ICtzdGF0aWMgTElTVF9IRUFEKGZpcmV3
YWxsX2xpc3QpOw0KPiBXaHkgaXMgdGhhdCBuZWVkZWQ/ICBXaHkgY2FuJ3QgeW91IGp1c3Qgd2Fs
ayB0aGUgbGlzdCBvZiBkZXZpY2VzIG9uIHRoaXMNCj4gImJ1cy9jbGFzcyIgaWYgeW91IHJlYWxs
eSB3YW50ZWQgdG8/DQo+DQo+IEFsb25nIHRob3NlIGxpbmVzLCB3aHkgaXMgdGhpcyBnb2luZyBh
cm91bmQgdGhlIGRyaXZlciBtb2RlbCBhbmQNCj4gaWdub3JpbmcgaXQ/ICBTaG91bGRuJ3QgdGhp
cyBiZSBhIGJ1cyBhbmQgeW91IGhhdmUgZGV2aWNlcyBhdHRhY2hlZCB0bw0KPiBpdCBvZiB0aGUg
c3BlY2lmaWMgdHlwZT8NClRoaXMgcGFydCBvZiB0aGUgc2VyaWVzIGlzIG9ubHkgYSBhIHNldCBv
ZiBjb21tb24gZnVuY3Rpb25zIGFuZCBiaW5kaW5ncw0KdGhhdCBJIHBsYW4gdG8gcmV1c2UgZm9y
IGZ1dHVyIFNUTTMyIFNvQ3MuDQpUaGUgJ3JlYWwnIGJ1cyBpbXBsZW1lbnRhdGlvbiBpcyBpbiBw
YXRjaCA0Lg0KDQpCZW5qYW1pbg0KPg0KPg0KPiBncmVnIGstaA0K
