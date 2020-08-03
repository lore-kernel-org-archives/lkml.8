Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE8EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C60322075A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 08:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GEKOq4tq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgHCI5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 04:57:41 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34318 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725806AbgHCI5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 04:57:40 -0400
X-UUID: 96cee2b537f1408297909ca48114b1b5-20200803
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ERSI7lvLnv/tu/AUYaGM8CHfyvlRJpUTDWsBR5j2Xvw=;
        b=GEKOq4tqqwW6xqawGaHXbMe+hHC8exyqRuyublY1HCUObDpmnSVWMDAd+BWB52HClfd1yKR+5/qR7vVfq11eAxXUKJcXbv8qJO0Z/kDRIWuOv3eVmD9OylJ4eWaeoslnoa9PIxffOUcorgcZMzfYjQ6+5jRaRKjfb9qq/sTHwPM=;
X-UUID: 96cee2b537f1408297909ca48114b1b5-20200803
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 160316854; Mon, 03 Aug 2020 16:57:38 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 3 Aug 2020 16:57:35 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 3 Aug 2020 16:57:35 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH 1/3] spmi: Add driver shutdown support
Date:   Mon, 3 Aug 2020 16:57:25 +0800
Message-ID: <1596445047-2975-2-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1596445047-2975-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1596445047-2975-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIG5ldyBzaHV0ZG93bigpIG1ldGhvZC4gIFVzZSBpdCBpbiB0aGUgc3RhbmRhcmQgZHJpdmVy
IG1vZGVsIHN0eWxlLg0KDQpTaWduZWQtb2ZmLWJ5OiBIc2luLUhzaXVuZyBXYW5nIDxoc2luLWhz
aXVuZy53YW5nQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvc3BtaS9zcG1pLmMgIHwgMTIg
KysrKysrKysrKysrDQogZHJpdmVycy9zcG1pL3NwbWkuYyAgfCAxMiArKysrKysrKysrKysNCiBp
bmNsdWRlL2xpbnV4L3NwbWkuaCB8ICAxICsNCiAyIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlv
bnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3BtaS9zcG1pLmMgYi9kcml2ZXJzL3NwbWkv
c3BtaS5jDQppbmRleCBjMTZiNjBmLi41ZmRlMDI0IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zcG1p
L3NwbWkuYw0KKysrIGIvZHJpdmVycy9zcG1pL3NwbWkuYw0KQEAgLTM1Nyw2ICszNTcsMTcgQEAg
c3RhdGljIGludCBzcG1pX2Rydl9yZW1vdmUoc3RydWN0IGRldmljZSAqZGV2KQ0KIAlyZXR1cm4g
MDsNCiB9DQogDQorc3RhdGljIHZvaWQgc3BtaV9kcnZfc2h1dGRvd24oc3RydWN0IGRldmljZSAq
ZGV2KQ0KK3sNCisJY29uc3Qgc3RydWN0IHNwbWlfZHJpdmVyICpzZHJ2ID0gdG9fc3BtaV9kcml2
ZXIoZGV2LT5kcml2ZXIpOw0KKw0KKwlpZiAoIXNkcnYpDQorCQlyZXR1cm47DQorDQorDQorCWlm
IChzZHJ2LT5zaHV0ZG93bikNCisJCXNkcnYtPnNodXRkb3duKHRvX3NwbWlfZGV2aWNlKGRldikp
Ow0KK30NCit9DQorDQogc3RhdGljIGludCBzcG1pX2Rydl91ZXZlbnQoc3RydWN0IGRldmljZSAq
ZGV2LCBzdHJ1Y3Qga29ial91ZXZlbnRfZW52ICplbnYpDQogew0KIAlpbnQgcmV0Ow0KQEAgLTM3
Myw2ICszODQsNyBAQCBzdGF0aWMgc3RydWN0IGJ1c190eXBlIHNwbWlfYnVzX3R5cGUgPSB7DQpA
QCAtMzczLDYgKzM4NCw3IEBAIHN0YXRpYyBzdHJ1Y3QgYnVzX3R5cGUgc3BtaV9idXNfdHlwZSA9
IHsNCiAJLm1hdGNoCQk9IHNwbWlfZGV2aWNlX21hdGNoLA0KIAkucHJvYmUJCT0gc3BtaV9kcnZf
cHJvYmUsDQogCS5yZW1vdmUJCT0gc3BtaV9kcnZfcmVtb3ZlLA0KKwkuc2h1dGRvd24JPSBzcG1p
X2Rydl9zaHV0ZG93biwNCiAJLnVldmVudAkJPSBzcG1pX2Rydl91ZXZlbnQsDQogfTsNCiANCmRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NwbWkuaCBiL2luY2x1ZGUvbGludXgvc3BtaS5oDQpp
bmRleCAzOTRhM2Y2Li43MjliY2JmIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9zcG1pLmgN
CisrKyBiL2luY2x1ZGUvbGludXgvc3BtaS5oDQpAQCAtMTM4LDYgKzEzOCw3IEBAIHN0cnVjdCBz
cG1pX2RyaXZlciB7DQogCXN0cnVjdCBkZXZpY2VfZHJpdmVyIGRyaXZlcjsNCiAJaW50CSgqcHJv
YmUpKHN0cnVjdCBzcG1pX2RldmljZSAqc2Rldik7DQogCXZvaWQJKCpyZW1vdmUpKHN0cnVjdCBz
cG1pX2RldmljZSAqc2Rldik7DQorCXZvaWQJKCpzaHV0ZG93bikoc3RydWN0IHNwbWlfZGV2aWNl
ICpzZGV2KTsNCiB9Ow0KIA0KIHN0YXRpYyBpbmxpbmUgc3RydWN0IHNwbWlfZHJpdmVyICp0b19z
cG1pX2RyaXZlcihzdHJ1Y3QgZGV2aWNlX2RyaXZlciAqZCkNCi0tIA0KMi42LjQNCg==

