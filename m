Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,TO_MALFORMED,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACF2C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 08:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE542084D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 08:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HyEBog59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgANIXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 03:23:02 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:20611 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725860AbgANIXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 03:23:02 -0500
X-UUID: aacc4a8ed2614a2ca509c4cccb2e2dae-20200114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=PSf/TrlUffkCTyRqTndCRzJKJpXu//HKIZ0YNx6bdFw=;
        b=HyEBog59UMfoIVTKJTlH72+ea08pNuL6HVqqGdua+5ziLs8FCAMvgwYVTWNvPGEgbd0oBtUe+ZZ+nLUk1VWSPnSuDO0wij4XCQZN9daVFfMokmG2/LQ/SIDmtXKrYdkOh7dYxbv/rOqhTlNWBqcmtxOqTfxJZ5g6YWxcfrjU0gc=;
X-UUID: aacc4a8ed2614a2ca509c4cccb2e2dae-20200114
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 370260785; Tue, 14 Jan 2020 16:22:53 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 14 Jan
 2020 16:19:45 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 14 Jan 2020 16:23:04 +0800
Message-ID: <1578990166.21256.35.camel@mhfsdcap03>
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
Date:   Tue, 14 Jan 2020 16:22:46 +0800
In-Reply-To: <20200110111006.GB2220@a0393678ub>
References: <1578448326-27455-1-git-send-email-chunfeng.yun@mediatek.com>
         <20200110111006.GB2220@a0393678ub>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 1AEB94C361A44643E233821C0E36D4AF5C4CF96D15DEF8217D3092ACDB6042B82000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS2lzaG9uLA0KDQpPbiBGcmksIDIwMjAtMDEtMTAgYXQgMTY6NDAgKzA1MzAsIEtpc2hvbiBW
aWpheSBBYnJhaGFtIEkgd3JvdGU6DQo+IEhpLA0KPiANCj4gT24gV2VkLCBKYW4gMDgsIDIwMjAg
YXQgMDk6NTE6NTZBTSArMDgwMCwgQ2h1bmZlbmcgWXVuIHdyb3RlOg0KPiA+IEFkZCB0d28gb3B0
aW9uYWwgcHJvcGVydGllcywgb25lIGZvciB0dW5pbmcgSi1LIHZvbHRhZ2UgYnkgSU5UUiwNCj4g
PiBhbm90aGVyIGZvciBkaXNjb25uZWN0IHRocmVzaG9sZCwgYm90aCBvZiB0aGVtIGFyZSByZWxh
dGVkIHdpdGgNCj4gPiBjb25uZWN0IGRldGVjdGlvbg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCj4gPiBBY2tlZC1ieTog
Um9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCj4gDQo+IFBhdGNoIGRvZXMgbm90IGFwcGx5
LiBJIGdldCB0aGUgZm9sbG93aW5nIGVycm9ycw0KPiBlcnJvcjogcGF0Y2ggZmFpbGVkOiBEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L3BoeS1tdGstdHBoeS50eHQ6NTINCj4g
ZXJyb3I6IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvcGh5LW10ay10cGh5
LnR4dDogcGF0Y2ggZG9lcyBub3QgYXBwbHkNCj4gZXJyb3I6IERpZCB5b3UgaGFuZCBlZGl0IHlv
dXIgcGF0Y2g/DQo+IA0KPiBDYW4geW91IHNlbmQgdGhlbSBhZ2FpbiBpbiB0aGUgcmlnaHQgZm9y
bWF0Pw0KSSBkb3dubG9hZCB0aGlzIHBhdGNoIGZyb20gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVs
Lm9yZy9wYXRjaC8xMTMyMjUwNS8NCmFuZCBmZXRjaCBrZXJuZWw1LjUtcmM1LCB0aGVuDQoNCmdp
dCBhbSAtLXJlamVjdA0KUkVTRU5ELXY1LTAxLTExLWR0LWJpbmRpbmdzLXBoeS1tdGstdHBoeS1h
ZGQtdHdvLW9wdGlvbmFsLXByb3BlcnRpZXMtZm9yLXUycGh5LnBhdGNoDQpBcHBseWluZzogZHQt
YmluZGluZ3M6IHBoeS1tdGstdHBoeTogYWRkIHR3byBvcHRpb25hbCBwcm9wZXJ0aWVzIGZvcg0K
dTJwaHkNCkNoZWNraW5nIHBhdGNoIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
aHkvcGh5LW10ay10cGh5LnR4dC4uLg0KQXBwbGllZCBwYXRjaCBEb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvcGh5L3BoeS1tdGstdHBoeS50eHQNCmNsZWFubHkuDQoNCmRvbid0IHJl
cHJvZHVjZSB0aGUgZXJyb3IgeW91IGVuY291bnRlcmVkLCBjYW4geW91IHRlbGwgbWUgdGhlIHN0
ZXBzIHlvdQ0KYXBwbHkgdGhlIHBhdGNoLCB0aGFua3MNCg0KDQo+IA0KPiBUaGFua3MNCj4gS2lz
aG9uDQo+ID4gLS0tDQo+ID4gdjU6IGFkZCBhY2tlZC1ieSBSb2INCj4gPiANCj4gPiB2NDogbm8g
Y2hhbmdlcw0KPiA+IA0KPiA+IHYzOiBjaGFuZ2UgY29tbWl0IGxvZw0KPiA+IA0KPiA+IHYyOiBj
aGFuZ2UgZGVzY3JpcHRpb24NCj4gPiAtLS0NCj4gPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3BoeS9waHktbXRrLXRwaHkudHh0IHwgMiArKw0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvcGh5LW10ay10cGh5LnR4dCBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvcGh5LW10ay10cGh5LnR4dA0KPiA+IGluZGV4IGE1Zjdh
NGYwZGJjMS4uY2U2YWJmYmRmYmUxIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9waHkvcGh5LW10ay10cGh5LnR4dA0KPiA+ICsrKyBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvcGh5LW10ay10cGh5LnR4dA0KPiA+IEBAIC01
Miw2ICs1Miw4IEBAIE9wdGlvbmFsIHByb3BlcnRpZXMgKFBIWV9UWVBFX1VTQjIgcG9ydCAoY2hp
bGQpIG5vZGUpOg0KPiA+ICAtIG1lZGlhdGVrLGV5ZS12cnQJOiB1MzIsIHRoZSBzZWxlY3Rpb24g
b2YgVlJUIHJlZmVyZW5jZSB2b2x0YWdlDQo+ID4gIC0gbWVkaWF0ZWssZXllLXRlcm0JOiB1MzIs
IHRoZSBzZWxlY3Rpb24gb2YgSFNfVFggVEVSTSByZWZlcmVuY2Ugdm9sdGFnZQ0KPiA+ICAtIG1l
ZGlhdGVrLGJjMTIJOiBib29sLCBlbmFibGUgQkMxMiBvZiB1MnBoeSBpZiBzdXBwb3J0IGl0DQo+
ID4gKy0gbWVkaWF0ZWssZGlzY3RoCTogdTMyLCB0aGUgc2VsZWN0aW9uIG9mIGRpc2Nvbm5lY3Qg
dGhyZXNob2xkDQo+ID4gKy0gbWVkaWF0ZWssaW50cgk6IHUzMiwgdGhlIHNlbGVjdGlvbiBvZiBp
bnRlcm5hbCBSIChyZXNpc3RhbmNlKQ0KPiA+ICANCj4gPiAgRXhhbXBsZToNCj4gPiAgDQo+ID4g
LS0gDQo+ID4gMi4yNC4wDQoNCg==

