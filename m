Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054C4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 09:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF3542070B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 09:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eeEIpWvS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgHJJga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 05:36:30 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:11038 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725809AbgHJJg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 05:36:29 -0400
X-UUID: 961db87e583542018ad200db35459a15-20200810
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=VwRgWjEdkPYGkWZKNJSxx1FhonydZDDe5W6HPLrIeDY=;
        b=eeEIpWvS96ga53cQzaNwO/MvUBF8zz1atKtNYY7cJmUcqxBmKHQcHUu0K5ycnuVXCq/zkJfe80j3nANG4mDhzL28sHSuTqop1eNwcSufHtxqL4tYHOiKZ9b91D45Kbpe+We/CeXO+bUFZYV85vVZorq48Tun943h9wkxLUCeN5Q=;
X-UUID: 961db87e583542018ad200db35459a15-20200810
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <wendell.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 746720287; Mon, 10 Aug 2020 17:36:27 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 10 Aug 2020 17:36:24 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 10 Aug 2020 17:36:25 +0800
Message-ID: <1597052186.27843.1.camel@mtkswgap22>
Subject: Re: [PATCH 1/1] clk: Export clk_register_composite
From:   Wendell Lin <wendell.lin@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <wsd_upstream@mediatek.com>
Date:   Mon, 10 Aug 2020 17:36:26 +0800
In-Reply-To: <1595493126-21611-1-git-send-email-wendell.lin@mediatek.com>
References: <1595493126-21611-1-git-send-email-wendell.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGhpYXMgYW5kIGFsbCwNCg0KR2VudGxlIHBpbmcgb24gdGhpcyBwYXRjaC4NCg0KVGhh
bmtzDQoNCldlbmRlbGwgTGluDQoNCg0KT24gVGh1LCAyMDIwLTA3LTIzIGF0IDE2OjMyICswODAw
LCBXZW5kZWxsIExpbiB3cm90ZToNCj4gY2xrX3JlZ2lzdGVyX2NvbXBvc2l0ZSgpIHdpbGwgYmUg
dXNlZCBpbiBtZWRpYXRlaydzDQo+IGNsb2NrIGtlcm5lbCBtb2R1bGUsIHNvIGV4cG9ydCBpdCB0
byBHUEwgbW9kdWxlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFdlbmRlbGwgTGluIDx3ZW5kZWxs
LmxpbkBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9jbGsvY2xrLWNvbXBvc2l0ZS5j
IHwgICAgMSArDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2Nsay9jbGstY29tcG9zaXRlLmMgYi9kcml2ZXJzL2Nsay9jbGstY29t
cG9zaXRlLmMNCj4gaW5kZXggNzM3NmY1Ny4uN2M2MDljMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9jbGsvY2xrLWNvbXBvc2l0ZS5jDQo+ICsrKyBiL2RyaXZlcnMvY2xrL2Nsay1jb21wb3NpdGUu
Yw0KPiBAQCAtMzYwLDYgKzM2MCw3IEBAIHN0cnVjdCBjbGsgKmNsa19yZWdpc3Rlcl9jb21wb3Np
dGUoc3RydWN0IGRldmljZSAqZGV2LCBjb25zdCBjaGFyICpuYW1lLA0KPiAgCQlyZXR1cm4gRVJS
X0NBU1QoaHcpOw0KPiAgCXJldHVybiBody0+Y2xrOw0KPiAgfQ0KPiArRVhQT1JUX1NZTUJPTF9H
UEwoY2xrX3JlZ2lzdGVyX2NvbXBvc2l0ZSk7DQo+ICANCj4gIHN0cnVjdCBjbGsgKmNsa19yZWdp
c3Rlcl9jb21wb3NpdGVfcGRhdGEoc3RydWN0IGRldmljZSAqZGV2LCBjb25zdCBjaGFyICpuYW1l
LA0KPiAgCQkJY29uc3Qgc3RydWN0IGNsa19wYXJlbnRfZGF0YSAqcGFyZW50X2RhdGEsDQoNCg==

