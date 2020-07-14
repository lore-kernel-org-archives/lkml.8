Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8080C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C2DA22B2B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752716;
	bh=PtD6kzJHepOAdrv/PmWvzqv98Ct/bG4qvEQTAwnaIM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KjjdOk56OWRUbLvhPkJEDdRpUfRS8LI0d+sFiQ7BrHPtC9i7MtrRcUOfXfuNJVAP9
	 cyZCTIG3x0gAj1wAfOEBESoJQ/VnSe9nJOLDCzECMgD1/t+9IbX7eV2efiT73enrxa
	 9/3iwLfJAiZjTiZePPdY4nGSWN80sDuqR3aUd31o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgGNSvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:51:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730438AbgGNSvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:51:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5320C22B47;
        Tue, 14 Jul 2020 18:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752710;
        bh=PtD6kzJHepOAdrv/PmWvzqv98Ct/bG4qvEQTAwnaIM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=krxwT34G2Mrq9BTWY6rHhSb4L5P4GKUASredrODBjjBYDar/Dwz4sosyPFpCfvqo4
         fE3HTBBBmN+S/CUcLqKWA/ExD967tonS+wpDiSCTwCGWNpH4EuSgzbE6/kLop1uTgf
         q/nb6aGX3T0aa9BFWtgCcWk1RBa9yoiw0VL+3KlE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Luwei Kang <luwei.kang@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 050/109] perf intel-pt: Fix PEBS sample for XMM registers
Date:   Tue, 14 Jul 2020 20:43:53 +0200
Message-Id: <20200714184107.917340584@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184105.507384017@linuxfoundation.org>
References: <20200714184105.507384017@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit 4c95ad261cfac120dd66238fcae222766754c219 ]

The condition to add XMM registers was missing, the regs array needed to
be in the outer scope, and the size of the regs array was too small.

Fixes: 143d34a6b387b ("perf intel-pt: Add XMM registers to synthesized PEBS sample")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Luwei Kang <luwei.kang@intel.com>
Link: http://lore.kernel.org/lkml/20200630133935.11150-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/intel-pt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index a1c9eb6d4f40d..c5cce3a60476b 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1707,6 +1707,7 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 	u64 sample_type = evsel->core.attr.sample_type;
 	u64 id = evsel->core.id[0];
 	u8 cpumode;
+	u64 regs[8 * sizeof(sample.intr_regs.mask)];
 
 	if (intel_pt_skip_event(pt))
 		return 0;
@@ -1756,8 +1757,8 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 	}
 
 	if (sample_type & PERF_SAMPLE_REGS_INTR &&
-	    items->mask[INTEL_PT_GP_REGS_POS]) {
-		u64 regs[sizeof(sample.intr_regs.mask)];
+	    (items->mask[INTEL_PT_GP_REGS_POS] ||
+	     items->mask[INTEL_PT_XMM_POS])) {
 		u64 regs_mask = evsel->core.attr.sample_regs_intr;
 		u64 *pos;
 
-- 
2.25.1



