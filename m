Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC305C11D24
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 02:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3CE224670
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 02:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uJFOP4A+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbgBUCjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 21:39:15 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:23466 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729259AbgBUCjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 21:39:15 -0500
X-UUID: 9e3efbe0b5074d69af190b54988f52bc-20200221
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=RpulXJAZR+NqeOVzsHlHAJYWbww70aOP1WMWbMK1iwg=;
        b=uJFOP4A+wNF949LOBsiNII4+dcVn2ipkHntBB1bGuZQ3gBHxY1U6BlDX/csa1yCq64IBlaetpImq0B4Y9tsqn/S4dZ4OJchzCLOaXGdpPTECVNkdfQliyAvXE0gHO1VRn+hyuZFvFGlaDokSxxToEfoJPJGsrN8t9BDSf4Vb/LA=;
X-UUID: 9e3efbe0b5074d69af190b54988f52bc-20200221
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <wen.su@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1772381247; Fri, 21 Feb 2020 10:39:09 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 21 Feb 2020 10:38:17 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 21 Feb 2020 10:38:48 +0800
From:   Wen Su <Wen.Su@mediatek.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <wsd_upstream@mediatek.com>, <wen.su@mediatek.com>
Subject: [RESEND v2 0/4] Add Support for MediaTek PMIC MT6359 Regulator
Date:   Fri, 21 Feb 2020 10:39:02 +0800
Message-ID: <1582252746-8149-1-git-send-email-Wen.Su@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaHNldCBhZGQgc3VwcG9ydCB0byBNVDYzNTkgUE1JQyByZWd1bGF0b3IuIE1UNjM1
OSBpcyBwcmltYXJ5DQpQTUlDIGZvciBNVDY3NzkgcGxhdGZvcm0uDQoNCkNoYW5nZXMgc2luY2Ug
djI6DQotIHJlbW92ZSBvcGVuIGNvZGluZyBpbiB0aGUgbXQ2MzU5IHJlZ3VsYXRvciBmb3Igdm9s
dF90YWJsZSB0eXBlIHJlZ3VsYXRvcnMNCi0gcmVmaW5lIGNvZGluZyBzdHlsZSBpbiB0aGUgbXQ2
MzU5IHJlZ3VsYXRvciB0byBhdm9pZCB1c2luZyB0ZXJuZXJ5IG9wZXJhdG9yDQotIHJlbW92ZSB1
bm5lY2Vzc2FyeSByZWplY3Qgb3BlcmF0aW9uIGluIG10NjM1OSByZWd1bGF0b3Igc2V0IG1vZGUg
ZnVuY3Rpb24NCg0KDQp3ZW4uc3UgKDQpOg0KICBkdC1iaW5kaW5nczogcmVndWxhdG9yOiBBZGQg
ZG9jdW1lbnQgZm9yIE1UNjM1OSByZWd1bGF0b3INCiAgbWZkOiBBZGQgZm9yIFBNSUMgTVQ2MzU5
IHJlZ2lzdGVycyBkZWZpbml0aW9uDQogIHJlZ3VsYXRvcjogbXQ2MzU5OiBBZGQgc3VwcG9ydCBm
b3IgTVQ2MzU5IHJlZ3VsYXRvcg0KICBhcm02NDogZHRzOiBtdDYzNTk6IGFkZCBQTUlDIE1UNjM1
OSByZWxhdGVkIG5vZGVzDQoNCiAuLi4vYmluZGluZ3MvcmVndWxhdG9yL210NjM1OS1yZWd1bGF0
b3IudHh0ICAgICAgICB8ICA1OSArKw0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ2
MzU5LmR0c2kgICAgICAgICAgIHwgMzEyICsrKysrKysrDQogZHJpdmVycy9yZWd1bGF0b3IvS2Nv
bmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDkgKw0KIGRyaXZlcnMvcmVndWxhdG9y
L01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCiBkcml2ZXJzL3JlZ3Vs
YXRvci9tdDYzNTktcmVndWxhdG9yLmMgICAgICAgICAgICAgICB8IDg1OSArKysrKysrKysrKysr
KysrKysrKysNCiBpbmNsdWRlL2xpbnV4L21mZC9tdDYzNTkvcmVnaXN0ZXJzLmggICAgICAgICAg
ICAgICB8IDUzMSArKysrKysrKysrKysrDQogaW5jbHVkZS9saW51eC9yZWd1bGF0b3IvbXQ2MzU5
LXJlZ3VsYXRvci5oICAgICAgICAgfCAgNTggKysNCiA3IGZpbGVzIGNoYW5nZWQsIDE4MjkgaW5z
ZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvcmVndWxhdG9yL210NjM1OS1yZWd1bGF0b3IudHh0DQogY3JlYXRlIG1vZGUgMTAw
NjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ2MzU5LmR0c2kNCiBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9yZWd1bGF0b3IvbXQ2MzU5LXJlZ3VsYXRvci5jDQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IGluY2x1ZGUvbGludXgvbWZkL210NjM1OS9yZWdpc3RlcnMuaA0KIGNyZWF0ZSBt
b2RlIDEwMDY0NCBpbmNsdWRlL2xpbnV4L3JlZ3VsYXRvci9tdDYzNTktcmVndWxhdG9yLmg=

