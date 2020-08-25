Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F01C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5063720782
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=axis.com header.i=@axis.com header.b="Qmz3BsH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgHYPd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:33:59 -0400
Received: from smtp2.axis.com ([195.60.68.18]:42874 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbgHYPdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 11:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=3757; q=dns/txt; s=axis-central1;
  t=1598369629; x=1629905629;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6u0giep84Vqjswp4FAaMyA0eMEjwRejj8AWYbb8MEmk=;
  b=Qmz3BsH7Km90qoz1JbjZvXDdg/E0NW4Dp9G8f1NESH7N65B9wxTyPsDr
   NzeDbFrnyzy+3KIx+YLDGM+CR+vsPIC6whnndd+SJzOM1W11idRlk2qTm
   boYviYQEvV3uL/W8Cf7mAhul7QrCf+DsZYhZEZdh8BRuX0qQaPs2ASu9j
   zkdASi/uSCUYHK4z917s4Xem+p6nxachj/VaTGKnN+ZOZWZjPRZRMh9s0
   Q8ncSP28SoyL6lMGJuPBjGDZCdPS+eBBQ6x+iNuaSrucwgrqOuvkSBq+c
   NJ0hsoRILeTyQBvDViFUmtLhMHJypbUofKY+QUPODuAEAwbMfjBCH3zuP
   A==;
IronPort-SDR: xjs3YL7hc/0RqTof64rOhXPJbxyRrBkvPLRFBBXQE8B7OlMZXChnyD+qbA/tgSxSPu7H2C7dXf
 xAfCxaur4SgMT7sypkRnh6US0lLVNgXwSxlvQ88DWk1rRt5Kw3CvAQ28ZOAyfD4FP7Mh8GxaFP
 F9my6D7lL40WAQzWZpWYfG/0+PqtQe3S6tZI0O4gmN27ajtjrteDwHnfx+V7lgMh+m3q+Zfnz9
 4+2FhiI0HPlx0Y9FMEAS1eln1UefJsP7fOwwtNsL2GrpXW7RRzAJVKXQMY0/Mh+5wBNxhIvDuP
 rLM=
X-IronPort-AV: E=Sophos;i="5.76,353,1592863200"; 
   d="scan'208";a="11853117"
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <jbaron@akamai.com>, <rostedt@goodmis.org>, <mingo@redhat.com>
CC:     <kernel@axis.com>, <corbet@lwn.net>, <pmladek@suse.com>,
        <sergey.senozhatsky@gmail.com>, <john.ogness@linutronix.de>,
        <linux-kernel@vger.kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH v3 0/2] Dynamic debug trace support
Date:   Tue, 25 Aug 2020 17:33:36 +0200
Message-ID: <20200825153338.17061-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:
 - Split flag rename to a separate patch
 - Rename event to printk:dyndbg

v2:
 - Remove stack buffer and use code similar to __ftrace_trace_stack()
 - Use an event with the same class as printk:console

Vincent Whitchurch (2):
  dynamic debug: split enable and printk flags
  dynamic debug: allow printing to trace event

 .../admin-guide/dynamic-debug-howto.rst       |   1 +
 include/linux/dynamic_debug.h                 |  11 +-
 include/trace/events/printk.h                 |  12 +-
 lib/dynamic_debug.c                           | 161 ++++++++++++++----
 4 files changed, 151 insertions(+), 34 deletions(-)

Range-diff:
-:  ------------ > 1:  2564b3dbbb04 dynamic debug: split enable and printk flags
1:  7bd3fb553503 ! 2:  90291c35d751 dynamic debug: allow printing to trace event
    @@ Commit message
         debug do it.
     
         Add an "x" flag to make the dynamic debug call site print to a new
    -    printk:dynamic trace event.  The trace event can be emitted instead of
    -    or in addition to the printk().
    +    printk:dyndbg trace event.  The trace event can be emitted instead of or
    +    in addition to the printk().
     
         The print buffer is statically allocated and managed using code borrowed
         from __ftrace_trace_stack() and is limited to 256 bytes (four of these
    @@ Documentation/admin-guide/dynamic-debug-howto.rst: of the characters::
      The flags are::
      
        p    enables the pr_debug() callsite.
    -+  x    enables trace to the printk:dynamic event
    ++  x    enables trace to the printk:dyndbg event
        f    Include the function name in the printed message
        l    Include line number in the printed message
        m    Include module name in the printed message
     
      ## include/linux/dynamic_debug.h ##
     @@ include/linux/dynamic_debug.h: struct _ddebug {
    - 	 * writes commands to <debugfs>/dynamic_debug/control
    - 	 */
    - #define _DPRINTK_FLAGS_NONE	0
    --#define _DPRINTK_FLAGS_PRINT	(1<<0) /* printk() a message using the format */
    -+#define _DPRINTK_FLAGS_PRINTK	(1<<0) /* printk() a message using the format */
    - #define _DPRINTK_FLAGS_INCL_MODNAME	(1<<1)
      #define _DPRINTK_FLAGS_INCL_FUNCNAME	(1<<2)
      #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
      #define _DPRINTK_FLAGS_INCL_TID		(1<<4)
    +-#define _DPRINTK_FLAGS_ENABLE		_DPRINTK_FLAGS_PRINTK
     +#define _DPRINTK_FLAGS_TRACE		(1<<5)
    -+#define _DPRINTK_FLAGS_PRINT		(_DPRINTK_FLAGS_PRINTK | \
    ++#define _DPRINTK_FLAGS_ENABLE		(_DPRINTK_FLAGS_PRINTK | \
     +					 _DPRINTK_FLAGS_TRACE)
      #if defined DEBUG
    --#define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINT
    -+#define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINTK
    + #define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINTK
      #else
    - #define _DPRINTK_FLAGS_DEFAULT 0
    - #endif
     
      ## include/trace/events/printk.h ##
     @@
    @@ include/trace/events/printk.h: TRACE_EVENT(console,
     +	TP_ARGS(text, len)
     +);
     +
    -+DEFINE_EVENT(printk, dynamic,
    ++DEFINE_EVENT(printk, dyndbg,
     +	TP_PROTO(const char *text, size_t len),
     +	TP_ARGS(text, len)
     +);
    @@ lib/dynamic_debug.c
      
      #include <rdma/ib_verbs.h>
      
    -@@ lib/dynamic_debug.c: static inline const char *trim_prefix(const char *path)
    - }
    - 
    - static struct { unsigned flag:8; char opt_char; } opt_array[] = {
    --	{ _DPRINTK_FLAGS_PRINT, 'p' },
    -+	{ _DPRINTK_FLAGS_PRINTK, 'p' },
    - 	{ _DPRINTK_FLAGS_INCL_MODNAME, 'm' },
    +@@ lib/dynamic_debug.c: static struct { unsigned flag:8; char opt_char; } opt_array[] = {
      	{ _DPRINTK_FLAGS_INCL_FUNCNAME, 'f' },
      	{ _DPRINTK_FLAGS_INCL_LINENO, 'l' },
      	{ _DPRINTK_FLAGS_INCL_TID, 't' },
    @@ lib/dynamic_debug.c: static char *dynamic_emit_prefix(const struct _ddebug *desc
     +	buf = this_cpu_ptr(dynamic_trace_bufs.bufs) + bufidx;
     +
     +	len = vscnprintf(buf->buf, sizeof(buf->buf), fmt, args);
    -+	trace_dynamic(buf->buf, len);
    ++	trace_dyndbg(buf->buf, len);
     +
     +out:
     +	/* As above. */
-- 
2.28.0

