Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670CCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FBEF207C4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgERGXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 02:23:32 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2139 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726040AbgERGXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 02:23:31 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 34D235D91A416AA7C583;
        Mon, 18 May 2020 14:23:27 +0800 (CST)
Received: from dggeme752-chm.china.huawei.com (10.3.19.98) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 18 May 2020 14:23:27 +0800
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme752-chm.china.huawei.com (10.3.19.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 18 May 2020 14:23:26 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1913.007;
 Mon, 18 May 2020 14:23:26 +0800
From:   Hushijie <hushijie3@huawei.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     "will@kernel.org" <will@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nixiaoming <nixiaoming@huawei.com>,
        "wangxu (AE)" <wangxu72@huawei.com>,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
        yangerkun <yangerkun@huawei.com>,
        "Wangle (RTOS FAE)" <wangle6@huawei.com>,
        "Chengang (L)" <cg.chen@huawei.com>,
        "Chenjie (K)" <chenjie6@huawei.com>,
        "Huangjianhui (Alex)" <alex.huangjianhui@huawei.com>
Subject: Re: [PATCH v5] hugetlbfs: Get unmapped area below TASK_UNMAPPED_BASE
 for hugetlbfs
Thread-Topic: [PATCH v5] hugetlbfs: Get unmapped area below TASK_UNMAPPED_BASE
 for hugetlbfs
Thread-Index: AdYs3KFnzadL7fPfR1K7soKYD38V2Q==
Date:   Mon, 18 May 2020 06:23:26 +0000
Message-ID: <c27a402512b84ce598420b28f525eb75@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.103.250]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pk9uIDUvMTYvMjAgMTI6NDcgQU0sIEh1c2hpamllIHdyb3RlOg0KPj4+IE9uIDUvMTQvMjAgNzoz
MSBBTSwgU2hpamllIEh1IHdyb3RlOg0KPj4+PiArCWlmIChtbS0+Z2V0X3VubWFwcGVkX2FyZWEg
PT0gYXJjaF9nZXRfdW5tYXBwZWRfYXJlYSkNCj4+Pj4gKwkJcmV0dXJuIGh1Z2V0bGJfZ2V0X3Vu
bWFwcGVkX2FyZWFfYm90dG9tdXAoZmlsZSwgYWRkciwgbGVuLA0KPj4+PiArCQkJCXBnb2ZmLCBm
bGFncyk7DQo+Pj4+ICsJcmV0dXJuIGh1Z2V0bGJfZ2V0X3VubWFwcGVkX2FyZWFfdG9wZG93bihm
aWxlLCBhZGRyLCBsZW4sDQo+Pj4+ICsJCQlwZ29mZiwgZmxhZ3MpOw0KPj4+DQo+Pj4gSSBsaWtl
IHRoaXMgY29kZSB1c2luZyB0aGUgdmFsdWUgb2YgbW0tPmdldF91bm1hcHBlZF9hcmVhIHRvIGRl
dGVybWluZQ0KPj4+IHdoaWNoIHJvdXRpbmUgdG8gY2FsbC4gIEl0IGlzIHVzZWQgYnkgYSBmZXcg
YXJjaGl0ZWN0dXJlcy4gICBIb3dldmVyLCBJDQo+Pj4gbm90aWNlZCB0aGF0IG9uIGF0IGxlYXN0
IG9uZSBhcmNoaXRlY3R1cmUgKHBvd2VycGMpIG1tLT5nZXRfdW5tYXBwZWRfYXJlYQ0KPj4+IG1h
eSBiZSBhc3NpZ25lZCB0byByb3V0aW5lcyBvdGhlciB0aGFuIGFyY2hfZ2V0X3VubWFwcGVkX2Fy
ZWEgb3INCj4+PiBhcmNoX2dldF91bm1hcHBlZF9hcmVhX3RvcGRvd24uICBJbiBzdWNoIGEgY2Fz
ZSwgd2Ugd291bGQgY2FsbCB0aGUgJ25ldycNCj4+PiB0b3Bkb3duIHJvdXRpbmUuICBJIHdvdWxk
IHByZWZlciB0aGF0IHdlIGNhbGwgdGhlIGJvdHRvbXVwIHJvdXRpbmUgaW4gdGhpcw0KPj4+IGRl
ZmF1bHQgY2FzZS4NCj4+Pg0KPj4+IEluIHJlYWxpdHksIHRoaXMgZG9lcyBub3QgaW1wYWN0IHBv
d2VycGMgYXMgdGhhdCBhcmNoaXRlY3R1cmUgaGFzIGl0J3MNCj4+PiBvd24gaHVnZXRsYl9nZXRf
dW5tYXBwZWRfYXJlYSByb3V0aW5lLg0KPj4+DQo+PiANCj4+IFllcywgSSBhbHNvIG5vdGljZWQg
dGhpcyBiZWZvcmUsIHBvd2VycGMgdXNlcyByYWRpeF9fYXJjaF9nZXRfdW5tYXBwZWRfYXJlYSoo
KSANCj4+IHdoZW4gQ09ORklHX1BQQ19SQURJWF9NTVUgb3BlbmVkIGFzICd5JyBhbmQgcmFkaXhf
ZW5hYmxlZCgpIHJldHVybnMgDQo+PiB0cnVlLiBIb3dldmVyLCBwb3dlcnBjIGltcGxlbWVudGVk
IGl0cyBvd24gaHVnZXRsYl9nZXRfdW5tYXBwZWRfYXJlYSgpLiBUaGlzDQo+PiBwYXRjaCBhY3R1
YWxseSBoYXMgbm8gZWZmZWN0IG9uIHBvd2VycGMuDQo+PiANCj4+PiBCZWNhdXNlIG9mIHRoaXMs
IEkgc3VnZ2VzdCB3ZSBhZGQgYSBjb21tZW50IGFib3ZlIHRoaXMgY29kZSBhbmQgc3dpdGNoDQo+
Pj4gdGhlIGlmL2Vsc2Ugb3JkZXIuICBGb3IgZXhhbXBsZSwNCj4+Pg0KPj4+ICsgICAgICAgLyoN
Cj4+PiArICAgICAgICAqIFVzZSBtbS0+Z2V0X3VubWFwcGVkX2FyZWEgdmFsdWUgYXMgYSBoaW50
IHRvIHVzZSB0b3Bkb3duIHJvdXRpbmUuDQo+Pj4gKyAgICAgICAgKiBJZiBhcmNoaXRlY3R1cmVz
IGhhdmUgc3BlY2lhbCBuZWVkcywgdGhleSBzaG91bGQgZGVmaW5lIHRoZWlyIG93bg0KPj4+ICsg
ICAgICAgICogdmVyc2lvbiBvZiBodWdldGxiX2dldF91bm1hcHBlZF9hcmVhLg0KPj4+ICsgICAg
ICAgICovDQo+Pj4gKyAgICAgICBpZiAobW0tPmdldF91bm1hcHBlZF9hcmVhID09IGFyY2hfZ2V0
X3VubWFwcGVkX2FyZWFfdG9wZG93bikNCj4+PiArICAgICAgICAgICAgICAgcmV0dXJuIGh1Z2V0
bGJfZ2V0X3VubWFwcGVkX2FyZWFfdG9wZG93bihmaWxlLCBhZGRyLCBsZW4sDQo+Pj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBwZ29mZiwgZmxhZ3MpOw0KPj4+ICsgICAgICAgcmV0
dXJuIGh1Z2V0bGJfZ2V0X3VubWFwcGVkX2FyZWFfYm90dG9tdXAoZmlsZSwgYWRkciwgbGVuLA0K
Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHBnb2ZmLCBmbGFncyk7DQo+Pj4NCj4+PiBUaG91
Z2h0cz8NCj4+PiAtLSANCj4+PiBNaWtlIEtyYXZldHoNCj4+Pg0KPj4gSSBhZ3JlZSB3aXRoIHlv
dS4gSXQncyBjbGV2ZXIgdG8gc3dpdGNoIHRoZSBpZi9lbHNlIG9yZGVyLiBJZiB0aGVyZSBpcyBz
dWNoDQo+PiBhIGNhc2UsIG1tLT5nZXRfdW5tYXBwZWRfYXJlYSgpIGlzIG5laWh0ZXIgYXJjaF9n
ZXRfdW5tYXBwZWRfYXJlYSgpIG5vcg0KPj4gYXJjaF9nZXRfdW5tYXBwZWRfYXJlYV90b3Bkb3du
KCksIGl0IGlzIGluZGVlZCBtb3JlIGFwcHJvcHJpYXRlIHRvIG1ha2UgdGhlDQo+PiBib3R0b211
cCByb3V0aW5lIGFzIHRoZSBkZWZhdWx0IGJlaGF2aW9yLg0KPj4gDQo+PiBNYXkgSSBwdXQgdGhp
cyBjb2RlIGFuZCBjb21tZW50IHlvdSBzaG93IGFib3ZlIGludG8gcGF0Y2ggdjYgYW5kIGFkZCAN
Cj4+ICJTaWduZWQtb2ZmLWJ5OiBNaWtlIEtyYXZldHogPG1pa2Uua3JhdmV0ekBvcmFjbGUuY29t
PiIgdG8gaXQ/DQo+DQo+RmVlbCBmcmVlIHRvIGFkZCB0aGlzIGNvZGUgYW5kIG15IFNpZ25lZC1v
ZmYtYnkuDQo+DQo+SSBhc3N1bWUgdGhpcyBzdGlsbCB3b3JrcyBmb3IgeW91ciB1c2UgY2FzZS4g
IENvcnJlY3Q/DQo+LS0gDQo+TWlrZSBLcmF2ZXR6DQo+DQoNClllcywgSXQgc3RpbGwgd29ya3Mg
Zm9yIG91ciB1c2UgY2FzZS4NCg0KVGhhbmtzIGZvciB5b3VyIHJlcGxpZXMgYW5kIHN1Z2dlc3Rp
b25zLCBJIHdpbGwgc3VibWl0IHBhdGNoIHY2IGxhdGVyLg0KLS0NClNoaWppZSBIdQ0K
