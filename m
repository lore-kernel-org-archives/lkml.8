Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311D4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECDA024685
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220504;
	bh=45d2iO0H2cOy137iGO3K3lbg8WV9KCUgEqKusADk4l0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WcxnvZk30LpYbACa8kdgLoHF31rv+D0CyaYkGZCwjY3z22HSNPUdfnBV97cWRTtDM
	 UZPL9NrroA/1ggfLwsYrCB8dV9lsqEVZkL+9pdP6UaZRMfELSq50EoYLHlsH7KFPSV
	 +1J4eL/7e+xwspcmXB79pSXJQEEk2ywfgwq9GVP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgA1OIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:08:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:56326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbgA1OIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:08:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8B4422522;
        Tue, 28 Jan 2020 14:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220499;
        bh=45d2iO0H2cOy137iGO3K3lbg8WV9KCUgEqKusADk4l0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LqWFJK02qAlA9sKWy9Enw6Dbk0oFw/suGHoDyvcG/S1OXO7wEGc5SDFrwvrsRI1Gk
         z3INl8XWurCgpV4J/i8tUWj1+09WsjukaEPk4L2/fVzcLO172+unnDboTlOLYsr2bK
         0/4TBCYVONEiXeBvZ+HGVEtKkB5MmUSUGBvGTBm4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 030/183] clk: kirkwood: fix refcount leak in kirkwood_clk_init()
Date:   Tue, 28 Jan 2020 15:04:09 +0100
Message-Id: <20200128135833.037000115@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135829.486060649@linuxfoundation.org>
References: <20200128135829.486060649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

[ Upstream commit e7beeab9c61591cd0e690d8733d534c3f4278ff8 ]

The of_find_compatible_node() returns a node pointer with refcount
incremented, but there is the lack of use of the of_node_put() when
done. Add the missing of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Fixes: 58d516ae95cb ("clk: mvebu: kirkwood: maintain clock init order")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/mvebu/kirkwood.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/mvebu/kirkwood.c b/drivers/clk/mvebu/kirkwood.c
index 99550f25975ea..1d2b9a1a96094 100644
--- a/drivers/clk/mvebu/kirkwood.c
+++ b/drivers/clk/mvebu/kirkwood.c
@@ -335,6 +335,8 @@ static void __init kirkwood_clk_init(struct device_node *np)
 	if (cgnp) {
 		mvebu_clk_gating_setup(cgnp, kirkwood_gating_desc);
 		kirkwood_clk_muxing_setup(cgnp, kirkwood_mux_desc);
+
+		of_node_put(cgnp);
 	}
 }
 CLK_OF_DECLARE(kirkwood_clk, "marvell,kirkwood-core-clock",
-- 
2.20.1



