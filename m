Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1546EC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 12:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5397207FB
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 12:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dPd2NzNq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgHPMwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 08:52:32 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:6858 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725843AbgHPMw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 08:52:29 -0400
X-UUID: 4a5fdee5eef341928f4ac76df0d9ce6f-20200816
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=tnCvM0ehaNufpV7eQrvwPu1Df01rjGmSfmECzsOP8Xk=;
        b=dPd2NzNqCk06Q6vL8lwQei8ZKDIU9IxQNa8kVF4YMFyBDSPKuNmzGsABCm86ZMRD8E4EKkWEh+y9AaVNzByiKWZp11vj5LEG9irkZQKS/UCw7u9EpjvzIuLly9ooFR1fvs/YAhjI9dIN0BogUk6GWJzu3Jhtpn6QBEN2Df/1oYI=;
X-UUID: 4a5fdee5eef341928f4ac76df0d9ce6f-20200816
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <phil.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 115726227; Sun, 16 Aug 2020 20:52:24 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 16 Aug 2020 20:52:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 16 Aug 2020 20:52:22 +0800
From:   Phil Chang <phil.chang@mediatek.com>
To:     <robin.murphy@arm.com>
CC:     <alix.wu@mediatek.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <phil.chang@mediatek.com>,
        <yj.chiang@mediatek.com>
Subject: Re: Re: [PATCH] ARM64: Setup DMA32 zone size by bootargs
Date:   Sun, 16 Aug 2020 20:50:34 +0800
Message-ID: <20200816125033.4565-1-phil.chang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <db255462-7a02-f3a4-075a-5070f630e9d6@arm.com>
References: <db255462-7a02-f3a4-075a-5070f630e9d6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gdGhpcyBwYXRjaCBhbGxvd2luZyB0aGUgYXJtNjQgRE1BIHpvbmUgYmUgY29uZmlndXJhYmxl
Lg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBBbGl4IFd1IDxhbGl4Lnd1QG1lZGlhdGVrLmNvbT4N
Cj4+IFNpZ25lZC1vZmYtYnk6IFlKIENoaWFuZyA8eWouY2hpYW5nQG1lZGlhdGVrLmNvbT4NCj4+
IFNpZ25lZC1vZmYtYnk6IFBoaWwgQ2hhbmcgPHBoaWwuY2hhbmdAbWVkaWF0ZWsuY29tPg0KPj4g
LS0tDQo+PiBIaQ0KPj4gDQo+PiBGb3Igc29tZSBkZXZpY2VzLCB0aGUgbWFpbiBtZW1vcnkgc3Bs
aXQgaW50byAyIHBhcnQgZHVlIHRvIHRoZSBtZW1vcnkgYXJjaGl0ZWN0dXJlLA0KPj4gdGhlIGVm
ZmljaWVudCBhbmQgbGVzcyBpbmVmZmljaWVudCBwYXJ0Lg0KPj4gT25lIG9mIHRoZSB1c2UgY2Fz
ZSBpcyBmaW5lLXR1bmUgdGhlIGRtYTMyIHNpemUgdG8gY29udGFpbiBhbGwgdGhlDQo+PiBlZmZp
Y2llbnQgcGFydCBvZiBtZW1vcnkgYmxvY2sgb24gdGhpcyBraW5kIG9mIGFyY2hpdGVjdHVyZSwN
Cj4+IGJ1dCBpbiBnZW5lcmFsLCB0aGUgRE1BMzIgem9uZSBzaXplIGlzIGhhcmRjb2RlIHRvIDRH
Lg0KPg0KPiBUaGUgc29sZSBwb2ludCBvZiBaT05FX0RNQTMyIGlzIHRvIGNvbnRhaW4gYWxsIHRo
ZSAzMi1iaXQgYWRkcmVzc2FibGUgDQo+IG1lbW9yeSB3aGljaCBpcyBub3QgY292ZXJlZCBieSBa
T05FX0RNQS4gQXMgc3VjaCB0aGUgb25seSBwb3NzaWJsZSB0aGluZyANCj4gdGhhdCBjb3VsZCBi
ZSBjb25maWd1cmVkIGlzIHRoZSBzaXplIG9mIFpPTkVfRE1BIChpZiBwcmVzZW50KSwgYW5kIHRo
aXMgDQo+IHBhdGNoIG1ha2VzIG5vIHNlbnNlLg0KPg0KPiBJZiB5b3Ugd2FudCB0byBkZXNjcmli
ZSBOVU1BIGNoYXJhY3RlcmlzdGljcywgdXNlIE5VTUEgcHJvcGVydGllcy4gDQo+IEdpdmluZyB1
c2VycyBmcmVlZG9tIHRvIGJyZWFrIGZ1bmRhbWVudGFsIGFzc3VtcHRpb25zIG9mIHRoZSBETUEg
bGF5ZXIgDQo+IGJ5IGFyYml0cmFyaWx5IGNoYW5naW5nIHRoZSBtZWFuaW5nIG9mICIzMi1iaXQi
IGlzIG5vdCBhbiBhcHByb3ByaWF0ZSANCj4gc29sdXRpb24uDQo+DQo+IFJvYmluLg0KDQpIaSBS
b2Jpbg0KDQpUaGFubmtzIGZvciB5b3VyIHJlcGx5LCBob3cgYWJvdXQgYWRkIGEgY29uZGljdGlv
biB0bw0KbGltaXQgdGhlIGN1c3RvbWl6ZSBkbWEzMiB6b25lIHNpemUgdW5kZXIgNEcgPw0KDQo+
PiAgIC4uLi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQgICAgICAgICB8ICAzICsr
DQo+PiAgIGFyY2gvYXJtNjQvaW5jbHVkZS9hc20vbWVtb3J5LmggICAgICAgICAgICAgICB8ICAy
ICsrDQo+PiAgIGFyY2gvYXJtNjQvbW0vaW5pdC5jICAgICAgICAgICAgICAgICAgICAgICAgICB8
IDMzICsrKysrKysrKysrKysrKysrLS0NCj4+ICAgMyBmaWxlcyBjaGFuZ2VkLCAzNSBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQgYi9Eb2N1bWVudGF0aW9uL2FkbWlu
LWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dA0KPj4gaW5kZXggZmI5NWZhZDgxYzc5Li40NDFh
ZDNjYjhlZTggMTAwNjQ0DQo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tlcm5l
bC1wYXJhbWV0ZXJzLnR4dA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJu
ZWwtcGFyYW1ldGVycy50eHQNCj4+IEBAIC05NTYsNiArOTU2LDkgQEANCj4+ICAgCQkJVGhlIGZp
bHRlciBjYW4gYmUgZGlzYWJsZWQgb3IgY2hhbmdlZCB0byBhbm90aGVyDQo+PiAgIAkJCWRyaXZl
ciBsYXRlciB1c2luZyBzeXNmcy4NCj4+ICAgDQo+PiArCWRtYTMyX3pvbmU9bm4JW0tNR10gW0tO
TCxCT09UXQ0KPj4gKwkJCUZvcmNlcyB0aGUgRE1BMzIgem9uZSBzaXplIG9mIDxubj4gaW4gbWIs
IGFybTY0IG9ubHkuDQo+PiArDQo+PiAgIAlkcml2ZXJfYXN5bmNfcHJvYmU9ICBbS05MXQ0KPj4g
ICAJCQlMaXN0IG9mIGRyaXZlciBuYW1lcyB0byBiZSBwcm9iZWQgYXN5bmNocm9ub3VzbHkuDQo+
PiAgIAkJCUZvcm1hdDogPGRyaXZlcl9uYW1lMT4sPGRyaXZlcl9uYW1lMj4uLi4NCj4+IGRpZmYg
LS1naXQgYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL21lbW9yeS5oIGIvYXJjaC9hcm02NC9pbmNs
dWRlL2FzbS9tZW1vcnkuaA0KPj4gaW5kZXggYTE4NzFiYjMyYmIxLi4zNzdmMjI1MjYxOGEgMTAw
NjQ0DQo+PiAtLS0gYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL21lbW9yeS5oDQo+PiArKysgYi9h
cmNoL2FybTY0L2luY2x1ZGUvYXNtL21lbW9yeS5oDQo+PiBAQCAtMTc0LDYgKzE3NCw4IEBAIGV4
dGVybiB1NjQJCQlraW1hZ2VfdmFkZHI7DQo+PiAgIC8qIHRoZSBvZmZzZXQgYmV0d2VlbiB0aGUg
a2VybmVsIHZpcnR1YWwgYW5kIHBoeXNpY2FsIG1hcHBpbmdzICovDQo+PiAgIGV4dGVybiB1NjQJ
CQlraW1hZ2Vfdm9mZnNldDsNCj4+ICAgDQo+PiArZXh0ZXJuIHBoeXNfYWRkcl90CQlhcm1fZG1h
X3pvbmVfc2l6ZTsNCj4+ICsNCj4+ICAgc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIGthc2xy
X29mZnNldCh2b2lkKQ0KPj4gICB7DQo+PiAgIAlyZXR1cm4ga2ltYWdlX3ZhZGRyIC0gS0lNQUdF
X1ZBRERSOw0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvbW0vaW5pdC5jIGIvYXJjaC9hcm02
NC9tbS9pbml0LmMNCj4+IGluZGV4IDFlOTNjZmM3YzQ3YS4uNjQyYWIzMjMzOTJjIDEwMDY0NA0K
Pj4gLS0tIGEvYXJjaC9hcm02NC9tbS9pbml0LmMNCj4+ICsrKyBiL2FyY2gvYXJtNjQvbW0vaW5p
dC5jDQo+PiBAQCAtNjAsNiArNjAsOSBAQCBFWFBPUlRfU1lNQk9MKHBoeXN2aXJ0X29mZnNldCk7
DQo+PiAgIHN0cnVjdCBwYWdlICp2bWVtbWFwIF9fcm9fYWZ0ZXJfaW5pdDsNCj4+ICAgRVhQT1JU
X1NZTUJPTCh2bWVtbWFwKTsNCj4+ICAgDQo+PiArcGh5c19hZGRyX3QgYXJtX2RtYV96b25lX3Np
emUgX19yb19hZnRlcl9pbml0Ow0KPj4gK0VYUE9SVF9TWU1CT0woYXJtX2RtYV96b25lX3NpemUp
Ow0KPj4gKw0KPj4gICAvKg0KPj4gICAgKiBXZSBjcmVhdGUgYm90aCBaT05FX0RNQSBhbmQgWk9O
RV9ETUEzMi4gWk9ORV9ETUEgY292ZXJzIHRoZSBmaXJzdCAxRyBvZg0KPj4gICAgKiBtZW1vcnkg
YXMgc29tZSBkZXZpY2VzLCBuYW1lbHkgdGhlIFJhc3BiZXJyeSBQaSA0LCBoYXZlIHBlcmlwaGVy
YWxzIHdpdGgNCj4+IEBAIC0yNDIsNiArMjQ1LDI1IEBAIHN0YXRpYyBpbnQgX19pbml0IGVhcmx5
X21lbShjaGFyICpwKQ0KPj4gICB9DQo+PiAgIGVhcmx5X3BhcmFtKCJtZW0iLCBlYXJseV9tZW0p
Ow0KPj4gICANCj4+ICsvKg0KPj4gKyAqIFNldHVwIHRoZSBkbWEzMiB6b25lIHNpemUNCj4+ICsg
Ki8NCj4+ICtzdGF0aWMgaW50IF9faW5pdCBzZXR1cF9kbWEzMl96b25lKGNoYXIgKnApDQo+PiAr
ew0KPj4gKwlpZiAoIXApDQo+PiArCQlyZXR1cm4gLUVJTlZBTDsNCj4+ICsNCj4+ICsJaWYgKGtz
dHJ0b3VsbChwLCAwLCAmYXJtX2RtYV96b25lX3NpemUpKQ0KPj4gKwkJcmV0dXJuIC1FSU5WQUw7
DQo+PiArDQo+PiArCWFybV9kbWFfem9uZV9zaXplICo9IFNaXzFNOw0KPj4gKwlwcl9ub3RpY2Uo
IlNldHVwIGRtYTMyIHpvbmUgc2l6ZSB0byAlbGx1IE1iXG4iLCBhcm1fZG1hX3pvbmVfc2l6ZSk7
DQo+PiArDQo+PiArCXJldHVybiAwOw0KPj4gK30NCj4+ICsNCj4+ICtlYXJseV9wYXJhbSgiZG1h
MzJfem9uZSIsIHNldHVwX2RtYTMyX3pvbmUpOw0KPj4gKw0KPj4gICBzdGF0aWMgaW50IF9faW5p
dCBlYXJseV9pbml0X2R0X3NjYW5fdXNhYmxlbWVtKHVuc2lnbmVkIGxvbmcgbm9kZSwNCj4+ICAg
CQljb25zdCBjaGFyICp1bmFtZSwgaW50IGRlcHRoLCB2b2lkICpkYXRhKQ0KPj4gICB7DQo+PiBA
QCAtMzkyLDEwICs0MTQsMTUgQEAgdm9pZCBfX2luaXQgYXJtNjRfbWVtYmxvY2tfaW5pdCh2b2lk
KQ0KPj4gICAJCWFybTY0X2RtYV9waHlzX2xpbWl0ID0gbWF4X3pvbmVfcGh5cyhBUk02NF9aT05F
X0RNQV9CSVRTKTsNCj4+ICAgCX0NCj4+ICAgDQo+PiAtCWlmIChJU19FTkFCTEVEKENPTkZJR19a
T05FX0RNQTMyKSkNCj4+IC0JCWFybTY0X2RtYTMyX3BoeXNfbGltaXQgPSBtYXhfem9uZV9waHlz
KDMyKTsNCj4+IC0JZWxzZQ0KPj4gKwlpZiAoSVNfRU5BQkxFRChDT05GSUdfWk9ORV9ETUEzMikp
IHsNCj4+ICsJCWlmIChhcm1fZG1hX3pvbmVfc2l6ZSkNCj4+ICsJCQlhcm02NF9kbWEzMl9waHlz
X2xpbWl0ID0gYXJtX2RtYV96b25lX3NpemUgKw0KPj4gKwkJCQkJCW1lbWJsb2NrX3N0YXJ0X29m
X0RSQU0oKTsNCj4+ICsJCWVsc2UNCj4+ICsJCQlhcm02NF9kbWEzMl9waHlzX2xpbWl0ID0gbWF4
X3pvbmVfcGh5cygzMik7DQo+PiArCX0gZWxzZSB7DQo+PiAgIAkJYXJtNjRfZG1hMzJfcGh5c19s
aW1pdCA9IFBIWVNfTUFTSyArIDE7DQo+PiArCX0NCj4+ICAgDQo+PiAgIAlyZXNlcnZlX2NyYXNo
a2VybmVsKCk7DQo+PiANCj4+DQo=

