Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3329FC433E4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07AB520720
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="urKCtOUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgGKGuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 02:50:06 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:37603 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726963AbgGKGuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 02:50:06 -0400
X-UUID: 4e06c3eac4b141eba298de744f2c6a0b-20200711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=sgr1Zs/aJm2W+sw/MhVKuVhlKEzM0+yMq/CPDd+2YIE=;
        b=urKCtOUXlWMZ463/DtoGXbjDNh6FUidoqSFYgJnBfD56p/AK8UhSwsAoNv9n9DaBVDoIRRPIvW8TC2cT1tq8ZgAHJzLrwA5SzZeUVRDWJDADXyWtDGAZi2Lmy2VamT6oGK5HSJNlrNKroz67ctcyhq3o/ExLu4BFtwCPJ5ZWdA8=;
X-UUID: 4e06c3eac4b141eba298de744f2c6a0b-20200711
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 221799176; Sat, 11 Jul 2020 14:50:02 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Jul 2020 14:49:58 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Jul 2020 14:49:57 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Will Deacon <will@kernel.org>, Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <cui.zhang@mediatek.com>,
        <chao.hao@mediatek.com>, <ming-fan.chen@mediatek.com>
Subject: [PATCH 02/21] dt-binding: memory: mediatek: Extend LARB_NR_MAX to 32
Date:   Sat, 11 Jul 2020 14:48:27 +0800
Message-ID: <20200711064846.16007-3-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200711064846.16007-1-yong.wu@mediatek.com>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RXh0ZW5kIHRoZSBtYXggbGFyYiBudW1iZXIgZGVmaW5pdGlvbiBhcyBtdDgxOTIgaGFzIGxhcmJf
bnIgb3ZlciAxNi4NCg0KU2lnbmVkLW9mZi1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5j
b20+DQotLS0NCiBpbmNsdWRlL2R0LWJpbmRpbmdzL21lbW9yeS9tdGstc21pLWxhcmItcG9ydC5o
IHwgNCArKy0tDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCg0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHQtYmluZGluZ3MvbWVtb3J5L210ay1zbWktbGFy
Yi1wb3J0LmggYi9pbmNsdWRlL2R0LWJpbmRpbmdzL21lbW9yeS9tdGstc21pLWxhcmItcG9ydC5o
DQppbmRleCAyZWM3ZmU1Y2U0ZTkuLmY0ZDhlM2FlZDBiYyAxMDA2NDQNCi0tLSBhL2luY2x1ZGUv
ZHQtYmluZGluZ3MvbWVtb3J5L210ay1zbWktbGFyYi1wb3J0LmgNCisrKyBiL2luY2x1ZGUvZHQt
YmluZGluZ3MvbWVtb3J5L210ay1zbWktbGFyYi1wb3J0LmgNCkBAIC02LDEwICs2LDEwIEBADQog
I2lmbmRlZiBfX0RUU19NVEtfSU9NTVVfUE9SVF9IXw0KICNkZWZpbmUgX19EVFNfTVRLX0lPTU1V
X1BPUlRfSF8NCiANCi0jZGVmaW5lIE1US19MQVJCX05SX01BWAkJCTE2DQorI2RlZmluZSBNVEtf
TEFSQl9OUl9NQVgJCQkzMg0KIA0KICNkZWZpbmUgTVRLX000VV9JRChsYXJiLCBwb3J0KQkJKCgo
bGFyYikgPDwgNSkgfCAocG9ydCkpDQotI2RlZmluZSBNVEtfTTRVX1RPX0xBUkIoaWQpCQkoKChp
ZCkgPj4gNSkgJiAweGYpDQorI2RlZmluZSBNVEtfTTRVX1RPX0xBUkIoaWQpCQkoKChpZCkgPj4g
NSkgJiAweDFmKQ0KICNkZWZpbmUgTVRLX000VV9UT19QT1JUKGlkKQkJKChpZCkgJiAweDFmKQ0K
IA0KICNlbmRpZg0KLS0gDQoyLjE4LjANCg==

