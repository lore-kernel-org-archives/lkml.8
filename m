Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EFFC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B119020735
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgHUTRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:17:11 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3140 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725801AbgHUTRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:17:08 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 29221672D2BB94E0A5A2;
        Sat, 22 Aug 2020 03:17:05 +0800 (CST)
Received: from dggema722-chm.china.huawei.com (10.3.20.86) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Sat, 22 Aug 2020 03:17:04 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggema722-chm.china.huawei.com (10.3.20.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sat, 22 Aug 2020 03:17:04 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Sat, 22 Aug 2020 03:17:04 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Randy Dunlap <rdunlap@infradead.org>, "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "ganapatrao.kulkarni@cavium.com" <ganapatrao.kulkarni@cavium.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        huangdaode <huangdaode@huawei.com>,
        Linuxarm <linuxarm@huawei.com>,
        "Jonathan Cameron" <jonathan.cameron@huawei.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Steve Capper <steve.capper@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: RE: [PATCH v7 1/3] dma-contiguous: provide the ability to reserve
 per-numa CMA
Thread-Topic: [PATCH v7 1/3] dma-contiguous: provide the ability to reserve
 per-numa CMA
Thread-Index: AQHWd69ix8OgXlSJiUCOYl4oKg5K9qlCNSCAgAC5sFA=
Date:   Fri, 21 Aug 2020 19:17:04 +0000
Message-ID: <b24cfc9fca7842b78ff6b7af575c0843@hisilicon.com>
References: <20200821113355.6140-1-song.bao.hua@hisilicon.com>
 <20200821113355.6140-2-song.bao.hua@hisilicon.com>
 <5eafce91-cc92-e6ed-23b0-98f253129e1b@infradead.org>
In-Reply-To: <5eafce91-cc92-e6ed-23b0-98f253129e1b@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.113]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFuZHkgRHVubGFwIFtt
YWlsdG86cmR1bmxhcEBpbmZyYWRlYWQub3JnXQ0KPiBTZW50OiBTYXR1cmRheSwgQXVndXN0IDIy
LCAyMDIwIDQ6MDggQU0NCj4gVG86IFNvbmcgQmFvIEh1YSAoQmFycnkgU29uZykgPHNvbmcuYmFv
Lmh1YUBoaXNpbGljb24uY29tPjsgaGNoQGxzdC5kZTsNCj4gbS5zenlwcm93c2tpQHNhbXN1bmcu
Y29tOyByb2Jpbi5tdXJwaHlAYXJtLmNvbTsgd2lsbEBrZXJuZWwub3JnOw0KPiBnYW5hcGF0cmFv
Lmt1bGthcm5pQGNhdml1bS5jb207IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOw0KPiBha3BtQGxp
bnV4LWZvdW5kYXRpb24ub3JnDQo+IENjOiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBaZW5ndGFvIChCKSA8cHJpbWUuemVuZ0BoaXNpbGljb24uY29tPjsN
Cj4gaHVhbmdkYW9kZSA8aHVhbmdkYW9kZUBodWF3ZWkuY29tPjsgTGludXhhcm0gPGxpbnV4YXJt
QGh1YXdlaS5jb20+Ow0KPiBKb25hdGhhbiBDYW1lcm9uIDxqb25hdGhhbi5jYW1lcm9uQGh1YXdl
aS5jb20+OyBOaWNvbGFzIFNhZW56IEp1bGllbm5lDQo+IDxuc2FlbnpqdWxpZW5uZUBzdXNlLmRl
PjsgU3RldmUgQ2FwcGVyIDxzdGV2ZS5jYXBwZXJAYXJtLmNvbT47IE1pa2UNCj4gUmFwb3BvcnQg
PHJwcHRAbGludXguaWJtLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyAxLzNdIGRtYS1j
b250aWd1b3VzOiBwcm92aWRlIHRoZSBhYmlsaXR5IHRvIHJlc2VydmUNCj4gcGVyLW51bWEgQ01B
DQo+IA0KPiBPbiA4LzIxLzIwIDQ6MzMgQU0sIEJhcnJ5IFNvbmcgd3JvdGU6DQo+ID4gLS0tDQo+
ID4gIC12Nzogd2l0aCByZXNwZWN0IHRvIFdpbGwncyBjb21tZW50cw0KPiA+ICAqIG1vdmUgdG8g
dXNlIGZvcl9lYWNoX29ubGluZV9ub2RlDQo+ID4gICogYWRkIGRlc2NyaXB0aW9uIGlmIHVzZXJz
IGRvbid0IHNwZWNpZnkgcGVybnVtYV9jbWENCj4gPiAgKiBwcm92aWRlIGRlZmF1bHQgdmFsdWUg
Zm9yIENPTkZJR19ETUFfUEVSTlVNQV9DTUENCj4gPg0KPiA+ICAuLi4vYWRtaW4tZ3VpZGUva2Vy
bmVsLXBhcmFtZXRlcnMudHh0ICAgICAgICAgfCAgMTEgKysNCj4gPiAgaW5jbHVkZS9saW51eC9k
bWEtY29udGlndW91cy5oICAgICAgICAgICAgICAgIHwgICA2ICsrDQo+ID4gIGtlcm5lbC9kbWEv
S2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxMSArKw0KPiA+ICBrZXJuZWwv
ZG1hL2NvbnRpZ3VvdXMuYyAgICAgICAgICAgICAgICAgICAgICAgfCAxMDANCj4gKysrKysrKysr
KysrKysrKy0tDQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgMTE4IGluc2VydGlvbnMoKyksIDEwIGRl
bGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vYWRtaW4tZ3Vp
ZGUva2VybmVsLXBhcmFtZXRlcnMudHh0DQo+IGIvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9r
ZXJuZWwtcGFyYW1ldGVycy50eHQNCj4gPiBpbmRleCBiZGMxZjMzZmQzZDEuLmM2MDk1MjdmYzM1
YSAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJh
bWV0ZXJzLnR4dA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2VybmVsLXBh
cmFtZXRlcnMudHh0DQo+ID4gQEAgLTU5OSw2ICs1OTksMTcgQEANCj4gPiAgCQkJYWx0b2dldGhl
ci4gRm9yIG1vcmUgaW5mb3JtYXRpb24sIHNlZQ0KPiA+ICAJCQlpbmNsdWRlL2xpbnV4L2RtYS1j
b250aWd1b3VzLmgNCj4gPg0KPiA+ICsJcGVybnVtYV9jbWE9bm5bTUddDQo+ID4gKwkJCVtBUk02
NCxLTkxdDQo+ID4gKwkJCVNldHMgdGhlIHNpemUgb2Yga2VybmVsIHBlci1udW1hIG1lbW9yeSBh
cmVhIGZvcg0KPiA+ICsJCQljb250aWd1b3VzIG1lbW9yeSBhbGxvY2F0aW9ucy4gQSB2YWx1ZSBv
ZiAwIGRpc2FibGVzDQo+ID4gKwkJCXBlci1udW1hIENNQSBhbHRvZ2V0aGVyLiBBbmQgSWYgdGhp
cyBvcHRpb24gaXMgbm90DQo+ID4gKwkJCXNwZWNpZmljZWQsIHRoZSBkZWZhdWx0IHZhbHVlIGlz
IDAuDQo+ID4gKwkJCVdpdGggcGVyLW51bWEgQ01BIGVuYWJsZWQsIERNQSB1c2VycyBvbiBub2Rl
IG5pZCB3aWxsDQo+ID4gKwkJCWZpcnN0IHRyeSB0byBhbGxvY2F0ZSBidWZmZXIgZnJvbSB0aGUg
cGVybnVtYSBhcmVhDQo+ID4gKwkJCXdoaWNoIGlzIGxvY2F0ZWQgaW4gbm9kZSBuaWQsIGlmIHRo
ZSBhbGxvY2F0aW9uIGZhaWxzLA0KPiA+ICsJCQl0aGV5IHdpbGwgZmFsbGJhY2sgdG8gdGhlIGds
b2JhbCBkZWZhdWx0IG1lbW9yeSBhcmVhLg0KPiA+ICsNCj4gDQo+IEVudHJpZXMgaW4ga2VybmVs
LXBhcmFtZXRlcnMudHh0IGFyZSBzdXBwb3NlZCB0byBiZSBpbiBhbHBoYWJldGljYWwgb3JkZXIN
Cj4gYnV0IHRoaXMgb25lIGlzIG5vdC4gIElmIHlvdSB3YW50IHRvIGtlZXAgaXQgbmVhciB0aGUg
Y21hPSBlbnRyeSwgeW91IGNhbg0KPiByZW5hbWUgaXQgbGlrZSBNaWtlIHN1Z2dlc3RlZC4gIE90
aGVyd2lzZSBpdCBuZWVkcyB0byBiZSBtb3ZlZC4NCg0KQXMgSSd2ZSByZXBsaWVkIGluIE1pa2Un
cyBjb21tZW50LCBJJ2QgbGlrZSB0byByZW5hbWUgaXQgdG8gY21hX3Blci4uLg0KDQo+IA0KPiAN
Cj4gPiAgCWNtb19mcmVlX2hpbnQ9CVtQUENdIEZvcm1hdDogeyB5ZXMgfCBubyB9DQo+ID4gIAkJ
CVNwZWNpZnkgd2hldGhlciBwYWdlcyBhcmUgbWFya2VkIGFzIGJlaW5nIGluYWN0aXZlDQo+ID4g
IAkJCXdoZW4gdGhleSBhcmUgZnJlZWQuICBUaGlzIGlzIHVzZWQgaW4gQ01PIGVudmlyb25tZW50
cw0KPiANCj4gDQo+IA0KPiAtLQ0KPiB+UmFuZHkNCg0KVGhhbmtzDQpCYXJyeQ0KDQo=
