Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A483CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 00:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89B1D20812
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 00:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgFHAvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 20:51:07 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2102 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728001AbgFHAvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 20:51:07 -0400
Received: from dggemi402-hub.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 434C31893322DC83ADAA;
        Mon,  8 Jun 2020 08:51:03 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.10]) by
 dggemi402-hub.china.huawei.com ([10.3.17.135]) with mapi id 14.03.0487.000;
 Mon, 8 Jun 2020 08:50:56 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Roman Gushchin <guro@fb.com>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        John Garry <john.garry@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "hch@lst.de" <hch@lst.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
Subject: RE: [PATCH 2/3] arm64: mm: reserve hugetlb CMA after numa_init
Thread-Topic: [PATCH 2/3] arm64: mm: reserve hugetlb CMA after numa_init
Thread-Index: AQHWOVDqOQ5Ue+21CU6BOgFAT6Yo26jFs6GAgAdkKACAANEJQA==
Date:   Mon, 8 Jun 2020 00:50:56 +0000
Message-ID: <B926444035E5E2439431908E3842AFD24E1ED7@DGGEMI525-MBS.china.huawei.com>
References: <20200603024231.61748-1-song.bao.hua@hisilicon.com>
 <20200603024231.61748-3-song.bao.hua@hisilicon.com>
 <20200603032219.GA548147@carbon.lan>
 <bad059a3-c564-30a1-198f-1c92de601aed@gmail.com>
In-Reply-To: <bad059a3-c564-30a1-198f-1c92de601aed@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.95]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWF0dGhpYXMgQnJ1Z2dl
ciBbbWFpbHRvOm1hdHRoaWFzLmJnZ0BnbWFpbC5jb21dDQo+IFNlbnQ6IE1vbmRheSwgSnVuZSA4
LCAyMDIwIDg6MTUgQU0NCj4gVG86IFJvbWFuIEd1c2hjaGluIDxndXJvQGZiLmNvbT47IFNvbmcg
QmFvIEh1YSAoQmFycnkgU29uZykNCj4gPHNvbmcuYmFvLmh1YUBoaXNpbGljb24uY29tPg0KPiBD
YzogY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IEpvaG4gR2FycnkgPGpvaG4uZ2FycnlAaHVhd2Vp
LmNvbT47DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IExpbnV4YXJtIDxsaW51eGFy
bUBodWF3ZWkuY29tPjsNCj4gaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IFplbmd0
YW8gKEIpIDxwcmltZS56ZW5nQGhpc2lsaWNvbi5jb20+Ow0KPiBKb25hdGhhbiBDYW1lcm9uIDxq
b25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+Ow0KPiByb2Jpbi5tdXJwaHlAYXJtLmNvbTsgaGNo
QGxzdC5kZTsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBtLnN6eXBy
b3dza2lAc2Ftc3VuZy5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzNdIGFybTY0OiBtbTog
cmVzZXJ2ZSBodWdldGxiIENNQSBhZnRlciBudW1hX2luaXQNCj4gDQo+IA0KPiANCj4gT24gMDMv
MDYvMjAyMCAwNToyMiwgUm9tYW4gR3VzaGNoaW4gd3JvdGU6DQo+ID4gT24gV2VkLCBKdW4gMDMs
IDIwMjAgYXQgMDI6NDI6MzBQTSArMTIwMCwgQmFycnkgU29uZyB3cm90ZToNCj4gPj4gaHVnZXRs
Yl9jbWFfcmVzZXJ2ZSgpIGlzIGNhbGxlZCBhdCB0aGUgd3JvbmcgcGxhY2UuIG51bWFfaW5pdCBo
YXMgbm90IGJlZW4NCj4gPj4gZG9uZSB5ZXQuIHNvIGFsbCByZXNlcnZlZCBtZW1vcnkgd2lsbCBi
ZSBsb2NhdGVkIGF0IG5vZGUwLg0KPiA+Pg0KPiA+PiBDYzogUm9tYW4gR3VzaGNoaW4gPGd1cm9A
ZmIuY29tPg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBCYXJyeSBTb25nIDxzb25nLmJhby5odWFAaGlz
aWxpY29uLmNvbT4NCj4gPg0KPiA+IEFja2VkLWJ5OiBSb21hbiBHdXNoY2hpbiA8Z3Vyb0BmYi5j
b20+DQo+ID4NCj4gDQo+IFdoZW4gZGlkIHRoaXMgYnJlYWsgb3Igd2FzIGl0IGJyb2tlbiBzaW5j
ZSB0aGUgYmVnaW5uaW5nPw0KPiBJbiBhbnkgY2FzZSwgY291bGQgeW91IHByb3ZpZGUgYSAiRml4
ZXMiIHRhZyBmb3IgaXQsIHNvIHRoYXQgaXQgY2FuIGVhc2lseSBiZQ0KPiBiYWNrcG9ydGVkIHRv
IG9sZGVyIHJlbGVhc2VzLg0KDQpJIGd1ZXNzIGl0IHdhcyBicm9rZW4gYXQgdGhlIGZpcnN0IGJl
Z2lubmluZy4NCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2lkPWNmMTFlODVmYzA4Y2MNCg0KRml4ZXM6IGNm
MTFlODVmYzA4YyAoIm1tOiBodWdldGxiOiBvcHRpb25hbGx5IGFsbG9jYXRlIGdpZ2FudGljIGh1
Z2VwYWdlcyB1c2luZyBjbWEiKQ0KDQpXb3VsZCB5b3UgdGhpbmsgaXQgaXMgYmV0dGVyIGZvciBt
ZSB0byBzZW5kIHYyIGZvciB0aGlzIHBhdGNoIHNlcGFyYXRlbHkgd2l0aCB0aGlzIHRhZyBhbmQg
dGFrZSB0aGlzIG91dCBvZiBteSBvcmlnaW5hbCBwYXRjaCBzZXQgZm9yIHBlci1udW1hIENNQT8N
ClBsZWFzZSBnaXZlIHlvdXIgc3VnZ2VzdGlvbi4NCg0KQmVzdCBSZWdhcmRzDQpCYXJyeQ0KDQo+
IA0KPiBSZWdhcmRzLA0KPiBNYXR0aGlhcw0KPiANCj4gPiBUaGFua3MhDQo+ID4NCj4gPj4gLS0t
DQo+ID4+ICBhcmNoL2FybTY0L21tL2luaXQuYyB8IDEwICsrKysrLS0tLS0NCj4gPj4gIDEgZmls
ZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybTY0L21tL2luaXQuYyBiL2FyY2gvYXJtNjQvbW0vaW5pdC5jDQo+
ID4+IGluZGV4IGU0MjcyN2UzNTY4ZS4uOGYwZTcwZWJiNDlkIDEwMDY0NA0KPiA+PiAtLS0gYS9h
cmNoL2FybTY0L21tL2luaXQuYw0KPiA+PiArKysgYi9hcmNoL2FybTY0L21tL2luaXQuYw0KPiA+
PiBAQCAtNDU4LDExICs0NTgsNiBAQCB2b2lkIF9faW5pdCBhcm02NF9tZW1ibG9ja19pbml0KHZv
aWQpDQo+ID4+ICAJaGlnaF9tZW1vcnkgPSBfX3ZhKG1lbWJsb2NrX2VuZF9vZl9EUkFNKCkgLSAx
KSArIDE7DQo+ID4+DQo+ID4+ICAJZG1hX2NvbnRpZ3VvdXNfcmVzZXJ2ZShhcm02NF9kbWEzMl9w
aHlzX2xpbWl0KTsNCj4gPj4gLQ0KPiA+PiAtI2lmZGVmIENPTkZJR19BUk02NF80S19QQUdFUw0K
PiA+PiAtCWh1Z2V0bGJfY21hX3Jlc2VydmUoUFVEX1NISUZUIC0gUEFHRV9TSElGVCk7DQo+ID4+
IC0jZW5kaWYNCj4gPj4gLQ0KPiA+PiAgfQ0KPiA+Pg0KPiA+PiAgdm9pZCBfX2luaXQgYm9vdG1l
bV9pbml0KHZvaWQpDQo+ID4+IEBAIC00NzgsNiArNDczLDExIEBAIHZvaWQgX19pbml0IGJvb3Rt
ZW1faW5pdCh2b2lkKQ0KPiA+PiAgCW1pbl9sb3dfcGZuID0gbWluOw0KPiA+Pg0KPiA+PiAgCWFy
bTY0X251bWFfaW5pdCgpOw0KPiA+PiArDQo+ID4+ICsjaWZkZWYgQ09ORklHX0FSTTY0XzRLX1BB
R0VTDQo+ID4+ICsJaHVnZXRsYl9jbWFfcmVzZXJ2ZShQVURfU0hJRlQgLSBQQUdFX1NISUZUKTsN
Cj4gPj4gKyNlbmRpZg0KPiA+PiArDQo+ID4+ICAJLyoNCj4gPj4gIAkgKiBTcGFyc2VtZW0gdHJp
ZXMgdG8gYWxsb2NhdGUgYm9vdG1lbSBpbiBtZW1vcnlfcHJlc2VudCgpLCBzbyBtdXN0DQo+IGJl
DQo+ID4+ICAJICogZG9uZSBhZnRlciB0aGUgZml4ZWQgcmVzZXJ2YXRpb25zLg0KPiA+PiAtLQ0K
PiA+PiAyLjIzLjANCg0K
