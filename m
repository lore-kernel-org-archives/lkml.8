Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1697BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB62220724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592945690;
	bh=gXMGaPjzCQIeju5Hb/u1hZJDt2Bem+pqUM5c4cI8O0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H1lWGwipx65aSOkINC9oENb+DL2JJ2N63e3CBObjK8Mei7aDhmOaVtljgUA2ZMDSr
	 lKixDY4ZQJI1NZjzGT/nVAMTl5hSxJcltP9wkZIvj4/NQ8YPmLy40MbY8pMN+P9yYe
	 FhtUoQRtvLsGSUy72i/7m1KkmEg77/RU/zfuXdmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404104AbgFWUys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:54:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:43230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392651AbgFWUpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:45:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B386E20781;
        Tue, 23 Jun 2020 20:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592945139;
        bh=gXMGaPjzCQIeju5Hb/u1hZJDt2Bem+pqUM5c4cI8O0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GbytVoX+08OuO4ftjWpVNLgS5MhQruSwQYRVnmWEbjqoAIWp18jVEwUMwlOaJeYel
         qI6KqIC+3G4aGfxzhnvv4Z6qDQWyTkiUp3snNl17KmJ25FmKZ3vR+YHEgwNwc5Cu2C
         xvVMq2U+RoQHYBqljzN9lwCtAkSobxr6umMocB3Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 054/136] clk: ti: composite: fix memory leak
Date:   Tue, 23 Jun 2020 21:58:30 +0200
Message-Id: <20200623195306.396249218@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195303.601828702@linuxfoundation.org>
References: <20200623195303.601828702@linuxfoundation.org>
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
index beea89463ca2c..4ea5c08a1eb66 100644
--- a/drivers/clk/ti/composite.c
+++ b/drivers/clk/ti/composite.c
@@ -240,6 +240,7 @@ cleanup:
 		if (!cclk->comp_clks[i])
 			continue;
 		list_del(&cclk->comp_clks[i]->link);
+		kfree(cclk->comp_clks[i]->parent_names);
 		kfree(cclk->comp_clks[i]);
 	}
 
-- 
2.25.1



