Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB0CC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B245C2086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="p5m/COyp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgGWIJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 04:09:12 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:55273 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725911AbgGWIJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 04:09:11 -0400
X-UUID: 5a8b5a857fda4708bf5ff0e2187a5346-20200723
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=fSiTx6h04vMgROFBHuBqIq+Fo4UKmOysYSBBC24bIvw=;
        b=p5m/COyppFN9UbEVJvmKuB+4Bb1HlVu/jvrAHJQc0zBm0MHQCYu7qtnzJSU5ftLyPG6WCTiOcgurUMKIKIVAGnB01LLxKXa5J08040dLB3ZlqnBtkxPl9hBYlbuLzT2jYpjdEsKjJgAMvk73pOcE62FFQY3q36cTD1gh66OKYgI=;
X-UUID: 5a8b5a857fda4708bf5ff0e2187a5346-20200723
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <wendell.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 575408228; Thu, 23 Jul 2020 16:09:09 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Jul 2020 16:09:07 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Jul 2020 16:09:07 +0800
Message-ID: <1595491748.17583.4.camel@mtkswgap22>
Subject: Re: [PATCH 2/2] clk: mediatek: Add EXPORT_SYMBOL for kernel module
 support
From:   Wendell Lin <wendell.lin@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Date:   Thu, 23 Jul 2020 16:09:08 +0800
In-Reply-To: <159448481956.1987609.4970524569331045099@swboyd.mtv.corp.google.com>
References: <1593588382-19049-1-git-send-email-wendell.lin@mediatek.com>
         <1593588382-19049-3-git-send-email-wendell.lin@mediatek.com>
         <159448481956.1987609.4970524569331045099@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIwLTA3LTExIGF0IDA5OjI2IC0wNzAwLCBTdGVwaGVuIEJveWQgd3JvdGU6DQo+
IFF1b3RpbmcgV2VuZGVsbCBMaW4gKDIwMjAtMDctMDEgMDA6MjY6MjIpDQo+ID4gRXhwb3J0IGNv
bW1vbiBBUElzIGZyb20gTWVkaWF0ZWsgY2xvY2sgZHJpdmVyLg0KPiA+IA0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFdlbmRlbGwgTGluIDx3ZW5kZWxsLmxpbkBtZWRpYXRlay5jb20+DQo+IA0KPiBJcyB0
aGlzIG5lZWRlZCBmb3Igc29tZXRoaW5nPyBJJ2QgcHJlZmVyIHRvIHNlZSBzb21lIHNvcnQgb2Yg
bWVkaWF0ZWsNCj4gbW9kdWxhciBwYXRjaGVzIHRoYXQgaW5jbHVkZWQgdGhpcyBwYXRjaCBpbiBp
dCBiZWZvcmUgdGhpcyBpcyBhcHBsaWVkLg0KDQpHb3QgaXQuIA0KSSdsbCBwcmVwYXJlIGEgbmV3
IHNlcmllcyBvZiBtZWRpYXRlayBtb2R1bGFyIHBhdGNoZXMgdGhhdCBpbmNsdWRlZCB0aGlzDQpw
YXRjaCBpbiBpdCBsYXRlci4NCg0KUmVnYXJkcywNCldlbmRlbGwNCg0K

