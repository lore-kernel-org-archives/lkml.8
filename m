Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22A5C2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 06:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C4320838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 06:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HdO234FF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgBGG3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 01:29:09 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:61291 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726417AbgBGG3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 01:29:09 -0500
X-UUID: 8bbd85f1ab1647128adf2e7a48c741a2-20200207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=R/+a0fdrCDE55+6NHJbY91tgYCmhdw3+sIz81IyvB4g=;
        b=HdO234FFanK4JzHsBHdy4uzl3Z8p1rFOlSX1F+VDNMRB1dSz1IocidIrm3rh5jb2VoyL2xumRm4MUL6mkuGZ813LHDa6QE2Q7YzHG3UGKQCHDTTfsUWa+ywO3VxCKyJqW8EkwDjKbj76EWU3SwA8xUq2AguMLnvtixKRv4B9ecY=;
X-UUID: 8bbd85f1ab1647128adf2e7a48c741a2-20200207
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <frankie.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1799503453; Fri, 07 Feb 2020 14:29:01 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 7 Feb 2020 14:28:19 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 7 Feb 2020 14:28:24 +0800
Message-ID: <1581056939.22229.55.camel@mtkswgap22>
Subject: Re: [PATCH v1 1/1] binder: transaction latency tracking for user
 build
From:   Frankie Chang <Frankie.Chang@mediatek.com>
To:     Joel Fernandes <joel@joelfernandes.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        "Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?=" <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        <Jian-Min.Liu@mediatek.com>
Date:   Fri, 7 Feb 2020 14:28:59 +0800
In-Reply-To: <20200207031759.GA121785@google.com>
References: <1580885572-14272-1-git-send-email-Frankie.Chang@mediatek.com>
         <20200205093612.GA1167956@kroah.com> <20200205154943.GE142103@google.com>
         <1581045023.22229.46.camel@mtkswgap22> <20200207031759.GA121785@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTAyLTA2IGF0IDIyOjE3IC0wNTAwLCBKb2VsIEZlcm5hbmRlcyB3cm90ZToN
Cj4gT24gRnJpLCBGZWIgMDcsIDIwMjAgYXQgMTE6MTA6MjNBTSArMDgwMCwgRnJhbmtpZSBDaGFu
ZyB3cm90ZToNCj4gPiBPbiBXZWQsIDIwMjAtMDItMDUgYXQgMTA6NDkgLTA1MDAsIEpvZWwgRmVy
bmFuZGVzIHdyb3RlOg0KPiA+ID4gT24gV2VkLCBGZWIgMDUsIDIwMjAgYXQgMDk6MzY6MTJBTSAr
MDAwMCwgR3JlZyBLcm9haC1IYXJ0bWFuIHdyb3RlOg0KPiA+ID4gPiBPbiBXZWQsIEZlYiAwNSwg
MjAyMCBhdCAwMjo1Mjo1MlBNICswODAwLCBGcmFua2llIENoYW5nIHdyb3RlOg0KPiA+ID4gPiA+
IFJlY29yZCBzdGFydC9lbmQgdGltZXN0YW1wIHRvIGJpbmRlciB0cmFuc2FjdGlvbi4NCj4gPiA+
ID4gPiBXaGVuIHRyYW5zYWN0aW9uIGlzIGNvbXBsZXRlZCBvciB0cmFuc2FjdGlvbiBpcyBmcmVl
LA0KPiA+ID4gPiA+IGl0IHdvdWxkIGJlIGNoZWNrZWQgaWYgdHJhbnNhY3Rpb24gbGF0ZW5jeSBv
dmVyIHRocmVzaG9sZCAoMiBzZWMpLA0KPiA+ID4gPiA+IGlmIHllcywgcHJpbnRpbmcgcmVsYXRl
ZCBpbmZvcm1hdGlvbiBmb3IgdHJhY2luZy4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBGcmFua2llIENoYW5nIDxGcmFua2llLkNoYW5nQG1lZGlhdGVrLmNvbT4NCj4gPiA+
ID4gPiAtLS0NCj4gPiA+ID4gPiAgZHJpdmVycy9hbmRyb2lkL0tjb25maWcgICAgICAgICAgIHwg
ICAgOCArKysNCj4gPiA+ID4gPiAgZHJpdmVycy9hbmRyb2lkL2JpbmRlci5jICAgICAgICAgIHwg
IDEwNyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+ID4gIGRy
aXZlcnMvYW5kcm9pZC9iaW5kZXJfaW50ZXJuYWwuaCB8ICAgIDQgKysNCj4gPiA+ID4gPiAgMyBm
aWxlcyBjaGFuZ2VkLCAxMTkgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2FuZHJvaWQvS2NvbmZpZyBiL2RyaXZlcnMvYW5kcm9pZC9LY29u
ZmlnDQo+ID4gPiA+ID4gaW5kZXggNmZkZjJhYi4uN2JhODBlYiAxMDA2NDQNCj4gPiA+ID4gPiAt
LS0gYS9kcml2ZXJzL2FuZHJvaWQvS2NvbmZpZw0KPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvYW5k
cm9pZC9LY29uZmlnDQo+ID4gPiA+ID4gQEAgLTU0LDYgKzU0LDE0IEBAIGNvbmZpZyBBTkRST0lE
X0JJTkRFUl9JUENfU0VMRlRFU1QNCj4gPiA+ID4gPiAgCSAgZXhoYXVzdGl2ZWx5IHdpdGggY29t
YmluYXRpb25zIG9mIHZhcmlvdXMgYnVmZmVyIHNpemVzIGFuZA0KPiA+ID4gPiA+ICAJICBhbGln
bm1lbnRzLg0KPiA+ID4gPiA+ICANCj4gPiA+ID4gPiArY29uZmlnIEJJTkRFUl9VU0VSX1RSQUNL
SU5HDQo+ID4gPiA+ID4gKwlib29sICJBbmRyb2lkIEJpbmRlciB0cmFuc2FjdGlvbiB0cmFja2lu
ZyINCj4gPiA+ID4gPiArCWhlbHANCj4gPiA+ID4gPiArCSAgVXNlZCBmb3IgdHJhY2sgYWJub3Jt
YWwgYmluZGVyIHRyYW5zYWN0aW9uIHdoaWNoIGlzIG92ZXIgMiBzZWNvbmRzLA0KPiA+ID4gPiA+
ICsJICB3aGVuIHRoZSB0cmFuc2FjdGlvbiBpcyBkb25lIG9yIGJlIGZyZWUsIHRoaXMgdHJhbnNh
Y3Rpb24gd291bGQgYmUNCj4gPiA+ID4gPiArCSAgY2hlY2tlZCB3aGV0aGVyIGl0IGV4ZWN1dGVk
IG92ZXJ0aW1lLg0KPiA+ID4gPiA+ICsJICBJZiB5ZXMsIHByaW50aW5nIG91dCB0aGUgZGV0YWls
IGluZm8gYWJvdXQgaXQuDQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICBlbmRpZiAjIGlmIEFORFJP
SUQNCj4gPiA+ID4gPiAgDQo+ID4gPiA+ID4gIGVuZG1lbnUNCj4gPiA+ID4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9hbmRyb2lkL2JpbmRlci5jIGIvZHJpdmVycy9hbmRyb2lkL2JpbmRlci5jDQo+
ID4gPiA+ID4gaW5kZXggZTliYzlmYy4uNWEzNTJlZSAxMDA2NDQNCj4gPiA+ID4gPiAtLS0gYS9k
cml2ZXJzL2FuZHJvaWQvYmluZGVyLmMNCj4gPiA+ID4gPiArKysgYi9kcml2ZXJzL2FuZHJvaWQv
YmluZGVyLmMNCj4gPiA+ID4gPiBAQCAtNzYsNiArNzYsMTEgQEANCj4gPiA+ID4gPiAgI2luY2x1
ZGUgImJpbmRlcl9pbnRlcm5hbC5oIg0KPiA+ID4gPiA+ICAjaW5jbHVkZSAiYmluZGVyX3RyYWNl
LmgiDQo+ID4gPiA+ID4gIA0KPiA+ID4gPiA+ICsjaWZkZWYgQ09ORklHX0JJTkRFUl9VU0VSX1RS
QUNLSU5HDQo+ID4gPiA+ID4gKyNpbmNsdWRlIDxsaW51eC9ydGMuaD4NCj4gPiA+ID4gPiArI2lu
Y2x1ZGUgPGxpbnV4L3RpbWUuaD4NCj4gPiA+ID4gPiArI2VuZGlmDQo+ID4gPiA+ID4gKw0KPiA+
ID4gPiA+ICBzdGF0aWMgSExJU1RfSEVBRChiaW5kZXJfZGVmZXJyZWRfbGlzdCk7DQo+ID4gPiA+
ID4gIHN0YXRpYyBERUZJTkVfTVVURVgoYmluZGVyX2RlZmVycmVkX2xvY2spOw0KPiA+ID4gPiA+
ICANCj4gPiA+ID4gPiBAQCAtNTkxLDggKzU5NiwxMDQgQEAgc3RydWN0IGJpbmRlcl90cmFuc2Fj
dGlvbiB7DQo+ID4gPiA+ID4gIAkgKiBkdXJpbmcgdGhyZWFkIHRlYXJkb3duDQo+ID4gPiA+ID4g
IAkgKi8NCj4gPiA+ID4gPiAgCXNwaW5sb2NrX3QgbG9jazsNCj4gPiA+ID4gPiArI2lmZGVmIENP
TkZJR19CSU5ERVJfVVNFUl9UUkFDS0lORw0KPiA+ID4gPiA+ICsJc3RydWN0IHRpbWVzcGVjIHRp
bWVzdGFtcDsNCj4gPiA+ID4gPiArCXN0cnVjdCB0aW1ldmFsIHR2Ow0KPiA+ID4gPiA+ICsjZW5k
aWYNCj4gPiA+ID4gPiAgfTsNCj4gPiA+ID4gPiAgDQo+ID4gPiA+ID4gKyNpZmRlZiBDT05GSUdf
QklOREVSX1VTRVJfVFJBQ0tJTkcNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKy8qDQo+ID4gPiA+
ID4gKyAqIGJpbmRlcl9wcmludF9kZWxheSAtIE91dHB1dCBpbmZvIG9mIGEgZGVsYXkgdHJhbnNh
Y3Rpb24NCj4gPiA+ID4gPiArICogQHQ6ICAgICAgICAgIHBvaW50ZXIgdG8gdGhlIG92ZXItdGlt
ZSB0cmFuc2FjdGlvbg0KPiA+ID4gPiA+ICsgKi8NCj4gPiA+ID4gPiArc3RhdGljIHZvaWQgYmlu
ZGVyX3ByaW50X2RlbGF5KHN0cnVjdCBiaW5kZXJfdHJhbnNhY3Rpb24gKnQpDQo+ID4gPiA+ID4g
K3sNCj4gPiA+ID4gPiArCXN0cnVjdCBydGNfdGltZSB0bTsNCj4gPiA+ID4gPiArCXN0cnVjdCB0
aW1lc3BlYyAqc3RhcnRpbWU7DQo+ID4gPiA+ID4gKwlzdHJ1Y3QgdGltZXNwZWMgY3VyLCBzdWJf
dDsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKwlrdGltZV9nZXRfdHMoJmN1cik7DQo+ID4gPiA+
ID4gKwlzdGFydGltZSA9ICZ0LT50aW1lc3RhbXA7DQo+ID4gPiA+ID4gKwlzdWJfdCA9IHRpbWVz
cGVjX3N1YihjdXIsICpzdGFydGltZSk7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsJLyogaWYg
dHJhbnNhY3Rpb24gdGltZSBpcyBvdmVyIHRoYW4gMiBzZWMsDQo+ID4gPiA+ID4gKwkgKiBzaG93
IHRpbWVvdXQgd2FybmluZyBsb2cuDQo+ID4gPiA+ID4gKwkgKi8NCj4gPiA+ID4gPiArCWlmIChz
dWJfdC50dl9zZWMgPCAyKQ0KPiA+ID4gPiA+ICsJCXJldHVybjsNCj4gPiA+ID4gPiArDQo+ID4g
PiA+ID4gKwlydGNfdGltZV90b190bSh0LT50di50dl9zZWMsICZ0bSk7DQo+ID4gPiA+ID4gKw0K
PiA+ID4gPiA+ICsJc3Bpbl9sb2NrKCZ0LT5sb2NrKTsNCj4gPiA+ID4gPiArCXByX2luZm9fcmF0
ZWxpbWl0ZWQoIiVkOiBmcm9tICVkOiVkIHRvICVkOiVkIiwNCj4gPiA+ID4gPiArCQkJICAgIHQt
PmRlYnVnX2lkLA0KPiA+ID4gPiA+ICsJCQkgICAgdC0+ZnJvbSA/IHQtPmZyb20tPnByb2MtPnBp
ZCA6IDAsDQo+ID4gPiA+ID4gKwkJCSAgICB0LT5mcm9tID8gdC0+ZnJvbS0+cGlkIDogMCwNCj4g
PiA+ID4gPiArCQkJICAgIHQtPnRvX3Byb2MgPyB0LT50b19wcm9jLT5waWQgOiAwLA0KPiA+ID4g
PiA+ICsJCQkgICAgdC0+dG9fdGhyZWFkID8gdC0+dG9fdGhyZWFkLT5waWQgOiAwKTsNCj4gPiA+
ID4gPiArCXNwaW5fdW5sb2NrKCZ0LT5sb2NrKTsNCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKwlw
cl9pbmZvX3JhdGVsaW1pdGVkKCIgdG90YWwgJXUuJTAzbGQgcyBjb2RlICV1IHN0YXJ0ICVsdS4l
MDNsZCBhbmRyb2lkICVkLSUwMmQtJTAyZCAlMDJkOiUwMmQ6JTAyZC4lMDNsdVxuIiwNCj4gPiA+
ID4gPiArCQkJICAgICh1bnNpZ25lZCBpbnQpc3ViX3QudHZfc2VjLA0KPiA+ID4gPiA+ICsJCQkg
ICAgKHN1Yl90LnR2X25zZWMgLyBOU0VDX1BFUl9NU0VDKSwNCj4gPiA+ID4gPiArCQkJICAgIHQt
PmNvZGUsDQo+ID4gPiA+ID4gKwkJCSAgICAodW5zaWduZWQgbG9uZylzdGFydGltZS0+dHZfc2Vj
LA0KPiA+ID4gPiA+ICsJCQkgICAgKHN0YXJ0aW1lLT50dl9uc2VjIC8gTlNFQ19QRVJfTVNFQyks
DQo+ID4gPiA+ID4gKwkJCSAgICAodG0udG1feWVhciArIDE5MDApLCAodG0udG1fbW9uICsgMSks
IHRtLnRtX21kYXksDQo+ID4gPiA+ID4gKwkJCSAgICB0bS50bV9ob3VyLCB0bS50bV9taW4sIHRt
LnRtX3NlYywNCj4gPiA+ID4gPiArCQkJICAgICh1bnNpZ25lZCBsb25nKSh0LT50di50dl91c2Vj
IC8gVVNFQ19QRVJfTVNFQykpOw0KPiA+ID4gPiA+ICt9DQo+ID4gPiA+IA0KPiA+ID4gPiBJY2ss
IHdoeSBub3QgdXNlIGEgdHJhY2Vwb2ludCBmb3IgdGhpcyBpbnN0ZWFkPw0KPiA+ID4gPiANCj4g
PiA+ID4gQW5kIHdoYXQgaXMgdXNlcnNwYWNlIHN1cHBvc2VkIHRvIGRvIHdpdGggdGhpcyBpZiB0
aGV5IHNlZSBpdD8NCj4gPiA+IA0KPiA+ID4gT3IgYW5vdGhlciBvcHRpb24gaXMgdG8gaW1wbGVt
ZW50IHRoaXMgc2VwYXJhdGVseSBvdXRzaWRlIG9mIGJpbmRlci5jIHVzaW5nDQo+ID4gPiByZWdp
c3Rlcl90cmFjZV8qIG9uIHRoZSBleGlzdGluZyBiaW5kZXIgdHJhY2Vwb2ludHMsIHNpbWlsYXIg
dG8gd2hhdCBzYXkgdGhlDQo+ID4gPiBibG9jayB0cmFjZXIgb3IgcHJlZW1wdC1vZmYgdHJhY2Vy
cyBkby4gQ2FsbCBpdCwgc2F5LCAiYmluZGVyLWxhdGVuY3kgdHJhY2VyIi4NCj4gPiA+IA0KPiA+
ID4gVGhhdCB3YXkgYWxsIG9mIHRoaXMgdHJhY2luZyBjb2RlIGlzIGluLWtlcm5lbCBidXQgb3V0
c2lkZSBvZiBiaW5kZXIuYy4NCj4gPiA+IA0KPiA+ID4gdGhhbmtzLA0KPiA+ID4gDQo+ID4gPiAg
LSBKb2VsDQo+ID4gPiANCj4gPiBUaW1lIGxpbWl0YXRpb24gb2YgcmVjb3JkaW5nIGlzIHRoZSBy
ZWFzb24gd2h5IHdlIGRvbid0IHVzZSB0cmFjZXBvaW50Lg0KPiA+IEluIHNvbWUgc2l0dWF0aW9u
cywgdGhlIGV4Y2VwdGlvbiBpcyBjYXVzZWQgYnkgYSBzZXJpZXMgb2YgdHJhbnNhY3Rpb25zDQo+
ID4gaW50ZXJhY3Rpb24uDQo+ID4gU29tZSBhYm5vcm1hbCB0cmFuc2FjdGlvbnMgbWF5IGJlIHBl
bmRpbmcgZm9yIGEgbG9uZyB0aW1lIGFnbywgdGhleQ0KPiA+IGNvdWxkIG5vdCBiZSByZWNvcmRl
ZCBkdWUgdG8gYnVmZmVyIGxpbWl0ZWQuDQo+IA0KPiByZWdpc3Rlcl90cmFjZV8qIGRvZXMgbm90
IHVzZSB0aGUgdHJhY2UgYnVmZmVyIHNvIEkgYW0gbm90IHN1cmUgd2hhdCB5b3UNCj4gbWVhbi4g
SSBhbSBhc2tpbmcgeW91IHRvIHVzZSB0cmFjZXBvaW50cywgbm90IGZ0cmFjZSBldmVudHMuDQo+
IA0KPiB0aGFua3MsDQo+IA0KPiAgLSBKb2VsDQo+IA0KVGhlIGV4aXN0aW5nIGJpbmRlciB0cmFj
ZXBvaW50IG1heSBub3QgYmUgcHJlY2lzZSBlbm91Z2ggYmVjYXVzZSB0aGVyZQ0KaXMgbm8gcHJv
cGVyIHRyYWNlcG9pbnQgd2hpY2ggY2FuIHJlcHJlc2VudCB0aGUgcmVhbCBmaW5pc2hlZCB0aW1l
IG9mDQp0cmFuc2FjdGlvbi4NCg0KVGhlIHJlYXNvbiB3aHkgd2UgZG9uJ3QgcHV0IHRoZSBjb2Rl
IG91dHNpZGUgYmluZGVyLmMgaXMgdGhhdCBzdHJ1Y3R1cmUNCm9mIGJpbmRlcl90cmFuc2FjdGlv
biBkaWRuJ3QgcHV0IGluIGhlYWRlciBmaWxlLg0KSWYgaXQgY291bGQgYmUgbW92ZWQgdG8gYmlu
ZGVyX2ludGVybmFsLmgsIHRoZW4gd2UgY2FuIGFkZA0KImJpbmRlci1sYXRlbmN5IHRyYWNlciIg
YXMgeW91IG1lbnRpb25lZCBlYXJsaWVyLg0K

