Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA007C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 03:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FA832076D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 03:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LUoYkR/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgHaDAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 23:00:08 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:56157 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726692AbgHaDAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 23:00:05 -0400
X-UUID: 83132b0db23946a2a501e9fa94dcfc33-20200831
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=sxA4q5kZv1gPdhXKXWhBUtYma0O+/4Q3ZgXNHmoU+Js=;
        b=LUoYkR/WmFRSKppCxbv+gLdg84HG68hd7KB0bX/USBtwBP4y5+3M8tj7OUsFNaMdnUfuf672LOkhWUfXQZ+zRt+epT2Pr0h7p5lFwVkprMOf7Cff6jXbAHgIf657s6LzRewB5fFXEiediSKgv05UeD2waUnRPwoRss2PlNlh+Ys=;
X-UUID: 83132b0db23946a2a501e9fa94dcfc33-20200831
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1559049207; Mon, 31 Aug 2020 10:59:53 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 31 Aug
 2020 10:59:51 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 31 Aug 2020 10:59:50 +0800
Message-ID: <1598842698.11403.2.camel@mhfsdcap03>
Subject: Re: [PATCH v4 2/2] usb typec: mt6360: Add MT6360 Type-C DT binding
 documentation
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     ChiYuan Huang <u0084500@gmail.com>
CC:     Rob Herring <robh@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>, <matthias.bgg@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        cy_huang <cy_huang@richtek.com>, <gene_chen@richtek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Mon, 31 Aug 2020 10:58:18 +0800
In-Reply-To: <CADiBU39P7jeSOV2_GcXh6A=b8SCViURCsS8SZFmy+oY2hS74tg@mail.gmail.com>
References: <1598610636-4939-1-git-send-email-u0084500@gmail.com>
         <1598610636-4939-2-git-send-email-u0084500@gmail.com>
         <20200828220520.GA3482472@bogus>
         <CADiBU3-pd7nvtf2_1ssYVLQc4HOHX6PUyyx6GiJ_gH-4DaGmog@mail.gmail.com>
         <CADiBU39P7jeSOV2_GcXh6A=b8SCViURCsS8SZFmy+oY2hS74tg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 2140C069E5EBD92A1DA8B8FF4EC85146537652C50164FEE7A5993EA1D23FCBB42000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIwLTA4LTI5IGF0IDEwOjQ5ICswODAwLCBDaGlZdWFuIEh1YW5nIHdyb3RlOg0K
PiBDaGlZdWFuIEh1YW5nIDx1MDA4NDUwMEBnbWFpbC5jb20+IOaWvCAyMDIw5bm0OOaciDI55pel
IOmAseWFrSDkuIrljYg4OjMy5a+r6YGT77yaDQo+ID4NCj4gPiBSb2IgSGVycmluZyA8cm9iaEBr
ZXJuZWwub3JnPiDmlrwgMjAyMOW5tDjmnIgyOeaXpSDpgLHlha0g5LiK5Y2INjowNeWvq+mBk++8
mg0KPiA+ID4NCj4gPiA+IE9uIEZyaSwgQXVnIDI4LCAyMDIwIGF0IDA2OjMwOjM2UE0gKzA4MDAs
IGN5X2h1YW5nIHdyb3RlOg0KPiA+ID4gPiBGcm9tOiBDaGlZdWFuIEh1YW5nIDxjeV9odWFuZ0By
aWNodGVrLmNvbT4NCj4gPiA+ID4NCj4gPiA+ID4gQWRkIGEgZGV2aWNldHJlZSBiaW5kaW5nIGRv
Y3VtZW50YXRpb24gZm9yIHRoZSBNVDYzNjAgVHlwZS1DIGRyaXZlci4NCj4gPiA+ID4NCj4gPiA+
ID4gdXNiIHR5cGVjOiBtdDYzNjA6IFJlbmFtZSBEVCBiaW5kaW5nIGRvdW1lbnQgZnJvbSBtdDYz
NjAgdG8gbXQ2MzZ4DQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IENoaVl1YW4gSHVh
bmcgPGN5X2h1YW5nQHJpY2h0ZWsuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIC4uLi9iaW5k
aW5ncy91c2IvbWVkaWF0ZWssbXQ2MzYwLXRjcGMueWFtbCAgICAgICAgIHwgNzMgKysrKysrKysr
KysrKysrKysrKysrKw0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDczIGluc2VydGlvbnMoKykN
Cj4gPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvdXNiL21lZGlhdGVrLG10NjM2MC10Y3BjLnlhbWwNCj4gPiA+ID4NCj4gPiA+ID4gZGlm
ZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWss
bXQ2MzYwLXRjcGMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2Iv
bWVkaWF0ZWssbXQ2MzYwLXRjcGMueWFtbA0KPiA+ID4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
PiA+ID4gPiBpbmRleCAwMDAwMDAwMC4uOWU4YWIwZA0KPiA+ID4gPiAtLS0gL2Rldi9udWxsDQo+
ID4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0
ZWssbXQ2MzYwLXRjcGMueWFtbA0KPiA+ID4gPiBAQCAtMCwwICsxLDczIEBADQo+ID4gPiA+ICsj
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkN
Cj4gPiA+ID4gKyVZQU1MIDEuMg0KPiA+ID4gPiArLS0tDQo+ID4gPiA+ICskaWQ6ICJodHRwOi8v
ZGV2aWNldHJlZS5vcmcvc2NoZW1hcy91c2IvbWVkaWF0ZWssbXQ2MzYwLXRjcGMueWFtbCMiDQo+
ID4gPiA+ICskc2NoZW1hOiAiaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3Jl
LnlhbWwjIg0KPiA+ID4gPiArDQo+ID4gPiA+ICt0aXRsZTogTWVkaWF0ZWsgTVQ2MzYwIFR5cGUt
QyBQb3J0IFN3aXRjaCBhbmQgUG93ZXIgRGVsaXZlcnkgY29udHJvbGxlciBEVCBiaW5kaW5ncw0K
PiA+ID4gPiArDQo+ID4gPiA+ICttYWludGFpbmVyczoNCj4gPiA+ID4gKyAgLSBDaGlZdWFuIEh1
YW5nIDxjeV9odWFuZ0ByaWNodGVrLmNvbT4NCj4gPiA+ID4gKw0KPiA+ID4gPiArZGVzY3JpcHRp
b246IHwNCj4gPiA+ID4gKyAgTWVkaWF0ZWsgTVQ2MzYwIGlzIGEgbXVsdGktZnVuY3Rpb25hbCBk
ZXZpY2UuIEl0IGludGVncmF0ZXMgY2hhcmdlciwgQURDLCBmbGFzaCwgUkdCIGluZGljYXRvcnMs
DQo+ID4gPiA+ICsgIHJlZ3VsYXRvcnMgKEJVQ0tzL0xET3MpLCBhbmQgVHlwZUMgUG9ydCBTd2l0
Y2ggd2l0aCBQb3dlciBEZWxpdmVyeSBjb250cm9sbGVyLg0KPiA+ID4gPiArICBUaGlzIGRvY3Vt
ZW50IG9ubHkgZGVzY3JpYmVzIE1UNjM2MCBUeXBlLUMgUG9ydCBTd2l0Y2ggYW5kIFBvd2VyIERl
bGl2ZXJ5IGNvbnRyb2xsZXIuDQo+ID4gPiA+ICsNCj4gPiA+ID4gK3Byb3BlcnRpZXM6DQo+ID4g
PiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gPiA+ICsgICAgZW51bToNCj4gPiA+ID4gKyAgICAgIC0g
bWVkaWF0ZWssbXQ2MzYwLXRjcGMNCj4gPiA+ID4gKw0KPiA+ID4gPiArICBpbnRlcnJ1cHRzLWV4
dGVuZGVkOg0KPiA+ID4NCj4gPiA+IFVzZSAnaW50ZXJydXB0cycuIFRoZSB0b29saW5nIHdpbGwg
YXV0b21hdGljYWxseSBzdXBwb3J0DQo+ID4gPiAnaW50ZXJydXB0cy1leHRlbmRlZCcuDQo+ID4g
T2theS4NCj4gPiA+DQo+ID4gPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiA+ID4gKw0KPiA+ID4g
PiArICBpbnRlcnJ1cHQtbmFtZXM6DQo+ID4gPiA+ICsgICAgaXRlbXM6DQo+ID4gPiA+ICsgICAg
ICAtIGNvbnN0OiBQRF9JUlFCDQo+ID4gPiA+ICsNCj4gPiA+ID4gK3BhdHRlcm5Qcm9wZXJ0aWVz
Og0KPiA+ID4gPiArICAiY29ubmVjdG9yIjoNCj4gPiA+ID4gKyAgICB0eXBlOiBvYmplY3QNCj4g
PiA+ID4gKyAgICAkcmVmOiAuLi9jb25uZWN0b3IvdXNiLWNvbm5lY3Rvci55YW1sIw0KPiA+ID4g
PiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ID4gPiArICAgICAgUHJvcGVydGllcyBmb3IgdXNiIGMg
Y29ubmVjdG9yLg0KPiA+ID4gPiArDQo+ID4gPiA+ICthZGRpdGlvbmFsUHJvcGVydGllczogZmFs
c2UNCj4gPiA+ID4gKw0KPiA+ID4gPiArcmVxdWlyZWQ6DQo+ID4gPiA+ICsgIC0gY29tcGF0aWJs
ZQ0KPiA+ID4gPiArICAtIGludGVycnVwdHMtZXh0ZW5kZWQNCj4gPiA+ID4gKyAgLSBpbnRlcnJ1
cHQtbmFtZXMNCj4gPiA+ID4gKw0KPiA+ID4gPiArZXhhbXBsZXM6DQo+ID4gPiA+ICsgIC0gfA0K
PiA+ID4gPiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9p
cnEuaD4NCj4gPiA+ID4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvdXNiL3BkLmg+DQo+ID4g
PiA+ICsgICAgaTJjMCB7DQo+ID4gPiA+ICsgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0K
PiA+ID4gPiArICAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4gPiA+ID4gKw0KPiA+ID4gPiAr
ICAgICAgICBtdDYzNjBAMzQgew0KPiA+ID4gPiArICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJt
ZWRpYXRlayxtdDYzNjAiOw0KPiA+ID4gPiArICAgICAgICAgICAgcmVnID0gPDB4MzQ+Ow0KPiA+
ID4gPiArDQo+ID4gPiA+ICsgICAgICAgICAgICB0Y3BjIHsNCj4gPiA+ID4gKyAgICAgICAgICAg
ICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10NjM2MC10Y3BjIjsNCj4gPiA+ID4gKyAgICAg
ICAgICAgICAgICBpbnRlcnJ1cHRzLWV4dGVuZGVkID0gPCZncGlvMjYgMyBJUlFfVFlQRV9MRVZF
TF9MT1c+Ow0KPiA+ID4gPiArICAgICAgICAgICAgICAgIGludGVycnVwdC1uYW1lcyA9ICJQRF9J
UlFCIjsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgICAgICAgICAgIGNvbm5lY3RvciB7DQo+
ID4gPg0KPiA+ID4gV2hlcmUncyB0aGUgZGF0YSBjb25uZWN0aW9ucz8gVGhlIGFzc3VtcHRpb24g
b2YgdGhlIGJpbmRpbmcgaXMgdGhlIFVTQg0KPiA+ID4gKDIgYW5kIDMpIGNvbm5lY3Rpb25zIGNv
bWUgZnJvbSB0aGUgcGFyZW50IGlmIHRoZXJlJ3Mgbm8gZ3JhcGggdG8gdGhlDQo+ID4gPiBVU0Ig
Y29udHJvbGxlcihzKS4NCj4gPiBNVDYzNjAgaXMgb25seSBhIHN1YnBtaWMuIFR5cGVDIHBhcnQg
b25seSBoYW5kbGUgdGhlIENDIGxvZ2ljIHRvIHN1cHBvcnQgVVNCUEQuDQo+ID4gRm9yIHRoZSB1
c2IgY29ubmVjdGlvbiBsaWtlIGFzIHVzYmhzL3VzYnNzLCAgaXQgbmVlZCB0byBiZSBoYW5kbGVk
DQo+ID4gYnkvY29ubmVjdCB0byBhcHBsaWNhdGlvbiBwcm9jZXNzb3Igc2lkZS4NCj4gPiBMSWtl
IGFzIGNvbm5lY3Rvci91c2ItY29ubmVjdG9yLnlhbWwgZGVjcmliZWQsIGl0ICBzcGVjaWZ5IHRo
ZSBwb3J0DQo+ID4gcHJvcGVydHkgdG8gYmluZCBVU0IgSFMvU1MuDQo+ID4NCj4gRG8gaSBuZWVk
IHRvIGFkZCB0aGUgcG9ydHMgaW50byB0aGUgY29ubmVjdG9yIG5vZGUgZm9yIGV4YW1wbGU/DQo+
IExpa2UgYXMgaHMvc3MvYXV4LCB0byBtYWtlIHRoZSB1c2VyIGtub3cgdG8gdXNlIDYzNjAncyB0
Y3BjPw0KPiANCj4gSSBjaGVjayB0aGUgIHN0eWxlIGluIGNvbm5lY3Rvci91c2ItY29ubmVjdC55
YW1sDQo+IERvIEkgYWxzbyBuZWVkIHRvIHJlcGxhY2UgdHdvIHNwYWNlIGluc3RlYWQgb2Ygb25l
IHRhYiBpbiB0aGUgYmluZGluZyBleGFtcGxlPw0KDQpzZWUgd3JpdGluZy1zY2hlbWEucnN0IGFi
b3V0IGV4YW1wbGVzOg0KDQoiTm90ZTogWUFNTCBkb2Vzbid0IGFsbG93IGxlYWRpbmcgdGFicywg
c28gc3BhY2VzIG11c3QgYmUgdXNlZCBpbnN0ZWFkLiINCj4gDQo+ID4gPg0KPiA+ID4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJ1c2ItYy1jb25uZWN0b3IiOw0KPiA+
ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgbGFiZWwgPSAiVVNCLUMiOw0KPiA+ID4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgZGF0YS1yb2xlID0gImR1YWwiOw0KPiA+ID4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgcG93ZXItcm9sZSA9ICJkdWFsIjsNCj4gPiA+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgIHRyeS1wb3dlci1yb2xlID0gInNpbmsiOw0KPiA+ID4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgc291cmNlLXBkb3MgPSA8UERPX0ZJWEVEKDUwMDAsIDEwMDAs
IFBET19GSVhFRF9EVUFMX1JPTEUgfCBQRE9fRklYRURfREFUQV9TV0FQKT47DQo+ID4gPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICBzaW5rLXBkb3MgPSA8UERPX0ZJWEVEKDUwMDAsIDIwMDAs
IFBET19GSVhFRF9EVUFMX1JPTEUgfCBQRE9fRklYRURfREFUQV9TV0FQKT47DQo+ID4gPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICBvcC1zaW5rLW1pY3Jvd2F0dCA9IDwxMDAwMDAwMD47DQo+
ID4gPiA+ICsgICAgICAgICAgICAgICAgfTsNCj4gPiA+ID4gKyAgICAgICAgICAgIH07DQo+ID4g
PiA+ICsgICAgICAgIH07DQo+ID4gPiA+ICsgICAgfTsNCj4gPiA+ID4gKy4uLg0KPiA+ID4gPiAt
LQ0KPiA+ID4gPiAyLjcuNA0KPiA+ID4gPg0KDQo=

