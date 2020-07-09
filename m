Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433C9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17F3520720
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="oznUVSq5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgGIH4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 03:56:45 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:15240 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726118AbgGIH4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 03:56:44 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0697mOa6011824;
        Thu, 9 Jul 2020 09:56:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=PjimJKcwCGdTe67CN4aV9vRO3WO9hHLqREjVFyCK/DM=;
 b=oznUVSq5i3TEu5NSPUpfxlYxeM3m+tx2em+QoRcP296wfE5tgsPOMmO8KEh1f3hXZsh8
 DzgEKerKGYmgHR9yKHNZ8VaPWB5MkmiMsjFhUHzIfxlKG7s/6XsiMtp2fnbRcFadaO1U
 zaIXtMp0S83ZeroEicdiO9TITyZqk9R/Qe7uaOTRWpH4RB05RwgOTPZKQWqbjJ2vbD6h
 z3e9wkMkEttXeAxxS77EraZYnLSOJzXA5vhrtPsKdYzWcadSRi8GtF0KEU9ooYVm7wDW
 VGyRw5eD26N+PzeQZtMyBEzKxIqe8Jvgf9MvZhDGQpw1sMR34sL/tZ/Odjy38cYFybl/ Mw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 325k4036gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jul 2020 09:56:14 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C416710002A;
        Thu,  9 Jul 2020 09:56:11 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A42402A5335;
        Thu,  9 Jul 2020 09:56:11 +0200 (CEST)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 9 Jul
 2020 09:56:11 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1473.003; Thu, 9 Jul 2020 09:56:10 +0200
From:   Philippe CORNU <philippe.cornu@st.com>
To:     Angelo Ribeiro <Angelo.Ribeiro@synopsys.com>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pop.adrian61@gmail.com" <pop.adrian61@gmail.com>
CC:     Jose Abreu <Jose.Abreu@synopsys.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH v2] drm/bridge: dw-mipi-dsi.c: Add VPG runtime config
 through debugfs
Thread-Topic: [PATCH v2] drm/bridge: dw-mipi-dsi.c: Add VPG runtime config
 through debugfs
Thread-Index: AQHWDBotInPkNFsaBECN9f5nx+r1ZajoYdsAgBYY4fCAANhUAA==
Date:   Thu, 9 Jul 2020 07:56:10 +0000
Message-ID: <8b34476f-61b6-0d28-cf0c-1d6a08df71c8@st.com>
References: <a809feb7d7153a92e323416f744f1565e995da01.1586180592.git.angelo.ribeiro@synopsys.com>
 <d46d3aaf-d3cd-e5e1-81b9-c019537bd09a@st.com>
 <CH2PR12MB37823C45C7CC1A142ACC4BBECB670@CH2PR12MB3782.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB37823C45C7CC1A142ACC4BBECB670@CH2PR12MB3782.namprd12.prod.outlook.com>
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
Content-ID: <36C08152BFA52E42B8BA706BC095EAEC@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-09_04:2020-07-08,2020-07-09 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiA3LzgvMjAgNzowOCBQTSwgQW5nZWxvIFJpYmVpcm8gd3JvdGU6DQo+IEhpLA0KPiANCj4g
SXMgdGhpcyBwYXRjaCBnb29kIHRvIGdvPw0KPiBAZGFuaWVsQGZmd2xsLmNoLCBAUGhpbGlwcGUg
Q09STlUNCj4gDQo+IFdhcyBhbHJlYWR5IHRlc3RlZCBieSBAWWFubmljayBGRVJUUkUNCj4gYW5k
IEBBZHJpYW4gUG9wDQo+IG9uIGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDIwLzQvNi82OTEgLg0K
PiANCj4gVGhhbmtzLA0KPiBBbmdlbG8NCj4gDQo+IEZyb206IFlhbm5pY2sNCj4gRkVSVFJFIDx5
YW5uaWNrLmZlcnRyZUBzdC5jb20+DQo+IERhdGU6IFdlZCwgSnVuIDI0LCAyMDIwIGF0IDE2OjM1
OjA0DQo+IA0KPj4gSGVsbG8gQW5nZWxvLA0KPj4gdGhhbmtzIGZvciB0aGUgcGF0Y2guDQo+PiBU
ZXN0ZWQtYnk6IFlhbm5pY2sgRmVydHJlIDx5YW5uaWNrLmZlcnRyZUBzdC5jb20+DQo+PiBUZXN0
ZWQgT0sgb24gU1RNMzJNUDEtRElTQ08sIERTSSB2MS4zMQ0KPj4NCj4+IEJlc3QgcmVnYXJkcw0K
Pj4NCj4+DQo+PiBPbiA0LzYvMjAgMzo0OSBQTSwgQW5nZWxvIFJpYmVpcm8gd3JvdGU6DQo+Pj4g
QWRkIHN1cHBvcnQgZm9yIHRoZSB2aWRlbyBwYXR0ZXJuIGdlbmVyYXRvciAoVlBHKSBCRVIgcGF0
dGVybiBtb2RlIGFuZA0KPj4+IGNvbmZpZ3VyYXRpb24gaW4gcnVudGltZS4NCj4+Pg0KPj4+IFRo
aXMgZW5hYmxlcyB1c2luZyB0aGUgZGVidWdmcyBpbnRlcmZhY2UgdG8gbWFuaXB1bGF0ZSB0aGUg
VlBHIGFmdGVyDQo+Pj4gdGhlIHBpcGVsaW5lIGlzIHNldC4NCj4+PiBBbHNvLCBlbmFibGVzIHRo
ZSB1c2FnZSBvZiB0aGUgVlBHIEJFUiBwYXR0ZXJuLg0KPj4+DQo+Pj4gQ2hhbmdlcyBpbiB2MjoN
Cj4+PiAgICAgLSBBZGRlZCBWSURfTU9ERV9WUEdfTU9ERQ0KPj4+ICAgICAtIFNvbHZlZCBpbmNv
bXBhdGlibGUgcmV0dXJuIHR5cGUgb24gX19nZXQgYW5kIF9fc2V0DQo+Pj4NCj4+PiBSZXBvcnRl
ZC1ieToga2J1aWxkIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+Pj4gUmVwb3J0ZWQtYnk6
IEFkcmlhbiBQb3AgPHBvcC5hZHJpYW42MUBnbWFpbC5jb20+DQo+Pj4gQ2M6IEd1c3Rhdm8gUGlt
ZW50ZWwgPGd1c3Rhdm8ucGltZW50ZWxAc3lub3BzeXMuY29tPg0KPj4+IENjOiBKb2FvIFBpbnRv
IDxqcGludG9Ac3lub3BzeXMuY29tPg0KPj4+IENjOiBKb3NlIEFicmV1IDxqb3NlLmFicmV1QHN5
bm9wc3lzLmNvbT4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG8gUmliZWlybyA8YW5nZWxvLnJp
YmVpcm9Ac3lub3BzeXMuY29tPg0KPj4+IC0tLQ0KPj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9icmlk
Z2Uvc3lub3BzeXMvZHctbWlwaS1kc2kuYyB8IDk4ICsrKysrKysrKysrKysrKysrKysrKysrKy0t
LQ0KPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA5MCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygt
KQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9icmlkZ2Uvc3lub3BzeXMv
ZHctbWlwaS1kc2kuYyBiL2RyaXZlcnMvZ3B1L2RybS9icmlkZ2Uvc3lub3BzeXMvZHctbWlwaS1k
c2kuYw0KPj4+IGluZGV4IGIxODM1MWIuLjlkZTM2NDUgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2JyaWRnZS9zeW5vcHN5cy9kdy1taXBpLWRzaS5jDQo+Pj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2JyaWRnZS9zeW5vcHN5cy9kdy1taXBpLWRzaS5jDQo+Pj4gQEAgLTkxLDYgKzkx
LDcgQEANCj4+PiAgICAjZGVmaW5lIFZJRF9NT0RFX1RZUEVfQlVSU1QJCQkweDINCj4+PiAgICAj
ZGVmaW5lIFZJRF9NT0RFX1RZUEVfTUFTSwkJCTB4Mw0KPj4+ICAgICNkZWZpbmUgVklEX01PREVf
VlBHX0VOQUJMRQkJQklUKDE2KQ0KPj4+ICsjZGVmaW5lIFZJRF9NT0RFX1ZQR19NT0RFCQlCSVQo
MjApDQo+Pj4gICAgI2RlZmluZSBWSURfTU9ERV9WUEdfSE9SSVpPTlRBTAkJQklUKDI0KQ0KPj4+
ICAgIA0KPj4+ICAgICNkZWZpbmUgRFNJX1ZJRF9QS1RfU0laRQkJMHgzYw0KPj4+IEBAIC0yMjEs
NiArMjIyLDIxIEBADQo+Pj4gICAgI2RlZmluZSBQSFlfU1RBVFVTX1RJTUVPVVRfVVMJCTEwMDAw
DQo+Pj4gICAgI2RlZmluZSBDTURfUEtUX1NUQVRVU19USU1FT1VUX1VTCTIwMDAwDQo+Pj4gICAg
DQo+Pj4gKyNpZmRlZiBDT05GSUdfREVCVUdfRlMNCj4+PiArI2RlZmluZSBWUEdfREVGUyhuYW1l
LCBkc2kpIFwNCj4+PiArCSgodm9pZCBfX2ZvcmNlICopJigoKmRzaSkudnBnX2RlZnMubmFtZSkp
DQo+Pj4gKw0KPj4+ICsjZGVmaW5lIFJFR0lTVEVSKG5hbWUsIG1hc2ssIGRzaSkgXA0KPj4+ICsJ
eyAjbmFtZSwgVlBHX0RFRlMobmFtZSwgZHNpKSwgbWFzaywgZHNpIH0NCj4+PiArDQo+Pj4gK3N0
cnVjdCBkZWJ1Z2ZzX2VudHJpZXMgew0KPj4+ICsJY29uc3QgY2hhcgkJCQkqbmFtZTsNCj4+PiAr
CWJvb2wJCQkJCSpyZWc7DQo+Pj4gKwl1MzIJCQkJCW1hc2s7DQo+Pj4gKwlzdHJ1Y3QgZHdfbWlw
aV9kc2kJCQkqZHNpOw0KPj4+ICt9Ow0KPj4+ICsjZW5kaWYgLyogQ09ORklHX0RFQlVHX0ZTICov
DQo+Pj4gKw0KPj4+ICAgIHN0cnVjdCBkd19taXBpX2RzaSB7DQo+Pj4gICAgCXN0cnVjdCBkcm1f
YnJpZGdlIGJyaWRnZTsNCj4+PiAgICAJc3RydWN0IG1pcGlfZHNpX2hvc3QgZHNpX2hvc3Q7DQo+
Pj4gQEAgLTIzOCw5ICsyNTQsMTIgQEAgc3RydWN0IGR3X21pcGlfZHNpIHsNCj4+PiAgICANCj4+
PiAgICAjaWZkZWYgQ09ORklHX0RFQlVHX0ZTDQo+Pj4gICAgCXN0cnVjdCBkZW50cnkgKmRlYnVn
ZnM7DQo+Pj4gLQ0KPj4+IC0JYm9vbCB2cGc7DQo+Pj4gLQlib29sIHZwZ19ob3Jpem9udGFsOw0K
Pj4+ICsJc3RydWN0IGRlYnVnZnNfZW50cmllcyAqZGVidWdmc192cGc7DQo+Pj4gKwlzdHJ1Y3Qg
ew0KPj4+ICsJCWJvb2wgdnBnOw0KPj4+ICsJCWJvb2wgdnBnX2hvcml6b250YWw7DQo+Pj4gKwkJ
Ym9vbCB2cGdfYmVyX3BhdHRlcm47DQo+Pj4gKwl9IHZwZ19kZWZzOw0KPj4+ICAgICNlbmRpZiAv
KiBDT05GSUdfREVCVUdfRlMgKi8NCj4+PiAgICANCj4+PiAgICAJc3RydWN0IGR3X21pcGlfZHNp
ICptYXN0ZXI7IC8qIGR1YWwtZHNpIG1hc3RlciBwdHIgKi8NCj4+PiBAQCAtNTMwLDkgKzU0OSwx
MSBAQCBzdGF0aWMgdm9pZCBkd19taXBpX2RzaV92aWRlb19tb2RlX2NvbmZpZyhzdHJ1Y3QgZHdf
bWlwaV9kc2kgKmRzaSkNCj4+PiAgICAJCXZhbCB8PSBWSURfTU9ERV9UWVBFX05PTl9CVVJTVF9T
WU5DX0VWRU5UUzsNCj4+PiAgICANCj4+PiAgICAjaWZkZWYgQ09ORklHX0RFQlVHX0ZTDQo+Pj4g
LQlpZiAoZHNpLT52cGcpIHsNCj4+PiArCWlmIChkc2ktPnZwZ19kZWZzLnZwZykgew0KPj4+ICAg
IAkJdmFsIHw9IFZJRF9NT0RFX1ZQR19FTkFCTEU7DQo+Pj4gLQkJdmFsIHw9IGRzaS0+dnBnX2hv
cml6b250YWwgPyBWSURfTU9ERV9WUEdfSE9SSVpPTlRBTCA6IDA7DQo+Pj4gKwkJdmFsIHw9IGRz
aS0+dnBnX2RlZnMudnBnX2hvcml6b250YWwgPw0KPj4+ICsJCSAgICAgICBWSURfTU9ERV9WUEdf
SE9SSVpPTlRBTCA6IDA7DQo+Pj4gKwkJdmFsIHw9IGRzaS0+dnBnX2RlZnMudnBnX2Jlcl9wYXR0
ZXJuID8gVklEX01PREVfVlBHX01PREUgOiAwOw0KPj4+ICAgIAl9DQo+Pj4gICAgI2VuZGlmIC8q
IENPTkZJR19ERUJVR19GUyAqLw0KPj4+ICAgIA0KPj4+IEBAIC05NjEsNiArOTgyLDY4IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgZHJtX2JyaWRnZV9mdW5jcyBkd19taXBpX2RzaV9icmlkZ2VfZnVu
Y3MgPSB7DQo+Pj4gICAgDQo+Pj4gICAgI2lmZGVmIENPTkZJR19ERUJVR19GUw0KPj4+ICAgIA0K
Pj4+ICtpbnQgZHdfbWlwaV9kc2lfZGVidWdmc193cml0ZSh2b2lkICpkYXRhLCB1NjQgdmFsKQ0K
Pj4+ICt7DQo+Pj4gKwlzdHJ1Y3QgZGVidWdmc19lbnRyaWVzICp2cGcgPSBkYXRhOw0KPj4+ICsJ
c3RydWN0IGR3X21pcGlfZHNpICpkc2k7DQo+Pj4gKwl1MzIgbW9kZV9jZmc7DQo+Pj4gKw0KPj4+
ICsJaWYgKCF2cGcpDQo+Pj4gKwkJcmV0dXJuIC1FTk9ERVY7DQo+Pj4gKw0KPj4+ICsJZHNpID0g
dnBnLT5kc2k7DQo+Pj4gKw0KPj4+ICsJKnZwZy0+cmVnID0gKGJvb2wpdmFsOw0KPj4+ICsNCj4+
PiArCW1vZGVfY2ZnID0gZHNpX3JlYWQoZHNpLCBEU0lfVklEX01PREVfQ0ZHKTsNCj4+PiArDQo+
Pj4gKwlpZiAoKnZwZy0+cmVnKQ0KPj4+ICsJCW1vZGVfY2ZnIHw9IHZwZy0+bWFzazsNCj4+PiAr
CWVsc2UNCj4+PiArCQltb2RlX2NmZyAmPSB+dnBnLT5tYXNrOw0KPj4+ICsNCj4+PiArCWRzaV93
cml0ZShkc2ksIERTSV9WSURfTU9ERV9DRkcsIG1vZGVfY2ZnKTsNCj4+PiArDQo+Pj4gKwlyZXR1
cm4gMDsNCj4+PiArfQ0KPj4+ICsNCj4+PiAraW50IGR3X21pcGlfZHNpX2RlYnVnZnNfc2hvdyh2
b2lkICpkYXRhLCB1NjQgKnZhbCkNCj4+PiArew0KPj4+ICsJc3RydWN0IGRlYnVnZnNfZW50cmll
cyAqdnBnID0gZGF0YTsNCj4+PiArDQo+Pj4gKwlpZiAoIXZwZykNCj4+PiArCQlyZXR1cm4gLUVO
T0RFVjsNCj4+PiArDQo+Pj4gKwkqdmFsID0gKnZwZy0+cmVnOw0KPj4+ICsNCj4+PiArCXJldHVy
biAwOw0KPj4+ICt9DQo+Pj4gKw0KPj4+ICtERUZJTkVfREVCVUdGU19BVFRSSUJVVEUoZm9wc194
MzIsIGR3X21pcGlfZHNpX2RlYnVnZnNfc2hvdywNCj4+PiArCQkJIGR3X21pcGlfZHNpX2RlYnVn
ZnNfd3JpdGUsICIlbGx1XG4iKTsNCj4+PiArDQo+Pj4gK3N0YXRpYyB2b2lkIGRlYnVnZnNfY3Jl
YXRlX2ZpbGVzKHZvaWQgKmRhdGEpDQo+Pj4gK3sNCj4+PiArCXN0cnVjdCBkd19taXBpX2RzaSAq
ZHNpID0gZGF0YTsNCj4+PiArCXN0cnVjdCBkZWJ1Z2ZzX2VudHJpZXMgZGVidWdmc1tdID0gew0K
Pj4+ICsJCVJFR0lTVEVSKHZwZywgVklEX01PREVfVlBHX0VOQUJMRSwgZHNpKSwNCj4+PiArCQlS
RUdJU1RFUih2cGdfaG9yaXpvbnRhbCwgVklEX01PREVfVlBHX0hPUklaT05UQUwsIGRzaSksDQo+
Pj4gKwkJUkVHSVNURVIodnBnX2Jlcl9wYXR0ZXJuLCBWSURfTU9ERV9WUEdfTU9ERSwgZHNpKSwN
Cj4+PiArCX07DQo+Pj4gKwlpbnQgaTsNCj4+PiArDQo+Pj4gKwlkc2ktPmRlYnVnZnNfdnBnID0g
a21hbGxvYyhzaXplb2YoZGVidWdmcyksIEdGUF9LRVJORUwpOw0KPj4+ICsJaWYgKCFkc2ktPmRl
YnVnZnNfdnBnKQ0KPj4+ICsJCXJldHVybjsNCj4+PiArDQo+Pj4gKwltZW1jcHkoZHNpLT5kZWJ1
Z2ZzX3ZwZywgZGVidWdmcywgc2l6ZW9mKGRlYnVnZnMpKTsNCj4+PiArDQo+Pj4gKwlmb3IgKGkg
PSAwOyBpIDwgQVJSQVlfU0laRShkZWJ1Z2ZzKTsgaSsrKQ0KPj4+ICsJCWRlYnVnZnNfY3JlYXRl
X2ZpbGUoZHNpLT5kZWJ1Z2ZzX3ZwZ1tpXS5uYW1lLCAwNjQ0LA0KPj4+ICsJCQkJICAgIGRzaS0+
ZGVidWdmcywgJmRzaS0+ZGVidWdmc192cGdbaV0sDQo+Pj4gKwkJCQkgICAgJmZvcHNfeDMyKTsN
Cj4+PiArfQ0KPj4+ICsNCj4+PiAgICBzdGF0aWMgdm9pZCBkd19taXBpX2RzaV9kZWJ1Z2ZzX2lu
aXQoc3RydWN0IGR3X21pcGlfZHNpICpkc2kpDQo+Pj4gICAgew0KPj4+ICAgIAlkc2ktPmRlYnVn
ZnMgPSBkZWJ1Z2ZzX2NyZWF0ZV9kaXIoZGV2X25hbWUoZHNpLT5kZXYpLCBOVUxMKTsNCj4+PiBA
QCAtOTY5LDE0ICsxMDUyLDEzIEBAIHN0YXRpYyB2b2lkIGR3X21pcGlfZHNpX2RlYnVnZnNfaW5p
dChzdHJ1Y3QgZHdfbWlwaV9kc2kgKmRzaSkNCj4+PiAgICAJCXJldHVybjsNCj4+PiAgICAJfQ0K
Pj4+ICAgIA0KPj4+IC0JZGVidWdmc19jcmVhdGVfYm9vbCgidnBnIiwgMDY2MCwgZHNpLT5kZWJ1
Z2ZzLCAmZHNpLT52cGcpOw0KPj4+IC0JZGVidWdmc19jcmVhdGVfYm9vbCgidnBnX2hvcml6b250
YWwiLCAwNjYwLCBkc2ktPmRlYnVnZnMsDQo+Pj4gLQkJCSAgICAmZHNpLT52cGdfaG9yaXpvbnRh
bCk7DQo+Pj4gKwlkZWJ1Z2ZzX2NyZWF0ZV9maWxlcyhkc2kpOw0KDQpIaSBBbmdlbG8sDQpBbmQg
dGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLg0KQ291bGQgeW91IHBsZWFzZSBleHBsYWluIHdoeSB5
b3UgaGF2ZSAic28gbWFueSBsaW5lcyIgZm9yIGFkZGluZyB0aGUgYmVyIA0KcGF0dGVybiwgaW5z
dGVhZCBvZiB0aGVzZSA0IGxpbmVzIDoNCg0KKyNkZWZpbmUgVklEX01PREVfVlBHX01PREUJCUJJ
VCgyMCkNCitib29sIHZwZ19iZXJfcGF0dGVybjsNCit2YWwgfD0gZHNpLT52cGdfYmVyX3BhdHRl
cm4gPyBWSURfTU9ERV9WUEdfTU9ERSA6IDA7DQorZGVidWdmc19jcmVhdGVfYm9vbCgidnBnX2Jl
cl9wYXR0ZXJuIiwgMDY2MCwgZHNpLT5kZWJ1Z2ZzLCANCiZkc2ktPnZwZ19iZXJfcGF0dGVybik7
DQoNCk1hbnkgdGhhbmtzDQpQaGlsaXBwZSA6LSkNCg0KPj4+ICAgIH0NCj4+PiAgICANCj4+PiAg
ICBzdGF0aWMgdm9pZCBkd19taXBpX2RzaV9kZWJ1Z2ZzX3JlbW92ZShzdHJ1Y3QgZHdfbWlwaV9k
c2kgKmRzaSkNCj4+PiAgICB7DQo+Pj4gICAgCWRlYnVnZnNfcmVtb3ZlX3JlY3Vyc2l2ZShkc2kt
PmRlYnVnZnMpOw0KPj4+ICsJa2ZyZWUoZHNpLT5kZWJ1Z2ZzX3ZwZyk7DQo+Pj4gICAgfQ0KPj4+
ICAgIA0KPj4+ICAgICNlbHNlDQo+Pj4NCj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fDQo+PiBkcmktZGV2ZWwgbWFpbGluZyBsaXN0DQo+PiBkcmktZGV2
ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+PiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19f
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWxf
XzshIUE0RjJSOUdfcGchUGFENzU4LVRwQ0hKY0pHNGJpQjVvTTNXSlhkMW1UYkxpdEQ4SzFxelNW
UTRaMDZuY19fMDZNUl9zei1JVE1JbCQNCj4gDQo+IA==
