Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF36C761A1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1655520801
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ub0zzd8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgBTF3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 00:29:18 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33497 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbgBTF3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 00:29:17 -0500
Received: by mail-pg1-f195.google.com with SMTP id 6so1341593pgk.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 21:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EjE4Cf7VSGmXDtiO9wfyAofjvoP2FRT6B4UQ7hLR5AY=;
        b=Ub0zzd8dWNfTsDTewN1jODEFnVsMOTPD5316AMePvfM0o+2Um4n9L/wKg+jmamqCXq
         8XJPquqFIDrrkvHZluYuz/9foLpjkiu1cwtAW+C6ixGT2XEtt1997AUR+VbqkhkTZdzl
         o5Mvsf40nekLYIMcM3FQU1MgEUFl7BiExQQPPXuxeVKXp8HfH+JhvF2wo4AC3khFtn3M
         SXAy+mVO5lNQeWedTjZgBj4OTWbmRklis6gQDEcVDjVAOWHLBjuDP8m2jXw0slsHtjfW
         oqRmzzpv94v3l2QQrjT0rFWu7CnwcuidgwMR+onqK+HtBbaZRXFThQpJGkT0KXKOYy47
         zlkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EjE4Cf7VSGmXDtiO9wfyAofjvoP2FRT6B4UQ7hLR5AY=;
        b=nhX9DaDJ5q5Wd+wTZXGY3iw25qSFCOjQd9oNLSpYlldx3/hUEqBEJEFtkupYu6wP9d
         cFR1xbRiv7s2WadhKyTWuagGbYNxNDxV9Fvw8S/a/8t8efzw6SYdIiFC316wL6fDQ2dZ
         nKYVqCs1xlCJXKA5OM16OJo0RVHMQUSZr0ybRzIGBDbJP/eJj9viZ1YedAS2MF4tJYZb
         G2TNh9nk68s2TFAWjGzPFv1tFbP07o7k9iup4XlTk91xyi13I3LbqZ9A4WF8UlF05o4m
         B8ttde/doQJ3+h2kljCREha57G/emB8MDM0NwxUq4FujxzhUO5RVMn7WaeHYiGGC5iro
         kV1Q==
X-Gm-Message-State: APjAAAUm7qRY+dmnXLiEmazScGEa44bQMRs+31wbLVwKPBSRz2xZncFZ
        cUhLBxXmt+KUFlgq+aEg8hy4DA==
X-Google-Smtp-Source: APXvYqzXGCJ8KKqo2Ke8Te55VXSZTK7rRAQmCpM2W+Cmx3hGbcok220pWXGhNqhw2DaGZEJJib1fwg==
X-Received: by 2002:a62:1456:: with SMTP id 83mr30897343pfu.186.1582176557002;
        Wed, 19 Feb 2020 21:29:17 -0800 (PST)
Received: from localhost.localdomain (li1441-214.members.linode.com. [45.118.134.214])
        by smtp.gmail.com with ESMTPSA id l69sm1535663pgd.1.2020.02.19.21.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 21:29:16 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 9/9] perf cs-etm: Fixup exception exit for thread stack
Date:   Thu, 20 Feb 2020 13:27:01 +0800
Message-Id: <20200220052701.7754-10-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220052701.7754-1-leo.yan@linaro.org>
References: <20200220052701.7754-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For instruction emulation or other cases (like ptrace), the program will
be trapped into kernel and the kernel executes the instruction with
single step, so the exception return address will be one instruction
ahead than the recorded address 'ret_addr' in the thread stack.
Finally, it's impossible to pop up the thread stack due to the mismatch
between the return address and 'ret_addr'.

To fix this issue, this patch reads out the 'ret_addr' from the top of
thread stack, and if detects the exception return address is one
instruction ahead than 'ret_addr', it implies the kernel has executed
single step.  For this case, calibrate 'to_ip' to 'ret_addr' so can
allow the thread stack to pop up.

Before:

  main  3258        100      instructions:
          ffff800010095f48 do_emulate_mrs+0x48 ([kernel.kallsyms])
          ffff800010096060 emulate_mrs+0x48 ([kernel.kallsyms])
          ffff8000100904ec do_undefinstr+0x1f4 ([kernel.kallsyms])
          ffff80001008788c el0_sync_handler+0x124 ([kernel.kallsyms])
          ffff800010082d00 el0_sync+0x140 ([kernel.kallsyms])
              ffffad8137d8 _dl_sysdep_start+0x2f8 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
              ffffad800884 _dl_start_final+0xac (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
              ffffad800b00 _dl_start+0x200 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
              ffffad800048 _start+0x8 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)

  main  3258        100      instructions:
          ffff8000100835fc finish_ret_to_user+0xbc ([kernel.kallsyms])
              ffffad8137d8 _dl_sysdep_start+0x2f8 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
              ffffad800884 _dl_start_final+0xac (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
              ffffad800b00 _dl_start+0x200 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
              ffffad800048 _start+0x8 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)

  main  3258        100      instructions:
              ffffad801138 dl_main+0x70 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
              ffffad81384c _dl_sysdep_start+0x36c (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
              ffffad8137d8 _dl_sysdep_start+0x2f8 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
              ffffad800884 _dl_start_final+0xac (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
              ffffad800b00 _dl_start+0x200 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
              ffffad800048 _start+0x8 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)

Note: after return back from instruction emulation with emulate_mrs(),
_dl_sysdep_start+0x2f8 cannot be popped up.

After:

  main  3258        100      instructions:
          ffff800010095f48 do_emulate_mrs+0x48 ([kernel.kallsyms])
          ffff800010096060 emulate_mrs+0x48 ([kernel.kallsyms])
          ffff8000100904ec do_undefinstr+0x1f4 ([kernel.kallsyms])
          ffff80001008788c el0_sync_handler+0x124 ([kernel.kallsyms])
          ffff800010082d00 el0_sync+0x140 ([kernel.kallsyms])
              ffffad8137d8 _dl_sysdep_start+0x2f8 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
              ffffad800884 _dl_start_final+0xac (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
              ffffad800b00 _dl_start+0x200 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
              ffffad800048 _start+0x8 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)

  main  3258        100      instructions:
          ffff8000100835fc finish_ret_to_user+0xbc ([kernel.kallsyms])
              ffffad8137d8 _dl_sysdep_start+0x2f8 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
              ffffad800884 _dl_start_final+0xac (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
              ffffad800b00 _dl_start+0x200 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
              ffffad800048 _start+0x8 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)

  main  3258        100      instructions:
              ffffad801138 dl_main+0x70 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
              ffffad81384c _dl_sysdep_start+0x36c (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
              ffffad800884 _dl_start_final+0xac (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
              ffffad800b00 _dl_start+0x200 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
              ffffad800048 _start+0x8 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 4800daf0dc3d..7ff55704de5c 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1190,6 +1190,34 @@ static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
 		    tidq->prev_packet->end_addr)
 			insn_len = 0;
 
+		/*
+		 * Fixup the exception exit.
+		 *
+		 * For instruction emulation or single step cases, when return
+		 * from exception, since an extra instruction has been executed
+		 * in kernel, the exception return address 'top_ip' is an
+		 * instruction ahead than the expected address 'ret_addr' in
+		 * thread stack.
+		 *
+		 * When detects this case, calibrate 'to_ip' to 'ret_addr' so
+		 * can pop up thread stack.
+		 */
+		flags = PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_RETURN |
+			PERF_IP_FLAG_INTERRUPT;
+		if (tidq->prev_packet->flags == flags) {
+			u64 ret_addr;
+			int ret_insn_len;
+
+			ret_addr = thread_stack__get_top_ret_addr(tidq->thread,
+						tidq->prev_packet->cpu);
+			ret_insn_len = cs_etm__instr_size(etmq,
+							  trace_chan_id,
+							  tidq->packet->isa,
+							  ret_addr);
+			if (to_ip == ret_addr + ret_insn_len)
+				to_ip = ret_addr;
+		}
+
 		/*
 		 * Create thread stacks by keeping track of calls and returns;
 		 * any call pushes thread stack, return pops the stack, and
-- 
2.17.1

