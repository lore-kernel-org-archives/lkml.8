Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4502C35DE1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916312467B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TbCOTLvK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbgBYLrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 06:47:52 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:34005 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729221AbgBYLrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 06:47:52 -0500
X-UUID: 4e1207c9983546bbb40cbe2c083f0038-20200225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=uG/aJuarO3hgV1jRiJvimGDQyEGjg4zprETLw6mHtxc=;
        b=TbCOTLvKvSO0DfRTVDpIAnaEw2IPfHLGbeB7W350MqTT7uhtyir12Zrcp6L1ulVMNV+CrWXBeStFUJyu12+Nr8m4lngsf/Qrlt1DkkEIX5r1DmfN4Ri0JQSgEeSUwAH4ysA0BjVCTQjJjU8aE7z8IaR3RjTPvCkp27lySoZteSY=;
X-UUID: 4e1207c9983546bbb40cbe2c083f0038-20200225
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 468850720; Tue, 25 Feb 2020 19:47:39 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 25 Feb
 2020 19:46:17 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Tue, 25 Feb 2020 19:46:18 +0800
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
Subject: [PATCH v2 1/4] dt-binds: display: mediatek: add property to control mipi tx drive current
Date:   Tue, 25 Feb 2020 19:47:27 +0800
Message-ID: <20200225114730.124939-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200225114730.124939-1-jitao.shi@mediatek.com>
References: <20200225114730.124939-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 40DE30FEC415DA454AAABC48CB3544E2F670014FB02503C8587B9B19739D33C22000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGEgcHJvcGVydHkgdG8gY29udHJvbCBtaXBpIHR4IGRyaXZlIGN1cnJlbnQ6DQoibWlwaXR4
LWN1cnJlbnQtZHJpdmUiDQoNClNpZ25lZC1vZmYtYnk6IEppdGFvIFNoaSA8aml0YW8uc2hpQG1l
ZGlhdGVrLmNvbT4NCi0tLQ0KIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0
ZWsvbWVkaWF0ZWssZHNpLnR4dCAgICAgfCA0ICsrKysNCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkc2kudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHNpLnR4dA0KaW5kZXgg
YTE5YTZjYzM3NWVkLi43ODAyMDFkZGNkNWMgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkc2kudHh0DQorKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRp
YXRlayxkc2kudHh0DQpAQCAtMzMsNiArMzMsOSBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KIC0g
I2Nsb2NrLWNlbGxzOiBtdXN0IGJlIDwwPjsNCiAtICNwaHktY2VsbHM6IG11c3QgYmUgPDA+Lg0K
IA0KK09wdGlvbmFsIHByb3BlcnRpZXM6DQorLSBtaXBpdHgtY3VycmVudC1kcml2ZTogYWRqdXN0
IGRyaXZpbmcgY3VycmVudCwgc2hvdWxkIGJlIDEgfiAweEYNCisNCiBFeGFtcGxlOg0KIA0KIG1p
cGlfdHgwOiBtaXBpLWRwaHlAMTAyMTUwMDAgew0KQEAgLTQyLDYgKzQ1LDcgQEAgbWlwaV90eDA6
IG1pcGktZHBoeUAxMDIxNTAwMCB7DQogCWNsb2NrLW91dHB1dC1uYW1lcyA9ICJtaXBpX3R4MF9w
bGwiOw0KIAkjY2xvY2stY2VsbHMgPSA8MD47DQogCSNwaHktY2VsbHMgPSA8MD47DQorCW1pcGl0
eC1jdXJyZW50LWRyaXZlID0gPDB4OD47DQogfTsNCiANCiBkc2kwOiBkc2lAMTQwMWIwMDAgew0K
LS0gDQoyLjIxLjANCg==

