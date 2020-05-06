Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A8EC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 08:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21BE6206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 08:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bXv/+2Mc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgEFIQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 04:16:17 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:7851 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728633AbgEFIQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 04:16:12 -0400
X-UUID: 980493b0e88047678e53e74e1b346b5d-20200506
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=oR3OUqlEj6501mnxViC+sy+Qka6UCB/kplYNkHLN4E0=;
        b=bXv/+2McDwv3fBU/3kYuADLHu6nxA9hwwYC/QZeDgpDejgafdhnxwWhBbs5SUyFHw7hz3d3xOl1aVeUlpIybnETDK/MUXV+OGCrs6RVm8/MiqWiAgD+l5TlPP3qX8/V+3tKMoi6vw4LL6v0SOKJM+tpiub4V3C5adxjP1A5EY20=;
X-UUID: 980493b0e88047678e53e74e1b346b5d-20200506
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 344912794; Wed, 06 May 2020 16:16:06 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 6 May 2020 16:16:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 6 May 2020 16:16:04 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v14 02/11] dt-bindings: soc: Add MT8183 power dt-bindings
Date:   Wed, 6 May 2020 16:15:54 +0800
Message-ID: <1588752963-19934-3-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1588752963-19934-1-git-send-email-weiyi.lu@mediatek.com>
References: <1588752963-19934-1-git-send-email-weiyi.lu@mediatek.com>
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
XSstWzAtOV0rLCBlLmcuIGlzcC0wLCBjYW0tMS4NCkFuZCBhZGQgYW4gb3B0aW9uYWwgc21pLWNv
bW0gcHJvcGVydHkgZm9yIHBoYW5kbGUgdG8gc21pLWNvbW1vbg0KY29udHJvbGxlci4NCg0KU2ln
bmVkLW9mZi1ieTogV2VpeWkgTHUgPHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIC4uLi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9zY3BzeXMudHh0ICAgIHwgMjEgKysrKysr
KysrKysrKystLS0NCiBpbmNsdWRlL2R0LWJpbmRpbmdzL3Bvd2VyL210ODE4My1wb3dlci5oICAg
ICAgICAgICB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDQ0
IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1
ZGUvZHQtYmluZGluZ3MvcG93ZXIvbXQ4MTgzLXBvd2VyLmgNCg0KZGlmZiAtLWdpdCBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvc2Nwc3lzLnR4dCBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvc2Nwc3lzLnR4dA0K
aW5kZXggMmJjMzY3Ny4uNTQyNGU2NiAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNl
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
dGhlIG1mZyBwb3dlciBkb21haW4NCistIHNtaV9jb21tOiBhIHBoYW5kbGUgdG8gdGhlIHNtaS1j
b21tb24gY29udHJvbGxlcg0KIA0KIEV4YW1wbGU6DQogDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9k
dC1iaW5kaW5ncy9wb3dlci9tdDgxODMtcG93ZXIuaCBiL2luY2x1ZGUvZHQtYmluZGluZ3MvcG93
ZXIvbXQ4MTgzLXBvd2VyLmgNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwLi5k
NmIyNWY4DQotLS0gL2Rldi9udWxsDQorKysgYi9pbmNsdWRlL2R0LWJpbmRpbmdzL3Bvd2VyL210
ODE4My1wb3dlci5oDQpAQCAtMCwwICsxLDI2IEBADQorLyogU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IEdQTC0yLjAgKi8NCisvKg0KKyAqIENvcHlyaWdodCAoYykgMjAxOCBNZWRpYVRlayBJbmMu
DQorICogQXV0aG9yOiBXZWl5aSBMdSA8d2VpeWkubHVAbWVkaWF0ZWsuY29tPg0KKyAqLw0KKw0K
KyNpZm5kZWYgX0RUX0JJTkRJTkdTX1BPV0VSX01UODE4M19QT1dFUl9IDQorI2RlZmluZSBfRFRf
QklORElOR1NfUE9XRVJfTVQ4MTgzX1BPV0VSX0gNCisNCisjZGVmaW5lIE1UODE4M19QT1dFUl9E
T01BSU5fQVVESU8JMA0KKyNkZWZpbmUgTVQ4MTgzX1BPV0VSX0RPTUFJTl9DT05OCTENCisjZGVm
aW5lIE1UODE4M19QT1dFUl9ET01BSU5fTUZHX0FTWU5DCTINCisjZGVmaW5lIE1UODE4M19QT1dF
Ul9ET01BSU5fTUZHCQkzDQorI2RlZmluZSBNVDgxODNfUE9XRVJfRE9NQUlOX01GR19DT1JFMAk0
DQorI2RlZmluZSBNVDgxODNfUE9XRVJfRE9NQUlOX01GR19DT1JFMQk1DQorI2RlZmluZSBNVDgx
ODNfUE9XRVJfRE9NQUlOX01GR18yRAk2DQorI2RlZmluZSBNVDgxODNfUE9XRVJfRE9NQUlOX0RJ
U1AJNw0KKyNkZWZpbmUgTVQ4MTgzX1BPV0VSX0RPTUFJTl9DQU0JCTgNCisjZGVmaW5lIE1UODE4
M19QT1dFUl9ET01BSU5fSVNQCQk5DQorI2RlZmluZSBNVDgxODNfUE9XRVJfRE9NQUlOX1ZERUMJ
MTANCisjZGVmaW5lIE1UODE4M19QT1dFUl9ET01BSU5fVkVOQwkxMQ0KKyNkZWZpbmUgTVQ4MTgz
X1BPV0VSX0RPTUFJTl9WUFVfVE9QCTEyDQorI2RlZmluZSBNVDgxODNfUE9XRVJfRE9NQUlOX1ZQ
VV9DT1JFMAkxMw0KKyNkZWZpbmUgTVQ4MTgzX1BPV0VSX0RPTUFJTl9WUFVfQ09SRTEJMTQNCisN
CisjZW5kaWYgLyogX0RUX0JJTkRJTkdTX1BPV0VSX01UODE4M19QT1dFUl9IICovDQotLSANCjEu
OC4xLjEuZGlydHkNCg==

