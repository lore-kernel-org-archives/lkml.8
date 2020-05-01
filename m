Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E295DC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD71F2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340560;
	bh=DAkD6Py2r/Q89a1dv8TwLCySnyJebQY3iz7j5csUrug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g3OC7L9ujdeGAe9Ok1qacNZGBHwIRlBL5yTbNfDrr3o4QzXpsfid6qRxgO9h2Eony
	 kfTgTW6Rw6STNNTeAQ6zFh1zb7c29IYOdveIJLVNZN58phV5i+sJIEoJI3WE04sG4s
	 +JrWtG6CCV6Ro6naGEoCv6bGp8EGpjqJ8mo/Ofyk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbgEANmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:42:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730996AbgEANmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:42:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B822924956;
        Fri,  1 May 2020 13:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340556;
        bh=DAkD6Py2r/Q89a1dv8TwLCySnyJebQY3iz7j5csUrug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q18VaixzNhdiPk7bHWeNTctSjsyspKtk+4pzCpu3HVhlMRiQQ0/8O334WgFyBlQAM
         UKRbrvmREpZtzCyHb6VcROcpC2Y/TGZuqEXCgUGk3wScboDjfzRh4B1ws3iM34eDqp
         DcCI+eJZCuknNSwIJgVq2tSM75vZ0JYxUEzdMMfA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 5.6 030/106] clk: asm9260: fix __clk_hw_register_fixed_rate_with_accuracy typo
Date:   Fri,  1 May 2020 15:23:03 +0200
Message-Id: <20200501131547.604417051@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131543.421333643@linuxfoundation.org>
References: <20200501131543.421333643@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

commit 924ed1f5c181132897c5928af7f3afd28792889c upstream.

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

>From what I can tell, __clk_hw_register_fixed_rate() is the correct
API here, so use that instead.

Fixes: 728e3096741a ("clk: asm9260: Use parent accuracy in fixed rate clk")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lkml.kernel.org/r/20200408155402.2138446-1-arnd@arndb.de
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/clk-asm9260.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/clk-asm9260.c
+++ b/drivers/clk/clk-asm9260.c
@@ -276,7 +276,7 @@ static void __init asm9260_acc_init(stru
 
 	/* TODO: Convert to DT parent scheme */
 	ref_clk = of_clk_get_parent_name(np, 0);
-	hw = __clk_hw_register_fixed_rate_with_accuracy(NULL, NULL, pll_clk,
+	hw = __clk_hw_register_fixed_rate(NULL, NULL, pll_clk,
 			ref_clk, NULL, NULL, 0, rate, 0,
 			CLK_FIXED_RATE_PARENT_ACCURACY);
 


