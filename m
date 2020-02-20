Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1815DC761A6
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D388224672
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 05:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EtbK0CAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgBTF2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 00:28:05 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39465 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgBTF2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 00:28:05 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so1079530plp.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 21:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pg84RLRaY7DJxyDSMPZbGr590RXmwderFKyxMD4qhHs=;
        b=EtbK0CAOmpSbcDPLgIU57J4pbsWiLhgj8PJjJdZUkT36BH423lw50LIBZ6oimhwo7B
         Sjhm6rrzCFDAQPOrbEi+A7hfBFaekC7cvSqEAMqyStPwRunknU0ha98tGQ03tfevo9A+
         r4VTFCl53ETXQjE6gd7Ki9fX1eSQvO5DfTcTkn3YEH/w8SjHHJg/LYjzrDYXjbVFj8HK
         f04gwwD3TNdBl/gSIQhJpnhkay07JdzPRkr9mvDuJCsqZHWjLQW9OW7/2KZ8SGEs7aD0
         apgCLXJrGCbVtX+GUpenNIDBJOvXT2pAJhHSJZitp+SNMesTfr+ypavC1+5PzGtn+suN
         NlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pg84RLRaY7DJxyDSMPZbGr590RXmwderFKyxMD4qhHs=;
        b=Khg7tzG3ot/EnZ2h3jMO42XQ0vSNP08NXWsnrJbSptdy9BQH2YOZxtNGhoOfsQsnxY
         TPiPmJ6WIaGE6YW7ZWyKydrg9os2zAxZ/RoPs1eGGUx4qVTRwooenVjuZ1rj6JFbA58F
         YGzcFNVcG7fYZCbqGHy9gfNJPJ1ubTVck24zv6S1pgpf2gj5Yv8yOTHe1o1JrldLRqN8
         R6ScvYu5WKG4svwy9LbTLxBl+XLIxFBr+AqvMCxhzqwZforju02mYD2zKUl1KCAZgIic
         IMIxOVR8kyCB5lhUoA6gFgA/8E5pL2kl/fb8u9MSrW/0n9CnsvezVxMG+Th9P/8yQnb5
         23Sg==
X-Gm-Message-State: APjAAAU/BYpUBXN0SSx8rtPFVN1wixMb+MG7uCRqmfXXd+KduWbQL1cr
        MF9oIRCVngmvs5N4zTGq96ygWQ==
X-Google-Smtp-Source: APXvYqxAqy48qOzwRndX7scgkAgyTyIDpfAXWYVGedHG10XKIQ8TuGqlP4Smxj6nM85lF99funOyRw==
X-Received: by 2002:a17:902:9a09:: with SMTP id v9mr28636473plp.341.1582176482715;
        Wed, 19 Feb 2020 21:28:02 -0800 (PST)
Received: from localhost.localdomain (li1441-214.members.linode.com. [45.118.134.214])
        by smtp.gmail.com with ESMTPSA id l69sm1535663pgd.1.2020.02.19.21.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 21:28:02 -0800 (PST)
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
Subject: [PATCH v5 2/9] perf cs-etm: Reflect branch prior to exception
Date:   Thu, 20 Feb 2020 13:26:54 +0800
Message-Id: <20200220052701.7754-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200220052701.7754-1-leo.yan@linaro.org>
References: <20200220052701.7754-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a branch instruction is to be executed, if the branch target
address is not mapped into the virtual address space, this branch
instruction will trigger an exception with data abort.  For this case,
CoreSight decoding flow cannot reflect the complete branch flow prior
to exception, and leads the user space addresses inconsistency before
and after the exception handling.

Let's see the detailed explanation for the issue with an example:

  Packet 0: range packet
            start_addr=0xffffad8018a4     end_addr=0xffffad8018ec
  Packet 1: exception packet
            start_addr=0xffffad8018a4     end_addr=0xffffad801910
  Packet 2: range packet
            start_addr=0xffff800010081c00 end_addr=0xffff800010081c18

There have three packets are coming; from packet 0 to packet 1,
CPU tries to branch from 0xffffad8018ec-4 to 0xffffad801910, accessing
the address 0xffffad801910 causes the data abort, so this branch is not
taken and an exception is triggered and jump to 0xffff800010081c00 in
packet 2.

When handle this sequence, it misses a range packet for the branch
between 0xffffad8018ec-4 and 0xffffad801910, so Perf tool cannot
generate a branch sample for it and this might introduce confusion for
the addresses before and after exception handling, since we can see the
exception return address is 0xffffad801910, which is not a sequential
value for the address 0xffffad8018ec-4 before exception was taken.

  0xffffad8018ec-4 -> 0xffff800010081c00: exception is taken ...
  ... exception return back -> 0xffffad801910

To fix this issue, firstly we need to decide which conditions can be
used to distinguish that a branch triggers an exception.  So below
conditions are used to make decision:

  - Check if the exception is a trap by comparing the specific sample
    flag for the exception packet;
  - The exception packet's end address is not same with its previous
    range packet's end address, which implies a branch triggering the
    exception and the branch target address is contained in the
    exception packet's end address.

This patch changes the exception packet to a 'fake' range packet; this
allows to generate an extra branch sample for the branch instruction
prior to the exception (between 0xffffad8018ec-4 and 0xffffad801910).
So finally can get below samples:

  0xffffad8018ec-4 -> 0xffffad801910: branch
  0xffffad801910 -> 0xffff800010081c00: exception is taken ...
  ... exception return back -> 0xffffad801910

Note, this 'fake' range packet will add an extra recording for last
branch array and change the thread stack pushing and popping (if later
supported).  But since 'fake' range packet's instruction length is set
to zero, it doesn't introduce any change for instruction samples.

Before:

  # perf script -F,+flags

             main  3258          1          branches:   int                      ffffad8018e8 dl_main+0x820 (/usr/lib/aarch64-linux-gnu/ld-2.28.so) => ffff800010081c00 vectors+0x400 ([kernel.kallsyms])
             main  3258          1          branches:   jmp                  ffff800010081c20 vectors+0x420 ([kernel.kallsyms]) => ffff800010082bc0 el0_sync+0x0 ([kernel.kallsyms])
             main  3258          1          branches:   jcc                  ffff800010082c8c el0_sync+0xcc ([kernel.kallsyms]) => ffff800010082ca0 el0_sync+0xe0 ([kernel.kallsyms])
             main  3258          1          branches:   jmp                  ffff800010082ca0 el0_sync+0xe0 ([kernel.kallsyms]) => ffff800010082ccc el0_sync+0x10c ([kernel.kallsyms])
             [...]
             main  3258          1          branches:   jcc                  ffff800010083574 finish_ret_to_user+0x34 ([kernel.kallsyms]) => ffff800010083580 finish_ret_to_user+0x40 ([kernel.kallsyms])
             main  3258          1          branches:   jmp                  ffff800010083580 finish_ret_to_user+0x40 ([kernel.kallsyms]) => ffff800010083598 finish_ret_to_user+0x58 ([kernel.kallsyms])
             main  3258          1          branches:   jmp                  ffff800010083598 finish_ret_to_user+0x58 ([kernel.kallsyms]) => ffff8000100835c4 finish_ret_to_user+0x84 ([kernel.kallsyms])
             main  3258          1          branches:   iret                 ffff800010083610 finish_ret_to_user+0xd0 ([kernel.kallsyms]) =>     ffffad801910 dl_main+0x848 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)

After:

  # perf script -F,+flags

             main  3258          1          branches:   jmp                      ffffad8018e8 dl_main+0x820 (/usr/lib/aarch64-linux-gnu/ld-2.28.so) =>     ffffad801910 dl_main+0x848 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
             main  3258          1          branches:   int                      ffffad801910 dl_main+0x848 (/usr/lib/aarch64-linux-gnu/ld-2.28.so) => ffff800010081c00 vectors+0x400 ([kernel.kallsyms])
             main  3258          1          branches:   jmp                  ffff800010081c20 vectors+0x420 ([kernel.kallsyms]) => ffff800010082bc0 el0_sync+0x0 ([kernel.kallsyms])
             main  3258          1          branches:   jcc                  ffff800010082c8c el0_sync+0xcc ([kernel.kallsyms]) => ffff800010082ca0 el0_sync+0xe0 ([kernel.kallsyms])
             main  3258          1          branches:   jmp                  ffff800010082ca0 el0_sync+0xe0 ([kernel.kallsyms]) => ffff800010082ccc el0_sync+0x10c ([kernel.kallsyms])
             [...]
             main  3258          1          branches:   jcc                  ffff800010083574 finish_ret_to_user+0x34 ([kernel.kallsyms]) => ffff800010083580 finish_ret_to_user+0x40 ([kernel.kallsyms])
             main  3258          1          branches:   jmp                  ffff800010083580 finish_ret_to_user+0x40 ([kernel.kallsyms]) => ffff800010083598 finish_ret_to_user+0x58 ([kernel.kallsyms])
             main  3258          1          branches:   jmp                  ffff800010083598 finish_ret_to_user+0x58 ([kernel.kallsyms]) => ffff8000100835c4 finish_ret_to_user+0x84 ([kernel.kallsyms])
             main  3258          1          branches:   iret                 ffff800010083610 finish_ret_to_user+0xd0 ([kernel.kallsyms]) =>     ffffad801910 dl_main+0x848 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)

Suggested-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  1 +
 tools/perf/util/cs-etm.c                      | 66 ++++++++++++++++++-
 2 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index cd92a99eb89d..f1f66d883391 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -482,6 +482,7 @@ cs_etm_decoder__buffer_exception(struct cs_etm_packet_queue *queue,
 
 	packet = &queue->packet_buffer[queue->tail];
 	packet->exception_number = elem->exception_number;
+	packet->end_addr = elem->en_addr;
 
 	return ret;
 }
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 48932a7a933f..7cf30b5e0e20 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1477,8 +1477,11 @@ static int cs_etm__sample(struct cs_etm_queue *etmq,
 	return 0;
 }
 
-static int cs_etm__exception(struct cs_etm_traceid_queue *tidq)
+static int cs_etm__exception(struct cs_etm_queue *etmq,
+			     struct cs_etm_traceid_queue *tidq)
 {
+	u32 flags;
+
 	/*
 	 * Usually the exception packet follows a range packet, if it's not the
 	 * case, directly bail out.
@@ -1486,6 +1489,65 @@ static int cs_etm__exception(struct cs_etm_traceid_queue *tidq)
 	if (tidq->prev_packet->sample_type != CS_ETM_RANGE)
 		return 0;
 
+	/*
+	 * If the exception is a trap and its end_addr is not same with its
+	 * previous range packet's end_addr, this implies the exception is
+	 * triggered by a branch and the exception packet's end_addr is the
+	 * branch target address from the previous range packet.
+	 *
+	 * Below is an example with three packets:
+	 *   Packet 0: range packet
+	 *             start_addr=0xffffad8018a4     end_addr=0xffffad8018ec
+	 *   Packet 1: exception packet
+	 *             start_addr=0xffffad8018a4     end_addr=0xffffad801910
+	 *   Packet 2: range packet
+	 *             start_addr=0xffff800010081c00 end_addr=0xffff800010081c18
+	 *
+	 * CPU tries to branch from 0xffffad8018ec-4 (packet 0) to
+	 * 0xffffad801910 (packet 1), accessing the address 0xffffad801910
+	 * causes data abort, so the branch is not taken and an exception is
+	 * triggered and jump to 0xffff800010081c00 (packet 2).
+	 *
+	 * For this case, it misses a range packet for the branch between
+	 * 0xffffad8018ec-4 and 0xffffad801910, so perf tool cannot generate
+	 * branch sample and introduces confusion for exception return parsing:
+	 *
+	 *   0xffffad8018ec-4 -> 0xffff800010081c00: exception is taken
+	 *   ... exception return back ... -> 0xffffad801910
+	 *
+	 * To fix this issue, the exception packet is changed to a 'fake'
+	 * range packet.  This can allow to generate a branch sample between
+	 * 0xffffad8018ec-4 and 0xffffad801910.  Finally get below samples:
+	 *
+	 *   0xffffad8018ec-4 -> 0xffffad801910: branch
+	 *   0xffffad801910 -> 0xffff800010081c00: exception is taken
+	 *   ... exception return back ... -> 0xffffad801910
+	 */
+
+	/* Use flags to check if the exception is trap */
+	flags = PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL |
+		PERF_IP_FLAG_INTERRUPT;
+
+	if (tidq->packet->sample_type == CS_ETM_EXCEPTION &&
+	    tidq->packet->flags == flags &&
+	    tidq->packet->end_addr != tidq->prev_packet->end_addr) {
+		/*
+		 * Change the exception packet to a range packet, so can reflect
+		 * branch from prev_packet::end_addr-4 to packet::start_addr;
+		 *
+		 * This branch is not taken yet, so set its instruction count
+		 * to zero.  Set 'last_instr_taken_branch' to true, so allow
+		 * it to generate samples with its seqential range packet.
+		 */
+		tidq->packet->sample_type = CS_ETM_RANGE;
+		tidq->packet->start_addr = tidq->packet->end_addr;
+		tidq->packet->instr_count = 0;
+		tidq->packet->last_instr_taken_branch = true;
+
+		/* Generate sample with the previous range packet */
+		return cs_etm__sample(etmq, tidq);
+	}
+
 	/*
 	 * When the exception packet is inserted, whether the last instruction
 	 * in previous range packet is taken branch or not, we need to force
@@ -2045,7 +2107,7 @@ static int cs_etm__process_traceid_queue(struct cs_etm_queue *etmq,
 			 * make sure the previous instruction
 			 * range packet to be handled properly.
 			 */
-			cs_etm__exception(tidq);
+			cs_etm__exception(etmq, tidq);
 			break;
 		case CS_ETM_DISCONTINUITY:
 			/*
-- 
2.17.1

