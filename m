Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEBCC2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41937206F5
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbgDHPyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:54:08 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:49277 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729566AbgDHPyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:54:07 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MXYEr-1jns7o1mmd-00YvPf; Wed, 08 Apr 2020 17:54:03 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: asm9260: fix __clk_hw_register_fixed_rate_with_accuracy typo
Date:   Wed,  8 Apr 2020 17:53:43 +0200
Message-Id: <20200408155402.2138446-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TilCS4/VbuvG1KlVdP8CC9XcCXl56DTAeZrXFyWtCRJQJbt3WQY
 vL1y7YQYEAAEDItmxZwDm1hXg0BmmuqZRGqZ4m8wZ5SK0YYxn9p/oQc8ChpBQEsm0NTEpht
 UGK5R7q3GcdWN6iNhlwUrBMzGBCYmY34XVELclaI0VWqLnD10cpoxJvsIhIHVTXl7VVZSJC
 EvMK3h9sJ8jqoLMGHsRmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oBHlDLZYRwo=:dNKCojhrR5uxAPhnQyNh0S
 5Vet3C2JOoi9r5zsd+vx8DicDLfqbkS1NUR0I7NMIWz6yagR1dWAbOZVJ6Lg8koGbQCHc34EU
 VcehZAHy1RucDAPRs+i7KVUtiPME6o2w6sgasZWA7mMznt3/gEROYbguGHMXVE7yVspnEjbX1
 UZc1kexz1lYuN0dwDEulAfq/H2Ceknc8XW7aGeRkX7WmTTn/L/znhNA4Gpr/Jf9jgWODLUM1v
 0ew9uvvy2WV5WAhADSd7GMPdZYEUByx9yem32RKeYp3A9M4hFuuQ/rKhJXhe7Ch1/MGSwqGcb
 ea2hAKsEjLG3NnkYrUqUqtmURl9DCxvPhS5lpVnPP/8o3FhagjSgEi/2LCTignL+fOEo8NVZw
 UqH7TJPHesiMO4a060dqTatQp0c2OFEt5c0labJqWKXqdUxj4UUt7h//e+o1zYnZLXhBw9OE1
 8A02Vh3KHqP5qKFDJFsIJ0vFGAO5Mwt6J3IT57lBgbAbScBAAHZCghgl4/ipi6iPEYxN/XRXj
 qsDteNiDDDMdF0RPtDiJgOdDOvmSCKk/mHvvHTnUZK9QXr2K1JZtXZVw0QVV8suYswqRhrfX+
 94ZB25cbszWZ8VkS1hB28bm5O0wkpfgBZDCvGR6CkZ6S7NiNUDFD8IL/qKtD5klpew5oeo4/T
 z83euCQOUov2rUyYpzmAxUxWnSKTJqMYsLFFvy+Uie9pdFzXZBf0szyx8JZIb70Q0+srnv8EZ
 pD+Ii+lOtvDIG5EZKg8jKGONIdQzvEtRt/qzGYEdLl+MBlltTIHqXPWgRgpIBOzQwinUL/FxR
 wYKFNaBLxR33rI5/X0w04H+zaYg78DiXMjqhZGkdPvlEOdo6Go=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/clk/clk-asm9260.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-asm9260.c b/drivers/clk/clk-asm9260.c
index 536b59aabd2c..bacebd457e6f 100644
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
2.26.0

