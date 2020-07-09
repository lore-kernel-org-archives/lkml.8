Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D320C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 12:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6E8D20708
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 12:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgGIM10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 08:27:26 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:35344 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726605AbgGIM10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 08:27:26 -0400
Received: from dggemi405-hub.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id D44486ED531235F12C5A;
        Thu,  9 Jul 2020 20:27:20 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.177]) by
 dggemi405-hub.china.huawei.com ([10.3.17.143]) with mapi id 14.03.0487.000;
 Thu, 9 Jul 2020 20:27:12 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     "liwei (CM)" <liwei213@huawei.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>
CC:     fengbaopeng <fengbaopeng2@hisilicon.com>,
        "nsaenzjulienne@suse.de" <nsaenzjulienne@suse.de>,
        "steve.capper@arm.com" <steve.capper@arm.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        sujunfei <sujunfei2@hisilicon.com>,
        "Xiaqing (A)" <saberlily.xia@hisilicon.com>,
        "Yaobaofeng (Yaobaofeng)" <yaobaofeng@huawei.com>
Subject: RE: [PATCH] arm64: mm: free unused memmap for sparse memory model
 that define VMEMMAP
Thread-Topic: [PATCH] arm64: mm: free unused memmap for sparse memory model
 that define VMEMMAP
Thread-Index: AQHWVMrtlX9AbygsxkCkGlEoK5gXXaj9QcNg//+H1QCAAmJ40A==
Date:   Thu, 9 Jul 2020 12:27:11 +0000
Message-ID: <B926444035E5E2439431908E3842AFD256289A@DGGEMI525-MBS.china.huawei.com>
References: <20200708015555.14946-1-liwei213@huawei.com>
 <B926444035E5E2439431908E3842AFD255E7A1@DGGEMI525-MBS.china.huawei.com>
 <1699CE87DE933F49876AD744B5DC140F230F8396@DGGEMM506-MBS.china.huawei.com>
In-Reply-To: <1699CE87DE933F49876AD744B5DC140F230F8396@DGGEMM506-MBS.china.huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.83]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGl3ZWkgKENNKQ0KPiBT
ZW50OiBXZWRuZXNkYXksIEp1bHkgOCwgMjAyMCA3OjUyIFBNDQo+IFRvOiBTb25nIEJhbyBIdWEg
KEJhcnJ5IFNvbmcpIDxzb25nLmJhby5odWFAaGlzaWxpY29uLmNvbT47DQo+IGNhdGFsaW4ubWFy
aW5hc0Bhcm0uY29tOyB3aWxsQGtlcm5lbC5vcmcNCj4gQ2M6IGZlbmdiYW9wZW5nIDxmZW5nYmFv
cGVuZzJAaGlzaWxpY29uLmNvbT47IG5zYWVuemp1bGllbm5lQHN1c2UuZGU7DQo+IHN0ZXZlLmNh
cHBlckBhcm0uY29tOyBycHB0QGxpbnV4LmlibS5jb207DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgc3VqdW5mZWkN
Cj4gPHN1anVuZmVpMkBoaXNpbGljb24uY29tPjsgWGlhcWluZyAoQSkgPHNhYmVybGlseS54aWFA
aGlzaWxpY29uLmNvbT47DQo+IFlhb2Jhb2ZlbmcgKFlhb2Jhb2ZlbmcpIDx5YW9iYW9mZW5nQGh1
YXdlaS5jb20+DQo+IFN1YmplY3Q6ILTwuLQ6IFtQQVRDSF0gYXJtNjQ6IG1tOiBmcmVlIHVudXNl
ZCBtZW1tYXAgZm9yIHNwYXJzZSBtZW1vcnkNCj4gbW9kZWwgdGhhdCBkZWZpbmUgVk1FTU1BUA0K
PiANCj4gSGksIGJhb2h1YQ0KPiANCj4gVGhhbmsgeW91IGZvciB5b3VyIGF0dGVudGlvbi4NCj4g
DQo+IEluIG15IHVuZGVyc3RhbmRpbmcgb2YgdGhlIE1FTU9SWV9IT1RQTFVHIHRoaXMgcGF0Y2gg
aGFzIG5vIGVmZmVjdCBvbiBpdC4NCj4gVGhlIHJlYXNvbiBpcyB0aGF0IGluIHNwYXJzZV9hZGRf
b25lX3NlY3Rpb24oKSB0aGUgbWVtb3J5IHRoYXQgbWVtbWFwDQo+IG5lZWRzIGZyb20gU2xhYiBp
ZiBrZXJuZWwgc3RhcnQgY29tcGxldGVko6x0aGlzIG1lbW9yeSBoYXMgbm90aGluZyB0byBkbyB3
aXRoDQo+IG1lbWJsb2NrIGFsbG9jLyBmcmVlIG1lbW9yeSBpbiB0aGUgcHJvY2VzcyBvZiBrZXJu
ZWwgc3RhcnQuDQo+IA0KPiBZb3UgbWF5IGhhdmUgYSBsb29rIHZtZW1tYXBfYWxsb2NfYmxvY2sg
KCkgdGhpcyBmdW5jdGlvbi4NCj4gDQo+IElmIEkgZG9uJ3QgdW5kZXJzdGFuZCByaWdodCB3ZWxj
b21lIHBvaW50ZWQgb3V0IGluIGEgdGltZWx5IG1hbm5lci4NCg0KQXQgdGhlIGZpcnN0IGdsYW5j
ZSBvZiB0aGlzIHBhdGNoLCBJIHN1c3BlY3QgdGhhdCB0aGlzIGJvb3RtZW0gbWF5IGJlIHVzZWQg
YnkgaG90LWFkZGVkIG1lbW9yeS4NCklmIHlvdSBjb25maXJtIHRoaXMgd29uJ3QgaGFwcGVuLCBw
bGVhc2UgaWdub3JlIG15IG5vaXNlLg0KDQpCVFcsIG5leHQgdGltZSwgYmVhciBpbiBtaW5kIHRo
YXQgdG9wLXBvc3QgaXMgbm90IGEgZ29vZCB3YXkgdG8gcmVwbHkgbWFpbCA6LSkNCg0KPiANCj4g
VGhhbmtzIQ0KPiANCj4gDQo+IC0tLS0t08q8/tStvP4tLS0tLQ0KPiC3orz+yMs6IFNvbmcgQmFv
IEh1YSAoQmFycnkgU29uZykNCj4gt6LLzcqxvOQ6IDIwMjDE6jfUwjjI1SAxNToxOQ0KPiDK1bz+
yMs6IGxpd2VpIChDTSkgPGxpd2VpMjEzQGh1YXdlaS5jb20+OyBjYXRhbGluLm1hcmluYXNAYXJt
LmNvbTsNCj4gd2lsbEBrZXJuZWwub3JnDQo+ILOty806IGZlbmdiYW9wZW5nIDxmZW5nYmFvcGVu
ZzJAaGlzaWxpY29uLmNvbT47IG5zYWVuemp1bGllbm5lQHN1c2UuZGU7DQo+IHN0ZXZlLmNhcHBl
ckBhcm0uY29tOyBycHB0QGxpbnV4LmlibS5jb207DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgc3VqdW5mZWkNCj4g
PHN1anVuZmVpMkBoaXNpbGljb24uY29tPg0KPiDW98ziOiBSRTogW1BBVENIXSBhcm02NDogbW06
IGZyZWUgdW51c2VkIG1lbW1hcCBmb3Igc3BhcnNlIG1lbW9yeQ0KPiBtb2RlbCB0aGF0IGRlZmlu
ZSBWTUVNTUFQDQo+IA0KPiANCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
PiBGcm9tOiBsaXdlaSAoQ00pDQo+ID4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDgsIDIwMjAgMTo1
NiBQTQ0KPiA+IFRvOiBjYXRhbGluLm1hcmluYXNAYXJtLmNvbTsgd2lsbEBrZXJuZWwub3JnDQo+
ID4gQ2M6IGxpd2VpIChDTSkgPGxpd2VpMjEzQGh1YXdlaS5jb20+OyBmZW5nYmFvcGVuZw0KPiA+
IDxmZW5nYmFvcGVuZzJAaGlzaWxpY29uLmNvbT47IG5zYWVuemp1bGllbm5lQHN1c2UuZGU7DQo+
ID4gc3RldmUuY2FwcGVyQGFybS5jb207IHJwcHRAbGludXguaWJtLmNvbTsgU29uZyBCYW8gSHVh
IChCYXJyeSBTb25nKQ0KPiA+IDxzb25nLmJhby5odWFAaGlzaWxpY29uLmNvbT47IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gPiBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBzdWp1bmZlaSA8c3VqdW5mZWkyQGhpc2lsaWNvbi5jb20+DQo+ID4gU3ViamVjdDog
W1BBVENIXSBhcm02NDogbW06IGZyZWUgdW51c2VkIG1lbW1hcCBmb3Igc3BhcnNlIG1lbW9yeQ0K
PiBtb2RlbA0KPiA+IHRoYXQgZGVmaW5lIFZNRU1NQVANCj4gPg0KPiA+IEZvciB0aGUgbWVtb3J5
IGhvbGUsIHNwYXJzZSBtZW1vcnkgbW9kZWwgdGhhdCBkZWZpbmUNCj4gU1BBUlNFTUVNX1ZNRU1N
QVANCj4gPiBkbyBub3QgZnJlZSB0aGUgcmVzZXJ2ZWQgbWVtb3J5IGZvciB0aGUgcGFnZSBtYXAs
IHRoaXMgcGF0Y2ggZG8gaXQuDQo+IA0KPiBIZWxsbyBXZWksDQo+IEp1c3QgY3VyaW91cyBpZiB0
aGlzIHBhdGNoIGJyZWFrcyBNRU1PUllfSE9UUExVRz8NCj4gDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBXZWkgTGkgPGxpd2VpMjEzQGh1YXdlaS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2hl
biBGZW5nIDxwdWNrLmNoZW5AaGlzaWxpY29uLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBYaWEg
UWluZyA8c2FiZXJsaWx5LnhpYUBoaXNpbGljb24uY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL2Fy
bTY0L21tL2luaXQuYyB8IDgxDQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNzEgaW5zZXJ0aW9ucygr
KSwgMTAgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9tbS9p
bml0LmMgYi9hcmNoL2FybTY0L21tL2luaXQuYyBpbmRleA0KPiA+IDFlOTNjZmM3YzQ3YS4uZDFi
NTZiNDdkNWJhIDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvbW0vaW5pdC5jDQo+ID4gKysr
IGIvYXJjaC9hcm02NC9tbS9pbml0LmMNCj4gPiBAQCAtNDQxLDcgKzQ0MSw0OCBAQCB2b2lkIF9f
aW5pdCBib290bWVtX2luaXQodm9pZCkNCj4gPiAgCW1lbWJsb2NrX2R1bXBfYWxsKCk7DQo+ID4g
IH0NCj4gPg0KPiANCj4gVGhhbmtzDQo+IEJhcnJ5DQoNCg==
