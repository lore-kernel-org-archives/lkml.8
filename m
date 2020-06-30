Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3737C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B845E20759
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="P+OSWT6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbgF3HE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:04:28 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:39226 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730386AbgF3HE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:04:27 -0400
X-UUID: 24aee6f623034ba788fcf49abffd2938-20200630
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=85Y8+6bkZLH5yMFgsr9O3/8M6UcByJwt+cBROWXTJxI=;
        b=P+OSWT6F21j9ksS46fSGcHQdhA/2bejizLU1uJCuAa9XA+6VnvoNpdrGX/F2dNeBvm2rymKbuIQcALj8BS374rJgdXYcXX5pgeQ+0rUDU9GTRmVJ8Qz4fZDThMywhMIayoVtk5luXCsbQPHhbqWQ01EnbfSRB7Hd66Hq8FcktwY=;
X-UUID: 24aee6f623034ba788fcf49abffd2938-20200630
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2056151911; Tue, 30 Jun 2020 15:04:12 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 30 Jun
 2020 15:04:10 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 30 Jun 2020 15:04:09 +0800
Message-ID: <1593500631.3798.9.camel@mhfsdcap03>
Subject: Re: [PATCH 1/2] usb: mtu3: disable USB2 LPM
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Peter Chen <hzpeterchen@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        USB list <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 30 Jun 2020 15:03:51 +0800
In-Reply-To: <CAL411-qVjxYk7f+b74XHfj7jpxALS4LYUKe0XdSfwRZcQibNfA@mail.gmail.com>
References: <1593410434-19406-1-git-send-email-chunfeng.yun@mediatek.com>
         <CAL411-qVjxYk7f+b74XHfj7jpxALS4LYUKe0XdSfwRZcQibNfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: FC147824681EC42AD367BF2416B37B5EB0CDBAF9C30100AADD32FDD739E780162000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA2LTI5IGF0IDE1OjM3ICswODAwLCBQZXRlciBDaGVuIHdyb3RlOg0KPiBP
biBNb24sIEp1biAyOSwgMjAyMCBhdCAyOjA0IFBNIENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVu
QG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBBIFN1cGVyU3BlZWQgZGV2aWNlIHNoYWxs
IGluY2x1ZGUgdGhlIFVTQiAyLjAgZXh0ZW5zaW9uIGRlc2NyaXB0b3INCj4gPiBhbmQgc2hhbGwg
c3VwcG9ydCBMUE0gd2hlbiBvcGVyYXRpbmcgaW4gVVNCIDIuMCBIUyBtb2RlKHNlZSB1c2IzLjIN
Cj4gPiBzcGVjOS42LjIuMSkuIEJ1dCB3ZSBhbHdheXMgZG9uJ3Qgc3VwcG9ydCBpdCwgc28gZGlz
YWJsZSBpdCBieQ0KPiA+IGRlZmF1bHQsIG90aGVyd2lzZSBkZXZpY2Ugd2lsbCBlbnRlciBMUE0g
c3VzcGVuZCBtb2RlIHdoZW4NCj4gPiBjb25uZWN0ZWQgdG8gV2luMTAgc3lzdGVtLg0KPiANCj4g
TGludXggYWxzbyBzdXBwb3J0cyBVU0IyIExQTS4gQmVzaWRlcywgVVNCLUlGIENIOSB0ZXN0IHdp
bGwgY2hlY2sNCj4gTFBNIHN1cHBvcnQgaWYgdGhlIGRldmljZSBpcyBVU0IgMi4xLCBob3cgY291
bGQgeW91IGRlYWwgd2l0aCBpdD8NCkluZGVlZCBuZWVkIHN1cHBvcnQgaXQgZm9yIFNTIGRldmlj
ZSwgSSdsbCBjaGVjayBpdCBhZ2FpbiwgdGhhbmtzIGEgbG90DQoNCj4gDQo+IFBldGVyDQo+IA0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0
ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3VzYi9tdHUzL210dTNfY29yZS5jIHwgMiAr
Kw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy91c2IvbXR1My9tdHUzX2NvcmUuYyBiL2RyaXZlcnMvdXNiL210dTMvbXR1
M19jb3JlLmMNCj4gPiBpbmRleCA5ZGQwMjE2Li41MGQ2YTQwIDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvdXNiL210dTMvbXR1M19jb3JlLmMNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9tdHUzL210
dTNfY29yZS5jDQo+ID4gQEAgLTYwNCw2ICs2MDQsOCBAQCBzdGF0aWMgdm9pZCBtdHUzX3JlZ3Nf
aW5pdChzdHJ1Y3QgbXR1MyAqbXR1KQ0KPiA+ICAgICAgICAgbXR1M19jbHJiaXRzKG1iYXNlLCBV
M0RfTUlTQ19DVFJMLCBWQlVTX0ZSQ19FTiB8IFZCVVNfT04pOw0KPiA+ICAgICAgICAgLyogZW5h
YmxlIGF1dG9tYXRpY2FsIEhXUlcgZnJvbSBMMSAqLw0KPiA+ICAgICAgICAgbXR1M19zZXRiaXRz
KG1iYXNlLCBVM0RfUE9XRVJfTUFOQUdFTUVOVCwgTFBNX0hSV0UpOw0KPiA+ICsgICAgICAgLyog
YWx3YXlzIHJlamVjdCBMUE0gcmVxdWVzdCAqLw0KPiA+ICsgICAgICAgbXR1M19zZXRiaXRzKG1i
YXNlLCBVM0RfUE9XRVJfTUFOQUdFTUVOVCwgTFBNX01PREUoMSkpOw0KPiA+DQo+ID4gICAgICAg
ICAvKiB1c2UgbmV3IFFNVSBmb3JtYXQgd2hlbiBIVyB2ZXJzaW9uID49IDB4MTAwMyAqLw0KPiA+
ICAgICAgICAgaWYgKG10dS0+Z2VuMmNwKQ0KPiA+IC0tDQo+ID4gMS45LjENCj4gPiBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiA+IGxpbnV4LWFybS1r
ZXJuZWwgbWFpbGluZyBsaXN0DQo+ID4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnDQo+ID4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1hcm0ta2VybmVsDQoNCg==

