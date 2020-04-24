Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C44BC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48D8520736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587731553;
	bh=l0ZRuARmG39itY8Gk3NXDFg74u0GGjLdxKk76vOkrOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QrIE6ug9oOdJtp7jRqOvoTpcMA9HYWLOWDZ7Ze3uPFlW1VPHbCQ3uR5Ny7DLjmgea
	 0SKqQC48BXxMl66BHP9lTsjJgmJ/YmPYvQtWZn9mo2Dw6gT8VzW9s6WjNzxovmRumP
	 EhHzvK574OMiU1xu5ZHtOtFrpr833uEpP2+DxwvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgDXMcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:32:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:52284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727125AbgDXMW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:22:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 547BF21582;
        Fri, 24 Apr 2020 12:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587730977;
        bh=l0ZRuARmG39itY8Gk3NXDFg74u0GGjLdxKk76vOkrOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ge8KogarkkOTxEfqmoJAKxRcZDmFBOxdJpbGAmnidNmvfcTLQ+zHLcEAX6H6jWZN/
         qk7dZ3ONe6EjFJcUmGBErK0Fk4aJmbbFzpWznQ6jEQibr/ovSS1xUWB3ozefTwfbwp
         UO9je6TORIb8pLmVLROMCegEEZ8tlfsjpNWilq5Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 17/38] clk: asm9260: fix __clk_hw_register_fixed_rate_with_accuracy typo
Date:   Fri, 24 Apr 2020 08:22:15 -0400
Message-Id: <20200424122237.9831-17-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424122237.9831-1-sashal@kernel.org>
References: <20200424122237.9831-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 924ed1f5c181132897c5928af7f3afd28792889c ]

The __clk_hw_register_fixed_rate_with_accuracy() function (with two '_')
does not exist, and apparently never did:

drivers/clk/clk-asm9260.c: In function 'asm9260_acc_init':
drivers/clk/clk-asm9260.c:279:7: error: implicit declaration of function '__clk_hw_register_fixed_rate_with_accuracy'; did you mean 'clk_hw_register_fixed_rate_with_accuracy'? [-Werror=implicit-function-declaration]
  279 |  hw = __clk_hw_register_fixed_rate_with_accuracy(NULL, NULL, pll_clk,
      |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |       clk_hw_register_fixed_rate_with_accuracy
drivers/clk/clk-asm9260.c:279:5: error: assignment to 'struct clk_hw *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
  279 |  hw = __clk_hw_register_fixed_rate_with_accuracy(NULL, NULL, pll_clk,
      |     ^

From what I can tell, __clk_hw_register_fixed_rate() is the correct
API here, so use that instead.

Fixes: 728e3096741a ("clk: asm9260: Use parent accuracy in fixed rate clk")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lkml.kernel.org/r/20200408155402.2138446-1-arnd@arndb.de
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk-asm9260.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-asm9260.c b/drivers/clk/clk-asm9260.c
index 536b59aabd2cb..bacebd457e6f3 100644
--- a/drivers/clk/clk-asm9260.c
+++ b/drivers/clk/clk-asm9260.c
@@ -276,7 +276,7 @@ static void __init asm9260_acc_init(struct device_node *np)
 
 	/* TODO: Convert to DT parent scheme */
 	ref_clk = of_clk_get_parent_name(np, 0);
-	hw = __clk_hw_register_fixed_rate_with_accuracy(NULL, NULL, pll_clk,
+	hw = __clk_hw_register_fixed_rate(NULL, NULL, pll_clk,
 			ref_clk, NULL, NULL, 0, rate, 0,
 			CLK_FIXED_RATE_PARENT_ACCURACY);
 
-- 
2.20.1

