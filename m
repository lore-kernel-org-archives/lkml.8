Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E46CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 043B520708
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbgFVLYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 07:24:30 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2527 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730006AbgFVLYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 07:24:19 -0400
Received: from dggemi402-hub.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id C40D5764D42DFF3ABD0C;
        Mon, 22 Jun 2020 19:24:17 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.126]) by
 dggemi402-hub.china.huawei.com ([10.3.17.135]) with mapi id 14.03.0487.000;
 Mon, 22 Jun 2020 19:24:09 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     John Garry <john.garry@huawei.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v3] driver core: platform: expose numa_node to users in
 sysfs
Thread-Topic: [PATCH v3] driver core: platform: expose numa_node to users in
 sysfs
Thread-Index: AQHWReYTVpuuKIUXc0+/IcmdTQnez6jj830AgACHrdA=
Date:   Mon, 22 Jun 2020 11:24:09 +0000
Message-ID: <B926444035E5E2439431908E3842AFD251405E@DGGEMI525-MBS.china.huawei.com>
References: <20200619030045.81956-1-song.bao.hua@hisilicon.com>
 <dc66d5a7-fa26-4c56-7445-57f99d3a5018@huawei.com>
In-Reply-To: <dc66d5a7-fa26-4c56-7445-57f99d3a5018@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.232]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2huIEdhcnJ5DQo+IFNlbnQ6
IE1vbmRheSwgSnVuZSAyMiwgMjAyMCAxMDo0OSBQTQ0KPiBUbzogU29uZyBCYW8gSHVhIChCYXJy
eSBTb25nKSA8c29uZy5iYW8uaHVhQGhpc2lsaWNvbi5jb20+Ow0KPiBncmVna2hAbGludXhmb3Vu
ZGF0aW9uLm9yZzsgcmFmYWVsQGtlcm5lbC5vcmcNCj4gQ2M6IFJvYmluIE11cnBoeSA8cm9iaW4u
bXVycGh5QGFybS5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBaZW5ndGFv
IChCKSA8cHJpbWUuemVuZ0BoaXNpbGljb24uY29tPjsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdl
aS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjNdIGRyaXZlciBjb3JlOiBwbGF0Zm9ybTog
ZXhwb3NlIG51bWFfbm9kZSB0byB1c2VycyBpbg0KPiBzeXNmcw0KPiANCj4gT24gMTkvMDYvMjAy
MCAwNDowMCwgQmFycnkgU29uZyB3cm90ZToNCj4gPiBTb21lIHBsYXRmb3JtIGRldmljZXMgbGlr
ZSBBUk0gU01NVSBhcmUgbWVtb3J5LW1hcHBlZCBhbmQgcG9wdWxhdGVkDQo+IGJ5IEFDUEkvSU9S
VC4NCj4gPiBJbiB0aGlzIGNhc2UsIE5VTUEgdG9wb2xvZ3kgb2YgdGhvc2UgcGxhdGZvcm0gZGV2
aWNlcyBhcmUgZXhwb3J0ZWQgYnkNCj4gZmlybXdhcmUgYXMNCj4gPiB3ZWxsLiBTb2Z0d2FyZSBt
aWdodCBjYXJlIGFib3V0IHRoZSBudW1hX25vZGUgb2YgdGhvc2UgZGV2aWNlcyBpbiBvcmRlciB0
bw0KPiBhY2hpZXZlDQo+ID4gTlVNQSBsb2NhbGl0eS4NCj4gDQoNClRoYW5rcyBmb3IgeW91ciBy
ZXZpZXcsIEpvaG4uDQoNCj4gSXMgaXQgZ2VuZXJhbGx5IHRoZSBjYXNlIHRoYXQgdGhlIFNNTVUg
d2lsbCBiZSBpbiB0aGUgc2FtZSBOVU1BIG5vZGUgYXMNCj4gdGhlIGVuZHBvaW50IGRldmljZSAo
d2hpY2ggeW91J3JlIGRyaXZpbmcpPyBJZiBzbywgd2UgY2FuIGdldCB0aGlzIGluZm8NCg0KDQpU
aGlzIGNvdWxkIGJlIHRydWUsIGJ1dCBJIGFtIG5vdCBzdXJlIGlmIGl0IGhhcyB0byBiZSB0cnVl
IDotKQ0KDQpPbiB0aGUgb3RoZXIgaGFuZCwgZHJpdmVycy9hY3BpL2FybTY0L2lvcnQuYyBoYXMg
c29tZSBjb2RlIHRvIHNldCBudW1hIG5vZGUgZm9yIHNtbXUuDQpJdCBkb2Vzbid0IGFzc3VtZSB0
aGUgbnVtYV9ub2RlIGlzIGRpcmVjdGx5IHNhbWUgd2l0aCB0aGUgcGNpIGRldmljZXMuDQoNCnN0
YXRpYyBpbnQgIF9faW5pdCBhcm1fc21tdV92M19zZXRfcHJveGltaXR5KHN0cnVjdCBkZXZpY2Ug
KmRldiwNCgkJCQkJICAgICAgc3RydWN0IGFjcGlfaW9ydF9ub2RlICpub2RlKQ0Kew0KCXN0cnVj
dCBhY3BpX2lvcnRfc21tdV92MyAqc21tdTsNCg0KCXNtbXUgPSAoc3RydWN0IGFjcGlfaW9ydF9z
bW11X3YzICopbm9kZS0+bm9kZV9kYXRhOw0KCWlmIChzbW11LT5mbGFncyAmIEFDUElfSU9SVF9T
TU1VX1YzX1BYTV9WQUxJRCkgew0KCQlpbnQgZGV2X25vZGUgPSBhY3BpX21hcF9weG1fdG9fbm9k
ZShzbW11LT5weG0pOw0KDQoJCWlmIChkZXZfbm9kZSAhPSBOVU1BX05PX05PREUgJiYgIW5vZGVf
b25saW5lKGRldl9ub2RlKSkNCgkJCXJldHVybiAtRUlOVkFMOw0KDQoJCXNldF9kZXZfbm9kZShk
ZXYsIGRldl9ub2RlKTsNCgkJcHJfaW5mbygiU01NVS12M1slbGx4XSBNYXBwZWQgdG8gUHJveGlt
aXR5IGRvbWFpbiAlZFxuIiwNCgkJCXNtbXUtPmJhc2VfYWRkcmVzcywNCgkJCXNtbXUtPnB4bSk7
DQoJfQ0KCXJldHVybiAwOw0KfQ0KDQpudW1hX25vZGUgbWF5IGFsc28gZXh0ZW5kIHRvIG90aGVy
IHBsYXRmb3JtIGRldmljZXMgb25jZSB3ZSBwcm92aWRlIGEgY29tbW9uIGRldl9zZXRfcHJveGlt
aXR5KCkgY2FsbGJhY2sgdG8gdGhlbS4NCmlvcnRfYWRkX3BsYXRmb3JtX2RldmljZSgpIHdpbGwg
c2V0IG5vZGUgZm9yIHRoZW06DQoNCnN0YXRpYyBpbnQgX19pbml0IGlvcnRfYWRkX3BsYXRmb3Jt
X2RldmljZShzdHJ1Y3QgYWNwaV9pb3J0X25vZGUgKm5vZGUsDQoJCQkJCSAgIGNvbnN0IHN0cnVj
dCBpb3J0X2Rldl9jb25maWcgKm9wcykNCnsNCglzdHJ1Y3QgZndub2RlX2hhbmRsZSAqZndub2Rl
Ow0KCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXY7DQoJc3RydWN0IHJlc291cmNlICpyOw0K
CWludCByZXQsIGNvdW50Ow0KDQoJcGRldiA9IHBsYXRmb3JtX2RldmljZV9hbGxvYyhvcHMtPm5h
bWUsIFBMQVRGT1JNX0RFVklEX0FVVE8pOw0KCWlmICghcGRldikNCgkJcmV0dXJuIC1FTk9NRU07
DQoNCglpZiAob3BzLT5kZXZfc2V0X3Byb3hpbWl0eSkgew0KCQlyZXQgPSBvcHMtPmRldl9zZXRf
cHJveGltaXR5KCZwZGV2LT5kZXYsIG5vZGUpOw0KCQlpZiAocmV0KQ0KCQkJZ290byBkZXZfcHV0
Ow0KCX0NCgkuLi4NCn0NCg0KSXQgaXMgcHJvYmFibHkgd29ydGggdG8gbWFrZSBkZXZfc2V0X3By
b3hpbWl0eSgpIGNvbW1vbiBmb3IgYWxsIGlvcnQgZGV2aWNlcy4NCg0KPiBmcm9tIHN5c2ZzIGFs
cmVhZHkgZm9yIHRoZSBlbmRwb2ludCwgYW5kIGFsc28gaGF2ZSBhIGxpbmsgZnJvbSB0aGUNCj4g
ZW5kcG9pbnQgdG8gdGhlIGlvbW11IGZvciBwY2kgZGV2aWNlcyAod2hpY2ggSSBhc3N1bWUgeW91
J3JlIGludGVyZXN0ZWQgaW4pOg0KPiANCg0KPiByb290QChub25lKSQgbHMgLWwgL3N5cy9kZXZp
Y2VzL3BjaTAwMDA6NzQvMDAwMDo3NDowMi4wLyB8IGdyZXAgaW9tbXUNCj4gbHJ3eHJ3eHJ3eCAx
IHJvb3QgIHJvb3QgMCBKdW4gMjIgMTA6MzMgaW9tbXUgLT4NCj4gLi4vLi4vcGxhdGZvcm0vYXJt
LXNtbXUtdjMuMi5hdXRvL2lvbW11L3NtbXUzLjB4MDAwMDAwMDE0MDAwMDAwMA0KPiBscnd4cnd4
cnd4IDEgcm9vdCAgcm9vdCAwIEp1biAyMiAxMDozMyBpb21tdV9ncm91cCAtPg0KPiAuLi8uLi8u
Li9rZXJuZWwvaW9tbXVfZ3JvdXBzLzANCj4gcm9vdEAobm9uZSkkDQoNClN1cmUgdGhlcmUgaXMg
YW4gaW1wbGljaXQgd2F5IHRvIGZpZ3VyZSBvdXQgdGhlIG51bWEgbm9kZSBvZiBzbW11IGJ5IHZh
cmlvdXMgbGlua3MgYmV0d2VlbiBzbW11DQphbmQgZGV2aWNlcyB3aGljaCB1c2UgdGhlIHNtbXUg
aWYgc21tdSBhbmQgZGV2aWNlcyBhcmUgbHVja2lseSBwdXQgaW4gb25lIHNhbWUgbnVtYSBub2Rl
Lg0KDQpIb3dldmVyLCBpdCBpcyBzdGlsbCBtdWNoIG1vcmUgY2xlYXIgYW5kIGNyZWRpYmxlIHRv
IHVzZXJzIGJ5IGV4cG9zaW5nIHRoZSBkYXRhIGRpcmVjdGx5IGZyb20gQUNQSSB0YWJsZS4gDQoN
Cj4gDQo+IFRoYW5rcywNCj4gSm9obg0KDQpCYXJyeQ0KDQo=
