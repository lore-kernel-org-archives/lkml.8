Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA066C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABF2A2074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qmcsrnbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgE2E3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 00:29:48 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:32195 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725777AbgE2E3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 00:29:47 -0400
X-UUID: a79da786f4844c81b39505ffcaeaae55-20200529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=/8kwEHmJ6TaKvbOevYpGl57UqTkIwazDt7MXIqKtVPY=;
        b=qmcsrnbzADgRypVyMJU/lHib1OIYoafb48XWw0diQCBr5kUmgwZdXKklqZ1Fi1qVyq03f566vBPsrL2TKUXxgAaaLoDCArZedcz7sRnM9s9n1QFioPpp55RyTdxuTXqBTN+i58a/2xhF1SM5fOhtqzlG6bi6edI4X7602P3DsF4=;
X-UUID: a79da786f4844c81b39505ffcaeaae55-20200529
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1712265074; Fri, 29 May 2020 12:29:43 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 29 May 2020 12:29:30 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 29 May 2020 12:29:34 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH] usb: host: xhci-mtk: avoid runtime suspend when removing hcd
Date:   Fri, 29 May 2020 12:29:28 +0800
Message-ID: <1590726569-28248-1-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2hlbiBydW50aW1lIHN1c3BlbmQgd2FzIGVuYWJsZWQsIHJ1bnRpbWUgc3VzcGVuZCBtaWdodCBo
YXBwZW5lZA0Kd2hlbiB4aGNpIGlzIHJlbW92aW5nIGhjZC4gVGhpcyBtaWdodCBjYXVzZSBrZXJu
ZWwgcGFuaWMgd2hlbiBoY2QNCmhhcyBiZWVuIGZyZWVkIGJ1dCBydW50aW1lIHBtIHN1c3BlbmQg
cmVsYXRlZCBoYW5kbGUgbmVlZCB0bw0KcmVmZXJlbmNlIGl0Lg0KDQpDaGFuZ2UtSWQ6IEk3MGE1
ZGM4MDA2MjA3Y2FlZWNiYWM2OTU1Y2U4ZTUzNDVkY2M3MGU2DQpTaWduZWQtb2ZmLWJ5OiBNYWNw
YXVsIExpbiA8bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy91c2IvaG9z
dC94aGNpLW10ay5jIHwgICAgNSArKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2kt
bXRrLmMgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMNCmluZGV4IGJmYmRiM2MuLjY0MWQy
NGUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMNCisrKyBiL2RyaXZl
cnMvdXNiL2hvc3QveGhjaS1tdGsuYw0KQEAgLTU4Nyw2ICs1ODcsOSBAQCBzdGF0aWMgaW50IHho
Y2lfbXRrX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpkZXYpDQogCXN0cnVjdCB4aGNp
X2hjZAkqeGhjaSA9IGhjZF90b194aGNpKGhjZCk7DQogCXN0cnVjdCB1c2JfaGNkICAqc2hhcmVk
X2hjZCA9IHhoY2ktPnNoYXJlZF9oY2Q7DQogDQorCXBtX3J1bnRpbWVfcHV0X3N5bmMoJmRldi0+
ZGV2KTsNCisJcG1fcnVudGltZV9kaXNhYmxlKCZkZXYtPmRldik7DQorDQogCXVzYl9yZW1vdmVf
aGNkKHNoYXJlZF9oY2QpOw0KIAl4aGNpLT5zaGFyZWRfaGNkID0gTlVMTDsNCiAJZGV2aWNlX2lu
aXRfd2FrZXVwKCZkZXYtPmRldiwgZmFsc2UpOw0KQEAgLTU5Nyw4ICs2MDAsNiBAQCBzdGF0aWMg
aW50IHhoY2lfbXRrX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpkZXYpDQogCXhoY2lf
bXRrX3NjaF9leGl0KG10ayk7DQogCXhoY2lfbXRrX2Nsa3NfZGlzYWJsZShtdGspOw0KIAl4aGNp
X210a19sZG9zX2Rpc2FibGUobXRrKTsNCi0JcG1fcnVudGltZV9wdXRfc3luYygmZGV2LT5kZXYp
Ow0KLQlwbV9ydW50aW1lX2Rpc2FibGUoJmRldi0+ZGV2KTsNCiANCiAJcmV0dXJuIDA7DQogfQ0K
LS0gDQoxLjcuOS41DQo=

