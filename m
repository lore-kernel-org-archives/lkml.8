Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503E6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A1CD22B42
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="c5Pmg1YA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbgHEUOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:14:40 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:63732 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726787AbgHEQX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:23:26 -0400
X-UUID: e29e6b337d304d3cae0f2fadfbac608b-20200805
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=W+8vFgDLAHSnyx4ZlvFOpI0WldrXWUwa3ro5eWJKSTY=;
        b=c5Pmg1YAT9B0AVaO9NmHflQFavAF5UKYRZ/aOKtMeMJBQqdVFlXumpaDCHb0Aolw8SE6VBOWuj1hkJRih0BalhIkepWC3iCnVjaVzYDKwykLf0eu5zIqIpca6RM/UB+h40ms4OYHP9G2WhiMLF/5yCfdrlFDxgfx+kg0x1vDD20=;
X-UUID: e29e6b337d304d3cae0f2fadfbac608b-20200805
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 826500220; Wed, 05 Aug 2020 18:53:19 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 5 Aug 2020 18:53:16 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 5 Aug 2020 18:53:17 +0800
From:   Qii Wang <qii.wang@mediatek.com>
To:     <wsa@the-dreams.de>
CC:     <robh+dt@kernel.org>, <linux-i2c@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <qii.wang@mediatek.com>
Subject: [PATCH v3 0/4] add i2c support for mt8192
Date:   Wed, 5 Aug 2020 18:52:18 +0800
Message-ID: <1596624742-14727-1-git-send-email-qii.wang@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBzZXJpZXMgYXJlIGJhc2VkIG9uIDUuOC1yYzEgYW5kIHdlIHByb3ZpZGUgZm91ciBpMmMg
cGF0Y2hlcw0KdG8gc3VwcG9ydCBtdDgxOTIgU29DLg0KDQpNYWluIGNoYW5nZXMgY29tcGFyZWQg
dG8gdjI6DQotLWRlbGV0ZSB1bnVzZWQgSTJDX0RNQV80R19NT0RFDQoNCk1haW4gY2hhbmdlcyBj
b21wYXJlZCB0byB2MToNCi0tbW9kaWZ5IHRoZSBjb21taXQgd2l0aCBhY2Nlc3MgbW9yZSB0aGFu
IDhHQiBkcmFtDQotLWFkZCBSZXZpZXdlZC1ieSBhbmQgQWNrZWQtYnkgZnJvbSBZaW5nam9lLCBN
YXR0aGlhcyBhbmQgUm9iDQoNClFpaSBXYW5nICg0KToNCiAgaTJjOiBtZWRpYXRlazogQWRkIGFw
ZG1hIHN5bmMgaW4gaTJjIGRyaXZlcg0KICBpMmM6IG1lZGlhdGVrOiBBZGQgYWNjZXNzIHRvIG1v
cmUgdGhhbiA4R0IgZHJhbSBpbiBpMmMgZHJpdmVyDQogIGR0LWJpbmRpbmdzOiBpMmM6IHVwZGF0
ZSBiaW5kaW5ncyBmb3IgTVQ4MTkyIFNvQw0KICBpMmM6IG1lZGlhdGVrOiBBZGQgaTJjIGNvbXBh
dGlibGUgZm9yIE1lZGlhVGVrIE1UODE5Mg0KDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3MvaTJj
L2kyYy1tdDY1eHgudHh0ICAgICAgICAgfCAgMSArDQogZHJpdmVycy9pMmMvYnVzc2VzL2kyYy1t
dDY1eHguYyAgICAgICAgICAgICAgICAgICAgfCA3NyArKysrKysrKysrKysrKystLS0tLS0tDQog
MiBmaWxlcyBjaGFuZ2VkLCA1MyBpbnNlcnRpb25zKCspLCAyNSBkZWxldGlvbnMoLSkNCg0KLS0g
DQoxLjkuMQ0K

