Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3489DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 06:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C2FB207D5
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 06:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oFs3Ny0O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgFEGEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 02:04:30 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:3601 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725962AbgFEGE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 02:04:29 -0400
X-UUID: e14f76053beb48bdbb8fddce40959679-20200605
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=5zTg+Ae3aI1oUNdcUL6hKGmNs4wF6e1l6u5UQkutTio=;
        b=oFs3Ny0Ob60ZMWSxzSRXOV/zfLBO7m3HchUR7My58YphoF8wMAzqtny8E4uI4SWIZ+NPuE+vuqybkFLHr8MZF1ZwNnyHZGDqJkBfUGMXP20FQykTnCo4ULKTQN+lTrB1q9rK6V054rDhxymkxVNAg1e/HOlHJvI/Ja7lp2CdcH4=;
X-UUID: e14f76053beb48bdbb8fddce40959679-20200605
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <xia.jiang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1031911475; Fri, 05 Jun 2020 14:04:23 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 5 Jun
 2020 14:04:21 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 5 Jun 2020 14:04:19 +0800
Message-ID: <1591336937.31802.2.camel@mhfsdcap03>
Subject: Re: [PATCH v8 04/14] media: platform: Change the fixed device node
 number to unfixed value
From:   Xia Jiang <xia.jiang@mediatek.com>
To:     Tomasz Figa <tfiga@chromium.org>
CC:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Rick Chang <rick.chang@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        <srv_heupstream@mediatek.com>, <senozhatsky@chromium.org>,
        <mojahsu@chromium.org>, <drinkcat@chromium.org>,
        <maoguang.meng@mediatek.com>, <sj.huang@mediatek.com>
Date:   Fri, 5 Jun 2020 14:02:17 +0800
In-Reply-To: <20200521135937.GD209565@chromium.org>
References: <20200403094033.8288-1-xia.jiang@mediatek.com>
         <20200403094033.8288-5-xia.jiang@mediatek.com>
         <20200521135937.GD209565@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: C643C80CC609DDC425F0E80F5429FEB6BC9807E21373CF433474C9660B3CCD582000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA1LTIxIGF0IDEzOjU5ICswMDAwLCBUb21hc3ogRmlnYSB3cm90ZToNCj4g
SGkgWGlhLA0KPiANCj4gT24gRnJpLCBBcHIgMDMsIDIwMjAgYXQgMDU6NDA6MjNQTSArMDgwMCwg
WGlhIEppYW5nIHdyb3RlOg0KPiA+IENoYW5nZSBkZXZpY2Ugbm9kZSBudW1iZXIgZnJvbSAzIHRv
IC0xIGJlY2F1c2UgdGhhdCB0aGUgZHJpdmVyIHdpbGwNCj4gPiBhbHNvIHN1cHBvcnQganBlZyBl
bmNvZGVyLg0KPiA+IA0KPiANCj4gVGhhbmtzIGZvciB0aGUgcGF0Y2guIFRoZSBjaGFuZ2UgaXMg
Y29ycmVjdCwgYnV0IEkgdGhpbmsgdGhlIGNvbW1pdA0KPiBtZXNzYWdlIGRvZXNuJ3QgcmVhbGx5
IGV4cGxhaW4gdGhlIHJlYWwgcmVhc29uIGZvciBpdC4gUGVyaGFwcyBzb21ldGhpbmcNCj4gbGlr
ZQ0KPiANCj4gIlRoZSBkcml2ZXIgY2FuIGJlIGluc3RhbnRpYXRlZCBtdWx0aXBsZSB0aW1lcywg
ZS5nLiBmb3IgYSBkZWNvZGVyIGFuZA0KPiBhbiBlbmNvZGVyLiBNb3Jlb3Zlciwgb3RoZXIgZHJp
dmVycyBjb3VsZCBjb2V4aXN0IG9uIHRoZSBzYW1lIHN5c3RlbS4NCj4gVGhpcyBtYWtlcyB0aGUg
c3RhdGljIHZpZGVvIG5vZGUgbnVtYmVyIGFzc2lnbm1lbnQgcG9pbnRsZXNzLCBzbyBzd2l0Y2gN
Cj4gdG8gYXV0b21hdGljIGFzc2lnbm1lbnQgaW5zdGVhZC4iDQo+IA0KPiBXRFlUPw0KRGVhciBU
b21hc3osDQpUaGFua3MgZm9yIHlvdXIgYWR2aWNlLkkgaGF2ZSBjaGFuZ2VkIGl0IGluIG5ldyB2
OSAuDQoNCkJlc3QgUmVnYXJkcywNClhpYSBKaWFuZw0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBU
b21hc3oNCg0K

