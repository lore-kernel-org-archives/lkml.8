Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D422C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 12:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 489A42080D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 12:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgGUM1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 08:27:39 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:42816 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727025AbgGUM1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 08:27:39 -0400
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 19ABA1480FECEBDBDB13;
        Tue, 21 Jul 2020 20:27:26 +0800 (CST)
Received: from DGGEMM422-HUB.china.huawei.com (10.1.198.39) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 21 Jul 2020 20:27:25 +0800
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.195]) by
 dggemm422-hub.china.huawei.com ([10.1.198.39]) with mapi id 14.03.0487.000;
 Tue, 21 Jul 2020 20:27:17 +0800
From:   "liwei (CM)" <liwei213@huawei.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
CC:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        fengbaopeng <fengbaopeng2@hisilicon.com>,
        "nsaenzjulienne@suse.de" <nsaenzjulienne@suse.de>,
        "steve.capper@arm.com" <steve.capper@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        sujunfei <sujunfei2@hisilicon.com>,
        "Xiaqing (A)" <saberlily.xia@hisilicon.com>,
        "Yaobaofeng (Yaobaofeng)" <yaobaofeng@huawei.com>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSF0gYXJtNjQ6IG1tOiBmcmVlIHVudXNl?=
 =?utf-8?B?ZCBtZW1tYXAgZm9yIHNwYXJzZSBtZW1vcnkgbW9kZWwgdGhhdCBkZWZpbmUg?=
 =?utf-8?Q?VMEMMAP?=
Thread-Topic: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGFybTY0OiBtbTogZnJlZSB1bnVzZWQgbWVtbWFw?=
 =?utf-8?Q?_for_sparse_memory_model_that_define_VMEMMAP?=
Thread-Index: AQHWVMrtO0CAKNNn+U+1wOV2mLLlGKj8wE6AgACJU9CAAV82gIASsSBA///IkQCAAOew8A==
Date:   Tue, 21 Jul 2020 12:27:16 +0000
Message-ID: <1699CE87DE933F49876AD744B5DC140F2312BA84@dggemm526-mbx.china.huawei.com>
References: <20200708015555.14946-1-liwei213@huawei.com>
 <B926444035E5E2439431908E3842AFD255E7A1@DGGEMI525-MBS.china.huawei.com>
 <1699CE87DE933F49876AD744B5DC140F230F8396@DGGEMM506-MBS.china.huawei.com>
 <B926444035E5E2439431908E3842AFD256289A@DGGEMI525-MBS.china.huawei.com>
 <1699CE87DE933F49876AD744B5DC140F2312A02B@dggemm526-mbx.china.huawei.com>
 <20200721063524.GC802087@linux.ibm.com>
In-Reply-To: <20200721063524.GC802087@linux.ibm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.77.141]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCuWPkeS7tuS6ujogTWlrZSBSYXBvcG9ydCBbbWFp
bHRvOnJwcHRAbGludXguaWJtLmNvbV0gDQrlj5HpgIHml7bpl7Q6IDIwMjDlubQ35pyIMjHml6Ug
MTQ6MzUNCuaUtuS7tuS6ujogbGl3ZWkgKENNKSA8bGl3ZWkyMTNAaHVhd2VpLmNvbT4NCuaKhOmA
gTogU29uZyBCYW8gSHVhIChCYXJyeSBTb25nKSA8c29uZy5iYW8uaHVhQGhpc2lsaWNvbi5jb20+
OyBjYXRhbGluLm1hcmluYXNAYXJtLmNvbTsgd2lsbEBrZXJuZWwub3JnOyBmZW5nYmFvcGVuZyA8
ZmVuZ2Jhb3BlbmcyQGhpc2lsaWNvbi5jb20+OyBuc2FlbnpqdWxpZW5uZUBzdXNlLmRlOyBzdGV2
ZS5jYXBwZXJAYXJtLmNvbTsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBzdWp1bmZlaSA8c3VqdW5mZWkyQGhpc2lsaWNv
bi5jb20+OyBYaWFxaW5nIChBKSA8c2FiZXJsaWx5LnhpYUBoaXNpbGljb24uY29tPjsgWWFvYmFv
ZmVuZyAoWWFvYmFvZmVuZykgPHlhb2Jhb2ZlbmdAaHVhd2VpLmNvbT4NCuS4u+mimDogUmU6IOet
lOWkjTogW1BBVENIXSBhcm02NDogbW06IGZyZWUgdW51c2VkIG1lbW1hcCBmb3Igc3BhcnNlIG1l
bW9yeSBtb2RlbCB0aGF0IGRlZmluZSBWTUVNTUFQDQoNCkhpLA0KDQpPbiBUdWUsIEp1bCAyMSwg
MjAyMCBhdCAwMTo1NjozM0FNICswMDAwLCBsaXdlaSAoQ00pIHdyb3RlOg0KPiBIaSwgYWxsDQo+
IA0KPiBJJ20gc29ycnkgdG8gYm90aGVyIHlvdSwgYnV0IHN0aWxsIHZlcnkgaG9wZSB5b3UgY2Fu
IGdpdmUgY29tbWVudHMgb3Igc3VnZ2VzdGlvbnMgdG8gdGhpcyBwYXRjaCwgdGhhbmsgeW91IHZl
cnkgbXVjaC4NCiANCkkgY2Fubm90IGZpbmQgeW91ciBwYXRjaCBuZWl0aGVyIGluIEluYm94IG5v
ciBpbiB0aGUgcHVibGljIGFyY2hpdmVzLg0KQ2FuIHlvdSByZXNlbmQgaXQgcGxlYXNlPw0KDQpI
aSwgTWlrZQ0KDQpJIHJlc2VuZCB0aGUgcGF0Y2gsIGlmIHlvdSBzZWUgcGxlYXNlIGdpdmUgYWR2
aWNlLCB0aGFua3MhDQoNCg0KDQo+IC0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCj4g5Y+R5Lu25Lq6
OiBTb25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcpDQo+IOWPkemAgeaXtumXtDogMjAyMOW5tDfmnIg5
5pelIDIwOjI3DQo+IOaUtuS7tuS6ujogbGl3ZWkgKENNKSA8bGl3ZWkyMTNAaHVhd2VpLmNvbT47
IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOyANCj4gd2lsbEBrZXJuZWwub3JnDQo+IOaKhOmAgTog
ZmVuZ2Jhb3BlbmcgPGZlbmdiYW9wZW5nMkBoaXNpbGljb24uY29tPjsgbnNhZW56anVsaWVubmVA
c3VzZS5kZTsgDQo+IHN0ZXZlLmNhcHBlckBhcm0uY29tOyBycHB0QGxpbnV4LmlibS5jb207IA0K
PiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IA0KPiBzdWp1bmZlaSA8c3VqdW5mZWkyQGhpc2lsaWNvbi5jb20+OyBYaWFx
aW5nIChBKSANCj4gPHNhYmVybGlseS54aWFAaGlzaWxpY29uLmNvbT47IFlhb2Jhb2ZlbmcgKFlh
b2Jhb2ZlbmcpIA0KPiA8eWFvYmFvZmVuZ0BodWF3ZWkuY29tPg0KPiDkuLvpopg6IFJFOiBbUEFU
Q0hdIGFybTY0OiBtbTogZnJlZSB1bnVzZWQgbWVtbWFwIGZvciBzcGFyc2UgbWVtb3J5IG1vZGVs
IA0KPiB0aGF0IGRlZmluZSBWTUVNTUFQDQo+IA0KPiANCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBsaXdlaSAoQ00pDQo+ID4gU2VudDogV2VkbmVzZGF5LCBK
dWx5IDgsIDIwMjAgNzo1MiBQTQ0KPiA+IFRvOiBTb25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcpIDxz
b25nLmJhby5odWFAaGlzaWxpY29uLmNvbT47IA0KPiA+IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29t
OyB3aWxsQGtlcm5lbC5vcmcNCj4gPiBDYzogZmVuZ2Jhb3BlbmcgPGZlbmdiYW9wZW5nMkBoaXNp
bGljb24uY29tPjsgDQo+ID4gbnNhZW56anVsaWVubmVAc3VzZS5kZTsgc3RldmUuY2FwcGVyQGFy
bS5jb207IHJwcHRAbGludXguaWJtLmNvbTsgDQo+ID4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyANCj4gPiBzdWp1bmZl
aSA8c3VqdW5mZWkyQGhpc2lsaWNvbi5jb20+OyBYaWFxaW5nIChBKSANCj4gPiA8c2FiZXJsaWx5
LnhpYUBoaXNpbGljb24uY29tPjsgWWFvYmFvZmVuZyAoWWFvYmFvZmVuZykgDQo+ID4gPHlhb2Jh
b2ZlbmdAaHVhd2VpLmNvbT4NCj4gPiBTdWJqZWN0OiDnrZTlpI06IFtQQVRDSF0gYXJtNjQ6IG1t
OiBmcmVlIHVudXNlZCBtZW1tYXAgZm9yIHNwYXJzZSBtZW1vcnkgDQo+ID4gbW9kZWwgdGhhdCBk
ZWZpbmUgVk1FTU1BUA0KPiA+IA0KPiA+IEhpLCBiYW9odWENCj4gPiANCj4gPiBUaGFuayB5b3Ug
Zm9yIHlvdXIgYXR0ZW50aW9uLg0KPiA+IA0KPiA+IEluIG15IHVuZGVyc3RhbmRpbmcgb2YgdGhl
IE1FTU9SWV9IT1RQTFVHIHRoaXMgcGF0Y2ggaGFzIG5vIGVmZmVjdCBvbiBpdC4NCj4gPiBUaGUg
cmVhc29uIGlzIHRoYXQgaW4gc3BhcnNlX2FkZF9vbmVfc2VjdGlvbigpIHRoZSBtZW1vcnkgdGhh
dCANCj4gPiBtZW1tYXAgbmVlZHMgZnJvbSBTbGFiIGlmIGtlcm5lbCBzdGFydCBjb21wbGV0ZWTv
vIx0aGlzIG1lbW9yeSBoYXMgDQo+ID4gbm90aGluZyB0byBkbyB3aXRoIG1lbWJsb2NrIGFsbG9j
LyBmcmVlIG1lbW9yeSBpbiB0aGUgcHJvY2VzcyBvZiBrZXJuZWwgc3RhcnQuDQo+ID4gDQo+ID4g
WW91IG1heSBoYXZlIGEgbG9vayB2bWVtbWFwX2FsbG9jX2Jsb2NrICgpIHRoaXMgZnVuY3Rpb24u
DQo+ID4gDQo+ID4gSWYgSSBkb24ndCB1bmRlcnN0YW5kIHJpZ2h0IHdlbGNvbWUgcG9pbnRlZCBv
dXQgaW4gYSB0aW1lbHkgbWFubmVyLg0KPiANCj4gQXQgdGhlIGZpcnN0IGdsYW5jZSBvZiB0aGlz
IHBhdGNoLCBJIHN1c3BlY3QgdGhhdCB0aGlzIGJvb3RtZW0gbWF5IGJlIHVzZWQgYnkgaG90LWFk
ZGVkIG1lbW9yeS4NCj4gSWYgeW91IGNvbmZpcm0gdGhpcyB3b24ndCBoYXBwZW4sIHBsZWFzZSBp
Z25vcmUgbXkgbm9pc2UuDQo+IA0KPiBCVFcsIG5leHQgdGltZSwgYmVhciBpbiBtaW5kIHRoYXQg
dG9wLXBvc3QgaXMgbm90IGEgZ29vZCB3YXkgdG8gcmVwbHkgDQo+IG1haWwgOi0pDQo+IA0KPiA+
IA0KPiA+IFRoYW5rcyENCj4gPiANCj4gPiANCj4gPiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+
ID4g5Y+R5Lu25Lq6OiBTb25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcpDQo+ID4g5Y+R6YCB5pe26Ze0
OiAyMDIw5bm0N+aciDjml6UgMTU6MTkNCj4gPiDmlLbku7bkuro6IGxpd2VpIChDTSkgPGxpd2Vp
MjEzQGh1YXdlaS5jb20+OyBjYXRhbGluLm1hcmluYXNAYXJtLmNvbTsgDQo+ID4gd2lsbEBrZXJu
ZWwub3JnDQo+ID4g5oqE6YCBOiBmZW5nYmFvcGVuZyA8ZmVuZ2Jhb3BlbmcyQGhpc2lsaWNvbi5j
b20+OyANCj4gPiBuc2FlbnpqdWxpZW5uZUBzdXNlLmRlOyBzdGV2ZS5jYXBwZXJAYXJtLmNvbTsg
cnBwdEBsaW51eC5pYm0uY29tOyANCj4gPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IA0KPiA+IHN1anVuZmVpIDxzdWp1
bmZlaTJAaGlzaWxpY29uLmNvbT4NCj4gPiDkuLvpopg6IFJFOiBbUEFUQ0hdIGFybTY0OiBtbTog
ZnJlZSB1bnVzZWQgbWVtbWFwIGZvciBzcGFyc2UgbWVtb3J5IA0KPiA+IG1vZGVsIHRoYXQgZGVm
aW5lIFZNRU1NQVANCj4gPiANCj4gPiANCj4gPiANCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+ID4gPiBGcm9tOiBsaXdlaSAoQ00pDQo+ID4gPiBTZW50OiBXZWRuZXNkYXksIEp1
bHkgOCwgMjAyMCAxOjU2IFBNDQo+ID4gPiBUbzogY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IHdp
bGxAa2VybmVsLm9yZw0KPiA+ID4gQ2M6IGxpd2VpIChDTSkgPGxpd2VpMjEzQGh1YXdlaS5jb20+
OyBmZW5nYmFvcGVuZyANCj4gPiA+IDxmZW5nYmFvcGVuZzJAaGlzaWxpY29uLmNvbT47IG5zYWVu
emp1bGllbm5lQHN1c2UuZGU7IA0KPiA+ID4gc3RldmUuY2FwcGVyQGFybS5jb207IHJwcHRAbGlu
dXguaWJtLmNvbTsgU29uZyBCYW8gSHVhIChCYXJyeSANCj4gPiA+IFNvbmcpIDxzb25nLmJhby5o
dWFAaGlzaWxpY29uLmNvbT47IA0KPiA+ID4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnOw0KPiA+ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgc3VqdW5mZWkgPHN1
anVuZmVpMkBoaXNpbGljb24uY29tPg0KPiA+ID4gU3ViamVjdDogW1BBVENIXSBhcm02NDogbW06
IGZyZWUgdW51c2VkIG1lbW1hcCBmb3Igc3BhcnNlIG1lbW9yeQ0KPiA+IG1vZGVsDQo+ID4gPiB0
aGF0IGRlZmluZSBWTUVNTUFQDQo+ID4gPg0KPiA+ID4gRm9yIHRoZSBtZW1vcnkgaG9sZSwgc3Bh
cnNlIG1lbW9yeSBtb2RlbCB0aGF0IGRlZmluZQ0KPiA+IFNQQVJTRU1FTV9WTUVNTUFQDQo+ID4g
PiBkbyBub3QgZnJlZSB0aGUgcmVzZXJ2ZWQgbWVtb3J5IGZvciB0aGUgcGFnZSBtYXAsIHRoaXMg
cGF0Y2ggZG8gaXQuDQo+ID4gDQo+ID4gSGVsbG8gV2VpLA0KPiA+IEp1c3QgY3VyaW91cyBpZiB0
aGlzIHBhdGNoIGJyZWFrcyBNRU1PUllfSE9UUExVRz8NCj4gPiANCj4gPiA+DQo+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBXZWkgTGkgPGxpd2VpMjEzQGh1YXdlaS5jb20+DQo+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBDaGVuIEZlbmcgPHB1Y2suY2hlbkBoaXNpbGljb24uY29tPg0KPiA+ID4gU2lnbmVkLW9m
Zi1ieTogWGlhIFFpbmcgPHNhYmVybGlseS54aWFAaGlzaWxpY29uLmNvbT4NCj4gPiA+IC0tLQ0K
PiA+ID4gIGFyY2gvYXJtNjQvbW0vaW5pdC5jIHwgODENCj4gPiA+ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgNzEgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAt
LWdpdCBhL2FyY2gvYXJtNjQvbW0vaW5pdC5jIGIvYXJjaC9hcm02NC9tbS9pbml0LmMgaW5kZXgg
DQo+ID4gPiAxZTkzY2ZjN2M0N2EuLmQxYjU2YjQ3ZDViYSAxMDA2NDQNCj4gPiA+IC0tLSBhL2Fy
Y2gvYXJtNjQvbW0vaW5pdC5jDQo+ID4gPiArKysgYi9hcmNoL2FybTY0L21tL2luaXQuYw0KPiA+
ID4gQEAgLTQ0MSw3ICs0NDEsNDggQEAgdm9pZCBfX2luaXQgYm9vdG1lbV9pbml0KHZvaWQpDQo+
ID4gPiAgCW1lbWJsb2NrX2R1bXBfYWxsKCk7DQo+ID4gPiAgfQ0KPiA+ID4NCj4gPiANCj4gPiBU
aGFua3MNCj4gPiBCYXJyeQ0KPiANCg0KLS0NClNpbmNlcmVseSB5b3VycywNCk1pa2UuDQo=
