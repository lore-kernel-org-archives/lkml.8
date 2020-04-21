Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5450EC38A30
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 01:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3D4F2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 01:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="m1L+849n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgDUBfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 21:35:16 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:15078 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725897AbgDUBfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 21:35:15 -0400
X-UUID: 170dbb33d036478c8dba9f581ca0d290-20200421
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=tKjf4UjhrVLsulgdGZ92MxlbkkoP6I0QBgm4UjGVFkU=;
        b=m1L+849nnQ76c+RmZa0AMCrsIgLqfgy/gN3/bT0Cxwm6IMAICCXMO8DY6TeRuTWJS4688dIrbxelxrqJPGBjgRjkEi7jE7mSWb2ZussX+T55C16X8OqyqI1Vcvk2lgBuM0Wdw3Sz1UUbLuUsE92sJmBhbqOKPTLMwVElkub1VKQ=;
X-UUID: 170dbb33d036478c8dba9f581ca0d290-20200421
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1285149905; Tue, 21 Apr 2020 09:35:13 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 21 Apr 2020 09:35:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 21 Apr 2020 09:35:12 +0800
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: [PATCH v2] stacktrace: cleanup inconsistent variable type
Date:   Tue, 21 Apr 2020 09:35:11 +0800
Message-ID: <20200421013511.5960-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TW9kaWZ5IHRoZSB2YXJpYWJsZSB0eXBlIG9mICdza2lwJyBtZW1iZXIgb2Ygc3RydWN0IHN0YWNr
X3RyYWNlLg0KSW4gdGhlb3J5LCB0aGUgJ3NraXAnIHZhcmlhYmxlIHR5cGUgc2hvdWxkIGJlIHVu
c2lnbmVkIGludC4NClRoZXJlIGFyZSB0d28gcmVhc29uczoNCi0gVGhlICdza2lwJyBvbmx5IGhh
cyB0d28gc2l0dWF0aW9uLCAxKVBvc2l0aXZlIHZhbHVlLCAyKVplcm8NCi0gVGhlICdza2lwJyBv
ZiBzdHJ1Y3Qgc3RhY2tfdHJhY2UgaGFzIGluY29uc2lzdGVudCB0eXBlIHdpdGggc3RydWN0DQog
IHN0YWNrX3RyYWNlX2RhdGEsIGl0IG1ha2VzIGEgYml0IGNvbmZ1c2lvbiBpbiB0aGUgcmVsYXRp
b25zaGlwIGJldHdlZW4NCiAgc3RydWN0IHN0YWNrX3RyYWNlIGFuZCBzdGFja190cmFjZV9kYXRh
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBXYWx0ZXIgV3UgPHdhbHRlci16aC53dUBtZWRpYXRlay5jb20+
DQpDYzogTWF0dGhpYXMgQnJ1Z2dlciA8bWF0dGhpYXMuYmdnQGdtYWlsLmNvbT4NCkNjOiBUaG9t
YXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCkNjOiBQZXRlciBaaWpsc3RyYSA8cGV0
ZXJ6QGluZnJhZGVhZC5vcmc+DQpDYzogSW5nbyBNb2xuYXIgPG1pbmdvQGtlcm5lbC5vcmc+DQpD
YzogSm9zaCBQb2ltYm9ldWYgPGpwb2ltYm9lQHJlZGhhdC5jb20+DQpDYzogQmFydCBWYW4gQXNz
Y2hlIDxidmFuYXNzY2hlQGFjbS5vcmc+DQpDYzogQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1m
b3VuZGF0aW9uLm9yZz4NCi0tLQ0KY2hhbmdlcyBpbiB2MjoNCm1vZGlmeSB0aGUgY29tbWl0IGxv
ZyB0byBkZXNjcmliZSB0aGUgbWF0dGVyIG1vcmUgY2xlYXJseS4NCg0KLS0tDQogaW5jbHVkZS9s
aW51eC9zdGFja3RyYWNlLmggfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3N0YWNrdHJhY2Uu
aCBiL2luY2x1ZGUvbGludXgvc3RhY2t0cmFjZS5oDQppbmRleCA4M2JkOGNiNDc1ZDcuLmI3YWY4
Y2MxM2VkYSAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvc3RhY2t0cmFjZS5oDQorKysgYi9p
bmNsdWRlL2xpbnV4L3N0YWNrdHJhY2UuaA0KQEAgLTY0LDcgKzY0LDcgQEAgdm9pZCBhcmNoX3N0
YWNrX3dhbGtfdXNlcihzdGFja190cmFjZV9jb25zdW1lX2ZuIGNvbnN1bWVfZW50cnksIHZvaWQg
KmNvb2tpZSwNCiBzdHJ1Y3Qgc3RhY2tfdHJhY2Ugew0KIAl1bnNpZ25lZCBpbnQgbnJfZW50cmll
cywgbWF4X2VudHJpZXM7DQogCXVuc2lnbmVkIGxvbmcgKmVudHJpZXM7DQotCWludCBza2lwOwkv
KiBpbnB1dCBhcmd1bWVudDogSG93IG1hbnkgZW50cmllcyB0byBza2lwICovDQorCXVuc2lnbmVk
IGludCBza2lwOwkvKiBpbnB1dCBhcmd1bWVudDogSG93IG1hbnkgZW50cmllcyB0byBza2lwICov
DQogfTsNCiANCiBleHRlcm4gdm9pZCBzYXZlX3N0YWNrX3RyYWNlKHN0cnVjdCBzdGFja190cmFj
ZSAqdHJhY2UpOw0KLS0gDQoyLjE4LjANCg==

