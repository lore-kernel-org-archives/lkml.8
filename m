Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3742FC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 08:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C311208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 08:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MlgjgnoI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgBJIbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 03:31:04 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:26053 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726968AbgBJIbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 03:31:04 -0500
X-UUID: 5b9bbc56cfdc4bba9c29251cc2c3084e-20200210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Jme6XnUcV22sv+Lb0GfidwDPAVP5wJkTpFliBwJ3cpI=;
        b=MlgjgnoIA4AD4sGad07cNjNs9aeX4kPOkUBvg6aJe/XqqKbp6z7t+WdI8EyBQG7wwk4xzFLVfTa+JAxwf9PZ2n7AHIwcbS7t1WZ32/TY3Vt36qp+4oPBYAJm/RO/vCS/hK5rMBvIQNeNet3kupcf44gHZJvloGaQBGVgtKNZf/Y=;
X-UUID: 5b9bbc56cfdc4bba9c29251cc2c3084e-20200210
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <yingjoe.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 878928057; Mon, 10 Feb 2020 16:30:57 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 10 Feb 2020 16:31:39 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by mtkcas08.mediatek.inc
 (172.21.101.126) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 10 Feb
 2020 16:31:12 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 10 Feb 2020 16:31:12 +0800
Message-ID: <1581323455.2213.6.camel@mtksdaap41>
Subject: Re: [PATCH v2] mtd: mtk-quadspi: add support for DMA reading
From:   Yingjoe Chen <yingjoe.chen@mediatek.com>
To:     Chuanhong Guo <gch981213@gmail.com>
CC:     <linux-mtd@lists.infradead.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 10 Feb 2020 16:30:55 +0800
In-Reply-To: <20200208084022.193231-1-gch981213@gmail.com>
References: <20200208084022.193231-1-gch981213@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIwLTAyLTA4IGF0IDE2OjQwICswODAwLCBDaHVhbmhvbmcgR3VvIHdyb3RlOg0K
PiBQSU8gcmVhZGluZyBtb2RlIG9uIHRoaXMgY29udHJvbGxlciBpcyBwcmV0dHkgaW5lZmZpY2ll
bnQNCj4gKG9uZSBjbWQrYWRkcitkdW1teSBzZXF1ZW5jZSByZWFkcyBvbmx5IG9uZSBieXRlKQ0K
PiBUaGlzIHBhdGNoIGFkZHMgc3VwcG9ydCBmb3IgcmVhZGluZyB1c2luZyBETUEgbW9kZSB3aGlj
aCBpbmNyZWFzZXMNCj4gcmVhZGluZyBzcGVlZCBmcm9tIDFNQi9zIHRvIDRNQi9zDQo+IA0KPiBE
TUEgYnVzeSBjaGVja2luZyBpcyBpbXBsZW1lbnRlZCB3aXRoIHJlYWRsX3BvbGxfdGltZW91dCBi
ZWNhdXNlDQo+IEkgZG9uJ3QgaGF2ZSBhY2Nlc3MgdG8gSVJRLXJlbGF0ZWQgZG9jcy4gVGhlIHNw
ZWVkIGluY3JlbWVudCBjb21lcw0KPiBmcm9tIHRob3NlIHNhdmVkIGNtZCthZGRyK2R1bW15IGNs
b2Nrcy4NCg0KSGkgQ2h1YW5ob25nLA0KDQpUaGFua3MgZm9yIHlvdXIgcGF0Y2gsIEknbSBjaGVj
a2luZyB3aXRoIEd1b2NodW4gdG8gc2VlIGlmIHdlIGNvdWxkDQpyZWxlYXNlIElSUSByZWxhdGVk
IGluZm9ybWF0aW9uIHRvIHlvdS4NCg0KDQo+IFRoaXMgY29udHJvbGxlciByZXF1aXJlcyB0aGF0
IERNQSBzb3VyY2UvZGVzdGluYXRpb24gYWRkcmVzcyBhbmQNCj4gcmVhZGluZyBsZW5ndGggc2hv
dWxkIGJlIDE2LWJ5dGUgYWxpZ25lZC4gV2UgdXNlIGEgYm91bmNlIGJ1ZmZlciBpZg0KPiBvbmUg
b2YgdGhlbSBpcyBub3QgYWxpZ25lZCwgcmVhZCBtb3JlIHRoYW4gd2hhdCB3ZSBuZWVkLCBhbmQg
Y29weQ0KPiBkYXRhIGZyb20gY29ycmVzcG9uZGluZyBidWZmZXIgb2Zmc2V0Lg0KDQpJJ3ZlIGNo
ZWNrZWQgd2l0aCBvdXIgSFcgZ3V5cy4gVGhlIGxpbWl0YXRpb24gaXMgb24gRFJBTSBvbmx5Lg0K
U28gZm9yIHJlYWQgd2Ugc2hvdWxkIGNoZWNrIGJ1ZmZlciBhbmQgbGVuZ3RoIHRvIG1ha2Ugc3Vy
ZSBpdCBpcw0KYWxpZ25lZCwgYnV0IGRvbid0IG5lZWQgdG8gY2hlY2sgZnJvbS4NCg0KSm9lLkMN
Cg0K

