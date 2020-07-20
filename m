Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F04C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D0392176B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="FCelGv/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgGTJVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:21:54 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:35179 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726736AbgGTJVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:21:53 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06K9EfOc031975;
        Mon, 20 Jul 2020 11:21:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=GN+yMTwPABdvVS7FhpTsm1OeMf5cbjvKozUPn7B/wV0=;
 b=FCelGv/muQ0iz9iNtNePn+kuqHIZ8Ao19lKMbdtwbZvONG8p5URLzO+HDLjxYVjsAkrr
 iYNd8jksWV6jSPgbNjqhj+kfsYStKHyjBz5H4Dv4WpBeSkJPmvgtl1POi6wsNWOfWs6j
 1G2hvOnj9oCcQC035VphHI+hz96+vd1IWwLmb6i41dGEFM+IX0S6I8MniOgS8zacoj7X
 yr3SpFFR56k8oZO4sFDog1LHox4AaxzuktXEeiUNnfW/F8wi91MwOWMFbgXwO43PhuUT
 NcXeLG8HhHHe8mdKtTbWBBkcc2/aaNPwp6UqLWfURIay/QtgSxI7i4HdKb37m4+UIMHg oQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32bs6uqvpb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 11:21:36 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F301A10002A;
        Mon, 20 Jul 2020 11:21:35 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DF5FC2B33A4;
        Mon, 20 Jul 2020 11:21:35 +0200 (CEST)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Jul
 2020 11:21:35 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Mon, 20 Jul 2020 11:21:35 +0200
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
Subject: Re: [PATCH v4 3/5] dt-bindings: bus: Add STM32 ETZPC firewall
 controller
Thread-Topic: [PATCH v4 3/5] dt-bindings: bus: Add STM32 ETZPC firewall
 controller
Thread-Index: AQHWT6sXiDhFwJxpJEGLijki4gqejakFrtAAgAp+pQA=
Date:   Mon, 20 Jul 2020 09:21:35 +0000
Message-ID: <98aef908-ddbb-4bcd-1880-02f2583059c6@st.com>
References: <20200701132523.32533-1-benjamin.gaignard@st.com>
 <20200701132523.32533-4-benjamin.gaignard@st.com>
 <20200713170542.GA384390@bogus>
In-Reply-To: <20200713170542.GA384390@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A487863F4E9234D83FD1BD592691EB8@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-20_05:2020-07-17,2020-07-20 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDcvMTMvMjAgNzowNSBQTSwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IE9uIFdlZCwgSnVs
IDAxLCAyMDIwIGF0IDAzOjI1OjIxUE0gKzAyMDAsIEJlbmphbWluIEdhaWduYXJkIHdyb3RlOg0K
Pj4gRG9jdW1lbnQgU1RNMzIgRVRaUEMgZmlyZXdhbGwgY29udHJvbGxlciBiaW5kaW5ncw0KPj4N
Cj4+IFNpZ25lZC1vZmYtYnk6IEJlbmphbWluIEdhaWduYXJkIDxiZW5qYW1pbi5nYWlnbmFyZEBz
dC5jb20+DQo+PiAtLS0NCj4+ICAgLi4uL2JpbmRpbmdzL2J1cy9zdG0zMi9zdCxzdG0zMi1ldHpw
Yy55YW1sICAgICAgICAgfCA0NiArKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIDEgZmlsZSBj
aGFuZ2VkLCA0NiBpbnNlcnRpb25zKCspDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYnVzL3N0bTMyL3N0LHN0bTMyLWV0enBjLnlhbWwN
Cj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2J1
cy9zdG0zMi9zdCxzdG0zMi1ldHpwYy55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2J1cy9zdG0zMi9zdCxzdG0zMi1ldHpwYy55YW1sDQo+PiBuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMDAwLi5kOTI4NjVmZGE0MGMNCj4+IC0tLSAvZGV2L251
bGwNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9idXMvc3RtMzIv
c3Qsc3RtMzItZXR6cGMueWFtbA0KPj4gQEAgLTAsMCArMSw0NiBAQA0KPj4gKyMgU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IChHUEwtMi4wIE9SIEJTRC0yLUNsYXVzZSkNCj4+ICslWUFNTCAxLjIN
Cj4+ICstLS0NCj4+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2J1cy9zdG0z
Mi9zdCxzdG0zMi1ldHpwYy55YW1sIw0KPj4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9y
Zy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPj4gKw0KPj4gK3RpdGxlOiBTVE0zMiBFeHRlbmRl
ZCBUcnVzdFpvbmUgUHJvdGVjdGlvbiBjb250cm9sbGVyDQo+PiArDQo+PiArbWFpbnRhaW5lcnM6
DQo+PiArICAtIEJlbmphbWluIEdhaWduYXJkIDxiZW5qYW1pbi5nYWlnbmFyZEBzdC5jb20+DQo+
PiArDQo+PiArZGVzY3JpcHRpb246IFNUTWljcm9lbGVjdHJvbmljcydzIFNUTTMyIGZpcmV3YWxs
IGJ1cyBjb250cm9sbGVyIGltcGxlbWVudGF0aW9uDQo+PiArDQo+PiArYWxsT2Y6DQo+PiArICAt
ICRyZWY6ICJmaXJld2FsbC1wcm92aWRlci55YW1sIyINCj4+ICsgIC0gJHJlZjogL3NjaGVtYXMv
c2ltcGxlLWJ1cy55YW1sIw0KPiBZb3VyIGJ1cyBoYXMgY29udHJvbHMvc2V0dXAsIGl0J3Mgbm90
IGEgc2ltcGxlLWJ1cy4NCj4NCj4gRG8geW91IGV4cGVjdCBhbiBvbGQga2VybmVsIG9yIG9uZSB3
aXRoIHN1cHBvcnQgZm9yICJzdCxzdG0zMi1ldHpwYy1idXMiDQo+IGRpc2FibGVkIHRvIHdvcms/
IEhvdydzIGl0IGdvaW5nIHRvIGtub3cgaWYgY2VydGFpbiBub2RlcyBjYW4ndCBiZQ0KPiBhY2Nl
c3NlZCB3aXRob3V0IHRoYXQgc3VwcG9ydD8NCkl0IGFscmVhZHkgd29ya3Mgd2l0aCBzaW1wbGUg
YnVzLg0KVGhlIGdvYWwgYmVoaW5kIGltcGxlbWVudGluZyBmaXJld2FsbCBidXMgY29udHJvbGxl
cnMgaXMgdG8gZXhwb3NlIHRoaXMgDQppbiB0aGUgRFQNCnJhdGhlciB0aGFuIGhpZGUgaXQgaW4g
dGhlIGJvb3Qgc3RhZ2VzLg0KDQo+DQo+PiArDQo+PiArcHJvcGVydGllczoNCj4+ICsgIGNvbXBh
dGlibGU6DQo+PiArICAgIGNvbnRhaW5zOg0KPj4gKyAgICAgIGVudW06DQo+PiArICAgICAgICAt
IHN0LHN0bTMyLWV0enBjLWJ1cw0KPj4gKw0KPj4gKyAgcmVnOg0KPj4gKyAgIG1heEl0ZW1zOiAx
DQo+PiArDQo+PiArICAnI2ZpcmV3YWxsLWNlbGxzJzoNCj4+ICsgICAgY29uc3Q6IDINCj4+ICsN
Cj4+ICtyZXF1aXJlZDoNCj4+ICsgIC0gY29tcGF0aWJsZQ0KPj4gKyAgLSByZWcNCj4+ICsgIC0g
JyNmaXJld2FsbC1jZWxscycNCj4+ICsNCj4+ICtleGFtcGxlczoNCj4+ICsgIC0gfA0KPj4gKyAg
ICBzb2NANWMwMDcwMDAgew0KPj4gKyAgICAgIGNvbXBhdGlibGUgPSAic3Qsc3RtMzItZXR6cGMt
YnVzIiwgInNpbXBsZS1idXMiOw0KPj4gKyAgICAgIHJlZyA9IDwweDVjMDA3MDAwIDB4NDAwPjsN
Cj4+ICsgICAgICAjZmlyZXdhbGwtY2VsbHMgPSA8Mj47DQo+PiArICAgICAgI2FkZHJlc3MtY2Vs
bHMgPSA8MT47DQo+PiArICAgICAgI3NpemUtY2VsbHMgPSA8MT47DQo+PiArICAgICAgcmFuZ2Vz
Ow0KPj4gKyAgICB9Ow0KPj4gKw0KPj4gKy4uLg0KPj4gLS0gDQo+PiAyLjE1LjANCj4+DQo=
