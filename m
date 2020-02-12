Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10F8C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF73420714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="o4z8ZeqJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgBLJzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:55:11 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:62115 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728712AbgBLJzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:55:10 -0500
X-UUID: 569e267dd7884339957488b3b7250a38-20200212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Vr1pHkQVOl3JW4Dfr5vCs2HYOfLXE6nj+3u5wfIpXq4=;
        b=o4z8ZeqJWm49Rh9nJxQ30LLooRuKQ5JAS1tzIbEjKZ5cY3AOtA0CXNYqijJEXuBLLtzNm0TV7B10vpqGK0HYuzHi4f9/9LBXwZFZYidwKCRc8S8a5jrAnEdGWZg8nXRuUNEFnBMKHiU8y+vJic8iqaXxHkXkwvpU2qe1Iq8y/9E=;
X-UUID: 569e267dd7884339957488b3b7250a38-20200212
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1879772572; Wed, 12 Feb 2020 17:55:04 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 12 Feb 2020 17:54:20 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 12 Feb 2020 17:55:10 +0800
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
Subject: [PATCH 2/2] drm/mediatek: move gce event property to mutex device node
Date:   Wed, 12 Feb 2020 17:55:01 +0800
Message-ID: <20200212095501.12124-2-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200212095501.12124-1-bibby.hsieh@mediatek.com>
References: <20200212095501.12124-1-bibby.hsieh@mediatek.com>
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
YmJ5LmhzaWVoQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHJtX2NydGMuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2NydGMuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KaW5k
ZXggM2M1M2VhMjIyMDhjLi44YTMxZTViOTgzZGIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHJtX2NydGMuYw0KQEAgLTgxOSw3ICs4MTksNyBAQCBpbnQgbXRrX2RybV9jcnRjX2Ny
ZWF0ZShzdHJ1Y3QgZHJtX2RldmljZSAqZHJtX2RldiwNCiAJCQlkcm1fY3J0Y19pbmRleCgmbXRr
X2NydGMtPmJhc2UpKTsNCiAJCW10a19jcnRjLT5jbWRxX2NsaWVudCA9IE5VTEw7DQogCX0NCi0J
cmV0ID0gb2ZfcHJvcGVydHlfcmVhZF91MzJfaW5kZXgoZGV2LT5vZl9ub2RlLCAibWVkaWF0ZWss
Z2NlLWV2ZW50cyIsDQorCXJldCA9IG9mX3Byb3BlcnR5X3JlYWRfdTMyX2luZGV4KHByaXYtPm11
dGV4X25vZGUsICJtZWRpYXRlayxnY2UtZXZlbnRzIiwNCiAJCQkJCSBkcm1fY3J0Y19pbmRleCgm
bXRrX2NydGMtPmJhc2UpLA0KIAkJCQkJICZtdGtfY3J0Yy0+Y21kcV9ldmVudCk7DQogCWlmIChy
ZXQpDQotLSANCjIuMTguMA0K

