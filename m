Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267BDC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D4424655
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="kwE+guB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbgAWJsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 04:48:41 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22828 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726103AbgAWJsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 04:48:40 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00N9mC54013055;
        Thu, 23 Jan 2020 10:48:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=5SeB8s9x5wreO4d7oXmbLoQrU983LvSqPs1ieUjIzyc=;
 b=kwE+guB4L+TVQrsvECuZKE3pAe4MDcMpp91Cq7pFu6eBCAOy503dDk9w9cH0KIK6vL5X
 61EQIPLI0+LTzvLPlbCnp+TO5qjB1ojfB+eRhw4SQCU/ZuGLdCB7X1YfcGLTg/EsiNz5
 nlOjb3aB8I9Kz6P6xxv+3WTz85bcdneeP9LZqAX994RT+OoDxEuU2Ay9c2IUMTuG7Dgk
 SqtnoRHt72jALZaUqv9lX8ubtifxrwc8iHAJpZw4iy51Ln5sdvedYIVA+FzDFXY01zvZ
 7Xxqx5eKRM81VMnrLGYD9SMaaoyLWQSSWkRjTxQhVeZMIwBXJCh8PKn73dMR1BDgf4i+ 7g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xkr1e9h4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jan 2020 10:48:31 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CA5F110002A;
        Thu, 23 Jan 2020 10:48:30 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BCFF421FEBE;
        Thu, 23 Jan 2020 10:48:30 +0100 (CET)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 23 Jan
 2020 10:48:30 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1473.003; Thu, 23 Jan 2020 10:48:30 +0100
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
Subject: Re: [PATCH] drm/stm: ltdc: add number of interrupts
Thread-Topic: [PATCH] drm/stm: ltdc: add number of interrupts
Thread-Index: AQHV0EN8f8iUffIhZ0Oxt7cntisoXKf38z2A
Date:   Thu, 23 Jan 2020 09:48:30 +0000
Message-ID: <2b967bed-c2fa-1575-3e06-ae5b19069e56@st.com>
References: <1579601632-7001-1-git-send-email-yannick.fertre@st.com>
In-Reply-To: <1579601632-7001-1-git-send-email-yannick.fertre@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D570B8DBE1872C4E9FC6288AD5D884E0@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-23_01:2020-01-23,2020-01-22 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBZYW5uaWNrLA0KVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLA0KDQpBY2tlZC1ieTogUGhp
bGlwcGUgQ29ybnUgPHBoaWxpcHBlLmNvcm51QHN0LmNvbT4NCg0KUGhpbGlwcGUgOi0pDQoNCk9u
IDEvMjEvMjAgMTE6MTMgQU0sIFlhbm5pY2sgRmVydHJlIHdyb3RlOg0KPiBUaGUgbnVtYmVyIG9m
IGludGVycnVwdHMgZGVwZW5kcyBvbiB0aGUgbHRkYyB2ZXJzaW9uLg0KPiBEb24ndCB0cnkgdG8g
Z2V0IGludGVycnVwdCB3aGljaCBub3QgZXhpc3QsIGF2b2lkaW5nDQo+IGtlcm5lbCB3YXJuaW5n
IG1lc3NhZ2VzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWWFubmljayBGZXJ0cmUgPHlhbm5pY2su
ZmVydHJlQHN0LmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL3N0bS9sdGRjLmMgfCAz
MCArKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vc3Rt
L2x0ZGMuaCB8ICAxICsNCj4gICAyIGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDE1
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9zdG0vbHRk
Yy5jIGIvZHJpdmVycy9ncHUvZHJtL3N0bS9sdGRjLmMNCj4gaW5kZXggYzI4MTVlOC4uNTgwOTJi
MCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3N0bS9sdGRjLmMNCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL3N0bS9sdGRjLmMNCj4gQEAgLTExNDYsMTIgKzExNDYsMTQgQEAgc3RhdGlj
IGludCBsdGRjX2dldF9jYXBzKHN0cnVjdCBkcm1fZGV2aWNlICpkZGV2KQ0KPiAgIAkJbGRldi0+
Y2Fwcy5wYWRfbWF4X2ZyZXFfaHogPSA5MDAwMDAwMDsNCj4gICAJCWlmIChsZGV2LT5jYXBzLmh3
X3ZlcnNpb24gPT0gSFdWRVJfMTAyMDApDQo+ICAgCQkJbGRldi0+Y2Fwcy5wYWRfbWF4X2ZyZXFf
aHogPSA2NTAwMDAwMDsNCj4gKwkJbGRldi0+Y2Fwcy5uYl9pcnEgPSAyOw0KPiAgIAkJYnJlYWs7
DQo+ICAgCWNhc2UgSFdWRVJfMjAxMDE6DQo+ICAgCQlsZGV2LT5jYXBzLnJlZ19vZnMgPSBSRUdf
T0ZTXzQ7DQo+ICAgCQlsZGV2LT5jYXBzLnBpeF9mbXRfaHcgPSBsdGRjX3BpeF9mbXRfYTE7DQo+
ICAgCQlsZGV2LT5jYXBzLm5vbl9hbHBoYV9vbmx5X2wxID0gZmFsc2U7DQo+ICAgCQlsZGV2LT5j
YXBzLnBhZF9tYXhfZnJlcV9oeiA9IDE1MDAwMDAwMDsNCj4gKwkJbGRldi0+Y2Fwcy5uYl9pcnEg
PSA0Ow0KPiAgIAkJYnJlYWs7DQo+ICAgCWRlZmF1bHQ6DQo+ICAgCQlyZXR1cm4gLUVOT0RFVjsN
Cj4gQEAgLTEyNTEsMTMgKzEyNTMsMjEgQEAgaW50IGx0ZGNfbG9hZChzdHJ1Y3QgZHJtX2Rldmlj
ZSAqZGRldikNCj4gICAJcmVnX2NsZWFyKGxkZXYtPnJlZ3MsIExURENfSUVSLA0KPiAgIAkJICBJ
RVJfTElFIHwgSUVSX1JSSUUgfCBJRVJfRlVJRSB8IElFUl9URVJSSUUpOw0KPiAgIA0KPiAtCWZv
ciAoaSA9IDA7IGkgPCBNQVhfSVJROyBpKyspIHsNCj4gKwlyZXQgPSBsdGRjX2dldF9jYXBzKGRk
ZXYpOw0KPiArCWlmIChyZXQpIHsNCj4gKwkJRFJNX0VSUk9SKCJoYXJkd2FyZSBpZGVudGlmaWVy
ICgweCUwOHgpIG5vdCBzdXBwb3J0ZWQhXG4iLA0KPiArCQkJICBsZGV2LT5jYXBzLmh3X3ZlcnNp
b24pOw0KPiArCQlnb3RvIGVycjsNCj4gKwl9DQo+ICsNCj4gKwlEUk1fREVCVUdfRFJJVkVSKCJs
dGRjIGh3IHZlcnNpb24gMHglMDh4XG4iLCBsZGV2LT5jYXBzLmh3X3ZlcnNpb24pOw0KPiArDQo+
ICsJZm9yIChpID0gMDsgaSA8IGxkZXYtPmNhcHMubmJfaXJxOyBpKyspIHsNCj4gICAJCWlycSA9
IHBsYXRmb3JtX2dldF9pcnEocGRldiwgaSk7DQo+IC0JCWlmIChpcnEgPT0gLUVQUk9CRV9ERUZF
UikNCj4gKwkJaWYgKGlycSA8IDApIHsNCj4gKwkJCXJldCA9IGlycTsNCj4gICAJCQlnb3RvIGVy
cjsNCj4gLQ0KPiAtCQlpZiAoaXJxIDwgMCkNCj4gLQkJCWNvbnRpbnVlOw0KPiArCQl9DQo+ICAg
DQo+ICAgCQlyZXQgPSBkZXZtX3JlcXVlc3RfdGhyZWFkZWRfaXJxKGRldiwgaXJxLCBsdGRjX2ly
cSwNCj4gICAJCQkJCQlsdGRjX2lycV90aHJlYWQsIElSUUZfT05FU0hPVCwNCj4gQEAgLTEyNjgs
MTYgKzEyNzgsNiBAQCBpbnQgbHRkY19sb2FkKHN0cnVjdCBkcm1fZGV2aWNlICpkZGV2KQ0KPiAg
IAkJfQ0KPiAgIAl9DQo+ICAgDQo+IC0NCj4gLQlyZXQgPSBsdGRjX2dldF9jYXBzKGRkZXYpOw0K
PiAtCWlmIChyZXQpIHsNCj4gLQkJRFJNX0VSUk9SKCJoYXJkd2FyZSBpZGVudGlmaWVyICgweCUw
OHgpIG5vdCBzdXBwb3J0ZWQhXG4iLA0KPiAtCQkJICBsZGV2LT5jYXBzLmh3X3ZlcnNpb24pOw0K
PiAtCQlnb3RvIGVycjsNCj4gLQl9DQo+IC0NCj4gLQlEUk1fREVCVUdfRFJJVkVSKCJsdGRjIGh3
IHZlcnNpb24gMHglMDh4XG4iLCBsZGV2LT5jYXBzLmh3X3ZlcnNpb24pOw0KPiAtDQo+ICAgCS8q
IEFkZCBlbmRwb2ludHMgcGFuZWxzIG9yIGJyaWRnZXMgaWYgYW55ICovDQo+ICAgCWZvciAoaSA9
IDA7IGkgPCBNQVhfRU5EUE9JTlRTOyBpKyspIHsNCj4gICAJCWlmIChwYW5lbFtpXSkgew0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3N0bS9sdGRjLmggYi9kcml2ZXJzL2dwdS9kcm0v
c3RtL2x0ZGMuaA0KPiBpbmRleCBhMWFkMGFlLi4zMTBlODdmIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vc3RtL2x0ZGMuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vc3RtL2x0ZGMu
aA0KPiBAQCAtMTksNiArMTksNyBAQCBzdHJ1Y3QgbHRkY19jYXBzIHsNCj4gICAJY29uc3QgdTMy
ICpwaXhfZm10X2h3OwkvKiBzdXBwb3J0ZWQgcGl4ZWwgZm9ybWF0cyAqLw0KPiAgIAlib29sIG5v
bl9hbHBoYV9vbmx5X2wxOyAvKiBub24tbmF0aXZlIG5vLWFscGhhIGZvcm1hdHMgb24gbGF5ZXIg
MSAqLw0KPiAgIAlpbnQgcGFkX21heF9mcmVxX2h6OwkvKiBtYXggZnJlcXVlbmN5IHN1cHBvcnRl
ZCBieSBwYWQgKi8NCj4gKwlpbnQgbmJfaXJxOwkJLyogbnVtYmVyIG9mIGhhcmR3YXJlIGludGVy
cnVwdHMgKi8NCj4gICB9Ow0KPiAgIA0KPiAgICNkZWZpbmUgTFREQ19NQVhfTEFZRVIJNA0KPiA=
