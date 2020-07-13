Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8266DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 561B920663
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hcTBR1V0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgGMGzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:55:54 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:35030 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725830AbgGMGzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 02:55:54 -0400
X-UUID: 474391b0ea3341caa0a2e701608106dd-20200713
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=+Ge9G9rSePdPEHWfzy1cfUe7vMpgioTYIlHODRFrwkk=;
        b=hcTBR1V01BvFVOcL44C3w3YSZLGRuq/FvLGwAt6XomEoV1yYRvZFBkRHNVTx1M6WesSiSY+7aPclKNgqNZreRNhgIQQH1hrtVBa890fnkMCBgKoDvX3mQ0TuwNdKE4VmlkYnEZiKMDMG3wGuxdINFJ4nq/X6ys/epgshYJ/Jt1s=;
X-UUID: 474391b0ea3341caa0a2e701608106dd-20200713
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1177699355; Mon, 13 Jul 2020 14:55:48 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 13 Jul
 2020 14:55:47 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 13 Jul 2020 14:55:45 +0800
Message-ID: <1594623300.23885.36.camel@mhfsdcap03>
Subject: Re: [v2 PATCH] usb: gadget: bdc: use readl_poll_timeout() to
 simplify code
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Stephen Boyd <swboyd@chromium.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Mon, 13 Jul 2020 14:55:00 +0800
In-Reply-To: <b73d8a90-96cd-42b5-bbc2-26e300da0603@gmail.com>
References: <1594611017-4535-1-git-send-email-chunfeng.yun@mediatek.com>
         <b73d8a90-96cd-42b5-bbc2-26e300da0603@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 5DE5EC88EF47CDA1AC3C74117593930ACC115D18580B92FF06D31A130EB8FCEE2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIwLTA3LTEyIGF0IDIwOjUzIC0wNzAwLCBGbG9yaWFuIEZhaW5lbGxpIHdyb3Rl
Og0KPiANCj4gT24gNy8xMi8yMDIwIDg6MzAgUE0sIENodW5mZW5nIFl1biB3cm90ZToNCj4gPiBV
c2UgcmVhZGxfcG9sbF90aW1lb3V0KCkgdG8gcG9sbCByZWdpc3RlciBzdGF0dXMNCj4gPiANCj4g
PiBDYzogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+DQo+ID4gU2lnbmVk
LW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0t
LQ0KPiA+IHYyIGNoYW5nZXMsIHN1Z2dlc3RlZCBieSBTdGVwaGVuOg0KPiA+ICAgMS4gdXNlIHVu
c2lnbmVkIGludCBpbnN0ZWFkIG9mIGludCBmb3IgQHVzZWMgcGFyYW1ldGVyDQo+ID4gICAyLiBh
ZGQgZGV2X2xvZygpIGJhY2sNCj4gPiAgIDMuIGRyb3AgIkVyciIgaW4gZXJyb3IgbG9nDQo+ID4g
LS0tDQo+ID4gIGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19jb3JlLmMgfCAyNiArKysr
KysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9u
cygrKSwgMTUgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNi
L2dhZGdldC91ZGMvYmRjL2JkY19jb3JlLmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9i
ZGNfY29yZS5jDQo+ID4gaW5kZXggMDJhM2E3Ny4uNTNkY2NiMSAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfY29yZS5jDQo+ID4gKysrIGIvZHJpdmVycy91
c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2NvcmUuYw0KPiA+IEBAIC0xMiw2ICsxMiw3IEBADQo+ID4g
ICNpbmNsdWRlIDxsaW51eC9zcGlubG9jay5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvcGxhdGZv
cm1fZGV2aWNlLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4NCj4gPiArI2lu
Y2x1ZGUgPGxpbnV4L2lvcG9sbC5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvaW9wb3J0Lmg+DQo+
ID4gICNpbmNsdWRlIDxsaW51eC9pby5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvbGlzdC5oPg0K
PiA+IEBAIC0yOSwyNCArMzAsMTkgQEANCj4gPiAgI2luY2x1ZGUgImJkY19kYmcuaCINCj4gPiAg
DQo+ID4gIC8qIFBvbGwgdGlsbCBjb250cm9sbGVyIHN0YXR1cyBpcyBub3QgT0lQICovDQo+ID4g
LXN0YXRpYyBpbnQgcG9sbF9vaXAoc3RydWN0IGJkYyAqYmRjLCBpbnQgdXNlYykNCj4gPiArc3Rh
dGljIGludCBwb2xsX29pcChzdHJ1Y3QgYmRjICpiZGMsIHUzMiB1c2VjKQ0KPiA+ICB7DQo+ID4g
IAl1MzIgc3RhdHVzOw0KPiA+IC0JLyogUG9sbCB0aWxsIFNUUyE9IE9JUCAqLw0KPiA+IC0Jd2hp
bGUgKHVzZWMpIHsNCj4gPiAtCQlzdGF0dXMgPSBiZGNfcmVhZGwoYmRjLT5yZWdzLCBCRENfQkRD
U0MpOw0KPiA+IC0JCWlmIChCRENfQ1NUUyhzdGF0dXMpICE9IEJEQ19PSVApIHsNCj4gPiAtCQkJ
ZGV2X2RiZyhiZGMtPmRldiwNCj4gPiAtCQkJCSJwb2xsX29pcCBjb21wbGV0ZSBzdGF0dXM9JWQi
LA0KPiA+IC0JCQkJQkRDX0NTVFMoc3RhdHVzKSk7DQo+ID4gLQkJCXJldHVybiAwOw0KPiA+IC0J
CX0NCj4gPiAtCQl1ZGVsYXkoMTApOw0KPiA+IC0JCXVzZWMgLT0gMTA7DQo+ID4gLQl9DQo+ID4g
LQlkZXZfZXJyKGJkYy0+ZGV2LCAiRXJyOiBvcGVyYXRpb24gdGltZWRvdXQgQkRDU0M6IDB4JTA4
eFxuIiwgc3RhdHVzKTsNCj4gPiArCWludCByZXQ7DQo+ID4gIA0KPiA+IC0JcmV0dXJuIC1FVElN
RURPVVQ7DQo+ID4gKwlyZXQgPSByZWFkbF9wb2xsX3RpbWVvdXQoYmRjLT5yZWdzICsgQkRDX0JE
Q1NDLCBzdGF0dXMsDQo+ID4gKwkJKEJEQ19DU1RTKHN0YXR1cykgIT0gQkRDX09JUCksIDEwLCB1
c2VjKTsNCj4gDQo+IFlvdSBjb3VsZCBwcm9iYWJseSBpbmRlbnQgdGhpcyB0byB0aGUgb3Blbmlu
ZyBwYXJlbnRoZXNpcywgDQpEb25lLCB2MyBpcyBzZW50IG91dCwgdGhhbmtzDQoNCj4gYnV0IHdp
dGggb3INCj4gd2l0aG91dCBpdDoNCj4gDQo+IFJldmlld2VkLWJ5OiBGbG9yaWFuIEZhaW5lbGxp
IDxmLmZhaW5lbGxpQGdtYWlsLmNvbT4NCj4gDQo+IGFuZCB0aGFua3MgZm9yIHBpY2tpbmcgdXAg
dGhlIE1BSU5UQUlORVJTIGZpbGUgdXBkYXRlIDspDQo+IA0KPiA+ICsJaWYgKHJldCkNCj4gPiAr
CQlkZXZfZXJyKGJkYy0+ZGV2LCAib3BlcmF0aW9uIHRpbWVkb3V0IEJEQ1NDOiAweCUwOHhcbiIs
IHN0YXR1cyk7DQo+ID4gKwllbHNlDQo+ID4gKwkJZGV2X2RiZyhiZGMtPmRldiwgIiVzIGNvbXBs
ZXRlIHN0YXR1cz0lZCIsIF9fZnVuY19fLCBCRENfQ1NUUyhzdGF0dXMpKTsNCj4gPiArDQo+ID4g
KwlyZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4gIA0KPiA+ICAvKiBTdG9wIHRoZSBCREMgY29udHJv
bGxlciAqLw0KPiA+IA0KPiANCg0K

