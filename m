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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C654C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D55121D7D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pZfWpOO8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgGNJEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:04:48 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33429 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726431AbgGNJEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:04:47 -0400
X-UUID: 96a93593bea04ce3bb92840ad50347c8-20200714
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=oQhNO1aDSq964/bNoXZsaKR638iBryUKI8hdFeOuNn4=;
        b=pZfWpOO8RCMm9n4Q4i4vg2DYCge5qafplcO6YOJ5gRLNGg5bGnwFEk9GdRQ7E/qB047rzbpsoba3ZjYhdLGOAQNxIKS+K5Vo5KqyosKgIhNrevCYS2VZxyNwOA+iQt81Exm2SJVX0IjahPT8E+TOM5mL4e+8LOiryWaB29hxbq0=;
X-UUID: 96a93593bea04ce3bb92840ad50347c8-20200714
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <hanks.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 525924331; Tue, 14 Jul 2020 17:04:44 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 14 Jul 2020 17:04:42 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Jul 2020 17:04:42 +0800
From:   Hanks Chen <hanks.chen@mediatek.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sean Wang <sean.wang@kernel.org>
CC:     mtk01761 <wendell.lin@mediatek.com>,
        Andy Teng <andy.teng@mediatek.com>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        Hanks Chen <hanks.chen@mediatek.com>
Subject: [PATCH 7/7] clk: mediatek: add UART0 clock support
Date:   Tue, 14 Jul 2020 17:04:39 +0800
Message-ID: <1594717479-8160-8-git-send-email-hanks.chen@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1594717479-8160-1-git-send-email-hanks.chen@mediatek.com>
References: <1594717479-8160-1-git-send-email-hanks.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIE1UNjc3OSBVQVJUMCBjbG9jayBzdXBwb3J0Lg0KDQpGaXhlczogNzEwNzc0ZTA0ODYxICgi
Y2xrOiBtZWRpYXRlazogQWRkIE1UNjc3OSBjbG9jayBzdXBwb3J0IikNClNpZ25lZC1vZmYtYnk6
IFdlbmRlbGwgTGluIDx3ZW5kZWxsLmxpbkBtZWRpYXRlay5jb20+DQpTaWduZWQtb2ZmLWJ5OiBI
YW5rcyBDaGVuIDxoYW5rcy5jaGVuQG1lZGlhdGVrLmNvbT4NClJldmlld2VkLWJ5OiBNYXR0aGlh
cyBCcnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPg0KLS0tDQogZHJpdmVycy9jbGsvbWVk
aWF0ZWsvY2xrLW10Njc3OS5jIHwgICAgMiArKw0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDY3NzkuYyBi
L2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDY3NzkuYw0KaW5kZXggOTc2NmNjYy4uNmUwZDNh
MSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDY3NzkuYw0KKysrIGIv
ZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10Njc3OS5jDQpAQCAtOTE5LDYgKzkxOSw4IEBADQog
CQkgICAgInB3bV9zZWwiLCAxOSksDQogCUdBVEVfSU5GUkEwKENMS19JTkZSQV9QV00sICJpbmZy
YV9wd20iLA0KIAkJICAgICJwd21fc2VsIiwgMjEpLA0KKwlHQVRFX0lORlJBMChDTEtfSU5GUkFf
VUFSVDAsICJpbmZyYV91YXJ0MCIsDQorCQkgICAgInVhcnRfc2VsIiwgMjIpLA0KIAlHQVRFX0lO
RlJBMChDTEtfSU5GUkFfVUFSVDEsICJpbmZyYV91YXJ0MSIsDQogCQkgICAgInVhcnRfc2VsIiwg
MjMpLA0KIAlHQVRFX0lORlJBMChDTEtfSU5GUkFfVUFSVDIsICJpbmZyYV91YXJ0MiIsDQotLSAN
CjEuNy45LjUNCg==

