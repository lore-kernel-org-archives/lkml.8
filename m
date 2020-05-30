Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C00C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A0D32070E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bSoSH3xg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgE3IOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 04:14:19 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:50833 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725813AbgE3IOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 04:14:18 -0400
X-UUID: 6edb94bfe3ba405d9c19a6e8ac650db8-20200530
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=8H2tXyQBBPUD1GcH5xZGraxq7v8PS8Ye3wet1U9PU0c=;
        b=bSoSH3xgmtyF636WFzCrKTwuUhjqeIpWrY5UJ1oACD3z1x91GMNP5fbYIzY89oLtzeUYUfRarzUkXnzalDFzBtGvmNwv+QH6H9aI2VcPTR4qM3ug5gh1uipYv7XJsZumG3gYU1L38lciGy0KnWa6tolCbn/B1KEDenNFAJ80/cs=;
X-UUID: 6edb94bfe3ba405d9c19a6e8ac650db8-20200530
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1464659450; Sat, 30 May 2020 16:14:13 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 30 May 2020 16:14:10 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 30 May 2020 16:14:10 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, <anan.sun@mediatek.com>,
        <cui.zhang@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>, <eizan@chromium.org>,
        <acourbot@chromium.org>
Subject: [PATCH v4 12/17] memory: mtk-smi: Get rid of mtk_smi_larb_get/put
Date:   Sat, 30 May 2020 16:10:13 +0800
Message-ID: <1590826218-23653-13-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
References: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWZ0ZXIgYWRkaW5nIGRldmljZV9saW5rIGJldHdlZW4gdGhlIGlvbW11IGNvbnN1bWVyIGFuZCBz
bWktbGFyYiwNCnRoZSBwbV9ydW50aW1lX2dldChfc3luYykgb2Ygc21pLWxhcmIgYW5kIHNtaS1j
b21tb24gd2lsbCBiZSBjYWxsZWQNCmF1dG9tYXRpY2FsbHkuIHdlIGNhbiBnZXQgcmlkIG9mIG10
a19zbWlfbGFyYl9nZXQvcHV0Lg0KDQpDQzogTWF0dGhpYXMgQnJ1Z2dlciA8bWF0dGhpYXMuYmdn
QGdtYWlsLmNvbT4NClNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29t
Pg0KUmV2aWV3ZWQtYnk6IEV2YW4gR3JlZW4gPGV2Z3JlZW5AY2hyb21pdW0ub3JnPg0KLS0tDQog
ZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jICAgfCAxNCAtLS0tLS0tLS0tLS0tLQ0KIGluY2x1ZGUv
c29jL21lZGlhdGVrL3NtaS5oIHwgMjAgLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiAyIGZpbGVzIGNo
YW5nZWQsIDM0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZW1vcnkvbXRr
LXNtaS5jIGIvZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jDQppbmRleCA2Y2RlZmRhLi4xOWMzOTQ5
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jDQorKysgYi9kcml2ZXJzL21l
bW9yeS9tdGstc21pLmMNCkBAIC0xMjUsMjAgKzEyNSw2IEBAIHN0YXRpYyB2b2lkIG10a19zbWlf
Y2xrX2Rpc2FibGUoY29uc3Qgc3RydWN0IG10a19zbWkgKnNtaSkNCiAJY2xrX2Rpc2FibGVfdW5w
cmVwYXJlKHNtaS0+Y2xrX2FwYik7DQogfQ0KIA0KLWludCBtdGtfc21pX2xhcmJfZ2V0KHN0cnVj
dCBkZXZpY2UgKmxhcmJkZXYpDQotew0KLQlpbnQgcmV0ID0gcG1fcnVudGltZV9nZXRfc3luYyhs
YXJiZGV2KTsNCi0NCi0JcmV0dXJuIChyZXQgPCAwKSA/IHJldCA6IDA7DQotfQ0KLUVYUE9SVF9T
WU1CT0xfR1BMKG10a19zbWlfbGFyYl9nZXQpOw0KLQ0KLXZvaWQgbXRrX3NtaV9sYXJiX3B1dChz
dHJ1Y3QgZGV2aWNlICpsYXJiZGV2KQ0KLXsNCi0JcG1fcnVudGltZV9wdXRfc3luYyhsYXJiZGV2
KTsNCi19DQotRVhQT1JUX1NZTUJPTF9HUEwobXRrX3NtaV9sYXJiX3B1dCk7DQotDQogc3RhdGlj
IGludA0KIG10a19zbWlfbGFyYl9iaW5kKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmlj
ZSAqbWFzdGVyLCB2b2lkICpkYXRhKQ0KIHsNCmRpZmYgLS1naXQgYS9pbmNsdWRlL3NvYy9tZWRp
YXRlay9zbWkuaCBiL2luY2x1ZGUvc29jL21lZGlhdGVrL3NtaS5oDQppbmRleCA1YTM0Yjg3Li5m
OGJmNTk1IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9zb2MvbWVkaWF0ZWsvc21pLmgNCisrKyBiL2lu
Y2x1ZGUvc29jL21lZGlhdGVrL3NtaS5oDQpAQCAtMjAsMjYgKzIwLDYgQEAgc3RydWN0IG10a19z
bWlfbGFyYl9pb21tdSB7DQogCXVuc2lnbmVkIGludCAgIG1tdTsNCiB9Ow0KIA0KLS8qDQotICog
bXRrX3NtaV9sYXJiX2dldDogRW5hYmxlIHRoZSBwb3dlciBkb21haW4gYW5kIGNsb2NrcyBmb3Ig
dGhpcyBsb2NhbCBhcmJpdGVyLg0KLSAqICAgICAgICAgICAgICAgICAgIEl0IGFsc28gaW5pdGlh
bGl6ZSBzb21lIGJhc2ljIHNldHRpbmcobGlrZSBpb21tdSkuDQotICogbXRrX3NtaV9sYXJiX3B1
dDogRGlzYWJsZSB0aGUgcG93ZXIgZG9tYWluIGFuZCBjbG9ja3MgZm9yIHRoaXMgbG9jYWwgYXJi
aXRlci4NCi0gKiBCb3RoIHNob3VsZCBiZSBjYWxsZWQgaW4gbm9uLWF0b21pYyBjb250ZXh0Lg0K
LSAqDQotICogUmV0dXJucyAwIGlmIHN1Y2Nlc3NmdWwsIG5lZ2F0aXZlIG9uIGZhaWx1cmUuDQot
ICovDQotaW50IG10a19zbWlfbGFyYl9nZXQoc3RydWN0IGRldmljZSAqbGFyYmRldik7DQotdm9p
ZCBtdGtfc21pX2xhcmJfcHV0KHN0cnVjdCBkZXZpY2UgKmxhcmJkZXYpOw0KLQ0KLSNlbHNlDQot
DQotc3RhdGljIGlubGluZSBpbnQgbXRrX3NtaV9sYXJiX2dldChzdHJ1Y3QgZGV2aWNlICpsYXJi
ZGV2KQ0KLXsNCi0JcmV0dXJuIDA7DQotfQ0KLQ0KLXN0YXRpYyBpbmxpbmUgdm9pZCBtdGtfc21p
X2xhcmJfcHV0KHN0cnVjdCBkZXZpY2UgKmxhcmJkZXYpIHsgfQ0KLQ0KICNlbmRpZg0KIA0KICNl
bmRpZg0KLS0gDQoxLjkuMQ0K

