Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BB9C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED22246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="q9+ylRye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgB1IQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 03:16:07 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:40450 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725928AbgB1IQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 03:16:06 -0500
X-UUID: bb85578dfd2c4ab3bd3eccacfee9cfeb-20200228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=iiTeyRrWpFxbRbm/zUqFMsVdCyJg1pm41Q+smhNO+Zw=;
        b=q9+ylRyewtd89L/qoMOZEWFLLMFBVNJWWjv0L0DV2IQXGAzWWmTwf/KaVz7yohn2k64g9i/0VuvGNAmX2nHjuJawVNnn3ovLIQ4KXa46CF2pHTWDhz8SrNeTguiTVL2Odddb7dYum8U9Xcr3mVgo4mD8v6JeMgcLZBhD47RSb2A=;
X-UUID: bb85578dfd2c4ab3bd3eccacfee9cfeb-20200228
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2012579019; Fri, 28 Feb 2020 16:15:25 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 28 Feb
 2020 16:16:00 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Fri, 28 Feb 2020 16:15:42 +0800
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
Subject: [PATCH v11 2/6] dt-bindings: display: mediatek: control dpi pins mode to avoid leakage
Date:   Fri, 28 Feb 2020 16:14:37 +0800
Message-ID: <20200228081441.88179-3-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200228081441.88179-1-jitao.shi@mediatek.com>
References: <20200228081441.88179-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F57B7FDD5C7BD966BFDA5B4FA6394A541920697BDECF91A298F3BF1DE5DFADA82000:8
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

