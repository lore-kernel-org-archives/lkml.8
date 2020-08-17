Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C1FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64C7220658
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597693901;
	bh=76s7D4MfERblX/4AMHImA7rzFqIClB7ILCfxPsJZtjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gWXm7JA5m4WdaW86VnJHa5d/lpafHXHwWy2QbhR1zw4H7awBzurGscFoAZKrD5yKP
	 AHJ99PD976lh9L0xzL6MOlFHXJ8ypDTHJSLL4t5humCmcKEY2XBe9ETXudDWQ5Zecv
	 r53gKnsii/BLQwF4fm5eFvejJ+/+9AECzR1+GFjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404459AbgHQTvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:51:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729126AbgHQPSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:18:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7312E20709;
        Mon, 17 Aug 2020 15:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597677514;
        bh=76s7D4MfERblX/4AMHImA7rzFqIClB7ILCfxPsJZtjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=snLMlLpcAzDonh+fgvEw1EK0SA/tpR5ZD/GUcyowmelDqA1CakTKp7tw83FZ3hZRv
         ncxIRECNzP0hjjIWl8gGxga6HzlVLNeH3hQdO/ztjJzjqTNMrUoWIWKSou/UEdGo5E
         V28jGfwlmfNp5XAC8ZlA7a42vqqnwWR8q7RNfcyI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 011/464] x86, sched: Bail out of frequency invariance if turbo_freq/base_freq gives 0
Date:   Mon, 17 Aug 2020 17:09:24 +0200
Message-Id: <20200817143834.296104724@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Giovanni Gherdovich <ggherdovich@suse.cz>

[ Upstream commit f4291df103315a696f0b8c4f45ca8ae773c17441 ]

Be defensive against the case where the processor reports a base_freq
larger than turbo_freq (the ratio would be zero).

Fixes: 1567c3e3467c ("x86, sched: Add support for frequency invariance")
Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lkml.kernel.org/r/20200531182453.15254-4-ggherdovich@suse.cz
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/smpboot.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 20e1cea262e4b..518ac6bf752e0 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1977,6 +1977,7 @@ static bool core_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
 static bool intel_set_max_freq_ratio(void)
 {
 	u64 base_freq, turbo_freq;
+	u64 turbo_ratio;
 
 	if (slv_set_max_freq_ratio(&base_freq, &turbo_freq))
 		goto out;
@@ -2010,9 +2011,15 @@ static bool intel_set_max_freq_ratio(void)
 		return false;
 	}
 
-	arch_turbo_freq_ratio = div_u64(turbo_freq * SCHED_CAPACITY_SCALE,
-					base_freq);
+	turbo_ratio = div_u64(turbo_freq * SCHED_CAPACITY_SCALE, base_freq);
+	if (!turbo_ratio) {
+		pr_debug("Non-zero turbo and base frequencies led to a 0 ratio.\n");
+		return false;
+	}
+
+	arch_turbo_freq_ratio = turbo_ratio;
 	arch_set_max_freq_ratio(turbo_disabled());
+
 	return true;
 }
 
-- 
2.25.1



