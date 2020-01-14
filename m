Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE41C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 08:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5266D2465A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 08:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QXVtnf1D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbgANInY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 03:43:24 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:19112 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726044AbgANInY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 03:43:24 -0500
X-UUID: 79f9a9652fba4d1b961fbd873e7a6b4c-20200114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Dost+0dFRh/iyChepfPjiNF1opJPrShWqwDKLyfccxU=;
        b=QXVtnf1DkOTqkpLGMZjknKW60MYhfMs6y+lpAUJ9y42cuJPoeNvFy+SLphZudI9nIZSN9gmCkEbLoNA8otekF98ixvxHA1PvwpzmS9kNc4IRreHkhsgbZPt83wrIoRHwg80rQfL69UWC0O+Jb41flAYsYAEizeXNHTfs79dfHZk=;
X-UUID: 79f9a9652fba4d1b961fbd873e7a6b4c-20200114
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 123695352; Tue, 14 Jan 2020 16:43:17 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 14 Jan
 2020 16:43:39 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 14 Jan 2020 16:42:27 +0800
Message-ID: <1578991386.21256.36.camel@mhfsdcap03>
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
Date:   Tue, 14 Jan 2020 16:43:06 +0800
In-Reply-To: <970b7cce-40ed-9ab7-5e04-9e3d609eadf7@ti.com>
References: <1578448326-27455-1-git-send-email-chunfeng.yun@mediatek.com>
         <20200110111006.GB2220@a0393678ub> <1578990166.21256.35.camel@mhfsdcap03>
         <970b7cce-40ed-9ab7-5e04-9e3d609eadf7@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: D582942802D1883A0CC1327A8F6B5666E8F2723D1A7B198DCC432FD73969D2B32000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTAxLTE0IGF0IDE0OjAxICswNTMwLCBLaXNob24gVmlqYXkgQWJyYWhhbSBJ
IHdyb3RlOg0KPiBIaSBDaHVuZmVuZywNCj4gDQo+IE9uIDE0LzAxLzIwIDE6NTIgUE0sIENodW5m
ZW5nIFl1biB3cm90ZToNCj4gPiBIaSBLaXNob24sDQo+ID4gDQo+ID4gT24gRnJpLCAyMDIwLTAx
LTEwIGF0IDE2OjQwICswNTMwLCBLaXNob24gVmlqYXkgQWJyYWhhbSBJIHdyb3RlOg0KPiA+PiBI
aSwNCj4gPj4NCj4gPj4gT24gV2VkLCBKYW4gMDgsIDIwMjAgYXQgMDk6NTE6NTZBTSArMDgwMCwg
Q2h1bmZlbmcgWXVuIHdyb3RlOg0KPiA+Pj4gQWRkIHR3byBvcHRpb25hbCBwcm9wZXJ0aWVzLCBv
bmUgZm9yIHR1bmluZyBKLUsgdm9sdGFnZSBieSBJTlRSLA0KPiA+Pj4gYW5vdGhlciBmb3IgZGlz
Y29ubmVjdCB0aHJlc2hvbGQsIGJvdGggb2YgdGhlbSBhcmUgcmVsYXRlZCB3aXRoDQo+ID4+PiBj
b25uZWN0IGRldGVjdGlvbg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1
biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCj4gPj4+IEFja2VkLWJ5OiBSb2IgSGVycmlu
ZyA8cm9iaEBrZXJuZWwub3JnPg0KPiA+Pg0KPiA+PiBQYXRjaCBkb2VzIG5vdCBhcHBseS4gSSBn
ZXQgdGhlIGZvbGxvd2luZyBlcnJvcnMNCj4gPj4gZXJyb3I6IHBhdGNoIGZhaWxlZDogRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktbXRrLXRwaHkudHh0OjUyDQo+ID4+
IGVycm9yOiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L3BoeS1tdGstdHBo
eS50eHQ6IHBhdGNoIGRvZXMgbm90IGFwcGx5DQo+ID4+IGVycm9yOiBEaWQgeW91IGhhbmQgZWRp
dCB5b3VyIHBhdGNoPw0KPiA+Pg0KPiA+PiBDYW4geW91IHNlbmQgdGhlbSBhZ2FpbiBpbiB0aGUg
cmlnaHQgZm9ybWF0Pw0KPiA+IEkgZG93bmxvYWQgdGhpcyBwYXRjaCBmcm9tIGh0dHBzOi8vcGF0
Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTEzMjI1MDUvDQo+ID4gYW5kIGZldGNoIGtlcm5lbDUu
NS1yYzUsIHRoZW4NCj4gDQo+IFBsZWFzZSB0cnkgYXBwbHlpbmcgdG8NCj4gZ2l0Oi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2tpc2hvbi9saW51eC1waHkuZ2l0IG5l
eHQNCg0KR290IGl0LCB3aWxsIHRlc3QgYWdhaW4sIHRoYW5rcyBhIGxvdA0KDQo+ID4gDQo+ID4g
Z2l0IGFtIC0tcmVqZWN0DQo+ID4gUkVTRU5ELXY1LTAxLTExLWR0LWJpbmRpbmdzLXBoeS1tdGst
dHBoeS1hZGQtdHdvLW9wdGlvbmFsLXByb3BlcnRpZXMtZm9yLXUycGh5LnBhdGNoDQo+ID4gQXBw
bHlpbmc6IGR0LWJpbmRpbmdzOiBwaHktbXRrLXRwaHk6IGFkZCB0d28gb3B0aW9uYWwgcHJvcGVy
dGllcyBmb3INCj4gPiB1MnBoeQ0KPiA+IENoZWNraW5nIHBhdGNoIERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9waHkvcGh5LW10ay10cGh5LnR4dC4uLg0KPiA+IEFwcGxpZWQgcGF0
Y2ggRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktbXRrLXRwaHkudHh0
DQo+ID4gY2xlYW5seS4NCj4gPiANCj4gPiBkb24ndCByZXByb2R1Y2UgdGhlIGVycm9yIHlvdSBl
bmNvdW50ZXJlZCwgY2FuIHlvdSB0ZWxsIG1lIHRoZSBzdGVwcyB5b3UNCj4gPiBhcHBseSB0aGUg
cGF0Y2gsIHRoYW5rcw0KPiANCj4gZ2l0IGFtIGNodW5mZW5nLnl1bi5wYXRjaCAtLXJlamVjdA0K
PiBBcHBseWluZzogZHQtYmluZGluZ3M6IHBoeS1tdGstdHBoeTogYWRkIHR3byBvcHRpb25hbCBw
cm9wZXJ0aWVzIGZvciB1MnBoeQ0KPiBDaGVja2luZyBwYXRjaCBEb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvcGh5L3BoeS1tdGstdHBoeS50eHQuLi4NCj4gZXJyb3I6IHdoaWxlIHNl
YXJjaGluZyBmb3I6DQo+IC0gbWVkaWF0ZWssZXllLXZydAk6IHUzMiwgdGhlIHNlbGVjdGlvbiBv
ZiBWUlQgcmVmZXJlbmNlIHZvbHRhZ2U/DQo+IC0gbWVkaWF0ZWssZXllLXRlcm0JOiB1MzIsIHRo
ZSBzZWxlY3Rpb24gb2YgSFNfVFggVEVSTSByZWZlcmVuY2Ugdm9sdGFnZT8NCj4gLSBtZWRpYXRl
ayxiYzEyCTogYm9vbCwgZW5hYmxlIEJDMTIgb2YgdTJwaHkgaWYgc3VwcG9ydCBpdD8NCj4gPw0K
PiBFeGFtcGxlOj8NCj4gPw0KPiANCj4gZXJyb3I6IHBhdGNoIGZhaWxlZDoNCj4gRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktbXRrLXRwaHkudHh0OjUyDQo+IEFwcGx5
aW5nIHBhdGNoIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvcGh5LW10ay10
cGh5LnR4dA0KPiB3aXRoIDEgcmVqZWN0Li4uDQo+IFJlamVjdGVkIGh1bmsgIzEuDQo+IFBhdGNo
IGZhaWxlZCBhdCAwMDAxIGR0LWJpbmRpbmdzOiBwaHktbXRrLXRwaHk6IGFkZCB0d28gb3B0aW9u
YWwNCj4gcHJvcGVydGllcyBmb3IgdTJwaHkNCj4gVXNlICdnaXQgYW0gLS1zaG93LWN1cnJlbnQt
cGF0Y2gnIHRvIHNlZSB0aGUgZmFpbGVkIHBhdGNoDQo+IFdoZW4geW91IGhhdmUgcmVzb2x2ZWQg
dGhpcyBwcm9ibGVtLCBydW4gImdpdCBhbSAtLWNvbnRpbnVlIi4NCj4gSWYgeW91IHByZWZlciB0
byBza2lwIHRoaXMgcGF0Y2gsIHJ1biAiZ2l0IGFtIC0tc2tpcCIgaW5zdGVhZC4NCj4gVG8gcmVz
dG9yZSB0aGUgb3JpZ2luYWwgYnJhbmNoIGFuZCBzdG9wIHBhdGNoaW5nLCBydW4gImdpdCBhbSAt
LWFib3J0Ii4NCj4gDQo+IFRoYW5rcw0KPiBLaXNob24NCg0K

