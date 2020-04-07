Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04837C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 03:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 852E920672
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 03:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Hhzu7vsW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgDGDha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 23:37:30 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:39957 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726303AbgDGDh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 23:37:29 -0400
X-UUID: 93d7219f171f48e29004bad637e6f52e-20200407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=xMyvElthjOstM9PdI/6GoHMLeRrsFL8BjfQEJHhLRDw=;
        b=Hhzu7vsWb2xFS7GujolgStKSH+gwzjKfRkiXY+yKRwU0S2k5I8VljfeAgWUHEG3OTGh87a3Na4KRum3qyACph7XYEh8TL0LsVFPGmw6zpPV4ArbkqYoWU63XCqu4nk53Rdbnl/cRHJr4vTi/HCB+YZ96M5HWKZIgNODqWFHa56Q=;
X-UUID: 93d7219f171f48e29004bad637e6f52e-20200407
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2018824660; Tue, 07 Apr 2020 11:37:16 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 7 Apr
 2020 11:37:14 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 7 Apr 2020 11:37:13 +0800
Message-ID: <1586230628.28772.8.camel@mhfsdcap03>
Subject: Re: [PATCH] USB: mtu3: Use the correct style for SPDX License
 Identifier
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=" 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Joe Perches <joe@perches.com>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Tue, 7 Apr 2020 11:37:08 +0800
In-Reply-To: <20200404103728.GA6011@nishad>
References: <20200404103728.GA6011@nishad>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 455CD0340B1F1D8F978B7CFC18F4BFDB3E82DE13CD7AB8C93EAFAC02F918BEEB2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIwLTA0LTA0IGF0IDE2OjA3ICswNTMwLCBOaXNoYWQgS2FtZGFyIHdyb3RlOg0K
PiBUaGlzIHBhdGNoIGNvcnJlY3RzIHRoZSBTUERYIExpY2Vuc2UgSWRlbnRpZmllciBzdHlsZSBp
bg0KPiBoZWFkZXIgZmlsZXMgcmVsYXRlZCB0byBNZWRpYVRlayBVU0IzIER1YWwgUm9sZSBjb250
cm9sbGVyLg0KPiBGb3IgQyBoZWFkZXIgZmlsZXMgRG9jdW1lbnRhdGlvbi9wcm9jZXNzL2xpY2Vu
c2UtcnVsZXMucnN0DQo+IG1hbmRhdGVzIEMtbGlrZSBjb21tZW50cyAob3Bwb3NlZCB0byBDIHNv
dXJjZSBmaWxlcyB3aGVyZQ0KPiBDKysgc3R5bGUgc2hvdWxkIGJlIHVzZWQpLg0KPiANCj4gQ2hh
bmdlcyBtYWRlIGJ5IHVzaW5nIGEgc2NyaXB0IHByb3ZpZGVkIGJ5IEpvZSBQZXJjaGVzIGhlcmU6
DQo+IGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE5LzIvNy80Ni4NCj4gDQo+IFN1Z2dlc3RlZC1i
eTogSm9lIFBlcmNoZXMgPGpvZUBwZXJjaGVzLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTmlzaGFk
IEthbWRhciA8bmlzaGFka2FtZGFyQGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9t
dHUzL210dTMuaCAgICAgICAgIHwgMiArLQ0KPiAgZHJpdmVycy91c2IvbXR1My9tdHUzX2RlYnVn
LmggICB8IDIgKy0NCj4gIGRyaXZlcnMvdXNiL210dTMvbXR1M19kci5oICAgICAgfCAyICstDQo+
ICBkcml2ZXJzL3VzYi9tdHUzL210dTNfaHdfcmVncy5oIHwgMiArLQ0KPiAgZHJpdmVycy91c2Iv
bXR1My9tdHUzX3FtdS5oICAgICB8IDIgKy0NCj4gIGRyaXZlcnMvdXNiL210dTMvbXR1M190cmFj
ZS5oICAgfCAyICstDQo+ICA2IGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNiBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9tdHUzL210dTMuaCBiL2Ry
aXZlcnMvdXNiL210dTMvbXR1My5oDQo+IGluZGV4IDYwODdiZTIzNmEzNS4uZDQ5ZGI5MmFiMjZj
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9tdHUzL210dTMuaA0KPiArKysgYi9kcml2ZXJz
L3VzYi9tdHUzL210dTMuaA0KPiBAQCAtMSw0ICsxLDQgQEANCj4gLS8vIFNQRFgtTGljZW5zZS1J
ZGVudGlmaWVyOiBHUEwtMi4wDQo+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIu
MCAqLw0KPiAgLyoNCj4gICAqIG10dTMuaCAtIE1lZGlhVGVrIFVTQjMgRFJEIGhlYWRlcg0KPiAg
ICoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL210dTMvbXR1M19kZWJ1Zy5oIGIvZHJpdmVy
cy91c2IvbXR1My9tdHUzX2RlYnVnLmgNCj4gaW5kZXggZTk2YTY5MjM0ZDA1Li5mYjZiMjgyNzdj
OWIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL210dTMvbXR1M19kZWJ1Zy5oDQo+ICsrKyBi
L2RyaXZlcnMvdXNiL210dTMvbXR1M19kZWJ1Zy5oDQo+IEBAIC0xLDQgKzEsNCBAQA0KPiAtLy8g
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gKy8qIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wICovDQo+ICAvKg0KPiAgICogbXR1M19kZWJ1Zy5oIC0gZGVidWcgaGVh
ZGVyDQo+ICAgKg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvbXR1My9tdHUzX2RyLmggYi9k
cml2ZXJzL3VzYi9tdHUzL210dTNfZHIuaA0KPiBpbmRleCA1ZTU4YzRkYmQ1NGEuLjc2MGZlN2Q2
OWM2YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvbXR1My9tdHUzX2RyLmgNCj4gKysrIGIv
ZHJpdmVycy91c2IvbXR1My9tdHUzX2RyLmgNCj4gQEAgLTEsNCArMSw0IEBADQo+IC0vLyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IEdQTC0yLjAgKi8NCj4gIC8qDQo+ICAgKiBtdHUzX2RyLmggLSBkdWFsIHJvbGUgc3dpdGNo
IGFuZCBob3N0IGdsdWUgbGF5ZXIgaGVhZGVyDQo+ICAgKg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy91c2IvbXR1My9tdHUzX2h3X3JlZ3MuaCBiL2RyaXZlcnMvdXNiL210dTMvbXR1M19od19yZWdz
LmgNCj4gaW5kZXggODM4MmQwNjY3NDllLi5iZjM0Zjc4NGY4NGIgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvdXNiL210dTMvbXR1M19od19yZWdzLmgNCj4gKysrIGIvZHJpdmVycy91c2IvbXR1My9t
dHUzX2h3X3JlZ3MuaA0KPiBAQCAtMSw0ICsxLDQgQEANCj4gLS8vIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wDQo+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCAq
Lw0KPiAgLyoNCj4gICAqIG10dTNfaHdfcmVncy5oIC0gTWVkaWFUZWsgVVNCMyBEUkQgcmVnaXN0
ZXIgYW5kIGZpZWxkIGRlZmluaXRpb25zDQo+ICAgKg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91
c2IvbXR1My9tdHUzX3FtdS5oIGIvZHJpdmVycy91c2IvbXR1My9tdHUzX3FtdS5oDQo+IGluZGV4
IDljZmRlMjAxZGI2My4uNjZlMWMwYWI1YTk5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9t
dHUzL210dTNfcW11LmgNCj4gKysrIGIvZHJpdmVycy91c2IvbXR1My9tdHUzX3FtdS5oDQo+IEBA
IC0xLDQgKzEsNCBAQA0KPiAtLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4g
Ky8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wICovDQo+ICAvKg0KPiAgICogbXR1
M19xbXUuaCAtIFF1ZXVlIE1hbmFnZW1lbnQgVW5pdCBkcml2ZXIgaGVhZGVyDQo+ICAgKg0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvbXR1My9tdHUzX3RyYWNlLmggYi9kcml2ZXJzL3VzYi9t
dHUzL210dTNfdHJhY2UuaA0KPiBpbmRleCAwNTBlMzBmMGZiZDQuLjFiODk3NjM2ZGFmMiAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvbXR1My9tdHUzX3RyYWNlLmgNCj4gKysrIGIvZHJpdmVy
cy91c2IvbXR1My9tdHUzX3RyYWNlLmgNCj4gQEAgLTEsNCArMSw0IEBADQo+IC0vLyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IEdQTC0yLjAgKi8NCj4gIC8qKg0KPiAgICogbXR1M190cmFjZS5oIC0gdHJhY2Ugc3VwcG9ydA0K
PiAgICoNCg0KUmV2aWV3ZWQtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVr
LmNvbT4NCg0KVGhhbmtzDQoNCg==

