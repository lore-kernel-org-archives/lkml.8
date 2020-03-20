Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7A6C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 07:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A9A2051A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 07:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZRFWly7Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgCTHcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 03:32:51 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:22824 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727066AbgCTHct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 03:32:49 -0400
X-UUID: 7793a52cf1924649b8b54433c4876cd6-20200320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ZC2J6BbILzkt+Pj6lQ1euyr8SqmbBtkMhxwCjUic6jM=;
        b=ZRFWly7ZEKq/qfFUIgymQvkF+UV8mLPok2DQLQHjNV/GrMqZgrLFJNt07O7oEFm5xQ/gH9sZJij89l4mTlQPenlOxy01TKkm0z547HpQHGRUHUp5+J5aUA92o11oSo3hpsnIJDUgR6rE6WioIytielE+AnYRD9JorCkFIlF9L14=;
X-UUID: 7793a52cf1924649b8b54433c4876cd6-20200320
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1849391621; Fri, 20 Mar 2020 15:32:26 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 20 Mar 2020 15:31:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 20 Mar 2020 15:29:18 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v13 02/11] dt-bindings: soc: Add MT8183 power dt-bindings
Date:   Fri, 20 Mar 2020 15:32:11 +0800
Message-ID: <1584689540-5227-3-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1584689540-5227-1-git-send-email-weiyi.lu@mediatek.com>
References: <1584689540-5227-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
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
XSstWzAtOV0rLCBlLmcuIGlzcC0wLCBjYW0tMS4NCg0KU2lnbmVkLW9mZi1ieTogV2VpeWkgTHUg
PHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Nv
Yy9tZWRpYXRlay9zY3BzeXMudHh0ICAgIHwgMjAgKysrKysrKysrKysrKystLS0NCiBpbmNsdWRl
L2R0LWJpbmRpbmdzL3Bvd2VyL210ODE4My1wb3dlci5oICAgICAgICAgICB8IDI2ICsrKysrKysr
KysrKysrKysrKysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDQzIGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvZHQtYmluZGluZ3MvcG93ZXIv
bXQ4MTgzLXBvd2VyLmgNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9zb2MvbWVkaWF0ZWsvc2Nwc3lzLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvc2Nwc3lzLnR4dA0KaW5kZXggMmJjMzY3Ny4uMWJhYWE2
ZiAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWVk
aWF0ZWsvc2Nwc3lzLnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3NvYy9tZWRpYXRlay9zY3BzeXMudHh0DQpAQCAtMTUsNiArMTUsNyBAQCBwb3dlci9wb3dlci1k
b21haW4ueWFtbC4gSXQgcHJvdmlkZXMgdGhlIHBvd2VyIGRvbWFpbnMgZGVmaW5lZCBpbg0KIC0g
aW5jbHVkZS9kdC1iaW5kaW5ncy9wb3dlci9tdDI3MDEtcG93ZXIuaA0KIC0gaW5jbHVkZS9kdC1i
aW5kaW5ncy9wb3dlci9tdDI3MTItcG93ZXIuaA0KIC0gaW5jbHVkZS9kdC1iaW5kaW5ncy9wb3dl
ci9tdDc2MjItcG93ZXIuaA0KKy0gaW5jbHVkZS9kdC1iaW5kaW5ncy9wb3dlci9tdDgxODMtcG93
ZXIuaA0KIA0KIFJlcXVpcmVkIHByb3BlcnRpZXM6DQogLSBjb21wYXRpYmxlOiBTaG91bGQgYmUg
b25lIG9mOg0KQEAgLTI3LDEyICsyOCwxNiBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KIAktICJt
ZWRpYXRlayxtdDc2MjNhLXNjcHN5cyI6IEZvciBNVDc2MjNBIFNvQw0KIAktICJtZWRpYXRlayxt
dDc2Mjktc2Nwc3lzIiwgIm1lZGlhdGVrLG10NzYyMi1zY3BzeXMiOiBGb3IgTVQ3NjI5IFNvQw0K
IAktICJtZWRpYXRlayxtdDgxNzMtc2Nwc3lzIg0KKwktICJtZWRpYXRlayxtdDgxODMtc2Nwc3lz
Ig0KIC0gI3Bvd2VyLWRvbWFpbi1jZWxsczogTXVzdCBiZSAxDQogLSByZWc6IEFkZHJlc3MgcmFu
Z2Ugb2YgdGhlIFNDUFNZUyB1bml0DQogLSBpbmZyYWNmZzogbXVzdCBjb250YWluIGEgcGhhbmRs
ZSB0byB0aGUgaW5mcmFjZmcgY29udHJvbGxlcg0KLS0gY2xvY2ssIGNsb2NrLW5hbWVzOiBjbG9j
a3MgYWNjb3JkaW5nIHRvIHRoZSBjb21tb24gY2xvY2sgYmluZGluZy4NCi0gICAgICAgICAgICAg
ICAgICAgICAgVGhlc2UgYXJlIGNsb2NrcyB3aGljaCBoYXJkd2FyZSBuZWVkcyB0byBiZQ0KLSAg
ICAgICAgICAgICAgICAgICAgICBlbmFibGVkIGJlZm9yZSBlbmFibGluZyBjZXJ0YWluIHBvd2Vy
IGRvbWFpbnMuDQorLSBjbG9jaywgY2xvY2stbmFtZXM6IENsb2NrcyBhY2NvcmRpbmcgdG8gdGhl
IGNvbW1vbiBjbG9jayBiaW5kaW5nLg0KKyAgICAgICAgICAgICAgICAgICAgICBTb21lIFNvQ3Mg
aGF2ZSB0byBncm91cHMgb2YgY2xvY2tzLg0KKyAgICAgICAgICAgICAgICAgICAgICBCQVNJQyBj
bG9ja3MgbmVlZCB0byBiZSBlbmFibGVkIGJlZm9yZSBlbmFibGluZyB0aGUNCisgICAgICAgICAg
ICAgICAgICAgICAgY29ycmVzcG9uZGluZyBwb3dlciBkb21haW4uDQorICAgICAgICAgICAgICAg
ICAgICAgIFNVQlNZUyBjbG9ja3MgbmVlZCB0byBiZSBlbmFibGVkIGJlZm9yZSByZWxlYXNpbmcg
dGhlDQorICAgICAgICAgICAgICAgICAgICAgIGJ1cyBwcm90ZWN0aW9uLg0KIAlSZXF1aXJlZCBj
bG9ja3MgZm9yIE1UMjcwMSBvciBNVDc2MjM6ICJtbSIsICJtZmciLCAiZXRoaWYiDQogCVJlcXVp
cmVkIGNsb2NrcyBmb3IgTVQyNzEyOiAibW0iLCAibWZnIiwgInZlbmMiLCAianBnZGVjIiwgImF1
ZGlvIiwgInZkZWMiDQogCVJlcXVpcmVkIGNsb2NrcyBmb3IgTVQ2NzY1OiBNVVg6ICJtbSIsICJt
ZmciDQpAQCAtNDMsNiArNDgsMTUgQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCiAJUmVxdWlyZWQg
Y2xvY2tzIGZvciBNVDc2MjIgb3IgTVQ3NjI5OiAiaGlmX3NlbCINCiAJUmVxdWlyZWQgY2xvY2tz
IGZvciBNVDc2MjNBOiAiZXRoaWYiDQogCVJlcXVpcmVkIGNsb2NrcyBmb3IgTVQ4MTczOiAibW0i
LCAibWZnIiwgInZlbmMiLCAidmVuY19sdCINCisJUmVxdWlyZWQgY2xvY2tzIGZvciBNVDgxODM6
IEJBU0lDOiAiYXVkaW8iLCAibWZnIiwgIm1tIiwgImNhbSIsICJpc3AiLA0KKwkJCQkJICAgInZw
dSIsICJ2cHUxIiwgInZwdTIiLCAidnB1MyINCisJCQkJICAgIFNVQlNZUzogIm1tLTAiLCAibW0t
MSIsICJtbS0yIiwgIm1tLTMiLA0KKwkJCQkJICAgICJtbS00IiwgIm1tLTUiLCAibW0tNiIsICJt
bS03IiwNCisJCQkJCSAgICAibW0tOCIsICJtbS05IiwgImlzcC0wIiwgImlzcC0xIiwNCisJCQkJ
CSAgICAiY2FtLTAiLCAiY2FtLTEiLCAiY2FtLTIiLCAiY2FtLTMiLA0KKwkJCQkJICAgICJjYW0t
NCIsICJjYW0tNSIsICJjYW0tNiIsICJ2cHUtMCIsDQorCQkJCQkgICAgInZwdS0xIiwgInZwdS0y
IiwgInZwdS0zIiwgInZwdS00IiwNCisJCQkJCSAgICAidnB1LTUiDQogDQogT3B0aW9uYWwgcHJv
cGVydGllczoNCiAtIHZkZWMtc3VwcGx5OiBQb3dlciBzdXBwbHkgZm9yIHRoZSB2ZGVjIHBvd2Vy
IGRvbWFpbg0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHQtYmluZGluZ3MvcG93ZXIvbXQ4MTgzLXBv
d2VyLmggYi9pbmNsdWRlL2R0LWJpbmRpbmdzL3Bvd2VyL210ODE4My1wb3dlci5oDQpuZXcgZmls
ZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMC4uNWMwYzhjNw0KLS0tIC9kZXYvbnVsbA0KKysr
IGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9wb3dlci9tdDgxODMtcG93ZXIuaA0KQEAgLTAsMCArMSwy
NiBAQA0KKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQorICoNCisgKiBDb3B5
cmlnaHQgKGMpIDIwMTggTWVkaWFUZWsgSW5jLg0KKyAqIEF1dGhvcjogV2VpeWkgTHUgPHdlaXlp
Lmx1QG1lZGlhdGVrLmNvbT4NCisgKi8NCisNCisjaWZuZGVmIF9EVF9CSU5ESU5HU19QT1dFUl9N
VDgxODNfUE9XRVJfSA0KKyNkZWZpbmUgX0RUX0JJTkRJTkdTX1BPV0VSX01UODE4M19QT1dFUl9I
DQorDQorI2RlZmluZSBNVDgxODNfUE9XRVJfRE9NQUlOX0FVRElPCTANCisjZGVmaW5lIE1UODE4
M19QT1dFUl9ET01BSU5fQ09OTgkxDQorI2RlZmluZSBNVDgxODNfUE9XRVJfRE9NQUlOX01GR19B
U1lOQwkyDQorI2RlZmluZSBNVDgxODNfUE9XRVJfRE9NQUlOX01GRwkJMw0KKyNkZWZpbmUgTVQ4
MTgzX1BPV0VSX0RPTUFJTl9NRkdfQ09SRTAJNA0KKyNkZWZpbmUgTVQ4MTgzX1BPV0VSX0RPTUFJ
Tl9NRkdfQ09SRTEJNQ0KKyNkZWZpbmUgTVQ4MTgzX1BPV0VSX0RPTUFJTl9NRkdfMkQJNg0KKyNk
ZWZpbmUgTVQ4MTgzX1BPV0VSX0RPTUFJTl9ESVNQCTcNCisjZGVmaW5lIE1UODE4M19QT1dFUl9E
T01BSU5fQ0FNCQk4DQorI2RlZmluZSBNVDgxODNfUE9XRVJfRE9NQUlOX0lTUAkJOQ0KKyNkZWZp
bmUgTVQ4MTgzX1BPV0VSX0RPTUFJTl9WREVDCTEwDQorI2RlZmluZSBNVDgxODNfUE9XRVJfRE9N
QUlOX1ZFTkMJMTENCisjZGVmaW5lIE1UODE4M19QT1dFUl9ET01BSU5fVlBVX1RPUAkxMg0KKyNk
ZWZpbmUgTVQ4MTgzX1BPV0VSX0RPTUFJTl9WUFVfQ09SRTAJMTMNCisjZGVmaW5lIE1UODE4M19Q
T1dFUl9ET01BSU5fVlBVX0NPUkUxCTE0DQorDQorI2VuZGlmIC8qIF9EVF9CSU5ESU5HU19QT1dF
Ul9NVDgxODNfUE9XRVJfSCAqLw0KLS0gDQoxLjguMS4xLmRpcnR5DQo=

