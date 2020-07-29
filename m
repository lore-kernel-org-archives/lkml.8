Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD18C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E299420809
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="e/sLIATz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgG2Hjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 03:39:52 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:37634 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726290AbgG2Hjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 03:39:51 -0400
X-UUID: 700611f5285945a7aad4c10411b29e77-20200729
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=BAzzGPnATd/QF6uwaKKNFf1HLANzxr4fsUKdT6hn41E=;
        b=e/sLIATztxhhbPyi8+pFqwk1LXK4Rn2nYe5w7muboFS6U2rr2wBgDPpK3LR2gFDVY2v2FErS7EoZyVmha3Wt++0t4X2I3gqYmVRpvJdLMa+80jkcciPEg7tSnva3yXu2zx9quUVSQHUb5WV0M92CoO4l9ZZBF8qum4GaLHdRiHI=;
X-UUID: 700611f5285945a7aad4c10411b29e77-20200729
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1438535055; Wed, 29 Jul 2020 15:39:47 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 29 Jul 2020 15:39:45 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 29 Jul 2020 15:39:46 +0800
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <seiya.wang@mediatek.com>, Crystal Guo <crystal.guo@mediatek.com>
Subject: [PATCH 2/2] arm64: dts: mt8192: add infracfg_rst node
Date:   Wed, 29 Jul 2020 15:39:17 +0800
Message-ID: <1596008357-11213-3-git-send-email-crystal.guo@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1596008357-11213-1-git-send-email-crystal.guo@mediatek.com>
References: <1596008357-11213-1-git-send-email-crystal.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YWRkIGluZnJhY2ZnX3JzdCBub2RlIHdoaWNoIGlzIGZvciBNVDgxOTIgcGxhdGZvcm0NCg0KU2ln
bmVkLW9mZi1ieTogQ3J5c3RhbCBHdW8gPGNyeXN0YWwuZ3VvQG1lZGlhdGVrLmNvbT4NCi0tLQ0K
IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTkyLmR0c2kgfCAxMCArKysrKysrKyst
DQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZm
IC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTIuZHRzaSBiL2FyY2gv
YXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTkyLmR0c2kNCmluZGV4IGIxNmRiYmQuLmFkYzYy
MzkgMTAwNjQ0DQotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi5kdHNp
DQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi5kdHNpDQpAQCAtMjE3
LDkgKzIxNywxNyBAQA0KIAkJfTsNCiANCiAJCWluZnJhY2ZnOiBpbmZyYWNmZ0AxMDAwMTAwMCB7
DQotCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTItaW5mcmFjZmciLCAic3lzY29uIjsN
CisJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5Mi1pbmZyYWNmZyIsICJzeXNjb24iLCAi
c2ltcGxlLW1mZCI7DQogCQkJcmVnID0gPDAgMHgxMDAwMTAwMCAwIDB4MTAwMD47DQogCQkJI2Ns
b2NrLWNlbGxzID0gPDE+Ow0KKw0KKwkJCWluZnJhY2ZnX3JzdDogcmVzZXQtY29udHJvbGxlciB7
DQorCQkJCWNvbXBhdGlibGUgPSAidGksc3lzY29uLXJlc2V0IjsNCisJCQkJI3Jlc2V0LWNlbGxz
ID0gPDE+Ow0KKwkJCQl0aSxyZXNldC1iaXRzID0gPA0KKwkJCQkJMHgxNDAgMTUgMHgxNDQgMTUg
MCAwIChBU1NFUlRfU0VUIHwgREVBU1NFUlRfU0VUIHwgU1RBVFVTX05PTkUpIC8qIDA6IHBjaWUg
Ki8NCisJCQkJPjsNCisJCQl9Ow0KIAkJfTsNCiANCiAJCXBlcmljZmc6IHBlcmljZmdAMTAwMDMw
MDAgew0KLS0gDQoxLjguMS4xLmRpcnR5DQo=

