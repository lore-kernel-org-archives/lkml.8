Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26073C35669
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E629520659
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582425448;
	bh=F0bnm1NLtK71H1aDOAoi9ykCnmiTb2Z+2jqTPWmo9bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=17hb4m9DNwmzD75O/K7JckQTSbZFdKjnDgZyS1P0SB7+ypfcdc16UtU939XX/J9oO
	 90iOUVFwg2h6IlwEWD4M4iLP6Yuf4eYIhHdIgn7vGHjsP/8/R+3fhLROOw536TXIFD
	 zuWbzZoOWEz+m0IA42aP8+97+dzRlEc8F4fedPPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgBWCh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 21:37:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:50102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727636AbgBWCVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:21:41 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F57C21D56;
        Sun, 23 Feb 2020 02:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582424500;
        bh=F0bnm1NLtK71H1aDOAoi9ykCnmiTb2Z+2jqTPWmo9bk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zb/GIV0qvTFF77+R9DpuQmz57J5n6RPBe1zDxAkzb8cXS/GMeZAPhXta8r9mc1SCA
         dr1bwD/irlH+xzp1HDXEXb/5q7Gp2yrBcVqd7howA3zDLr6bG3OvYCI+3wjEQDz+vJ
         coUBbgWlqooTmaPfJkWJ+b9a+mhRcWK5iSfMyFT0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.5 17/58] perf/x86/intel: Add Elkhart Lake support
Date:   Sat, 22 Feb 2020 21:20:38 -0500
Message-Id: <20200223022119.707-17-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200223022119.707-1-sashal@kernel.org>
References: <20200223022119.707-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

[ Upstream commit eda23b387f6c4bb2971ac7e874a09913f533b22c ]

Elkhart Lake also uses Tremont CPU. From the perspective of Intel PMU,
there is nothing changed compared with Jacobsville.
Share the perf code with Jacobsville.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/1580236279-35492-1-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/intel/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 3be51aa06e67e..dff6623804c28 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4765,6 +4765,7 @@ __init int intel_pmu_init(void)
 		break;
 
 	case INTEL_FAM6_ATOM_TREMONT_D:
+	case INTEL_FAM6_ATOM_TREMONT:
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, glp_hw_cache_event_ids,
 		       sizeof(hw_cache_event_ids));
-- 
2.20.1

