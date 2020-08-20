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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00505C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE8282078D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mh+AxgJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgHTGGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 02:06:24 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:10199 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726851AbgHTGGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 02:06:01 -0400
X-UUID: 4cbf90b65e094ecd871f2d0efacbfc39-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ldbB1FMWbsV9yN9EbgJIgNPCJqsEbBR2TEb+4qx1VRU=;
        b=mh+AxgJkl4eJokNUm5+NwpaNVt0WzxGYwYqcWtpJPLuSZA6/PK1VmHILBdXHID+V5dmhnc/Zl5TiROTJM7AiKx+wip7iZtm2RoCLVD5sdKD+t+5fHTyo10RHCAwDPDXmF1wtkuQ7yNIaP9ZxvJ63mCtvCcRP2bQwhsEF84Ep4+w=;
X-UUID: 4cbf90b65e094ecd871f2d0efacbfc39-20200820
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 548181161; Thu, 20 Aug 2020 14:05:59 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 14:05:57 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 14:05:56 +0800
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
Subject: [PATCH v1 19/21] drm/mediatek: add aal bypass shadow register function
Date:   Thu, 20 Aug 2020 14:04:16 +0800
Message-ID: <1597903458-8055-20-git-send-email-yongqiang.niu@mediatek.com>
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

YWRkIGFhbCBieXBhc3Mgc2hhZG93IHJlZ2lzdGVyIGZ1bmN0aW9uDQoNClNpZ25lZC1vZmYtYnk6
IFlvbmdxaWFuZyBOaXUgPHlvbmdxaWFuZy5uaXVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYyB8IDExICsrKysrKysrKystDQog
MSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMgYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQppbmRleCAzMTViZDNhLi5i
NGE2ZGY1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRw
X2NvbXAuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAu
Yw0KQEAgLTM4LDcgKzM4LDggQEANCiAjZGVmaW5lIEFBTF9SRUxBWV9NT0RFCQkJCQlCSVQoMCkN
CiAjZGVmaW5lIEFBTF9FTkdJTkVfRU4JCQkJCUJJVCgxKQ0KICNkZWZpbmUgRElTUF9BQUxfU0la
RQkJCQkweDAwMzANCi0NCisjZGVmaW5lIERJU1BfQUFMX1NIQURPV19DVFJMCQkJMHgwMGYwDQor
I2RlZmluZSBBQUxfQllQQVNTX1NIQURPVwkJCQlCSVQoMCkNCiAjZGVmaW5lIERJU1BfQUFMX09V
VFBVVF9TSVpFCQkJMHgwNGQ4DQogDQogI2RlZmluZSBESVNQX0NDT1JSX0VOCQkJCTB4MDAwMA0K
QEAgLTIwNyw2ICsyMDgsMTMgQEAgc3RhdGljIHZvaWQgbXRrX2FhbF9zdG9wKHN0cnVjdCBtdGtf
ZGRwX2NvbXAgKmNvbXApDQogCXdyaXRlbF9yZWxheGVkKDB4MCwgY29tcC0+cmVncyArIERJU1Bf
QUFMX0VOKTsNCiB9DQogDQorc3RhdGljIHZvaWQgbXRrX2FhbF9ieXBhc3Nfc2hhZG93KHN0cnVj
dCBtdGtfZGRwX2NvbXAgKmNvbXApDQorew0KKwltdGtfZGRwX3dyaXRlX21hc2soTlVMTCwgQUFM
X0JZUEFTU19TSEFET1csIGNvbXAsDQorCQkJICAgRElTUF9BQUxfU0hBRE9XX0NUUkwsDQorCQkJ
ICAgQUFMX0JZUEFTU19TSEFET1cpOw0KK30NCisNCiBzdGF0aWMgdm9pZCBtdGtfY2NvcnJfY29u
ZmlnKHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXAsIHVuc2lnbmVkIGludCB3LA0KIAkJCSAgICAg
dW5zaWduZWQgaW50IGgsIHVuc2lnbmVkIGludCB2cmVmcmVzaCwNCiAJCQkgICAgIHVuc2lnbmVk
IGludCBicGMsIHN0cnVjdCBjbWRxX3BrdCAqY21kcV9wa3QpDQpAQCAtMzY1LDYgKzM3Myw3IEBA
IHN0YXRpYyB2b2lkIG10a19wb3N0bWFza19zdG9wKHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXAp
DQogCS5jb25maWcgPSBtdGtfYWFsX2NvbmZpZywNCiAJLnN0YXJ0ID0gbXRrX2FhbF9zdGFydCwN
CiAJLnN0b3AgPSBtdGtfYWFsX3N0b3AsDQorCS5ieXBhc3Nfc2hhZG93ID0gbXRrX2FhbF9ieXBh
c3Nfc2hhZG93LA0KIH07DQogDQogc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZGRwX2NvbXBfZnVu
Y3MgZGRwX2Njb3JyID0gew0KLS0gDQoxLjguMS4xLmRpcnR5DQo=

