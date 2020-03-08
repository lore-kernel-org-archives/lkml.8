Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F13C18E5A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D60120838
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UZlXvRIB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgCHKxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 06:53:12 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:20447 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726339AbgCHKxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 06:53:12 -0400
X-UUID: 4bbe4a8b0c264a27a313218f51fa1815-20200308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=1JNePjB6YqDB7fVq03Mwu2OpxYlWObOTYcRp1X0n4oQ=;
        b=UZlXvRIBIwKaaMMI5eTtkFMM1vV8nLU3exQpyAmS3l8lwst9Elh5LPAQ2ctxpngBN8ER/GOt2LBeqZ8Q78M53AjIblZJm8tp+JjRjULJEVQ1dJm3pVooC4oBPDbnclOcm2UzUMs8OplbLq+FgD0n0DQn/oI/APMXZTBG/dpjJb4=;
X-UUID: 4bbe4a8b0c264a27a313218f51fa1815-20200308
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1339047386; Sun, 08 Mar 2020 18:53:00 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 8 Mar 2020 18:52:06 +0800
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
Subject: [PATCH v5 11/13] soc: mediatek: cmdq: add jump function
Date:   Sun, 8 Mar 2020 18:52:53 +0800
Message-ID: <1583664775-19382-12-git-send-email-dennis-yc.hsieh@mediatek.com>
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

QWRkIGp1bXAgZnVuY3Rpb24gc28gdGhhdCBjbGllbnQgY2FuIGp1bXAgdG8gYW55IGFkZHJlc3Mg
d2hpY2gNCmNvbnRhaW5zIGluc3RydWN0aW9uLg0KDQpTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMg
SHNpZWggPGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyB8IDEzICsrKysrKysrKysrKysNCiBpbmNsdWRlL2xp
bnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oICB8IDExICsrKysrKysrKysrDQogMiBmaWxlcyBj
aGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRp
YXRlay9tdGstY21kcS1oZWxwZXIuYyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhl
bHBlci5jDQppbmRleCA1OWJjMTE2NGI0MTEuLmJiNWJlMjBmYzcwYSAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQorKysgYi9kcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KQEAgLTEzLDYgKzEzLDcgQEANCiAjZGVmaW5lIENN
RFFfUE9MTF9FTkFCTEVfTUFTSwlCSVQoMCkNCiAjZGVmaW5lIENNRFFfRU9DX0lSUV9FTgkJQklU
KDApDQogI2RlZmluZSBDTURRX1JFR19UWVBFCQkxDQorI2RlZmluZSBDTURRX0pVTVBfUkVMQVRJ
VkUJMQ0KIA0KIHN0cnVjdCBjbWRxX2luc3RydWN0aW9uIHsNCiAJdW5pb24gew0KQEAgLTM3Miw2
ICszNzMsMTggQEAgaW50IGNtZHFfcGt0X2Fzc2lnbihzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2
IHJlZ19pZHgsIHUzMiB2YWx1ZSkNCiB9DQogRVhQT1JUX1NZTUJPTChjbWRxX3BrdF9hc3NpZ24p
Ow0KIA0KK2ludCBjbWRxX3BrdF9qdW1wKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCBkbWFfYWRkcl90
IGFkZHIpDQorew0KKwlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCisN
CisJaW5zdC5vcCA9IENNRFFfQ09ERV9KVU1QOw0KKwlpbnN0Lm9mZnNldCA9IENNRFFfSlVNUF9S
RUxBVElWRTsNCisJaW5zdC52YWx1ZSA9IGFkZHIgPj4NCisJCWNtZHFfbWJveF9zaGlmdCgoKHN0
cnVjdCBjbWRxX2NsaWVudCAqKXBrdC0+Y2wpLT5jaGFuKTsNCisJcmV0dXJuIGNtZHFfcGt0X2Fw
cGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQorfQ0KK0VYUE9SVF9TWU1CT0woY21kcV9wa3RfanVt
cCk7DQorDQogaW50IGNtZHFfcGt0X2ZpbmFsaXplKHN0cnVjdCBjbWRxX3BrdCAqcGt0KQ0KIHsN
CiAJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHsgezB9IH07DQpkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCBiL2luY2x1ZGUvbGludXgvc29j
L21lZGlhdGVrL210ay1jbWRxLmgNCmluZGV4IDk5ZTc3MTU1Zjk2Ny4uMWE2YzU2ZjNiZWMxIDEw
MDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KKysrIGIv
aW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KQEAgLTIxMyw2ICsyMTMsMTcg
QEAgaW50IGNtZHFfcGt0X3BvbGxfbWFzayhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTggc3Vic3lz
LA0KICAqLw0KIGludCBjbWRxX3BrdF9hc3NpZ24oc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiBy
ZWdfaWR4LCB1MzIgdmFsdWUpOw0KIA0KKy8qKg0KKyAqIGNtZHFfcGt0X2p1bXAoKSAtIEFwcGVu
ZCBqdW1wIGNvbW1hbmQgdG8gdGhlIENNRFEgcGFja2V0LCBhc2sgR0NFDQorICoJCSAgICAgdG8g
ZXhlY3V0ZSBhbiBpbnN0cnVjdGlvbiB0aGF0IGNoYW5nZSBjdXJyZW50IHRocmVhZCBQQyB0bw0K
KyAqCQkgICAgIGEgcGh5c2ljYWwgYWRkcmVzcyB3aGljaCBzaG91bGQgY29udGFpbnMgbW9yZSBp
bnN0cnVjdGlvbi4NCisgKiBAcGt0OiAgICAgICAgdGhlIENNRFEgcGFja2V0DQorICogQGFkZHI6
ICAgICAgIHBoeXNpY2FsIGFkZHJlc3Mgb2YgdGFyZ2V0IGluc3RydWN0aW9uIGJ1ZmZlcg0KKyAq
DQorICogUmV0dXJuOiAwIGZvciBzdWNjZXNzOyBlbHNlIHRoZSBlcnJvciBjb2RlIGlzIHJldHVy
bmVkDQorICovDQoraW50IGNtZHFfcGt0X2p1bXAoc3RydWN0IGNtZHFfcGt0ICpwa3QsIGRtYV9h
ZGRyX3QgYWRkcik7DQorDQogLyoqDQogICogY21kcV9wa3RfZmluYWxpemUoKSAtIEFwcGVuZCBF
T0MgYW5kIGp1bXAgY29tbWFuZCB0byBwa3QuDQogICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQot
LSANCjIuMTguMA0K

