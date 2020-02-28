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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0305BC3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5E3246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 08:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Fum5kK93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgB1IPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 03:15:48 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:6614 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726287AbgB1IPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 03:15:48 -0500
X-UUID: 2a91b08ff3c2401bb1ed3ba5f51df7be-20200228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5KIAJmoTEhesMxKkwMtB3WhawX6q5b9wBfPte+p7ggk=;
        b=Fum5kK93fc/Y8VU56e05l7uaRi0scKy/WS/8ok0QHPtqf0vNPdTxkIm9EdvnOKGzpSml5hV8Gi5JuwXazBPKZIdp6T/ljoqMZ0s8KTGxiMz6a7ELtxKtAFju/cNkfi3Lj6H1bW2pd5chZ97gRoEFdCDo7SJA6JMxlEPP5yeTEe0=;
X-UUID: 2a91b08ff3c2401bb1ed3ba5f51df7be-20200228
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1533816250; Fri, 28 Feb 2020 16:15:31 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 28 Feb
 2020 16:14:08 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Fri, 28 Feb 2020 16:15:50 +0800
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
Subject: [PATCH v11 3/6] dt-bindings: display: mediatek: dpi sample data in dual edge support
Date:   Fri, 28 Feb 2020 16:14:38 +0800
Message-ID: <20200228081441.88179-4-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200228081441.88179-1-jitao.shi@mediatek.com>
References: <20200228081441.88179-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9C0CC5AF09DDE5E172435E0E236F3E98FD367E38DAD99B45F8829F8E69DA87212000:8
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
ICAgIHwgNCArKystDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rp
c3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS50eHQNCmluZGV4IDc3Y2Ez
MmEzMjM5OS4uNGVlZWFkMWQzOWRiIDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnR4dA0KKysrIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWss
ZHBpLnR4dA0KQEAgLTE5LDcgKzE5LDggQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCiANCiBPcHRp
b25hbCBwcm9wZXJ0aWVzOg0KIC0gcGluY3RybC1uYW1lczogQ29udGFpbiAiZ3Bpb21vZGUiIGFu
ZCAiZHBpbW9kZSIuDQotICBwaW5jdHJsLW5hbWVzIHNlZSBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcGluY3RybHBpbmN0cmwtYmluZGluZ3MudHh0DQorICBwaW5jdHJsLW5hbWVz
IHNlZSBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGluY3RybC9waW5jdHJsLWJp
bmRpbmdzLnR4dA0KKy0gcGNsay1zYW1wbGU6IHJlZmVyIERvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tZWRpYS92aWRlby1pbnRlcmZhY2VzLnR4dC4NCiANCiBFeGFtcGxlOg0KIA0K
QEAgLTM3LDYgKzM4LDcgQEAgZHBpMDogZHBpQDE0MDFkMDAwIHsNCiANCiAJcG9ydCB7DQogCQlk
cGkwX291dDogZW5kcG9pbnQgew0KKwkJCXBjbGstc2FtcGxlID0gPDA+Ow0KIAkJCXJlbW90ZS1l
bmRwb2ludCA9IDwmaGRtaTBfaW4+Ow0KIAkJfTsNCiAJfTsNCi0tIA0KMi4yMS4wDQo=

