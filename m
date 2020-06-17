Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CDBC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46FBE208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mGK9vshn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgFQHFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 03:05:37 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:11651 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725536AbgFQHFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 03:05:32 -0400
X-UUID: 17289305761249b9ae81c631586c6301-20200617
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=sFJmN4Wh3vZM8/oU/VtnNpfoEznKzEY3P9YuUgNgScc=;
        b=mGK9vshnTS0idt2eDgiU1yyDIFFpvUGAcwAvjXKk/O+INIg0Fnq8nLWJV1ADN1nMJ56QpZUD6AxJ9EEfdsEK6Swk4tQ0nkI1nbMaduTXztHZUCsRKh7+Chjv1kMK7HzVPzGBHSNyfWVSko+oLft86JT0KJigCKiCOKqvAHO1B4U=;
X-UUID: 17289305761249b9ae81c631586c6301-20200617
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1829706215; Wed, 17 Jun 2020 15:05:25 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 17 Jun 2020 15:05:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 17 Jun 2020 15:05:22 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
        Wendell Lin <wendell.lin@mediatek.com>
Subject: [PATCH v16 02/11] dt-bindings: soc: Add MT8183 power dt-bindings
Date:   Wed, 17 Jun 2020 15:05:08 +0800
Message-ID: <1592377517-14817-3-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1592377517-14817-1-git-send-email-weiyi.lu@mediatek.com>
References: <1592377517-14817-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 0AF6C61D160782B90D753CEF63B0F93B7E3504FF64E2CD5137561A2921C7035B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHBvd2VyIGR0LWJpbmRpbmdzIG9mIE1UODE4MyBhbmQgaW50cm9kdWNlcyAiQkFTSUMiIGFu
ZA0KIlNVQlNZUyIgY2xvY2sgdHlwZXMgaW4gYmluZGluZyBkb2N1bWVudC4NClRoZSAiQkFTSUMi
IHR5cGUgaXMgY29tcGF0aWJsZSB0byB0aGUgb3JpZ2luYWwgcG93ZXIgY29udHJvbCB3aXRoDQpj
bG9jayBuYW1lIFthLXpdK1swLTldKiwgZS5nLiBtbSwgdnB1MS4NClRoZSAiU1VCU1lTIiB0eXBl
IGlzIHVzZWQgZm9yIGJ1cyBwcm90ZWN0aW9uIGNvbnRyb2wgd2l0aCBjbG9jaw0KbmFtZSBbYS16
XSstWzAtOV0rLCBlLmcuIGlzcC0wLCBjYW0tMS4NCkFuZCBhZGQgYW4gb3B0aW9uYWwgIm1lZGlh
dGVrLHNtaSIgcHJvcGVydHkgZm9yIHBoYW5kbGUgdG8gc21pLWNvbW1vbg0Kbm9kZS4NCg0KU2ln
bmVkLW9mZi1ieTogV2VpeWkgTHUgPHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4NClJldmlld2VkLWJ5
OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KLS0tDQogLi4uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc29jL21lZGlhdGVrL3NjcHN5cy50eHQgICAgfCAyMSArKysrKysrKysrKysrKy0tLQ0K
IGluY2x1ZGUvZHQtYmluZGluZ3MvcG93ZXIvbXQ4MTgzLXBvd2VyLmggICAgICAgICAgIHwgMjYg
KysrKysrKysrKysrKysrKysrKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygr
KSwgMyBkZWxldGlvbnMoLSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9kdC1iaW5kaW5n
cy9wb3dlci9tdDgxODMtcG93ZXIuaA0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9zY3BzeXMudHh0IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9zY3BzeXMudHh0DQppbmRleCAyYmMzNjc3
Li44ZTBiOWYyIDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3NvYy9tZWRpYXRlay9zY3BzeXMudHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3Mvc29jL21lZGlhdGVrL3NjcHN5cy50eHQNCkBAIC0xNSw2ICsxNSw3IEBAIHBvd2Vy
L3Bvd2VyLWRvbWFpbi55YW1sLiBJdCBwcm92aWRlcyB0aGUgcG93ZXIgZG9tYWlucyBkZWZpbmVk
IGluDQogLSBpbmNsdWRlL2R0LWJpbmRpbmdzL3Bvd2VyL210MjcwMS1wb3dlci5oDQogLSBpbmNs
dWRlL2R0LWJpbmRpbmdzL3Bvd2VyL210MjcxMi1wb3dlci5oDQogLSBpbmNsdWRlL2R0LWJpbmRp
bmdzL3Bvd2VyL210NzYyMi1wb3dlci5oDQorLSBpbmNsdWRlL2R0LWJpbmRpbmdzL3Bvd2VyL210
ODE4My1wb3dlci5oDQogDQogUmVxdWlyZWQgcHJvcGVydGllczoNCiAtIGNvbXBhdGlibGU6IFNo
b3VsZCBiZSBvbmUgb2Y6DQpAQCAtMjcsMTIgKzI4LDE2IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6
DQogCS0gIm1lZGlhdGVrLG10NzYyM2Etc2Nwc3lzIjogRm9yIE1UNzYyM0EgU29DDQogCS0gIm1l
ZGlhdGVrLG10NzYyOS1zY3BzeXMiLCAibWVkaWF0ZWssbXQ3NjIyLXNjcHN5cyI6IEZvciBNVDc2
MjkgU29DDQogCS0gIm1lZGlhdGVrLG10ODE3My1zY3BzeXMiDQorCS0gIm1lZGlhdGVrLG10ODE4
My1zY3BzeXMiDQogLSAjcG93ZXItZG9tYWluLWNlbGxzOiBNdXN0IGJlIDENCiAtIHJlZzogQWRk
cmVzcyByYW5nZSBvZiB0aGUgU0NQU1lTIHVuaXQNCiAtIGluZnJhY2ZnOiBtdXN0IGNvbnRhaW4g
YSBwaGFuZGxlIHRvIHRoZSBpbmZyYWNmZyBjb250cm9sbGVyDQotLSBjbG9jaywgY2xvY2stbmFt
ZXM6IGNsb2NrcyBhY2NvcmRpbmcgdG8gdGhlIGNvbW1vbiBjbG9jayBiaW5kaW5nLg0KLSAgICAg
ICAgICAgICAgICAgICAgICBUaGVzZSBhcmUgY2xvY2tzIHdoaWNoIGhhcmR3YXJlIG5lZWRzIHRv
IGJlDQotICAgICAgICAgICAgICAgICAgICAgIGVuYWJsZWQgYmVmb3JlIGVuYWJsaW5nIGNlcnRh
aW4gcG93ZXIgZG9tYWlucy4NCistIGNsb2NrLCBjbG9jay1uYW1lczogQ2xvY2tzIGFjY29yZGlu
ZyB0byB0aGUgY29tbW9uIGNsb2NrIGJpbmRpbmcuDQorICAgICAgICAgICAgICAgICAgICAgIFNv
bWUgU29DcyBoYXZlIHRvIGdyb3VwcyBvZiBjbG9ja3MuDQorICAgICAgICAgICAgICAgICAgICAg
IEJBU0lDIGNsb2NrcyBuZWVkIHRvIGJlIGVuYWJsZWQgYmVmb3JlIGVuYWJsaW5nIHRoZQ0KKyAg
ICAgICAgICAgICAgICAgICAgICBjb3JyZXNwb25kaW5nIHBvd2VyIGRvbWFpbi4NCisgICAgICAg
ICAgICAgICAgICAgICAgU1VCU1lTIGNsb2NrcyBuZWVkIHRvIGJlIGVuYWJsZWQgYmVmb3JlIHJl
bGVhc2luZyB0aGUNCisgICAgICAgICAgICAgICAgICAgICAgYnVzIHByb3RlY3Rpb24uDQogCVJl
cXVpcmVkIGNsb2NrcyBmb3IgTVQyNzAxIG9yIE1UNzYyMzogIm1tIiwgIm1mZyIsICJldGhpZiIN
CiAJUmVxdWlyZWQgY2xvY2tzIGZvciBNVDI3MTI6ICJtbSIsICJtZmciLCAidmVuYyIsICJqcGdk
ZWMiLCAiYXVkaW8iLCAidmRlYyINCiAJUmVxdWlyZWQgY2xvY2tzIGZvciBNVDY3NjU6IE1VWDog
Im1tIiwgIm1mZyINCkBAIC00Myw2ICs0OCwxNSBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KIAlS
ZXF1aXJlZCBjbG9ja3MgZm9yIE1UNzYyMiBvciBNVDc2Mjk6ICJoaWZfc2VsIg0KIAlSZXF1aXJl
ZCBjbG9ja3MgZm9yIE1UNzYyM0E6ICJldGhpZiINCiAJUmVxdWlyZWQgY2xvY2tzIGZvciBNVDgx
NzM6ICJtbSIsICJtZmciLCAidmVuYyIsICJ2ZW5jX2x0Ig0KKwlSZXF1aXJlZCBjbG9ja3MgZm9y
IE1UODE4MzogQkFTSUM6ICJhdWRpbyIsICJtZmciLCAibW0iLCAiY2FtIiwgImlzcCIsDQorCQkJ
CQkgICAidnB1IiwgInZwdTEiLCAidnB1MiIsICJ2cHUzIg0KKwkJCQkgICAgU1VCU1lTOiAibW0t
MCIsICJtbS0xIiwgIm1tLTIiLCAibW0tMyIsDQorCQkJCQkgICAgIm1tLTQiLCAibW0tNSIsICJt
bS02IiwgIm1tLTciLA0KKwkJCQkJICAgICJtbS04IiwgIm1tLTkiLCAiaXNwLTAiLCAiaXNwLTEi
LA0KKwkJCQkJICAgICJjYW0tMCIsICJjYW0tMSIsICJjYW0tMiIsICJjYW0tMyIsDQorCQkJCQkg
ICAgImNhbS00IiwgImNhbS01IiwgImNhbS02IiwgInZwdS0wIiwNCisJCQkJCSAgICAidnB1LTEi
LCAidnB1LTIiLCAidnB1LTMiLCAidnB1LTQiLA0KKwkJCQkJICAgICJ2cHUtNSINCiANCiBPcHRp
b25hbCBwcm9wZXJ0aWVzOg0KIC0gdmRlYy1zdXBwbHk6IFBvd2VyIHN1cHBseSBmb3IgdGhlIHZk
ZWMgcG93ZXIgZG9tYWluDQpAQCAtNTUsNiArNjksNyBAQCBPcHRpb25hbCBwcm9wZXJ0aWVzOg0K
IC0gbWZnX2FzeW5jLXN1cHBseTogUG93ZXIgc3VwcGx5IGZvciB0aGUgbWZnX2FzeW5jIHBvd2Vy
IGRvbWFpbg0KIC0gbWZnXzJkLXN1cHBseTogUG93ZXIgc3VwcGx5IGZvciB0aGUgbWZnXzJkIHBv
d2VyIGRvbWFpbg0KIC0gbWZnLXN1cHBseTogUG93ZXIgc3VwcGx5IGZvciB0aGUgbWZnIHBvd2Vy
IGRvbWFpbg0KKy0gbWVkaWF0ZWssc21pIDogQSBwaGFuZGxlIHRvIHRoZSBzbWlfY29tbW9uIG5v
ZGUNCiANCiBFeGFtcGxlOg0KIA0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHQtYmluZGluZ3MvcG93
ZXIvbXQ4MTgzLXBvd2VyLmggYi9pbmNsdWRlL2R0LWJpbmRpbmdzL3Bvd2VyL210ODE4My1wb3dl
ci5oDQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMC4uZDFhYjM4Nw0KLS0tIC9k
ZXYvbnVsbA0KKysrIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9wb3dlci9tdDgxODMtcG93ZXIuaA0K
QEAgLTAsMCArMSwyNiBAQA0KKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wICov
DQorLyoNCisgKiBDb3B5cmlnaHQgKGMpIDIwMjAgTWVkaWFUZWsgSW5jLg0KKyAqIEF1dGhvcjog
V2VpeWkgTHUgPHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4NCisgKi8NCisNCisjaWZuZGVmIF9EVF9C
SU5ESU5HU19QT1dFUl9NVDgxODNfUE9XRVJfSA0KKyNkZWZpbmUgX0RUX0JJTkRJTkdTX1BPV0VS
X01UODE4M19QT1dFUl9IDQorDQorI2RlZmluZSBNVDgxODNfUE9XRVJfRE9NQUlOX0FVRElPCTAN
CisjZGVmaW5lIE1UODE4M19QT1dFUl9ET01BSU5fQ09OTgkxDQorI2RlZmluZSBNVDgxODNfUE9X
RVJfRE9NQUlOX01GR19BU1lOQwkyDQorI2RlZmluZSBNVDgxODNfUE9XRVJfRE9NQUlOX01GRwkJ
Mw0KKyNkZWZpbmUgTVQ4MTgzX1BPV0VSX0RPTUFJTl9NRkdfQ09SRTAJNA0KKyNkZWZpbmUgTVQ4
MTgzX1BPV0VSX0RPTUFJTl9NRkdfQ09SRTEJNQ0KKyNkZWZpbmUgTVQ4MTgzX1BPV0VSX0RPTUFJ
Tl9NRkdfMkQJNg0KKyNkZWZpbmUgTVQ4MTgzX1BPV0VSX0RPTUFJTl9ESVNQCTcNCisjZGVmaW5l
IE1UODE4M19QT1dFUl9ET01BSU5fQ0FNCQk4DQorI2RlZmluZSBNVDgxODNfUE9XRVJfRE9NQUlO
X0lTUAkJOQ0KKyNkZWZpbmUgTVQ4MTgzX1BPV0VSX0RPTUFJTl9WREVDCTEwDQorI2RlZmluZSBN
VDgxODNfUE9XRVJfRE9NQUlOX1ZFTkMJMTENCisjZGVmaW5lIE1UODE4M19QT1dFUl9ET01BSU5f
VlBVX1RPUAkxMg0KKyNkZWZpbmUgTVQ4MTgzX1BPV0VSX0RPTUFJTl9WUFVfQ09SRTAJMTMNCisj
ZGVmaW5lIE1UODE4M19QT1dFUl9ET01BSU5fVlBVX0NPUkUxCTE0DQorDQorI2VuZGlmIC8qIF9E
VF9CSU5ESU5HU19QT1dFUl9NVDgxODNfUE9XRVJfSCAqLw0KLS0gDQoxLjguMS4xLmRpcnR5DQo=

