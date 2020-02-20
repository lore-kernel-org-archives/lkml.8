Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44C4C761A1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717D820801
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ssb5jO6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgBTF3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 00:29:00 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44554 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgBTF3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 00:29:00 -0500
Received: by mail-pl1-f194.google.com with SMTP id d9so1070822plo.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 21:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=leyno95cobAtAcNQFGrlVZ0utmyIUUJFgDrYtk3rO3A=;
        b=ssb5jO6qvG1aojB3oqYW76CRN/TETCqlTpGBQUhq3KQfF8uaQftqD1BQfIPG8lDkC7
         79WIqFOVmqnqIb0KYR6Meyy4JB40F6kgOkFiLeIBEjhOa/EaOwH1bx49dEsbQM6JY0q2
         tt3CxtpQFRWCgs1YcCf59oV82Sss663tZJhUJfj9sRNSla4Q40sXRW8ewBIWzb4A9l8S
         payzUUOQA52An/Ng3ie75+detcANzNCmgzEH6W+lVqjnbVYpcDzGmNz2fWFq6NGRK9RW
         dWP7qH5y5WRGndesIr5WehhcLQKiYsEVYoP+c1unPljkPoQvRrH4s1IAmG2DLfQ8HaDA
         AJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=leyno95cobAtAcNQFGrlVZ0utmyIUUJFgDrYtk3rO3A=;
        b=J5IClMlquMLwJ6CnqekGvGdbXCya0KDlW8iPaZwM3RvGf7SvXEV8/07ZzicG7pAd9G
         JRkDWymOK6HRF5lCc2FuytGv5GEEcD+y2LaLb4NQujdt1cJ1kE6TY7EqhsZKfYWvgnck
         wbETP599hwoXN9gkIdjk9hvdb3Zj0Ps2UFjcni+wjjWwseOhgEqvdBewheQ2P25oCk8X
         HCZlGVp3XjYKZbs4ojAjVad/1x10gzdeQpD6ikKn52UwD6cq0U5hJV98nbEGVwGJNgJv
         WQrXC81bIB4VpsoWayjhNSMXo3r5mHNPx2PDeoHcDU7AuxouD800RJMYW4gx5SOSQQ3g
         09Ig==
X-Gm-Message-State: APjAAAVigueoBsC/zV/t0jMbTl0kajWUn6LPQmNQRroA4qE6s5OSwpt1
        Lit/8jwF0/UXIxu5mWJisRaFzA==
X-Google-Smtp-Source: APXvYqw+bW5EqKGykBiDWFo04XmcY84U5/oexdvpR3ClTdeonThzRPh5LAsuxd9zv9R1t7JndxijgA==
X-Received: by 2002:a17:90a:2223:: with SMTP id c32mr1627110pje.15.1582176539000;
        Wed, 19 Feb 2020 21:28:59 -0800 (PST)
Received: from localhost.localdomain (li1441-214.members.linode.com. [45.118.134.214])
        by smtp.gmail.com with ESMTPSA id l69sm1535663pgd.1.2020.02.19.21.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 21:28:58 -0800 (PST)
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
Subject: [PATCH v5 7/9] perf cs-etm: Fixup exception entry for thread stack
Date:   Thu, 20 Feb 2020 13:26:59 +0800
Message-Id: <20200220052701.7754-8-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220052701.7754-1-leo.yan@linaro.org>
References: <20200220052701.7754-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In theory when an exception is taken, the thread stack is pushed with an
expected return address (ret_addr): from_ip + insn_len; and later when
the exception returns back, it compares the return address (from the new
packet's to_ip) with the ret_addr in the of thread stack, if have the
same values then the thread stack will be popped.

When a branch instruction's target address triggers an exception, the
thread stack's ret_addr is the branch target address plus instruction
length for exception entry; but this branch instruction is not taken,
the exception return address is the branch target address, thus the
thread stack's ret_addr cannot match with the exception return address,
so the thread stack cannot pop properly.

This patch fixes up the ret_addr at the exception entry, when it detects
the exception is triggered by a branch target address, it sets
'insn_len' to zero.  This allows the thread stack can pop properly when
return from exception.

Before:

  # perf script --itrace=g16l64i100

  main  3258        100      instructions:
          ffff800010082c1c el0_sync+0x5c ([kernel.kallsyms])
              ffffad816a14 memcpy+0x4 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
              ffffad800820 _dl_start_final+0x48 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
              ffffad800b00 _dl_start+0x200 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
              ffffad800048 _start+0x8 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
              ffffad800044 _start+0x4 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)

The issues in the output:
memcpy+0x4 => The function call memcpy() causes exception; it's return
              address should be memcpy+0x0.
_start+0x4 => The thread stack is not popped correctly, this is a stale
              data which is left in the previous exception flow.

After:

  # perf script --itrace=g16l64i100

  main  3258        100      instructions:
          ffff800010082c1c el0_sync+0x5c ([kernel.kallsyms])
              ffffad816a10 memcpy+0x0 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
              ffffad800820 _dl_start_final+0x48 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
              ffffad800b00 _dl_start+0x200 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
              ffffad800048 _start+0x8 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index d9c22c145307..4800daf0dc3d 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1160,6 +1160,7 @@ static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
 	u8 trace_chan_id = tidq->trace_chan_id;
 	int insn_len;
 	u64 from_ip, to_ip;
+	u32 flags;
 
 	if (etm->synth_opts.callchain || etm->synth_opts.thread_stack) {
 		from_ip = cs_etm__last_executed_instr(tidq->prev_packet);
@@ -1168,6 +1169,27 @@ static void cs_etm__add_stack_event(struct cs_etm_queue *etmq,
 		insn_len = cs_etm__instr_size(etmq, trace_chan_id,
 					      tidq->prev_packet->isa, from_ip);
 
+		/*
+		 * Fixup the exception entry.
+		 *
+		 * If the packet's start_addr is same with its end_addr, this
+		 * packet was altered from a exception packet to a range packet;
+		 * the detailed info is described in cs_etm__exception(), which
+		 * is used to handle the case for a branch instruction is not
+		 * taken but the branch triggers an exception.
+		 *
+		 * In this case, fixup 'insn_len' to zero so that allow the
+		 * thread stack's return address can match with the exception
+		 * return address, finally can pop up thread stack properly when
+		 * return from exception.
+		 */
+		flags = PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL |
+			PERF_IP_FLAG_INTERRUPT;
+		if (tidq->prev_packet->flags == flags &&
+		    tidq->prev_packet->start_addr ==
+		    tidq->prev_packet->end_addr)
+			insn_len = 0;
+
 		/*
 		 * Create thread stacks by keeping track of calls and returns;
 		 * any call pushes thread stack, return pops the stack, and
-- 
2.17.1

