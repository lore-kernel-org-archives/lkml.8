Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23029C3B1BF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 06:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB9320857
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 06:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ALwC+KfQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgBPGOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 01:14:51 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:55814 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725816AbgBPGOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 01:14:50 -0500
X-UUID: d8e917794f3d459d81609e3dc42f7030-20200216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=7SmjLqt/17FB6xxDRlRjlGO7LPQoiK/Km0WSuW6uGcQ=;
        b=ALwC+KfQ/BtnKEmuJCYDWjrkdVa7k/ub5f4wfCFPtWtgRATcFxd+c30YfKOMEue5uQv9kgBo1oMEx/wMOlrohlNOWKs3oYU0E31g9qGnIZHFUXGvlnAfcMYjClzry8C7u+rLDfA0o/uM674jYARLbwqQj7rWcDKVxPoxaVuY5Ew=;
X-UUID: d8e917794f3d459d81609e3dc42f7030-20200216
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <argus.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1339350079; Sun, 16 Feb 2020 14:14:44 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 16 Feb 2020 14:13:35 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 16 Feb 2020 14:14:33 +0800
From:   Argus Lin <argus.lin@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
CC:     Chenglin Xu <chenglin.xu@mediatek.com>, <argus.lin@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <wsd_upstream@mediatek.com>, <henryc.chen@mediatek.com>,
        <flora.fu@mediatek.com>, Chen Zhong <chen.zhong@mediatek.com>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 1/3] dt-bindings: pwrap: mediatek: add pwrap support for MT6779
Date:   Sun, 16 Feb 2020 14:14:37 +0800
Message-ID: <1581833679-4319-2-git-send-email-argus.lin@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1581833679-4319-1-git-send-email-argus.lin@mediatek.com>
References: <1581833679-4319-1-git-send-email-argus.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGJpbmRpbmcgZG9jdW1lbnQgb2YgcHdyYXAgZm9yIE1UNjc3OSBTb0NzLg0KDQpDaGFuZ2Ut
SWQ6IEk2MTU5NjRjOGY3YjgyY2ZhNGQ4ZjE1M2UzMGVlYjUxNDAwMDAwMTllDQpTaWduZWQtb2Zm
LWJ5OiBBcmd1cyBMaW4gPGFyZ3VzLmxpbkBtZWRpYXRlay5jb20+DQpBY2tlZC1ieTogUm9iIEhl
cnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCi0tLQ0KIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9zb2MvbWVkaWF0ZWsvcHdyYXAudHh0IHwgMSArDQogMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc29jL21lZGlhdGVrL3B3cmFwLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9zb2MvbWVkaWF0ZWsvcHdyYXAudHh0DQppbmRleCA3YTMyNDA0Li5lY2FjMmJiIDEw
MDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRl
ay9wd3JhcC50eHQNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2Mv
bWVkaWF0ZWsvcHdyYXAudHh0DQpAQCAtMjAsNiArMjAsNyBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVz
IGluIHB3cmFwIGRldmljZSBub2RlLg0KIC0gY29tcGF0aWJsZToNCiAJIm1lZGlhdGVrLG10Mjcw
MS1wd3JhcCIgZm9yIE1UMjcwMS83NjIzIFNvQ3MNCiAJIm1lZGlhdGVrLG10Njc2NS1wd3JhcCIg
Zm9yIE1UNjc2NSBTb0NzDQorCSJtZWRpYXRlayxtdDY3NzktcHdyYXAiIGZvciBNVDY3NzkgU29D
cw0KIAkibWVkaWF0ZWssbXQ2Nzk3LXB3cmFwIiBmb3IgTVQ2Nzk3IFNvQ3MNCiAJIm1lZGlhdGVr
LG10NzYyMi1wd3JhcCIgZm9yIE1UNzYyMiBTb0NzDQogCSJtZWRpYXRlayxtdDgxMzUtcHdyYXAi
IGZvciBNVDgxMzUgU29Dcw0KLS0NCjEuOC4xLjEuZGlydHkNCg==

