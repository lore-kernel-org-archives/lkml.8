Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FE7C54FD2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 02:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB042074D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 02:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585102980;
	bh=U+knP07i54M5HZPZ5NicCCkJhRVYwH39OmNKxW+VlDk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=pAG0x7CKDdRQigThDVn/1hy7fD+kZFRZDCoqYG7Pd79te6TjfcMLAjqDzodKZtzxo
	 O95JrPgVz9kWibjVUyfbmHCSzkC4ERi0GqqnGu+m+TtRnBUmXEUG1Qx2uT/wJpkZcU
	 LueUY0XSCh/oczGil63FBfpoD21IUwF62+6fYxjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgCYCW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 22:22:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727253AbgCYCW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 22:22:59 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E8F32072E;
        Wed, 25 Mar 2020 02:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585102978;
        bh=U+knP07i54M5HZPZ5NicCCkJhRVYwH39OmNKxW+VlDk=;
        h=From:To:Cc:Subject:Date:From;
        b=rvpuwhvGapsq62EQSFXD0+nkfo/fg1qn/Hb/yYiScVUrGB5gx7VD52zLJimTOaILf
         4p5A65OnHbwtkGb89KlmXWSnWM/EovfARf8B1uH/6ub8p8ACmS2xPNS315SRPyIcWr
         zEP3tt3hr8VDtEGkPdSW4wa16RrgQqPm5n/BV0Wk=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH] clk: Pass correct arguments to __clk_hw_register_gate()
Date:   Tue, 24 Mar 2020 19:22:57 -0700
Message-Id: <20200325022257.148244-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I copy/pasted these macros and forgot to update the argument
names and where they're passed to. Fix it so that these macros make
sense.

Reported-by: Maxime Ripard <maxime@cerno.tech>
Fixes: 194efb6e2667 ("clk: gate: Add support for specifying parents via DT/pointers")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 include/linux/clk-provider.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 952ac035bab9..95cc8a4f6e39 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -522,9 +522,9 @@ struct clk *clk_register_gate(struct device *dev, const char *name,
  * @clk_gate_flags: gate-specific flags for this clock
  * @lock: shared register lock for this clock
  */
-#define clk_hw_register_gate_parent_hw(dev, name, parent_name, flags, reg,    \
+#define clk_hw_register_gate_parent_hw(dev, name, parent_hw, flags, reg,      \
 				       bit_idx, clk_gate_flags, lock)	      \
-	__clk_hw_register_gate((dev), NULL, (name), (parent_name), NULL,      \
+	__clk_hw_register_gate((dev), NULL, (name), NULL, (parent_hw),        \
 			       NULL, (flags), (reg), (bit_idx),		      \
 			       (clk_gate_flags), (lock))
 /**
@@ -539,10 +539,10 @@ struct clk *clk_register_gate(struct device *dev, const char *name,
  * @clk_gate_flags: gate-specific flags for this clock
  * @lock: shared register lock for this clock
  */
-#define clk_hw_register_gate_parent_data(dev, name, parent_name, flags, reg,  \
+#define clk_hw_register_gate_parent_data(dev, name, parent_data, flags, reg,  \
 				       bit_idx, clk_gate_flags, lock)	      \
-	__clk_hw_register_gate((dev), NULL, (name), (parent_name), NULL,      \
-			       NULL, (flags), (reg), (bit_idx),		      \
+	__clk_hw_register_gate((dev), NULL, (name), NULL, NULL, (parent_data) \
+			       (flags), (reg), (bit_idx),		      \
 			       (clk_gate_flags), (lock))
 void clk_unregister_gate(struct clk *clk);
 void clk_hw_unregister_gate(struct clk_hw *hw);
-- 
Sent by a computer, using git, on the internet

