Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDD4C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EC5A206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MxWeYRK1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387781AbgGWDkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 23:40:22 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:13231 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729401AbgGWDkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 23:40:22 -0400
X-UUID: 31fb2f3793914a77a8078d2faa36c60a-20200723
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ZbWETBCEtkhObmiJkYGQX/vsgV+SlSvzPQ6IFNLuifQ=;
        b=MxWeYRK1rkv6h/Ves7Zbh+BEt2IxL+b/1k13wyOEpdcm2cIzPFdt+1h7b+bzviSVI0ijQMoHgoNsTvgaD4QZT6bdASWN6bfYRLLZUIWnxeRxBDnu9pWFlFrQXddH8CAl4taxYOBURRjYsM9kg5ndEeGwvRVzIaEdfFy//jGiclE=;
X-UUID: 31fb2f3793914a77a8078d2faa36c60a-20200723
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1356488543; Thu, 23 Jul 2020 11:40:19 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Jul 2020 11:40:17 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Jul 2020 11:40:15 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Argus Lin <argus.lin@mediatek.com>
CC:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Subject: [PATCH v2 0/4] Add PMIC wrapper support for Mediatek MT6873/8192 SoC IC
Date:   Thu, 23 Jul 2020 11:39:56 +0800
Message-ID: <1595475600-23180-1-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBzZXJpZXMgYWRkcyBzdXBwb3J0IGZvciBuZXcgU29DIE1UNjg3My84MTkyIHRvIHRoZSBw
bWljLXdyYXAgZHJpdmVyLg0KDQpjaGFuZ2VzIHNpbmNlIHYxOg0KLSBzZXBhcmF0ZSBQV1JBUF9D
QVBfQVJCIHRvIGEgbmV3IHBhdGNoLg0KDQpIc2luLUhzaXVuZyBXYW5nICg0KToNCiAgc29jOiBt
ZWRpYXRlazogcHdyYXA6IHVzZSBCSVQoKSBtYWNybw0KICBzb2M6IG1lZGlhdGVrOiBwd3JhcDog
YWRkIGFyYml0ZXIgY2FwYWJpbGl0eQ0KICBkdC1iaW5kaW5nczogbWVkaWF0ZWs6IGFkZCBjb21w
YXRpYmxlIGZvciBNVDY4NzMvODE5MiBwd3JhcA0KICBzb2M6IG1lZGlhdGVrOiBwd3JhcDogYWRk
IHB3cmFwIGRyaXZlciBmb3IgTVQ2ODczLzgxOTIgU29Dcw0KDQogLi4uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc29jL21lZGlhdGVrL3B3cmFwLnR4dCAgICAgfCAgIDEgKw0KIGRyaXZlcnMvc29jL21l
ZGlhdGVrL210ay1wbWljLXdyYXAuYyAgICAgICAgICAgICAgIHwgMTAwICsrKysrKysrKysrKysr
KysrKy0tLQ0KIDIgZmlsZXMgY2hhbmdlZCwgODggaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25z
KC0pDQoNCi0tIA0KMi42LjQNCg==

