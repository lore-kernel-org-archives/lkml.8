Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C8CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51D3921548
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389633AbgE1MJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 08:09:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:6224 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388907AbgE1MJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 08:09:34 -0400
IronPort-SDR: vU7hcmqVRbRfhWXx85hq7R6Iv3zD2Fx5XbjaXiWd2KBz6Z4EZBqkk10ejJr7wQ4KAreiwr0Oe5
 mCnfjzkNDmRQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 05:09:34 -0700
IronPort-SDR: VEcnEG7uhUim81Ar03elcl/rsp5cTkb8WUc52CY2Kg38HbQ875GTEJJmcEBHGXPgEAyVI1jjTc
 aYRxD2O/twrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,444,1583222400"; 
   d="scan'208";a="270831810"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.157])
  by orsmga006.jf.intel.com with ESMTP; 28 May 2020 05:09:32 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 2/2] perf intel-pt: Refine kernel decoding only warning message
Date:   Thu, 28 May 2020 15:08:59 +0300
Message-Id: <20200528120859.21604-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200528120859.21604-1-adrian.hunter@intel.com>
References: <20200528120859.21604-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop the message displaying when user space is not being traced.

Example:

  Prerequisites:

    sudo setcap "cap_sys_rawio,cap_sys_admin,cap_sys_ptrace,cap_syslog,cap_ipc_lock=ep" ~/bin/perf
    sudo chmod +r /proc/kcore

  Before:

    $ perf record --no-switch-events --kcore -a -e intel_pt//k -- sleep 0.001
    Warning:
    Intel Processor Trace decoding will not be possible except for kernel tracing!
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 0.838 MB perf.data ]

  After:

    $ perf record --no-switch-events --kcore -a -e intel_pt//k -- sleep 0.001
    [ perf record: Woken up 1 times to write data ]
    [ perf record: Captured and wrote 1.068 MB perf.data ]

    $ sudo chmod go-r /proc/kcore
    $ sudo setcap -r ~/bin/perf

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/arch/x86/util/intel-pt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 3fc547769707..9fb137282dc8 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -879,7 +879,8 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 	 * per-cpu with no sched_switch (except workload-only).
 	 */
 	if (!ptr->have_sched_switch && !perf_cpu_map__empty(cpus) &&
-	    !target__none(&opts->target))
+	    !target__none(&opts->target) &&
+	    !intel_pt_evsel->core.attr.exclude_user)
 		ui__warning("Intel Processor Trace decoding will not be possible except for kernel tracing!\n");
 
 	return 0;
-- 
2.17.1

