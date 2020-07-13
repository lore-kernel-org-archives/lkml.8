Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AFFC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D69720674
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mBna305Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbgGMG3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:29:04 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:42031 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728656AbgGMG3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 02:29:02 -0400
X-UUID: 9a50178f7b1a490d86b7c429d9e75fb9-20200713
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=u1YVFUhNBChKn3hVAOGio4nlm710e7A413UQV7bi/Ys=;
        b=mBna305ZK72/GAJFpSATHv/bBo7ihIxjO/BiQjY68gvNJjMyTwZaYxhg1gg7hlVcufyTnx4jLrnPx0lG9BafwVyIYu7l2fvDbBUEDf4rb9L86GcJWC68uuLLJfnYS6/aCjNYW28ECjTDwbI3aimpbmD1V4Ze0fkIRSIjMd4NAd4=;
X-UUID: 9a50178f7b1a490d86b7c429d9e75fb9-20200713
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1851266747; Mon, 13 Jul 2020 14:28:53 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 13 Jul
 2020 14:28:51 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 13 Jul 2020 14:28:51 +0800
Message-ID: <1594621684.16172.22.camel@mhfsdcap03>
Subject: Re: [PATCH 01/21] dt-binding: memory: mediatek: Add a common
 larb-port header file
From:   Yong Wu <yong.wu@mediatek.com>
To:     Pi-Hsun Shih <pihsun@chromium.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Youlin Pei =?UTF-8?Q?=28=E8=A3=B4=E5=8F=8B=E6=9E=97=29?= 
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <cui.zhang@mediatek.com>,
        <chao.hao@mediatek.com>, <ming-fan.chen@mediatek.com>
Date:   Mon, 13 Jul 2020 14:28:04 +0800
In-Reply-To: <CANdKZ0dwsaP=s8AgRbDx2_0y4JmPnF-X0Rb=4vor2MWCYWfGKw@mail.gmail.com>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
         <20200711064846.16007-2-yong.wu@mediatek.com>
         <9e21288c-07da-88b0-2dbb-bd9a2a4d529b@gmail.com>
         <CANdKZ0dwsaP=s8AgRbDx2_0y4JmPnF-X0Rb=4vor2MWCYWfGKw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: B2F7F870170CA2A9C5CE3E2AE2DE382AD28F42E6BD22B1BEE765926AC2E33B272000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA3LTEzIGF0IDEzOjQzICswODAwLCBQaS1Ic3VuIFNoaWggd3JvdGU6DQo+
IE9uIE1vbiwgSnVsIDEzLCAyMDIwIGF0IDI6MDYgQU0gTWF0dGhpYXMgQnJ1Z2dlciA8bWF0dGhp
YXMuYmdnQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPg0KPiA+DQo+ID4gT24gMTEvMDcvMjAy
MCAwODo0OCwgWW9uZyBXdSB3cm90ZToNCj4gPiA+IFB1dCBhbGwgdGhlIG1hY3JvcyBhYm91dCBz
bWkgbGFyYi9wb3J0IHRvZ2V0aGVycywgdGhpcyBpcyBhIHByZXBhcmluZw0KPiA+ID4gcGF0Y2gg
Zm9yIGV4dGVuZGluZyBMQVJCX05SIGFuZCBhZGRpbmcgbmV3IGRvbS1pZCBzdXBwb3J0Lg0KPiA+
ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0K
PiA+ID4gLS0tDQo+ID4gPiAgIGluY2x1ZGUvZHQtYmluZGluZ3MvbWVtb3J5L210MjcxMi1sYXJi
LXBvcnQuaCAgfCAgMiArLQ0KPiA+ID4gICBpbmNsdWRlL2R0LWJpbmRpbmdzL21lbW9yeS9tdDY3
NzktbGFyYi1wb3J0LmggIHwgIDIgKy0NCj4gPiA+ICAgaW5jbHVkZS9kdC1iaW5kaW5ncy9tZW1v
cnkvbXQ4MTczLWxhcmItcG9ydC5oICB8ICAyICstDQo+ID4gPiAgIGluY2x1ZGUvZHQtYmluZGlu
Z3MvbWVtb3J5L210ODE4My1sYXJiLXBvcnQuaCAgfCAgMiArLQ0KPiA+ID4gICBpbmNsdWRlL2R0
LWJpbmRpbmdzL21lbW9yeS9tdGstc21pLWxhcmItcG9ydC5oIHwgMTUgKysrKysrKysrKysrKysr
DQo+ID4gPiAgIDUgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMo
LSkNCj4gPiA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvZHQtYmluZGluZ3MvbWVtb3J5
L210ay1zbWktbGFyYi1wb3J0LmgNCj4gPiA+DQo+ID4gPiAuLi4NCj4gPiA+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL2R0LWJpbmRpbmdzL21lbW9yeS9tdGstc21pLWxhcmItcG9ydC5oIGIvaW5jbHVk
ZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXRrLXNtaS1sYXJiLXBvcnQuaA0KPiA+ID4gbmV3IGZpbGUg
bW9kZSAxMDA2NDQNCj4gPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uMmVjN2ZlNWNlNGU5DQo+ID4g
PiAtLS0gL2Rldi9udWxsDQo+ID4gPiArKysgYi9pbmNsdWRlL2R0LWJpbmRpbmdzL21lbW9yeS9t
dGstc21pLWxhcmItcG9ydC5oDQo+ID4gPiBAQCAtMCwwICsxLDE1IEBADQo+ID4gPiArLyogU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seSAqLw0KPiA+ID4gKy8qDQo+ID4gPiAr
ICogQ29weXJpZ2h0IChjKSAyMDIwIE1lZGlhVGVrIEluYy4NCj4gPiA+ICsgKiBBdXRob3I6IFlv
bmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KPiA+ID4gKyAqLw0KPiA+ID4gKyNpZm5kZWYg
X19EVFNfTVRLX0lPTU1VX1BPUlRfSF8NCj4gPiA+ICsjZGVmaW5lIF9fRFRTX01US19JT01NVV9Q
T1JUX0hfDQo+ID4gPiArDQo+ID4gPiArI2RlZmluZSBNVEtfTEFSQl9OUl9NQVggICAgICAgICAg
ICAgICAgICAgICAgMTYNCj4gPg0KPiA+IGluY2x1ZGUvc29jL21lZGlhdGVrL3NtaS5oIGhhcyB0
aGUgdmVyeSBzYW1lIGRlZmluZS4NCj4gPiBTaG91bGQgc21pLmggaW5jbHVkZSB0aGlzIGZpbGU/
DQo+ID4NCj4gPiBSZWdhcmRzLA0KPiA+IE1hdHRoaWFzDQo+ID4NCj4gDQo+IExvb2tzIGxpa2Ug
dGhpcyBpcyBiZWluZyBhZGRyZXNzZWQgaW4gcGF0Y2ggNSBpbiB0aGlzIHNlcmllcyAoWzA1LzIx
XQ0KPiBpb21tdS9tZWRpYXRlazogVXNlIHRoZSBjb21tb24gbXRrLXNtaS1sYXJiLXBvcnQuaCkN
Cj4gVGhhdCBzYWlkLCBzaG91bGQgdGhhdCBwYXRjaCBiZSBtZXJnZWQgaW50byB0aGlzIG9uZT8N
Cg0KQXQgdGhlIGJlZ2lubmluZywgSSByZWFsbHkgZGlkIGxpa2UgdGhpcy4gQnV0IGNoZWNrcGF0
Y2ggd2lsbCBjb21wbGFpbg0KbGlrZSB0aGF0Og0KDQpXQVJOSU5HOkRUX1NQTElUX0JJTkRJTkdf
UEFUQ0g6IERUIGJpbmRpbmcgZG9jcyBhbmQgaW5jbHVkZXMgc2hvdWxkIGJlIGENCnNlcGFyYXRl
IHBhdGNoLiBTZWU6DQpEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3VibWl0dGlu
Zy1wYXRjaGVzLnJzdA0KDQo+IA0KPiANCj4gDQo+ID4gPiArDQo+ID4gPiArI2RlZmluZSBNVEtf
TTRVX0lEKGxhcmIsIHBvcnQpICAgICAgICAgICAgICAgKCgobGFyYikgPDwgNSkgfCAocG9ydCkp
DQo+ID4gPiArI2RlZmluZSBNVEtfTTRVX1RPX0xBUkIoaWQpICAgICAgICAgICgoKGlkKSA+PiA1
KSAmIDB4ZikNCj4gPiA+ICsjZGVmaW5lIE1US19NNFVfVE9fUE9SVChpZCkgICAgICAgICAgKChp
ZCkgJiAweDFmKQ0KPiA+ID4gKw0KPiA+ID4gKyNlbmRpZg0KPiA+ID4NCg0K

