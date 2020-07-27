Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55488C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2538720792
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jXOcOWcX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgG0HRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 03:17:01 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:23418 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726116AbgG0HQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 03:16:45 -0400
X-UUID: 2e4ffec7d3ec4e73b391aee17663c861-20200727
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ufjzZjNOHimcMX86Fnfqnwe5QrRh888Z/o+t/Lvqu3o=;
        b=jXOcOWcXga2m3FwL2ncjk9L+LprcPR6TvBrJfS1kK54uIRiivkSpW9fZsgo7z6zwqX/UG2HprZl9NZBzmND7Vb42ze7FpS+bkeSjZYH8wc2zSZS9mkzf23m302FWVhpDn5d7T/VyI8ltWQZemVXGb7kISCtOWtYJX2tWJ+NOXcQ=;
X-UUID: 2e4ffec7d3ec4e73b391aee17663c861-20200727
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 504771410; Mon, 27 Jul 2020 15:16:41 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 27 Jul 2020 15:16:38 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 27 Jul 2020 15:16:39 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH 07/11] usb: mtu3: remove repeated error log
Date:   Mon, 27 Jul 2020 15:14:56 +0800
Message-ID: <1595834101-13094-7-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1595834101-13094-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1595834101-13094-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 00A026CDA25A030254C6AB9822EE2914ADBAA6D88F98B076D42B2123E33AE3752000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGNhbGxlciBhbHJlYWR5IHByaW50IGVycm9yIGxvZy4NCg0KU2lnbmVkLW9mZi1ieTogQ2h1
bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy91c2Iv
bXR1My9tdHUzX2dhZGdldC5jIHwgOCArLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgNyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL210dTMv
bXR1M19nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL210dTMvbXR1M19nYWRnZXQuYw0KaW5kZXggM2Qx
MzEyOS4uMmJjOWE5NSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL210dTMvbXR1M19nYWRnZXQu
Yw0KKysrIGIvZHJpdmVycy91c2IvbXR1My9tdHUzX2dhZGdldC5jDQpAQCAtNjczLDggKzY3Myw2
IEBAIHN0YXRpYyB2b2lkIG10dTNfZ2FkZ2V0X2luaXRfZXBzKHN0cnVjdCBtdHUzICptdHUpDQog
DQogaW50IG10dTNfZ2FkZ2V0X3NldHVwKHN0cnVjdCBtdHUzICptdHUpDQogew0KLQlpbnQgcmV0
Ow0KLQ0KIAltdHUtPmcub3BzID0gJm10dTNfZ2FkZ2V0X29wczsNCiAJbXR1LT5nLm1heF9zcGVl
ZCA9IG10dS0+bWF4X3NwZWVkOw0KIAltdHUtPmcuc3BlZWQgPSBVU0JfU1BFRURfVU5LTk9XTjsN
CkBAIC02ODUsMTEgKzY4Myw3IEBAIGludCBtdHUzX2dhZGdldF9zZXR1cChzdHJ1Y3QgbXR1MyAq
bXR1KQ0KIA0KIAltdHUzX2dhZGdldF9pbml0X2VwcyhtdHUpOw0KIA0KLQlyZXQgPSB1c2JfYWRk
X2dhZGdldF91ZGMobXR1LT5kZXYsICZtdHUtPmcpOw0KLQlpZiAocmV0KQ0KLQkJZGV2X2Vyciht
dHUtPmRldiwgImZhaWxlZCB0byByZWdpc3RlciB1ZGNcbiIpOw0KLQ0KLQlyZXR1cm4gcmV0Ow0K
KwlyZXR1cm4gdXNiX2FkZF9nYWRnZXRfdWRjKG10dS0+ZGV2LCAmbXR1LT5nKTsNCiB9DQogDQog
dm9pZCBtdHUzX2dhZGdldF9jbGVhbnVwKHN0cnVjdCBtdHUzICptdHUpDQotLSANCjEuOS4xDQo=

