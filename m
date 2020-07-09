Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BED9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 23:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 169A62070E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 23:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgGIXpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 19:45:46 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2569 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726433AbgGIXpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 19:45:46 -0400
Received: from dggemi402-hub.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 40CF658EE18A1E123377;
        Fri, 10 Jul 2020 07:45:43 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.177]) by
 dggemi402-hub.china.huawei.com ([10.3.17.135]) with mapi id 14.03.0487.000;
 Fri, 10 Jul 2020 07:45:34 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Roman Gushchin <guro@fb.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "Jonathan Cameron" <jonathan.cameron@huawei.com>
Subject: RE: [PATCH v3] mm/hugetlb: avoid hardcoding while checking if cma
 is enable
Thread-Topic: [PATCH v3] mm/hugetlb: avoid hardcoding while checking if cma
 is enable
Thread-Index: AQHWVBOoulIbQRW0JUWzWUpoYRXjrqj8AzOAgAFtnQCAABEKgIAAvWLggADYSICAANMYAA==
Date:   Thu, 9 Jul 2020 23:45:33 +0000
Message-ID: <B926444035E5E2439431908E3842AFD256460F@DGGEMI525-MBS.china.huawei.com>
References: <20200707040204.30132-1-song.bao.hua@hisilicon.com>
 <20200707125641.dbd2ccd63f525aa5870069d8@linux-foundation.org>
 <9066e009-5ed2-1992-d70d-fd27b4bf5871@oracle.com>
 <20200708184615.GA251665@carbon.dhcp.thefacebook.com>
 <B926444035E5E2439431908E3842AFD2560E41@DGGEMI525-MBS.china.huawei.com>
 <b2a98ab7-0a36-ad3d-f40d-1cc9216c7961@oracle.com>
In-Reply-To: <b2a98ab7-0a36-ad3d-f40d-1cc9216c7961@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.68]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWlrZSBLcmF2ZXR6IFtt
YWlsdG86bWlrZS5rcmF2ZXR6QG9yYWNsZS5jb21dDQo+IFNlbnQ6IEZyaWRheSwgSnVseSAxMCwg
MjAyMCA2OjU4IEFNDQo+IFRvOiBTb25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcpIDxzb25nLmJhby5o
dWFAaGlzaWxpY29uLmNvbT47IFJvbWFuDQo+IEd1c2hjaGluIDxndXJvQGZiLmNvbT4NCj4gQ2M6
IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+OyBsaW51eC1tbUBrdmFj
ay5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IExpbnV4YXJtIDxsaW51eGFy
bUBodWF3ZWkuY29tPjsgSm9uYXRoYW4NCj4gQ2FtZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBodWF3
ZWkuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzXSBtbS9odWdldGxiOiBhdm9pZCBoYXJk
Y29kaW5nIHdoaWxlIGNoZWNraW5nIGlmIGNtYQ0KPiBpcyBlbmFibGUNCj4gDQo+IExvb2tzIGxp
a2UgdGhpcyBwcm9kdWNlZCBhIHdhcm5pbmcgaW4gbGludXgtbmV4dC4gIEkgc3VzcGVjdCBpdCBp
cyBkdWUgdG8gdGhlDQo+IGNvbWJpbmF0aW9uIENPTkZJR19IVUdFVExCX1BBR0UgJiYgIUNPTkZJ
R19DTUEuDQo+IA0KPiBJbnN0ZWFkIG9mIGFkZGluZyB0aGUgcm91dGluZSBodWdldGxiX2NtYV9l
bmFibGVkKCkgdG8gc2NhbiB0aGUgaHVnZXRsYl9jbWENCj4gYXJyYXksIGNvdWxkIHdlIGp1c3Qg
dXNlIGEgYm9vbGVhbiBhcyBmb2xsb3dzPyAgSXQgY2FuIHNpbXBseSBiZSBzZXQgaW4NCj4gaHVn
ZXRsYl9jbWFfcmVzZXJ2ZSB3aGVuIHdlIHJlc2VydmUgQ01BLg0KDQpNYXliZSBqdXN0IHVzZSBo
dWdldGxiX2NtYV9zaXplPyBJZiBodWdldGxiX2NtYV9zaXplIGlzIG5vdCAwLCBzb21lb25lIGlz
IHRyeWluZyB0byB1c2UNCmNtYSwgdGhlbiBib290bWVtIGZvciBnaWdhbnRpYyBwYWdlcyB3aWxs
IGJlIHRvdGFsbHkgaWdub3JlZCBhY2NvcmRpbmcgdG8gZGlzY3Vzc2lvbiBoZXJlOg0KaHR0cHM6
Ly9sa21sLm9yZy9sa21sLzIwMjAvNy84LzEyODgNCg0KaWYgc29tZWJvZHkgc2V0cyBhIHdyb25n
IGh1Z2V0bGJfY21hX3NpemUgd2hpY2ggY2F1c2VzIHRoYXQgY21hIGlzIG5vdCByZXNlcnZlZC4g
DQpJdCBpcyB0aGUgZmF1bHQgb2YgdXNlcnM/IFdlIGp1c3QgbmVlZCB0byBkb2N1bWVudCBodWdl
dGxiX2NtYSB3aWxsIG92ZXJ3cml0ZSBib290bWVtDQpyZXNlcnZhdGlvbnM/DQoNCj4gLS0NCj4g
TWlrZSBLcmF2ZXR6DQo+IA0KPiBkaWZmIC0tZ2l0IGEvbW0vaHVnZXRsYi5jIGIvbW0vaHVnZXRs
Yi5jDQo+IGluZGV4IGZhYjQ0ODViOWU1Mi4uOTJjYjg4MmNmMjg3IDEwMDY0NA0KPiAtLS0gYS9t
bS9odWdldGxiLmMNCj4gKysrIGIvbW0vaHVnZXRsYi5jDQo+IEBAIC00Niw2ICs0Niw3IEBAIHVu
c2lnbmVkIGludCBkZWZhdWx0X2hzdGF0ZV9pZHg7DQo+ICBzdHJ1Y3QgaHN0YXRlIGhzdGF0ZXNb
SFVHRV9NQVhfSFNUQVRFXTsNCj4gDQo+ICBzdGF0aWMgc3RydWN0IGNtYSAqaHVnZXRsYl9jbWFb
TUFYX05VTU5PREVTXTsNCj4gK3N0YXRpYyBib29sIGh1Z2V0bGJfY21hX2VuYWJsZWQgPSBmYWxz
ZTsNCj4gDQo+ICAvKg0KPiAgICogTWluaW11bSBwYWdlIG9yZGVyIGFtb25nIHBvc3NpYmxlIGh1
Z2VwYWdlIHNpemVzLCBzZXQgdG8gYSBwcm9wZXIgdmFsdWUNCj4gQEAgLTI1NzEsNyArMjU3Miw3
IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBodWdldGxiX2hzdGF0ZV9hbGxvY19wYWdlcyhzdHJ1Y3QN
Cj4gaHN0YXRlICpoKQ0KPiANCj4gIAlmb3IgKGkgPSAwOyBpIDwgaC0+bWF4X2h1Z2VfcGFnZXM7
ICsraSkgew0KPiAgCQlpZiAoaHN0YXRlX2lzX2dpZ2FudGljKGgpKSB7DQo+IC0JCQlpZiAoSVNf
RU5BQkxFRChDT05GSUdfQ01BKSAmJiBodWdldGxiX2NtYVswXSkgew0KPiArCQkJaWYgKGh1Z2V0
bGJfY21hX2VuYWJsZWQpIHsNCj4gIAkJCQlwcl93YXJuX29uY2UoIkh1Z2VUTEI6IGh1Z2V0bGJf
Y21hIGlzIGVuYWJsZWQsIHNraXANCj4gYm9vdCB0aW1lIGFsbG9jYXRpb25cbiIpOw0KPiAgCQkJ
CWJyZWFrOw0KPiAgCQkJfQ0KPiBAQCAtNTcwOCw2ICs1NzA5LDcgQEAgdm9pZCBfX2luaXQgaHVn
ZXRsYl9jbWFfcmVzZXJ2ZShpbnQgb3JkZXIpDQo+ICAJCXJlc2VydmVkICs9IHNpemU7DQo+ICAJ
CXByX2luZm8oImh1Z2V0bGJfY21hOiByZXNlcnZlZCAlbHUgTWlCIG9uIG5vZGUgJWRcbiIsDQo+
ICAJCQlzaXplIC8gU1pfMU0sIG5pZCk7DQo+ICsJCWh1Z2V0bGJfY21hX2VuYWJsZWQgPSB0cnVl
Ow0KPiANCj4gIAkJaWYgKHJlc2VydmVkID49IGh1Z2V0bGJfY21hX3NpemUpDQo+ICAJCQlicmVh
azsNCg0KVGhhbmtzDQpCYXJyeQ0KDQo=
