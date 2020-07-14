Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA731C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 869B52083B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:50:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rlsWiAri"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgGNIul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 04:50:41 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:1323 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725820AbgGNIuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 04:50:40 -0400
X-UUID: 65a92e58ddae429aa8b7621b74b9a986-20200714
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=W/y420kbWaO6GK4t6Nc9Br0LkiIrvJUWkJeD0Ieos6k=;
        b=rlsWiArirqRW7K3jNOYK4Prdb4NdX4w9uXpaFmxzc9tuNb6y53eEeNfETwYymyAR5h2TDl3XvP8bOc05XpmgP8wD9BIPBs7pzMpFvpGcn/9VWyNaKweSAU/ra2YkQ+3/ESG8w6pcFEJgy26LxhmTYDJP+VDIEAYyIxi9wPzNWxk=;
X-UUID: 65a92e58ddae429aa8b7621b74b9a986-20200714
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 492418105; Tue, 14 Jul 2020 16:50:36 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Jul 2020 16:50:34 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Jul 2020 16:50:33 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 3/9] usb: gadget: bdc: fix improper SPDX comment style for header file
Date:   Tue, 14 Jul 2020 16:48:48 +0800
Message-ID: <1594716535-24699-3-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1594716535-24699-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1594716535-24699-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A485723BC2235A744514B15BCFB892FE534E75B11330134FA6BC01E2CCF3F2CD2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rm9yIEMgaGVhZGVyIGZpbGVzIERvY3VtZW50YXRpb24vcHJvY2Vzcy9saWNlbnNlLXJ1bGVzLnJz
dA0KbWFuZGF0ZXMgQy1saWtlIGNvbW1lbnRzIChvcHBvc2VkIHRvIEMgc291cmNlIGZpbGVzIHdo
ZXJlDQpDKysgc3R5bGUgc2hvdWxkIGJlIHVzZWQpLg0KDQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVu
ZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3VzYi9nYWRn
ZXQvdWRjL2JkYy9iZGMuaCAgICAgfCAyICstDQogZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMv
YmRjX2NtZC5oIHwgMiArLQ0KIGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19kYmcuaCB8
IDIgKy0NCiBkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZXAuaCAgfCAyICstDQogNCBm
aWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGMuaCBiL2RyaXZlcnMvdXNiL2dhZGdl
dC91ZGMvYmRjL2JkYy5oDQppbmRleCBmNTZlZTc2Li5lZTBlYWZjIDEwMDY0NA0KLS0tIGEvZHJp
dmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjLmgNCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC91
ZGMvYmRjL2JkYy5oDQpAQCAtMSw0ICsxLDQgQEANCi0vLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogR1BMLTIuMCsNCisvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCsgKi8NCiAv
Kg0KICAqIGJkYy5oIC0gaGVhZGVyIGZvciB0aGUgQlJDTSBCREMgVVNCMy4wIGRldmljZSBjb250
cm9sbGVyDQogICoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNf
Y21kLmggYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfY21kLmgNCmluZGV4IGMyNGU2
ZmMuLmU0ODFkMzYgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNf
Y21kLmgNCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19jbWQuaA0KQEAgLTEs
NCArMSw0IEBADQotLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArDQorLyogU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArICovDQogLyoNCiAgKiBiZGNfY21kLmggLSBo
ZWFkZXIgZm9yIHRoZSBCREMgZGVidWcgZnVuY3Rpb25zDQogICoNCmRpZmYgLS1naXQgYS9kcml2
ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZGJnLmggYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRj
L2JkYy9iZGNfZGJnLmgNCmluZGV4IDM3M2Q1YWIuLjg1OWQ1ODggMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZGJnLmgNCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdl
dC91ZGMvYmRjL2JkY19kYmcuaA0KQEAgLTEsNCArMSw0IEBADQotLy8gU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjArDQorLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAr
ICovDQogLyoNCiAgKiBiZGNfZGJnLmggLSBoZWFkZXIgZm9yIHRoZSBCREMgZGVidWcgZnVuY3Rp
b25zDQogICoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZXAu
aCBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19lcC5oDQppbmRleCBhMzdmZjgwMy4u
NWJiZDczZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19lcC5o
DQorKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZXAuaA0KQEAgLTEsNCArMSw0
IEBADQotLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArDQorLyogU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IEdQTC0yLjArICovDQogLyoNCiAgKiBiZGNfZXAuaCAtIGhlYWRlciBm
b3IgdGhlIEJEQyBkZWJ1ZyBmdW5jdGlvbnMNCiAgKg0KLS0gDQoxLjkuMQ0K

