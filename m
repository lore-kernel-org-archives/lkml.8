Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F63C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 20:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 659B820724
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 20:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgHUUrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 16:47:47 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3141 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725831AbgHUUrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 16:47:45 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 0B449708F77DCF66FDA3;
        Sat, 22 Aug 2020 04:47:43 +0800 (CST)
Received: from dggema773-chm.china.huawei.com (10.1.198.217) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Sat, 22 Aug 2020 04:47:42 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggema773-chm.china.huawei.com (10.1.198.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sat, 22 Aug 2020 04:47:42 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Sat, 22 Aug 2020 04:47:42 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>, "hch@lst.de" <hch@lst.de>,
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
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v7 0/3] make dma_alloc_coherent NUMA-aware by per-NUMA CMA
Thread-Topic: [PATCH v7 0/3] make dma_alloc_coherent NUMA-aware by per-NUMA
 CMA
Thread-Index: AQHWd+P3Cxxhv5+npUG1WD6UP12kNalC7yyQgAAUM8A=
Date:   Fri, 21 Aug 2020 20:47:42 +0000
Message-ID: <0a1636c9a3cc4bafb64ef43bed19f2fe@hisilicon.com>
References: <20200821113355.6140-1-song.bao.hua@hisilicon.com>
 <e47f4bfd-3af7-f682-23a1-51800f992d35@oracle.com> 
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU29uZyBCYW8gSHVhIChC
YXJyeSBTb25nKQ0KPiBTZW50OiBTYXR1cmRheSwgQXVndXN0IDIyLCAyMDIwIDc6MjcgQU0NCj4g
VG86ICdNaWtlIEtyYXZldHonIDxtaWtlLmtyYXZldHpAb3JhY2xlLmNvbT47IGhjaEBsc3QuZGU7
DQo+IG0uc3p5cHJvd3NraUBzYW1zdW5nLmNvbTsgcm9iaW4ubXVycGh5QGFybS5jb207IHdpbGxA
a2VybmVsLm9yZzsNCj4gZ2FuYXBhdHJhby5rdWxrYXJuaUBjYXZpdW0uY29tOyBjYXRhbGluLm1h
cmluYXNAYXJtLmNvbTsNCj4gYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZw0KPiBDYzogaW9tbXVA
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgWmVuZ3RhbyAoQikgPHBy
aW1lLnplbmdAaGlzaWxpY29uLmNvbT47DQo+IGh1YW5nZGFvZGUgPGh1YW5nZGFvZGVAaHVhd2Vp
LmNvbT47IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPg0KPiBTdWJqZWN0OiBSRTogW1BB
VENIIHY3IDAvM10gbWFrZSBkbWFfYWxsb2NfY29oZXJlbnQgTlVNQS1hd2FyZSBieQ0KPiBwZXIt
TlVNQSBDTUENCj4gDQo+IA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
IEZyb206IE1pa2UgS3JhdmV0eiBbbWFpbHRvOm1pa2Uua3JhdmV0ekBvcmFjbGUuY29tXQ0KPiA+
IFNlbnQ6IFNhdHVyZGF5LCBBdWd1c3QgMjIsIDIwMjAgNTo1MyBBTQ0KPiA+IFRvOiBTb25nIEJh
byBIdWEgKEJhcnJ5IFNvbmcpIDxzb25nLmJhby5odWFAaGlzaWxpY29uLmNvbT47IGhjaEBsc3Qu
ZGU7DQo+ID4gbS5zenlwcm93c2tpQHNhbXN1bmcuY29tOyByb2Jpbi5tdXJwaHlAYXJtLmNvbTsg
d2lsbEBrZXJuZWwub3JnOw0KPiA+IGdhbmFwYXRyYW8ua3Vsa2FybmlAY2F2aXVtLmNvbTsgY2F0
YWxpbi5tYXJpbmFzQGFybS5jb207DQo+ID4gYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZw0KPiA+
IENjOiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsgbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnOw0KPiA+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFpl
bmd0YW8gKEIpIDxwcmltZS56ZW5nQGhpc2lsaWNvbi5jb20+Ow0KPiA+IGh1YW5nZGFvZGUgPGh1
YW5nZGFvZGVAaHVhd2VpLmNvbT47IExpbnV4YXJtDQo+IDxsaW51eGFybUBodWF3ZWkuY29tPg0K
PiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMC8zXSBtYWtlIGRtYV9hbGxvY19jb2hlcmVudCBO
VU1BLWF3YXJlIGJ5DQo+ID4gcGVyLU5VTUEgQ01BDQo+ID4NCj4gPiBIaSBCYXJyeSwNCj4gPiBT
b3JyeSBmb3IganVtcGluZyBpbiBzbyBsYXRlLg0KPiA+DQo+ID4gT24gOC8yMS8yMCA0OjMzIEFN
LCBCYXJyeSBTb25nIHdyb3RlOg0KPiA+ID4NCj4gPiA+IHdpdGggcGVyLW51bWEgQ01BLCBzbW11
IHdpbGwgZ2V0IG1lbW9yeSBmcm9tIGxvY2FsIG51bWEgbm9kZSB0byBzYXZlDQo+ID4gY29tbWFu
ZA0KPiA+ID4gcXVldWVzIGFuZCBwYWdlIHRhYmxlcy4gdGhhdCBtZWFucyBkbWFfdW5tYXAgbGF0
ZW5jeSB3aWxsIGJlIHNocnVuaw0KPiA+IG11Y2guDQo+ID4NCj4gPiBTaW5jZSBwZXItbm9kZSBD
TUEgYXJlYXMgZm9yIGh1Z2V0bGIgd2FzIGludHJvZHVjZWQsIEkgaGF2ZSBiZWVuIHRoaW5raW5n
DQo+ID4gYWJvdXQgdGhlIGxpbWl0ZWQgbnVtYmVyIG9mIENNQSBhcmVhcy4gIEluIG1vc3QgY29u
ZmlndXJhdGlvbnMsIEkgYmVsaWV2ZQ0KPiA+IGl0IGlzIGxpbWl0ZWQgdG8gNy4gIEFuZCwgSUlS
QyBpdCBpcyBub3Qgc29tZXRoaW5nIHRoYXQgY2FuIGJlIGNoYW5nZWQgYXQNCj4gPiBydW50aW1l
LCB5b3UgbmVlZCB0byByZWNvbmZpZyBhbmQgcmVidWlsZCB0byBpbmNyZWFzZSB0aGUgbnVtYmVy
LiAgSW4NCj4gY29udHJhc3QNCj4gPiBzb21lIGNvbmZpZ3MgaGF2ZSBOT0RFU19TSElGVCBzZXQg
dG8gMTAuICBJIHdhc24ndCB0b28gd29ycmllZCBiZWNhdXNlIG9mDQo+ID4gdGhlIGxpbWl0ZWQg
aHVnZXRsYiB1c2UgY2FzZS4gIEhvd2V2ZXIsIHRoaXMgc2VyaWVzIGlzIGFkZGluZyBhbm90aGVy
IHVzZXINCj4gPiBvZiBwZXItbm9kZSBDTUEgYXJlYXMuDQo+ID4NCj4gPiBXaXRoIG1vcmUgdXNl
cnMsIHNob3VsZCB0cnkgdG8gc3luYyB1cCBudW1iZXIgb2YgQ01BIGFyZWFzIGFuZCBudW1iZXIg
b2YNCj4gPiBub2Rlcz8gIE9yLCBwZXJoYXBzIEkgYW0gd29ycnlpbmcgYWJvdXQgbm90aGluZz8N
Cj4gDQo+IEhpIE1pa2UsDQo+IFRoZSBjdXJyZW50IGxpbWl0YXRpb24gaXMgOC4gSWYgdGhlIHNl
cnZlciBoYXMgNCBub2RlcyBhbmQgd2UgZW5hYmxlIGJvdGgNCj4gcGVybnVtYQ0KPiBDTUEgYW5k
IGh1Z2V0bGIsIHRoZSBsYXN0IG5vZGUgd2lsbCBmYWlsIHRvIGdldCBvbmUgY21hIGFyZWEgYXMg
dGhlIGRlZmF1bHQNCj4gZ2xvYmFsIGNtYSBhcmVhIHdpbGwgdGFrZSAxIG9mIDguIFNvIHVzZXJz
IG5lZWQgdG8gY2hhbmdlIG1lbnVjb25maWcuDQo+IElmIHRoZSBzZXJ2ZXIgaGFzIDggbm9kZXMs
IHdlIGVuYWJsZSBvbmUgb2YgcGVybnVtYSBjbWEgYW5kIGh1Z2V0bGIsIG9uZQ0KPiBub2RlDQo+
IHdpbGwgZmFpbCB0byBnZXQgY21hLg0KPiANCj4gV2UgbWF5IHNldCB0aGUgZGVmYXVsdCBudW1i
ZXIgb2YgQ01BIGFyZWFzIGFzIDgrTUFYX05PREVTKGlmIGh1Z2V0bGINCj4gZW5hYmxlZCkgKw0K
PiBNQVhfTk9ERVMoaWYgcGVybnVtYSBjbWEgZW5hYmxlZCkgaWYgd2UgZG9uJ3QgZXhwZWN0IHVz
ZXJzIHRvIGNoYW5nZQ0KPiBjb25maWcsIGJ1dA0KPiByaWdodCBub3cgaHVnZXRsYiBoYXMgbm90
IGFuIG9wdGlvbiBpbiBLY29uZmlnIHRvIGVuYWJsZSBvciBkaXNhYmxlIGxpa2UNCj4gcGVybnVt
YSBjbWENCj4gaGFzIERNQV9QRVJOVU1BX0NNQS4NCg0KSSB3b3VsZCBwcmVmZXIgd2UgbWFrZSBz
b21lIGNoYW5nZXMgbGlrZToNCg0KY29uZmlnIENNQV9BUkVBUw0KCWludCAiTWF4aW11bSBjb3Vu
dCBvZiB0aGUgQ01BIGFyZWFzIg0KCWRlcGVuZHMgb24gQ01BDQorCWRlZmF1bHQgMTkgaWYgTlVN
QQ0KCWRlZmF1bHQgNw0KCWhlbHANCgkgIENNQSBhbGxvd3MgdG8gY3JlYXRlIENNQSBhcmVhcyBm
b3IgcGFydGljdWxhciBwdXJwb3NlLCBtYWlubHksDQoJICB1c2VkIGFzIGRldmljZSBwcml2YXRl
IGFyZWEuIFRoaXMgcGFyYW1ldGVyIHNldHMgdGhlIG1heGltdW0NCgkgIG51bWJlciBvZiBDTUEg
YXJlYSBpbiB0aGUgc3lzdGVtLg0KDQotCSAgSWYgdW5zdXJlLCBsZWF2ZSB0aGUgZGVmYXVsdCB2
YWx1ZSAiNyIuDQorCSAgSWYgdW5zdXJlLCBsZWF2ZSB0aGUgZGVmYXVsdCB2YWx1ZSAiNyIgb3Ig
IjE5IiBpZiBOVU1BIGlzIHVzZWQuDQoNCjErIENPTkZJR19DTUFfQVJFQVMgc2hvdWxkIGJlIHF1
aXRlIGVub3VnaCBmb3IgYWxtb3N0IGFsbCBzZXJ2ZXJzIGluIHRoZSBtYXJrZXRzLg0KDQpJZiAy
IG51bWEgbm9kZXMsIGFuZCBib3RoIGh1Z2V0bGIgY21hIGFuZCBwZXJudW1hIGNtYSBpcyBlbmFi
bGVkLCB3ZSBuZWVkIDIqMiArIDEgPSA1DQpJZiA0IG51bWEgbm9kZXMsIGFuZCBib3RoIGh1Z2V0
bGIgY21hIGFuZCBwZXJudW1hIGNtYSBpcyBlbmFibGVkLCB3ZSBuZWVkIDIqNCArIDEgPSA5ICAg
IC0+IGRlZmF1bHQgQVJNNjQgY29uZmlnLg0KSWYgOCBudW1hIG5vZGVzLCBhbmQgYm90aCBodWdl
dGxiIGNtYSBhbmQgcGVybnVtYSBjbWEgaXMgZW5hYmxlZCwgd2UgbmVlZCAyKjggKyAxID0gMTcN
Cg0KVGhlIGRlZmF1bHQgdmFsdWUgaXMgc3VwcG9ydGluZyB0aGUgbW9zdCBjb21tb24gY2FzZSBh
bmQgaXMgbm90IGdvaW5nIHRvIHN1cHBvcnQgdGhvc2Ugc2VydmVycw0Kd2l0aCBOT0RFU19TSElG
VD0xMCwgdGhleSBjYW4gbWFrZSB0aGVpciBvd24gY29uZmlnIGp1c3QgbGlrZSB1c2VycyBuZWVk
IHRvIGluY3JlYXNlIENNQV9BUkVBUw0KaWYgdGhleSBhZGQgbWFueSBjbWEgYXJlYXMgaW4gZGV2
aWNlIHRyZWUgaW4gYSBzeXN0ZW0gZXZlbiB3aXRob3V0IE5VTUEuDQoNCkhvdyBkbyB5b3UgdGhp
bmssIG1pa2U/DQoNClRoYW5rcw0KQmFycnkNCg==
