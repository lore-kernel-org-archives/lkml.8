Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42EAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A4F620809
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592582280;
	bh=SqyLi8d8xiFLHBec76SFFQfbGYQNGQ0Jb1+ic5vnbfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e7zpzZ3NTtiplv9HS83f5nEchaqyEeR5shWfb2AZbq0iesXXU8/VGab0fWcc+HurU
	 pY/Q/Kb/Cq6w8Hp0viP3gPahGZ8oFhcS3Aec6PsOI/LtAUpGj3vo3Q6uM1fxhzxo/s
	 irKL3OpWKrrk6nPy2XqCQ1i6ossfD2UZ1oDeonbo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404246AbgFSPTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:19:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392578AbgFSPSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:18:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2505721835;
        Fri, 19 Jun 2020 15:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579881;
        bh=SqyLi8d8xiFLHBec76SFFQfbGYQNGQ0Jb1+ic5vnbfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qs9elEb1VUnsTyU1ojXP11+tCjSiQbDzrmVWl6pSpKIgsV/uBn4bRnzgJ2n0k5UHF
         3rCNNxRmhH8ejKjz9L+vHsLC0CMfsJ15CrZM1SQkiheBvaWm3dJvEQ8jpRoCf1Krnm
         NXiN15uQN/IeRivGlRBvsmMTXTa7186De/ZUEKk0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        andriy.shevchenko@linux.intel.com,
        platform-driver-x86@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 039/376] tools/power/x86/intel-speed-select: Fix CLX-N package information output
Date:   Fri, 19 Jun 2020 16:29:17 +0200
Message-Id: <20200619141712.205782477@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prarit Bhargava <prarit@redhat.com>

[ Upstream commit 28c59ae6965ca0626e3150e2f2863e0f0c810ed7 ]

On CLX-N the perf-profile output is missing the package, die, and cpu
output.  On CLX-N the pkg_dev struct will never be evaluated by the core
code so pkg_dev.processed is always 0 and the package, die, and cpu
information is never output.

Set the pkg_dev.processed flag to 1 for CLX-N processors.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: andriy.shevchenko@linux.intel.com
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/x86/intel-speed-select/isst-config.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index b73763489410..3688f1101ec4 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -1169,6 +1169,7 @@ static void dump_clx_n_config_for_cpu(int cpu, void *arg1, void *arg2,
 
 		ctdp_level = &clx_n_pkg_dev.ctdp_level[0];
 		pbf_info = &ctdp_level->pbf_info;
+		clx_n_pkg_dev.processed = 1;
 		isst_ctdp_display_information(cpu, outf, tdp_level, &clx_n_pkg_dev);
 		free_cpu_set(ctdp_level->core_cpumask);
 		free_cpu_set(pbf_info->core_cpumask);
-- 
2.25.1



