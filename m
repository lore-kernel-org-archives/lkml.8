Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A6DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 02:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 744FC2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 02:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ikwe7hsm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbgHDCqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 22:46:00 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:65435 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730335AbgHDCp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 22:45:59 -0400
X-UUID: 4c8503704e0d43518b906f406aad3f87-20200804
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=BUJdISNL45J7vXInlHBIZKujtbVyNSjWJjnGfPo7yno=;
        b=Ikwe7hsmg4aezzuWK6ZshO73JfPz2vR1lOUH0CUFd/XV681nRPorQ1V3o+mbNF5roQ8RKWmXHKZiK1W1sEz5uVcAieJqIyxhGMgz00HaBXjl//ZbrZVptAmBNDVt4wDSvDgFCM7vNppt0pZjQ6gvqTgBnPr2TAxC2/4P+7F4a8c=;
X-UUID: 4c8503704e0d43518b906f406aad3f87-20200804
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <frankie.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 336970064; Tue, 04 Aug 2020 10:45:53 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 4 Aug 2020 10:45:45 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 4 Aug 2020 10:45:45 +0800
Message-ID: <1596509145.5207.21.camel@mtkswgap22>
Subject: Re: [PATCH v6 2/3] binder: add trace at free transaction.
From:   Frankie Chang <Frankie.Chang@mediatek.com>
To:     Todd Kjos <tkjos@google.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Jian-Min Liu <Jian-Min.Liu@mediatek.com>
Date:   Tue, 4 Aug 2020 10:45:45 +0800
In-Reply-To: <CAHRSSEwKa=wkp3+_cgZc3cZ+k_OEw82HTaKewLNFPovFVxsnbg@mail.gmail.com>
References: <1595252430.5899.6.camel@mtkswgap22>
         <1595906401-11985-1-git-send-email-Frankie.Chang@mediatek.com>
         <1595906401-11985-3-git-send-email-Frankie.Chang@mediatek.com>
         <CAHRSSEwqbbTZgaE-KLC0-AMHzRVU3O2AwUzW9i5u54tVmkFAQA@mail.gmail.com>
         <1596424276.5207.13.camel@mtkswgap22>
         <CAHRSSEwKa=wkp3+_cgZc3cZ+k_OEw82HTaKewLNFPovFVxsnbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA4LTAzIGF0IDA4OjEyIC0wNzAwLCBUb2RkIEtqb3Mgd3JvdGU6DQo+IE9u
IFN1biwgQXVnIDIsIDIwMjAgYXQgODoxMSBQTSBGcmFua2llIENoYW5nIDxGcmFua2llLkNoYW5n
QG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBGcmksIDIwMjAtMDctMzEgYXQgMTE6
NTAgLTA3MDAsIFRvZGQgS2pvcyB3cm90ZToNCj4gPiA+IE9uIE1vbiwgSnVsIDI3LCAyMDIwIGF0
IDg6MjggUE0gRnJhbmtpZSBDaGFuZw0KPiA+ID4gPEZyYW5raWUuQ2hhbmdAbWVkaWF0ZWsuY29t
PiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gRnJvbTogIkZyYW5raWUuQ2hhbmciIDxGcmFua2ll
LkNoYW5nQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4NCj4gPiA+ID4gU2luY2UgdGhlIG9yaWdpbmFs
IHRyYWNlX2JpbmRlcl90cmFuc2FjdGlvbl9yZWNlaXZlZCBjYW5ub3QNCj4gPiA+ID4gcHJlY2lz
ZWx5IHByZXNlbnQgdGhlIHJlYWwgZmluaXNoZWQgdGltZSBvZiB0cmFuc2FjdGlvbiwgYWRkaW5n
IGENCj4gPiA+ID4gdHJhY2VfYmluZGVyX3R4bl9sYXRlbmN5X2ZyZWUgYXQgdGhlIHBvaW50IG9m
IGZyZWUgdHJhbnNhY3Rpb24NCj4gPiA+ID4gbWF5IGJlIG1vcmUgY2xvc2UgdG8gaXQuDQo+ID4g
PiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEZyYW5raWUuQ2hhbmcgPEZyYW5raWUuQ2hhbmdA
bWVkaWF0ZWsuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGRyaXZlcnMvYW5kcm9pZC9iaW5k
ZXIuYyAgICAgICB8ICAgIDYgKysrKysrDQo+ID4gPiA+ICBkcml2ZXJzL2FuZHJvaWQvYmluZGVy
X3RyYWNlLmggfCAgIDI3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gPiAgMiBm
aWxlcyBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2FuZHJvaWQvYmluZGVyLmMgYi9kcml2ZXJzL2FuZHJvaWQvYmluZGVyLmMN
Cj4gPiA+ID4gaW5kZXggMmRmMTQ2Zi4uMWU2ZmM0MCAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJp
dmVycy9hbmRyb2lkL2JpbmRlci5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvYW5kcm9pZC9iaW5k
ZXIuYw0KPiA+ID4gPiBAQCAtMTUyMiw2ICsxNTIyLDkgQEAgc3RhdGljIHZvaWQgYmluZGVyX2Zy
ZWVfdHJhbnNhY3Rpb24oc3RydWN0IGJpbmRlcl90cmFuc2FjdGlvbiAqdCkNCj4gPiA+ID4gICAg
ICAgICAgKiBJZiB0aGUgdHJhbnNhY3Rpb24gaGFzIG5vIHRhcmdldF9wcm9jLCB0aGVuDQo+ID4g
PiA+ICAgICAgICAgICogdC0+YnVmZmVyLT50cmFuc2FjdGlvbiBoYXMgYWxyZWFkeSBiZWVuIGNs
ZWFyZWQuDQo+ID4gPiA+ICAgICAgICAgICovDQo+ID4gPiA+ICsgICAgICAgc3Bpbl9sb2NrKCZ0
LT5sb2NrKTsNCj4gPiA+ID4gKyAgICAgICB0cmFjZV9iaW5kZXJfdHhuX2xhdGVuY3lfZnJlZSh0
KTsNCj4gPiA+ID4gKyAgICAgICBzcGluX3VubG9jaygmdC0+bG9jayk7DQo+ID4gPg0KPiA+ID4g
SG1tLiBJIGRvbid0IHByZWZlciB0YWtpbmcgdGhlIGxvY2sganVzdCB0byBjYWxsIGEgdHJhY2Uu
IEl0IGRvZXNuJ3QNCj4gPiA+IG1ha2UgY2xlYXIgd2h5IHRoZSBsb2NrIGhhcyB0byBiZSB0YWtl
bi4gSSdkIHByZWZlciBzb21ldGhpbmcgbGlrZToNCj4gPiA+DQo+ID4gPiBpZiAodHJhY2VfYmlu
ZGVyX3R4bl9sYXRlbmN5X2ZyZWVfZW5hYmxlZCgpKSB7DQo+ID4gYw0KPiA+ID4gfQ0KPiA+ID4N
Cj4gPiA+IEFuZCB0aGVuIHRoZSB0cmFjZSB3b3VsZCB1c2UgdGhlIHBhc3NlZC1pbiB2YWx1ZXMg
aW5zdGVhZCBvZiBhY2Nlc3NpbmcNCj4gPiA+IHZpYSB0LT50b19wcm9jL3RvX3RocmVhZC4NCj4g
PiA+DQo+ID4gVGhlbiB3ZSBzdGlsbCBhZGQgbG9jayBwcm90ZWN0aW9uIGluIHRoZSBob29rIGZ1
bmN0aW9uLCB3aGVuIHRyYWNlIGlzDQo+ID4gZGlzYWJsZSA/DQo+IA0KPiBJIGRvbid0IHVuZGVy
c3RhbmQuLi4gaW4gdGhlIGV4YW1wbGUgSSBnYXZlLCB0aGUgdHJhY2UgZG9lc24ndCBnZXQNCj4g
Y2FsbGVkIGlmIGRpc2FibGVkLiBXaGF0IGRvIHlvdSBtZWFuIHRvICJhZGQgbG9jayBwcm90ZWN0
aW9uIHdoZW4gdGhlDQo+IHRyYWNlIGlzIGRpc2FibGVkKCkiPw0KPiANCj4gPg0KPiA+IE9yIHdl
IGFsc28gcGFzcyB0aGVzZSB0byBob29rIGZ1bmN0aW9uLCBubyBtYXR0ZXIgdGhlIHRyYWNlIGlz
IGVuYWJsZSBvcg0KPiANCj4gV2hhdCBkbyB5b3UgbWVhbiBieSAiaG9vayIgZnVuY3Rpb24/IElm
IHNvbWV0aGluZyBoYXMgYXR0YWNoZWQgdG8gdGhlDQo+IHRyYWNlLCB0aGVuIHh4eF9lbmFibGVk
KCkgd2lsbCByZXR1cm4gdHJ1ZS4NCj4gDQpJJ20gc29ycnkgZm9yIHRoYXQgSSBtaXN1bmRlcnN0
YW5kIHRoaXMgWFhYX2VuYWJsZWQoKS4gDQoNCj4gPiBub3QuSSB0aGluayB0aGlzIHdheSBpcyBt
b3JlIGNsZWFyIHRoYXQgdGhlIGxvY2sgcHJvdGVjdHMgQGZyb20sDQo+ID4gQHRvX3Byb2MgYW5k
IEB0b190aHJlYWQuVGhlbiwgdGhlcmUgaXMgbm8gbmVlZCB0byBhZGQgdGhlIGxvY2sgaW4gaG9v
aw0KPiA+IGZ1bmN0aW9uLg0KPiANCj4gV2h5IGlzIGl0IGNsZWFyZXIgKG90aGVyIHRoYW4gdGhl
IGZhY3QgdGhhdCBJIG1pc3NlZCBpbmNsdWRpbmcgdC0+ZnJvbQ0KPiB1bmRlciB0aGUgbG9jayk/
DQo+IA0KSSB0aGluayB5b3VyIGV4YW1wbGUgaXMgY2xlYXIgZW5vdWdoLg0KDQo+ID4NCj4gPiBp
bnQgZnJvbV9wcm9jLCBmcm9tX3RocmVhZCwgdG9fcHJvYywgdG9fdGhyZWFkOw0KPiA+DQo+ID4g
c3Bpbl9sb2NrKCZ0LT5sb2NrKTsNCj4gPiBmcm9tX3Byb2MgPSB0LT5mcm9tID8gdC0+ZnJvbS0+
cHJvYy0+cGlkIDogMDsNCj4gPiBmcm9tX3RocmVhZCA9IHQtPmZyb20gPyB0LT5mcm9tLT5waWQg
OjA7DQo+ID4gdG9fcHJvYyA9IHQtPnRvX3Byb2MgPyB0LT50b19wcm9jLT5waWQgOiAwOw0KPiA+
IHRvX3RocmVhZCA9IHQtPnRvX3RocmVhZCA/IHQtPnRvX3RocmVhZC0+cGlkIDogMDsNCj4gPiBz
cGluX3VubG9jaygmdC0+bG9jayk7DQo+ID4gdHJhY2VfYmluZGVyX3R4bl9sYXRlbmN5X2ZyZWUo
dCwgZnJvbV9wcm9jLCBmcm9tX3RocmVhZCwgdG9fcHJvYywNCj4gPiB0b19waWQpOw0KPiANCj4g
VGhlIG1haW4gZmVlZGJhY2sgaXMgSSdkIGxpa2UgdG8gc2VlIHRoZSBmaWVsZHMgZGVyZWZlcmVu
Y2VkIGluIHRoZQ0KPiBzYW1lIGNvbnRleHQgYXMgdGhlIGxvY2sgYWNxdWlzaXRpb24gaW5zdGVh
ZCBvZiBhY3F1aXJpbmcgdGhlIGxvY2sgYW5kDQo+IGNhbGxpbmcgdGhlIHRyYWNlIGZ1bmN0aW9u
LCBzbyB0aGlzIGNvZGUgd291bGQgYmUgZmluZS4gVGhlcmUgd2lsbCBiZQ0KPiB2ZXJ5IGxpdHRs
ZSBjb250ZW50aW9uIGZvciB0LT5sb2NrIHNvIHVzaW5nIHh4eF9lbmFibGVkKCkgaXMgb3B0aW9u
YWwuDQo+IA0KPiBTaW5jZSB0cmFjZV9iaW5kZXJfdHhuX2xhdGVuY3lfZnJlZSgpIGlzIGNhbGxl
ZCB0d2ljZSwgIGl0IHdvdWxkIG1ha2UNCj4gc2Vuc2UgdG8gaGF2ZSBhIGhlbHBlciBmdW5jdGlv
biB0byBkbyB0aGUgYWJvdmUuDQo+IA0KT2theSwgSSB3aWxsIG1ha2UgYSBoZWxwZXIgZnVuY3Rp
b24gdG8gZG8gdGhpcyBpbiBuZXh0IHZlcnNpb24gcGF0Y2guDQpWZXJ5IHRoYW5rcyBmb3IgeW91
ciBoZWxwIGZvciB0aGlzLg0KDQo+ID4NCj4gPiA+ID4gICAgICAgICBiaW5kZXJfZnJlZV90eG5f
Zml4dXBzKHQpOw0KPiA+ID4gPiAgICAgICAgIGtmcmVlKHQpOw0KPiA+ID4gPiAgICAgICAgIGJp
bmRlcl9zdGF0c19kZWxldGVkKEJJTkRFUl9TVEFUX1RSQU5TQUNUSU9OKTsNCj4gPiA+ID4gQEAg
LTMwOTMsNiArMzA5Niw5IEBAIHN0YXRpYyB2b2lkIGJpbmRlcl90cmFuc2FjdGlvbihzdHJ1Y3Qg
YmluZGVyX3Byb2MgKnByb2MsDQo+ID4gPiA+ICAgICAgICAga2ZyZWUodGNvbXBsZXRlKTsNCj4g
PiA+ID4gICAgICAgICBiaW5kZXJfc3RhdHNfZGVsZXRlZChCSU5ERVJfU1RBVF9UUkFOU0FDVElP
Tl9DT01QTEVURSk7DQo+ID4gPiA+ICBlcnJfYWxsb2NfdGNvbXBsZXRlX2ZhaWxlZDoNCj4gPiA+
ID4gKyAgICAgICBzcGluX2xvY2soJnQtPmxvY2spOw0KPiA+ID4gPiArICAgICAgIHRyYWNlX2Jp
bmRlcl90eG5fbGF0ZW5jeV9mcmVlKHQpOw0KPiA+ID4gPiArICAgICAgIHNwaW5fdW5sb2NrKCZ0
LT5sb2NrKTsNCj4gPiA+ID4gICAgICAgICBrZnJlZSh0KTsNCj4gPiA+ID4gICAgICAgICBiaW5k
ZXJfc3RhdHNfZGVsZXRlZChCSU5ERVJfU1RBVF9UUkFOU0FDVElPTik7DQo+ID4gPiA+ICBlcnJf
YWxsb2NfdF9mYWlsZWQ6DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FuZHJvaWQvYmlu
ZGVyX3RyYWNlLmggYi9kcml2ZXJzL2FuZHJvaWQvYmluZGVyX3RyYWNlLmgNCj4gPiA+ID4gaW5k
ZXggNjczMWMzYy4uOGFjODdkMSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9hbmRyb2lk
L2JpbmRlcl90cmFjZS5oDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvYW5kcm9pZC9iaW5kZXJfdHJh
Y2UuaA0KPiA+ID4gPiBAQCAtOTUsNiArOTUsMzMgQEANCj4gPiA+ID4gICAgICAgICAgICAgICAg
ICAgX19lbnRyeS0+dGhyZWFkX3RvZG8pDQo+ID4gPiA+ICApOw0KPiA+ID4gPg0KPiA+ID4gPiAr
VFJBQ0VfRVZFTlQoYmluZGVyX3R4bl9sYXRlbmN5X2ZyZWUsDQo+ID4gPiA+ICsgICAgICAgVFBf
UFJPVE8oc3RydWN0IGJpbmRlcl90cmFuc2FjdGlvbiAqdCksDQo+ID4gPiA+ICsgICAgICAgVFBf
QVJHUyh0KSwNCj4gPiA+ID4gKyAgICAgICBUUF9TVFJVQ1RfX2VudHJ5KA0KPiA+ID4gPiArICAg
ICAgICAgICAgICAgX19maWVsZChpbnQsIGRlYnVnX2lkKQ0KPiA+ID4gPiArICAgICAgICAgICAg
ICAgX19maWVsZChpbnQsIGZyb21fcHJvYykNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIF9fZmll
bGQoaW50LCBmcm9tX3RocmVhZCkNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIF9fZmllbGQoaW50
LCB0b19wcm9jKQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgX19maWVsZChpbnQsIHRvX3RocmVh
ZCkNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIF9fZmllbGQodW5zaWduZWQgaW50LCBjb2RlKQ0K
PiA+ID4gPiArICAgICAgICAgICAgICAgX19maWVsZCh1bnNpZ25lZCBpbnQsIGZsYWdzKQ0KPiA+
ID4gPiArICAgICAgICksDQo+ID4gPiA+ICsgICAgICAgVFBfZmFzdF9hc3NpZ24oDQo+ID4gPiA+
ICsgICAgICAgICAgICAgICBfX2VudHJ5LT5kZWJ1Z19pZCA9IHQtPmRlYnVnX2lkOw0KPiA+ID4g
PiArICAgICAgICAgICAgICAgX19lbnRyeS0+ZnJvbV9wcm9jID0gdC0+ZnJvbSA/IHQtPmZyb20t
PnByb2MtPnBpZCA6IDA7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICBfX2VudHJ5LT5mcm9tX3Ro
cmVhZCA9IHQtPmZyb20gPyB0LT5mcm9tLT5waWQgOiAwOw0KPiA+ID4gPiArICAgICAgICAgICAg
ICAgX19lbnRyeS0+dG9fcHJvYyA9IHQtPnRvX3Byb2MgPyB0LT50b19wcm9jLT5waWQgOiAwOw0K
PiA+ID4gPiArICAgICAgICAgICAgICAgX19lbnRyeS0+dG9fdGhyZWFkID0gdC0+dG9fdGhyZWFk
ID8gdC0+dG9fdGhyZWFkLT5waWQgOiAwOw0KPiA+ID4gPiArICAgICAgICAgICAgICAgX19lbnRy
eS0+Y29kZSA9IHQtPmNvZGU7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICBfX2VudHJ5LT5mbGFn
cyA9IHQtPmZsYWdzOw0KPiA+ID4gPiArICAgICAgICksDQo+ID4gPiA+ICsgICAgICAgVFBfcHJp
bnRrKCJ0cmFuc2FjdGlvbj0lZCBmcm9tICVkOiVkIHRvICVkOiVkIGZsYWdzPTB4JXggY29kZT0w
eCV4IiwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgX19lbnRyeS0+ZGVidWdfaWQsIF9fZW50
cnktPmZyb21fcHJvYywgX19lbnRyeS0+ZnJvbV90aHJlYWQsDQo+ID4gPiA+ICsgICAgICAgICAg
ICAgICAgIF9fZW50cnktPnRvX3Byb2MsIF9fZW50cnktPnRvX3RocmVhZCwgX19lbnRyeS0+Y29k
ZSwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgX19lbnRyeS0+ZmxhZ3MpDQo+ID4gPiA+ICsp
Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICBUUkFDRV9FVkVOVChiaW5kZXJfdHJhbnNhY3Rpb24sDQo+
ID4gPiA+ICAgICAgICAgVFBfUFJPVE8oYm9vbCByZXBseSwgc3RydWN0IGJpbmRlcl90cmFuc2Fj
dGlvbiAqdCwNCj4gPiA+ID4gICAgICAgICAgICAgICAgICBzdHJ1Y3QgYmluZGVyX25vZGUgKnRh
cmdldF9ub2RlKSwNCj4gPiA+ID4gLS0NCj4gPiA+ID4gMS43LjkuNQ0KPiA+DQoNCg==

