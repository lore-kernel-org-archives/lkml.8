Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1FFC10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5336220578
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fSMM/0ua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgCKHlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:41:11 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:48573 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728399AbgCKHlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:41:08 -0400
X-UUID: 2ac0eba338ed45ffa245c0e7eff96242-20200311
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ky4U2iOoR/7QiRcWdPirzV01VHNVyn80Ewfl4QlT/O8=;
        b=fSMM/0ua2SbwT+3PcZr10JLvg37lDkVXfPrX/r3VOfFtYDaavpSYEwW9pVlV076V3LV2VqhZCpsUIjkQsNDjyDL2Oap8rqTHYIJ5CPMcNuLGA4YkEUOdQFMmlhtYqBIULCs7rrm3KIEy41SWcvPBNKj44cmoBnZ7j2Dr2da6bjM=;
X-UUID: 2ac0eba338ed45ffa245c0e7eff96242-20200311
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 524470452; Wed, 11 Mar 2020 15:40:54 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 11 Mar
 2020 15:41:13 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Wed, 11 Mar 2020 15:42:03 +0800
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
Subject: [PATCH v3 2/4] dt-bindings: display: mediatek: get mipitx calibration data from nvmem
Date:   Wed, 11 Mar 2020 15:40:30 +0800
Message-ID: <20200311074032.119481-3-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200311074032.119481-1-jitao.shi@mediatek.com>
References: <20200311074032.119481-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E25E520462EF9651236524639997E14D57FB8F467C6CAC3B9008681332D7BE932000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHByb3BlcnRpZXMgdG8gZ2V0IGdldCBtaXBpdHggY2FsaWJyYXRpb24gZGF0YS4NCg0KU2ln
bmVkLW9mZi1ieTogSml0YW8gU2hpIDxqaXRhby5zaGlAbWVkaWF0ZWsuY29tPg0KLS0tDQogLi4u
L2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkc2kudHh0ICAg
IHwgNSArKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21l
ZGlhdGVrLGRzaS50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxh
eS9tZWRpYXRlay9tZWRpYXRlayxkc2kudHh0DQppbmRleCBkNTAxZjlmZjRiMWYuLmIxNzkyOTNj
NDNkZSAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNw
bGF5L21lZGlhdGVrL21lZGlhdGVrLGRzaS50eHQNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRzaS50eHQNCkBAIC0zNCw2
ICszNCw5IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQogLSAjcGh5LWNlbGxzOiBtdXN0IGJlIDww
Pi4NCiANCiBPcHRpb25hbCBwcm9wZXJ0aWVzOg0KKy0gbnZtZW0tY2VsbHM6IEEgcGhhbmRsZSB0
byB0aGUgY2FsaWJyYXRpb24gZGF0YSBwcm92aWRlZCBieSBhIG52bWVtIGRldmljZS4gSWYNCisg
ICAgICAgICAgICAgICB1bnNwZWNpZmllZCBkZWZhdWx0IHZhbHVlcyBzaGFsbCBiZSB1c2VkLg0K
Ky0gbnZtZW0tY2VsbC1uYW1lczogU2hvdWxkIGJlICJjYWxpYnJhdGlvbi1kYXRhIg0KIC0gZHJp
dmUtc3RyZW5ndGgtbWljcm9hbXA6IGFkanVzdCBkcml2aW5nIGN1cnJlbnQsIHNob3VsZCBiZSAx
IH4gMHhGDQogDQogRXhhbXBsZToNCkBAIC00NSw2ICs0OCw4IEBAIG1pcGlfdHgwOiBtaXBpLWRw
aHlAMTAyMTUwMDAgew0KIAljbG9jay1vdXRwdXQtbmFtZXMgPSAibWlwaV90eDBfcGxsIjsNCiAJ
I2Nsb2NrLWNlbGxzID0gPDA+Ow0KIAkjcGh5LWNlbGxzID0gPDA+Ow0KKwludm1lbS1jZWxscz0g
PCZtaXBpX3R4X2NhbGlicmF0aW9uPjsNCisJbnZtZW0tY2VsbC1uYW1lcyA9ICJjYWxpYnJhdGlv
bi1kYXRhIjsNCiAJZHJpdmUtc3RyZW5ndGgtbWljcm9hbXAgPSA8MHg4PjsNCiB9Ow0KIA0KLS0g
DQoyLjIxLjANCg==

