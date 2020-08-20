Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA589C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C747C2078D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="AuzSmdpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgHTGF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 02:05:58 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44885 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726803AbgHTGFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 02:05:47 -0400
X-UUID: 2acc7ab44dd24e588a630215aae5687d-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Vg+Y1wHyK8bnAhkX5OXUgFt1K9GhR5ON+bofhLcBoQk=;
        b=AuzSmdpID7MbZFLcWPozsCnMWwV2IlftScgg7qVrd9i4yFAFJJn3pzXOOqjKXQt8OhuSAB0yt+jhuoKkbhBplSCxARvgEcb5JQeiibP54b8WbrbQS3houfSzq9u8TyndL/uin1EUyer4/9J/uNYvO57ebYztFD62RLB0BToO9ow=;
X-UUID: 2acc7ab44dd24e588a630215aae5687d-20200820
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1106908150; Thu, 20 Aug 2020 14:05:45 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 14:05:42 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 14:05:41 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v1 11/21] drm/mediatek: fix gamma size config
Date:   Thu, 20 Aug 2020 14:04:08 +0800
Message-ID: <1597903458-8055-12-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597903458-8055-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1597903458-8055-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zml4IGdhbW1hIHNpemUgY29uZmlnDQoNClNpZ25lZC1vZmYtYnk6IFlvbmdxaWFuZyBOaXUgPHlv
bmdxaWFuZy5uaXVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcm1fZGRwX2NvbXAuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHJtX2RkcF9jb21wLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9k
ZHBfY29tcC5jDQppbmRleCBiZWNkNzJkLi4xZDhkYzZhIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KQEAgLTI5NSw3ICsyOTUsNyBAQCBzdGF0aWMg
dm9pZCBtdGtfZ2FtbWFfY29uZmlnKHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXAsIHVuc2lnbmVk
IGludCB3LA0KIAkJCSAgICAgdW5zaWduZWQgaW50IGgsIHVuc2lnbmVkIGludCB2cmVmcmVzaCwN
CiAJCQkgICAgIHVuc2lnbmVkIGludCBicGMsIHN0cnVjdCBjbWRxX3BrdCAqY21kcV9wa3QpDQog
ew0KLQltdGtfZGRwX3dyaXRlKGNtZHFfcGt0LCBoIDw8IDE2IHwgdywgY29tcCwgRElTUF9HQU1N
QV9TSVpFKTsNCisJbXRrX2RkcF93cml0ZShjbWRxX3BrdCwgdyA8PCAxNiB8IGgsIGNvbXAsIERJ
U1BfR0FNTUFfU0laRSk7DQogCW10a19kaXRoZXJfc2V0KGNvbXAsIGJwYywgRElTUF9HQU1NQV9D
RkcsIGNtZHFfcGt0KTsNCiB9DQogDQotLSANCjEuOC4xLjEuZGlydHkNCg==

