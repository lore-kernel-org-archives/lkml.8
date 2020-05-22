Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319B7C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 10:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 133732065C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 10:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="rORpKnmy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbgEVKMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 06:12:34 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:25166 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728281AbgEVKMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 06:12:33 -0400
X-UUID: aa7538676fed4a19805128da08b1b442-20200522
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=6VbmeS/yrB1shYHBD+b0ArTurRXYrmNDPa81/IwQ/tI=;
        b=rORpKnmyumfflCfytKRhmTVJuOy37KS2lD8cDOBpUqY+wnPY2vyfA2ykKfT5mf2A+X1gqZnpTFpVToJy2FBBiKVq2Zo71jMj/70kcdFcwmol6zDWei2libtTVIoeHsKl3/oiu96t94bSBQVHcgHCQU2Xcm9n3I3Tzx7Ep5jP0lw=;
X-UUID: aa7538676fed4a19805128da08b1b442-20200522
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1393466909; Fri, 22 May 2020 18:12:27 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 22 May
 2020 18:12:25 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 22 May 2020 18:12:24 +0800
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
Subject: [PATCH] drm/mediatek: dsi: fix scrolling of panel with small hfp or hbp
Date:   Fri, 22 May 2020 18:12:25 +0800
Message-ID: <20200522101225.62571-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9EFD99E22082E0674480556A643F1BD34B12751A45F5F49297FAC1342418AC822000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SWYgcGFuZWwgaGFzIHRvbyBzbWFsbCBoZnAgb3IgaGJwLCBob3Jpem9udGFsX2Zyb250cG9yY2hf
Ynl0ZSBvcg0KaG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0ZSBtYXkgYmVjb21lIHZlcnkgc21hbGwg
dmFsdWUgb3IgbmVnYXRpdmUNCnZhbHVlLiBUaGlzIHBhdGNoIGFkanVzdHMgdGhlaXIgdmFsdWVz
IHNvIHRoYXQgdGhleSBhcmUgZ3JlYXRlcg0KdGhhbiBtaW5pbXVtIHZhbHVlIGFuZCBrZWVwIHRv
dGFsIG9mIHRoZW0gdW5jaGFuZ2VkLg0KDQpTaWduZWQtb2ZmLWJ5OiBKaXRhbyBTaGkgPGppdGFv
LnNoaUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rz
aS5jIHwgMTggKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlv
bnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQppbmRleCAwZWRlNjk4MzBhOWQu
LmFlYmFhZmQ5MGNlYiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHNpLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMNCkBAIC0xNDgs
NiArMTQ4LDkgQEANCiAJKHR5cGUgPT0gTUlQSV9EU0lfR0VORVJJQ19SRUFEX1JFUVVFU1RfMl9Q
QVJBTSkgfHwgXA0KIAkodHlwZSA9PSBNSVBJX0RTSV9EQ1NfUkVBRCkpDQogDQorI2RlZmluZSBN
SU5fSEZQX0JZVEUJCTB4MDINCisjZGVmaW5lIE1JTl9IQlBfQllURQkJMHgwMg0KKw0KIHN0cnVj
dCBtdGtfcGh5X3RpbWluZyB7DQogCXUzMiBscHg7DQogCXUzMiBkYV9oc19wcmVwYXJlOw0KQEAg
LTQ1MCw2ICs0NTMsNyBAQCBzdGF0aWMgdm9pZCBtdGtfZHNpX2NvbmZpZ192ZG9fdGltaW5nKHN0
cnVjdCBtdGtfZHNpICpkc2kpDQogCXUzMiBob3Jpem9udGFsX3N5bmNfYWN0aXZlX2J5dGU7DQog
CXUzMiBob3Jpem9udGFsX2JhY2twb3JjaF9ieXRlOw0KIAl1MzIgaG9yaXpvbnRhbF9mcm9udHBv
cmNoX2J5dGU7DQorCXMzMiBzaWduZWRfaGZwX2J5dGUsIHNpZ25lZF9oYnBfYnl0ZTsNCiAJdTMy
IGRzaV90bXBfYnVmX2JwcCwgZGF0YV9waHlfY3ljbGVzOw0KIAlzdHJ1Y3QgbXRrX3BoeV90aW1p
bmcgKnRpbWluZyA9ICZkc2ktPnBoeV90aW1pbmc7DQogDQpAQCAtNTE5LDYgKzUyMywyMCBAQCBz
dGF0aWMgdm9pZCBtdGtfZHNpX2NvbmZpZ192ZG9fdGltaW5nKHN0cnVjdCBtdGtfZHNpICpkc2kp
DQogCQl9DQogCX0NCiANCisJc2lnbmVkX2hmcF9ieXRlID0gKHMzMilob3Jpem9udGFsX2Zyb250
cG9yY2hfYnl0ZTsNCisJc2lnbmVkX2hicF9ieXRlID0gKHMzMilob3Jpem9udGFsX2JhY2twb3Jj
aF9ieXRlOw0KKw0KKwlpZiAoc2lnbmVkX2hmcF9ieXRlICsgc2lnbmVkX2hicF9ieXRlIDwgTUlO
X0hGUF9CWVRFICsgTUlOX0hCUF9CWVRFKSB7DQorCQlEUk1fV0FSTigiQ2FsY3VsYXRlZCBoZnBf
Ynl0ZSBhbmQgaGJwX2J5dGUgYXJlIHRvbyBzbWFsbCwgIg0KKwkJCSAicGFuZWwgbWF5IG5vdCB3
b3JrIHByb3Blcmx5LlxuIik7DQorCX0gZWxzZSBpZiAoc2lnbmVkX2hmcF9ieXRlIDwgTUlOX0hG
UF9CWVRFKSB7DQorCQlob3Jpem9udGFsX2Zyb250cG9yY2hfYnl0ZSA9IE1JTl9IRlBfQllURTsN
CisJCWhvcml6b250YWxfYmFja3BvcmNoX2J5dGUgLT0gTUlOX0hGUF9CWVRFIC0gc2lnbmVkX2hm
cF9ieXRlOw0KKwl9IGVsc2UgaWYgKHNpZ25lZF9oYnBfYnl0ZSA8IE1JTl9IQlBfQllURSkgew0K
KwkJaG9yaXpvbnRhbF9mcm9udHBvcmNoX2J5dGUgLT0gTUlOX0hCUF9CWVRFIC0gc2lnbmVkX2hi
cF9ieXRlOw0KKwkJaG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0ZSA9IE1JTl9IQlBfQllURTsNCisJ
fQ0KKw0KIAl3cml0ZWwoaG9yaXpvbnRhbF9zeW5jX2FjdGl2ZV9ieXRlLCBkc2ktPnJlZ3MgKyBE
U0lfSFNBX1dDKTsNCiAJd3JpdGVsKGhvcml6b250YWxfYmFja3BvcmNoX2J5dGUsIGRzaS0+cmVn
cyArIERTSV9IQlBfV0MpOw0KIAl3cml0ZWwoaG9yaXpvbnRhbF9mcm9udHBvcmNoX2J5dGUsIGRz
aS0+cmVncyArIERTSV9IRlBfV0MpOw0KLS0gDQoyLjI1LjENCg==

