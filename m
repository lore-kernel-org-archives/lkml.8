Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7796DC433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 387E02074D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="nBZzkx4a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgIEINf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 04:13:35 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:5315 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728514AbgIEINa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 04:13:30 -0400
X-UUID: 43cf2ef8dfe24453a2b484204e67ff2b-20200905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Xyql66Axq7r0/zD3VtLzwTuEdmn0pBqUypd/sipGyzI=;
        b=nBZzkx4aThrlSW11aIafCoNwIXFiaPnoiIIh6+TwKa91g6V+3TDKYQnxQv4vvofCeG/l1lOX/JPY5gBJKPiWrJSvTzHd4Lg9kcVQ6sHm+oeqiUUxereBpkMYQUJIhzMOoqGTzr2bcC/paGuyHZ6fQqYKPbZo8f/fw/3sgbtgPTc=;
X-UUID: 43cf2ef8dfe24453a2b484204e67ff2b-20200905
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 289913520; Sat, 05 Sep 2020 16:13:24 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 5 Sep 2020 16:13:21 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 5 Sep 2020 16:13:21 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Will Deacon <will@kernel.org>, Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>
Subject: [PATCH v2 14/23] iommu/mediatek: Add power-domain operation
Date:   Sat, 5 Sep 2020 16:09:11 +0800
Message-ID: <20200905080920.13396-15-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200905080920.13396-1-yong.wu@mediatek.com>
References: <20200905080920.13396-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gdGhlIHByZXZpb3VzIFNvQywgdGhlIE00VSBIVyBpcyBpbiB0aGUgRU1JIHBvd2VyIGRvbWFp
biB3aGljaCBpcw0KYWx3YXlzIG9uLiB0aGUgbGF0ZXN0IE00VSBpcyBpbiB0aGUgZGlzcGxheSBw
b3dlciBkb21haW4gd2hpY2ggbWF5IGJlDQp0dXJuZWQgb24vb2ZmLCB0aHVzIHdlIGhhdmUgdG8g
YWRkIHBtX3J1bnRpbWUgaW50ZXJmYWNlIGZvciBpdC4NCg0KV2hlbiB0aGUgZW5naW5lIHdvcmss
IHRoZSBlbmdpbmUgYWx3YXlzIGVuYWJsZSB0aGUgcG93ZXIgYW5kIGNsb2NrcyBmb3INCnNtaS1s
YXJiL3NtaS1jb21tb24sIHRoZW4gdGhlIE00VSdzIHBvd2VyIHdpbGwgYWx3YXlzIGJlIHBvd2Vy
ZWQgb24NCmF1dG9tYXRpY2FsbHkgdmlhIHRoZSBkZXZpY2UgbGluayB3aXRoIHNtaS1jb21tb24u
DQoNCk5vdGU6IHdlIGRvbid0IGVuYWJsZSB0aGUgTTRVIHBvd2VyIGluIGlvbW11X21hcC91bm1h
cCBmb3IgdGxiIGZsdXNoLg0KSWYgaXRzIHBvd2VyIGFscmVhZHkgaXMgb24sIG9mIGNvdXJzZSBp
dCBpcyBvay4gaWYgdGhlIHBvd2VyIGlzIG9mZiwNCnRoZSBtYWluIHRsYiB3aWxsIGJlIHJlc2V0
IHdoaWxlIE00VSBwb3dlciBvbiwgdGh1cyB0aGUgdGxiIGZsdXNoIHdoaWxlDQptNHUgcG93ZXIg
b2ZmIGlzIHVubmVjZXNzYXJ5LCBqdXN0IHNraXAgaXQuDQoNClNpZ25lZC1vZmYtYnk6IFlvbmcg
V3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9pb21tdS9tdGtfaW9tbXUu
YyB8IDMzICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCAyNyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9pb21tdS9tdGtfaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCmluZGV4IDY4
ZGU1OWUwZDUyMS4uZDIyNzcyZWM2NGM4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pb21tdS9tdGtf
aW9tbXUuYw0KKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KQEAgLTE5Niw2ICsxOTYs
MTAgQEAgc3RhdGljIHZvaWQgbXRrX2lvbW11X3RsYl9mbHVzaF9yYW5nZV9zeW5jKHVuc2lnbmVk
IGxvbmcgaW92YSwgc2l6ZV90IHNpemUsDQogCXUzMiB0bXA7DQogDQogCWZvcl9lYWNoX200dShk
YXRhKSB7DQorCQkvKiBza2lwIHRsYiBmbHVzaCB3aGVuIHBtIGlzIG5vdCBhY3RpdmUuICovDQor
CQlpZiAoIXBtX3J1bnRpbWVfYWN0aXZlKGRhdGEtPmRldikpDQorCQkJY29udGludWU7DQorDQog
CQlzcGluX2xvY2tfaXJxc2F2ZSgmZGF0YS0+dGxiX2xvY2ssIGZsYWdzKTsNCiAJCXdyaXRlbF9y
ZWxheGVkKEZfSU5WTERfRU4xIHwgRl9JTlZMRF9FTjAsDQogCQkJICAgICAgIGRhdGEtPmJhc2Ug
KyBkYXRhLT5wbGF0X2RhdGEtPmludl9zZWxfcmVnKTsNCkBAIC0zODAsNiArMzg0LDcgQEAgc3Rh
dGljIGludCBtdGtfaW9tbXVfYXR0YWNoX2RldmljZShzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21h
aW4sDQogew0KIAlzdHJ1Y3QgbXRrX2lvbW11X2RhdGEgKmRhdGEgPSBkZXZfaW9tbXVfcHJpdl9n
ZXQoZGV2KTsNCiAJc3RydWN0IG10a19pb21tdV9kb21haW4gKmRvbSA9IHRvX210a19kb21haW4o
ZG9tYWluKTsNCisJc3RydWN0IGRldmljZSAqbTR1ZGV2ID0gZGF0YS0+ZGV2Ow0KIAlpbnQgcmV0
Ow0KIA0KIAlpZiAoIWRhdGEpDQpAQCAtMzg3LDEyICszOTIsMTggQEAgc3RhdGljIGludCBtdGtf
aW9tbXVfYXR0YWNoX2RldmljZShzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4sDQogDQogCS8q
IFVwZGF0ZSB0aGUgcGd0YWJsZSBiYXNlIGFkZHJlc3MgcmVnaXN0ZXIgb2YgdGhlIE00VSBIVyAq
Lw0KIAlpZiAoIWRhdGEtPm00dV9kb20pIHsNCisJCXJldCA9IHBtX3J1bnRpbWVfZ2V0X3N5bmMo
bTR1ZGV2KTsNCisJCWlmIChyZXQgPCAwKQ0KKwkJCXJldHVybiByZXQ7DQogCQlyZXQgPSBtdGtf
aW9tbXVfaHdfaW5pdChkYXRhKTsNCi0JCWlmIChyZXQpDQorCQlpZiAocmV0KSB7DQorCQkJcG1f
cnVudGltZV9wdXQobTR1ZGV2KTsNCiAJCQlyZXR1cm4gcmV0Ow0KKwkJfQ0KIAkJZGF0YS0+bTR1
X2RvbSA9IGRvbTsNCiAJCXdyaXRlbChkb20tPmNmZy5hcm1fdjdzX2NmZy50dGJyICYgTU1VX1BU
X0FERFJfTUFTSywNCiAJCSAgICAgICBkYXRhLT5iYXNlICsgUkVHX01NVV9QVF9CQVNFX0FERFIp
Ow0KKwkJcG1fcnVudGltZV9wdXQobTR1ZGV2KTsNCiAJfQ0KIA0KIAltdGtfaW9tbXVfY29uZmln
KGRhdGEsIGRldiwgdHJ1ZSk7DQpAQCAtNzIyLDEwICs3MzMsMTMgQEAgc3RhdGljIGludCBtdGtf
aW9tbXVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJaWYgKGRldi0+cG1f
ZG9tYWluKSB7DQogCQlzdHJ1Y3QgZGV2aWNlX2xpbmsgKmxpbms7DQogDQorCQlwbV9ydW50aW1l
X2VuYWJsZShkZXYpOw0KKw0KIAkJbGluayA9IGRldmljZV9saW5rX2FkZChkYXRhLT5zbWljb21t
X2RldiwgZGV2LA0KIAkJCQkgICAgICAgRExfRkxBR19TVEFURUxFU1MgfCBETF9GTEFHX1BNX1JV
TlRJTUUpOw0KIAkJaWYgKCFsaW5rKSB7DQogCQkJZGV2X2VycihkZXYsICJVbmFibGUgbGluayAl
cy5cbiIsIGRldl9uYW1lKGRhdGEtPnNtaWNvbW1fZGV2KSk7DQorCQkJcG1fcnVudGltZV9kaXNh
YmxlKGRldik7DQogCQkJcmV0dXJuIC1FSU5WQUw7DQogCQl9DQogCX0NCkBAIC03NTIsOCArNzY2
LDEwIEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQogDQogCXJldHVybiBjb21wb25lbnRfbWFzdGVyX2FkZF93aXRoX21hdGNoKGRldiwg
Jm10a19pb21tdV9jb21fb3BzLCBtYXRjaCk7DQogb3V0Og0KLQlpZiAoZGV2LT5wbV9kb21haW4p
DQorCWlmIChkZXYtPnBtX2RvbWFpbikgew0KIAkJZGV2aWNlX2xpbmtfcmVtb3ZlKGRhdGEtPnNt
aWNvbW1fZGV2LCBkZXYpOw0KKwkJcG1fcnVudGltZV9kaXNhYmxlKGRldik7DQorCX0NCiAJcmV0
dXJuIHJldDsNCiB9DQogDQpAQCAtNzY4LDggKzc4NCwxMCBAQCBzdGF0aWMgaW50IG10a19pb21t
dV9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJCWJ1c19zZXRfaW9tbXUo
JnBsYXRmb3JtX2J1c190eXBlLCBOVUxMKTsNCiANCiAJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGRh
dGEtPmJjbGspOw0KLQlpZiAocGRldi0+ZGV2LnBtX2RvbWFpbikNCisJaWYgKHBkZXYtPmRldi5w
bV9kb21haW4pIHsNCiAJCWRldmljZV9saW5rX3JlbW92ZShkYXRhLT5zbWljb21tX2RldiwgJnBk
ZXYtPmRldik7DQorCQlwbV9ydW50aW1lX2Rpc2FibGUoJnBkZXYtPmRldik7DQorCX0NCiAJZGV2
bV9mcmVlX2lycSgmcGRldi0+ZGV2LCBkYXRhLT5pcnEsIGRhdGEpOw0KIAljb21wb25lbnRfbWFz
dGVyX2RlbCgmcGRldi0+ZGV2LCAmbXRrX2lvbW11X2NvbV9vcHMpOw0KIAlyZXR1cm4gMDsNCkBA
IC04MDEsNiArODE5LDkgQEAgc3RhdGljIGludCBfX21heWJlX3VudXNlZCBtdGtfaW9tbXVfcmVz
dW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCiAJdm9pZCBfX2lvbWVtICpiYXNlID0gZGF0YS0+YmFz
ZTsNCiAJaW50IHJldDsNCiANCisJLyogQXZvaWQgZmlyc3QgcmVzdW1lIHRvIGFmZmVjdCB0aGUg
ZGVmYXVsdCB2YWx1ZSBvZiByZWdpc3RlcnMgYmVsb3cuICovDQorCWlmICghbTR1X2RvbSkNCisJ
CXJldHVybiAwOw0KIAlyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoZGF0YS0+YmNsayk7DQogCWlm
IChyZXQpIHsNCiAJCWRldl9lcnIoZGF0YS0+ZGV2LCAiRmFpbGVkIHRvIGVuYWJsZSBjbGsoJWQp
IGluIHJlc3VtZVxuIiwgcmV0KTsNCkBAIC04MTQsMTMgKzgzNSwxMyBAQCBzdGF0aWMgaW50IF9f
bWF5YmVfdW51c2VkIG10a19pb21tdV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KIAl3cml0
ZWxfcmVsYXhlZChyZWctPmludF9tYWluX2NvbnRyb2wsIGJhc2UgKyBSRUdfTU1VX0lOVF9NQUlO
X0NPTlRST0wpOw0KIAl3cml0ZWxfcmVsYXhlZChyZWctPml2cnBfcGFkZHIsIGJhc2UgKyBSRUdf
TU1VX0lWUlBfUEFERFIpOw0KIAl3cml0ZWxfcmVsYXhlZChyZWctPnZsZF9wYV9ybmcsIGJhc2Ug
KyBSRUdfTU1VX1ZMRF9QQV9STkcpOw0KLQlpZiAobTR1X2RvbSkNCi0JCXdyaXRlbChtNHVfZG9t
LT5jZmcuYXJtX3Y3c19jZmcudHRiciAmIE1NVV9QVF9BRERSX01BU0ssDQotCQkgICAgICAgYmFz
ZSArIFJFR19NTVVfUFRfQkFTRV9BRERSKTsNCisJd3JpdGVsKG00dV9kb20tPmNmZy5hcm1fdjdz
X2NmZy50dGJyICYgTU1VX1BUX0FERFJfTUFTSywNCisJICAgICAgIGJhc2UgKyBSRUdfTU1VX1BU
X0JBU0VfQUREUik7DQogCXJldHVybiAwOw0KIH0NCiANCiBzdGF0aWMgY29uc3Qgc3RydWN0IGRl
dl9wbV9vcHMgbXRrX2lvbW11X3BtX29wcyA9IHsNCisJU0VUX1JVTlRJTUVfUE1fT1BTKG10a19p
b21tdV9zdXNwZW5kLCBtdGtfaW9tbXVfcmVzdW1lLCBOVUxMKQ0KIAlTRVRfTk9JUlFfU1lTVEVN
X1NMRUVQX1BNX09QUyhtdGtfaW9tbXVfc3VzcGVuZCwgbXRrX2lvbW11X3Jlc3VtZSkNCiB9Ow0K
IA0KLS0gDQoyLjE4LjANCg==

