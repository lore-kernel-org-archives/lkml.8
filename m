Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6504C18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE298208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dSEzX5Iw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgCKHSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:18:53 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:20417 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726160AbgCKHSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:18:51 -0400
X-UUID: f5d40f382d5647cb9d453a9df03882a3-20200311
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=JjlUifr9XVbMvq2Ua2czBdK7aPiBCtIeib5Cawn+s3o=;
        b=dSEzX5IwMRTy6n3UWCeFJsiNkBRAGhF7q/iq6OBBLvCSvJlg1pKdaD+iz746in9/XYK0p8TNhLZP2h3oh83TCbLXBrLYmBXyoN5PkNK0nyJpp/C+FlN3khtT4Nd41d5WkfBCG5gt9oplcogt5GElZBrLO8cY7DlUAoBYaulsha0=;
X-UUID: f5d40f382d5647cb9d453a9df03882a3-20200311
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 69581695; Wed, 11 Mar 2020 15:18:43 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 11 Mar
 2020 15:14:26 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Wed, 11 Mar 2020 15:18:07 +0800
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
Subject: [PATCH v13 2/6] dt-bindings: display: mediatek: control dpi pins mode to avoid leakage
Date:   Wed, 11 Mar 2020 15:18:19 +0800
Message-ID: <20200311071823.117899-3-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200311071823.117899-1-jitao.shi@mediatek.com>
References: <20200311071823.117899-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: EEB2C134C140F530CBBCD4DC61CFFF84ADDCAB296BAFE6E04F7549C523C14D8D2000:8
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
L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQNCmluZGV4IDU4OTE0Y2Y2ODFiOC4uMjYwYWU3NWFj
NjQwIDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3Bs
YXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnR4dA0KQEAgLTE3LDYg
KzE3LDEwIEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQogICBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvZ3JhcGgudHh0LiBUaGlzIHBvcnQgc2hvdWxkIGJlIGNvbm5lY3RlZA0KICAg
dG8gdGhlIGlucHV0IHBvcnQgb2YgYW4gYXR0YWNoZWQgSERNSSBvciBMVkRTIGVuY29kZXIgY2hp
cC4NCiANCitPcHRpb25hbCBwcm9wZXJ0aWVzOg0KKy0gcGluY3RybC1uYW1lczogQ29udGFpbiAi
ZGVmYXVsdCIgYW5kICJzbGVlcCIuDQorICBwaW5jdHJsLW5hbWVzIHNlZSBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvcGluY3RybHBpbmN0cmwtYmluZGluZ3MudHh0DQorDQogRXhh
bXBsZToNCiANCiBkcGkwOiBkcGlAMTQwMWQwMDAgew0KQEAgLTI3LDYgKzMxLDkgQEAgZHBpMDog
ZHBpQDE0MDFkMDAwIHsNCiAJCSA8Jm1tc3lzIENMS19NTV9EUElfRU5HSU5FPiwNCiAJCSA8JmFw
bWl4ZWRzeXMgQ0xLX0FQTUlYRURfVFZEUExMPjsNCiAJY2xvY2stbmFtZXMgPSAicGl4ZWwiLCAi
ZW5naW5lIiwgInBsbCI7DQorCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCIsICJzbGVlcCI7DQor
CXBpbmN0cmwtMCA9IDwmZHBpX3Bpbl9mdW5jPjsNCisJcGluY3RybC0xID0gPCZkcGlfcGluX2lk
bGU+Ow0KIA0KIAlwb3J0IHsNCiAJCWRwaTBfb3V0OiBlbmRwb2ludCB7DQotLSANCjIuMjEuMA0K

