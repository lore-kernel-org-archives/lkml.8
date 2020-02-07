Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FACC35247
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 03:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A3221D7D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 03:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Xz7tBGi3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgBGDKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 22:10:32 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:29246 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726509AbgBGDKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 22:10:32 -0500
X-UUID: c782487949f44d5cae00623e8948f311-20200207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=AVUNJMoThA1dscpdVLSgtsytpPvPRpIt9//axxaCTQs=;
        b=Xz7tBGi3B9tdvV71NDwtLWhHln72HJhRrGomtyVDbrMCbg55XqOyfluOL7g6kbj850VX5HbkmiScI98y76nJhvXgZlvQt+dtohsD7m61vGMjbtZV4ijH9aovXaVNQki9GIyRR8sEJ7YcmfsQU5MTvIeByzt3wzh/4EY5tAEZmDY=;
X-UUID: c782487949f44d5cae00623e8948f311-20200207
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <frankie.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 209294105; Fri, 07 Feb 2020 11:10:24 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 7 Feb 2020 11:09:37 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 7 Feb 2020 11:09:48 +0800
Message-ID: <1581045023.22229.46.camel@mtkswgap22>
Subject: Re: [PATCH v1 1/1] binder: transaction latency tracking for user
 build
From:   Frankie Chang <Frankie.Chang@mediatek.com>
To:     Joel Fernandes <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
        "Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?=" <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        <Jian-Min.Liu@mediatek.com>
Date:   Fri, 7 Feb 2020 11:10:23 +0800
In-Reply-To: <20200205154943.GE142103@google.com>
References: <1580885572-14272-1-git-send-email-Frankie.Chang@mediatek.com>
         <20200205093612.GA1167956@kroah.com> <20200205154943.GE142103@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTAyLTA1IGF0IDEwOjQ5IC0wNTAwLCBKb2VsIEZlcm5hbmRlcyB3cm90ZToN
Cj4gT24gV2VkLCBGZWIgMDUsIDIwMjAgYXQgMDk6MzY6MTJBTSArMDAwMCwgR3JlZyBLcm9haC1I
YXJ0bWFuIHdyb3RlOg0KPiA+IE9uIFdlZCwgRmViIDA1LCAyMDIwIGF0IDAyOjUyOjUyUE0gKzA4
MDAsIEZyYW5raWUgQ2hhbmcgd3JvdGU6DQo+ID4gPiBSZWNvcmQgc3RhcnQvZW5kIHRpbWVzdGFt
cCB0byBiaW5kZXIgdHJhbnNhY3Rpb24uDQo+ID4gPiBXaGVuIHRyYW5zYWN0aW9uIGlzIGNvbXBs
ZXRlZCBvciB0cmFuc2FjdGlvbiBpcyBmcmVlLA0KPiA+ID4gaXQgd291bGQgYmUgY2hlY2tlZCBp
ZiB0cmFuc2FjdGlvbiBsYXRlbmN5IG92ZXIgdGhyZXNob2xkICgyIHNlYyksDQo+ID4gPiBpZiB5
ZXMsIHByaW50aW5nIHJlbGF0ZWQgaW5mb3JtYXRpb24gZm9yIHRyYWNpbmcuDQo+ID4gPiANCj4g
PiA+IFNpZ25lZC1vZmYtYnk6IEZyYW5raWUgQ2hhbmcgPEZyYW5raWUuQ2hhbmdAbWVkaWF0ZWsu
Y29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9hbmRyb2lkL0tjb25maWcgICAgICAgICAg
IHwgICAgOCArKysNCj4gPiA+ICBkcml2ZXJzL2FuZHJvaWQvYmluZGVyLmMgICAgICAgICAgfCAg
MTA3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ICBkcml2ZXJz
L2FuZHJvaWQvYmluZGVyX2ludGVybmFsLmggfCAgICA0ICsrDQo+ID4gPiAgMyBmaWxlcyBjaGFu
Z2VkLCAxMTkgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9hbmRyb2lkL0tjb25maWcgYi9kcml2ZXJzL2FuZHJvaWQvS2NvbmZpZw0KPiA+ID4gaW5kZXgg
NmZkZjJhYi4uN2JhODBlYiAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvYW5kcm9pZC9LY29u
ZmlnDQo+ID4gPiArKysgYi9kcml2ZXJzL2FuZHJvaWQvS2NvbmZpZw0KPiA+ID4gQEAgLTU0LDYg
KzU0LDE0IEBAIGNvbmZpZyBBTkRST0lEX0JJTkRFUl9JUENfU0VMRlRFU1QNCj4gPiA+ICAJICBl
eGhhdXN0aXZlbHkgd2l0aCBjb21iaW5hdGlvbnMgb2YgdmFyaW91cyBidWZmZXIgc2l6ZXMgYW5k
DQo+ID4gPiAgCSAgYWxpZ25tZW50cy4NCj4gPiA+ICANCj4gPiA+ICtjb25maWcgQklOREVSX1VT
RVJfVFJBQ0tJTkcNCj4gPiA+ICsJYm9vbCAiQW5kcm9pZCBCaW5kZXIgdHJhbnNhY3Rpb24gdHJh
Y2tpbmciDQo+ID4gPiArCWhlbHANCj4gPiA+ICsJICBVc2VkIGZvciB0cmFjayBhYm5vcm1hbCBi
aW5kZXIgdHJhbnNhY3Rpb24gd2hpY2ggaXMgb3ZlciAyIHNlY29uZHMsDQo+ID4gPiArCSAgd2hl
biB0aGUgdHJhbnNhY3Rpb24gaXMgZG9uZSBvciBiZSBmcmVlLCB0aGlzIHRyYW5zYWN0aW9uIHdv
dWxkIGJlDQo+ID4gPiArCSAgY2hlY2tlZCB3aGV0aGVyIGl0IGV4ZWN1dGVkIG92ZXJ0aW1lLg0K
PiA+ID4gKwkgIElmIHllcywgcHJpbnRpbmcgb3V0IHRoZSBkZXRhaWwgaW5mbyBhYm91dCBpdC4N
Cj4gPiA+ICsNCj4gPiA+ICBlbmRpZiAjIGlmIEFORFJPSUQNCj4gPiA+ICANCj4gPiA+ICBlbmRt
ZW51DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hbmRyb2lkL2JpbmRlci5jIGIvZHJpdmVy
cy9hbmRyb2lkL2JpbmRlci5jDQo+ID4gPiBpbmRleCBlOWJjOWZjLi41YTM1MmVlIDEwMDY0NA0K
PiA+ID4gLS0tIGEvZHJpdmVycy9hbmRyb2lkL2JpbmRlci5jDQo+ID4gPiArKysgYi9kcml2ZXJz
L2FuZHJvaWQvYmluZGVyLmMNCj4gPiA+IEBAIC03Niw2ICs3NiwxMSBAQA0KPiA+ID4gICNpbmNs
dWRlICJiaW5kZXJfaW50ZXJuYWwuaCINCj4gPiA+ICAjaW5jbHVkZSAiYmluZGVyX3RyYWNlLmgi
DQo+ID4gPiAgDQo+ID4gPiArI2lmZGVmIENPTkZJR19CSU5ERVJfVVNFUl9UUkFDS0lORw0KPiA+
ID4gKyNpbmNsdWRlIDxsaW51eC9ydGMuaD4NCj4gPiA+ICsjaW5jbHVkZSA8bGludXgvdGltZS5o
Pg0KPiA+ID4gKyNlbmRpZg0KPiA+ID4gKw0KPiA+ID4gIHN0YXRpYyBITElTVF9IRUFEKGJpbmRl
cl9kZWZlcnJlZF9saXN0KTsNCj4gPiA+ICBzdGF0aWMgREVGSU5FX01VVEVYKGJpbmRlcl9kZWZl
cnJlZF9sb2NrKTsNCj4gPiA+ICANCj4gPiA+IEBAIC01OTEsOCArNTk2LDEwNCBAQCBzdHJ1Y3Qg
YmluZGVyX3RyYW5zYWN0aW9uIHsNCj4gPiA+ICAJICogZHVyaW5nIHRocmVhZCB0ZWFyZG93bg0K
PiA+ID4gIAkgKi8NCj4gPiA+ICAJc3BpbmxvY2tfdCBsb2NrOw0KPiA+ID4gKyNpZmRlZiBDT05G
SUdfQklOREVSX1VTRVJfVFJBQ0tJTkcNCj4gPiA+ICsJc3RydWN0IHRpbWVzcGVjIHRpbWVzdGFt
cDsNCj4gPiA+ICsJc3RydWN0IHRpbWV2YWwgdHY7DQo+ID4gPiArI2VuZGlmDQo+ID4gPiAgfTsN
Cj4gPiA+ICANCj4gPiA+ICsjaWZkZWYgQ09ORklHX0JJTkRFUl9VU0VSX1RSQUNLSU5HDQo+ID4g
PiArDQo+ID4gPiArLyoNCj4gPiA+ICsgKiBiaW5kZXJfcHJpbnRfZGVsYXkgLSBPdXRwdXQgaW5m
byBvZiBhIGRlbGF5IHRyYW5zYWN0aW9uDQo+ID4gPiArICogQHQ6ICAgICAgICAgIHBvaW50ZXIg
dG8gdGhlIG92ZXItdGltZSB0cmFuc2FjdGlvbg0KPiA+ID4gKyAqLw0KPiA+ID4gK3N0YXRpYyB2
b2lkIGJpbmRlcl9wcmludF9kZWxheShzdHJ1Y3QgYmluZGVyX3RyYW5zYWN0aW9uICp0KQ0KPiA+
ID4gK3sNCj4gPiA+ICsJc3RydWN0IHJ0Y190aW1lIHRtOw0KPiA+ID4gKwlzdHJ1Y3QgdGltZXNw
ZWMgKnN0YXJ0aW1lOw0KPiA+ID4gKwlzdHJ1Y3QgdGltZXNwZWMgY3VyLCBzdWJfdDsNCj4gPiA+
ICsNCj4gPiA+ICsJa3RpbWVfZ2V0X3RzKCZjdXIpOw0KPiA+ID4gKwlzdGFydGltZSA9ICZ0LT50
aW1lc3RhbXA7DQo+ID4gPiArCXN1Yl90ID0gdGltZXNwZWNfc3ViKGN1ciwgKnN0YXJ0aW1lKTsN
Cj4gPiA+ICsNCj4gPiA+ICsJLyogaWYgdHJhbnNhY3Rpb24gdGltZSBpcyBvdmVyIHRoYW4gMiBz
ZWMsDQo+ID4gPiArCSAqIHNob3cgdGltZW91dCB3YXJuaW5nIGxvZy4NCj4gPiA+ICsJICovDQo+
ID4gPiArCWlmIChzdWJfdC50dl9zZWMgPCAyKQ0KPiA+ID4gKwkJcmV0dXJuOw0KPiA+ID4gKw0K
PiA+ID4gKwlydGNfdGltZV90b190bSh0LT50di50dl9zZWMsICZ0bSk7DQo+ID4gPiArDQo+ID4g
PiArCXNwaW5fbG9jaygmdC0+bG9jayk7DQo+ID4gPiArCXByX2luZm9fcmF0ZWxpbWl0ZWQoIiVk
OiBmcm9tICVkOiVkIHRvICVkOiVkIiwNCj4gPiA+ICsJCQkgICAgdC0+ZGVidWdfaWQsDQo+ID4g
PiArCQkJICAgIHQtPmZyb20gPyB0LT5mcm9tLT5wcm9jLT5waWQgOiAwLA0KPiA+ID4gKwkJCSAg
ICB0LT5mcm9tID8gdC0+ZnJvbS0+cGlkIDogMCwNCj4gPiA+ICsJCQkgICAgdC0+dG9fcHJvYyA/
IHQtPnRvX3Byb2MtPnBpZCA6IDAsDQo+ID4gPiArCQkJICAgIHQtPnRvX3RocmVhZCA/IHQtPnRv
X3RocmVhZC0+cGlkIDogMCk7DQo+ID4gPiArCXNwaW5fdW5sb2NrKCZ0LT5sb2NrKTsNCj4gPiA+
ICsNCj4gPiA+ICsJcHJfaW5mb19yYXRlbGltaXRlZCgiIHRvdGFsICV1LiUwM2xkIHMgY29kZSAl
dSBzdGFydCAlbHUuJTAzbGQgYW5kcm9pZCAlZC0lMDJkLSUwMmQgJTAyZDolMDJkOiUwMmQuJTAz
bHVcbiIsDQo+ID4gPiArCQkJICAgICh1bnNpZ25lZCBpbnQpc3ViX3QudHZfc2VjLA0KPiA+ID4g
KwkJCSAgICAoc3ViX3QudHZfbnNlYyAvIE5TRUNfUEVSX01TRUMpLA0KPiA+ID4gKwkJCSAgICB0
LT5jb2RlLA0KPiA+ID4gKwkJCSAgICAodW5zaWduZWQgbG9uZylzdGFydGltZS0+dHZfc2VjLA0K
PiA+ID4gKwkJCSAgICAoc3RhcnRpbWUtPnR2X25zZWMgLyBOU0VDX1BFUl9NU0VDKSwNCj4gPiA+
ICsJCQkgICAgKHRtLnRtX3llYXIgKyAxOTAwKSwgKHRtLnRtX21vbiArIDEpLCB0bS50bV9tZGF5
LA0KPiA+ID4gKwkJCSAgICB0bS50bV9ob3VyLCB0bS50bV9taW4sIHRtLnRtX3NlYywNCj4gPiA+
ICsJCQkgICAgKHVuc2lnbmVkIGxvbmcpKHQtPnR2LnR2X3VzZWMgLyBVU0VDX1BFUl9NU0VDKSk7
DQo+ID4gPiArfQ0KPiA+IA0KPiA+IEljaywgd2h5IG5vdCB1c2UgYSB0cmFjZXBvaW50IGZvciB0
aGlzIGluc3RlYWQ/DQo+ID4gDQo+ID4gQW5kIHdoYXQgaXMgdXNlcnNwYWNlIHN1cHBvc2VkIHRv
IGRvIHdpdGggdGhpcyBpZiB0aGV5IHNlZSBpdD8NCj4gDQo+IE9yIGFub3RoZXIgb3B0aW9uIGlz
IHRvIGltcGxlbWVudCB0aGlzIHNlcGFyYXRlbHkgb3V0c2lkZSBvZiBiaW5kZXIuYyB1c2luZw0K
PiByZWdpc3Rlcl90cmFjZV8qIG9uIHRoZSBleGlzdGluZyBiaW5kZXIgdHJhY2Vwb2ludHMsIHNp
bWlsYXIgdG8gd2hhdCBzYXkgdGhlDQo+IGJsb2NrIHRyYWNlciBvciBwcmVlbXB0LW9mZiB0cmFj
ZXJzIGRvLiBDYWxsIGl0LCBzYXksICJiaW5kZXItbGF0ZW5jeSB0cmFjZXIiLg0KPiANCj4gVGhh
dCB3YXkgYWxsIG9mIHRoaXMgdHJhY2luZyBjb2RlIGlzIGluLWtlcm5lbCBidXQgb3V0c2lkZSBv
ZiBiaW5kZXIuYy4NCj4gDQo+IHRoYW5rcywNCj4gDQo+ICAtIEpvZWwNCj4gDQpUaW1lIGxpbWl0
YXRpb24gb2YgcmVjb3JkaW5nIGlzIHRoZSByZWFzb24gd2h5IHdlIGRvbid0IHVzZSB0cmFjZXBv
aW50Lg0KSW4gc29tZSBzaXR1YXRpb25zLCB0aGUgZXhjZXB0aW9uIGlzIGNhdXNlZCBieSBhIHNl
cmllcyBvZiB0cmFuc2FjdGlvbnMNCmludGVyYWN0aW9uLg0KU29tZSBhYm5vcm1hbCB0cmFuc2Fj
dGlvbnMgbWF5IGJlIHBlbmRpbmcgZm9yIGEgbG9uZyB0aW1lIGFnbywgdGhleQ0KY291bGQgbm90
IGJlIHJlY29yZGVkIGR1ZSB0byBidWZmZXIgbGltaXRlZC4NClRoZXJlZm9yZSwgaXQgaXMgZGlm
ZmljdWx0IHRvIGRpZyBvdXQgdGhlIHJvb3QgY2F1c2VzIHdoaWNoIGNhdXNlZCBieQ0KdGhlIGVh
cmxpZXIgdHJhbnNhY3Rpb25zIG9jY3VycmVkLg0KDQpBbm90aGVyIHBvaW50IGlzIHRoYXQgd2Un
ZCBqdXN0IGxpa2UgdG8gcmVjb3JkIHRoZSBhYm5vcm1hbA0KdHJhbnNhY3Rpb25zLg0KQnV0IG1v
c3Qgb2YgdHJhbnNhY3Rpb25zIGFyZSBsZXNzIHRoYW4gMiBzZWNvbmRzLCB0aGVzZSBhcmUgbm90
IHRoZSBrZXkNCnBvaW50IHdlIG5lZWQgdG8gZm9jdXMgb24uDQoNCnRoYW5rcywNCg0KRnJhbmtp
ZQ0K

