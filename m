Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A0BC28E83
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A7E1206CA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WZAyFRkq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbgIDIRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 04:17:49 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:22139 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729744AbgIDIRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 04:17:44 -0400
X-UUID: d66e97dddf924caf96f81c241837bf5f-20200904
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=8rRrbCmdA3reTEcnRumgB1k/g3lTeehQQDEOoft6l6Y=;
        b=WZAyFRkqGESgqiNjzJnb3RA0PdEM+n1eHQWK9FkN19RiEpp1bEQj6M5mwT7nxxfGsGbAzkU2mx1jhS3mGqNUOqyCxnVOBGKBzS0Z0ilzFnndbY1nMHlIGOVLOKtA5gBI2feKosYfZzppVebNq/uXTgRRw7TUseTXks4c6INc1aY=;
X-UUID: d66e97dddf924caf96f81c241837bf5f-20200904
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1262005186; Fri, 04 Sep 2020 16:17:32 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 4 Sep 2020 16:17:30 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Sep 2020 16:17:29 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Zhanyong Wang <zhanyong.wang@mediatek.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: [RFC PATCH v2 2/4] usb: xhci-mtk: add mt8192 wakeup
Date:   Fri, 4 Sep 2020 16:15:38 +0800
Message-ID: <1599207340-4673-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1599207340-4673-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1599207340-4673-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 2EBBA91619F7DF239197DD7B7CD12799BA62E7C589CD9089C0DA839B21AE0BD52000:8
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
LmNvbT4NCi0tLQ0KdjI6IG5vIGNoYW5nZXMNCi0tLQ0KIGRyaXZlcnMvdXNiL2hvc3QveGhjaS1t
dGsuYyB8IDkgKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQ0KIG1v
ZGUgY2hhbmdlIDEwMDY0NCA9PiAxMDA3NTUgZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5jDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMgYi9kcml2ZXJzL3VzYi9o
b3N0L3hoY2ktbXRrLmMNCm9sZCBtb2RlIDEwMDY0NA0KbmV3IG1vZGUgMTAwNzU1DQppbmRleCA0
MzExZDRjLi5kOTUyMjFmDQotLS0gYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMNCisrKyBi
L2RyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGsuYw0KQEAgLTY4LDkgKzY4LDEzIEBADQogI2RlZmlu
ZSBTU0NfSVBfU0xFRVBfRU4JQklUKDQpDQogI2RlZmluZSBTU0NfU1BNX0lOVF9FTgkJQklUKDEp
DQogDQorLyogbXQ4MTkyIGV0YyAqLw0KKyNkZWZpbmUgU1NDX0lQX1NMRUVQX0VOX1YzCUJJVCg2
KQ0KKw0KIGVudW0gc3N1c2JfdXdrX3ZlcnMgew0KIAlTU1VTQl9VV0tfVjEgPSAxLA0KIAlTU1VT
Ql9VV0tfVjIsDQorCVNTVVNCX1VXS19WMywNCiB9Ow0KIA0KIHN0YXRpYyBpbnQgeGhjaV9tdGtf
aG9zdF9lbmFibGUoc3RydWN0IHhoY2lfaGNkX210ayAqbXRrKQ0KQEAgLTMwNSw2ICszMDksMTEg
QEAgc3RhdGljIHZvaWQgdXNiX3dha2V1cF9pcF9zbGVlcF9zZXQoc3RydWN0IHhoY2lfaGNkX210
ayAqbXRrLCBib29sIGVuYWJsZSkNCiAJCW1zayA9IFNTQ19JUF9TTEVFUF9FTiB8IFNTQ19TUE1f
SU5UX0VOOw0KIAkJdmFsID0gZW5hYmxlID8gbXNrIDogMDsNCiAJCWJyZWFrOw0KKwljYXNlIFNT
VVNCX1VXS19WMzoNCisJCXJlZyA9IG10ay0+dXdrX3JlZ19iYXNlICsgUEVSSV9TU1VTQl9TUE1f
Q1RSTDsNCisJCW1zayA9IFNTQ19JUF9TTEVFUF9FTl9WMyB8IFNTQ19TUE1fSU5UX0VOOw0KKwkJ
dmFsID0gZW5hYmxlID8gbXNrIDogMDsNCisJCWJyZWFrOw0KIAlkZWZhdWx0Og0KIAkJcmV0dXJu
Ow0KIAl9DQotLSANCjEuOS4xDQo=

