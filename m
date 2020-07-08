Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A07C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ADEA20672
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgGHHwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:52:10 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2566 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725747AbgGHHwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:52:09 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id C7CFBFEC0BD6E4BD4AB8;
        Wed,  8 Jul 2020 15:52:04 +0800 (CST)
Received: from DGGEMM506-MBS.china.huawei.com ([169.254.4.37]) by
 DGGEMM404-HUB.china.huawei.com ([10.3.20.212]) with mapi id 14.03.0487.000;
 Wed, 8 Jul 2020 15:51:54 +0800
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
Thread-Index: AQHWVMrtO0CAKNNn+U+1wOV2mLLlGKj8wE6AgACJU9A=
Date:   Wed, 8 Jul 2020 07:51:54 +0000
Message-ID: <1699CE87DE933F49876AD744B5DC140F230F8396@DGGEMM506-MBS.china.huawei.com>
References: <20200708015555.14946-1-liwei213@huawei.com>
 <B926444035E5E2439431908E3842AFD255E7A1@DGGEMI525-MBS.china.huawei.com>
In-Reply-To: <B926444035E5E2439431908E3842AFD255E7A1@DGGEMI525-MBS.china.huawei.com>
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

SGksIGJhb2h1YQ0KDQpUaGFuayB5b3UgZm9yIHlvdXIgYXR0ZW50aW9uLg0KDQpJbiBteSB1bmRl
cnN0YW5kaW5nIG9mIHRoZSBNRU1PUllfSE9UUExVRyB0aGlzIHBhdGNoIGhhcyBubyBlZmZlY3Qg
b24gaXQuIFRoZSByZWFzb24gaXMgdGhhdCBpbiBzcGFyc2VfYWRkX29uZV9zZWN0aW9uKCkgdGhl
IG1lbW9yeSB0aGF0IG1lbW1hcCBuZWVkcyBmcm9tIFNsYWIgaWYga2VybmVsIHN0YXJ0IGNvbXBs
ZXRlZKOsdGhpcyBtZW1vcnkgaGFzIG5vdGhpbmcgdG8gZG8gd2l0aCBtZW1ibG9jayBhbGxvYy8g
ZnJlZSBtZW1vcnkgaW4gdGhlIHByb2Nlc3Mgb2Yga2VybmVsIHN0YXJ0Lg0KDQpZb3UgbWF5IGhh
dmUgYSBsb29rIHZtZW1tYXBfYWxsb2NfYmxvY2sgKCkgdGhpcyBmdW5jdGlvbi4NCg0KSWYgSSBk
b24ndCB1bmRlcnN0YW5kIHJpZ2h0IHdlbGNvbWUgcG9pbnRlZCBvdXQgaW4gYSB0aW1lbHkgbWFu
bmVyLg0KDQpUaGFua3MhDQoNCg0KLS0tLS3Tyrz+1K28/i0tLS0tDQq3orz+yMs6IFNvbmcgQmFv
IEh1YSAoQmFycnkgU29uZykgDQq3osvNyrG85DogMjAyMMTqN9TCOMjVIDE1OjE5DQrK1bz+yMs6
IGxpd2VpIChDTSkgPGxpd2VpMjEzQGh1YXdlaS5jb20+OyBjYXRhbGluLm1hcmluYXNAYXJtLmNv
bTsgd2lsbEBrZXJuZWwub3JnDQqzrcvNOiBmZW5nYmFvcGVuZyA8ZmVuZ2Jhb3BlbmcyQGhpc2ls
aWNvbi5jb20+OyBuc2FlbnpqdWxpZW5uZUBzdXNlLmRlOyBzdGV2ZS5jYXBwZXJAYXJtLmNvbTsg
cnBwdEBsaW51eC5pYm0uY29tOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHN1anVuZmVpIDxzdWp1bmZlaTJAaGlzaWxp
Y29uLmNvbT4NCtb3zOI6IFJFOiBbUEFUQ0hdIGFybTY0OiBtbTogZnJlZSB1bnVzZWQgbWVtbWFw
IGZvciBzcGFyc2UgbWVtb3J5IG1vZGVsIHRoYXQgZGVmaW5lIFZNRU1NQVANCg0KDQoNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbGl3ZWkgKENNKQ0KPiBTZW50OiBXZWRu
ZXNkYXksIEp1bHkgOCwgMjAyMCAxOjU2IFBNDQo+IFRvOiBjYXRhbGluLm1hcmluYXNAYXJtLmNv
bTsgd2lsbEBrZXJuZWwub3JnDQo+IENjOiBsaXdlaSAoQ00pIDxsaXdlaTIxM0BodWF3ZWkuY29t
PjsgZmVuZ2Jhb3BlbmcgDQo+IDxmZW5nYmFvcGVuZzJAaGlzaWxpY29uLmNvbT47IG5zYWVuemp1
bGllbm5lQHN1c2UuZGU7IA0KPiBzdGV2ZS5jYXBwZXJAYXJtLmNvbTsgcnBwdEBsaW51eC5pYm0u
Y29tOyBTb25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcpIA0KPiA8c29uZy5iYW8uaHVhQGhpc2lsaWNv
bi5jb20+OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHN1anVuZmVpIDxzdWp1bmZlaTJAaGlzaWxpY29uLmNvbT4N
Cj4gU3ViamVjdDogW1BBVENIXSBhcm02NDogbW06IGZyZWUgdW51c2VkIG1lbW1hcCBmb3Igc3Bh
cnNlIG1lbW9yeSBtb2RlbCANCj4gdGhhdCBkZWZpbmUgVk1FTU1BUA0KPiANCj4gRm9yIHRoZSBt
ZW1vcnkgaG9sZSwgc3BhcnNlIG1lbW9yeSBtb2RlbCB0aGF0IGRlZmluZSBTUEFSU0VNRU1fVk1F
TU1BUCANCj4gZG8gbm90IGZyZWUgdGhlIHJlc2VydmVkIG1lbW9yeSBmb3IgdGhlIHBhZ2UgbWFw
LCB0aGlzIHBhdGNoIGRvIGl0Lg0KDQpIZWxsbyBXZWksDQpKdXN0IGN1cmlvdXMgaWYgdGhpcyBw
YXRjaCBicmVha3MgTUVNT1JZX0hPVFBMVUc/DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFdlaSBM
aSA8bGl3ZWkyMTNAaHVhd2VpLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQ2hlbiBGZW5nIDxwdWNr
LmNoZW5AaGlzaWxpY29uLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogWGlhIFFpbmcgPHNhYmVybGls
eS54aWFAaGlzaWxpY29uLmNvbT4NCj4gLS0tDQo+ICBhcmNoL2FybTY0L21tL2luaXQuYyB8IDgx
DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCA3MSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L21tL2luaXQuYyBiL2FyY2gvYXJtNjQvbW0vaW5p
dC5jIGluZGV4IA0KPiAxZTkzY2ZjN2M0N2EuLmQxYjU2YjQ3ZDViYSAxMDA2NDQNCj4gLS0tIGEv
YXJjaC9hcm02NC9tbS9pbml0LmMNCj4gKysrIGIvYXJjaC9hcm02NC9tbS9pbml0LmMNCj4gQEAg
LTQ0MSw3ICs0NDEsNDggQEAgdm9pZCBfX2luaXQgYm9vdG1lbV9pbml0KHZvaWQpDQo+ICAJbWVt
YmxvY2tfZHVtcF9hbGwoKTsNCj4gIH0NCj4gDQoNClRoYW5rcw0KQmFycnkNCg0K
