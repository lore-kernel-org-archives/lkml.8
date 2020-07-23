Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092C8C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6EE2207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uEHPbaWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387814AbgGWDk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 23:40:27 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:22385 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387797AbgGWDkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 23:40:25 -0400
X-UUID: 0ecb2dcba9044329a88e747761756eb2-20200723
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=K40oCWnkehv+R4EecDWzyL/LvaW4FziBkaXpPnK2J84=;
        b=uEHPbaWUN57zLnCJto1lG7xffMporf9epi/OOTybHosd8OcRwimWeT3rzuT6127RUzjeym9MHAxWPjtSsnZSFqGvLPOd0IokB9BAKJggoi6sKuR7nlkltWKzseReqPMN3EJg9X3CIST02fHUOvcvoFuJFntHMShuZjegyf81wu0=;
X-UUID: 0ecb2dcba9044329a88e747761756eb2-20200723
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1093032588; Thu, 23 Jul 2020 11:40:20 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Jul 2020 11:40:18 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Jul 2020 11:40:16 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Argus Lin <argus.lin@mediatek.com>
CC:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Subject: [PATCH v2 4/4] soc: mediatek: pwrap: add pwrap driver for MT6873/8192 SoCs
Date:   Thu, 23 Jul 2020 11:40:00 +0800
Message-ID: <1595475600-23180-5-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1595475600-23180-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1595475600-23180-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TVQ2ODczLzgxOTIgYXJlIGhpZ2hseSBpbnRlZ3JhdGVkIFNvQ3MgYW5kIHVzZSBQTUlDX01UNjM1
OSBmb3INCnBvd2VyIG1hbmFnZW1lbnQuIFRoaXMgcGF0Y2ggYWRkcyBwd3JhcCBtYXN0ZXIgZHJp
dmVyIHRvDQphY2Nlc3MgUE1JQ19NVDYzNTkuDQoNClNpZ25lZC1vZmYtYnk6IEhzaW4tSHNpdW5n
IFdhbmcgPGhzaW4taHNpdW5nLndhbmdAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9zb2Mv
bWVkaWF0ZWsvbXRrLXBtaWMtd3JhcC5jIHwgMjkgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCiAxIGZpbGUgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9zb2MvbWVkaWF0ZWsvbXRrLXBtaWMtd3JhcC5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsv
bXRrLXBtaWMtd3JhcC5jDQppbmRleCA4ZDc2ZWQ0Li42YmEwNjA0IDEwMDY0NA0KLS0tIGEvZHJp
dmVycy9zb2MvbWVkaWF0ZWsvbXRrLXBtaWMtd3JhcC5jDQorKysgYi9kcml2ZXJzL3NvYy9tZWRp
YXRlay9tdGstcG1pYy13cmFwLmMNCkBAIC02MzIsNiArNjMyLDE3IEBAIHN0YXRpYyBpbnQgbXQ2
Nzk3X3JlZ3NbXSA9IHsNCiAJW1BXUkFQX0RDTV9EQkNfUFJEXSA9CQkweDFENCwNCiB9Ow0KIA0K
K3N0YXRpYyBpbnQgbXQ2ODczX3JlZ3NbXSA9IHsNCisJW1BXUkFQX0lOSVRfRE9ORTJdID0JCTB4
MCwNCisJW1BXUkFQX1RJTUVSX0VOXSA9CQkweDNFMCwNCisJW1BXUkFQX0lOVF9FTl0gPQkJMHg0
NDgsDQorCVtQV1JBUF9XQUNTMl9DTURdID0JCTB4QzgwLA0KKwlbUFdSQVBfU1dJTkZfMl9XREFU
QV8zMV8wXSA9CTB4Qzg0LA0KKwlbUFdSQVBfU1dJTkZfMl9SREFUQV8zMV8wXSA9CTB4Qzk0LA0K
KwlbUFdSQVBfV0FDUzJfVkxEQ0xSXSA9CQkweENBNCwNCisJW1BXUkFQX1dBQ1MyX1JEQVRBXSA9
CQkweENBOCwNCit9Ow0KKw0KIHN0YXRpYyBpbnQgbXQ3NjIyX3JlZ3NbXSA9IHsNCiAJW1BXUkFQ
X01VWF9TRUxdID0JCTB4MCwNCiAJW1BXUkFQX1dSQVBfRU5dID0JCTB4NCwNCkBAIC0xMDUwLDYg
KzEwNjEsNyBAQCBlbnVtIHB3cmFwX3R5cGUgew0KIAlQV1JBUF9NVDY3NjUsDQogCVBXUkFQX01U
Njc3OSwNCiAJUFdSQVBfTVQ2Nzk3LA0KKwlQV1JBUF9NVDY4NzMsDQogCVBXUkFQX01UNzYyMiwN
CiAJUFdSQVBfTVQ4MTM1LA0KIAlQV1JBUF9NVDgxNzMsDQpAQCAtMTUxNyw2ICsxNTI5LDcgQEAg
c3RhdGljIGludCBwd3JhcF9pbml0X2NpcGhlcihzdHJ1Y3QgcG1pY193cmFwcGVyICp3cnApDQog
CWNhc2UgUFdSQVBfTVQ3NjIyOg0KIAkJcHdyYXBfd3JpdGVsKHdycCwgMCwgUFdSQVBfQ0lQSEVS
X0VOKTsNCiAJCWJyZWFrOw0KKwljYXNlIFBXUkFQX01UNjg3MzoNCiAJY2FzZSBQV1JBUF9NVDgx
ODM6DQogCQlicmVhazsNCiAJfQ0KQEAgLTE5NTMsNiArMTk2NiwxOSBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IHBtaWNfd3JhcHBlcl90eXBlIHB3cmFwX210Njc5NyA9IHsNCiAJLmluaXRfc29jX3Nw
ZWNpZmljID0gTlVMTCwNCiB9Ow0KIA0KK3N0YXRpYyBzdHJ1Y3QgcG1pY193cmFwcGVyX3R5cGUg
cHdyYXBfbXQ2ODczID0gew0KKwkucmVncyA9IG10Njg3M19yZWdzLA0KKwkudHlwZSA9IFBXUkFQ
X01UNjg3MywNCisJLmFyYl9lbl9hbGwgPSAweDc3N2YsDQorCS5pbnRfZW5fYWxsID0gQklUKDQp
IHwgQklUKDUpLA0KKwkuaW50MV9lbl9hbGwgPSAwLA0KKwkuc3BpX3cgPSBQV1JBUF9NQU5fQ01E
X1NQSV9XUklURSwNCisJLndkdF9zcmMgPSBQV1JBUF9XRFRfU1JDX01BU0tfQUxMLA0KKwkuY2Fw
cyA9IFBXUkFQX0NBUF9BUkIsDQorCS5pbml0X3JlZ19jbG9jayA9IHB3cmFwX2NvbW1vbl9pbml0
X3JlZ19jbG9jaywNCisJLmluaXRfc29jX3NwZWNpZmljID0gTlVMTCwNCit9Ow0KKw0KIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgcG1pY193cmFwcGVyX3R5cGUgcHdyYXBfbXQ3NjIyID0gew0KIAkucmVn
cyA9IG10NzYyMl9yZWdzLA0KIAkudHlwZSA9IFBXUkFQX01UNzYyMiwNCkBAIC0yMDMxLDYgKzIw
NTcsOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBvZl9wd3JhcF9tYXRjaF90
YmxbXSA9IHsNCiAJCS5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10Njc5Ny1wd3JhcCIsDQogCQku
ZGF0YSA9ICZwd3JhcF9tdDY3OTcsDQogCX0sIHsNCisJCS5jb21wYXRpYmxlID0gIm1lZGlhdGVr
LG10Njg3My1wd3JhcCIsDQorCQkuZGF0YSA9ICZwd3JhcF9tdDY4NzMsDQorCX0sIHsNCiAJCS5j
b21wYXRpYmxlID0gIm1lZGlhdGVrLG10NzYyMi1wd3JhcCIsDQogCQkuZGF0YSA9ICZwd3JhcF9t
dDc2MjIsDQogCX0sIHsNCi0tIA0KMi42LjQNCg==

