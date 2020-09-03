Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8B2C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 03:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 259DD2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 03:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="k7yITeuz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgICDb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 23:31:27 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:20248 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726814AbgICDb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 23:31:26 -0400
X-UUID: 9e659e22f642458dbc5337c05c54f431-20200903
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=hociBLiC64wu1IzlEev33FmaQGVirv5h4VmmTW9yoM8=;
        b=k7yITeuz0KU582V07H75BwE3yF+BIJEzxiPibfmNydKLgRBh10lm06dONh04fwmEHEYMB+BuqDujlC9Jo7hyhMH74k59QkEuCNsk3+u1Zub9TzJAlPn5amDb/TJflLmsvhpi8SnvHJwdhJgOzzwwE3ryrUF61Hs9IesUAtXqJ4o=;
X-UUID: 9e659e22f642458dbc5337c05c54f431-20200903
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1268380734; Thu, 03 Sep 2020 11:31:18 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 3 Sep 2020 11:31:14 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 3 Sep 2020 11:31:16 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Zhanyong Wang <zhanyong.wang@mediatek.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: [RFC PATCH 2/4] usb: xhci-mtk: add mt8192 wakeup
Date:   Thu, 3 Sep 2020 11:28:57 +0800
Message-ID: <1599103739-7873-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1599103739-7873-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1599103739-7873-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: FEB47EC28599F8900A1B88EC2B675D27B0B83DB643C6363D646DBF0A312870782000:8
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

