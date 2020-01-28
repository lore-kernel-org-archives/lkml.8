Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DEFC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713AE2071E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221068;
	bh=6Fz8xjv9nZBw1/1d96jNOMkJO+3yPvlTXHgJXrMglNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gCFwtfE0UXR1BGBZt7w0RUGbfcF3wRUOGhoHW5g40XFmn6Wp0nzVyoMxsexzo9+wm
	 XWGUrGwdrukNOtLuPrtk2e2HXP24KBFh5Sv4LPJMCDL4qlk2afKoBpJiC4lUu9jLms
	 kmMDs4heMntSOcpa9kIAi/EjXJs1dEYPJ4vXlDqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbgA1ORr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:17:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:41512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730314AbgA1ORm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:17:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B85E62071E;
        Tue, 28 Jan 2020 14:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221062;
        bh=6Fz8xjv9nZBw1/1d96jNOMkJO+3yPvlTXHgJXrMglNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LGGKhPHsA0/Z1nQaj7gELFyj1P62phJOVdfkVyIlwQCds6NY8ZfVl//t9jWSzouoa
         f4+3+p7h7YbYRWWeyJR9tAsY24DvZhQUpUXNH0w4pCTC4JPsTHTo9oH+SFEs0csCLz
         Jcv+bWW7MLcJy6tqAWmc45ZKG+FEi1n7Uz3+q9wc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 036/271] clk: armada-xp: fix refcount leak in axp_clk_init()
Date:   Tue, 28 Jan 2020 15:03:05 +0100
Message-Id: <20200128135855.365455374@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

[ Upstream commit db20a90a4b6745dad62753f8bd2f66afdd5abc84 ]

The of_find_compatible_node() returns a node pointer with refcount
incremented, but there is the lack of use of the of_node_put() when
done. Add the missing of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Fixes: 0a11a6ae9437 ("clk: mvebu: armada-xp: maintain clock init order")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/mvebu/armada-xp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mvebu/armada-xp.c b/drivers/clk/mvebu/armada-xp.c
index b3094315a3c0f..2fa15a2747190 100644
--- a/drivers/clk/mvebu/armada-xp.c
+++ b/drivers/clk/mvebu/armada-xp.c
@@ -202,7 +202,9 @@ static void __init axp_clk_init(struct device_node *np)
 
 	mvebu_coreclk_setup(np, &axp_coreclks);
 
-	if (cgnp)
+	if (cgnp) {
 		mvebu_clk_gating_setup(cgnp, axp_gating_desc);
+		of_node_put(cgnp);
+	}
 }
 CLK_OF_DECLARE(axp_clk, "marvell,armada-xp-core-clock", axp_clk_init);
-- 
2.20.1



