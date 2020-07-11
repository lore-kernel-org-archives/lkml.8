Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EDDC433E7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8C4820720
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 06:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="I6Ivn84K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgGKGuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 02:50:15 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39520 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726963AbgGKGuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 02:50:15 -0400
X-UUID: 3a91b375458b486f8ec06bde54248efb-20200711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=x0xfVmpYZuSxhMoMzStadgCKhVFTNZwOTohvBaXulhY=;
        b=I6Ivn84Kk6j3l4x6kkuq8+p45REHIpQ/X+O7TnH9YaUMDpe8P8OnkbCUbTdqA0Z6iY/28XFExbKRd2E0ivT9oOc3rCvNtf2gB/G59BKKpD4n4McKje7GASWYqsvpgJindf7B23mMGx/tkH5vLgK8BJ4oOhhLYp1Cnzl8xrIbMds=;
X-UUID: 3a91b375458b486f8ec06bde54248efb-20200711
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1629835902; Sat, 11 Jul 2020 14:50:11 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Jul 2020 14:50:07 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Jul 2020 14:50:06 +0800
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
Subject: [PATCH 03/21] dt-binding: memory: mediatek: Add domain definition
Date:   Sat, 11 Jul 2020 14:48:28 +0800
Message-ID: <20200711064846.16007-4-yong.wu@mediatek.com>
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

SW4gdGhlIGxhdGVzdCBTb0MsIHRoZXJlIGFyZSBzZXZlcmFsIEhXIElQIHJlcXVpcmUgYSBzZXBl
Y2lhbCBpb3ZhDQpyYW5nZSwgbWFpbmx5IENDVSBhbmQgVlBVIGhhcyB0aGlzIHJlcXVpcmVtZW50
LiBUYWtlIENDVSBhcyBhIGV4YW1wbGUsDQpDQ1UgcmVxdWlyZSBpdHMgaW92YSBsb2NhdGUgaW4g
dGhlIHJhbmdlKDB4NDAwMF8wMDAwIH4gMHg0M2ZmX2ZmZmYpLg0KDQpJbiB0aGlzIHBhdGNoIHdl
IGFkZCBhIGRvbWFpbiBkZWZpbml0aW9uIGZvciB0aGUgc3BlY2lhbCBwb3J0LiBUaGlzIGlzDQph
IHByZXBhcmluZyBwYXRjaCBmb3IgbXVsdGktZG9tYWluIHN1cHBvcnQuDQoNClNpZ25lZC1vZmYt
Ynk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KLS0tDQogaW5jbHVkZS9kdC1iaW5k
aW5ncy9tZW1vcnkvbXRrLXNtaS1sYXJiLXBvcnQuaCB8IDkgKysrKysrKystDQogMSBmaWxlIGNo
YW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXRrLXNtaS1sYXJiLXBvcnQuaCBiL2luY2x1ZGUvZHQt
YmluZGluZ3MvbWVtb3J5L210ay1zbWktbGFyYi1wb3J0LmgNCmluZGV4IGY0ZDhlM2FlZDBiYy4u
ZDAwZjVkZTg0MzhiIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXRr
LXNtaS1sYXJiLXBvcnQuaA0KKysrIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9tZW1vcnkvbXRrLXNt
aS1sYXJiLXBvcnQuaA0KQEAgLTcsOSArNywxNiBAQA0KICNkZWZpbmUgX19EVFNfTVRLX0lPTU1V
X1BPUlRfSF8NCiANCiAjZGVmaW5lIE1US19MQVJCX05SX01BWAkJCTMyDQorI2RlZmluZSBNVEtf
TTRVX0RPTV9OUl9NQVgJCTgNCisNCisjZGVmaW5lIE1US19NNFVfRE9NX0lEKGRvbWlkLCBsYXJi
LCBwb3J0KQlcDQorCSgoKGRvbWlkKSAmIDB4NykgPDwgMTYgfCAoKChsYXJiKSAmIDB4MWYpIDw8
IDUpIHwgKChwb3J0KSAmIDB4MWYpKQ0KKw0KKy8qIFRoZSBkZWZhdWx0IGRvbSBpZCBpcyAwLiAq
Lw0KKyNkZWZpbmUgTVRLX000VV9JRChsYXJiLCBwb3J0KQkJTVRLX000VV9ET01fSUQoMCwgbGFy
YiwgcG9ydCkNCiANCi0jZGVmaW5lIE1US19NNFVfSUQobGFyYiwgcG9ydCkJCSgoKGxhcmIpIDw8
IDUpIHwgKHBvcnQpKQ0KICNkZWZpbmUgTVRLX000VV9UT19MQVJCKGlkKQkJKCgoaWQpID4+IDUp
ICYgMHgxZikNCiAjZGVmaW5lIE1US19NNFVfVE9fUE9SVChpZCkJCSgoaWQpICYgMHgxZikNCisj
ZGVmaW5lIE1US19NNFVfVE9fRE9NKGlkKQkJKCgoaWQpID4+IDE2KSAmIDB4NykNCiANCiAjZW5k
aWYNCi0tIA0KMi4xOC4wDQo=

