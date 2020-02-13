Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C74C3B186
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 01:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAB821739
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 01:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="j+K2q+JA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbgBMBYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 20:24:02 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:61392 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729366AbgBMBYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 20:24:01 -0500
X-UUID: b624fb22974445158a1e7b5bb8c04a20-20200213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xxmEaRGjkWrQG8Gtb9KKre7wf2OJRxreHnt3z0nXk8c=;
        b=j+K2q+JAIaLEU05PnlmC9Hw+miN6fHIxsFrloHZWoEccD18zVwX+JxPOk2KvZ4kylF8xc4U+ysps2brUMhx7T+UY+bLwboDaHirVPfQUZUleqUfWgHfIDWRrfF8MCx9uJ5RQeR7ev4+FsdK0hb5R3EB8MlmG4YNb4llUd4VrcPI=;
X-UUID: b624fb22974445158a1e7b5bb8c04a20-20200213
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1591756928; Thu, 13 Feb 2020 09:23:56 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 13 Feb 2020 09:23:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 13 Feb 2020 09:23:59 +0800
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
Subject: [PATCH 2/2] drm/mediatek: add fb swap in async_update
Date:   Thu, 13 Feb 2020 09:23:53 +0800
Message-ID: <20200213012353.26815-2-bibby.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200213012353.26815-1-bibby.hsieh@mediatek.com>
References: <20200213012353.26815-1-bibby.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QmVzaWRlcyB4LCB5IHBvc2l0aW9uLCB3aWR0aCBhbmQgaGVpZ2h0LA0KZmIgYWxzbyBuZWVkIHVw
ZGF0aW5nIGluIGFzeW5jIHVwZGF0ZS4NCg0KRml4ZXM6IDkyMGZmZmNjODkxMiAoImRybS9tZWRp
YXRlazogdXBkYXRlIGN1cnNvcnMgYnkgdXNpbmcgYXN5bmMgYXRvbWljIHVwZGF0ZSIpDQoNClNp
Z25lZC1vZmYtYnk6IEJpYmJ5IEhzaWVoIDxiaWJieS5oc2llaEBtZWRpYXRlay5jb20+DQotLS0N
CiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jIHwgMSArDQogMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fcGxhbmUuYw0KaW5kZXggZDMyYjQ5NGZmMWRlLi5lMDg0YzM2ZmRkOGEgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jDQorKysgYi9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jDQpAQCAtMTIyLDYgKzEyMiw3IEBAIHN0
YXRpYyB2b2lkIG10a19wbGFuZV9hdG9taWNfYXN5bmNfdXBkYXRlKHN0cnVjdCBkcm1fcGxhbmUg
KnBsYW5lLA0KIAlwbGFuZS0+c3RhdGUtPnNyY195ID0gbmV3X3N0YXRlLT5zcmNfeTsNCiAJcGxh
bmUtPnN0YXRlLT5zcmNfaCA9IG5ld19zdGF0ZS0+c3JjX2g7DQogCXBsYW5lLT5zdGF0ZS0+c3Jj
X3cgPSBuZXdfc3RhdGUtPnNyY193Ow0KKwlzd2FwKHBsYW5lLT5zdGF0ZS0+ZmIsIG5ld19zdGF0
ZS0+ZmIpOw0KIAlzdGF0ZS0+cGVuZGluZy5hc3luY19kaXJ0eSA9IHRydWU7DQogDQogCW10a19k
cm1fY3J0Y19hc3luY191cGRhdGUobmV3X3N0YXRlLT5jcnRjLCBwbGFuZSwgbmV3X3N0YXRlKTsN
Ci0tIA0KMi4xOC4wDQo=

