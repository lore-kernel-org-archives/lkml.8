Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310ABC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 19:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 121DF2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 19:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgHRTaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 15:30:08 -0400
Received: from foss.arm.com ([217.140.110.172]:47910 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbgHRTaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 15:30:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BF6B31B;
        Tue, 18 Aug 2020 12:30:02 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2D1BD3F71F;
        Tue, 18 Aug 2020 12:30:01 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        jeremy.linton@arm.com, coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>
Subject: [PATCH] coresight: etm4x: Handle unreachable sink in perf mode
Date:   Tue, 18 Aug 2020 20:29:31 +0100
Message-Id: <20200818192931.168584-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the specified/hinted sink is not reachable from a subset of the CPUs,
we could end up unable to trace the event on those CPUs. This
is the best effort we could do until we support 1:1 configurations.
Fail gracefully in such cases avoiding a WARN_ON, which can be easily
triggered by the user on certain platforms, like :

[10919.513250] ------------[ cut here ]------------
[10919.517861] WARNING: CPU: 2 PID: 24021 at
drivers/hwtracing/coresight/coresight-etm-perf.c:316 etm_event_start+0xf8/0x100
...

[10919.564403] CPU: 2 PID: 24021 Comm: perf Not tainted 5.8.0+ #24
[10919.570308] pstate: 80400089 (Nzcv daIf +PAN -UAO BTYPE=--)
[10919.575865] pc : etm_event_start+0xf8/0x100
[10919.580034] lr : etm_event_start+0x80/0x100
[10919.584202] sp : fffffe001932f940
[10919.587502] x29: fffffe001932f940 x28: fffffc834995f800
[10919.592799] x27: 0000000000000000 x26: fffffe0011f3ced0
[10919.598095] x25: fffffc837fce244c x24: fffffc837fce2448
[10919.603391] x23: 0000000000000002 x22: fffffc8353529c00
[10919.608688] x21: fffffc835bb31000 x20: 0000000000000000
[10919.613984] x19: fffffc837fcdcc70 x18: 0000000000000000
[10919.619281] x17: 0000000000000000 x16: 0000000000000000
[10919.624577] x15: 0000000000000000 x14: 00000000000009f8
[10919.629874] x13: 00000000000009f8 x12: 0000000000000018
[10919.635170] x11: 0000000000000000 x10: 0000000000000000
[10919.640467] x9 : fffffe00108cd168 x8 : 0000000000000000
[10919.645763] x7 : 0000000000000020 x6 : 0000000000000001
[10919.651059] x5 : 0000000000000002 x4 : 0000000000000001
[10919.656356] x3 : 0000000000000000 x2 : 0000000000000000
[10919.661652] x1 : fffffe836eb40000 x0 : 0000000000000000
[10919.666949] Call trace:
[10919.669382]  etm_event_start+0xf8/0x100
[10919.673203]  etm_event_add+0x40/0x60
[10919.676765]  event_sched_in.isra.134+0xcc/0x210
[10919.681281]  merge_sched_in+0xb0/0x2a8
[10919.685017]  visit_groups_merge.constprop.140+0x15c/0x4b8
[10919.690400]  ctx_sched_in+0x15c/0x170
[10919.694048]  perf_event_sched_in+0x6c/0xa0
[10919.698130]  ctx_resched+0x60/0xa0
[10919.701517]  perf_event_exec+0x288/0x2f0
[10919.705425]  begin_new_exec+0x4c8/0xf58
[10919.709247]  load_elf_binary+0x66c/0xf30
[10919.713155]  exec_binprm+0x15c/0x450
[10919.716716]  __do_execve_file+0x508/0x748
[10919.720711]  __arm64_sys_execve+0x40/0x50
[10919.724707]  do_el0_svc+0xf4/0x1b8
[10919.728095]  el0_sync_handler+0xf8/0x124
[10919.732003]  el0_sync+0x140/0x180

Fixes: f9d81a657bb8 ("coresight: perf: Allow tracing on hotplugged CPUs")
Reported-by: Jeremy Linton <jeremy.linton@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 1a3169e69bb1..9d61a71da96f 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -321,6 +321,16 @@ static void etm_event_start(struct perf_event *event, int flags)
 	if (!event_data)
 		goto fail;
 
+	/*
+	 * Check if this ETM is allowed to trace, as decided
+	 * at etm_setup_aux(). This could be due to an unreachable
+	 * sink from this ETM. We can't do much in this case if
+	 * the sink was specified or hinted to the driver. For
+	 * now, simply don't record anything on this ETM.
+	 */
+	if (!cpumask_test_cpu(cpu, &event_data->mask))
+		goto fail_end_stop;
+
 	path = etm_event_cpu_path(event_data, cpu);
 	/* We need a sink, no need to continue without one */
 	sink = coresight_get_sink(path);
-- 
2.24.1

