Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DBDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2839C2071A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732251AbgGVNkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 09:40:49 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2585 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726425AbgGVNkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 09:40:49 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 8230B9D299EE4F900D9A;
        Wed, 22 Jul 2020 21:40:44 +0800 (CST)
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.195]) by
 DGGEMM405-HUB.china.huawei.com ([10.3.20.213]) with mapi id 14.03.0487.000;
 Wed, 22 Jul 2020 21:40:34 +0800
From:   "liwei (CM)" <liwei213@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     Mike Rapoport <rppt@linux.ibm.com>,
        "will@kernel.org" <will@kernel.org>,
        "Xiaqing (A)" <saberlily.xia@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        butao <butao@hisilicon.com>,
        fengbaopeng <fengbaopeng2@hisilicon.com>,
        "nsaenzjulienne@suse.de" <nsaenzjulienne@suse.de>,
        "steve.capper@arm.com" <steve.capper@arm.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        sujunfei <sujunfei2@hisilicon.com>,
        zhaojiapeng <zhaojiapeng@huawei.com>
Subject: =?gb2312?B?tPC4tDogtPC4tDogW1BBVENIXSBhcm02NDogbW06IGZyZWUgdW51c2VkIG1l?=
 =?gb2312?B?bW1hcCBmb3Igc3BhcnNlIG1lbW9yeSBtb2RlbCB0aGF0IGRlZmluZSBWTUVN?=
 =?gb2312?Q?MAP?=
Thread-Topic: =?gb2312?B?tPC4tDogW1BBVENIXSBhcm02NDogbW06IGZyZWUgdW51c2VkIG1lbW1hcCBm?=
 =?gb2312?Q?or_sparse_memory_model_that_define_VMEMMAP?=
Thread-Index: AQHWXzEQMpvo3yT4K0COUiys26URoqkSmCeAgAClMpD//8slAIAAjr5A
Date:   Wed, 22 Jul 2020 13:40:34 +0000
Message-ID: <1699CE87DE933F49876AD744B5DC140F2312F0D6@dggemm526-mbx.china.huawei.com>
References: <20200721073203.107862-1-liwei213@huawei.com>
 <20200722060705.GK802087@linux.ibm.com>
 <1699CE87DE933F49876AD744B5DC140F2312E948@dggemm526-mbx.china.huawei.com>
 <20200722124910.GE27540@gaia>
In-Reply-To: <20200722124910.GE27540@gaia>
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

DQotLS0tLdPKvP7Urbz+LS0tLS0NCreivP7IyzogQ2F0YWxpbiBNYXJpbmFzIFttYWlsdG86Y2F0
YWxpbi5tYXJpbmFzQGFybS5jb21dIA0Kt6LLzcqxvOQ6IDIwMjDE6jfUwjIyyNUgMjA6NDkNCsrV
vP7IyzogbGl3ZWkgKENNKSA8bGl3ZWkyMTNAaHVhd2VpLmNvbT4NCrOty806IE1pa2UgUmFwb3Bv
cnQgPHJwcHRAbGludXguaWJtLmNvbT47IHdpbGxAa2VybmVsLm9yZzsgWGlhcWluZyAoQSkgPHNh
YmVybGlseS54aWFAaGlzaWxpY29uLmNvbT47IENoZW5mZW5nIChwdWNrKSA8cHVjay5jaGVuQGhp
c2lsaWNvbi5jb20+OyBidXRhbyA8YnV0YW9AaGlzaWxpY29uLmNvbT47IGZlbmdiYW9wZW5nIDxm
ZW5nYmFvcGVuZzJAaGlzaWxpY29uLmNvbT47IG5zYWVuemp1bGllbm5lQHN1c2UuZGU7IHN0ZXZl
LmNhcHBlckBhcm0uY29tOyBTb25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcpIDxzb25nLmJhby5odWFA
aGlzaWxpY29uLmNvbT47IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgc3VqdW5mZWkgPHN1anVuZmVpMkBoaXNpbGljb24u
Y29tPjsgemhhb2ppYXBlbmcgPHpoYW9qaWFwZW5nQGh1YXdlaS5jb20+DQrW98ziOiBSZTogtPC4
tDogW1BBVENIXSBhcm02NDogbW06IGZyZWUgdW51c2VkIG1lbW1hcCBmb3Igc3BhcnNlIG1lbW9y
eSBtb2RlbCB0aGF0IGRlZmluZSBWTUVNTUFQDQoNCk9uIFdlZCwgSnVsIDIyLCAyMDIwIGF0IDA4
OjQxOjE3QU0gKzAwMDAsIGxpd2VpIChDTSkgd3JvdGU6DQo+IE1pa2UgUmFwb3BvcnQgd3JvdGU6
DQo+ID4gT24gVHVlLCBKdWwgMjEsIDIwMjAgYXQgMDM6MzI6MDNQTSArMDgwMCwgV2VpIExpIHdy
b3RlOg0KPiA+ID4gRm9yIHRoZSBtZW1vcnkgaG9sZSwgc3BhcnNlIG1lbW9yeSBtb2RlbCB0aGF0
IGRlZmluZSANCj4gPiA+IFNQQVJTRU1FTV9WTUVNTUFQIGRvIG5vdCBmcmVlIHRoZSByZXNlcnZl
ZCBtZW1vcnkgZm9yIHRoZSBwYWdlIG1hcCwgdGhpcyBwYXRjaCBkbyBpdC4NCj4gPiANCj4gPiBB
cmUgdGhlcmUgbnVtYmVycyBzaG93aW5nIGhvdyBtdWNoIG1lbW9yeSBpcyBhY3R1YWxseSBmcmVl
ZD8NCj4gPiANCj4gPiBUaGUgZnJlZWluZyBvZiBlbXB0eSBtZW1tYXAgd291bGQgYmVjb21lIHJh
dGhlciBjb21wbGV4IHdpdGggdGhlc2UgDQo+ID4gY2hhbmdlcywgZG8gdGhlIG1lbW9yeSBzYXZp
bmdzIGp1c3RpZnkgaXQ/DQo+IA0KPiBJbiB0aGUgc3BhcnNlIG1lbW9yeSBtb2RlbCwgdGhlIHNp
emUgb2YgYSBzZWN0aW9uIGlzIDEgR0IgDQo+IChTRUNUSU9OX1NJWkVfQklUUyAzMCkgYnkgZGVm
YXVsdC4NCg0KQ2FuIHdlIHJlZHVjZSBTRUNUSU9OX1NJWkVfQklUUyBpbnN0ZWFkPyBTYXkgMjY/
DQoNCkhpLCBDYXRhbGluDQoNClllcywgeW91IGFyZSByaWdodCwgcmVkdWNlIFNFQ1RJT05fU0la
RV9CSVRTIHRvIDI2IGNhbiBzYXZlIGFsbW9zdCB0aGUgc2FtZSBtZW1vcnkgYXMgdGhlIHBhdGNo
LiANCg0KMSkgSG93ZXZlciwgaXQgaXMgbm90IGNsZWFyIHdoZXRoZXIgY2hhbmdpbmcgdGhlIHNl
Y3Rpb24gc2l6ZSBoYXMgYW55IG90aGVyIGltcGFjdC4NCg0KMikgSnVzdCBsaWtlIHRoZSBmbGF0
IG1lbW9yeSBtb2RlbCBhbmQgdGhlIHNwYXJzZSBtZW1vcnkgbW9kZWwgdGhhdCBkb2VzIG5vdCBk
ZWZpbmUgVk1FTU1BUCwgYm90aCBvZiB0aGVtIGhhdmUgdGhlaXIgb3duIHdheXMgdG8gZnJlZSB1
bnVzZWQgbWVtbWFwLiBJIHRoaW5rIHdlJ3ZlIGdpdmVuIGEgc2ltaWxhciB3YXkgZm9yIHNwYXJz
ZSBtZW1vcnkgZGVmaW5lIFZNRU1NQVAuDQoNCjMpIFRoaXMgZXhwbGljaXQgZnJlZSB1bnVzZWQg
bWVtbWFwIG1ldGhvZCBkb2VzIHJlZHVjZSB1bm5lY2Vzc2FyeSBtZW1vcnkgd2FzdGUgZm9yIHVz
ZXJzIHdobyBkbyBub3Qgbm90aWNlIHRoZSBzZWN0aW9uIHNpemUgbW9kaWZpY2F0aW9uLg0KDQpI
b3BlIHlvdSB3aWxsIHJlY29uc2lkZXIgdGhlIHB1cnBvc2UgYW5kIHNpZ25pZmljYW5jZSBvZiB0
aGlzIHBhdGNoLCB0aGFua3MuDQoNCi0tDQpDYXRhbGluDQo=
