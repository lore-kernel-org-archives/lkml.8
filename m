Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9955AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 786D8206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgGUB4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 21:56:45 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2648 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725857AbgGUB4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 21:56:45 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 7AB62FA7F9BA7BAE1B14;
        Tue, 21 Jul 2020 09:56:41 +0800 (CST)
Received: from DGGEMM422-HUB.china.huawei.com (10.1.198.39) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 21 Jul 2020 09:56:40 +0800
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.195]) by
 dggemm422-hub.china.huawei.com ([10.1.198.39]) with mapi id 14.03.0487.000;
 Tue, 21 Jul 2020 09:56:35 +0800
From:   "liwei (CM)" <liwei213@huawei.com>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
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
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBhcm02NDogbW06IGZyZWUgdW51c2VkIG1lbW1hcCBm?=
 =?gb2312?Q?or_sparse_memory_model_that_define_VMEMMAP?=
Thread-Topic: [PATCH] arm64: mm: free unused memmap for sparse memory model
 that define VMEMMAP
Thread-Index: AQHWVMrtO0CAKNNn+U+1wOV2mLLlGKj8wE6AgACJU9CAAV82gIASsSBA
Date:   Tue, 21 Jul 2020 01:56:33 +0000
Message-ID: <1699CE87DE933F49876AD744B5DC140F2312A02B@dggemm526-mbx.china.huawei.com>
References: <20200708015555.14946-1-liwei213@huawei.com>
 <B926444035E5E2439431908E3842AFD255E7A1@DGGEMI525-MBS.china.huawei.com>
 <1699CE87DE933F49876AD744B5DC140F230F8396@DGGEMM506-MBS.china.huawei.com>
 <B926444035E5E2439431908E3842AFD256289A@DGGEMI525-MBS.china.huawei.com>
In-Reply-To: <B926444035E5E2439431908E3842AFD256289A@DGGEMI525-MBS.china.huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.77.141]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIGFsbA0KDQpJJ20gc29ycnkgdG8gYm90aGVyIHlvdSwgYnV0IHN0aWxsIHZlcnkgaG9wZSB5
b3UgY2FuIGdpdmUgY29tbWVudHMgb3Igc3VnZ2VzdGlvbnMgdG8gdGhpcyBwYXRjaCwgdGhhbmsg
eW91IHZlcnkgbXVjaC4NCg0KDQotLS0tLdPKvP7Urbz+LS0tLS0NCreivP7IyzogU29uZyBCYW8g
SHVhIChCYXJyeSBTb25nKSANCreiy83KsbzkOiAyMDIwxOo31MI5yNUgMjA6MjcNCsrVvP7Iyzog
bGl3ZWkgKENNKSA8bGl3ZWkyMTNAaHVhd2VpLmNvbT47IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29t
OyB3aWxsQGtlcm5lbC5vcmcNCrOty806IGZlbmdiYW9wZW5nIDxmZW5nYmFvcGVuZzJAaGlzaWxp
Y29uLmNvbT47IG5zYWVuemp1bGllbm5lQHN1c2UuZGU7IHN0ZXZlLmNhcHBlckBhcm0uY29tOyBy
cHB0QGxpbnV4LmlibS5jb207IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgc3VqdW5mZWkgPHN1anVuZmVpMkBoaXNpbGlj
b24uY29tPjsgWGlhcWluZyAoQSkgPHNhYmVybGlseS54aWFAaGlzaWxpY29uLmNvbT47IFlhb2Jh
b2ZlbmcgKFlhb2Jhb2ZlbmcpIDx5YW9iYW9mZW5nQGh1YXdlaS5jb20+DQrW98ziOiBSRTogW1BB
VENIXSBhcm02NDogbW06IGZyZWUgdW51c2VkIG1lbW1hcCBmb3Igc3BhcnNlIG1lbW9yeSBtb2Rl
bCB0aGF0IGRlZmluZSBWTUVNTUFQDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IGxpd2VpIChDTSkNCj4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDgsIDIwMjAgNzo1
MiBQTQ0KPiBUbzogU29uZyBCYW8gSHVhIChCYXJyeSBTb25nKSA8c29uZy5iYW8uaHVhQGhpc2ls
aWNvbi5jb20+OyANCj4gY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IHdpbGxAa2VybmVsLm9yZw0K
PiBDYzogZmVuZ2Jhb3BlbmcgPGZlbmdiYW9wZW5nMkBoaXNpbGljb24uY29tPjsgbnNhZW56anVs
aWVubmVAc3VzZS5kZTsgDQo+IHN0ZXZlLmNhcHBlckBhcm0uY29tOyBycHB0QGxpbnV4LmlibS5j
b207IA0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IA0KPiBzdWp1bmZlaSA8c3VqdW5mZWkyQGhpc2lsaWNvbi5jb20+
OyBYaWFxaW5nIChBKSANCj4gPHNhYmVybGlseS54aWFAaGlzaWxpY29uLmNvbT47IFlhb2Jhb2Zl
bmcgKFlhb2Jhb2ZlbmcpIA0KPiA8eWFvYmFvZmVuZ0BodWF3ZWkuY29tPg0KPiBTdWJqZWN0OiC0
8Li0OiBbUEFUQ0hdIGFybTY0OiBtbTogZnJlZSB1bnVzZWQgbWVtbWFwIGZvciBzcGFyc2UgbWVt
b3J5IA0KPiBtb2RlbCB0aGF0IGRlZmluZSBWTUVNTUFQDQo+IA0KPiBIaSwgYmFvaHVhDQo+IA0K
PiBUaGFuayB5b3UgZm9yIHlvdXIgYXR0ZW50aW9uLg0KPiANCj4gSW4gbXkgdW5kZXJzdGFuZGlu
ZyBvZiB0aGUgTUVNT1JZX0hPVFBMVUcgdGhpcyBwYXRjaCBoYXMgbm8gZWZmZWN0IG9uIGl0Lg0K
PiBUaGUgcmVhc29uIGlzIHRoYXQgaW4gc3BhcnNlX2FkZF9vbmVfc2VjdGlvbigpIHRoZSBtZW1v
cnkgdGhhdCBtZW1tYXAgDQo+IG5lZWRzIGZyb20gU2xhYiBpZiBrZXJuZWwgc3RhcnQgY29tcGxl
dGVko6x0aGlzIG1lbW9yeSBoYXMgbm90aGluZyB0byANCj4gZG8gd2l0aCBtZW1ibG9jayBhbGxv
Yy8gZnJlZSBtZW1vcnkgaW4gdGhlIHByb2Nlc3Mgb2Yga2VybmVsIHN0YXJ0Lg0KPiANCj4gWW91
IG1heSBoYXZlIGEgbG9vayB2bWVtbWFwX2FsbG9jX2Jsb2NrICgpIHRoaXMgZnVuY3Rpb24uDQo+
IA0KPiBJZiBJIGRvbid0IHVuZGVyc3RhbmQgcmlnaHQgd2VsY29tZSBwb2ludGVkIG91dCBpbiBh
IHRpbWVseSBtYW5uZXIuDQoNCkF0IHRoZSBmaXJzdCBnbGFuY2Ugb2YgdGhpcyBwYXRjaCwgSSBz
dXNwZWN0IHRoYXQgdGhpcyBib290bWVtIG1heSBiZSB1c2VkIGJ5IGhvdC1hZGRlZCBtZW1vcnku
DQpJZiB5b3UgY29uZmlybSB0aGlzIHdvbid0IGhhcHBlbiwgcGxlYXNlIGlnbm9yZSBteSBub2lz
ZS4NCg0KQlRXLCBuZXh0IHRpbWUsIGJlYXIgaW4gbWluZCB0aGF0IHRvcC1wb3N0IGlzIG5vdCBh
IGdvb2Qgd2F5IHRvIHJlcGx5IG1haWwgOi0pDQoNCj4gDQo+IFRoYW5rcyENCj4gDQo+IA0KPiAt
LS0tLdPKvP7Urbz+LS0tLS0NCj4gt6K8/sjLOiBTb25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcpDQo+
ILeiy83KsbzkOiAyMDIwxOo31MI4yNUgMTU6MTkNCj4gytW8/sjLOiBsaXdlaSAoQ00pIDxsaXdl
aTIxM0BodWF3ZWkuY29tPjsgY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IA0KPiB3aWxsQGtlcm5l
bC5vcmcNCj4gs63LzTogZmVuZ2Jhb3BlbmcgPGZlbmdiYW9wZW5nMkBoaXNpbGljb24uY29tPjsg
bnNhZW56anVsaWVubmVAc3VzZS5kZTsgDQo+IHN0ZXZlLmNhcHBlckBhcm0uY29tOyBycHB0QGxp
bnV4LmlibS5jb207IA0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IA0KPiBzdWp1bmZlaSA8c3VqdW5mZWkyQGhpc2ls
aWNvbi5jb20+DQo+INb3zOI6IFJFOiBbUEFUQ0hdIGFybTY0OiBtbTogZnJlZSB1bnVzZWQgbWVt
bWFwIGZvciBzcGFyc2UgbWVtb3J5IG1vZGVsIA0KPiB0aGF0IGRlZmluZSBWTUVNTUFQDQo+IA0K
PiANCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBsaXdlaSAo
Q00pDQo+ID4gU2VudDogV2VkbmVzZGF5LCBKdWx5IDgsIDIwMjAgMTo1NiBQTQ0KPiA+IFRvOiBj
YXRhbGluLm1hcmluYXNAYXJtLmNvbTsgd2lsbEBrZXJuZWwub3JnDQo+ID4gQ2M6IGxpd2VpIChD
TSkgPGxpd2VpMjEzQGh1YXdlaS5jb20+OyBmZW5nYmFvcGVuZyANCj4gPiA8ZmVuZ2Jhb3Blbmcy
QGhpc2lsaWNvbi5jb20+OyBuc2FlbnpqdWxpZW5uZUBzdXNlLmRlOyANCj4gPiBzdGV2ZS5jYXBw
ZXJAYXJtLmNvbTsgcnBwdEBsaW51eC5pYm0uY29tOyBTb25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcp
IA0KPiA+IDxzb25nLmJhby5odWFAaGlzaWxpY29uLmNvbT47IGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZzsNCj4gPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBzdWp1
bmZlaSA8c3VqdW5mZWkyQGhpc2lsaWNvbi5jb20+DQo+ID4gU3ViamVjdDogW1BBVENIXSBhcm02
NDogbW06IGZyZWUgdW51c2VkIG1lbW1hcCBmb3Igc3BhcnNlIG1lbW9yeQ0KPiBtb2RlbA0KPiA+
IHRoYXQgZGVmaW5lIFZNRU1NQVANCj4gPg0KPiA+IEZvciB0aGUgbWVtb3J5IGhvbGUsIHNwYXJz
ZSBtZW1vcnkgbW9kZWwgdGhhdCBkZWZpbmUNCj4gU1BBUlNFTUVNX1ZNRU1NQVANCj4gPiBkbyBu
b3QgZnJlZSB0aGUgcmVzZXJ2ZWQgbWVtb3J5IGZvciB0aGUgcGFnZSBtYXAsIHRoaXMgcGF0Y2gg
ZG8gaXQuDQo+IA0KPiBIZWxsbyBXZWksDQo+IEp1c3QgY3VyaW91cyBpZiB0aGlzIHBhdGNoIGJy
ZWFrcyBNRU1PUllfSE9UUExVRz8NCj4gDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBXZWkgTGkg
PGxpd2VpMjEzQGh1YXdlaS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2hlbiBGZW5nIDxwdWNr
LmNoZW5AaGlzaWxpY29uLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBYaWEgUWluZyA8c2FiZXJs
aWx5LnhpYUBoaXNpbGljb24uY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL2FybTY0L21tL2luaXQu
YyB8IDgxDQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNzEgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRp
b25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9tbS9pbml0LmMgYi9hcmNo
L2FybTY0L21tL2luaXQuYyBpbmRleCANCj4gPiAxZTkzY2ZjN2M0N2EuLmQxYjU2YjQ3ZDViYSAx
MDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L21tL2luaXQuYw0KPiA+ICsrKyBiL2FyY2gvYXJt
NjQvbW0vaW5pdC5jDQo+ID4gQEAgLTQ0MSw3ICs0NDEsNDggQEAgdm9pZCBfX2luaXQgYm9vdG1l
bV9pbml0KHZvaWQpDQo+ID4gIAltZW1ibG9ja19kdW1wX2FsbCgpOw0KPiA+ICB9DQo+ID4NCj4g
DQo+IFRoYW5rcw0KPiBCYXJyeQ0KDQo=
