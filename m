Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA3FC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2F5C221E5
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="CNlsHBhS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgIKI3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 04:29:54 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:1229 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725613AbgIKI3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 04:29:51 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08B8S3D7001767;
        Fri, 11 Sep 2020 10:29:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=NPQB3mzG+KC4r8q2wcOs8xMlMzwaex4jb/8qkinpIxc=;
 b=CNlsHBhSyGwnpGkj2SWWaXCRpwaUROtYzB2TT9dBHLqDdA+JZFHivlYm0ThANbnpaEMT
 74Dy7lamZNKG42XyNUEYz9PRy3qmU1tQZyXTnEhe1+9bWvndHfrbO5SD+01lBy1RSFG4
 6YAMCz65sqM4uExpu2EivULV+jvgb4OhLQKTSecSDeMLn3GQT0BSJPlCf4FRSwTZPopO
 Dv4zwUKvS88IhUuOc7UNmVvS+LmkcY0OLm2HZ5ev13N66+V9vvRRQHc/cYVz7TjifNSK
 IwjoQluegbaufQzOyZYvIvBG3qOwM5BcIDXzLsprZn3ssMDVT359J++omDTbhk1UFtuL XA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 33byt88mek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Sep 2020 10:29:30 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CF67310002A;
        Fri, 11 Sep 2020 10:29:27 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BA60321E26A;
        Fri, 11 Sep 2020 10:29:27 +0200 (CEST)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 11 Sep
 2020 10:29:27 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1473.003; Fri, 11 Sep 2020 10:29:27 +0200
From:   Philippe CORNU <philippe.cornu@st.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "jonas@kwiboo.se" <jonas@kwiboo.se>,
        "jernej.skrabec@siol.net" <jernej.skrabec@siol.net>
CC:     "heiko.stuebner@theobroma-systems.com" 
        <heiko.stuebner@theobroma-systems.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Yannick FERTRE <yannick.fertre@st.com>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>
Subject: Re: [PATCH] drm/bridge: dw-mipi-dsi: permit configuring the escape
 clock rate
Thread-Topic: [PATCH] drm/bridge: dw-mipi-dsi: permit configuring the escape
 clock rate
Thread-Index: AQHWgrq0GnmfCHcy9EO3+U4LDjE6p6ljBFQA
Date:   Fri, 11 Sep 2020 08:29:27 +0000
Message-ID: <078aae69-936f-cb78-623f-6bdcb1c2630d@st.com>
References: <20200904125531.15248-1-narmstrong@baylibre.com>
In-Reply-To: <20200904125531.15248-1-narmstrong@baylibre.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C82391012D30F14E973A5E5130F2B86A@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-11_02:2020-09-10,2020-09-11 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDkvNC8yMCAyOjU1IFBNLCBOZWlsIEFybXN0cm9uZyB3cm90ZToNCj4gVGhlIEFtbG9n
aWMgRC1QSFkgaW4gdGhlIEFtbG9naWMgQVhHIFNvQyBGYW1pbHkgZG9lcyBzdXBwb3J0IGEgZnJl
cXVlbmN5DQo+IGhpZ2hlciB0aGFuIDEwTUh6IGZvciB0aGUgVFggRXNjYXBlIENsb2NrLCB0aHVz
IG1ha2UgdGhlIHRhcmdldCByYXRlDQo+IGNvbmZpZ3VyYWJsZS4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IE5laWwgQXJtc3Ryb25nIDxuYXJtc3Ryb25nQGJheWxpYnJlLmNvbT4NCj4gLS0tDQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9zeW5vcHN5cy9kdy1taXBpLWRzaS5jIHwgMjUgKysrKysr
KysrKysrKysrLS0tLQ0KPiAgIGluY2x1ZGUvZHJtL2JyaWRnZS9kd19taXBpX2RzaS5oICAgICAg
ICAgICAgICB8ICAxICsNCj4gICAyIGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDUg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9z
eW5vcHN5cy9kdy1taXBpLWRzaS5jIGIvZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9zeW5vcHN5cy9k
dy1taXBpLWRzaS5jDQo+IGluZGV4IGQ1ODBiMmFhNGNlOS4uMzFmYzk2NWM2NmZkIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYnJpZGdlL3N5bm9wc3lzL2R3LW1pcGktZHNpLmMNCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9zeW5vcHN5cy9kdy1taXBpLWRzaS5jDQo+IEBA
IC01NjIsMTUgKzU2MiwzMCBAQCBzdGF0aWMgdm9pZCBkd19taXBpX2RzaV9kaXNhYmxlKHN0cnVj
dCBkd19taXBpX2RzaSAqZHNpKQ0KPiAgIA0KPiAgIHN0YXRpYyB2b2lkIGR3X21pcGlfZHNpX2lu
aXQoc3RydWN0IGR3X21pcGlfZHNpICpkc2kpDQo+ICAgew0KPiArCWNvbnN0IHN0cnVjdCBkd19t
aXBpX2RzaV9waHlfb3BzICpwaHlfb3BzID0gZHNpLT5wbGF0X2RhdGEtPnBoeV9vcHM7DQo+ICsJ
dW5zaWduZWQgaW50IGVzY19yYXRlOyAvKiBpbiBNSHogKi8NCj4gKwl1MzIgZXNjX2Nsa19kaXZp
c2lvbjsNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICAgCS8qDQo+ICAgCSAqIFRoZSBtYXhpbXVtIHBl
cm1pdHRlZCBlc2NhcGUgY2xvY2sgaXMgMjBNSHogYW5kIGl0IGlzIGRlcml2ZWQgZnJvbQ0KPiAt
CSAqIGxhbmVieXRlY2xrLCB3aGljaCBpcyBydW5uaW5nIGF0ICJsYW5lX21icHMgLyA4Ii4gIFRo
dXMgd2Ugd2FudDoNCj4gLQkgKg0KPiAtCSAqICAgICAobGFuZV9tYnBzID4+IDMpIC8gZXNjX2Ns
a19kaXZpc2lvbiA8IDIwDQo+ICsJICogbGFuZWJ5dGVjbGssIHdoaWNoIGlzIHJ1bm5pbmcgYXQg
ImxhbmVfbWJwcyAvIDgiLg0KPiArCSAqLw0KPiArCWlmIChwaHlfb3BzLT5nZXRfZXNjX2Nsa19y
YXRlKSB7DQo+ICsJCXJldCA9IHBoeV9vcHMtPmdldF9lc2NfY2xrX3JhdGUoZHNpLT5wbGF0X2Rh
dGEtPnByaXZfZGF0YSwNCj4gKwkJCQkJCSZlc2NfcmF0ZSk7DQo+ICsJCWlmIChyZXQpDQo+ICsJ
CQlEUk1fREVCVUdfRFJJVkVSKCJQaHkgZ2V0X2VzY19jbGtfcmF0ZSgpIGZhaWxlZFxuIik7DQo+
ICsJfSBlbHNlDQo+ICsJCWVzY19yYXRlID0gMjA7IC8qIERlZmF1bHQgdG8gMjBNSHogKi8NCj4g
Kw0KPiArCS8qDQo+ICsJICogV2Ugd2FudCA6DQo+ICsJICogICAgIChsYW5lX21icHMgPj4gMykg
LyBlc2NfY2xrX2RpdmlzaW9uIDwgWA0KPiAgIAkgKiB3aGljaCBpczoNCj4gLQkgKiAgICAgKGxh
bmVfbWJwcyA+PiAzKSAvIDIwID4gZXNjX2Nsa19kaXZpc2lvbg0KPiArCSAqICAgICAobGFuZV9t
YnBzID4+IDMpIC8gWCA+IGVzY19jbGtfZGl2aXNpb24NCj4gICAJICovDQo+IC0JdTMyIGVzY19j
bGtfZGl2aXNpb24gPSAoZHNpLT5sYW5lX21icHMgPj4gMykgLyAyMCArIDE7DQo+ICsJZXNjX2Ns
a19kaXZpc2lvbiA9IChkc2ktPmxhbmVfbWJwcyA+PiAzKSAvIGVzY19yYXRlICsgMTsNCj4gICAN
Cj4gICAJZHNpX3dyaXRlKGRzaSwgRFNJX1BXUl9VUCwgUkVTRVQpOw0KPiAgIA0KPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9kcm0vYnJpZGdlL2R3X21pcGlfZHNpLmggYi9pbmNsdWRlL2RybS9icmlk
Z2UvZHdfbWlwaV9kc2kuaA0KPiBpbmRleCBiMGUzOTBiMzI4OGUuLmJkYThhYTdjMjI4MCAxMDA2
NDQNCj4gLS0tIGEvaW5jbHVkZS9kcm0vYnJpZGdlL2R3X21pcGlfZHNpLmgNCj4gKysrIGIvaW5j
bHVkZS9kcm0vYnJpZGdlL2R3X21pcGlfZHNpLmgNCj4gQEAgLTM2LDYgKzM2LDcgQEAgc3RydWN0
IGR3X21pcGlfZHNpX3BoeV9vcHMgew0KPiAgIAkJCSAgICAgdW5zaWduZWQgaW50ICpsYW5lX21i
cHMpOw0KPiAgIAlpbnQgKCpnZXRfdGltaW5nKSh2b2lkICpwcml2X2RhdGEsIHVuc2lnbmVkIGlu
dCBsYW5lX21icHMsDQo+ICAgCQkJICBzdHJ1Y3QgZHdfbWlwaV9kc2lfZHBoeV90aW1pbmcgKnRp
bWluZyk7DQo+ICsJaW50ICgqZ2V0X2VzY19jbGtfcmF0ZSkodm9pZCAqcHJpdl9kYXRhLCB1bnNp
Z25lZCBpbnQgKmVzY19jbGtfcmF0ZSk7DQo+ICAgfTsNCj4gICANCj4gICBzdHJ1Y3QgZHdfbWlw
aV9kc2lfaG9zdF9vcHMgew0KPiANCg0KSGkgTmVpbCwNClRoYW5rIHlvdSBmb3IgdGhlIHBhdGNo
DQoNClJldmlld2VkLWJ5OiBQaGlsaXBwZSBDb3JudSA8cGhpbGlwcGUuY29ybnVAc3QuY29tPg0K
DQpQaGlsaXBwZSA6LSk=
