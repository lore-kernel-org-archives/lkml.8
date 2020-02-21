Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E69C35653
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E10208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bbZUsx1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgBUL2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 06:28:52 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:24825 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726325AbgBUL2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:28:45 -0500
X-UUID: 3a975e572a3341228fc0b111ea5d6de8-20200221
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=XodA7BzhxWVO79U3wJoih2V4Ux+s2E3aSrebwRF6fd8=;
        b=bbZUsx1zax2XTy75X6YDwAdC9CH1xvDcfsexF3sSojdEG3vUUReVpyR+9GR2uFtyHNeN3IxNrw4Pf+t+D7O1iyIMFMiDPrpKzUHq6JSB96FdsuCCj4hSpe/pxQvfIr0nKui6YL9XbD4ZwphcQddFx1k9cxPdwd4JMRSRgF0l+F0=;
X-UUID: 3a975e572a3341228fc0b111ea5d6de8-20200221
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 536201141; Fri, 21 Feb 2020 19:28:36 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 21 Feb
 2020 19:27:16 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Fri, 21 Feb 2020 19:27:36 +0800
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
Subject: [PATCH v6 3/4] drm/mediatek: add mt8183 dpi clock factor
Date:   Fri, 21 Feb 2020 19:28:27 +0800
Message-ID: <20200221112828.55837-4-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200221112828.55837-1-jitao.shi@mediatek.com>
References: <20200221112828.55837-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 91EB9B1974E47041F4D3BDC634E08A126827C642FACA741D6C624581B1C5EA8A2000:8
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
CmluZGV4IDM2ZTRkYmQyN2QxYi4uZTFhMzMyNTRkZmJlIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcGkuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcGkuYw0KQEAgLTY3NSw2ICs2NzUsMTYgQEAgc3RhdGljIHVuc2lnbmVkIGludCBtdDI3
MDFfY2FsY3VsYXRlX2ZhY3RvcihpbnQgY2xvY2spDQogCQlyZXR1cm4gMTsNCiB9DQogDQorc3Rh
dGljIHVuc2lnbmVkIGludCBtdDgxODNfY2FsY3VsYXRlX2ZhY3RvcihpbnQgY2xvY2spDQorew0K
KwlpZiAoY2xvY2sgPD0gMjcwMDApDQorCQlyZXR1cm4gODsNCisJZWxzZSBpZiAoY2xvY2sgPD0g
MTY3MDAwKQ0KKwkJcmV0dXJuIDQ7DQorCWVsc2UNCisJCXJldHVybiAyOw0KK30NCisNCiBzdGF0
aWMgY29uc3Qgc3RydWN0IG10a19kcGlfY29uZiBtdDgxNzNfY29uZiA9IHsNCiAJLmNhbF9mYWN0
b3IgPSBtdDgxNzNfY2FsY3VsYXRlX2ZhY3RvciwNCiAJLnJlZ19oX2ZyZV9jb24gPSAweGUwLA0K
QEAgLTY4Niw2ICs2OTYsMTEgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZHBpX2NvbmYgbXQy
NzAxX2NvbmYgPSB7DQogCS5lZGdlX3NlbF9lbiA9IHRydWUsDQogfTsNCiANCitzdGF0aWMgY29u
c3Qgc3RydWN0IG10a19kcGlfY29uZiBtdDgxODNfY29uZiA9IHsNCisJLmNhbF9mYWN0b3IgPSBt
dDgxODNfY2FsY3VsYXRlX2ZhY3RvciwNCisJLnJlZ19oX2ZyZV9jb24gPSAweGUwLA0KK307DQor
DQogc3RhdGljIGludCBtdGtfZHBpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQogew0KIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KQEAgLTc4Miw2ICs3OTcs
OSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdGtfZHBpX29mX2lkc1tdID0g
ew0KIAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE3My1kcGkiLA0KIAkgIC5kYXRhID0g
Jm10ODE3M19jb25mLA0KIAl9LA0KKwl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1k
cGkiLA0KKwkgIC5kYXRhID0gJm10ODE4M19jb25mLA0KKwl9LA0KIAl7IH0sDQogfTsNCiANCi0t
IA0KMi4yMS4wDQo=

