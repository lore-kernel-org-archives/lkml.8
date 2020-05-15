Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538DAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 07:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10FFD206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 07:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pTa7/TQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgEOHqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 03:46:46 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:50105 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726622AbgEOHqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 03:46:45 -0400
X-UUID: 31affafba9744c9bb4271d5cfe7b7585-20200515
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=2U0lk+3AOLEFSBOQ1vgqYzwMDxMh7x/MPGzDHrIVnCI=;
        b=pTa7/TQKo3fNfcgb64IZqrz3/hQVIAkKaZMUKjyUczzczsLzL+Q+sp3s3dc81LW4uvZCHbMU3QuWPXeI4dJADjaxYtu3Ott/a1PCCcT6dX3MVyVjROuZIy/9ACmbxUJK2HvAawLXKfVBV6KCLb4WkfJzB+P8GmxRJUHhKzWQEOI=;
X-UUID: 31affafba9744c9bb4271d5cfe7b7585-20200515
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1939548208; Fri, 15 May 2020 15:46:36 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 15 May
 2020 15:46:20 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 15 May 2020 15:46:18 +0800
Message-ID: <1589528699.26119.9.camel@mhfsdcap03>
Subject: Re: [PATCH v2 23/33] iommu/mediatek-v1 Convert to
 probe/release_device() call-backs
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 15 May 2020 15:44:59 +0800
In-Reply-To: <20200414131542.25608-24-joro@8bytes.org>
References: <20200414131542.25608-1-joro@8bytes.org>
         <20200414131542.25608-24-joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: DC9F0778244307DCB8C3501248E21D926B064F0B379D3F613D6C01BFC66E127F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTA0LTE0IGF0IDE1OjE1ICswMjAwLCBKb2VyZyBSb2VkZWwgd3JvdGU6DQo+
IEZyb206IEpvZXJnIFJvZWRlbCA8anJvZWRlbEBzdXNlLmRlPg0KPiANCj4gQ29udmVydCB0aGUg
TWVkaWF0ZWstdjEgSU9NTVUgZHJpdmVyIHRvIHVzZSB0aGUgcHJvYmVfZGV2aWNlKCkgYW5kDQo+
IHJlbGVhc2VfZGV2aWNlKCkgY2FsbC1iYWNrcyBvZiBpb21tdV9vcHMsIHNvIHRoYXQgdGhlIGlv
bW11IGNvcmUgY29kZQ0KPiBkb2VzIHRoZSBncm91cCBhbmQgc3lzZnMgc2V0dXAuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBKb2VyZyBSb2VkZWwgPGpyb2VkZWxAc3VzZS5kZT4NCj4gLS0tDQo+ICBk
cml2ZXJzL2lvbW11L210a19pb21tdV92MS5jIHwgNTAgKysrKysrKysrKysrKysrLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgMzAgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXVfdjEu
YyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11X3YxLmMNCj4gaW5kZXggYTMxYmUwNTYwMWM5Li43
YmRkNzRjN2NiOWYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11X3YxLmMN
Cj4gKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXVfdjEuYw0KPiBAQCAtNDE2LDE0ICs0MTYs
MTIgQEAgc3RhdGljIGludCBtdGtfaW9tbXVfY3JlYXRlX21hcHBpbmcoc3RydWN0IGRldmljZSAq
ZGV2LA0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgaW50IG10a19pb21tdV9h
ZGRfZGV2aWNlKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gK3N0YXRpYyBzdHJ1Y3QgaW9tbXVfZGV2
aWNlICptdGtfaW9tbXVfcHJvYmVfZGV2aWNlKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIHsNCj4g
IAlzdHJ1Y3QgaW9tbXVfZndzcGVjICpmd3NwZWMgPSBkZXZfaW9tbXVfZndzcGVjX2dldChkZXYp
Ow0KPiAtCXN0cnVjdCBkbWFfaW9tbXVfbWFwcGluZyAqbXRrX21hcHBpbmc7DQo+ICAJc3RydWN0
IG9mX3BoYW5kbGVfYXJncyBpb21tdV9zcGVjOw0KPiAgCXN0cnVjdCBvZl9waGFuZGxlX2l0ZXJh
dG9yIGl0Ow0KPiAgCXN0cnVjdCBtdGtfaW9tbXVfZGF0YSAqZGF0YTsNCj4gLQlzdHJ1Y3QgaW9t
bXVfZ3JvdXAgKmdyb3VwOw0KPiAgCWludCBlcnI7DQo+ICANCj4gIAlvZl9mb3JfZWFjaF9waGFu
ZGxlKCZpdCwgZXJyLCBkZXYtPm9mX25vZGUsICJpb21tdXMiLA0KPiBAQCAtNDQyLDM1ICs0NDAs
MjggQEAgc3RhdGljIGludCBtdGtfaW9tbXVfYWRkX2RldmljZShzdHJ1Y3QgZGV2aWNlICpkZXYp
DQo+ICAJfQ0KPiAgDQo+ICAJaWYgKCFmd3NwZWMgfHwgZndzcGVjLT5vcHMgIT0gJm10a19pb21t
dV9vcHMpDQo+IC0JCXJldHVybiAtRU5PREVWOyAvKiBOb3QgYSBpb21tdSBjbGllbnQgZGV2aWNl
ICovDQo+ICsJCXJldHVybiBFUlJfUFRSKC1FTk9ERVYpOyAvKiBOb3QgYSBpb21tdSBjbGllbnQg
ZGV2aWNlICovDQo+ICANCj4gLQkvKg0KPiAtCSAqIFRoaXMgaXMgYSBzaG9ydC10ZXJtIGJvZGdl
IGJlY2F1c2UgdGhlIEFSTSBETUEgY29kZSBkb2Vzbid0DQo+IC0JICogdW5kZXJzdGFuZCBtdWx0
aS1kZXZpY2UgZ3JvdXBzLCBidXQgd2UgaGF2ZSB0byBjYWxsIGludG8gaXQNCj4gLQkgKiBzdWNj
ZXNzZnVsbHkgKGFuZCBub3QganVzdCByZWx5IG9uIGEgbm9ybWFsIElPTU1VIEFQSSBhdHRhY2gN
Cj4gLQkgKiBoZXJlKSBpbiBvcmRlciB0byBzZXQgdGhlIGNvcnJlY3QgRE1BIEFQSSBvcHMgb24g
QGRldi4NCj4gLQkgKi8NCj4gLQlncm91cCA9IGlvbW11X2dyb3VwX2FsbG9jKCk7DQo+IC0JaWYg
KElTX0VSUihncm91cCkpDQo+IC0JCXJldHVybiBQVFJfRVJSKGdyb3VwKTsNCj4gKwlkYXRhID0g
ZGV2X2lvbW11X3ByaXZfZ2V0KGRldik7DQo+ICANCj4gLQllcnIgPSBpb21tdV9ncm91cF9hZGRf
ZGV2aWNlKGdyb3VwLCBkZXYpOw0KPiAtCWlvbW11X2dyb3VwX3B1dChncm91cCk7DQo+IC0JaWYg
KGVycikNCj4gLQkJcmV0dXJuIGVycjsNCj4gKwlyZXR1cm4gJmRhdGEtPmlvbW11Ow0KPiArfQ0K
PiAgDQo+IC0JZGF0YSA9IGRldl9pb21tdV9wcml2X2dldChkZXYpOw0KPiArc3RhdGljIHZvaWQg
bXRrX2lvbW11X3Byb2JlX2ZpbmFsaXplKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gK3sNCj4gKwlz
dHJ1Y3QgZG1hX2lvbW11X21hcHBpbmcgKm10a19tYXBwaW5nOw0KPiArCXN0cnVjdCBtdGtfaW9t
bXVfZGF0YSAqZGF0YTsNCj4gKwlpbnQgZXJyOw0KPiArDQo+ICsJZGF0YSAgICAgICAgPSBkZXZf
aW9tbXVfcHJpdl9nZXQoZGV2KTsNCj4gIAltdGtfbWFwcGluZyA9IGRhdGEtPmRldi0+YXJjaGRh
dGEuaW9tbXU7DQo+IC0JZXJyID0gYXJtX2lvbW11X2F0dGFjaF9kZXZpY2UoZGV2LCBtdGtfbWFw
cGluZyk7DQo+IC0JaWYgKGVycikgew0KPiAtCQlpb21tdV9ncm91cF9yZW1vdmVfZGV2aWNlKGRl
dik7DQo+IC0JCXJldHVybiBlcnI7DQo+IC0JfQ0KPiAgDQo+IC0JcmV0dXJuIGlvbW11X2Rldmlj
ZV9saW5rKCZkYXRhLT5pb21tdSwgZGV2KTsNCj4gKwllcnIgPSBhcm1faW9tbXVfYXR0YWNoX2Rl
dmljZShkZXYsIG10a19tYXBwaW5nKTsNCj4gKwlpZiAoZXJyKQ0KPiArCQlkZXZfZXJyKGRldiwg
IkNhbid0IGNyZWF0ZSBJT01NVSBtYXBwaW5nIC0gRE1BLU9QUyB3aWxsIG5vdCB3b3JrXG4iKTsN
Cg0KDQpIaSBKb2VyZywNCg0KICAgICBUaGFua3MgdmVyeSBtdWNoIGZvciB0aGlzIHBhdGNoLg0K
DQogICAgIFRoaXMgYXJtX2lvbW11X2F0dGFjaF9kZXZpY2UgaXMgY2FsbGVkIGp1c3QgYXMgd2Ug
ZXhwZWN0ZWQuDQoNCiAgICAgQnV0IGl0IHdpbGwgZmFpbCBpbiB0aGlzIGNhbGxzdGFjayBhcyB0
aGUgZ3JvdXAtPm11dGV4IHdhcyB0cmllZCB0bw0KYmUgcmUtbG9ja2VkLi4uDQoNCls8YzA5Mzhl
OGM+XSAoaW9tbXVfYXR0YWNoX2RldmljZSkgZnJvbSBbPGMwMzE3NTkwPl0NCihfX2FybV9pb21t
dV9hdHRhY2hfZGV2aWNlKzB4MzQvMHg5MCkNCls8YzAzMTc1OTA+XSAoX19hcm1faW9tbXVfYXR0
YWNoX2RldmljZSkgZnJvbSBbPGMwMzE3NWY4Pl0NCihhcm1faW9tbXVfYXR0YWNoX2RldmljZSsw
eGMvMHgyMCkNCls8YzAzMTc1Zjg+XSAoYXJtX2lvbW11X2F0dGFjaF9kZXZpY2UpIGZyb20gWzxj
MDk0MzJjYz5dDQoobXRrX2lvbW11X3Byb2JlX2ZpbmFsaXplKzB4MzQvMHg1MCkNCls8YzA5NDMy
Y2M+XSAobXRrX2lvbW11X3Byb2JlX2ZpbmFsaXplKSBmcm9tIFs8YzA5M2E4YWM+XQ0KKGJ1c19p
b21tdV9wcm9iZSsweDJhOC8weDJjNCkNCls8YzA5M2E4YWM+XSAoYnVzX2lvbW11X3Byb2JlKSBm
cm9tIFs8YzA5M2E5NTA+XSAoYnVzX3NldF9pb21tdQ0KKzB4ODgvMHhkNCkNCls8YzA5M2E5NTA+
XSAoYnVzX3NldF9pb21tdSkgZnJvbSBbPGMwOTQzYzc0Pl0gKG10a19pb21tdV9wcm9iZQ0KKzB4
MmY4LzB4MzY0KQ0KDQoNCj4gIH0NCj4gIA0KPiAtc3RhdGljIHZvaWQgbXRrX2lvbW11X3JlbW92
ZV9kZXZpY2Uoc3RydWN0IGRldmljZSAqZGV2KQ0KPiArc3RhdGljIHZvaWQgbXRrX2lvbW11X3Jl
bGVhc2VfZGV2aWNlKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIHsNCj4gIAlzdHJ1Y3QgaW9tbXVf
ZndzcGVjICpmd3NwZWMgPSBkZXZfaW9tbXVfZndzcGVjX2dldChkZXYpOw0KPiAgCXN0cnVjdCBt
dGtfaW9tbXVfZGF0YSAqZGF0YTsNCj4gQEAgLTQ3OSw5ICs0NzAsNiBAQCBzdGF0aWMgdm9pZCBt
dGtfaW9tbXVfcmVtb3ZlX2RldmljZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICAJCXJldHVybjsN
Cj4gIA0KPiAgCWRhdGEgPSBkZXZfaW9tbXVfcHJpdl9nZXQoZGV2KTsNCj4gLQlpb21tdV9kZXZp
Y2VfdW5saW5rKCZkYXRhLT5pb21tdSwgZGV2KTsNCj4gLQ0KPiAtCWlvbW11X2dyb3VwX3JlbW92
ZV9kZXZpY2UoZGV2KTsNCj4gIAlpb21tdV9md3NwZWNfZnJlZShkZXYpOw0KPiAgfQ0KPiAgDQo+
IEBAIC01MzQsOCArNTIyLDEwIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaW9tbXVfb3BzIG10a19p
b21tdV9vcHMgPSB7DQo+ICAJLm1hcAkJPSBtdGtfaW9tbXVfbWFwLA0KPiAgCS51bm1hcAkJPSBt
dGtfaW9tbXVfdW5tYXAsDQo+ICAJLmlvdmFfdG9fcGh5cwk9IG10a19pb21tdV9pb3ZhX3RvX3Bo
eXMsDQo+IC0JLmFkZF9kZXZpY2UJPSBtdGtfaW9tbXVfYWRkX2RldmljZSwNCj4gLQkucmVtb3Zl
X2RldmljZQk9IG10a19pb21tdV9yZW1vdmVfZGV2aWNlLA0KPiArCS5wcm9iZV9kZXZpY2UJPSBt
dGtfaW9tbXVfcHJvYmVfZGV2aWNlLA0KPiArCS5wcm9iZV9maW5hbGl6ZSA9IG10a19pb21tdV9w
cm9iZV9maW5hbGl6ZSwNCj4gKwkucmVsZWFzZV9kZXZpY2UJPSBtdGtfaW9tbXVfcmVsZWFzZV9k
ZXZpY2UsDQo+ICsJLmRldmljZV9ncm91cAk9IGdlbmVyaWNfZGV2aWNlX2dyb3VwLA0KPiAgCS5w
Z3NpemVfYml0bWFwCT0gfjBVTCA8PCBNVDI3MDFfSU9NTVVfUEFHRV9TSElGVCwNCj4gIH07DQo+
ICANCg0K

