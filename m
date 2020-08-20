Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AA6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 01:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBF80207DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 01:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="J1IlM1Yh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgHTB6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 21:58:21 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:62776 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726362AbgHTB6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 21:58:21 -0400
X-UUID: 458344327af840cf9009a36fee9ac9c5-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=EFWywN6zeLfx3mYDlfu+y15rEMdXgmrxserMhZ887hk=;
        b=J1IlM1Yh+IHRVrTZB10AbJJjGKJIysMwZxenNX8Ft9rLwFeBaUaZpAmzSONDJdkWSaIEyuXNZrptSzF00gOsovKM15ESR3J7/GOay1iESu2CnkD99HcLAahG3JqX0QJF6e0qy2hezG2roBv4hil5Of18//EPupwNMU9T1Xqd/v8=;
X-UUID: 458344327af840cf9009a36fee9ac9c5-20200820
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 481422092; Thu, 20 Aug 2020 09:58:15 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 20 Aug
 2020 09:58:14 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 09:58:10 +0800
Message-ID: <1597888623.23067.19.camel@mhfsdcap03>
Subject: Re: [PATCH 10/10] usb: udc: net2280: convert to
 readl_poll_timeout_atomic()
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>
Date:   Thu, 20 Aug 2020 09:57:03 +0800
In-Reply-To: <20200819145957.GA183103@rowland.harvard.edu>
References: <1597840865-26631-1-git-send-email-chunfeng.yun@mediatek.com>
         <1597840865-26631-10-git-send-email-chunfeng.yun@mediatek.com>
         <20200819145957.GA183103@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 22D2EDA70C9DE4A57BACB86CCD4B9AF55312C82D351F55D5F12277413D9518212000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA4LTE5IGF0IDEwOjU5IC0wNDAwLCBBbGFuIFN0ZXJuIHdyb3RlOg0KPiBP
biBXZWQsIEF1ZyAxOSwgMjAyMCBhdCAwODo0MTowNVBNICswODAwLCBDaHVuZmVuZyBZdW4gd3Jv
dGU6DQo+ID4gVXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2Rl
DQo+ID4gDQo+ID4gQ2M6IEFsYW4gU3Rlcm4gPHN0ZXJuQHJvd2xhbmQuaGFydmFyZC5lZHU+DQo+
ID4gQ2M6IEZlbGlwZSBCYWxiaSA8YmFsYmlAa2VybmVsLm9yZz4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4g
IGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvbmV0MjI4MC5jIHwgMjEgKysrKysrKysrKy0tLS0tLS0t
LS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMo
LSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9uZXQyMjgw
LmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL25ldDIyODAuYw0KPiA+IGluZGV4IDc1MzBiZDku
LmYxYTIxZjQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9uZXQyMjgw
LmMNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL25ldDIyODAuYw0KPiA+IEBAIC01
Miw2ICs1Miw3IEBADQo+ID4gICNpbmNsdWRlIDxsaW51eC91c2IvZ2FkZ2V0Lmg+DQo+ID4gICNp
bmNsdWRlIDxsaW51eC9wcmVmZXRjaC5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvaW8uaD4NCj4g
PiArI2luY2x1ZGUgPGxpbnV4L2lvcG9sbC5oPg0KPiA+ICANCj4gPiAgI2luY2x1ZGUgPGFzbS9i
eXRlb3JkZXIuaD4NCj4gPiAgI2luY2x1ZGUgPGFzbS9pcnEuaD4NCj4gPiBAQCAtMzYwLDE4ICsz
NjEsMTYgQEAgc3RhdGljIGlubGluZSB2b2lkIGVuYWJsZV9wY2lpcnFlbmIoc3RydWN0IG5ldDIy
ODBfZXAgKmVwKQ0KPiA+ICBzdGF0aWMgaW50IGhhbmRzaGFrZSh1MzIgX19pb21lbSAqcHRyLCB1
MzIgbWFzaywgdTMyIGRvbmUsIGludCB1c2VjKQ0KPiA+ICB7DQo+ID4gIAl1MzIJcmVzdWx0Ow0K
PiA+ICsJaW50CXJldDsNCj4gPiAgDQo+ID4gLQlkbyB7DQo+ID4gLQkJcmVzdWx0ID0gcmVhZGwo
cHRyKTsNCj4gPiAtCQlpZiAocmVzdWx0ID09IH4odTMyKTApCQkvKiAiZGV2aWNlIHVucGx1Z2dl
ZCIgKi8NCj4gPiAtCQkJcmV0dXJuIC1FTk9ERVY7DQo+ID4gLQkJcmVzdWx0ICY9IG1hc2s7DQo+
ID4gLQkJaWYgKHJlc3VsdCA9PSBkb25lKQ0KPiA+IC0JCQlyZXR1cm4gMDsNCj4gPiAtCQl1ZGVs
YXkoMSk7DQo+ID4gLQkJdXNlYy0tOw0KPiA+IC0JfSB3aGlsZSAodXNlYyA+IDApOw0KPiA+IC0J
cmV0dXJuIC1FVElNRURPVVQ7DQo+ID4gKwlyZXQgPSByZWFkbF9wb2xsX3RpbWVvdXRfYXRvbWlj
KHB0ciwgcmVzdWx0LA0KPiA+ICsJCQkJCSgocmVzdWx0ICYgbWFzaykgPT0gZG9uZSB8fA0KPiA+
ICsJCQkJCSByZXN1bHQgPT0gVTMyX01BWCksDQo+ID4gKwkJCQkJMSwgdXNlYyk7DQo+ID4gKwlp
ZiAocmVzdWx0ID09IFUzMl9NQVgpCQkvKiBkZXZpY2UgdW5wbHVnZ2VkICovDQo+ID4gKwkJcmV0
dXJuIC1FTk9ERVY7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIHJldDsNCj4gPiAgfQ0KPiA+ICANCj4g
PiAgc3RhdGljIGNvbnN0IHN0cnVjdCB1c2JfZXBfb3BzIG5ldDIyODBfZXBfb3BzOw0KPiA+IC0t
IA0KPiANCj4gQWNrZWQtYnk6IEFsYW4gU3Rlcm4gPHN0ZXJuQHJvd2xhbmQuaGFydmFyZC5lZHU+
DQo+IA0KPiBIb3dldmVyLCBJIG5vdGljZWQgdGhhdCB0aGUga2VybmVsZG9jIGZvciByZWFkbF9w
b2xsX3RpbWVvdXRfYXRvbWljKCkgaXMgDQo+IG91dCBvZiBkYXRlLiAgQ2FuIHlvdSBmaXggaXQg
dXA/DQpPaywgd2lsbCBkbyBpdCwgdGhhbmtzDQoNCj4gDQo+IEFsYW4gU3Rlcm4NCg0K

