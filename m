Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB92C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A417D207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="C7NIF7eJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbgCaI2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 04:28:49 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:1193 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730130AbgCaI2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 04:28:49 -0400
X-UUID: 27c3a258fd2946e9b20f835d5c37fb9c-20200331
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=VzIh7K8rBDivjUV0LUL5VF+9MBEwJlNgJwsTeiHpaZs=;
        b=C7NIF7eJWf+Ubx/fLw30NZh5tQ4xCYiu43scSmr6eEGCYOc6Gedambjn8XdE1VxS9DHs0vU1xogpY9yPEvDBqPusVJ70N+0wqegLLzdR0d57zAtVOMoee943s9h2Khyibl53w6/vZpud7p+bzBozbwOzaeru33FTSQ4t0igCfBg=;
X-UUID: 27c3a258fd2946e9b20f835d5c37fb9c-20200331
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1153805642; Tue, 31 Mar 2020 16:27:56 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 31 Mar
 2020 16:27:56 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Tue, 31 Mar 2020 16:27:53 +0800
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
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v4 1/4] dt-bindings: display: mediatek: add property to control mipi tx drive current
Date:   Tue, 31 Mar 2020 16:27:22 +0800
Message-ID: <20200331082725.81048-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200331082725.81048-1-jitao.shi@mediatek.com>
References: <20200331082725.81048-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 90AA4ED07D6CA90FC7A1A22ECDF2157AFC8EC43A9C690BF4AF586CB50E8623C62000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGEgcHJvcGVydHkgdG8gY29udHJvbCBtaXBpIHR4IGRyaXZlIGN1cnJlbnQ6DQoiZHJpdmUt
c3RyZW5ndGgtbWljcm9hbXAiDQoNClNpZ25lZC1vZmYtYnk6IEppdGFvIFNoaSA8aml0YW8uc2hp
QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVk
aWF0ZWsvbWVkaWF0ZWssZHNpLnR4dCAgICB8IDUgKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNSBp
bnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkc2kudHh0IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHNpLnR4dA0KaW5k
ZXggYTE5YTZjYzM3NWVkLi5kNzhiNmQ2ZDhmYWIgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkc2kudHh0DQor
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9t
ZWRpYXRlayxkc2kudHh0DQpAQCAtMzMsNiArMzMsMTAgQEAgUmVxdWlyZWQgcHJvcGVydGllczoN
CiAtICNjbG9jay1jZWxsczogbXVzdCBiZSA8MD47DQogLSAjcGh5LWNlbGxzOiBtdXN0IGJlIDww
Pi4NCiANCitPcHRpb25hbCBwcm9wZXJ0aWVzOg0KKy0gZHJpdmUtc3RyZW5ndGgtbWljcm9hbXA6
IGFkanVzdCBkcml2aW5nIGN1cnJlbnQsIHNob3VsZCBiZSAzMDAwIH4gNjAwMC4gQW5kDQorCQkJ
CQkJICAgdGhlIHN0ZXAgaXMgMjAwLg0KKw0KIEV4YW1wbGU6DQogDQogbWlwaV90eDA6IG1pcGkt
ZHBoeUAxMDIxNTAwMCB7DQpAQCAtNDIsNiArNDYsNyBAQCBtaXBpX3R4MDogbWlwaS1kcGh5QDEw
MjE1MDAwIHsNCiAJY2xvY2stb3V0cHV0LW5hbWVzID0gIm1pcGlfdHgwX3BsbCI7DQogCSNjbG9j
ay1jZWxscyA9IDwwPjsNCiAJI3BoeS1jZWxscyA9IDwwPjsNCisJZHJpdmUtc3RyZW5ndGgtbWlj
cm9hbXAgPSA8NDYwMD47DQogfTsNCiANCiBkc2kwOiBkc2lAMTQwMWIwMDAgew0KLS0gDQoyLjIx
LjANCg==

