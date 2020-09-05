Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B908C433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34EF62074D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 08:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="edesmhfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgIEINJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 04:13:09 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:58408 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728465AbgIEINF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 04:13:05 -0400
X-UUID: 7f8506d2f66d43f4a5a9f6d754d03d14-20200905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=myVFj1U3iRi7Gh4AobiqyuhDtViW2dsfHPIq8FoB+qY=;
        b=edesmhfC1p2Yep/nIwnAGF9/SVw6wgFjSSiGtrYUdAYPMQYM6ltkkbQG/A2NzYzssfMT+Q7EGJIDe6J7uYdM6bmIKiMS42tG+bJHMms9N+OHre8hndSCLTMDBztO/yMsxSiuwuw7pxrLkBcB8rSL4lIuHMF/JojXYmY2LuPHyf4=;
X-UUID: 7f8506d2f66d43f4a5a9f6d754d03d14-20200905
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2035466605; Sat, 05 Sep 2020 16:13:02 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 5 Sep 2020 16:12:59 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 5 Sep 2020 16:12:59 +0800
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
Subject: [PATCH v2 12/23] iommu/mediatek: Move hw_init into attach_device
Date:   Sat, 5 Sep 2020 16:09:09 +0800
Message-ID: <20200905080920.13396-13-yong.wu@mediatek.com>
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

SW4gYXR0YWNoIGRldmljZSwgaXQgd2lsbCB1cGRhdGUgdGhlIHBhZ2V0YWJsZSBiYXNlIGFkZHJl
c3MgcmVnaXN0ZXIuDQpNb3ZlIHRoZSBod19pbml0IGZ1bmN0aW9uIGFsc28gaGVyZS4gVGhlbiBp
dCBvbmx5IG5lZWQgY2FsbA0KcG1fcnVudGltZV9nZXQvcHV0IG9uZSB0aW1lIGhlcmUgaWYgbTR1
IGhhcyBwb3dlciBkb21haW4uDQoNClNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVk
aWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyB8IDEwICsrKysrKy0t
LS0NCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvbXRr
X2lvbW11LmMNCmluZGV4IDZlODVjOTk3NmEzMy4uOTQwYjdhOTE5MWIyIDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUu
Yw0KQEAgLTEyMiw2ICsxMjIsOCBAQCBzdHJ1Y3QgbXRrX2lvbW11X2RvbWFpbiB7DQogDQogc3Rh
dGljIGNvbnN0IHN0cnVjdCBpb21tdV9vcHMgbXRrX2lvbW11X29wczsNCiANCitzdGF0aWMgaW50
IG10a19pb21tdV9od19pbml0KGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfZGF0YSAqZGF0YSk7DQor
DQogLyoNCiAgKiBJbiBNNFUgNEdCIG1vZGUsIHRoZSBwaHlzaWNhbCBhZGRyZXNzIGlzIHJlbWFw
cGVkIGFzIGJlbG93Og0KICAqDQpAQCAtMzc3LDEyICszNzksMTYgQEAgc3RhdGljIGludCBtdGtf
aW9tbXVfYXR0YWNoX2RldmljZShzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4sDQogew0KIAlz
dHJ1Y3QgbXRrX2lvbW11X2RhdGEgKmRhdGEgPSBkZXZfaW9tbXVfcHJpdl9nZXQoZGV2KTsNCiAJ
c3RydWN0IG10a19pb21tdV9kb21haW4gKmRvbSA9IHRvX210a19kb21haW4oZG9tYWluKTsNCisJ
aW50IHJldDsNCiANCiAJaWYgKCFkYXRhKQ0KIAkJcmV0dXJuIC1FTk9ERVY7DQogDQogCS8qIFVw
ZGF0ZSB0aGUgcGd0YWJsZSBiYXNlIGFkZHJlc3MgcmVnaXN0ZXIgb2YgdGhlIE00VSBIVyAqLw0K
IAlpZiAoIWRhdGEtPm00dV9kb20pIHsNCisJCXJldCA9IG10a19pb21tdV9od19pbml0KGRhdGEp
Ow0KKwkJaWYgKHJldCkNCisJCQlyZXR1cm4gcmV0Ow0KIAkJZGF0YS0+bTR1X2RvbSA9IGRvbTsN
CiAJCXdyaXRlbChkb20tPmNmZy5hcm1fdjdzX2NmZy50dGJyICYgTU1VX1BUX0FERFJfTUFTSywN
CiAJCSAgICAgICBkYXRhLT5iYXNlICsgUkVHX01NVV9QVF9CQVNFX0FERFIpOw0KQEAgLTcwNSwx
MCArNzExLDYgQEAgc3RhdGljIGludCBtdGtfaW9tbXVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikNCiANCiAJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgZGF0YSk7DQogDQot
CXJldCA9IG10a19pb21tdV9od19pbml0KGRhdGEpOw0KLQlpZiAocmV0KQ0KLQkJcmV0dXJuIHJl
dDsNCi0NCiAJcmV0ID0gaW9tbXVfZGV2aWNlX3N5c2ZzX2FkZCgmZGF0YS0+aW9tbXUsIGRldiwg
TlVMTCwNCiAJCQkJICAgICAibXRrLWlvbW11LiVwYSIsICZpb2FkZHIpOw0KIAlpZiAocmV0KQ0K
LS0gDQoyLjE4LjANCg==

