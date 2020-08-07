Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC33C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 02:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A786E2177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 02:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="c5FOfhM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgHGCOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 22:14:52 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:43331 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726027AbgHGCOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 22:14:52 -0400
X-UUID: ae261989d0a84694b73d2c8c8dba076f-20200807
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=JxLw+a2yeVjmglZikNxU8lr4nwwrSEYeYUL+KumKsqM=;
        b=c5FOfhM3iSiu7+xP15b3XDvMWwrLlwtsPmxaHuWGhHoYIBNpLdWiYZJGvrfdK7jufM6otqkjqxA5FBbkLi+uAgsDYoMhfIPLdZwQwGc4nR78riPRRhBuVnYDK3Bbv/cI9bV7NAMueuIRJJUtPLzD1LV5vHtvpwLSZMPWlKchP70=;
X-UUID: ae261989d0a84694b73d2c8c8dba076f-20200807
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2043936039; Fri, 07 Aug 2020 10:14:44 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 7 Aug
 2020 10:14:39 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 7 Aug 2020 10:14:41 +0800
Message-ID: <1596766438.18559.4.camel@mhfsdcap03>
Subject: Re: [PATCH 11/21] iommu/mediatek: Add power-domain operation
From:   Yong Wu <yong.wu@mediatek.com>
To:     chao hao <Chao.Hao@mediatek.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <cui.zhang@mediatek.com>,
        <ming-fan.chen@mediatek.com>, chao hao <"Chao. Hao"@mediatek.com>
Date:   Fri, 7 Aug 2020 10:13:58 +0800
In-Reply-To: <1595839778.2350.4.camel@mbjsdccf07>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
         <20200711064846.16007-12-yong.wu@mediatek.com>
         <1595839778.2350.4.camel@mbjsdccf07>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 1FA9D0F3014E9C59CFEAA84127CB84AF86104ADCF9CE47405B4B97E5C86E5DE82000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA3LTI3IGF0IDE2OjQ5ICswODAwLCBjaGFvIGhhbyB3cm90ZToNCj4gT24g
U2F0LCAyMDIwLTA3LTExIGF0IDE0OjQ4ICswODAwLCBZb25nIFd1IHdyb3RlOg0KPiA+IEluIHRo
ZSBwcmV2aW91cyBTb0MsIHRoZSBNNFUgSFcgaXMgaW4gdGhlIEVNSSBwb3dlciBkb21haW4gd2hp
Y2ggaXMNCj4gPiBhbHdheXMgb24uIHRoZSBsYXRlc3QgTTRVIGlzIGluIHRoZSBkaXNwbGF5IHBv
d2VyIGRvbWFpbiB3aGljaCBtYXkgYmUNCj4gPiB0dXJuZWQgb24vb2ZmLCB0aHVzIHdlIGhhdmUg
dG8gYWRkIHBtX3J1bnRpbWUgaW50ZXJmYWNlIGZvciBpdC4NCj4gPiANCj4gPiB3ZSBzaG91bGQg
ZW5hYmxlIGl0cyBwb3dlciBiZWZvcmUgTTRVIGh3IGluaXRpYWwuIGFuZCBkaXNhYmxlIGl0IGFm
dGVyIEhXDQo+ID4gaW5pdGlhbGl6ZS4NCj4gPiANCj4gPiBXaGVuIHRoZSBlbmdpbmUgd29yaywg
dGhlIGVuZ2luZSBhbHdheXMgZW5hYmxlIHRoZSBwb3dlciBhbmQgY2xvY2tzIGZvcg0KPiA+IHNt
aS1sYXJiL3NtaS1jb21tb24sIHRoZW4gdGhlIE00VSdzIHBvd2VyIHdpbGwgYWx3YXlzIGJlIHBv
d2VyZWQgb24NCj4gPiBhdXRvbWF0aWNhbGx5IHZpYSB0aGUgZGV2aWNlIGxpbmsgd2l0aCBzbWkt
Y29tbW9uLg0KPiA+IA0KPiA+IE5vdGU6IHdlIGRvbid0IGVuYWJsZSB0aGUgTTRVIHBvd2VyIGlu
IGlvbW11X21hcC91bm1hcCBmb3IgdGxiIGZsdXNoLg0KPiA+IElmIGl0cyBwb3dlciBhbHJlYWR5
IGlzIG9uLCBvZiBjb3Vyc2UgaXQgaXMgb2suIGlmIHRoZSBwb3dlciBpcyBvZmYsDQo+ID4gdGhl
IG1haW4gdGxiIHdpbGwgYmUgcmVzZXQgd2hpbGUgTTRVIHBvd2VyIG9uLCB0aHVzIHRoZSB0bGIg
Zmx1c2ggd2hpbGUNCj4gPiBtNHUgcG93ZXIgb2ZmIGlzIHVubmVjZXNzYXJ5LCBqdXN0IHNraXAg
aXQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5j
b20+DQoNCi4uLg0KDQo+ID4gIA0KPiA+ICAJaWYgKGRhdGEtPnBsYXRfZGF0YS0+bTR1X3BsYXQg
PT0gTTRVX01UODE3Mykgew0KPiA+IEBAIC03MjgsNyArNzU2LDE1IEBAIHN0YXRpYyBpbnQgbXRr
X2lvbW11X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gIA0KPiA+ICAJ
cGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgZGF0YSk7DQo+ID4gIA0KPiA+ICsJaWYgKGRldi0+
cG1fZG9tYWluKQ0KPiA+ICsJCXBtX3J1bnRpbWVfZW5hYmxlKGRldik7DQo+IA0KPiBoaSB5b25n
LA0KPiANCj4gSWYgeW91IHB1dCAicG1fcnVudGltZV9lbmFibGUiIGhlcmUsIGl0IG1heWJlIG5v
dCBkZXZpY2VfbGluayB3aXRoDQo+IHNtaV9jb21tb24gZm9yIHByZXZpb3VzIHBhdGNoOiANCj4g
aWYoaSB8fCAhcG1fcnVudGltZV9lbmFibGVkKGRldikpDQo+ICAgICBjb250aW51ZTsNCj4gDQo+
IFdoZXRoZXIgcHV0IGl0IHVwIGZyb250Pw0KDQpUaGFua3MgZm9yIHJldmlldy4gTXkgZmF1bHQg
aGVyZS4gSSB3aWxsIGZpeCBpdC4NCg0KPiANCj4gYmVzdCByZWdhcmRzLA0KPiBjaGFvDQoNCg==

