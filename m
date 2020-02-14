Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5393EC3B194
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 04:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C44620848
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 04:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="iSkjkCrx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgBNEuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 23:50:04 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:9103 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727965AbgBNEuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 23:50:04 -0500
X-UUID: 55ec36f7826a43b88364de5223826f4e-20200214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=bodm7HuU1//uvOvOzppYILsbecoq1h7G7NokkwpmJMQ=;
        b=iSkjkCrxvIgJc8bToPkSxRVjaAAPQZHl83uUXW1lPa2841HvZZOPcKEpOVhiyWpzPuaLCqzi0+ZdMr862EzSUXfMzk13FKukMiA71fYvlo/YhakGOrBRrifZZ7Fp6nlKROYS3h4gUlw6TuUZG7mQyTKfi1vRKnGS1zw6VWjw838=;
X-UUID: 55ec36f7826a43b88364de5223826f4e-20200214
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1424935915; Fri, 14 Feb 2020 12:49:58 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 14 Feb 2020 12:49:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Feb 2020 12:49:56 +0800
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        YT Shen <yt.shen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        CK Hu <ck.hu@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>, <tfiga@chromium.org>,
        <drinkcat@chromium.org>, <linux-kernel@vger.kernel.org>,
        <srv_heupstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>
Subject: [PATCH 2/3] drm/mediatek: make sure previous message done or be aborted before send
Date:   Fri, 14 Feb 2020 12:49:53 +0800
Message-ID: <20200214044954.16923-2-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200214044954.16923-1-bibby.hsieh@mediatek.com>
References: <20200214044954.16923-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWVkaWF0ZWsgQ01EUSBkcml2ZXIgcmVtb3ZlZCBhdG9taWMgcGFyYW1ldGVyIGFuZCBpbXBsZW1l
bnRhdGlvbg0KcmVsYXRlZCB0byBhdG9taWMuIERSTSBkcml2ZXIgbmVlZCB0byBtYWtlIHN1cmUg
cHJldmlvdXMgbWVzc2FnZQ0KZG9uZSBvciBiZSBhYm9ydGVkIGJlZm9yZSB3ZSBzZW5kIG5leHQg
bWVzc2FnZS4NCg0KSWYgcHJldmlvdXMgbWVzc2FnZSBpcyBzdGlsbCB3YWl0aW5nIGZvciBldmVu
dCwgaXQgbWVhbnMgdGhlDQpzZXR0aW5nIGhhc24ndCBiZWVuIHVwZGF0ZWQgaW50byBkaXNwbGF5
IGhhcmR3YXJlIHJlZ2lzdGVyLA0Kd2UgY2FuIGFib3J0IHRoZSBtZXNzYWdlIGFuZCBzZW5kIG5l
eHQgbWVzc2FnZSB0byB1cGRhdGUgdGhlDQpuZXdlc3Qgc2V0dGluZyBpbnRvIGRpc3BsYXkgaGFy
ZHdhcmUuDQpJZiBwcmV2aW91cyBtZXNzYWdlIGFscmVhZHkgc3RhcnRlZCwgd2UgaGF2ZSB0byB3
YWl0IGl0IHVudGlsDQp0cmFuc21pc3Npb24gaGFzIGJlZW4gY29tcGxldGVkLg0KDQpTbyB3ZSBm
bHVzaCBtYm94IGNsaWVudCBiZWZvcmUgd2Ugc2VuZCBuZXcgbWVzc2FnZSB0byBjb250cm9sbGVy
DQpkcml2ZXIuDQoNClRoaXMgcGF0Y2ggZGVwZW5kcyBvbiBwdGFjaDoNClswLzNdIFJlbW92ZSBh
dG9taWNfZXhlYw0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9jb3Zlci8xMTM4MTY3Ny8N
Cg0KU2lnbmVkLW9mZi1ieTogQmliYnkgSHNpZWggPGJpYmJ5LmhzaWVoQG1lZGlhdGVrLmNvbT4N
Ci0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyB8IDEgKw0KIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcm1fY3J0Yy5jDQppbmRleCAzYzUzZWEyMjIwOGMuLmUzNWI2NmM1YmEwZiAxMDA2NDQNCi0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KKysrIGIvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQpAQCAtNDkxLDYgKzQ5MSw3IEBAIHN0
YXRpYyB2b2lkIG10a19kcm1fY3J0Y19od19jb25maWcoc3RydWN0IG10a19kcm1fY3J0YyAqbXRr
X2NydGMpDQogCX0NCiAjaWYgSVNfRU5BQkxFRChDT05GSUdfTVRLX0NNRFEpDQogCWlmIChtdGtf
Y3J0Yy0+Y21kcV9jbGllbnQpIHsNCisJCW1ib3hfZmx1c2gobXRrX2NydGMtPmNtZHFfY2xpZW50
LT5jaGFuLCAyMDAwKTsNCiAJCWNtZHFfaGFuZGxlID0gY21kcV9wa3RfY3JlYXRlKG10a19jcnRj
LT5jbWRxX2NsaWVudCwgUEFHRV9TSVpFKTsNCiAJCWNtZHFfcGt0X2NsZWFyX2V2ZW50KGNtZHFf
aGFuZGxlLCBtdGtfY3J0Yy0+Y21kcV9ldmVudCk7DQogCQljbWRxX3BrdF93ZmUoY21kcV9oYW5k
bGUsIG10a19jcnRjLT5jbWRxX2V2ZW50KTsNCi0tIA0KMi4xOC4wDQo=

