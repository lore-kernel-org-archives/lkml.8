Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49477C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B96524699
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582814774;
	bh=kuJqm9lVHTgSkHtET51GQHu9pcWS6zXH9KVddYyPlhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QUr68U34EapAhCNXDSsdyRp7oVb/xKljmgGumtg4tt/MiAwipoq1JkgZ7sxwR64CI
	 YygV4/FRUz2tkxLUVFq7wwmQ+dxmr4jtor09ZztQILlgEj6Zf85jFFbVrKsLYK6ld1
	 DyTydsSMF9PqJuGEySHeeZGdqjXy/90Zl7AKrO2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbgB0OqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:46:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:41452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730382AbgB0Npb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:45:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 276BA21D7E;
        Thu, 27 Feb 2020 13:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811130;
        bh=kuJqm9lVHTgSkHtET51GQHu9pcWS6zXH9KVddYyPlhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uFh0Z5ALQNnIO/IrXOEVfeka36NkuqW2KR1EJ1FMce1hFgGuqLc88LkwhN7Bi3+Gb
         CTbQn6ZNBaIkssu2kY6XuSaDlqqW3BXqmW8468eZNjg0cYK1DjRVSyJMEFXo8asEyd
         BXl2E0ifoSIpVDe2yz9iNzmhLec8N3L19gbV38Jk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 015/165] perf/x86/intel: Fix inaccurate period in context switch for auto-reload
Date:   Thu, 27 Feb 2020 14:34:49 +0100
Message-Id: <20200227132233.229300857@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132230.840899170@linuxfoundation.org>
References: <20200227132230.840899170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

commit f861854e1b435b27197417f6f90d87188003cb24 upstream.

Perf doesn't take the left period into account when auto-reload is
enabled with fixed period sampling mode in context switch.

Here is the MSR trace of the perf command as below.
(The MSR trace is simplified from a ftrace log.)

    #perf record -e cycles:p -c 2000000 -- ./triad_loop

      //The MSR trace of task schedule out
      //perf disable all counters, disable PEBS, disable GP counter 0,
      //read GP counter 0, and re-enable all counters.
      //The counter 0 stops at 0xfffffff82840
      write_msr: MSR_CORE_PERF_GLOBAL_CTRL(38f), value 0
      write_msr: MSR_IA32_PEBS_ENABLE(3f1), value 0
      write_msr: MSR_P6_EVNTSEL0(186), value 40003003c
      rdpmc: 0, value fffffff82840
      write_msr: MSR_CORE_PERF_GLOBAL_CTRL(38f), value f000000ff

      //The MSR trace of the same task schedule in again
      //perf disable all counters, enable and set GP counter 0,
      //enable PEBS, and re-enable all counters.
      //0xffffffe17b80 (-2000000) is written to GP counter 0.
      write_msr: MSR_CORE_PERF_GLOBAL_CTRL(38f), value 0
      write_msr: MSR_IA32_PMC0(4c1), value ffffffe17b80
      write_msr: MSR_P6_EVNTSEL0(186), value 40043003c
      write_msr: MSR_IA32_PEBS_ENABLE(3f1), value 1
      write_msr: MSR_CORE_PERF_GLOBAL_CTRL(38f), value f000000ff

When the same task schedule in again, the counter should starts from
previous left. However, it starts from the fixed period -2000000 again.

A special variant of intel_pmu_save_and_restart() is used for
auto-reload, which doesn't update the hwc->period_left.
When the monitored task schedules in again, perf doesn't know the left
period. The fixed period is used, which is inaccurate.

With auto-reload, the counter always has a negative counter value. So
the left period is -value. Update the period_left in
intel_pmu_save_and_restart_reload().

With the patch:

      //The MSR trace of task schedule out
      write_msr: MSR_CORE_PERF_GLOBAL_CTRL(38f), value 0
      write_msr: MSR_IA32_PEBS_ENABLE(3f1), value 0
      write_msr: MSR_P6_EVNTSEL0(186), value 40003003c
      rdpmc: 0, value ffffffe25cbc
      write_msr: MSR_CORE_PERF_GLOBAL_CTRL(38f), value f000000ff

      //The MSR trace of the same task schedule in again
      write_msr: MSR_CORE_PERF_GLOBAL_CTRL(38f), value 0
      write_msr: MSR_IA32_PMC0(4c1), value ffffffe25cbc
      write_msr: MSR_P6_EVNTSEL0(186), value 40043003c
      write_msr: MSR_IA32_PEBS_ENABLE(3f1), value 1
      write_msr: MSR_CORE_PERF_GLOBAL_CTRL(38f), value f000000ff

Fixes: d31fc13fdcb2 ("perf/x86/intel: Fix event update for auto-reload")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200121190125.3389-1-kan.liang@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/events/intel/ds.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1326,6 +1326,8 @@ intel_pmu_save_and_restart_reload(struct
 	old = ((s64)(prev_raw_count << shift) >> shift);
 	local64_add(new - old + count * period, &event->count);
 
+	local64_set(&hwc->period_left, -new);
+
 	perf_event_update_userpage(event);
 
 	return 0;


