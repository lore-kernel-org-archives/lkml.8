Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A03C3524C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 05:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90ABC207E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 05:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580707510;
	bh=Qj0A4dBg2+EbgvzsZzt/fI+ruX6asrU4O34elgEepAo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=wndBNVk4LoKWU/uPTMFYsWBCw16NBMpXGzRGg77Ch/ntuxhghzS25qqRA/SWQqShQ
	 l80479P7vz/URyaoJPPJlgqRz9P4Hefdc/fICgAxKd8gNFn946SsQKjTbSrEiJm9vn
	 Q6Y11ChOODTIinTf5P2zFgSA6bZnGogsjEGxXyXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgBCFZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 00:25:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:52420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgBCFZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 00:25:09 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8170120721;
        Mon,  3 Feb 2020 05:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580707508;
        bh=Qj0A4dBg2+EbgvzsZzt/fI+ruX6asrU4O34elgEepAo=;
        h=From:To:Cc:Subject:Date:From;
        b=CJ1uqYB64VAtVTJqDtqDCL137PkwcqiMg6jTAzrWjF7psLETQhIEmoO8pVqiuJB2g
         hMaUpmKpOzcpwOGr7XZ5UYtPIarqx3xDn0pOZMvZLpbnYyQuJtLaqwiUNE7kfzMG93
         SSBT2RSlR5J/ZHHWyXDDDnoCVGYur6lIr/P4VGHk=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wen He <wen.he_1@nxp.com>
Subject: [PATCH 1/2] clk: ls1028a: Fix warning on clamp() usage
Date:   Sun,  2 Feb 2020 21:25:06 -0800
Message-Id: <20200203052507.93215-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These constants are used in clamp() with the value being clamped an
unsigned long. Make them unsigned long defines so that clamp() doesn't
complain about comparing different types.

In file included from include/linux/list.h:9,
                 from include/linux/kobject.h:19,
                 from include/linux/of.h:17,
                 from include/linux/clk-provider.h:9,
                 from drivers/clk/clk-plldig.c:8:
drivers/clk/clk-plldig.c: In function 'plldig_determine_rate':
include/linux/kernel.h:835:29: warning: comparison of distinct pointer types lacks a cast
  835 |   (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
      |

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Wen He <wen.he_1@nxp.com>
Fixes: d37010a3c162 ("clk: ls1028a: Add clock driver for Display output interface")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk-plldig.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-plldig.c b/drivers/clk/clk-plldig.c
index a5da08f98d01..312b8312d503 100644
--- a/drivers/clk/clk-plldig.c
+++ b/drivers/clk/clk-plldig.c
@@ -37,8 +37,8 @@
 #define PLLDIG_MAX_VCO_FREQ         1300000000
 
 /* Range of the output frequencies, in Hz */
-#define PHI1_MIN_FREQ               27000000
-#define PHI1_MAX_FREQ               600000000
+#define PHI1_MIN_FREQ               27000000UL
+#define PHI1_MAX_FREQ               600000000UL
 
 /* Maximum value of the reduced frequency divider */
 #define MAX_RFDPHI1          63UL
-- 
Sent by a computer, using git, on the internet

