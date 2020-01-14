Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,TO_MALFORMED,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF46EC33CAF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 00:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 923462080D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 00:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Cgc4VRZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgANAbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 19:31:03 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:4948 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728838AbgANAbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 19:31:03 -0500
X-UUID: b64d3bbc8486442fb8107ded0c55dc3a-20200114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=9hc72qii6aEbO5HSZ/JJr0ZnpKxriy/nHTRZcH5uTGc=;
        b=Cgc4VRZi2oDVXSOd1pVglWjNlQ2CSP8IRlENBYgN8jcFHuJ9CJccjI3v9bbaPhyGX6oELFonJdA4X07hTEY/OKTiQ2cQ6fTZ0HxfMYco6+J7SlHE6dtj+zBouiV7wXdUK5fCV7S0iJnTovpXARSS47Gw5+5fHqRe6tl/pqX2wss=;
X-UUID: b64d3bbc8486442fb8107ded0c55dc3a-20200114
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 545209942; Tue, 14 Jan 2020 08:30:55 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32DR.mediatek.inc
 (172.27.6.104) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 14 Jan
 2020 08:30:00 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 14 Jan 2020 08:30:09 +0800
Message-ID: <1578961847.21256.27.camel@mhfsdcap03>
Subject: Re: [RESEND PATCH v5 01/11] dt-bindings: phy-mtk-tphy: add two
 optional properties for u2phy
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@a0393678ub>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Date:   Tue, 14 Jan 2020 08:30:47 +0800
In-Reply-To: <20200110111006.GB2220@a0393678ub>
References: <1578448326-27455-1-git-send-email-chunfeng.yun@mediatek.com>
         <20200110111006.GB2220@a0393678ub>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: AF61AF8D6FD7E89E3E467A138EA30DB0D5E4DFF88A35929018A5237C3BB832952000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTAxLTEwIGF0IDE2OjQwICswNTMwLCBLaXNob24gVmlqYXkgQWJyYWhhbSBJ
IHdyb3RlOg0KPiBIaSwNCj4gDQo+IE9uIFdlZCwgSmFuIDA4LCAyMDIwIGF0IDA5OjUxOjU2QU0g
KzA4MDAsIENodW5mZW5nIFl1biB3cm90ZToNCj4gPiBBZGQgdHdvIG9wdGlvbmFsIHByb3BlcnRp
ZXMsIG9uZSBmb3IgdHVuaW5nIEotSyB2b2x0YWdlIGJ5IElOVFIsDQo+ID4gYW5vdGhlciBmb3Ig
ZGlzY29ubmVjdCB0aHJlc2hvbGQsIGJvdGggb2YgdGhlbSBhcmUgcmVsYXRlZCB3aXRoDQo+ID4g
Y29ubmVjdCBkZXRlY3Rpb24NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4g
PGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+ID4gQWNrZWQtYnk6IFJvYiBIZXJyaW5nIDxy
b2JoQGtlcm5lbC5vcmc+DQo+IA0KPiBQYXRjaCBkb2VzIG5vdCBhcHBseS4gSSBnZXQgdGhlIGZv
bGxvd2luZyBlcnJvcnMNCj4gZXJyb3I6IHBhdGNoIGZhaWxlZDogRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3BoeS9waHktbXRrLXRwaHkudHh0OjUyDQo+IGVycm9yOiBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L3BoeS1tdGstdHBoeS50eHQ6IHBhdGNoIGRv
ZXMgbm90IGFwcGx5DQo+IGVycm9yOiBEaWQgeW91IGhhbmQgZWRpdCB5b3VyIHBhdGNoPw0KPiAN
Cj4gQ2FuIHlvdSBzZW5kIHRoZW0gYWdhaW4gaW4gdGhlIHJpZ2h0IGZvcm1hdD8NClNvcnJ5LCBJ
J2xsIGNoZWNrIGl0Lg0KDQo+IA0KPiBUaGFua3MNCj4gS2lzaG9uDQo+ID4gLS0tDQo+ID4gdjU6
IGFkZCBhY2tlZC1ieSBSb2INCj4gPiANCj4gPiB2NDogbm8gY2hhbmdlcw0KPiA+IA0KPiA+IHYz
OiBjaGFuZ2UgY29tbWl0IGxvZw0KPiA+IA0KPiA+IHYyOiBjaGFuZ2UgZGVzY3JpcHRpb24NCj4g
PiAtLS0NCj4gPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktbXRr
LXRwaHkudHh0IHwgMiArKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+
ID4gDQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
aHkvcGh5LW10ay10cGh5LnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
aHkvcGh5LW10ay10cGh5LnR4dA0KPiA+IGluZGV4IGE1ZjdhNGYwZGJjMS4uY2U2YWJmYmRmYmUx
IDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkv
cGh5LW10ay10cGh5LnR4dA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9waHkvcGh5LW10ay10cGh5LnR4dA0KPiA+IEBAIC01Miw2ICs1Miw4IEBAIE9wdGlvbmFs
IHByb3BlcnRpZXMgKFBIWV9UWVBFX1VTQjIgcG9ydCAoY2hpbGQpIG5vZGUpOg0KPiA+ICAtIG1l
ZGlhdGVrLGV5ZS12cnQJOiB1MzIsIHRoZSBzZWxlY3Rpb24gb2YgVlJUIHJlZmVyZW5jZSB2b2x0
YWdlDQo+ID4gIC0gbWVkaWF0ZWssZXllLXRlcm0JOiB1MzIsIHRoZSBzZWxlY3Rpb24gb2YgSFNf
VFggVEVSTSByZWZlcmVuY2Ugdm9sdGFnZQ0KPiA+ICAtIG1lZGlhdGVrLGJjMTIJOiBib29sLCBl
bmFibGUgQkMxMiBvZiB1MnBoeSBpZiBzdXBwb3J0IGl0DQo+ID4gKy0gbWVkaWF0ZWssZGlzY3Ro
CTogdTMyLCB0aGUgc2VsZWN0aW9uIG9mIGRpc2Nvbm5lY3QgdGhyZXNob2xkDQo+ID4gKy0gbWVk
aWF0ZWssaW50cgk6IHUzMiwgdGhlIHNlbGVjdGlvbiBvZiBpbnRlcm5hbCBSIChyZXNpc3RhbmNl
KQ0KPiA+ICANCj4gPiAgRXhhbXBsZToNCj4gPiAgDQo+ID4gLS0gDQo+ID4gMi4yNC4wDQoNCg==

