Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BE5C10F29
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 810F8206D7
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="s8/c0YGB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgCHKxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 06:53:10 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:9987 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726303AbgCHKxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 06:53:10 -0400
X-UUID: 64c1179f5d194a068920a379d641488d-20200308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=plPRMCv0gSjWkN3Yby1RX9eA2GpH1jcE9KjYJ51C3wA=;
        b=s8/c0YGBV2asOq66pi6DF0a59bvhatVguMIU/vHGITYyan3vXpPaJ1Ep5LwA/0NKkrTZFkwZKgia11AFYDxpPPBNsCPRn9gk/gpICijJ3z9RSfctX2yxxeYQHfYyrlpZz3XC+j0XQ8m10hnhOVKEl5RjRG1FIeU7uXCzxog/hiU=;
X-UUID: 64c1179f5d194a068920a379d641488d-20200308
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1287345391; Sun, 08 Mar 2020 18:53:00 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 8 Mar 2020 18:54:08 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 8 Mar 2020 18:52:59 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        HS Liao <hs.liao@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v5 09/13] soc: mediatek: cmdq: add write_s value function
Date:   Sun, 8 Mar 2020 18:52:51 +0800
Message-ID: <1583664775-19382-10-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1583664775-19382-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1583664775-19382-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YWRkIHdyaXRlX3MgZnVuY3Rpb24gaW4gY21kcSBoZWxwZXIgZnVuY3Rpb25zIHdoaWNoDQp3cml0
ZXMgYSBjb25zdGFudCB2YWx1ZSB0byBhZGRyZXNzIHdpdGggbGFyZ2UgZG1hDQphY2Nlc3Mgc3Vw
cG9ydC4NCg0KU2lnbmVkLW9mZi1ieTogRGVubmlzIFlDIEhzaWVoIDxkZW5uaXMteWMuaHNpZWhA
bWVkaWF0ZWsuY29tPg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQot
LS0NCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyB8IDI2ICsrKysrKysr
KysrKysrKysrKysrKysrKysrDQogaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEu
aCAgfCAxNCArKysrKysrKysrKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygr
KQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMg
Yi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KaW5kZXggMDNjMTI5MjMw
Y2Q3Li5hOWViYmFiYjc0MzkgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGst
Y21kcS1oZWxwZXIuYw0KKysrIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVy
LmMNCkBAIC0yNjksNiArMjY5LDMyIEBAIGludCBjbWRxX3BrdF93cml0ZV9zKHN0cnVjdCBjbWRx
X3BrdCAqcGt0LCB1MTYgaGlnaF9hZGRyX3JlZ19pZHgsDQogfQ0KIEVYUE9SVF9TWU1CT0woY21k
cV9wa3Rfd3JpdGVfcyk7DQogDQoraW50IGNtZHFfcGt0X3dyaXRlX3NfdmFsdWUoc3RydWN0IGNt
ZHFfcGt0ICpwa3QsIHUxNiBoaWdoX2FkZHJfcmVnX2lkeCwNCisJCQkgICB1MTYgYWRkcl9sb3cs
IHUzMiB2YWx1ZSwgdTMyIG1hc2spDQorew0KKwlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0
ID0geyB7MH0gfTsNCisJaW50IGVycjsNCisNCisJaWYgKG1hc2sgIT0gVTMyX01BWCkgew0KKwkJ
aW5zdC5vcCA9IENNRFFfQ09ERV9NQVNLOw0KKwkJaW5zdC5tYXNrID0gfm1hc2s7DQorCQllcnIg
PSBjbWRxX3BrdF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KKwkJaWYgKGVyciA8IDApDQor
CQkJcmV0dXJuIGVycjsNCisNCisJCWluc3Qub3AgPSBDTURRX0NPREVfV1JJVEVfU19NQVNLOw0K
Kwl9IGVsc2Ugew0KKwkJaW5zdC5vcCA9IENNRFFfQ09ERV9XUklURV9TOw0KKwl9DQorDQorCWlu
c3Quc29wID0gaGlnaF9hZGRyX3JlZ19pZHg7DQorCWluc3Qub2Zmc2V0ID0gYWRkcl9sb3c7DQor
CWluc3QudmFsdWUgPSB2YWx1ZTsNCisNCisJcmV0dXJuIGNtZHFfcGt0X2FwcGVuZF9jb21tYW5k
KHBrdCwgaW5zdCk7DQorfQ0KK0VYUE9SVF9TWU1CT0woY21kcV9wa3Rfd3JpdGVfc192YWx1ZSk7
DQorDQogaW50IGNtZHFfcGt0X3dmZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGV2ZW50KQ0K
IHsNCiAJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHsgezB9IH07DQpkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCBiL2luY2x1ZGUvbGludXgv
c29jL21lZGlhdGVrL210ay1jbWRxLmgNCmluZGV4IDAxYjQxODRhZjMxMC4uZmVjMjkyYWFjODNj
IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KKysr
IGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KQEAgLTEzNSw2ICsxMzUs
MjAgQEAgaW50IGNtZHFfcGt0X3JlYWRfcyhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGhpZ2hf
YWRkcl9yZWdfaWR4LCB1MTYgYWRkcl9sb3csDQogaW50IGNtZHFfcGt0X3dyaXRlX3Moc3RydWN0
IGNtZHFfcGt0ICpwa3QsIHUxNiBoaWdoX2FkZHJfcmVnX2lkeCwNCiAJCSAgICAgdTE2IGFkZHJf
bG93LCB1MTYgc3JjX3JlZ19pZHgsIHUzMiBtYXNrKTsNCiANCisvKioNCisgKiBjbWRxX3BrdF93
cml0ZV9zX3ZhbHVlKCkgLSBhcHBlbmQgd3JpdGVfcyBjb21tYW5kIHdpdGggbWFzayB0byB0aGUg
Q01EUQ0KKyAqCQkJICAgICAgcGFja2V0IHdoaWNoIHdyaXRlIHZhbHVlIHRvIGEgcGh5c2ljYWwg
YWRkcmVzcw0KKyAqIEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KKyAqIEBoaWdoX2FkZHJfcmVnX2lk
eDoJaW50ZXJuYWwgcmVnaXNnZXIgSUQgd2hpY2ggY29udGFpbnMgaGlnaCBhZGRyZXNzIG9mIHBh
DQorICogQGFkZHJfbG93Oglsb3cgYWRkcmVzcyBvZiBwYQ0KKyAqIEB2YWx1ZToJdGhlIHNwZWNp
ZmllZCB0YXJnZXQgdmFsdWUNCisgKiBAbWFzazoJdGhlIHNwZWNpZmllZCB0YXJnZXQgbWFzaw0K
KyAqDQorICogUmV0dXJuOiAwIGZvciBzdWNjZXNzOyBlbHNlIHRoZSBlcnJvciBjb2RlIGlzIHJl
dHVybmVkDQorICovDQoraW50IGNtZHFfcGt0X3dyaXRlX3NfdmFsdWUoc3RydWN0IGNtZHFfcGt0
ICpwa3QsIHUxNiBoaWdoX2FkZHJfcmVnX2lkeCwNCisJCQkgICB1MTYgYWRkcl9sb3csIHUzMiB2
YWx1ZSwgdTMyIG1hc2spOw0KKw0KIC8qKg0KICAqIGNtZHFfcGt0X3dmZSgpIC0gYXBwZW5kIHdh
aXQgZm9yIGV2ZW50IGNvbW1hbmQgdG8gdGhlIENNRFEgcGFja2V0DQogICogQHBrdDoJdGhlIENN
RFEgcGFja2V0DQotLSANCjIuMTguMA0K

