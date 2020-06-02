Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A411CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A077206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="k9mn8oVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgFBLyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 07:54:16 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:62304 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726267AbgFBLyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:54:15 -0400
X-UUID: db722be8915d4774a20434feec800d44-20200602
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=L8W+8mcW7tehoLHNruKxathHioAmFWgzPfCM36oBzVI=;
        b=k9mn8oVKytEFmfU9V9wfE7bOeHl582gKVvTUdOLHqqCH7lSp7cflofcwSgaHQ0ZeaoDugr6BF/FB6eHeRMa4ma2CVUniQg21aktdRPhztGUzRTYCM7UqUwSZOh1PjvKZdklXygr7vZ8rdF/qyB5qTjsL4yEYpKiAmqrxOacpFw0=;
X-UUID: db722be8915d4774a20434feec800d44-20200602
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 723940935; Tue, 02 Jun 2020 19:54:12 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 2 Jun 2020 19:54:01 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 2 Jun 2020 19:54:01 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Alexander Tsoy <alexander@tsoy.me>,
        "Johan Hovold" <johan@kernel.org>,
        Hui Wang <hui.wang@canonical.com>,
        =?UTF-8?q?Szabolcs=20Sz=C5=91ke?= <szszoke.code@gmail.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        <alsa-devel@alsa-project.org>, <linux-usb@vger.kernel.org>
CC:     Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] sound: usb: pcm: fix incorrect power state when playing sound after PM_AUTO suspend
Date:   Tue, 2 Jun 2020 19:53:41 +0800
Message-ID: <1591098821-17910-1-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org>
References: <linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBmaXggaW5jb3JyZWN0IHBvd2VyIHN0YXRlIGNoYW5nZWQgYnkgdXNiX2F1ZGlv
X3N1c3BlbmQoKQ0Kd2hlbiBDT05GSUdfUE0gaXMgZW5hYmxlZC4NCg0KQWZ0ZXIgcmVjZWl2aW5n
IHN1c3BlbmQgUE0gbWVzc2FnZSB3aXRoIGF1dG8gZmxhZywgdXNiX2F1ZGlvX3N1c3BlbmQoKQ0K
Y2hhbmdlIGNhcmQncyBwb3dlciBzdGF0ZSB0byBTTkRSVl9DVExfUE9XRVJfRDNob3QuIE9ubHkg
d2hlbiB0aGUgb3RoZXINCnJlc3VtZSBQTSBtZXNzYWdlIHdpdGggYXV0byBmbGFnIGNhbiBjaGFu
Z2UgcG93ZXIgc3RhdGUgdG8NClNORFJWX0NUTF9QT1dFUl9EMCBpbiBfX3VzYl9hdWRpb19yZXN1
bWUoKS4NCg0KSG93ZXZlciwgd2hlbiBzeXN0ZW0gaXMgbm90IHVuZGVyIGF1dG8gc3VzcGVuZCwg
cmVzdW1lIFBNIG1lc3NhZ2Ugd2l0aA0KYXV0byBmbGFnIG1pZ2h0IG5vdCBiZSBhYmxlIHRvIHJl
Y2VpdmUgb24gdGltZSB3aGljaCBjYXVzZSB0aGUgcG93ZXINCnN0YXRlIHdhcyBpbmNvcnJlY3Qu
IEF0IHRoaXMgdGltZSwgaWYgYSBwbGF5ZXIgc3RhcnRzIHRvIHBsYXkgc291bmQsDQp3aWxsIGNh
dXNlIHNuZF91c2JfcGNtX29wZW4oKSB0byBhY2Nlc3MgdGhlIGNhcmQgYW5kIHNldHVwX2h3X2lu
Zm8oKSB3aWxsDQpyZXN1bWUgdGhlIGNhcmQuDQoNCkJ1dCBldmVuIHRoZSBjYXJkIGlzIGJhY2sg
dG8gd29yayBhbmQgYWxsIGZ1bmN0aW9uIG5vcm1hbCwgdGhlIHBvd2VyDQpzdGF0ZSBpcyBzdGls
bCBpbiBTTkRSVl9DVExfUE9XRVJfRDNob3QuIFdoaWNoIGNhdXNlIHRoZSBpbmZpbml0ZSBsb29w
DQpoYXBwZW5lZCBpbiBzbmRfcG93ZXJfd2FpdCgpIHRvIGNoZWNrIHRoZSBwb3dlciBzdGF0ZS4g
VGh1cyB0aGUNCnN1Y2Nlc3NpdmUgc2V0dGluZyBpb2N0bCBjYW5ub3QgYmUgcGFzc2VkIHRvIGNh
cmQuDQoNCkhlbmNlIHdlIHN1Z2dlc3QgdG8gY2hhbmdlIHBvd2VyIHN0YXRlIHRvIFNORFJWX0NU
TF9QT1dFUl9EMCB3aGVuIGNhcmQNCmhhcyBiZWVuIHJlc3VtZWQgc3VjY2Vzc2Z1bGx5Lg0KDQpT
aWduZWQtb2ZmLWJ5OiBNYWNwYXVsIExpbiA8bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29tPg0KLS0t
DQogc291bmQvdXNiL3BjbS5jIHwgICAxMSArKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAx
MSBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9zb3VuZC91c2IvcGNtLmMgYi9zb3VuZC91
c2IvcGNtLmMNCmluZGV4IGE0ZTQwNjQuLmQ2NjdlY2IgMTAwNjQ0DQotLS0gYS9zb3VuZC91c2Iv
cGNtLmMNCisrKyBiL3NvdW5kL3VzYi9wY20uYw0KQEAgLTEzMjIsNiArMTMyMiwxNyBAQCBzdGF0
aWMgaW50IHNldHVwX2h3X2luZm8oc3RydWN0IHNuZF9wY21fcnVudGltZSAqcnVudGltZSwgc3Ry
dWN0IHNuZF91c2Jfc3Vic3RyZQ0KIAlpZiAoZXJyIDwgMCkNCiAJCXJldHVybiBlcnI7DQogDQor
CS8qIGZpeCBpbmNvcnJlY3QgcG93ZXIgc3RhdGUgd2hlbiByZXN1bWluZyBieSBvcGVuIGFuZCBs
YXRlciBpb2N0bHMgKi8NCisJaWYgKElTX0VOQUJMRUQoQ09ORklHX1BNKSAmJg0KKwkJc25kX3Bv
d2VyX2dldF9zdGF0ZShzdWJzLT5zdHJlYW0tPmNoaXAtPmNhcmQpDQorCQkJPT0gU05EUlZfQ1RM
X1BPV0VSX0QzaG90KSB7DQorCQkvKiBzZXQgdGhlc2UgdmFyaWFibGVzIGZvciBwb3dlciBzdGF0
ZSBjb3JyZWN0aW9uICovDQorCQlzdWJzLT5zdHJlYW0tPmNoaXAtPmF1dG9zdXNwZW5kZWQgPSAw
Ow0KKwkJc3Vicy0+c3RyZWFtLT5jaGlwLT5udW1fc3VzcGVuZGVkX2ludGYgPSAxOw0KKwkJZGV2
X2luZm8oJnN1YnMtPmRldi0+ZGV2LA0KKwkJCSJjaGFuZ2UgcG93ZXIgc3RhdGUgZnJvbSBEM2hv
dCB0byBEMFxuIik7DQorCX0NCisNCiAJcmV0dXJuIHNuZF91c2JfYXV0b3Jlc3VtZShzdWJzLT5z
dHJlYW0tPmNoaXApOw0KIH0NCiANCi0tIA0KMS43LjkuNQ0K

