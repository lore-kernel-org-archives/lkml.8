Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46A6C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 05:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C2724677
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 05:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oG436vtj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgCBFyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 00:54:00 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:11339 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725446AbgCBFx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 00:53:59 -0500
X-UUID: da4ad93e0dab4b2f8cc91e498331ea9c-20200302
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=t4He3J1fTTd1ShvzHhVtQAeAmIgLfyTFftjbZWTdLIo=;
        b=oG436vtj99R9yR9HMOop9/lWBcqrx9FlOlgs4SH1S7PLeSKHjd+FyV+i3TPawFSoLd3aiJcyxAGPdZ7+9lAXb8yqEreONqg+AMxjEaJS3fWhXq1SiKFqh2MHQfJH4DxzL4jghxgyV1Wxz5nHgrQmtQ1JpFzHfMT131lxeKSQVFA=;
X-UUID: da4ad93e0dab4b2f8cc91e498331ea9c-20200302
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <wen.su@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1626716386; Mon, 02 Mar 2020 13:53:54 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 2 Mar 2020 13:51:13 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 2 Mar 2020 13:51:25 +0800
Message-ID: <1583128432.18202.3.camel@mtkswgap22>
Subject: Re: Applied "regulator: mt6359: Add support for MT6359 regulator"
 to the regulator tree
From:   Wen Su <Wen.Su@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Date:   Mon, 2 Mar 2020 13:53:52 +0800
In-Reply-To: <20200226114706.GE4136@sirena.org.uk>
References: <20200226114706.GE4136@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 942391240DD208876DE14664B578D3ED6A5B0C160211EB22242DAAFE98F653942000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyaywgDQoNCk9uIFdlZCwgMjAyMC0wMi0yNiBhdCAxMTo0NyArMDAwMCwgTWFyayBCcm93
biB3cm90ZToNCj4gT24gVHVlLCBGZWIgMjUsIDIwMjAgYXQgMDE6MjQ6MTFQTSArMDAwMCwgTWFy
ayBCcm93biB3cm90ZToNCj4gPiBUaGUgcGF0Y2gNCj4gPiANCj4gPiAgICByZWd1bGF0b3I6IG10
NjM1OTogQWRkIHN1cHBvcnQgZm9yIE1UNjM1OSByZWd1bGF0b3INCj4gPiANCj4gPiBoYXMgYmVl
biBhcHBsaWVkIHRvIHRoZSByZWd1bGF0b3IgdHJlZSBhdA0KPiANCj4gLi4uYW5kIGRyb3BwZWQg
YmVjYXVzZSB0aGUgTUZEIGRlcGVuZGVuY3kgaXNuJ3Qgb24gYSBuZXdseSBhZGRlZCBkcml2ZXIN
Cj4gbGlrZSBpdCBhcHBlYXJlZC4NCg0KSSBhbSBzb3JyeSB0byBib3RoZXIgeW91LiBIb3cgc2hv
dWxkIEkgcHJvY2VlZCBmb3IgdGhpcyBwYXRjaCBzZXQgd2hpY2gNCmluY2x1ZGluZyByZWd1bGF0
b3IgZHJpdmVyIGFuZCBNRkQgaGVhZGVyIGZpbGUgPyBQbGVhc2UgZ2l2ZSBhZHZpY2UuDQoNClRo
YW5rIHlvdS4NCg0K

