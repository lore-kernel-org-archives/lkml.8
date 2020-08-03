Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E03C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 06:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C10402067D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 06:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qH73Jgme"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgHCGRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 02:17:11 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48273 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725831AbgHCGRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 02:17:11 -0400
X-UUID: efcf9d132f214aa6bd25bee79f80de3e-20200803
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=AxpoOF2EVqGDrkSgJE/mVxWLigpKfOKa6+0MTFuhn4E=;
        b=qH73JgmevQF06n41to3tw+3EOSCUUtU5t1F3atsir4Kwa3q3ZLt7JQDqNPsGGRIwoTkYUMP28zvdMcbRd3NS5eu1bnjmLuboHMDGgS+2IFGREpBjD5aqDHuOHgeZ6GJijkkIJP0Fjd3m859y9BwYfKpJzNq9dD1lfxdAED0b030=;
X-UUID: efcf9d132f214aa6bd25bee79f80de3e-20200803
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1838103932; Mon, 03 Aug 2020 14:17:07 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 3 Aug 2020 14:17:05 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 3 Aug 2020 14:17:06 +0800
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <seiya.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <fan.chen@mediatek.com>, <yong.liang@mediatek.com>
Subject: [v2,0/6] introduce TI reset controller for MT8192 SoC 
Date:   Mon, 3 Aug 2020 14:15:05 +0800
Message-ID: <20200803061511.29555-1-crystal.guo@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

djEgY2hhbmdlczoNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTE2OTA1MjMv
DQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzExNjkwNTI3Lw0KDQpDcnlzdGFs
IEd1byAoNik6DQogIGR0LWJpbmRpbmc6IHJlc2V0LWNvbnRyb2xsZXI6IHRpOiBhZGQgYXNzZXJ0
LWRlYXNzZXJ0LXRvZ2V0aGVyDQogICAgcHJvcGVydHkNCiAgZHQtYmluZGluZzogcmVzZXQtY29u
dHJvbGxlcjogdGk6IGFkZCB1cGRhdGUtZm9yY2UgcHJvcGVydHkNCiAgZHQtYmluZGluZzogcmVz
ZXQtY29udHJvbGxlcjogdGk6IGFkZCBnZW5lcmljLXJlc2V0IHRvIGNvbXBhdGlibGUNCiAgcmVz
ZXQtY29udHJvbGxlcjogdGk6IGludHJvZHVjZSBhIG5ldyByZXNldCBoYW5kbGVyDQogIHJlc2V0
LWNvbnRyb2xsZXI6IHRpOiBJbnRyb2R1Y2UgZm9yY2UtdXBkYXRlIG1ldGhvZA0KICBhcm02NDog
ZHRzOiBtdDgxOTI6IGFkZCBpbmZyYWNmZ19yc3Qgbm9kZQ0KDQogLi4uL2JpbmRpbmdzL3Jlc2V0
L3RpLXN5c2Nvbi1yZXNldC50eHQgICAgICAgIHwgIDUgKysrDQogYXJjaC9hcm02NC9ib290L2R0
cy9tZWRpYXRlay9tdDgxOTIuZHRzaSAgICAgIHwgMTMgKysrKysrLQ0KIGRyaXZlcnMvcmVzZXQv
cmVzZXQtdGktc3lzY29uLmMgICAgICAgICAgICAgICB8IDM1ICsrKysrKysrKysrKysrKysrLS0N
CiAzIGZpbGVzIGNoYW5nZWQsIDUwIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCg==

