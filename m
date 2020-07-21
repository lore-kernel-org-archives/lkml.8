Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AEBC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 550982080D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HbebthKh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgGUD3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 23:29:16 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:11938 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727849AbgGUD3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 23:29:15 -0400
X-UUID: 0efb29e786b24d63a65f5cad76c89a81-20200721
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=p5edfquzkRU6ceVF49k8bWT2pebXpZwumAzJ3c92oME=;
        b=HbebthKhqHugyLTk15GvvmaBqFjYhFtClpzYngY/SmiLNBq/GO0AdNBaIn6OJ4ukjfPqo5PAxuKOZ/tIYTUrEMmUPoqvdfZmVZszdBAke37RjKmcJRXjtL9ocfe1pBuCoK2wxM3Dt6x65LkKHdSdOy8ABs8E5i066/qJw25bsTo=;
X-UUID: 0efb29e786b24d63a65f5cad76c89a81-20200721
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 574409423; Tue, 21 Jul 2020 11:29:02 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 21 Jul
 2020 11:28:59 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 21 Jul 2020 11:28:58 +0800
Message-ID: <1595302076.16172.49.camel@mhfsdcap03>
Subject: Re: Re: [PATCH 04/21] dt-binding: mediatek: Add binding for mt8192
 IOMMU and SMI
From:   Yong Wu <yong.wu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     <youlin.pei@mediatek.com>, <devicetree@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <cui.zhang@mediatek.com>, <srv_heupstream@mediatek.com>,
        <chao.hao@mediatek.com>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>,
        "Tomasz Figa" <tfiga@google.com>,
        <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <ming-fan.chen@mediatek.com>, <anan.sun@mediatek.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 21 Jul 2020 11:27:56 +0800
In-Reply-To: <20200720231621.GA3106350@bogus>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
         <20200711064846.16007-5-yong.wu@mediatek.com>
         <20200720231621.GA3106350@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: D49D8E756E183EDB1F2B9E9AB572BFF9AED4A4D42C576D30129F7E826088FE652000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA3LTIwIGF0IDE3OjE2IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gU2F0LCBKdWwgMTEsIDIwMjAgYXQgMDI6NDg6MjlQTSArMDgwMCwgWW9uZyBXdSB3cm90ZToN
Cj4gPiBUaGlzIHBhdGNoIGFkZHMgZGVjcmlwdGlvbnMgZm9yIG10ODE5MiBJT01NVSBhbmQgU01J
Lg0KPiA+IA0KPiA+IG10ODE5MiBhbHNvIGlzIE1USyBJT01NVSBnZW4yIHdoaWNoIHVzZXMgQVJN
IFNob3J0LURlc2NyaXB0b3IgdHJhbnNsYXRpb24NCj4gPiB0YWJsZSBmb3JtYXQuIFRoZSBNNFUt
U01JIEhXIGRpYWdyYW0gaXMgYXMgYmVsb3c6DQo+ID4gDQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICBFTUkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICBNNFUNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgIC0tLS0tLS0tLS0tLQ0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgU01JIENvbW1vbg0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAtLS0tLS0t
LS0tLS0NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+ID4gICArLS0tLS0tLSst
LS0tLS0rLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLSsNCj4gPiAgIHwgICAg
ICAgfCAgICAgIHwgICAgICB8ICAgICAgIC4uLi4uLiAgICAgICAgIHwgICAgICAgfA0KPiA+ICAg
fCAgICAgICB8ICAgICAgfCAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICB8DQo+
ID4gbGFyYjAgICBsYXJiMSAgbGFyYjIgIGxhcmI0ICAgICAuLi4uLi4gICAgICBsYXJiMTkgICBs
YXJiMjANCj4gPiBkaXNwMCAgIGRpc3AxICAgbWRwICAgIHZkZWMgICAgICAgICAgICAgICAgICAg
SVBFICAgICAgSVBFDQo+ID4gDQo+ID4gQWxsIHRoZSBjb25uZWN0aW9ucyBhcmUgSFcgZml4ZWQs
IFNXIGNhbiBOT1QgYWRqdXN0IGl0Lg0KPiA+IA0KPiA+IG10ODE5MiBNNFUgc3VwcG9ydCAwfjE2
R0IgaW92YSByYW5nZS4gd2UgcHJlYXNzaWduIGRpZmZlcmVudCBlbmdpbmVzDQo+ID4gaW50byBk
aWZmZXJlbnQgaW92YSByYW5nZXM6DQo+ID4gDQo+ID4gZG9tYWluLWlkICBtb2R1bGUgICAgIGlv
dmEtcmFuZ2UgICAgICAgICAgICAgICAgICBsYXJicw0KPiA+ICAgIDAgICAgICAgZGlzcCAgICAg
ICAgMCB+IDRHICAgICAgICAgICAgICAgICAgICAgIGxhcmIwLzENCj4gPiAgICAxICAgICAgIHZj
b2RlYyAgICAgIDRHIH4gOEcgICAgICAgICAgICAgICAgICAgICBsYXJiNC81LzcNCj4gPiAgICAy
ICAgICAgIGNhbS9tZHAgICAgIDhHIH4gMTJHICAgICAgICAgICAgIGxhcmIyLzkvMTEvMTMvMTQv
MTYvMTcvMTgvMTkvMjANCj4gPiAgICAzICAgICAgIENDVTAgICAgMHg0MDAwXzAwMDAgfiAweDQz
ZmZfZmZmZiAgICAgbGFyYjEzOiBwb3J0IDkvMTANCj4gPiAgICA0ICAgICAgIENDVTEgICAgMHg0
NDAwXzAwMDAgfiAweDQ3ZmZfZmZmZiAgICAgbGFyYjE0OiBwb3J0IDQvNQ0KPiANCj4gWW91IHBy
b2JhYmx5IHdhbnQgdG8gdXNlIGRtYS1yYW5nZXMgZm9yIGRlZmluaW5nIHRoZXNlIA0KPiBhZGRy
ZXNzIHJlc3RyaWN0aW9ucy4gDQoNClllcy4gUGxlYXNlIHNlZSB0aGUgY29tbWl0IG1lc3NhZ2Ug
b2YgWzE4LzIxXSBpbiB0aGlzIHBhdGNoc2V0Lg0KDQo+IA0KPiBIb3cgaXMgdGhlIGRvbWFpbi1p
ZCB1c2VkIG9yIG5lZWRlZD8NCg0KSGVyZSB3ZSBhc3NpZ24gZGlmZmVyZW50IGxhcmIvcG9ydHMg
aW4gZGlmZmVyZW50IGlvdmEgcmFuZ2VzLg0KSW4gdGhlIGlvbW11IGRyaXZlciwgd2Ugd2lsbCBs
aXN0IHRoZSBpb3ZhIHJhbmdlcyBhcyBhYm92ZSBhbmQgdXNlIHRoZQ0KZG9tYWluLWlkIHRvIGdl
dCB0aGUgZGV0YWlsZWQgaW92YSByYW5nZSwgdGhlbiBjcmVhdGUgYSBpb21tdSBkb21haW4gZm9y
DQplYWNoIGEgaW92YSByYW5nZS4NCg0KRm9yIHRoZSBpb21tdSBtYXN0ZXJzLCBpdCBvbmx5IG5l
ZWQgdXNlIGl0cyBzcGVjaWFsIHBvcnQgaW4gaXRzIGR0c2kNCm5vZGUsIHRoZW4gdGhlIGlvdmEg
Z290IGZyb20gZG1hX2FsbG9jX2F0dHJzIGZvciB0aGF0IGRldmljZSB3aWxsIGxvY2F0ZQ0KaW4g
dGhlIHNwZWNpYWwgaW92YSByYW5nZXMuDQoNCj4gDQo+IFJvYiANCj4gDQo+IF9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IExpbnV4LW1lZGlhdGVrIG1h
aWxpbmcgbGlzdA0KPiBMaW51eC1tZWRpYXRla0BsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbWVkaWF0ZWsNCg0K

