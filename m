Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE929C433EC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86ED5207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 03:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Ghwzl+hd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387687AbgGWDGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 23:06:18 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:45534 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387603AbgGWDGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 23:06:13 -0400
X-UUID: 07c7263e65c74c03bd03e4e2f86a06a6-20200723
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=7uVbshrKxzDKJKB3nqLKrcjiGO4dehse9Az1U7E6QkQ=;
        b=Ghwzl+hdcARkgPzy2RSySwrPOpKqTLQwljVaQ7Dl5uccdDMOefqKnDlsTQORPbzWCubQO3vl2M21bkeHzg9dsWqYLCCnkxLfCbqGVqds3zYMAUd8RRKvu1tO5T6OGLCnlvMThRNy6vFDW5jYNVnPnm4TOnztjAkJMv4mgfZmF28=;
X-UUID: 07c7263e65c74c03bd03e4e2f86a06a6-20200723
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <xia.jiang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 542896450; Thu, 23 Jul 2020 11:06:09 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 23 Jul 2020 11:06:07 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Jul 2020 11:06:03 +0800
From:   Xia Jiang <xia.jiang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rick Chang <rick.chang@mediatek.com>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <srv_heupstream@mediatek.com>, <senozhatsky@chromium.org>,
        <mojahsu@chromium.org>, <drinkcat@chromium.org>,
        <maoguang.meng@mediatek.com>, Xia Jiang <xia.jiang@mediatek.com>
Subject: [PATCH v10 04/28] media: platform: Change the fixed device node number to unfixed value
Date:   Thu, 23 Jul 2020 11:04:27 +0800
Message-ID: <20200723030451.5616-5-xia.jiang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200723030451.5616-1-xia.jiang@mediatek.com>
References: <20200723030451.5616-1-xia.jiang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGRyaXZlciBjYW4gYmUgaW5zdGFudGlhdGVkIG11bHRpcGxlIHRpbWVzLCBlLmcuIGZvciBh
IGRlY29kZXIgYW5kDQphbiBlbmNvZGVyLiBNb3Jlb3Zlciwgb3RoZXIgZHJpdmVycyBjb3VsZCBj
b2V4aXN0IG9uIHRoZSBzYW1lIHN5c3RlbS4NClRoaXMgbWFrZXMgdGhlIHN0YXRpYyB2aWRlbyBu
b2RlIG51bWJlciBhc3NpZ25tZW50IHBvaW50bGVzcywgc28gc3dpdGNoDQp0byBhdXRvbWF0aWMg
YXNzaWdubWVudCBpbnN0ZWFkLg0KDQpSZXZpZXdlZC1ieTogVG9tYXN6IEZpZ2EgPHRmaWdhQGNo
cm9taXVtLm9yZz4NClNpZ25lZC1vZmYtYnk6IFhpYSBKaWFuZyA8eGlhLmppYW5nQG1lZGlhdGVr
LmNvbT4NCi0tLQ0KdjEwOiBubyBjaGFuZ2VzDQotLS0NCiBkcml2ZXJzL21lZGlhL3BsYXRmb3Jt
L210ay1qcGVnL210a19qcGVnX2NvcmUuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvcGxh
dGZvcm0vbXRrLWpwZWcvbXRrX2pwZWdfY29yZS5jIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9t
dGstanBlZy9tdGtfanBlZ19jb3JlLmMNCmluZGV4IDI2Nzc1ODA5NDFiMC4uMTI2MDljYTQ2ZmQ5
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tdGstanBlZy9tdGtfanBlZ19j
b3JlLmMNCisrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRrLWpwZWcvbXRrX2pwZWdfY29y
ZS5jDQpAQCAtMTE1NCw3ICsxMTU0LDcgQEAgc3RhdGljIGludCBtdGtfanBlZ19wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAlqcGVnLT5kZWNfdmRldi0+ZGV2aWNlX2NhcHMg
PSBWNEwyX0NBUF9TVFJFQU1JTkcgfA0KIAkJCQkgICAgICBWNEwyX0NBUF9WSURFT19NMk1fTVBM
QU5FOw0KIA0KLQlyZXQgPSB2aWRlb19yZWdpc3Rlcl9kZXZpY2UoanBlZy0+ZGVjX3ZkZXYsIFZG
TF9UWVBFX1ZJREVPLCAzKTsNCisJcmV0ID0gdmlkZW9fcmVnaXN0ZXJfZGV2aWNlKGpwZWctPmRl
Y192ZGV2LCBWRkxfVFlQRV9WSURFTywgLTEpOw0KIAlpZiAocmV0KSB7DQogCQl2NGwyX2Vycigm
anBlZy0+djRsMl9kZXYsICJGYWlsZWQgdG8gcmVnaXN0ZXIgdmlkZW8gZGV2aWNlXG4iKTsNCiAJ
CWdvdG8gZXJyX2RlY192ZGV2X3JlZ2lzdGVyOw0KLS0gDQoyLjE4LjANCg==

