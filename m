Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3711C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 05:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9616208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 05:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TSRbl2hx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgGUFkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 01:40:40 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:57087 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726236AbgGUFkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 01:40:40 -0400
X-UUID: cc432f4744db4df7b5e4d1b882bf4560-20200721
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=eWGLaIff1b5fkIGfcrTBbKrRw56MLBclARuf7ORFwYI=;
        b=TSRbl2hxl9TchwnuA4LaHCjKDdlTPI1icBpkoGXq114J7G9G7zI6ajJM+SckXX8o0SOI4SebOU1DG21/4tr3csbx34W5bvgFrIhNJ+8QpPsWyvt0cdTRGscSfcSBsrN+4SIbPgxIFs1tR5ENGPx/62dZ0NpYNRgd8NnqZ5QlGT0=;
X-UUID: cc432f4744db4df7b5e4d1b882bf4560-20200721
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <hanks.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 71357364; Tue, 21 Jul 2020 13:40:38 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 21 Jul 2020 13:40:35 +0800
Received: from mtkslt209.mediatek.inc (10.21.15.96) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 21 Jul 2020 13:40:35 +0800
From:   Hanks Chen <hanks.chen@mediatek.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     YueHaibing <yuehaibing@huawei.com>,
        mtk01761 <wendell.lin@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        Hanks Chen <hanks.chen@mediatek.com>
Subject: [PATCH 1/2] dt-bindings: clock: remove UART3 clock support
Date:   Tue, 21 Jul 2020 13:40:32 +0800
Message-ID: <20200721054033.18520-2-hanks.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200721054033.18520-1-hanks.chen@mediatek.com>
References: <20200721054033.18520-1-hanks.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cmVtb3ZlIHRoZSByZWR1bmRhbnQgY2xrIGludGVyZmFjZSBvZiB1YXJ0Lg0KDQpGaXhlczogNzEw
Nzc0ZTA0ODYxICgiY2xrOiBtZWRpYXRlazogQWRkIE1UNjc3OSBjbG9jayBzdXBwb3J0IikNClNp
Z25lZC1vZmYtYnk6IEhhbmtzIENoZW4gPGhhbmtzLmNoZW5AbWVkaWF0ZWsuY29tPg0KLS0tDQog
aW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9tdDY3NzktY2xrLmggfCAxIC0NCiAxIGZpbGUgY2hh
bmdlZCwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kdC1iaW5kaW5ncy9j
bG9jay9tdDY3NzktY2xrLmggYi9pbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL210Njc3OS1jbGsu
aA0KaW5kZXggYjA4MzEzOWFmYmQyLi4yYjVmMjM1NGQ3ZWIgMTAwNjQ0DQotLS0gYS9pbmNsdWRl
L2R0LWJpbmRpbmdzL2Nsb2NrL210Njc3OS1jbGsuaA0KKysrIGIvaW5jbHVkZS9kdC1iaW5kaW5n
cy9jbG9jay9tdDY3NzktY2xrLmgNCkBAIC0yMjksNyArMjI5LDYgQEANCiAjZGVmaW5lIENMS19J
TkZSQV9VQVJUMAkJCTIxDQogI2RlZmluZSBDTEtfSU5GUkFfVUFSVDEJCQkyMg0KICNkZWZpbmUg
Q0xLX0lORlJBX1VBUlQyCQkJMjMNCi0jZGVmaW5lIENMS19JTkZSQV9VQVJUMwkJCTI0DQogI2Rl
ZmluZSBDTEtfSU5GUkFfR0NFXzI2TQkJMjUNCiAjZGVmaW5lIENMS19JTkZSQV9DUV9ETUFfRlBD
CQkyNg0KICNkZWZpbmUgQ0xLX0lORlJBX0JUSUYJCQkyNw0KLS0gDQoyLjE4LjANCg==

