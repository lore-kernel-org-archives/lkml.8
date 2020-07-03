Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BB2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 01:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72D0420B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 01:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gTpT5exU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgGCBlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 21:41:52 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:45582 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726028AbgGCBlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 21:41:51 -0400
X-UUID: ca18e9f1428243f9bbdd55803ab32466-20200703
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=sUHdggt26F3MOMSAq41fK1KG/YmQcbQ9D5Hb4j4vHwE=;
        b=gTpT5exURc8zkpN1I2YB09E+U1WngkCfzhZbBniWYXIIouonZMOUHgZv1apcRyPZx4fI1x7Mx9tvlA8vXU3qn7JJ20luTSuI2eVOHEFpcDkoL5uc5qw9dKZkhpb5ZyH5w40FmtHW0aaoTLiAOtBiC+l3mMAHulyZHqXFrW0jpjI=;
X-UUID: ca18e9f1428243f9bbdd55803ab32466-20200703
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1849453336; Fri, 03 Jul 2020 09:41:35 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 3 Jul
 2020 09:41:30 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 3 Jul 2020 09:41:30 +0800
Message-ID: <1593740465.23885.19.camel@mhfsdcap03>
Subject: Re: [PATCH 16/30] usb: mtu3: mtu3_trace: Function headers are not
 suitable for kerneldoc
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 3 Jul 2020 09:41:05 +0800
In-Reply-To: <20200702144625.2533530-17-lee.jones@linaro.org>
References: <20200702144625.2533530-1-lee.jones@linaro.org>
         <20200702144625.2533530-17-lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 6C16EDA848D1FBDB58785863678FD0E8CB02C388F192B15DB8BCAD8D1E917B032000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA3LTAyIGF0IDE1OjQ2ICswMTAwLCBMZWUgSm9uZXMgd3JvdGU6DQo+IEZp
eGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3YXJuaW5nczoNCj4gDQo+ICBkcml2
ZXJzL3VzYi9tdHUzL210dTNfdHJhY2UuYzoxMzo2OiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90
b3R5cGUgZm9yIOKAmG10dTNfZGJnX3RyYWNl4oCZIFstV21pc3NpbmctcHJvdG90eXBlc10NCj4g
IDEzIHwgdm9pZCBtdHUzX2RiZ190cmFjZShzdHJ1Y3QgZGV2aWNlICpkZXYsIGNvbnN0IGNoYXIg
KmZtdCwgLi4uKQ0KPiAgfCBefn5+fn5+fn5+fn5+fg0KVGhlIGRlc2NyaXB0aW9uIGRvZXNuJ3Qg
bWF0Y2ggd2l0aCB0aGUgdGl0bGUgYW5kIGNvZGUgY2hhbmdlcw0KDQo+IA0KPiBDYzogQ2h1bmZl
bmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KPiBDYzogbGludXgtbWVkaWF0ZWtA
bGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25l
c0BsaW5hcm8ub3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL210dTMvbXR1M190cmFjZS5jIHwg
MiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvbXR1My9tdHUzX3RyYWNlLmMgYi9kcml2ZXJz
L3VzYi9tdHUzL210dTNfdHJhY2UuYw0KPiBpbmRleCA0ZjVlNzg1N2VjMzEyLi4xNTVlYWUxMjZl
NWUyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9tdHUzL210dTNfdHJhY2UuYw0KPiArKysg
Yi9kcml2ZXJzL3VzYi9tdHUzL210dTNfdHJhY2UuYw0KPiBAQCAtMSw1ICsxLDUgQEANCj4gIC8v
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+IC0vKioNCj4gKy8qDQo+ICAgKiBt
dHUzX3RyYWNlLmMgLSB0cmFjZSBzdXBwb3J0DQo+ICAgKg0KPiAgICogQ29weXJpZ2h0IChDKSAy
MDE5IE1lZGlhVGVrIEluYy4NCg0K

