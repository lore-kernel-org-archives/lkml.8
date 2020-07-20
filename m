Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8C0C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16C602080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="aieiYV5j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgGTJR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:17:28 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:42314 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726657AbgGTJR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:17:27 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06K9AiTc031182;
        Mon, 20 Jul 2020 11:17:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=IIqjr+2EWMm3hORsqkFhj9cLOppUA2l9XjaSeJ9kH0A=;
 b=aieiYV5jwCr1RxBctMZGMP2BTkzrRr8JJxWnf0FmCRDKEmMjibLwCJEEFkr7gUoD1CZ9
 yYF5l913JmyfnlrkdUFEh7NtPyBj5GPSmBlzzlf5hTLwE/w1Y/Mbu/3y/+OQ213SpujD
 Ug5Rt3AYgQ91n8WMApBAWCu+wpwBCKt832CKDcbftRXjerleeYNbkOe6fu0oA4GuiytT
 zyZSYvcHQIhl/SvekFZ+PWTOwz6JLuRp2vHNXiHSBiJcb+v2l1+MOxt6Z2f+wYy4MwNf
 zb8TSbhVtZJ3vBhc/OJDtU/TzSlPpbbBL+FVTx0/6Sd9Ja/Uc6g/rFnSMZQ0rgldyJ6P gQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32bsagqwpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 11:17:10 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D048F10002A;
        Mon, 20 Jul 2020 11:17:07 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BC0E521F664;
        Mon, 20 Jul 2020 11:17:07 +0200 (CEST)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Jul
 2020 11:17:07 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Mon, 20 Jul 2020 11:17:07 +0200
From:   Benjamin GAIGNARD <benjamin.gaignard@st.com>
To:     Rob Herring <robh@kernel.org>
CC:     "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stefano.stabellini@xilinx.com" <stefano.stabellini@xilinx.com>,
        "tomase@xilinx.com" <tomase@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 1/5] dt-bindings: bus: Add firewall bindings
Thread-Topic: [PATCH v4 1/5] dt-bindings: bus: Add firewall bindings
Thread-Index: AQHWT6sWuhNHUdehJ0WOrRFCPK5R86kFrZMAgAp+ogA=
Date:   Mon, 20 Jul 2020 09:17:07 +0000
Message-ID: <77cebf30-863e-6265-a061-e0b406bb8de7@st.com>
References: <20200701132523.32533-1-benjamin.gaignard@st.com>
 <20200701132523.32533-2-benjamin.gaignard@st.com>
 <20200713170116.GA364356@bogus>
In-Reply-To: <20200713170116.GA364356@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4445D5F24D8E624B8E2A5AA83AF41703@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-20_05:2020-07-17,2020-07-20 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDcvMTMvMjAgNzowMSBQTSwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IE9uIFdlZCwgSnVs
IDAxLCAyMDIwIGF0IDAzOjI1OjE5UE0gKzAyMDAsIEJlbmphbWluIEdhaWduYXJkIHdyb3RlOg0K
Pj4gQWRkIHNjaGVtYXMgZm9yIGZpcmV3YWxsIGNvbnN1bWVyIGFuZCBwcm92aWRlci4NCj4+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBCZW5qYW1pbiBHYWlnbmFyZCA8YmVuamFtaW4uZ2FpZ25hcmRAc3Qu
Y29tPg0KPj4gUmV2aWV3ZWQtYnk6IExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxlaWpAbGluYXJv
Lm9yZz4NCj4+IC0tLQ0KPj4gICAuLi4vYmluZGluZ3MvYnVzL3N0bTMyL2ZpcmV3YWxsLWNvbnN1
bWVyLnlhbWwgICAgICB8IDM2ICsrKysrKysrKysrKysrKysrKysrKysNCj4+ICAgLi4uL2JpbmRp
bmdzL2J1cy9zdG0zMi9maXJld2FsbC1wcm92aWRlci55YW1sICAgICAgfCAxOCArKysrKysrKysr
Kw0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDU0IGluc2VydGlvbnMoKykNCj4+ICAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9idXMvc3RtMzIvZmly
ZXdhbGwtY29uc3VtZXIueWFtbA0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2J1cy9zdG0zMi9maXJld2FsbC1wcm92aWRlci55YW1sDQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9idXMv
c3RtMzIvZmlyZXdhbGwtY29uc3VtZXIueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9idXMvc3RtMzIvZmlyZXdhbGwtY29uc3VtZXIueWFtbA0KPj4gbmV3IGZpbGUgbW9k
ZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uZDNkNzZmOTliMzhkDQo+PiAtLS0gL2Rl
di9udWxsDQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYnVzL3N0
bTMyL2ZpcmV3YWxsLWNvbnN1bWVyLnlhbWwNCj4+IEBAIC0wLDAgKzEsMzYgQEANCj4+ICsjIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4+
ICslWUFNTCAxLjINCj4+ICstLS0NCj4+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hl
bWFzL2J1cy9zdG0zMi9maXJld2FsbC1jb25zdW1lci55YW1sIw0KPj4gKyRzY2hlbWE6IGh0dHA6
Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPj4gKw0KPj4gK3RpdGxl
OiBDb21tb24gQnVzIEZpcmV3YWxsIGNvbnN1bWVyIGJpbmRpbmcNCj4gSSdtIGFsbCBmb3IgY29t
bW9uIGJpbmRpbmdzLCBidXQgSSB3YW50IHRvIHNlZSBtb3JlIHRoYW4gMSB1c2VyIGJlZm9yZQ0K
PiBhY2NlcHRpbmcgdGhpcy4gVGhlcmUncyBiZWVuIHNvbWUgb3RoZXIgcG9zdGluZ3MgZm9yIHNp
bWlsYXIgaC93DQo+IChBRkFJQ1QpIHJlY2VudGx5Lg0KPg0KPj4gKw0KPj4gK2Rlc2NyaXB0aW9u
OiB8DQo+PiArICBGaXJld2FsbCBwcm9wZXJ0aWVzIHByb3ZpZGUgdGhlIHBvc3NpYmxlIGZpcmV3
YWxsIGJ1cyBjb250cm9sbGVyDQo+PiArICBjb25maWd1cmF0aW9ucyBmb3IgYSBkZXZpY2UuDQo+
PiArICBCdXMgZmlyZXdhbGwgY29udHJvbGxlcnMgYXJlIHR5cGljYWxseSB1c2VkIHRvIGNvbnRy
b2wgaWYgYSBoYXJkd2FyZQ0KPj4gKyAgYmxvY2sgY2FuIHBlcmZvcm0gcmVhZCBvciB3cml0ZSBv
cGVyYXRpb25zIG9uIGJ1cy4NCj4+ICsgIFRoZSBjb250ZW50cyBvZiB0aGUgZmlyZXdhbGwgYnVz
IGNvbmZpZ3VyYXRpb24gcHJvcGVydGllcyBhcmUgZGVmaW5lZCBieQ0KPj4gKyAgdGhlIGJpbmRp
bmcgZm9yIHRoZSBpbmRpdmlkdWFsIGZpcmV3YWxsIGNvbnRyb2xsZXIgZGV2aWNlLg0KPj4gKw0K
Pj4gKyAgVGhlIGZpcnN0IGNvbmZpZ3VyYXRpb24gJ2ZpcmV3YWxsLTAnIG9yIHRoZSBvbmUgbmFt
ZWQgJ2RlZmF1bHQnIGlzDQo+PiArICBhcHBsaWVkIGJlZm9yZSBwcm9iaW5nIHRoZSBkZXZpY2Ug
aXRzZWxmLg0KPiBUaGlzIGlzIGEgTGludXggaW1wbGVtZW50YXRpb24gZGV0YWlsIGFuZCBkZWJh
dGFibGUgd2hldGhlciB0aGUgY29yZQ0KPiBzaG91bGQgZG8gdGhpcyBvciBkcml2ZXJzLg0KSSBj
b3VsZCBwcmVmaXggdGhlIHByb3BlcnR5IHdpdGggJ3N0LHN0bTMyJyBzbyBpdCB3aWxsIGRlZGlj
YXRlZCB0byANClNUTTMyIFNvQ3MuDQpXaWxsIGl0IHNvdW5kIGJldHRlciBmb3IgeW91ID8NCg0K
IEZyb20gR3JlZyBjb21tZW50cyBpbiB0aGUgcHJldmlvdXMgdmVyc2lvbnMgb2YgdGhpcyBwYXRj
aCBJIHVuZGVyc3RhbmQgdGhhdA0KaXQgaXNuJ3Qgc29tZXRoaW5nIHRvIGJlIGRvbmUgaW4gdGhl
IGNvcmUuIFRoZSBiZXN0IEkgY2FuIGRvIGhlcmUgaXMgdG8gDQprZWVwIGl0IGFzDQpoZWxwZXJz
IGZvciBTVE0zMiBTb0NzLg0KPg0KPj4gKw0KPj4gK21haW50YWluZXJzOg0KPj4gKyAgLSBCZW5q
YW1pbiBHYWlnbmFyZCA8YmVuamFtaW4uZ2FpZ25hcmRAc3QuY29tPg0KPj4gKw0KPj4gKyMgYWx3
YXlzIHNlbGVjdCB0aGUgY29yZSBzY2hlbWENCj4+ICtzZWxlY3Q6IHRydWUNCj4+ICsNCj4+ICtw
cm9wZXJ0aWVzOg0KPj4gKyAgZmlyZXdhbGwtMDogdHJ1ZQ0KPj4gKw0KPj4gKyAgZmlyZXdhbGwt
bmFtZXM6IHRydWUNCj4+ICsNCj4+ICtwYXR0ZXJuUHJvcGVydGllczoNCj4+ICsgICJmaXJld2Fs
bC1bMC05XSI6DQo+PiArICAgICRyZWY6ICIvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9u
cy9waGFuZGxlLWFycmF5Ig0KPiBTbyBJIGd1ZXNzIG11bHRpcGxlIHByb3BlcnRpZXMgaXMgdG8g
ZW5jb2RlIGFsbCB0aGUgbW9kZXMgaW50byBEVCBsaWtlDQo+IHBpbmN0cmwgZG9lcy4gSXMgdGhh
dCByZWFsbHkgbmVjZXNzYXJ5PyBJIGRvbid0IHRoaW5rIHNvIGFzIEkgd291bGRuJ3QNCj4gZXhw
ZWN0IG1vZGVzIHRvIGJlIGRlZmluZWQgYnkgdGhlIGNvbnN1bWVyLCBidXQgYnkgdGhlIHByb3Zp
ZGVyIGluIHRoaXMNCj4gY2FzZS4gVG8gdXNlIHBpbmN0cmwgYXMgYSBleGFtcGxlLCB3ZSBjb3Vs
ZCBoYXZlIHBhZCBzZXR0aW5nIHBlciBNTUMNCj4gc3BlZWQuIFRoYXQgaGFzIHRvIGJlIGluIHRo
ZSBjb25zdW1lciBzaWRlIGFzIHRoZSBwaW5jdHJsIGtub3dzIG5vdGhpbmcNCj4gYWJvdXQgTU1D
Lg0KSSBleHBlY3QgdG8gYmUgYWJsZSB0byBzZXQgcGhhbmRsZSBvbiBkaWZmZXJlbnQgZmlyZXdh
bGwgY29udHJvbGxlcnMuDQpJIGRvbid0IGtub3cgaWYgaXQgaXMgcG9zc2libGUgd2l0aCB0aGUg
c2FtZSBzdHJ1Y3R1cmUgdGhhbiBmb3IgcGlucyANCmNvbnRyb2xsZXJzLg0KPiAgIA0KPiBSb2IN
Cg==
