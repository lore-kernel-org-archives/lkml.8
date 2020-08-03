Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A162C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 06:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C99E2067D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 06:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="o5FuR9vm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgHCGRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 02:17:17 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:19210 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728276AbgHCGRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 02:17:15 -0400
X-UUID: 381cf9e045e24dffa21b5668fe4be067-20200803
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Irp9/QjysrH0oJjoPG2VHXVZnPkCnGZYljixcmAEdkM=;
        b=o5FuR9vmeu/sJjVz5wBz3PjUMa5IwuFs0cIZ5JGcwHbH2y7abkqg6Qek0B3YH0fIxthHZmiRwmIVvakk6FDtLFyBO2MWyWO3xWnOcer0L5WjXl/2Am0QE53l59fLHM+cQDPjDnNVartL5kSxSL/ITNPZOWXqECRUH8Ocu5Pl6QE=;
X-UUID: 381cf9e045e24dffa21b5668fe4be067-20200803
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1099579061; Mon, 03 Aug 2020 14:17:11 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 3 Aug 2020 14:17:08 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 3 Aug 2020 14:17:09 +0800
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <seiya.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <fan.chen@mediatek.com>, <yong.liang@mediatek.com>,
        Crystal Guo <crystal.guo@mediatek.com>
Subject: [v2,3/6] dt-binding: reset-controller: ti: add generic-reset to compatible
Date:   Mon, 3 Aug 2020 14:15:08 +0800
Message-ID: <20200803061511.29555-4-crystal.guo@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200803061511.29555-1-crystal.guo@mediatek.com>
References: <20200803061511.29555-1-crystal.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIFRJIHN5c2NvbiByZXNldCBjb250cm9sbGVyIHByb3ZpZGVzIGEgY29tbW9uIHJlc2V0IG1h
bmFnZW1lbnQsDQphbmQgc2hvdWxkIGJlIHN1aXRhYmxlIGZvciBvdGhlciBTT0NzLiBBZGQgY29t
cGF0aWJsZSAiZ2VuZXJpYy1yZXNldCIsDQp3aGljaCBkZW5vdGVzIHRvIHVzZSBhIGNvbW1vbiBy
ZXNldC1jb250cm9sbGVyIGRyaXZlci4NCg0KU2lnbmVkLW9mZi1ieTogQ3J5c3RhbCBHdW8gPGNy
eXN0YWwuZ3VvQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9yZXNldC90aS1zeXNjb24tcmVzZXQudHh0IHwgMSArDQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvcmVzZXQvdGktc3lzY29uLXJlc2V0LnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9yZXNldC90aS1zeXNjb24tcmVzZXQudHh0DQppbmRleCBkNTUxMTYxYWU3
ODUuLmUzNmQzNjMxZWFiMiAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9yZXNldC90aS1zeXNjb24tcmVzZXQudHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvcmVzZXQvdGktc3lzY29uLXJlc2V0LnR4dA0KQEAgLTI1LDYgKzI1
LDcgQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCiAJCQkgICAgInRpLGsybC1wc2Nyc3QiDQogCQkJ
ICAgICJ0aSxrMmhrLXBzY3JzdCINCiAJCQkgICAgInRpLHN5c2Nvbi1yZXNldCINCisJCQkgICAg
ImdlbmVyaWMtcmVzZXQiLCAidGksc3lzY29uLXJlc2V0Ig0KICAtICNyZXNldC1jZWxscwkJOiBT
aG91bGQgYmUgMS4gUGxlYXNlIHNlZSB0aGUgcmVzZXQgY29uc3VtZXIgbm9kZSBiZWxvdw0KIAkJ
CSAgZm9yIHVzYWdlIGRldGFpbHMNCiAgLSB0aSxyZXNldC1iaXRzCTogQ29udGFpbnMgdGhlIHJl
c2V0IGNvbnRyb2wgcmVnaXN0ZXIgaW5mb3JtYXRpb24NCi0tIA0KMi4xOC4wDQo=

