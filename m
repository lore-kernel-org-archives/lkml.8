Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285C9C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 03:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CD520661
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 03:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EnBQ14yM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgBKDWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 22:22:24 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:10991 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728010AbgBKDWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 22:22:08 -0500
X-UUID: 8771a79ea72b4bebbfa993842887e7a7-20200211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=r8ejWidlqTJxz08EZdYATpK/d/uKxpmz1wmwhDhD88A=;
        b=EnBQ14yM6GCiVgbkRUipum8S2QWgzbzNL2uFXJjXEcvgpwGHM5in8Wsj2lA9nDPuG2o3h9kfUnltUJhJsIBLgzE/7hef0EnSpPPsItImnStK7/72T8N0lsB55QbScprsXxo6ihqmBz4k0IMs656dTXrWFW/6fGub4ZPUZ6LnfCg=;
X-UUID: 8771a79ea72b4bebbfa993842887e7a7-20200211
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1590352609; Tue, 11 Feb 2020 11:21:53 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 11 Feb 2020 11:20:24 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 11 Feb 2020 11:20:57 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [RESEND PATCH v5 04/11] dt-bindings: phy-mtk-tphy: add a new reference clock
Date:   Tue, 11 Feb 2020 11:21:09 +0800
Message-ID: <be9f3664d1b3fdd299a5216df4bda643c39c7bd7.1581389234.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <bfcf6a4dd6829dfa1bd0119b34043db7364dfd8e.1581389234.git.chunfeng.yun@mediatek.com>
References: <bfcf6a4dd6829dfa1bd0119b34043db7364dfd8e.1581389234.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C7BF73084191A2E385A32F298866C72CB013C6A40172E1BF65CF20618662C3962000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXN1YWxseSB0aGUgZGlnaXRhbCBhbmQgYW5hbG9nIHBoeXMgdXNlIHRoZSBzYW1lIHJlZmVyZW5j
ZSBjbG9jaywNCmJ1dCBvbiBzb21lIHBsYXRmb3JtcywgdGhleSBhcmUgc2VwYXJhdGVkLCBzbyBh
ZGQgYW5vdGhlciBvcHRpb25hbA0KY2xvY2sgdG8gc3VwcG9ydCBpdC4NCkluIG9yZGVyIHRvIGtl
ZXAgdGhlIGNsb2NrIG5hbWVzIGNvbnNpc3RlbnQgd2l0aCBQSFkgSVAncywgdXNlDQp0aGUgZGFf
cmVmIGZvciBhbmFsb2cgcGh5IGFuZCByZWYgY2xvY2sgZm9yIGRpZ2l0YWwgcGh5Lg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQpBY2tl
ZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCi0tLQ0KdjR+djU6IG5vIGNoYW5n
ZXMNCg0KdjM6IGFkZCBhY2tlZC1ieSBSb2INCg0KdjI6IGZpeCB0eXBvIG9mIGFuYWxvZyBhbmQg
bmVlZGVkDQotLS0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L3BoeS1t
dGstdHBoeS50eHQgfCA3ICsrKysrLS0NCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3BoeS9waHktbXRrLXRwaHkudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3BoeS9waHktbXRrLXRwaHkudHh0DQppbmRleCA0OGJjMWEyZTkyOTkuLmE4NTli
MGRiNDA1MSAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
aHkvcGh5LW10ay10cGh5LnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3BoeS9waHktbXRrLXRwaHkudHh0DQpAQCAtNDEsOSArNDEsMTIgQEAgT3B0aW9uYWwgcHJv
cGVydGllcyAoUEhZX1RZUEVfVVNCMiBwb3J0IChjaGlsZCkgbm9kZSk6DQogLSBjbG9ja3MJOiBh
IGxpc3Qgb2YgcGhhbmRsZSArIGNsb2NrLXNwZWNpZmllciBwYWlycywgb25lIGZvciBlYWNoDQog
CQkgIGVudHJ5IGluIGNsb2NrLW5hbWVzDQogLSBjbG9jay1uYW1lcwk6IG1heSBjb250YWluDQot
CQkgICJyZWYiOiA0OE0gcmVmZXJlbmNlIGNsb2NrIGZvciBIaWdoU3BlZWQgYW5vbG9nIHBoeTsg
YW5kIDI2TQ0KLQkJCXJlZmVyZW5jZSBjbG9jayBmb3IgU3VwZXJTcGVlZCBhbm9sb2cgcGh5LCBz
b21ldGltZXMgaXMNCisJCSAgInJlZiI6IDQ4TSByZWZlcmVuY2UgY2xvY2sgZm9yIEhpZ2hTcGVl
ZCAoZGlnaXRhbCkgcGh5OyBhbmQgMjZNDQorCQkJcmVmZXJlbmNlIGNsb2NrIGZvciBTdXBlclNw
ZWVkIChkaWdpdGFsKSBwaHksIHNvbWV0aW1lcyBpcw0KIAkJCTI0TSwgMjVNIG9yIDI3TSwgZGVw
ZW5kZWQgb24gcGxhdGZvcm0uDQorCQkgICJkYV9yZWYiOiB0aGUgcmVmZXJlbmNlIGNsb2NrIG9m
IGFuYWxvZyBwaHksIHVzZWQgaWYgdGhlIGNsb2Nrcw0KKwkJCW9mIGFuYWxvZyBhbmQgZGlnaXRh
bCBwaHlzIGFyZSBzZXBhcmF0ZWQsIG90aGVyd2lzZSB1c2VzDQorCQkJInJlZiIgY2xvY2sgb25s
eSBpZiBuZWVkZWQuDQogDQogLSBtZWRpYXRlayxleWUtc3JjCTogdTMyLCB0aGUgdmFsdWUgb2Yg
c2xldyByYXRlIGNhbGlicmF0ZQ0KIC0gbWVkaWF0ZWssZXllLXZydAk6IHUzMiwgdGhlIHNlbGVj
dGlvbiBvZiBWUlQgcmVmZXJlbmNlIHZvbHRhZ2UNCi0tIA0KMi4yNS4wDQo=

