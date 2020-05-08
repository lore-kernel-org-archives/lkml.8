Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D467C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3955C24999
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbgEHNEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729385AbgEHNEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:04:47 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7AEC05BD43;
        Fri,  8 May 2020 06:04:47 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gD-000763-KG; Fri, 08 May 2020 15:04:41 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4227B1C0475;
        Fri,  8 May 2020 15:04:41 +0200 (CEST)
Date:   Fri, 08 May 2020 13:04:41 -0000
From:   "tip-bot2 for Thomas Richter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf symbol: Fix kernel symbol address display
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200415070744.59919-1-tmricht@linux.ibm.com>
References: <20200415070744.59919-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <158894308122.8414.10725108204895472441.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     51d9635582c55479bf7904fa47e39aef2b323a50
Gitweb:        https://git.kernel.org/tip/51d9635582c55479bf7904fa47e39aef2b323a50
Author:        Thomas Richter <tmricht@linux.ibm.com>
AuthorDate:    Wed, 15 Apr 2020 09:07:44 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:32 -03:00

perf symbol: Fix kernel symbol address display

Running commands

   ./perf record -e rb0000 -- find .
   ./perf report -v

reveals symbol names and its addresses. There is a mismatch between
kernel symbol and address. Here is an example for kernel symbol
check_chain_key:

 3.55%  find /lib/modules/.../build/vmlinux  0xf11ec  v [k] check_chain_key

This address is off by 0xff000 as can be seen with:

[root@t35lp46 ~]# fgrep check_chain_key /proc/kallsyms
00000000001f00d0 t check_chain_key
[root@t35lp46 ~]# objdump -t ~/linux/vmlinux| fgrep check_chain_key
00000000001f00d0 l     F .text	00000000000001e8 check_chain_key
[root@t35lp46 ~]#

This function is located in main memory 0x1f00d0 - 0x1f02b4. It has
several entries in the perf data file with the correct address:

[root@t35lp46 perf]# ./perf report -D -i perf.data.find-bad | \
				fgrep SAMPLE| fgrep 0x1f01ec
PERF_RECORD_SAMPLE(IP, 0x1): 22228/22228: 0x1f01ec period: 1300000 addr: 0
PERF_RECORD_SAMPLE(IP, 0x1): 22228/22228: 0x1f01ec period: 1300000 addr: 0

The root cause happens when reading symbol tables during perf report.
A long gdb call chain leads to

   machine__deliver_events
     perf_evlist__deliver_event
       perf_evlist__deliver_sample
         build_id__mark_dso_hits
	   thread__find_map(1)      Read correct address from sample entry
	     map__load
	       dso__load            Some more functions to end up in
	         ....
		 dso__load_sym.

Function dso__load_syms  checks for kernel relocation and symbol
adjustment for the kernel and results in kernel map adjustment of
	 kernel .text segment address (0x100000 on s390)
	 kernel .text segment offset in file (0x1000 on s390).
This results in all kernel symbol addresses to be changed by subtracting
0xff000 (on s390). For the symbol check_chain_key we end up with

    0x1f00d0 - 0x100000 + 0x1000 = 0xf11d0

and this address is saved in the perf symbol table. This calculation is
also applied by the mapping functions map__mapip() and map__unmapip()
to map IP addresses to dso mappings.

During perf report processing functions

   process_sample_event    (builtin-report.c)
     machine__resolve
       thread__find_map
     hist_entry_iter_add

are called. Function thread__find_map(1)
takes the correct sample address and applies the mapping function
map__mapip() from the kernel dso and saves the modified address
in struct addr_location for further reference. From now on this address
is used.

Funktion process_sample_event() then calls hist_entry_iter_add() to save
the address in member ip of struct hist_entry.

When samples are displayed using

    perf_evlist__tty_browse_hists
      hists__fprintf
        hist_entry__fprintf
	  hist_entry__snprintf
	    __hist_entry__snprintf
	      _hist_entry__sym_snprintf()

This simply displays the address of the symbol and ignores the dso <-> map
mappings done in function thread__find_map. This leads to the address
mismatch.

Output before:

ot@t35lp46 perf]# ./perf report -v | fgrep check_chain_key
     3.55%  find     /lib/modules/5.6.0d-perf+/build/vmlinux
     						0xf11ec v [k] check_chain_key
[root@t35lp46 perf]#

Output after:

[root@t35lp46 perf]# ./perf report -v | fgrep check_chain_key
     3.55%  find     /lib/modules/5.6.0d-perf+/build/vmlinux
     						0x1f01ec v [k] check_chain_key
[root@t35lp46 perf]#

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Link: http://lore.kernel.org/lkml/20200415070744.59919-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/sort.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index dc23b34..c1f8879 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -300,8 +300,14 @@ static int _hist_entry__sym_snprintf(struct map_symbol *ms,
 
 	if (verbose > 0) {
 		char o = map ? dso__symtab_origin(map->dso) : '!';
+		u64 rip = ip;
+
+		if (map && map->dso && map->dso->kernel
+		    && map->dso->adjust_symbols)
+			rip = map->unmap_ip(map, ip);
+
 		ret += repsep_snprintf(bf, size, "%-#*llx %c ",
-				       BITS_PER_LONG / 4 + 2, ip, o);
+				       BITS_PER_LONG / 4 + 2, rip, o);
 	}
 
 	ret += repsep_snprintf(bf + ret, size - ret, "[%c] ", level);
