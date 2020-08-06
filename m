Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F21EC38150
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9173D22D05
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GF9F6mWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgHFJgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 05:36:22 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:47550 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729002AbgHFJWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 05:22:46 -0400
X-UUID: 9b5a535d52124b33b67b243e4bcc4b26-20200806
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=dGXGiunHjZndJ6cHTy/bVaVcZvEJmUdgQt8u80wNGMc=;
        b=GF9F6mWVU+fjxwWa8z4VOZHYFq3LUr3qvEA/mJ6FmxyH87jGLiPuMoPINvDvit195pxf1M1Td0uQdqVG6Flb5iLRQIZVN9A5DIKLkqKS+U4XWJA6eTvBUIZ/0h9yHvjYOioDwx/rA+prlmsSFzu4v8VKx6S5B+XamAtcIdDApBQ=;
X-UUID: 9b5a535d52124b33b67b243e4bcc4b26-20200806
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 231799712; Thu, 06 Aug 2020 17:22:01 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 6 Aug 2020 17:21:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 6 Aug 2020 17:21:58 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v17 01/12] dt-bindings: mediatek: Add property to mt8183 smi-common
Date:   Thu, 6 Aug 2020 17:21:44 +0800
Message-ID: <1596705715-15320-2-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1596705715-15320-1-git-send-email-weiyi.lu@mediatek.com>
References: <1596705715-15320-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rm9yIHNjcHN5cyBkcml2ZXIgdXNpbmcgcmVnbWFwIGJhc2VkIHN5c2NvbiBkcml2ZXIgQVBJLg0K
DQpTaWduZWQtb2ZmLWJ5OiBXZWl5aSBMdSA8d2VpeWkubHVAbWVkaWF0ZWsuY29tPg0KQWNrZWQt
Ynk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQotLS0NCiAuLi4vZGV2aWNldHJlZS9i
aW5kaW5ncy9tZW1vcnktY29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWNvbW1vbi50eHQgICAgICB8
IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0K
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZW1vcnktY29u
dHJvbGxlcnMvbWVkaWF0ZWssc21pLWNvbW1vbi50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbWVtb3J5LWNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1jb21tb24udHh0DQpp
bmRleCBiNDc4YWRlLi4wMTc0NGVjIDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL21lbW9yeS1jb250cm9sbGVycy9tZWRpYXRlayxzbWktY29tbW9uLnR4dA0K
KysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lbW9yeS1jb250cm9sbGVy
cy9tZWRpYXRlayxzbWktY29tbW9uLnR4dA0KQEAgLTIwLDcgKzIwLDcgQEAgUmVxdWlyZWQgcHJv
cGVydGllczoNCiAJIm1lZGlhdGVrLG10MjcxMi1zbWktY29tbW9uIg0KIAkibWVkaWF0ZWssbXQ3
NjIzLXNtaS1jb21tb24iLCAibWVkaWF0ZWssbXQyNzAxLXNtaS1jb21tb24iDQogCSJtZWRpYXRl
ayxtdDgxNzMtc21pLWNvbW1vbiINCi0JIm1lZGlhdGVrLG10ODE4My1zbWktY29tbW9uIg0KKwki
bWVkaWF0ZWssbXQ4MTgzLXNtaS1jb21tb24iLCAic3lzY29uIg0KIC0gcmVnIDogdGhlIHJlZ2lz
dGVyIGFuZCBzaXplIG9mIHRoZSBTTUkgYmxvY2suDQogLSBwb3dlci1kb21haW5zIDogYSBwaGFu
ZGxlIHRvIHRoZSBwb3dlciBkb21haW4gb2YgdGhpcyBsb2NhbCBhcmJpdGVyLg0KIC0gY2xvY2tz
IDogTXVzdCBjb250YWluIGFuIGVudHJ5IGZvciBlYWNoIGVudHJ5IGluIGNsb2NrLW5hbWVzLg0K
LS0gDQoxLjguMS4xLmRpcnR5DQo=

