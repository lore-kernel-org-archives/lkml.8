Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CABC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D0262065F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CruyKFrh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732870AbgF3LJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 07:09:04 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:44873 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732666AbgF3LJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 07:09:03 -0400
X-UUID: 13a1312f612746c6baad6853361ab0ad-20200630
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=39/WvHSlJfaFdr2D13fz2nqg2RkI5zVNbDVhi335aSs=;
        b=CruyKFrhtCHKIxEwxVegZqp5ApeNXLIS/1KR07KpaemHNJSXWk2RLJUSAGu9JFxqOwQKl5lWiU0li9covL0TxtVwInJRwcluJmgv/apfMXW3hNVHctclb54MyLM80fvKYuPLb7VtLcpkDj5jOPKOqkye6x2IWSdazkPjPpIh/0A=;
X-UUID: 13a1312f612746c6baad6853361ab0ad-20200630
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1858030806; Tue, 30 Jun 2020 19:08:58 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 30 Jun 2020 19:08:52 +0800
Received: from [10.15.20.246] (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 30 Jun 2020 19:08:52 +0800
Message-ID: <1593515273.26985.0.camel@mbjsdccf07>
Subject: Re: [PATCH v5 06/10] iommu/mediatek: Add sub_comm id in translation
 fault
From:   chao hao <Chao.Hao@mediatek.com>
To:     Yong Wu <yong.wu@mediatek.com>
CC:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Evan Green <evgreen@chromium.org>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        FY Yang <fy.yang@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>
Date:   Tue, 30 Jun 2020 19:07:53 +0800
In-Reply-To: <1593514516.24171.25.camel@mhfsdcap03>
References: <20200629071310.1557-1-chao.hao@mediatek.com>
         <20200629071310.1557-7-chao.hao@mediatek.com>
         <1593514516.24171.25.camel@mhfsdcap03>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTA2LTMwIGF0IDE4OjU1ICswODAwLCBZb25nIFd1IHdyb3RlOg0KPiBPbiBN
b24sIDIwMjAtMDYtMjkgYXQgMTU6MTMgKzA4MDAsIENoYW8gSGFvIHdyb3RlOg0KPiA+IFRoZSBt
YXggbGFyYiBudW1iZXIgdGhhdCBhIGlvbW11IEhXIHN1cHBvcnQgaXMgOChsYXJiMH5sYXJiNyBp
biB0aGUgYmVsb3cNCj4gPiBkaWFncmFtKS4NCj4gPiBJZiB0aGUgbGFyYidzIG51bWJlciBpcyBv
dmVyIDgsIHdlIHVzZSBhIHN1Yl9jb21tb24gZm9yIG1lcmdpbmcNCj4gPiBzZXZlcmFsIGxhcmJz
IGludG8gb25lIGxhcmIuIEF0IHRoaXMgY2FzZSwgd2Ugd2lsbCBleHRlbmQgbGFyYl9pZDoNCj4g
PiBiaXRbMTE6OV0gbWVhbnMgY29tbW9uLWlkOw0KPiA+IGJpdFs4OjddIG1lYW5zIHN1YmNvbW1v
bi1pZDsNCj4gPiBGcm9tIHRoZXNlIHR3byB2YXJpYWJsZXMsIHdlIGNvdWxkIGdldCB0aGUgcmVh
bCBsYXJiIG51bWJlciB3aGVuDQo+ID4gdHJhbnNsYXRpb24gZmF1bHQgaGFwcGVuLg0KPiA+IFRo
ZSBkaWFncmFtIGlzIGFzIGJlbG93Og0KPiA+IAkJIEVNSQ0KPiA+IAkJICB8DQo+ID4gCQlJT01N
VQ0KPiA+IAkJICB8DQo+ID4gICAgICAgICAgICAtLS0tLS0tLS0tLS0tLS0tLQ0KPiA+IAkgICB8
ICAgICAgICAgICAgICAgfA0KPiA+IAljb21tb24xICAgCWNvbW1vbjANCj4gPiAJICAgfAkJICAg
fA0KPiA+IAkgICAtLS0tLS0tLS0tLS0tLS0tLQ0KPiA+IAkJICB8DQo+ID4gICAgICAgICAgICAg
IHNtaSBjb21tb24NCj4gPiAJCSAgfA0KPiA+ICAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQo+ID4gICB8ICAgICAgIHwgICAgICAgfCAgICAgICB8ICAgICB8ICAgIHwNCj4g
PiAgMydkMCAgICAzJ2QxICAgIDMnZDIgICAgMydkMyAgLi4uICAzJ2Q3ICAgPC1jb21tb25faWQo
bWF4IGlzIDgpDQo+ID4gICB8ICAgICAgIHwgICAgICAgfCAgICAgICB8ICAgICB8ICAgIHwNCj4g
PiBMYXJiMCAgIExhcmIxICAgICB8ICAgICBMYXJiMyAgLi4uIExhcmI3DQo+ID4gCQkgIHwNCj4g
PiAJICAgIHNtaSBzdWIgY29tbW9uDQo+ID4gCQkgIHwNCj4gPiAgICAgIC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQo+ID4gICAgICB8ICAgICAgICB8ICAgICAgIHwgICAgICAgfA0KPiA+ICAg
ICAyJ2QwICAgICAyJ2QxICAgIDInZDIgICAgMidkMyAgIDwtc3ViX2NvbW1vbl9pZChtYXggaXMg
NCkNCj4gPiAgICAgIHwgICAgICAgIHwgICAgICAgfCAgICAgICB8DQo+ID4gICAgTGFyYjggICAg
TGFyYjkgICBMYXJiMTAgIExhcmIxMQ0KPiA+IA0KPiA+IEluIHRoaXMgcGF0Y2ggd2UgZXh0ZW5k
IGxhcmJfcmVtYXBbXSB0byBsYXJiX3JlbWFwWzhdWzRdIGZvciB0aGlzLg0KPiA+IGxhcmJfcmVt
YXBbeF1beV06IHggbWVhbnMgY29tbW9uLWlkIGFib3ZlLCB5IG1lYW5zIHN1YmNvbW1vbl9pZCBh
Ym92ZS4NCj4gPiANCj4gPiBXZSBjYW4gYWxzbyBkaXN0aW5ndWlzaCBpZiB0aGUgTTRVIEhXIGhh
cyBzdWJfY29tbW9uIGJ5IEhBU19TVUJfQ09NTQ0KPiA+IG1hY3JvLg0KPiA+IA0KPiA+IENjOiBN
YXR0aGlhcyBCcnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IENoYW8gSGFvIDxjaGFvLmhhb0BtZWRpYXRlay5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IFlv
bmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2lvbW11
L210a19pb21tdS5jICB8IDIwICsrKysrKysrKysrKystLS0tLS0tDQo+ID4gIGRyaXZlcnMvaW9t
bXUvbXRrX2lvbW11LmggIHwgIDMgKystDQo+ID4gIGluY2x1ZGUvc29jL21lZGlhdGVrL3NtaS5o
IHwgIDIgKysNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCA4IGRlbGV0
aW9ucygtKQ0KPiANCj4gW3NuaXBdDQo+IA0KPiA+IEBAIC00OCw3ICs0OSw3IEBAIHN0cnVjdCBt
dGtfaW9tbXVfcGxhdF9kYXRhIHsNCj4gPiAgCWVudW0gbXRrX2lvbW11X3BsYXQgbTR1X3BsYXQ7
DQo+ID4gIAl1MzIgICAgICAgICAgICAgICAgIGZsYWdzOw0KPiA+ICAJdTMyICAgICAgICAgICAg
ICAgICBpbnZfc2VsX3JlZzsNCj4gPiAtCXVuc2lnbmVkIGNoYXIgICAgICAgbGFyYmlkX3JlbWFw
W01US19MQVJCX05SX01BWF07DQo+ID4gKwl1bnNpZ25lZCBjaGFyICAgICAgIGxhcmJpZF9yZW1h
cFtNVEtfTEFSQl9DT01fTUFYXVtNVEtfTEFSQl9TVUJDT01fTUFYXTsNCj4gPiAgfTsNCj4gPiAg
DQo+ID4gIHN0cnVjdCBtdGtfaW9tbXVfZG9tYWluOw0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L3NvYy9tZWRpYXRlay9zbWkuaCBiL2luY2x1ZGUvc29jL21lZGlhdGVrL3NtaS5oDQo+ID4gaW5k
ZXggNWEzNGI4N2Q4OWUzLi5mYTY1YTU1NDY4ZTIgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9z
b2MvbWVkaWF0ZWsvc21pLmgNCj4gPiArKysgYi9pbmNsdWRlL3NvYy9tZWRpYXRlay9zbWkuaA0K
PiA+IEBAIC0xMiw2ICsxMiw4IEBADQo+ID4gICNpZmRlZiBDT05GSUdfTVRLX1NNSQ0KPiA+ICAN
Cj4gPiAgI2RlZmluZSBNVEtfTEFSQl9OUl9NQVgJCTE2DQo+ID4gKyNkZWZpbmUgTVRLX0xBUkJf
Q09NX01BWAk4DQo+ID4gKyNkZWZpbmUgTVRLX0xBUkJfU1VCQ09NX01BWAk0DQo+IA0KPiBCb3Ro
IGFyZSBvbmx5IHVzZWQgaW4gbXRrX2lvbW11LmgsIGFuZCBJIGRvbid0IHRoaW5rIHNtaSBoYXMg
cGxhbiB0byB1c2UNCj4gdGhlbS4gdGh1cyB3ZSBjb3VsZCBtb3ZlIHRoZW0gaW50byBtdGtfaW9t
bXUuaA0KPiANCm9rLCBnb3QgaXQuIFRoYW5rcyBmb3IgeW91ciBhZHZpY2UuDQoNCj4gPiAgDQo+
ID4gICNkZWZpbmUgTVRLX1NNSV9NTVVfRU4ocG9ydCkJQklUKHBvcnQpDQo+ID4gIA0KPiANCj4g
DQoNCg==

