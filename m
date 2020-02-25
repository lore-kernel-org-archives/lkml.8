Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E01C35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D19C20656
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UlXGXTar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbgBYJmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 04:42:10 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:21523 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729324AbgBYJmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 04:42:09 -0500
X-UUID: 715bc4b9216941a88e154c325204f587-20200225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=SYqjf55bgEilwKvR5E5iUnNYlLZi0fnyp+qvXPo+QZU=;
        b=UlXGXTaryjo9Zr/L96T9UCjX4VdUBLj45xcMxo5jbSJ6dDUfd3I+x9a7q6LJgREwY4Dltqguodmmr+tTRBXQ8DePjqRlqnSwOy+sAL8YRKYljz0V1dSAO9qnEGizf58bXVmWmow28OYZsJNiAH7ARyZf9soToYLBSoU9cgqyOVQ=;
X-UUID: 715bc4b9216941a88e154c325204f587-20200225
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 319737610; Tue, 25 Feb 2020 17:41:12 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 25 Feb
 2020 17:37:15 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Tue, 25 Feb 2020 17:39:50 +0800
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
Subject: [PATCH v8 4/7] dt-bindings: display: mediatek: dpi sample data in dual edge support
Date:   Tue, 25 Feb 2020 17:40:54 +0800
Message-ID: <20200225094057.120144-5-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200225094057.120144-1-jitao.shi@mediatek.com>
References: <20200225094057.120144-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 4B0FB546FF66D627201F8C17E97E65579B3C837BCC58C8EA2829E5A0F820878A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHByb3BlcnR5ICJwY2xrLXNhbXBsZSIgdG8gY29uZmlnIHRoZSBkcGkgc2FtcGxlIG9uIGZh
bGxpbmcgKDApLA0KcmlzaW5nICgxKSwgYm90aCBmYWxsaW5nIGFuZCByaXNpbmcgKDIpLg0KDQpT
aWduZWQtb2ZmLWJ5OiBKaXRhbyBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5jb20+DQotLS0NCiAu
Li4vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQg
ICAgIHwgNCArKysrDQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsv
bWVkaWF0ZWssZHBpLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNw
bGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQNCmluZGV4IGE3YjFiOGJmYjY1ZS4uZjM2MmZm
ZjUxNDM3IDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rp
c3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnR4dA0KQEAgLTIw
LDYgKzIwLDkgQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCiBPcHRpb25hbCBwcm9wZXJ0aWVzOg0K
IC0gcGluY3RybC1uYW1lczogQ29udGFpbiAiZ3Bpb21vZGUiIGFuZCAiZHBpbW9kZSIuDQogICBw
aW5jdHJsLW5hbWVzIHNlZSBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGluY3Ry
bHBpbmN0cmwtYmluZGluZ3MudHh0DQorLSBwY2xrLXNhbXBsZTogMDogc2FtcGxlIGluIGZhbGxp
bmcgZWRnZSwgMTogc2FtcGxlIGluIHJpc2luZyBlZGdlLCAyOiBzYW1wbGUNCisgIGluIGJvdGgg
ZmFsbGluZyBhbmQgcmlzaW5nIGVkZ2UuDQorICBwY2xrLXNhbXBsZSBzZWUgRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lZGlhL3ZpZGVvLWludGVyZmFjZXMudHh0Lg0KIA0KIEV4
YW1wbGU6DQogDQpAQCAtMzcsNiArNDAsNyBAQCBkcGkwOiBkcGlAMTQwMWQwMDAgew0KIA0KIAlw
b3J0IHsNCiAJCWRwaTBfb3V0OiBlbmRwb2ludCB7DQorCQkJcGNsay1zYW1wbGUgPSAwOw0KIAkJ
CXJlbW90ZS1lbmRwb2ludCA9IDwmaGRtaTBfaW4+Ow0KIAkJfTsNCiAJfTsNCi0tIA0KMi4yMS4w
DQo=

