Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A0FC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9C70207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gn6DI5iy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388932AbgEYG4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 02:56:34 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:3720 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388385AbgEYG4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 02:56:33 -0400
X-UUID: fbd3d7b1f60848d9a269012ade4917c9-20200525
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=6DRd72G/04IUjrJWtULzvnV0W9JE0UNqefujrxFZ1Cs=;
        b=gn6DI5iy1sAcJebaPEH3cWoU+p0wrbb/2AW989G3Y5roI3t7japerJPGtbNckLDbVnKVfOdiA+PXIg0Y7lC35PPNjJj3pLizUJ5gGZyHVaBacRfGJ73A50eywhDjZuCm6+SNvc5HbvyM8F0b57Eg7UoebLJVN/6ksMeBSqwaZ9Y=;
X-UUID: fbd3d7b1f60848d9a269012ade4917c9-20200525
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1290107391; Mon, 25 May 2020 14:56:14 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 25 May
 2020 14:56:13 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 May 2020 14:56:13 +0800
Message-ID: <1590389672.13912.26.camel@mhfsdcap03>
Subject: Re: [PATCH v3 7/7] iommu/mediatek: Add mt6779 basic support
From:   Yong Wu <yong.wu@mediatek.com>
To:     Chao Hao <chao.hao@mediatek.com>
CC:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        FY Yang <fy.yang@mediatek.com>, Jun Yan <jun.yan@mediatek.com>
Date:   Mon, 25 May 2020 14:54:32 +0800
In-Reply-To: <20200509083654.5178-8-chao.hao@mediatek.com>
References: <20200509083654.5178-1-chao.hao@mediatek.com>
         <20200509083654.5178-8-chao.hao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: D84AC03253283C703994F8FF4CE4C4A6A591C83D422D4AD6387936229962A63F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIwLTA1LTA5IGF0IDE2OjM2ICswODAwLCBDaGFvIEhhbyB3cm90ZToNCj4gMS4g
U3RhcnQgZnJvbSBtdDY3NzksIElOVkxEVF9TRUwgbW92ZSB0byBvZmZzZXQ9MHgyYywgc28gd2Ug
YWRkDQo+ICAgIFJFR19NTVVfSU5WX1NFTF9HRU4yIGRlZmluaXRpb24gYW5kIG10Njc3OSB1c2Vz
IGl0Lg0KPiAyLiBDaGFuZ2UgUFJPVEVDVF9QQV9BTElHTiBmcm9tIDEyOCBieXRlIHRvIDI1NiBi
eXRlLg0KPiAzLiBGb3IgUkVHX01NVV9DVFJMX1JFRyByZWdpc3Rlciwgd2Ugb25seSBuZWVkIHRv
IGNoYW5nZSBiaXRbMjowXSwNCj4gICAgb3RoZXJzIGJpdHMga2VlcCBkZWZhdWx0IHZhbHVlLCBl
eDogZW5hYmxlIHZpY3RpbSB0bGIuDQo+IDQuIEFkZCBtdDY3NzlfZGF0YSB0byBzdXBwb3J0IG1t
X2lvbW11IEhXIGluaXQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaGFvIEhhbyA8Y2hhby5oYW9A
bWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgfCAxOCAr
KysrKysrKysrKysrKystLS0NCj4gIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmggfCAgMSArDQo+
ICAyIGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUv
bXRrX2lvbW11LmMNCj4gaW5kZXggZGM5YWU5NDRlNzEyLi4zNGM0ZmZiNzdjNzMgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gKysrIGIvZHJpdmVycy9pb21tdS9t
dGtfaW9tbXUuYw0KPiBAQCAtMzcsNiArMzcsNyBAQA0KPiAgI2RlZmluZSBSRUdfTU1VX0lOVkxE
X1NUQVJUX0EJCQkweDAyNA0KPiAgI2RlZmluZSBSRUdfTU1VX0lOVkxEX0VORF9BCQkJMHgwMjgN
Cj4gIA0KPiArI2RlZmluZSBSRUdfTU1VX0lOVl9TRUxfR0VOMgkJCTB4MDJjDQo+ICAjZGVmaW5l
IFJFR19NTVVfSU5WX1NFTF9HRU4xCQkJMHgwMzgNCg0KTm9ybWFsbHkgdGhlIHJlZ2lzdGVyIG5h
bWUgY29tZXMgZnJvbSB0aGUgQ09EQS4gSW4gdGhlIGxhc3RlZCBDT0RBLA0KdGhpcyBpcyBjYWxs
ZWQgIk1NVV9JTlZMRFRfU0VMIi4gQnV0IGl0J3Mgc2FtZSB3aXRoIHRoZSBwcmV2aW91cyAweDM4
DQp0b3RhbGx5LiBVc2luZyBfR0VOMSwgX0dFTjIgaXMgb2sgZm9yIG1lLiBQbGVhc2UgYWRkIGl0
cyBjb2RhIG5hbWUgaW4NCnRoZSBjb21tZW50LiBsaWtlOg0KDQojZGVmaW5lIFJFR19NTVVfSU5W
X1NFTF9HRU4yCQkweDAyYyAvKiBNTVVfSU5WTERUX1NFTCAqLw0KDQo+ICAjZGVmaW5lIEZfSU5W
TERfRU4wCQkJCUJJVCgwKQ0KPiAgI2RlZmluZSBGX0lOVkxEX0VOMQkJCQlCSVQoMSkNCj4gQEAg
LTk3LDcgKzk4LDcgQEANCj4gICNkZWZpbmUgRl9NTVVfSU5UX0lEX0xBUkJfSUQoYSkJCQkoKChh
KSA+PiA3KSAmIDB4NykNCj4gICNkZWZpbmUgRl9NTVVfSU5UX0lEX1BPUlRfSUQoYSkJCQkoKChh
KSA+PiAyKSAmIDB4MWYpDQo+ICANCj4gLSNkZWZpbmUgTVRLX1BST1RFQ1RfUEFfQUxJR04JCQkx
MjgNCj4gKyNkZWZpbmUgTVRLX1BST1RFQ1RfUEFfQUxJR04JCQkyNTYNCj4gIA0KPiAgLyoNCj4g
ICAqIEdldCB0aGUgbG9jYWwgYXJiaXRlciBJRCBhbmQgdGhlIHBvcnRpZCB3aXRoaW4gdGhlIGxh
cmIgYXJiaXRlcg0KPiBAQCAtNTU0LDExICs1NTUsMTIgQEAgc3RhdGljIGludCBtdGtfaW9tbXVf
aHdfaW5pdChjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X2RhdGEgKmRhdGEpDQo+ICAJCXJldHVybiBy
ZXQ7DQo+ICAJfQ0KPiAgDQo+ICsJcmVndmFsID0gcmVhZGxfcmVsYXhlZChkYXRhLT5iYXNlICsg
UkVHX01NVV9DVFJMX1JFRyk7DQo+ICAJaWYgKGRhdGEtPnBsYXRfZGF0YS0+bTR1X3BsYXQgPT0g
TTRVX01UODE3MykNCj4gLQkJcmVndmFsID0gRl9NTVVfUFJFRkVUQ0hfUlRfUkVQTEFDRV9NT0Qg
fA0KPiArCQlyZWd2YWwgfD0gRl9NTVVfUFJFRkVUQ0hfUlRfUkVQTEFDRV9NT0QgfA0KDQpUaGUg
ZGVmYXVsdCB2YWx1ZSBpcyBub3Qgb2sgZm9yIG10ODE3MyhJdHMgYml0OSBpcyBpbl9vcmRlcl93
cml0ZV9lbiwgd2UNCmNvdWxkIG5vdCB1c2UgaXRzIGRlZmF1bHQgMSdiMSkuIHRodXMsIERvbid0
IHRvdWNoIHRoaXMgbGluZS4NCg0KPiAgCQkJIEZfTU1VX1RGX1BST1RfVE9fUFJPR1JBTV9BRERS
X01UODE3MzsNCj4gIAllbHNlDQo+IC0JCXJlZ3ZhbCA9IEZfTU1VX1RGX1BST1RfVE9fUFJPR1JB
TV9BRERSOw0KPiArCQlyZWd2YWwgfD0gRl9NTVVfVEZfUFJPVF9UT19QUk9HUkFNX0FERFI7DQo+
ICAJd3JpdGVsX3JlbGF4ZWQocmVndmFsLCBkYXRhLT5iYXNlICsgUkVHX01NVV9DVFJMX1JFRyk7
DQo+ICANCj4gIAlyZWd2YWwgPSBGX0wyX01VTElUX0hJVF9FTiB8DQo+IEBAIC04MDQsNiArODA2
LDE1IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBtdDI3MTJfZGF0
YSA9IHsNCj4gIAkubGFyYmlkX3JlbWFwID0ge3swfSwgezF9LCB7Mn0sIHszfSwgezR9LCB7NX0s
IHs2fSwgezd9fSwNCj4gIH07DQo+ICANCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11
X3BsYXRfZGF0YSBtdDY3NzlfZGF0YSA9IHsNCj4gKwkubTR1X3BsYXQgPSBNNFVfTVQ2Nzc5LA0K
PiArCS5sYXJiaWRfcmVtYXAgPSB7ezB9LCB7MX0sIHsyfSwgezN9LCB7NX0sIHs3LCA4fSwgezEw
fSwgezl9fSwNCj4gKwkuaGFzX3N1Yl9jb21tID0gdHJ1ZSwNCj4gKwkuaGFzX3dyX2xlbiA9IHRy
dWUsDQo+ICsJLmhhc19taXNjX2N0cmwgPSB0cnVlLA0KPiArCS5pbnZfc2VsX3JlZyA9IFJFR19N
TVVfSU5WX1NFTF9HRU4yLA0KDQphbGlnbiAnPScgYSBiaXQuDQoNCj4gK307DQo+ICsNCj4gIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBtdDgxNzNfZGF0YSA9IHsNCj4g
IAkubTR1X3BsYXQgICAgID0gTTRVX01UODE3MywNCj4gIAkuaGFzXzRnYl9tb2RlID0gdHJ1ZSwN
Cj4gQEAgLTgyMiw2ICs4MzMsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19pb21tdV9wbGF0
X2RhdGEgbXQ4MTgzX2RhdGEgPSB7DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2
aWNlX2lkIG10a19pb21tdV9vZl9pZHNbXSA9IHsNCj4gIAl7IC5jb21wYXRpYmxlID0gIm1lZGlh
dGVrLG10MjcxMi1tNHUiLCAuZGF0YSA9ICZtdDI3MTJfZGF0YX0sDQo+ICsJeyAuY29tcGF0aWJs
ZSA9ICJtZWRpYXRlayxtdDY3NzktbTR1IiwgLmRhdGEgPSAmbXQ2Nzc5X2RhdGF9LA0KPiAgCXsg
LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTczLW00dSIsIC5kYXRhID0gJm10ODE3M19kYXRh
fSwNCj4gIAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1tNHUiLCAuZGF0YSA9ICZt
dDgxODNfZGF0YX0sDQo+ICAJe30NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lv
bW11LmggYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQo+IGluZGV4IDk5NzFjZWRkNzJlYS4u
ZmI3OWU3MTBjOGQ5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQo+
ICsrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCj4gQEAgLTMxLDYgKzMxLDcgQEAgc3Ry
dWN0IG10a19pb21tdV9zdXNwZW5kX3JlZyB7DQo+ICBlbnVtIG10a19pb21tdV9wbGF0IHsNCj4g
IAlNNFVfTVQyNzAxLA0KPiAgCU00VV9NVDI3MTIsDQo+ICsJTTRVX01UNjc3OSwNCj4gIAlNNFVf
TVQ4MTczLA0KPiAgCU00VV9NVDgxODMsDQo+ICB9Ow0KDQo=

