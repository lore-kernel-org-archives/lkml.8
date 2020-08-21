Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781F7C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 01:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50B0E208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 01:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="d+PzrZd1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgHUBoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 21:44:32 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:1829 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725859AbgHUBoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 21:44:30 -0400
X-UUID: f669e5d1f69a4fe1bd47bc46ef479947-20200821
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=myVsjwfmsGiFqleY7utMNLzdKyLv2kTDb2x08UFOPCQ=;
        b=d+PzrZd1if0v4MPLIPVPJTCzaR6PoZlzt5yEfmGQiNXZVO7Zr7bD+Cm65fG0N19zwhpAUGiToIjgmd8/8tDBjiB1FUFtITBtBQcWv/Orz+mtTlVuwDOJIhcpNhvcPazmqEIjtrp1DNke3XUNlYElB01B2BjHlOL+bsrP2AvE4vs=;
X-UUID: f669e5d1f69a4fe1bd47bc46ef479947-20200821
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1742172575; Fri, 21 Aug 2020 09:44:25 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 21 Aug
 2020 09:44:24 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 21 Aug 2020 09:44:23 +0800
Message-ID: <1597974192.21253.1.camel@mhfsdcap03>
Subject: Re: [PATCH v2 11/11] iopoll: update kerneldoc of
 read_poll_timeout_atomic()
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>
Date:   Fri, 21 Aug 2020 09:43:12 +0800
In-Reply-To: <49de5eaf-9870-522c-b1f2-037ecb122237@gmail.com>
References: <1597902349-8998-1-git-send-email-chunfeng.yun@mediatek.com>
         <1597902349-8998-11-git-send-email-chunfeng.yun@mediatek.com>
         <49de5eaf-9870-522c-b1f2-037ecb122237@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 442D63025AC8AD7A9DE72A802969C476581D10A5A37734827091AB339203CB192000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA4LTIwIGF0IDEzOjE0ICswMzAwLCBTZXJnZWkgU2h0eWx5b3Ygd3JvdGU6
DQo+IEhlbGxvIQ0KPiANCj4gT24gMjAuMDguMjAyMCA4OjQ1LCBDaHVuZmVuZyBZdW4gd3JvdGU6
DQo+IA0KPiA+IEFyZ3VtZW50cyBkZXNjcmlwdGlvbiBvZiByZWFkX3BvbGxfdGltZW91dF9hdG9t
aWMoKSBpZiBvdXQgb2YgZGF0ZSwNCj4gDQo+ICAgICBzL2lmL2lzLz8NCldpbGwgZml4IGl0LCB0
aGFua3MNCg0KPiANCj4gPiB1cGRhdGUgaXQuDQo+ID4gDQo+ID4gQ2M6IEFsYW4gU3Rlcm4gPHN0
ZXJuQHJvd2xhbmQuaGFydmFyZC5lZHU+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVu
IDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KPiBbLi4uXQ0KPiANCj4gTUJSLCBTZXJnZWkN
Cg0K

