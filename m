Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015E8C18E5C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD85C20873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZYD4YF5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbgCKNlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 09:41:23 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:50052 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729345AbgCKNlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 09:41:23 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DB0DEC0F5D;
        Wed, 11 Mar 2020 13:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1583934082; bh=oVoyuxIlBGz3ZShXiT6O9EPX9Q5VwDgjwocJvAJsmOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZYD4YF5cLLSo+ccTWIM3l0tY8uM/wWCLMfsJuXR3xfoe6eMkLoogmF/Y/0KjYL8kj
         UVWXmhUqyzfx4heWCJh2u4Fy8Sggw1B5qGLn0gdyCY9OPv+2k1KbQOH7U/+xVRmV0v
         rmRxNvvLIOfZ+9TnOlXv4JA27alQEOBHat0foH7LElM8gyl894GlB5p1BEzF4TDCeN
         lRVophBUcECKK7On7UNnJEQyRsCzks0XVVzo6y1w/Ig/564Jil/m0JGXX+PtGwkTzk
         Rrjpi09FircFZBecTj7XctuhRc4yKhHc8KjaA29qDYCJr9eRsjjP9oTucSglWiP6ei
         4wxXOcrAqDKBw==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.79])
        by mailhost.synopsys.com (Postfix) with ESMTP id 9D0C9A0064;
        Wed, 11 Mar 2020 13:41:19 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 3/3] CLK: HSDK: CGU: add support for 148.5MHz clock
Date:   Wed, 11 Mar 2020 16:41:15 +0300
Message-Id: <20200311134115.13257-4-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200311134115.13257-1-Eugeniy.Paltsev@synopsys.com>
References: <20200311134115.13257-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for 148.5MHz clock for HDMI PLL

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 drivers/clk/clk-hsdk-pll.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-hsdk-pll.c b/drivers/clk/clk-hsdk-pll.c
index 0ea7af57a5b1..b4f8852201cb 100644
--- a/drivers/clk/clk-hsdk-pll.c
+++ b/drivers/clk/clk-hsdk-pll.c
@@ -81,6 +81,7 @@ static const struct hsdk_pll_cfg asdt_pll_cfg[] = {
 
 static const struct hsdk_pll_cfg hdmi_pll_cfg[] = {
 	{ 27000000,   0, 0,  0, 0, 1 },
+	{ 148500000,  0, 21, 3, 0, 0 },
 	{ 297000000,  0, 21, 2, 0, 0 },
 	{ 540000000,  0, 19, 1, 0, 0 },
 	{ 594000000,  0, 21, 1, 0, 0 },
-- 
2.21.1

