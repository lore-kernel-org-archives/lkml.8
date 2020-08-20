Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D42C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C5A8204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NFWm/ny2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730876AbgHTLfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:35:43 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:48627 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730643AbgHTLcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 07:32:52 -0400
X-UUID: 588f2b4e3c8e4e8db45b2eabea53c397-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=75cV0UNvaSFcEM+ct8jXkWIGJbUbdQ/lh05MDRsBTN0=;
        b=NFWm/ny2jgdfVodzFuGo0u/CZk9ClrQl3quJuZuUvlYYZ3e5bSmrr4rN2VNmSjIYaskEX8th/J3DLrJ8wI3Lr9A7Lf9HFP5qrvc+QydtJJzoYErbguwh9Rv16dd1auPaNeAvE20Va3VwObezAUP3A7JXBJWNKoeWBzyY8KI4yxU=;
X-UUID: 588f2b4e3c8e4e8db45b2eabea53c397-20200820
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 287845818; Thu, 20 Aug 2020 19:32:32 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 19:32:28 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 19:32:27 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Al Cooper <alcooperx@gmail.com>,
        Sasi Kumar <sasi.kumar@broadcom.com>,
        Peter Chen <peter.chen@nxp.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 07/11] usb: gadget: bdc: avoid precedence issues
Date:   Thu, 20 Aug 2020 19:30:42 +0800
Message-ID: <1597923046-12535-7-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597923046-12535-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1597923046-12535-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 8AD06DDE1DD208043ADBFE70C9BAA1AC6B260E30948CDF1CCDA65F835038900B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkICgpIGFyb3VuZCBtYWNybyBhcmd1bWVudCB0byBhdm9pZCBwcmVjZWRlbmNlIGlzc3Vlcw0K
DQpDYzogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+DQpTaWduZWQtb2Zm
LWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQotLS0NCnYyOiBh
ZGQgQ2MgRmxvcmlhbg0KLS0tDQogZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjLmggfCAx
OCArKysrKysrKystLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA5
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMv
YmRjLmggYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGMuaA0KaW5kZXggNjU4YWJlZi4u
ZjhkNTk1OCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkYy5oDQor
KysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGMuaA0KQEAgLTg2LDIwICs4NiwyMCBA
QA0KICNkZWZpbmUgQkRDX0VQU1RTNQkweDc0DQogI2RlZmluZSBCRENfRVBTVFM2CTB4NzgNCiAj
ZGVmaW5lIEJEQ19FUFNUUzcJMHg3Yw0KLSNkZWZpbmUgQkRDX1NSUkJBTChuKQkoMHgyMDAgKyAo
biAqIDB4MTApKQ0KLSNkZWZpbmUgQkRDX1NSUkJBSChuKQkoMHgyMDQgKyAobiAqIDB4MTApKQ0K
LSNkZWZpbmUgQkRDX1NSUklOVChuKQkoMHgyMDggKyAobiAqIDB4MTApKQ0KLSNkZWZpbmUgQkRD
X0lOVENUTFMobikJKDB4MjBjICsgKG4gKiAweDEwKSkNCisjZGVmaW5lIEJEQ19TUlJCQUwobikJ
KDB4MjAwICsgKChuKSAqIDB4MTApKQ0KKyNkZWZpbmUgQkRDX1NSUkJBSChuKQkoMHgyMDQgKyAo
KG4pICogMHgxMCkpDQorI2RlZmluZSBCRENfU1JSSU5UKG4pCSgweDIwOCArICgobikgKiAweDEw
KSkNCisjZGVmaW5lIEJEQ19JTlRDVExTKG4pCSgweDIwYyArICgobikgKiAweDEwKSkNCiANCiAv
KiBFeHRlbmRlZCBjYXBhYmlsaXR5IHJlZ3MgKi8NCiAjZGVmaW5lIEJEQ19GU0NOT0MJMHhjZDQN
CiAjZGVmaW5lIEJEQ19GU0NOSUMJMHhjZTQNCi0jZGVmaW5lIE5VTV9OQ1MocCkJKHAgPj4gMjgp
DQorI2RlZmluZSBOVU1fTkNTKHApCSgocCkgPj4gMjgpDQogDQogLyogUmVnaXN0ZXIgYml0IGZp
ZWxkcyBhbmQgTWFza3MgKi8NCiAvKiBCREMgQ29uZmlndXJhdGlvbiAwICovDQogI2RlZmluZSBC
RENfUEdTKHApCSgoKHApICYgKDB4NyA8PCA4KSkgPj4gOCkNCi0jZGVmaW5lIEJEQ19TUEIocCkJ
KHAgJiAweDcpDQorI2RlZmluZSBCRENfU1BCKHApCSgocCkgJiAweDcpDQogDQogLyogQkRDIENh
cGFiaWxpdHkxICovDQogI2RlZmluZSBCRENfUDY0CQkoMSA8PCAwKQ0KQEAgLTExMyw3ICsxMTMs
NyBAQA0KICNkZWZpbmUgQkRDX0NNRF9EVkMJMHgxDQogI2RlZmluZSBCRENfQ01EX0NXUwkJKDB4
MSA8PCA1KQ0KICNkZWZpbmUgQkRDX0NNRF9DU1QocCkJCSgoKHApICYgKDB4ZiA8PCA2KSk+PjYp
DQotI2RlZmluZSBCRENfQ01EX0VQTihwKQkJKChwICYgMHgxZikgPDwgMTApDQorI2RlZmluZSBC
RENfQ01EX0VQTihwKQkJKCgocCkgJiAweDFmKSA8PCAxMCkNCiAjZGVmaW5lIEJEQ19TVUJfQ01E
X0FERAkJKDB4MSA8PCAxNykNCiAjZGVmaW5lIEJEQ19TVUJfQ01EX0ZXSwkJKDB4NCA8PCAxNykN
CiAvKiBSZXNldCBzZXF1ZW5jZSBudW1iZXIgKi8NCkBAIC0xNjMsNyArMTYzLDcgQEANCiAjZGVm
aW5lIEJEQ19TUEVFRF9IUwkweDMNCiAjZGVmaW5lIEJEQ19TUEVFRF9TUwkweDQNCiANCi0jZGVm
aW5lIEJEQ19QU1QocCkJKHAgJiAweGYpDQorI2RlZmluZSBCRENfUFNUKHApCSgocCkgJiAweGYp
DQogI2RlZmluZSBCRENfUFNUX01BU0sJMHhmDQogDQogLyogVVNQUE1TICovDQpAQCAtMjI4LDcg
KzIyOCw3IEBADQogLyogc3RhdHVzIHJlcG9ydCBkZWZpbmVzICovDQogI2RlZmluZSBTUl9YU0YJ
CTANCiAjZGVmaW5lIFNSX1VTUEMJCTQNCi0jZGVmaW5lIFNSX0JEX0xFTihwKSAgICAocCAmIDB4
ZmZmZmZmKQ0KKyNkZWZpbmUgU1JfQkRfTEVOKHApICAgICgocCkgJiAweGZmZmZmZikNCiANCiAj
ZGVmaW5lIFhTRl9TVUNDCTB4MQ0KICNkZWZpbmUgWFNGX1NIT1JUCTB4Mw0KLS0gDQoxLjkuMQ0K

