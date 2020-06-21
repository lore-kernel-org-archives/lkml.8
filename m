Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D82C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 14:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51D9C2493A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 14:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CA5UQuj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbgFUOSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 10:18:42 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:24615 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730022AbgFUOSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 10:18:42 -0400
X-UUID: ff84bf6c0a3841e8b96080752feccf61-20200621
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=zjy0Ak+D9DAftvBlSEpPOHJuYg7xQmlYSXBwWHYwZjg=;
        b=CA5UQuj9UiEpddIfXW2/VVXtjYPd1pnsljjIEfB262YAIpzj0ETAzO0dc36NCTnOKbQQToIC2Xrc4A8NS9pPWZxY8saY7aAouYFJxHyvEdKpLKXSrjUaIvrmPMUBXhoYL1DrEuWrByjdbdj9iLX1EPQABvPUrDTRYKSnhS1n0Oo=;
X-UUID: ff84bf6c0a3841e8b96080752feccf61-20200621
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 460192093; Sun, 21 Jun 2020 22:18:40 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 21 Jun 2020 22:18:29 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 21 Jun 2020 22:18:30 +0800
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
Subject: [PATCH v1 01/11] soc: mediatek: cmdq: add address shift in jump
Date:   Sun, 21 Jun 2020 22:18:25 +0800
Message-ID: <1592749115-24158-2-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1592749115-24158-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1592749115-24158-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C6CBDA1DC8780D7EC90386ECCFF347699D5936E76A8A9EA4679A4E99F5EA44512000:8
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
bHBlci5jDQppbmRleCBjNjcwODE3NTk3MjguLjk4ZjIzYmEzYmE0NyAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQorKysgYi9kcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KQEAgLTI5MSw3ICsyOTEsOCBAQCBzdGF0aWMgaW50
IGNtZHFfcGt0X2ZpbmFsaXplKHN0cnVjdCBjbWRxX3BrdCAqcGt0KQ0KIA0KIAkvKiBKVU1QIHRv
IGVuZCAqLw0KIAlpbnN0Lm9wID0gQ01EUV9DT0RFX0pVTVA7DQotCWluc3QudmFsdWUgPSBDTURR
X0pVTVBfUEFTUzsNCisJaW5zdC52YWx1ZSA9IENNRFFfSlVNUF9QQVNTID4+DQorCQljbWRxX21i
b3hfc2hpZnQoKChzdHJ1Y3QgY21kcV9jbGllbnQgKilwa3QtPmNsKS0+Y2hhbik7DQogCWVyciA9
IGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQogDQogCXJldHVybiBlcnI7DQot
LSANCjEuNy45LjUNCg==

