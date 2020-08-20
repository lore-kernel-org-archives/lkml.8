Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55D8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F7B9204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Y6lBTbZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbgHTLhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:37:04 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:29940 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730154AbgHTLcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 07:32:51 -0400
X-UUID: fc157446e9cb41f3bc3de99a6f4896b1-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=G7pvdWU6ecd0ZELjOP1tjCdcvdakfvhwkNEctXHsX3w=;
        b=Y6lBTbZDjgKKOj7caJpk1mtzuw3Z0Qn0ZUOokYIMZ3AvqlF1aAX+flQj5HdUBc2zNnKqSERYSZKPglPl706yIqqcrdRs/vfmc25ywYpt6JVRMg1cEHNI/sJelnAZosLxwsG8YJXWhVoGSZEhztyZi6RjGZOvlFxWiMJzvkb3bzc=;
X-UUID: fc157446e9cb41f3bc3de99a6f4896b1-20200820
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 882762425; Thu, 20 Aug 2020 19:32:22 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 19:32:20 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 19:32:18 +0800
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
Subject: [PATCH v2 01/11] usb: gadget: bdc: fix improper SPDX comment style for header file
Date:   Thu, 20 Aug 2020 19:30:36 +0800
Message-ID: <1597923046-12535-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 921FA67EAD5DF1151DD75AC4BE3FAD03D1FB55737FB5FEAF8748B0F0395FC15B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rm9yIEMgaGVhZGVyIGZpbGVzIERvY3VtZW50YXRpb24vcHJvY2Vzcy9saWNlbnNlLXJ1bGVzLnJz
dA0KbWFuZGF0ZXMgQy1saWtlIGNvbW1lbnRzIChvcHBvc2VkIHRvIEMgc291cmNlIGZpbGVzIHdo
ZXJlDQpDKysgc3R5bGUgc2hvdWxkIGJlIHVzZWQpLg0KDQpDYzogRmxvcmlhbiBGYWluZWxsaSA8
Zi5mYWluZWxsaUBnbWFpbC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5m
ZW5nLnl1bkBtZWRpYXRlay5jb20+DQotLS0NCnYyOiBhZGQgQ2MgRmxvcmlhbg0KLS0tDQogZHJp
dmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjLmggICAgIHwgMiArLQ0KIGRyaXZlcnMvdXNiL2dh
ZGdldC91ZGMvYmRjL2JkY19jbWQuaCB8IDIgKy0NCiBkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2Jk
Yy9iZGNfZGJnLmggfCAyICstDQogZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2VwLmgg
IHwgMiArLQ0KIDQgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjLmggYi9kcml2
ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGMuaA0KaW5kZXggYWM3NWUyNS4uZmNiYTc3ZSAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkYy5oDQorKysgYi9kcml2ZXJz
L3VzYi9nYWRnZXQvdWRjL2JkYy9iZGMuaA0KQEAgLTEsNCArMSw0IEBADQotLy8gU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IEdQTC0yLjArDQorLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQ
TC0yLjArICovDQogLyoNCiAgKiBiZGMuaCAtIGhlYWRlciBmb3IgdGhlIEJSQ00gQkRDIFVTQjMu
MCBkZXZpY2UgY29udHJvbGxlcg0KICAqDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0
L3VkYy9iZGMvYmRjX2NtZC5oIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2NtZC5o
DQppbmRleCAyOWNjOTg4Li4zNzNlNjc0IDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0
L3VkYy9iZGMvYmRjX2NtZC5oDQorKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNf
Y21kLmgNCkBAIC0xLDQgKzEsNCBAQA0KLS8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwt
Mi4wKw0KKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKyAqLw0KIC8qDQogICog
YmRjX2NtZC5oIC0gaGVhZGVyIGZvciB0aGUgQkRDIGRlYnVnIGZ1bmN0aW9ucw0KICAqDQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2RiZy5oIGIvZHJpdmVycy91
c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2RiZy5oDQppbmRleCAzNzNkNWFiLi44NTlkNTg4IDEwMDY0
NA0KLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2RiZy5oDQorKysgYi9kcml2
ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZGJnLmgNCkBAIC0xLDQgKzEsNCBAQA0KLS8vIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKw0KKy8qIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBHUEwtMi4wKyAqLw0KIC8qDQogICogYmRjX2RiZy5oIC0gaGVhZGVyIGZvciB0aGUgQkRD
IGRlYnVnIGZ1bmN0aW9ucw0KICAqDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3Vk
Yy9iZGMvYmRjX2VwLmggYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZXAuaA0KaW5k
ZXggYTM3ZmY4MDMuLjViYmQ3M2YgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRj
L2JkYy9iZGNfZXAuaA0KKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2VwLmgN
CkBAIC0xLDQgKzEsNCBAQA0KLS8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKw0K
Ky8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKyAqLw0KIC8qDQogICogYmRjX2Vw
LmggLSBoZWFkZXIgZm9yIHRoZSBCREMgZGVidWcgZnVuY3Rpb25zDQogICoNCi0tIA0KMS45LjEN
Cg==

