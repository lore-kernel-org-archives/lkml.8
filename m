Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE27C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 03:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8A07206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 03:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KaU0BzgX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgGMDHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 23:07:13 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:6545 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725892AbgGMDHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 23:07:13 -0400
X-UUID: 4811811ba21d4d35a72bf7eee98a23cb-20200713
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=2l8vL3u3679ezEkrX69hcehMR167w1K+mBHFYSW1lf4=;
        b=KaU0BzgX/sQ9LtEB2ql0u2/+kmiV9yue7GHjcxHwF1Pj1hFOhk8cXwCj6RW8S+mvqkDIdwIFFeuCoPgGcI6n6iFNy196fyu+Gwt3l0sljMjTU+dQOcl0J0+eXIr9ISf7hFNkESfDClI71SNd2K/ha0fKtoSFGAQp9nBFWx9Q6M0=;
X-UUID: 4811811ba21d4d35a72bf7eee98a23cb-20200713
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1170697637; Mon, 13 Jul 2020 11:07:02 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 13 Jul
 2020 11:06:58 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 13 Jul 2020 11:07:00 +0800
Message-ID: <1594609574.23885.35.camel@mhfsdcap03>
Subject: Re: [PATCH] usb: gadget: bdc: use readl_poll_timeout() to simplify
 code
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Stephen Boyd <swboyd@chromium.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 13 Jul 2020 11:06:14 +0800
In-Reply-To: <159442422281.1987609.11864731950347548589@swboyd.mtv.corp.google.com>
References: <1594351856-876-1-git-send-email-chunfeng.yun@mediatek.com>
         <159442422281.1987609.11864731950347548589@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 5ED3BABE978817700309295AA67CE6BCA2D7FAEDCB2EABD67461765368135CB92000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTA3LTEwIGF0IDE2OjM3IC0wNzAwLCBTdGVwaGVuIEJveWQgd3JvdGU6DQo+
IFF1b3RpbmcgQ2h1bmZlbmcgWXVuICgyMDIwLTA3LTA5IDIwOjMwOjU2KQ0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfY29yZS5jIGIvZHJpdmVycy91c2Iv
Z2FkZ2V0L3VkYy9iZGMvYmRjX2NvcmUuYw0KPiA+IGluZGV4IDAyYTNhNzcuLmZhMTczZGUgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2NvcmUuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19jb3JlLmMNCj4gPiBAQCAtMzIs
MjEgKzMzLDE0IEBADQo+ID4gIHN0YXRpYyBpbnQgcG9sbF9vaXAoc3RydWN0IGJkYyAqYmRjLCBp
bnQgdXNlYykNCj4gDQo+IENhbiB3ZSBjaGFuZ2UgdXNlYyB0byB1bnNpZ25lZD8gTm90IHN1cmUg
d2h5IG5lZ2F0aXZlIHRpbWUgaXMgaW1wb3J0YW50Lg0KWWVzLCBpdCdzIHNlbnNpYmxlIHRvIHVz
ZSB1bnNpZ25lZC4NCg0KPiANCj4gPiAgew0KPiA+ICAgICAgICAgdTMyIHN0YXR1czsNCj4gPiAt
ICAgICAgIC8qIFBvbGwgdGlsbCBTVFMhPSBPSVAgKi8NCj4gPiAtICAgICAgIHdoaWxlICh1c2Vj
KSB7DQo+ID4gLSAgICAgICAgICAgICAgIHN0YXR1cyA9IGJkY19yZWFkbChiZGMtPnJlZ3MsIEJE
Q19CRENTQyk7DQo+ID4gLSAgICAgICAgICAgICAgIGlmIChCRENfQ1NUUyhzdGF0dXMpICE9IEJE
Q19PSVApIHsNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICBkZXZfZGJnKGJkYy0+ZGV2LA0K
PiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgInBvbGxfb2lwIGNvbXBsZXRlIHN0
YXR1cz0lZCIsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCRENfQ1NUUyhz
dGF0dXMpKTsNCj4gDQo+IFRoaXMgZGVidWcgbWVzc2FnZSB3YXMgbG9zdCBpbiB0aGUgY29udmVy
c2lvbi4gQW55IHJlYXNvbj8NCk5vLCB3aWxsIGFkZCBpdCBiYWNrDQo+IA0KPiA+IC0gICAgICAg
ICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+IC0gICAgICAgICAgICAgICB9DQo+ID4gLSAg
ICAgICAgICAgICAgIHVkZWxheSgxMCk7DQo+ID4gLSAgICAgICAgICAgICAgIHVzZWMgLT0gMTA7
DQo+ID4gLSAgICAgICB9DQo+ID4gLSAgICAgICBkZXZfZXJyKGJkYy0+ZGV2LCAiRXJyOiBvcGVy
YXRpb24gdGltZWRvdXQgQkRDU0M6IDB4JTA4eFxuIiwgc3RhdHVzKTsNCj4gPiArICAgICAgIGlu
dCByZXQ7DQo+ID4gIA0KPiA+IC0gICAgICAgcmV0dXJuIC1FVElNRURPVVQ7DQo+ID4gKyAgICAg
ICByZXQgPSByZWFkbF9wb2xsX3RpbWVvdXQoYmRjLT5yZWdzICsgQkRDX0JEQ1NDLCBzdGF0dXMs
DQo+ID4gKyAgICAgICAgICAgICAgIChCRENfQ1NUUyhzdGF0dXMpICE9IEJEQ19PSVApLCAxMCwg
dXNlYyk7DQo+ID4gKyAgICAgICBpZiAocmV0KQ0KPiA+ICsgICAgICAgICAgICAgICBkZXZfZXJy
KGJkYy0+ZGV2LCAiRXJyOiBvcGVyYXRpb24gdGltZWRvdXQgQkRDU0M6IDB4JTA4eFxuIiwgc3Rh
dHVzKTsNCj4gDQo+IFBsZWFzZSBkcm9wICJFcnI6IiBhcyB3ZSBoYXZlIGtlcm5lbCBsb2cgbGV2
ZWxzIChpLmUuIGRldl9lcnIoKSB1c2VkDQo+IGhlcmUpIGZvciB0aGF0Lg0KT2sNCg0KVGhhbmtz
DQoNCj4gDQo+ID4gKw0KPiA+ICsgICAgICAgcmV0dXJuIHJldDsNCj4gPiAgfQ0KDQo=

