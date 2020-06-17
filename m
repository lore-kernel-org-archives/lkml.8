Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3094C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 05:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3017207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 05:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bIYfQxQM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgFQFnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 01:43:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:1574 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725851AbgFQFnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 01:43:18 -0400
X-UUID: 4d3606af9abb4eb3b71ff1d3b9ba594b-20200617
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=rdDoFRdKNzLFxd2DJUrNxctB8vmIe5DS4Jzw+A+aOnM=;
        b=bIYfQxQM3ixEWbj5ddGKb24ocTww1yEbDTKx/93ZPyi8XNFz2M6uH+9eRIrW6rDf0VbYOgfD5Y1BnL2k0VWGBSeg0QcT7JLHLhZxjWt1NpASrJ/eEmDrLjMo8FRJbFjPFx3Qab69Dl11ksLchHh5nmX6ZEFRj1y53VoKuxR63zM=;
X-UUID: 4d3606af9abb4eb3b71ff1d3b9ba594b-20200617
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 854175745; Wed, 17 Jun 2020 13:43:14 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 17 Jun 2020 13:43:12 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 17 Jun 2020 13:43:12 +0800
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
Subject: [PATCH v3] usb: gadget: u_serial: improve performance for large data
Date:   Wed, 17 Jun 2020 13:42:57 +0800
Message-ID: <1592372577-7986-1-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1592362007-7120-1-git-send-email-macpaul.lin@mediatek.com>
References: <1592362007-7120-1-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
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
YWNwYXVsIExpbiA8bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29tPg0KLS0tDQpDaGFuZ2VzIGZvciB2
MjoNCiAgLSBEcm9wIHByZXZpb3VzIHBhdGNoIGZvciBhZGRpbmcgZmxhZyB3aGljaCBpbmRpY2F0
ZXMgaGFyZHdhcmUgY2FwYWJpbGl0eSBpbg0KICAgIGdhZGdldC5oIGFuZCBpbiBETUEgZW5naW5l
IGFjY29yZGluZyB0byBBbGFuJ3Mgc3VnZ2VzdGlvbi4gVGhhbmtzLg0KICAtIFJlcGxhY2UgcmVx
dWVzdGVkIGJ1ZmZlciBzaXplICJSRVFfQlVGX1NJWkUiIGluc3RlYWQgb2YgY2hlY2tpbmcgaGFy
ZHdhcmUNCiAgICBjYXBhYmlsaXR5Lg0KICAtIFJlZmluZSBjb21taXQgbWVzc2FnZXMuDQpDaGFu
Z2VzIGZvciB2MzoNCiAgLSBDb2RlOiBubyBjaGFuZ2UuDQogICAgQ29tbWl0OiBBZGQgbWlzc2lu
ZyBjaGFuZ2UgbG9nIGluIHYyLg0KDQogZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2Vy
aWFsLmMgfCAgICA1ICsrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91
X3NlcmlhbC5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMNCmluZGV4
IDNjZmM2ZTIuLmQ3OTEyYTkgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rp
b24vdV9zZXJpYWwuYw0KKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFs
LmMNCkBAIC04MCw2ICs4MCw3IEBADQogI2RlZmluZSBRVUVVRV9TSVpFCQkxNg0KICNkZWZpbmUg
V1JJVEVfQlVGX1NJWkUJCTgxOTIJCS8qIFRYIG9ubHkgKi8NCiAjZGVmaW5lIEdTX0NPTlNPTEVf
QlVGX1NJWkUJODE5Mg0KKyNkZWZpbmUgUkVRX0JVRl9TSVpFCQk0MDk2DQogDQogLyogY29uc29s
ZSBpbmZvICovDQogc3RydWN0IGdzX2NvbnNvbGUgew0KQEAgLTI0Nyw3ICsyNDgsNyBAQCBzdGF0
aWMgaW50IGdzX3N0YXJ0X3R4KHN0cnVjdCBnc19wb3J0ICpwb3J0KQ0KIAkJCWJyZWFrOw0KIA0K
IAkJcmVxID0gbGlzdF9lbnRyeShwb29sLT5uZXh0LCBzdHJ1Y3QgdXNiX3JlcXVlc3QsIGxpc3Qp
Ow0KLQkJbGVuID0gZ3Nfc2VuZF9wYWNrZXQocG9ydCwgcmVxLT5idWYsIGluLT5tYXhwYWNrZXQp
Ow0KKwkJbGVuID0gZ3Nfc2VuZF9wYWNrZXQocG9ydCwgcmVxLT5idWYsIFJFUV9CVUZfU0laRSk7
DQogCQlpZiAobGVuID09IDApIHsNCiAJCQl3YWtlX3VwX2ludGVycnVwdGlibGUoJnBvcnQtPmRy
YWluX3dhaXQpOw0KIAkJCWJyZWFrOw0KQEAgLTUxNCw3ICs1MTUsNyBAQCBzdGF0aWMgaW50IGdz
X2FsbG9jX3JlcXVlc3RzKHN0cnVjdCB1c2JfZXAgKmVwLCBzdHJ1Y3QgbGlzdF9oZWFkICpoZWFk
LA0KIAkgKiBiZSBhcyBzcGVlZHkgYXMgd2UgbWlnaHQgb3RoZXJ3aXNlIGJlLg0KIAkgKi8NCiAJ
Zm9yIChpID0gMDsgaSA8IG47IGkrKykgew0KLQkJcmVxID0gZ3NfYWxsb2NfcmVxKGVwLCBlcC0+
bWF4cGFja2V0LCBHRlBfQVRPTUlDKTsNCisJCXJlcSA9IGdzX2FsbG9jX3JlcShlcCwgUkVRX0JV
Rl9TSVpFLCBHRlBfQVRPTUlDKTsNCiAJCWlmICghcmVxKQ0KIAkJCXJldHVybiBsaXN0X2VtcHR5
KGhlYWQpID8gLUVOT01FTSA6IDA7DQogCQlyZXEtPmNvbXBsZXRlID0gZm47DQotLSANCjEuNy45
LjUNCg==

