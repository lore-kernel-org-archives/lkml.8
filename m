Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428C4C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1916820782
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="k8jguoJz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgHaBum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 21:50:42 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:13831 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726454AbgHaBul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 21:50:41 -0400
X-UUID: d8fa7b74a7b744ad955a77d5ff1ffc1e-20200831
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=s+O33/eGp7dWd0QU6yX77AekPJjIOCIf4Necc446y1c=;
        b=k8jguoJzrw39NfQqGy5IijQ8DDU073rlaB6CjvuclozdQeecUCgScz1jFckhTZF2sWjT97JlDzx/prAXHbfv0u1YyeX642O3Y3+RpfUXveplfvUmP/NNKxz9YEc0HdH6VkV0E61ziU5fTg1OgksZG4OqCK3fX5NccqxU0sgLcW0=;
X-UUID: d8fa7b74a7b744ad955a77d5ff1ffc1e-20200831
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1613170683; Mon, 31 Aug 2020 09:50:34 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 31 Aug
 2020 09:50:32 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 31 Aug 2020 09:50:33 +0800
Message-ID: <1598838539.7054.9.camel@mhfsdcap03>
Subject: Re: [PATCH v5 4/4] MAINTAINERS: add files for Mediatek DRM drivers
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Mon, 31 Aug 2020 09:48:59 +0800
In-Reply-To: <20200823014830.15962-5-chunkuang.hu@kernel.org>
References: <20200823014830.15962-1-chunkuang.hu@kernel.org>
         <20200823014830.15962-5-chunkuang.hu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: D668365A83D97117FF652764C1C8C4D5D5E78AECFE5584A33530F1932BFEA8AE2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIwLTA4LTIzIGF0IDA5OjQ4ICswODAwLCBDaHVuLUt1YW5nIEh1IHdyb3RlOg0K
PiBNZWRpYXRlayBIRE1JIHBoeSBkcml2ZXIgaXMgbW92ZWQgZnJvbSBkcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsgdG8NCj4gZHJpdmVycy9waHkvbWVkaWF0ZWssIHNvIGFkZCB0aGUgbmV3IGZvbGRl
ciB0byB0aGUgTWVkaWF0ZWsgRFJNIGRyaXZlcnMnDQo+IGluZm9ybWF0aW9uLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQ2h1bi1LdWFuZyBIdSA8Y2h1bmt1YW5nLmh1QGtlcm5lbC5vcmc+DQo+IFJl
dmlld2VkLWJ5OiBNYXR0aGlhcyBCcnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPg0KPiAt
LS0NCj4gIE1BSU5UQUlORVJTIHwgMSArDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KykNCj4gDQo+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQo+IGluZGV4
IGRlYWFmYjYxNzM2MS4uMTkxYmFjZjAyMjA5IDEwMDY0NA0KPiAtLS0gYS9NQUlOVEFJTkVSUw0K
PiArKysgYi9NQUlOVEFJTkVSUw0KPiBAQCAtNTc5Myw2ICs1NzkzLDcgQEAgTDoJZHJpLWRldmVs
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiAgUzoJU3VwcG9ydGVkDQo+ICBGOglEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay8NCj4gIEY6CWRyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay8NCj4gK0Y6CWRyaXZlcnMvcGh5L21lZGlhdGVrL3BoeS1tdGstaGRt
aSoNCj4gIA0KPiAgRFJNIERSSVZFUlMgRk9SIE5WSURJQSBURUdSQQ0KPiAgTToJVGhpZXJyeSBS
ZWRpbmcgPHRoaWVycnkucmVkaW5nQGdtYWlsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IENodW5mZW5n
IFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCg0KVGhhbmtzDQoNCg0KDQo=

