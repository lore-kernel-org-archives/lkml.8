Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1D4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 820DD2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 13:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ja8TmubB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbgHQNHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 09:07:43 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:9462 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728537AbgHQNHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 09:07:07 -0400
X-UUID: cc3a7c998d4e41beb86266ca4ca0c93f-20200817
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Kc2wbQ5/5ctPeZ+MBcGEqqORVXhdRTfyC3iZHOQDq5c=;
        b=ja8TmubBv78/qB7FOeuvo3C9/tBdX+EV2uq7cuJQ58QN9JBAue9/G6c44JFV5RF0z6Ido+6i4SoKC0/GiDsGql08SsZ39U+1kAL58NXVp+9yt8NXU5RT+/bfXvHePAEhlR8NQ5Rq6UWPYlSMRiuNE2FD601f//1hTUIjCXEEkLU=;
X-UUID: cc3a7c998d4e41beb86266ca4ca0c93f-20200817
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1227788580; Mon, 17 Aug 2020 21:06:38 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 17 Aug
 2020 21:06:36 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 17 Aug 2020 21:06:35 +0800
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
Subject: [PATCH v2] drm/mediatek: dsi: fix scrolling of panel with small hfp or hbp
Date:   Mon, 17 Aug 2020 21:06:40 +0800
Message-ID: <20200817130640.18021-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.12.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 4BE646BE1621BC9DA9C810CAA548159897D201F4DC13F4A0D86FCF88B04C65B62000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0ZSBzaG91bGQgYmUgaGJwICogYnBwIC0gaGJwIGV4dHJh
IGJ5dGVzLg0KU28gcmVtb3ZlIHRoZSB3cm9uZyBzdWJ0cmFjdGlvbiAxMC4NCg0KU2lnbmVkLW9m
Zi1ieTogSml0YW8gU2hpIDxqaXRhby5zaGlAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kc2kuYyB8IDkgKysrKy0tLS0tDQogMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RzaS5jDQppbmRleCAyNzBiZjIyYzk4ZmUuLjVkMDMxZTYzNDU3MSAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHNpLmMNCkBAIC00NzMsMTQgKzQ3MywxMyBAQCBzdGF0aWMgdm9pZCBtdGtf
ZHNpX2NvbmZpZ192ZG9fdGltaW5nKHN0cnVjdCBtdGtfZHNpICpkc2kpDQogCWhvcml6b250YWxf
c3luY19hY3RpdmVfYnl0ZSA9ICh2bS0+aHN5bmNfbGVuICogZHNpX3RtcF9idWZfYnBwIC0gMTAp
Ow0KIA0KIAlpZiAoZHNpLT5tb2RlX2ZsYWdzICYgTUlQSV9EU0lfTU9ERV9WSURFT19TWU5DX1BV
TFNFKQ0KLQkJaG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0ZSA9DQotCQkJKHZtLT5oYmFja19wb3Jj
aCAqIGRzaV90bXBfYnVmX2JwcCAtIDEwKTsNCisJCWhvcml6b250YWxfYmFja3BvcmNoX2J5dGUg
PSB2bS0+aGJhY2tfcG9yY2ggKiBkc2lfdG1wX2J1Zl9icHA7DQogCWVsc2UNCi0JCWhvcml6b250
YWxfYmFja3BvcmNoX2J5dGUgPSAoKHZtLT5oYmFja19wb3JjaCArIHZtLT5oc3luY19sZW4pICoN
Ci0JCQlkc2lfdG1wX2J1Zl9icHAgLSAxMCk7DQorCQlob3Jpem9udGFsX2JhY2twb3JjaF9ieXRl
ID0gKHZtLT5oYmFja19wb3JjaCArIHZtLT5oc3luY19sZW4pICoNCisJCQkJCSAgICBkc2lfdG1w
X2J1Zl9icHA7DQogDQogCWRhdGFfcGh5X2N5Y2xlcyA9IHRpbWluZy0+bHB4ICsgdGltaW5nLT5k
YV9oc19wcmVwYXJlICsNCi0JCQkgIHRpbWluZy0+ZGFfaHNfemVybyArIHRpbWluZy0+ZGFfaHNf
ZXhpdCArIDM7DQorCQkJICB0aW1pbmctPmRhX2hzX3plcm8gKyB0aW1pbmctPmRhX2hzX2V4aXQ7
DQogDQogCWlmIChkc2ktPm1vZGVfZmxhZ3MgJiBNSVBJX0RTSV9NT0RFX1ZJREVPX0JVUlNUKSB7
DQogCQlpZiAoKHZtLT5oZnJvbnRfcG9yY2ggKyB2bS0+aGJhY2tfcG9yY2gpICogZHNpX3RtcF9i
dWZfYnBwID4NCi0tIA0KMi4xMi41DQo=

