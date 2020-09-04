Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6AFC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D85502074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qTKPeI+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbgIDIY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 04:24:58 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:24201 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbgIDIY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 04:24:57 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200904082454epoutp01a6681fdf43b256f43935a354e34bce86~xhxtgSvbI1179311793epoutp01Z
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:24:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200904082454epoutp01a6681fdf43b256f43935a354e34bce86~xhxtgSvbI1179311793epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599207894;
        bh=kKYe8jUDIFfqv+1/UdThRiUK91jwLuikxpfQEkVY5jI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=qTKPeI+QIp2ltpsW5Te2JO6Vc7ZG+Tb6JAByGMO9IcDtJ/mUZcYeVtMVutaq1dc/r
         HIJqWMbaYlXtcmc9aU9ueP3a12NcXZyfBT0G/lTGZ6nWLDuDCqc7mj8oT7hgIF9oRU
         FoZURmN1t1j+IvGPUuUKHaUw6jnEK7FVkCotku00=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20200904082453epcas2p2788c315f8427ad963e05f3eea0ec092e~xhxs9AQuD3180431804epcas2p2K;
        Fri,  4 Sep 2020 08:24:53 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.181]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4BjW1v3kQTzMqYkq; Fri,  4 Sep
        2020 08:24:51 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        AD.B5.19322.1D9F15F5; Fri,  4 Sep 2020 17:24:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20200904082449epcas2p4420d5df2083325b328a182c79f5c0948~xhxo5DRSY0396603966epcas2p4S;
        Fri,  4 Sep 2020 08:24:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200904082449epsmtrp18d3aa913c8087fa00630b448c79c1fa2~xhxo4PbL21800218002epsmtrp1u;
        Fri,  4 Sep 2020 08:24:49 +0000 (GMT)
X-AuditID: b6c32a45-7adff70000004b7a-ff-5f51f9d1b3de
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1B.56.08382.1D9F15F5; Fri,  4 Sep 2020 17:24:49 +0900 (KST)
Received: from tiffany.dsn.sec.samsung.com (unknown [12.36.155.63]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200904082449epsmtip114e75309813ab3940737851a44d00cca~xhxosYFHV0655806558epsmtip1k;
        Fri,  4 Sep 2020 08:24:49 +0000 (GMT)
From:   Changki Kim <changki.kim@samsung.com>
To:     pmladek@suse.com
Cc:     sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        john.ogness@linutronix.de, changbin.du@intel.com,
        masahiroy@kernel.org, rd.dunlap@gmail.com,
        gregkh@linuxfoundation.org, krzk@kernel.org,
        linux-kernel@vger.kernel.org, Changki Kim <changki.kim@samsung.com>
Subject: printk: Add process name information to printk() output.
Date:   Fri,  4 Sep 2020 17:24:38 +0900
Message-Id: <20200904082438.20707-1-changki.kim@samsung.com>
X-Mailer: git-send-email 2.14.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEKsWRmVeSWpSXmKPExsWy7bCmqe7Fn4HxBn1vtSw2XjzOZNF57wyr
        RfPi9WwW267MZ7Q4f34Du8XlXXPYLB4+uMFq8f/xV1aLF5s7WS32dTxgslj7+TG7A7fHzll3
        2T1a9t1i91i85yWTx6ZVnWwe786dY/fYP3cNu0ffllWMHuu3XGXx+LxJLoAzKscmIzUxJbVI
        ITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hcJYWyxJxSoFBAYnGx
        kr6dTVF+aUmqQkZ+cYmtUmpBSk6BoWGBXnFibnFpXrpecn6ulaGBgZEpUGVCTsbRxaIFDWoV
        S96WNjCulOti5OSQEDCR2DF9ElMXIxeHkMAORon7p9+yQjifGCW6V7SzgFQJCXxjlNj6thCm
        Y/nLvWwQRXsZJWa8a2KEcH4wSpz+vZYZpIpNQFticf9soG4ODhEBEYlb6xRAapgFupgk7i1c
        ATZVWMBR4u79Y0wgNouAqsTXOWsZQWxeARuJFVcPsEJsk5d4v+A+2AIJgbfsEv8abwGtZgdy
        XCQOSkOUCEu8Or6FHcKWknjZ3wZl10t861/AAtHawyjxt+s4G0TCWGLWs3ZGkNuYBTQl1u/S
        BzElBJQljtwCu4xZgE+i4/Bfdogwr0RHmxCEqSrRPRmqWFriww4biHEeEk3Tb0ADKlbiX+dm
        tgmMsrMQpi9gZFzFKJZaUJybnlpsVGCIHD2bGMGJT8t1B+Pktx/0DjEycTAeYpTgYFYS4fU4
        FxgvxJuSWFmVWpQfX1Sak1p8iNEUGFYTmaVEk/OBqTevJN7Q1MjMzMDS1MLUzMhCSZw3V/FC
        nJBAemJJanZqakFqEUwfEwenVAPTglV+FZsyOy6In4hQXLA9avePBLfO+zr+4i4LT/r775FJ
        PCPy8dG56+qvzWrkVjFf+Zy0fu+EQwVXtjY+eyO6SSNC00nz/4r+ZO19166xNtZcls/h+x5Y
        283hf+iLxu1D3qnSBQkn7pwIO+I1w+Ft6fv7HPbCxs+8WNfN0hBeF+86+czPsBV777obh1TG
        /NDnuVvrw7J/ZWTx8qLsyjSfB2x+4V4tdaoeFWX6jR+yiid+MesWWi7QxVr6uffR7Htx/gtj
        vq0XMJ0sO0mlqy1x+rtmQcNAsQ7XDWLWpjyZdtYP5tZd6jK7KVMmoSP8s6J22SHXw3+kN9+o
        OBd1/3fEPc7vF2zEebiilfL+WSqxFGckGmoxFxUnAgCAHiBBBQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKLMWRmVeSWpSXmKPExsWy7bCSnO7Fn4HxBk/fC1psvHicyaLz3hlW
        i+bF69kstl2Zz2hx/vwGdovLu+awWTx8cIPV4v/jr6wWLzZ3slrs63jAZLH282N2B26PnbPu
        snu07LvF7rF4z0smj02rOtk83p07x+6xf+4ado++LasYPdZvucri8XmTXABnFJdNSmpOZllq
        kb5dAlfG0cWiBQ1qFUveljYwrpTrYuTkkBAwkVj+ci9bFyMXh5DAbkaJO9NfsUIkpCWOv5rN
        DmELS9xvOcIKUfSNUeLWw51MIAk2AW2Jxf2zWboYOThEBEQkbq1TAKlhFpjGJPHo9huwZmEB
        R4m794+B1bMIqEp8nbOWEcTmFbCRWHH1ANQyeYn3C+4zTmDkWcDIsIpRMrWgODc9t9iwwDAv
        tVyvODG3uDQvXS85P3cTIzgktTR3MG5f9UHvECMTB+MhRgkOZiURXo9zgfFCvCmJlVWpRfnx
        RaU5qcWHGKU5WJTEeW8ULowTEkhPLEnNTk0tSC2CyTJxcEo1MClUittP+tv/+7301zniyyfK
        LilgdHKI470odJK3OFtBcklTwgu/ryEXvy3O63rGzPHW2qx4mkrylk+Li17puFiKinP+X258
        mPdMyyfBGcGPFif/4hM8Fbz+hF9/6fbuvkKpGytapGY+OjZ3E8fG8s9ndjbOSSmN4t4QOuWm
        peQigX9H/+/eoenfzlEyVdTPRGJhXEbHgdqst1HCx4ST/lVonWVcdzEwx/fKwyUTzZa7KqxP
        /xBhetP9WGeTyo7FkrUfj9VL/QkUKFgrUOJhu3xzoT/PSvWMhxtaHTcvbbh6doeISsXKrYce
        znZbdOTAvedijULnfq/NTZmsJKuoKbrlSCL/54OvK8prZts8n6XEUpyRaKjFXFScCAALbe7y
        uAIAAA==
X-CMS-MailID: 20200904082449epcas2p4420d5df2083325b328a182c79f5c0948
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200904082449epcas2p4420d5df2083325b328a182c79f5c0948
References: <CGME20200904082449epcas2p4420d5df2083325b328a182c79f5c0948@epcas2p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Printk() meesages are the most basic and useful debug method.
However, additional information needs in multi-processor.
If we add messages with processor id and process name, we can find
a problem only with messages when the problem occurs with H/W IP or CPU.
This is very useful in narrowing down the scope of the problems.

Therefore, instead of trying to help buffering, let's try to help
reconstructing messages by saving caller information as of calling
log_store() and adding it as "[$processor_id: $process_name: $thread_id]"
upon printing to consoles.

Some examples for console output:

  [    0.059580] [0:      swapper/0:    1] CPU: All CPU(s) started at EL1i
  [    2.153157] [5:           init:    1] migov: complete to probe migov
  [    7.441317] [4:           init:    1] NET: Registered protocol family 39
  [   22.793389] [5:  kworker/u16:1:  184] SMP: stopping secondary CPUs

Signed-off-by: Changki Kim <changki.kim@samsung.com>
---
 kernel/printk/printk.c            | 20 ++++++++++++++++++--
 kernel/printk/printk_ringbuffer.h |  7 +++++++
 lib/Kconfig.debug                 | 16 ++++++++++++++++
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ad8d1dfe5fbe..b8e7a263b123 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -408,7 +408,7 @@ static unsigned long console_dropped;
 /* the next printk record to read after the last 'clear' command */
 static u64 clear_seq;
 
-#ifdef CONFIG_PRINTK_CALLER
+#if defined(CONFIG_PRINTK_CALLER) || defined(CONFIG_PRINTK_PROCESS)
 #define PREFIX_MAX		48
 #else
 #define PREFIX_MAX		32
@@ -530,7 +530,12 @@ static int log_store(u32 caller_id, int facility, int level,
 	else
 		r.info->ts_nsec = local_clock();
 	r.info->caller_id = caller_id;
-
+#ifdef CONFIG_PRINTK_PROCESS
+	get_task_comm(r.info->process, current);
+	r.info->pid = task_pid_nr(current);
+	r.info->cpu_id = raw_smp_processor_id();
+	r.info->in_interrupt = in_interrupt() ? 1 : 0;
+#endif
 	/* insert message */
 	prb_commit(&e);
 
@@ -1298,6 +1303,16 @@ static size_t print_caller(u32 id, char *buf)
 #else
 #define print_caller(id, buf) 0
 #endif
+#ifdef CONFIG_PRINTK_PROCESS
+static size_t print_process(const struct printk_info *info, char *buf)
+{
+	return sprintf(buf, "%c[%1d:%15s:%5d]",
+		       info->in_interrupt ? 'I' : ' ', info->cpu_id,
+		       info->process, info->pid);
+}
+#else
+#define print_process(info, buf) 0
+#endif
 
 static size_t info_print_prefix(const struct printk_info  *info, bool syslog,
 				bool time, char *buf)
@@ -1310,6 +1325,7 @@ static size_t info_print_prefix(const struct printk_info  *info, bool syslog,
 	if (time)
 		len += print_time(info->ts_nsec, buf + len);
 
+	len += print_process(info, buf + len);
 	len += print_caller(info->caller_id, buf + len);
 
 	if (IS_ENABLED(CONFIG_PRINTK_CALLER) || time) {
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index e6302da041f9..fcefe9516606 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -4,6 +4,7 @@
 #define _KERNEL_PRINTK_RINGBUFFER_H
 
 #include <linux/atomic.h>
+#include <linux/sched.h>
 
 /*
  * Meta information about each stored message.
@@ -21,6 +22,12 @@ struct printk_info {
 	u8	flags:5;	/* internal record flags */
 	u8	level:3;	/* syslog level */
 	u32	caller_id;	/* thread id or processor id */
+#ifdef CONFIG_PRINTK_PROCESS
+	int	pid;			/* process id */
+	u8	cpu_id;			/* processor id */
+	u8	in_interrupt;		/* interrupt conext */
+	char process[TASK_COMM_LEN];	/* process name */
+#endif
 };
 
 /*
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index a84a41d8fadd..921d9e0eeb1a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -35,6 +35,22 @@ config PRINTK_CALLER
 	  no option to enable/disable at the kernel command line parameter or
 	  sysfs interface.
 
+config PRINTK_PROCESS
+        bool "Show process information on printks"
+        depends on PRINTK && !PRINTK_CALLER
+        help
+          Selecting this option causes printk() to add cpu number, process name
+	  and pid to every message.
+
+	  This option is intended for environments where multiple cores and
+	  multiple processes concurrently call printk() for many times, for it
+	  is difficult to interpret without knowing where these lines came from.
+	  This option is very useful from the point of view of vendor. You can
+	  infer problems of CPU or H/W IP to the cpu number and process name.
+
+	  This option can not use with PRINK_CALLER. Because prefix is too long
+	  and has duplicate information (processor id and thread id).
+
 config CONSOLE_LOGLEVEL_DEFAULT
 	int "Default console loglevel (1-15)"
 	range 1 15
-- 
2.14.2

