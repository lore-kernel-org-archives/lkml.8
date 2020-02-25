Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1C0C35DFB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A90D920CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JOArML+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbgBYLtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 06:49:25 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:41281 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729510AbgBYLtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 06:49:25 -0500
X-UUID: 8cd06643e6ac4fb4b42787beafb37981-20200225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=tEuIuqbj8JcbuuArgO1nPH3pErg0cD0oQ9Q5Xkop0Zw=;
        b=JOArML+X7PQWj2lXxm+uN287ND+vJ64UPJKoQFc/pjMgmh7U59L0X8mi3i2F3vM9bvAAs3f2Wvnnn+CyochRzDgPEbaXzTQINNBDVy9C190Z5fVfpEUYLORAHxEPUE7Bmg3SI5M0itJRjolTDtlP2whQRDHmzHLUrYZL9x05YJw=;
X-UUID: 8cd06643e6ac4fb4b42787beafb37981-20200225
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 274965202; Tue, 25 Feb 2020 19:47:38 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 25 Feb
 2020 19:48:12 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Tue, 25 Feb 2020 19:46:16 +0800
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
Subject: [PATCH v2 0/4] Config mipi tx drive current and impedance
Date:   Tue, 25 Feb 2020 19:47:26 +0800
Message-ID: <20200225114730.124939-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: DBA67982F7B2CBA2F3BB6E7444224D083ADD37C79BB3BC4FC5858E737CCE96102000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB2MToNCiAtIGZpeCBjb2Rpbmcgc3R5bGUuDQogLSBjaGFuZ2UgbXRrX21p
cGlfdHhfY29uZmlnX2NhbGlicmF0aW9uX2RhdGEoKSB0byB2b2lkDQoNCkppdGFvIFNoaSAoNCk6
DQogIGR0LWJpbmRzOiBkaXNwbGF5OiBtZWRpYXRlazogYWRkIHByb3BlcnR5IHRvIGNvbnRyb2wg
bWlwaSB0eCBkcml2ZQ0KICAgIGN1cnJlbnQNCiAgZHQtYmluZHM6IGRpc3BsYXk6IG1lZGlhdGVr
OiBnZXQgbWlwaXR4IGNhbGlicmF0aW9uIGRhdGEgZnJvbSBudm1lbQ0KICBkcm0vbWVkaWF0ZWs6
IGFkZCB0aGUgbWlwaXR4IGRyaXZpbmcgY29udHJvbA0KICBkcm0vbWVkaWF0ZWs6IGNvbmZpZyBt
aXBpdHggaW1wZWRhbmNlIHdpdGggY2FsaWJyYXRpb24gZGF0YQ0KDQogLi4uL2Rpc3BsYXkvbWVk
aWF0ZWsvbWVkaWF0ZWssZHNpLnR4dCAgICAgICAgIHwgIDkgKysrDQogZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19taXBpX3R4LmMgICAgICAgIHwgIDYgKysNCiBkcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX21pcGlfdHguaCAgICAgICAgfCAgMSArDQogZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19tdDgxODNfbWlwaV90eC5jIHwgNjQgKysrKysrKysrKysrKysrKysrKw0KIDQg
ZmlsZXMgY2hhbmdlZCwgODAgaW5zZXJ0aW9ucygrKQ0KDQotLSANCjIuMjEuMA0K

