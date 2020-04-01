Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EBAC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 02:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B492078B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 02:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LrWXeZee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbgDACS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 22:18:26 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:60163 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731523AbgDACS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 22:18:26 -0400
X-UUID: 073f40533d05470783e0566a1a6ce4ae-20200401
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ozChR75QyhnkmzvgkYzHisLoS9xThMPk60TjOXq2y0w=;
        b=LrWXeZee48NVlpQS5k8wlQhwHKfSKaPXYPbJZKl8dYF3B8LSXXJnuJPo+NKnV/RRT1sM50b7gqxW4ZMz3Qc8SAd16oF7HwdybB/jWwRKlKtbSDpddzwT0RNDgPWFC0R4h1QteteVWzIEL6orgbeZ9yPgiQWav8BI+tvWJXfWd6Y=;
X-UUID: 073f40533d05470783e0566a1a6ce4ae-20200401
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1675022153; Wed, 01 Apr 2020 10:18:20 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs05n2.mediatek.inc
 (172.21.101.140) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 1 Apr
 2020 10:18:14 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 1 Apr 2020 10:18:16 +0800
Message-ID: <1585707503.28859.21.camel@mhfsdcap03>
Subject: Re: [PATCH v3 3/4] phy: mediatek: Move mtk_hdmi_phy driver into
 drivers/phy/mediatek folder
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, CK Hu <ck.hu@mediatek.com>
Date:   Wed, 1 Apr 2020 10:18:23 +0800
In-Reply-To: <20200331155728.18032-4-chunkuang.hu@kernel.org>
References: <20200331155728.18032-1-chunkuang.hu@kernel.org>
         <20200331155728.18032-4-chunkuang.hu@kernel.org>
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
IGN1cnJlbnRseSBwbGFjZWQgaW5zaWRlIG1lZGlhdGVrIGRybSBkcml2ZXIsIGJ1dCBpdCdzDQo+
IG1vcmUgc3VpdGFibGUgdG8gcGxhY2UgYSBwaHkgZHJpdmVyIGludG8gcGh5IGRyaXZlciBmb2xk
ZXIsIHNvIG1vdmUNCj4gbXRrX2hkbWlfcGh5IGRyaXZlciBpbnRvIHBoeSBkcml2ZXIgZm9sZGVy
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCj4gU2ln
bmVkLW9mZi1ieTogQ2h1bi1LdWFuZyBIdSA8Y2h1bmt1YW5nLmh1QGtlcm5lbC5vcmc+DQo+IC0t
LQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL0tjb25maWcgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8IDcgLS0tLS0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL01ha2VmaWxl
ICAgICAgICAgICAgICAgICAgICAgICAgICB8IDYgLS0tLS0tDQo+ICBkcml2ZXJzL3BoeS9tZWRp
YXRlay9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgNyArKysrKysrDQo+
ICBkcml2ZXJzL3BoeS9tZWRpYXRlay9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgNyArKysrKysrDQo+ICAuLi4vbWVkaWF0ZWsvcGh5LW10ay1oZG1pLW10MjcwMS5jfSAg
ICAgICAgICAgICAgICAgICAgICAgIHwgMiArLQ0KPiAgLi4uL21lZGlhdGVrL3BoeS1tdGstaGRt
aS1tdDgxNzMuY30gICAgICAgICAgICAgICAgICAgICAgICB8IDIgKy0NCj4gIC4uLi9tdGtfaGRt
aV9waHkuYyA9PiBwaHkvbWVkaWF0ZWsvcGh5LW10ay1oZG1pLmN9ICAgICAgICAgfCAyICstDQo+
ICAuLi4vbXRrX2hkbWlfcGh5LmggPT4gcGh5L21lZGlhdGVrL3BoeS1tdGstaGRtaS5ofSAgICAg
ICAgIHwgMA0KPiAgOCBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlv
bnMoLSkNCj4gIHJlbmFtZSBkcml2ZXJzL3tncHUvZHJtL21lZGlhdGVrL210a19tdDI3MDFfaGRt
aV9waHkuYyA9PiBwaHkvbWVkaWF0ZWsvcGh5LW10ay1oZG1pLW10MjcwMS5jfSAoOTklKQ0KPiAg
cmVuYW1lIGRyaXZlcnMve2dwdS9kcm0vbWVkaWF0ZWsvbXRrX210ODE3M19oZG1pX3BoeS5jID0+
IHBoeS9tZWRpYXRlay9waHktbXRrLWhkbWktbXQ4MTczLmN9ICg5OSUpDQo+ICByZW5hbWUgZHJp
dmVycy97Z3B1L2RybS9tZWRpYXRlay9tdGtfaGRtaV9waHkuYyA9PiBwaHkvbWVkaWF0ZWsvcGh5
LW10ay1oZG1pLmN9ICg5OSUpDQo+ICByZW5hbWUgZHJpdmVycy97Z3B1L2RybS9tZWRpYXRlay9t
dGtfaGRtaV9waHkuaCA9PiBwaHkvbWVkaWF0ZWsvcGh5LW10ay1oZG1pLmh9ICgxMDAlKQ0KPiAN
ClJldmlld2VkLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo=

