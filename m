Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F202C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0863E2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944016;
	bh=U5b0UBf7FMEr2zEPspBFgp7gEax7PArlSSw6xZKwkrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OzvPWGEizZMCuy9ZuXVBW2lktPLMRaHoPTruUVIYXeJ+3mu55RiwCxlXH5l0a1qk5
	 3EQJJuo6djGiPKuOC/+QnInzvqKgX6x1Q8TntErKRu6L0w4TCtol1YAcocxuJjar1f
	 psxwJ/mKqxFzYPHbrJPqUvFl/D0PGBIdOFeivKkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390719AbgFWU0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:26:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390705AbgFWU0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:26:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 703462070E;
        Tue, 23 Jun 2020 20:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944009;
        bh=U5b0UBf7FMEr2zEPspBFgp7gEax7PArlSSw6xZKwkrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V9txVXTdrgZJs26N+mW3KSVI0uqWbQOnhs1c8ZxlWSDfnJ2lWUS86ln0Poel30ZKp
         flXiTylvJb1wTxQgB8z5yTsM06rZ4ikw6O90ce4fyKCrfLjm1SZ38f+OOc1cAjMyeO
         dMLQRU9tG7cT2toZYVNuhd0ybL9uTBu+ULV9AM+M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 138/314] clk: ti: composite: fix memory leak
Date:   Tue, 23 Jun 2020 21:55:33 +0200
Message-Id: <20200623195345.451347049@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tero Kristo <t-kristo@ti.com>

[ Upstream commit c7c1cbbc9217ebb5601b88d138d4a5358548de9d ]

The parent_names is never released for a component clock definition,
causing some memory leak. Fix by releasing it once it is no longer
needed.

Reported-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Link: https://lkml.kernel.org/r/20200429131341.4697-2-t-kristo@ti.com
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/ti/composite.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/ti/composite.c b/drivers/clk/ti/composite.c
index 6a89936ba03af..eaa43575cfa5e 100644
--- a/drivers/clk/ti/composite.c
+++ b/drivers/clk/ti/composite.c
@@ -196,6 +196,7 @@ cleanup:
 		if (!cclk->comp_clks[i])
 			continue;
 		list_del(&cclk->comp_clks[i]->link);
+		kfree(cclk->comp_clks[i]->parent_names);
 		kfree(cclk->comp_clks[i]);
 	}
 
-- 
2.25.1



