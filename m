Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163B2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 04:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6B42207C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 04:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RirTj+SX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgFKEYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 00:24:44 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52342 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725799AbgFKEYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 00:24:44 -0400
X-UUID: f9f3ecb57a2445499a99fad18d155855-20200611
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:To:Reply-To:From:Subject:Message-ID; bh=9koF6CFHB5bfjnigNtEtT8Nwa33piiOWJpOgL6Qy/xA=;
        b=RirTj+SX0+dmOUHbYB0UrEwtkYCD38agrkHM97AwevMKSACLmVyP9tbN8G4P+YKOKLtAgsUGBdB7Sh4LGHarl69o0AImhOxTM9A51t6dfHEhUEICf2bzxgkTbUgd0VQv7DzuIJS3l8QmQahQx8E+tpZr49xPpDH49WLgr1+igR8=;
X-UUID: f9f3ecb57a2445499a99fad18d155855-20200611
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 268571297; Thu, 11 Jun 2020 12:24:38 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 11 Jun 2020 12:24:36 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 11 Jun 2020 12:24:35 +0800
Message-ID: <1591849476.15994.18.camel@mtkswgap22>
Subject: Re: [PATCH v2] usb: gadget: configfs: Fix KASAN use-after-free
From:   Macpaul Lin <macpaul.lin@mediatek.com>
Reply-To: <1484645392-29819-1-git-send-email-jilin@nvidia.com>
To:     Macpaul Lin <macpaul@gmail.com>, Jim Lin <jilin@nvidia.com>,
        "Felipe Balbi" <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Steve Beattie" <steve.beattie@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Steve Beattie <steve.beattie@canonical.com>,
        Siqi Lin <siqilin@google.com>
Date:   Thu, 11 Jun 2020 12:24:36 +0800
In-Reply-To: <CACCg+XODNWZ5FMYLxQaLpspjDYKB_3Uzx1zC-q0dAo2g8xpOYw@mail.gmail.com>
References: <1484645392-29819-1-git-send-email-jilin@nvidia.com>
         <CAGXu5jL8zwxUbymeA4cByaJZ8Ju6=Bv+-dbdfc=5Cu4oRwwoJA@mail.gmail.com>
         <CACCg+XODNWZ5FMYLxQaLpspjDYKB_3Uzx1zC-q0dAo2g8xpOYw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 90582FA388D51A6F2BD0EF1B90F2F16B2872F2141A6CFDD258B7A1A1A65D698F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE3LTA5LTAxIGF0IDEwOjI1OjMyIC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIHVzYjogZ2FkZ2V0OiBjb25maWdmczogRml4IEtBU0FO
IHVzZS1hZnRlci1mcmVlDQo+IFRvOiBKaW0gTGluIDxqaWxpbkBudmlkaWEuY29tPg0KPiBDYzog
RmVsaXBlIEJhbGJpIDxiYWxiaUBrZXJuZWwub3JnPiwgPGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5v
cmc+LCBMS01MDQo+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPiwgR3JlZyBLSCA8Z3Jl
Z2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+LA0KPiBTdGV2ZSBCZWF0dGllIDxzdGV2ZS5iZWF0dGll
QGNhbm9uaWNhbC5jb20+DQo+IA0KPiANCj4gT24gVHVlLCBKYW4gMTcsIDIwMTcgYXQgMToyOSBB
TSwgSmltIExpbiA8amlsaW5AbnZpZGlhLmNvbT4gd3JvdGU6DQo+ID4gV2hlbiBnYWRnZXQgaXMg
ZGlzY29ubmVjdGVkLCBydW5uaW5nIHNlcXVlbmNlIGlzIGxpa2UgdGhpcy4NCj4gPiAuIGNvbXBv
c2l0ZV9kaXNjb25uZWN0DQo+ID4gLiBDYWxsIHRyYWNlOg0KPiA+ICAgdXNiX3N0cmluZ19jb3B5
KzB4ZDAvMHgxMjgNCj4gPiAgIGdhZGdldF9jb25maWdfbmFtZV9jb25maWd1cmF0aW9uX3N0b3Jl
KzB4NA0KPiA+ICAgZ2FkZ2V0X2NvbmZpZ19uYW1lX2F0dHJfc3RvcmUrMHg0MC8weDUwDQo+ID4g
ICBjb25maWdmc193cml0ZV9maWxlKzB4MTk4LzB4MWY0DQo+ID4gICB2ZnNfd3JpdGUrMHgxMDAv
MHgyMjANCj4gPiAgIFN5U193cml0ZSsweDU4LzB4YTgNCj4gPiAuIGNvbmZpZ2ZzX2NvbXBvc2l0
ZV91bmJpbmQNCj4gPiAuIGNvbmZpZ2ZzX2NvbXBvc2l0ZV9iaW5kDQo+ID4NCj4gPiBJbiBjb25m
aWdmc19jb21wb3NpdGVfYmluZCwgaXQgaGFzDQo+ID4gImNuLT5zdHJpbmdzLnMgPSBjbi0+Y29u
ZmlndXJhdGlvbjsiDQo+ID4NCj4gPiBXaGVuIHVzYl9zdHJpbmdfY29weSBpcyBpbnZva2VkLiBp
dCB3b3VsZA0KPiA+IGFsbG9jYXRlIG1lbW9yeSwgY29weSBpbnB1dCBzdHJpbmcsIHJlbGVhc2Ug
cHJldmlvdXMgcG9pbnRlZCBtZW1vcnkgc3BhY2UsDQo+ID4gYW5kIHVzZSBuZXcgYWxsb2NhdGVk
IG1lbW9yeS4NCj4gPg0KPiA+IFdoZW4gZ2FkZ2V0IGlzIGNvbm5lY3RlZCwgaG9zdCBzZW5kcyBk
b3duIHJlcXVlc3QgdG8gZ2V0IGluZm9ybWF0aW9uLg0KPiA+IENhbGwgdHJhY2U6DQo+ID4gICB1
c2JfZ2FkZ2V0X2dldF9zdHJpbmcrMHhlYy8weDE2OA0KPiA+ICAgbG9va3VwX3N0cmluZysweDY0
LzB4OTgNCj4gPiAgIGNvbXBvc2l0ZV9zZXR1cCsweGEzNC8weDFlZTgNCj4gPiAgIGFuZHJvaWRf
c2V0dXArMHhiNC8weDE0MA0KPiA+DQo+ID4gSWYgZ2FkZ2V0IGlzIGRpc2Nvbm5lY3RlZCBhbmQg
Y29ubmVjdGVkIHF1aWNrbHksIGluIHRoZSBmYWlsZWQgY2FzZSwNCj4gPiBjbi0+Y29uZmlndXJh
dGlvbiBtZW1vcnkgaGFzIGJlZW4gcmVsZWFzZWQgYnkgdXNiX3N0cmluZ19jb3B5IGtmcmVlIGJ1
dA0KPiA+IGNvbmZpZ2ZzX2NvbXBvc2l0ZV9iaW5kIGhhc24ndCBiZWVuIHJ1biBpbiB0aW1lIHRv
IGFzc2lnbiBuZXcgYWxsb2NhdGVkDQo+ID4gImNuLT5jb25maWd1cmF0aW9uIiBwb2ludGVyIHRv
ICJjbi0+c3RyaW5ncy5zIi4NCj4gPg0KPiA+IFdoZW4gInN0cmxlbihzLT5zKSBvZiB1c2JfZ2Fk
Z2V0X2dldF9zdHJpbmcgaXMgYmVpbmcgZXhlY3V0ZWQsIHRoZSBkYW5nbGluZw0KPiA+IG1lbW9y
eSBpcyBhY2Nlc3NlZCwgIkJVRzogS0FTQU46IHVzZS1hZnRlci1mcmVlIiBlcnJvciBvY2N1cnMu
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKaW0gTGluIDxqaWxpbkBudmlkaWEuY29tPg0KPiAN
Cj4gSGkhIFdoYXQncyB0aGUgY3VycmVudCBzdGF0ZSBvZiB0aGlzIHBhdGNoPw0KDQpNZWRpYXRl
ayBpcyB1c2luZyB0aGlzIGJ1ZyBmaXggaW4gQW5kcm9pZCBrZXJuZWwgMy4xOCwgNC40LCA0Ljks
IDQuMTQNCmFuZCA0LjE5LiBLZXJuZWwgY29kZSBub3dhZGF5cy4NCg0KU2luY2UgdGhlcmUgYXJl
IG5ld3MgdGhhdCBHb29nbGUgaXMgcGxhbm5pbmcgdG8gdXNlIEdlbmVyaWMgS2VybmVsIEltYWdl
DQooR0tJKSBmb3IgZnV0dXJlIEFuZHJvaWQuIFNob3VsZCB0aGlzIHBhdGNoIGJlIHJlZmluZWQg
YW5kIGFkYXB0IGludG8NCkxpbnV4Pw0KDQpEZWFyIEppbSBhbmQgU2lxaSwgYWNjb3JkaW5nIHRv
IEZlbGlwZSdzIG1haWwgYmVmb3JlLCBkbyB5b3UgaGF2ZQ0KZW52aXJvbm1lbnRzIHRvIHRlc3Qg
aXQgb24gYSBMaW51eCBlbnZpcm9ubWVudCBsaWtlIG9uIFBDPyBNYXliZSBvbiBzb21lDQplbWJl
ZGRlZCBlbnZpcm9ubWVudCBub3QgdXNpbmcgQW5kcm9pZCBvciBDaHJvbWl1bSBPUz8gSSBkb24n
dCBoYXZlIHRoYXQNCmtpbmQgb2YgZW52aXJvbm1lbnQgaW4gbXkgb2ZmaWNlIGhlbmNlIEkganVz
dCBjb3VsZG4ndCBwcm92aWRlIGEgaGVscCB0bw0KZG8gdGhlIHRlc3QuDQoNCj4gPiAtLS0NCj4g
PiBDaGFuZ2VzIGluIHYyOg0KPiA+ICBSZXBocmFzZSBjb21taXQgZGVzY3JpcHRpb24NCj4gPg0K
PiA+ICBkcml2ZXJzL3VzYi9nYWRnZXQvY29uZmlnZnMuYyB8IDE1ICsrKysrKysrKysrLS0tLQ0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvY29uZmlnZnMuYyBiL2RyaXZl
cnMvdXNiL2dhZGdldC9jb25maWdmcy5jDQo+ID4gaW5kZXggNzhjNDQ5Ny4uMzlmZWE2MiAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvY29uZmlnZnMuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvdXNiL2dhZGdldC9jb25maWdmcy5jDQo+ID4gQEAgLTEwNiw2ICsxMDYsOSBAQCBzdHJ1
Y3QgZ2FkZ2V0X2NvbmZpZ19uYW1lIHsNCj4gPiAgICAgICAgIHN0cnVjdCBsaXN0X2hlYWQgbGlz
dDsNCj4gPiAgfTsNCj4gPg0KPiA+ICsjZGVmaW5lIE1BWF9VU0JfU1RSSU5HX0xFTiAgICAgMTI2
DQo+ID4gKyNkZWZpbmUgTUFYX1VTQl9TVFJJTkdfV0lUSF9OVUxMX0xFTiAgIChNQVhfVVNCX1NU
UklOR19MRU4rMSkNCj4gPiArDQo+ID4gIHN0YXRpYyBpbnQgdXNiX3N0cmluZ19jb3B5KGNvbnN0
IGNoYXIgKnMsIGNoYXIgKipzX2NvcHkpDQo+ID4gIHsNCj4gPiAgICAgICAgIGludCByZXQ7DQo+
ID4gQEAgLTExNSwxMiArMTE4LDE2IEBAIHN0YXRpYyBpbnQgdXNiX3N0cmluZ19jb3B5KGNvbnN0
IGNoYXIgKnMsIGNoYXIgKipzX2NvcHkpDQo+ID4gICAgICAgICBpZiAocmV0ID4gMTI2KQ0KPiAN
Cj4gVGhpcyBzaG91bGQgYmUgTUFYX1VTQl9TVFJJTkdfTEVOLCB5ZXM/DQo+IA0KPiA+ICAgICAg
ICAgICAgICAgICByZXR1cm4gLUVPVkVSRkxPVzsNCj4gPg0KPiA+IC0gICAgICAgc3RyID0ga3N0
cmR1cChzLCBHRlBfS0VSTkVMKTsNCj4gPiAtICAgICAgIGlmICghc3RyKQ0KPiA+IC0gICAgICAg
ICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gPiArICAgICAgIGlmIChjb3B5KSB7DQo+ID4gKyAg
ICAgICAgICAgICAgIHN0ciA9IGNvcHk7DQo+ID4gKyAgICAgICB9IGVsc2Ugew0KPiA+ICsgICAg
ICAgICAgICAgICBzdHIgPSBrbWFsbG9jKE1BWF9VU0JfU1RSSU5HX1dJVEhfTlVMTF9MRU4sIEdG
UF9LRVJORUwpOw0KPiA+ICsgICAgICAgICAgICAgICBpZiAoIXN0cikNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gPiArICAgICAgIH0NCj4gPiArICAgICAg
IHN0cmNweShzdHIsIHMpOw0KPiA+ICAgICAgICAgaWYgKHN0cltyZXQgLSAxXSA9PSAnXG4nKQ0K
PiA+ICAgICAgICAgICAgICAgICBzdHJbcmV0IC0gMV0gPSAnXDAnOw0KPiA+IC0gICAgICAga2Zy
ZWUoY29weSk7DQo+ID4gICAgICAgICAqc19jb3B5ID0gc3RyOw0KPiA+ICAgICAgICAgcmV0dXJu
IDA7DQo+ID4gIH0NCj4gPiAtLQ0KPiA+IDIuNy40DQo+ID4NCj4gDQo+IC1LZWVzDQoNClRoYW5r
IHlvdSB2ZXJ5IG11Y2guDQpNYWNwYXVsIExpbg0K

