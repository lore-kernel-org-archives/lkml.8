Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69179C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4CF214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217023;
	bh=wOWp9MgWg9YkFkHNl2ETiM5sFaQrBjkSp/k2yidDicg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eP5b0x9mUDvlBUY58k1xgbUGg7tjELb7KFaTXIwsFjo6zLHzF+FDX2sEGgtj21wkf
	 BS0lOw30j25XcXSPpGIrdY/xPO6SC2rQhNy1o+XV1K6YOqm3JhZ7PYUvHBde/Fmnsq
	 ALZmra9Hfn/b7CJNnbPIY2PgjUIFK3HBYMGt0iJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391028AbgAPXXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:23:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:52050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391044AbgAPXXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:23:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 664012072B;
        Thu, 16 Jan 2020 23:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217015;
        bh=wOWp9MgWg9YkFkHNl2ETiM5sFaQrBjkSp/k2yidDicg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DAwnM0APNyY3MXlEfwRXrGKS65V//VdKq0bSv6LDSZxyq8DSg8x6Lt11S+oYJuFri
         /lq99bcJYjdQZslCJYOsjNDd8LtDBuv+Q4lSMINagI1ikQJSmxschhBob47hBZ/NKU
         kpHJXCnwSXw/Oy12iyn/RKEuoCeKdJkyT2iH7l0M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marian Mihailescu <mihailescu2m@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 5.4 113/203] clk: samsung: exynos5420: Preserve CPU clocks configuration during suspend/resume
Date:   Fri, 17 Jan 2020 00:17:10 +0100
Message-Id: <20200116231755.324704601@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marian Mihailescu <mihailescu2m@gmail.com>

commit e21be0d1d7bd7f78a77613f6bcb6965e72b22fc1 upstream.

Save and restore top PLL related configuration registers for big (APLL)
and LITTLE (KPLL) cores during suspend/resume cycle. So far, CPU clocks
were reset to default values after suspend/resume cycle and performance
after system resume was affected when performance governor has been selected.

Fixes: 773424326b51 ("clk: samsung: exynos5420: add more registers to restore list")
Signed-off-by: Marian Mihailescu <mihailescu2m@gmail.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/samsung/clk-exynos5420.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -165,6 +165,8 @@ static const unsigned long exynos5x_clk_
 	GATE_BUS_CPU,
 	GATE_SCLK_CPU,
 	CLKOUT_CMU_CPU,
+	APLL_CON0,
+	KPLL_CON0,
 	CPLL_CON0,
 	DPLL_CON0,
 	EPLL_CON0,


