Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E144C3815B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 04:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA37D2082D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 04:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fNbaJMpF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgDJEeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 00:34:14 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:27110 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725830AbgDJEeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 00:34:14 -0400
X-UUID: a3480a9eb0a345a1b31aa15d6eb22c20-20200410
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=oXyxi7IUgBNHR+VYtiCeIx+6ezK7zPDvVd2okeNBTBs=;
        b=fNbaJMpFO/cnuCk/GkyGsyGISC98jzF228UYLBiRljwq00+vnhPW/4UrBpLv5iheq3yBmWst6DRnSV0Ax774YsGgTX4nGozF729mq1J5kfuEBgkBxVdw7H8SjivcvUImlWIsAdpFeo6vZxx94pnp7d35YGZ2WSSfkxzEeDCQeAs=;
X-UUID: a3480a9eb0a345a1b31aa15d6eb22c20-20200410
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 486658226; Fri, 10 Apr 2020 12:32:56 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 10 Apr
 2020 12:32:53 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 10 Apr 2020 12:32:50 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, <huijuan.xie@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH v5 1/4] dt-bindings: display: mediatek: add property to control mipi tx drive current
Date:   Fri, 10 Apr 2020 12:32:45 +0800
Message-ID: <20200410043248.114384-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200410043248.114384-1-jitao.shi@mediatek.com>
References: <20200410043248.114384-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 2F6DC314AAFFE7325705D7A5029BA7AB77B87FFA4ED9EE4DC05F3445E42225E72000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGEgcHJvcGVydHkgdG8gY29udHJvbCBtaXBpIHR4IGRyaXZlIGN1cnJlbnQ6DQoiZHJpdmUt
c3RyZW5ndGgtbWljcm9hbXAiDQoNClJldmlld2VkLWJ5OiBDaHVuLUt1YW5nIEh1IDxjaHVua3Vh
bmcuaHVAa2VybmVsLm9yZz4NClNpZ25lZC1vZmYtYnk6IEppdGFvIFNoaSA8aml0YW8uc2hpQG1l
ZGlhdGVrLmNvbT4NCi0tLQ0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0
ZWsvbWVkaWF0ZWssZHNpLnR4dCAgICB8IDUgKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkc2kudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHNpLnR4dA0KaW5kZXgg
YTE5YTZjYzM3NWVkLi5kNzhiNmQ2ZDhmYWIgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkc2kudHh0DQorKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRp
YXRlayxkc2kudHh0DQpAQCAtMzMsNiArMzMsMTAgQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCiAt
ICNjbG9jay1jZWxsczogbXVzdCBiZSA8MD47DQogLSAjcGh5LWNlbGxzOiBtdXN0IGJlIDwwPi4N
CiANCitPcHRpb25hbCBwcm9wZXJ0aWVzOg0KKy0gZHJpdmUtc3RyZW5ndGgtbWljcm9hbXA6IGFk
anVzdCBkcml2aW5nIGN1cnJlbnQsIHNob3VsZCBiZSAzMDAwIH4gNjAwMC4gQW5kDQorCQkJCQkJ
ICAgdGhlIHN0ZXAgaXMgMjAwLg0KKw0KIEV4YW1wbGU6DQogDQogbWlwaV90eDA6IG1pcGktZHBo
eUAxMDIxNTAwMCB7DQpAQCAtNDIsNiArNDYsNyBAQCBtaXBpX3R4MDogbWlwaS1kcGh5QDEwMjE1
MDAwIHsNCiAJY2xvY2stb3V0cHV0LW5hbWVzID0gIm1pcGlfdHgwX3BsbCI7DQogCSNjbG9jay1j
ZWxscyA9IDwwPjsNCiAJI3BoeS1jZWxscyA9IDwwPjsNCisJZHJpdmUtc3RyZW5ndGgtbWljcm9h
bXAgPSA8NDYwMD47DQogfTsNCiANCiBkc2kwOiBkc2lAMTQwMWIwMDAgew0KLS0gDQoyLjIxLjAN
Cg==

