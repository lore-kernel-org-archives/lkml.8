Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A574C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 06:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F7AA20870
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 06:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Y+uiPU2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgGEGsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 02:48:55 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:23427 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726597AbgGEGsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 02:48:45 -0400
X-UUID: 1a8fe2b2d7a848b9b9cce1fe86b71ecc-20200705
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=LGi4+xEP6DG20iCsDrqvUw5PUEePljQk1caVimQ5Kps=;
        b=Y+uiPU2h2i9j2gnrQgZKQk+MVTdCuAJ0yY1LKAQhLUrLsvH17rbAReh1rqOsYhMPbmSrwp2evoYsA96Ut6C6sL0jV1EUbX87fkfQQUpw9JNBa+lYv1DrAJtm2oC0UgC/DQqhSeDDhynu7/z/0rzgO2rwu+EVG4hyl+PnLdyijCU=;
X-UUID: 1a8fe2b2d7a848b9b9cce1fe86b71ecc-20200705
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 436682722; Sun, 05 Jul 2020 14:48:38 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 5 Jul 2020 14:48:35 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 5 Jul 2020 14:48:36 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v2 1/8] soc: mediatek: cmdq: add address shift in jump
Date:   Sun, 5 Jul 2020 14:48:28 +0800
Message-ID: <1593931715-32761-2-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1593931715-32761-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1593931715-32761-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGFkZHJlc3Mgc2hpZnQgd2hlbiBjb21wb3NlIGp1bXAgaW5zdHJ1Y3Rpb24NCnRvIGNvbXBh
dGlibGUgd2l0aCAzNWJpdCBmb3JtYXQuDQoNClNpZ25lZC1vZmYtYnk6IERlbm5pcyBZQyBIc2ll
aCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvc29jL21lZGlh
dGVrL210ay1jbWRxLWhlbHBlci5jIHwgICAgMyArKy0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRp
YXRlay9tdGstY21kcS1oZWxwZXIuYyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhl
bHBlci5jDQppbmRleCBkYzY0NGNmYjY0MTkuLjlmYWY3OGZiZWQzYSAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQorKysgYi9kcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KQEAgLTMyOSw3ICszMjksOCBAQCBpbnQgY21kcV9w
a3RfZmluYWxpemUoc3RydWN0IGNtZHFfcGt0ICpwa3QpDQogDQogCS8qIEpVTVAgdG8gZW5kICov
DQogCWluc3Qub3AgPSBDTURRX0NPREVfSlVNUDsNCi0JaW5zdC52YWx1ZSA9IENNRFFfSlVNUF9Q
QVNTOw0KKwlpbnN0LnZhbHVlID0gQ01EUV9KVU1QX1BBU1MgPj4NCisJCWNtZHFfZ2V0X3NoaWZ0
X3BhKCgoc3RydWN0IGNtZHFfY2xpZW50ICopcGt0LT5jbCktPmNoYW4pOw0KIAllcnIgPSBjbWRx
X3BrdF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KIA0KIAlyZXR1cm4gZXJyOw0KLS0gDQox
LjcuOS41DQo=

