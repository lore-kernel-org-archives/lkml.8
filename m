Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89005C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 13:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55ECF20675
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 13:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cyjb4Jh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgBWNPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 08:15:19 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:62408 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726302AbgBWNPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 08:15:18 -0500
X-UUID: 1d18b034a6be43ee88cd15a93b00d9fb-20200223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=HUcMinlJztCOhwy6UvhkEzNXlyN6matYqtCW9mEf2tg=;
        b=cyjb4Jh2uiN5gqUWXcDwNSbbBVQ3VHvCM2Bac0nMvB+TU+UEj1X0VX443+da8woBc78lZX2D00EuYgtDBxqrxzXVnpF/zvaNrtN7oOulBxQJJ5XSmN6RM2SeAzYcvbTPeIwqoYFR2vF7IIKMvWuCsA2LkzSg713ZlOzSXTT6XpQ=;
X-UUID: 1d18b034a6be43ee88cd15a93b00d9fb-20200223
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 708867206; Sun, 23 Feb 2020 21:15:08 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 23 Feb 2020 21:11:02 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 23 Feb 2020 21:14:50 +0800
Message-ID: <1582463706.19053.32.camel@mtkswgap22>
Subject: Re: [PATCH] lib: iov_iter.c: fix a possible calculation error on
 remaining bytes
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Shen Jing <jingx.shen@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Jerry Zhang <zhangjerry@google.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
Date:   Sun, 23 Feb 2020 21:15:06 +0800
In-Reply-To: <20200218124142.GJ23230@ZenIV.linux.org.uk>
References: <1582011672-17189-1-git-send-email-macpaul.lin@mediatek.com>
         <20200218124142.GJ23230@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: D743D5FFED43F9BC952FE27FF4BE8AE9BAFC6F359885D5FD278658A4DF9A560E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTAyLTE4IGF0IDEyOjQxICswMDAwLCBBbCBWaXJvIHdyb3RlOg0KPiBPbiBU
dWUsIEZlYiAxOCwgMjAyMCBhdCAwMzo0MToxMlBNICswODAwLCBNYWNwYXVsIExpbiB3cm90ZToN
Cj4gPiBUaGlzIGlzc3VlIHdhcyBmb3VuZCB3aGVuIGFkYmQgdHJ5aW5nIHRvIG9wZW4gZnVuY3Rp
b25mcyB3aXRoIEFJTyBtb2RlLg0KPiA+IFVzdWFsbHksIHdlIG5lZWQgdG8gc2V0ICJzZXRwcm9w
IHN5cy51c2IuZmZzLmFpb19jb21wYXQgMCIgdG8gZW5hYmxlDQo+ID4gYWRiZCB3aXRoIEFJTyBt
b2RlIG9uIEFuZHJvaWQuDQo+ID4gDQo+ID4gV2hlbiBhZGJkIGlzIG9wZW5pbmcgZnVuY3Rpb25m
cywgaXQgd2lsbCB0cnkgdG8gcmVhZCAyNCBieXRlcyBhdCB0aGUNCj4gPiBmaXNydCByZWFkIEkv
TyBjb250cm9sLiBJZiB0aGlzIHJlYWRpbmcgaGFzIGJlZW4gZmFpbGVkLCBhZGJkIHdpbGwNCj4g
PiB0cnkgdG8gc2VuZCBGVU5DVElPTkZTX0NMRUFSX0hBTFQgdG8gZnVuY3Rpb25mcy4gV2hlbiBh
ZGJkIGlzIGluIEFJTw0KPiA+IG1vZGUsIGZ1bmN0aW9uZnMgd2lsbCBiZSBhY3RlZCB3aXRoIGFz
eW5jcm9uaXplZCBJL08gcGF0aC4gQWZ0ZXIgdGhlDQo+ID4gc3VjY2Vzc2Z1bCByZWFkIHRyYW5z
ZmVyIGhhcyBiZWVuIGNvbXBsZXRlZCBieSBnYWRnZXQgaGFyZHdhcmUsIHRoZQ0KPiA+IGZvbGxv
d2luZyBzZXJpZXMgb2YgZnVuY3Rpb25zIHdpbGwgYmUgY2FsbGVkLg0KPiA+ICAgZmZzX2VwZmls
ZV9hc3luY19pb19jb21wbGV0ZSgpIC0+IGZmc191c2VyX2NvcHlfd29ya2VyKCkgLT4NCj4gPiAg
ICAgY29weV90b19pdGVyKCkgLT4gX2NvcHlfdG9faXRlcigpIC0+IGNvcHlvdXQoKSAtPg0KPiA+
ICAgICBpdGVyYXRlX2FuZF9hZHZhbmNlKCkgLT4gaXRlcmF0ZV9pb3ZlYygpDQo+ID4gDQo+ID4g
QWRkaW5nIGRlYnVnIHRyYWNlIHRvIHRoZXNlIGZ1bmN0aW9ucywgaXQgaGFzIGJlZW4gZm91bmQg
dGhhdCBpbg0KPiA+IGl0ZXJhdGVfaW92ZWMoKSwgdGhlIGNhbGN1bGF0aW9uIHJlc3VsdCBvZiBu
IHdpbGwgYmUgdHVybmVkIGludG8gemVyby4NCj4gPiAgICBuID0gd2FudGVkIC0gbjsgLyogMCA9
PSBuID0gMjQgLSAyNDsgKi8NCj4gPiBXaGljaCBjYXVzZXMgY29weW91dCgpIHdvbid0IGNvcHkg
ZGF0YSB0byB1c2Vyc3BhY2Ugc2luY2UgdGhlIGxlbmd0aA0KPiA+IHRvIGJlIGNvcGllZCAidi5p
b3ZfbGVuIiB3aWxsIGJlIHplcm8sIHdoaWNoIGlzbid0IGNvcnJlY3QuIFRoaXMgYWxzbw0KPiA+
IGxlYWRzIGZmc19jb3B5X3RvX2l0ZXIoKSBhbHdheXMgcmV0dXJuIC1FRkFVTFQuIEZpbmFsbHkg
YWRiZCBjYW5ub3QNCj4gPiBvcGVuIGZ1bmN0aW9uZnMgYW5kIHNlbmQgRlVOQ1RJT05GU19DTEVB
Ul9IQUxULg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hY3BhdWwgTGluIDxtYWNwYXVsLmxp
bkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGxpYi9pb3ZfaXRlci5jIHwgMyArKy0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0K
PiA+IGRpZmYgLS1naXQgYS9saWIvaW92X2l0ZXIuYyBiL2xpYi9pb3ZfaXRlci5jDQo+ID4gaW5k
ZXggZmIyOWMwMmM2YTNjLi5mOTMzNDE0NGUyNTkgMTAwNjQ0DQo+ID4gLS0tIGEvbGliL2lvdl9p
dGVyLmMNCj4gPiArKysgYi9saWIvaW92X2l0ZXIuYw0KPiA+IEBAIC0zNiw3ICszNiw4IEBADQo+
ID4gIAkJc2tpcCA9IF9fdi5pb3ZfbGVuOwkJCVwNCj4gPiAgCQluIC09IF9fdi5pb3ZfbGVuOwkJ
CVwNCj4gPiAgCX0JCQkJCQlcDQo+ID4gLQluID0gd2FudGVkIC0gbjsJCQkJCVwNCj4gPiArCWlm
IChuICE9IHdhbnRlZCkJCQkJXA0KPiA+ICsJCW4gPSB3YW50ZWQgLSBuOwkJCQlcDQo+ID4gIH0N
Cj4gDQo+IAlGaXJzdCBvZiBhbGwsIG5vdGhpbmcgaW4gdGhhdCBsaW5lIGNhbiBwb3NzaWJseSAq
Y2F1c2UqDQo+IGNvcHlvdXQoKSB0byBkbyBhbnl0aGluZyAtIGl0J3MgYWZ0ZXIgdGhlIGNhbGxz
IG9mIHN0ZXAuICBXaGF0J3MNCj4gbW9yZSwgdGhpcyBjaGFuZ2VzIGJlaGF2aW91ciBvbmx5IHdo
ZW4gd2FudGVkIHdvdWxkJ3ZlIGJlZW4gZXF1YWwgdG8NCj4gbiwgZG9lc24ndCBpdD8gIFdoaWNo
IHRyYW5zbGF0ZXMgaW50byAibm8gZGVjcmVtZW50cyBvZiBuIGhhdmUNCj4gaGFwcGVuZWQgYXQg
YWxsIiwgaS5lLiAibm90aGluZyBoYXMgYmVlbiBjb3BpZWQiLiAgSU9XLCBpdCdzDQo+IGEgY29u
c2VxdWVuY2Ugb2Ygbm8gY29weW91dCwgbm90IHRoZSBjYXVzZSBvZiBzdWNoLiAgWW91IGNhbg0K
PiBtYWtlIGNvcHlfdG9faXRlcigpIGxpZSBhbmQgcHJldGVuZCBpZiBoYXMgY29waWVkIGV2ZXJ5
dGhpbmcNCj4gd2hlbiBpdCBoYXMgY29waWVkIG5vdGhpbmcsIGJ1dCB0aGF0IHdvbid0IGNoYW5n
ZSB0aGUgdW5kZXJseWluZw0KPiBidWcuDQo+IA0KPiAJU28gSSdtIGFmcmFpZCB5b3VyIGRlYnVn
Z2luZyBpcyBub3QgZmluaXNoZWQgLSB5b3UNCj4gc3RpbGwgbmVlZCB0byBmaW5kIG91dCB3aGF0
IGNhdXNlcyB0aGUgY29weW91dCBmYWlsdXJlcyBhbmQvb3INCj4gQlMgaW92X2l0ZXIgcGFkZGVk
IGJ5IGNhbGxlci4NCg0KVGhhbmtzIGZvciB5b3VyIGV4cGxhbmF0aW9uLiBBZnRlciB0aGVzZSBk
YXlzLCBJJ3ZlIGZvdW5kIHRoaXMgaXNzdWUNCm9ubHkgaGFwcGVuZWQgb24gYXJtIDY0LWJpdCBz
eXN0ZW0sIHdoaWxlIGFybSAzMi1iaXQgc3lzdGVtIHdvcmtzIHdlbGwuDQpBZnRlciBtb3JlIGRl
YnVnZ2luZywgaXQgbG9va3MgbGlrZSBhcm0gNjQgdGFnZ2VkIEFCSSByZWxhdGVkIGlzc3VlLg0K
SSd2ZSB1cGRhdGUgYSBuZXcgcGF0Y2ggaGVyZTogDQogICAgdXNiOiBnYWRnZXQ6IGZfZnM6IHRy
eSB0byBmaXggQUlPIGlzc3VlIHVuZGVyIEFSTSA2NCBiaXQgVEFHR0VEIG1vZGUNCiAgICBodHRw
czovL2xrbWwub3JnL2xrbWwvMjAyMC8yLzIzLzE2Lg0KDQpUaGFua3MuDQpNYWNwYXVsIExpbi4N
Cg==

