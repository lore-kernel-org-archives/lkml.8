Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A810C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E87E20672
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="i7Mf4L2g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgGTNkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 09:40:35 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:6799 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726535AbgGTNke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:40:34 -0400
X-UUID: e6697f5f9bbd4450abe130800530c3de-20200720
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=yjrsMDbea0ajD15SAf9EUujh8AYZA8JCoirJ5p5xHCA=;
        b=i7Mf4L2gZG92BzRUmc7p6ux/bmAuNWA3rJIpiJY0In3ntaNiRJA3wshccrHysRXE9YMGzsLaSGZYtlsA2AlMjUdvU449YSrHerKLF2cC1WGMiqKSD7ba7Vo8NDEgzOTbv0/r7U5ABpXGTLmi5NV+OeDrMihBDwFIYDrmBnZlTy8=;
X-UUID: e6697f5f9bbd4450abe130800530c3de-20200720
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <frankie.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1297103856; Mon, 20 Jul 2020 21:40:32 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 20 Jul 2020 21:40:28 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 20 Jul 2020 21:40:28 +0800
Message-ID: <1595252430.5899.6.camel@mtkswgap22>
Subject: Re: [PATCH v5] binder: transaction latency tracking for user build
From:   Frankie Chang <Frankie.Chang@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ". Todd Kjos" <tkjos@google.com>
CC:     Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Jian-Min Liu <Jian-Min.Liu@mediatek.com>
Date:   Mon, 20 Jul 2020 21:40:30 +0800
In-Reply-To: <1593696357.5899.3.camel@mtkswgap22>
References: <20200507085544.GB1097552@kroah.com>
         <1591791827-23871-1-git-send-email-Frankie.Chang@mediatek.com>
         <1593696357.5899.3.camel@mtkswgap22>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZywgVG9kZCBhbmQgYWxsDQoNCkdlbnRsZSBwaW5nIGZvciB0aGlzIHBhdGNoIHNldA0K
DQpUaGFua3MNCg0KT24gVGh1LCAyMDIwLTA3LTAyIGF0IDIxOjI1ICswODAwLCBGcmFua2llIENo
YW5nIHdyb3RlOg0KPiBIaSBHcmVnLCBUb2RkIGFuZCBhbGwNCj4gDQo+IEdlbnRsZSByZW1pbmQg
b2YgdGhpcyBwYXRjaCBzZXQNCj4gDQo+IFRoYW5rcy4NCj4gRnJhbmtpZQ0KPiANCj4gT24gV2Vk
LCAyMDIwLTA2LTEwIGF0IDIwOjIzICswODAwLCBGcmFua2llIENoYW5nIHdyb3RlOg0KPiA+IEZy
YW5raWUuQ2hhbmcgKDMpOg0KPiA+ICAgYmluZGVyOiBtb3ZlIHN0cnVjdHMgZnJvbSBjb3JlIGZp
bGUgdG8gaGVhZGVyIGZpbGUNCj4gPiAgIGJpbmRlcjogYWRkIHRyYWNlIGF0IGZyZWUgdHJhbnNh
Y3Rpb24uDQo+ID4gICBiaW5kZXI6IGFkZCB0cmFuc2FjdGlvbiBsYXRlbmN5IHRyYWNlcg0KPiA+
IA0KPiA+ICBkcml2ZXJzL2FuZHJvaWQvS2NvbmZpZyAgICAgICAgICAgICAgICAgfCAgIDggKw0K
PiA+ICBkcml2ZXJzL2FuZHJvaWQvTWFrZWZpbGUgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiA+
ICBkcml2ZXJzL2FuZHJvaWQvYmluZGVyLmMgICAgICAgICAgICAgICAgfCA0MDggKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0NCj4gPiAgZHJpdmVycy9hbmRyb2lkL2JpbmRlcl9pbnRlcm5hbC5oICAg
ICAgIHwgNDE2ICsrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICBkcml2ZXJzL2FuZHJvaWQv
YmluZGVyX2xhdGVuY3lfdHJhY2VyLmMgfCAxMDggKysrKysrDQo+ID4gIGRyaXZlcnMvYW5kcm9p
ZC9iaW5kZXJfdHJhY2UuaCAgICAgICAgICB8ICA0OSArKysNCj4gPiAgNiBmaWxlcyBjaGFuZ2Vk
LCA1ODYgaW5zZXJ0aW9ucygrKSwgNDA0IGRlbGV0aW9ucygtKSAgY3JlYXRlIG1vZGUgMTAwNjQ0
IGRyaXZlcnMvYW5kcm9pZC9iaW5kZXJfbGF0ZW5jeV90cmFjZXIuYw0KPiA+IA0KPiA+IENoYW5n
ZSBmcm9tIHY1Og0KPiA+ICAgLSBjaGFuZ2UgY29uZmlnIG5hbWUgdG8gdGhlIHByb3BlciBvbmUs
IENPTkZJR19CSU5ERVJfVFJBTlNBQ1RJT05fTEFURU5DWV9UUkFDS0lORy4NCj4gPiAgIC0gY2hh
bmdlIHRyYWNlcG9pbnQgbmFtZSB0byBtb3JlIGRlc2NyaXB0aXZlIG9uZSwgdHJhY2VfYmluZGVy
X3R4bl9sYXRlbmN5XyhhbGxvY3xpbmZvfGZyZWUpDQo+ID4gICAtIGVuaGFuY2Ugc29tZSBsb2Nr
IHByb3RlY3Rpb24uDQo+ID4gDQo+ID4gQ2hhbmdlIGZyb20gdjQ6DQo+ID4gICAtIHNwbGl0IHVw
IGludG8gcGF0Y2ggc2VyaWVzLg0KPiA+IA0KPiA+IENoYW5nZSBmcm9tIHYzOg0KPiA+ICAgLSB1
c2UgdHJhY2Vwb2ludHMgZm9yIGJpbmRlcl91cGRhdGVfaW5mbyBhbmQgcHJpbnRfYmluZGVyX3Ry
YW5zYWN0aW9uX2V4dCwNCj4gPiAgICAgaW5zdGVhZCBvZiBjdXN0b20gcmVnaXN0cmF0aW9uIGZ1
bmN0aW9ucy4NCj4gPiANCj4gPiBDaGFuZ2UgZnJvbSB2MjoNCj4gPiAgIC0gY3JlYXRlIHRyYW5z
YWN0aW9uIGxhdGVuY3kgbW9kdWxlIHRvIG1vbml0b3Igc2xvdyB0cmFuc2FjdGlvbi4NCj4gPiAN
Cj4gPiBDaGFuZ2UgZnJvbSB2MToNCj4gPiAgIC0gZmlyc3QgcGF0Y2hzZXQuDQo+IA0KDQo=

