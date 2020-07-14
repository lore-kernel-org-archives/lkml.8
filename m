Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DC4C433EA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FFA8221FD
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YQ/3xTav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgGNJyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:54:13 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:23734 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725997AbgGNJyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:54:11 -0400
X-UUID: 4666040cc9074353b46bbc01f3425efe-20200714
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=dMebhq5tR/KQ7hMcnV9SdRoVU+Z7gUzMSXG15eF6Tvk=;
        b=YQ/3xTav2uGQbQ6DgGj5UWPba8V0432KvxBi0Lc49EZyzSyH37JMkTrk1n9b2b3UPzwH05hTItVO+fOzou5ft5Pw9KfPk5dp83cp8PU2mllF2CzP80k+qBWRmndQlvD0N0UnM063m7Srwi0Y7v+W5WVa7YyBjbq2NTePGfHae4Q=;
X-UUID: 4666040cc9074353b46bbc01f3425efe-20200714
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2055831850; Tue, 14 Jul 2020 17:54:08 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH 2/3] dt-bindings: mediatek: add compatible for MT6873/8192 pwrap
Date:   Tue, 14 Jul 2020 17:53:51 +0800
Message-ID: <1594720432-19586-3-git-send-email-hsin-hsiung.wang@mediatek.com>
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

VGhpcyBhZGRzIGR0LWJpbmRpbmcgZG9jdW1lbnRhdGlvbiBvZiBwd3JhcCBmb3IgTWVkaWF0ZWsg
TVQ2ODczLzgxOTINClNvQ3MgUGxhdGZvcm0uDQoNClNpZ25lZC1vZmYtYnk6IEhzaW4tSHNpdW5n
IFdhbmcgPGhzaW4taHNpdW5nLndhbmdAbWVkaWF0ZWsuY29tPg0KLS0tDQogRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9wd3JhcC50eHQgfCAxICsNCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvcHdyYXAudHh0IGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9wd3JhcC50eHQNCmluZGV4IGVjYWMy
YmIuLjgwNTFjMTcgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3Mvc29jL21lZGlhdGVrL3B3cmFwLnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3NvYy9tZWRpYXRlay9wd3JhcC50eHQNCkBAIC0yMiw2ICsyMiw3IEBAIFJlcXVp
cmVkIHByb3BlcnRpZXMgaW4gcHdyYXAgZGV2aWNlIG5vZGUuDQogCSJtZWRpYXRlayxtdDY3NjUt
cHdyYXAiIGZvciBNVDY3NjUgU29Dcw0KIAkibWVkaWF0ZWssbXQ2Nzc5LXB3cmFwIiBmb3IgTVQ2
Nzc5IFNvQ3MNCiAJIm1lZGlhdGVrLG10Njc5Ny1wd3JhcCIgZm9yIE1UNjc5NyBTb0NzDQorCSJt
ZWRpYXRlayxtdDY4NzMtcHdyYXAiIGZvciBNVDY4NzMvODE5MiBTb0NzDQogCSJtZWRpYXRlayxt
dDc2MjItcHdyYXAiIGZvciBNVDc2MjIgU29Dcw0KIAkibWVkaWF0ZWssbXQ4MTM1LXB3cmFwIiBm
b3IgTVQ4MTM1IFNvQ3MNCiAJIm1lZGlhdGVrLG10ODE3My1wd3JhcCIgZm9yIE1UODE3MyBTb0Nz
DQotLSANCjIuNi40DQo=

