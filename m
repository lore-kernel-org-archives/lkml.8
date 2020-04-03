Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9E8C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 08:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD3A2073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 08:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fn2bbVuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390444AbgDCIEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 04:04:20 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:43024 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727431AbgDCIET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 04:04:19 -0400
X-UUID: a8112b3f49e74f23b99f04fa80e7c743-20200403
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=UKsMIZViskVCMsCYNCt5Rxgv/TMbuDCktmnQMVQYVz4=;
        b=fn2bbVuQeUEgNdznXsYRIeHXJ6HIZrGM5x0VvFpD/+knBuggJuiA0cneAq73zt6v0J7Uv18eS7IHtm7Uf3Za9rbv94aOLaKSkuaHefbUX/5dNA1qFm2QHxBmyBVs8MCj5Qvn2YwSxiTri6aIS+ZtGYJIJN8gzcYOSV+RdultJm0=;
X-UUID: a8112b3f49e74f23b99f04fa80e7c743-20200403
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 853206419; Fri, 03 Apr 2020 16:03:59 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 3 Apr
 2020 16:03:55 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Fri, 3 Apr 2020 16:03:52 +0800
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
Subject: [PATCH v14 1/3] dt-bindings: display: mediatek: control dpi pins mode to avoid leakage
Date:   Fri, 3 Apr 2020 16:03:48 +0800
Message-ID: <20200403080350.95826-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200403080350.95826-1-jitao.shi@mediatek.com>
References: <20200403080350.95826-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 549CAC134CA528093FBABE536F5A78E2AF44513E591E31BB41E79651B89372092000:8
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
ZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQgICB8
IDYgKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVk
aWF0ZWssZHBpLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5
L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQNCmluZGV4IDU4OTE0Y2Y2ODFiOC4uNzdkZWY0NDU2
NzA2IDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3Bs
YXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnR4dA0KQEAgLTE3LDYg
KzE3LDkgQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCiAgIERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9ncmFwaC50eHQuIFRoaXMgcG9ydCBzaG91bGQgYmUgY29ubmVjdGVkDQogICB0
byB0aGUgaW5wdXQgcG9ydCBvZiBhbiBhdHRhY2hlZCBIRE1JIG9yIExWRFMgZW5jb2RlciBjaGlw
Lg0KIA0KK09wdGlvbmFsIHByb3BlcnRpZXM6DQorLSBwaW5jdHJsLW5hbWVzOiBDb250YWluICJk
ZWZhdWx0IiBhbmQgInNsZWVwIi4NCisNCiBFeGFtcGxlOg0KIA0KIGRwaTA6IGRwaUAxNDAxZDAw
MCB7DQpAQCAtMjcsNiArMzAsOSBAQCBkcGkwOiBkcGlAMTQwMWQwMDAgew0KIAkJIDwmbW1zeXMg
Q0xLX01NX0RQSV9FTkdJTkU+LA0KIAkJIDwmYXBtaXhlZHN5cyBDTEtfQVBNSVhFRF9UVkRQTEw+
Ow0KIAljbG9jay1uYW1lcyA9ICJwaXhlbCIsICJlbmdpbmUiLCAicGxsIjsNCisJcGluY3RybC1u
YW1lcyA9ICJkZWZhdWx0IiwgInNsZWVwIjsNCisJcGluY3RybC0wID0gPCZkcGlfcGluX2Z1bmM+
Ow0KKwlwaW5jdHJsLTEgPSA8JmRwaV9waW5faWRsZT47DQogDQogCXBvcnQgew0KIAkJZHBpMF9v
dXQ6IGVuZHBvaW50IHsNCi0tIA0KMi4yMS4wDQo=

