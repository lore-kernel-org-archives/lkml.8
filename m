Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7501C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5BC1207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EqFirDj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387827AbgGWDka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 23:40:30 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:23959 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387797AbgGWDk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 23:40:29 -0400
X-UUID: d3778d8c9f22499baf90fb023526a554-20200723
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=fpzOG0X71zzG1KUuoZmURiigMLk58k6qDYDOQDvWkFE=;
        b=EqFirDj1Dce3WeR9XXLwwD/eazkx1Dd92tm4JIDRHCRUfEVemc9Gi8UpttI1NfUW45mlHJptNi5IipLEsUvwRYCrsgZOInQ2n0oWV+GwdUJb3zKCty1ch139E2qcWUo5EI4eMbjEUX5LOoCMKR3dSTnx8pSCIOTyrHt5+2JcNSw=;
X-UUID: d3778d8c9f22499baf90fb023526a554-20200723
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 71822816; Thu, 23 Jul 2020 11:40:27 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Jul 2020 11:40:18 +0800
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
Subject: [PATCH v2 1/4] soc: mediatek: pwrap: use BIT() macro
Date:   Thu, 23 Jul 2020 11:39:57 +0800
Message-ID: <1595475600-23180-2-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1595475600-23180-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1595475600-23180-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: BA7D5B9AA0E58B7402DB3CFD803D03AAB5AE9577599C8F9348C208794635BAF22000:8
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

