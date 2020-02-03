Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B992C35249
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 02:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3976B206E6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 02:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PYppEEMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgBCCII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 21:08:08 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:53020 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbgBCCID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 21:08:03 -0500
Received: by mail-pj1-f68.google.com with SMTP id ep11so5586059pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Feb 2020 18:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KJap86/nifhfKi4VuHxVtjpPRBdgECtLUfE8Ufly4fs=;
        b=PYppEEMnSw65Q+/EuTeFNY5JGTW+KuYhJ1c0bRNSQsGnBZrKMBBzqoNKpRDaNfltQG
         EOhMMOlN6GZ0dw74yRyB+UInd2M5cUbF9H3EJXouXCn6mpcJLbTBaWfE7zGHSUuvNL4x
         03aLpR4Yn7qupJOU5e78Hw9f/VMipepCAk+/mT33QQsDGCzjdAyZryrfYQzS0NwTJuR1
         muxX2Lvpum5UCBzBR9lpWB+qtS8X0VbyaV+xzoNS2IlI0cbX5yK9gkKMKAXF5coymZ90
         l1qX+FS1nf/k1qCco2/tIrm2fF9x7c2Qleu2tt1zEEOq4IIVKNP0zYznRl5wXBDLhAmR
         HH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KJap86/nifhfKi4VuHxVtjpPRBdgECtLUfE8Ufly4fs=;
        b=HM41VNSDZus9DTa/mPrx8zuAt8JPa8CFzYKBd3lLFAqU7DnTsRRia4P3MyEvTaK5iN
         PCXK8sJ8CSQBGGn3va2Y9tK3UaVi/aMdLFqMInZEIt6dcvPbUf3du5DRqCvAQ2CGPHZP
         sFau4FDq46/AjbdmV25Heal6DOqi6sUn/Kl971hbo0C2dJsBgRkX31qS5/EdLQX43mpC
         porYKmBZwdDd9wC9pzfq+06KSSQmyRyEZVBT3nL+hvD9FORxtwlD4mXTo+6mEJ1p4VE7
         vKeVcQRcCfPR05iHEsT2qDxq9hOcL7Xv3VfLf6HhIl5YPVlMSdGegUUJaKfdLvsZSeGW
         c3hQ==
X-Gm-Message-State: APjAAAWui7xkXN/iCzFGrlbNBEdWN4NVlvyrbySJA4y9fCf5TDLkF4kW
        WIVx0ux2iC0cBsBnNVLqvIWwNQ==
X-Google-Smtp-Source: APXvYqy2wBn72cFl4uPvISqbSJeko9Inoq+xTUi3ClJPBeMEExgUnchgln1bvP4RNe71Ta69M9Re3Q==
X-Received: by 2002:a17:90a:191:: with SMTP id 17mr26932771pjc.88.1580695682224;
        Sun, 02 Feb 2020 18:08:02 -0800 (PST)
Received: from localhost.localdomain (li1441-214.members.linode.com. [45.118.134.214])
        by smtp.gmail.com with ESMTPSA id z29sm17521201pgc.21.2020.02.02.18.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 18:08:01 -0800 (PST)
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
Subject: [PATCH v4 3/5] perf cs-etm: Support branch filter
Date:   Mon,  3 Feb 2020 10:07:14 +0800
Message-Id: <20200203020716.31832-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200203020716.31832-1-leo.yan@linaro.org>
References: <20200203020716.31832-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If user specifies option '-F,+callindent' or call chain related options,
it means users only care about function calls and returns; for these
cases, it's pointless to generate samples for the branches within
function.  But unlike other hardware trace handling (e.g. Intel's pt or
bts), Arm CoreSight doesn't filter branch types for these options and
generate samples for all branches, this causes Perf to output many
spurious blanks if the branch is not a function call or return.

To only output pairs of calls and returns, this patch introduces branch
filter and the filter is set according to synthetic options.  Finally,
Perf can output only for calls and returns and avoid to output other
unnecessary blanks.

Before:

  # perf script -F,+callindent
            main  2808          1          branches:                 coresight_test1@plt                                  aaaaba8d37d8 main+0x14 (/root/coresight_test/main)
            main  2808          1          branches:                     coresight_test1@plt                              aaaaba8d367c coresight_test1@plt+0xc (/root/coresight_test/main)
            main  2808          1          branches:                     _init                                            aaaaba8d3650 _init+0x30 (/root/coresight_test/main)
            main  2808          1          branches:                     _dl_fixup                                        ffff86373b4c _dl_runtime_resolve+0x40 (/lib/aarch64-linux-gnu/ld-2.28.s
            main  2808          1          branches:                         _dl_lookup_symbol_x                          ffff8636e078 _dl_fixup+0xb8 (/lib/aarch64-linux-gnu/ld-2.28.so)
            main  2808          1          branches:                                                                      ffff8636a3f4 _dl_lookup_symbol_x+0x5c (/lib/aarch64-linux-gnu/ld-2.28.s
            main  2808          1          branches:                                                                      ffff8636a3f4 _dl_lookup_symbol_x+0x5c (/lib/aarch64-linux-gnu/ld-2.28.s
            main  2808          1          branches:                                                                      ffff8636a3f4 _dl_lookup_symbol_x+0x5c (/lib/aarch64-linux-gnu/ld-2.28.s
            main  2808          1          branches:                                                                      ffff8636a3f4 _dl_lookup_symbol_x+0x5c (/lib/aarch64-linux-gnu/ld-2.28.s
            main  2808          1          branches:                                                                      ffff8636a3f4 _dl_lookup_symbol_x+0x5c (/lib/aarch64-linux-gnu/ld-2.28.s
  [...]

After:

  # perf script -F,+callindent
            main  2808          1          branches:                 coresight_test1@plt                                  aaaaba8d37d8 main+0x14 (/root/coresight_test/main)
            main  2808          1          branches:                     _dl_fixup                                        ffff86373b4c _dl_runtime_resolve+0x40 (/lib/aarch64-linux-gnu/ld-2.28.s
            main  2808          1          branches:                         _dl_lookup_symbol_x                          ffff8636e078 _dl_fixup+0xb8 (/lib/aarch64-linux-gnu/ld-2.28.so)
            main  2808          1          branches:                             do_lookup_x                              ffff8636a49c _dl_lookup_symbol_x+0x104 (/lib/aarch64-linux-gnu/ld-2.28.
            main  2808          1          branches:                                 check_match                          ffff86369bf0 do_lookup_x+0x238 (/lib/aarch64-linux-gnu/ld-2.28.so)
            main  2808          1          branches:                                     strcmp                           ffff86369888 check_match+0x70 (/lib/aarch64-linux-gnu/ld-2.28.so)
            main  2808          1          branches:                 printf@plt                                           aaaaba8d37ec main+0x28 (/root/coresight_test/main)
            main  2808          1          branches:                     _dl_fixup                                        ffff86373b4c _dl_runtime_resolve+0x40 (/lib/aarch64-linux-gnu/ld-2.28.s
            main  2808          1          branches:                         _dl_lookup_symbol_x                          ffff8636e078 _dl_fixup+0xb8 (/lib/aarch64-linux-gnu/ld-2.28.so)
            main  2808          1          branches:                             do_lookup_x                              ffff8636a49c _dl_lookup_symbol_x+0x104 (/lib/aarch64-linux-gnu/ld-2.28.
            main  2808          1          branches:                                 _dl_name_match_p                     ffff86369af0 do_lookup_x+0x138 (/lib/aarch64-linux-gnu/ld-2.28.so)
            main  2808          1          branches:                                     strcmp                           ffff8636f7f0 _dl_name_match_p+0x18 (/lib/aarch64-linux-gnu/ld-2.28.so)
  [...]

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 4d289ecf49e2..617facef24cc 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -56,6 +56,7 @@ struct cs_etm_auxtrace {
 
 	int num_cpu;
 	u32 auxtrace_type;
+	u32 branches_filter;
 	u64 branches_sample_type;
 	u64 branches_id;
 	u64 instructions_sample_type;
@@ -1218,6 +1219,10 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 	} dummy_bs;
 	u64 ip;
 
+	if (etm->branches_filter &&
+	    !(etm->branches_filter & tidq->prev_packet->flags))
+		return 0;
+
 	ip = cs_etm__last_executed_instr(tidq->prev_packet);
 
 	event->sample.header.type = PERF_RECORD_SAMPLE;
@@ -2733,6 +2738,13 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 				session->itrace_synth_opts->thread_stack;
 	}
 
+	if (etm->synth_opts.calls)
+		etm->branches_filter |= PERF_IP_FLAG_CALL | PERF_IP_FLAG_ASYNC |
+					PERF_IP_FLAG_TRACE_END;
+	if (etm->synth_opts.returns)
+		etm->branches_filter |= PERF_IP_FLAG_RETURN |
+					PERF_IP_FLAG_TRACE_BEGIN;
+
 	err = cs_etm__synth_events(etm, session);
 	if (err)
 		goto err_delete_thread;
-- 
2.17.1

