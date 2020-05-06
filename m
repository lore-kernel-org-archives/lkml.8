Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29949C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 067DC2068E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778877;
	bh=Ub+hs7ObfrDseE0HXZX5Az3sIufIGM2CLRUZG7uas4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KLRMnUzChgGFo4daeGDxcSUkFRDxY4vouF+CAetJAeBak2A3uV3+zPTj0pjPiC1qd
	 9ndwQGsOBiqXZ/bTUB4bbQ9IFzGBdgR9nRHfN/23SnzAdVWFnBMWvbTZ9LMLUrZBzC
	 tnPRwiZHHIQJfhdocP68hZFx2GUtVMBDiyPh90hI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbgEFP14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:27:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730336AbgEFP1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:27:24 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E745D2145D;
        Wed,  6 May 2020 15:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778843;
        bh=Ub+hs7ObfrDseE0HXZX5Az3sIufIGM2CLRUZG7uas4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JC7zZBL3XRU/lmsRBVSec7xXmobVr0WFu+RuB8OtO+uFA0ZGd1pZ/byEX2ISlSKqC
         f7Fa4ykHdHStYPSiD5wYp249wfP2K7iuRUPPfAcMQtAfYdCtNhikJpOc2Xn9Zdes2Y
         HNoJ0b021TMnOkPL7TfKLaK3rH4H05gql3HA4Ck0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 85/91] perf symbol: Fix kernel symbol address display
Date:   Wed,  6 May 2020 12:22:28 -0300
Message-Id: <20200506152234.21977-86-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

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
index dc23b349fff9..c1f8879f92cc 100644
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
-- 
2.21.1

