Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D6BC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 06:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8FFD2067C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 06:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fEcZ1Nch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgIBGwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 02:52:09 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:44051 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726247AbgIBGwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 02:52:08 -0400
X-UUID: 5e48a1cfac724b3dadee74824d957d0f-20200902
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=lDVSYqSdhWvazAaxAPYnlR1bfGV0xbA4TBV5NTbHi/w=;
        b=fEcZ1Nchul9aWpUBHS2Te9gDzlkfCxMbHyWMjJrY6K54ETWYGkMa2xSoBKLus2di7OHp1wUj8GBRdZNZkZCQ43T9pqu2avdBES3ARtBZb1DF2Y1usazBc562VjGUKnFQuOkOyFVbncBfPzM8n/BjhnZKkSJbWsMTaBPogF3sMQ0=;
X-UUID: 5e48a1cfac724b3dadee74824d957d0f-20200902
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 951357032; Wed, 02 Sep 2020 14:52:06 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 2 Sep 2020 14:52:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 2 Sep 2020 14:52:04 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <mark-pk.tsai@mediatek.com>, <robh@kernel.org>
CC:     <alix.wu@mediatek.com>, <daniel@0x0f.com>,
        <devicetree@vger.kernel.org>, <jason@lakedaemon.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <maz@kernel.org>, <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <yj.chiang@mediatek.com>
Subject: Re: [PATCH 2/2] dt-bindings: interrupt-controller: Add MStar interrupt controller
Date:   Wed, 2 Sep 2020 14:52:04 +0800
Message-ID: <20200902065205.1971-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200902063344.1852-3-mark-pk.tsai@mediatek.com>
References: <20200902063344.1852-3-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSwNCg0KSSd2ZSB1cGRhdGVkIHRoZSB5YW1sIGFuZCBwb3N0IGl0IGluIHRoZSBwYXRjaCBz
ZXJpZXMgdjNbMV0uDQpCdXQgSSBzdGlsbCBrZWVwIHRoZSB2ZW5kb3Igc3BlY2lmaWMgcHJvcGVy
dHkgbXN0YXIsaXJxcy1tYXAtcmFuZ2UgYXMgSQ0KbWVudGlvbmVkIGluIHRoZSBsYXN0IHJlcGx5
Lg0KUGxlYXNlIHJldmlldyBpdC4NCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwv
MjAyMDA5MDIwNjMzNDQuMTg1Mi0zLW1hcmstcGsudHNhaUBtZWRpYXRlay5jb20v

