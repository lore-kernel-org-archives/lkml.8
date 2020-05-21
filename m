Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE40C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEC022083E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="E+mxuizH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgEUJHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 05:07:17 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:59523 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728764AbgEUJGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 05:06:37 -0400
X-UUID: 3e71c011987c460a88dad4dc253d272a-20200521
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=EngFUxNH5G2cMwDOiap0tjIUd5Mm1vZg+pAPcXVH5HI=;
        b=E+mxuizHyPk8hp4vNn8SZdEf8d2Ns3dobgZuUPBodzJStzm2nMjKK7sLLO/K8qhzuk+/Uq2WcbRLGhk6DOumWAKd1cBKr9eKSTgDOE6LJ0tOGEyoyWYKLix2KzLTCRkH19VWPBzBnXUbQEvYJcq70LqWNhudb4niDutceBzOe2M=;
X-UUID: 3e71c011987c460a88dad4dc253d272a-20200521
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1162361000; Thu, 21 May 2020 17:06:32 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 May 2020 17:06:29 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 21 May 2020 17:06:28 +0800
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
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v15 02/11] dt-bindings: soc: Add MT8183 power dt-bindings
Date:   Thu, 21 May 2020 17:06:15 +0800
Message-ID: <1590051985-29149-3-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1590051985-29149-1-git-send-email-weiyi.lu@mediatek.com>
References: <1590051985-29149-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F67F8F8D0C13B39D584C4CD926A4C34186E56C83059A2CA805D364C519AD016A2000:8
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
bmVkLW9mZi1ieTogV2VpeWkgTHUgPHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIC4uLi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9zY3BzeXMudHh0ICAgIHwgMjEgKysrKysr
KysrKysrKystLS0NCiBpbmNsdWRlL2R0LWJpbmRpbmdzL3Bvd2VyL210ODE4My1wb3dlci5oICAg
ICAgICAgICB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDQ0
IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1
ZGUvZHQtYmluZGluZ3MvcG93ZXIvbXQ4MTgzLXBvd2VyLmgNCg0KZGlmZiAtLWdpdCBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvc2Nwc3lzLnR4dCBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvc2Nwc3lzLnR4dA0K
aW5kZXggMmJjMzY3Ny4uOGUwYjlmMiAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvc2Nwc3lzLnR4dA0KKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9zY3BzeXMudHh0DQpAQCAtMTUsNiAr
MTUsNyBAQCBwb3dlci9wb3dlci1kb21haW4ueWFtbC4gSXQgcHJvdmlkZXMgdGhlIHBvd2VyIGRv
bWFpbnMgZGVmaW5lZCBpbg0KIC0gaW5jbHVkZS9kdC1iaW5kaW5ncy9wb3dlci9tdDI3MDEtcG93
ZXIuaA0KIC0gaW5jbHVkZS9kdC1iaW5kaW5ncy9wb3dlci9tdDI3MTItcG93ZXIuaA0KIC0gaW5j
bHVkZS9kdC1iaW5kaW5ncy9wb3dlci9tdDc2MjItcG93ZXIuaA0KKy0gaW5jbHVkZS9kdC1iaW5k
aW5ncy9wb3dlci9tdDgxODMtcG93ZXIuaA0KIA0KIFJlcXVpcmVkIHByb3BlcnRpZXM6DQogLSBj
b21wYXRpYmxlOiBTaG91bGQgYmUgb25lIG9mOg0KQEAgLTI3LDEyICsyOCwxNiBAQCBSZXF1aXJl
ZCBwcm9wZXJ0aWVzOg0KIAktICJtZWRpYXRlayxtdDc2MjNhLXNjcHN5cyI6IEZvciBNVDc2MjNB
IFNvQw0KIAktICJtZWRpYXRlayxtdDc2Mjktc2Nwc3lzIiwgIm1lZGlhdGVrLG10NzYyMi1zY3Bz
eXMiOiBGb3IgTVQ3NjI5IFNvQw0KIAktICJtZWRpYXRlayxtdDgxNzMtc2Nwc3lzIg0KKwktICJt
ZWRpYXRlayxtdDgxODMtc2Nwc3lzIg0KIC0gI3Bvd2VyLWRvbWFpbi1jZWxsczogTXVzdCBiZSAx
DQogLSByZWc6IEFkZHJlc3MgcmFuZ2Ugb2YgdGhlIFNDUFNZUyB1bml0DQogLSBpbmZyYWNmZzog
bXVzdCBjb250YWluIGEgcGhhbmRsZSB0byB0aGUgaW5mcmFjZmcgY29udHJvbGxlcg0KLS0gY2xv
Y2ssIGNsb2NrLW5hbWVzOiBjbG9ja3MgYWNjb3JkaW5nIHRvIHRoZSBjb21tb24gY2xvY2sgYmlu
ZGluZy4NCi0gICAgICAgICAgICAgICAgICAgICAgVGhlc2UgYXJlIGNsb2NrcyB3aGljaCBoYXJk
d2FyZSBuZWVkcyB0byBiZQ0KLSAgICAgICAgICAgICAgICAgICAgICBlbmFibGVkIGJlZm9yZSBl
bmFibGluZyBjZXJ0YWluIHBvd2VyIGRvbWFpbnMuDQorLSBjbG9jaywgY2xvY2stbmFtZXM6IENs
b2NrcyBhY2NvcmRpbmcgdG8gdGhlIGNvbW1vbiBjbG9jayBiaW5kaW5nLg0KKyAgICAgICAgICAg
ICAgICAgICAgICBTb21lIFNvQ3MgaGF2ZSB0byBncm91cHMgb2YgY2xvY2tzLg0KKyAgICAgICAg
ICAgICAgICAgICAgICBCQVNJQyBjbG9ja3MgbmVlZCB0byBiZSBlbmFibGVkIGJlZm9yZSBlbmFi
bGluZyB0aGUNCisgICAgICAgICAgICAgICAgICAgICAgY29ycmVzcG9uZGluZyBwb3dlciBkb21h
aW4uDQorICAgICAgICAgICAgICAgICAgICAgIFNVQlNZUyBjbG9ja3MgbmVlZCB0byBiZSBlbmFi
bGVkIGJlZm9yZSByZWxlYXNpbmcgdGhlDQorICAgICAgICAgICAgICAgICAgICAgIGJ1cyBwcm90
ZWN0aW9uLg0KIAlSZXF1aXJlZCBjbG9ja3MgZm9yIE1UMjcwMSBvciBNVDc2MjM6ICJtbSIsICJt
ZmciLCAiZXRoaWYiDQogCVJlcXVpcmVkIGNsb2NrcyBmb3IgTVQyNzEyOiAibW0iLCAibWZnIiwg
InZlbmMiLCAianBnZGVjIiwgImF1ZGlvIiwgInZkZWMiDQogCVJlcXVpcmVkIGNsb2NrcyBmb3Ig
TVQ2NzY1OiBNVVg6ICJtbSIsICJtZmciDQpAQCAtNDMsNiArNDgsMTUgQEAgUmVxdWlyZWQgcHJv
cGVydGllczoNCiAJUmVxdWlyZWQgY2xvY2tzIGZvciBNVDc2MjIgb3IgTVQ3NjI5OiAiaGlmX3Nl
bCINCiAJUmVxdWlyZWQgY2xvY2tzIGZvciBNVDc2MjNBOiAiZXRoaWYiDQogCVJlcXVpcmVkIGNs
b2NrcyBmb3IgTVQ4MTczOiAibW0iLCAibWZnIiwgInZlbmMiLCAidmVuY19sdCINCisJUmVxdWly
ZWQgY2xvY2tzIGZvciBNVDgxODM6IEJBU0lDOiAiYXVkaW8iLCAibWZnIiwgIm1tIiwgImNhbSIs
ICJpc3AiLA0KKwkJCQkJICAgInZwdSIsICJ2cHUxIiwgInZwdTIiLCAidnB1MyINCisJCQkJICAg
IFNVQlNZUzogIm1tLTAiLCAibW0tMSIsICJtbS0yIiwgIm1tLTMiLA0KKwkJCQkJICAgICJtbS00
IiwgIm1tLTUiLCAibW0tNiIsICJtbS03IiwNCisJCQkJCSAgICAibW0tOCIsICJtbS05IiwgImlz
cC0wIiwgImlzcC0xIiwNCisJCQkJCSAgICAiY2FtLTAiLCAiY2FtLTEiLCAiY2FtLTIiLCAiY2Ft
LTMiLA0KKwkJCQkJICAgICJjYW0tNCIsICJjYW0tNSIsICJjYW0tNiIsICJ2cHUtMCIsDQorCQkJ
CQkgICAgInZwdS0xIiwgInZwdS0yIiwgInZwdS0zIiwgInZwdS00IiwNCisJCQkJCSAgICAidnB1
LTUiDQogDQogT3B0aW9uYWwgcHJvcGVydGllczoNCiAtIHZkZWMtc3VwcGx5OiBQb3dlciBzdXBw
bHkgZm9yIHRoZSB2ZGVjIHBvd2VyIGRvbWFpbg0KQEAgLTU1LDYgKzY5LDcgQEAgT3B0aW9uYWwg
cHJvcGVydGllczoNCiAtIG1mZ19hc3luYy1zdXBwbHk6IFBvd2VyIHN1cHBseSBmb3IgdGhlIG1m
Z19hc3luYyBwb3dlciBkb21haW4NCiAtIG1mZ18yZC1zdXBwbHk6IFBvd2VyIHN1cHBseSBmb3Ig
dGhlIG1mZ18yZCBwb3dlciBkb21haW4NCiAtIG1mZy1zdXBwbHk6IFBvd2VyIHN1cHBseSBmb3Ig
dGhlIG1mZyBwb3dlciBkb21haW4NCistIG1lZGlhdGVrLHNtaSA6IEEgcGhhbmRsZSB0byB0aGUg
c21pX2NvbW1vbiBub2RlDQogDQogRXhhbXBsZToNCiANCmRpZmYgLS1naXQgYS9pbmNsdWRlL2R0
LWJpbmRpbmdzL3Bvd2VyL210ODE4My1wb3dlci5oIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9wb3dl
ci9tdDgxODMtcG93ZXIuaA0KbmV3IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAuLmQx
YWIzODcNCi0tLSAvZGV2L251bGwNCisrKyBiL2luY2x1ZGUvZHQtYmluZGluZ3MvcG93ZXIvbXQ4
MTgzLXBvd2VyLmgNCkBAIC0wLDAgKzEsMjYgQEANCisvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogR1BMLTIuMCAqLw0KKy8qDQorICogQ29weXJpZ2h0IChjKSAyMDIwIE1lZGlhVGVrIEluYy4N
CisgKiBBdXRob3I6IFdlaXlpIEx1IDx3ZWl5aS5sdUBtZWRpYXRlay5jb20+DQorICovDQorDQor
I2lmbmRlZiBfRFRfQklORElOR1NfUE9XRVJfTVQ4MTgzX1BPV0VSX0gNCisjZGVmaW5lIF9EVF9C
SU5ESU5HU19QT1dFUl9NVDgxODNfUE9XRVJfSA0KKw0KKyNkZWZpbmUgTVQ4MTgzX1BPV0VSX0RP
TUFJTl9BVURJTwkwDQorI2RlZmluZSBNVDgxODNfUE9XRVJfRE9NQUlOX0NPTk4JMQ0KKyNkZWZp
bmUgTVQ4MTgzX1BPV0VSX0RPTUFJTl9NRkdfQVNZTkMJMg0KKyNkZWZpbmUgTVQ4MTgzX1BPV0VS
X0RPTUFJTl9NRkcJCTMNCisjZGVmaW5lIE1UODE4M19QT1dFUl9ET01BSU5fTUZHX0NPUkUwCTQN
CisjZGVmaW5lIE1UODE4M19QT1dFUl9ET01BSU5fTUZHX0NPUkUxCTUNCisjZGVmaW5lIE1UODE4
M19QT1dFUl9ET01BSU5fTUZHXzJECTYNCisjZGVmaW5lIE1UODE4M19QT1dFUl9ET01BSU5fRElT
UAk3DQorI2RlZmluZSBNVDgxODNfUE9XRVJfRE9NQUlOX0NBTQkJOA0KKyNkZWZpbmUgTVQ4MTgz
X1BPV0VSX0RPTUFJTl9JU1AJCTkNCisjZGVmaW5lIE1UODE4M19QT1dFUl9ET01BSU5fVkRFQwkx
MA0KKyNkZWZpbmUgTVQ4MTgzX1BPV0VSX0RPTUFJTl9WRU5DCTExDQorI2RlZmluZSBNVDgxODNf
UE9XRVJfRE9NQUlOX1ZQVV9UT1AJMTINCisjZGVmaW5lIE1UODE4M19QT1dFUl9ET01BSU5fVlBV
X0NPUkUwCTEzDQorI2RlZmluZSBNVDgxODNfUE9XRVJfRE9NQUlOX1ZQVV9DT1JFMQkxNA0KKw0K
KyNlbmRpZiAvKiBfRFRfQklORElOR1NfUE9XRVJfTVQ4MTgzX1BPV0VSX0ggKi8NCi0tIA0KMS44
LjEuMS5kaXJ0eQ0K

