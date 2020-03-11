Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE74C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 01:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C9121D56
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 01:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KOftGtCh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgCKBxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 21:53:33 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:38187 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726463AbgCKBxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 21:53:32 -0400
X-UUID: 6a56e4500bd34b35bb8a16fe0d916be8-20200311
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=MeJypbtXZBi16e+sneeWLK3w3UOQDEmwsecp62tfwK4=;
        b=KOftGtChChN2R3tI37nwpPyjzlJLlH6lc7hL/U/x5NR5KC/uuqVNNRyNmINeLam4t6hEhOVmvZaKAg8TG0gdTXo9FS1OFiblFDzjrgurBt9lLyxpxR7GHsW26lrrU62+VwKNyzwFQOzp7MUAaxnaA7j0Mj5BvO0DciLjARnR1Mw=;
X-UUID: 6a56e4500bd34b35bb8a16fe0d916be8-20200311
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 445182679; Wed, 11 Mar 2020 09:53:25 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 11 Mar 2020 09:52:08 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 11 Mar 2020 09:53:31 +0800
Message-ID: <1583891602.17522.17.camel@mtksdccf07>
Subject: Re: [PATCH -next] lib/test_kasan: silence a -Warray-bounds warning
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Dmitry Vyukov <dvyukov@google.com>, Qian Cai <cai@lca.pw>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 11 Mar 2020 09:53:22 +0800
In-Reply-To: <CACT4Y+aV9BrvEHdaadL7FXsjMi4iPDJUnK8eyJj=HuZFa4fxuw@mail.gmail.com>
References: <1583847469-4354-1-git-send-email-cai@lca.pw>
         <CACT4Y+aV9BrvEHdaadL7FXsjMi4iPDJUnK8eyJj=HuZFa4fxuw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUWlhbiwNCg0KT24gVHVlLCAyMDIwLTAzLTEwIGF0IDE2OjIwICswMTAwLCAnRG1pdHJ5IFZ5
dWtvdicgdmlhIGthc2FuLWRldiB3cm90ZToNCj4gT24gVHVlLCBNYXIgMTAsIDIwMjAgYXQgMjoz
OCBQTSBRaWFuIENhaSA8Y2FpQGxjYS5wdz4gd3JvdGU6DQo+ID4NCj4gPiBUaGUgY29tbWl0ICJr
YXNhbjogYWRkIHRlc3QgZm9yIGludmFsaWQgc2l6ZSBpbiBtZW1tb3ZlIiBpbnRyb2R1Y2VkIGEN
Cj4gPiBjb21waWxhdGlvbiB3YXJuaW5nIHdoZXJlIGl0IHVzZWQgYSBuZWdhdGl2ZSBzaXplIG9u
IHB1cnBvc2UuIFNpbGVuY2UgaXQNCj4gPiBieSBkaXNhYmxpbmcgImFycmF5LWJvdW5kcyIgY2hl
Y2tpbmcgZm9yIHRoaXMgZmlsZSBvbmx5IGZvciB0ZXN0aW5nDQo+ID4gcHVycG9zZS4NCj4gPg0K
PiA+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSAuL2luY2x1ZGUvbGludXgvYml0bWFwLmg6OSwNCj4g
PiAgICAgICAgICAgICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4L2NwdW1hc2suaDoxMiwNCj4g
PiAgICAgICAgICAgICAgICAgIGZyb20gLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9jcHVtYXNrLmg6
NSwNCj4gPiAgICAgICAgICAgICAgICAgIGZyb20gLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc3Iu
aDoxMSwNCj4gPiAgICAgICAgICAgICAgICAgIGZyb20gLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9w
cm9jZXNzb3IuaDoyMiwNCj4gPiAgICAgICAgICAgICAgICAgIGZyb20gLi9hcmNoL3g4Ni9pbmNs
dWRlL2FzbS9jcHVmZWF0dXJlLmg6NSwNCj4gPiAgICAgICAgICAgICAgICAgIGZyb20gLi9hcmNo
L3g4Ni9pbmNsdWRlL2FzbS90aHJlYWRfaW5mby5oOjUzLA0KPiA+ICAgICAgICAgICAgICAgICAg
ZnJvbSAuL2luY2x1ZGUvbGludXgvdGhyZWFkX2luZm8uaDozOCwNCj4gPiAgICAgICAgICAgICAg
ICAgIGZyb20gLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wcmVlbXB0Lmg6NywNCj4gPiAgICAgICAg
ICAgICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4L3ByZWVtcHQuaDo3OCwNCj4gPiAgICAgICAg
ICAgICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4L3JjdXBkYXRlLmg6MjcsDQo+ID4gICAgICAg
ICAgICAgICAgICBmcm9tIC4vaW5jbHVkZS9saW51eC9yY3VsaXN0Lmg6MTEsDQo+ID4gICAgICAg
ICAgICAgICAgICBmcm9tIC4vaW5jbHVkZS9saW51eC9waWQuaDo1LA0KPiA+ICAgICAgICAgICAg
ICAgICAgZnJvbSAuL2luY2x1ZGUvbGludXgvc2NoZWQuaDoxNCwNCj4gPiAgICAgICAgICAgICAg
ICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4L3VhY2Nlc3MuaDo2LA0KPiA+ICAgICAgICAgICAgICAg
ICAgZnJvbSAuL2FyY2gveDg2L2luY2x1ZGUvYXNtL2ZwdS94c3RhdGUuaDo1LA0KPiA+ICAgICAg
ICAgICAgICAgICAgZnJvbSAuL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BndGFibGUuaDoyNiwNCj4g
PiAgICAgICAgICAgICAgICAgIGZyb20gLi9pbmNsdWRlL2xpbnV4L2thc2FuLmg6MTUsDQo+ID4g
ICAgICAgICAgICAgICAgICBmcm9tIGxpYi90ZXN0X2thc2FuLmM6MTI6DQo+ID4gSW4gZnVuY3Rp
b24gJ21lbW1vdmUnLA0KPiA+ICAgICBpbmxpbmVkIGZyb20gJ2ttYWxsb2NfbWVtbW92ZV9pbnZh
bGlkX3NpemUnIGF0DQo+ID4gbGliL3Rlc3Rfa2FzYW4uYzozMDE6MjoNCj4gPiAuL2luY2x1ZGUv
bGludXgvc3RyaW5nLmg6NDQxOjk6IHdhcm5pbmc6ICdfX2J1aWx0aW5fbWVtbW92ZScgcG9pbnRl
cg0KPiA+IG92ZXJmbG93IGJldHdlZW4gb2Zmc2V0IDAgYW5kIHNpemUgWy0yLCA5MjIzMzcyMDM2
ODU0Nzc1ODA3XQ0KPiA+IFstV2FycmF5LWJvdW5kc10NCj4gPiAgIHJldHVybiBfX2J1aWx0aW5f
bWVtbW92ZShwLCBxLCBzaXplKTsNCj4gPiAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fg0KPiA+DQoNCldoZW4gcGFzcyB0aGUgbmVnYXRpdmUgbnVtYmVycywgdGhlbiB0aGVy
ZSBhcmUgdHdvIHdhcm5pbmcuIEluIGdjYy04IHRoZQ0Kd2FybmluZyBpcyBjaGVja2VkIGJ5IGFy
cmF5LWJvdW5kcywgYnV0IGluIGdjYy05IHRoZSB3YXJuaW5nIGlzIGNoZWNrZWQNCmJ5IHN0cmlu
Z29wLW92ZXJmbG93Lg0KDQpJIHRyeSB0byB1c2UgeW91IHBhdGNoIHRvIGNoZWNrIHRoZSBnY2Mt
OSB0b29sY2hhaW5zLCBidXQgaXQgc3RpbGwgaGF2ZQ0KdGhlIHdhcm5pbmcsIGJ1dCB1c2luZyBi
ZWxvdyB0aGUgcGF0Y2ggY2FuIGZpeCB0aGUgd2FybmluZyBpbiBnY2MtOCBhbmQNCmdjYy05Lg0K
DQoNCi0tLSBhL2xpYi90ZXN0X2thc2FuLmMNCisrKyBiL2xpYi90ZXN0X2thc2FuLmMNCkBAIC0y
ODksNiArMjg5LDcgQEAgc3RhdGljIG5vaW5saW5lIHZvaWQgX19pbml0DQprbWFsbG9jX21lbW1v
dmVfaW52YWxpZF9zaXplKHZvaWQpDQogew0KICAgICAgICBjaGFyICpwdHI7DQogICAgICAgIHNp
emVfdCBzaXplID0gNjQ7DQorICAgICAgIHZvbGF0aWxlIHNpemVfdCBpbnZhbGlkX3NpemUgPSAt
MjsNCg0KICAgICAgICBwcl9pbmZvKCJpbnZhbGlkIHNpemUgaW4gbWVtbW92ZVxuIik7DQogICAg
ICAgIHB0ciA9IGttYWxsb2Moc2l6ZSwgR0ZQX0tFUk5FTCk7DQpAQCAtMjk4LDcgKzI5OSw3IEBA
IHN0YXRpYyBub2lubGluZSB2b2lkIF9faW5pdA0Ka21hbGxvY19tZW1tb3ZlX2ludmFsaWRfc2l6
ZSh2b2lkKQ0KICAgICAgICB9DQoNCiAgICAgICAgbWVtc2V0KChjaGFyICopcHRyLCAwLCA2NCk7
DQotICAgICAgIG1lbW1vdmUoKGNoYXIgKilwdHIsIChjaGFyICopcHRyICsgNCwgLTIpOw0KKyAg
ICAgICBtZW1tb3ZlKChjaGFyICopcHRyLCAoY2hhciAqKXB0ciArIDQsIGludmFsaWRfc2l6ZSk7
DQogICAgICAgIGtmcmVlKHB0cik7DQogfQ0KDQoNCg0KPiA+IFNpZ25lZC1vZmYtYnk6IFFpYW4g
Q2FpIDxjYWlAbGNhLnB3Pg0KPiA+IC0tLQ0KPiA+ICBsaWIvTWFrZWZpbGUgfCAyICsrDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9s
aWIvTWFrZWZpbGUgYi9saWIvTWFrZWZpbGUNCj4gPiBpbmRleCBhYjY4YTg2NzQzNjAuLjI0ZDUx
OWEwNzQxZCAxMDA2NDQNCj4gPiAtLS0gYS9saWIvTWFrZWZpbGUNCj4gPiArKysgYi9saWIvTWFr
ZWZpbGUNCj4gPiBAQCAtMjk3LDYgKzI5Nyw4IEBAIFVCU0FOX1NBTklUSVpFX3Vic2FuLm8gOj0g
bg0KPiA+ICBLQVNBTl9TQU5JVElaRV91YnNhbi5vIDo9IG4NCj4gPiAgS0NTQU5fU0FOSVRJWkVf
dWJzYW4ubyA6PSBuDQo+ID4gIENGTEFHU191YnNhbi5vIDo9ICQoY2FsbCBjYy1vcHRpb24sIC1m
bm8tc3RhY2stcHJvdGVjdG9yKSAkKERJU0FCTEVfU1RBQ0tMRUFLX1BMVUdJTikNCj4gPiArIyBr
bWFsbG9jX21lbW1vdmVfaW52YWxpZF9zaXplKCkgZG9lcyB0aGlzIG9uIHB1cnBvc2UuDQo+ID4g
K0NGTEFHU190ZXN0X2thc2FuLm8gKz0gJChjYWxsIGNjLWRpc2FibGUtd2FybmluZywgYXJyYXkt
Ym91bmRzKQ0KPiA+DQo+ID4gIG9iai0kKENPTkZJR19TQklUTUFQKSArPSBzYml0bWFwLm8NCj4g
Pg0KPiA+IC0tDQo+ID4gMS44LjMuMQ0KPiA+DQo+IA0KPiBBY2tlZC1ieTogRG1pdHJ5IFZ5dWtv
diA8ZHZ5dWtvdkBnb29nbGUuY29tPg0KPiANCj4gVGhhbmtzDQo+IA0KDQo=

