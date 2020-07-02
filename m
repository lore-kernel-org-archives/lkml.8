Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA044C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78DCF20760
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Iy7dgZr9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgGBJha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 05:37:30 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:60431 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728173AbgGBJh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 05:37:28 -0400
X-UUID: db28042b07244017933c06de660cbfb4-20200702
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=hARrGPzXfIlQJmdtvnD1T2dZjIRMUTbWg4IXe9GBIK0=;
        b=Iy7dgZr9zwoBgjEScIT2aJlObAT/W47O9jH1ZUiyeKiZtaSOOWLn0C4ustJCO46qLnuZw+fYtsG3niEkZVrPS6p3JCpCYZgkCy55wHuzCAMVaVu0uJYoezTKdk4r+zHN9HbAiO+afWjnbRLVS+Cur0vW0vuOZLOgTTmfj8L3CRs=;
X-UUID: db28042b07244017933c06de660cbfb4-20200702
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1898905698; Thu, 02 Jul 2020 17:37:23 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 2 Jul 2020 17:37:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Jul 2020 17:37:20 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [PATCH 2/4] arm64: dts: mt2712: add mediatek,infracfg to iommu
Date:   Thu, 2 Jul 2020 17:37:18 +0800
Message-ID: <20200702093721.6063-2-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200702093721.6063-1-miles.chen@mediatek.com>
References: <20200702093721.6063-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIG1lZGlhdGVrLGluZnJhY2ZnIHRvIGlvbW11IG5vZGUuDQoNClNpZ25lZC1vZmYtYnk6IE1p
bGVzIENoZW4gPG1pbGVzLmNoZW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogYXJjaC9hcm02NC9ib290
L2R0cy9tZWRpYXRlay9tdDI3MTJlLmR0c2kgfCAxICsNCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQy
NzEyZS5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDI3MTJlLmR0c2kNCmlu
ZGV4IGRiMTdkMGE0ZWQ1Ny4uMDc0OWIwZjQ4MzRjIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm02NC9i
b290L2R0cy9tZWRpYXRlay9tdDI3MTJlLmR0c2kNCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMv
bWVkaWF0ZWsvbXQyNzEyZS5kdHNpDQpAQCAtMzMxLDYgKzMzMSw3IEBADQogCQljbG9jay1uYW1l
cyA9ICJiY2xrIjsNCiAJCW1lZGlhdGVrLGxhcmJzID0gPCZsYXJiMCAmbGFyYjEgJmxhcmIyDQog
CQkJCSAgJmxhcmIzICZsYXJiNj47DQorCQltZWRpYXRlayxpbmZyYWNmZyA9IDwmaW5mcmFjZmc+
Ow0KIAkJI2lvbW11LWNlbGxzID0gPDE+Ow0KIAl9Ow0KIA0KLS0gDQoyLjE4LjANCg==

