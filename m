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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16DAC43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 03:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A81AE207D3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 03:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="iPX3XW+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgICDYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 23:24:12 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33269 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726526AbgICDXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 23:23:30 -0400
X-UUID: 9c0e08a39bc94ba2af09c8d0a8a819ab-20200903
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=+yk96Z/qU4ICJoOFeZO6a1PuxPNlbXgUawAmlp06RSo=;
        b=iPX3XW+OGUIvHy60a2iFRENXD5ywARJKPfwb7h1eXSDdHrXJ2zSpshltMUp8nAifIV9Fhk0Eb6uvCv3eUxOFbatH/8ZNXtMqaGrbLkXPYTRueyL6SOfaQewub8YDDpIcolUlPe6gHOc5WktdmTSHk99fFbK3XcHBzreg3LyFr6E=;
X-UUID: 9c0e08a39bc94ba2af09c8d0a8a819ab-20200903
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 621238008; Thu, 03 Sep 2020 11:23:25 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 3 Sep 2020 11:23:23 +0800
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
Subject: [PATCH v3 4/9] dt-bindings: ARM: Mediatek: Document bindings for MT8192 Camera
Date:   Thu, 3 Sep 2020 11:22:55 +0800
Message-ID: <1599103380-4155-5-git-send-email-weiyi.lu@mediatek.com>
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

VGhpcyBwYXRjaCBhZGRzIHRoZSBiaW5kaW5nIGRvY3VtZW50YXRpb24gb2YgY2Ftc3lzLXJhdywN
CmNhbXN5cyBhbmQgaW1nc3lzIGZvciBNZWRpYXRlayBNVDgxOTIuDQoNClNpZ25lZC1vZmYtYnk6
IFdlaXlpIEx1IDx3ZWl5aS5sdUBtZWRpYXRlay5jb20+DQotLS0NCiAuLi4vYmluZGluZ3MvYXJt
L21lZGlhdGVrL21lZGlhdGVrLGNhbXN5cy1yYXcueWFtbCB8IDU0ICsrKysrKysrKysrKysrKysr
KysrKysNCiAuLi4vYmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLGNhbXN5cy50eHQgICAg
ICB8ICAxICsNCiAuLi4vYmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLGltZ3N5cy50eHQg
ICAgICB8ICAyICsNCiAzIGZpbGVzIGNoYW5nZWQsIDU3IGluc2VydGlvbnMoKykNCiBjcmVhdGUg
bW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRl
ay9tZWRpYXRlayxjYW1zeXMtcmF3LnlhbWwNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssY2Ftc3lzLXJhdy55YW1s
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRl
ayxjYW1zeXMtcmF3LnlhbWwNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwLi5l
YjM5NWZmDQotLS0gL2Rldi9udWxsDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLGNhbXN5cy1yYXcueWFtbA0KQEAgLTAsMCArMSw1
NCBAQA0KKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wIE9SIEJTRC0yLUNsYXVz
ZSkNCislWUFNTCAxLjINCistLS0NCiskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFz
L2FybS9tZWRpYXRlay9tZWRpYXRlayxjYW1zeXMtcmF3LnlhbWwjDQorJHNjaGVtYTogaHR0cDov
L2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQorDQordGl0bGU6IE1lZGlh
VGVrIENBTVNZUyBSQVcgQ29udHJvbGxlcg0KKw0KK21haW50YWluZXJzOg0KKyAgLSBXZWl5aSBM
dSA8d2VpeWkubHVAbWVkaWF0ZWsuY29tPg0KKw0KK2Rlc2NyaXB0aW9uOg0KKyAgVGhlIE1lZGlh
dGVrIGNhbXN5cyByYXcgY29udHJvbGxlciBwcm92aWRlcyBmdW5jdGlvbmFsIGNvbmZpZ3VyYXRp
b25zIGFuZCBjbG9ja3MgdG8gdGhlIHN5c3RlbS4NCisNCitwcm9wZXJ0aWVzOg0KKyAgY29tcGF0
aWJsZToNCisgICAgaXRlbXM6DQorICAgICAgLSBlbnVtOg0KKyAgICAgICAgICAtIG1lZGlhdGVr
LG10ODE5Mi1jYW1zeXNfcmF3YQ0KKyAgICAgICAgICAtIG1lZGlhdGVrLG10ODE5Mi1jYW1zeXNf
cmF3Yg0KKyAgICAgICAgICAtIG1lZGlhdGVrLG10ODE5Mi1jYW1zeXNfcmF3Yw0KKyAgICAgIC0g
Y29uc3Q6IHN5c2Nvbg0KKw0KKyAgcmVnOg0KKyAgICBtYXhJdGVtczogMQ0KKw0KKyAgJyNjbG9j
ay1jZWxscyc6DQorICAgIGNvbnN0OiAxDQorDQorcmVxdWlyZWQ6DQorICAtIGNvbXBhdGlibGUN
CisgIC0gcmVnDQorDQorZXhhbXBsZXM6DQorICAtIHwNCisgICAgY2Ftc3lzX3Jhd2E6IHN5c2Nv
bkAxYTA0ZjAwMCB7DQorICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5Mi1jYW1z
eXNfcmF3YSIsICJzeXNjb24iOw0KKyAgICAgICAgcmVnID0gPDAgMHgxYTA0ZjAwMCAwIDB4MTAw
MD47DQorICAgICAgICAjY2xvY2stY2VsbHMgPSA8MT47DQorICAgIH07DQorDQorICAtIHwNCisg
ICAgY2Ftc3lzX3Jhd2I6IHN5c2NvbkAxYTA2ZjAwMCB7DQorICAgICAgICBjb21wYXRpYmxlID0g
Im1lZGlhdGVrLG10ODE5Mi1jYW1zeXNfcmF3YiIsICJzeXNjb24iOw0KKyAgICAgICAgcmVnID0g
PDAgMHgxYTA2ZjAwMCAwIDB4MTAwMD47DQorICAgICAgICAjY2xvY2stY2VsbHMgPSA8MT47DQor
ICAgIH07DQorDQorICAtIHwNCisgICAgY2Ftc3lzX3Jhd2M6IHN5c2NvbkAxYTA4ZjAwMCB7DQor
ICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5Mi1jYW1zeXNfcmF3YyIsICJzeXNj
b24iOw0KKyAgICAgICAgcmVnID0gPDAgMHgxYTA4ZjAwMCAwIDB4MTAwMD47DQorICAgICAgICAj
Y2xvY2stY2VsbHMgPSA8MT47DQorICAgIH07DQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxjYW1zeXMudHh0IGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxjYW1z
eXMudHh0DQppbmRleCBhMGNlODIwLi4wMDgyZjIxIDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxjYW1zeXMudHh0DQor
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlh
dGVrLGNhbXN5cy50eHQNCkBAIC05LDYgKzksNyBAQCBSZXF1aXJlZCBQcm9wZXJ0aWVzOg0KIAkt
ICJtZWRpYXRlayxtdDY3NjUtY2Ftc3lzIiwgInN5c2NvbiINCiAJLSAibWVkaWF0ZWssbXQ2Nzc5
LWNhbXN5cyIsICJzeXNjb24iDQogCS0gIm1lZGlhdGVrLG10ODE4My1jYW1zeXMiLCAic3lzY29u
Ig0KKwktICJtZWRpYXRlayxtdDgxOTItY2Ftc3lzIiwgInN5c2NvbiINCiAtICNjbG9jay1jZWxs
czogTXVzdCBiZSAxDQogDQogVGhlIGNhbXN5cyBjb250cm9sbGVyIHVzZXMgdGhlIGNvbW1vbiBj
bGsgYmluZGluZyBmcm9tDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxpbWdzeXMudHh0IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxpbWdzeXMudHh0DQppbmRl
eCAxZTFmMDA3Li5iNDMxMmQxIDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxpbWdzeXMudHh0DQorKysgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLGltZ3N5cy50
eHQNCkBAIC0xNCw2ICsxNCw4IEBAIFJlcXVpcmVkIFByb3BlcnRpZXM6DQogCS0gIm1lZGlhdGVr
LG10NzYyMy1pbWdzeXMiLCAibWVkaWF0ZWssbXQyNzAxLWltZ3N5cyIsICJzeXNjb24iDQogCS0g
Im1lZGlhdGVrLG10ODE3My1pbWdzeXMiLCAic3lzY29uIg0KIAktICJtZWRpYXRlayxtdDgxODMt
aW1nc3lzIiwgInN5c2NvbiINCisJLSAibWVkaWF0ZWssbXQ4MTkyLWltZ3N5cyIsICJzeXNjb24i
DQorCS0gIm1lZGlhdGVrLG10ODE5Mi1pbWdzeXMyIiwgInN5c2NvbiINCiAtICNjbG9jay1jZWxs
czogTXVzdCBiZSAxDQogDQogVGhlIGltZ3N5cyBjb250cm9sbGVyIHVzZXMgdGhlIGNvbW1vbiBj
bGsgYmluZGluZyBmcm9tDQotLSANCjEuOC4xLjEuZGlydHkNCg==

