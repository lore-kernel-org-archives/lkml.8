Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5DBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 03:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13A8920709
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 03:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgFZDoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 23:44:15 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2530 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728424AbgFZDoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 23:44:15 -0400
Received: from dggemi403-hub.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 06A23F95B094670A2D2B;
        Fri, 26 Jun 2020 11:44:13 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.126]) by
 dggemi403-hub.china.huawei.com ([10.3.17.136]) with mapi id 14.03.0487.000;
 Fri, 26 Jun 2020 11:44:06 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Robin Murphy <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "will@kernel.org" <will@kernel.org>,
        "ganapatrao.kulkarni@cavium.com" <ganapatrao.kulkarni@cavium.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Steve Capper <steve.capper@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: RE: [PATCH v2 2/2] arm64: mm: reserve per-numa CMA after numa_init
Thread-Topic: [PATCH v2 2/2] arm64: mm: reserve per-numa CMA after numa_init
Thread-Index: AQHWSsSbzGzpbLEug0S/DFMz+d2fJKjoqFEAgAGYvPA=
Date:   Fri, 26 Jun 2020 03:44:04 +0000
Message-ID: <B926444035E5E2439431908E3842AFD2524297@DGGEMI525-MBS.china.huawei.com>
References: <20200625074330.13668-1-song.bao.hua@hisilicon.com>
 <20200625074330.13668-3-song.bao.hua@hisilicon.com>
 <53b97598-6c83-1cb2-5763-4ded441403c5@arm.com>
In-Reply-To: <53b97598-6c83-1cb2-5763-4ded441403c5@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.18]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4gTXVycGh5IFtt
YWlsdG86cm9iaW4ubXVycGh5QGFybS5jb21dDQo+IFNlbnQ6IFRodXJzZGF5LCBKdW5lIDI1LCAy
MDIwIDExOjE2IFBNDQo+IFRvOiBTb25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcpIDxzb25nLmJhby5o
dWFAaGlzaWxpY29uLmNvbT47IGhjaEBsc3QuZGU7DQo+IG0uc3p5cHJvd3NraUBzYW1zdW5nLmNv
bTsgd2lsbEBrZXJuZWwub3JnOw0KPiBnYW5hcGF0cmFvLmt1bGthcm5pQGNhdml1bS5jb207IGNh
dGFsaW4ubWFyaW5hc0Bhcm0uY29tDQo+IENjOiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZzsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+Ow0KPiBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IE5pY29s
YXMNCj4gU2FlbnogSnVsaWVubmUgPG5zYWVuemp1bGllbm5lQHN1c2UuZGU+OyBTdGV2ZSBDYXBw
ZXINCj4gPHN0ZXZlLmNhcHBlckBhcm0uY29tPjsgQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1m
b3VuZGF0aW9uLm9yZz47DQo+IE1pa2UgUmFwb3BvcnQgPHJwcHRAbGludXguaWJtLmNvbT4NCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MiAyLzJdIGFybTY0OiBtbTogcmVzZXJ2ZSBwZXItbnVtYSBD
TUEgYWZ0ZXINCj4gbnVtYV9pbml0DQo+IA0KPiBPbiAyMDIwLTA2LTI1IDA4OjQzLCBCYXJyeSBT
b25nIHdyb3RlOg0KPiA+IFJpZ2h0IG5vdywgc21tdSBpcyB1c2luZyBkbWFfYWxsb2NfY29oZXJl
bnQoKSB0byBnZXQgbWVtb3J5IHRvIHNhdmUNCj4gcXVldWVzDQo+ID4gYW5kIHRhYmxlcy4gVHlw
aWNhbGx5LCBvbiBBUk02NCBzZXJ2ZXIsIHRoZXJlIGlzIGEgZGVmYXVsdCBDTUEgbG9jYXRlZCBh
dA0KPiA+IG5vZGUwLCB3aGljaCBjb3VsZCBiZSBmYXIgYXdheSBmcm9tIG5vZGUyLCBub2RlMyBl
dGMuDQo+ID4gd2l0aCB0aGlzIHBhdGNoLCBzbW11IHdpbGwgZ2V0IG1lbW9yeSBmcm9tIGxvY2Fs
IG51bWEgbm9kZSB0byBzYXZlDQo+IGNvbW1hbmQNCj4gPiBxdWV1ZXMgYW5kIHBhZ2UgdGFibGVz
LiB0aGF0IG1lYW5zIGRtYV91bm1hcCBsYXRlbmN5IHdpbGwgYmUgc2hydW5rDQo+IG11Y2guDQo+
ID4gTWVhbndoaWxlLCB3aGVuIGlvbW11LnBhc3N0aHJvdWdoIGlzIG9uLCBkZXZpY2UgZHJpdmVy
cyB3aGljaCBjYWxsIGRtYV8NCj4gPiBhbGxvY19jb2hlcmVudCgpIHdpbGwgYWxzbyBnZXQgbG9j
YWwgbWVtb3J5IGFuZCBhdm9pZCB0aGUgdHJhdmVsIGJldHdlZW4NCj4gPiBudW1hIG5vZGVzLg0K
PiA+DQo+ID4gQ2M6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiA+IENjOiBNYXJl
ayBTenlwcm93c2tpIDxtLnN6eXByb3dza2lAc2Ftc3VuZy5jb20+DQo+ID4gQ2M6IFdpbGwgRGVh
Y29uIDx3aWxsQGtlcm5lbC5vcmc+DQo+ID4gQ2M6IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5
QGFybS5jb20+DQo+ID4gQ2M6IEdhbmFwYXRyYW8gS3Vsa2FybmkgPGdhbmFwYXRyYW8ua3Vsa2Fy
bmlAY2F2aXVtLmNvbT4NCj4gPiBDYzogQ2F0YWxpbiBNYXJpbmFzIDxjYXRhbGluLm1hcmluYXNA
YXJtLmNvbT4NCj4gPiBDYzogTmljb2xhcyBTYWVueiBKdWxpZW5uZSA8bnNhZW56anVsaWVubmVA
c3VzZS5kZT4NCj4gPiBDYzogU3RldmUgQ2FwcGVyIDxzdGV2ZS5jYXBwZXJAYXJtLmNvbT4NCj4g
PiBDYzogQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4NCj4gPiBDYzog
TWlrZSBSYXBvcG9ydCA8cnBwdEBsaW51eC5pYm0uY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJh
cnJ5IFNvbmcgPHNvbmcuYmFvLmh1YUBoaXNpbGljb24uY29tPg0KPiA+IC0tLQ0KPiA+ICAgYXJj
aC9hcm02NC9tbS9pbml0LmMgfCAyICsrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9tbS9pbml0LmMgYi9hcmNo
L2FybTY0L21tL2luaXQuYw0KPiA+IGluZGV4IDFlOTNjZmM3YzQ3YS4uMDdkNGQxZmU3OTgzIDEw
MDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvbW0vaW5pdC5jDQo+ID4gKysrIGIvYXJjaC9hcm02
NC9tbS9pbml0LmMNCj4gPiBAQCAtNDIwLDYgKzQyMCw4IEBAIHZvaWQgX19pbml0IGJvb3RtZW1f
aW5pdCh2b2lkKQ0KPiA+DQo+ID4gICAJYXJtNjRfbnVtYV9pbml0KCk7DQo+ID4NCj4gPiArCWRt
YV9wZXJudW1hX2NtYV9yZXNlcnZlKCk7DQo+ID4gKw0KPiANCj4gSXQgbWlnaHQgYmUgd29ydGgg
cHV0dGluZyB0aGlzIGFmdGVyIHRoZSBodWdldGxiX2NtYV9yZXNlcnZlKCkgY2FsbCBmb3INCj4g
Y2xhcml0eSwgc2luY2UgdGhlIGNvbW1lbnQgYmVsb3cgYXBwbGllcyBlcXVhbGx5IHRvIHRoaXMg
Y2FsbCB0b28uDQoNClllcCwgaXQgbG9va3MgZXZlbiBiZXR0ZXIgdGhvdWdoIGRtYV9wZXJudW1h
X2NtYV9yZXNlcnZlKCkgaXMgc2VsZi1kb2N1bWVudGluZyBieSBuYW1lLg0KDQo+IA0KPiBSb2Jp
bi4NCj4gDQo+ID4gICAJLyoNCj4gPiAgIAkgKiBtdXN0IGJlIGRvbmUgYWZ0ZXIgYXJtNjRfbnVt
YV9pbml0KCkgd2hpY2ggY2FsbHMgbnVtYV9pbml0KCkgdG8NCj4gPiAgIAkgKiBpbml0aWFsaXpl
IG5vZGVfb25saW5lX21hcCB0aGF0IGdldHMgdXNlZCBpbiBodWdldGxiX2NtYV9yZXNlcnZlKCkN
Cj4gPg0KVGhhbmtzDQpCYXJyeQ0KDQo=
