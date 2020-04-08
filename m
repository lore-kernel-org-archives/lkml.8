Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55F0C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 08:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55B42074F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 08:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="R/HsOLhi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgDHItc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 04:49:32 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:23286 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726873AbgDHItc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 04:49:32 -0400
X-UUID: 9d3098026fa84606b94ff72d918351d7-20200408
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=pcxXWb5iQG4wOxAvyRLVWbYi/fyvTtoB5AgaZ19wR60=;
        b=R/HsOLhiSc64RJr6ITsvdUUniNyyb8dc7e4MQkAyQYCNb/GVHrAjYyR5nSJ8UzIa9x/I4nzFO3xFX3BrzPEs4c3LgoFJeavvZL1HEcRRGoH1OjhLCZeqLSpTcnlWvdOWx6k7ADl1Spx41kglKFNZTWdYgBcEbXFOAhf/x3h2Yhk=;
X-UUID: 9d3098026fa84606b94ff72d918351d7-20200408
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2120634440; Wed, 08 Apr 2020 16:49:28 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Apr 2020 16:49:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 8 Apr 2020 16:49:24 +0800
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: [PATCH] stacktrace: cleanup inconsistent variable type
Date:   Wed, 8 Apr 2020 16:49:03 +0800
Message-ID: <20200408084903.4261-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHNraXAgaW4gc3RydWN0IHN0YWNrX3RyYWNlIGhhcyBpbmNvbnNpc3RlbnQgdHlwZSB3aXRo
IHN0cnVjdA0Kc3RhY2tfdHJhY2VfZGF0YSwgaXQgbWFrZXMgYSBiaXQgY29uZnVzaW9uIGluIHRo
ZSByZWxhdGlvbnNoaXANCmJldHdlZW4gc3RydWN0IHN0YWNrX3RyYWNlIGFuZCBzdGFja190cmFj
ZV9kYXRhLiBJbiB0aGVvcnksDQp0aGUgc2tpcCB2YXJpYWJsZSB0eXBlIHNob3VsZCBiZSB1bnNp
Z25lZCBpbnQuDQoNClNpZ25lZC1vZmYtYnk6IFdhbHRlciBXdSA8d2FsdGVyLXpoLnd1QG1lZGlh
dGVrLmNvbT4NCkNjOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCkNjOiBQ
ZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+DQpDYzogSW5nbyBNb2xuYXIgPG1p
bmdvQGtlcm5lbC5vcmc+DQpDYzogSm9zaCBQb2ltYm9ldWYgPGpwb2ltYm9lQHJlZGhhdC5jb20+
DQpDYzogQmFydCBWYW4gQXNzY2hlIDxidmFuYXNzY2hlQGFjbS5vcmc+DQpDYzogQW5kcmV3IE1v
cnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4NCi0tLQ0KIGluY2x1ZGUvbGludXgvc3Rh
Y2t0cmFjZS5oIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zdGFja3RyYWNlLmggYi9pbmNs
dWRlL2xpbnV4L3N0YWNrdHJhY2UuaA0KaW5kZXggODNiZDhjYjQ3NWQ3Li5iN2FmOGNjMTNlZGEg
MTAwNjQ0DQotLS0gYS9pbmNsdWRlL2xpbnV4L3N0YWNrdHJhY2UuaA0KKysrIGIvaW5jbHVkZS9s
aW51eC9zdGFja3RyYWNlLmgNCkBAIC02NCw3ICs2NCw3IEBAIHZvaWQgYXJjaF9zdGFja193YWxr
X3VzZXIoc3RhY2tfdHJhY2VfY29uc3VtZV9mbiBjb25zdW1lX2VudHJ5LCB2b2lkICpjb29raWUs
DQogc3RydWN0IHN0YWNrX3RyYWNlIHsNCiAJdW5zaWduZWQgaW50IG5yX2VudHJpZXMsIG1heF9l
bnRyaWVzOw0KIAl1bnNpZ25lZCBsb25nICplbnRyaWVzOw0KLQlpbnQgc2tpcDsJLyogaW5wdXQg
YXJndW1lbnQ6IEhvdyBtYW55IGVudHJpZXMgdG8gc2tpcCAqLw0KKwl1bnNpZ25lZCBpbnQgc2tp
cDsJLyogaW5wdXQgYXJndW1lbnQ6IEhvdyBtYW55IGVudHJpZXMgdG8gc2tpcCAqLw0KIH07DQog
DQogZXh0ZXJuIHZvaWQgc2F2ZV9zdGFja190cmFjZShzdHJ1Y3Qgc3RhY2tfdHJhY2UgKnRyYWNl
KTsNCi0tIA0KMi4xOC4wDQo=

