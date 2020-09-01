Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB595C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 01:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEA5920C56
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 01:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gy8DlTHv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgIABvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 21:51:39 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:41469 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725993AbgIABvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 21:51:39 -0400
X-UUID: fb863039fb184cd8863257b0da953a10-20200901
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=qJACcI5q4eOD/v6iC3fhkqz1GyF30C7lbgepzbjso/E=;
        b=gy8DlTHvfVvc0T6QcfiF9Oi9m5JJMrVlEF+76bawofYPM4epNdaDKMVah5Ss2GOgE00pAd/7VLAd4KVGrk388A6HTiTCygffimyAHr4PpVfIliVFvEc7MZOorj3crNbID+Ju7mYg95LDyzgd9cE0sdOrZ9LUpoZDM9X5venRqaw=;
X-UUID: fb863039fb184cd8863257b0da953a10-20200901
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1891126655; Tue, 01 Sep 2020 09:51:36 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 1 Sep
 2020 09:51:31 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 1 Sep 2020 09:51:34 +0800
Message-ID: <1598924999.11403.3.camel@mhfsdcap03>
Subject: Re: [PATCH v5 4/4] MAINTAINERS: add files for Mediatek DRM drivers
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 1 Sep 2020 09:49:59 +0800
In-Reply-To: <CAAOTY_9hZgLGSiqCA6a1Ea+TjGZAH4-t4DFS9jCz3nEXNJY1zg@mail.gmail.com>
References: <20200823014830.15962-1-chunkuang.hu@kernel.org>
         <20200823014830.15962-5-chunkuang.hu@kernel.org>
         <1598838539.7054.9.camel@mhfsdcap03>
         <CAAOTY_9hZgLGSiqCA6a1Ea+TjGZAH4-t4DFS9jCz3nEXNJY1zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 724E468EB20BBC4E102A084E01A7702051D82B5CA6D15ABC5921E762D5A8F58F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTA5LTAxIGF0IDAwOjAyICswODAwLCBDaHVuLUt1YW5nIEh1IHdyb3RlOg0K
PiBIaSwgQ2h1bmZlbmc6DQo+IA0KPiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRl
ay5jb20+IOaWvCAyMDIw5bm0OOaciDMx5pelIOmAseS4gCDkuIrljYg5OjUw5a+r6YGT77yaDQo+
ID4NCj4gPiBPbiBTdW4sIDIwMjAtMDgtMjMgYXQgMDk6NDggKzA4MDAsIENodW4tS3VhbmcgSHUg
d3JvdGU6DQo+ID4gPiBNZWRpYXRlayBIRE1JIHBoeSBkcml2ZXIgaXMgbW92ZWQgZnJvbSBkcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsgdG8NCj4gPiA+IGRyaXZlcnMvcGh5L21lZGlhdGVrLCBzbyBh
ZGQgdGhlIG5ldyBmb2xkZXIgdG8gdGhlIE1lZGlhdGVrIERSTSBkcml2ZXJzJw0KPiA+ID4gaW5m
b3JtYXRpb24uDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bi1LdWFuZyBIdSA8Y2h1
bmt1YW5nLmh1QGtlcm5lbC5vcmc+DQo+ID4gPiBSZXZpZXdlZC1ieTogTWF0dGhpYXMgQnJ1Z2dl
ciA8bWF0dGhpYXMuYmdnQGdtYWlsLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIE1BSU5UQUlORVJT
IHwgMSArDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4gPg0KPiA+
ID4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4gPiA+IGluZGV4IGRl
YWFmYjYxNzM2MS4uMTkxYmFjZjAyMjA5IDEwMDY0NA0KPiA+ID4gLS0tIGEvTUFJTlRBSU5FUlMN
Cj4gPiA+ICsrKyBiL01BSU5UQUlORVJTDQo+ID4gPiBAQCAtNTc5Myw2ICs1NzkzLDcgQEAgTDog
ICAgICBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+ID4gPiAgUzogICBTdXBwb3J0
ZWQNCj4gPiA+ICBGOiAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5
L21lZGlhdGVrLw0KPiA+ID4gIEY6ICAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrLw0KPiA+ID4g
K0Y6ICAgZHJpdmVycy9waHkvbWVkaWF0ZWsvcGh5LW10ay1oZG1pKg0KPiA+ID4NCj4gPiA+ICBE
Uk0gRFJJVkVSUyBGT1IgTlZJRElBIFRFR1JBDQo+ID4gPiAgTTogICBUaGllcnJ5IFJlZGluZyA8
dGhpZXJyeS5yZWRpbmdAZ21haWwuY29tPg0KPiA+DQo+ID4gUmV2aWV3ZWQtYnk6IENodW5mZW5n
IFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCj4gPg0KPiANCj4gQ291bGQgeW91IGdp
dmUgYW4gJ0Fja2VkLWJ5JyB0YWcgb24gdGhpcyBwYXRjaD8gU28gSSBjb3VsZCBhcHBseSB0aGUN
Cj4gd2hvbGUgc2VyaWVzIGludG8gbXkgdHJlZS4NCkFja2VkLWJ5OiBDaHVuZmVuZyBZdW4gPGNo
dW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQoNClRoYW5rcw0KDQo+IA0KPiBSZWdhcmRzLA0KPiBD
aHVuLUt1YW5nLg0KPiANCj4gPiBUaGFua3MNCj4gPg0KPiA+DQo+ID4NCg0K

