Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C005C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E135221702
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sS1R17n0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgGQDGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 23:06:02 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40943 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726234AbgGQDGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 23:06:02 -0400
X-UUID: a30f0f068cda47eeb5f915c5f748eeea-20200717
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=yDeEAbe4gKOMg3lpNmaATuHz22t3i6QSgrRhLx4UB/8=;
        b=sS1R17n0fCZJGEO0VoxpZjAK3S89gmYTpX61JjrEmW+IeO6CsYeudL7iQBCyDYqAS6NSv9PYaNNw8pvxk6mp2MJC3Xbqercwp0OzAjSinDosnA/msULAfCZ0cVog7WYzA83pQQoVr8nfTFLMk68nBXd/OxBViOVzW4LY0YF9IpI=;
X-UUID: a30f0f068cda47eeb5f915c5f748eeea-20200717
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <huihui.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 298272245; Fri, 17 Jul 2020 11:05:59 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 17 Jul 2020 11:04:20 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 17 Jul 2020 11:04:17 +0800
From:   Huihui Wang <huihui.wang@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Subject: [PATCH v1]dma: mediatek: dma address bits config with compatible data  
Date:   Fri, 17 Jul 2020 11:02:01 +0800
Message-ID: <20200717030203.14872-1-huihui.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 16F70A7F1A7BE72609A4F403F50EC8DA7BEB91D12B6DF781330698ABEAFA582B2000:8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBjaGFuZ2UgdG8gdXNlIGNvbXBhdGlibGUgZGF0YSB0byBjb25maWd1cmUgbWVk
aWF0ZWsgZG1hIGFkZHJlc3MgYml0cy4NCkFuZCB1cGRhdGUgZHQtYmluZGluZ3MgYXMgd2VsbC4N
Cg0KDQpodWlodWkgd2FuZyAoMik6DQogIGR0LWJpbmRpbmdzOiBkbWE6IG1lZGlhdGVrOiBtYXJr
IHVzZWxlc3MgaXRlbXMgYXMgZGVjcmVwdGVkDQogIGRtYTogbWVkaWF0ZWs6IGRtYSBhZGRyZXNz
IGJpdHMgY29uZmlnIHdpdGggY29tcGF0aWJsZSBkYXRhDQoNCiAuLi4vYmluZGluZ3MvZG1hL210
ay11YXJ0LWFwZG1hLnR4dCAgICAgICAgICAgfCAxMSArKy0tDQogZHJpdmVycy9kbWEvbWVkaWF0
ZWsvbXRrLXVhcnQtYXBkbWEuYyAgICAgICAgIHwgNTUgKysrKysrKysrKysrKystLS0tLQ0KIDIg
ZmlsZXMgY2hhbmdlZCwgNDUgaW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25zKC0pDQoNCi0tIA0K
Mi4xOC4wDQo=

