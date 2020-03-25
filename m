Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5601BC18E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28DD820775
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="p1ccBwk/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgCYIOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:14:10 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:30461 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727383AbgCYIOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:14:10 -0400
X-UUID: d569855ced204cefb7cf9fcfaf31894d-20200325
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=0n+EUTSUdOSSkaTkHUmDbzhJFVoxjbBJTb+B0M4gX+k=;
        b=p1ccBwk/gar46gDywu4I7HQ3ny8LuN9edXSd3hWIP5UV/G1XB7Zz6TuvpuW0Gq/RoM7fTkLuAmLLwxnLMXG/QTD7PN+OCSYNW7M99+Op+dwRrHD4AbCfRD8HaPqkLrNKQsBLFTJkQfGuzQlXnDWwPN7Sx5bes9w8N9e0/X6fugQ=;
X-UUID: d569855ced204cefb7cf9fcfaf31894d-20200325
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <hanks.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 988951752; Wed, 25 Mar 2020 16:14:02 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 25 Mar 2020 16:13:27 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 25 Mar 2020 16:13:26 +0800
From:   Hanks Chen <hanks.chen@mediatek.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>
CC:     Andy Teng <andy.teng@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, Hanks Chen <hanks.chen@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>
Subject: [PATCH v4 5/6] pinctrl: mediatek: add mt6779 eint support
Date:   Wed, 25 Mar 2020 16:12:43 +0800
Message-ID: <1585123964-10791-6-git-send-email-hanks.chen@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1585123964-10791-1-git-send-email-hanks.chen@mediatek.com>
References: <1585123964-10791-1-git-send-email-hanks.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: FF973F850011CBAAEE0C21F1680A0D8197FD3BA48076E1571591A28544583C1E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YWRkIGRyaXZlciBzZXR0aW5nIHRvIHN1cHBvcnQgbXQ2Nzc5IGVpbnQNCg0KQ2hhbmdlLUlkOiBJ
N2FhMWU2NDExMmNiMmU0MzgxMzMyOGQ5OTcxZmQ2NDQ2MjllZGYwYQ0KU2lnbmVkLW9mZi1ieTog
SGFua3MgQ2hlbiA8aGFua3MuY2hlbkBtZWRpYXRlay5jb20+DQpTaWduZWQtb2ZmLWJ5OiBNYXJz
IENoZW5nIDxtYXJzLmNoZW5nQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvcGluY3RybC9t
ZWRpYXRlay9waW5jdHJsLW10Njc3OS5jIHwgICAgOCArKysrKysrKw0KIDEgZmlsZSBjaGFuZ2Vk
LCA4IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGluY3RybC9tZWRpYXRl
ay9waW5jdHJsLW10Njc3OS5jIGIvZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL3BpbmN0cmwtbXQ2
Nzc5LmMNCmluZGV4IDE0NWJmMjIuLjMyODIyNjAgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3BpbmN0
cmwvbWVkaWF0ZWsvcGluY3RybC1tdDY3NzkuYw0KKysrIGIvZHJpdmVycy9waW5jdHJsL21lZGlh
dGVrL3BpbmN0cmwtbXQ2Nzc5LmMNCkBAIC03MzEsMTEgKzczMSwxOSBAQA0KIAkiaW9jZmdfcnQi
LCAiaW9jZmdfbHQiLCAiaW9jZmdfdGwiLA0KIH07DQogDQorc3RhdGljIGNvbnN0IHN0cnVjdCBt
dGtfZWludF9odyBtdDY3NzlfZWludF9odyA9IHsNCisJLnBvcnRfbWFzayA9IDcsDQorCS5wb3J0
cyAgICAgPSA2LA0KKwkuYXBfbnVtICAgID0gMTk1LA0KKwkuZGJfY250ICAgID0gMTMsDQorfTsN
CisNCiBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19waW5fc29jIG10Njc3OV9kYXRhID0gew0KIAku
cmVnX2NhbCA9IG10Njc3OV9yZWdfY2FscywNCiAJLnBpbnMgPSBtdGtfcGluc19tdDY3NzksDQog
CS5ucGlucyA9IEFSUkFZX1NJWkUobXRrX3BpbnNfbXQ2Nzc5KSwNCiAJLm5ncnBzID0gQVJSQVlf
U0laRShtdGtfcGluc19tdDY3NzkpLA0KKwkuZWludF9odyA9ICZtdDY3NzlfZWludF9odywNCiAJ
LmdwaW9fbSA9IDAsDQogCS5pZXNfcHJlc2VudCA9IHRydWUsDQogCS5iYXNlX25hbWVzID0gbXQ2
Nzc5X3BpbmN0cmxfcmVnaXN0ZXJfYmFzZV9uYW1lcywNCi0tIA0KMS43LjkuNQ0K

