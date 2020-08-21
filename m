Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFEBC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64F7220735
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgHUT36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:29:58 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3493 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725801AbgHUT35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:29:57 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id AED36C3FAF846FD56BCF;
        Sat, 22 Aug 2020 03:29:55 +0800 (CST)
Received: from dggema722-chm.china.huawei.com (10.3.20.86) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Sat, 22 Aug 2020 03:29:55 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggema722-chm.china.huawei.com (10.3.20.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sat, 22 Aug 2020 03:29:55 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Sat, 22 Aug 2020 03:29:55 +0800
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
Thread-Index: AQHWd+P3Cxxhv5+npUG1WD6UP12kNalC7yyQ
Date:   Fri, 21 Aug 2020 19:29:55 +0000
Message-ID: <328438204e9e4afba84b20c6b778c504@hisilicon.com>
References: <20200821113355.6140-1-song.bao.hua@hisilicon.com>
 <e47f4bfd-3af7-f682-23a1-51800f992d35@oracle.com>
In-Reply-To: <e47f4bfd-3af7-f682-23a1-51800f992d35@oracle.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWlrZSBLcmF2ZXR6IFtt
YWlsdG86bWlrZS5rcmF2ZXR6QG9yYWNsZS5jb21dDQo+IFNlbnQ6IFNhdHVyZGF5LCBBdWd1c3Qg
MjIsIDIwMjAgNTo1MyBBTQ0KPiBUbzogU29uZyBCYW8gSHVhIChCYXJyeSBTb25nKSA8c29uZy5i
YW8uaHVhQGhpc2lsaWNvbi5jb20+OyBoY2hAbHN0LmRlOw0KPiBtLnN6eXByb3dza2lAc2Ftc3Vu
Zy5jb207IHJvYmluLm11cnBoeUBhcm0uY29tOyB3aWxsQGtlcm5lbC5vcmc7DQo+IGdhbmFwYXRy
YW8ua3Vsa2FybmlAY2F2aXVtLmNvbTsgY2F0YWxpbi5tYXJpbmFzQGFybS5jb207DQo+IGFrcG1A
bGludXgtZm91bmRhdGlvbi5vcmcNCj4gQ2M6IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IFplbmd0YW8gKEIpIDxwcmltZS56ZW5nQGhpc2lsaWNvbi5jb20+
Ow0KPiBodWFuZ2Rhb2RlIDxodWFuZ2Rhb2RlQGh1YXdlaS5jb20+OyBMaW51eGFybSA8bGludXhh
cm1AaHVhd2VpLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyAwLzNdIG1ha2UgZG1hX2Fs
bG9jX2NvaGVyZW50IE5VTUEtYXdhcmUgYnkNCj4gcGVyLU5VTUEgQ01BDQo+IA0KPiBIaSBCYXJy
eSwNCj4gU29ycnkgZm9yIGp1bXBpbmcgaW4gc28gbGF0ZS4NCj4gDQo+IE9uIDgvMjEvMjAgNDoz
MyBBTSwgQmFycnkgU29uZyB3cm90ZToNCj4gPg0KPiA+IHdpdGggcGVyLW51bWEgQ01BLCBzbW11
IHdpbGwgZ2V0IG1lbW9yeSBmcm9tIGxvY2FsIG51bWEgbm9kZSB0byBzYXZlDQo+IGNvbW1hbmQN
Cj4gPiBxdWV1ZXMgYW5kIHBhZ2UgdGFibGVzLiB0aGF0IG1lYW5zIGRtYV91bm1hcCBsYXRlbmN5
IHdpbGwgYmUgc2hydW5rDQo+IG11Y2guDQo+IA0KPiBTaW5jZSBwZXItbm9kZSBDTUEgYXJlYXMg
Zm9yIGh1Z2V0bGIgd2FzIGludHJvZHVjZWQsIEkgaGF2ZSBiZWVuIHRoaW5raW5nDQo+IGFib3V0
IHRoZSBsaW1pdGVkIG51bWJlciBvZiBDTUEgYXJlYXMuICBJbiBtb3N0IGNvbmZpZ3VyYXRpb25z
LCBJIGJlbGlldmUNCj4gaXQgaXMgbGltaXRlZCB0byA3LiAgQW5kLCBJSVJDIGl0IGlzIG5vdCBz
b21ldGhpbmcgdGhhdCBjYW4gYmUgY2hhbmdlZCBhdA0KPiBydW50aW1lLCB5b3UgbmVlZCB0byBy
ZWNvbmZpZyBhbmQgcmVidWlsZCB0byBpbmNyZWFzZSB0aGUgbnVtYmVyLiAgSW4gY29udHJhc3QN
Cj4gc29tZSBjb25maWdzIGhhdmUgTk9ERVNfU0hJRlQgc2V0IHRvIDEwLiAgSSB3YXNuJ3QgdG9v
IHdvcnJpZWQgYmVjYXVzZSBvZg0KPiB0aGUgbGltaXRlZCBodWdldGxiIHVzZSBjYXNlLiAgSG93
ZXZlciwgdGhpcyBzZXJpZXMgaXMgYWRkaW5nIGFub3RoZXIgdXNlcg0KPiBvZiBwZXItbm9kZSBD
TUEgYXJlYXMuDQo+IA0KPiBXaXRoIG1vcmUgdXNlcnMsIHNob3VsZCB0cnkgdG8gc3luYyB1cCBu
dW1iZXIgb2YgQ01BIGFyZWFzIGFuZCBudW1iZXIgb2YNCj4gbm9kZXM/ICBPciwgcGVyaGFwcyBJ
IGFtIHdvcnJ5aW5nIGFib3V0IG5vdGhpbmc/DQoNCkhpIE1pa2UsDQpUaGUgY3VycmVudCBsaW1p
dGF0aW9uIGlzIDguIElmIHRoZSBzZXJ2ZXIgaGFzIDQgbm9kZXMgYW5kIHdlIGVuYWJsZSBib3Ro
IHBlcm51bWENCkNNQSBhbmQgaHVnZXRsYiwgdGhlIGxhc3Qgbm9kZSB3aWxsIGZhaWwgdG8gZ2V0
IG9uZSBjbWEgYXJlYSBhcyB0aGUgZGVmYXVsdA0KZ2xvYmFsIGNtYSBhcmVhIHdpbGwgdGFrZSAx
IG9mIDguIFNvIHVzZXJzIG5lZWQgdG8gY2hhbmdlIG1lbnVjb25maWcuDQpJZiB0aGUgc2VydmVy
IGhhcyA4IG5vZGVzLCB3ZSBlbmFibGUgb25lIG9mIHBlcm51bWEgY21hIGFuZCBodWdldGxiLCBv
bmUgbm9kZQ0Kd2lsbCBmYWlsIHRvIGdldCBjbWEuDQoNCldlIG1heSBzZXQgdGhlIGRlZmF1bHQg
bnVtYmVyIG9mIENNQSBhcmVhcyBhcyA4K01BWF9OT0RFUyhpZiBodWdldGxiIGVuYWJsZWQpICsN
Ck1BWF9OT0RFUyhpZiBwZXJudW1hIGNtYSBlbmFibGVkKSBpZiB3ZSBkb24ndCBleHBlY3QgdXNl
cnMgdG8gY2hhbmdlIGNvbmZpZywgYnV0DQpyaWdodCBub3cgaHVnZXRsYiBoYXMgbm90IGFuIG9w
dGlvbiBpbiBLY29uZmlnIHRvIGVuYWJsZSBvciBkaXNhYmxlIGxpa2UgcGVybnVtYSBjbWENCmhh
cyBETUFfUEVSTlVNQV9DTUEuDQoNCj4gLS0NCj4gTWlrZSBLcmF2ZXR6DQoNClRoYW5rcw0KQmFy
cnkNCg==
