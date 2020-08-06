Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862F4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 15:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B52AB22E01
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 15:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="B8RRnKd3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgHFPpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 11:45:23 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:55473 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725927AbgHFOUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 10:20:16 -0400
X-UUID: c21eb5ad084c4d4583c72c78fe8f7549-20200806
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=3gLQcEfwtJI1Q0Ph3JAitnDfiUoVRJTnHH6hq25dato=;
        b=B8RRnKd3HPHMdUq3sU1Y/9nIiP7NlY9nDLUnwXh8mJ+Uh4dCfC49erokAyAV8aeJ80pn9xeTomcWvJT1eyrcLK0DSf01b+QgrU1bpnnwKIrKknwJsTjD5DmPlnkOgfDBZ7f6AoJUKzklvwjDxVfiSTgmbYYOz+6SBhPMxqXTuzo=;
X-UUID: c21eb5ad084c4d4583c72c78fe8f7549-20200806
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1258676737; Thu, 06 Aug 2020 22:08:14 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 6 Aug 2020 22:08:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 6 Aug 2020 22:08:11 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <daniel@0x0f.com>, Mark-PK Tsai <mark-pk.tsai@mediatek.com>
CC:     <alix.wu@mediatek.com>, <devicetree@vger.kernel.org>,
        <jason@lakedaemon.net>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <maz@kernel.org>, <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <yj.chiang@mediatek.com>
Subject: Re: [PATCH 0/2] irqchip: irq-mt58xx: Add mt58xx series interrupt
Date:   Thu, 6 Aug 2020 22:07:39 +0800
Message-ID: <20200806140739.31501-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CAFr9PX=Gk9h6ASi6saBLhoZ45g-WqCzDQo2XWT033fJykFSY_g@mail.gmail.com>
References: <CAFr9PX=Gk9h6ASi6saBLhoZ45g-WqCzDQo2XWT033fJykFSY_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRGFuaWVsIFBhbG1lciA8ZGFuaWVsQDB4MGYuY29tPg0KDQo+IEhpIE1hcmstUEssDQo+
IA0KPiBZb3VyIGRyaXZlciBzZWVtcyB0byBiZSBmb3IgdGhlIHNhbWUgaW50ZXJydXB0IGNvbnRy
b2xsZXIgSVAgdGhhdCBpcw0KPiBwcmVzZW50IGluIE1TdGFyJ3MgVFYgYW5kIGNhbWVyYSBTb0Nz
IGFuZCBub3cgU2lnbWFTdGFyJ3MgU29Dcy4NCj4gSSBzZW50IGEgc2VyaWVzWzBdIGZvciBhIGRy
aXZlciB2ZXJ5IHNpbWlsYXIgdG8geW91cnMgYnV0IGZvciB0aGUNCj4gTVN0YXIgU29Dcy4gRG8g
eW91IGtub3cgaWYgaXQgd291bGQgYmUgcG9zc2libGUgdG8gY29uZmlybSBpZiB0aGV5IGFyZQ0K
PiB0aGUNCj4gc2FtZSB0aGluZz8gTWVkaWFUZWsgYm91Z2h0IE1TdGFyIGEgZmV3IHllYXJzIGFn
byBzbyBpdCBzZWVtcyBsaWtlbHkNCj4gYnV0IEkgaGF2ZSBubyBoYXJkIGluZm9ybWF0aW9uLg0K
PiANCg0KWWVzLCBpdCdzIGZvciB0aGUgc2FtZSBpbnRlcnJ1cHQgY29udHJvbGxlciBJUC4NCg0K
PiBJZiB0aGV5IGFyZSB0aGUgc2FtZSB0aGluZyBjb3VsZCB3ZSB3b3JrIG9uIG1ha2luZyBvbmUg
c2VyaWVzIHRoYXQNCj4gc3VwcG9ydHMgYm90aCB1c2UgY2FzZXM/DQoNClN1cmUsIGFuZCBJIHRo
aW5rIHRoZSBpcnEgY29udHJvbGxlciBkcml2ZXIgc2hvdWxkIHN1cHBvcnQgYm90aCB1c2UgY2Fz
ZXMuDQpTbyBob3cgYWJvdXQga2VlcCB0aGUgTVRLIHZlcnNpb24gZHJpdmVyPw0KSSdsbCBzZW5k
IHBhdGNoIHYyIGFmdGVyIC1yYzEgYXMgSSBtZW50aW9uZWQgaW4gdGhlIHByZXZpb3VzIG1haWws
DQphbmQga2VlcCB5b3UgcG9zdGVkLg0KQW5kIGFueSBzdWdnZXN0aW9uIGlzIHdlbGNvbWUuIDop
DQoNCj4gSXQncyBhbHNvIHBvc3NpYmxlIHRoYXQgaWYgdGhlIGludGVycnVwdCBjb250cm9sbGVy
IGlzIHRoZSBzYW1lIHNvbWUNCj4gb3RoZXIgdGhpbmdzIGxpa2UgdGhlIFNQSSBOT1IgY29udHJv
bGxlciBldGMgYXJlIGFsc28gY29tbW9uIGFuZA0KPiB3b3JraW5nDQo+IG9uIGEgc2luZ2xlIGRy
aXZlciBmb3IgdGhvc2Ugd291bGQgc2F2ZSB1cyBib3RoIHRpbWUuDQo+IA0KDQpJJ20gbm90IHN1
cmUgYWJvdXQgdGhhdC4NCkknbGwgY2hlY2sgdGhlIHBhdGNoZXMgeW91IGNvbnRyaWJ1dGVkIGFu
ZCBjb25maXJtIHdpdGggb3VyIGRyaXZlciBvd25lcnMu

