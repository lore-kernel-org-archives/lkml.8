Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12675C2D0EF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83CD20787
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Fq9POf76"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbgCaI2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 04:28:20 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:33056 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730102AbgCaI2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 04:28:18 -0400
X-UUID: 9f5cff6902c54b979d8ed21b26fa32f1-20200331
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=baAC/mjJyyxJyJropjMcUiSH9v9z0VL+7p1/Vb1I9C4=;
        b=Fq9POf76tGniX09BR9UWOGHjUTmGf6RW+K0xPG8UqKm4iGZd8iRIJRR8FfV5kNVXiTnkHODeNWjClAjBEoOmqAQ0sG9bf6fg60OnjL+kw0KIb6BDhturfJnWw0/s0pRCO6Fc0l1jTBP+jo7VwgjPpn2zKM6IPvglR4mypd6jJAM=;
X-UUID: 9f5cff6902c54b979d8ed21b26fa32f1-20200331
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 2133848969; Tue, 31 Mar 2020 16:27:57 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 31 Mar
 2020 16:27:56 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Tue, 31 Mar 2020 16:27:54 +0800
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
Subject: [PATCH v4 2/4] dt-bindings: display: mediatek: get mipitx calibration data from nvmem
Date:   Tue, 31 Mar 2020 16:27:23 +0800
Message-ID: <20200331082725.81048-3-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200331082725.81048-1-jitao.shi@mediatek.com>
References: <20200331082725.81048-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 40A7C3EAC7A8A315B0CB8199B3C5988B4A427A8601750DB27B13C587AA44873F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHByb3BlcnRpZXMgdG8gZ2V0IGdldCBtaXBpdHggY2FsaWJyYXRpb24gZGF0YS4NCg0KUmV2
aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQpTaWduZWQtb2ZmLWJ5OiBK
aXRhbyBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5jb20+DQotLS0NCiAuLi4vZGV2aWNldHJlZS9i
aW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRzaS50eHQgICAgfCA1ICsrKysrDQog
MSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHNpLnR4
dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21l
ZGlhdGVrLGRzaS50eHQNCmluZGV4IGQ3OGI2ZDZkOGZhYi4uOGU0NzI5ZGU4Yzg1IDEwMDY0NA0K
LS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsv
bWVkaWF0ZWssZHNpLnR4dA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHNpLnR4dA0KQEAgLTM2LDYgKzM2LDkgQEAgUmVx
dWlyZWQgcHJvcGVydGllczoNCiBPcHRpb25hbCBwcm9wZXJ0aWVzOg0KIC0gZHJpdmUtc3RyZW5n
dGgtbWljcm9hbXA6IGFkanVzdCBkcml2aW5nIGN1cnJlbnQsIHNob3VsZCBiZSAzMDAwIH4gNjAw
MC4gQW5kDQogCQkJCQkJICAgdGhlIHN0ZXAgaXMgMjAwLg0KKy0gbnZtZW0tY2VsbHM6IEEgcGhh
bmRsZSB0byB0aGUgY2FsaWJyYXRpb24gZGF0YSBwcm92aWRlZCBieSBhIG52bWVtIGRldmljZS4g
SWYNCisgICAgICAgICAgICAgICB1bnNwZWNpZmllZCBkZWZhdWx0IHZhbHVlcyBzaGFsbCBiZSB1
c2VkLg0KKy0gbnZtZW0tY2VsbC1uYW1lczogU2hvdWxkIGJlICJjYWxpYnJhdGlvbi1kYXRhIg0K
IA0KIEV4YW1wbGU6DQogDQpAQCAtNDcsNiArNTAsOCBAQCBtaXBpX3R4MDogbWlwaS1kcGh5QDEw
MjE1MDAwIHsNCiAJI2Nsb2NrLWNlbGxzID0gPDA+Ow0KIAkjcGh5LWNlbGxzID0gPDA+Ow0KIAlk
cml2ZS1zdHJlbmd0aC1taWNyb2FtcCA9IDw0NjAwPjsNCisJbnZtZW0tY2VsbHM9IDwmbWlwaV90
eF9jYWxpYnJhdGlvbj47DQorCW52bWVtLWNlbGwtbmFtZXMgPSAiY2FsaWJyYXRpb24tZGF0YSI7
DQogfTsNCiANCiBkc2kwOiBkc2lAMTQwMWIwMDAgew0KLS0gDQoyLjIxLjANCg==

