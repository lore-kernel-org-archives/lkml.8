Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D03DC33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 02:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2629324682
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 02:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="lhq37AQm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgAOC1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 21:27:36 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:27604 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728862AbgAOC1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 21:27:36 -0500
X-UUID: 5e998053a0e64960ad6a82bb8dfbcd43-20200115
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=t7G0F5wFKNpxOWWP1HfUu2lE6k+aZLiE8/TaEH0DhZY=;
        b=lhq37AQmr4yJvlsFNVxE+ojajVnhVJpq21mBxpWRMStii4MwPz98FVfyHkUTZyNvSMr+CCVuodlKDiOqLCboEBPu/x+MkPSCGZXE8FgSy/yKQZjvqjLBkTxlrRbgNb3Mvt9+qEUXwUjAvAFYtfOO8x/goS3+8pmBLVqtb6ABPOM=;
X-UUID: 5e998053a0e64960ad6a82bb8dfbcd43-20200115
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 653031132; Wed, 15 Jan 2020 10:27:26 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 15 Jan
 2020 10:26:26 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 15 Jan 2020 10:26:37 +0800
Message-ID: <1579055239.21256.41.camel@mhfsdcap03>
Subject: Re: [RESEND PATCH v5 01/11] dt-bindings: phy-mtk-tphy: add two
 optional properties for u2phy
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Kishon Vijay Abraham I <kishon@a0393678ub>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Date:   Wed, 15 Jan 2020 10:27:19 +0800
In-Reply-To: <970b7cce-40ed-9ab7-5e04-9e3d609eadf7@ti.com>
References: <1578448326-27455-1-git-send-email-chunfeng.yun@mediatek.com>
         <20200110111006.GB2220@a0393678ub> <1578990166.21256.35.camel@mhfsdcap03>
         <970b7cce-40ed-9ab7-5e04-9e3d609eadf7@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: D6F4E3B3560C67F3EC8745B1AA703FF32EBECC3C2932946A4CB08C403FC63D962000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS2lzaG9uLA0KDQpPbiBUdWUsIDIwMjAtMDEtMTQgYXQgMTQ6MDEgKzA1MzAsIEtpc2hvbiBW
aWpheSBBYnJhaGFtIEkgd3JvdGU6DQo+IEhpIENodW5mZW5nLA0KPiANCj4gT24gMTQvMDEvMjAg
MTo1MiBQTSwgQ2h1bmZlbmcgWXVuIHdyb3RlOg0KPiA+IEhpIEtpc2hvbiwNCj4gPiANCj4gPiBP
biBGcmksIDIwMjAtMDEtMTAgYXQgMTY6NDAgKzA1MzAsIEtpc2hvbiBWaWpheSBBYnJhaGFtIEkg
d3JvdGU6DQo+ID4+IEhpLA0KPiA+Pg0KPiA+PiBPbiBXZWQsIEphbiAwOCwgMjAyMCBhdCAwOTo1
MTo1NkFNICswODAwLCBDaHVuZmVuZyBZdW4gd3JvdGU6DQo+ID4+PiBBZGQgdHdvIG9wdGlvbmFs
IHByb3BlcnRpZXMsIG9uZSBmb3IgdHVuaW5nIEotSyB2b2x0YWdlIGJ5IElOVFIsDQo+ID4+PiBh
bm90aGVyIGZvciBkaXNjb25uZWN0IHRocmVzaG9sZCwgYm90aCBvZiB0aGVtIGFyZSByZWxhdGVk
IHdpdGgNCj4gPj4+IGNvbm5lY3QgZGV0ZWN0aW9uDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1i
eTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KPiA+Pj4gQWNrZWQt
Ynk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+ID4+DQo+ID4+IFBhdGNoIGRvZXMg
bm90IGFwcGx5LiBJIGdldCB0aGUgZm9sbG93aW5nIGVycm9ycw0KPiA+PiBlcnJvcjogcGF0Y2gg
ZmFpbGVkOiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L3BoeS1tdGstdHBo
eS50eHQ6NTINCj4gPj4gZXJyb3I6IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
aHkvcGh5LW10ay10cGh5LnR4dDogcGF0Y2ggZG9lcyBub3QgYXBwbHkNCj4gPj4gZXJyb3I6IERp
ZCB5b3UgaGFuZCBlZGl0IHlvdXIgcGF0Y2g/DQo+ID4+DQo+ID4+IENhbiB5b3Ugc2VuZCB0aGVt
IGFnYWluIGluIHRoZSByaWdodCBmb3JtYXQ/DQo+ID4gSSBkb3dubG9hZCB0aGlzIHBhdGNoIGZy
b20gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMTMyMjUwNS8NCj4gPiBhbmQg
ZmV0Y2gga2VybmVsNS41LXJjNSwgdGhlbg0KPiANCj4gUGxlYXNlIHRyeSBhcHBseWluZyB0bw0K
PiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQva2lzaG9uL2xp
bnV4LXBoeS5naXQgbmV4dA0KDQpTb3JyeSwgc3RpbGwgbm90IHJlcHJvZHVjZSBpdCBvbiB5b3Vy
IG5leHQgYnJhbmNoLCBsb2dzIGFzIGZvbGxvd2luZzoNCg0KW2xpbnV4LXBoeV0kZ2l0IGFtIC0t
cmVqZWN0DQpSRVNFTkQtdjUtMDEtMTEtZHQtYmluZGluZ3MtcGh5LW10ay10cGh5LWFkZC10d28t
b3B0aW9uYWwtcHJvcGVydGllcy1mb3ItdTJwaHkucGF0Y2gNCkFwcGx5aW5nOiBkdC1iaW5kaW5n
czogcGh5LW10ay10cGh5OiBhZGQgdHdvIG9wdGlvbmFsIHByb3BlcnRpZXMgZm9yDQp1MnBoeQ0K
Q2hlY2tpbmcgcGF0Y2ggRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHkt
bXRrLXRwaHkudHh0Li4uDQpBcHBsaWVkIHBhdGNoIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9waHkvcGh5LW10ay10cGh5LnR4dA0KY2xlYW5seS4NCg0KW2xpbnV4LXBoeV0kZ2l0
IGxvZyAtLW9uZWxpbmUgLTYNCmU5M2QzY2Y3MGVlZSAoSEVBRCAtPiBuZXh0KSBkdC1iaW5kaW5n
czogcGh5LW10ay10cGh5OiBhZGQgdHdvIG9wdGlvbmFsDQpwcm9wZXJ0aWVzIGZvciB1MnBoeQ0K
MjhhMjYzODE0NjM4IChvcmlnaW4vbmV4dCkgZHQtYmluZGluZ3M6IHBoeTogQWRkIFBIWV9UWVBF
X0RQIGRlZmluaXRpb24NCjU2YjMzN2VmNTA1ZCBwaHk6IHRpOiBqNzIxZS13aXo6IEZpeCByZXR1
cm4gdmFsdWUgY2hlY2sgaW4gd2l6X3Byb2JlKCkNCmI2NmQxYWM4MjkxOCBkdC1iaW5kaW5nczog
dXNiOiBDb252ZXJ0IEFsbHdpbm5lciBBODAgVVNCIFBIWSBjb250cm9sbGVyDQp0byBhIHNjaGVt
YQ0KYjEwOWMxM2E1MzNiIHBoeTogaW50ZWwtbGdtLWVtbWM6IEZpeCB3YXJuaW5nIGJ5IGFkZGlu
ZyBtaXNzaW5nDQpNT0RVTEVfTElDRU5TRQ0KYzlmOWViYTA2NjI5IHBoeTogdGk6IGo3MjFlLXdp
ejogTWFuYWdlIHR5cGVjLWdwaW8tZGlyDQoNCj4gPiANCj4gPiBnaXQgYW0gLS1yZWplY3QNCj4g
PiBSRVNFTkQtdjUtMDEtMTEtZHQtYmluZGluZ3MtcGh5LW10ay10cGh5LWFkZC10d28tb3B0aW9u
YWwtcHJvcGVydGllcy1mb3ItdTJwaHkucGF0Y2gNCj4gPiBBcHBseWluZzogZHQtYmluZGluZ3M6
IHBoeS1tdGstdHBoeTogYWRkIHR3byBvcHRpb25hbCBwcm9wZXJ0aWVzIGZvcg0KPiA+IHUycGh5
DQo+ID4gQ2hlY2tpbmcgcGF0Y2ggRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bo
eS9waHktbXRrLXRwaHkudHh0Li4uDQo+ID4gQXBwbGllZCBwYXRjaCBEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvcGh5L3BoeS1tdGstdHBoeS50eHQNCj4gPiBjbGVhbmx5Lg0KPiA+
IA0KPiA+IGRvbid0IHJlcHJvZHVjZSB0aGUgZXJyb3IgeW91IGVuY291bnRlcmVkLCBjYW4geW91
IHRlbGwgbWUgdGhlIHN0ZXBzIHlvdQ0KPiA+IGFwcGx5IHRoZSBwYXRjaCwgdGhhbmtzDQo+IA0K
PiBnaXQgYW0gY2h1bmZlbmcueXVuLnBhdGNoIC0tcmVqZWN0DQo+IEFwcGx5aW5nOiBkdC1iaW5k
aW5nczogcGh5LW10ay10cGh5OiBhZGQgdHdvIG9wdGlvbmFsIHByb3BlcnRpZXMgZm9yIHUycGh5
DQo+IENoZWNraW5nIHBhdGNoIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkv
cGh5LW10ay10cGh5LnR4dC4uLg0KPiBlcnJvcjogd2hpbGUgc2VhcmNoaW5nIGZvcjoNCj4gLSBt
ZWRpYXRlayxleWUtdnJ0CTogdTMyLCB0aGUgc2VsZWN0aW9uIG9mIFZSVCByZWZlcmVuY2Ugdm9s
dGFnZT8NCj4gLSBtZWRpYXRlayxleWUtdGVybQk6IHUzMiwgdGhlIHNlbGVjdGlvbiBvZiBIU19U
WCBURVJNIHJlZmVyZW5jZSB2b2x0YWdlPw0KPiAtIG1lZGlhdGVrLGJjMTIJOiBib29sLCBlbmFi
bGUgQkMxMiBvZiB1MnBoeSBpZiBzdXBwb3J0IGl0Pw0KPiA/DQo+IEV4YW1wbGU6Pw0KPiA/DQpC
VFcsID8gaXMgbGluZSBicmVhaz8NCg0KV2hlbiBJIG9wZW4gdGhlIHBhdGNoIGJ5IHZpbSwgYW5k
IHNldCBpbnZsaXN0LCBsaW5lIGJyZWFrIGlzICQuDQoNCj4gDQo+IGVycm9yOiBwYXRjaCBmYWls
ZWQ6DQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvcGh5LW10ay10cGh5
LnR4dDo1Mg0KPiBBcHBseWluZyBwYXRjaCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvcGh5L3BoeS1tdGstdHBoeS50eHQNCj4gd2l0aCAxIHJlamVjdC4uLg0KPiBSZWplY3RlZCBo
dW5rICMxLg0KPiBQYXRjaCBmYWlsZWQgYXQgMDAwMSBkdC1iaW5kaW5nczogcGh5LW10ay10cGh5
OiBhZGQgdHdvIG9wdGlvbmFsDQo+IHByb3BlcnRpZXMgZm9yIHUycGh5DQo+IFVzZSAnZ2l0IGFt
IC0tc2hvdy1jdXJyZW50LXBhdGNoJyB0byBzZWUgdGhlIGZhaWxlZCBwYXRjaA0KPiBXaGVuIHlv
dSBoYXZlIHJlc29sdmVkIHRoaXMgcHJvYmxlbSwgcnVuICJnaXQgYW0gLS1jb250aW51ZSIuDQo+
IElmIHlvdSBwcmVmZXIgdG8gc2tpcCB0aGlzIHBhdGNoLCBydW4gImdpdCBhbSAtLXNraXAiIGlu
c3RlYWQuDQo+IFRvIHJlc3RvcmUgdGhlIG9yaWdpbmFsIGJyYW5jaCBhbmQgc3RvcCBwYXRjaGlu
ZywgcnVuICJnaXQgYW0gLS1hYm9ydCIuDQo+IA0KPiBUaGFua3MNCj4gS2lzaG9uDQoNCg==

