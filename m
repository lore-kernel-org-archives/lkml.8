Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C74C35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A17121927
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pFsy1pqO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbgBYJlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 04:41:17 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:7811 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729385AbgBYJlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 04:41:16 -0500
X-UUID: 2187fbae83654fcfa451448df3bcfe9a-20200225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=EOZhVfNB0b5LZMk1Mx0eD9SqOovmQbwT9yhV2ijRMxs=;
        b=pFsy1pqO4Dtq3JvvcUMTKGTAyEeu4oBIzNcp2bcx3LSkKQDB5R5y4IpGjqqd2WORAte90j9t7m7hB1QqNnsrNEQH9VFEadrX8CmtBI/eeOEJdkmdF8hYYJSYJ7kKf/YKt4ODPEnFwba0Jd/3/sjneyENUpQ+76EwmSNASDOsbRg=;
X-UUID: 2187fbae83654fcfa451448df3bcfe9a-20200225
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 522936693; Tue, 25 Feb 2020 17:41:10 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 25 Feb
 2020 17:39:48 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Tue, 25 Feb 2020 17:39:48 +0800
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
Subject: [PATCH v8 3/7] dt-bindings: display: mediatek: control dpi pins mode to avoid leakage
Date:   Tue, 25 Feb 2020 17:40:53 +0800
Message-ID: <20200225094057.120144-4-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200225094057.120144-1-jitao.shi@mediatek.com>
References: <20200225094057.120144-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A6156C3D769845A20D846C6BE7DE540963C817F1ACD04927F075C1E510C863D62000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHByb3BlcnR5ICJwaW5jdHJsLW5hbWVzIiB0byBzd2FwIHBpbiBtb2RlIGJldHdlZW4gZ3Bp
byBhbmQgZHBpIG1vZGUuIFNldA0KcGluIG1vZGUgdG8gZ3BpbyBvdXBwdXQtbG93IHRvIGF2b2lk
IGxlYWthZ2UgY3VycmVudCB3aGVuIGRwaSBkaXNhYmxlLg0KDQpTaWduZWQtb2ZmLWJ5OiBKaXRh
byBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5jb20+DQotLS0NCiAuLi4vZGV2aWNldHJlZS9iaW5k
aW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQgIHwgNyArKysrKysrDQogMSBm
aWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnR4dCBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlh
dGVrLGRwaS50eHQNCmluZGV4IDU4OTE0Y2Y2ODFiOC4uYTdiMWI4YmZiNjVlIDEwMDY0NA0KLS0t
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVk
aWF0ZWssZHBpLnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rp
c3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnR4dA0KQEAgLTE3LDYgKzE3LDEwIEBAIFJlcXVp
cmVkIHByb3BlcnRpZXM6DQogICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZ3Jh
cGgudHh0LiBUaGlzIHBvcnQgc2hvdWxkIGJlIGNvbm5lY3RlZA0KICAgdG8gdGhlIGlucHV0IHBv
cnQgb2YgYW4gYXR0YWNoZWQgSERNSSBvciBMVkRTIGVuY29kZXIgY2hpcC4NCiANCitPcHRpb25h
bCBwcm9wZXJ0aWVzOg0KKy0gcGluY3RybC1uYW1lczogQ29udGFpbiAiZ3Bpb21vZGUiIGFuZCAi
ZHBpbW9kZSIuDQorICBwaW5jdHJsLW5hbWVzIHNlZSBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvcGluY3RybHBpbmN0cmwtYmluZGluZ3MudHh0DQorDQogRXhhbXBsZToNCiANCiBk
cGkwOiBkcGlAMTQwMWQwMDAgew0KQEAgLTI3LDYgKzMxLDkgQEAgZHBpMDogZHBpQDE0MDFkMDAw
IHsNCiAJCSA8Jm1tc3lzIENMS19NTV9EUElfRU5HSU5FPiwNCiAJCSA8JmFwbWl4ZWRzeXMgQ0xL
X0FQTUlYRURfVFZEUExMPjsNCiAJY2xvY2stbmFtZXMgPSAicGl4ZWwiLCAiZW5naW5lIiwgInBs
bCI7DQorCXBpbmN0cmwtbmFtZXMgPSAiZ3Bpb21vZGUiLCAiZHBpbW9kZSI7DQorCXBpbmN0cmwt
MCA9IDwmZHBpX3Bpbl9ncGlvPjsNCisJcGluY3RybC0xID0gPCZkcGlfcGluX2Z1bmM+Ow0KIA0K
IAlwb3J0IHsNCiAJCWRwaTBfb3V0OiBlbmRwb2ludCB7DQotLSANCjIuMjEuMA0K

