Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC69C761A0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3314020725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Phfg6AmS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgBQJK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:10:29 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:58170 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728621AbgBQJK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:10:28 -0500
X-UUID: c037636fe97e4745adea956905f93b8b-20200217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=JXFRbt5srPcgSAZPL0nkpDZgwyrLakt2ZXMr+buWHPs=;
        b=Phfg6AmSdtZ9CTdO4TiHfUbIon4Vt0Exz3Gg00topn386KlB/O+rgQ+qZzhWPXoy1Y9dQKVzmoL7zWau+JdI4X6gvSiHzpGuZWtqOU81qt+TQgDeVIOa2HnDdjl7LtckUzc8pfObTXkXuSJWSawonkQJWW9m6xVKJjkIxemFyyI=;
X-UUID: c037636fe97e4745adea956905f93b8b-20200217
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1104764740; Mon, 17 Feb 2020 17:10:22 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 17 Feb 2020 17:09:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Feb 2020 17:09:57 +0800
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
Subject: [PATCH v1 3/3] drm/mediatek: move gce event property to mutex device node
Date:   Mon, 17 Feb 2020 17:10:20 +0800
Message-ID: <20200217091020.16144-3-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200217091020.16144-1-bibby.hsieh@mediatek.com>
References: <20200217091020.16144-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWNjb3JkaW5nIG10ayBoYXJkd2FyZSBkZXNpZ24sIHN0cmVhbV9kb25lMCBhbmQgc3RyZWFtX2Rv
bmUxIGFyZQ0KZ2VuZXJhdGVkIGJ5IG11dGV4LCBzbyB3ZSBtb3ZlIGdjZSBldmVudCBwcm9wZXJ0
eSB0byBtdXRleCBkZXZpY2UgbW9kZS4NCg0KU2lnbmVkLW9mZi1ieTogQmliYnkgSHNpZWggPGJp
YmJ5LmhzaWVoQG1lZGlhdGVrLmNvbT4NClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0
ZWsuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jIHwg
MiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jIGIvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQppbmRleCBlMzViNjZjNWJhMGYu
LmUxY2M3NzAzYTMxMiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2NydGMuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5j
DQpAQCAtODIwLDcgKzgyMCw3IEBAIGludCBtdGtfZHJtX2NydGNfY3JlYXRlKHN0cnVjdCBkcm1f
ZGV2aWNlICpkcm1fZGV2LA0KIAkJCWRybV9jcnRjX2luZGV4KCZtdGtfY3J0Yy0+YmFzZSkpOw0K
IAkJbXRrX2NydGMtPmNtZHFfY2xpZW50ID0gTlVMTDsNCiAJfQ0KLQlyZXQgPSBvZl9wcm9wZXJ0
eV9yZWFkX3UzMl9pbmRleChkZXYtPm9mX25vZGUsICJtZWRpYXRlayxnY2UtZXZlbnRzIiwNCisJ
cmV0ID0gb2ZfcHJvcGVydHlfcmVhZF91MzJfaW5kZXgocHJpdi0+bXV0ZXhfbm9kZSwgIm1lZGlh
dGVrLGdjZS1ldmVudHMiLA0KIAkJCQkJIGRybV9jcnRjX2luZGV4KCZtdGtfY3J0Yy0+YmFzZSks
DQogCQkJCQkgJm10a19jcnRjLT5jbWRxX2V2ZW50KTsNCiAJaWYgKHJldCkNCi0tIA0KMi4xOC4w
DQo=

