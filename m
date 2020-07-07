Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD08C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C08120578
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oC3Gybwj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgGGPqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:46:43 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44639 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729190AbgGGPqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:46:38 -0400
X-UUID: da1aef1162474931a4f0ccb007f63e72-20200707
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Ljkd4nR9NTQX2XK+y25x1zIqkShjpvQwq5oLuDB4DaY=;
        b=oC3Gybwjf/ESf4XNIbwFeRqFkwJYtFvd3iLoTWUipwOB9PnaOHyjjixcXvT1qs79cEEK3bqrpeOcnmZXX0uxbuQLxuptyTDyk8UitWxuftYDMtrOI/BxIXM627hVH9wLJN2CKxUy6fGCx1j3lwCmACMOo02HoJb5KFefhROqng0=;
X-UUID: da1aef1162474931a4f0ccb007f63e72-20200707
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1692277669; Tue, 07 Jul 2020 23:46:34 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 7 Jul 2020 23:46:23 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 7 Jul 2020 23:46:23 +0800
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
Subject: [PATCH v3 1/9] soc: mediatek: cmdq: add address shift in jump
Date:   Tue, 7 Jul 2020 23:45:06 +0800
Message-ID: <1594136714-11650-2-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1594136714-11650-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1594136714-11650-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 26F17CA5DABFC65FE053F2813D81D79DA4F7CF6DC06A0DA33992851FAF5098C22000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGFkZHJlc3Mgc2hpZnQgd2hlbiBjb21wb3NlIGp1bXAgaW5zdHJ1Y3Rpb24NCnRvIGNvbXBh
dGlibGUgd2l0aCAzNWJpdCBmb3JtYXQuDQoNCkNoYW5nZSBzaW5jZSB2MToNCi0gUmVuYW1lIGNt
ZHFfbWJveF9zaGlmdCgpIHRvIGNtZHFfZ2V0X3NoaWZ0X3BhKCkuDQoNClNpZ25lZC1vZmYtYnk6
IERlbm5pcyBZQyBIc2llaCA8ZGVubmlzLXljLmhzaWVoQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRy
aXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIHwgICAgMyArKy0NCiAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyBiL2RyaXZlcnMvc29jL21lZGlh
dGVrL210ay1jbWRxLWhlbHBlci5jDQppbmRleCBkYzY0NGNmYjY0MTkuLjlmYWY3OGZiZWQzYSAx
MDA2NDQNCi0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQorKysg
Yi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KQEAgLTMyOSw3ICszMjks
OCBAQCBpbnQgY21kcV9wa3RfZmluYWxpemUoc3RydWN0IGNtZHFfcGt0ICpwa3QpDQogDQogCS8q
IEpVTVAgdG8gZW5kICovDQogCWluc3Qub3AgPSBDTURRX0NPREVfSlVNUDsNCi0JaW5zdC52YWx1
ZSA9IENNRFFfSlVNUF9QQVNTOw0KKwlpbnN0LnZhbHVlID0gQ01EUV9KVU1QX1BBU1MgPj4NCisJ
CWNtZHFfZ2V0X3NoaWZ0X3BhKCgoc3RydWN0IGNtZHFfY2xpZW50ICopcGt0LT5jbCktPmNoYW4p
Ow0KIAllcnIgPSBjbWRxX3BrdF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KIA0KIAlyZXR1
cm4gZXJyOw0KLS0gDQoxLjcuOS41DQo=

