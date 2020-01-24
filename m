Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EE8C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 07:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9060C2071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 07:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbgAXHkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 02:40:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54442 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725821AbgAXHkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 02:40:03 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00O7cqtM072454
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 02:40:02 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xqanfk9bh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 02:40:01 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <tmricht@linux.ibm.com>;
        Fri, 24 Jan 2020 07:40:00 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 24 Jan 2020 07:39:57 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00O7dto851576994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jan 2020 07:39:55 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C4065204F;
        Fri, 24 Jan 2020 07:39:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 340A752052;
        Fri, 24 Jan 2020 07:39:55 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        borntraeger@de.ibm.com
Cc:     gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Test case 66 broken on s390 (lib/traceevent issue)
Date:   Fri, 24 Jan 2020 08:39:41 +0100
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 20012407-0008-0000-0000-0000034C3D1D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012407-0009-0000-0000-00004A6CABE2
Message-Id: <20200124073941.39119-1-tmricht@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-24_01:2020-01-24,2020-01-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001240062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test case 66 'Use vfs_getname probe to get syscall args filenames'
is broken on s390, but works on x86. The test case fails with:

 [root@m35lp76 perf]# perf test -F 66
 66: Use vfs_getname probe to get syscall args filenames
           :Recording open file:
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.004 MB /tmp/__perf_test.perf.data.TCdYj\
	 (20 samples) ]
 Looking at perf.data file for vfs_getname records for the file we touched:
  FAILED!
  [root@m35lp76 perf]#

The root cause of this failure has to do with
commit 88903c464321c ("tracing/probe: Add ustring type for user-space string")
and these changes:
   +         if (strcmp(parg->type->name, "string") == 0)
   +                 fmt = ", __get_str(%s)";
   +          else
   +                 fmt = ", REC->%s";

On x86 __get_str() function is used to print the file name. This is ok
for x86 because kernel and user space are in the same adddress space,
the high bit of the address determines kernel vs user space addresses.

This approach does not work on s390. On s390 kernel und user space are
in different address spaces, both start with address 0x0. Which address
space is currently active is stored in the processor status word (PSW).

Therefore s390 must use 'ustring' for lookup of filename in the user
space address space.

Setting up the kprobe event using perf command:

 # ./perf probe "vfs_getname=getname_flags:72 pathname=filename:ustring"

generates this format file:
  [root@m35lp76 perf]# cat /sys/kernel/debug/tracing/events/probe/\
	  vfs_getname/format
  name: vfs_getname
  ID: 1172
  format:
    field:unsigned short common_type; offset:0; size:2; signed:0;
    field:unsigned char common_flags; offset:2; size:1; signed:0;
    field:unsigned char common_preempt_count; offset:3; size:1; signed:0;
    field:int common_pid; offset:4; size:4; signed:1;

    field:unsigned long __probe_ip; offset:8; size:8; signed:0;
    field:__data_loc char[] pathname; offset:16; size:4; signed:1;

    print fmt: "(%lx) pathname=\"%s\"", REC->__probe_ip, REC->pathname
 [root@m35lp76 perf]#

The difference between 'ustring' and 'string' is the print fmt statement
in the last line. Using 'string' generates

  print fmt: "(%lx) pathname=\"%s\"", REC->__probe_ip, __get_str(pathname)

This does not work on s390 because __get_str() function does not
know the address space currently being used.

This is the command to generate the perf.data file:

 # ./perf record -e probe:vfs_getname -- touch /tmp/xxx

This command creates the perf.data file which contains the contents
for the kprobe event format file. The call chain is:

  main
  ....
  perf_session__open
  perf_header__process_sections (feature 1 tracing)
  perf_file_section__process
  trace_report
  read_event_files
  read_event_file
  parse_event_file
  tep_parse_event  --> now in lib/traceevent/event-parse.c
  __parse_event
  tep_parse_format
  event_read_format
  event_read_print
  event_read_print_args
  process_args
  process_arg_token --> processes REC->xxx entry of event format file
                        'print fmt' line
  process_entry --> generates argument of type TEP_PRINT_FIELD entry
                    with TEP_FIELD_IS_STRING set in arg->field.field->flags
		    member

Now the difference in the format file between
   [x86] print fmt: "(%lx) pathname=\"%s\"", ...,  __get_str(pathname)
and
   [s390] print fmt: "(%lx) pathname=\"%s\"", ...,  REC->pathname
comes into play.

In the x86 case the function process_arg_token()
handles in the case TEP_EVENT_ITEM the token "__get_str" and calls
functions

  process_function()
  +--> process_str()

and creates a print argument structure struct tep_print_arg with
type TEP_PRINT_STRING.
This is handled correctly when perf report later prints the argument using
function print_str_arg() in file lib/traceevent/event-parse.c
I omit the 35+ plus function call stack of the gdb where command.

In the s390 case the function process_arg_token()
handles in the case TEP_EVENT_ITEM the token "REC" and calls
function
  process_entry()

This creates a print argument structure struct tep_print_arg with
type TEP_PRINT_FIELD and bit TEP_FIELD_IS_STRING set in flags.

This is handled ***incorrectly** when perf report later prints the
argument using function print_str_arg() in file
lib/traceevent/event-parse.c. There is no support to print a string
when type is TEP_PRINT_FIELD and bit TEP_FIELD_IS_STRING inflags is set.
Again I omit the 35+ plus function call stack of the gdb where command.

Output before:
  [root@m35lp76 perf]# perf report --stdio | egrep '^(# Samp| +[1-9.])+'
  # Samples: 20  of event 'probe:vfs_getname'
  100.00%  (4d2c32) pathname=""

Output after:
  [root@m35lp76 perf]# ./perf report --stdio | egrep '^(# Samp| +[1-9.])+'
  # Samples: 20  of event 'probe:vfs_getname'
  5.00%  (4d2c32) pathname="/etc/ld.so.cache"
  5.00%  (4d2c32) pathname="/etc/ld.so.preload"
  5.00%  (4d2c32) pathname="/lib64/libc.so.6"
  5.00%  (4d2c32) pathname="/tmp/xxx"
  5.00%  (4d2c32) pathname="/usr/lib/locale/en_US.utf8/LC_ADDRESS"
  5.00%  (4d2c32) pathname="/usr/lib/locale/en_US.utf8/LC_COLLATE"
  5.00%  (4d2c32) pathname="/usr/lib/locale/en_US.utf8/LC_CTYPE"
  5.00%  (4d2c32) pathname="/usr/lib/locale/en_US.utf8/LC_IDENTIFICATION"
  5.00%  (4d2c32) pathname="/usr/lib/locale/en_US.utf8/LC_MEASUREMENT"
  5.00%  (4d2c32) pathname="/usr/lib/locale/en_US.utf8/LC_MESSAGES"
  5.00%  (4d2c32) pathname="/usr/lib/locale/en_US.utf8/LC_MESSAGES/SYS_LC_MESSAGES"
  5.00%  (4d2c32) pathname="/usr/lib/locale/en_US.utf8/LC_MONETARY"
  5.00%  (4d2c32) pathname="/usr/lib/locale/en_US.utf8/LC_NAME"
  5.00%  (4d2c32) pathname="/usr/lib/locale/en_US.utf8/LC_NUMERIC"
  5.00%  (4d2c32) pathname="/usr/lib/locale/en_US.utf8/LC_PAPER"
  5.00%  (4d2c32) pathname="/usr/lib/locale/en_US.utf8/LC_TELEPHONE"
  5.00%  (4d2c32) pathname="/usr/lib/locale/en_US.utf8/LC_TIME"
  5.00%  (4d2c32) pathname="/usr/lib/locale/locale-archive"
  5.00%  (4d2c32) pathname="/usr/lib64/gconv/gconv-modules.cache"
  5.00%  (4d2c32) pathname="/usr/share/locale/locale.alias"
  [root@m35lp76 perf]#

Fix this by adding print string support for TEP_FIELD_IS_STRING
bit set in flags and case TEP_PRINT_FIELD.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/lib/traceevent/event-parse.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index beaa8b8c08ff..68334f860b27 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -4003,6 +4003,15 @@ static void print_str_arg(struct trace_seq *s, void *data, int size,
 				trace_seq_printf(s, "%llx", addr);
 			break;
 		}
+		if (field->flags & TEP_FIELD_IS_STRING) {
+			int str_offset;
+
+			str_offset = tep_data2host4(tep, *(unsigned int *)(data + arg->field.field->offset));
+			str_offset &= 0xffff;
+			print_str_to_seq(s, format, len_arg,
+					 ((char *)data) + str_offset);
+			break;
+		}
 		str = malloc(len + 1);
 		if (!str) {
 			do_warning_event(event, "%s: not enough memory!",
-- 
2.21.0

