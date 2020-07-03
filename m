Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B2EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 02:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D1C7207CD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 02:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rU+Qxowk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgGCCjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 22:39:22 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:29315 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726098AbgGCCjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 22:39:21 -0400
X-UUID: 64a3eedf2d8f47b0872f0ccf7b813178-20200703
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ubghZLeTNlicdHeDwlIOfrhXL375GKduXj/VbUzsdHM=;
        b=rU+Qxowk3TNvO24jARAFD+TWLBTgDwEBgBXZ9wvMsf9Xh+LEkqpXi6+chqUa2OGMuJZey3YxnNxq7o1XY8YN4zjuL62B6DALbw2qLRh5OYwq/kwnijl7fo1wn1aPQA2XFM3IfwjjrCe5vxdvez9e7l4uDn74v/GMWyfN+uwCPMg=;
X-UUID: 64a3eedf2d8f47b0872f0ccf7b813178-20200703
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 901121176; Fri, 03 Jul 2020 10:39:16 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 3 Jul 2020 10:39:13 +0800
Received: from [10.15.20.246] (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 3 Jul 2020 10:39:13 +0800
Message-ID: <1593743885.22738.2.camel@mbjsdccf07>
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
Date:   Fri, 3 Jul 2020 10:38:05 +0800
In-Reply-To: <b9a68cda-bb2e-c9f3-4e44-c201df06c396@gmail.com>
References: <20200629071310.1557-1-chao.hao@mediatek.com>
         <20200629071310.1557-5-chao.hao@mediatek.com>
         <0e9ceba8-0cc4-44a1-148c-1c9a6b3844ce@gmail.com>
         <1593514398.2581.7.camel@mbjsdccf07>
         <b9a68cda-bb2e-c9f3-4e44-c201df06c396@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 3EE8F4A8513308CBFB404D0FBB6A79928236E6EF658504C0F5CE61D2EE0CAC8E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA3LTAxIGF0IDE2OjU4ICswMjAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMzAvMDYvMjAyMCAxMjo1MywgY2hhbyBoYW8gd3JvdGU6DQo+ID4gT24gTW9u
LCAyMDIwLTA2LTI5IGF0IDExOjI4ICswMjAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3RlOg0KPiA+
Pg0KPiA+PiBPbiAyOS8wNi8yMDIwIDA5OjEzLCBDaGFvIEhhbyB3cm90ZToNCj4gPj4+IEFkZCBG
X01NVV9JTl9PUkRFUl9XUl9FTiBhbmQgRl9NTVVfU1RBTkRBUkRfQVhJX01PREVfQklUIGRlZmlu
aXRpb24NCj4gPj4+IGluIE1JU0NfQ1RSTCByZWdpc3Rlci4NCj4gPj4+IEZfTU1VX1NUQU5EQVJE
X0FYSV9NT0RFX0JJVDoNCj4gPj4+ICAgSWYgd2Ugc2V0IEZfTU1VX1NUQU5EQVJEX0FYSV9NT0RF
X0JJVChiaXRbM11bMTldID0gMCwgbm90IGZvbGxvdw0KPiA+Pj4gc3RhbmRhcmQgQVhJIHByb3Rv
Y29sKSwgaW9tbXUgd2lsbCBzZW5kIHVyZ2VudCByZWFkIGNvbW1hbmQgZmlyc3RseQ0KPiA+Pj4g
Y29tcGFyZSB3aXRoIG5vcm1hbCByZWFkIGNvbW1hbmQgdG8gaW1wcm92ZSBwZXJmb3JtYW5jZS4N
Cj4gPj4NCj4gPj4gQ2FuIHlvdSBwbGVhc2UgaGVscCBtZSB0byB1bmRlcnN0YW5kIHRoZSBwaHJh
c2UuIFNvcnJ5IEknbSBub3QgYSBBWEkgc3BlY2lhbGlzdC4NCj4gPj4gRG9lcyB0aGlzIG1lYW4g
dGhhdCB5b3Ugd2lsbCBzZW5kIGEgJ3VyZ2VudCByZWFkIGNvbW1hbmQnIHdoaWNoIGlzIG5vdCBk
ZXNjcmliZWQNCj4gPj4gaW4gdGhlIHNwZWNpZmljYXRpb25zIGluc3RlYWQgb2YgYSBub3JtYWwg
cmVhZCBjb21tYW5kPw0KPiA+IA0KPiA+IG9rLg0KPiA+IGlvbW11IHNlbmRzIHJlYWQgY29tbWFu
ZCB0byBuZXh0IGJ1c19ub2RlIG5vcm1hbGx5KHdlIGNhbiBuYW1lIGl0IHRvDQo+ID4gY21kMSks
IHdoZW4gY21kMSBpc24ndCBoYW5kbGVkIGJ5IG5leHQgYnVzX25vZGUsIGlvbW11IGhhcyBhIHVy
Z2VudCByZWFkDQo+ID4gY29tbWFuZCBpcyBuZWVkZWQgdG8gYmUgc2VudCh3ZSBjYW4gbmFtZSBp
dCB0byBjbWQyKSwgaW9tbXUgd2lsbCBzZW5kDQo+ID4gY21kMiBhbmQgcmVwbGFjZSBjbWQxLiBT
byBjbWQyIGlzIGhhbmRsZWQgYnkgbmV4dCBidXNfbm9kZSBmaXJzdGx5IGFuZA0KPiA+IGNtZDIg
d2lsbCBiZSBoYW5kbGVkIHNlY29uZGx5Lg0KPiA+IEJ1dCBmb3Igc3RhbmRhcmQgQVhJIHByb3Rv
Y29sLCBpdCB3aWxsIGlnbm9yZSB0aGUgcHJpb3JpdHkgb2YgcmVhZA0KPiA+IGNvbW1hbmQgYW5k
IG9ubHkgYmUgaGFuZGxlZCBpbiBvcmRlci4gU28gY21kMiBpcyBoYW5kbGVkIGJ5IG5leHQNCj4g
PiBidXNfbm9kZSBhZnRlciBjbWQxIGlzIGRvbmUuDQo+ID4gDQo+IA0KPiBUaGFua3MuIFNvIEkg
cHJvcG9zZSBjaGFuZ2UgdGhpcyBwYXJ0IG9mIHRoZSBjb21taXQgbWVzc2FnZSB0byBzb21ldGhp
bmcgbGlrZToNCj4gRl9NTVVfU1RBTkRBUkRfQVhJX01PREVfQklUOg0KPiBJZiB3ZSBzZXQgRl9N
TVVfU1RBTkRBUkRfQVhJX01PREVfRU5fTUFTSyAoYml0WzNdWzE5XSA9IDAsIG5vdCBmb2xsb3cg
c3RhbmRhcmQNCj4gQVhJIHByb3RvY29sKSwgdGhlIGlvbW11IHdpbGwgcHJpb3JpemUgc2VuZGlu
ZyBvZiB1cmdlbnQgcmVhZCBjb21tYW5kIG92ZXIgYQ0KPiBub3JtYWwgcmVhZCBjb21tYW5kLiBU
aGlzIGltcHJvdmVzIHRoZSBwZXJmb3JtYW5jZS4NCj4gDQpvaywgdGhhbmtzDQoNCj4gPj4NCj4g
Pj4+IEZfTU1VX0lOX09SREVSX1dSX0VOOg0KPiA+Pj4gICBJZiB3ZSBzZXQgRl9NTVVfSU5fT1JE
RVJfV1JfRU4oYml0WzFdWzE3XSA9IDAsIG91dC1vZi1vcmRlciB3cml0ZSksIGlvbW11DQo+ID4+
PiB3aWxsIHJlLW9yZGVyIHdyaXRlIGNvbW1hbmQgYW5kIHNlbmQgbW9yZSBoaWdoZXIgcHJpb3Jp
dHkgd3JpdGUgY29tbWFuZA0KPiA+Pj4gaW5zdGVhZCBvZiBzZW5kaW5nIHdyaXRlIGNvbW1hbmQg
aW4gb3JkZXIuIFRoZSBmZWF0dXJlIGJlIGNvbnRyb2xsZWQNCj4gPj4+IGJ5IE9VVF9PUkRFUl9F
TiBtYWNybyBkZWZpbml0aW9uLg0KPiANCj4gRl9NTVVfSU5fT1JERVJfV1JfRU46DQo+IElmIHdl
IHNldCBGX01NVV9JTl9PUkRFUl9XUl9FTl9NQVNLIChiaXRbMV1bMTddID0gMCwgb3V0LW9mLW9y
ZGVyIHdyaXRlKSwgdGhlDQo+IGlvbW11IHdpbGwgcmUtb3JkZXIgd3JpdGUgY29tbWFuZHMgYW5k
IHNlbmQgdGhlIHdyaXRlIGNvbW1hbmQgd2l0aCBoaWdoZXINCj4gcHJpb3JpdHkuIE90aGVyd2lz
ZSB0aGUgc2VuZGluZyBvZiB3cml0ZSBjb21tYW5kcyB3aWxsIGJlIGRvbmUgaW4gb3JkZXIuIFRo
ZQ0KPiBmZWF0dXJlIGlzIGNvbnRyb2xsZWQgYnkgT1VUX09SREVSX1dSX0VOIHBsYXRmb3JtIGRh
dGEgZmxhZy4NCj4gDQo+IA0KPiA+Pj4NCj4gPj4+IENjOiBNYXR0aGlhcyBCcnVnZ2VyIDxtYXR0
aGlhcy5iZ2dAZ21haWwuY29tPg0KPiA+Pj4gU3VnZ2VzdGVkLWJ5OiBZb25nIFd1IDx5b25nLnd1
QG1lZGlhdGVrLmNvbT4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IENoYW8gSGFvIDxjaGFvLmhhb0Bt
ZWRpYXRlay5jb20+DQo+ID4+PiAtLS0NCj4gPj4+ICBkcml2ZXJzL2lvbW11L210a19pb21tdS5j
IHwgMTIgKysrKysrKysrKystDQo+ID4+PiAgZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaCB8ICAx
ICsNCj4gPj4+ICAyIGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyBi
L2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gPj4+IGluZGV4IDhmODFkZjZjYmU1MS4uNjdi
NDZiNWQ4M2Q5IDEwMDY0NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0K
PiA+Pj4gKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiA+Pj4gQEAgLTQyLDYgKzQy
LDkgQEANCj4gPj4+ICAjZGVmaW5lIEZfSU5WTERfRU4xCQkJCUJJVCgxKQ0KPiA+Pj4gIA0KPiA+
Pj4gICNkZWZpbmUgUkVHX01NVV9NSVNDX0NUUkwJCQkweDA0OA0KPiA+Pj4gKyNkZWZpbmUgRl9N
TVVfSU5fT1JERVJfV1JfRU4JCQkoQklUKDEpIHwgQklUKDE3KSkNCj4gPj4+ICsjZGVmaW5lIEZf
TU1VX1NUQU5EQVJEX0FYSV9NT0RFX0JJVAkJKEJJVCgzKSB8IEJJVCgxOSkpDQo+ID4+DQo+ID4+
IFdvdWxkbid0IGl0IG1ha2UgbW9yZSBzZW5zZSB0byBuYW1lIGl0IEZfTU1VX1NUQU5EQVJEX0FY
SV9NT0RFX0VOPw0KPiA+IG9rLCB5b3UgYXJlIHJpZ2h0Lg0KPiA+IDEnYjE6IGZvbGxvdyBzdGFu
ZGFyZCBheGkgcHJvdG9jb2wNCj4gPiANCj4gDQo+IFdoYXQgYWJvdXQNCj4gRl9NTVVfSU5fT1JE
RVJfV1JfRU5fTUFTSw0KPiBGX01NVV9TVEFOREFSRF9BWElfTU9ERV9FTl9NQVNLDQo+IA0KPiBC
YWNrZ3JvdW5kIGlzIHRoYXQgd2UgaGF2ZSB0byBzZXQvdW5zZXQgdHdvIGJpdHMgdG8gZW5hYmxl
IG9yIGRpc2FibGUgdGhlDQo+IGZlYXR1cmUsIHNvIGl0J3MgYSBtYXNrIHdlIGhhdmUgdG8gYXBw
bHkgdG8gdGhlIHJlZ2lzdGVyLg0KPiANCg0Kb2ssIHRoYW5rcyBmb3IgeW91ciBhZHZpY2UNCg0K
PiBSZWdhcmRzLA0KPiBNYXR0aGlhcw0KPiANCj4gPj4NCj4gPj4+ICsNCj4gPj4+ICAjZGVmaW5l
IFJFR19NTVVfRENNX0RJUwkJCQkweDA1MA0KPiA+Pj4gIA0KPiA+Pj4gICNkZWZpbmUgUkVHX01N
VV9DVFJMX1JFRwkJCTB4MTEwDQo+ID4+PiBAQCAtNTc0LDEwICs1NzcsMTcgQEAgc3RhdGljIGlu
dCBtdGtfaW9tbXVfaHdfaW5pdChjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X2RhdGEgKmRhdGEpDQo+
ID4+PiAgCX0NCj4gPj4+ICAJd3JpdGVsX3JlbGF4ZWQoMCwgZGF0YS0+YmFzZSArIFJFR19NTVVf
RENNX0RJUyk7DQo+ID4+PiAgDQo+ID4+PiArCXJlZ3ZhbCA9IHJlYWRsX3JlbGF4ZWQoZGF0YS0+
YmFzZSArIFJFR19NTVVfTUlTQ19DVFJMKTsNCj4gPj4NCj4gPj4gV2Ugb25seSBuZWVkIHRvIHJl
YWQgcmVndmFsIGluIHRoZSBlbHNlIGJyYW5jaC4NCj4gPiANCj4gPiBvaywgSSBnb3QgaXQuIHRo
YW5rcw0KPiA+IA0KPiA+Pg0KPiA+Pj4gIAlpZiAoTVRLX0lPTU1VX0hBU19GTEFHKGRhdGEtPnBs
YXRfZGF0YSwgUkVTRVRfQVhJKSkgew0KPiA+Pj4gIAkJLyogVGhlIHJlZ2lzdGVyIGlzIGNhbGxl
ZCBTVEFOREFSRF9BWElfTU9ERSBpbiB0aGlzIGNhc2UgKi8NCj4gPj4+IC0JCXdyaXRlbF9yZWxh
eGVkKDAsIGRhdGEtPmJhc2UgKyBSRUdfTU1VX01JU0NfQ1RSTCk7DQo+ID4+PiArCQlyZWd2YWwg
PSAwOw0KPiA+Pj4gKwl9IGVsc2Ugew0KPiA+Pj4gKwkJLyogRm9yIG1tX2lvbW11LCBpdCBjYW4g
aW1wcm92ZSBwZXJmb3JtYW5jZSBieSB0aGUgc2V0dGluZyAqLw0KPiA+Pj4gKwkJcmVndmFsICY9
IH5GX01NVV9TVEFOREFSRF9BWElfTU9ERV9CSVQ7DQo+ID4+PiArCQlpZiAoTVRLX0lPTU1VX0hB
U19GTEFHKGRhdGEtPnBsYXRfZGF0YSwgT1VUX09SREVSX0VOKSkNCj4gPj4+ICsJCQlyZWd2YWwg
Jj0gfkZfTU1VX0lOX09SREVSX1dSX0VOOw0KPiA+Pj4gIAl9DQo+ID4+PiArCXdyaXRlbF9yZWxh
eGVkKHJlZ3ZhbCwgZGF0YS0+YmFzZSArIFJFR19NTVVfTUlTQ19DVFJMKTsNCj4gPj4+ICANCj4g
Pj4+ICAJaWYgKGRldm1fcmVxdWVzdF9pcnEoZGF0YS0+ZGV2LCBkYXRhLT5pcnEsIG10a19pb21t
dV9pc3IsIDAsDQo+ID4+PiAgCQkJICAgICBkZXZfbmFtZShkYXRhLT5kZXYpLCAodm9pZCAqKWRh
dGEpKSB7DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaCBiL2Ry
aXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCj4gPj4+IGluZGV4IDdjYzM5ZjcyOTI2My4uNGI3ODBi
NjUxZWY0IDEwMDY0NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0KPiA+
Pj4gKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaA0KPiA+Pj4gQEAgLTIyLDYgKzIyLDcg
QEANCj4gPj4+ICAjZGVmaW5lIEhBU19CQ0xLCQkJQklUKDEpDQo+ID4+PiAgI2RlZmluZSBIQVNf
VkxEX1BBX1JORwkJCUJJVCgyKQ0KPiA+Pj4gICNkZWZpbmUgUkVTRVRfQVhJCQkJQklUKDMpDQo+
ID4+PiArI2RlZmluZSBPVVRfT1JERVJfRU4JCQlCSVQoNCkNCj4gPj4NCj4gPj4gTWF5YmUgc29t
ZXRoaW5nIGxpa2UgT1VUX09SREVSX1dSX0VOLCB0byBtYWtlIGNsZWFyIHRoYXQgaXQncyBhYm91
dCB0aGUgdGhlDQo+ID4+IHdyaXRlIHBhdGguDQo+ID4+DQo+ID4gb2ssIHRoYW5rcyBmb3IgeW91
ciBhZHZpY2UuDQo+ID4gDQo+ID4+PiAgDQo+ID4+PiAgI2RlZmluZSBNVEtfSU9NTVVfSEFTX0ZM
QUcocGRhdGEsIF94KSBcDQo+ID4+PiAgCQkoKCgocGRhdGEpLT5mbGFncykgJiAoX3gpKSA9PSAo
X3gpKQ0KPiA+Pj4NCj4gPiANCg0K

