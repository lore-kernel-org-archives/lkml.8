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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBBBC35DF9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 06:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED1721744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 06:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="byN4NZ1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbgBYGrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 01:47:13 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:61847 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725851AbgBYGrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 01:47:13 -0500
X-UUID: 98445fa2a36a499197f828316fb5f5ca-20200225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=2mRvrq0KsqWRkawRW7l0SARbfmn7cZF3ZQwEkeOJVU8=;
        b=byN4NZ1bpLDmR2YaHalWcZpIV1Nf9OsdBnl57YIvRDvR+cedwqRbVIPHoRo57kDCN7enNn6URW6yKj+UbozExR4jrxWnFWmmPt83+v0tUm7UI09c4Zhca1T0+ZVzwb7FOUCWBreeWeoKWLA/itMk9S4N/dOAgVfffv+MW8sKZfU=;
X-UUID: 98445fa2a36a499197f828316fb5f5ca-20200225
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1966124477; Tue, 25 Feb 2020 14:46:49 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 25 Feb
 2020 14:47:23 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Tue, 25 Feb 2020 14:45:29 +0800
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
Subject: [PATCH v7 3/4] drm/mediatek: add mt8183 dpi clock factor
Date:   Tue, 25 Feb 2020 14:46:37 +0800
Message-ID: <20200225064638.112282-4-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200225064638.112282-1-jitao.shi@mediatek.com>
References: <20200225064638.112282-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: AB392C234C931E3602719C4560FAD2E9A09EB13288F548CCAECD362BB4CC18A12000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGZhY3RvciBkZXBlbmRzIG9uIHRoZSBkaXZpZGVyIG9mIERQSSBpbiBNVDgxODMsIHRoZXJl
Zm9yZSwNCndlIHNob3VsZCBmaXggdGhpcyBmYWN0b3IgdG8gdGhlIHJpZ2h0IGFuZCBuZXcgb25l
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBKaXRhbyBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5jb20+DQpS
ZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHBpLmMgfCAxOCArKysrKysrKysrKysrKysrKysNCiAxIGZpbGUg
Y2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcGkuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMN
CmluZGV4IDA4Mjk5MDQyZGRhNy4uYzNlNjMxYjkzYzJlIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcGkuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcGkuYw0KQEAgLTY3Niw2ICs2NzYsMTYgQEAgc3RhdGljIHVuc2lnbmVkIGludCBtdDI3
MDFfY2FsY3VsYXRlX2ZhY3RvcihpbnQgY2xvY2spDQogCQlyZXR1cm4gMTsNCiB9DQogDQorc3Rh
dGljIHVuc2lnbmVkIGludCBtdDgxODNfY2FsY3VsYXRlX2ZhY3RvcihpbnQgY2xvY2spDQorew0K
KwlpZiAoY2xvY2sgPD0gMjcwMDApDQorCQlyZXR1cm4gODsNCisJZWxzZSBpZiAoY2xvY2sgPD0g
MTY3MDAwKQ0KKwkJcmV0dXJuIDQ7DQorCWVsc2UNCisJCXJldHVybiAyOw0KK30NCisNCiBzdGF0
aWMgY29uc3Qgc3RydWN0IG10a19kcGlfY29uZiBtdDgxNzNfY29uZiA9IHsNCiAJLmNhbF9mYWN0
b3IgPSBtdDgxNzNfY2FsY3VsYXRlX2ZhY3RvciwNCiAJLnJlZ19oX2ZyZV9jb24gPSAweGUwLA0K
QEAgLTY4Nyw2ICs2OTcsMTEgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZHBpX2NvbmYgbXQy
NzAxX2NvbmYgPSB7DQogCS5lZGdlX3NlbF9lbiA9IHRydWUsDQogfTsNCiANCitzdGF0aWMgY29u
c3Qgc3RydWN0IG10a19kcGlfY29uZiBtdDgxODNfY29uZiA9IHsNCisJLmNhbF9mYWN0b3IgPSBt
dDgxODNfY2FsY3VsYXRlX2ZhY3RvciwNCisJLnJlZ19oX2ZyZV9jb24gPSAweGUwLA0KK307DQor
DQogc3RhdGljIGludCBtdGtfZHBpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQogew0KIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KQEAgLTc4NCw2ICs3OTks
OSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdGtfZHBpX29mX2lkc1tdID0g
ew0KIAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE3My1kcGkiLA0KIAkgIC5kYXRhID0g
Jm10ODE3M19jb25mLA0KIAl9LA0KKwl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1k
cGkiLA0KKwkgIC5kYXRhID0gJm10ODE4M19jb25mLA0KKwl9LA0KIAl7IH0sDQogfTsNCiANCi0t
IA0KMi4yMS4wDQo=

