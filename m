Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87563C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65AF62073E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="W9mu+44/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732683AbgF3Kye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 06:54:34 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:10632 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729377AbgF3Kyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 06:54:33 -0400
X-UUID: 8652aa4974ec431eb1bd83e81af4e9d5-20200630
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=1frGonLY1z6bSq/H3kT64qvgesRuR+pzmBbHCLpti1k=;
        b=W9mu+44/QT8bk5uDWHK6tphZBC7tG5n/0s/UHdqvnnuKhI1DUkiq1zr7VrTU5GWDCtxRXEZ5P3t4KKC2zyWsIq60TBWONiIppfF5N/XfBLSIsurpv3akPiUZqApzNdtvxxGtN16GT9BoKim+JBIs4LrJsFcFLUV2QhHakTqB7Gs=;
X-UUID: 8652aa4974ec431eb1bd83e81af4e9d5-20200630
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 704726967; Tue, 30 Jun 2020 18:54:27 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 30 Jun 2020 18:54:17 +0800
Received: from [10.15.20.246] (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 30 Jun 2020 18:54:16 +0800
Message-ID: <1593514398.2581.7.camel@mbjsdccf07>
Subject: Re: [PATCH v5 04/10] iommu/mediatek: Setting MISC_CTRL register
From:   chao hao <Chao.Hao@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        "Yong Wu" <yong.wu@mediatek.com>,
        Evan Green <evgreen@chromium.org>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        FY Yang <fy.yang@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>
Date:   Tue, 30 Jun 2020 18:53:18 +0800
In-Reply-To: <0e9ceba8-0cc4-44a1-148c-1c9a6b3844ce@gmail.com>
References: <20200629071310.1557-1-chao.hao@mediatek.com>
         <20200629071310.1557-5-chao.hao@mediatek.com>
         <0e9ceba8-0cc4-44a1-148c-1c9a6b3844ce@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: BAF6CEB1E06926B691EB2968E120FA304DAE48B58E1A3A76D8C81A49D6E53EB22000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA2LTI5IGF0IDExOjI4ICswMjAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMjkvMDYvMjAyMCAwOToxMywgQ2hhbyBIYW8gd3JvdGU6DQo+ID4gQWRkIEZf
TU1VX0lOX09SREVSX1dSX0VOIGFuZCBGX01NVV9TVEFOREFSRF9BWElfTU9ERV9CSVQgZGVmaW5p
dGlvbg0KPiA+IGluIE1JU0NfQ1RSTCByZWdpc3Rlci4NCj4gPiBGX01NVV9TVEFOREFSRF9BWElf
TU9ERV9CSVQ6DQo+ID4gICBJZiB3ZSBzZXQgRl9NTVVfU1RBTkRBUkRfQVhJX01PREVfQklUKGJp
dFszXVsxOV0gPSAwLCBub3QgZm9sbG93DQo+ID4gc3RhbmRhcmQgQVhJIHByb3RvY29sKSwgaW9t
bXUgd2lsbCBzZW5kIHVyZ2VudCByZWFkIGNvbW1hbmQgZmlyc3RseQ0KPiA+IGNvbXBhcmUgd2l0
aCBub3JtYWwgcmVhZCBjb21tYW5kIHRvIGltcHJvdmUgcGVyZm9ybWFuY2UuDQo+IA0KPiBDYW4g
eW91IHBsZWFzZSBoZWxwIG1lIHRvIHVuZGVyc3RhbmQgdGhlIHBocmFzZS4gU29ycnkgSSdtIG5v
dCBhIEFYSSBzcGVjaWFsaXN0Lg0KPiBEb2VzIHRoaXMgbWVhbiB0aGF0IHlvdSB3aWxsIHNlbmQg
YSAndXJnZW50IHJlYWQgY29tbWFuZCcgd2hpY2ggaXMgbm90IGRlc2NyaWJlZA0KPiBpbiB0aGUg
c3BlY2lmaWNhdGlvbnMgaW5zdGVhZCBvZiBhIG5vcm1hbCByZWFkIGNvbW1hbmQ/DQoNCm9rLg0K
aW9tbXUgc2VuZHMgcmVhZCBjb21tYW5kIHRvIG5leHQgYnVzX25vZGUgbm9ybWFsbHkod2UgY2Fu
IG5hbWUgaXQgdG8NCmNtZDEpLCB3aGVuIGNtZDEgaXNuJ3QgaGFuZGxlZCBieSBuZXh0IGJ1c19u
b2RlLCBpb21tdSBoYXMgYSB1cmdlbnQgcmVhZA0KY29tbWFuZCBpcyBuZWVkZWQgdG8gYmUgc2Vu
dCh3ZSBjYW4gbmFtZSBpdCB0byBjbWQyKSwgaW9tbXUgd2lsbCBzZW5kDQpjbWQyIGFuZCByZXBs
YWNlIGNtZDEuIFNvIGNtZDIgaXMgaGFuZGxlZCBieSBuZXh0IGJ1c19ub2RlIGZpcnN0bHkgYW5k
DQpjbWQyIHdpbGwgYmUgaGFuZGxlZCBzZWNvbmRseS4NCkJ1dCBmb3Igc3RhbmRhcmQgQVhJIHBy
b3RvY29sLCBpdCB3aWxsIGlnbm9yZSB0aGUgcHJpb3JpdHkgb2YgcmVhZA0KY29tbWFuZCBhbmQg
b25seSBiZSBoYW5kbGVkIGluIG9yZGVyLiBTbyBjbWQyIGlzIGhhbmRsZWQgYnkgbmV4dA0KYnVz
X25vZGUgYWZ0ZXIgY21kMSBpcyBkb25lLg0KDQo+IA0KPiA+IEZfTU1VX0lOX09SREVSX1dSX0VO
Og0KPiA+ICAgSWYgd2Ugc2V0IEZfTU1VX0lOX09SREVSX1dSX0VOKGJpdFsxXVsxN10gPSAwLCBv
dXQtb2Ytb3JkZXIgd3JpdGUpLCBpb21tdQ0KPiA+IHdpbGwgcmUtb3JkZXIgd3JpdGUgY29tbWFu
ZCBhbmQgc2VuZCBtb3JlIGhpZ2hlciBwcmlvcml0eSB3cml0ZSBjb21tYW5kDQo+ID4gaW5zdGVh
ZCBvZiBzZW5kaW5nIHdyaXRlIGNvbW1hbmQgaW4gb3JkZXIuIFRoZSBmZWF0dXJlIGJlIGNvbnRy
b2xsZWQNCj4gPiBieSBPVVRfT1JERVJfRU4gbWFjcm8gZGVmaW5pdGlvbi4NCj4gPiANCj4gPiBD
YzogTWF0dGhpYXMgQnJ1Z2dlciA8bWF0dGhpYXMuYmdnQGdtYWlsLmNvbT4NCj4gPiBTdWdnZXN0
ZWQtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IENoYW8gSGFvIDxjaGFvLmhhb0BtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMv
aW9tbXUvbXRrX2lvbW11LmMgfCAxMiArKysrKysrKysrKy0NCj4gPiAgZHJpdmVycy9pb21tdS9t
dGtfaW9tbXUuaCB8ICAxICsNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRr
X2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+ID4gaW5kZXggOGY4MWRmNmNi
ZTUxLi42N2I0NmI1ZDgzZDkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9t
bXUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gPiBAQCAtNDIsNiAr
NDIsOSBAQA0KPiA+ICAjZGVmaW5lIEZfSU5WTERfRU4xCQkJCUJJVCgxKQ0KPiA+ICANCj4gPiAg
I2RlZmluZSBSRUdfTU1VX01JU0NfQ1RSTAkJCTB4MDQ4DQo+ID4gKyNkZWZpbmUgRl9NTVVfSU5f
T1JERVJfV1JfRU4JCQkoQklUKDEpIHwgQklUKDE3KSkNCj4gPiArI2RlZmluZSBGX01NVV9TVEFO
REFSRF9BWElfTU9ERV9CSVQJCShCSVQoMykgfCBCSVQoMTkpKQ0KPiANCj4gV291bGRuJ3QgaXQg
bWFrZSBtb3JlIHNlbnNlIHRvIG5hbWUgaXQgRl9NTVVfU1RBTkRBUkRfQVhJX01PREVfRU4/DQpv
aywgeW91IGFyZSByaWdodC4NCjEnYjE6IGZvbGxvdyBzdGFuZGFyZCBheGkgcHJvdG9jb2wNCg0K
PiANCj4gPiArDQo+ID4gICNkZWZpbmUgUkVHX01NVV9EQ01fRElTCQkJCTB4MDUwDQo+ID4gIA0K
PiA+ICAjZGVmaW5lIFJFR19NTVVfQ1RSTF9SRUcJCQkweDExMA0KPiA+IEBAIC01NzQsMTAgKzU3
NywxNyBAQCBzdGF0aWMgaW50IG10a19pb21tdV9od19pbml0KGNvbnN0IHN0cnVjdCBtdGtfaW9t
bXVfZGF0YSAqZGF0YSkNCj4gPiAgCX0NCj4gPiAgCXdyaXRlbF9yZWxheGVkKDAsIGRhdGEtPmJh
c2UgKyBSRUdfTU1VX0RDTV9ESVMpOw0KPiA+ICANCj4gPiArCXJlZ3ZhbCA9IHJlYWRsX3JlbGF4
ZWQoZGF0YS0+YmFzZSArIFJFR19NTVVfTUlTQ19DVFJMKTsNCj4gDQo+IFdlIG9ubHkgbmVlZCB0
byByZWFkIHJlZ3ZhbCBpbiB0aGUgZWxzZSBicmFuY2guDQoNCm9rLCBJIGdvdCBpdC4gdGhhbmtz
DQoNCj4gDQo+ID4gIAlpZiAoTVRLX0lPTU1VX0hBU19GTEFHKGRhdGEtPnBsYXRfZGF0YSwgUkVT
RVRfQVhJKSkgew0KPiA+ICAJCS8qIFRoZSByZWdpc3RlciBpcyBjYWxsZWQgU1RBTkRBUkRfQVhJ
X01PREUgaW4gdGhpcyBjYXNlICovDQo+ID4gLQkJd3JpdGVsX3JlbGF4ZWQoMCwgZGF0YS0+YmFz
ZSArIFJFR19NTVVfTUlTQ19DVFJMKTsNCj4gPiArCQlyZWd2YWwgPSAwOw0KPiA+ICsJfSBlbHNl
IHsNCj4gPiArCQkvKiBGb3IgbW1faW9tbXUsIGl0IGNhbiBpbXByb3ZlIHBlcmZvcm1hbmNlIGJ5
IHRoZSBzZXR0aW5nICovDQo+ID4gKwkJcmVndmFsICY9IH5GX01NVV9TVEFOREFSRF9BWElfTU9E
RV9CSVQ7DQo+ID4gKwkJaWYgKE1US19JT01NVV9IQVNfRkxBRyhkYXRhLT5wbGF0X2RhdGEsIE9V
VF9PUkRFUl9FTikpDQo+ID4gKwkJCXJlZ3ZhbCAmPSB+Rl9NTVVfSU5fT1JERVJfV1JfRU47DQo+
ID4gIAl9DQo+ID4gKwl3cml0ZWxfcmVsYXhlZChyZWd2YWwsIGRhdGEtPmJhc2UgKyBSRUdfTU1V
X01JU0NfQ1RSTCk7DQo+ID4gIA0KPiA+ICAJaWYgKGRldm1fcmVxdWVzdF9pcnEoZGF0YS0+ZGV2
LCBkYXRhLT5pcnEsIG10a19pb21tdV9pc3IsIDAsDQo+ID4gIAkJCSAgICAgZGV2X25hbWUoZGF0
YS0+ZGV2KSwgKHZvaWQgKilkYXRhKSkgew0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11
L210a19pb21tdS5oIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0KPiA+IGluZGV4IDdjYzM5
ZjcyOTI2My4uNGI3ODBiNjUxZWY0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaW9tbXUvbXRr
X2lvbW11LmgNCj4gPiArKysgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQo+ID4gQEAgLTIy
LDYgKzIyLDcgQEANCj4gPiAgI2RlZmluZSBIQVNfQkNMSwkJCUJJVCgxKQ0KPiA+ICAjZGVmaW5l
IEhBU19WTERfUEFfUk5HCQkJQklUKDIpDQo+ID4gICNkZWZpbmUgUkVTRVRfQVhJCQkJQklUKDMp
DQo+ID4gKyNkZWZpbmUgT1VUX09SREVSX0VOCQkJQklUKDQpDQo+IA0KPiBNYXliZSBzb21ldGhp
bmcgbGlrZSBPVVRfT1JERVJfV1JfRU4sIHRvIG1ha2UgY2xlYXIgdGhhdCBpdCdzIGFib3V0IHRo
ZSB0aGUNCj4gd3JpdGUgcGF0aC4NCj4gDQpvaywgdGhhbmtzIGZvciB5b3VyIGFkdmljZS4NCg0K
PiA+ICANCj4gPiAgI2RlZmluZSBNVEtfSU9NTVVfSEFTX0ZMQUcocGRhdGEsIF94KSBcDQo+ID4g
IAkJKCgoKHBkYXRhKS0+ZmxhZ3MpICYgKF94KSkgPT0gKF94KSkNCj4gPiANCg0K

