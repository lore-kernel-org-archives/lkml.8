Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDB7C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61AF321D7D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="l0QPdh0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgGNJyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:54:18 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:23625 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726545AbgGNJyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:54:12 -0400
X-UUID: 317a6a9d405e4a8ca6a67bf8b1b1f0eb-20200714
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=xiCp+OBjegRdQn5GWMKIY6rpngUfMrca0NKfJdPGP8M=;
        b=l0QPdh0CVRGMhELGGFyAzYk/NXa8si0+gKisDxAnGpS3P4fZwhhkE2bKJQlz/wDqXUGDOtYE2QcJIMTdzC0Qjia+fcNDLuoip/brl5r9+xC9wOcBQ5TcE8vfH52Au50QLm7wJVtWXsRBm4g/bZiUjfmdFZWkHfSq/cC5W1q0V6Q=;
X-UUID: 317a6a9d405e4a8ca6a67bf8b1b1f0eb-20200714
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1505717196; Tue, 14 Jul 2020 17:54:07 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Jul 2020 17:54:04 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Jul 2020 17:54:06 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Argus Lin <argus.lin@mediatek.com>
CC:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH 0/3] Add PMIC wrapper support for Mediatek MT6873/8192 SoC IC
Date:   Tue, 14 Jul 2020 17:53:49 +0800
Message-ID: <1594720432-19586-1-git-send-email-hsin-hsiung.wang@mediatek.com>
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
bWljLXdyYXAgZHJpdmVyLg0KDQpIc2luLUhzaXVuZyBXYW5nICgzKToNCiAgc29jOiBtZWRpYXRl
azogcHdyYXA6IHVzZSBCSVQoKSBtYWNybw0KICBkdC1iaW5kaW5nczogbWVkaWF0ZWs6IGFkZCBj
b21wYXRpYmxlIGZvciBNVDY4NzMvODE5MiBwd3JhcA0KICBzb2M6IG1lZGlhdGVrOiBwd3JhcDog
YWRkIHB3cmFwIGRyaXZlciBmb3IgTVQ2ODczLzgxOTIgU29Dcw0KDQogLi4uL2RldmljZXRyZWUv
YmluZGluZ3Mvc29jL21lZGlhdGVrL3B3cmFwLnR4dCAgICAgfCAgIDEgKw0KIGRyaXZlcnMvc29j
L21lZGlhdGVrL210ay1wbWljLXdyYXAuYyAgICAgICAgICAgICAgIHwgMTAyICsrKysrKysrKysr
KysrKysrKy0tLQ0KIDIgZmlsZXMgY2hhbmdlZCwgOTAgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRp
b25zKC0pDQoNCi0tIA0KMi42LjQNCg==

