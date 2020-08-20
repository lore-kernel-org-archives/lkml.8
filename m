Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49003C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1514C2078D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uyz6aljE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgHTGF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 02:05:57 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:19751 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726759AbgHTGFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 02:05:47 -0400
X-UUID: 32decb3983594f699bc7b53c6eb7fa1a-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=M8qskVn5Swjp+eL1e43Nsf0pOF4txuFRZvPdDs+/jiA=;
        b=uyz6aljE/IZlTQyWbkCzsx6yfVz3js2Nhh34gxRe68gPdiJ3IyLzuJ6GdpADlN2rYtBNI526pqFEeI5LCLwbg+kT2VDvZwRnXsB4ifP7gNX0m2lSrEWWsiXmECqM8CbEs3jt+Qp9ZgXT9ZAw6GuXsrddxLd5LkT9QVnseh4iCNo=;
X-UUID: 32decb3983594f699bc7b53c6eb7fa1a-20200820
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 857934898; Thu, 20 Aug 2020 14:05:41 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 14:05:39 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 14:05:38 +0800
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
Subject: [PATCH v1 08/21] drm/mediatek: check if fb is null
Date:   Thu, 20 Aug 2020 14:04:05 +0800
Message-ID: <1597903458-8055-9-git-send-email-yongqiang.niu@mediatek.com>
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

SXQncyBwb3NzaWJsZSB0aGF0IHN0YXRlLT5iYXNlLmZiIGlzIG51bGwuIEFkZCBhIGNoZWNrIGJl
Zm9yZSBhY2Nlc3MgaXRzDQpmb3JtYXQuDQoNClNpZ25lZC1vZmYtYnk6IFlvbmdxaWFuZyBOaXUg
PHlvbmdxaWFuZy5uaXVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kaXNwX292bC5jIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kaXNwX292bC5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5j
DQppbmRleCA0MjdmZTdmLi4yNTA2ODAzIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kaXNwX292bC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2Rpc3Bfb3ZsLmMNCkBAIC0yNjksNyArMjY5LDcgQEAgc3RhdGljIHZvaWQgbXRrX292bF9sYXll
cl9jb25maWcoc3RydWN0IG10a19kZHBfY29tcCAqY29tcCwgdW5zaWduZWQgaW50IGlkeCwNCiAJ
fQ0KIA0KIAljb24gPSBvdmxfZm10X2NvbnZlcnQob3ZsLCBmbXQpOw0KLQlpZiAoc3RhdGUtPmJh
c2UuZmItPmZvcm1hdC0+aGFzX2FscGhhKQ0KKwlpZiAoc3RhdGUtPmJhc2UuZmIgJiYgc3RhdGUt
PmJhc2UuZmItPmZvcm1hdC0+aGFzX2FscGhhKQ0KIAkJY29uIHw9IE9WTF9DT05fQUVOIHwgT1ZM
X0NPTl9BTFBIQTsNCiANCiAJaWYgKHBlbmRpbmctPnJvdGF0aW9uICYgRFJNX01PREVfUkVGTEVD
VF9ZKSB7DQotLSANCjEuOC4xLjEuZGlydHkNCg==

