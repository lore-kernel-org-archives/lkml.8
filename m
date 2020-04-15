Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D28C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 07:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEB5F20771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 07:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404414AbgDOHIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 03:08:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25910 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2393655AbgDOHH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 03:07:58 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03F74Bxd063713
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 03:07:57 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30dnmhkhes-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 03:07:57 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Wed, 15 Apr 2020 08:07:19 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 15 Apr 2020 08:07:18 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03F77qlE52822220
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Apr 2020 07:07:52 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B06D4A405B;
        Wed, 15 Apr 2020 07:07:52 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72EF5A4054;
        Wed, 15 Apr 2020 07:07:52 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 15 Apr 2020 07:07:52 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf symbol: Fix kernel symbol address display
Date:   Wed, 15 Apr 2020 09:07:44 +0200
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 20041507-0016-0000-0000-00000304D316
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041507-0017-0000-0000-00003368CF57
Message-Id: <20200415070744.59919-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-15_01:2020-04-14,2020-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 clxscore=1015 mlxscore=0 spamscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004150049
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 tools/perf/util/sort.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index ab0cfd790ad0..0695b3f6460f 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -297,8 +297,14 @@ static int _hist_entry__sym_snprintf(struct map_symbol *ms,
 
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
2.25.1

