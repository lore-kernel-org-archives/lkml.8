Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654B0C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 02:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336E52078B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 02:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eO/MFYa0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731647AbgDACUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 22:20:25 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:60423 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731531AbgDACUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 22:20:24 -0400
X-UUID: 88d619244fdd4ff5bc346702305f340f-20200401
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=EVfDkcSg67rWMGV0bZzmWDij5Lm1irRxXDFbaSycSd8=;
        b=eO/MFYa00Q6WgesBbYWNB5OWpjs0CKgLw5n4bvRtbIpchNoyCqDPKhmqzQ0iDZTwGHWIZ9pdKozf4dB5tNHIzLYwbqtU05c6ZkNurOxGr+hT3A2ns9TFKebVss5l47u8EUgFHSE16YdNEKCemeh4SimYzVdh4wTDZRJBoFpTQH8=;
X-UUID: 88d619244fdd4ff5bc346702305f340f-20200401
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1947929388; Wed, 01 Apr 2020 10:20:21 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs05n1.mediatek.inc
 (172.21.101.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 1 Apr
 2020 10:20:19 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 1 Apr 2020 10:20:17 +0800
Message-ID: <1585707625.28859.23.camel@mhfsdcap03>
Subject: Re: [PATCH v3 2/4] drm/mediatek: Separate mtk_hdmi_phy to an
 independent module
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, CK Hu <ck.hu@mediatek.com>
Date:   Wed, 1 Apr 2020 10:20:25 +0800
In-Reply-To: <20200331155728.18032-3-chunkuang.hu@kernel.org>
References: <20200331155728.18032-1-chunkuang.hu@kernel.org>
         <20200331155728.18032-3-chunkuang.hu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTAzLTMxIGF0IDIzOjU3ICswODAwLCBDaHVuLUt1YW5nIEh1IHdyb3RlOg0K
PiBGcm9tOiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KPiANCj4gbXRrX2hkbWlfcGh5IGlz
IGEgcGFydCBvZiBtdGtfaGRtaSBtb2R1bGUsIGJ1dCBwaHkgZHJpdmVyIHNob3VsZCBiZSBhbg0K
PiBpbmRlcGVuZGVudCBtb2R1bGUgcmF0aGVyIHRoYW4gYmUgcGFydCBvZiBkcm0gbW9kdWxlLCBz
byBzZXBhcmF0ZSB0aGUgcGh5DQo+IGRyaXZlciB0byBhbiBpbmRlcGVuZGVudCBtb2R1bGUuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KPiBTaWduZWQt
b2ZmLWJ5OiBDaHVuLUt1YW5nIEh1IDxjaHVua3VhbmcuaHVAa2VybmVsLm9yZz4NCj4gLS0tDQo+
ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvS2NvbmZpZyAgICAgICAgfCAgOSArKysrKysrKy0N
Cj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9NYWtlZmlsZSAgICAgICB8IDExICsrKysrKyst
LS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2hkbWkuYyAgICAgfCAgMiArLQ0K
PiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1pLmggICAgIHwgIDEgLQ0KPiAgZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1pX3BoeS5jIHwgIDEgKw0KPiAgZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19oZG1pX3BoeS5oIHwgIDEgLQ0KPiAgNiBmaWxlcyBjaGFuZ2Vk
LCAxNyBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KUmV2aWV3ZWQtYnk6IENodW5mZW5n
IFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCg0KVGhhbmtzIGEgbG90DQoNCg==

