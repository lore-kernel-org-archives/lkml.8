Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1276C35DF8
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 06:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B3F21744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 06:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="K0cJVJjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgBYG5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 01:57:39 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:55019 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728999AbgBYG5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 01:57:39 -0500
X-UUID: 77d95543c9c649f483443a3d1d27b690-20200225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=XR2ppAD5uxrVIqeYRVReyXmjp0MHBUPGhrr7FaNU7Hc=;
        b=K0cJVJjFRtuJFmX01fuH+CSx0tV2+29+DPcI+ZK7SmZQsget8GqdMXDfbOLKq3uOUrAxEXI5S0m2WjM4CcZPtWg/Gu8wNrokrtzIclvcmEik+20RKR+tzrzyig3yYTx6dM9sVfb9opjbvNCgdXrdbs6LLaPVMqETFkDKcjLbJlg=;
X-UUID: 77d95543c9c649f483443a3d1d27b690-20200225
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1509474478; Tue, 25 Feb 2020 14:46:48 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 25 Feb
 2020 14:42:52 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Tue, 25 Feb 2020 14:45:27 +0800
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
Subject: [PATCH v7 2/4] drm/mediatek: dpi sample mode support
Date:   Tue, 25 Feb 2020 14:46:36 +0800
Message-ID: <20200225064638.112282-3-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200225064638.112282-1-jitao.shi@mediatek.com>
References: <20200225064638.112282-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F530CDD1AE990674843909EBD598AE1A7B6D596DFB8696F3C5AA950F8906ABF92000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RFBJIGNhbiBzYW1wbGUgb24gZmFsbGluZywgcmlzaW5nIG9yIGJvdGggZWRnZS4NCldoZW4gRFBJ
IHNhbXBsZSB0aGUgZGF0YSBib3RoIHJpc2luZyBhbmQgZmFsbGluZyBlZGdlLg0KSXQgY2FuIHJl
ZHVjZSBoYWxmIGRhdGEgaW8gcGlucy4NCg0KU2lnbmVkLW9mZi1ieTogSml0YW8gU2hpIDxqaXRh
by5zaGlAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cGkuYyB8IDE4ICsrKysrKysrKysrKysrKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcGkuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMNCmlu
ZGV4IDAxZmE4YjhkNzYzZC4uMDgyOTkwNDJkZGE3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcGkuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcGkuYw0KQEAgLTc1LDYgKzc1LDcgQEAgc3RydWN0IG10a19kcGkgew0KIAllbnVtIG10a19k
cGlfb3V0X2JpdF9udW0gYml0X251bTsNCiAJZW51bSBtdGtfZHBpX291dF9jaGFubmVsX3N3YXAg
Y2hhbm5lbF9zd2FwOw0KIAlpbnQgcmVmY291bnQ7DQorCXUzMiBwY2xrX3NhbXBsZTsNCiB9Ow0K
IA0KIHN0YXRpYyBpbmxpbmUgc3RydWN0IG10a19kcGkgKm10a19kcGlfZnJvbV9lbmNvZGVyKHN0
cnVjdCBkcm1fZW5jb2RlciAqZSkNCkBAIC0zNDgsNiArMzQ5LDEzIEBAIHN0YXRpYyB2b2lkIG10
a19kcGlfY29uZmlnX2Rpc2FibGVfZWRnZShzdHJ1Y3QgbXRrX2RwaSAqZHBpKQ0KIAkJbXRrX2Rw
aV9tYXNrKGRwaSwgZHBpLT5jb25mLT5yZWdfaF9mcmVfY29uLCAwLCBFREdFX1NFTF9FTik7DQog
fQ0KIA0KK3N0YXRpYyB2b2lkIG10a19kcGlfZW5hYmxlX3BjbGtfc2FtcGxlX2R1YWxfZWRnZShz
dHJ1Y3QgbXRrX2RwaSAqZHBpKQ0KK3sNCisJbXRrX2RwaV9tYXNrKGRwaSwgRFBJX0REUl9TRVRU
SU5HLCBERFJfRU4gfCBERFJfNFBIQVNFLA0KKwkJICAgICBERFJfRU4gfCBERFJfNFBIQVNFKTsN
CisJbXRrX2RwaV9tYXNrKGRwaSwgRFBJX09VVFBVVF9TRVRUSU5HLCBFREdFX1NFTCwgRURHRV9T
RUwpOw0KK30NCisNCiBzdGF0aWMgdm9pZCBtdGtfZHBpX2NvbmZpZ19jb2xvcl9mb3JtYXQoc3Ry
dWN0IG10a19kcGkgKmRwaSwNCiAJCQkJCWVudW0gbXRrX2RwaV9vdXRfY29sb3JfZm9ybWF0IGZv
cm1hdCkNCiB7DQpAQCAtNDM5LDcgKzQ0Nyw4IEBAIHN0YXRpYyBpbnQgbXRrX2RwaV9zZXRfZGlz
cGxheV9tb2RlKHN0cnVjdCBtdGtfZHBpICpkcGksDQogCXBsbF9yYXRlID0gY2xrX2dldF9yYXRl
KGRwaS0+dHZkX2Nsayk7DQogDQogCXZtLnBpeGVsY2xvY2sgPSBwbGxfcmF0ZSAvIGZhY3RvcjsN
Ci0JY2xrX3NldF9yYXRlKGRwaS0+cGl4ZWxfY2xrLCB2bS5waXhlbGNsb2NrKTsNCisJY2xrX3Nl
dF9yYXRlKGRwaS0+cGl4ZWxfY2xrLA0KKwkJICAgICB2bS5waXhlbGNsb2NrICogKGRwaS0+cGNs
a19zYW1wbGUgPiAxID8gMiA6IDEpKTsNCiAJdm0ucGl4ZWxjbG9jayA9IGNsa19nZXRfcmF0ZShk
cGktPnBpeGVsX2Nsayk7DQogDQogCWRldl9kYmcoZHBpLT5kZXYsICJHb3QgIFBMTCAlbHUgSHos
IHBpeGVsIGNsb2NrICVsdSBIelxuIiwNCkBAIC00NTAsNyArNDU5LDggQEAgc3RhdGljIGludCBt
dGtfZHBpX3NldF9kaXNwbGF5X21vZGUoc3RydWN0IG10a19kcGkgKmRwaSwNCiAJbGltaXQueV9i
b3R0b20gPSAweDAwMTA7DQogCWxpbWl0LnlfdG9wID0gMHgwRkUwOw0KIA0KLQlkcGlfcG9sLmNr
X3BvbCA9IE1US19EUElfUE9MQVJJVFlfRkFMTElORzsNCisJZHBpX3BvbC5ja19wb2wgPSBkcGkt
PnBjbGtfc2FtcGxlID09IDEgPw0KKwkJCSBNVEtfRFBJX1BPTEFSSVRZX1JJU0lORyA6IE1US19E
UElfUE9MQVJJVFlfRkFMTElORzsNCiAJZHBpX3BvbC5kZV9wb2wgPSBNVEtfRFBJX1BPTEFSSVRZ
X1JJU0lORzsNCiAJZHBpX3BvbC5oc3luY19wb2wgPSB2bS5mbGFncyAmIERJU1BMQVlfRkxBR1Nf
SFNZTkNfSElHSCA/DQogCQkJICAgIE1US19EUElfUE9MQVJJVFlfRkFMTElORyA6IE1US19EUElf
UE9MQVJJVFlfUklTSU5HOw0KQEAgLTUwNCw2ICs1MTQsOCBAQCBzdGF0aWMgaW50IG10a19kcGlf
c2V0X2Rpc3BsYXlfbW9kZShzdHJ1Y3QgbXRrX2RwaSAqZHBpLA0KIAltdGtfZHBpX2NvbmZpZ19j
b2xvcl9mb3JtYXQoZHBpLCBkcGktPmNvbG9yX2Zvcm1hdCk7DQogCW10a19kcGlfY29uZmlnXzJu
X2hfZnJlKGRwaSk7DQogCW10a19kcGlfY29uZmlnX2Rpc2FibGVfZWRnZShkcGkpOw0KKwlpZiAo
ZHBpLT5wY2xrX3NhbXBsZSA+IDEpDQorCQltdGtfZHBpX2VuYWJsZV9wY2xrX3NhbXBsZV9kdWFs
X2VkZ2UoZHBpKTsNCiAJbXRrX2RwaV9zd19yZXNldChkcGksIGZhbHNlKTsNCiANCiAJcmV0dXJu
IDA7DQpAQCAtNjg5LDYgKzcwMSw4IEBAIHN0YXRpYyBpbnQgbXRrX2RwaV9wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIA0KIAlkcGktPmRldiA9IGRldjsNCiAJZHBpLT5jb25m
ID0gKHN0cnVjdCBtdGtfZHBpX2NvbmYgKilvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoZGV2KTsN
CisJZHBpLT5wY2xrX3NhbXBsZSA9IG9mX3Byb3BlcnR5X3JlYWRfdTMyX2luZGV4KGRldi0+b2Zf
bm9kZSwNCisJCQkJCQkgICAgICAicGNsay1zYW1wbGUiKTsNCiANCiAJbWVtID0gcGxhdGZvcm1f
Z2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCiAJZHBpLT5yZWdzID0gZGV2
bV9pb3JlbWFwX3Jlc291cmNlKGRldiwgbWVtKTsNCi0tIA0KMi4yMS4wDQo=

