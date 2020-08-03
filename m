Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8B6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 03:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBF1E20738
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 03:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fVupjEeN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgHCDL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 23:11:26 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:61898 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727883AbgHCDLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 23:11:23 -0400
X-UUID: 120aa51f445b4e0bbe1a4cbd9ba0d31c-20200803
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ALLw9ZkoA1S/JkwkqnRLE4IdmraD+sOk9I6zVmWez/M=;
        b=fVupjEeN3UxOG2tf1l65DYvFaQuKb+ayNxwRuhGCOn7ZrjEc4SfexFEbjML0e7XXNaNSypddLZdxnmvGyuz1Pb1YjeaU2skoUWex115JbiGuzu4VRt+VW4LXKf+lhtERrQ4f00c87xBlO0kS4uS69jdjx/xzq02dHM6Z+ANDHG0=;
X-UUID: 120aa51f445b4e0bbe1a4cbd9ba0d31c-20200803
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <frankie.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1942870867; Mon, 03 Aug 2020 11:11:18 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 3 Aug 2020 11:11:15 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 3 Aug 2020 11:11:15 +0800
Message-ID: <1596424276.5207.13.camel@mtkswgap22>
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
Date:   Mon, 3 Aug 2020 11:11:16 +0800
In-Reply-To: <CAHRSSEwqbbTZgaE-KLC0-AMHzRVU3O2AwUzW9i5u54tVmkFAQA@mail.gmail.com>
References: <1595252430.5899.6.camel@mtkswgap22>
         <1595906401-11985-1-git-send-email-Frankie.Chang@mediatek.com>
         <1595906401-11985-3-git-send-email-Frankie.Chang@mediatek.com>
         <CAHRSSEwqbbTZgaE-KLC0-AMHzRVU3O2AwUzW9i5u54tVmkFAQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 538817EDDCF731873A891B6A7D5A4FC560716D01388453026712EC4D613164242000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTA3LTMxIGF0IDExOjUwIC0wNzAwLCBUb2RkIEtqb3Mgd3JvdGU6DQo+IE9u
IE1vbiwgSnVsIDI3LCAyMDIwIGF0IDg6MjggUE0gRnJhbmtpZSBDaGFuZw0KPiA8RnJhbmtpZS5D
aGFuZ0BtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogIkZyYW5raWUuQ2hhbmci
IDxGcmFua2llLkNoYW5nQG1lZGlhdGVrLmNvbT4NCj4gPg0KPiA+IFNpbmNlIHRoZSBvcmlnaW5h
bCB0cmFjZV9iaW5kZXJfdHJhbnNhY3Rpb25fcmVjZWl2ZWQgY2Fubm90DQo+ID4gcHJlY2lzZWx5
IHByZXNlbnQgdGhlIHJlYWwgZmluaXNoZWQgdGltZSBvZiB0cmFuc2FjdGlvbiwgYWRkaW5nIGEN
Cj4gPiB0cmFjZV9iaW5kZXJfdHhuX2xhdGVuY3lfZnJlZSBhdCB0aGUgcG9pbnQgb2YgZnJlZSB0
cmFuc2FjdGlvbg0KPiA+IG1heSBiZSBtb3JlIGNsb3NlIHRvIGl0Lg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogRnJhbmtpZS5DaGFuZyA8RnJhbmtpZS5DaGFuZ0BtZWRpYXRlay5jb20+DQo+ID4g
LS0tDQo+ID4gIGRyaXZlcnMvYW5kcm9pZC9iaW5kZXIuYyAgICAgICB8ICAgIDYgKysrKysrDQo+
ID4gIGRyaXZlcnMvYW5kcm9pZC9iaW5kZXJfdHJhY2UuaCB8ICAgMjcgKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYW5kcm9pZC9iaW5kZXIuYyBiL2RyaXZlcnMvYW5k
cm9pZC9iaW5kZXIuYw0KPiA+IGluZGV4IDJkZjE0NmYuLjFlNmZjNDAgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9hbmRyb2lkL2JpbmRlci5jDQo+ID4gKysrIGIvZHJpdmVycy9hbmRyb2lkL2Jp
bmRlci5jDQo+ID4gQEAgLTE1MjIsNiArMTUyMiw5IEBAIHN0YXRpYyB2b2lkIGJpbmRlcl9mcmVl
X3RyYW5zYWN0aW9uKHN0cnVjdCBiaW5kZXJfdHJhbnNhY3Rpb24gKnQpDQo+ID4gICAgICAgICAg
KiBJZiB0aGUgdHJhbnNhY3Rpb24gaGFzIG5vIHRhcmdldF9wcm9jLCB0aGVuDQo+ID4gICAgICAg
ICAgKiB0LT5idWZmZXItPnRyYW5zYWN0aW9uIGhhcyBhbHJlYWR5IGJlZW4gY2xlYXJlZC4NCj4g
PiAgICAgICAgICAqLw0KPiA+ICsgICAgICAgc3Bpbl9sb2NrKCZ0LT5sb2NrKTsNCj4gPiArICAg
ICAgIHRyYWNlX2JpbmRlcl90eG5fbGF0ZW5jeV9mcmVlKHQpOw0KPiA+ICsgICAgICAgc3Bpbl91
bmxvY2soJnQtPmxvY2spOw0KPiANCj4gSG1tLiBJIGRvbid0IHByZWZlciB0YWtpbmcgdGhlIGxv
Y2sganVzdCB0byBjYWxsIGEgdHJhY2UuIEl0IGRvZXNuJ3QNCj4gbWFrZSBjbGVhciB3aHkgdGhl
IGxvY2sgaGFzIHRvIGJlIHRha2VuLiBJJ2QgcHJlZmVyIHNvbWV0aGluZyBsaWtlOg0KPiANCj4g
aWYgKHRyYWNlX2JpbmRlcl90eG5fbGF0ZW5jeV9mcmVlX2VuYWJsZWQoKSkgew0KYw0KPiB9DQo+
IA0KPiBBbmQgdGhlbiB0aGUgdHJhY2Ugd291bGQgdXNlIHRoZSBwYXNzZWQtaW4gdmFsdWVzIGlu
c3RlYWQgb2YgYWNjZXNzaW5nDQo+IHZpYSB0LT50b19wcm9jL3RvX3RocmVhZC4NCj4gDQpUaGVu
IHdlIHN0aWxsIGFkZCBsb2NrIHByb3RlY3Rpb24gaW4gdGhlIGhvb2sgZnVuY3Rpb24sIHdoZW4g
dHJhY2UgaXMNCmRpc2FibGUgPw0KDQpPciB3ZSBhbHNvIHBhc3MgdGhlc2UgdG8gaG9vayBmdW5j
dGlvbiwgbm8gbWF0dGVyIHRoZSB0cmFjZSBpcyBlbmFibGUgb3INCm5vdC5JIHRoaW5rIHRoaXMg
d2F5IGlzIG1vcmUgY2xlYXIgdGhhdCB0aGUgbG9jayBwcm90ZWN0cyBAZnJvbSwNCkB0b19wcm9j
IGFuZCBAdG9fdGhyZWFkLlRoZW4sIHRoZXJlIGlzIG5vIG5lZWQgdG8gYWRkIHRoZSBsb2NrIGlu
IGhvb2sNCmZ1bmN0aW9uLg0KDQppbnQgZnJvbV9wcm9jLCBmcm9tX3RocmVhZCwgdG9fcHJvYywg
dG9fdGhyZWFkOw0KIA0Kc3Bpbl9sb2NrKCZ0LT5sb2NrKTsNCmZyb21fcHJvYyA9IHQtPmZyb20g
PyB0LT5mcm9tLT5wcm9jLT5waWQgOiAwOw0KZnJvbV90aHJlYWQgPSB0LT5mcm9tID8gdC0+ZnJv
bS0+cGlkIDowOw0KdG9fcHJvYyA9IHQtPnRvX3Byb2MgPyB0LT50b19wcm9jLT5waWQgOiAwOw0K
dG9fdGhyZWFkID0gdC0+dG9fdGhyZWFkID8gdC0+dG9fdGhyZWFkLT5waWQgOiAwOw0Kc3Bpbl91
bmxvY2soJnQtPmxvY2spOw0KdHJhY2VfYmluZGVyX3R4bl9sYXRlbmN5X2ZyZWUodCwgZnJvbV9w
cm9jLCBmcm9tX3RocmVhZCwgdG9fcHJvYywNCnRvX3BpZCk7DQoNCj4gPiAgICAgICAgIGJpbmRl
cl9mcmVlX3R4bl9maXh1cHModCk7DQo+ID4gICAgICAgICBrZnJlZSh0KTsNCj4gPiAgICAgICAg
IGJpbmRlcl9zdGF0c19kZWxldGVkKEJJTkRFUl9TVEFUX1RSQU5TQUNUSU9OKTsNCj4gPiBAQCAt
MzA5Myw2ICszMDk2LDkgQEAgc3RhdGljIHZvaWQgYmluZGVyX3RyYW5zYWN0aW9uKHN0cnVjdCBi
aW5kZXJfcHJvYyAqcHJvYywNCj4gPiAgICAgICAgIGtmcmVlKHRjb21wbGV0ZSk7DQo+ID4gICAg
ICAgICBiaW5kZXJfc3RhdHNfZGVsZXRlZChCSU5ERVJfU1RBVF9UUkFOU0FDVElPTl9DT01QTEVU
RSk7DQo+ID4gIGVycl9hbGxvY190Y29tcGxldGVfZmFpbGVkOg0KPiA+ICsgICAgICAgc3Bpbl9s
b2NrKCZ0LT5sb2NrKTsNCj4gPiArICAgICAgIHRyYWNlX2JpbmRlcl90eG5fbGF0ZW5jeV9mcmVl
KHQpOw0KPiA+ICsgICAgICAgc3Bpbl91bmxvY2soJnQtPmxvY2spOw0KPiA+ICAgICAgICAga2Zy
ZWUodCk7DQo+ID4gICAgICAgICBiaW5kZXJfc3RhdHNfZGVsZXRlZChCSU5ERVJfU1RBVF9UUkFO
U0FDVElPTik7DQo+ID4gIGVycl9hbGxvY190X2ZhaWxlZDoNCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9hbmRyb2lkL2JpbmRlcl90cmFjZS5oIGIvZHJpdmVycy9hbmRyb2lkL2JpbmRlcl90cmFj
ZS5oDQo+ID4gaW5kZXggNjczMWMzYy4uOGFjODdkMSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L2FuZHJvaWQvYmluZGVyX3RyYWNlLmgNCj4gPiArKysgYi9kcml2ZXJzL2FuZHJvaWQvYmluZGVy
X3RyYWNlLmgNCj4gPiBAQCAtOTUsNiArOTUsMzMgQEANCj4gPiAgICAgICAgICAgICAgICAgICBf
X2VudHJ5LT50aHJlYWRfdG9kbykNCj4gPiAgKTsNCj4gPg0KPiA+ICtUUkFDRV9FVkVOVChiaW5k
ZXJfdHhuX2xhdGVuY3lfZnJlZSwNCj4gPiArICAgICAgIFRQX1BST1RPKHN0cnVjdCBiaW5kZXJf
dHJhbnNhY3Rpb24gKnQpLA0KPiA+ICsgICAgICAgVFBfQVJHUyh0KSwNCj4gPiArICAgICAgIFRQ
X1NUUlVDVF9fZW50cnkoDQo+ID4gKyAgICAgICAgICAgICAgIF9fZmllbGQoaW50LCBkZWJ1Z19p
ZCkNCj4gPiArICAgICAgICAgICAgICAgX19maWVsZChpbnQsIGZyb21fcHJvYykNCj4gPiArICAg
ICAgICAgICAgICAgX19maWVsZChpbnQsIGZyb21fdGhyZWFkKQ0KPiA+ICsgICAgICAgICAgICAg
ICBfX2ZpZWxkKGludCwgdG9fcHJvYykNCj4gPiArICAgICAgICAgICAgICAgX19maWVsZChpbnQs
IHRvX3RocmVhZCkNCj4gPiArICAgICAgICAgICAgICAgX19maWVsZCh1bnNpZ25lZCBpbnQsIGNv
ZGUpDQo+ID4gKyAgICAgICAgICAgICAgIF9fZmllbGQodW5zaWduZWQgaW50LCBmbGFncykNCj4g
PiArICAgICAgICksDQo+ID4gKyAgICAgICBUUF9mYXN0X2Fzc2lnbigNCj4gPiArICAgICAgICAg
ICAgICAgX19lbnRyeS0+ZGVidWdfaWQgPSB0LT5kZWJ1Z19pZDsNCj4gPiArICAgICAgICAgICAg
ICAgX19lbnRyeS0+ZnJvbV9wcm9jID0gdC0+ZnJvbSA/IHQtPmZyb20tPnByb2MtPnBpZCA6IDA7
DQo+ID4gKyAgICAgICAgICAgICAgIF9fZW50cnktPmZyb21fdGhyZWFkID0gdC0+ZnJvbSA/IHQt
PmZyb20tPnBpZCA6IDA7DQo+ID4gKyAgICAgICAgICAgICAgIF9fZW50cnktPnRvX3Byb2MgPSB0
LT50b19wcm9jID8gdC0+dG9fcHJvYy0+cGlkIDogMDsNCj4gPiArICAgICAgICAgICAgICAgX19l
bnRyeS0+dG9fdGhyZWFkID0gdC0+dG9fdGhyZWFkID8gdC0+dG9fdGhyZWFkLT5waWQgOiAwOw0K
PiA+ICsgICAgICAgICAgICAgICBfX2VudHJ5LT5jb2RlID0gdC0+Y29kZTsNCj4gPiArICAgICAg
ICAgICAgICAgX19lbnRyeS0+ZmxhZ3MgPSB0LT5mbGFnczsNCj4gPiArICAgICAgICksDQo+ID4g
KyAgICAgICBUUF9wcmludGsoInRyYW5zYWN0aW9uPSVkIGZyb20gJWQ6JWQgdG8gJWQ6JWQgZmxh
Z3M9MHgleCBjb2RlPTB4JXgiLA0KPiA+ICsgICAgICAgICAgICAgICAgIF9fZW50cnktPmRlYnVn
X2lkLCBfX2VudHJ5LT5mcm9tX3Byb2MsIF9fZW50cnktPmZyb21fdGhyZWFkLA0KPiA+ICsgICAg
ICAgICAgICAgICAgIF9fZW50cnktPnRvX3Byb2MsIF9fZW50cnktPnRvX3RocmVhZCwgX19lbnRy
eS0+Y29kZSwNCj4gPiArICAgICAgICAgICAgICAgICBfX2VudHJ5LT5mbGFncykNCj4gPiArKTsN
Cj4gPiArDQo+ID4gIFRSQUNFX0VWRU5UKGJpbmRlcl90cmFuc2FjdGlvbiwNCj4gPiAgICAgICAg
IFRQX1BST1RPKGJvb2wgcmVwbHksIHN0cnVjdCBiaW5kZXJfdHJhbnNhY3Rpb24gKnQsDQo+ID4g
ICAgICAgICAgICAgICAgICBzdHJ1Y3QgYmluZGVyX25vZGUgKnRhcmdldF9ub2RlKSwNCj4gPiAt
LQ0KPiA+IDEuNy45LjUNCg0K

