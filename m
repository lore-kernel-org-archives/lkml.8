Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9649CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FAF62078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="AahgDr6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgGJIrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 04:47:25 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:45275 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726757AbgGJIrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 04:47:24 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06A8hvsN023297;
        Fri, 10 Jul 2020 10:47:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=PrN5kBt2TadyKgoLOcW355tH8MFDlyPGhVCqGnwYIbg=;
 b=AahgDr6fLSVPD+7/zRFJ8QQLDZR7z0NW7fZM9JnEqlBUB7gyBtdN0pGO4jucEMCDrx2x
 4Vnus3hjNObAWTrO2BONsmcw0AcGXZGauvAoix0ns47r0oKRd4ybLrY3xSTPTaelkd3k
 xLWyDgjQaA/dHqOxmKGwoDbVKhYShJveMlgZkaaKWByuk+XAX5A39pghRfoySOqPxdIa
 NvuKWv8Km57ROUT+dzicTN74USqKUe/EO1u4KqhqS0UwUEDBwnkR3JIqZw3DrYYGsEFN
 jTyLFDyRj6j98feg6edaZHugHZeYlmc5XX4vnTZmcO1odjW4FUpxeNerIdM8Gz/bDGSR gg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 325k3w23uw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 10:47:16 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BC776100038;
        Fri, 10 Jul 2020 10:47:15 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 93B8B2AD2C5;
        Fri, 10 Jul 2020 10:47:15 +0200 (CEST)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE3.st.com
 (10.75.127.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Jul
 2020 10:47:15 +0200
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1473.003; Fri, 10 Jul 2020 10:47:15 +0200
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
Subject: Re: [PATCH] drm/bridge/synopsys: dsi: allow sending longer LP
 commands
Thread-Topic: [PATCH] drm/bridge/synopsys: dsi: allow sending longer LP
 commands
Thread-Index: AQHWT7RR56+kk8DFkkudT5fcfOVJRKkAbGUA
Date:   Fri, 10 Jul 2020 08:47:14 +0000
Message-ID: <4947d7a1-5816-5789-dfcd-e802a9463ffa@st.com>
References: <20200701143131.841-1-yannick.fertre@st.com>
In-Reply-To: <20200701143131.841-1-yannick.fertre@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <03D6A15FFFB854438405B991F3EA5C68@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-10_02:2020-07-10,2020-07-10 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDcvMS8yMCA0OjMxIFBNLCBZYW5uaWNrIEZlcnRyZSB3cm90ZToNCj4gRnJvbTogQW50
b25pbyBCb3JuZW8gPGFudG9uaW8uYm9ybmVvQHN0LmNvbT4NCj4gDQo+IEN1cnJlbnQgY29kZSBk
b2VzIG5vdCBwcm9wZXJseSBjb21wdXRlcyB0aGUgbWF4IGxlbmd0aCBvZiBMUA0KPiBjb21tYW5k
cyB0aGF0IGNhbiBiZSBzZW5kIGR1cmluZyBIIG9yIFYgc3luYywgYW5kIHJlbHkgb24gc3RhdGlj
DQo+IHZhbHVlcy4NCj4gTGltaXRpbmcgdGhlIG1heCBMUCBsZW5ndGggdG8gNCBieXRlIGR1cmlu
ZyB0aGUgVi1zeW5jIGlzIG92ZXJseQ0KPiBjb25zZXJ2YXRpdmUuDQo+IA0KPiBSZWxheCB0aGUg
bGltaXQgYW5kIGFsbG93cyBsb25nZXIgTFAgY29tbWFuZHMgKDE2IGJ5dGVzKSB0byBiZQ0KPiBz
ZW50IGR1cmluZyBWLXN5bmMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbnRvbmlvIEJvcm5lbyA8
YW50b25pby5ib3JuZW9Ac3QuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYnJpZGdl
L3N5bm9wc3lzL2R3LW1pcGktZHNpLmMgfCAxNyArKysrKysrKystLS0tLS0tLQ0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2JyaWRnZS9zeW5vcHN5cy9kdy1taXBpLWRzaS5jIGIvZHJp
dmVycy9ncHUvZHJtL2JyaWRnZS9zeW5vcHN5cy9kdy1taXBpLWRzaS5jDQo+IGluZGV4IGQ1ODBi
MmFhNGNlOS4uMWEyNGVhNjQ4ZWY4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYnJp
ZGdlL3N5bm9wc3lzL2R3LW1pcGktZHNpLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2JyaWRn
ZS9zeW5vcHN5cy9kdy1taXBpLWRzaS5jDQo+IEBAIC0zNjAsNiArMzYwLDE1IEBAIHN0YXRpYyB2
b2lkIGR3X21pcGlfbWVzc2FnZV9jb25maWcoc3RydWN0IGR3X21pcGlfZHNpICpkc2ksDQo+ICAg
CWJvb2wgbHBtID0gbXNnLT5mbGFncyAmIE1JUElfRFNJX01TR19VU0VfTFBNOw0KPiAgIAl1MzIg
dmFsID0gMDsNCj4gICANCj4gKwkvKg0KPiArCSAqIFRPRE8gZHcgZHJ2IGltcHJvdmVtZW50cw0K
PiArCSAqIGxhcmdlc3QgcGFja2V0IHNpemVzIGR1cmluZyBoZnAgb3IgZHVyaW5nIHZzYS92cGIv
dmZwDQo+ICsJICogc2hvdWxkIGJlIGNvbXB1dGVkIGFjY29yZGluZyB0byBieXRlIGxhbmUsIGxh
bmUgbnVtYmVyIGFuZCBvbmx5DQo+ICsJICogaWYgc2VuZGluZyBscCBjbWRzIGluIGhpZ2ggc3Bl
ZWQgaXMgZW5hYmxlIChQSFlfVFhSRVFVRVNUQ0xLSFMpDQo+ICsJICovDQo+ICsJZHNpX3dyaXRl
KGRzaSwgRFNJX0RQSV9MUF9DTURfVElNLCBPVVRWQUNUX0xQQ01EX1RJTUUoMTYpDQo+ICsJCSAg
fCBJTlZBQ1RfTFBDTURfVElNRSg0KSk7DQo+ICsNCj4gICAJaWYgKG1zZy0+ZmxhZ3MgJiBNSVBJ
X0RTSV9NU0dfUkVRX0FDSykNCj4gICAJCXZhbCB8PSBBQ0tfUlFTVF9FTjsNCj4gICAJaWYgKGxw
bSkNCj4gQEAgLTYxMSwxNCArNjIwLDYgQEAgc3RhdGljIHZvaWQgZHdfbWlwaV9kc2lfZHBpX2Nv
bmZpZyhzdHJ1Y3QgZHdfbWlwaV9kc2kgKmRzaSwNCj4gICAJZHNpX3dyaXRlKGRzaSwgRFNJX0RQ
SV9WQ0lELCBEUElfVkNJRChkc2ktPmNoYW5uZWwpKTsNCj4gICAJZHNpX3dyaXRlKGRzaSwgRFNJ
X0RQSV9DT0xPUl9DT0RJTkcsIGNvbG9yKTsNCj4gICAJZHNpX3dyaXRlKGRzaSwgRFNJX0RQSV9D
RkdfUE9MLCB2YWwpOw0KPiAtCS8qDQo+IC0JICogVE9ETyBkdyBkcnYgaW1wcm92ZW1lbnRzDQo+
IC0JICogbGFyZ2VzdCBwYWNrZXQgc2l6ZXMgZHVyaW5nIGhmcCBvciBkdXJpbmcgdnNhL3ZwYi92
ZnANCj4gLQkgKiBzaG91bGQgYmUgY29tcHV0ZWQgYWNjb3JkaW5nIHRvIGJ5dGUgbGFuZSwgbGFu
ZSBudW1iZXIgYW5kIG9ubHkNCj4gLQkgKiBpZiBzZW5kaW5nIGxwIGNtZHMgaW4gaGlnaCBzcGVl
ZCBpcyBlbmFibGUgKFBIWV9UWFJFUVVFU1RDTEtIUykNCj4gLQkgKi8NCj4gLQlkc2lfd3JpdGUo
ZHNpLCBEU0lfRFBJX0xQX0NNRF9USU0sIE9VVFZBQ1RfTFBDTURfVElNRSg0KQ0KPiAtCQkgIHwg
SU5WQUNUX0xQQ01EX1RJTUUoNCkpOw0KPiAgIH0NCj4gICANCj4gICBzdGF0aWMgdm9pZCBkd19t
aXBpX2RzaV9wYWNrZXRfaGFuZGxlcl9jb25maWcoc3RydWN0IGR3X21pcGlfZHNpICpkc2kpDQo+
IA0KDQooKyBBbnRvbmlvKQ0KDQpIaSBZYW5uaWNrICYgQW50b25pbywNCg0KUmV2aWV3ZWQtYnk6
IFBoaWxpcHBlIENvcm51IDxwaGlsaXBwZS5jb3JudUBzdC5jb20+DQpUZXN0ZWQtYnk6IFBoaWxp
cHBlIENvcm51IDxwaGlsaXBwZS5jb3JudUBzdC5jb20+DQoNCihUZXN0ZWQgd2l0aCB0aGUgMyBw
YXRjaGVzIG5hbWVkDQpkcm0vYnJpZGdlL3N5bm9wc3lzOiBkc2k6IGFsbG93IExQIGNvbW1hbmRz
IGluIHZpZGVvIG1vZGUNCmRybS9icmlkZ2Uvc3lub3BzeXM6IGRzaTogYWxsb3cgc2VuZGluZyBs
b25nZXIgTFAgY29tbWFuZHMNCmRybS9icmlkZ2Uvc3lub3BzeXM6IGRzaTogYWRkIHN1cHBvcnQg
Zm9yIG5vbi1jb250aW51b3VzIEhTIGNsb2NrDQpvbiB2YXJpb3VzIGRzaSBicmlkZ2VzICsgc3Rt
MzJtcDE1NyBkaXNjbyBib2FyZCkNCg0KTWFueSB0aGFua3MNClBoaWxpcHBlIDotKQ==
