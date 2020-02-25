Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485C7C35DF2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 06:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D24221744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 06:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PDOVoogu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgBYGry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 01:47:54 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:20268 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729084AbgBYGry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 01:47:54 -0500
X-UUID: 6899bc803adf455eb33e7163a8c70a4e-20200225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ZT7Dd2Y1yKEa/ZFxOwKFSN23PW3YcbLcZR1d9hGkyN4=;
        b=PDOVoogu4VlshOLgJKOetUKeEHItiTY1dwrGZBOm3VH0xjeuVdW5WFuKZR+7HSMsiA8BfYahjwYKBh51h5EofnVP+YphjUvaKSw0kNcd5KWCkGwsjdiTViqBRzOHeX/nZLGGgw+vpCk96+5ssFyGbkIj7dUBekCclof+k1Uwrqs=;
X-UUID: 6899bc803adf455eb33e7163a8c70a4e-20200225
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 565801886; Tue, 25 Feb 2020 14:46:47 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 25 Feb
 2020 14:45:25 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Tue, 25 Feb 2020 14:45:26 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, <huijuan.xie@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v7 1/4] dt-bindings: display: mediatek: update dpi supported chips
Date:   Tue, 25 Feb 2020 14:46:35 +0800
Message-ID: <20200225064638.112282-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200225064638.112282-1-jitao.shi@mediatek.com>
References: <20200225064638.112282-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 36D434DF1AFD45B96C71B37245CDEFEE9D2EBB3A30CB89FBDF11EFC42E1CB94B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGRlY3JpcHRpb25zIGFib3V0IHN1cHBvcnRlZCBjaGlwcywgaW5jbHVkaW5nIE1UMjcwMSAm
IE1UODE3MyAmDQptdDgxODMNCg0KMS4gQWRkIG1vcmUgY2hpcHMgc3VwcG9ydC4gZXguIE1UMjcw
MSAmIE1UODE3MyAmIE1UODE4Mw0KMi4gQWRkIHByb3BlcnR5ICJwaW5jdHJsLW5hbWVzIiB0byBz
d2FwIHBpbiBtb2RlIGJldHdlZW4gZ3BpbyBhbmQgZHBpIG1vZGUuIFNldA0KICAgcGluIG1vZGUg
dG8gZ3BpbyBvdXBwdXQtbG93IHRvIGF2b2lkIGxlYWthZ2UgY3VycmVudCB3aGVuIGRwaSBkaXNh
YmxlLg0KMy4gQWRkIHByb3BlcnR5ICJwY2xrLXNhbXBsZSIgdG8gY29uZmlnIHRoZSBkcGkgc2Ft
cGxlIG9uIGZhbGxpbmcgKDApLA0KICAgcmlzaW5nICgxKSwgYm90aCBmYWxsaW5nIGFuZCByaXNp
bmcgKDIpLg0KDQpTaWduZWQtb2ZmLWJ5OiBKaXRhbyBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5j
b20+DQotLS0NCiAuLi4vYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGkudHh0
ICAgICAgICAgfCAxMCArKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMo
KykNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNw
bGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGkudHh0DQppbmRleCBiNmE3ZTcz
OTdiOGIuLjBkZWU0ZjdhMjI3ZSAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQNCisrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRw
aS50eHQNCkBAIC03LDYgKzcsNyBAQCBvdXRwdXQgYnVzLg0KIA0KIFJlcXVpcmVkIHByb3BlcnRp
ZXM6DQogLSBjb21wYXRpYmxlOiAibWVkaWF0ZWssPGNoaXA+LWRwaSINCisgIHRoZSBzdXBwb3J0
ZWQgY2hpcHMgYXJlIG10MjcwMSAsIG10ODE3MyBhbmQgbXQ4MTgzLg0KIC0gcmVnOiBQaHlzaWNh
bCBiYXNlIGFkZHJlc3MgYW5kIGxlbmd0aCBvZiB0aGUgY29udHJvbGxlcidzIHJlZ2lzdGVycw0K
IC0gaW50ZXJydXB0czogVGhlIGludGVycnVwdCBzaWduYWwgZnJvbSB0aGUgZnVuY3Rpb24gYmxv
Y2suDQogLSBjbG9ja3M6IGRldmljZSBjbG9ja3MNCkBAIC0xNiw2ICsxNywxMSBAQCBSZXF1aXJl
ZCBwcm9wZXJ0aWVzOg0KICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2dyYXBo
LnR4dC4gVGhpcyBwb3J0IHNob3VsZCBiZSBjb25uZWN0ZWQNCiAgIHRvIHRoZSBpbnB1dCBwb3J0
IG9mIGFuIGF0dGFjaGVkIEhETUkgb3IgTFZEUyBlbmNvZGVyIGNoaXAuDQogDQorT3B0aW9uYWwg
cHJvcGVydGllczoNCistIHBpbmN0cmwtbmFtZXM6IENvbnRhaW4gImdwaW9tb2RlIiBhbmQgImRw
aW1vZGUiLg0KKy0gcGNsay1zYW1wbGU6IDA6IHNhbXBsZSBpbiBmYWxsaW5nIGVkZ2UsIDE6IHNh
bXBsZSBpbiByaXNpbmcgZWRnZSwgMjogc2FtcGxlDQorICBpbiBib3RoIGZhbGxpbmcgYW5kIHJp
c2luZyBlZGdlLg0KKw0KIEV4YW1wbGU6DQogDQogZHBpMDogZHBpQDE0MDFkMDAwIHsNCkBAIC0y
Niw2ICszMiwxMCBAQCBkcGkwOiBkcGlAMTQwMWQwMDAgew0KIAkJIDwmbW1zeXMgQ0xLX01NX0RQ
SV9FTkdJTkU+LA0KIAkJIDwmYXBtaXhlZHN5cyBDTEtfQVBNSVhFRF9UVkRQTEw+Ow0KIAljbG9j
ay1uYW1lcyA9ICJwaXhlbCIsICJlbmdpbmUiLCAicGxsIjsNCisJcGNsay1zYW1wbGUgPSAwOw0K
KwlwaW5jdHJsLW5hbWVzID0gImdwaW9tb2RlIiwgImRwaW1vZGUiOw0KKwlwaW5jdHJsLTAgPSA8
JmRwaV9waW5fZ3Bpbz47DQorCXBpbmN0cmwtMSA9IDwmZHBpX3Bpbl9mdW5jPjsNCiANCiAJcG9y
dCB7DQogCQlkcGkwX291dDogZW5kcG9pbnQgew0KLS0gDQoyLjIxLjANCg==

