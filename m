Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF77C33CB1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 07:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9052087F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 07:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="r59H1ZXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgATHry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 02:47:54 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:7459 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726130AbgATHrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 02:47:52 -0500
X-UUID: 91f1ec16ecb5461794a5a9c265c0e8e4-20200120
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=VOjHatv3U3xNNKFat1fmDIBCP5I8ZbhE5gQiqF6rP2w=;
        b=r59H1ZXxekmZNY5OeHyzdXWDMB08W/kvJ7Fe1nanW1+yJjK1Ze1efpKWOpmrvkMEzVJAdcR3xRPsyN5ANj0B5JuIiSyZuqRtBl7S5fI4d/skY1mHtLrIwjmARJlz+tNUC1MGkI9A01S7D1Z5EFn7KN9Y78KqlGb1VT/MDkx51S0=;
X-UUID: 91f1ec16ecb5461794a5a9c265c0e8e4-20200120
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <wen.su@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1878007573; Mon, 20 Jan 2020 15:47:46 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 20 Jan 2020 15:47:12 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 20 Jan 2020 15:48:39 +0800
From:   Wen Su <Wen.Su@mediatek.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <wsd_upstream@mediatek.com>, <wen.su@mediatek.com>
Subject: [RESEND 0/4] Add Support for MediaTek PMIC MT6359 Regulator
Date:   Mon, 20 Jan 2020 15:47:26 +0800
Message-ID: <1579506450-21830-1-git-send-email-Wen.Su@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaHNldCBhZGQgc3VwcG9ydCB0byBNVDYzNTkgUE1JQyByZWd1bGF0b3IuIE1UNjM1
OSBpcyBwcmltYXJ5DQpQTUlDIGZvciBNVDY3NzkgcGxhdGZvcm0uDQo=

