Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FD2C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D441205F4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578737867;
	bh=9qcvowxmEQncxH6EJpnreHVGbP7op9XJu/sacMFNzTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UlZK1FD2S8r+naPRCeNQBsrdfnQsYzCOfSf4hroWDCWB5u1dm/rRBsVerwHMxPq4L
	 aL+Xr+K9sCrZ7pFb6QxjGNUSp2RFp97RWnKTO3ZbilBB2kLUQzy3eDuhwbkO19T4yX
	 zolgBhnzt28sOz8VsLzZBw02kifi3eUmzuABg05k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730508AbgAKKRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:17:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:34828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728946AbgAKKRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:17:43 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 452352077C;
        Sat, 11 Jan 2020 10:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578737862;
        bh=9qcvowxmEQncxH6EJpnreHVGbP7op9XJu/sacMFNzTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qtleNEkQqPwAevwiwFZkiLseoebyCqKQsY13aicSb6WwClwvE5uEb/lfiMOo+3nET
         GLReXdJwsDhR1jU2bgxqTmKBG3dNP1WqgsEubTVw/MZdAeVhTiCzD89++IKjqWaMws
         +jugm9BU7ZTGrZRy6/WC2DxpmB8ocIIL4rYXRKEw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 46/84] perf/x86/intel: Fix PT PMI handling
Date:   Sat, 11 Jan 2020 10:50:23 +0100
Message-Id: <20200111094903.790241100@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094845.328046411@linuxfoundation.org>
References: <20200111094845.328046411@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

[ Upstream commit 92ca7da4bdc24d63bb0bcd241c11441ddb63b80a ]

Commit:

  ccbebba4c6bf ("perf/x86/intel/pt: Bypass PT vs. LBR exclusivity if the core supports it")

skips the PT/LBR exclusivity check on CPUs where PT and LBRs coexist, but
also inadvertently skips the active_events bump for PT in that case, which
is a bug. If there aren't any hardware events at the same time as PT, the
PMI handler will ignore PT PMIs, as active_events reads zero in that case,
resulting in the "Uhhuh" spurious NMI warning and PT data loss.

Fix this by always increasing active_events for PT events.

Fixes: ccbebba4c6bf ("perf/x86/intel/pt: Bypass PT vs. LBR exclusivity if the core supports it")
Reported-by: Vitaly Slobodskoy <vitaly.slobodskoy@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: https://lkml.kernel.org/r/20191210105101.77210-1-alexander.shishkin@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index c9625bff4328..429389489eed 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -375,7 +375,7 @@ int x86_add_exclusive(unsigned int what)
 	 * LBR and BTS are still mutually exclusive.
 	 */
 	if (x86_pmu.lbr_pt_coexist && what == x86_lbr_exclusive_pt)
-		return 0;
+		goto out;
 
 	if (!atomic_inc_not_zero(&x86_pmu.lbr_exclusive[what])) {
 		mutex_lock(&pmc_reserve_mutex);
@@ -387,6 +387,7 @@ int x86_add_exclusive(unsigned int what)
 		mutex_unlock(&pmc_reserve_mutex);
 	}
 
+out:
 	atomic_inc(&active_events);
 	return 0;
 
@@ -397,11 +398,15 @@ int x86_add_exclusive(unsigned int what)
 
 void x86_del_exclusive(unsigned int what)
 {
+	atomic_dec(&active_events);
+
+	/*
+	 * See the comment in x86_add_exclusive().
+	 */
 	if (x86_pmu.lbr_pt_coexist && what == x86_lbr_exclusive_pt)
 		return;
 
 	atomic_dec(&x86_pmu.lbr_exclusive[what]);
-	atomic_dec(&active_events);
 }
 
 int x86_setup_perfctr(struct perf_event *event)
-- 
2.20.1



