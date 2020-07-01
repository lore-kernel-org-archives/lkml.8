Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D80C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE2A7206A1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="P+0E0tHn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgGAH0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:26:33 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:41895 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728112AbgGAH0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:26:32 -0400
X-UUID: e3bd05d1bd884da1b261eeae8bff57e9-20200701
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=pjzZi8GsOp/6mOYGzyWkbBVPIScF0UUgCzvv6N1KZXc=;
        b=P+0E0tHnPLTsSsfGgJwRCZlWXf9eYxF6iLgN0uECDqsFcREXXIVVntkSdnU7tOf/n6DoQRlTqh9NWggU5R8GIz9uPGxcGaYt4VsusSrNulhyIMrHl0zo+dGJF8DL3CKPiw2pUDj3hXMxOiIU+/wzROGUvDGa3y3jBdIwhx849Yk=;
X-UUID: e3bd05d1bd884da1b261eeae8bff57e9-20200701
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <wendell.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1068209113; Wed, 01 Jul 2020 15:26:27 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 1 Jul 2020 15:26:24 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 1 Jul 2020 15:26:25 +0800
From:   Wendell Lin <wendell.lin@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        mtk01761 <wendell.lin@mediatek.com>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Subject: [PATCH 1/2] clk: Export clk_register_composite
Date:   Wed, 1 Jul 2020 15:26:21 +0800
Message-ID: <1593588382-19049-2-git-send-email-wendell.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1593588382-19049-1-git-send-email-wendell.lin@mediatek.com>
References: <1593588382-19049-1-git-send-email-wendell.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Y2xrX3JlZ2lzdGVyX2NvbXBvc2l0ZSgpIHdpbGwgYmUgdXNlZCBpbiBtZWRpYXRlaydzDQpjbG9j
ayBrZXJuZWwgbW9kdWxlLCBzbyBleHBvcnQgaXQgdG8gR1BMIG1vZHVsZXMuDQoNClNpZ25lZC1v
ZmYtYnk6IFdlbmRlbGwgTGluIDx3ZW5kZWxsLmxpbkBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2
ZXJzL2Nsay9jbGstY29tcG9zaXRlLmMgfCAgICAxICsNCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2Nsay1jb21wb3NpdGUuYyBiL2Ry
aXZlcnMvY2xrL2Nsay1jb21wb3NpdGUuYw0KaW5kZXggNzM3NmY1Ny4uZmI1Y2I0YSAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvY2xrL2Nsay1jb21wb3NpdGUuYw0KKysrIGIvZHJpdmVycy9jbGsvY2xr
LWNvbXBvc2l0ZS5jDQpAQCAtMzYwLDYgKzM2MCw3IEBAIHN0cnVjdCBjbGsgKmNsa19yZWdpc3Rl
cl9jb21wb3NpdGUoc3RydWN0IGRldmljZSAqZGV2LCBjb25zdCBjaGFyICpuYW1lLA0KIAkJcmV0
dXJuIEVSUl9DQVNUKGh3KTsNCiAJcmV0dXJuIGh3LT5jbGs7DQogfQ0KK0VYUE9SVF9TWU1CT0wo
Y2xrX3JlZ2lzdGVyX2NvbXBvc2l0ZSk7DQogDQogc3RydWN0IGNsayAqY2xrX3JlZ2lzdGVyX2Nv
bXBvc2l0ZV9wZGF0YShzdHJ1Y3QgZGV2aWNlICpkZXYsIGNvbnN0IGNoYXIgKm5hbWUsDQogCQkJ
Y29uc3Qgc3RydWN0IGNsa19wYXJlbnRfZGF0YSAqcGFyZW50X2RhdGEsDQotLSANCjEuNy45LjUN
Cg==

