Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C76DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DB622080C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NLZTu+Nk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731163AbgFSIFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 04:05:31 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:27880 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729548AbgFSIFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 04:05:17 -0400
X-UUID: b696b1294c7a4639856c86d8dfb1705b-20200619
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=pkta2QbbE1IXKyYB7noFCSjfGxO9nkhj518++z9rfPA=;
        b=NLZTu+NkZyVwgdb86QPKOMshyP7jJ+w3yWnwr5nlg9JOJb1pcZds01Iaa3Blx4HpmgaMbWNWTAaoAuR/W2IHNvqzmanUWePT5q9GVqvpEOdLFjC8+MYP2JkIpYP1FZRNDtxb+AysdyPB9UWRSQnLQUVQKZKSGZAySmnpGpIsQos=;
X-UUID: b696b1294c7a4639856c86d8dfb1705b-20200619
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <eastl.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 304416723; Fri, 19 Jun 2020 16:05:06 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 19 Jun 2020 16:05:05 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 19 Jun 2020 16:05:05 +0800
From:   EastL <EastL.Lee@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
CC:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Subject: [PATCH v5] dmaengine: mediatek-cqdma: add dt-bindings and remove redundant queue
Date:   Fri, 19 Jun 2020 16:04:58 +0800
Message-ID: <1592553902-30592-1-git-send-email-EastL.Lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBzZXQgYWRkcyBkb2N1bWVudCB0aGUgZGV2aWNldHJlZSBiaW5kaW5ncyBmb3Ig
TWVkaWFUZWsgQ29tbWFuZC1RdWV1ZSBETUEgY29udHJvbGxlciwNCmFuZCByZW1vdmUgcmVkdW5k
YW50IHF1ZXVlIHN0cnVjdHVyZS4NCg0KaGFuZ2VzIHNpbmNlIHY0Og0KLSBmaXggeWFtbCAmIGRt
YS1tYXNrIGNvZGUgZmxvdw0KDQpoYW5nZXMgc2luY2UgdjM6DQotIGZpeCBkdF9iaW5kaW5nX2No
ZWNrIGVycm9ycw0KDQpDaGFuZ2VzIHNpbmNlIHYyOg0KLSBhZGQgZGV2aWNldHJlZSBiaW5kaW5n
cyBmb3IgTWVkaWFUZWsgQ29tbWFuZC1RdWV1ZSBETUEgY29udHJvbGxlcg0KDQpDaGFuZ2VzIHNp
bmNlIHYxOg0KLSByZW1vdmUgcmVkdW5kYW50IHF1ZXVlIHN0cnVjdHVyZQ0KLSBmaXggd3Jvbmcg
ZGVzY3JpcHRpb24gYW5kIHRhZ3MgaW4gdGhlIGVhcmxpZXIgcGF0Y2gNCi0gYWRkIGRtYS1jaGFu
bmVsLW1hc2sgZm9yIERNQSBjYXBhYmlsaXR5DQotIGZpeCBjb21wYXRpYmxlIGZvciBjb21tb24N
Cg0K

