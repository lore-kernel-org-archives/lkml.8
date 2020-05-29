Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30105C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 092BE2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XtDq46ug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgE2EdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 00:33:08 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:54675 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725562AbgE2EdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 00:33:07 -0400
X-UUID: f0271cf6ad2d45038bb3d5c8fea372a1-20200529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=NQxTpzWSVt9V/exBuo1GGmsYXw0ueriE8T12aD6F8IM=;
        b=XtDq46ugdCZakv0oCcUDzadMUYjE6/TWegB2PNYxZtPM4VKPNCYaFG5cpBrlgQkFA3fMlcq1jP/97Wq+wV5Bxua9aLYovYopOJOyv0I3M/UUfMMBAxEOem6HhueJkD/jpW8TnB7qnMZ3lmzTjsOj1sgu4ZW8hLBlX9utYS/Ic04=;
X-UUID: f0271cf6ad2d45038bb3d5c8fea372a1-20200529
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1318030598; Fri, 29 May 2020 12:33:03 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 29 May 2020 12:32:57 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 29 May 2020 12:33:02 +0800
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
Subject: [PATCH v2] usb: host: xhci-mtk: avoid runtime suspend when removing hcd
Date:   Fri, 29 May 2020 12:32:58 +0800
Message-ID: <1590726778-29065-1-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1590726569-28248-1-git-send-email-macpaul.lin@mediatek.com>
References: <1590726569-28248-1-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F7F5029A8E56D799AC15E58E9FB9F79910F4976461FD69A9201D4F2A0F901EDB2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2hlbiBydW50aW1lIHN1c3BlbmQgd2FzIGVuYWJsZWQsIHJ1bnRpbWUgc3VzcGVuZCBtaWdodCBo
YXBwZW5lZA0Kd2hlbiB4aGNpIGlzIHJlbW92aW5nIGhjZC4gVGhpcyBtaWdodCBjYXVzZSBrZXJu
ZWwgcGFuaWMgd2hlbiBoY2QNCmhhcyBiZWVuIGZyZWVkIGJ1dCBydW50aW1lIHBtIHN1c3BlbmQg
cmVsYXRlZCBoYW5kbGUgbmVlZCB0bw0KcmVmZXJlbmNlIGl0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBN
YWNwYXVsIExpbiA8bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy91c2Iv
aG9zdC94aGNpLW10ay5jIHwgICAgNSArKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L3ho
Y2ktbXRrLmMgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMNCmluZGV4IGJmYmRiM2MuLjY0
MWQyNGUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMNCisrKyBiL2Ry
aXZlcnMvdXNiL2hvc3QveGhjaS1tdGsuYw0KQEAgLTU4Nyw2ICs1ODcsOSBAQCBzdGF0aWMgaW50
IHhoY2lfbXRrX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpkZXYpDQogCXN0cnVjdCB4
aGNpX2hjZAkqeGhjaSA9IGhjZF90b194aGNpKGhjZCk7DQogCXN0cnVjdCB1c2JfaGNkICAqc2hh
cmVkX2hjZCA9IHhoY2ktPnNoYXJlZF9oY2Q7DQogDQorCXBtX3J1bnRpbWVfcHV0X3N5bmMoJmRl
di0+ZGV2KTsNCisJcG1fcnVudGltZV9kaXNhYmxlKCZkZXYtPmRldik7DQorDQogCXVzYl9yZW1v
dmVfaGNkKHNoYXJlZF9oY2QpOw0KIAl4aGNpLT5zaGFyZWRfaGNkID0gTlVMTDsNCiAJZGV2aWNl
X2luaXRfd2FrZXVwKCZkZXYtPmRldiwgZmFsc2UpOw0KQEAgLTU5Nyw4ICs2MDAsNiBAQCBzdGF0
aWMgaW50IHhoY2lfbXRrX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpkZXYpDQogCXho
Y2lfbXRrX3NjaF9leGl0KG10ayk7DQogCXhoY2lfbXRrX2Nsa3NfZGlzYWJsZShtdGspOw0KIAl4
aGNpX210a19sZG9zX2Rpc2FibGUobXRrKTsNCi0JcG1fcnVudGltZV9wdXRfc3luYygmZGV2LT5k
ZXYpOw0KLQlwbV9ydW50aW1lX2Rpc2FibGUoJmRldi0+ZGV2KTsNCiANCiAJcmV0dXJuIDA7DQog
fQ0KLS0gDQoxLjcuOS41DQo=

