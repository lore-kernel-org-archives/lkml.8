Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD22C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 03:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CE322087D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 03:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="U2fujxzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgHQDEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 23:04:43 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:30617 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726424AbgHQDEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 23:04:42 -0400
X-UUID: 10613096b3cf44528ce0a95538465e74-20200817
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=2z0RtoXOILn4N4IkKnkfphbCO4iJTa65Gx/fuN7b5FE=;
        b=U2fujxznu0nP4YK5Ob+w8kaMWpON9iHmgJaHPPPTgRzRUzNai9dsuzORSU34+X0YL7IE3tW6c7Fv1HmozwTUGE+QJwTJRSk4sP2ne3UcTx29EE7/+vDzQxpzuNaa3zM3ZgBNaYRSMibPT1taEjRuGbSQXp3mPSFHZWlN3Yrqe7Q=;
X-UUID: 10613096b3cf44528ce0a95538465e74-20200817
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2128854509; Mon, 17 Aug 2020 11:04:40 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 17 Aug 2020 11:04:38 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 17 Aug 2020 11:04:37 +0800
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <s-anna@ti.com>, <afd@ti.com>, <seiya.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <fan.chen@mediatek.com>, <yong.liang@mediatek.com>
Subject: [v4,0/4] introduce TI reset controller for MT8192 SoC
Date:   Mon, 17 Aug 2020 11:03:20 +0800
Message-ID: <20200817030324.5690-1-crystal.guo@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

djQ6DQpmaXggdHlwb3Mgb24gdjMgY29tbWl0IG1lc3NhZ2UuDQoNCnYzOg0KMS4gcmV2ZXJ0IHYy
IGNoYW5nZXMuDQoyLiBhZGQgJ3Jlc2V0LWR1cmF0aW9uLXVzJyBwcm9wZXJ0eSB0byBkZWNsYXJl
IGEgbWluaW11bSBkZWxheSwNCndoaWNoIG5lZWRzIHRvIGJlIHdhaXRlZCBiZXR3ZWVuIGFzc2Vy
dCBhbmQgZGVhc3NlcnQuDQozLiBhZGQgJ21lZGlhdGVrLGluZnJhLXJlc2V0JyB0byBjb21wYXRp
YmxlLg0KDQoNCnYyIGNoYW5nZXM6DQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNo
LzExNjk3MzcxLw0KMS4gYWRkICdhc3NlcnQtZGVhc3NlcnQtdG9nZXRoZXInIHByb3BlcnR5IHRv
IGludHJvZHVjZSBhIG5ldyByZXNldCBoYW5kbGVyLA0Kd2hpY2ggYWxsb3dzIGRldmljZSB0byBk
byBzZXJpYWxpemVkIGFzc2VydCBhbmQgZGVhc3NlcnQgb3BlcmF0aW9ucyBpbiBhIHNpbmdsZQ0K
c3RlcCBieSAncmVzZXQnIG1ldGhvZC4NCjIuIGFkZCAndXBkYXRlLWZvcmNlJyBwcm9wZXJ0eSB0
byBpbnRyb2R1Y2UgZm9yY2UtdXBkYXRlIG1ldGhvZCwgd2hpY2ggZm9yY2VzDQp0aGUgd3JpdGUg
b3BlcmF0aW9uIGluIGNhc2UgdGhlIHJlYWQgYWxyZWFkeSBoYXBwZW5zIHRvIHJldHVybiB0aGUg
Y29ycmVjdCB2YWx1ZS4NCjMuIGFkZCAnZ2VuZXJpYy1yZXNldCcgdG8gY29tcGF0aWJsZQ0KDQp2
MSBjaGFuZ2VzOg0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMTY5MDUyMy8N
Cmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTE2OTA1MjcvDQoNCkNyeXN0YWwg
R3VvICg0KToNCiAgZHQtYmluZGluZzogcmVzZXQtY29udHJvbGxlcjogdGk6IGFkZCByZXNldC1k
dXJhdGlvbi11cyBwcm9wZXJ0eQ0KICBkdC1iaW5kaW5nOiByZXNldC1jb250cm9sbGVyOiB0aTog
YWRkICdtZWRpYXRlayxpbmZyYS1yZXNldCcgdG8NCiAgICBjb21wYXRpYmxlDQogIHJlc2V0LWNv
bnRyb2xsZXI6IHRpOiBpbnRyb2R1Y2UgYSBuZXcgcmVzZXQgaGFuZGxlcg0KICBhcm02NDogZHRz
OiBtdDgxOTI6IGFkZCBpbmZyYWNmZ19yc3Qgbm9kZQ0KDQogLi4uL2JpbmRpbmdzL3Jlc2V0L3Rp
LXN5c2Nvbi1yZXNldC50eHQgICAgICAgIHwgIDYgKysrKysNCiBhcmNoL2FybTY0L2Jvb3QvZHRz
L21lZGlhdGVrL210ODE5Mi5kdHNpICAgICAgfCAxMSArKysrKysrLQ0KIGRyaXZlcnMvcmVzZXQv
cmVzZXQtdGktc3lzY29uLmMgICAgICAgICAgICAgICB8IDI2ICsrKysrKysrKysrKysrKysrLS0N
CiAzIGZpbGVzIGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCg==

