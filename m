Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA5BC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 09:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4E24207CD
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 09:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="G1t2Xboh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgGEJoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 05:44:22 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:7634 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726134AbgGEJoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 05:44:21 -0400
X-UUID: 33ba9c41c393484594545a3bc23d7c7f-20200705
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=bVAN/Pr8hp2riddPU0Ip98uCQV+TayeMJMDOKh3eCMI=;
        b=G1t2XbohuX5vrSHUSv00rfOOvnOD7dzzgBrqvUOjVP2NR+ys05ynEDkgxkFzIMiDZYxpCGwEt8iRA34aK4RUqjWzULJbiC80tDdzl0hda9Rw1psiKq/Xj+NPfMNO3p0gnXBABb+adNrlKWn9RvRn4NvepK/pRXgtSDPr/b/2cGg=;
X-UUID: 33ba9c41c393484594545a3bc23d7c7f-20200705
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1955651590; Sun, 05 Jul 2020 17:44:13 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 5 Jul
 2020 17:44:12 +0800
Received: from [10.16.6.141] (10.16.6.141) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 5 Jul 2020 17:44:11 +0800
Message-ID: <1593942260.24547.0.camel@mszsdaap41>
Subject: Re: [PATCH] drm/panel: auo,b116xw03: fix flash backlight when power
 on
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Sam Ravnborg <sam@ravnborg.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, <huijuan.xie@mediatek.com>
Date:   Sun, 5 Jul 2020 17:44:20 +0800
In-Reply-To: <20200705080637.GA1745670@ravnborg.org>
References: <20200703095113.55712-1-jitao.shi@mediatek.com>
         <20200705080637.GA1745670@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: A3D6659F2DC4FFFA11B5C6F5A8FFA03230239A4D2ADD46D9DBF384DD810AE9CF2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIwLTA3LTA1IGF0IDEwOjA2ICswMjAwLCBTYW0gUmF2bmJvcmcgd3JvdGU6DQo+
IEhpIEppdGFvLg0KPiANCj4gT24gRnJpLCBKdWwgMDMsIDIwMjAgYXQgMDU6NTE6MTNQTSArMDgw
MCwgSml0YW8gU2hpIHdyb3RlOg0KPiA+IERlbGF5IHRoZSBiYWNrbGlnaHQgb24gdG8gbWFrZSBz
dXJlIHRoZSB2aWRlbyBzdGFibGUuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSml0YW8gU2hp
IDxqaXRhby5zaGlAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0v
cGFuZWwvcGFuZWwtc2ltcGxlLmMgfCAzICsrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9wYW5lbC9w
YW5lbC1zaW1wbGUuYyBiL2RyaXZlcnMvZ3B1L2RybS9wYW5lbC9wYW5lbC1zaW1wbGUuYw0KPiA+
IGluZGV4IDNhZDgyOGVhZWZlMS4uMThmMzRmMjg2ZDNkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9wYW5lbC9wYW5lbC1zaW1wbGUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9wYW5lbC9wYW5lbC1zaW1wbGUuYw0KPiA+IEBAIC03MzQsNiArNzM0LDkgQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBwYW5lbF9kZXNjIGF1b19iMTE2eHcwMyA9IHsNCj4gPiAgCQkud2lkdGggPSAy
NTYsDQo+ID4gIAkJLmhlaWdodCA9IDE0NCwNCj4gPiAgCX0sDQo+ID4gKwkuZGVsYXkgPSB7DQo+
ID4gKwkJLmVuYWJsZSA9IDQwMCwNCj4gPiArCX0sDQo+ID4gIH07DQo+ID4gIA0KPiA+ICBzdGF0
aWMgY29uc3Qgc3RydWN0IGRybV9kaXNwbGF5X21vZGUgYXVvX2IxMzN4dG4wMV9tb2RlID0gew0K
PiANCj4gUGF0Y2ggZGlkIG5vdCBhcHBseSB0byBkcm0tbWlzYy1uZXh0Lg0KPiBQbGVhc2UgdXBk
YXRlIC0gYW5kIHdoZW4geW91IGRvIHNvIGFsc28gYWRkOg0KPiAuYnVzX2ZsYWdzDQo+IC5idXNf
Zm9ybWF0DQo+IC5jb25uZWN0b3JfdHlwZQ0KPiANCj4gU28gd2UgaGF2ZSB0aGlzIHBhbmVsIHBy
b3Blcmx5IGRlZmluZWQuDQo+IA0KPiAJU2FtDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQpJ
J2xsIGFkZCB0aG9zZSBuZXh0IHZlcnNpb24uDQoNCkppdGFvDQo=

