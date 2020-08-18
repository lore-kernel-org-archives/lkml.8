Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F11C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 03:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB29F2078E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 03:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="K5xJN0/F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgHRDEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 23:04:15 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:43711 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726582AbgHRDEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 23:04:11 -0400
X-UUID: 618ab5a220d248e8ade346bd00d58f67-20200818
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ddJenZYkqw0WgyewrMTDBvePI1A8zbqjCPPEEEH5/Dc=;
        b=K5xJN0/Fv5keQnuKKh7XMAP6QNTLOZ/yn4v2rLU+YX3XDAqAFfyEAnhVohAn0vJeLK/2VDp2ZTQ1ZRaKEkH0EF7JJ6TIv/pvsF3GPeSLk+gHIM0KZybY78PmD6Ina38ZVR5JDeKcJS9AlGEEwNDjm60pvpB+1xXA3GH71MDhq4k=;
X-UUID: 618ab5a220d248e8ade346bd00d58f67-20200818
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <eastl.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 600597630; Tue, 18 Aug 2020 11:04:06 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 18 Aug 2020 11:04:03 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 18 Aug 2020 11:04:03 +0800
From:   EastL Lee <EastL.Lee@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
CC:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <cc.hwang@mediatek.com>,
        EastL Lee <EastL.Lee@mediatek.com>
Subject: [PATCH v7 4/4] dmaengine: mediatek-cqdma: fix compatible
Date:   Tue, 18 Aug 2020 11:03:54 +0800
Message-ID: <1597719834-6675-5-git-send-email-EastL.Lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1597719834-6675-1-git-send-email-EastL.Lee@mediatek.com>
References: <1597719834-6675-1-git-send-email-EastL.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: ECDA5C1B6B0E7CD570170718E736B4B0A83837A13B57DECF133A8114A2B90B532000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGRzIG10Njc3OSBjb21wYXRpYmxlLg0KDQpTaWduZWQtb2ZmLWJ5OiBFYXN0
TCBMZWUgPEVhc3RMLkxlZUBtZWRpYXRlay5jb20+DQpSZXZpZXdlZC1ieTogTWF0dGhpYXMgQnJ1
Z2dlciA8bWF0dGhpYXMuYmdnQGdtYWlsLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZG1hL21lZGlhdGVr
L210ay1jcWRtYS5jIHwgMSArDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9tZWRpYXRlay9tdGstY3FkbWEuYyBiL2RyaXZlcnMvZG1h
L21lZGlhdGVrL210ay1jcWRtYS5jDQppbmRleCAxNjEwNjMyLi4xN2IzYWI5IDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9kbWEvbWVkaWF0ZWsvbXRrLWNxZG1hLmMNCisrKyBiL2RyaXZlcnMvZG1hL21l
ZGlhdGVrL210ay1jcWRtYS5jDQpAQCAtNTQ3LDYgKzU0Nyw3IEBAIHN0YXRpYyB2b2lkIG10a19j
cWRtYV9od19kZWluaXQoc3RydWN0IG10a19jcWRtYV9kZXZpY2UgKmNxZG1hKQ0KIA0KIHN0YXRp
YyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19jcWRtYV9tYXRjaFtdID0gew0KIAl7IC5j
b21wYXRpYmxlID0gIm1lZGlhdGVrLG10Njc2NS1jcWRtYSIgfSwNCisJeyAuY29tcGF0aWJsZSA9
ICJtZWRpYXRlayxtdDY3NzktY3FkbWEiIH0sDQogCXsgLyogc2VudGluZWwgKi8gfQ0KIH07DQog
TU9EVUxFX0RFVklDRV9UQUJMRShvZiwgbXRrX2NxZG1hX21hdGNoKTsNCi0tIA0KMS45LjENCg==

