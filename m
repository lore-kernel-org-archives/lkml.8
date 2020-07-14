Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A443C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7831A212CC
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qga6wQmn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgGNJeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:34:04 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:34604 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726889AbgGNJeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:34:02 -0400
X-UUID: 294ffe915ddd4f2ebdd084d2a09cb58b-20200714
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=g0vfCKfsVImSYs7pBa71fJvZ3L9cSxC+jFd3c5Ar0OA=;
        b=qga6wQmnl6LFOkFK300s5TBJueZg6wKqfCxqm5ApKl/ZRsDH9DFKNGfON9o0N811mIV5nbnXtOhLq1skUUp1gl8KFO7yK+XzxmK+qHBqDCq+Tf2eYe/t2m2HpEiDShWesjx0GfIE2m3D5iou3wiEwCOHQkXt+aM8yocisuLvyqU=;
X-UUID: 294ffe915ddd4f2ebdd084d2a09cb58b-20200714
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1789059505; Tue, 14 Jul 2020 17:33:57 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 14 Jul
 2020 17:33:55 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Jul 2020 17:33:54 +0800
Message-ID: <1594719186.16172.35.camel@mhfsdcap03>
Subject: Re: [PATCH 11/21] iommu/mediatek: Add power-domain operation
From:   Yong Wu <yong.wu@mediatek.com>
To:     Pi-Hsun Shih <pihsun@chromium.org>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
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
Date:   Tue, 14 Jul 2020 17:33:06 +0800
In-Reply-To: <CANdKZ0e3=AeCxpSHVk7daUE01L7AgJYmZ7jeOQDT169SaowL-g@mail.gmail.com>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
         <20200711064846.16007-12-yong.wu@mediatek.com>
         <CANdKZ0e3=AeCxpSHVk7daUE01L7AgJYmZ7jeOQDT169SaowL-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 4A868CC5672C9E09033785D03A34B39C2AB230B1DC2A9B4BD748D338AF6B73A92000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA3LTEzIGF0IDE1OjAzICswODAwLCBQaS1Ic3VuIFNoaWggd3JvdGU6DQo+
IE9uIFNhdCwgSnVsIDExLCAyMDIwIGF0IDI6NTEgUE0gWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRl
ay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSW4gdGhlIHByZXZpb3VzIFNvQywgdGhlIE00VSBIVyBp
cyBpbiB0aGUgRU1JIHBvd2VyIGRvbWFpbiB3aGljaCBpcw0KPiA+IGFsd2F5cyBvbi4gdGhlIGxh
dGVzdCBNNFUgaXMgaW4gdGhlIGRpc3BsYXkgcG93ZXIgZG9tYWluIHdoaWNoIG1heSBiZQ0KPiA+
IHR1cm5lZCBvbi9vZmYsIHRodXMgd2UgaGF2ZSB0byBhZGQgcG1fcnVudGltZSBpbnRlcmZhY2Ug
Zm9yIGl0Lg0KPiA+DQo+ID4gd2Ugc2hvdWxkIGVuYWJsZSBpdHMgcG93ZXIgYmVmb3JlIE00VSBo
dyBpbml0aWFsLiBhbmQgZGlzYWJsZSBpdCBhZnRlciBIVw0KPiA+IGluaXRpYWxpemUuDQo+ID4N
Cj4gPiBXaGVuIHRoZSBlbmdpbmUgd29yaywgdGhlIGVuZ2luZSBhbHdheXMgZW5hYmxlIHRoZSBw
b3dlciBhbmQgY2xvY2tzIGZvcg0KPiA+IHNtaS1sYXJiL3NtaS1jb21tb24sIHRoZW4gdGhlIE00
VSdzIHBvd2VyIHdpbGwgYWx3YXlzIGJlIHBvd2VyZWQgb24NCj4gPiBhdXRvbWF0aWNhbGx5IHZp
YSB0aGUgZGV2aWNlIGxpbmsgd2l0aCBzbWktY29tbW9uLg0KPiA+DQo+ID4gTm90ZTogd2UgZG9u
J3QgZW5hYmxlIHRoZSBNNFUgcG93ZXIgaW4gaW9tbXVfbWFwL3VubWFwIGZvciB0bGIgZmx1c2gu
DQo+ID4gSWYgaXRzIHBvd2VyIGFscmVhZHkgaXMgb24sIG9mIGNvdXJzZSBpdCBpcyBvay4gaWYg
dGhlIHBvd2VyIGlzIG9mZiwNCj4gPiB0aGUgbWFpbiB0bGIgd2lsbCBiZSByZXNldCB3aGlsZSBN
NFUgcG93ZXIgb24sIHRodXMgdGhlIHRsYiBmbHVzaCB3aGlsZQ0KPiA+IG00dSBwb3dlciBvZmYg
aXMgdW5uZWNlc3NhcnksIGp1c3Qgc2tpcCBpdC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlv
bmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2lvbW11
L210a19pb21tdS5jIHwgNTQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0NyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0K
PiA+IC4uLg0KPiA+ICAgICAgICAgZm9yX2VhY2hfbTR1KGRhdGEpIHsNCj4gPiArICAgICAgICAg
ICAgICAgLyogc2tpcCB0bGIgZmx1c2ggd2hlbiBwbSBpcyBub3QgYWN0aXZlICovDQo+ID4gKyAg
ICAgICAgICAgICAgIGlmIChwbV9ydW50aW1lX2VuYWJsZWQoZGF0YS0+ZGV2KSAmJg0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgIXBtX3J1bnRpbWVfYWN0aXZlKGRhdGEtPmRldikpDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+ID4gKw0KPiANCj4gcG1fcnVudGltZV9h
Y3RpdmUoZGV2KSA9PSBmYWxzZSBpbXBsaWVzIGRldi0+cG93ZXIuZGlzYWJsZV9kZXB0aCA9PSAw
LA0KPiB3aGljaCBpbXBsaWVzIHBtX3J1bnRpbWVfZW5hYmxlZChkZXYpID09IHRydWUsIHNvIHRo
ZQ0KPiBwbV9ydW50aW1lX2VuYWJsZWQoZGF0YS0+ZGV2KSBjYW4gYmUgb21pdHRlZCBoZXJlLg0K
DQpZZXMuIFRoYW5rcy4NCldpbGwgZml4IGluIG5leHQgdmVyc2lvbi4NCg0KPiANCj4gPiAgICAg
ICAgICAgICAgICAgc3Bpbl9sb2NrX2lycXNhdmUoJmRhdGEtPnRsYl9sb2NrLCBmbGFncyk7DQo+
ID4gICAgICAgICAgICAgICAgIHdyaXRlbF9yZWxheGVkKEZfSU5WTERfRU4xIHwgRl9JTlZMRF9F
TjAsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRhdGEtPmJhc2UgKyBkYXRh
LT5wbGF0X2RhdGEtPmludl9zZWxfcmVnKTsNCj4gPiAuLi4NCg0K

