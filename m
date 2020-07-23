Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA91C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 02:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E6992084D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 02:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jw9YaF1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733293AbgGWCsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 22:48:06 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48699 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728914AbgGWCsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 22:48:06 -0400
X-UUID: f1b92779c5f243aaa205778aeed6cbf9-20200723
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=o5Pnaz5PzLl00kO7UGNUdo3DX9rzOLiF6hNu8QVIo/Y=;
        b=jw9YaF1gpolTRR6kmJctp0538ekNI6ytMdVJATBkIzebqHAGpKAumpdRWQO9hqzP8WACwf/RoGa9jeCWf7wKvi/SCwRiPUYlWg41SgIXaNgZ1W2pIuQPEzhzlHk7n9sABajwUAkjdcAhwC8u6WkFN4LE6PK236p8ArMBRZTC3yg=;
X-UUID: f1b92779c5f243aaa205778aeed6cbf9-20200723
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <frankie.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1709787636; Thu, 23 Jul 2020 10:48:02 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Jul 2020 10:47:58 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Jul 2020 10:47:56 +0800
Message-ID: <1595472479.5899.8.camel@mtkswgap22>
Subject: Re: [PATCH v5 2/3] binder: add trace at free transaction.
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
Date:   Thu, 23 Jul 2020 10:47:59 +0800
In-Reply-To: <CAHRSSEydixN=4JQW3PGsTVaYZG+1aVZA6JOE9c9GufiWrkDycQ@mail.gmail.com>
References: <20200507085544.GB1097552@kroah.com>
         <1591791827-23871-1-git-send-email-Frankie.Chang@mediatek.com>
         <1591791827-23871-3-git-send-email-Frankie.Chang@mediatek.com>
         <CAHRSSEydixN=4JQW3PGsTVaYZG+1aVZA6JOE9c9GufiWrkDycQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA3LTIwIGF0IDExOjIzIC0wNzAwLCBUb2RkIEtqb3Mgd3JvdGU6DQo+IE9u
IFdlZCwgSnVuIDEwLCAyMDIwIGF0IDU6MjQgQU0gRnJhbmtpZSBDaGFuZw0KPiA8RnJhbmtpZS5D
aGFuZ0BtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogIkZyYW5raWUuQ2hhbmci
IDxGcmFua2llLkNoYW5nQG1lZGlhdGVrLmNvbT4NCj4gPg0KPiA+IFNpbmNlIHRoZSBvcmlnaW5h
bCB0cmFjZV9iaW5kZXJfdHJhbnNhY3Rpb25fcmVjZWl2ZWQgY2Fubm90DQo+ID4gcHJlY2lzZWx5
IHByZXNlbnQgdGhlIHJlYWwgZmluaXNoZWQgdGltZSBvZiB0cmFuc2FjdGlvbiwgYWRkaW5nIGEN
Cj4gPiB0cmFjZV9iaW5kZXJfdHhuX2xhdGVuY3lfZnJlZSBhdCB0aGUgcG9pbnQgb2YgZnJlZSB0
cmFuc2FjdGlvbg0KPiA+IG1heSBiZSBtb3JlIGNsb3NlIHRvIGl0Lg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogRnJhbmtpZS5DaGFuZyA8RnJhbmtpZS5DaGFuZ0BtZWRpYXRlay5jb20+DQo+ID4g
LS0tDQo+ID4gIGRyaXZlcnMvYW5kcm9pZC9iaW5kZXIuYyAgICAgICB8ICAgIDIgKysNCj4gPiAg
ZHJpdmVycy9hbmRyb2lkL2JpbmRlcl90cmFjZS5oIHwgICAyNyArKysrKysrKysrKysrKysrKysr
KysrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hbmRyb2lkL2JpbmRlci5jIGIvZHJpdmVycy9hbmRyb2lk
L2JpbmRlci5jDQo+ID4gaW5kZXggMTU5MjM5Ni4uNWVjOWFmOCAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL2FuZHJvaWQvYmluZGVyLmMNCj4gPiArKysgYi9kcml2ZXJzL2FuZHJvaWQvYmluZGVy
LmMNCj4gPiBAQCAtMTUyMyw2ICsxNTIzLDcgQEAgc3RhdGljIHZvaWQgYmluZGVyX2ZyZWVfdHJh
bnNhY3Rpb24oc3RydWN0IGJpbmRlcl90cmFuc2FjdGlvbiAqdCkNCj4gPiAgICAgICAgICAqIElm
IHRoZSB0cmFuc2FjdGlvbiBoYXMgbm8gdGFyZ2V0X3Byb2MsIHRoZW4NCj4gPiAgICAgICAgICAq
IHQtPmJ1ZmZlci0+dHJhbnNhY3Rpb24gaGFzIGFscmVhZHkgYmVlbiBjbGVhcmVkLg0KPiA+ICAg
ICAgICAgICovDQo+ID4gKyAgICAgICB0cmFjZV9iaW5kZXJfdHhuX2xhdGVuY3lfZnJlZSh0KTsN
Cj4gPiAgICAgICAgIGJpbmRlcl9mcmVlX3R4bl9maXh1cHModCk7DQo+ID4gICAgICAgICBrZnJl
ZSh0KTsNCj4gPiAgICAgICAgIGJpbmRlcl9zdGF0c19kZWxldGVkKEJJTkRFUl9TVEFUX1RSQU5T
QUNUSU9OKTsNCj4gPiBAQCAtMzA5NCw2ICszMDk1LDcgQEAgc3RhdGljIHZvaWQgYmluZGVyX3Ry
YW5zYWN0aW9uKHN0cnVjdCBiaW5kZXJfcHJvYyAqcHJvYywNCj4gPiAgICAgICAgIGtmcmVlKHRj
b21wbGV0ZSk7DQo+ID4gICAgICAgICBiaW5kZXJfc3RhdHNfZGVsZXRlZChCSU5ERVJfU1RBVF9U
UkFOU0FDVElPTl9DT01QTEVURSk7DQo+ID4gIGVycl9hbGxvY190Y29tcGxldGVfZmFpbGVkOg0K
PiA+ICsgICAgICAgdHJhY2VfYmluZGVyX3R4bl9sYXRlbmN5X2ZyZWUodCk7DQo+ID4gICAgICAg
ICBrZnJlZSh0KTsNCj4gPiAgICAgICAgIGJpbmRlcl9zdGF0c19kZWxldGVkKEJJTkRFUl9TVEFU
X1RSQU5TQUNUSU9OKTsNCj4gPiAgZXJyX2FsbG9jX3RfZmFpbGVkOg0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2FuZHJvaWQvYmluZGVyX3RyYWNlLmggYi9kcml2ZXJzL2FuZHJvaWQvYmluZGVy
X3RyYWNlLmgNCj4gPiBpbmRleCA2NzMxYzNjLi44YWM4N2QxIDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvYW5kcm9pZC9iaW5kZXJfdHJhY2UuaA0KPiA+ICsrKyBiL2RyaXZlcnMvYW5kcm9pZC9i
aW5kZXJfdHJhY2UuaA0KPiA+IEBAIC05NSw2ICs5NSwzMyBAQA0KPiA+ICAgICAgICAgICAgICAg
ICAgIF9fZW50cnktPnRocmVhZF90b2RvKQ0KPiA+ICApOw0KPiA+DQo+ID4gK1RSQUNFX0VWRU5U
KGJpbmRlcl90eG5fbGF0ZW5jeV9mcmVlLA0KPiA+ICsgICAgICAgVFBfUFJPVE8oc3RydWN0IGJp
bmRlcl90cmFuc2FjdGlvbiAqdCksDQo+ID4gKyAgICAgICBUUF9BUkdTKHQpLA0KPiA+ICsgICAg
ICAgVFBfU1RSVUNUX19lbnRyeSgNCj4gPiArICAgICAgICAgICAgICAgX19maWVsZChpbnQsIGRl
YnVnX2lkKQ0KPiA+ICsgICAgICAgICAgICAgICBfX2ZpZWxkKGludCwgZnJvbV9wcm9jKQ0KPiA+
ICsgICAgICAgICAgICAgICBfX2ZpZWxkKGludCwgZnJvbV90aHJlYWQpDQo+ID4gKyAgICAgICAg
ICAgICAgIF9fZmllbGQoaW50LCB0b19wcm9jKQ0KPiA+ICsgICAgICAgICAgICAgICBfX2ZpZWxk
KGludCwgdG9fdGhyZWFkKQ0KPiA+ICsgICAgICAgICAgICAgICBfX2ZpZWxkKHVuc2lnbmVkIGlu
dCwgY29kZSkNCj4gPiArICAgICAgICAgICAgICAgX19maWVsZCh1bnNpZ25lZCBpbnQsIGZsYWdz
KQ0KPiA+ICsgICAgICAgKSwNCj4gPiArICAgICAgIFRQX2Zhc3RfYXNzaWduKA0KPiA+ICsgICAg
ICAgICAgICAgICBfX2VudHJ5LT5kZWJ1Z19pZCA9IHQtPmRlYnVnX2lkOw0KPiA+ICsgICAgICAg
ICAgICAgICBfX2VudHJ5LT5mcm9tX3Byb2MgPSB0LT5mcm9tID8gdC0+ZnJvbS0+cHJvYy0+cGlk
IDogMDsNCj4gPiArICAgICAgICAgICAgICAgX19lbnRyeS0+ZnJvbV90aHJlYWQgPSB0LT5mcm9t
ID8gdC0+ZnJvbS0+cGlkIDogMDsNCj4gPiArICAgICAgICAgICAgICAgX19lbnRyeS0+dG9fcHJv
YyA9IHQtPnRvX3Byb2MgPyB0LT50b19wcm9jLT5waWQgOiAwOw0KPiA+ICsgICAgICAgICAgICAg
ICBfX2VudHJ5LT50b190aHJlYWQgPSB0LT50b190aHJlYWQgPyB0LT50b190aHJlYWQtPnBpZCA6
IDA7DQo+IA0KPiB0LT50b19wcm9jIGFuZCB0LT50b190aHJlYWQgYXJlIG5vdCBzYWZlIHRvIGRl
cmVmZXJlbmNlIHdpdGhvdXQNCj4gaG9sZGluZyB0LT5sb2NrLiBJZiB0aGUgdGFyZ2V0IHByb2Nl
c3MgZGllcywgdGhlc2UgZmllbGRzIGNhbiBiZSBzZXQNCj4gdG8gTlVMTA0KPiANClRoYW5rcyBm
b3IgcmVtaW5kLiBJIHdpbGwgYWRkIGxvY2sgcHJvdGVjdGlvbiBmb3IgdGhlc2UgdC0+dG9fcHJv
YyAmDQp0LT50b190aHJlYWQgaW4gdjcuDQoNCj4gPiArICAgICAgICAgICAgICAgX19lbnRyeS0+
Y29kZSA9IHQtPmNvZGU7DQo+ID4gKyAgICAgICAgICAgICAgIF9fZW50cnktPmZsYWdzID0gdC0+
ZmxhZ3M7DQo+ID4gKyAgICAgICApLA0KPiA+ICsgICAgICAgVFBfcHJpbnRrKCJ0cmFuc2FjdGlv
bj0lZCBmcm9tICVkOiVkIHRvICVkOiVkIGZsYWdzPTB4JXggY29kZT0weCV4IiwNCj4gPiArICAg
ICAgICAgICAgICAgICBfX2VudHJ5LT5kZWJ1Z19pZCwgX19lbnRyeS0+ZnJvbV9wcm9jLCBfX2Vu
dHJ5LT5mcm9tX3RocmVhZCwNCj4gPiArICAgICAgICAgICAgICAgICBfX2VudHJ5LT50b19wcm9j
LCBfX2VudHJ5LT50b190aHJlYWQsIF9fZW50cnktPmNvZGUsDQo+ID4gKyAgICAgICAgICAgICAg
ICAgX19lbnRyeS0+ZmxhZ3MpDQo+ID4gKyk7DQo+ID4gKw0KPiA+ICBUUkFDRV9FVkVOVChiaW5k
ZXJfdHJhbnNhY3Rpb24sDQo+ID4gICAgICAgICBUUF9QUk9UTyhib29sIHJlcGx5LCBzdHJ1Y3Qg
YmluZGVyX3RyYW5zYWN0aW9uICp0LA0KPiA+ICAgICAgICAgICAgICAgICAgc3RydWN0IGJpbmRl
cl9ub2RlICp0YXJnZXRfbm9kZSksDQo+ID4gLS0NCj4gPiAxLjcuOS41DQoNCg==

