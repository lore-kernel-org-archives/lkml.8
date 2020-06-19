Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D881FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A363020776
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YSqcfWE7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbgFSBzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 21:55:11 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:61727 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728414AbgFSBzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 21:55:11 -0400
X-UUID: 36793c47f4934525899c2ced162e9734-20200619
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=eSIoLyaJEFkINxafFPsx03C8ForADV0MP2v7hBefnU4=;
        b=YSqcfWE73wFZ8YSKTFDeIGjJJ1UHFXicZar1Ymvmsd/Xio3KddIHfo8pbZEQ1e1JFCcEe2ix8GIf9q4uiZwmK2qvJ4nHNv3zfqiA6LDxvaluGjFoscorshvJNIShs1IXpEUnGAl3YhgyljfO4kHMkrYXLhqxUYV3Pyw37xpr7bc=;
X-UUID: 36793c47f4934525899c2ced162e9734-20200619
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 485305922; Fri, 19 Jun 2020 09:55:08 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 19 Jun 2020 09:54:58 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 19 Jun 2020 09:55:04 +0800
Message-ID: <1592531704.23014.1.camel@mtkswgap22>
Subject: Re: [PATCH] Fix unwind_frame for clang-built kernels
From:   Miles Chen <miles.chen@mediatek.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
CC:     Nathan Huckleberry <nhuck@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kristof Beyls <Kristof.Beyls@arm.com>
Date:   Fri, 19 Jun 2020 09:55:04 +0800
In-Reply-To: <CAKwvOdkibnsr+z8-pXG1RjOEcrGQ6HQ0=PM-B9p-i85_BKS0cQ@mail.gmail.com>
References: <20200616223633.73971-1-nhuck@google.com>
         <CAKwvOdkibnsr+z8-pXG1RjOEcrGQ6HQ0=PM-B9p-i85_BKS0cQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 7E2F102F10D549D6E1CCFDFA8195D3DEE40C7CE5360F0C642E1E211402486FC02000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA2LTE4IGF0IDEzOjIyIC0wNzAwLCBOaWNrIERlc2F1bG5pZXJzIHdyb3Rl
Og0KPiBPbiBUdWUsIEp1biAxNiwgMjAyMCBhdCAzOjM2IFBNICdOYXRoYW4gSHVja2xlYmVycnkn
IHZpYSBDbGFuZyBCdWlsdA0KPiBMaW51eCA8Y2xhbmctYnVpbHQtbGludXhAZ29vZ2xlZ3JvdXBz
LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBTaW5jZSBjbGFuZyBkb2VzIG5vdCBwdXNoIHBjIGFuZCBz
cCBpbiBmdW5jdGlvbiBwcm9sb2d1ZXMsIHRoZSBjdXJyZW50DQo+ID4gaW1wbGVtZW50YXRpb24g
b2YgdW53aW5kX2ZyYW1lIGRvZXMgbm90IHdvcmsuIEJ5IHVzaW5nIHRoZSBwcmV2aW91cw0KPiA+
IGZyYW1lJ3MgbHIvZnAgaW5zdGVhZCBvZiBzYXZlZCBwYy9zcCB3ZSBnZXQgdmFsaWQgdW53aW5k
cyBvbiBjbGFuZy1idWlsdA0KPiA+IGtlcm5lbHMuDQo+ID4NCj4gPiBUaGUgYm91bmRzIGNoZWNr
IG9uIG5leHQgZnJhbWUgcG9pbnRlciBtdXN0IGJlIGNoYW5nZWQgYXMgd2VsbCBzaW5jZQ0KPiA+
IHRoZXJlIGFyZSA4IGxlc3MgYnl0ZXMgYmV0d2VlbiBmcmFtZXMuDQo+ID4NCj4gPiBUaGlzIGZp
eGVzIC9wcm9jLzxwaWQ+L3N0YWNrLg0KPiA+DQo+ID4gTGluazogaHR0cHM6Ly9naXRodWIuY29t
L0NsYW5nQnVpbHRMaW51eC9saW51eC9pc3N1ZXMvOTEyDQo+ID4gU2lnbmVkLW9mZi1ieTogTmF0
aGFuIEh1Y2tsZWJlcnJ5IDxuaHVja0Bnb29nbGUuY29tPg0KPiANCj4gVGhhbmtzIGZvciB0aGUg
cGF0Y2gsIE5hdGhhbiEgIFdoZW4gSSBsb29rZWQgaW50byB0aGlzLCBJIGZvdW5kIHRoZQ0KPiBs
YXRlc3QgQVJNIEFBUENTIFswXSBzcGVjaWZpY2FsbHkgc2F5cyAod2l0aCBgaXRgIHJlZmVycmlu
ZyB0byBgYQ0KPiBwbGF0Zm9ybWA6ICJJdCBtYXkgcGVybWl0IHRoZSBmcmFtZSBwb2ludGVyIHJl
Z2lzdGVyIHRvIGJlIHVzZWQgYXMgYQ0KPiBnZW5lcmFsLXB1cnBvc2UgY2FsbGVlLXNhdmVkIHJl
Z2lzdGVyLCBidXQgcHJvdmlkZSBhIHBsYXRmb3JtLXNwZWNpZmljDQo+IG1lY2hhbmlzbSBmb3Ig
ZXh0ZXJuYWwgYWdlbnRzIHRvIHJlbGlhYmx5IGxvY2F0ZSB0aGUgY2hhaW4gb2YgZnJhbWUNCj4g
cmVjb3Jkcy4iICAgV2hpbGUgaXQncyBnb29kIHRoYXQncyBhY2tub3dsZWRnZWQgaW4gdGhlIGRv
Y3VtZW50YXRpb24sDQo+IHRoZSBjdXJyZW50IHdvcmRpbmcgaXMgcmVsYXhlZCBpbiBvcmRlciB0
byBub3QgZm9yY2UgY3VycmVudA0KPiBpbXBsZW1lbnRhdGlvbnMgdG8gY29udmVyZ2UuICBUaGlz
IGhhcyB0aGUgdW5mb3J0dW5hdGUgc2lkZSBlZmZlY3Qgb2YNCj4gbWFraW5nIGZpbmRpbmcgdGhl
IGZyYW1lIHBvaW50ZXIgdG9vbGNoYWluIGRlcGVuZGVuZGVudCwgaGVuY2UgdGhpcw0KPiBwYXRj
aCBhbmQgeW91ciBwcmV2aW91cyBjb21taXQgNmRjNWZkOTNiMmYxICgiQVJNOiA4OTAwLzE6DQo+
IFVOV0lOREVSX0ZSQU1FX1BPSU5URVIgaW1wbGVtZW50YXRpb24gZm9yIENsYW5nIikuICBCZWlu
ZyBtb3JlDQo+IHNwZWNpZmljIGluIHRoZSBkb2N1bWVudGF0aW9uIHdvdWxkIGZvcmNlIGF0IGxl
YXN0IG9uZSBpbXBsZW1lbnRhdGlvbg0KPiB0byBjaGFuZ2UsIGFuZCBJIHRoaW5rIHRoYXQgd291
bGQgYWxzbyBpbXBseSBhbiBBQkkgYnJlYWsuICBTbyBJIGNhbg0KPiBzZWUgaXQgYm90aCB3YXlz
LCB0aG91Z2ggSSBzdGlsbCB3b3VsZCBwcmVmZXIgdGhhdCB0aGUgbGFuZ3VhZ2UgcGluDQo+IHRo
aXMgZG93biwgZXZlbiBpZiB3ZSBoYWQgdG8gY2hhbmdlIExMVk0uICBKdXN0IHByb3ZpZGluZyBh
ZGRpdGlvbmFsDQo+IGNvbnRleHQgZm9yIGZvbGtzIG9uIHRoZSB0aHJlYWQuDQo+IA0KPiBUaGlz
IHNob3VsZCBhbHNvIGhhdmUgYSByZXBvcnRlZCBieSB0YWcgZnJvbSBNaWxlcywgaW4gdjIuDQo+
IA0KPiBSZXBvcnRlZC1ieTogTWlsZXMgQ2hlbiA8TWlsZXMuQ2hlbkBtZWRpYXRlay5jb20+DQo+
IA0KPiBNaWxlcyBtZW50aW9uZWQgdG8gbWUgdGhhdCBoZSB0ZXN0ZWQgaXQsIGJ1dCBtYXliZSBN
aWxlcyBjYW4gY29uZmlybQ0KPiB0aGF0IHB1YmxpY2x5IG9uLWxpc3QgdmlhIGFuIGV4cGxpY2l0
IFRlc3RlZC1ieTogdGFnPw0KDQpUaGFua3MgZm9yIHRoZSBwYXRjaC4NCg0KVGVzdGVkLWJ5OiBN
aWxlcyBDaGVuIDxtaWxlcy5jaGVuQG1lZGlhdGVrLmNvbT4NCg0KPiANCj4gVGhpcyB3b3VsZCBi
ZSB1c2VmdWwgZm9yIHVzIHRvIGhhdmUgaW4gc3RhYmxlOyBvdGhlcndpc2Ugd2UnbGwgaGF2ZSB0
bw0KPiBjYXJyeSBvdXQgb2YgdHJlZSBpbiBBbmRyb2lkIGFuZCBDck9TLCB3aGljaCBJJ2QgcmF0
aGVyIG5vdCBkby4gIFZpYQ0KPiBEb2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3RhYmxlLWtlcm5lbC1y
dWxlcy5yc3QsIGlmIHlvdSBhZGQgdGhpcyB0YWcgdG8NCj4gVjIsIHRoYXQgd2lsbCBncmVhdGx5
IHNpbXBsaWZ5IHN1Ym1pdHRpbmcgdGhpcyB0byBzdGFibGU6DQo+IENjOiBzdGFibGVAdmdlci5r
ZXJuZWwub3JnDQo+IA0KPiBNaWxlcyBhbHNvIHNob3dlZCBtZSB0aGUgYmVoYXZpb3Igb2YgdGhp
cyBwYXRjaCBmb3IgZGlmZmVyZW50IGtlcm5lbA0KPiB2ZXJzaW9ucywgd2hpY2ggdmFyaWVzIGFu
eXdoZXJlIGZyb20gZW1wdHkgb3Igc2luZ2xlIGVudHJ5IHRyYWNlcyB0bw0KPiBwYW5pY3MsIHNv
IHRoaXMgaXMgcHJldHR5IGltcG9ydGFudCB0aGF0IHRoaXMgd29ya3MgZm9yIENsYW5nIGJ1aWxk
cy4NCj4gDQo+IFswXSBodHRwczovL3N0YXRpYy5kb2NzLmFybS5jb20vaWhpMDA0Mi9pL2FhcGNz
MzIucGRmDQo+IA0KPiA+IC0tLQ0KPiA+ICBhcmNoL2FybS9rZXJuZWwvc3RhY2t0cmFjZS5jIHwg
MjQgKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyNCBpbnNl
cnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0va2VybmVsL3N0YWNrdHJh
Y2UuYyBiL2FyY2gvYXJtL2tlcm5lbC9zdGFja3RyYWNlLmMNCj4gPiBpbmRleCBjYzcyNmFmZWEw
MjMuLjc2ZWE0MTc4YTU1YyAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybS9rZXJuZWwvc3RhY2t0
cmFjZS5jDQo+ID4gKysrIGIvYXJjaC9hcm0va2VybmVsL3N0YWNrdHJhY2UuYw0KPiA+IEBAIC0y
Miw2ICsyMiwxOSBAQA0KPiA+ICAgKiBBIHNpbXBsZSBmdW5jdGlvbiBlcGlsb2d1ZSBsb29rcyBs
aWtlIHRoaXM6DQo+ID4gICAqICAgICBsZG0gICAgIHNwLCB7ZnAsIHNwLCBwY30NCj4gPiAgICoN
Cj4gPiArICogV2hlbiBjb21waWxlZCB3aXRoIGNsYW5nLCBwYyBhbmQgc3AgYXJlIG5vdCBwdXNo
ZWQuIEEgc2ltcGxlIGZ1bmN0aW9uDQo+ID4gKyAqIHByb2xvZ3VlIGxvb2tzIGxpa2UgdGhpcyB3
aGVuIGJ1aWx0IHdpdGggY2xhbmc6DQo+ID4gKyAqDQo+ID4gKyAqICAgICBzdG1kYiAgIHsuLi4s
IGZwLCBscn0NCj4gPiArICogICAgIGFkZCAgICAgZnAsIHNwLCAjeA0KPiA+ICsgKiAgICAgc3Vi
ICAgICBzcCwgc3AsICN5DQo+ID4gKyAqDQo+ID4gKyAqIEEgc2ltcGxlIGZ1bmN0aW9uIGVwaWxv
Z3VlIGxvb2tzIGxpa2UgdGhpcyB3aGVuIGJ1aWx0IHdpdGggY2xhbmc6DQo+ID4gKyAqDQo+ID4g
KyAqICAgICBzdWIgICAgIHNwLCBmcCwgI3gNCj4gPiArICogICAgIGxkbSAgICAgey4uLiwgZnAs
IHBjfQ0KPiA+ICsgKg0KPiA+ICsgKg0KPiA+ICAgKiBOb3RlIHRoYXQgd2l0aCBmcmFtZXBvaW50
ZXIgZW5hYmxlZCwgZXZlbiB0aGUgbGVhZiBmdW5jdGlvbnMgaGF2ZSB0aGUgc2FtZQ0KPiA+ICAg
KiBwcm9sb2d1ZSBhbmQgZXBpbG9ndWUsIHRoZXJlZm9yZSB3ZSBjYW4gaWdub3JlIHRoZSBMUiB2
YWx1ZSBpbiB0aGlzIGNhc2UuDQo+ID4gICAqLw0KPiA+IEBAIC0zNCw2ICs0NywxNiBAQCBpbnQg
bm90cmFjZSB1bndpbmRfZnJhbWUoc3RydWN0IHN0YWNrZnJhbWUgKmZyYW1lKQ0KPiA+ICAgICAg
ICAgbG93ID0gZnJhbWUtPnNwOw0KPiA+ICAgICAgICAgaGlnaCA9IEFMSUdOKGxvdywgVEhSRUFE
X1NJWkUpOw0KPiA+DQo+ID4gKyNpZmRlZiBDT05GSUdfQ0NfSVNfQ0xBTkcNCj4gPiArICAgICAg
IC8qIGNoZWNrIGN1cnJlbnQgZnJhbWUgcG9pbnRlciBpcyB3aXRoaW4gYm91bmRzICovDQo+ID4g
KyAgICAgICBpZiAoZnAgPCBsb3cgKyA0IHx8IGZwID4gaGlnaCAtIDQpDQo+IA0KPiBUaGUgcGF0
Y2ggTEdUTTsgbWF5YmUgUnVzc2VsbCBvciBDYXRhbGluIGNvdWxkIHRyaXBsZSBjaGVjayB0aGlz
DQo+IGJvdW5kcyBjaGVjaz8gIEFzc3VtaW5nIHRoZXJlJ3Mgbm8gaXNzdWUsIHlvdSBjYW4gaW5j
bHVkZSBvbiBhIHYyIG15DQo+IHJldmlld2VkIGJ5Og0KPiANCj4gUmV2aWV3ZWQtYnk6IE5pY2sg
RGVzYXVsbmllcnMgPG5kZXNhdWxuaWVyc0Bnb29nbGUuY29tPg0KPiANCj4gSSdkIHByb2JhYmx5
IHdhaXQgdGhlIHJlbWFpbmRlciBvZiBhIHdlZWsgYmVmb3JlIHNlbmRpbmcgYSB2MiB0bw0KPiBj
b2xsZWN0IGFkZGl0aW9uYWwgZmVlZGJhY2suICBUaGFuayB5b3UgYWdhaW4uDQo+IA0KPiA+ICsg
ICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiArDQo+ID4gKyAgICAgICBmcmFtZS0+
c3AgPSBmcmFtZS0+ZnA7DQo+ID4gKyAgICAgICBmcmFtZS0+ZnAgPSAqKHVuc2lnbmVkIGxvbmcg
KikoZnApOw0KPiA+ICsgICAgICAgZnJhbWUtPnBjID0gZnJhbWUtPmxyOw0KPiA+ICsgICAgICAg
ZnJhbWUtPmxyID0gKih1bnNpZ25lZCBsb25nICopKGZwICsgNCk7DQo+ID4gKyNlbHNlDQo+ID4g
ICAgICAgICAvKiBjaGVjayBjdXJyZW50IGZyYW1lIHBvaW50ZXIgaXMgd2l0aGluIGJvdW5kcyAq
Lw0KPiA+ICAgICAgICAgaWYgKGZwIDwgbG93ICsgMTIgfHwgZnAgPiBoaWdoIC0gNCkNCj4gPiAg
ICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gQEAgLTQyLDYgKzY1LDcgQEAgaW50
IG5vdHJhY2UgdW53aW5kX2ZyYW1lKHN0cnVjdCBzdGFja2ZyYW1lICpmcmFtZSkNCj4gPiAgICAg
ICAgIGZyYW1lLT5mcCA9ICoodW5zaWduZWQgbG9uZyAqKShmcCAtIDEyKTsNCj4gPiAgICAgICAg
IGZyYW1lLT5zcCA9ICoodW5zaWduZWQgbG9uZyAqKShmcCAtIDgpOw0KPiA+ICAgICAgICAgZnJh
bWUtPnBjID0gKih1bnNpZ25lZCBsb25nICopKGZwIC0gNCk7DQo+ID4gKyNlbmRpZg0KPiA+DQo+
ID4gICAgICAgICByZXR1cm4gMDsNCj4gPiAgfQ0KPiA+IC0tDQo+ID4gMi4yNy4wLjI5MC5nYmE2
NTNjNjJkYS1nb29nDQo+ID4NCj4gPiAtLQ0KPiANCg0K

