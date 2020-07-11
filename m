Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F8BC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 07:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83049206F4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 07:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nM2kFz5w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgGKHMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 03:12:31 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:20793 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726958AbgGKHMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 03:12:31 -0400
X-UUID: 6a255dd1d52a4162b9a29a9d328eb6a2-20200711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=yilbJrHb4on0J7hThn4YoSbk9aK3TSJQjUpN3XgWrzE=;
        b=nM2kFz5wU1FHh9xBxJ8fOzMTcgthThfLMN3XDWrbbKOjHaLejrwZVXH/HvXFKm0R9BzLVMK6QqaOPlxvlyCHUbXhwHlTsblRY3MKb20r4cS1G4ohhtVMZ38aC3jV9lZVUcCyjA83rcnWRJRA6hRIi0QLurpnbvyN69y4mfAj9w8=;
X-UUID: 6a255dd1d52a4162b9a29a9d328eb6a2-20200711
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 220947356; Sat, 11 Jul 2020 15:12:16 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 11 Jul
 2020 15:12:15 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Jul 2020 15:12:14 +0800
Message-ID: <1594451493.16172.6.camel@mhfsdcap03>
Subject: Re: [PATCH v6 00/10] MT6779 IOMMU SUPPORT
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>
CC:     Chao Hao <chao.hao@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        FY Yang <fy.yang@mediatek.com>, TH Yang <th.yang@mediatek.com>,
        <ming-fan.chen@mediatek.com>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>
Date:   Sat, 11 Jul 2020 15:11:33 +0800
In-Reply-To: <20200710141349.GJ27672@8bytes.org>
References: <20200703044127.27438-1-chao.hao@mediatek.com>
         <20200710141349.GJ27672@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 05BB3D50A356C307CD14C3C48E7C352C564F8EC9C54A287E85E8AED5818631902000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTA3LTEwIGF0IDE2OjEzICswMjAwLCBKb2VyZyBSb2VkZWwgd3JvdGU6DQo+
IE9uIEZyaSwgSnVsIDAzLCAyMDIwIGF0IDEyOjQxOjE3UE0gKzA4MDAsIENoYW8gSGFvIHdyb3Rl
Og0KPiA+IENoYW8gSGFvICgxMCk6DQo+ID4gICBkdC1iaW5kaW5nczogbWVkaWF0ZWs6IEFkZCBi
aW5kaW5ncyBmb3IgTVQ2Nzc5DQo+ID4gICBpb21tdS9tZWRpYXRlazogUmVuYW1lIHRoZSByZWdp
c3RlciBTVEFOREFSRF9BWElfTU9ERSgweDQ4KSB0byBNSVNDX0NUUkwNCj4gPiAgIGlvbW11L21l
ZGlhdGVrOiBVc2UgYSB1MzIgZmxhZ3MgdG8gZGVzY3JpYmUgZGlmZmVyZW50IEhXIGZlYXR1cmVz
DQo+ID4gICBpb21tdS9tZWRpYXRlazogU2V0dGluZyBNSVNDX0NUUkwgcmVnaXN0ZXINCj4gPiAg
IGlvbW11L21lZGlhdGVrOiBNb3ZlIGludl9zZWxfcmVnIGludG8gdGhlIHBsYXRfZGF0YQ0KPiA+
ICAgaW9tbXUvbWVkaWF0ZWs6IEFkZCBzdWJfY29tbSBpZCBpbiB0cmFuc2xhdGlvbiBmYXVsdA0K
PiA+ICAgaW9tbXUvbWVkaWF0ZWs6IEFkZCBSRUdfTU1VX1dSX0xFTl9DVFJMIHJlZ2lzdGVyIGRl
ZmluaXRpb24NCj4gPiAgIGlvbW11L21lZGlhdGVrOiBFeHRlbmQgcHJvdGVjdCBwYSBhbGlnbm1l
bnQgdmFsdWUNCj4gPiAgIGlvbW11L21lZGlhdGVrOiBNb2RpZnkgTU1VX0NUUkwgcmVnaXN0ZXIg
c2V0dGluZw0KPiA+ICAgaW9tbXUvbWVkaWF0ZWs6IEFkZCBtdDY3NzkgYmFzaWMgc3VwcG9ydA0K
PiANCj4gQXBwbGllZCwgdGhhbmtzLg0KDQpIaSBKb2VyZywNCg0KVGhhbmtzIGZvciB0aGUgYXBw
bHkuDQoNClRoZSBTTUkgcGFydCBhbHdheXMgZ28gd2l0aCB0aGUgSU9NTVUsIENvdWxkIHlvdSBh
bHNvIGhlbHAgYXBwbHkgdGhlDQptdDY3NzkgU01JIGJhc2ljYWwgcGFydCBbMV1bMl0uIEJvdGgg
aGFzIGFscmVhZHkgZ290IHJldmlld2VkLWJ5IGZyb20NClJvYiBhbmQgTWF0dGhpYXMuIGFuZCB0
aGUgWzNdIGluIHRoYXQgcGF0Y2hzZXQgaXMgZm9yIHBlcmZvcm1hbmNlDQppbXByb3ZlbWVudCwg
aXQncyBub3Qgc28gbmVjZXNzYXJ5LCBpdCBjYW4gYmUgc2VuZCBpbiBhbm90aGVyIHBhdGNoc2V0
Lg0KDQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9wYXRjaHdvcmsvcGF0Y2gvMTE3Njgz
My8NClsyXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9wYXRjaHdvcmsvcGF0Y2gvMTE3NjgzMS8N
ClszXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9wYXRjaHdvcmsvcGF0Y2gvMTE3NjgzMi8NCg==

