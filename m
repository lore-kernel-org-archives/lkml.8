Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EE1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 03:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62A5A206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 03:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgGXDkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 23:40:40 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2989 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726500AbgGXDkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 23:40:39 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 0A897205CB04CB491566;
        Fri, 24 Jul 2020 11:40:38 +0800 (CST)
Received: from DGGEMM421-HUB.china.huawei.com (10.1.198.38) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 24 Jul 2020 11:40:37 +0800
Received: from DGGEMM526-MBX.china.huawei.com ([169.254.8.195]) by
 dggemm421-hub.china.huawei.com ([10.1.198.38]) with mapi id 14.03.0487.000;
 Fri, 24 Jul 2020 11:40:28 +0800
From:   "liwei (CM)" <liwei213@huawei.com>
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
CC:     "will@kernel.org" <will@kernel.org>,
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
Subject: =?gb2312?B?tPC4tDogtPC4tDogtPC4tDogW1BBVENIXSBhcm02NDogbW06IGZyZWUgdW51?=
 =?gb2312?B?c2VkIG1lbW1hcCBmb3Igc3BhcnNlIG1lbW9yeSBtb2RlbCB0aGF0IGRlZmlu?=
 =?gb2312?Q?e_VMEMMAP?=
Thread-Topic: =?gb2312?B?tPC4tDogtPC4tDogW1BBVENIXSBhcm02NDogbW06IGZyZWUgdW51c2VkIG1l?=
 =?gb2312?B?bW1hcCBmb3Igc3BhcnNlIG1lbW9yeSBtb2RlbCB0aGF0IGRlZmluZSBWTUVN?=
 =?gb2312?Q?MAP?=
Thread-Index: AQHWXzEQMpvo3yT4K0COUiys26URoqkSmCeAgAClMpD//8slAIAAjr5AgADtUACAAB6BgIABbsbg
Date:   Fri, 24 Jul 2020 03:40:28 +0000
Message-ID: <1699CE87DE933F49876AD744B5DC140F231335A0@dggemm526-mbx.china.huawei.com>
References: <20200721073203.107862-1-liwei213@huawei.com>
 <20200722060705.GK802087@linux.ibm.com>
 <1699CE87DE933F49876AD744B5DC140F2312E948@dggemm526-mbx.china.huawei.com>
 <20200722124910.GE27540@gaia>
 <1699CE87DE933F49876AD744B5DC140F2312F0D6@dggemm526-mbx.china.huawei.com>
 <20200723112926.GB7315@gaia> <20200723131837.GC1975360@linux.ibm.com>
In-Reply-To: <20200723131837.GC1975360@linux.ibm.com>
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

DQoNCi0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjLOiBNaWtlIFJhcG9wb3J0IFttYWlsdG86cnBw
dEBsaW51eC5pYm0uY29tXSANCreiy83KsbzkOiAyMDIwxOo31MIyM8jVIDIxOjE5DQrK1bz+yMs6
IENhdGFsaW4gTWFyaW5hcyA8Y2F0YWxpbi5tYXJpbmFzQGFybS5jb20+DQqzrcvNOiBsaXdlaSAo
Q00pIDxsaXdlaTIxM0BodWF3ZWkuY29tPjsgd2lsbEBrZXJuZWwub3JnOyBYaWFxaW5nIChBKSA8
c2FiZXJsaWx5LnhpYUBoaXNpbGljb24uY29tPjsgQ2hlbmZlbmcgKHB1Y2spIDxwdWNrLmNoZW5A
aGlzaWxpY29uLmNvbT47IGJ1dGFvIDxidXRhb0BoaXNpbGljb24uY29tPjsgZmVuZ2Jhb3Blbmcg
PGZlbmdiYW9wZW5nMkBoaXNpbGljb24uY29tPjsgbnNhZW56anVsaWVubmVAc3VzZS5kZTsgc3Rl
dmUuY2FwcGVyQGFybS5jb207IFNvbmcgQmFvIEh1YSAoQmFycnkgU29uZykgPHNvbmcuYmFvLmh1
YUBoaXNpbGljb24uY29tPjsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBzdWp1bmZlaSA8c3VqdW5mZWkyQGhpc2lsaWNv
bi5jb20+OyB6aGFvamlhcGVuZyA8emhhb2ppYXBlbmdAaHVhd2VpLmNvbT4NCtb3zOI6IFJlOiC0
8Li0OiC08Li0OiBbUEFUQ0hdIGFybTY0OiBtbTogZnJlZSB1bnVzZWQgbWVtbWFwIGZvciBzcGFy
c2UgbWVtb3J5IG1vZGVsIHRoYXQgZGVmaW5lIFZNRU1NQVANCg0KT24gVGh1LCBKdWwgMjMsIDIw
MjAgYXQgMTI6Mjk6MjZQTSArMDEwMCwgQ2F0YWxpbiBNYXJpbmFzIHdyb3RlOg0KPiBPbiBXZWQs
IEp1bCAyMiwgMjAyMCBhdCAwMTo0MDozNFBNICswMDAwLCBsaXdlaSAoQ00pIHdyb3RlOg0KPiA+
IENhdGFsaW4gTWFyaW5hcyB3cm90ZToNCj4gPiA+IE9uIFdlZCwgSnVsIDIyLCAyMDIwIGF0IDA4
OjQxOjE3QU0gKzAwMDAsIGxpd2VpIChDTSkgd3JvdGU6DQo+ID4gPiA+IE1pa2UgUmFwb3BvcnQg
d3JvdGU6DQo+ID4gPiA+ID4gT24gVHVlLCBKdWwgMjEsIDIwMjAgYXQgMDM6MzI6MDNQTSArMDgw
MCwgV2VpIExpIHdyb3RlOg0KPiA+ID4gPiA+ID4gRm9yIHRoZSBtZW1vcnkgaG9sZSwgc3BhcnNl
IG1lbW9yeSBtb2RlbCB0aGF0IGRlZmluZSANCj4gPiA+ID4gPiA+IFNQQVJTRU1FTV9WTUVNTUFQ
IGRvIG5vdCBmcmVlIHRoZSByZXNlcnZlZCBtZW1vcnkgZm9yIHRoZSANCj4gPiA+ID4gPiA+IHBh
Z2UgbWFwLCB0aGlzIHBhdGNoIGRvIGl0Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEFyZSB0aGVy
ZSBudW1iZXJzIHNob3dpbmcgaG93IG11Y2ggbWVtb3J5IGlzIGFjdHVhbGx5IGZyZWVkPw0KPiA+
ID4gPiA+IA0KPiA+ID4gPiA+IFRoZSBmcmVlaW5nIG9mIGVtcHR5IG1lbW1hcCB3b3VsZCBiZWNv
bWUgcmF0aGVyIGNvbXBsZXggd2l0aCANCj4gPiA+ID4gPiB0aGVzZSBjaGFuZ2VzLCBkbyB0aGUg
bWVtb3J5IHNhdmluZ3MganVzdGlmeSBpdD8NCj4gPiA+ID4gDQo+ID4gPiA+IEluIHRoZSBzcGFy
c2UgbWVtb3J5IG1vZGVsLCB0aGUgc2l6ZSBvZiBhIHNlY3Rpb24gaXMgMSBHQiANCj4gPiA+ID4g
KFNFQ1RJT05fU0laRV9CSVRTIDMwKSBieSBkZWZhdWx0Lg0KPiA+ID4gDQo+ID4gPiBDYW4gd2Ug
cmVkdWNlIFNFQ1RJT05fU0laRV9CSVRTIGluc3RlYWQ/IFNheSAyNj8NCj4gPiANCj4gPiBZZXMs
IHlvdSBhcmUgcmlnaHQsIHJlZHVjZSBTRUNUSU9OX1NJWkVfQklUUyB0byAyNiBjYW4gc2F2ZSBh
bG1vc3QgDQo+ID4gdGhlIHNhbWUgbWVtb3J5IGFzIHRoZSBwYXRjaC4NCj4gPiANCj4gPiAxKSBI
b3dldmVyLCBpdCBpcyBub3QgY2xlYXIgd2hldGhlciBjaGFuZ2luZyB0aGUgc2VjdGlvbiBzaXpl
IGhhcyANCj4gPiBhbnkgb3RoZXIgaW1wYWN0Lg0KPiANCj4gV2VsbCwgd2Ugc2hvdWxkIGFuYWx5
c2UgdGhpcy4NCj4gDQo+ID4gMikgSnVzdCBsaWtlIHRoZSBmbGF0IG1lbW9yeSBtb2RlbCBhbmQg
dGhlIHNwYXJzZSBtZW1vcnkgbW9kZWwgdGhhdCANCj4gPiBkb2VzIG5vdCBkZWZpbmUgVk1FTU1B
UCwgYm90aCBvZiB0aGVtIGhhdmUgdGhlaXIgb3duIHdheXMgdG8gZnJlZSANCj4gPiB1bnVzZWQg
bWVtbWFwLiBJIHRoaW5rIHdlJ3ZlIGdpdmVuIGEgc2ltaWxhciB3YXkgZm9yIHNwYXJzZSBtZW1v
cnkgDQo+ID4gZGVmaW5lIFZNRU1NQVAuDQo+IA0KPiBJIHRoaW5rIHdlIGRpZCBpdCBmb3IgZmxh
dG1lbSBpbml0aWFsbHkgKG9uIGFybTMyKSBhbmQgYWRkZWQgc3VwcG9ydCANCj4gZm9yIHNwYXJz
ZW1lbSBsYXRlciBvbiwgc28gZnJlZV91bnVzZWRfbWVtbWFwKCkgaGFkIHRvIGNvcGUgd2l0aCAN
Cj4gc3BhcnNlIHNlY3Rpb25zLiBPbiBhcm02NCB3ZSBpbnRyb2R1Y2VkIHZtZW1tYXAgc3VwcG9y
dCBhbmQgZGlkbid0IA0KPiBib3RoZXIgd2l0aCB0aGUgZnJlZWluZyBhdCBhbGwgYmVjYXVzZSBv
ZiB0aGUgYWRkZWQgY29tcGxleGl0eSBvZiB0aGUgDQo+IHZtZW1tYXAgcGFnZSB0YWJsZXMuDQo+
IA0KPiBJIHdvbmRlciB3aGV0aGVyIHdlIHNob3VsZCBqdXN0IGRpc2FsbG93IGZsYXRtZW0gYW5k
IG5vbi12bWVtbWFwIA0KPiBzcGFyc2VtZW0gb24gYXJtNjQuIElzIHRoZXJlIGFueSB2YWx1ZSBp
biBrZWVwaW5nIHRoZW0gYXJvdW5kPw0KDQpGTEFUTUVNIGlzIHVzZWZ1bCBmb3IgVU1BIHN5c3Rl
bXMgd2l0aCBhIHNpbmdsZSBtZW1vcnkgYmFuaywgc28gcHJvYmFibHkgaXQncyB3b3J0aCBrZWVw
aW5nIGl0IGZvciBsb3cgZW5kIG1hY2hpbmVzLg0KDQpOb24tdm1lbW1hcCBzcGFyc2VtZW0gaXMg
ZXNzZW50aWFsbHkgZGlzYWJsZSBpbiBhcmNoL2FybTY0L0tjb25maWcsIHNvIGZvciBOVU1BIGNv
bmZpZ3VyYXRpb25zIFNQQVJTRU1FTV9WTUVNTUFQIGlzIHRoZSBvbmx5IGNob2ljZS4NCiANCj4g
PiAzKSBUaGlzIGV4cGxpY2l0IGZyZWUgdW51c2VkIG1lbW1hcCBtZXRob2QgZG9lcyByZWR1Y2Ug
dW5uZWNlc3NhcnkgDQo+ID4gbWVtb3J5IHdhc3RlIGZvciB1c2VycyB3aG8gZG8gbm90IG5vdGlj
ZSB0aGUgc2VjdGlvbiBzaXplIA0KPiA+IG1vZGlmaWNhdGlvbi4NCj4gDQo+IEJ1dCBpZiB3ZSBj
aGFuZ2VkIFNFQ1RJT05fU0laRV9CSVRTIGluIHRoZSBtYWlubGluZSBrZXJuZWwsIHRoZW4gd2Ug
DQo+IHdvdWxkbid0IG5lZWQgYWRkaXRpb25hbCBjb2RlIHRvIGZyZWUgdGhlIHVudXNlZCBtZW1t
YXAuDQoNCk1vcmVvdmVyIGlmIHdlIHJlZHVjZSBTRUNUSU9OX1NJWkVfQklUUywgd2UgY2FuIGRy
b3ANCmZyZWVfdW51c2VkX21lbW1hcCgpIGFuZCBzaW5jZSB0aGUgYXJtNjQgbWVtb3J5IG1hcCBm
b3Igc3BhcnNlIHdpbGwgbm90IGRpZmZlciBmcm9tIG90aGVyIGFyY2hlcyB3ZSBjYW4gZHJvcCBj
dXN0b20gcGZuX3ZhbGlkKCkgYXMgd2VsbC4NCg0KSGksIE1pa2UgJiBDYXRhbGluDQoNCkxldCdz
IHRoaW5rIGFuZCBkaXNjdXNzIHRvZ2V0aGVyIGFib3V0IHRoZSBpbXBhY3Qgb2YgZGlyZWN0bHkg
cmVkdWNpbmcgdGhlIHNlY3Rpb24gc2l6ZaO6DQoNCjEpIEN1cnJlbnRseSwgdGhlIG1lbW9yeSBv
ZiBQQyBvciBNb2JpbGUgZGV2aWNlcyBhcmUgaW5jcmVhc2luZy4gSWYgdGhlIHNlY3Rpb24gc2l6
ZSBpcyByZWR1Y2VkLCB0aGUgY29uc3VtcHRpb24gb2YgdGhlIHNlY3Rpb24gc3RydWN0dXJlIHdp
bGwgYWxzbyBpbmNyZWFzZS4NCg0KMikgSWYgdGhlIHNlY3Rpb24gc2l6ZSBpcyB0b28gc21hbGws
IG1lbW9yeSBob3RwbHVnIG1heSBiZSBhZmZlY3RlZC4gSG90cGx1ZyBhZGQgb3IgcmVtb3ZlIGEg
bWVtYmxvY2sgbWVhbnMgdGhhdCB5b3UgbmVlZCB0byBvbmxpbmUgb3Igb2ZmbGluZSBtYW55IHNl
Y3Rpb25zLiBJbiB0aGlzIGNhc2UsIHNvZnR3YXJlIGNvbnN1bXB0aW9uIG1heSBpbmNyZWFzZS4N
Cg0KQ3VycmVudGx5LCB0aGUgcGFnZSBtYXAgaXMgd2FzdGVkIHdoZW4gdGhlIGRlZmF1bHQgc2Vj
dGlvbiBzaXplIGlzIHVzZWQuIEluIHNvbWUgY2FzZXMsIHRoZSB3YXN0ZSBpcyBzZXJpb3VzLiBQ
bGVhc2UgaGVscCB0byBjaGVjayB3aGV0aGVyIHRoZSBzZWN0aW9uIHNpemUgcmVkdWN0aW9uIGhh
cyBvdGhlciBpbXBhY3RzIGFuZCB3aGV0aGVyIGl0IG1lZXRzIHRoZSBsb25nLXRlcm0gZXZvbHV0
aW9uLg0KDQpUaGFua3MuDQoNCj4gLS0NCj4gQ2F0YWxpbg0KDQotLQ0KU2luY2VyZWx5IHlvdXJz
LA0KTWlrZS4NCg==
