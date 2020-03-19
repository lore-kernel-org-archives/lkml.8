Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F997C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C2B21924
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623875;
	bh=xpF/oJrCEXUxvt+0y7Lo8jkFhhTZdOsK+QynZE3xPvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aBaR/6dU6Mx+9Q80zPIFuUKVp8VEXA1Duth+FYBiOgZuYflKgwLQtGPxkHI8ecySF
	 4TAO2IH5PFrZTW/zbh9ZcvrOtUWYslGIgUIyQ7FNDGxKC9+7+/LKKSIpFboqBsDD7T
	 q0d7sy6YaaBwAz8zabKlo9kkGwsFfA3Ygmn8u61U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgCSNRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:17:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:39448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729669AbgCSNRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:17:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 710B8214D8;
        Thu, 19 Mar 2020 13:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623869;
        bh=xpF/oJrCEXUxvt+0y7Lo8jkFhhTZdOsK+QynZE3xPvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ah+uBNz1up8wfNdCT6E/NSrn03X8495ZUfwetsGiNOrzjOndaxdWrwC20+s9SC91H
         EEauz5PKX0Q2pmzDafOF7b7OVbWMX7ZZcMMkgaIXAQcwujGpwyoopJtu4z9QImoZ8N
         GCkrH9FrZj/QY8BY3eoE050HL5Yy6XlfVy0CqGfk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kim Phillips <kim.phillips@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 82/99] perf/amd/uncore: Replace manual sampling check with CAP_NO_INTERRUPT flag
Date:   Thu, 19 Mar 2020 14:04:00 +0100
Message-Id: <20200319124005.115184451@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123941.630731708@linuxfoundation.org>
References: <20200319123941.630731708@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kim Phillips <kim.phillips@amd.com>

[ Upstream commit f967140dfb7442e2db0868b03b961f9c59418a1b ]

Enable the sampling check in kernel/events/core.c::perf_event_open(),
which returns the more appropriate -EOPNOTSUPP.

BEFORE:

  $ sudo perf record -a -e instructions,l3_request_g1.caching_l3_cache_accesses true
  Error:
  The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (l3_request_g1.caching_l3_cache_accesses).
  /bin/dmesg | grep -i perf may provide additional information.

With nothing relevant in dmesg.

AFTER:

  $ sudo perf record -a -e instructions,l3_request_g1.caching_l3_cache_accesses true
  Error:
  l3_request_g1.caching_l3_cache_accesses: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'

Fixes: c43ca5091a37 ("perf/x86/amd: Add support for AMD NB and L2I "uncore" counters")
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20200311191323.13124-1-kim.phillips@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/amd/uncore.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index baa7e36073f90..604a8558752d1 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -193,20 +193,18 @@ static int amd_uncore_event_init(struct perf_event *event)
 
 	/*
 	 * NB and Last level cache counters (MSRs) are shared across all cores
-	 * that share the same NB / Last level cache. Interrupts can be directed
-	 * to a single target core, however, event counts generated by processes
-	 * running on other cores cannot be masked out. So we do not support
-	 * sampling and per-thread events.
+	 * that share the same NB / Last level cache.  On family 16h and below,
+	 * Interrupts can be directed to a single target core, however, event
+	 * counts generated by processes running on other cores cannot be masked
+	 * out. So we do not support sampling and per-thread events via
+	 * CAP_NO_INTERRUPT, and we do not enable counter overflow interrupts:
 	 */
-	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
-		return -EINVAL;
 
 	/* NB and Last level cache counters do not have usr/os/guest/host bits */
 	if (event->attr.exclude_user || event->attr.exclude_kernel ||
 	    event->attr.exclude_host || event->attr.exclude_guest)
 		return -EINVAL;
 
-	/* and we do not enable counter overflow interrupts */
 	hwc->config = event->attr.config & AMD64_RAW_EVENT_MASK_NB;
 	hwc->idx = -1;
 
@@ -314,6 +312,7 @@ static struct pmu amd_nb_pmu = {
 	.start		= amd_uncore_start,
 	.stop		= amd_uncore_stop,
 	.read		= amd_uncore_read,
+	.capabilities	= PERF_PMU_CAP_NO_INTERRUPT,
 };
 
 static struct pmu amd_llc_pmu = {
@@ -324,6 +323,7 @@ static struct pmu amd_llc_pmu = {
 	.start		= amd_uncore_start,
 	.stop		= amd_uncore_stop,
 	.read		= amd_uncore_read,
+	.capabilities	= PERF_PMU_CAP_NO_INTERRUPT,
 };
 
 static struct amd_uncore *amd_uncore_alloc(unsigned int cpu)
-- 
2.20.1



