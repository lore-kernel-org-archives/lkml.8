Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5854BC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086CE22522
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NKSCsxDy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbgAUKsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:48:08 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:5502 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728792AbgAUKsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:48:07 -0500
X-UUID: 7e1ae8c026604aa78f3c52e97c15b4b8-20200121
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=nrD/+39k4zqN28HCQYUHnInVNtyVGduO5k2QMQrSOxw=;
        b=NKSCsxDy5MGyyxduMGB+olbe8/Rdjgb14wWL1dVqazsDql7+x5fRZih0udfkd/mlB3JDPqhSvBm2s8onF40uWloI9AgtFu8dXhFJcKdDCT53hymlA0Ge0CzO+J3sUdJqnso8LvAfMydueyXCStdV7bD1KYJ8kTVCBzvpTrnkGtQ=;
X-UUID: 7e1ae8c026604aa78f3c52e97c15b4b8-20200121
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1620369439; Tue, 21 Jan 2020 18:48:00 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 21 Jan 2020 18:48:50 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 21 Jan 2020 18:46:44 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Min.Guo@mediatek.com>, <Chunfeng.Yun@mediatek.com>
CC:     Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] usb: musb: tusb6010: fix a possible missing data type replacement
Date:   Tue, 21 Jan 2020 18:47:50 +0800
Message-ID: <1579603670-10970-1-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmVwbGFjZSAidW5zaWduZWQiIHRvICJ1MzIiIGZvciBjaGVja3BhdGNoIGZpeCB0byB0dXNiX3dy
aXRlYigpLg0KDQpTaWduZWQtb2ZmLWJ5OiBNYWNwYXVsIExpbiA8bWFjcGF1bC5saW5AbWVkaWF0
ZWsuY29tPg0KLS0tDQogZHJpdmVycy91c2IvbXVzYi90dXNiNjAxMC5jIHwgMiArLQ0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvbXVzYi90dXNiNjAxMC5jIGIvZHJpdmVycy91c2IvbXVzYi90dXNiNjAxMC5j
DQppbmRleCA1ZDQ0OTA4OWUzYWQuLjk5ODkwZDFiYmZjYiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
dXNiL211c2IvdHVzYjYwMTAuYw0KKysrIGIvZHJpdmVycy91c2IvbXVzYi90dXNiNjAxMC5jDQpA
QCAtMTU2LDcgKzE1Niw3IEBAIHN0YXRpYyB1OCB0dXNiX3JlYWRiKHZvaWQgX19pb21lbSAqYWRk
ciwgdTMyIG9mZnNldCkNCiAJcmV0dXJuIHZhbDsNCiB9DQogDQotc3RhdGljIHZvaWQgdHVzYl93
cml0ZWIodm9pZCBfX2lvbWVtICphZGRyLCB1bnNpZ25lZCBvZmZzZXQsIHU4IGRhdGEpDQorc3Rh
dGljIHZvaWQgdHVzYl93cml0ZWIodm9pZCBfX2lvbWVtICphZGRyLCB1MzIgb2Zmc2V0LCB1OCBk
YXRhKQ0KIHsNCiAJdTE2IHRtcDsNCiANCi0tIA0KMi4xOC4wDQo=

