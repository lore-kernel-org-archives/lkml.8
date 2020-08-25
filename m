Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D85C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2A5620639
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OsgvLxeV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgHYCPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:15:49 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:27369 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726027AbgHYCPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:15:48 -0400
X-UUID: 47f6bdc6a8034c698eda1c6a7e7e0617-20200825
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ii64oCh7zep+4Ck47ItpZY3LpD+hSPCz2XQvCSfA6EY=;
        b=OsgvLxeVyRDla5CqbtlfBtLVL9PzP1ctRY7NHfoTjydZ8L1ig2p33mw1pZdM3yyKaSHqwh4qYZL9QSnZdBWTiIVcG81BI1M1QBKx3frxts2N7bB7KL7c2Ca83z34Na9YXqzYTKPNpvZfwKIGZcVhsddLPfqBmScG1lcB4szTgeA=;
X-UUID: 47f6bdc6a8034c698eda1c6a7e7e0617-20200825
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 329853360; Tue, 25 Aug 2020 10:15:46 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 25 Aug 2020 10:15:43 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 Aug 2020 10:15:43 +0800
Message-ID: <1598321744.29129.4.camel@mtksdccf07>
Subject: Re: [PATCH v2 0/6] kasan: add workqueue and timer stack for generic
 KASAN
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Marco Elver <elver@google.com>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Tejun Heo" <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 25 Aug 2020 10:15:44 +0800
In-Reply-To: <CANpmjNNYhYwyzT3pBzJdb=XCGyLj7X+Fhqui-6JAZJWGys25Rg@mail.gmail.com>
References: <20200824080706.24704-1-walter-zh.wu@mediatek.com>
         <CANpmjNNYhYwyzT3pBzJdb=XCGyLj7X+Fhqui-6JAZJWGys25Rg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 159432FB446FF43D5236F7CC4F80666B07F364717DF91DA958E52F2F389B3D492000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA4LTI0IGF0IDEzOjUwICswMjAwLCBNYXJjbyBFbHZlciB3cm90ZToNCj4g
T24gTW9uLCAyNCBBdWcgMjAyMCBhdCAxMDowNywgV2FsdGVyIFd1IDx3YWx0ZXItemgud3VAbWVk
aWF0ZWsuY29tPiB3cm90ZToNCj4gPg0KPiA+IFN5emJvdCByZXBvcnRzIG1hbnkgVUFGIGlzc3Vl
cyBmb3Igd29ya3F1ZXVlIG9yIHRpbWVyLCBzZWUgWzFdIGFuZCBbMl0uDQo+ID4gSW4gc29tZSBv
ZiB0aGVzZSBhY2Nlc3MvYWxsb2NhdGlvbiBoYXBwZW5lZCBpbiBwcm9jZXNzX29uZV93b3JrKCks
DQo+ID4gd2Ugc2VlIHRoZSBmcmVlIHN0YWNrIGlzIHVzZWxlc3MgaW4gS0FTQU4gcmVwb3J0LCBp
dCBkb2Vzbid0IGhlbHANCj4gPiBwcm9ncmFtbWVycyB0byBzb2x2ZSBVQUYgb24gd29ya3F1ZXVl
LiBUaGUgc2FtZSBtYXkgc3RhbmQgZm9yIHRpbWVzLg0KPiA+DQo+ID4gVGhpcyBwYXRjaHNldCBp
bXByb3ZlcyBLQVNBTiByZXBvcnRzIGJ5IG1ha2luZyB0aGVtIHRvIGhhdmUgd29ya3F1ZXVlDQo+
ID4gcXVldWVpbmcgc3RhY2sgYW5kIHRpbWVyIHF1ZXVlaW5nIHN0YWNrIGluZm9ybWF0aW9uLiBJ
dCBpcyB1c2VmdWwgZm9yDQo+ID4gcHJvZ3JhbW1lcnMgdG8gc29sdmUgdXNlLWFmdGVyLWZyZWUg
b3IgZG91YmxlLWZyZWUgbWVtb3J5IGlzc3VlLg0KPiA+DQo+ID4gR2VuZXJpYyBLQVNBTiB3aWxs
IHJlY29yZCB0aGUgbGFzdCB0d28gd29ya3F1ZXVlIGFuZCB0aW1lciBzdGFja3MsDQo+ID4gcHJp
bnQgdGhlbSBpbiBLQVNBTiByZXBvcnQuIEl0IGlzIG9ubHkgc3VpdGFibGUgZm9yIGdlbmVyaWMg
S0FTQU4uDQo+ID4NCj4gPiBbMV1odHRwczovL2dyb3Vwcy5nb29nbGUuY29tL2cvc3l6a2FsbGVy
LWJ1Z3Mvc2VhcmNoP3E9JTIydXNlLWFmdGVyLWZyZWUlMjIrcHJvY2Vzc19vbmVfd29yaw0KPiA+
IFsyXWh0dHBzOi8vZ3JvdXBzLmdvb2dsZS5jb20vZy9zeXprYWxsZXItYnVncy9zZWFyY2g/cT0l
MjJ1c2UtYWZ0ZXItZnJlZSUyMiUyMGV4cGlyZV90aW1lcnMNCj4gPiBbM11odHRwczovL2J1Z3pp
bGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTE5ODQzNw0KPiA+DQo+ID4gV2FsdGVyIFd1
ICg2KToNCj4gPiB0aW1lcjoga2FzYW46IHJlY29yZCB0aW1lciBzdGFjaw0KPiA+IHdvcmtxdWV1
ZToga2FzYW46IHJlY29yZCB3b3JrcXVldWUgc3RhY2sNCj4gPiBrYXNhbjogcHJpbnQgdGltZXIg
YW5kIHdvcmtxdWV1ZSBzdGFjaw0KPiA+IGxpYi90ZXN0X2thc2FuLmM6IGFkZCB0aW1lciB0ZXN0
IGNhc2UNCj4gPiBsaWIvdGVzdF9rYXNhbi5jOiBhZGQgd29ya3F1ZXVlIHRlc3QgY2FzZQ0KPiA+
IGthc2FuOiB1cGRhdGUgZG9jdW1lbnRhdGlvbiBmb3IgZ2VuZXJpYyBrYXNhbg0KPiA+DQo+ID4g
LS0tDQo+ID4NCj4gPiBDaGFuZ2VzIHNpbmNlIHYxOg0KPiA+IC0gVGhhbmtzIGZvciBNYXJjbyBh
bmQgVGhvbWFzIHN1Z2dlc3Rpb24uDQo+ID4gLSBSZW1vdmUgdW5uZWNlc3NhcnkgY29kZSBhbmQg
Zml4IGNvbW1pdCBsb2cNCj4gPiAtIHJldXNlIGthc2FuX3JlY29yZF9hdXhfc3RhY2soKSBhbmQg
YXV4X3N0YWNrDQo+ID4gICB0byByZWNvcmQgdGltZXIgYW5kIHdvcmtxdWV1ZSBzdGFjay4NCj4g
PiAtIGNoYW5nZSB0aGUgYXV4IHN0YWNrIHRpdGxlIGZvciBjb21tb24gbmFtZS4NCj4gDQo+IE11
Y2ggY2xlYW5lci4NCj4gDQo+IEluIGdlbmVyYWwsDQo+IA0KPiBBY2tlZC1ieTogTWFyY28gRWx2
ZXIgPGVsdmVyQGdvb2dsZS5jb20+DQo+IA0KPiBidXQgSSBsZWZ0IHNvbWUgbW9yZSBjb21tZW50
cy4gSSdtIGEgYml0IHdvcnJpZWQgYWJvdXQgdGhlIHRlc3RzLA0KPiBiZWNhdXNlIG9mIEtBU0FO
LXRlc3QgS1VuaXQgcmV3b3JrLCBidXQgcHJvYmFibHkgbm90IG11Y2ggd2UgY2FuIGRvDQo+IHVu
dGlsIHRoZXNlIGFyZSBhZGRlZCB0byAtbW0gdHJlZS4NCj4gDQoNCkhpIE1hcmNvLA0KDQpUaGFu
a3MgZm9yIHlvdXIgcmV2aWV3IGFuZCBmcmllbmRseSByZW1pbmRlci4NCg0KSWYgbmVlZGVkLCBJ
IHdpbGwgcmViYXNlIGFuZCByZXNlbmQgdGhlIHRlc3QgY2FzZS4NCg0KDQpXYWx0ZXINCg0KPiBU
aGFua3MsDQo+IC0tIE1hcmNvDQoNCg==

