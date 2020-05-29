Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61893C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41A3B20776
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="q0oGSqWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgE2PqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 11:46:14 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:39766 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726970AbgE2PqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 11:46:14 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04TFbsGw004565;
        Fri, 29 May 2020 17:45:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=MUqHOgczk7YoJhh076iqGU09+X0d5LSpCvIgcaIw6hU=;
 b=q0oGSqWCvjiL3B4zk68Matq7A+gu2efgaP+G8uXEWnPc9o93OqEZ1vtb4usPssjrtLVn
 3meynMM4VDckBEJXGrXxCWOlCCKGk5K1EZVzmfTIx6kHKYlqVkJe73c3V50QYhqWquCE
 rutWC0WF5G+S/sDfzfx7nedXU0esELuaNrx5OigSCARnKYp1uhBUh2v/dCQVHaeY0e/F
 bwLlh6ThmCAdDee8QwGDK7BrpFTZV2a6MUMukwAJSChKy0RfewWwop5Cklp4Jam8y8YA
 psmO5/z8OTrHe6lPz4UFItkpbhQC0zvpagrl6lH8jYu2gtaF3dCsvNgSm+TN/JfVuwwu bg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 316tqhhpwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 May 2020 17:45:48 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 48A0E100034;
        Fri, 29 May 2020 17:45:45 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DFC542B1893;
        Fri, 29 May 2020 17:45:44 +0200 (CEST)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 29 May
 2020 17:45:44 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1473.003; Fri, 29 May 2020 17:45:44 +0200
From:   Philippe CORNU <philippe.cornu@st.com>
To:     Adrian Ratiu <adrian.ratiu@collabora.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
CC:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Heiko Stuebner <heiko@sntech.de>,
        Adrian Pop <pop.adrian61@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: Re: [Linux-stm32] [PATCH v8 08/10] drm: stm: dw-mipi-dsi: let the
 bridge handle the HW version check
Thread-Topic: [Linux-stm32] [PATCH v8 08/10] drm: stm: dw-mipi-dsi: let the
 bridge handle the HW version check
Thread-Index: AQHWNdA2P+mlUH/UMUatFbM8/3eWsg==
Date:   Fri, 29 May 2020 15:45:44 +0000
Message-ID: <4acc09e8-0610-01f6-b18d-3ffc390c45a3@st.com>
References: <20200427081952.3536741-1-adrian.ratiu@collabora.com>
 <20200427081952.3536741-9-adrian.ratiu@collabora.com>
In-Reply-To: <20200427081952.3536741-9-adrian.ratiu@collabora.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB516333C6BA834A9DE9BB87A8FFBD44@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-29_08:2020-05-28,2020-05-29 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWRyaWFuLA0KYW5kIHRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHRoZSBwYXRjaHNldC4NClRo
YW5rIHlvdSBhbHNvIGZvciBoYXZpbmcgdGVzdGVkIGl0IG9uIFNUTTMyRjc2OSBhbmQgU1RNMzJN
UDEuDQpTb3JyeSBmb3IgdGhlIGxhdGUgcmVzcG9uc2UsIFlhbm5pY2sgYW5kIEkgd2lsbCByZXZp
ZXcgaXQgYXMgc29vbiBhcyANCnBvc3NpYmxlIGFuZCB3ZSB3aWxsIGtlZXAgeW91IHBvc3RlZC4N
Ck5vdGU6IERvIG5vdCBoZXNpdGF0ZSB0byBwdXQgdXMgaW4gY29weSBmb3IgdGhlIG5leHQgdmVy
c2lvbiANCihwaGlsaXBwZS5jb3JudUBzdC5jb20sIHlhbm5pY2suZmVydHJlQHN0LmNvbSkNClJl
Z2FyZHMsDQpQaGlsaXBwZSA6LSkNCg0KDQpPbiA0LzI3LzIwIDEwOjE5IEFNLCBBZHJpYW4gUmF0
aXUgd3JvdGU6DQo+IFRoZSBzdG0gbWlwaS1kc2kgcGxhdGZvcm0gZHJpdmVyIGFkZGVkIGEgdmVy
c2lvbiB0ZXN0IGluDQo+IGNvbW1pdCBmYTYyNTFhNzQ3YjcgKCJkcm0vc3RtOiBkc2k6IGNoZWNr
IGhhcmR3YXJlIHZlcnNpb24iKQ0KPiBzbyB0aGF0IEhXIHJldmlzaW9ucyBvdGhlciB0aGFuIHYx
LjN4IGdldCByZWplY3RlZC4gVGhlIHJvY2tjaGlwDQo+IGRyaXZlciBoYWQgbm8gc3VjaCBjaGVj
ayBhbmQganVzdCBhc3N1bWVkIHJlZ2lzdGVyIGxheW91dHMgYXJlDQo+IHYxLjN4IGNvbXBhdGli
bGUuDQo+IA0KPiBIYXZpbmcgc3VjaCB0ZXN0cyB3YXMgYSBnb29kIGlkZWEgYmVjYXVzZSBvbmx5
IHYxMzAvdjEzMSBsYXlvdXRzDQo+IHdlcmUgc3VwcG9ydGVkIGF0IHRoZSB0aW1lLCBob3dldmVy
IHNpbmNlIGFkZGluZyBtdWx0aXBsZSBsYXlvdXQNCj4gc3VwcG9ydCBpbiB0aGUgYnJpZGdlLCB0
aGUgdmVyc2lvbiBpcyBhdXRvbWF0aWNhbGx5IGNoZWNrZWQgZm9yDQo+IGFsbCBkcml2ZXJzLCBj
b21wYXRpYmxlIGxheW91dHMgZ2V0IHBpY2tlZCBhbmQgdW5zdXBwb3J0ZWQgSFcgaXMNCj4gYXV0
b21hdGljYWxseSByZWplY3RlZCBieSB0aGUgYnJpZGdlLCBzbyB0aGVyZSdzIG5vIHVzZSBrZWVw
aW5nDQo+IHRoZSB0ZXN0IGluIHRoZSBzdG0gZHJpdmVyLg0KPiANCj4gVGhlIG1haW4gcmVhc29u
IHByb21wdGluZyB0aGlzIGNoYW5nZSBpcyB0aGF0IHRoZSBzdG0gZHJpdmVyDQo+IHRlc3QgaW1t
ZWRpYXRlbHkgZGlzYWJsZWQgdGhlIHBlcmlwaGVyYWwgY2xvY2sgYWZ0ZXIgcmVhZGluZw0KPiB0
aGUgdmVyc2lvbiwgbWFraW5nIHRoZSBicmlkZ2UgcmVhZCB2ZXJzaW9uIDB4MCBpbW1lZGlhdGVs
eQ0KPiBhZnRlciBpbiBpdHMgb3duIHByb2JlKCksIHNvIHdlIG1vdmUgdGhlIGNsb2NrIGRpc2Fi
bGluZyBhZnRlcg0KPiB0aGUgYnJpZGdlIGRvZXMgdGhlIHZlcnNpb24gdGVzdC4NCj4gDQo+IFRl
c3RlZCBvbiBTVE0zMkY3NjkgYW5kIFNUTTMyTVAxLg0KPiANCj4gQ2M6IGxpbnV4LXN0bTMyQHN0
LW1kLW1haWxtYW4uc3Rvcm1yZXBseS5jb20NCj4gUmVwb3J0ZWQtYnk6IEFkcmlhbiBQb3AgPHBv
cC5hZHJpYW42MUBnbWFpbC5jb20+DQo+IFRlc3RlZC1ieTogQWRyaWFuIFBvcCA8cG9wLmFkcmlh
bjYxQGdtYWlsLmNvbT4NCj4gVGVzdGVkLWJ5OiBBcm5hdWQgRmVycmFyaXMgPGFybmF1ZC5mZXJy
YXJpc0Bjb2xsYWJvcmEuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBBZHJpYW4gUmF0aXUgPGFkcmlh
bi5yYXRpdUBjb2xsYWJvcmEuY29tPg0KPiAtLS0NCj4gTmV3IGluIHY2Lg0KPiAtLS0NCj4gICBk
cml2ZXJzL2dwdS9kcm0vc3RtL2R3X21pcGlfZHNpLXN0bS5jIHwgMTIgKysrLS0tLS0tLS0tDQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vc3RtL2R3X21pcGlfZHNpLXN0bS5jIGIvZHJp
dmVycy9ncHUvZHJtL3N0bS9kd19taXBpX2RzaS1zdG0uYw0KPiBpbmRleCAyZTFmMjY2NDQ5NWQw
Li43MjE4ZTQwNWQ3ZTJiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vc3RtL2R3X21p
cGlfZHNpLXN0bS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9zdG0vZHdfbWlwaV9kc2ktc3Rt
LmMNCj4gQEAgLTQwMiwxNSArNDAyLDYgQEAgc3RhdGljIGludCBkd19taXBpX2RzaV9zdG1fcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gICAJCWdvdG8gZXJyX2RzaV9wcm9i
ZTsNCj4gICAJfQ0KPiAgIA0KPiAtCWRzaS0+aHdfdmVyc2lvbiA9IGRzaV9yZWFkKGRzaSwgRFNJ
X1ZFUlNJT04pICYgVkVSU0lPTjsNCj4gLQljbGtfZGlzYWJsZV91bnByZXBhcmUocGNsayk7DQo+
IC0NCj4gLQlpZiAoZHNpLT5od192ZXJzaW9uICE9IEhXVkVSXzEzMCAmJiBkc2ktPmh3X3ZlcnNp
b24gIT0gSFdWRVJfMTMxKSB7DQo+IC0JCXJldCA9IC1FTk9ERVY7DQo+IC0JCURSTV9FUlJPUigi
YmFkIGRzaSBoYXJkd2FyZSB2ZXJzaW9uXG4iKTsNCj4gLQkJZ290byBlcnJfZHNpX3Byb2JlOw0K
PiAtCX0NCj4gLQ0KPiAgIAlkd19taXBpX2RzaV9zdG1fcGxhdF9kYXRhLmJhc2UgPSBkc2ktPmJh
c2U7DQo+ICAgCWR3X21pcGlfZHNpX3N0bV9wbGF0X2RhdGEucHJpdl9kYXRhID0gZHNpOw0KPiAg
IA0KPiBAQCAtNDIzLDYgKzQxNCw5IEBAIHN0YXRpYyBpbnQgZHdfbWlwaV9kc2lfc3RtX3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAgCQlnb3RvIGVycl9kc2lfcHJvYmU7
DQo+ICAgCX0NCj4gICANCj4gKwlkc2ktPmh3X3ZlcnNpb24gPSBkc2lfcmVhZChkc2ksIERTSV9W
RVJTSU9OKSAmIFZFUlNJT047DQo+ICsJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKHBjbGspOw0KPiAr
DQo+ICAgCXJldHVybiAwOw0KPiAgIA0KPiAgIGVycl9kc2lfcHJvYmU6DQo+IA==
