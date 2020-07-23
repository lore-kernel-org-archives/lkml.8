Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8413C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B308B2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="n6mdgpCq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgGWIIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 04:08:20 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40435 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726597AbgGWIIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 04:08:20 -0400
X-UUID: f4aed0d3e2464b208f1a0d992a9d9f48-20200723
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=iHKeR/AeryDDzrZa62FayPp2h6VezjXi9BL3bT7aMkY=;
        b=n6mdgpCqbBYSubyISsSRKuf03LEc0qWHqYL8X2b1Thwkz461JsFtxLy1ZYbx09xlC1GByxTXT9TmVXsC9PkG6aErS7QvMIeku+6/1SY5YT98x55ep9EdSKwRoDwzj4zmwPflbfn4S2p9xh2ePHflu5uF0r5eB1sg3MICWDgYRgk=;
X-UUID: f4aed0d3e2464b208f1a0d992a9d9f48-20200723
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <wendell.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 965061598; Thu, 23 Jul 2020 16:08:15 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Jul 2020 16:08:13 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Jul 2020 16:08:13 +0800
Message-ID: <1595491694.17583.3.camel@mtkswgap22>
Subject: Re: [PATCH 1/2] clk: Export clk_register_composite
From:   Wendell Lin <wendell.lin@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Thu, 23 Jul 2020 16:08:14 +0800
In-Reply-To: <159442720733.1987609.12625915294903304595@swboyd.mtv.corp.google.com>
References: <1593588382-19049-1-git-send-email-wendell.lin@mediatek.com>
         <1593588382-19049-2-git-send-email-wendell.lin@mediatek.com>
         <159442720733.1987609.12625915294903304595@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTA3LTEwIGF0IDE3OjI2IC0wNzAwLCBTdGVwaGVuIEJveWQgd3JvdGU6DQo+
IFF1b3RpbmcgV2VuZGVsbCBMaW4gKDIwMjAtMDctMDEgMDA6MjY6MjEpDQo+ID4gY2xrX3JlZ2lz
dGVyX2NvbXBvc2l0ZSgpIHdpbGwgYmUgdXNlZCBpbiBtZWRpYXRlaydzDQo+ID4gY2xvY2sga2Vy
bmVsIG1vZHVsZSwgc28gZXhwb3J0IGl0IHRvIEdQTCBtb2R1bGVzLg0KPiA+IA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFdlbmRlbGwgTGluIDx3ZW5kZWxsLmxpbkBtZWRpYXRlay5jb20+DQo+ID4gLS0t
DQo+ID4gIGRyaXZlcnMvY2xrL2Nsay1jb21wb3NpdGUuYyB8ICAgIDEgKw0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9j
bGsvY2xrLWNvbXBvc2l0ZS5jIGIvZHJpdmVycy9jbGsvY2xrLWNvbXBvc2l0ZS5jDQo+ID4gaW5k
ZXggNzM3NmY1Ny4uZmI1Y2I0YSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Nsay9jbGstY29t
cG9zaXRlLmMNCj4gPiArKysgYi9kcml2ZXJzL2Nsay9jbGstY29tcG9zaXRlLmMNCj4gPiBAQCAt
MzYwLDYgKzM2MCw3IEBAIHN0cnVjdCBjbGsgKmNsa19yZWdpc3Rlcl9jb21wb3NpdGUoc3RydWN0
IGRldmljZSAqZGV2LCBjb25zdCBjaGFyICpuYW1lLA0KPiA+ICAgICAgICAgICAgICAgICByZXR1
cm4gRVJSX0NBU1QoaHcpOw0KPiA+ICAgICAgICAgcmV0dXJuIGh3LT5jbGs7DQo+ID4gIH0NCj4g
PiArRVhQT1JUX1NZTUJPTChjbGtfcmVnaXN0ZXJfY29tcG9zaXRlKTsNCj4gDQo+IFNob3VsZCBi
ZSBFWFBPUlRfU1lNQk9MX0dQTCgpDQoNCkdvdCBpdCwgSSdsbCBmaXggaXQuDQoNClJlZ2FyZHMs
DQpXZW5kZWxsDQoNCg==

