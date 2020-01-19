Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F49C33CB6
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 01:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1EC24680
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 01:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kBJZi2be"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgASBqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 20:46:22 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:17002 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728978AbgASBqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 20:46:20 -0500
X-UUID: 59440ec3e1d644e3a3dffd68aa4b00f4-20200119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=+VvUdG5czMFQ6vj3bLpdxYbfWO+M89EVYUK9328VdMQ=;
        b=kBJZi2bef0+ZYnlTKEgbAB/DSr79Y5KcXRJzJZQ7JaLjKdDwt10wGPeZvM10pWoOyin0+tRMdVz8ks1HQ387GpavggzsnIWGGu5V1ZYcM7tx+R/Vh0SsyLNSytJAxdUY9WxfdOXVE6Se0JTSk3rXf7KR+k2fm3WAsLPO9yZwgbM=;
X-UUID: 59440ec3e1d644e3a3dffd68aa4b00f4-20200119
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1445019353; Sun, 19 Jan 2020 09:46:17 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sun, 19 Jan
 2020 09:46:43 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Sun, 19 Jan 2020 09:45:06 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v10 4/5] drm/panel: support for boe, tv101wum-n53 wuxga dsi video mode panel
Date:   Sun, 19 Jan 2020 09:45:40 +0800
Message-ID: <20200119014541.64273-5-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200119014541.64273-1-jitao.shi@mediatek.com>
References: <20200119014541.64273-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E92652DB935B8C4B9CBE49BB4E0082055E79ADBB6757440A24D486470C73F4BB2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qm9lLHR2MTAxd3VtLW41MydzIGNvbm5lY3RvciBpcyBzYW1lIGFzIGJvZSx0djEwMXd1bS1ubDYu
DQpUaGUgbW9zdCBjb2RlcyBjYW4gYmUgcmV1c2UuDQpTbyBib2UsdHYxMDF3dW0tbjUzIGFuZCBi
b2UsdHYxMDF3dW0tbmw2IHVzZSBvbmUgZHJpdmVyIGZpbGUuDQpBZGQgdGhlIGRpZmZlcmVudCBw
YXJ0cyBpbiBkcml2ZXIgZGF0YS4NCg0KU2lnbmVkLW9mZi1ieTogSml0YW8gU2hpIDxqaXRhby5z
aGlAbWVkaWF0ZWsuY29tPg0KUmV2aWV3ZWQtYnk6IFNhbSBSYXZuYm9yZyA8c2FtQHJhdm5ib3Jn
Lm9yZz4NCi0tLQ0KIC4uLi9ncHUvZHJtL3BhbmVsL3BhbmVsLWJvZS10djEwMXd1bS1ubDYuYyAg
ICB8IDMxICsrKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMzEgaW5zZXJ0aW9u
cygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3BhbmVsL3BhbmVsLWJvZS10djEw
MXd1bS1ubDYuYyBiL2RyaXZlcnMvZ3B1L2RybS9wYW5lbC9wYW5lbC1ib2UtdHYxMDF3dW0tbmw2
LmMNCmluZGV4IDIxNjAxNDRjYTUxYi4uZTc3ZWE1NzdkOTNhIDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL3BhbmVsL3BhbmVsLWJvZS10djEwMXd1bS1ubDYuYw0KKysrIGIvZHJpdmVycy9n
cHUvZHJtL3BhbmVsL3BhbmVsLWJvZS10djEwMXd1bS1ubDYuYw0KQEAgLTU5Myw2ICs1OTMsMzQg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwYW5lbF9kZXNjIGF1b19rZDEwMW44MF80NW5hX2Rlc2Mg
PSB7DQogCS5kaXNjaGFyZ2Vfb25fZGlzYWJsZSA9IHRydWUsDQogfTsNCiANCitzdGF0aWMgY29u
c3Qgc3RydWN0IGRybV9kaXNwbGF5X21vZGUgYm9lX3R2MTAxd3VtX241M19kZWZhdWx0X21vZGUg
PSB7DQorCS5jbG9jayA9IDE1OTkxNiwNCisJLmhkaXNwbGF5ID0gMTIwMCwNCisJLmhzeW5jX3N0
YXJ0ID0gMTIwMCArIDgwLA0KKwkuaHN5bmNfZW5kID0gMTIwMCArIDgwICsgMjQsDQorCS5odG90
YWwgPSAxMjAwICsgODAgKyAyNCArIDQwLA0KKwkudmRpc3BsYXkgPSAxOTIwLA0KKwkudnN5bmNf
c3RhcnQgPSAxOTIwICsgMjAsDQorCS52c3luY19lbmQgPSAxOTIwICsgMjAgKyA0LA0KKwkudnRv
dGFsID0gMTkyMCArIDIwICsgNCArIDEwLA0KKwkudnJlZnJlc2ggPSA2MCwNCisJLnR5cGUgPSBE
Uk1fTU9ERV9UWVBFX0RSSVZFUiB8IERSTV9NT0RFX1RZUEVfUFJFRkVSUkVELA0KK307DQorDQor
c3RhdGljIGNvbnN0IHN0cnVjdCBwYW5lbF9kZXNjIGJvZV90djEwMXd1bV9uNTNfZGVzYyA9IHsN
CisJLm1vZGVzID0gJmJvZV90djEwMXd1bV9uNTNfZGVmYXVsdF9tb2RlLA0KKwkuYnBjID0gOCwN
CisJLnNpemUgPSB7DQorCQkud2lkdGhfbW0gPSAxMzUsDQorCQkuaGVpZ2h0X21tID0gMjE2LA0K
Kwl9LA0KKwkubGFuZXMgPSA0LA0KKwkuZm9ybWF0ID0gTUlQSV9EU0lfRk1UX1JHQjg4OCwNCisJ
Lm1vZGVfZmxhZ3MgPSBNSVBJX0RTSV9NT0RFX1ZJREVPIHwgTUlQSV9EU0lfTU9ERV9WSURFT19T
WU5DX1BVTFNFIHwNCisJCSAgICAgIE1JUElfRFNJX01PREVfTFBNLA0KKwkuaW5pdF9jbWRzID0g
Ym9lX2luaXRfY21kLA0KK307DQorDQogc3RhdGljIGludCBib2VfcGFuZWxfZ2V0X21vZGVzKHN0
cnVjdCBkcm1fcGFuZWwgKnBhbmVsLA0KIAkJCSAgICAgICBzdHJ1Y3QgZHJtX2Nvbm5lY3RvciAq
Y29ubmVjdG9yKQ0KIHsNCkBAIC03MjUsNiArNzUzLDkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBv
Zl9kZXZpY2VfaWQgYm9lX29mX21hdGNoW10gPSB7DQogCXsgLmNvbXBhdGlibGUgPSAiYXVvLGtk
MTAxbjgwLTQ1bmEiLA0KIAkgIC5kYXRhID0gJmF1b19rZDEwMW44MF80NW5hX2Rlc2MNCiAJfSwN
CisJeyAuY29tcGF0aWJsZSA9ICJib2UsdHYxMDF3dW0tbjUzIiwNCisJICAuZGF0YSA9ICZib2Vf
dHYxMDF3dW1fbjUzX2Rlc2MNCisJfSwNCiAJeyAvKiBzZW50aW5lbCAqLyB9DQogfTsNCiBNT0RV
TEVfREVWSUNFX1RBQkxFKG9mLCBib2Vfb2ZfbWF0Y2gpOw0KLS0gDQoyLjIxLjANCg==

