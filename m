Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C60EC433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C813820714
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CJ2E0eL0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgG1KQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:16:26 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:28087 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728711AbgG1KQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:16:24 -0400
X-UUID: 79b8673d867148d9b7fb4e02fdeab622-20200728
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=k9muKPyZDqBZfxd+zXdTzvxlhvvct36d5hwul+hcVtQ=;
        b=CJ2E0eL0QJ36mzyFJqKVMMrzmUGjZKenJ7Zd0GJ4c/HJmDv1Gmav9v90hOWSN3S00t/YJWNbwRd19PFOeqn8N/ExF/H8R0k/BuViFpYrM87Qd6ZWfxdrhNjxfizoCPp4zqZlW3LW642uupp4XcD8rKq3Bg1+h/H47HeQexUTLsI=;
X-UUID: 79b8673d867148d9b7fb4e02fdeab622-20200728
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <freddy.hsin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 462996204; Tue, 28 Jul 2020 18:16:20 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 28 Jul 2020 18:16:17 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 28 Jul 2020 18:16:17 +0800
From:   Freddy Hsin <freddy.hsin@mediatek.com>
To:     <linux-mediatek@lists.infradead.or>,
        <linux-arm-kernel@lists.infradead.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Saravana Kannan <saravanak@google.com>,
        <linux-kernel@vger.kernel.org>, <chang-an.chen@mediatek.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        <wsd_upstream@mediatek.com>, <kuohong.wang@mediatek.com>,
        <stanley.chu@mediatek.com>
Subject: [PATCH v1] Porting Mediatek timer driver to kernel module 
Date:   Tue, 28 Jul 2020 18:16:15 +0800
Message-ID: <1595931377-21627-1-git-send-email-freddy.hsin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UG9ydGluZyBNZWRpYXRlayB0aW1lciBkcml2ZXIgdG8ga2VybmVsIG1vZHVsZSBmb3IgR0tJDQoo
R2VuZXJpYyBLZXJuZWwgSW1hZ2UpLiBDbG9ja3NvdXJjZSBtbWlvIGZ1bmN0aW9ucyBhcmUNCmV4
cG9ydGVkIGZvciBNZWRpYXRlayB0aW1lciBpbml0IGZ1bmN0aW9uLg0KDQpUaGlzIHBhdGNoIGRl
cGVuZHMgb24gdGhlIHRpbWVyLW9mIHBhdGNoIHN1Ym1pdHRlZCBieSBCYW9saW4gV2FuZw0KaHR0
cHM6Ly9sa21sLm9yZy9sa21sLzIwMjAvMy8yNC83Mg0KDQoNCkZyZWRkeSBIc2luICgyKToNCiAg
a2VybmVsOiB0aW1lOiByZW1vdmUgaW5pdCBzZWN0aW9uIGxhYmVsIG9mIHNjaGVkX2Nsb2NrX3Jl
Z2lzdGVyDQogIHRpbWVyOiBtdDY4NzM6IHBvcnRpbmcgdGltZXIgZHJpdmVyIHRvIGxvYWRhYmxl
IG1vZHVsZQ0KDQogZHJpdmVycy9jbG9ja3NvdXJjZS9LY29uZmlnICAgICAgICAgIHwgICAgMiAr
LQ0KIGRyaXZlcnMvY2xvY2tzb3VyY2UvbW1pby5jICAgICAgICAgICB8ICAgIDQgKysrLQ0KIGRy
aXZlcnMvY2xvY2tzb3VyY2UvdGltZXItbWVkaWF0ZWsuYyB8ICAgMzkgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KIGtlcm5lbC90aW1lL3NjaGVkX2Nsb2NrLmMgICAgICAgICAg
ICB8ICAgIDEgKw==

