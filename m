Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F652C7619D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3912520725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ovFWnEov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgBQIUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:20:14 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:62245 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727332AbgBQIUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:20:13 -0500
X-UUID: dee000e57eaf4740b35a3448db1d1eec-20200217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From; bh=jQ9jiEAD2Qgw9xt2uBetQRSbbbkk2xVLWRf6Tt0CQOM=;
        b=ovFWnEovHbQgmArRt5239KHyQ/tn7TP89aiWMIdtCIk6W17QAFYapr48Z0NdANrTuFX4EtEBbKuvXFaZ1vuwDabLvj8EMNnYai2K95H1cUAIvZtfIlnjDWpHKcx/vgJxC7Qqt2nAiwouHs+LQFBzUdiPPWtDr+mJSqHOvBo+fhE=;
X-UUID: dee000e57eaf4740b35a3448db1d1eec-20200217
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.liang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 109297671; Mon, 17 Feb 2020 16:19:50 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 17 Feb 2020 16:18:15 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Feb 2020 16:19:21 +0800
From:   Yong Liang <yong.liang@mediatek.com>
To:     <yong.liang@mediatek.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] amr64: dts: modify mt8183.dtsi
Date:   Mon, 17 Feb 2020 16:19:22 +0800
Message-ID: <20200217081922.22544-2-yong.liang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200217081922.22544-1-yong.liang@mediatek.com>
References: <Add watchdog device node>
 <20200217081922.22544-1-yong.liang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E9D7FE62B9A55861B3935A74EF087037A76413B02FF19D309EAAD239B8C7F5C52000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogInlvbmcubGlhbmciIDx5b25nLmxpYW5nQG1lZGlhdGVrLmNvbT4NCg0KQWRkIHdhdGNo
ZG9nIGRldmljZSBub2RlDQpEb2N1bWVudCBiYXNlIG9uIGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL3BpcGVybWFpbC9saW51eC1tZWRpYXRlay8yMDIwLUphbnVhcnkvMDI2NDE1Lmh0bWwNCg0K
U2lnbmVkLW9mZi1ieTogeW9uZy5saWFuZyA8eW9uZy5saWFuZ0BtZWRpYXRlay5jb20+DQotLS0N
CiBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4My5kdHNpIHwgNyArKysrKysrDQog
MSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02
NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVk
aWF0ZWsvbXQ4MTgzLmR0c2kNCmluZGV4IDEwYjMyNDcxYmM3Yi4uOGI1OWUwZWJhMmViIDEwMDY0
NA0KLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaQ0KKysrIGIv
YXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaQ0KQEAgLTI1Myw2ICsyNTMs
MTMgQEANCiAJCQkjaW50ZXJydXB0LWNlbGxzID0gPDI+Ow0KIAkJfTsNCiANCisJCXdhdGNoZG9n
OiB3YXRjaGRvZ0AxMDAwNzAwMCB7DQorCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMt
d2R0IiwNCisJCQkJICAgICAibWVkaWF0ZWssbXQ2NTg5LXdkdCI7DQorCQkJcmVnID0gPDAgMHgx
MDAwNzAwMCAwIDB4MTAwPjsNCisJCQkjcmVzZXQtY2VsbHMgPSA8MT47DQorCQl9Ow0KKw0KIAkJ
YXBtaXhlZHN5czogc3lzY29uQDEwMDBjMDAwIHsNCiAJCQljb21wYXRpYmxlID0gIm1lZGlhdGVr
LG10ODE4My1hcG1peGVkc3lzIiwgInN5c2NvbiI7DQogCQkJcmVnID0gPDAgMHgxMDAwYzAwMCAw
IDB4MTAwMD47DQotLSANCjIuMTguMA0K

