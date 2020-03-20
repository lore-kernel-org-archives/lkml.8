Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888A4C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 07:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F91D20777
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 07:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MCstwFlz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgCTHdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 03:33:13 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:15951 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726657AbgCTHcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 03:32:41 -0400
X-UUID: 61d4942309dc412fac145fbba63c54ca-20200320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=CNJCkVUjHNfglySeQk6l/dMidP8MpvHpn3ZQ8HhLFK0=;
        b=MCstwFlzOCqHk5WYt/7SS9hfM2/WBlN5nanyYiILLpIQJpucLrsutKKOkRYfgWSwR9S5OoYcpuVsvjJGDRWBr63Okl6rVaW6Eox8C7MIaRG5NRS0qiq3flT43rCgDNHCqEsGT1MgOi12PrTEhmeSlMIq9Nw/gKnXiMIhoJb7kOc=;
X-UUID: 61d4942309dc412fac145fbba63c54ca-20200320
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 443330880; Fri, 20 Mar 2020 15:32:27 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 20 Mar 2020 15:29:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 20 Mar 2020 15:29:19 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v13 09/11] soc: mediatek: Add a comma at the end
Date:   Fri, 20 Mar 2020 15:32:18 +0800
Message-ID: <1584689540-5227-10-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1584689540-5227-1-git-send-email-weiyi.lu@mediatek.com>
References: <1584689540-5227-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 6517BB6049B43F6435E03951A65B04C9067DFE9AE334AE332E674281AEF591BD2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QSBtaW5vciBjb2Rpbmcgc3R5bGUgZml4DQoNClNpZ25lZC1vZmYtYnk6IFdlaXlpIEx1IDx3ZWl5
aS5sdUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lz
LmMgfCAxNCArKysrKysrLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyks
IDcgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGst
c2Nwc3lzLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMNCmluZGV4IDk0ODIz
ZTIuLjg1Mzg0MDggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lz
LmMNCisrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1zY3BzeXMuYw0KQEAgLTEzNzQsNyAr
MTM3NCw3IEBAIHN0YXRpYyB2b2lkIG10a19yZWdpc3Rlcl9wb3dlcl9kb21haW5zKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYsDQogCS5udW1fZG9tYWlucyA9IEFSUkFZX1NJWkUoc2NwX2Rv
bWFpbl9kYXRhX210MjcwMSksDQogCS5yZWdzID0gew0KIAkJLnB3cl9zdGFfb2ZmcyA9IFNQTV9Q
V1JfU1RBVFVTLA0KLQkJLnB3cl9zdGEybmRfb2ZmcyA9IFNQTV9QV1JfU1RBVFVTXzJORA0KKwkJ
LnB3cl9zdGEybmRfb2ZmcyA9IFNQTV9QV1JfU1RBVFVTXzJORCwNCiAJfSwNCiB9Ow0KIA0KQEAg
LTEzODUsNyArMTM4NSw3IEBAIHN0YXRpYyB2b2lkIG10a19yZWdpc3Rlcl9wb3dlcl9kb21haW5z
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsDQogCS5udW1fc3ViZG9tYWlucyA9IEFSUkFZ
X1NJWkUoc2NwX3N1YmRvbWFpbl9tdDI3MTIpLA0KIAkucmVncyA9IHsNCiAJCS5wd3Jfc3RhX29m
ZnMgPSBTUE1fUFdSX1NUQVRVUywNCi0JCS5wd3Jfc3RhMm5kX29mZnMgPSBTUE1fUFdSX1NUQVRV
U18yTkQNCisJCS5wd3Jfc3RhMm5kX29mZnMgPSBTUE1fUFdSX1NUQVRVU18yTkQsDQogCX0sDQog
fTsNCiANCkBAIC0xMzk2LDcgKzEzOTYsNyBAQCBzdGF0aWMgdm9pZCBtdGtfcmVnaXN0ZXJfcG93
ZXJfZG9tYWlucyhzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KIAkubnVtX3N1YmRvbWFp
bnMgPSBBUlJBWV9TSVpFKHNjcF9zdWJkb21haW5fbXQ2Nzk3KSwNCiAJLnJlZ3MgPSB7DQogCQku
cHdyX3N0YV9vZmZzID0gU1BNX1BXUl9TVEFUVVNfTVQ2Nzk3LA0KLQkJLnB3cl9zdGEybmRfb2Zm
cyA9IFNQTV9QV1JfU1RBVFVTXzJORF9NVDY3OTcNCisJCS5wd3Jfc3RhMm5kX29mZnMgPSBTUE1f
UFdSX1NUQVRVU18yTkRfTVQ2Nzk3LA0KIAl9LA0KIH07DQogDQpAQCAtMTQwNSw3ICsxNDA1LDcg
QEAgc3RhdGljIHZvaWQgbXRrX3JlZ2lzdGVyX3Bvd2VyX2RvbWFpbnMoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldiwNCiAJLm51bV9kb21haW5zID0gQVJSQVlfU0laRShzY3BfZG9tYWluX2Rh
dGFfbXQ3NjIyKSwNCiAJLnJlZ3MgPSB7DQogCQkucHdyX3N0YV9vZmZzID0gU1BNX1BXUl9TVEFU
VVMsDQotCQkucHdyX3N0YTJuZF9vZmZzID0gU1BNX1BXUl9TVEFUVVNfMk5EDQorCQkucHdyX3N0
YTJuZF9vZmZzID0gU1BNX1BXUl9TVEFUVVNfMk5ELA0KIAl9LA0KIH07DQogDQpAQCAtMTQxNCw3
ICsxNDE0LDcgQEAgc3RhdGljIHZvaWQgbXRrX3JlZ2lzdGVyX3Bvd2VyX2RvbWFpbnMoc3RydWN0
IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCiAJLm51bV9kb21haW5zID0gQVJSQVlfU0laRShzY3Bf
ZG9tYWluX2RhdGFfbXQ3NjIzYSksDQogCS5yZWdzID0gew0KIAkJLnB3cl9zdGFfb2ZmcyA9IFNQ
TV9QV1JfU1RBVFVTLA0KLQkJLnB3cl9zdGEybmRfb2ZmcyA9IFNQTV9QV1JfU1RBVFVTXzJORA0K
KwkJLnB3cl9zdGEybmRfb2ZmcyA9IFNQTV9QV1JfU1RBVFVTXzJORCwNCiAJfSwNCiB9Ow0KIA0K
QEAgLTE0MjUsNyArMTQyNSw3IEBAIHN0YXRpYyB2b2lkIG10a19yZWdpc3Rlcl9wb3dlcl9kb21h
aW5zKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsDQogCS5udW1fc3ViZG9tYWlucyA9IEFS
UkFZX1NJWkUoc2NwX3N1YmRvbWFpbl9tdDgxNzMpLA0KIAkucmVncyA9IHsNCiAJCS5wd3Jfc3Rh
X29mZnMgPSBTUE1fUFdSX1NUQVRVUywNCi0JCS5wd3Jfc3RhMm5kX29mZnMgPSBTUE1fUFdSX1NU
QVRVU18yTkQNCisJCS5wd3Jfc3RhMm5kX29mZnMgPSBTUE1fUFdSX1NUQVRVU18yTkQsDQogCX0s
DQogfTsNCiANCkBAIC0xNDM2LDcgKzE0MzYsNyBAQCBzdGF0aWMgdm9pZCBtdGtfcmVnaXN0ZXJf
cG93ZXJfZG9tYWlucyhzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KIAkubnVtX3N1YmRv
bWFpbnMgPSBBUlJBWV9TSVpFKHNjcF9zdWJkb21haW5fbXQ4MTgzKSwNCiAJLnJlZ3MgPSB7DQog
CQkucHdyX3N0YV9vZmZzID0gMHgwMTgwLA0KLQkJLnB3cl9zdGEybmRfb2ZmcyA9IDB4MDE4NA0K
KwkJLnB3cl9zdGEybmRfb2ZmcyA9IDB4MDE4NCwNCiAJfQ0KIH07DQogDQotLSANCjEuOC4xLjEu
ZGlydHkNCg==

