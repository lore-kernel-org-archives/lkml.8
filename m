Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34729C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0940B20715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ptpOJFQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgERGxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 02:53:02 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:20606 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726040AbgERGxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 02:53:01 -0400
X-UUID: 50de2994ee194d24be05a64da9dcc874-20200518
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=BE27p8cgAXdiOJaTc4rLjiLgh00VCcwZpGfoS4OOzsM=;
        b=ptpOJFQJPFBPL0cXkOqi5XQq0/yJTcAYzd6Xd1kQWwUg4VdHh2mnbGPt0mbD9ULSgjuY9RuCQsxe6WDM+RcppeVDqP5klDWQdDGAiu8iiqef6Im9IPnivLimwGbVBzh1ZnPdTsfZL3fSYtLAJ1PlFQquB/C2sLu1OEw+FwOZ+Sc=;
X-UUID: 50de2994ee194d24be05a64da9dcc874-20200518
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1666374242; Mon, 18 May 2020 14:52:50 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 18 May
 2020 14:52:46 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 18 May 2020 14:52:46 +0800
Message-ID: <1589784680.15083.19.camel@mhfsdcap03>
Subject: Re: [PATCH v2 23/33] iommu/mediatek-v1 Convert to
 probe/release_device() call-backs
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>
CC:     Joerg Roedel <jroedel@suse.de>, Will Deacon <will@kernel.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Marek Szyprowski" <m.szyprowski@samsung.com>
Date:   Mon, 18 May 2020 14:51:20 +0800
In-Reply-To: <20200515100718.GS18353@8bytes.org>
References: <20200414131542.25608-1-joro@8bytes.org>
         <20200414131542.25608-24-joro@8bytes.org>
         <1589528699.26119.9.camel@mhfsdcap03> <20200515100718.GS18353@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 645326C83BAFED16ABAF80B4AAC8D7BA842597586DFE9CAF78B92A85A256ADAF2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTA1LTE1IGF0IDEyOjA3ICswMjAwLCBKb2VyZyBSb2VkZWwgd3JvdGU6DQo+
IEhpLA0KPiANCj4gT24gRnJpLCBNYXkgMTUsIDIwMjAgYXQgMDM6NDQ6NTlQTSArMDgwMCwgWW9u
ZyBXdSB3cm90ZToNCj4gPiBPbiBUdWUsIDIwMjAtMDQtMTQgYXQgMTU6MTUgKzAyMDAsIEpvZXJn
IFJvZWRlbCB3cm90ZToNCj4gPiA+IC0JcmV0dXJuIGlvbW11X2RldmljZV9saW5rKCZkYXRhLT5p
b21tdSwgZGV2KTsNCj4gPiA+ICsJZXJyID0gYXJtX2lvbW11X2F0dGFjaF9kZXZpY2UoZGV2LCBt
dGtfbWFwcGluZyk7DQo+ID4gPiArCWlmIChlcnIpDQo+ID4gPiArCQlkZXZfZXJyKGRldiwgIkNh
bid0IGNyZWF0ZSBJT01NVSBtYXBwaW5nIC0gRE1BLU9QUyB3aWxsIG5vdCB3b3JrXG4iKTsNCj4g
PiANCj4gPiANCj4gPiBIaSBKb2VyZywNCj4gPiANCj4gPiAgICAgIFRoYW5rcyB2ZXJ5IG11Y2gg
Zm9yIHRoaXMgcGF0Y2guDQo+ID4gDQo+ID4gICAgICBUaGlzIGFybV9pb21tdV9hdHRhY2hfZGV2
aWNlIGlzIGNhbGxlZCBqdXN0IGFzIHdlIGV4cGVjdGVkLg0KPiA+IA0KPiA+ICAgICAgQnV0IGl0
IHdpbGwgZmFpbCBpbiB0aGlzIGNhbGxzdGFjayBhcyB0aGUgZ3JvdXAtPm11dGV4IHdhcyB0cmll
ZCB0bw0KPiA+IGJlIHJlLWxvY2tlZC4uLg0KPiA+IA0KPiA+IFs8YzA5MzhlOGM+XSAoaW9tbXVf
YXR0YWNoX2RldmljZSkgZnJvbSBbPGMwMzE3NTkwPl0NCj4gPiAoX19hcm1faW9tbXVfYXR0YWNo
X2RldmljZSsweDM0LzB4OTApDQo+ID4gWzxjMDMxNzU5MD5dIChfX2FybV9pb21tdV9hdHRhY2hf
ZGV2aWNlKSBmcm9tIFs8YzAzMTc1Zjg+XQ0KPiA+IChhcm1faW9tbXVfYXR0YWNoX2RldmljZSsw
eGMvMHgyMCkNCj4gPiBbPGMwMzE3NWY4Pl0gKGFybV9pb21tdV9hdHRhY2hfZGV2aWNlKSBmcm9t
IFs8YzA5NDMyY2M+XQ0KPiA+IChtdGtfaW9tbXVfcHJvYmVfZmluYWxpemUrMHgzNC8weDUwKQ0K
PiA+IFs8YzA5NDMyY2M+XSAobXRrX2lvbW11X3Byb2JlX2ZpbmFsaXplKSBmcm9tIFs8YzA5M2E4
YWM+XQ0KPiA+IChidXNfaW9tbXVfcHJvYmUrMHgyYTgvMHgyYzQpDQo+ID4gWzxjMDkzYThhYz5d
IChidXNfaW9tbXVfcHJvYmUpIGZyb20gWzxjMDkzYTk1MD5dIChidXNfc2V0X2lvbW11DQo+ID4g
KzB4ODgvMHhkNCkNCj4gPiBbPGMwOTNhOTUwPl0gKGJ1c19zZXRfaW9tbXUpIGZyb20gWzxjMDk0
M2M3ND5dIChtdGtfaW9tbXVfcHJvYmUNCj4gPiArMHgyZjgvMHgzNjQpDQo+IA0KPiBUaGFua3Mg
Zm9yIHRoZSByZXBvcnQsIGlzDQo+IA0KPiAJaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8x
NTg5NTMwMTIzLTMwMjQwLTEtZ2l0LXNlbmQtZW1haWwteW9uZy53dUBtZWRpYXRlay5jb20vDQo+
IA0KPiBUaGUgZml4IGZvciB0aGlzIGlzc3VlIG9yIGlzIHNvbWV0aGluZyBlbHNlIHJlcXVpcmVk
Pw0KDQpOby4gVGhhdCBwYXRjaCBvbmx5IGFkanVzdCB0aGUgaW50ZXJuYWwgZmxvdyB0byBzYXRp
c2Z5IHRoZSBsYXRlc3QNCmZyYW1ld29yaywgaXQncyBub3QgZm9yIGZpeGluZyB0aGlzIG11dGV4
IGlzc3VlLiANCg0KSGVyZSBJIG9ubHkgcmVwb3J0ZWQgdGhpcyBpc3N1ZS4NCg0KYmVsb3cgaXMg
bXkgbG9jYWwgcGF0Y2guIHNwbGl0ICJkbWFfYXR0YWNoIiB0byBhdHRhY2hfZGV2aWNlIGFuZA0K
cHJvYmVfZmluYWxpemUuIEFib3V0IGF0dGFjaF9kZXZpY2UsIFVzZSB0aGUgZXhpc3RlZA0KX19p
b21tdV9hdHRhY2hfZ3JvdXAgaW5zdGVhZC4gVGhlbiByZW5hbWUgZnJvbSB0aGUgImRtYV9hdHRh
Y2giIHRvDQoicHJvYmVfZmluYWxpemUiIHRvIGRvIHRoZSBwcm9iZV9maW5hbGl6ZSBqb2IuIEFu
ZCBtb3ZlIGl0IG91dHNpZGUgb2YNCnRoZSBtdXRleF91bmxvY2suDQoNCkknbSBub3Qgc3VyZSBp
ZiBpdCBpcyByaWdodC4gYW5kIG9mIGNvdXJzZSBJIHdpbGwgdGVzdCBpZiB5b3UgaGF2ZSBhbnkN
Cm90aGVyIHNvbHV0aW9uLiBUaGFua3MuDQoNCg0KLS0tIGEvZHJpdmVycy9pb21tdS9pb21tdS5j
DQorKysgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMNCkBAIC0xNjY1LDI2ICsxNjY1LDIwIEBAIHN0
YXRpYyB2b2lkIHByb2JlX2FsbG9jX2RlZmF1bHRfZG9tYWluKHN0cnVjdA0KYnVzX3R5cGUgKmJ1
cywNCiANCiB9DQogDQotc3RhdGljIGludCBpb21tdV9ncm91cF9kb19kbWFfYXR0YWNoKHN0cnVj
dCBkZXZpY2UgKmRldiwgdm9pZCAqZGF0YSkNCitzdGF0aWMgaW50IGlvbW11X2dyb3VwX2RvX3By
b2JlX2ZpbmFsaXplKHN0cnVjdCBkZXZpY2UgKmRldiwgdm9pZA0KKmRhdGEpDQogew0KIAlzdHJ1
Y3QgaW9tbXVfZG9tYWluICpkb21haW4gPSBkYXRhOw0KLQljb25zdCBzdHJ1Y3QgaW9tbXVfb3Bz
ICpvcHM7DQotCWludCByZXQ7DQotDQotCXJldCA9IF9faW9tbXVfYXR0YWNoX2RldmljZShkb21h
aW4sIGRldik7DQotDQotCW9wcyA9IGRvbWFpbi0+b3BzOw0KKwljb25zdCBzdHJ1Y3QgaW9tbXVf
b3BzICpvcHMgPSBkb21haW4tPm9wczsNCiANCi0JaWYgKHJldCA9PSAwICYmIG9wcy0+cHJvYmVf
ZmluYWxpemUpDQorCWlmIChvcHMtPnByb2JlX2ZpbmFsaXplKQ0KIAkJb3BzLT5wcm9iZV9maW5h
bGl6ZShkZXYpOw0KLQ0KLQlyZXR1cm4gcmV0Ow0KKwlyZXR1cm4gMDsNCiB9DQogDQotc3RhdGlj
IGludCBfX2lvbW11X2dyb3VwX2RtYV9hdHRhY2goc3RydWN0IGlvbW11X2dyb3VwICpncm91cCkN
CitzdGF0aWMgaW50IGlvbW11X2dyb3VwX3Byb2JlX2ZpbmFsaXplKHN0cnVjdCBpb21tdV9ncm91
cCAqZ3JvdXApDQogew0KIAlyZXR1cm4gX19pb21tdV9ncm91cF9mb3JfZWFjaF9kZXYoZ3JvdXAs
IGdyb3VwLT5kZWZhdWx0X2RvbWFpbiwNCi0JCQkJCSAgaW9tbXVfZ3JvdXBfZG9fZG1hX2F0dGFj
aCk7DQorCQkJCQkgIGlvbW11X2dyb3VwX2RvX3Byb2JlX2ZpbmFsaXplKTsNCiB9DQogDQogc3Rh
dGljIGludCBpb21tdV9kb19jcmVhdGVfZGlyZWN0X21hcHBpbmdzKHN0cnVjdCBkZXZpY2UgKmRl
diwgdm9pZA0KKmRhdGEpDQpAQCAtMTczMSwxMiArMTcyNSwxNCBAQCBpbnQgYnVzX2lvbW11X3By
b2JlKHN0cnVjdCBidXNfdHlwZSAqYnVzKQ0KIA0KIAkJaW9tbXVfZ3JvdXBfY3JlYXRlX2RpcmVj
dF9tYXBwaW5ncyhncm91cCk7DQogDQotCQlyZXQgPSBfX2lvbW11X2dyb3VwX2RtYV9hdHRhY2go
Z3JvdXApOw0KKwkJcmV0ID0gX19pb21tdV9hdHRhY2hfZ3JvdXAoZ3JvdXAtPmRlZmF1bHRfZG9t
YWluLCBncm91cCk7DQogDQogCQltdXRleF91bmxvY2soJmdyb3VwLT5tdXRleCk7DQogDQogCQlp
ZiAocmV0KQ0KIAkJCWJyZWFrOw0KKw0KKwkJaW9tbXVfZ3JvdXBfcHJvYmVfZmluYWxpemUoZ3Jv
dXApOw0KIAl9DQogDQogCXJldHVybiByZXQ7DQotLSANCg0KPiANCj4gDQo+IFRoYW5rcywNCj4g
DQo+IAlKb2VyZw0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18NCj4gTGludXgtbWVkaWF0ZWsgbWFpbGluZyBsaXN0DQo+IExpbnV4LW1lZGlhdGVr
QGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1tZWRpYXRlaw0KDQo=

