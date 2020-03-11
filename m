Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553E0C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E294208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="i03nvMZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgCKHSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:18:52 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:50061 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728242AbgCKHSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:18:51 -0400
X-UUID: 874330735942467187f654d67ac1129c-20200311
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=NpG0UFgtvpYUvmohxAuJVlEvOR/uiLu0l/aZC1sFpwI=;
        b=i03nvMZQ7/HEw3BewGKfO5xXhIzvIv1jq/xtuvyTm6cTppyVAhHoTWjeG/6F7Mds8EuQl8Dszt/7GzdI88D9sDbWIyDkTWWxHamdsMcvHjSHACzoKeK5r79ml1XyebLmrDC42q1+izqwC0r/I20Nt6Z16M+9IpTkInQt8DrwWxc=;
X-UUID: 874330735942467187f654d67ac1129c-20200311
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 34341887; Wed, 11 Mar 2020 15:18:46 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 11 Mar
 2020 15:19:05 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Wed, 11 Mar 2020 15:18:08 +0800
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
        Jitao Shi <jitao.shi@mediatek.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v13 3/6] dt-bindings: display: mediatek: dpi sample data in dual edge support
Date:   Wed, 11 Mar 2020 15:18:20 +0800
Message-ID: <20200311071823.117899-4-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200311071823.117899-1-jitao.shi@mediatek.com>
References: <20200311071823.117899-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 525F2CC7A5C23B33077FE43390A8173C718BD776C6DED6F5262B5AA447564F412000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHByb3BlcnR5ICJwY2xrLXNhbXBsZSIgdG8gY29uZmlnIHRoZSBkcGkgc2FtcGxlIG9uIGZh
bGxpbmcgKDApLA0KcmlzaW5nICgxKSwgYm90aCBmYWxsaW5nIGFuZCByaXNpbmcgKDIpLg0KDQpB
Y2tlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NClNpZ25lZC1vZmYtYnk6IEpp
dGFvIFNoaSA8aml0YW8uc2hpQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIC4uLi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnR4dCAgICAgICB8IDIgKysNCiAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGkudHh0
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVk
aWF0ZWssZHBpLnR4dA0KaW5kZXggMjYwYWU3NWFjNjQwLi4yZGZiNTBhNzMyMWUgMTAwNjQ0DQot
LS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9t
ZWRpYXRlayxkcGkudHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
ZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGkudHh0DQpAQCAtMjAsNiArMjAsNyBAQCBSZXF1
aXJlZCBwcm9wZXJ0aWVzOg0KIE9wdGlvbmFsIHByb3BlcnRpZXM6DQogLSBwaW5jdHJsLW5hbWVz
OiBDb250YWluICJkZWZhdWx0IiBhbmQgInNsZWVwIi4NCiAgIHBpbmN0cmwtbmFtZXMgc2VlIERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waW5jdHJscGluY3RybC1iaW5kaW5ncy50
eHQNCistIHBjbGstc2FtcGxlOiByZWZlciBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbWVkaWEvdmlkZW8taW50ZXJmYWNlcy50eHQuDQogDQogRXhhbXBsZToNCiANCkBAIC0zNyw2
ICszOCw3IEBAIGRwaTA6IGRwaUAxNDAxZDAwMCB7DQogDQogCXBvcnQgew0KIAkJZHBpMF9vdXQ6
IGVuZHBvaW50IHsNCisJCQlwY2xrLXNhbXBsZSA9IDwwPjsNCiAJCQlyZW1vdGUtZW5kcG9pbnQg
PSA8JmhkbWkwX2luPjsNCiAJCX07DQogCX07DQotLSANCjIuMjEuMA0K

