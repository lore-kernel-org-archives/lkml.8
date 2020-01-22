Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA91BC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC4824656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ucm7i3HD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgAVJVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:21:33 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:27562 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729049AbgAVJVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:21:32 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00M9E5T0017505;
        Wed, 22 Jan 2020 10:20:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=u/gZg5v5O2lvH7c3i8F88g2U2swQh0X4mBt44nns32Q=;
 b=ucm7i3HDueX2khE20HpGolwzNFjIa0Puk/Wtek/QfMVSRNXuR46O93vA/F7MaMiI6YtR
 MvS9+LEBl3UgQe6UrcIUMWfsWkJT9w7MIg8nhQhsefeADdnJNIFtJmH0Z8W4jxwWx3Qv
 jjWH5313tSr/TywHSg1WyyoqE4wTq1Sn9ffN+gJcrhI+fXag0xJ9llSbvK+PcNZGNTtG
 dipOtYSoCjk2Y9VgTWchVnZiLVQXWRTXE+FIve35owCPS+JJjFc3O5pMOTZD3Nm+2RCT
 ElVOBkgxqBld7vOoWEYVewFfiXLuGJuiexxfSqlQFXaC/BX37SkHOaH/RTI8m9bf4vPn pw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xkr1e3jkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jan 2020 10:20:38 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 923FE10003E;
        Wed, 22 Jan 2020 10:20:30 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 36DBC2AB057;
        Wed, 22 Jan 2020 10:20:30 +0100 (CET)
Received: from SFHDAG6NODE2.st.com (10.75.127.17) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 22 Jan
 2020 10:20:29 +0100
Received: from SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6]) by
 SFHDAG6NODE2.st.com ([fe80::a56f:c186:bab7:13d6%20]) with mapi id
 15.00.1347.000; Wed, 22 Jan 2020 10:20:29 +0100
From:   Olivier MOYSAN <olivier.moysan@st.com>
To:     Rob Herring <robh@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] ASoC: dt-bindings: stm32: convert spdfirx to
 json-schema
Thread-Topic: [PATCH v3] ASoC: dt-bindings: stm32: convert spdfirx to
 json-schema
Thread-Index: AQHV0KYwQJhZ3lJcYU6nre5Twze71af2WFCA
Date:   Wed, 22 Jan 2020 09:20:29 +0000
Message-ID: <6a49bf6c-8851-a65c-5606-563776e07c08@st.com>
References: <20200117170352.16040-1-olivier.moysan@st.com>
 <20200121220022.GA12737@bogus>
In-Reply-To: <20200121220022.GA12737@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C57D8D8E50C2B442847FA8C55AFD97B6@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_05:2020-01-16,2020-01-17 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQpJIGRpZCBub3QgcmVwb3J0IHlvdXIgcmV2aWV3ZWQtYnkgdGFnLCBhcyBJIGhh
dmUgbWFkZSBhIGV4dHJhIGNoYW5nZSBpbiB2Mi4NClRoaXMgY2hhbmdlIGlzIHJlbGF0ZWQgdG8g
ZG1hcyBwcm9wZXJ0eSByZXBvcnRlZCBpbiB2MiBjaGFuZ2UgbG9nLg0KU29ycnksIHRoaXMgZXh0
cmEgY2hhbmdlIHdhcyBpbmRlZWQgbm90IGNsZWFybHkgaGlnaGxpZ2h0ZWQgaW4gbG9nIGNvbW1l
bnRzLg0KDQpSZWdhcmRzDQpPbGl2aWVyDQoNCk9uIDEvMjEvMjAgMTE6MDAgUE0sIFJvYiBIZXJy
aW5nIHdyb3RlOg0KPiBPbiBGcmksIDE3IEphbiAyMDIwIDE4OjAzOjUyICswMTAwLCBPbGl2aWVy
IE1veXNhbiB3cm90ZToNCj4+IENvbnZlcnQgdGhlIFNUTTMyIFNQRElGUlggYmluZGluZ3MgdG8g
RFQgc2NoZW1hIGZvcm1hdCB1c2luZyBqc29uLXNjaGVtYS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBPbGl2aWVyIE1veXNhbiA8b2xpdmllci5tb3lzYW5Ac3QuY29tPg0KPj4gLS0tDQo+PiBDaGFu
Z2VzIGluIHYyOg0KPj4gLSBBZGQgImFkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZSINCj4+IC0g
QWxzbyBjaGFuZ2UgbWluSXRlbXMgdG8gMiBmb3IgZG1hcyBwcm9wZXJ0eSwgYXMgYm90aCBETUFz
IGFyZSByZXF1aXJlZC4NCj4+DQo+PiBDaGFuZ2VzIGluIHYzOg0KPj4gLSBEcm9wIG1pbkl0ZW1z
L21heEl0ZW1zIGZvciBkbWFzIHByb3BlcnR5LCByZW1vdmUgcmVmIHRvIHN0bTMyLWRtYS50eHQu
DQo+PiAtLS0NCj4+ICAgLi4uL2JpbmRpbmdzL3NvdW5kL3N0LHN0bTMyLXNwZGlmcngudHh0ICAg
ICAgIHwgNTYgLS0tLS0tLS0tLS0tLQ0KPj4gICAuLi4vYmluZGluZ3Mvc291bmQvc3Qsc3RtMzIt
c3BkaWZyeC55YW1sICAgICAgfCA4MCArKysrKysrKysrKysrKysrKysrDQo+PiAgIDIgZmlsZXMg
Y2hhbmdlZCwgODAgaW5zZXJ0aW9ucygrKSwgNTYgZGVsZXRpb25zKC0pDQo+PiAgIGRlbGV0ZSBt
b2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvc3Qsc3Rt
MzItc3BkaWZyeC50eHQNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9zdCxzdG0zMi1zcGRpZnJ4LnlhbWwNCj4+DQo+IFBsZWFz
ZSBhZGQgQWNrZWQtYnkvUmV2aWV3ZWQtYnkgdGFncyB3aGVuIHBvc3RpbmcgbmV3IHZlcnNpb25z
LiBIb3dldmVyLA0KPiB0aGVyZSdzIG5vIG5lZWQgdG8gcmVwb3N0IHBhdGNoZXMgKm9ubHkqIHRv
IGFkZCB0aGUgdGFncy4gVGhlIHVwc3RyZWFtDQo+IG1haW50YWluZXIgd2lsbCBkbyB0aGF0IGZv
ciBhY2tzIHJlY2VpdmVkIG9uIHRoZSB2ZXJzaW9uIHRoZXkgYXBwbHkuDQo+DQo+IElmIGEgdGFn
IHdhcyBub3QgYWRkZWQgb24gcHVycG9zZSwgcGxlYXNlIHN0YXRlIHdoeSBhbmQgd2hhdCBjaGFu
Z2VkLg0K
