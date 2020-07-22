Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A9EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DA44206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DxlOfR0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730012AbgGVGwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 02:52:40 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:49983 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728063AbgGVGwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 02:52:39 -0400
X-UUID: b8e31aa69ef14041bf4931ca86dde9c5-20200722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=08ahtnmNrBBtT3nmOzdLNlR4diPbsxUTXv6y1fIw5lQ=;
        b=DxlOfR0DATwm7KW+V3JQs6BlXKER5IXKFJXqBncoNHqIz3zu/bnemjfSZlAg6ELgz00IirHatbbHWE+6eqs3UTgSKZgnYvCDI/IcwIC7MG3QJPum8Ue9R13sygJrxAqrj0oXgYNPNNSn71MbPzWRdQodfPqtJL6atg04iOEL2KA=;
X-UUID: b8e31aa69ef14041bf4931ca86dde9c5-20200722
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1835170231; Wed, 22 Jul 2020 14:52:27 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 22 Jul
 2020 14:52:25 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 22 Jul 2020 14:52:24 +0800
Message-ID: <1595400680.23885.59.camel@mhfsdcap03>
Subject: Re: [v3 PATCH] usb: gadget: bdc: use readl_poll_timeout() to
 simplify code
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Stephen Boyd <swboyd@chromium.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 22 Jul 2020 14:51:20 +0800
In-Reply-To: <87eep5p5jz.fsf@kernel.org>
References: <1594622881-6563-1-git-send-email-chunfeng.yun@mediatek.com>
         <87eep5p5jz.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 6934C1A160E6292ED1B6B2C90BF72BF7A76190B4B58533C98A2BEDF22A9AD80C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTA3LTIxIGF0IDEyOjQyICswMzAwLCBGZWxpcGUgQmFsYmkgd3JvdGU6DQo+
IEhpLA0KPiANCj4gQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPiB3cml0
ZXM6DQo+ID4gVXNlIHJlYWRsX3BvbGxfdGltZW91dCgpIHRvIHBvbGwgcmVnaXN0ZXIgc3RhdHVz
DQo+ID4NCj4gPiBDYzogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+DQo+
ID4gU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29t
Pg0KPiA+IFJldmlld2VkLWJ5OiBGbG9yaWFuIEZhaW5lbGxpIDxmLmZhaW5lbGxpQGdtYWlsLmNv
bT4NCj4gDQo+IEkgaGFkIGEgbG90IG9mIHRyb3VibGUgdG8gYXBwbHkgdGhpcyBwYXRjaCwgY291
bGQgeW91IGF2b2lkIGJhc2U2NA0KPiBlbmNvZGluZyBvbiB0aGUgcGF0Y2ggYm9keSBuZXh0IHRp
bWU/DQpTb3JyeSBmb3IgaW5jb252ZW5pZW5jZS4NCg0KDQpJIHVzdWFsbHkgdXNlIFNvdXJjZSBJ
bnNpZ2h0IDMuNSBvciBWaW0gdG8gZWRpdCB0aGUgY29kZSwgc29tZXRpbWVzIHVzZQ0KQmV5b25k
IENvbXBhcmUgdG8gY29tcGFyZSBwYXRjaGVzLCB0aGVpciBkZWZhdWx0IGVuY29kaW5nIGlzIFVU
Ri04IG9yDQpBTlNJLiBOb3Qgc3VyZSB3aGljaCB0b29sIHdvdWxkIHVzZSBiYXNlNjQgZW5jb2Rp
bmcsIG1heWJlIGludHJvZHVjZWQNCndoZW4gSSBjb3B5IGVtYWlsIGFkZHJlc3MgZnJvbSBXaW43
IHdpdGggQ2hpbmVzZSAodXNlZCB0byByZWNlaXZlIGVtYWlsKQ0KaW50byBXaW4xMCB3aXRoIEVu
Z2xpc2ggKHVzZWQgdG8gc2VudCBlbWFpbC9wYXRjaCkuIA0KDQoNCkNhbiB5b3UgdGVsbCBtZSB3
aGljaCBsaW5lcyBhcmUgYmFzZTY0IGVuY29kaW5nIGluIHRoaXMgcGF0Y2g/DQoNCg0KVGhlIHBh
dGNoJ3MgZW5jb2RpbmcgaXMgQU5TSSwgSSdsbCBjb252ZXJ0IGl0IGludG8gVVRGLTggYW5kIHJl
c2VuZCBpdCwNCnBsZWFzZSB0cnkgaXQgYWdhaW4uDQoNCj4gDQo+IFRoYW5rcw0KPiANCg0K

