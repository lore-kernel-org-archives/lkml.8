Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AE9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85EA82075F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 06:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BjKQaped"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgHYGdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 02:33:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3554 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726940AbgHYGdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 02:33:13 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07P6X9IF192523;
        Tue, 25 Aug 2020 02:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=vvi76QjKyE54oaQ7CT/u9t9c6lCeUf6xh2J5o8z4ZXE=;
 b=BjKQapedO43fu1ynDa1lZUf7eRKLGS2tRgBRgnXVJ5tQCpBprU8I/H3A4EsmIazGtW3C
 Z8zQJ6NxaMusHXb47dsTEdyXeX3g5vecDT4neQD9fEKfxdeXQAUJPA9wlakze8ALhv/D
 gaAF38cfhHqD9w9hPfdDms9x34wXGudyEt6Hu7SSk1SJAgI6QJqlKy5x7SCroUGbC2hl
 VuAvkBNMzehmC7PXVeue7Lmn8axfYVQOAUgUSdIdi8SolU0xWAwlaNenSMrAfsjNrhVa
 +mOOmwz7OWo6hnHxP0I4VVbDGi/djLxMH2iE6rUbCGufhfq5fsPpwYwmT2BR+UjrjTWQ zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 334ugmjuev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 02:33:12 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07P6XBDx192678;
        Tue, 25 Aug 2020 02:33:11 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 334ugmjue8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 02:33:11 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07P6X7Vt028363;
        Tue, 25 Aug 2020 06:33:09 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 33498u91ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 06:33:09 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07P6X6eR30605622
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Aug 2020 06:33:06 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62534AE053;
        Tue, 25 Aug 2020 06:33:06 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12DC8AE051;
        Tue, 25 Aug 2020 06:33:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Aug 2020 06:33:06 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com, jolsa@redhat.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf stat: Fix s390x compile error on F32 utils/stat-display.c
Date:   Tue, 25 Aug 2020 08:33:04 +0200
Message-Id: <20200825063304.77733-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_12:2020-08-24,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008250049
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a compile error on F32 and gcc version 10.1 on s390 in file
utils/stat-display.c.  The error does not show up with make DEBUG=y.
In fact the issue shows up when using both compiler options
-O6 and -D_FORTIFY_SOURCE=2 (which are omitted with DEBUG=Y).

This is the offending call chain:
print_counter_aggr()
  printout(config, -1, 0, ...)  with 2nd parm id set to -1
    aggr_printout(config, x, id --> -1, ...) which leads to this code:
		case AGGR_NONE:
                if (evsel->percore && !config->percore_show_thread) {
                        ....
                } else {
                        fprintf(config->output, "CPU%*d%s",
                                config->csv_output ? 0 : -7,
                                evsel__cpus(evsel)->map[id],
				                        ^^ id is -1 !!!!
                                config->csv_sep);
                }

This is a compiler inlining issue which is detected on s390 but not on
other plattforms.

Output before:
 # make util/stat-display.o
    .....

  util/stat-display.c: In function ‘perf_evlist__print_counters’:
  util/stat-display.c:121:4: error: array subscript -1 is below array
      bounds of ‘int[]’ [-Werror=array-bounds]
  121 |    fprintf(config->output, "CPU%*d%s",
      |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  122 |     config->csv_output ? 0 : -7,
      |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  123 |     evsel__cpus(evsel)->map[id],
      |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  124 |     config->csv_sep);
      |     ~~~~~~~~~~~~~~~~
  In file included from util/evsel.h:13,
                 from util/evlist.h:13,
                 from util/stat-display.c:9:
  /root/linux/tools/lib/perf/include/internal/cpumap.h:10:7:
  note: while referencing ‘map’
   10 |  int  map[];
      |       ^~~
  cc1: all warnings being treated as errors
  mv: cannot stat 'util/.stat-display.o.tmp': No such file or directory
  make[3]: *** [/root/linux/tools/build/Makefile.build:97: util/stat-display.o]
  Error 1
  make[2]: *** [Makefile.perf:716: util/stat-display.o] Error 2
  make[1]: *** [Makefile.perf:231: sub-make] Error 2
  make: *** [Makefile:110: util/stat-display.o] Error 2
  [root@t35lp46 perf]#

Output after:
  # make util/stat-display.o
    .....
  CC       util/stat-display.o
  [root@t35lp46 perf]#

Suggested-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/util/stat-display.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 57d0706e1330..cbe836649f84 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -117,12 +117,11 @@ static void aggr_printout(struct perf_stat_config *config,
 				cpu_map__id_to_die(id),
 				config->csv_output ? 0 : -3,
 				cpu_map__id_to_cpu(id), config->csv_sep);
-		} else {
+		} else if (id > -1)
 			fprintf(config->output, "CPU%*d%s",
 				config->csv_output ? 0 : -7,
 				evsel__cpus(evsel)->map[id],
 				config->csv_sep);
-		}
 		break;
 	case AGGR_THREAD:
 		fprintf(config->output, "%*s-%*d%s",
-- 
2.26.2

