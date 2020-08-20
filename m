Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E54C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88FCA2078D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XsYhDMyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgHTGG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 02:06:26 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:58879 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726951AbgHTGGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 02:06:01 -0400
X-UUID: f50066c0bf4d43d680157dc9e53267d0-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=T4O+YyIppnD25hiER8zzbit4v9W+Njgd5FCWpgHsGSk=;
        b=XsYhDMyfCGwthmBM71aQLLTNg91vRETbGFYLNnn689vNsMeRCDFepKBG3icCTOOdIwMffjjPILwj4siGRydtY5+a4H0NsFpffaZAMsmgFvOmokEoMlwNDnCGL12NyViY6cIlRiqqau9gbP23eIoupyub/FY1Sz549dZ+1V265FE=;
X-UUID: f50066c0bf4d43d680157dc9e53267d0-20200820
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1240852115; Thu, 20 Aug 2020 14:05:57 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 14:05:55 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 14:05:48 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v1 17/21] drm/mediatek: add rdma bypass shadow register function
Date:   Thu, 20 Aug 2020 14:04:14 +0800
Message-ID: <1597903458-8055-18-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597903458-8055-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1597903458-8055-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YWRkIHJkbWEgYnlwYXNzIHNoYWRvdyByZWdpc3RlciBmdW5jdGlvbg0KDQpTaWduZWQtb2ZmLWJ5
OiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9yZG1hLmMgfCAyMCArKysrKysrKysrKysrKysr
KysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfcmRtYS5jIGIvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kaXNwX3JkbWEuYw0KaW5kZXggMDY4M2JlZi4uOTFlZDZjNiAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9yZG1hLmMNCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9yZG1hLmMNCkBAIC00NiwxMiArNDYsMTYg
QEANCiAjZGVmaW5lIFJETUFfRklGT19QU0VVRE9fU0laRShieXRlcykJCQkoKChieXRlcykgLyAx
NikgPDwgMTYpDQogI2RlZmluZSBSRE1BX09VVFBVVF9WQUxJRF9GSUZPX1RIUkVTSE9MRChieXRl
cykJCSgoYnl0ZXMpIC8gMTYpDQogI2RlZmluZSBSRE1BX0ZJRk9fU0laRShyZG1hKQkJCSgocmRt
YSktPmRhdGEtPmZpZm9fc2l6ZSkNCisjZGVmaW5lIERJU1BfUkVHX1JETUFfU0hBRE9XX1VQREFU
RQkJMHgwMGJjDQorI2RlZmluZSBESVNQX1JETUFfQllQQVNTX1NIQURPVwkJCQlCSVQoMSkNCisj
ZGVmaW5lIERJU1BfUkRNQV9SRUFEX1dPUktfUkVHCQkJCUJJVCgyKQ0KICNkZWZpbmUgRElTUF9S
RE1BX01FTV9TVEFSVF9BRERSCQkweDBmMDANCiANCiAjZGVmaW5lIFJETUFfTUVNX0dNQwkJCQkw
eDQwNDAyMDIwDQogDQogc3RydWN0IG10a19kaXNwX3JkbWFfZGF0YSB7DQogCXVuc2lnbmVkIGlu
dCBmaWZvX3NpemU7DQorCWJvb2wgaGFzX3NoYWRvdzsNCiB9Ow0KIA0KIC8qKg0KQEAgLTEyNSw2
ICsxMjksMjEgQEAgc3RhdGljIHZvaWQgbXRrX3JkbWFfc3RvcChzdHJ1Y3QgbXRrX2RkcF9jb21w
ICpjb21wKQ0KIAlyZG1hX3VwZGF0ZV9iaXRzKGNvbXAsIERJU1BfUkVHX1JETUFfR0xPQkFMX0NP
TiwgUkRNQV9FTkdJTkVfRU4sIDApOw0KIH0NCiANCitzdGF0aWMgdm9pZCBtdGtfcmRtYV9ieXBh
c3Nfc2hhZG93KHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXApDQorew0KKwlzdHJ1Y3QgbXRrX2Rp
c3BfcmRtYSAqcmRtYSA9IGNvbXBfdG9fcmRtYShjb21wKTsNCisNCisJaWYgKHJkbWEtPmRhdGEt
Pmhhc19zaGFkb3cpIHsNCisJCXByX2VycigiZGlzYWJsZSByZG1hIHNoYWRvd1xuIik7DQorCQlt
dGtfZGRwX3dyaXRlX21hc2soTlVMTCwgRElTUF9SRE1BX0JZUEFTU19TSEFET1csIGNvbXAsDQor
CQkJCSAgIERJU1BfUkVHX1JETUFfU0hBRE9XX1VQREFURSwNCisJCQkJICAgRElTUF9SRE1BX0JZ
UEFTU19TSEFET1cpOw0KKwkJbXRrX2RkcF93cml0ZV9tYXNrKE5VTEwsIERJU1BfUkRNQV9SRUFE
X1dPUktfUkVHLCBjb21wLA0KKwkJCQkgICBESVNQX1JFR19SRE1BX1NIQURPV19VUERBVEUsDQor
CQkJCSAgIERJU1BfUkRNQV9SRUFEX1dPUktfUkVHKTsNCisJfQ0KK30NCisNCiBzdGF0aWMgdm9p
ZCBtdGtfcmRtYV9jb25maWcoc3RydWN0IG10a19kZHBfY29tcCAqY29tcCwgdW5zaWduZWQgaW50
IHdpZHRoLA0KIAkJCSAgICB1bnNpZ25lZCBpbnQgaGVpZ2h0LCB1bnNpZ25lZCBpbnQgdnJlZnJl
c2gsDQogCQkJICAgIHVuc2lnbmVkIGludCBicGMsIHN0cnVjdCBjbWRxX3BrdCAqY21kcV9wa3Qp
DQpAQCAtMjM4LDYgKzI1Nyw3IEBAIHN0YXRpYyB2b2lkIG10a19yZG1hX2xheWVyX2NvbmZpZyhz
dHJ1Y3QgbXRrX2RkcF9jb21wICpjb21wLCB1bnNpZ25lZCBpbnQgaWR4LA0KIAkuY29uZmlnID0g
bXRrX3JkbWFfY29uZmlnLA0KIAkuc3RhcnQgPSBtdGtfcmRtYV9zdGFydCwNCiAJLnN0b3AgPSBt
dGtfcmRtYV9zdG9wLA0KKwkuYnlwYXNzX3NoYWRvdyA9IG10a19yZG1hX2J5cGFzc19zaGFkb3cs
DQogCS5lbmFibGVfdmJsYW5rID0gbXRrX3JkbWFfZW5hYmxlX3ZibGFuaywNCiAJLmRpc2FibGVf
dmJsYW5rID0gbXRrX3JkbWFfZGlzYWJsZV92YmxhbmssDQogCS5sYXllcl9uciA9IG10a19yZG1h
X2xheWVyX25yLA0KLS0gDQoxLjguMS4xLmRpcnR5DQo=

