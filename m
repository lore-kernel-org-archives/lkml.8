Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325AAC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B2A2083E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XQjUJ81Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgCCK7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:59:07 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:30785 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728157AbgCCK7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:59:04 -0500
X-UUID: 05316f9c481a48d7b825d7f3bf4170bc-20200303
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=+x+PrbDJBJiVqHYvjuhbK3vXjX2qHO65rGPeR593FOg=;
        b=XQjUJ81YYNikIkve9D9M24UKitlqbqGPEDqkcondRCMZtTLCSHCCinz8NbNWZxyRm4+BkVtZcX1lfu3mfYET4SVCY1tMpdmoYixWvBJzKEVIHy9qCReIsHgFBQA9VLpIyHPomlUaXAShOldCtHxVhyoKclXEN0vkfHg01NzWwLQ=;
X-UUID: 05316f9c481a48d7b825d7f3bf4170bc-20200303
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1687676717; Tue, 03 Mar 2020 18:58:50 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 3 Mar 2020 18:57:57 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 3 Mar 2020 18:58:12 +0800
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
Subject: [PATCH v4 11/13] soc: mediatek: cmdq: add jump function
Date:   Tue, 3 Mar 2020 18:58:43 +0800
Message-ID: <1583233125-7827-12-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1583233125-7827-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1583233125-7827-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGp1bXAgZnVuY3Rpb24gc28gdGhhdCBjbGllbnQgY2FuIGp1bXAgdG8gYW55IGFkZHJlc3Mg
d2hpY2gNCmNvbnRhaW5zIGluc3RydWN0aW9uLg0KDQpTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMg
SHNpZWggPGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyB8IDEyICsrKysrKysrKysrKw0KIGluY2x1ZGUvbGlu
dXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggIHwgMTEgKysrKysrKysrKysNCiAyIGZpbGVzIGNo
YW5nZWQsIDIzIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlh
dGVrL210ay1jbWRxLWhlbHBlci5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVs
cGVyLmMNCmluZGV4IDU5YmMxMTY0YjQxMS4uZjI3YzY3MDM0ODgwIDEwMDY0NA0KLS0tIGEvZHJp
dmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCisrKyBiL2RyaXZlcnMvc29jL21l
ZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQpAQCAtMzcyLDYgKzM3MiwxOCBAQCBpbnQgY21kcV9w
a3RfYXNzaWduKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgcmVnX2lkeCwgdTMyIHZhbHVlKQ0K
IH0NCiBFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X2Fzc2lnbik7DQogDQoraW50IGNtZHFfcGt0X2p1
bXAoc3RydWN0IGNtZHFfcGt0ICpwa3QsIGRtYV9hZGRyX3QgYWRkcikNCit7DQorCXN0cnVjdCBj
bWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0KKw0KKwlpbnN0Lm9wID0gQ01EUV9DT0RF
X0pVTVA7DQorCWluc3Qub2Zmc2V0ID0gMTsNCisJaW5zdC52YWx1ZSA9IGFkZHIgPj4NCisJCWNt
ZHFfbWJveF9zaGlmdCgoKHN0cnVjdCBjbWRxX2NsaWVudCAqKXBrdC0+Y2wpLT5jaGFuKTsNCisJ
cmV0dXJuIGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQorfQ0KK0VYUE9SVF9T
WU1CT0woY21kcV9wa3RfanVtcCk7DQorDQogaW50IGNtZHFfcGt0X2ZpbmFsaXplKHN0cnVjdCBj
bWRxX3BrdCAqcGt0KQ0KIHsNCiAJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHsgezB9
IH07DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCBi
L2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCmluZGV4IDk5ZTc3MTU1Zjk2
Ny4uMWE2YzU2ZjNiZWMxIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsv
bXRrLWNtZHEuaA0KKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0K
QEAgLTIxMyw2ICsyMTMsMTcgQEAgaW50IGNtZHFfcGt0X3BvbGxfbWFzayhzdHJ1Y3QgY21kcV9w
a3QgKnBrdCwgdTggc3Vic3lzLA0KICAqLw0KIGludCBjbWRxX3BrdF9hc3NpZ24oc3RydWN0IGNt
ZHFfcGt0ICpwa3QsIHUxNiByZWdfaWR4LCB1MzIgdmFsdWUpOw0KIA0KKy8qKg0KKyAqIGNtZHFf
cGt0X2p1bXAoKSAtIEFwcGVuZCBqdW1wIGNvbW1hbmQgdG8gdGhlIENNRFEgcGFja2V0LCBhc2sg
R0NFDQorICoJCSAgICAgdG8gZXhlY3V0ZSBhbiBpbnN0cnVjdGlvbiB0aGF0IGNoYW5nZSBjdXJy
ZW50IHRocmVhZCBQQyB0bw0KKyAqCQkgICAgIGEgcGh5c2ljYWwgYWRkcmVzcyB3aGljaCBzaG91
bGQgY29udGFpbnMgbW9yZSBpbnN0cnVjdGlvbi4NCisgKiBAcGt0OiAgICAgICAgdGhlIENNRFEg
cGFja2V0DQorICogQGFkZHI6ICAgICAgIHBoeXNpY2FsIGFkZHJlc3Mgb2YgdGFyZ2V0IGluc3Ry
dWN0aW9uIGJ1ZmZlcg0KKyAqDQorICogUmV0dXJuOiAwIGZvciBzdWNjZXNzOyBlbHNlIHRoZSBl
cnJvciBjb2RlIGlzIHJldHVybmVkDQorICovDQoraW50IGNtZHFfcGt0X2p1bXAoc3RydWN0IGNt
ZHFfcGt0ICpwa3QsIGRtYV9hZGRyX3QgYWRkcik7DQorDQogLyoqDQogICogY21kcV9wa3RfZmlu
YWxpemUoKSAtIEFwcGVuZCBFT0MgYW5kIGp1bXAgY29tbWFuZCB0byBwa3QuDQogICogQHBrdDoJ
dGhlIENNRFEgcGFja2V0DQotLSANCjIuMTguMA0K

