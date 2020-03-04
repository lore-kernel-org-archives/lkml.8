Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C47C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 12:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C668820838
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 12:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IddU/DlZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbgCDMaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 07:30:46 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:8997 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729420AbgCDMap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 07:30:45 -0500
X-UUID: af168a97b4af4bd6ba21e7758aa64d8c-20200304
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=hUGYRcp79nujMp8CJYYSA+RvajWD2N45GZbZUHTBZnU=;
        b=IddU/DlZSXXFw1EUrAP469n+GZNlpN+nzgGE3K3en+IF0e5ppljZWJBXdOWt90V79AdR3w2R4Zv2eS9Wqa6cF51PJjKo+VFNvSh9vjd5zmrlyvHNZ1ZDIWNU9s/p65phrgcSU3h6ExdSJuA0xEZ+2tVQeB1Hpp8i2gmHqJj8Umc=;
X-UUID: af168a97b4af4bd6ba21e7758aa64d8c-20200304
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 723530932; Wed, 04 Mar 2020 20:29:41 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 4 Mar
 2020 20:28:17 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 4 Mar 2020 20:28:39 +0800
Message-ID: <1583324972.4784.24.camel@mhfsdcap03>
Subject: Re: [PATCH v2 2/3] iommu/mediatek: add pdata member for legacy ivrp
 paddr
From:   Yong Wu <yong.wu@mediatek.com>
To:     Fabien Parent <fparent@baylibre.com>
CC:     <anan.sun@mediatek.com>, <devicetree@vger.kernel.org>,
        <joro@8bytes.org>, <youlin.pei@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <ck.hu@mediatek.com>,
        <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <scott.wang@mediatek.com>, <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 4 Mar 2020 20:29:32 +0800
In-Reply-To: <1583324597.4784.23.camel@mhfsdcap03>
References: <20200302112152.2887131-1-fparent@baylibre.com>
         <20200302112152.2887131-2-fparent@baylibre.com>
         <1583324597.4784.23.camel@mhfsdcap03>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 031010B90B15B5E0A03BD5360C9733A8E74D3311E1BEF4AF91EC3A67C5B8F8BA2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTAzLTA0IGF0IDIwOjIzICswODAwLCBZb25nIFd1IHdyb3RlOg0KPiBPbiBN
b24sIDIwMjAtMDMtMDIgYXQgMTI6MjEgKzAxMDAsIEZhYmllbiBQYXJlbnQgd3JvdGU6DQo+ID4g
QWRkIGEgbmV3IHBsYXRmb3JtIGRhdGEgbWVtYmVyIGluIG9yZGVyIHRvIHNlbGVjdCB3aGljaCBJ
VlJQX1BBRERSDQo+ID4gZm9ybWF0IGlzIHVzZWQgYnkgYW4gU29DLg0KPiA+IA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEZhYmllbiBQYXJlbnQgPGZwYXJlbnRAYmF5bGlicmUuY29tPg0KPiA+IC0tLQ0K
PiA+IA0KPiA+IHYyOiBuZXcgcGF0Y2gNCj4gPiANCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9pb21t
dS9tdGtfaW9tbXUuYyB8IDMgKystDQo+ID4gIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmggfCAx
ICsNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyBiL2RyaXZl
cnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gPiBpbmRleCA5NTk0NWY0NjdjMDMuLjc4Y2IxNGFiN2Rk
MCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+ID4gKysrIGIv
ZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiA+IEBAIC01NjksNyArNTY5LDcgQEAgc3RhdGlj
IGludCBtdGtfaW9tbXVfaHdfaW5pdChjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X2RhdGEgKmRhdGEp
DQo+ID4gIAkJRl9JTlRfUFJFVEVUQ0hfVFJBTlNBVElPTl9GSUZPX0ZBVUxUOw0KPiA+ICAJd3Jp
dGVsX3JlbGF4ZWQocmVndmFsLCBkYXRhLT5iYXNlICsgUkVHX01NVV9JTlRfTUFJTl9DT05UUk9M
KTsNCj4gPiAgDQo+ID4gLQlpZiAoZGF0YS0+cGxhdF9kYXRhLT5tNHVfcGxhdCA9PSBNNFVfTVQ4
MTczKQ0KPiA+ICsJaWYgKGRhdGEtPnBsYXRfZGF0YS0+aGFzX2xlZ2FjeV9pdnJwX3BhZGRyKQ0K
PiA+ICAJCXJlZ3ZhbCA9IChkYXRhLT5wcm90ZWN0X2Jhc2UgPj4gMSkgfCAoZGF0YS0+ZW5hYmxl
XzRHQiA8PCAzMSk7DQo+ID4gIAllbHNlDQo+ID4gIAkJcmVndmFsID0gbG93ZXJfMzJfYml0cyhk
YXRhLT5wcm90ZWN0X2Jhc2UpIHwNCj4gPiBAQCAtNzg2LDYgKzc4Niw3IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBtdDgxNzNfZGF0YSA9IHsNCj4gPiAgCS5tNHVf
cGxhdCAgICAgPSBNNFVfTVQ4MTczLA0KPiA+ICAJLmhhc180Z2JfbW9kZSA9IHRydWUsDQo+ID4g
IAkuaGFzX2JjbGsgICAgID0gdHJ1ZSwNCj4gPiArCS5oYXNfbGVnYWN5X2l2cnBfcGFkZHIgPSB0
cnVlOw0KDQosDQoNCj4gPiAgCS5yZXNldF9heGkgICAgPSB0cnVlLA0KPiA+ICAJLmxhcmJpZF9y
ZW1hcCA9IHswLCAxLCAyLCAzLCA0LCA1fSwgLyogTGluZWFyIG1hcHBpbmcuICovDQo+ID4gIH07
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmggYi9kcml2ZXJzL2lv
bW11L210a19pb21tdS5oDQo+ID4gaW5kZXggZWE5NDlhMzI0ZTMzLi40Njk2YmEwMjdhNzEgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0KPiA+ICsrKyBiL2RyaXZl
cnMvaW9tbXUvbXRrX2lvbW11LmgNCj4gPiBAQCAtNDIsNiArNDIsNyBAQCBzdHJ1Y3QgbXRrX2lv
bW11X3BsYXRfZGF0YSB7DQo+ID4gIAlib29sICAgICAgICAgICAgICAgIGhhc19iY2xrOw0KPiA+
ICAJYm9vbCAgICAgICAgICAgICAgICBoYXNfdmxkX3BhX3JuZzsNCj4gPiAgCWJvb2wgICAgICAg
ICAgICAgICAgcmVzZXRfYXhpOw0KPiA+ICsJYm9vbCAgICAgICAgICAgICAgICBoYXNfbGVnYWN5
X2l2cnBfcGFkZHI7DQo+IA0KPiBJJ2QgbGlrZSB0byBwdXQgdGhpcyBiZWZvcmUgImhhc192bGRf
cGFfcm5nIiBhbHBoYWJldGljYWxseS4NCj4gDQo+IE90aGVyIHRoYW4gdGhpcywNCj4gDQo+IFJl
dmlld2VkLWJ5OiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCj4gDQo+ID4gIAl1bnNp
Z25lZCBjaGFyICAgICAgIGxhcmJpZF9yZW1hcFtNVEtfTEFSQl9OUl9NQVhdOw0KPiA+ICB9Ow0K
PiA+ICANCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fDQo+IExpbnV4LW1lZGlhdGVrIG1haWxpbmcgbGlzdA0KPiBMaW51eC1tZWRpYXRla0BsaXN0
cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtbWVkaWF0ZWsNCg0K

