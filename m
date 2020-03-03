Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA785C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 05:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA4024658
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 05:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WhsdKO3F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbgCCF2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 00:28:42 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:53729 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725763AbgCCF2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 00:28:42 -0500
X-UUID: 14193e4fbe314309a15c013b0f1a08c3-20200303
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=iiTeyRrWpFxbRbm/zUqFMsVdCyJg1pm41Q+smhNO+Zw=;
        b=WhsdKO3FwOfHYp/19k0cUx7fPATBy8EBjsMIw3oWBqSVOOIqqGvXtPXqkJ9XPR14mfbUrpFAUPwb9Gie2ShYz0TYQzhxmJmKZak2KUr8COLJkXrKN6uGX0P/tmIY4PNgFCo/YaH4cuXQSM+tQ20mQs3JcYOZ4A5FPhDA9BMtwyE=;
X-UUID: 14193e4fbe314309a15c013b0f1a08c3-20200303
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 145095014; Tue, 03 Mar 2020 13:27:58 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 3 Mar
 2020 13:26:34 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Tue, 3 Mar 2020 13:28:17 +0800
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
Subject: [PATCH v12 2/6] dt-bindings: display: mediatek: control dpi pins mode to avoid leakage
Date:   Tue, 3 Mar 2020 13:27:18 +0800
Message-ID: <20200303052722.94795-3-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200303052722.94795-1-jitao.shi@mediatek.com>
References: <20200303052722.94795-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 16E24079B5EC63597D44F88E585B4276553303577863E7E4995990F19E9BF1F32000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHByb3BlcnR5ICJwaW5jdHJsLW5hbWVzIiB0byBzd2FwIHBpbiBtb2RlIGJldHdlZW4gZ3Bp
byBhbmQgZHBpIG1vZGUuIFNldA0KdGhlIGRwaSBwaW5zIHRvIGdwaW8gbW9kZSBhbmQgb3V0cHV0
LWxvdyB0byBhdm9pZCBsZWFrYWdlIGN1cnJlbnQgd2hlbiBkcGkNCmRpc2FibGVkLg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBKaXRhbyBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5jb20+DQotLS0NCiAuLi4v
ZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQgIHwg
NyArKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVk
aWF0ZWssZHBpLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5
L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQNCmluZGV4IDU4OTE0Y2Y2ODFiOC4uNzdjYTMyYTMy
Mzk5IDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3Bs
YXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnR4dA0KQEAgLTE3LDYg
KzE3LDEwIEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQogICBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvZ3JhcGgudHh0LiBUaGlzIHBvcnQgc2hvdWxkIGJlIGNvbm5lY3RlZA0KICAg
dG8gdGhlIGlucHV0IHBvcnQgb2YgYW4gYXR0YWNoZWQgSERNSSBvciBMVkRTIGVuY29kZXIgY2hp
cC4NCiANCitPcHRpb25hbCBwcm9wZXJ0aWVzOg0KKy0gcGluY3RybC1uYW1lczogQ29udGFpbiAi
Z3Bpb21vZGUiIGFuZCAiZHBpbW9kZSIuDQorICBwaW5jdHJsLW5hbWVzIHNlZSBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGluY3RybHBpbmN0cmwtYmluZGluZ3MudHh0DQorDQog
RXhhbXBsZToNCiANCiBkcGkwOiBkcGlAMTQwMWQwMDAgew0KQEAgLTI3LDYgKzMxLDkgQEAgZHBp
MDogZHBpQDE0MDFkMDAwIHsNCiAJCSA8Jm1tc3lzIENMS19NTV9EUElfRU5HSU5FPiwNCiAJCSA8
JmFwbWl4ZWRzeXMgQ0xLX0FQTUlYRURfVFZEUExMPjsNCiAJY2xvY2stbmFtZXMgPSAicGl4ZWwi
LCAiZW5naW5lIiwgInBsbCI7DQorCXBpbmN0cmwtbmFtZXMgPSAiYWN0aXZlIiwgImlkbGUiOw0K
KwlwaW5jdHJsLTAgPSA8JmRwaV9waW5fZnVuYz47DQorCXBpbmN0cmwtMSA9IDwmZHBpX3Bpbl9p
ZGxlPjsNCiANCiAJcG9ydCB7DQogCQlkcGkwX291dDogZW5kcG9pbnQgew0KLS0gDQoyLjIxLjAN
Cg==

