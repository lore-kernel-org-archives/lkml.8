Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387DEC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2B8221D7A
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sBktYEyC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbgIIHfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:35:34 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:23294 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727055AbgIIHfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:35:17 -0400
X-UUID: 3f0189de9c5c468bb2010fcccb384438-20200909
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Q0p4czr84XYZ0qBgAfFPrawGlMUYs3mqiKwpRcor5wM=;
        b=sBktYEyC8UY1Ha0D6Rl8ufUayn+zLSaRVLwp1Adxd5qnvYgd5aZzHYzWTpCu0jlZ7me2rHq3z2753xTYP8e4tfMfVVuewNqOiA7kas4UGo5ggQW1ztrx/QOgIamhgisrGpLJ3DqaeWSUOnDnycshpQJV537XUz4/MUViXny6/ww=;
X-UUID: 3f0189de9c5c468bb2010fcccb384438-20200909
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2034636427; Wed, 09 Sep 2020 15:35:12 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 9 Sep 2020 15:35:06 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Sep 2020 15:35:05 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Al Cooper <alcooperx@gmail.com>,
        Peter Chen <peter.chen@nxp.com>, Bin Liu <b-liu@ti.com>,
        Sasi Kumar <sasi.kumar@broadcom.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v3 02/11] usb: gadget: bdc: remove bdc_ep_set_halt() declaration
Date:   Wed, 9 Sep 2020 15:32:53 +0800
Message-ID: <1599636782-7654-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1599636782-7654-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1599636782-7654-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 1C32FB86D9DB1A03C545F5F6ABFCD31B1FE79A7F9725C6FCC8412FCBFBAC55472000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tm8gZGVmaW5pdGlvbiBmb3IgYmRjX2VwX3NldF9oYWx0KCksIHNvIHJlbW92ZSBpdC4NCg0KQ2M6
IEZsb3JpYW4gRmFpbmVsbGkgPGYuZmFpbmVsbGlAZ21haWwuY29tPg0KU2lnbmVkLW9mZi1ieTog
Q2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KQWNrZWQtYnk6IEZsb3Jp
YW4gRmFpbmVsbGkgPGYuZmFpbmVsbGlAZ21haWwuY29tPg0KLS0tDQp2MzogYWRkIGFja2VkLWJ5
IEZsb3JpYW4NCg0KdjI6IGFkZCBDYyBGbG9yaWFuDQotLS0NCiBkcml2ZXJzL3VzYi9nYWRnZXQv
dWRjL2JkYy9iZGNfY21kLmggfCAxIC0NCiAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0K
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2NtZC5oIGIvZHJp
dmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2NtZC5oDQppbmRleCAzNzNlNjc0Li5hM2E2ZGJk
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2NtZC5oDQorKysg
Yi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfY21kLmgNCkBAIC0xNiw3ICsxNiw2IEBA
DQogaW50IGJkY19zdG9wX2VwKHN0cnVjdCBiZGMgKiwgaW50KTsNCiBpbnQgYmRjX2VwX3NldF9z
dGFsbChzdHJ1Y3QgYmRjICosIGludCk7DQogaW50IGJkY19lcF9jbGVhcl9zdGFsbChzdHJ1Y3Qg
YmRjICosIGludCk7DQotaW50IGJkY19lcF9zZXRfaGFsdChzdHJ1Y3QgYmRjX2VwICosIHUzMiAs
IGludCk7DQogaW50IGJkY19lcF9ibGEoc3RydWN0IGJkYyAqLCBzdHJ1Y3QgYmRjX2VwICosIGRt
YV9hZGRyX3QpOw0KIGludCBiZGNfZnVuY3Rpb25fd2FrZShzdHJ1Y3QgYmRjKiwgdTgpOw0KIGlu
dCBiZGNfZnVuY3Rpb25fd2FrZV9maChzdHJ1Y3QgYmRjKiwgdTgpOw0KLS0gDQoxLjkuMQ0K

