Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9749FC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76E7E2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="I0lhH+Sg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgGNJdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:33:55 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:42253 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725884AbgGNJdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:33:54 -0400
X-UUID: 03cb09f6c67347d4bd174cae1c380851-20200714
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=k1s7sjnnsRye1CFdb6q0XzdF7nQsqyfBB1IhxQ2urWM=;
        b=I0lhH+SgvmpVYRsa1E8cdyHfe2AuG/Qfq59D7x4V0Xq7oNnoXNT5Z+MVFpgFPN3M5eyulToc4tuqz1y4YHjhZwKmiBMIQG24M+WGajW4otv82ZBmBuEz3X77+92ieROMdmh3OGIh+9dXBLvgYT/4yIUnthElkq7mdi5YyidF3/Y=;
X-UUID: 03cb09f6c67347d4bd174cae1c380851-20200714
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 220981910; Tue, 14 Jul 2020 17:33:48 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 14 Jul
 2020 17:33:47 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Jul 2020 17:33:45 +0800
Message-ID: <1594719177.16172.33.camel@mhfsdcap03>
Subject: Re: [PATCH 12/21] iommu/mediatek: Add iova reserved function
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
        <chao.hao@mediatek.com>, <ming-fan.chen@mediatek.com>,
        Hao Chao <hao.chao@mediatek.com>
Date:   Tue, 14 Jul 2020 17:32:57 +0800
In-Reply-To: <CANdKZ0d8CSWQepCj9RFFxrvYq8K8G=oZCnskRiA3aY3gY-DD=w@mail.gmail.com>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
         <20200711064846.16007-13-yong.wu@mediatek.com>
         <CANdKZ0d8CSWQepCj9RFFxrvYq8K8G=oZCnskRiA3aY3gY-DD=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: DEC085A44EA7D3545BF3F8F5EDD48DA486042A01F90A9595EFE295D355A786BF2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA3LTEzIGF0IDE1OjMzICswODAwLCBQaS1Ic3VuIFNoaWggd3JvdGU6DQo+
IE9uIFNhdCwgSnVsIDExLCAyMDIwIGF0IDI6NTEgUE0gWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRl
ay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRm9yIG11bHRpcGxlIGlvbW11X2RvbWFpbnMsIHdlIG5l
ZWQgdG8gcmVzZXJ2ZSBzb21lIGlvdmEgcmVnaW9ucywgc28gd2UNCj4gPiB3aWxsIGFkZCBtdGtf
aW9tbXVfaW92YV9yZWdpb24gc3RydWN0dXJlLiBJdCBpbmNsdWRlcyB0aGUgYmFzZSBhZGRyZXNz
DQo+ID4gYW5kIHNpemUgb2YgdGhlIHJhbmdlLg0KPiA+IFRoaXMgaXMgYSBwcmVwYXJpbmcgcGF0
Y2ggZm9yIHN1cHBvcnRpbmcgbXVsdGktZG9tYWluLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
QW5hbiBzdW48YW5hbi5zdW5AbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhhbyBD
aGFvPGhhby5jaGFvQG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZb25nIFd1IDx5
b25nLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9pb21tdS9tdGtfaW9t
bXUuYyB8IDM3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgZHJp
dmVycy9pb21tdS9tdGtfaW9tbXUuaCB8ICA1ICsrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwg
NDIgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRr
X2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+ID4gaW5kZXggMDNhNmQ2NmY0
YmVmLi5mZGZkYjc1NzA2ZTAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9t
bXUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gPiBAQCAtMTUxLDYg
KzE1MSwxMSBAQCBzdGF0aWMgTElTVF9IRUFEKG00dWxpc3QpOyAvKiBMaXN0IGFsbCB0aGUgTTRV
IEhXcyAqLw0KPiA+IC4uLg0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgbXRrX2lvbW11X3B1dF9y
ZXN2X3JlZ2lvbnMoc3RydWN0IGRldmljZSAqZGV2LA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHN0cnVjdCBsaXN0X2hlYWQgKmhlYWQpDQo+ID4gK3sNCj4gPiAr
ICAgICAgIHN0cnVjdCBpb21tdV9yZXN2X3JlZ2lvbiAqZW50cnksICpuZXh0Ow0KPiA+ICsNCj4g
PiArICAgICAgIGxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShlbnRyeSwgbmV4dCwgaGVhZCwgbGlz
dCkNCj4gPiArICAgICAgICAgICAgICAga2ZyZWUoZW50cnkpOw0KPiA+ICt9DQo+ID4gKw0KPiAN
Cj4gVGhpcyBpcyB0aGUgc2FtZSBhcyBnZW5lcmljX2lvbW11X3B1dF9yZXN2X3JlZ2lvbnMsIHVz
ZSB0aGF0IGFzIHRoZQ0KPiAucHV0X3Jlc3ZfcmVnaW9ucyBjYWxsYmFjayBpbnN0ZWFkPw0KDQpU
aGFua3MgdmVyeSBtdWNoIGZvciB0aGUgcmV2aWV3Lg0KDQpZZXMuIEkgd2lsbCBmaXggaXQgaW4g
bmV4dCB2ZXJzaW9uLg0KDQo+IA0KPiA+IC4uLg0KPiA+IC0tDQo+ID4gMi4xOC4wDQoNCg==

