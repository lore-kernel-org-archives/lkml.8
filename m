Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24749C352A4
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED97B24696
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="bClpxiC9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgBGJjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 04:39:32 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:27202 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726798AbgBGJjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 04:39:32 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0179bwEi032026;
        Fri, 7 Feb 2020 10:39:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=uV+lOQb/omDQocQnES6jhPSEMxDi5yzug/DtBrg7Jxc=;
 b=bClpxiC9JbGfKTYOVULkh/N1MD+R1OBhC/IiKSY/2ON2YeMi5s+uD6dkf9CdClsalvlE
 rHBYdQio10C+9kgicSN5JFlHGYN+gCePYjbMELO+rde12Io2vDEygvaIeYEZLcKbQ+9B
 eNvSJ5yFDBa5JxP7iV9VzMtxDYE1f55Jl2v2AlYB2cqV6dvuQdr6Sb7bP1JAg9s3vqVL
 tkqi8DkbbmHTc8C2Q1w+zt6I3d5nezEK1GBh3OWC8o92jC1NaxHtlK29llZEtX6X66kI
 hdsS6LZAp9Npej7030laKit/mLEFiWbDvXg2SdiSWvph8IQRsDKXJ0TrUe0IoVnsqn9S TQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xyhk8srx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Feb 2020 10:39:16 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6CB5610002A;
        Fri,  7 Feb 2020 10:39:12 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5669A2A8FB0;
        Fri,  7 Feb 2020 10:39:12 +0100 (CET)
Received: from SFHDAG6NODE3.st.com (10.75.127.18) by SFHDAG6NODE3.st.com
 (10.75.127.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Feb
 2020 10:39:11 +0100
Received: from SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6]) by
 SFHDAG6NODE3.st.com ([fe80::d04:5337:ab17:b6f6%20]) with mapi id
 15.00.1473.003; Fri, 7 Feb 2020 10:39:11 +0100
From:   Philippe CORNU <philippe.cornu@st.com>
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Yannick FERTRE <yannick.fertre@st.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: one file of all simple DSI panels
Thread-Topic: [PATCH v4 1/3] dt-bindings: one file of all simple DSI panels
Thread-Index: AQHV3PIRj7wu8FMZKU6xZkktJ3qf8KgPaj+A
Date:   Fri, 7 Feb 2020 09:39:11 +0000
Message-ID: <1755cf1f-3a4a-5637-865e-028f227abbaa@st.com>
References: <20200206133344.724-1-benjamin.gaignard@st.com>
 <20200206133344.724-2-benjamin.gaignard@st.com>
In-Reply-To: <20200206133344.724-2-benjamin.gaignard@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E4CBBACC22A874BA4D832170E22A1C8@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-07_01:2020-02-07,2020-02-06 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmVuamFtaW4sDQphbmQgbWFueSB0aGFua3MgZm9yIHRoaXMgc2VyaWUuDQpSZWdhcmRpbmcg
dGhpcyBwYXRjaDoNCg0KUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIENvcm51IDxwaGlsaXBwZS5jb3Ju
dUBzdC5jb20+DQpQaGlsaXBwZSA6LSkNCg0KT24gMi82LzIwIDI6MzMgUE0sIEJlbmphbWluIEdh
aWduYXJkIHdyb3RlOg0KPiBGcm9tOiBTYW0gUmF2bmJvcmcgPHNhbUByYXZuYm9yZy5vcmc+DQo+
IA0KPiBUbyBjb21wbGVtZW50IHBhbmVsLXNpbXBsZS55YW1sLCBjcmVhdGUgcGFuZWwtc2ltcGxl
LWRzaS55YW1sLg0KPiBwYW5lbC1zaW1wbGUtZHNpLXlhbWwgYXJlIGZvciBhbGwgc2ltcGxlIERT
UCBwYW5lbHMgd2l0aCBhIHNpbmdsZQ0KPiBwb3dlci1zdXBwbHkgYW5kIG9wdGlvbmFsIGJhY2ts
aWdodCAvIGVuYWJsZSBHUElPLg0KPiANCj4gTWlncmF0ZSBwYW5hc29uaWMsdnZ4MTBmMDM0bjAw
IG92ZXIgdG8gdGhlIG5ldyBmaWxlLg0KPiANCj4gVGhlIG9iamVjdGl2ZXMgd2l0aCBvbmUgZmls
ZSBmb3IgYWxsIHRoZSBzaW1wbGUgRFNJIHBhbmVscyBhcmU6DQo+ICAgICAgLSBNYWtlIGl0IHNp
bXBsZXIgdG8gYWRkIGJpbmRpbmdzIGZvciBzaW1wbGUgRFNJIHBhbmVscw0KPiAgICAgIC0gS2Vl
cCB0aGUgbnVtYmVyIG9mIGJpbmRpbmdzIGZpbGUgbG93ZXINCj4gICAgICAtIEtlZXAgdGhlIGJp
bmRpbmcgZG9jdW1lbnRhdGlvbiBmb3Igc2ltcGxlIERTSSBwYW5lbHMgbW9yZSBjb25zaXN0ZW50
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTYW0gUmF2bmJvcmcgPHNhbUByYXZuYm9yZy5vcmc+DQo+
IFNpZ25lZC1vZmYtYnk6IEJlbmphbWluIEdhaWduYXJkIDxiZW5qYW1pbi5nYWlnbmFyZEBzdC5j
b20+DQo+IENjOiBUaGllcnJ5IFJlZGluZyA8dGhpZXJyeS5yZWRpbmdAZ21haWwuY29tPg0KPiBD
YzogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCj4gQ2M6IE1heGltZSBSaXBhcmQgPG1y
aXBhcmRAa2VybmVsLm9yZz4NCj4gQ2M6IFlhbm5pY2sgRmVydHJlIDx5YW5uaWNrLmZlcnRyZUBz
dC5jb20+DQo+IENjOiBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPg0KPiBDYzog
RGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPg0KPiBDYzogZHJpLWRldmVsQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZw0KPiBDYzogZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gLS0tDQo+
IHZlcnNpb24gNDoNCj4gLSByZW1vdmUgb3Jpc2V0ZWNoLG90bTgwMDlhIGFuZCByYXlkaXVtLHJt
NjgyMDAgY29tcGF0aWJsZXMNCj4gLSByZW1vdmUgcmVzZXQtZ3Bpb3Mgb3B0aW9uYWwgcHJvcGVy
dHkNCj4gDQo+IHZlcnNpb24gMzoNCj4gLSBhZGQgb3Jpc2V0ZWNoLG90bTgwMDlhIGFuZCByYXlk
aXVtLHJtNjgyMDAgY29tcGF0aWJsZXMNCj4gLSBhZGQgcmVzZXQtZ3Bpb3Mgb3B0aW9uYWwgcHJv
cGVydHkNCj4gLSBmaXggaW5kZW50YXRpb24gb24gY29tcGF0aWJsZSBlbnVtZXJhdGlvbg0KPiAN
Cj4gICAuLi4vZGlzcGxheS9wYW5lbC9wYW5hc29uaWMsdnZ4MTBmMDM0bjAwLnR4dCAgICAgICB8
IDIwIC0tLS0tLS0NCj4gICAuLi4vYmluZGluZ3MvZGlzcGxheS9wYW5lbC9wYW5lbC1zaW1wbGUt
ZHNpLnlhbWwgICB8IDY3ICsrKysrKysrKysrKysrKysrKysrKysNCj4gICAyIGZpbGVzIGNoYW5n
ZWQsIDY3IGluc2VydGlvbnMoKyksIDIwIGRlbGV0aW9ucygtKQ0KPiAgIGRlbGV0ZSBtb2RlIDEw
MDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9wYW5lbC9wYW5h
c29uaWMsdnZ4MTBmMDM0bjAwLnR4dA0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9wYW5lbC9wYW5lbC1zaW1wbGUtZHNpLnlh
bWwNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
ZGlzcGxheS9wYW5lbC9wYW5hc29uaWMsdnZ4MTBmMDM0bjAwLnR4dCBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L3BhbmVsL3BhbmFzb25pYyx2dngxMGYwMzRuMDAu
dHh0DQo+IGRlbGV0ZWQgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAzN2RlZGY2YTY3MDIuLjAw
MDAwMDAwMDAwMA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlz
cGxheS9wYW5lbC9wYW5hc29uaWMsdnZ4MTBmMDM0bjAwLnR4dA0KPiArKysgL2Rldi9udWxsDQo+
IEBAIC0xLDIwICswLDAgQEANCj4gLVBhbmFzb25pYyAxMCIgV1VYR0EgVEZUIExDRCBwYW5lbA0K
PiAtDQo+IC1SZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiAtLSBjb21wYXRpYmxlOiBzaG91bGQgYmUg
InBhbmFzb25pYyx2dngxMGYwMzRuMDAiDQo+IC0tIHJlZzogRFNJIHZpcnR1YWwgY2hhbm5lbCBv
ZiB0aGUgcGVyaXBoZXJhbA0KPiAtLSBwb3dlci1zdXBwbHk6IHBoYW5kbGUgb2YgdGhlIHJlZ3Vs
YXRvciB0aGF0IHByb3ZpZGVzIHRoZSBzdXBwbHkgdm9sdGFnZQ0KPiAtDQo+IC1PcHRpb25hbCBw
cm9wZXJ0aWVzOg0KPiAtLSBiYWNrbGlnaHQ6IHBoYW5kbGUgb2YgdGhlIGJhY2tsaWdodCBkZXZp
Y2UgYXR0YWNoZWQgdG8gdGhlIHBhbmVsDQo+IC0NCj4gLUV4YW1wbGU6DQo+IC0NCj4gLQltZHNz
X2RzaUBmZDkyMjgwMCB7DQo+IC0JCXBhbmVsQDAgew0KPiAtCQkJY29tcGF0aWJsZSA9ICJwYW5h
c29uaWMsdnZ4MTBmMDM0bjAwIjsNCj4gLQkJCXJlZyA9IDwwPjsNCj4gLQkJCXBvd2VyLXN1cHBs
eSA9IDwmdnJlZ192c3A+Ow0KPiAtCQkJYmFja2xpZ2h0ID0gPCZscDg1NjZfd2xlZD47DQo+IC0J
CX07DQo+IC0JfTsNCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9kaXNwbGF5L3BhbmVsL3BhbmVsLXNpbXBsZS1kc2kueWFtbCBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L3BhbmVsL3BhbmVsLXNpbXBsZS1kc2kueWFtbA0K
PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLjhiNjAzNjhhMjQy
NQ0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9kaXNwbGF5L3BhbmVsL3BhbmVsLXNpbXBsZS1kc2kueWFtbA0KPiBAQCAtMCwwICsxLDY3
IEBADQo+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IG9yIEJTRC0y
LUNsYXVzZSkNCj4gKyVZQU1MIDEuMg0KPiArLS0tDQo+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVl
Lm9yZy9zY2hlbWFzL2Rpc3BsYXkvcGFuZWwvcGFuZWwtc2ltcGxlLWRzaS55YW1sIw0KPiArJHNj
aGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ICsN
Cj4gK3RpdGxlOiBTaW1wbGUgRFNJIHBhbmVscyB3aXRoIGEgc2luZ2xlIHBvd2VyLXN1cHBseQ0K
PiArDQo+ICttYWludGFpbmVyczoNCj4gKyAgLSBUaGllcnJ5IFJlZGluZyA8dGhpZXJyeS5yZWRp
bmdAZ21haWwuY29tPg0KPiArICAtIFNhbSBSYXZuYm9yZyA8c2FtQHJhdm5ib3JnLm9yZz4NCj4g
Kw0KPiArZGVzY3JpcHRpb246IHwNCj4gKyAgVGhpcyBiaW5kaW5nIGZpbGUgaXMgYSBjb2xsZWN0
aW9uIG9mIHRoZSBEU0kgcGFuZWxzIHRoYXQNCj4gKyAgcmVxdWlyZXMgb25seSBhIHNpbmdsZSBw
b3dlci1zdXBwbHkuDQo+ICsgIFRoZXJlIGFyZSBvcHRpb25hbGx5IGEgYmFja2xpZ2h0IGFuZCBh
biBlbmFibGUgR1BJTy4NCj4gKyAgVGhlIHBhbmVsIG1heSB1c2UgYW4gT0YgZ3JhcGggYmluZGlu
ZyBmb3IgdGhlIGFzc29jaWF0aW9uIHRvIHRoZSBkaXNwbGF5LA0KPiArICBvciBpdCBtYXkgYmUg
YSBkaXJlY3QgY2hpbGQgbm9kZSBvZiB0aGUgZGlzcGxheS4NCj4gKw0KPiArICBJZiB0aGUgcGFu
ZWwgaXMgbW9yZSBhZHZhbmNlZCBhIGRlZGljYXRlZCBiaW5kaW5nIGZpbGUgaXMgcmVxdWlyZWQu
DQo+ICsNCj4gK2FsbE9mOg0KPiArICAtICRyZWY6IHBhbmVsLWNvbW1vbi55YW1sIw0KPiArDQo+
ICtwcm9wZXJ0aWVzOg0KPiArDQo+ICsgIGNvbXBhdGlibGU6DQo+ICsgICAgZW51bToNCj4gKyAg
ICAgICMgY29tcGF0aWJsZSBtdXN0IGJlIGxpc3RlZCBpbiBhbHBoYWJldGljYWwgb3JkZXIsIG9y
ZGVyZWQgYnkgY29tcGF0aWJsZS4NCj4gKyAgICAgICMgVGhlIGRlc2NyaXB0aW9uIGluIHRoZSBj
b21tZW50IGlzIG1hbmRhdG9yeSBmb3IgZWFjaCBjb21wYXRpYmxlLg0KPiArDQo+ICsgICAgICAg
ICMgUGFuYXNvbmljIDEwIiBXVVhHQSBURlQgTENEIHBhbmVsDQo+ICsgICAgICAtIHBhbmFzb25p
Yyx2dngxMGYwMzRuMDANCj4gKw0KPiArICByZWc6DQo+ICsgICAgbWF4SXRlbXM6IDENCj4gKyAg
ICBkZXNjcmlwdGlvbjogRFNJIHZpcnR1YWwgY2hhbm5lbA0KPiArDQo+ICsgIGJhY2tsaWdodDog
dHJ1ZQ0KPiArICBlbmFibGUtZ3Bpb3M6IHRydWUNCj4gKyAgcG9ydDogdHJ1ZQ0KPiArICBwb3dl
ci1zdXBwbHk6IHRydWUNCj4gKw0KPiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ICsN
Cj4gK3JlcXVpcmVkOg0KPiArICAtIGNvbXBhdGlibGUNCj4gKyAgLSBwb3dlci1zdXBwbHkNCj4g
KyAgLSByZWcNCj4gKw0KPiArZXhhbXBsZXM6DQo+ICsgIC0gfA0KPiArICAgIG1kc3NfZHNpQGZk
OTIyODAwIHsNCj4gKyAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiArICAgICAgI3NpemUt
Y2VsbHMgPSA8MD47DQo+ICsgICAgICBwYW5lbEAwIHsNCj4gKyAgICAgICAgY29tcGF0aWJsZSA9
ICJwYW5hc29uaWMsdnZ4MTBmMDM0bjAwIjsNCj4gKyAgICAgICAgcmVnID0gPDA+Ow0KPiArICAg
ICAgICBwb3dlci1zdXBwbHkgPSA8JnZjY19sY2RfcmVnPjsNCj4gKw0KPiArICAgICAgICBwb3J0
IHsNCj4gKyAgICAgICAgICBwYW5lbDogZW5kcG9pbnQgew0KPiArICAgICAgICAgICAgcmVtb3Rl
LWVuZHBvaW50ID0gPCZsdGRjX291dD47DQo+ICsgICAgICAgICAgfTsNCj4gKyAgICAgICAgfTsN
Cj4gKyAgICAgIH07DQo+ICsgICAgfTsNCj4g
