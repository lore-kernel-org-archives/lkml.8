Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E21CC35642
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47FEE222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 09:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="T9BrwRBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgBUJwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 04:52:47 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:45387 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726989AbgBUJwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 04:52:45 -0500
X-UUID: be55aa34972145a1a254910d1c281bf8-20200221
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=UC2cQOEUUnwGN4I9ZG54PmO0xlKAPWQEv9jZU9/Qyro=;
        b=T9BrwRBsYH4ZPy4UU5NnWetfzLGb049dsfnZhq5cLY4IltVM8NBsNhh3aQXyc/Qgoy0BwgBU0VedqAD1xi02onGKSW7NmqL/x0Ncl/92DIs2SVduh74S89iUMMI3jC5mctupLc/Q106y4Sp1Bx8VOPe38xUVloKzEP90TlMxWpQ=;
X-UUID: be55aa34972145a1a254910d1c281bf8-20200221
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2131867283; Fri, 21 Feb 2020 17:52:38 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 21 Feb 2020 17:53:34 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 21 Feb 2020 17:52:59 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        mtk01761 <wendell.lin@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Evan Green <evgreen@chromium.org>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <jroedel@suse.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>
CC:     Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
Subject: [PATCH 1/5] dt-bindings: clock: mediatek: document clk bindings for Mediatek MT6765 SoC
Date:   Fri, 21 Feb 2020 17:52:18 +0800
Message-ID: <1582278742-1626-2-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1582278742-1626-1-git-send-email-macpaul.lin@mediatek.com>
References: <1582278742-1626-1-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGRzIHRoZSBiaW5kaW5nIGRvY3VtZW50YXRpb24gZm9yIGFwbWl4ZWRzeXMs
IGF1ZHN5cywgY2Ftc3lzLA0KaW1nc3lzLCBpbmZyYWNmZywgbW1zeXMsIHBlcmljZmcsIHRvcGNr
Z2VuDQoNClNpZ25lZC1vZmYtYnk6IE1hcnMgQ2hlbmcgPG1hcnMuY2hlbmdAbWVkaWF0ZWsuY29t
Pg0KU2lnbmVkLW9mZi1ieTogT3dlbiBDaGVuIDxvd2VuLmNoZW5AbWVkaWF0ZWsuY29tPg0KU2ln
bmVkLW9mZi1ieTogTWFjcGF1bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNvbT4NCi0tLQ0K
IC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxhcG1peGVkc3lz
LnR4dCAgICAgfCAxICsNCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVk
aWF0ZWssYXVkc3lzLnR4dCAgICAgICAgIHwgMSArDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3Mv
YXJtL21lZGlhdGVrL21lZGlhdGVrLGNhbXN5cy50eHQgICAgICAgICB8IDEgKw0KIC4uLi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxpbWdzeXMudHh0ICAgICAgICAg
fCAxICsNCiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssaW5m
cmFjZmcudHh0ICAgICAgIHwgMSArDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlh
dGVrL21lZGlhdGVrLG1tc3lzLnR4dCAgICAgICAgICB8IDEgKw0KIC4uLi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxwZXJpY2ZnLnR4dCAgICAgICAgfCAxICsNCiAu
Li4vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssdG9wY2tnZW4udHh0
ICAgICAgIHwgMSArDQogOCBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCg0KZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVk
aWF0ZWssYXBtaXhlZHN5cy50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
YXJtL21lZGlhdGVrL21lZGlhdGVrLGFwbWl4ZWRzeXMudHh0DQppbmRleCBmZjAwMGNjYWRlNzgu
LmJkN2EwZmE1ODAxYiAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssYXBtaXhlZHN5cy50eHQNCisrKyBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssYXBtaXhlZHN5
cy50eHQNCkBAIC04LDYgKzgsNyBAQCBSZXF1aXJlZCBQcm9wZXJ0aWVzOg0KIC0gY29tcGF0aWJs
ZTogU2hvdWxkIGJlIG9uZSBvZjoNCiAJLSAibWVkaWF0ZWssbXQyNzAxLWFwbWl4ZWRzeXMiDQog
CS0gIm1lZGlhdGVrLG10MjcxMi1hcG1peGVkc3lzIiwgInN5c2NvbiINCisJLSAibWVkaWF0ZWss
bXQ2NzY1LWFwbWl4ZWRzeXMiLCAic3lzY29uIg0KIAktICJtZWRpYXRlayxtdDY3NzktYXBtaXhl
ZHN5cyIsICJzeXNjb24iDQogCS0gIm1lZGlhdGVrLG10Njc5Ny1hcG1peGVkc3lzIg0KIAktICJt
ZWRpYXRlayxtdDc2MjItYXBtaXhlZHN5cyINCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLGF1ZHN5cy50eHQgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLGF1ZHN5
cy50eHQNCmluZGV4IGU0Y2E3YjcwMzEyMy4uMzgzMDlkYjExNWY1IDEwMDY0NA0KLS0tIGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxhdWRz
eXMudHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlh
dGVrL21lZGlhdGVrLGF1ZHN5cy50eHQNCkBAIC03LDYgKzcsNyBAQCBSZXF1aXJlZCBQcm9wZXJ0
aWVzOg0KIA0KIC0gY29tcGF0aWJsZTogU2hvdWxkIGJlIG9uZSBvZjoNCiAJLSAibWVkaWF0ZWss
bXQyNzAxLWF1ZHN5cyIsICJzeXNjb24iDQorCS0gIm1lZGlhdGVrLG10Njc2NS1hdWRzeXMiLCAi
c3lzY29uIg0KIAktICJtZWRpYXRlayxtdDY3NzktYXVkaW8iLCAic3lzY29uIg0KIAktICJtZWRp
YXRlayxtdDc2MjItYXVkc3lzIiwgInN5c2NvbiINCiAJLSAibWVkaWF0ZWssbXQ3NjIzLWF1ZHN5
cyIsICJtZWRpYXRlayxtdDI3MDEtYXVkc3lzIiwgInN5c2NvbiINCmRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLGNhbXN5
cy50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21l
ZGlhdGVrLGNhbXN5cy50eHQNCmluZGV4IDFmNGFhYTE1YTM3ZS4uYTBjZTgyMDg1YWQwIDEwMDY0
NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9t
ZWRpYXRlayxjYW1zeXMudHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLGNhbXN5cy50eHQNCkBAIC02LDYgKzYsNyBAQCBUaGUg
TWVkaWFUZWsgY2Ftc3lzIGNvbnRyb2xsZXIgcHJvdmlkZXMgdmFyaW91cyBjbG9ja3MgdG8gdGhl
IHN5c3RlbS4NCiBSZXF1aXJlZCBQcm9wZXJ0aWVzOg0KIA0KIC0gY29tcGF0aWJsZTogU2hvdWxk
IGJlIG9uZSBvZjoNCisJLSAibWVkaWF0ZWssbXQ2NzY1LWNhbXN5cyIsICJzeXNjb24iDQogCS0g
Im1lZGlhdGVrLG10Njc3OS1jYW1zeXMiLCAic3lzY29uIg0KIAktICJtZWRpYXRlayxtdDgxODMt
Y2Ftc3lzIiwgInN5c2NvbiINCiAtICNjbG9jay1jZWxsczogTXVzdCBiZSAxDQpkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRl
ayxpbWdzeXMudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRp
YXRlay9tZWRpYXRlayxpbWdzeXMudHh0DQppbmRleCAyYjY5M2UzNDNjNTYuLjFlMWYwMDcxOGE3
ZCAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVk
aWF0ZWsvbWVkaWF0ZWssaW1nc3lzLnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxpbWdzeXMudHh0DQpAQCAtOCw2ICs4LDcg
QEAgUmVxdWlyZWQgUHJvcGVydGllczoNCiAtIGNvbXBhdGlibGU6IFNob3VsZCBiZSBvbmUgb2Y6
DQogCS0gIm1lZGlhdGVrLG10MjcwMS1pbWdzeXMiLCAic3lzY29uIg0KIAktICJtZWRpYXRlayxt
dDI3MTItaW1nc3lzIiwgInN5c2NvbiINCisJLSAibWVkaWF0ZWssbXQ2NzY1LWltZ3N5cyIsICJz
eXNjb24iDQogCS0gIm1lZGlhdGVrLG10Njc3OS1pbWdzeXMiLCAic3lzY29uIg0KIAktICJtZWRp
YXRlayxtdDY3OTctaW1nc3lzIiwgInN5c2NvbiINCiAJLSAibWVkaWF0ZWssbXQ3NjIzLWltZ3N5
cyIsICJtZWRpYXRlayxtdDI3MDEtaW1nc3lzIiwgInN5c2NvbiINCmRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLGluZnJh
Y2ZnLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsv
bWVkaWF0ZWssaW5mcmFjZmcudHh0DQppbmRleCBkYjJmNGZkNzU0ZTcuLjQ5YTk2OGJlMWE4MCAx
MDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0
ZWsvbWVkaWF0ZWssaW5mcmFjZmcudHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLGluZnJhY2ZnLnR4dA0KQEAgLTksNiArOSw3
IEBAIFJlcXVpcmVkIFByb3BlcnRpZXM6DQogLSBjb21wYXRpYmxlOiBTaG91bGQgYmUgb25lIG9m
Og0KIAktICJtZWRpYXRlayxtdDI3MDEtaW5mcmFjZmciLCAic3lzY29uIg0KIAktICJtZWRpYXRl
ayxtdDI3MTItaW5mcmFjZmciLCAic3lzY29uIg0KKwktICJtZWRpYXRlayxtdDY3NjUtaW5mcmFj
ZmciLCAic3lzY29uIg0KIAktICJtZWRpYXRlayxtdDY3NzktaW5mcmFjZmdfYW8iLCAic3lzY29u
Ig0KIAktICJtZWRpYXRlayxtdDY3OTctaW5mcmFjZmciLCAic3lzY29uIg0KIAktICJtZWRpYXRl
ayxtdDc2MjItaW5mcmFjZmciLCAic3lzY29uIg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssbW1zeXMudHh0IGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxtbXN5
cy50eHQNCmluZGV4IDMwMWVlZmJlMTYxOC4uNGE3MTI1MDliZWMyIDEwMDY0NA0KLS0tIGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxtbXN5
cy50eHQNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0
ZWsvbWVkaWF0ZWssbW1zeXMudHh0DQpAQCAtOCw2ICs4LDcgQEAgUmVxdWlyZWQgUHJvcGVydGll
czoNCiAtIGNvbXBhdGlibGU6IFNob3VsZCBiZSBvbmUgb2Y6DQogCS0gIm1lZGlhdGVrLG10Mjcw
MS1tbXN5cyIsICJzeXNjb24iDQogCS0gIm1lZGlhdGVrLG10MjcxMi1tbXN5cyIsICJzeXNjb24i
DQorCS0gIm1lZGlhdGVrLG10Njc2NS1tbXN5cyIsICJzeXNjb24iDQogCS0gIm1lZGlhdGVrLG10
Njc3OS1tbXN5cyIsICJzeXNjb24iDQogCS0gIm1lZGlhdGVrLG10Njc5Ny1tbXN5cyIsICJzeXNj
b24iDQogCS0gIm1lZGlhdGVrLG10NzYyMy1tbXN5cyIsICJtZWRpYXRlayxtdDI3MDEtbW1zeXMi
LCAic3lzY29uIg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWsscGVyaWNmZy50eHQgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLHBlcmljZmcudHh0DQppbmRleCBl
Y2YwMjdhOTAwM2EuLmRjYmQ0MTRjN2ZkNyAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWsscGVyaWNmZy50eHQNCisrKyBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWss
cGVyaWNmZy50eHQNCkBAIC05LDYgKzksNyBAQCBSZXF1aXJlZCBQcm9wZXJ0aWVzOg0KIC0gY29t
cGF0aWJsZTogU2hvdWxkIGJlIG9uZSBvZjoNCiAJLSAibWVkaWF0ZWssbXQyNzAxLXBlcmljZmci
LCAic3lzY29uIg0KIAktICJtZWRpYXRlayxtdDI3MTItcGVyaWNmZyIsICJzeXNjb24iDQorCS0g
Im1lZGlhdGVrLG10Njc2NS1wZXJpY2ZnIiwgInN5c2NvbiINCiAJLSAibWVkaWF0ZWssbXQ3NjIy
LXBlcmljZmciLCAic3lzY29uIg0KIAktICJtZWRpYXRlayxtdDc2MjMtcGVyaWNmZyIsICJtZWRp
YXRlayxtdDI3MDEtcGVyaWNmZyIsICJzeXNjb24iDQogCS0gIm1lZGlhdGVrLG10NzYyOS1wZXJp
Y2ZnIiwgInN5c2NvbiINCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLHRvcGNrZ2VuLnR4dCBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssdG9wY2tnZW4udHh0DQpp
bmRleCAwMjkzZDY5M2NlMGMuLjliMDM5NGNiYmRjOSAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssdG9wY2tnZW4udHh0
DQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21l
ZGlhdGVrLHRvcGNrZ2VuLnR4dA0KQEAgLTgsNiArOCw3IEBAIFJlcXVpcmVkIFByb3BlcnRpZXM6
DQogLSBjb21wYXRpYmxlOiBTaG91bGQgYmUgb25lIG9mOg0KIAktICJtZWRpYXRlayxtdDI3MDEt
dG9wY2tnZW4iDQogCS0gIm1lZGlhdGVrLG10MjcxMi10b3Bja2dlbiIsICJzeXNjb24iDQorCS0g
Im1lZGlhdGVrLG10Njc2NS10b3Bja2dlbiIsICJzeXNjb24iDQogCS0gIm1lZGlhdGVrLG10Njc3
OS10b3Bja2dlbiIsICJzeXNjb24iDQogCS0gIm1lZGlhdGVrLG10Njc5Ny10b3Bja2dlbiINCiAJ
LSAibWVkaWF0ZWssbXQ3NjIyLXRvcGNrZ2VuIg0KLS0gDQoyLjE4LjANCg==

