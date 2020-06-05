Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE57C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99C7020772
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZziRepXD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgFEKf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 06:35:58 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:31171 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726465AbgFEKf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 06:35:57 -0400
X-UUID: 1a82d9ddb32f49f8a64f95d3434ca921-20200605
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=nsUntpG+2ZTGK4HrWe8pIq15nHkMfEaQcUq9M+NOtWk=;
        b=ZziRepXD1Tc2tvW8UgCB9U8mMFj8HAhFyvII54fN0S5EPTBx0ntD9TZ9Jxgc6oMQi+wii8CRsxB8x9POeeJox6t0LZCwazYx5uJYvCREmw543rnnsapfKScKefLEbGZ793KXzKseHNCQ4P3zNQbhhoO7AsDOMFNjqEJ40LFE7XM=;
X-UUID: 1a82d9ddb32f49f8a64f95d3434ca921-20200605
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 158510851; Fri, 05 Jun 2020 18:35:49 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 5 Jun 2020 18:35:46 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 5 Jun 2020 18:35:45 +0800
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
        <matthias.bgg@gmail.com>, <hariprasad.kelam@gmail.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <howie.huang@mediatek.com>,
        <tzungbi@google.com>, Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: [PATCH v2 0/2] ASoC: mediatek: mt6358: support DMIC one-wire mode
Date:   Fri, 5 Jun 2020 18:33:40 +0800
Message-ID: <1591353222-18576-1-git-send-email-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 8183516B6E5D2C2436F93EBC972FC14D6494A6210300ACC0EE968670B2FED9B22000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

djIgY2hhbmdlczoNCgkxLiBVc2VzIGEgRFQgcHJvcGVydHkgdG8gc2VsZWN0IERNSUMgbW9kZSBp
bnN0ZWFkIG9mIGEgbWl4ZXIgY29udHJvbC4NCg0KdjEgY2hhbmdlczoNCgkxLiBVc2VzIGEgbWl4
ZXIgY29udHJvbCB0byBzZWxlY3QgRE1JQyBtb2RlLg0KCTIuIHBhdGNod29yayBsaXN0Og0KCQlo
dHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzExNTc4MzA5DQoNCkppYXhpbiBZdSAo
Mik6DQogIEFTb0M6IG1lZGlhdGVrOiBtdDYzNTg6IHN1cHBvcnQgRE1JQyBvbmUtd2lyZSBtb2Rl
DQogIEFTb0M6IGR0LWJpbmRpbmdzOiBtZWRpYXRlazogbXQ2MzU4OiBhZGQgZG1pYy1tb2RlIHBy
b3BlcnR5DQoNCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc291bmQvbXQ2MzU4
LnR4dCB8ICA2ICsrKysrKw0KIHNvdW5kL3NvYy9jb2RlY3MvbXQ2MzU4LmMgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgMjMgKysrKysrKysrKysrKysrKysrKysrLQ0KIDIgZmlsZXMgY2hhbmdl
ZCwgMjggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQotLSANCjEuOC4xLjEuZGlydHkN
Cg==

