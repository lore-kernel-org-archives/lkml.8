Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A8DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 11:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C97132085B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 11:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="G9mBCbvh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbgFRLGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 07:06:42 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54375 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726899AbgFRLGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 07:06:40 -0400
X-UUID: 12f8283cd6e04178a0277243b321be26-20200618
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Rw+XJf9G3LmNKirn/C94v5PKCGl3yGm8pZ+FUDGL5Qk=;
        b=G9mBCbvh01ky2dZXebCbEZApZIWckXVtny7t0q5wTtNkEP6cH6CemsJMQu0JDZKs8kTHI2bHIqVOietvbs50o+ZhCmFS2B+WkQX9v1JJVNLR5XNqkykWTrNUOIUtMO7JUNr7VTjV53MIDzBbQ/u5APiIlPMD87DcjIuPDaXrtn0=;
X-UUID: 12f8283cd6e04178a0277243b321be26-20200618
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 172430460; Thu, 18 Jun 2020 19:06:36 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 18 Jun 2020 19:06:32 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 18 Jun 2020 19:06:32 +0800
Message-ID: <1592478394.6408.9.camel@mtkswgap22>
Subject: Re: [PATCH v8 0/4] Add basic SoC support for mt6765
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        mtk01761 <wendell.lin@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Evan Green <evgreen@chromium.org>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <jroedel@suse.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        "Mediatek WSD Upstream" <wsd_upstream@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
Date:   Thu, 18 Jun 2020 19:06:34 +0800
In-Reply-To: <1582279929-11535-1-git-send-email-macpaul.lin@mediatek.com>
References: <1582279929-11535-1-git-send-email-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTAyLTIxIGF0IDE4OjEyICswODAwLCBNYWNwYXVsIExpbiB3cm90ZToNCj4g
VGhpcyBwYXRjaCBhZGRzIGJhc2ljIFNvQyBzdXBwb3J0IGZvciBNZWRpYXRlaydzIG5ldyA4LWNv
cmUgU29DLA0KPiBNVDY3NjUsIHdoaWNoIGlzIG1haW5seSBmb3Igc21hcnRwaG9uZSBhcHBsaWNh
dGlvbi4NCj4gDQo+IENoYW5nZXMgaW4gVjg6DQo+IDEuIE9yaWdpbiBWNyBwYXRjaHNldDoNCj4g
ICAgaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9jb3Zlci8xMTM3MDEwNS8NCj4gICAgU3Bs
aXQgb3JpZ2luIFY3IHBhdGNoc2V0IGludG8gMiBwYXRjaHNldCwNCj4gICAga2VlcCByZW1haW4g
cGF0Y2hlcyAjMiwgIzUsICM2LCBhbmQgIzcgaW4gdGhlIHNhbWUgb3JkZXIgYXMgdGhpcw0KPiAg
ICBWOCBwYXRjaHNldC4NCj4gICAgW3Y3LDIvN10gZHQtYmluZGluZ3M6IG1lZGlhdGVrOiBBZGQg
c21pIGR0cyBiaW5kaW5nIGZvciBNZWRpYXRlaw0KPiAgICAgICAgICAgICBNVDY3NjUgU29DDQo+
ICAgIFt2Nyw1LzddIHNvYzogbWVkaWF0ZWs6IGFkZCBNVDY3NjUgc2Nwc3lzIGFuZCBzdWJkb21h
aW4gc3VwcG9ydA0KPiAgICBbdjcsNi83XSBhcm02NDogZHRzOiBtZWRpYXRlazogYWRkIG10Njc2
NSBzdXBwb3J0DQo+ICAgIFt2Nyw3LzddIGFybTY0OiBkZWZjb25maWc6IGFkZCBDT05GSUdfQ09N
TU9OX0NMS19NVDY3NjVfWFhYIGNsb2Nrcw0KPiANCj4gQ2hhbmdlcyBpbiBWNzoNCj4gMS4gQWRh
cHQgVjYncyBwYXRjaHNldCB0byBsYXRlc3Qga2VybmVsIHRyZWUgNS41LXJjMS4NCj4gICAgT3Jp
Z2luIFY2IHBhdGNoc2V0Og0KPiAgICBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL2NvdmVy
LzExMDQxOTYzLw0KPiAyLiBDb3JyZWN0IDIgY2xvY2stY29udHJvbGxlciB0eXBlIGluIGRvY3Vt
ZW50YXRpb246DQo+ICAgIG1pcGkwIGFuZCB2ZW5jX2djb24uDQo+ICAgIFt2NyAxLzddIGR0LWJp
bmRpbmdzOiBjbG9jazogbWVkaWF0ZWs6IGRvY3VtZW50IGNsayBiaW5kaW5ncw0KPiAzLiBSZW1v
dmUgVjYncyBwYXRjaCAwMyBiZWNhdXNlIGl0IGhhcyBiZWVuIHRha2VuIGludG8gNS41LW5leHQt
c29jDQo+ICAgIFt2NiwgMDMvMDhdIGR0LWJpbmRpbmdzOiBtZWRpYXRlazogYWRkIE1UNjc2NSBw
b3dlciBkdC1iaW5kaW5ncw0KPiAzLiBVcGRhdGUgUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxy
b2JoQGtlcm5lbC5vcmc+IGZvcg0KPiAgICBbdjYsIDA0LzA4XSBjbGs6IG1lZGlhdGVrOiBhZGQg
bXQ2NzY1IGNsb2NrIElEcw0KPiAgICAtLT4gW3Y3LCAwMy8wN10gY2xrOiBtZWRpYXRlazogYWRk
IG10Njc2NSBjbG9jayBJRHMNCj4gNC4gVXBkYXRlIFNQRFggdGFnIGZvcg0KPiAgICBbdjYsIDA1
LzA4XSBjbGs6IG1lZGlhdGVrOiBBZGQgTVQ2NzY1IGNsb2NrIHN1cHBvcnQNCj4gICAgLS0+IFt2
NywgMDQvMDddIGNsazogbWVkaWF0ZWs6IEFkZCBNVDY3NjUgY2xvY2sgc3VwcG9ydA0KPiANCj4g
Q2hhbmdlcyBpbiBWNjoNCj4gMS4gQWRhcHQgVjUncyBwYXRjaHNldCB0byBsYXRlc3Qga2VybmVs
IHRyZWUuDQo+ICAgIE9yaWdpbiBWNSBwYXRjaHNldC4NCj4gICAgaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvcGF0Y2h3b3JrL2NvdmVyLzk2MzYxMi8NCj4gMi4gRHVlIHRvIGNsaydzIGNvbW1vbiBj
b2RlIGhhcyBiZWVuIHN1Ym1pdCBieSBvdGhlciBwbGF0Zm9ybSwNCj4gICAgdGhpcyBwYXRjaCBz
ZXQgd2lsbCBoYXZlIGRlcGVuZGVuY2llcyB3aXRoIHRoZSBmb2xsb3dpbmcgcGF0Y2hzZXRzDQo+
ICAgIGFzIHRoZSBmb2xsb3dpbmcgb3JkZXJzLg0KPiAgICAyLmEuIFt2OCwwMC8yMV0gTVQ4MTgz
IElPTU1VIFNVUFBPUlQNCj4gICAgICAgICBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL2Nv
dmVyLzExMDIzNTg1Lw0KPiAgICAyLmIuIFt2MTEsMC82XSBBZGQgYmFzaWMgbm9kZSBzdXBwb3J0
IGZvciBNZWRpYXRlayBNVDgxODMgU29DDQo+ICAgICAgICAgaHR0cHM6Ly9wYXRjaHdvcmsua2Vy
bmVsLm9yZy9jb3Zlci8xMDk2MjM4NS8NCj4gICAgMi5jLiBbdjYsMDAvMTRdIE1lZGlhdGVrIE1U
ODE4MyBzY3BzeXMgc3VwcG9ydA0KPiAgICAgICAgIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5v
cmcvY292ZXIvMTEwMDU3NTEvDQo+IDMuIENvcnJlY3QgcG93ZXIgcmVsYXRlZCBwYXRjaGVzIGlu
dG8gZHQtYmluZGluZyBwYXRjaGVzLg0KPiA0LiBSZS1vcmRlciBWNSdzIDQvMTEsIDYvMTEsIGFu
ZCA3LzExIGR1ZSBjbGsgY29tbW9uIGNvZGUgY2hhbmdlDQo+ICAgIGFuZCBtYWtlIGRlcGVuZGVu
Y2llcyBpbiBvcmRlci4NCj4gNS4gVXBkYXRlIHNvbWUgY29tbWl0IG1lc3NhZ2UgaW4gY2xrIHJl
bGF0ZWQgcGF0Y2hlcy4NCj4gDQo+IENoYW5nZXMgaW4gVjU6DQo+IDEuIGFkZCBjbGsgc3VwcG9y
dA0KPiANCj4gQ2hhbmdlcyBpbiBWNDoNCj4gMS4gYWRkIGdpYydzIHNldHRpbmdzIGluIHJlZyBw
cm9wZXJ0aWVzDQo+IDIuIHJlbW92ZSBzb21lIHBhdGNoZXMgYWJvdXQgZHQtYmluZGluZ3Mgc2lu
Y2UgR0tIIGFscmVhZHkgdG9vayB0aGVtDQo+IA0KPiBDaGFuZ2VzIGluIFYzOg0KPiAxLiBzcGxp
dCBkdC1iaW5kaW5nIGRvY3VtZW50IHBhdGNocw0KPiAyLiBmaXggbXQ2NzY1LmR0c2kgd2Fybmlu
Z3Mgd2l0aCBXPTEyDQo+IDMuIHJlbW92ZSB1bmNlc3NhcnkgUFBJIGFmZmluaXR5IGZvciB0aW1l
cg0KPiA0LiBhZGQgZ2ljYyBiYXNlIGZvciBnaWMgZHQgbm9kZQ0KPiANCj4gQ2hhbmdlcyBpbiBW
MjoNCj4gMS4gZml4IGNsayBwcm9wZXJ0aWVzIGluIHVhcnQgZHRzIG5vZGUNCj4gMi4gZml4IHR5
cG8gaW4gc3VibWl0IHRpdGxlDQo+IDMuIGFkZCBzaW1wbGUtYnVzIGluIG10Njc2NS5kdHNpDQo+
IDQuIHVzZSBjb3JyZWN0IFNQRFggbGljZW5zZSBmb3JtYXQNCj4gDQo+IE1hcnMgQ2hlbmcgKDMp
Og0KPiAgIGR0LWJpbmRpbmdzOiBtZWRpYXRlazogQWRkIHNtaSBkdHMgYmluZGluZyBmb3IgTWVk
aWF0ZWsgTVQ2NzY1IFNvQw0KPiAgIHNvYzogbWVkaWF0ZWs6IGFkZCBNVDY3NjUgc2Nwc3lzIGFu
ZCBzdWJkb21haW4gc3VwcG9ydA0KPiAgIGFybTY0OiBkdHM6IG1lZGlhdGVrOiBhZGQgbXQ2NzY1
IHN1cHBvcnQNCj4gDQo+IE93ZW4gQ2hlbiAoMSk6DQo+ICAgYXJtNjQ6IGRlZmNvbmZpZzogYWRk
IENPTkZJR19DT01NT05fQ0xLX01UNjc2NV9YWFggY2xvY2tzDQo+IA0KPiAgLi4uL21lbW9yeS1j
b250cm9sbGVycy9tZWRpYXRlayxzbWktY29tbW9uLnR4dCAgICAgfCAgICAxICsNCj4gIGFyY2gv
YXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvTWFrZWZpbGUgICAgICAgICAgICAgIHwgICAgMSArDQo+
ICBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210Njc2NS1ldmIuZHRzICAgICAgICB8ICAg
MzMgKysrDQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210Njc2NS5kdHNpICAgICAg
ICAgICB8ICAyNTMgKysrKysrKysrKysrKysrKysrKysNCj4gIGFyY2gvYXJtNjQvY29uZmlncy9k
ZWZjb25maWcgICAgICAgICAgICAgICAgICAgICAgIHwgICAgNiArDQo+ICBkcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstc2Nwc3lzLmMgICAgICAgICAgICAgICAgICB8ICAxMzAgKysrKysrKysrKw0K
PiAgNiBmaWxlcyBjaGFuZ2VkLCA0MjQgaW5zZXJ0aW9ucygrKQ0KPiAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ2NzY1LWV2Yi5kdHMNCj4gIGNyZWF0
ZSBtb2RlIDEwMDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210Njc2NS5kdHNpDQo+
IA0KDQpEZWFyIE1hdHRoaWFzIGFuZCBSb2IsDQoNCkp1c3QgYSByZW1pbmQgb2YgdGhlc2UgcGF0
Y2hlcyByZWxhdGVkIHRvIE1UNjc2NS4NClRoYW5rcyBmb3IgU3RlcGhlbidzIGhlbHAsIHRoZSBv
dGhlciBjbG9jayByZWxhdGVkIHBhdGNoZXMgb2YgTVQ2NzY1IGhhcw0KYmVlbiBhbHJlYWR5IG1l
cmdlZCBpbnRvIDUuOC1yYzEuIEkndmUgdGVzdGVkIHRoZXNlIHY4IHBhdGNoZXMgb2YgTVQ2NzY1
DQpvbiA1LjgtcmMxIGFuZCBzZWVtcyB0aGV5IHdlcmUgYWJsZSB0byBiZSBhcHBsaWVkLiBDb3Vs
ZCB5b3Uga2luZGx5IGhlbHANCnRvIGNoZWNrIGlmIHRoZXNlIHBhdGNoZXMgd2VyZSBxdWFsaWZp
ZWQgdG8gYmUgbWVyZ2VkIGludG8geW91ciB0cmVlPw0KDQpUaGFua3MgYSBsb3QhDQoNCkJlc3Qg
cmVnYXJkcywNCk1hY3BhdWwgTGluDQo=

