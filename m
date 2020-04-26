Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4627C55199
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 07:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1F5720700
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 07:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgDZHql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 03:46:41 -0400
Received: from smtpbguseast2.qq.com ([54.204.34.130]:58007 "EHLO
        smtpbguseast2.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgDZHqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 03:46:40 -0400
X-QQ-FEAT: gePYKjxTqyJ/NsE3O1A6OX9KhqqAyQbSc83x9J5NMwOtMDAXXVl6vG8WF2U+x
        68+Li2VTrpR1V08RkwWxnN3qVdzxnOHHj52d2CK6neUi6WBcOUEqr2SZoGDoTu7Xbdpf4LW
        1HnkhZ2PpM1y1T9hy9f5fFTwMcG3pMfaMVcku43W2jpk1MD03ZCeiY21PPxDqX5sdG3dCo5
        gIUberI1KfG2x1y+k4T/RP+BkR90niHW6NAWII/te5ccjQkrSKKd09Z+ffhG8WW1ICYBP3D
        HxV76bjO1pqqAI6ZNw6pJ+1XDmpcFbJDeKQg==
X-QQ-SSF: 00000000000000F0000000000000004
X-HAS-ATTACH: no
X-QQ-BUSINESS-ORIGIN: 2
X-Originating-IP: 123.168.109.24
In-Reply-To: <20200426070919.GB2084805@kroah.com>
References: <20200425080343.GA2048673@kroah.com>
 <20200426024436.7534-1-xujialu@vimux.org>
        <20200426070919.GB2084805@kroah.com>
X-QQ-STYLE: 
X-QQ-mid: webmail609t1587887187t209409
From:   "=?ISO-8859-1?B?eHVqaWFsdQ==?=" <xujialu@vimux.org>
To:     "=?ISO-8859-1?B?Z3JlZ2to?=" <gregkh@linuxfoundation.org>
Cc:     "=?ISO-8859-1?B?Y29yYmV0?=" <corbet@lwn.net>,
        "=?ISO-8859-1?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>,
        "=?ISO-8859-1?B?bWFzYWhpcm95?=" <masahiroy@kernel.org>,
        "=?ISO-8859-1?B?YWtwbQ==?=" <akpm@linux-foundation.org>,
        "=?ISO-8859-1?B?bWNoZWhhYitodWF3ZWk=?=" <mchehab+huawei@kernel.org>
Subject: Re: [PATCH] scripts: gtags_files_generator.sh
Mime-Version: 1.0
Content-Type: text/plain;
        charset="ISO-8859-1"
Content-Transfer-Encoding: base64
Date:   Sun, 26 Apr 2020 15:46:26 +0800
X-Priority: 3
Message-ID: <tencent_F9E56441F0B1BE9679BF02B22FA0EE610C0A@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-ReplyHash: 3673160699
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1])
        by smtp.qq.com (ESMTP) with SMTP
        id ; Sun, 26 Apr 2020 15:46:28 +0800 (CST)
Feedback-ID: webmail:vimux.org:bgforeign:bgforeign11
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIGdyZWcNCg0KSSdtIHJlYWxseSBzb3JyeSBmb3IgdGhlIGJhZCByZXBseSBpIGRpZCwg
aSBldmVuIGRvbid0IGtub3cgd2hhdCB3YXMgbXkgZW1haWwgcHJvYmxlbSAuLg0KDQpJIG1l
YW4gaSdtIHZlcnkgbmV3IHRvIGdpdC1zZW5kLWVtYWlsIHJlbGF0ZWQsIHZlcnkgdmVyeSBj
b25mdXNlZCBhYm91dCB0aGUgZW1haWwgcHJvY2Vzc2luZy4uDQoNClBsZWFzZSBoZWxwIG1l
IHVuZGVyc3RhbmRpbmcgd2hlcmUgbXkgcHJvYmxlbSBpcywgSSBhbSB2ZXJ5IHNlcmlvdXMg
aW4gb3JnYW5pemluZyB0aGlzDQoNCnN1Ym1pc3Npb24gcmVsYXRlZCBlbWFpbCwgZXZlbiBl
dmVyeSBzZW50ZW5jZSB3cml0dGVuIGluIHRoZSBlbWFpbC4NCg0KRGlkIGkgZmlsbGVkIHRo
ZSB3cm9uZyBtc2ctaWQgaW4gLS1pbi1yZXBseS10bz8gT3IgaSBzaG91bGQgZGlyZWN0bHkg
YW5zd2VyIHlvdXIgcXVlc3Rpb24gYnkgZm9sbG93aW5nDQoNCmZvcm1hdCwganVzdCBsaWtl
IHlvdXIgcmVwbHk6DQoNCiAgICAgICAgPiBtYWtlIGRlZmNvbmZpZw0KICAgICAgICA+IG1h
a2UNCiAgICAgICAgPiBzY3JpcHRzL2d0YWdzX2ZpbGVzX2dlbmVyYXRvci5zaA0KICAgICAg
ICA+IGd0YWdzIFstZiBndGFncy5maWxlc10NCiAgICAgICAgPg0KICAgICAgICA+IEVuam95
IHdpdGggdmltK2d0YWdzLiA6KQ0KDQogICAgICAgIFdoYXQncyB3cm9uZyB3aXRoIGp1c3Qg
J21ha2UgZ3RhZ3MnIHRoYXQgd2UgY3VycmVudGx5IGhhdmUgaW4gdGhlIGtlcm5lbA0KICAg
ICAgICB0cmVlPyAgU2hvdWxkbid0IHRoYXQgYmUgc3VmZmljaWVudCwgYW5kIGlmIG5vdCwg
dGhlbiB5b3UgbmVlZCB0bw0KICAgICAgICBleHBsYWluIHdoeSBpdCBpc24ndCBpbiB5b3Vy
IGNoYW5nZWxvZy4NCg0KSG93IGRvIHlvdSBhZGQgJz4nIGJlZm9yZSB0aGlzIGxpbmVzLCBh
bGwgYnkgaGFuZHM/DQoNCklmIEkgZGlkIHNvbWV0aGluZyB3cm9uZywgcGxlYXNlIGhlbHAg
bWUgdG8ga25vdyBpdCwgKG9oLCBteSBwb29yIGVuZ2xpc2ggLi4pDQoNClRoYW5rcyEgOigN
Cg0KVGhpcyBlbWFpbCBpcyBub3Qgc2VuZCBieSBnaXQtc2VuZC1lbWFpbC4NCg0KDQotLS0t
LS0tLS0tLS0tLS0tLS0gT3JpZ2luYWwgLS0tLS0tLS0tLS0tLS0tLS0tDQpGcm9tOiAiZ3Jl
Z2toIjxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47DQpEYXRlOiBTdW4sIEFwciAyNiwg
MjAyMCAwMzowOSBQTQ0KVG86ICJ4dWppYWx1Ijx4dWppYWx1QHZpbXV4Lm9yZz47DQpDYzog
ImNvcmJldCI8Y29yYmV0QGx3bi5uZXQ+OyJsaW51eC1rZXJuZWwiPGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc+OyJtYXNhaGlyb3kiPG1hc2FoaXJveUBrZXJuZWwub3JnPjsiYWtw
bSI8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz47Im1jaGVoYWIraHVhd2VpIjxtY2hlaGFi
K2h1YXdlaUBrZXJuZWwub3JnPjsNClN1YmplY3Q6IFJlOiBbUEFUQ0hdIHNjcmlwdHM6IGd0
YWdzX2ZpbGVzX2dlbmVyYXRvci5zaA0KDQoNCg0KT24gU3VuLCBBcHIgMjYsIDIwMjAgYXQg
MTA6NDQ6MzZBTSArMDgwMCwgeHVqaWFsdSB3cm90ZToNCj4gQWRkIGEgc2NyaXB0IHRvIGdl
bmVyYXRlIGEgbW9yZSBwcmVjaXNlIGd0YWdzLmZpbGVzIGZyb20gKi5jbWQgZmlsZXMuDQo+
IA0KPiBGb3IgbmF2aWdhdGluZyBsaW51eCBzb3VyY2VzLCBpdCB3aWxsIGJlIG1vcmUgZWZm
aWNpZW50IGlmIGd0YWdzL2NzY29wZQ0KPiBqdXN0IGNvbGxlY3RzIHNvdXJjZSBmaWxlcyB0
aGF0IG5lZWRlZCBmb3IgY29tcGlsYXRpb24uIFRoZSBrZXJuZWwNCj4gbWFrZWZpbGVzIGFs
cmVhZHkgY3JlYXRlICouY21kIGZpbGVzIHRoYXQgY29udGFpbiB0aGUgZmlsZXMgd2UgbmVl
ZGVkLA0KPiB0aGVuIGp1c3QgZXh0cmFjdHMgZmlsZXMgbGlzdCBmcm9tIHRoZW0gYW5kIGlu
dG8gZ3RhZ3MuZmlsZXMgY2F1c2UgaXQncw0KPiB0aGUgdGhlIGRlZmF1bHQgbmFtZSBsaXN0
IGZpbGUgZm9yIGd0YWdzLg0KPiANCj4gbWFrZSBkZWZjb25maWcNCj4gbWFrZQ0KPiBzY3Jp
cHRzL2d0YWdzX2ZpbGVzX2dlbmVyYXRvci5zaA0KPiBndGFncyBbLWYgZ3RhZ3MuZmlsZXNd
DQo+IA0KPiBFbmpveSB3aXRoIHZpbStndGFncy4gOikNCj4gDQo+IEhlcmUgaXMgYSBsb2cg
Zm9yIGNvbXBhcmlzb24gd2l0aCAnbWFrZSBndGFncyc6DQo+IA0KPiAkIHRpbWUgbWFrZSBB
UkNIPWFybSBjc2NvcGUNCj4gICBHRU4gICAgIGNzY29wZQ0KPiANCj4gcmVhbAkxbTIwLjYw
MHMNCj4gdXNlcgkxbTM2LjAwNHMNCj4gc3lzCTBtOC4xOTJzDQo+ICQgd2MgLWwgY3Njb3Bl
LmZpbGVzDQo+IDMxMjAxIGNzY29wZS5maWxlcwkJI2NvbGxlY3RlZCB0b28gbWFueSBmaWxl
cyB3ZSBkb24ndCBjYXJlDQo+IA0KPiAkIHRpbWUgLi9zY3JpcHRzL2d0YWdzX2ZpbGVzX2dl
bmVyYXRvci5zaA0KPiANCj4gU3VjY2VlZCwgMzcxNiBndGFncy5maWxlcyBsaXN0ZWQhDQo+
IA0KPiByZWFsCTBtMS41OTNzCQkjY29sbGVjdGVkIGZpbGVzIG9ubHkgd2UgY2FyZQ0KPiB1
c2VyCTBtMS43MDRzDQo+IHN5cwkwbTAuMjU2cw0KPiAJCQkJI2NvbGxlY3RlZCBhbHNvIGR0
cyBhbmQgZHRzaQ0KPiAkIGdyZXAgZHRzIGd0YWdzLmZpbGVzDQo+IGFyY2gvYXJtL2Jvb3Qv
ZHRzL3h4eHh4eC1jbG9ja3MuZHRzaQ0KPiBhcmNoL2FybS9ib290L2R0cy94eHh4eHguZHRz
aQ0KPiBhcmNoL2FybS9ib290L2R0cy94eHh4eHh4eC5kdHMNCj4gYXJjaC9hcm0vYm9vdC9k
dHMveHh4eHh4eHguZHRzaQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogeHVqaWFsdSA8eHVqaWFs
dUB2aW11eC5vcmc+DQo+IC0tLQ0KPiAgc2NyaXB0cy9ndGFnc19maWxlc19nZW5lcmF0b3Iu
c2ggfCA0OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNo
YW5nZWQsIDQ4IGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEwMDc1NSBzY3JpcHRz
L2d0YWdzX2ZpbGVzX2dlbmVyYXRvci5zaA0KDQpBcyB0aGlzIGlzIGEgbmV3IHZlcnNpb24s
IHlvdSBuZWVkIHRvIHByb3Blcmx5IHZlcnNpb24geW91ciBwYXRjaCwgYXMgaXMNCmRvY3Vt
ZW50ZWQsIHBsZWFzZSBkbyB0aGF0Lg0KDQpBbHNvLCB5b3Ugc2VlbSB0byBiZSBpZ25vcmlu
ZyBteSBwcmV2aW91cyBxdWVzdGlvbnMvY29tbWVudHMsIHdoaWNoDQptYWtlcyBtZSB3YW50
IHRvIGp1c3QgaWdub3JlIHRoaXMgcGF0Y2ggOigNCg0KZ3JlZyBrLWg=



