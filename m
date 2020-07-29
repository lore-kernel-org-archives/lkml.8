Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27ACAC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0764120809
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tenwb6XX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgG2Hjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 03:39:54 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:4514 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727026AbgG2Hjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 03:39:51 -0400
X-UUID: b124722788254b7490b25b97e4daac44-20200729
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=eB2IJ17uvfo0FspQJXyn1660hDC5oR6MCu06ojCR9Co=;
        b=tenwb6XXXywbH+ZU6VIkZ50W+yKXUO6OdJi6K2fH0yAuhCyXVfJpeAYuLjs1DHyA1xJhYHuKJIb7osToWZ0H1SO3MMIkNVKFQrwW+3jKXPhIvCrGPJQVYHSjoFiiKnW8IZugZ5w6ewRPEUK7zLqDIZLWOkf3vNgVpclbudHkVo8=;
X-UUID: b124722788254b7490b25b97e4daac44-20200729
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 543757748; Wed, 29 Jul 2020 15:39:47 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 29 Jul 2020 15:39:44 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 29 Jul 2020 15:39:45 +0800
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <seiya.wang@mediatek.com>, Crystal Guo <crystal.guo@mediatek.com>
Subject: [PATCH 1/2] reset-controller: ti: adjust the reset assert and deassert interface
Date:   Wed, 29 Jul 2020 15:39:16 +0800
Message-ID: <1596008357-11213-2-git-send-email-crystal.guo@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1596008357-11213-1-git-send-email-crystal.guo@mediatek.com>
References: <1596008357-11213-1-git-send-email-crystal.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHRpX3N5c2Nvbl9yZXNldCgpIHRvIGludGVncmF0ZSBhc3NlcnQgYW5kIGRlYXNzZXJ0IHRv
Z2V0aGVyLA0KYW5kIGNoYW5nZSByZXR1cm4gdmFsdWUgb2YgdGhlIHJlc2V0IGFzc2VydCBhbmQg
ZGVhc3NlcnQgaW50ZXJmYWNlDQpmcm9tIHJlZ21hcF91cGRhdGVfYml0cyB0byByZWdtYXBfd3Jp
dGVfYml0cy4NCg0Kd2hlbiBjbGVhciBiaXQgaXMgYWxyZWFkeSAxLCByZWdtYXBfdXBkYXRlX2Jp
dHMgY2FuIG5vdCB3cml0ZSAxIHRvIGl0IGFnYWluLg0KU29tZSBJQyBoYXMgdGhlIGZlYXR1cmUg
dGhhdCwgd2hlbiBzZXQgYml0IGlzIDEsIHRoZSBjbGVhciBiaXQgY2hhbmdlDQp0byAxIHRvZ2V0
aGVyLiBJdCB3aWxsIHRydWx5IGNsZWFyIGJpdCB0byAwIGJ5IHdyaXRlIDEgdG8gdGhlIGNsZWFy
IGJpdA0KDQpTaWduZWQtb2ZmLWJ5OiBDcnlzdGFsIEd1byA8Y3J5c3RhbC5ndW9AbWVkaWF0ZWsu
Y29tPg0KLS0tDQogZHJpdmVycy9yZXNldC9yZXNldC10aS1zeXNjb24uYyB8IDEzICsrKysrKysr
KysrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVzZXQvcmVzZXQtdGktc3lzY29uLmMgYi9kcml2ZXJz
L3Jlc2V0L3Jlc2V0LXRpLXN5c2Nvbi5jDQppbmRleCBhMjYzNWMyLi41YThlYzhmIDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9yZXNldC9yZXNldC10aS1zeXNjb24uYw0KKysrIGIvZHJpdmVycy9yZXNl
dC9yZXNldC10aS1zeXNjb24uYw0KQEAgLTg5LDcgKzg5LDcgQEAgc3RhdGljIGludCB0aV9zeXNj
b25fcmVzZXRfYXNzZXJ0KHN0cnVjdCByZXNldF9jb250cm9sbGVyX2RldiAqcmNkZXYsDQogCW1h
c2sgPSBCSVQoY29udHJvbC0+YXNzZXJ0X2JpdCk7DQogCXZhbHVlID0gKGNvbnRyb2wtPmZsYWdz
ICYgQVNTRVJUX1NFVCkgPyBtYXNrIDogMHgwOw0KIA0KLQlyZXR1cm4gcmVnbWFwX3VwZGF0ZV9i
aXRzKGRhdGEtPnJlZ21hcCwgY29udHJvbC0+YXNzZXJ0X29mZnNldCwgbWFzaywgdmFsdWUpOw0K
KwlyZXR1cm4gcmVnbWFwX3dyaXRlX2JpdHMoZGF0YS0+cmVnbWFwLCBjb250cm9sLT5hc3NlcnRf
b2Zmc2V0LCBtYXNrLCB2YWx1ZSk7DQogfQ0KIA0KIC8qKg0KQEAgLTEyMCw3ICsxMjAsNyBAQCBz
dGF0aWMgaW50IHRpX3N5c2Nvbl9yZXNldF9kZWFzc2VydChzdHJ1Y3QgcmVzZXRfY29udHJvbGxl
cl9kZXYgKnJjZGV2LA0KIAltYXNrID0gQklUKGNvbnRyb2wtPmRlYXNzZXJ0X2JpdCk7DQogCXZh
bHVlID0gKGNvbnRyb2wtPmZsYWdzICYgREVBU1NFUlRfU0VUKSA/IG1hc2sgOiAweDA7DQogDQot
CXJldHVybiByZWdtYXBfdXBkYXRlX2JpdHMoZGF0YS0+cmVnbWFwLCBjb250cm9sLT5kZWFzc2Vy
dF9vZmZzZXQsIG1hc2ssIHZhbHVlKTsNCisJcmV0dXJuIHJlZ21hcF93cml0ZV9iaXRzKGRhdGEt
PnJlZ21hcCwgY29udHJvbC0+ZGVhc3NlcnRfb2Zmc2V0LCBtYXNrLCB2YWx1ZSk7DQogfQ0KIA0K
IC8qKg0KQEAgLTE1OCwxMCArMTU4LDE5IEBAIHN0YXRpYyBpbnQgdGlfc3lzY29uX3Jlc2V0X3N0
YXR1cyhzdHJ1Y3QgcmVzZXRfY29udHJvbGxlcl9kZXYgKnJjZGV2LA0KIAkJIShjb250cm9sLT5m
bGFncyAmIFNUQVRVU19TRVQpOw0KIH0NCiANCitzdGF0aWMgaW50IHRpX3N5c2Nvbl9yZXNldChz
dHJ1Y3QgcmVzZXRfY29udHJvbGxlcl9kZXYgKnJjZGV2LA0KKwkJCSAgIHVuc2lnbmVkIGxvbmcg
aWQpDQorew0KKwl0aV9zeXNjb25fcmVzZXRfYXNzZXJ0KHJjZGV2LCBpZCk7DQorDQorCXJldHVy
biB0aV9zeXNjb25fcmVzZXRfZGVhc3NlcnQocmNkZXYsIGlkKTsNCit9DQorDQogc3RhdGljIGNv
bnN0IHN0cnVjdCByZXNldF9jb250cm9sX29wcyB0aV9zeXNjb25fcmVzZXRfb3BzID0gew0KIAku
YXNzZXJ0CQk9IHRpX3N5c2Nvbl9yZXNldF9hc3NlcnQsDQogCS5kZWFzc2VydAk9IHRpX3N5c2Nv
bl9yZXNldF9kZWFzc2VydCwNCiAJLnN0YXR1cwkJPSB0aV9zeXNjb25fcmVzZXRfc3RhdHVzLA0K
KwkucmVzZXQJCT0gdGlfc3lzY29uX3Jlc2V0LA0KIH07DQogDQogc3RhdGljIGludCB0aV9zeXNj
b25fcmVzZXRfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCi0tIA0KMS44LjEu
MS5kaXJ0eQ0K

