Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A6CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78F37204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594135998;
	bh=2b7zMVe6mmI61iDQvqn+sLJjzEjTT4Vn1x0St9mH+Pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=buzoBl+1Bg5U51C++U7UrVVnUGnqA0fnVsQo7L29hmin6qR/Wla84TNBAYHd72RbU
	 yt990FInvdKsc3B7o0pAy9kUXiIGSdZInVMitYNd9cBGn+/KC6rMJ8oQSxr3kEaP24
	 4sMEXC/T8W7It+YDTzDWSWG7JsdA/YtCbT6sF6Vw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbgGGPdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:33:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:32888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729609AbgGGPUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:20:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A8A3206E2;
        Tue,  7 Jul 2020 15:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594135253;
        bh=2b7zMVe6mmI61iDQvqn+sLJjzEjTT4Vn1x0St9mH+Pk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EcWrcutZWRK1y0Cfc4JnMqDD6915iioeD6ZtnirJ4y71NvLQ8knBRj2PjZVwnESBB
         Px0dzbieH6RtW+FwdmJA1ni2za78zXD0bd7Q4AjF06FZE14QGstp5C2cmFanGVwvoi
         GHZyhbD6arYUe7Xplbw2nVR2oHoZOPmzvPD37rgo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 05/65] sched/debug: Make sd->flags sysctl read-only
Date:   Tue,  7 Jul 2020 17:16:44 +0200
Message-Id: <20200707145752.698910547@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200707145752.417212219@linuxfoundation.org>
References: <20200707145752.417212219@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentin Schneider <valentin.schneider@arm.com>

[ Upstream commit 9818427c6270a9ce8c52c8621026fe9cebae0f92 ]

Writing to the sysctl of a sched_domain->flags directly updates the value of
the field, and goes nowhere near update_top_cache_domain(). This means that
the cached domain pointers can end up containing stale data (e.g. the
domain pointed to doesn't have the relevant flag set anymore).

Explicit domain walks that check for flags will be affected by
the write, but this won't be in sync with the cached pointers which will
still point to the domains that were cached at the last sched_domain
build.

In other words, writing to this interface is playing a dangerous game. It
could be made to trigger an update of the cached sched_domain pointers when
written to, but this does not seem to be worth the trouble. Make it
read-only.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200415210512.805-3-valentin.schneider@arm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index f7e4579e746c5..c4b702fe1d738 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -258,7 +258,7 @@ sd_alloc_ctl_domain_table(struct sched_domain *sd)
 	set_table_entry(&table[2], "busy_factor",	  &sd->busy_factor,	    sizeof(int),  0644, proc_dointvec_minmax);
 	set_table_entry(&table[3], "imbalance_pct",	  &sd->imbalance_pct,	    sizeof(int),  0644, proc_dointvec_minmax);
 	set_table_entry(&table[4], "cache_nice_tries",	  &sd->cache_nice_tries,    sizeof(int),  0644, proc_dointvec_minmax);
-	set_table_entry(&table[5], "flags",		  &sd->flags,		    sizeof(int),  0644, proc_dointvec_minmax);
+	set_table_entry(&table[5], "flags",		  &sd->flags,		    sizeof(int),  0444, proc_dointvec_minmax);
 	set_table_entry(&table[6], "max_newidle_lb_cost", &sd->max_newidle_lb_cost, sizeof(long), 0644, proc_doulongvec_minmax);
 	set_table_entry(&table[7], "name",		  sd->name,	       CORENAME_MAX_SIZE, 0444, proc_dostring);
 	/* &table[8] is terminator */
-- 
2.25.1



