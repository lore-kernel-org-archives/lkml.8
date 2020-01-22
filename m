Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704E5C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3731A24672
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579685479;
	bh=0ooPQTJdsbuy7mDT8DEDH6XQyhlkOcP1COJtU1twRMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IBYhCgtEBCvS+LA+xZ6UcRUcQOGWcK3RWxJ8+CJ2yWJuyvn2etGi0BaYqz7GXgUpJ
	 HYoO9n0FtlHOz2wi6rfN6nesqRC/geyvyeyrGrda2w8dJZ1fk1paVl/E29c/Qw75si
	 pwGV/rOpvuP/IKPmO55viOmzp23xUpPu9JGObhvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbgAVJbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:31:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:43232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729605AbgAVJbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:31:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67C0624673;
        Wed, 22 Jan 2020 09:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685475;
        bh=0ooPQTJdsbuy7mDT8DEDH6XQyhlkOcP1COJtU1twRMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nJafzGhJTTPJQZ8bZnnbJ7OPDT/YSRePHemhJ4pIVmn+pXRbRmR28jDtRD6UsacJe
         FpRMDnEx4V++Bf8S0ciwETwbQKUkZGgLYEEd14P76EjFrQLhCd73Ejohqfl4kZrFW5
         DkhpC2Suj09YlUNcFxyxhVWe+hA6R5c3G+DAW3ZU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marian Mihailescu <mihailescu2m@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 4.4 29/76] clk: samsung: exynos5420: Preserve CPU clocks configuration during suspend/resume
Date:   Wed, 22 Jan 2020 10:28:45 +0100
Message-Id: <20200122092754.738749967@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092751.587775548@linuxfoundation.org>
References: <20200122092751.587775548@linuxfoundation.org>
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
@@ -166,6 +166,8 @@ static unsigned long exynos5x_clk_regs[]
 	GATE_BUS_CPU,
 	GATE_SCLK_CPU,
 	CLKOUT_CMU_CPU,
+	APLL_CON0,
+	KPLL_CON0,
 	CPLL_CON0,
 	DPLL_CON0,
 	EPLL_CON0,


