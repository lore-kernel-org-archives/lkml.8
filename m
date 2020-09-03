Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C2CC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 03:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E1962080C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 03:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KQbZZxzB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgICDXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 23:23:32 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:61351 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727065AbgICDXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 23:23:30 -0400
X-UUID: 7034b30f97f44c36b4d3169ed4ab0cde-20200903
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=200s7wlp1Q5HnzUvIvOioTNYLeiVwaK328yD4LNQlHo=;
        b=KQbZZxzB9FL+0HkKqwbPgOz8dZWtcTNlJSP8kFtgPPnYLkD6rYf1sFltfhvJC7KW85wV98mB7BVjaHl+JX592+fHZMXIQtdBdnmhkB5D4wZjjS54jIJC2YPc+s2gffOTiB9Mo4o6kPmZN6dorcKwVeqbGTS6j7Ojb8jbUlo1LYk=;
X-UUID: 7034b30f97f44c36b4d3169ed4ab0cde-20200903
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 149065640; Thu, 03 Sep 2020 11:23:25 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 3 Sep 2020 11:23:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 3 Sep 2020 11:23:24 +0800
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
Subject: [PATCH v3 5/9] dt-bindings: ARM: Mediatek: Document bindings for MT8192 APU and GPU
Date:   Thu, 3 Sep 2020 11:22:56 +0800
Message-ID: <1599103380-4155-6-git-send-email-weiyi.lu@mediatek.com>
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

VGhpcyBwYXRjaCBhZGRzIHRoZSBiaW5kaW5nIGRvY3VtZW50YXRpb24gb2YgaXBlc3lzIGFuZCBt
ZmdjZmcNCmZvciBNZWRpYXRlayBNVDgxOTIuDQoNClNpZ25lZC1vZmYtYnk6IFdlaXlpIEx1IDx3
ZWl5aS5sdUBtZWRpYXRlay5jb20+DQotLS0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLGlwZXN5cy50eHQgfCAxICsNCiBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLG1mZ2NmZy50eHQg
fCAxICsNCiAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxp
cGVzeXMudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRl
ay9tZWRpYXRlayxpcGVzeXMudHh0DQppbmRleCAyY2U4ODliLi45Y2QxMDM1IDEwMDY0NA0KLS0t
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRl
ayxpcGVzeXMudHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJt
L21lZGlhdGVrL21lZGlhdGVrLGlwZXN5cy50eHQNCkBAIC03LDYgKzcsNyBAQCBSZXF1aXJlZCBQ
cm9wZXJ0aWVzOg0KIA0KIC0gY29tcGF0aWJsZTogU2hvdWxkIGJlIG9uZSBvZjoNCiAJLSAibWVk
aWF0ZWssbXQ2Nzc5LWlwZXN5cyIsICJzeXNjb24iDQorCS0gIm1lZGlhdGVrLG10ODE5Mi1pcGVz
eXMiLCAic3lzY29uIg0KIC0gI2Nsb2NrLWNlbGxzOiBNdXN0IGJlIDENCiANCiBUaGUgaXBlc3lz
IGNvbnRyb2xsZXIgdXNlcyB0aGUgY29tbW9uIGNsayBiaW5kaW5nIGZyb20NCmRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVr
LG1mZ2NmZy50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlh
dGVrL21lZGlhdGVrLG1mZ2NmZy50eHQNCmluZGV4IGFkNWY5ZDIuLmZjMWNlNjEgMTAwNjQ0DQot
LS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlh
dGVrLG1mZ2NmZy50eHQNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9h
cm0vbWVkaWF0ZWsvbWVkaWF0ZWssbWZnY2ZnLnR4dA0KQEAgLTksNiArOSw3IEBAIFJlcXVpcmVk
IFByb3BlcnRpZXM6DQogCS0gIm1lZGlhdGVrLG10MjcxMi1tZmdjZmciLCAic3lzY29uIg0KIAkt
ICJtZWRpYXRlayxtdDY3NzktbWZnY2ZnIiwgInN5c2NvbiINCiAJLSAibWVkaWF0ZWssbXQ4MTgz
LW1mZ2NmZyIsICJzeXNjb24iDQorCS0gIm1lZGlhdGVrLG10ODE5Mi1tZmdjZmciLCAic3lzY29u
Ig0KIC0gI2Nsb2NrLWNlbGxzOiBNdXN0IGJlIDENCiANCiBUaGUgbWZnY2ZnIGNvbnRyb2xsZXIg
dXNlcyB0aGUgY29tbW9uIGNsayBiaW5kaW5nIGZyb20NCi0tIA0KMS44LjEuMS5kaXJ0eQ0K

