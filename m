Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D338DC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 977C220661
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217723;
	bh=81KNmZ9DMcJBn4j49ZbLc7k8abGhSloqgZBSa4l0Wp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TIxpvVxR/uCRjT0HcfBSs/5T81i9ahdxoC3uOO7Cx8RX8XrVipcIf1D+TmxnncKL4
	 dPw5bbuau1hpkIuOaSPpB8lHZmukjZpS2A/l6quJ4FACfGvHtmg+JbNItTavS2fJOV
	 qZaPrnUTofiNoEZafdNojPbvz6/IVBtwEa8+CEZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404087AbgAPXc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:32:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:41678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403799AbgAPXcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:32:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D847020684;
        Thu, 16 Jan 2020 23:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217541;
        bh=81KNmZ9DMcJBn4j49ZbLc7k8abGhSloqgZBSa4l0Wp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mXY2g8ztMjkHfttt3pZ/ULMMlv+E5smkE1fPAdiHOTVFMIDcCVYdkfztxUWSMoDb3
         iI8xaOOj9ZdUh70R2T8/ESEczpMdf70WqYJfagmeWs4BUUuhdqPcdjKh3c/d+909VQ
         b1HeorZCTBuoddnTPkWqh6NKaFcS04pBwku+k/gM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marian Mihailescu <mihailescu2m@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 4.14 41/71] clk: samsung: exynos5420: Preserve CPU clocks configuration during suspend/resume
Date:   Fri, 17 Jan 2020 00:18:39 +0100
Message-Id: <20200116231715.455460576@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231709.377772748@linuxfoundation.org>
References: <20200116231709.377772748@linuxfoundation.org>
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
@@ -170,6 +170,8 @@ static const unsigned long exynos5x_clk_
 	GATE_BUS_CPU,
 	GATE_SCLK_CPU,
 	CLKOUT_CMU_CPU,
+	APLL_CON0,
+	KPLL_CON0,
 	CPLL_CON0,
 	DPLL_CON0,
 	EPLL_CON0,


