Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB29C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D596207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ALie7Y91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgGJIre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 04:47:34 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:35550 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726757AbgGJIrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 04:47:33 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06A8gvMY019342;
        Fri, 10 Jul 2020 10:47:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=hW99NkJO01Cohy8Gf4OtWTFT16GdgjphlWc9M91Ndb0=;
 b=ALie7Y91hIP0v34yBtcNOs7wvwnOIT/72QqC4tHooxspJoBoVHqjFYstbZlmAYuQST+H
 v0iur6QqLKBBOluT/GlS1SIu8Qp2+BNLAtE3tFptVf6/oNP9YI+okSrm2hcZna5vftud
 uoqLyCQNKdkQD6eDSBu90RrnEbcvIARBaBAJZjs8C62sMOSvPBZdyRIsTwb4eCYgsfZ6
 7oTBtyJ6Qclp/6e3mq3T5N6I3kU7Mj2KcohgKvHm9MulOwvby3Sy2fcoFaBh9zVldmLW
 iiiDJQCEXA+2SBJAMNJ9c6zUVcF0XxEKohucHxQCp8EoMHuhhdrbqtOUTvOR7Zmrc0// BQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 325k4d241m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 10:47:24 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E4B7B10002A;
        Fri, 10 Jul 2020 10:47:23 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D9CF72A5AD2;
        Fri, 10 Jul 2020 10:47:23 +0200 (CEST)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 10 Jul
 2020 10:47:23 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1473.003; Fri, 10 Jul 2020 10:47:23 +0200
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Antonio BORNEO <antonio.borneo@st.com>
Subject: Re: [PATCH] drm/bridge/synopsys: dsi: add support for non-continuous
 HS clock
Thread-Topic: [PATCH] drm/bridge/synopsys: dsi: add support for non-continuous
 HS clock
Thread-Index: AQHWT9/Fw6NgLa8gK02Mjd/7Q+XhP6kAbC6A
Date:   Fri, 10 Jul 2020 08:47:23 +0000
Message-ID: <8036e047-15c6-d259-66c2-c7f625faf759@st.com>
References: <20200701194234.18123-1-yannick.fertre@st.com>
In-Reply-To: <20200701194234.18123-1-yannick.fertre@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC00A6D55CBAED45991E6F0B1D92078E@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-10_02:2020-07-10,2020-07-10 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDcvMS8yMCA5OjQyIFBNLCBZYW5uaWNrIEZlcnRyZSB3cm90ZToNCj4gRnJvbTogQW50
b25pbyBCb3JuZW8gPGFudG9uaW8uYm9ybmVvQHN0LmNvbT4NCj4gDQo+IEN1cnJlbnQgY29kZSBl
bmFibGVzIHRoZSBIUyBjbG9jayB3aGVuIHZpZGVvIG1vZGUgaXMgc3RhcnRlZCBvciB0bw0KPiBz
ZW5kIG91dCBhIEhTIGNvbW1hbmQsIGFuZCBkaXNhYmxlcyB0aGUgSFMgY2xvY2sgdG8gc2VuZCBv
dXQgYSBMUA0KPiBjb21tYW5kLiBUaGlzIGlzIG5vdCB3aGF0IERTSSBzcGVjIHNwZWNpZnkuDQo+
IA0KPiBFbmFibGUgSFMgY2xvY2sgZWl0aGVyIGluIGNvbW1hbmQgYW5kIGluIHZpZGVvIG1vZGUu
DQo+IFNldCBhdXRvbWF0aWMgSFMgY2xvY2sgbWFuYWdlbWVudCBmb3IgcGFuZWxzIGFuZCBkZXZp
Y2VzIHRoYXQNCj4gc3VwcG9ydCBub24tY29udGludW91cyBIUyBjbG9jay4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEFudG9uaW8gQm9ybmVvIDxhbnRvbmlvLmJvcm5lb0BzdC5jb20+DQo+IC0tLQ0K
PiAgIGRyaXZlcnMvZ3B1L2RybS9icmlkZ2Uvc3lub3BzeXMvZHctbWlwaS1kc2kuYyB8IDkgKysr
KysrKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYnJpZGdlL3N5bm9wc3lzL2R3
LW1pcGktZHNpLmMgYi9kcml2ZXJzL2dwdS9kcm0vYnJpZGdlL3N5bm9wc3lzL2R3LW1pcGktZHNp
LmMNCj4gaW5kZXggZDU4MGIyYWE0Y2U5Li45NzlhY2FhOTBkMDAgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9icmlkZ2Uvc3lub3BzeXMvZHctbWlwaS1kc2kuYw0KPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYnJpZGdlL3N5bm9wc3lzL2R3LW1pcGktZHNpLmMNCj4gQEAgLTM2NSw3ICsz
NjUsNiBAQCBzdGF0aWMgdm9pZCBkd19taXBpX21lc3NhZ2VfY29uZmlnKHN0cnVjdCBkd19taXBp
X2RzaSAqZHNpLA0KPiAgIAlpZiAobHBtKQ0KPiAgIAkJdmFsIHw9IENNRF9NT0RFX0FMTF9MUDsN
Cj4gICANCj4gLQlkc2lfd3JpdGUoZHNpLCBEU0lfTFBDTEtfQ1RSTCwgbHBtID8gMCA6IFBIWV9U
WFJFUVVFU1RDTEtIUyk7DQo+ICAgCWRzaV93cml0ZShkc2ksIERTSV9DTURfTU9ERV9DRkcsIHZh
bCk7DQo+ICAgfQ0KPiAgIA0KPiBAQCAtNTQxLDE2ICs1NDAsMjIgQEAgc3RhdGljIHZvaWQgZHdf
bWlwaV9kc2lfdmlkZW9fbW9kZV9jb25maWcoc3RydWN0IGR3X21pcGlfZHNpICpkc2kpDQo+ICAg
c3RhdGljIHZvaWQgZHdfbWlwaV9kc2lfc2V0X21vZGUoc3RydWN0IGR3X21pcGlfZHNpICpkc2ks
DQo+ICAgCQkJCSB1bnNpZ25lZCBsb25nIG1vZGVfZmxhZ3MpDQo+ICAgew0KPiArCXUzMiB2YWw7
DQo+ICsNCj4gICAJZHNpX3dyaXRlKGRzaSwgRFNJX1BXUl9VUCwgUkVTRVQpOw0KPiAgIA0KPiAg
IAlpZiAobW9kZV9mbGFncyAmIE1JUElfRFNJX01PREVfVklERU8pIHsNCj4gICAJCWRzaV93cml0
ZShkc2ksIERTSV9NT0RFX0NGRywgRU5BQkxFX1ZJREVPX01PREUpOw0KPiAgIAkJZHdfbWlwaV9k
c2lfdmlkZW9fbW9kZV9jb25maWcoZHNpKTsNCj4gLQkJZHNpX3dyaXRlKGRzaSwgRFNJX0xQQ0xL
X0NUUkwsIFBIWV9UWFJFUVVFU1RDTEtIUyk7DQo+ICAgCX0gZWxzZSB7DQo+ICAgCQlkc2lfd3Jp
dGUoZHNpLCBEU0lfTU9ERV9DRkcsIEVOQUJMRV9DTURfTU9ERSk7DQo+ICAgCX0NCj4gICANCj4g
Kwl2YWwgPSBQSFlfVFhSRVFVRVNUQ0xLSFM7DQo+ICsJaWYgKGRzaS0+bW9kZV9mbGFncyAmIE1J
UElfRFNJX0NMT0NLX05PTl9DT05USU5VT1VTKQ0KPiArCQl2YWwgfD0gQVVUT19DTEtMQU5FX0NU
Ukw7DQo+ICsJZHNpX3dyaXRlKGRzaSwgRFNJX0xQQ0xLX0NUUkwsIHZhbCk7DQo+ICsNCj4gICAJ
ZHNpX3dyaXRlKGRzaSwgRFNJX1BXUl9VUCwgUE9XRVJVUCk7DQo+ICAgfQ0KPiAgIA0KPiANCg0K
KCsgQW50b25pbykNCg0KSGkgWWFubmljayAmIEFudG9uaW8sDQoNClJldmlld2VkLWJ5OiBQaGls
aXBwZSBDb3JudSA8cGhpbGlwcGUuY29ybnVAc3QuY29tPg0KVGVzdGVkLWJ5OiBQaGlsaXBwZSBD
b3JudSA8cGhpbGlwcGUuY29ybnVAc3QuY29tPg0KDQooVGVzdGVkIHdpdGggdGhlIDMgcGF0Y2hl
cyBuYW1lZA0KZHJtL2JyaWRnZS9zeW5vcHN5czogZHNpOiBhbGxvdyBMUCBjb21tYW5kcyBpbiB2
aWRlbyBtb2RlDQpkcm0vYnJpZGdlL3N5bm9wc3lzOiBkc2k6IGFsbG93IHNlbmRpbmcgbG9uZ2Vy
IExQIGNvbW1hbmRzDQpkcm0vYnJpZGdlL3N5bm9wc3lzOiBkc2k6IGFkZCBzdXBwb3J0IGZvciBu
b24tY29udGludW91cyBIUyBjbG9jaw0Kb24gdmFyaW91cyBkc2kgYnJpZGdlcyArIHN0bTMybXAx
NTcgZGlzY28gYm9hcmQpDQoNCk1hbnkgdGhhbmtzDQpQaGlsaXBwZSA6LSk=
