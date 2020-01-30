Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A6FC33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 03:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E43E20707
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 03:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LvZByeUm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgA3DoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 22:44:06 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:23159 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726811AbgA3DoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 22:44:06 -0500
X-UUID: b27cc1cbc00d4125a60e144d1168b3d8-20200130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=3bvai5RkNO6CsB90bdkSQOYb8Boyue9WmpvdjPAjYrE=;
        b=LvZByeUmLm02Ok2hWnLatHg7/qO01kS4WAdxpbZX63pcSnhfwymAwFzLGT9fxb5xyVUWZ4P+FekUugDq1QYEJxMNhQK9+smkTFdAJAbXV6uZLC+sNYE0UV+qLNVGzL6vmKwtDmD3kuQlNaJk+Daj9UxQ8LrSUZRmdzpLbzl436c=;
X-UUID: b27cc1cbc00d4125a60e144d1168b3d8-20200130
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1456654747; Thu, 30 Jan 2020 11:43:59 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 30 Jan 2020 11:43:15 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 30 Jan 2020 11:44:02 +0800
Message-ID: <1580355838.11126.5.camel@mtksdccf07>
Subject: Re: [PATCH v4 2/2] kasan: add test for invalid size in memmove
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Thu, 30 Jan 2020 11:43:58 +0800
In-Reply-To: <619b898f-f9c2-1185-5ea7-b9bf21924942@virtuozzo.com>
References: <20191112065313.7060-1-walter-zh.wu@mediatek.com>
         <619b898f-f9c2-1185-5ea7-b9bf21924942@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTExLTIyIGF0IDA2OjIxICswODAwLCBBbmRyZXkgUnlhYmluaW4gd3JvdGU6
DQo+IA0KPiBPbiAxMS8xMi8xOSA5OjUzIEFNLCBXYWx0ZXIgV3Ugd3JvdGU6DQo+ID4gVGVzdCBu
ZWdhdGl2ZSBzaXplIGluIG1lbW1vdmUgaW4gb3JkZXIgdG8gdmVyaWZ5IHdoZXRoZXIgaXQgY29y
cmVjdGx5DQo+ID4gZ2V0IEtBU0FOIHJlcG9ydC4NCj4gPiANCj4gPiBDYXN0aW5nIG5lZ2F0aXZl
IG51bWJlcnMgdG8gc2l6ZV90IHdvdWxkIGluZGVlZCB0dXJuIHVwIGFzIGEgbGFyZ2UNCj4gPiBz
aXplX3QsIHNvIGl0IHdpbGwgaGF2ZSBvdXQtb2YtYm91bmRzIGJ1ZyBhbmQgYmUgZGV0ZWN0ZWQg
YnkgS0FTQU4uDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogV2FsdGVyIFd1IDx3YWx0ZXItemgu
d3VAbWVkaWF0ZWsuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBEbWl0cnkgVnl1a292IDxkdnl1a292
QGdvb2dsZS5jb20+DQo+IA0KPiBSZXZpZXdlZC1ieTogQW5kcmV5IFJ5YWJpbmluIDxhcnlhYmlu
aW5AdmlydHVvenpvLmNvbT4NCg0KSGkgQW5kcmV5LCBEbWl0cnksIEFuZHJldywNCg0KV291bGQg
eW91IHRlbGwgbWUgd2h5IHRoaXMgcGF0Y2gtc2V0cyBkb24ndCBtZXJnZSBpbnRvIGxpbnV4LW5l
eHQgdHJlZT8NCldlIGxvc3Qgc29tZXRoaW5nPw0KDQpUaGFua3MgZm9yIHlvdXIgaGVscC4NCg0K
V2FsdGVyDQoNCg==

