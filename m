Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D77C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A47762076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587552217;
	bh=uHb5jBjIoswJZxzBsYgMUJiHR8BPe/xFo1UMnp0/+P8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B1y3KSt3S4zmUVECKvHKplSB5nlrmqVvk3KKGZYfz01QZ+iFPQtDtdmldRAqRUOUw
	 8x3Yoz2037dShhS3G8HjpmS45LuOUpVyaWK/adSASxLTmX8e/l9OLKGaeSnqRS1Hp6
	 eRki37gbwablzgOZWKUAOqd1dzIscz6yVJH74OPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbgDVKnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:43:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730061AbgDVKTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:19:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F1532070B;
        Wed, 22 Apr 2020 10:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550771;
        bh=uHb5jBjIoswJZxzBsYgMUJiHR8BPe/xFo1UMnp0/+P8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dis/rKoLDvhZ4GnYG9AC1gtl9Sfs53NNKZcoIMJrsK36E4J+B2Azhp0kxM1t8Jxw3
         ETdhRdBwvtOBoNS5x8m2gwGyskrRqyMo9OI1Gnf6SbYXleJwaVn4dgUoIZwJqmvBAn
         NxlMFJQdyFrXQkTbnr8TToTBwyHxmpTEyJj2i5XE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 043/118] clk: tegra: Fix Tegra PMC clock out parents
Date:   Wed, 22 Apr 2020 11:56:44 +0200
Message-Id: <20200422095039.000635183@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095031.522502705@linuxfoundation.org>
References: <20200422095031.522502705@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sowjanya Komatineni <skomatineni@nvidia.com>

[ Upstream commit 6fe38aa8cac3a5db38154331742835a4d9740788 ]

Tegra PMC clocks clk_out_1, clk_out_2, and clk_out_3 supported parents
are osc, osc_div2, osc_div4 and extern clock.

Clock driver is using incorrect parents clk_m, clk_m_div2, clk_m_div4
for PMC clocks.

This patch fixes this.

Tested-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/tegra/clk-tegra-pmc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra-pmc.c b/drivers/clk/tegra/clk-tegra-pmc.c
index bec3e008335f3..5e044ba1ae364 100644
--- a/drivers/clk/tegra/clk-tegra-pmc.c
+++ b/drivers/clk/tegra/clk-tegra-pmc.c
@@ -49,16 +49,16 @@ struct pmc_clk_init_data {
 
 static DEFINE_SPINLOCK(clk_out_lock);
 
-static const char *clk_out1_parents[] = { "clk_m", "clk_m_div2",
-	"clk_m_div4", "extern1",
+static const char *clk_out1_parents[] = { "osc", "osc_div2",
+	"osc_div4", "extern1",
 };
 
-static const char *clk_out2_parents[] = { "clk_m", "clk_m_div2",
-	"clk_m_div4", "extern2",
+static const char *clk_out2_parents[] = { "osc", "osc_div2",
+	"osc_div4", "extern2",
 };
 
-static const char *clk_out3_parents[] = { "clk_m", "clk_m_div2",
-	"clk_m_div4", "extern3",
+static const char *clk_out3_parents[] = { "osc", "osc_div2",
+	"osc_div4", "extern3",
 };
 
 static struct pmc_clk_init_data pmc_clks[] = {
-- 
2.20.1



