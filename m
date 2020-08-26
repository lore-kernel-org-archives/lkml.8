Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CA0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 05:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97E922076C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 05:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="q5/UzGFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgHZFCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 01:02:46 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50385 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725880AbgHZFCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 01:02:45 -0400
X-UUID: 3ad94a8d9640429fbcb6d4c03c8429f3-20200826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=LZGOQvRHmyPbkMCCtreR8dmbJ4eenqlWTBoYS5S2efk=;
        b=q5/UzGFS8IDHWqv7ZTbcytG6GHU/UYfqFov6nsigESfuP6EVSFZqkQ35ROKbY3G0C+8O5r5ExLYADlOS8T1klMB0tFhWXiWeM+VQJ0VWUmGBjEN7wk/ED2g9uxH7ttN78telveJoEwmv4A68qJvuKjXRlHiEjjuS0PLCiCQX9Zk=;
X-UUID: 3ad94a8d9640429fbcb6d4c03c8429f3-20200826
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <chih-en.hsu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1839887580; Wed, 26 Aug 2020 13:02:39 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Aug 2020 13:02:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Aug 2020 13:02:37 +0800
From:   Chih-En Hsu <chih-en.hsu@mediatek.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <Andrew-CT.Chen@mediatek.com>, <Michael.Mei@mediatek.com>,
        Chih-En Hsu <chih-en.hsu@mediatek.com>
Subject: [PATCH] nvmem: mtk-efuse: Remove EFUSE register write support
Date:   Wed, 26 Aug 2020 13:01:47 +0800
Message-ID: <20200826050145.24655-1-chih-en.hsu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A565F47BB12026B9CCB9E1F23E2296055C55981834A4D25BEDBBF1B87718B3DB2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBpcyB0byByZW1vdmUgZnVuY3Rpb24gIm10a19yZWdfd3JpdGUiIHNpbmNlDQpN
ZWRpYXRlayBFRlVTRSBoYXJkd2FyZSBvbmx5IHN1cHBvcnRzIHJlYWQgZnVuY3Rpb25hbGl0eQ0K
Zm9yIE5WTUVNIGNvbnN1bWVycy4NCg0KU2lnbmVkLW9mZi1ieTogQ2hpaC1FbiBIc3UgPGNoaWgt
ZW4uaHN1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvbnZtZW0vbXRrLWVmdXNlLmMgfCAx
NCAtLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxNCBkZWxldGlvbnMoLSkNCg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbnZtZW0vbXRrLWVmdXNlLmMgYi9kcml2ZXJzL252bWVtL210ay1l
ZnVzZS5jDQppbmRleCA4NTZkOWMzZmMzOGUuLjZhNTM3ZDk1OWYxNCAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvbnZtZW0vbXRrLWVmdXNlLmMNCisrKyBiL2RyaXZlcnMvbnZtZW0vbXRrLWVmdXNlLmMN
CkBAIC0yOCwxOSArMjgsNiBAQCBzdGF0aWMgaW50IG10a19yZWdfcmVhZCh2b2lkICpjb250ZXh0
LA0KIAlyZXR1cm4gMDsNCiB9DQogDQotc3RhdGljIGludCBtdGtfcmVnX3dyaXRlKHZvaWQgKmNv
bnRleHQsDQotCQkJIHVuc2lnbmVkIGludCByZWcsIHZvaWQgKl92YWwsIHNpemVfdCBieXRlcykN
Ci17DQotCXN0cnVjdCBtdGtfZWZ1c2VfcHJpdiAqcHJpdiA9IGNvbnRleHQ7DQotCXUzMiAqdmFs
ID0gX3ZhbDsNCi0JaW50IGkgPSAwLCB3b3JkcyA9IGJ5dGVzIC8gNDsNCi0NCi0Jd2hpbGUgKHdv
cmRzLS0pDQotCQl3cml0ZWwoKnZhbCsrLCBwcml2LT5iYXNlICsgcmVnICsgKGkrKyAqIDQpKTsN
Ci0NCi0JcmV0dXJuIDA7DQotfQ0KLQ0KIHN0YXRpYyBpbnQgbXRrX2VmdXNlX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogew0KIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRl
di0+ZGV2Ow0KQEAgLTYxLDcgKzQ4LDYgQEAgc3RhdGljIGludCBtdGtfZWZ1c2VfcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJZWNvbmZpZy5zdHJpZGUgPSA0Ow0KIAllY29u
ZmlnLndvcmRfc2l6ZSA9IDQ7DQogCWVjb25maWcucmVnX3JlYWQgPSBtdGtfcmVnX3JlYWQ7DQot
CWVjb25maWcucmVnX3dyaXRlID0gbXRrX3JlZ193cml0ZTsNCiAJZWNvbmZpZy5zaXplID0gcmVz
b3VyY2Vfc2l6ZShyZXMpOw0KIAllY29uZmlnLnByaXYgPSBwcml2Ow0KIAllY29uZmlnLmRldiA9
IGRldjsNCi0tIA0KMi4xOC4wDQo=

