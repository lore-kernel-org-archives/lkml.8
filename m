Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A137C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 03:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3919020897
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 03:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IcWBs2B8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgICDXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 23:23:30 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:48962 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726654AbgICDXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 23:23:30 -0400
X-UUID: 8c68f6e35caf494883a2ad3d0a575120-20200903
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=6a0DZnMcrJccG/fKnUY/ZJwWvVBIDv1bvW0ddGlQyuU=;
        b=IcWBs2B82SbKSS9njUu3CGOQ3ioFjF3oZj8VE94TQFP8Q3maPI3c4Mop+WvGITrYNfQO43eDElWIzfLWM7VjCeTSFiTNgDZ2WJ5TZXUra+TN2mTxjj9UaHlFQaOtuGaUMYf7IeoJ5PWZom28rsvzFQl2FGUSXGQmXbc75+hql5Y=;
X-UUID: 8c68f6e35caf494883a2ad3d0a575120-20200903
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1053688670; Thu, 03 Sep 2020 11:23:25 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 3 Sep 2020 11:23:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 3 Sep 2020 11:23:23 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
        Wendell Lin <wendell.lin@mediatek.com>
Subject: [PATCH v3 2/9] dt-bindings: ARM: Mediatek: Document bindings for MT8192 Audio
Date:   Thu, 3 Sep 2020 11:22:53 +0800
Message-ID: <1599103380-4155-3-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1599103380-4155-1-git-send-email-weiyi.lu@mediatek.com>
References: <1599103380-4155-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGRzIHRoZSBiaW5kaW5nIGRvY3VtZW50YXRpb24gb2YgYXVkc3lzIGFuZCBz
Y3AtYWRzcA0KZm9yIE1lZGlhdGVrIE1UODE5Mi4NCg0KU2lnbmVkLW9mZi1ieTogV2VpeWkgTHUg
PHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIC4uLi9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsv
bWVkaWF0ZWssYXVkc3lzLnR4dCAgICAgIHwgIDEgKw0KIC4uLi9iaW5kaW5ncy9hcm0vbWVkaWF0
ZWsvbWVkaWF0ZWssc2NwLWFkc3AueWFtbCAgIHwgMzggKysrKysrKysrKysrKysrKysrKysrKw0K
IDIgZmlsZXMgY2hhbmdlZCwgMzkgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLHNj
cC1hZHNwLnlhbWwNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssYXVkc3lzLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssYXVkc3lzLnR4dA0KaW5kZXgg
MzgzMDlkYi4uZmRjYjI2NyAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssYXVkc3lzLnR4dA0KKysrIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxhdWRzeXMudHh0
DQpAQCAtMTIsNiArMTIsNyBAQCBSZXF1aXJlZCBQcm9wZXJ0aWVzOg0KIAktICJtZWRpYXRlayxt
dDc2MjItYXVkc3lzIiwgInN5c2NvbiINCiAJLSAibWVkaWF0ZWssbXQ3NjIzLWF1ZHN5cyIsICJt
ZWRpYXRlayxtdDI3MDEtYXVkc3lzIiwgInN5c2NvbiINCiAJLSAibWVkaWF0ZWssbXQ4MTgzLWF1
ZGlvc3lzIiwgInN5c2NvbiINCisJLSAibWVkaWF0ZWssbXQ4MTkyLWF1ZHN5cyIsICJzeXNjb24i
DQogCS0gIm1lZGlhdGVrLG10ODUxNi1hdWRzeXMiLCAic3lzY29uIg0KIC0gI2Nsb2NrLWNlbGxz
OiBNdXN0IGJlIDENCiANCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLHNjcC1hZHNwLnlhbWwgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLHNjcC1hZHNwLnlhbWwN
Cm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwLi4yNGRmMzVkDQotLS0gL2Rldi9u
dWxsDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVr
L21lZGlhdGVrLHNjcC1hZHNwLnlhbWwNCkBAIC0wLDAgKzEsMzggQEANCisjIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiAoR1BMLTIuMCBPUiBCU0QtMi1DbGF1c2UpDQorJVlBTUwgMS4yDQorLS0t
DQorJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9hcm0vbWVkaWF0ZWsvbWVkaWF0
ZWssc2NwLWFkc3AueWFtbCMNCiskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1z
Y2hlbWFzL2NvcmUueWFtbCMNCisNCit0aXRsZTogTWVkaWFUZWsgU0NQIEFEU1AgQ29udHJvbGxl
cg0KKw0KK21haW50YWluZXJzOg0KKyAgLSBXZWl5aSBMdSA8d2VpeWkubHVAbWVkaWF0ZWsuY29t
Pg0KKw0KK2Rlc2NyaXB0aW9uOg0KKyAgVGhlIE1lZGlhdGVrIHNjcCBhZHNwIGNvbnRyb2xsZXIg
cHJvdmlkZXMgZnVuY3Rpb25hbCBjb25maWd1cmF0aW9ucyBhbmQgY2xvY2tzIHRvIHRoZSBzeXN0
ZW0uDQorDQorcHJvcGVydGllczoNCisgIGNvbXBhdGlibGU6DQorICAgIGl0ZW1zOg0KKyAgICAg
IC0gZW51bToNCisgICAgICAgICAgLSBtZWRpYXRlayxtdDgxOTItc2NwX2Fkc3ANCisgICAgICAt
IGNvbnN0OiBzeXNjb24NCisNCisgIHJlZzoNCisgICAgbWF4SXRlbXM6IDENCisNCisgICcjY2xv
Y2stY2VsbHMnOg0KKyAgICBjb25zdDogMQ0KKw0KK3JlcXVpcmVkOg0KKyAgLSBjb21wYXRpYmxl
DQorICAtIHJlZw0KKw0KK2V4YW1wbGVzOg0KKyAgLSB8DQorICAgIHNjcF9hZHNwOiBzeXNjb25A
MTA3MjAwMDAgew0KKyAgICAgICAgY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTItc2NwX2Fk
c3AiLCAic3lzY29uIjsNCisgICAgICAgIHJlZyA9IDwweDEwNzIwMDAwIDB4MTAwMD47DQorICAg
ICAgICAjY2xvY2stY2VsbHMgPSA8MT47DQorICAgIH07DQotLSANCjEuOC4xLjEuZGlydHkNCg==

