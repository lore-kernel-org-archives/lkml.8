Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B668C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36AF620772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="PDOJ8M5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbgGBMS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 08:18:58 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52294 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728719AbgGBMS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:18:56 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 062CF0Xf002765;
        Thu, 2 Jul 2020 14:18:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=ApHQVP3ut9KFHFGKREMuERST8R+KVi3zooiVAiRvOS0=;
 b=PDOJ8M5cQFdcAqiECihaBjSye2+EZjphHUCP0BlFaPeZ79vxyTgV+abZvJumZ6Ez0S29
 miHh8S7TlWYhJJFhg+1Ob5Bi9he3ok/FnBrQsIygzAVYGVvmbZw5ThypbCfXotwsjC7s
 t6t8zrYg/TmcbPWXx588S3zCMKJc+Y2TI3wWg79XtEgMH71nSYXdEULTubjWfu7lcW0T
 PMGqOX8STyZ46REko1j934IT/mP0aCBbCfAT5Zhp5PK6Pmupgl/1Ipy9EAJY1czYRT17
 Jy5XsCdK7DSVpgII860QFLo66glLk+1ifaX1+n7LhFzNW1kL1kZBcrG+yLibl72tKk/H yw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31ww0gg08e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jul 2020 14:18:48 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B71A310002A;
        Thu,  2 Jul 2020 14:18:47 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 994A82B1888;
        Thu,  2 Jul 2020 14:18:47 +0200 (CEST)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 2 Jul
 2020 14:18:47 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1473.003; Thu, 2 Jul 2020 14:18:46 +0200
From:   Philippe CORNU <philippe.cornu@st.com>
To:     Yannick FERTRE <yannick.fertre@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre TORGUE" <alexandre.torgue@st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/stm: ltdc: remove call of pm-runtime functions
Thread-Topic: [PATCH] drm/stm: ltdc: remove call of pm-runtime functions
Thread-Index: AQHWT5+4ILeimEtCa0WCtAriQBB35Kj0FRcA
Date:   Thu, 2 Jul 2020 12:18:46 +0000
Message-ID: <3b6e02b8-0f54-4eb0-9728-b304a1aa85d5@st.com>
References: <20200701120402.6444-1-yannick.fertre@st.com>
In-Reply-To: <20200701120402.6444-1-yannick.fertre@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <511E233C1CF6BF4C9507F21CE354F452@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-02_05:2020-07-02,2020-07-02 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDcvMS8yMCAyOjA0IFBNLCBZYW5uaWNrIEZlcnRyZSB3cm90ZToNCj4gSXQgaXMgbm90
IG5lY2Vzc2FyeSB0byBzdXNwZW5kIG9yIHN0b3AgdGhlIGx0ZGMgY2xvY2tzDQo+IHRvIG1vZGlm
eSB0aGUgcGl4ZWwgY2xvY2suDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZYW5uaWNrIEZlcnRyZSA8
eWFubmljay5mZXJ0cmVAc3QuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vc3RtL2x0
ZGMuYyB8IDE2IC0tLS0tLS0tLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMTYgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3N0bS9sdGRjLmMgYi9k
cml2ZXJzL2dwdS9kcm0vc3RtL2x0ZGMuYw0KPiBpbmRleCAzZjU5MGQ5MTZlOTEuLjZlMjhmNzA3
MDkyZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3N0bS9sdGRjLmMNCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL3N0bS9sdGRjLmMNCj4gQEAgLTUwNiwxNSArNTA2LDcgQEAgc3RhdGlj
IGJvb2wgbHRkY19jcnRjX21vZGVfZml4dXAoc3RydWN0IGRybV9jcnRjICpjcnRjLA0KPiAgIAkJ
CQkgc3RydWN0IGRybV9kaXNwbGF5X21vZGUgKmFkanVzdGVkX21vZGUpDQo+ICAgew0KPiAgIAlz
dHJ1Y3QgbHRkY19kZXZpY2UgKmxkZXYgPSBjcnRjX3RvX2x0ZGMoY3J0Yyk7DQo+IC0Jc3RydWN0
IGRybV9kZXZpY2UgKmRkZXYgPSBjcnRjLT5kZXY7DQo+ICAgCWludCByYXRlID0gbW9kZS0+Y2xv
Y2sgKiAxMDAwOw0KPiAtCWJvb2wgcnVudGltZV9hY3RpdmU7DQo+IC0JaW50IHJldDsNCj4gLQ0K
PiAtCXJ1bnRpbWVfYWN0aXZlID0gcG1fcnVudGltZV9hY3RpdmUoZGRldi0+ZGV2KTsNCj4gLQ0K
PiAtCWlmIChydW50aW1lX2FjdGl2ZSkNCj4gLQkJcG1fcnVudGltZV9wdXRfc3luYyhkZGV2LT5k
ZXYpOw0KPiAgIA0KPiAgIAlpZiAoY2xrX3NldF9yYXRlKGxkZXYtPnBpeGVsX2NsaywgcmF0ZSkg
PCAwKSB7DQo+ICAgCQlEUk1fRVJST1IoIkNhbm5vdCBzZXQgcmF0ZSAoJWRIeikgZm9yIHBpeGVs
IGNsa1xuIiwgcmF0ZSk7DQo+IEBAIC01MjMsMTQgKzUxNSw2IEBAIHN0YXRpYyBib29sIGx0ZGNf
Y3J0Y19tb2RlX2ZpeHVwKHN0cnVjdCBkcm1fY3J0YyAqY3J0YywNCj4gICANCj4gICAJYWRqdXN0
ZWRfbW9kZS0+Y2xvY2sgPSBjbGtfZ2V0X3JhdGUobGRldi0+cGl4ZWxfY2xrKSAvIDEwMDA7DQo+
ICAgDQo+IC0JaWYgKHJ1bnRpbWVfYWN0aXZlKSB7DQo+IC0JCXJldCA9IHBtX3J1bnRpbWVfZ2V0
X3N5bmMoZGRldi0+ZGV2KTsNCj4gLQkJaWYgKHJldCkgew0KPiAtCQkJRFJNX0VSUk9SKCJGYWls
ZWQgdG8gZml4dXAgbW9kZSwgY2Fubm90IGdldCBzeW5jXG4iKTsNCj4gLQkJCXJldHVybiBmYWxz
ZTsNCj4gLQkJfQ0KPiAtCX0NCj4gLQ0KPiAgIAlEUk1fREVCVUdfRFJJVkVSKCJyZXF1ZXN0ZWQg
Y2xvY2sgJWRrSHosIGFkanVzdGVkIGNsb2NrICVka0h6XG4iLA0KPiAgIAkJCSBtb2RlLT5jbG9j
aywgYWRqdXN0ZWRfbW9kZS0+Y2xvY2spOw0KPiAgIA0KPiANCkhpIFlhbm5pY2ssDQpNYW55IHRo
YW5rcyBmb3IgeW91ciBwYXRjaCwNCkFja2VkLWJ5OiBQaGlsaXBwZSBDb3JudSA8cGhpbGlwcGUu
Y29ybnVAc3QuY29tPg0KUGhpbGlwcGUgOi0p
