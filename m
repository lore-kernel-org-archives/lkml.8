Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D596BC433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 03:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B23EB207D3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 03:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="meF3D7oR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgICDg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 23:36:28 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:54968 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726654AbgICDgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 23:36:19 -0400
X-UUID: daab6e5d5257429b9eacd53c8bb73a45-20200903
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=hociBLiC64wu1IzlEev33FmaQGVirv5h4VmmTW9yoM8=;
        b=meF3D7oRcYuLgAOhGuujO/DDZP1Z9KtTnQb7l/IUO7xLXuhpBwlTfhLjw9WdCScQ4cSqz81d7DDqFBOYCg2pYM1p0EBU+3neqkqrns8hnZO9MrlDqXi8IAdVmf52pY7oXGTktNmmVjh9P7PxZDTFdob+WaqFe9c7p9ScLLiiXUE=;
X-UUID: daab6e5d5257429b9eacd53c8bb73a45-20200903
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 221452166; Thu, 03 Sep 2020 11:36:10 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 3 Sep 2020 11:36:06 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 3 Sep 2020 11:36:07 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Zhanyong Wang <zhanyong.wang@mediatek.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: [RFC PATCH 2/4] usb: xhci-mtk: add mt8192 wakeup
Date:   Thu, 3 Sep 2020 11:34:23 +0800
Message-ID: <1599104065-8009-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1599104065-8009-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1599104065-8009-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 78442EDDB1CD2F3D493CEF97F4919CCBDEE74B2861E492BE5451E4E9E612BDD72000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWmhhbnlvbmcgV2FuZyA8emhhbnlvbmcud2FuZ0BtZWRpYXRlay5jb20+DQoNCm5lZWQg
dG8gYWRkIHdha2V1cCBzb2x1dGlvbiBhcyBWMw0Kc2luY2Ugbm90IHN1cHBvcnQgcHJlc2VudGx5
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBaaGFueW9uZyBXYW5nIDx6aGFueW9uZy53YW5nQG1lZGlhdGVr
LmNvbT4NClNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVr
LmNvbT4NCi0tLQ0KIGRyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGsuYyB8IDkgKysrKysrKysrDQog
MSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQ0KIG1vZGUgY2hhbmdlIDEwMDY0NCA9PiAx
MDA3NTUgZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5jDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L3VzYi9ob3N0L3hoY2ktbXRrLmMgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMNCm9sZCBt
b2RlIDEwMDY0NA0KbmV3IG1vZGUgMTAwNzU1DQppbmRleCA0MzExZDRjLi5kOTUyMjFmDQotLS0g
YS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMNCisrKyBiL2RyaXZlcnMvdXNiL2hvc3QveGhj
aS1tdGsuYw0KQEAgLTY4LDkgKzY4LDEzIEBADQogI2RlZmluZSBTU0NfSVBfU0xFRVBfRU4JQklU
KDQpDQogI2RlZmluZSBTU0NfU1BNX0lOVF9FTgkJQklUKDEpDQogDQorLyogbXQ4MTkyIGV0YyAq
Lw0KKyNkZWZpbmUgU1NDX0lQX1NMRUVQX0VOX1YzCUJJVCg2KQ0KKw0KIGVudW0gc3N1c2JfdXdr
X3ZlcnMgew0KIAlTU1VTQl9VV0tfVjEgPSAxLA0KIAlTU1VTQl9VV0tfVjIsDQorCVNTVVNCX1VX
S19WMywNCiB9Ow0KIA0KIHN0YXRpYyBpbnQgeGhjaV9tdGtfaG9zdF9lbmFibGUoc3RydWN0IHho
Y2lfaGNkX210ayAqbXRrKQ0KQEAgLTMwNSw2ICszMDksMTEgQEAgc3RhdGljIHZvaWQgdXNiX3dh
a2V1cF9pcF9zbGVlcF9zZXQoc3RydWN0IHhoY2lfaGNkX210ayAqbXRrLCBib29sIGVuYWJsZSkN
CiAJCW1zayA9IFNTQ19JUF9TTEVFUF9FTiB8IFNTQ19TUE1fSU5UX0VOOw0KIAkJdmFsID0gZW5h
YmxlID8gbXNrIDogMDsNCiAJCWJyZWFrOw0KKwljYXNlIFNTVVNCX1VXS19WMzoNCisJCXJlZyA9
IG10ay0+dXdrX3JlZ19iYXNlICsgUEVSSV9TU1VTQl9TUE1fQ1RSTDsNCisJCW1zayA9IFNTQ19J
UF9TTEVFUF9FTl9WMyB8IFNTQ19TUE1fSU5UX0VOOw0KKwkJdmFsID0gZW5hYmxlID8gbXNrIDog
MDsNCisJCWJyZWFrOw0KIAlkZWZhdWx0Og0KIAkJcmV0dXJuOw0KIAl9DQotLSANCjEuOS4xDQo=

