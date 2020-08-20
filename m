Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDD0C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC06C204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TyIR5gYu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbgHTLhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:37:06 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:33992 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730457AbgHTLcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 07:32:51 -0400
X-UUID: 572a0bdfa57348b89cba30058469884b-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=1ZM5s5BYzq7pphBdN+ofbtbj4e0WXbm2jK+xsz7OBvs=;
        b=TyIR5gYuyNNs2HXIzYP9NTymrhv65MdgnSAaUgAr7PjtuNMKWgxyv9UY5PJjlMUCDBVSGqSoJ8xKqtVHegC0P8xuBMoq4irrX0VW+Z64l8fpjMEL39gF4UM5eUPj0REio30SKld1d6SJzbIIGkSjCesKfHGC05hCZ/9bTNBudaU=;
X-UUID: 572a0bdfa57348b89cba30058469884b-20200820
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 547291087; Thu, 20 Aug 2020 19:32:23 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 19:32:23 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 19:32:20 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Al Cooper <alcooperx@gmail.com>,
        Sasi Kumar <sasi.kumar@broadcom.com>,
        Peter Chen <peter.chen@nxp.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 02/11] usb: gadget: bdc: remove bdc_ep_set_halt() declaration
Date:   Thu, 20 Aug 2020 19:30:37 +0800
Message-ID: <1597923046-12535-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597923046-12535-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1597923046-12535-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 993446BD67BC065C383253FCC3998DD75C623113F854E26AD8DA7CFDA7CEDF122000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tm8gZGVmaW5pdGlvbiBmb3IgYmRjX2VwX3NldF9oYWx0KCksIHNvIHJlbW92ZSBpdC4NCg0KQ2M6
IEZsb3JpYW4gRmFpbmVsbGkgPGYuZmFpbmVsbGlAZ21haWwuY29tPg0KU2lnbmVkLW9mZi1ieTog
Q2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KLS0tDQp2MjogYWRkIENj
IEZsb3JpYW4NCi0tLQ0KIGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19jbWQuaCB8IDEg
LQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfY21kLmggYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2Jk
Yy9iZGNfY21kLmgNCmluZGV4IDM3M2U2NzQuLmEzYTZkYmQgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfY21kLmgNCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC91
ZGMvYmRjL2JkY19jbWQuaA0KQEAgLTE2LDcgKzE2LDYgQEANCiBpbnQgYmRjX3N0b3BfZXAoc3Ry
dWN0IGJkYyAqLCBpbnQpOw0KIGludCBiZGNfZXBfc2V0X3N0YWxsKHN0cnVjdCBiZGMgKiwgaW50
KTsNCiBpbnQgYmRjX2VwX2NsZWFyX3N0YWxsKHN0cnVjdCBiZGMgKiwgaW50KTsNCi1pbnQgYmRj
X2VwX3NldF9oYWx0KHN0cnVjdCBiZGNfZXAgKiwgdTMyICwgaW50KTsNCiBpbnQgYmRjX2VwX2Js
YShzdHJ1Y3QgYmRjICosIHN0cnVjdCBiZGNfZXAgKiwgZG1hX2FkZHJfdCk7DQogaW50IGJkY19m
dW5jdGlvbl93YWtlKHN0cnVjdCBiZGMqLCB1OCk7DQogaW50IGJkY19mdW5jdGlvbl93YWtlX2Zo
KHN0cnVjdCBiZGMqLCB1OCk7DQotLSANCjEuOS4xDQo=

