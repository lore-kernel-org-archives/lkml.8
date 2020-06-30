Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87C1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ACE720809
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="L21DghCH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732734AbgF3Kzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 06:55:49 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:61098 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732632AbgF3Kzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 06:55:48 -0400
X-UUID: d155703b879a48469e70dd2ed73a9869-20200630
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=bwKT46w9uGcCWgvZnA7Tt6P0SET70mbkJOxHElU0i8s=;
        b=L21DghCHrWldFdaBSXQEGQ15toyjeowj4Fz6tLIXxfOZVWi/ZgOWk3dUAzLmwXcQNIq7cxVGoNhVou11ecJSdwYt8il9snVbilXxT2Y3Bzui3VjK5g1pnnCZ9DKO+oNbtulUvN9Wf54WzvgaHY7bmCGMp6z9BxgSL3TaE92dGlY=;
X-UUID: d155703b879a48469e70dd2ed73a9869-20200630
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1915969159; Tue, 30 Jun 2020 18:55:40 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 30 Jun
 2020 18:55:34 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 30 Jun 2020 18:55:35 +0800
Message-ID: <1593514516.24171.25.camel@mhfsdcap03>
Subject: Re: [PATCH v5 06/10] iommu/mediatek: Add sub_comm id in translation
 fault
From:   Yong Wu <yong.wu@mediatek.com>
To:     Chao Hao <chao.hao@mediatek.com>
CC:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Evan Green <evgreen@chromium.org>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        FY Yang <fy.yang@mediatek.com>
Date:   Tue, 30 Jun 2020 18:55:16 +0800
In-Reply-To: <20200629071310.1557-7-chao.hao@mediatek.com>
References: <20200629071310.1557-1-chao.hao@mediatek.com>
         <20200629071310.1557-7-chao.hao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: D7FCA91426CFD155D58B85D54AA5A21697363337348731C64131373A298F8F732000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA2LTI5IGF0IDE1OjEzICswODAwLCBDaGFvIEhhbyB3cm90ZToNCj4gVGhl
IG1heCBsYXJiIG51bWJlciB0aGF0IGEgaW9tbXUgSFcgc3VwcG9ydCBpcyA4KGxhcmIwfmxhcmI3
IGluIHRoZSBiZWxvdw0KPiBkaWFncmFtKS4NCj4gSWYgdGhlIGxhcmIncyBudW1iZXIgaXMgb3Zl
ciA4LCB3ZSB1c2UgYSBzdWJfY29tbW9uIGZvciBtZXJnaW5nDQo+IHNldmVyYWwgbGFyYnMgaW50
byBvbmUgbGFyYi4gQXQgdGhpcyBjYXNlLCB3ZSB3aWxsIGV4dGVuZCBsYXJiX2lkOg0KPiBiaXRb
MTE6OV0gbWVhbnMgY29tbW9uLWlkOw0KPiBiaXRbODo3XSBtZWFucyBzdWJjb21tb24taWQ7DQo+
IEZyb20gdGhlc2UgdHdvIHZhcmlhYmxlcywgd2UgY291bGQgZ2V0IHRoZSByZWFsIGxhcmIgbnVt
YmVyIHdoZW4NCj4gdHJhbnNsYXRpb24gZmF1bHQgaGFwcGVuLg0KPiBUaGUgZGlhZ3JhbSBpcyBh
cyBiZWxvdzoNCj4gCQkgRU1JDQo+IAkJICB8DQo+IAkJSU9NTVUNCj4gCQkgIHwNCj4gICAgICAg
ICAgICAtLS0tLS0tLS0tLS0tLS0tLQ0KPiAJICAgfCAgICAgICAgICAgICAgIHwNCj4gCWNvbW1v
bjEgICAJY29tbW9uMA0KPiAJICAgfAkJICAgfA0KPiAJICAgLS0tLS0tLS0tLS0tLS0tLS0NCj4g
CQkgIHwNCj4gICAgICAgICAgICAgIHNtaSBjb21tb24NCj4gCQkgIHwNCj4gICAtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICB8ICAgICAgIHwgICAgICAgfCAgICAgICB8
ICAgICB8ICAgIHwNCj4gIDMnZDAgICAgMydkMSAgICAzJ2QyICAgIDMnZDMgIC4uLiAgMydkNyAg
IDwtY29tbW9uX2lkKG1heCBpcyA4KQ0KPiAgIHwgICAgICAgfCAgICAgICB8ICAgICAgIHwgICAg
IHwgICAgfA0KPiBMYXJiMCAgIExhcmIxICAgICB8ICAgICBMYXJiMyAgLi4uIExhcmI3DQo+IAkJ
ICB8DQo+IAkgICAgc21pIHN1YiBjb21tb24NCj4gCQkgIHwNCj4gICAgICAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KPiAgICAgIHwgICAgICAgIHwgICAgICAgfCAgICAgICB8DQo+ICAgICAy
J2QwICAgICAyJ2QxICAgIDInZDIgICAgMidkMyAgIDwtc3ViX2NvbW1vbl9pZChtYXggaXMgNCkN
Cj4gICAgICB8ICAgICAgICB8ICAgICAgIHwgICAgICAgfA0KPiAgICBMYXJiOCAgICBMYXJiOSAg
IExhcmIxMCAgTGFyYjExDQo+IA0KPiBJbiB0aGlzIHBhdGNoIHdlIGV4dGVuZCBsYXJiX3JlbWFw
W10gdG8gbGFyYl9yZW1hcFs4XVs0XSBmb3IgdGhpcy4NCj4gbGFyYl9yZW1hcFt4XVt5XTogeCBt
ZWFucyBjb21tb24taWQgYWJvdmUsIHkgbWVhbnMgc3ViY29tbW9uX2lkIGFib3ZlLg0KPiANCj4g
V2UgY2FuIGFsc28gZGlzdGluZ3Vpc2ggaWYgdGhlIE00VSBIVyBoYXMgc3ViX2NvbW1vbiBieSBI
QVNfU1VCX0NPTU0NCj4gbWFjcm8uDQo+IA0KPiBDYzogTWF0dGhpYXMgQnJ1Z2dlciA8bWF0dGhp
YXMuYmdnQGdtYWlsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQ2hhbyBIYW8gPGNoYW8uaGFvQG1l
ZGlhdGVrLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29t
Pg0KPiAtLS0NCj4gIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgIHwgMjAgKysrKysrKysrKysr
Ky0tLS0tLS0NCj4gIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmggIHwgIDMgKystDQo+ICBpbmNs
dWRlL3NvYy9tZWRpYXRlay9zbWkuaCB8ICAyICsrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDE3IGlu
c2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQoNCltzbmlwXQ0KDQo+IEBAIC00OCw3ICs0OSw3
IEBAIHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIHsNCj4gIAllbnVtIG10a19pb21tdV9wbGF0
IG00dV9wbGF0Ow0KPiAgCXUzMiAgICAgICAgICAgICAgICAgZmxhZ3M7DQo+ICAJdTMyICAgICAg
ICAgICAgICAgICBpbnZfc2VsX3JlZzsNCj4gLQl1bnNpZ25lZCBjaGFyICAgICAgIGxhcmJpZF9y
ZW1hcFtNVEtfTEFSQl9OUl9NQVhdOw0KPiArCXVuc2lnbmVkIGNoYXIgICAgICAgbGFyYmlkX3Jl
bWFwW01US19MQVJCX0NPTV9NQVhdW01US19MQVJCX1NVQkNPTV9NQVhdOw0KPiAgfTsNCj4gIA0K
PiAgc3RydWN0IG10a19pb21tdV9kb21haW47DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3NvYy9t
ZWRpYXRlay9zbWkuaCBiL2luY2x1ZGUvc29jL21lZGlhdGVrL3NtaS5oDQo+IGluZGV4IDVhMzRi
ODdkODllMy4uZmE2NWE1NTQ2OGUyIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL3NvYy9tZWRpYXRl
ay9zbWkuaA0KPiArKysgYi9pbmNsdWRlL3NvYy9tZWRpYXRlay9zbWkuaA0KPiBAQCAtMTIsNiAr
MTIsOCBAQA0KPiAgI2lmZGVmIENPTkZJR19NVEtfU01JDQo+ICANCj4gICNkZWZpbmUgTVRLX0xB
UkJfTlJfTUFYCQkxNg0KPiArI2RlZmluZSBNVEtfTEFSQl9DT01fTUFYCTgNCj4gKyNkZWZpbmUg
TVRLX0xBUkJfU1VCQ09NX01BWAk0DQoNCkJvdGggYXJlIG9ubHkgdXNlZCBpbiBtdGtfaW9tbXUu
aCwgYW5kIEkgZG9uJ3QgdGhpbmsgc21pIGhhcyBwbGFuIHRvIHVzZQ0KdGhlbS4gdGh1cyB3ZSBj
b3VsZCBtb3ZlIHRoZW0gaW50byBtdGtfaW9tbXUuaA0KDQo+ICANCj4gICNkZWZpbmUgTVRLX1NN
SV9NTVVfRU4ocG9ydCkJQklUKHBvcnQpDQo+ICANCg0K

