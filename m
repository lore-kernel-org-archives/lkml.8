Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76D6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96165206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fkyRCUsu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgENIFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 04:05:09 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:26663 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725935AbgENIFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 04:05:09 -0400
X-UUID: 4fb1093cbcec4f18b37bac5a7521f79b-20200514
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=mrYggCzs9Es3fAAe5f56aAmDrVDKZRIo+656NWVNAmE=;
        b=fkyRCUsuWECnwmFc3f1cZXB24o/Glfzc2EQM5fLKOFMBPDIK7BEpRcyM51QiQdYGDlwyCu8ufO+euJxRm6XqxY4Tdfa0UAbehr5MPvGAjBbSTuEbh6x/h6T9MlrGz4bNaohU7K9pW4WKg3suI9K2fx3fHwhOA2Ur1pi+Kv2jq8A=;
X-UUID: 4fb1093cbcec4f18b37bac5a7521f79b-20200514
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 930876128; Thu, 14 May 2020 16:05:05 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 14 May 2020 16:05:01 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 14 May 2020 16:05:01 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Sergey Organov <sorganov@gmail.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>,
        Stan Lu <stan.lu@mediatek.com>
Subject: [PATCH] usb: gadget: u_serial: fix coverity warning: negative index at array
Date:   Thu, 14 May 2020 16:05:00 +0800
Message-ID: <1589443500-3990-1-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBpc3N1ZSBoYXMgYmVlbiByZXBvcnRlZCBieSBjb3Zlcml0eSBzY2FubmVyLg0KUmVwbGFj
ZSAiaW50IHBvcnRudW0iIGJ5ICJ1bnNpZ25lZCBpbnQiLCB0aGlzIHZvaWQgbmVnYXRpdmUgaW5k
ZXggYXQNCmFycmF5Lg0KDQpTaWduZWQtb2ZmLWJ5OiBTdGFuIEx1IDxzdGFuLmx1QG1lZGlhdGVr
LmNvbT4NClNpZ25lZC1vZmYtYnk6IE1hY3BhdWwgTGluIDxtYWNwYXVsLmxpbkBtZWRpYXRlay5j
b20+DQotLS0NCiBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYyB8ICAgIDQg
KystLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9zZXJpYWwuYyBiL2Ry
aXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3NlcmlhbC5jDQppbmRleCA4MTY3ZDM3Li41Mzk1
MWYyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3Vfc2VyaWFsLmMN
CisrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X3NlcmlhbC5jDQpAQCAtNTg3LDcg
KzU4Nyw3IEBAIHN0YXRpYyBpbnQgZ3Nfc3RhcnRfaW8oc3RydWN0IGdzX3BvcnQgKnBvcnQpDQog
ICovDQogc3RhdGljIGludCBnc19vcGVuKHN0cnVjdCB0dHlfc3RydWN0ICp0dHksIHN0cnVjdCBm
aWxlICpmaWxlKQ0KIHsNCi0JaW50CQlwb3J0X251bSA9IHR0eS0+aW5kZXg7DQorCXVuc2lnbmVk
IGludAlwb3J0X251bSA9IHR0eS0+aW5kZXg7DQogCXN0cnVjdCBnc19wb3J0CSpwb3J0Ow0KIAlp
bnQJCXN0YXR1cyA9IDA7DQogDQpAQCAtMTIxMSw3ICsxMjExLDcgQEAgaW50IGdzZXJpYWxfYWxs
b2NfbGluZV9ub19jb25zb2xlKHVuc2lnbmVkIGNoYXIgKmxpbmVfbnVtKQ0KIAlzdHJ1Y3QgZ3Nf
cG9ydAkJCSpwb3J0Ow0KIAlzdHJ1Y3QgZGV2aWNlCQkJKnR0eV9kZXY7DQogCWludAkJCQlyZXQ7
DQotCWludAkJCQlwb3J0X251bTsNCisJdW5zaWduZWQgaW50CQkJcG9ydF9udW07DQogDQogCWNv
ZGluZy5kd0RURVJhdGUgPSBjcHVfdG9fbGUzMig5NjAwKTsNCiAJY29kaW5nLmJDaGFyRm9ybWF0
ID0gODsNCi0tIA0KMS43LjkuNQ0K

