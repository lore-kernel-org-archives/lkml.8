Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D62AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27D2D221FD
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SQaNxhAz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgGNJyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:54:16 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:23734 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726722AbgGNJyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:54:12 -0400
X-UUID: a282b83df6134ad08d53aa9e9a2058d4-20200714
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=fpzOG0X71zzG1KUuoZmURiigMLk58k6qDYDOQDvWkFE=;
        b=SQaNxhAzyeLt1rDu2GiX84d5kKecPvViNj2VJbUduvDByyXa2SZ2CHad4u5qL3aJVNSlKqVtlhe9NdQYKxjXfLodvjvqptCOgvYF1wUACB8TKs9qv7JM/34E0xJ0IEkk6n/pZbxEjQnwlzvfiS3rnS78l4BfY3iPhCd8SbV6V7k=;
X-UUID: a282b83df6134ad08d53aa9e9a2058d4-20200714
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1600075058; Tue, 14 Jul 2020 17:54:08 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Jul 2020 17:54:05 +0800
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
Subject: [PATCH 1/3] soc: mediatek: pwrap: use BIT() macro
Date:   Tue, 14 Jul 2020 17:53:50 +0800
Message-ID: <1594720432-19586-2-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1594720432-19586-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1594720432-19586-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIGEgYmV0dGVyIEJJVCgpIG1hcmNvIGZvciB0aGUgYml0IGRlZmluaXRpb24uDQpObyBmdW5j
dGlvbmFsIGNoYW5nZXMsIGNsZWFudXAgb25seS4NCg0KU2lnbmVkLW9mZi1ieTogSHNpbi1Ic2l1
bmcgV2FuZyA8aHNpbi1oc2l1bmcud2FuZ0BtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3Nv
Yy9tZWRpYXRlay9tdGstcG1pYy13cmFwLmMgfCA0ICsrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2Mv
bWVkaWF0ZWsvbXRrLXBtaWMtd3JhcC5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXBtaWMt
d3JhcC5jDQppbmRleCA1ZDM0ZThiLi5jODk3MjA1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zb2Mv
bWVkaWF0ZWsvbXRrLXBtaWMtd3JhcC5jDQorKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGst
cG1pYy13cmFwLmMNCkBAIC0yNyw4ICsyNyw4IEBADQogI2RlZmluZSBQV1JBUF9HRVRfV0FDU19S
REFUQSh4KQkJKCgoeCkgPj4gMCkgJiAweDAwMDBmZmZmKQ0KICNkZWZpbmUgUFdSQVBfR0VUX1dB
Q1NfRlNNKHgpCQkoKCh4KSA+PiAxNikgJiAweDAwMDAwMDA3KQ0KICNkZWZpbmUgUFdSQVBfR0VU
X1dBQ1NfUkVRKHgpCQkoKCh4KSA+PiAxOSkgJiAweDAwMDAwMDAxKQ0KLSNkZWZpbmUgUFdSQVBf
U1RBVEVfU1lOQ19JRExFMAkJKDEgPDwgMjApDQotI2RlZmluZSBQV1JBUF9TVEFURV9JTklUX0RP
TkUwCQkoMSA8PCAyMSkNCisjZGVmaW5lIFBXUkFQX1NUQVRFX1NZTkNfSURMRTAJCUJJVCgyMCkN
CisjZGVmaW5lIFBXUkFQX1NUQVRFX0lOSVRfRE9ORTAJCUJJVCgyMSkNCiANCiAvKiBtYWNybyBm
b3IgV0FDUyBGU00gKi8NCiAjZGVmaW5lIFBXUkFQX1dBQ1NfRlNNX0lETEUJCTB4MDANCi0tIA0K
Mi42LjQNCg==

