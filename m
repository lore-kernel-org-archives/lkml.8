Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBCAC2BA18
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE8020842
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgDDIm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 04:42:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41774 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgDDImV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 04:42:21 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeNW-0001M7-SW; Sat, 04 Apr 2020 10:42:10 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 548E71C07F3;
        Sat,  4 Apr 2020 10:42:04 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:42:03 -0000
From:   "tip-bot2 for Jin Yao" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf report: Print al_addr when symbol is not found
Cc:     Jin Yao <yao.jin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200227043939.4403-2-yao.jin@linux.intel.com>
References: <20200227043939.4403-2-yao.jin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <158598972387.28353.17069125196597189631.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     443bc639e518c6c4e8fc2e0456cccf3a04f6e77f
Gitweb:        https://git.kernel.org/tip/443bc639e518c6c4e8fc2e0456cccf3a04f6e77f
Author:        Jin Yao <yao.jin@linux.intel.com>
AuthorDate:    Thu, 27 Feb 2020 12:39:37 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 23 Mar 2020 11:08:29 -03:00

perf report: Print al_addr when symbol is not found

For branch mode, if the symbol is not found, it prints
the address.

For example, 0x0000555eee0365a0 in below output.

  Overhead  Command  Source Shared Object  Source Symbol                            Target Symbol
    17.55%  div      libc-2.27.so          [.] __random                             [.] __random
     6.11%  div      div                   [.] 0x0000555eee0365a0                   [.] rand
     6.10%  div      libc-2.27.so          [.] rand                                 [.] 0x0000555eee036769
     5.80%  div      libc-2.27.so          [.] __random_r                           [.] __random
     5.72%  div      libc-2.27.so          [.] __random                             [.] __random_r
     5.62%  div      libc-2.27.so          [.] __random_r                           [.] __random_r
     5.38%  div      libc-2.27.so          [.] __random                             [.] rand
     4.56%  div      libc-2.27.so          [.] __random                             [.] __random
     4.49%  div      div                   [.] 0x0000555eee036779                   [.] 0x0000555eee0365ff
     4.25%  div      div                   [.] 0x0000555eee0365fa                   [.] 0x0000555eee036760

But it's not very easy to understand what the instructions
are in the binary. So this patch uses the al_addr instead.

With this patch, the output is

  Overhead  Command  Source Shared Object  Source Symbol                            Target Symbol
    17.55%  div      libc-2.27.so          [.] __random                             [.] __random
     6.11%  div      div                   [.] 0x00000000000005a0                   [.] rand
     6.10%  div      libc-2.27.so          [.] rand                                 [.] 0x0000000000000769
     5.80%  div      libc-2.27.so          [.] __random_r                           [.] __random
     5.72%  div      libc-2.27.so          [.] __random                             [.] __random_r
     5.62%  div      libc-2.27.so          [.] __random_r                           [.] __random_r
     5.38%  div      libc-2.27.so          [.] __random                             [.] rand
     4.56%  div      libc-2.27.so          [.] __random                             [.] __random
     4.49%  div      div                   [.] 0x0000000000000779                   [.] 0x00000000000005ff
     4.25%  div      div                   [.] 0x00000000000005fa                   [.] 0x0000000000000760

Now we can use objdump to dump the object starting from 0x5a0.

For example,
objdump -d --start-address 0x5a0 div

00000000000005a0 <rand@plt>:
 5a0:   ff 25 2a 0a 20 00       jmpq   *0x200a2a(%rip)        # 200fd0 <__cxa_finalize@plt+0x200a20>
 5a6:   68 02 00 00 00          pushq  $0x2
 5ab:   e9 c0 ff ff ff          jmpq   570 <srand@plt-0x10>
 ...

Committer testing:

  [root@seventh ~]# perf record -a -b sleep 1
  [root@seventh ~]# perf report --header-only | grep cpudesc
  # cpudesc : Intel(R) Core(TM) i5-7500 CPU @ 3.40GHz
  [root@seventh ~]# perf evlist -v
  cycles: size: 120, { sample_period, sample_freq }: 4000, sample_type: IP|TID|TIME|CPU|PERIOD|BRANCH_STACK, read_format: ID, disabled: 1, inherit: 1, mmap: 1, comm: 1, freq: 1, task: 1, precise_ip: 3, sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, bpf_event: 1, branch_sample_type: ANY
  [root@seventh ~]#

Before:

  [root@seventh ~]# perf report --stdio --dso libsystemd-shared-241.so | head -20
  # To display the perf.data header info, please use --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 2K of event 'cycles'
  # Event count (approx.): 2240
  #
  # Overhead  Command          Source Shared Object      Source Symbol           Target Symbol           Basic Block Cycles
  # ........  ...............  ........................  ......................  ......................  ..................
  #
       0.13%  systemd-journal  libc-2.29.so              [.] cfree@GLIBC_2.2.5   [.] _int_free           1
       0.09%  systemd          libsystemd-shared-241.so  [.] 0x00007fe406465c82  [.] 0x00007fe406465d80  1
       0.09%  systemd          libsystemd-shared-241.so  [.] 0x00007fe406465ded  [.] 0x00007fe406465c30  1
       0.09%  systemd          libsystemd-shared-241.so  [.] 0x00007fe406465e4e  [.] 0x00007fe406465de0  1
       0.09%  systemd-journal  systemd-journald          [.] free@plt            [.] cfree@GLIBC_2.2.5   1
       0.09%  systemd-journal  libc-2.29.so              [.] _int_free           [.] _int_free           18
       0.09%  systemd-journal  libc-2.29.so              [.] _int_free           [.] _int_free           2
       0.04%  systemd          libsystemd-shared-241.so  [.] bus_resolve@plt     [.] bus_resolve         204
       0.04%  systemd          libsystemd-shared-241.so  [.] getpid_cached@plt   [.] getpid_cached       7
  [root@seventh ~]#

After:

  [root@seventh ~]# perf report --stdio --dso libsystemd-shared-241.so | head -20
  # To display the perf.data header info, please use --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 2K of event 'cycles'
  # Event count (approx.): 2240
  #
  # Overhead  Command          Source Shared Object      Source Symbol           Target Symbol           Basic Block Cycles
  # ........  ...............  ........................  ......................  ......................  ..................
  #
       0.13%  systemd-journal  libc-2.29.so              [.] cfree@GLIBC_2.2.5   [.] _int_free           1
       0.09%  systemd          libsystemd-shared-241.so  [.] 0x00000000000f7c82  [.] 0x00000000000f7d80  1
       0.09%  systemd          libsystemd-shared-241.so  [.] 0x00000000000f7ded  [.] 0x00000000000f7c30  1
       0.09%  systemd          libsystemd-shared-241.so  [.] 0x00000000000f7e4e  [.] 0x00000000000f7de0  1
       0.09%  systemd-journal  systemd-journald          [.] free@plt            [.] cfree@GLIBC_2.2.5   1
       0.09%  systemd-journal  libc-2.29.so              [.] _int_free           [.] _int_free           18
       0.09%  systemd-journal  libc-2.29.so              [.] _int_free           [.] _int_free           2
       0.04%  systemd          libsystemd-shared-241.so  [.] bus_resolve@plt     [.] bus_resolve         204
       0.04%  systemd          libsystemd-shared-241.so  [.] getpid_cached@plt   [.] getpid_cached       7
  [root@seventh ~]#

Lets use -v to get full paths and then try objdump on the unresolved address:

  [root@seventh ~]# perf report -v --stdio --dso libsystemd-shared-241.so |& grep libsystemd-shared-241.so | tail -1
     0.04% systemd-journal /usr/lib/systemd/libsystemd-shared-241.so 0x80c1a B [.] 0x0000000000080c1a 0x80a95 B [.] 0x0000000000080a95 61
  [root@seventh ~]#

  [root@seventh ~]# objdump -d --start-address 0x00000000000f7d80 /usr/lib/systemd/libsystemd-shared-241.so | head -20

  /usr/lib/systemd/libsystemd-shared-241.so:     file format elf64-x86-64

  Disassembly of section .text:

  00000000000f7d80 <proc_cmdline_parse_given@@SD_SHARED+0x330>:
     f7d80:	41 39 11             	cmp    %edx,(%r9)
     f7d83:	0f 84 ff fe ff ff    	je     f7c88 <proc_cmdline_parse_given@@SD_SHARED+0x238>
     f7d89:	4c 8d 05 97 09 0c 00 	lea    0xc0997(%rip),%r8        # 1b8727 <utf8_skip_data@@SD_SHARED+0x3147>
     f7d90:	b9 49 00 00 00       	mov    $0x49,%ecx
     f7d95:	48 8d 15 c9 f5 0b 00 	lea    0xbf5c9(%rip),%rdx        # 1b7365 <utf8_skip_data@@SD_SHARED+0x1d85>
     f7d9c:	31 ff                	xor    %edi,%edi
     f7d9e:	48 8d 35 9b ff 0b 00 	lea    0xbff9b(%rip),%rsi        # 1b7d40 <utf8_skip_data@@SD_SHARED+0x2760>
     f7da5:	e8 a6 d6 f4 ff       	callq  45450 <log_assert_failed_realm@plt>
     f7daa:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
     f7db0:	41 56                	push   %r14
     f7db2:	41 55                	push   %r13
     f7db4:	41 54                	push   %r12
     f7db6:	55                   	push   %rbp
  [root@seventh ~]#

If we tried the the reported address before this patch:

  [root@seventh ~]# objdump -d --start-address 0x00007fe406465d80 /usr/lib/systemd/libsystemd-shared-241.so | head -20

  /usr/lib/systemd/libsystemd-shared-241.so:     file format elf64-x86-64

  [root@seventh ~]#

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200227043939.4403-2-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/sort.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index ab0cfd7..e860595 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -869,7 +869,8 @@ static int hist_entry__sym_from_snprintf(struct hist_entry *he, char *bf,
 	if (he->branch_info) {
 		struct addr_map_symbol *from = &he->branch_info->from;
 
-		return _hist_entry__sym_snprintf(&from->ms, from->addr, he->level, bf, size, width);
+		return _hist_entry__sym_snprintf(&from->ms, from->al_addr,
+						 he->level, bf, size, width);
 	}
 
 	return repsep_snprintf(bf, size, "%-*.*s", width, width, "N/A");
@@ -881,7 +882,8 @@ static int hist_entry__sym_to_snprintf(struct hist_entry *he, char *bf,
 	if (he->branch_info) {
 		struct addr_map_symbol *to = &he->branch_info->to;
 
-		return _hist_entry__sym_snprintf(&to->ms, to->addr, he->level, bf, size, width);
+		return _hist_entry__sym_snprintf(&to->ms, to->al_addr,
+						 he->level, bf, size, width);
 	}
 
 	return repsep_snprintf(bf, size, "%-*.*s", width, width, "N/A");
