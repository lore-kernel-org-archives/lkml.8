Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A4EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7C12253D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="v5co6l0Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgAWJym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 04:54:42 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:18912 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726792AbgAWJyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 04:54:41 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00N9qYtZ031103;
        Thu, 23 Jan 2020 10:54:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=BECIotAqTZ4curw6tCZp7XoV78IzRZm8xDxenBuoeYg=;
 b=v5co6l0ZT0ja4V444Q2EDiWN48TF9JtopDiyHfdxtgtrK6wKjZXYZWW/tvL8DC/7528h
 ndu/iObcqI+9foqqxMixF8AQG+qqi5GyMICYMGWfmivAldkqC/RJVvRxQ0CvIOy26Cgt
 qjzQO07ievY49x92P3GjLXgcIGewPdkp+cbB5lmymzLasxuZRMIEO3+AgrsZNUfIhP2Y
 z167R2XX6xpRw3y0HAFBv1cV8bGRCVjborvMAF6HWiEa5QW3itXx7E/P5HUgLKQF3Cgd
 DUGEhBKXb/fayv76FNlFbV9aCy6IZrSybiZZL8rtsFvr1UUlR9kyygeUlRFIUs2LMJ9s kA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xkrp2hev9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jan 2020 10:54:32 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E11CD10003D;
        Thu, 23 Jan 2020 10:54:30 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D4C42220303;
        Thu, 23 Jan 2020 10:54:30 +0100 (CET)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 23 Jan
 2020 10:54:30 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1473.003; Thu, 23 Jan 2020 10:54:30 +0100
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
Subject: Re: [PATCH] drm/stm: dsi: stm mipi dsi doesn't print error on probe
 deferral
Thread-Topic: [PATCH] drm/stm: dsi: stm mipi dsi doesn't print error on probe
 deferral
Thread-Index: AQHV0ETplOrB/RayDE+q4WmBGigVhKf39OeA
Date:   Thu, 23 Jan 2020 09:54:30 +0000
Message-ID: <1fd9adf5-873b-2b9d-fe22-278f2ea64746@st.com>
References: <1579602245-7577-1-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1579602245-7577-1-git-send-email-yannick.fertre@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B3A3BD23C9EC140904C34361AB91F6F@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-23_01:2020-01-23,2020-01-22 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhcnMgWWFubmljayAmIEV0aWVubmUsDQpUaGFuayB5b3UgZm9yIHlvdXIgcGF0Y2gsDQoNClJl
dmlld2VkLWJ5OiBQaGlsaXBwZSBDb3JudSA8cGhpbGlwcGUuY29ybnVAc3QuY29tPg0KDQpQaGls
aXBwZSA6LSkNCg0KT24gMS8yMS8yMCAxMToyNCBBTSwgWWFubmljayBGZXJ0cmUgd3JvdGU6DQo+
IEZyb206IEV0aWVubmUgQ2FycmllcmUgPGV0aWVubmUuY2FycmllcmVAc3QuY29tPg0KPiANCj4g
Q2hhbmdlIERTSSBkcml2ZXIgdG8gbm90IHByaW50IGFuIGVycm9yIHRyYWNlIHdoZW4gcHJvYmUN
Cj4gaXMgZGVmZXJyZWQgZm9yIGEgY2xvY2sgcmVzb3VyY2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBFdGllbm5lIENhcnJpZXJlIDxldGllbm5lLmNhcnJpZXJlQHN0LmNvbT4NCj4gLS0tDQo+ICAg
ZHJpdmVycy9ncHUvZHJtL3N0bS9kd19taXBpX2RzaS1zdG0uYyB8IDQgKysrLQ0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vc3RtL2R3X21pcGlfZHNpLXN0bS5jIGIvZHJpdmVycy9ncHUv
ZHJtL3N0bS9kd19taXBpX2RzaS1zdG0uYw0KPiBpbmRleCA0YjE2NTYzLi4yZTFmMjY2IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vc3RtL2R3X21pcGlfZHNpLXN0bS5jDQo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9zdG0vZHdfbWlwaV9kc2ktc3RtLmMNCj4gQEAgLTM3Nyw3ICszNzcs
OSBAQCBzdGF0aWMgaW50IGR3X21pcGlfZHNpX3N0bV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KPiAgIAlkc2ktPnBsbHJlZl9jbGsgPSBkZXZtX2Nsa19nZXQoZGV2LCAicmVm
Iik7DQo+ICAgCWlmIChJU19FUlIoZHNpLT5wbGxyZWZfY2xrKSkgew0KPiAgIAkJcmV0ID0gUFRS
X0VSUihkc2ktPnBsbHJlZl9jbGspOw0KPiAtCQlEUk1fRVJST1IoIlVuYWJsZSB0byBnZXQgcGxs
IHJlZmVyZW5jZSBjbG9jazogJWRcbiIsIHJldCk7DQo+ICsJCWlmIChyZXQgIT0gLUVQUk9CRV9E
RUZFUikNCj4gKwkJCURSTV9FUlJPUigiVW5hYmxlIHRvIGdldCBwbGwgcmVmZXJlbmNlIGNsb2Nr
OiAlZFxuIiwNCj4gKwkJCQkgIHJldCk7DQo+ICAgCQlnb3RvIGVycl9jbGtfZ2V0Ow0KPiAgIAl9
DQo+ICAgDQo+IA==
