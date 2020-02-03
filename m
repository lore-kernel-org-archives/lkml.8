Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA4AC3524C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 02:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F2820CC7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 02:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LhHnSZFF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgBCCHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 21:07:55 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33612 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgBCCHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 21:07:55 -0500
Received: by mail-pl1-f194.google.com with SMTP id ay11so5217390plb.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Feb 2020 18:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OzwMrO1QLAvOkLauztgxisjFtHkDUQkxoW1enJHbnIQ=;
        b=LhHnSZFFZYDt14qiPWg7QZDaTjwAU7mTXzTqAbmNtuCWcM8I6CEb11Ad7OwXsnEKtj
         u38TTRzvx0YER2Iod4MWFShCafa26lqk6hmUv+nGxuMRk/AutXq8zm36Ty3ur3apiVUM
         OhG0amU2WbOVFMVjzDeIIPYV2Trkg5me4Vv5FGF4nZ06aZmgUVi2UMnkG6YtxLNWnhH+
         MbCl08BuFDgRA/VC5oVHnXioX+FvL9O1WYPiR8GCjdgDpm9zAeJLrrb9CK4bmR7vBd/T
         VmOfzZOLuxdb2HDGxT3zi1q+yjxBkVHl5iEDz5zydeLiQVSO5BQ2u1gbKCeQPxI4C8IQ
         /ILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OzwMrO1QLAvOkLauztgxisjFtHkDUQkxoW1enJHbnIQ=;
        b=ZTZWo5MFRZaoc9khF8r15YyoKWlKhZW5EnJa2CNposRSvv/FPNl6w+NRilDczpDC61
         LIh1maMv7yUEsydkLfbrTB08kL8BtJsvsSGcNYo6D2D9DewQTAIiBGevqadOBDH+eV4O
         fn8LdTZb2hPPZx5GVxpLwY7j3FmwZb53JcqF15VzRQymM+DvE+E5RhcdeohQkPJcwXUS
         ZHpI9Ew9cyOjpXO6/Bpnz4xDBtqh4OyxH9PMSZ5ac1LNg2q1c1k/a0iN3y4l1VrMfBKG
         DRmBOIGNdO2CPUW6QHFu7EkPoyNgwDtdiy8zxsyz7R2ZrYG+iNv5YsaZpWTkHskRGipO
         mV/w==
X-Gm-Message-State: APjAAAW6FFg2Q76lUBPKP45vt/7QmPxSqdbkgk2wFM/VjlaV2DU/g/UI
        cuCKo4G4l/i3vFs7O/3zPsS8cA==
X-Google-Smtp-Source: APXvYqz2lxXNsFsQs/ZQTvjbTO4U3hRLhKP8vnQWrSWmmKhTWX7tiT7qlbw3TA9jQOBdUGOHaa13vQ==
X-Received: by 2002:a17:90a:a406:: with SMTP id y6mr27764261pjp.115.1580695674111;
        Sun, 02 Feb 2020 18:07:54 -0800 (PST)
Received: from localhost.localdomain (li1441-214.members.linode.com. [45.118.134.214])
        by smtp.gmail.com with ESMTPSA id z29sm17521201pgc.21.2020.02.02.18.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 18:07:53 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 2/5] perf cs-etm: Support thread stack
Date:   Mon,  3 Feb 2020 10:07:13 +0800
Message-Id: <20200203020716.31832-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200203020716.31832-1-leo.yan@linaro.org>
References: <20200203020716.31832-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Arm CoreSight doesn't support thread stack, the decoding cannot
display symbols with indented spaces to reflect the stack depth.

This patch adds support thread stack for Arm CoreSight, this allows
'perf script' to display properly for option '-F,+callindent'.

Before:

  # perf script -F,+callindent
            main  2808          1          branches: coresight_test1                      ffff8634f5c8 coresight_test1+0x3c (/root/coresight_test/libcstest.so)
            main  2808          1          branches: printf@plt                           aaaaba8d37ec main+0x28 (/root/coresight_test/main)
            main  2808          1          branches: printf@plt                           aaaaba8d36bc printf@plt+0xc (/root/coresight_test/main)
            main  2808          1          branches: _init                                aaaaba8d3650 _init+0x30 (/root/coresight_test/main)
            main  2808          1          branches: _dl_fixup                            ffff86373b4c _dl_runtime_resolve+0x40 (/lib/aarch64-linux-gnu/ld-2.28.so)
            main  2808          1          branches: _dl_lookup_symbol_x                  ffff8636e078 _dl_fixup+0xb8 (/lib/aarch64-linux-gnu/ld-2.28.so)
  [...]

After:

  # perf script -F,+callindent
            main  2808          1          branches:                 coresight_test1                                      ffff8634f5c8 coresight_test1+0x3c (/root/coresight_test/libcstest.so)
            main  2808          1          branches:                 printf@plt                                           aaaaba8d37ec main+0x28 (/root/coresight_test/main)
            main  2808          1          branches:                     printf@plt                                       aaaaba8d36bc printf@plt+0xc (/root/coresight_test/main)
            main  2808          1          branches:                     _init                                            aaaaba8d3650 _init+0x30 (/root/coresight_test/main)
            main  2808          1          branches:                     _dl_fixup                                        ffff86373b4c _dl_runtime_resolve+0x40 (/lib/aarch64-linux-gnu/ld-2.28.s
            main  2808          1          branches:                         _dl_lookup_symbol_x                          ffff8636e078 _dl_fixup+0xb8 (/lib/aarch64-linux-gnu/ld-2.28.so)
  [...]

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index cb6fcc2acca0..4d289ecf49e2 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1117,6 +1117,45 @@ static void cs_etm__copy_insn(struct cs_etm_queue *etmq,
 			   sample->insn_len, (void *)sample->insn);
 }
 
+static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
+				    struct cs_etm_traceid_queue *tidq)
+{
+	struct cs_etm_auxtrace *etm = etmq->etm;
+	u8 trace_chan_id = tidq->trace_chan_id;
+	int insn_len;
+	u64 from_ip, to_ip;
+
+	if (etm->synth_opts.thread_stack) {
+		from_ip = cs_etm__last_executed_instr(tidq->prev_packet);
+		to_ip = cs_etm__first_executed_instr(tidq->packet);
+
+		insn_len = cs_etm__instr_size(etmq, trace_chan_id,
+					      tidq->prev_packet->isa, from_ip);
+
+		/*
+		 * Create thread stacks by keeping track of calls and returns;
+		 * any call pushes thread stack, return pops the stack, and
+		 * flush stack when the trace is discontinuous.
+		 */
+		thread_stack__event(tidq->thread, tidq->prev_packet->cpu,
+				    tidq->prev_packet->flags,
+				    from_ip, to_ip, insn_len,
+				    etmq->buffer->buffer_nr + 1);
+	} else {
+		/*
+		 * The thread stack can be output via thread_stack__process();
+		 * thus the detailed information about paired calls and returns
+		 * will be facilitated by Python script for the db-export.
+		 *
+		 * Need to set trace buffer number and flush thread stack if the
+		 * trace buffer number has been alternate.
+		 */
+		thread_stack__set_trace_nr(tidq->thread,
+					   tidq->prev_packet->cpu,
+					   etmq->buffer->buffer_nr + 1);
+	}
+}
+
 static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 					    struct cs_etm_traceid_queue *tidq,
 					    u64 addr, u64 period)
@@ -1471,6 +1510,9 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 		tidq->period_instructions = instrs_over;
 	}
 
+	if (tidq->prev_packet->last_instr_taken_branch)
+		cs_etm__add_stack_event(etmq, tidq);
+
 	if (etm->sample_branches) {
 		bool generate_sample = false;
 
@@ -2687,6 +2729,8 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 		itrace_synth_opts__set_default(&etm->synth_opts,
 				session->itrace_synth_opts->default_no_sample);
 		etm->synth_opts.callchain = false;
+		etm->synth_opts.thread_stack =
+				session->itrace_synth_opts->thread_stack;
 	}
 
 	err = cs_etm__synth_events(etm, session);
-- 
2.17.1

