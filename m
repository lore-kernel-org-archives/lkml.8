Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04321C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 06:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65762082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 06:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Yb3dlr6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgA3Goi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 01:44:38 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:4528 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725798AbgA3Goi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 01:44:38 -0500
X-UUID: 7e56b355a92445ed8706ebd151455210-20200130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=nT9JMqdZL40d6DpIqTDz/AwubrwRPPy0W7SQItA5Q+w=;
        b=Yb3dlr6UnD4Cx2R+Zz6bVPOpZG+iBOUPeZY6gohalqZGQPI5KjyuDefcwA5FNZYtWxXxV2w1pox9YJ5CzU0EdzknfZNUVyaVQDl9dya3bKFFpOq3RriVzj1JVEKmGzxae49iwix8P91gaXJMQNWUniCdnLswq4PtYlzH0JkWHF4=;
X-UUID: 7e56b355a92445ed8706ebd151455210-20200130
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 636216165; Thu, 30 Jan 2020 14:44:33 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 30 Jan 2020 14:44:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 30 Jan 2020 14:43:35 +0800
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: [PATCH v3] lib/stackdepot: Fix global out-of-bounds in stackdepot
Date:   Thu, 30 Jan 2020 14:44:30 +0800
Message-ID: <20200130064430.17198-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SWYgdGhlIGRlcG90X2luZGV4ID0gU1RBQ0tfQUxMT0NfTUFYX1NMQUJTIC0gMiBhbmQgbmV4dF9z
bGFiX2luaXRlZCA9IDAsDQp0aGVuIGl0IHdpbGwgY2F1c2UgYXJyYXkgb3V0LW9mLWJvdW5kcyBh
Y2Nlc3MsIHNvIHRoYXQgd2Ugc2hvdWxkIG1vZGlmeQ0KdGhlIGRldGVjdGlvbiB0byBhdm9pZCB0
aGlzIGFycmF5IG91dC1vZi1ib3VuZHMgYnVnLg0KDQpBc3N1bWUgZGVwb3RfaW5kZXggPSBTVEFD
S19BTExPQ19NQVhfU0xBQlMgLSAzDQpDb25zaWRlciBmb2xsb3dpbmcgY2FsbCBmbG93IHNlcXVl
bmNlOg0KDQpzdGFja19kZXBvdF9zYXZlKCkNCiAgIGRlcG90X2FsbG9jX3N0YWNrKCkNCiAgICAg
IGlmICh1bmxpa2VseShkZXBvdF9pbmRleCArIDEgPj0gU1RBQ0tfQUxMT0NfTUFYX1NMQUJTKSkg
Ly9wYXNzDQogICAgICBkZXBvdF9pbmRleCsrICAvL2RlcG90X2luZGV4ID0gU1RBQ0tfQUxMT0Nf
TUFYX1NMQUJTIC0gMg0KICAgICAgaWYgKGRlcG90X2luZGV4ICsgMSA8IFNUQUNLX0FMTE9DX01B
WF9TTEFCUykgLy9lbnRlcg0KICAgICAgICAgc21wX3N0b3JlX3JlbGVhc2UoJm5leHRfc2xhYl9p
bml0ZWQsIDApOyAvL25leHRfc2xhYl9pbml0ZWQgPSAwDQogICAgICBpbml0X3N0YWNrX3NsYWIo
KQ0KICAgICAgICAgaWYgKHN0YWNrX3NsYWJzW2RlcG90X2luZGV4XSA9PSBOVUxMKSAvL2VudGVy
IGFuZCBleGl0DQoNCnN0YWNrX2RlcG90X3NhdmUoKQ0KICAgZGVwb3RfYWxsb2Nfc3RhY2soKQ0K
ICAgICAgaWYgKHVubGlrZWx5KGRlcG90X2luZGV4ICsgMSA+PSBTVEFDS19BTExPQ19NQVhfU0xB
QlMpKSAvL3Bhc3MNCiAgICAgIGRlcG90X2luZGV4KysgIC8vZGVwb3RfaW5kZXggPSBTVEFDS19B
TExPQ19NQVhfU0xBQlMgLSAxDQogICAgICBpbml0X3N0YWNrX3NsYWIoJnByZWFsbG9jKQ0KICAg
ICAgICAgc3RhY2tfc2xhYnNbZGVwb3RfaW5kZXggKyAxXSAgLy9oZXJlIGdldCBnbG9iYWwgb3V0
LW9mLWJvdW5kcw0KDQpDYzogRG1pdHJ5IFZ5dWtvdiA8ZHZ5dWtvdkBnb29nbGUuY29tPg0KQ2M6
IE1hdHRoaWFzIEJydWdnZXIgPG1hdHRoaWFzLmJnZ0BnbWFpbC5jb20+DQpDYzogVGhvbWFzIEds
ZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQpDYzogQWxleGFuZGVyIFBvdGFwZW5rbyA8Z2xp
ZGVyQGdvb2dsZS5jb20+DQpDYzogSm9zaCBQb2ltYm9ldWYgPGpwb2ltYm9lQHJlZGhhdC5jb20+
DQpDYzogS2F0ZSBTdGV3YXJ0IDxrc3Rld2FydEBsaW51eGZvdW5kYXRpb24ub3JnPg0KQ2M6IEdy
ZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQpDYzogS2F0ZSBT
dGV3YXJ0IDxrc3Rld2FydEBsaW51eGZvdW5kYXRpb24ub3JnPg0KU2lnbmVkLW9mZi1ieTogV2Fs
dGVyIFd1IDx3YWx0ZXItemgud3VAbWVkaWF0ZWsuY29tPg0KLS0tDQpjaGFuZ2VzIGluIHYyOg0K
bW9kaWZ5IGNhbGwgZmxvdyBzZXF1ZW5jZSBhbmQgcHJlY29uZGl0b24NCg0KY2hhbmdlcyBpbiB2
MzoNCmFkZCBzb21lIHJldmlld2Vycw0KLS0tDQogbGliL3N0YWNrZGVwb3QuYyB8IDIgKy0NCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdp
dCBhL2xpYi9zdGFja2RlcG90LmMgYi9saWIvc3RhY2tkZXBvdC5jDQppbmRleCBlZDcxN2RkMDhm
ZjMuLjdlOGExNWU0MTYwMCAxMDA2NDQNCi0tLSBhL2xpYi9zdGFja2RlcG90LmMNCisrKyBiL2xp
Yi9zdGFja2RlcG90LmMNCkBAIC0xMDYsNyArMTA2LDcgQEAgc3RhdGljIHN0cnVjdCBzdGFja19y
ZWNvcmQgKmRlcG90X2FsbG9jX3N0YWNrKHVuc2lnbmVkIGxvbmcgKmVudHJpZXMsIGludCBzaXpl
LA0KIAlyZXF1aXJlZF9zaXplID0gQUxJR04ocmVxdWlyZWRfc2l6ZSwgMSA8PCBTVEFDS19BTExP
Q19BTElHTik7DQogDQogCWlmICh1bmxpa2VseShkZXBvdF9vZmZzZXQgKyByZXF1aXJlZF9zaXpl
ID4gU1RBQ0tfQUxMT0NfU0laRSkpIHsNCi0JCWlmICh1bmxpa2VseShkZXBvdF9pbmRleCArIDEg
Pj0gU1RBQ0tfQUxMT0NfTUFYX1NMQUJTKSkgew0KKwkJaWYgKHVubGlrZWx5KGRlcG90X2luZGV4
ICsgMiA+PSBTVEFDS19BTExPQ19NQVhfU0xBQlMpKSB7DQogCQkJV0FSTl9PTkNFKDEsICJTdGFj
ayBkZXBvdCByZWFjaGVkIGxpbWl0IGNhcGFjaXR5Iik7DQogCQkJcmV0dXJuIE5VTEw7DQogCQl9
DQotLSANCjIuMTguMA0K

