Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298FFC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF22D2068E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778615;
	bh=Pio6T+xY2i1QC/htIeXnBVegxA7Xf7NA0Iu5+6b4sC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FM38m/edAhVTWsiucFZ4UbYAAERzVBPKuo6nYhCooaPTQuxqhQhe9l9IjuD3+Pkcy
	 EPB024V/HaLeWLsJ/TFKtr5aRqYoDhh0xdMnrVqK8UStVMw981q3g9SSsTxPVcLUw9
	 Tn6cd1ztpPYMe7glIKdus9rc3icwCzUYM71akAF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbgEFPXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:23:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729693AbgEFPXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:23:30 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52269215A4;
        Wed,  6 May 2020 15:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778609;
        bh=Pio6T+xY2i1QC/htIeXnBVegxA7Xf7NA0Iu5+6b4sC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dV0JNXiY/pktesHWn+6d6BsJPxH/ctGy4C3pUYppmBJXFmK/FEWnbeNu54FaV2c/h
         ocpel7gRPw2sGTS2c8xQcyBxbsX5zl4fdagZtNxEtrceY8KiqA7EvdrFgxZNcT+CUI
         kxnAVoEs7M8anc3Rn87rF58jqCn/u14DpRxzbhRQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 12/91] perf script: Remove extraneous newline in perf_sample__fprintf_regs()
Date:   Wed,  6 May 2020 12:21:15 -0300
Message-Id: <20200506152234.21977-13-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

When printing iregs, there was a double newline printed because
perf_sample__fprintf_regs() was printing its own and then at the end of
all fields, perf script was adding one.  This was causing blank line in
the output:

Before:

  $ perf script -Fip,iregs
             401b8d ABI:2    DX:0x100    SI:0x4a8340    DI:0x4a9340

             401b8d ABI:2    DX:0x100    SI:0x4a9340    DI:0x4a8340

             401b8d ABI:2    DX:0x100    SI:0x4a8340    DI:0x4a9340

             401b8d ABI:2    DX:0x100    SI:0x4a9340    DI:0x4a8340

After:

  $ perf script -Fip,iregs
             401b8d ABI:2    DX:0x100    SI:0x4a8340    DI:0x4a9340
             401b8d ABI:2    DX:0x100    SI:0x4a9340    DI:0x4a8340
             401b8d ABI:2    DX:0x100    SI:0x4a8340    DI:0x4a9340

Committer testing:

First we need to figure out how to request that registers be recorded,
so we use:

  # perf record -h reg

   Usage: perf record [<options>] [<command>]
      or: perf record [<options>] -- <command> [<options>]

      -I, --intr-regs[=<any register>]
                            sample selected machine registers on interrupt, use '-I?' to list register names
          --buildid-all     Record build-id of all DSOs regardless of hits
          --user-regs[=<any register>]
                            sample selected machine registers on interrupt, use '--user-regs=?' to list register names

  #

Ok, now lets ask for them all:

  # perf record -a --intr-regs --user-regs sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 4.105 MB perf.data (2760 samples) ]
  #

Lets look at the first 6 output lines:

  # perf script -Fip,iregs | head -6
   ffffffff8a06f2f4 ABI:2    AX:0xffffd168fee0a980    BX:0xffff8a23b087f000    CX:0xfffeb69aaeb25d73    DX:0xffff8a253e8310f0    SI:0xfffffff9bafe7359    DI:0xffffb1690204fb10    BP:0xffffd168fee0a950    SP:0xffffb1690204fb88    IP:0xffffffff8a06f2f4 FLAGS:0x4e    CS:0x10    SS:0x18    R8:0x1495f0a91129a    R9:0xffff8a23b087f000   R10:0x1   R11:0xffffffff   R12:0x0   R13:0xffff8a253e827e00   R14:0xffffd168fee0aa5c   R15:0xffffd168fee0a980

   ffffffff8a06f2f4 ABI:2    AX:0x0    BX:0xffffd168fee0a950    CX:0x5684cc1118491900    DX:0x0    SI:0xffffd168fee0a9d0    DI:0x202    BP:0xffffb1690204fd70    SP:0xffffb1690204fd20    IP:0xffffffff8a06f2f4 FLAGS:0x24e    CS:0x10    SS:0x18    R8:0x0    R9:0xffffd168fee0a9d0   R10:0x1   R11:0xffffffff   R12:0xffffffff8a23e480   R13:0xffff8a23b087f240   R14:0xffff8a23b087f000   R15:0xffffd168fee0a950

   ffffffff8a06f2f4 ABI:2    AX:0x0    BX:0x0    CX:0x7f25f334335b    DX:0x0    SI:0x2400    DI:0x4    BP:0x7fff5f264570    SP:0x7fff5f264538    IP:0xffffffff8a06f2f4 FLAGS:0x24e    CS:0x10    SS:0x2b    R8:0x0    R9:0x2312d20   R10:0x0   R11:0x246   R12:0x22cc0e0   R13:0x0   R14:0x0   R15:0x22d0780

  #

Reproduced, apply the patch and:

[root@five ~]# perf script -Fip,iregs | head -6
 ffffffff8a06f2f4 ABI:2    AX:0xffffd168fee0a980    BX:0xffff8a23b087f000    CX:0xfffeb69aaeb25d73    DX:0xffff8a253e8310f0    SI:0xfffffff9bafe7359    DI:0xffffb1690204fb10    BP:0xffffd168fee0a950    SP:0xffffb1690204fb88    IP:0xffffffff8a06f2f4 FLAGS:0x4e    CS:0x10    SS:0x18    R8:0x1495f0a91129a    R9:0xffff8a23b087f000   R10:0x1   R11:0xffffffff   R12:0x0   R13:0xffff8a253e827e00   R14:0xffffd168fee0aa5c   R15:0xffffd168fee0a980
 ffffffff8a06f2f4 ABI:2    AX:0x0    BX:0xffffd168fee0a950    CX:0x5684cc1118491900    DX:0x0    SI:0xffffd168fee0a9d0    DI:0x202    BP:0xffffb1690204fd70    SP:0xffffb1690204fd20    IP:0xffffffff8a06f2f4 FLAGS:0x24e    CS:0x10    SS:0x18    R8:0x0    R9:0xffffd168fee0a9d0   R10:0x1   R11:0xffffffff   R12:0xffffffff8a23e480   R13:0xffff8a23b087f240   R14:0xffff8a23b087f000   R15:0xffffd168fee0a950
 ffffffff8a06f2f4 ABI:2    AX:0x0    BX:0x0    CX:0x7f25f334335b    DX:0x0    SI:0x2400    DI:0x4    BP:0x7fff5f264570    SP:0x7fff5f264538    IP:0xffffffff8a06f2f4 FLAGS:0x24e    CS:0x10    SS:0x2b    R8:0x0    R9:0x2312d20   R10:0x0   R11:0x246   R12:0x22cc0e0   R13:0x0   R14:0x0   R15:0x22d0780
 ffffffff8a24074b ABI:2    AX:0xcb    BX:0xcb    CX:0x0    DX:0x0    SI:0xffffb1690204ff58    DI:0xcb    BP:0xffffb1690204ff58    SP:0xffffb1690204ff40    IP:0xffffffff8a24074b FLAGS:0x24e    CS:0x10    SS:0x18    R8:0x0    R9:0x0   R10:0x0   R11:0x0   R12:0x0   R13:0x0   R14:0x0   R15:0x0
 ffffffff8a310600 ABI:2    AX:0x0    BX:0xffffffff8b8c39a0    CX:0x0    DX:0xffff8a2503890300    SI:0xffffb1690204ff20    DI:0xffff8a23e4080000    BP:0xffff8a23e4080000    SP:0xffffb1690204fec0    IP:0xffffffff8a310600 FLAGS:0x28e    CS:0x10    SS:0x18    R8:0x0    R9:0x0   R10:0x0   R11:0x0   R12:0xffffffffffffffea   R13:0xffff8a23e4080020   R14:0x0   R15:0x0
 ffffffff8a11b688 ABI:2    AX:0x0    BX:0xffff8a237b7c8800    CX:0xffffb1690204fae0    DX:0x78    SI:0xffff8a237b7c8800    DI:0xffffb1690204fa10    BP:0xffffb1690204fb00    SP:0xffffb1690204fa00    IP:0xffffffff8a11b688 FLAGS:0x8a    CS:0x10    SS:0x18    R8:0x1495f0a917eba    R9:0xffffd168fde19a48   R10:0xffffb1690204fd98   R11:0xffff8a253e82afb0   R12:0xffff8a237b7c8800   R13:0xffffb1690204fb00   R14:0x0   R15:0xffff8a237b7c8800
[root@five ~]#

To see it more clearly, lets get just two of those registers by sample:

  # perf record -a --intr-regs=ax,bx --user-regs=cx,dx sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 3.502 MB perf.data (1653 samples) ]
  #

Extra info, lets see what gets setup in that 'struct perf_event_attr':

  # perf evlist -v
  cycles: size: 120, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CPU|PERIOD|REGS_USER|REGS_INTR, read_format: ID, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, task: 1, precise_ip: 2, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1, sample_regs_user: 0xc, sample_regs_intr: 0x3
  #

Cook, some PERF_SAMPLE_REGS_USER|PERF_SAMPLE_REGS_INTR +
attr.sample_regs_user and attr.sample_regs_intr register masks, now lets
see if those newlines are gone in a more compact fashion:

  # perf script -Fip,iregs,uregs
   ffffffff8a56df78 ABI:2    AX:0xffff8a25137b6028    BX:0xffff8a2502f18000  ABI:2    CX:0x7f204460e49b    DX:0xf42920
   ffffffff8a56df78 ABI:2    AX:0xffff8a25137b6028    BX:0xffff8a2502f18000  ABI:2    CX:0x7f204460e49b    DX:0xf42920
   ffffffff8a56df78 ABI:2    AX:0xffff8a25137b6028    BX:0xffff8a2502f18000  ABI:2    CX:0x7f204460e49b    DX:0xf42920
   ffffffff8a56df78 ABI:2    AX:0xffff8a25137b6028    BX:0xffff8a2502f18000  ABI:2    CX:0x7f204460e49b    DX:0xf42920
   ffffffff8a56df78 ABI:2    AX:0xffff8a25137b6028    BX:0xffff8a2502f18000  ABI:2    CX:0x7f204460e49b    DX:0xf42920
   ffffffff8a56df78 ABI:2    AX:0xffff8a25137b6028    BX:0xffff8a2502f18000  ABI:2    CX:0x7f204460e49b    DX:0xf42920
   ffffffff8a29b78d ABI:2    AX:0x2a20ffcd6000    BX:0x2ec7d9000  ABI:2    CX:0x7f204460e49b    DX:0xf42920
  #

And where was that?

  # perf script -Fip,iregs,uregs,sym,dso
   ffffffff8a56df78 strrchr (/lib/modules/5.7.0-rc2/build/vmlinux) ABI:2    AX:0xffff8a25137b6028    BX:0xffff8a2502f18000  ABI:2    CX:0x7f204460e49b    DX:0xf42920
   ffffffff8a56df78 strrchr (/lib/modules/5.7.0-rc2/build/vmlinux) ABI:2    AX:0xffff8a25137b6028    BX:0xffff8a2502f18000  ABI:2    CX:0x7f204460e49b    DX:0xf42920
   ffffffff8a56df78 strrchr (/lib/modules/5.7.0-rc2/build/vmlinux) ABI:2    AX:0xffff8a25137b6028    BX:0xffff8a2502f18000  ABI:2    CX:0x7f204460e49b    DX:0xf42920
   ffffffff8a56df78 strrchr (/lib/modules/5.7.0-rc2/build/vmlinux) ABI:2    AX:0xffff8a25137b6028    BX:0xffff8a2502f18000  ABI:2    CX:0x7f204460e49b    DX:0xf42920
   ffffffff8a56df78 strrchr (/lib/modules/5.7.0-rc2/build/vmlinux) ABI:2    AX:0xffff8a25137b6028    BX:0xffff8a2502f18000  ABI:2    CX:0x7f204460e49b    DX:0xf42920
   ffffffff8a56df78 strrchr (/lib/modules/5.7.0-rc2/build/vmlinux) ABI:2    AX:0xffff8a25137b6028    BX:0xffff8a2502f18000  ABI:2    CX:0x7f204460e49b    DX:0xf42920
   ffffffff8a29b78d __vma_link_rb (/lib/modules/5.7.0-rc2/build/vmlinux) ABI:2    AX:0x2a20ffcd6000    BX:0x2ec7d9000  ABI:2    CX:0x7f204460e49b    DX:0xf42920
  #

Signed-off-by: Stephane Eranian <eranian@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200418231908.152212-1-eranian@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index a2236542900d..3aadefd2791e 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -604,8 +604,6 @@ static int perf_sample__fprintf_regs(struct regs_dump *regs, uint64_t mask,
 		printed += fprintf(fp, "%5s:0x%"PRIx64" ", perf_reg_name(r), val);
 	}
 
-	fprintf(fp, "\n");
-
 	return printed;
 }
 
-- 
2.21.1

