Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16945C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 02:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E512A208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 02:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UQNlZQuY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgFQCrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 22:47:01 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:18229 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726275AbgFQCrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 22:47:01 -0400
X-UUID: 29cb5b068b674c549fb17cb674c4c795-20200617
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ZB3PDgfcBojaJ/fPpU6l0md70bnLTvLTU3jl+XWvIfE=;
        b=UQNlZQuY0/jpjIyCUaZKGd/4VnP5RTrlQYm4MJYqT6cBPb4hKiOKDz0U1f0kjvNOmwd331xjUs47K8ji18ypFCErWOq5PEmc5xWaGbptHlwbAPqsZsKtKVJXW69RULvBnlcW8Tq0de6144qXGe/K9IJV8zaz1JVe1VU8B6ydnKU=;
X-UUID: 29cb5b068b674c549fb17cb674c4c795-20200617
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 464138752; Wed, 17 Jun 2020 10:46:56 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 17 Jun 2020 10:46:50 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 17 Jun 2020 10:46:52 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Sergey Organov <sorganov@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>
Subject: [PATCH v2] usb: gadget: u_serial: improve performance for large data
Date:   Wed, 17 Jun 2020 10:46:47 +0800
Message-ID: <1592362007-7120-1-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1592310884-4307-1-git-send-email-macpaul.lin@mediatek.com>
References: <1592310884-4307-1-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 341107C8CF0BF6B3E6614FF7FFDF49CB2287241339A1BF5421EE54432FA9522B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tm93YWRheXMgc29tZSBlbWJlZGRlZCBzeXN0ZW1zIHVzZSBWQ09NIHRvIHRyYW5zZmVyIGxhcmdl
IGxvZyBhbmQgZGF0YS4NClRha2UgTFRFIE1PREVNIGFzIGFuIGV4YW1wbGUsIGR1cmluZyB0aGUg
bG9uZyBkZWJ1Z2dpbmcgc3RhZ2UsIGxhcmdlDQpsb2cgYW5kIGRhdGEgd2VyZSB0cmFuc2ZlciB0
aHJvdWdoIFZDT00gd2hlbiBkb2luZyBmaWVsZCB0cnkgb3IgaW4NCm9wZXJhdG9yJ3MgbGFiLiBI
ZXJlIHdlIHN1Z2dlc3Qgc2xpZ2h0bHkgaW5jcmVhc2UgdGhlIHRyYW5zZmVyIGJ1ZmZlcg0KaW4g
dV9zZXJpYWwuYyBmb3IgcGVyZm9ybWFuY2UgaW1wcm92aW5nLg0KDQpTaWduZWQtb2ZmLWJ5OiBN
YWNwYXVsIExpbiA8bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy91c2Iv
Z2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMgfCAgICA1ICsrKy0tDQogMSBmaWxlIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dXNiL2dhZGdldC9mdW5jdGlvbi91X3NlcmlhbC5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0
aW9uL3Vfc2VyaWFsLmMNCmluZGV4IDNjZmM2ZTIuLmQ3OTEyYTkgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYw0KKysrIGIvZHJpdmVycy91c2IvZ2Fk
Z2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMNCkBAIC04MCw2ICs4MCw3IEBADQogI2RlZmluZSBRVUVV
RV9TSVpFCQkxNg0KICNkZWZpbmUgV1JJVEVfQlVGX1NJWkUJCTgxOTIJCS8qIFRYIG9ubHkgKi8N
CiAjZGVmaW5lIEdTX0NPTlNPTEVfQlVGX1NJWkUJODE5Mg0KKyNkZWZpbmUgUkVRX0JVRl9TSVpF
CQk0MDk2DQogDQogLyogY29uc29sZSBpbmZvICovDQogc3RydWN0IGdzX2NvbnNvbGUgew0KQEAg
LTI0Nyw3ICsyNDgsNyBAQCBzdGF0aWMgaW50IGdzX3N0YXJ0X3R4KHN0cnVjdCBnc19wb3J0ICpw
b3J0KQ0KIAkJCWJyZWFrOw0KIA0KIAkJcmVxID0gbGlzdF9lbnRyeShwb29sLT5uZXh0LCBzdHJ1
Y3QgdXNiX3JlcXVlc3QsIGxpc3QpOw0KLQkJbGVuID0gZ3Nfc2VuZF9wYWNrZXQocG9ydCwgcmVx
LT5idWYsIGluLT5tYXhwYWNrZXQpOw0KKwkJbGVuID0gZ3Nfc2VuZF9wYWNrZXQocG9ydCwgcmVx
LT5idWYsIFJFUV9CVUZfU0laRSk7DQogCQlpZiAobGVuID09IDApIHsNCiAJCQl3YWtlX3VwX2lu
dGVycnVwdGlibGUoJnBvcnQtPmRyYWluX3dhaXQpOw0KIAkJCWJyZWFrOw0KQEAgLTUxNCw3ICs1
MTUsNyBAQCBzdGF0aWMgaW50IGdzX2FsbG9jX3JlcXVlc3RzKHN0cnVjdCB1c2JfZXAgKmVwLCBz
dHJ1Y3QgbGlzdF9oZWFkICpoZWFkLA0KIAkgKiBiZSBhcyBzcGVlZHkgYXMgd2UgbWlnaHQgb3Ro
ZXJ3aXNlIGJlLg0KIAkgKi8NCiAJZm9yIChpID0gMDsgaSA8IG47IGkrKykgew0KLQkJcmVxID0g
Z3NfYWxsb2NfcmVxKGVwLCBlcC0+bWF4cGFja2V0LCBHRlBfQVRPTUlDKTsNCisJCXJlcSA9IGdz
X2FsbG9jX3JlcShlcCwgUkVRX0JVRl9TSVpFLCBHRlBfQVRPTUlDKTsNCiAJCWlmICghcmVxKQ0K
IAkJCXJldHVybiBsaXN0X2VtcHR5KGhlYWQpID8gLUVOT01FTSA6IDA7DQogCQlyZXEtPmNvbXBs
ZXRlID0gZm47DQotLSANCjEuNy45LjUNCg==

