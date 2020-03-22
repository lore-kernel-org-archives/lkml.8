Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA03C4332D
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 06:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2532E2070A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 06:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="EcGrFexH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgCVGUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 02:20:38 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38130 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgCVGUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 02:20:37 -0400
Received: by mail-qt1-f193.google.com with SMTP id z12so8922888qtq.5
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 23:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=eQT0ZEFOdAImqghPxf+cjqAdzqTThMz3RIHGYI3fc/M=;
        b=EcGrFexHKW08/MgvI9Ft5P6fLMPzptOY8naQTsa9FGxEjm1WIVyDWe6Umj9A9iq+hx
         LjXzG2rgMFHhUEEL5ghJByFROlanhb8UukBBOUgUJyW5/jd5CeerQSdhAsiEkkE3ilim
         UUAsvcaix7EaratBhZiehA3GC8glWlmOYE26R80I+pXzDJ2dTys8di/RUA70xt9GgXdn
         zeoDdBxfXBniefTWMvI6qCBIU+I5kVS84JNWIaNutXrbwleP4mhC9nADlNX0aTPs6lPI
         MHH3TXq7LzADqseEOAZkxrdFK/0E1VWMeAdXsr8KVI2GkN6SBNkTHeZWMqbG4S0hwvkj
         I0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eQT0ZEFOdAImqghPxf+cjqAdzqTThMz3RIHGYI3fc/M=;
        b=DDkJwexanLnTPqFMdKTjCASw/kXijYC2m33UVbMYh3iLf9wKnHVErIy5k9qSrg4970
         +SsxJz2DWOaVXu+Lvqzsi2d8+J/3Np0TYP5eCij891VeGLCAM2HwvLVtpPFBMI5cnSjE
         IU8A9Ux0l0S0BsvpocdB9V9n83eUjVFnvnvwxZLzv5QxsVrDFZ/3NSCMZxVORUGNRPqA
         FZsK6g1iezmBka2AJPgsXgdyDhRBecRaEUSt5N246L3/csda8Irz9zjC+5Re8OA3BrN0
         u+BakslnFuiiYH4Kvb8aR1XIAkrS/9IWcz4HIUzPwUq7Bx+EDGsFMUpreKLwfFGOka/s
         gEeA==
X-Gm-Message-State: ANhLgQ2Kzu6utPaSpjJ38edONKfS0aoMgu5BVjol9miRKEKcL1SfqnAx
        Pan+r9+MTAa7RJ6+kHvRuMUih0aCE9jl3g==
X-Google-Smtp-Source: ADFU+vt5yPf6JeNMTMn+CsXWhZ70HP/jl8WpLDtCJHkojZlz5O0nxgEFyR7pIc1+81CoQj2GLGGNKw==
X-Received: by 2002:ac8:45c9:: with SMTP id e9mr11205674qto.185.1584858035724;
        Sat, 21 Mar 2020 23:20:35 -0700 (PDT)
Received: from juliacomputing.com (c-76-24-28-244.hsd1.ma.comcast.net. [76.24.28.244])
        by smtp.gmail.com with ESMTPSA id y17sm9516622qth.59.2020.03.21.23.20.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 23:20:35 -0700 (PDT)
Date:   Sun, 22 Mar 2020 02:20:33 -0400
From:   Keno Fischer <keno@juliacomputing.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>, robert@ocallahan.org
Subject: [RFC PATCH] seccomp: Add a trace action that allows the syscall if
 ptracer absent
Message-ID: <20200322062033.GA72532@juliacomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

# Background

One usecase for seccomp that has become more common is as a sort-of
pre-filter for ptrace events. This is useful to reduce debugging
overhead by avoiding traps to the ptracer for events that the
ptracer is not interested in and is used extensively for this
purpose in modern ptrace clients such as the rr debugger [1].

As a simpler, but illustrative example, consider perhaps an
expression like `strace -e open`. An advanced strace implementation
could set a seccomp filter that causes a SECCOMP_RET_TRACE option
for open system calls only (or even only system calls involving a
particular file descriptor).

However, when used for this purpose, the persistent and inherited
nature of the seccomp filter can present a problem (though
perfectly sensible from the perspective of a security feature of
course). Of course the ptracer could simply attach itself to the
entire process tree, but this of course presents its own performance
challenges negating the originall performance advantage (e.g.
in the `strace` example above, strace may only want to trace its
original child).

The most desirable feature would probably be for the ptracer to have
the capability to remove a seccomp filter from a child, but I
understand that the design of seccomp as an immutable tree of filters
makes this difficult, not to mention that such a feature is perhaps
undesirable given seccomp's intention as a security feature (even
if guarded behind a non-default flag). This instead implements an
additional trace action, that I believe can achieve much the same
effect while being significantly less invasive:

# This patch

The default behavior of the `SECCOMP_RET_TRACE` is to fail the system
call with `ENOSYS` if no ptracer is attached to the process. This
patch adds a similar option `SECCOMP_RET_TRACE_ALLOW`, that behaves
identically to `SECCOMP_RET_TRACE` in all respects, except that it
allows the system call to go forward unmodified in the case that no
ptracer is attached (or that the ptracer does not have the seccomp
event enabled).

This remedies the situation discussed in the previous section by making
it irrelevant whether or not the seccomp filter is installed in
the children of the original initial task, as they will not see any
difference in behavior from the presence of a properly-implemented
seccomp filter as long as no ptracer is attached.

I think another possible use of an interface like this would be ptracers
that want to occaisionally attach to running processes for profiling
or logging purposes, but otherwise do not want to disturb the
functioning of the process.

It is not entirely satisfying of course, as the new behavior will
be re-activated by any new ptracer attaching to such a process,
even if such a ptracer is unaware of the presence of the seccomp filter.
Such a situation is probably fairly rare (esp. since the alternative
is just to keep every child ptrace-attached, which would prevent
other ptracers from attaching anyway), but it deserves pointing out
nonetheless.

# Alternatives considered

As discussed above, I considered proposing some mechanism for the
removal of seccomp filters after the fact, but rejected this approach
because it seemed to invasive and counter to the design intent of the
API.

Another idea I considered was allowing the BPF filter to access some
ptracer-writable metadata area that could be used to modify the behavior
of the filter after the fact (if enabled by a flag). I still think
this would potentially be a viable solution. However, I worried that
this would get too far into the realm of allowing eBPF seccomp filters,
which as far as I understand was previously rejected (though I did
not completely research the history of this suggestion). A solution
like this would of course address the shortcoming I mentioned above
by allowing the ptracer to render the filter truly inert.

Lastly I considered instead adding a field to the seccomp_data
structure that would indicate whether or not the ptracer was available
or not. However, that approached seemed a lot more likely to result
in user confusion and incorrect filters than simply adding an additional
action.

[1] https://github.com/mozilla/rr

Signed-Off-By: Keno Fischer <keno@juliacomputing.com>

---
 .../userspace-api/seccomp_filter.rst          |  5 ++++
 include/uapi/linux/seccomp.h                  |  1 +
 kernel/seccomp.c                              | 26 +++++++++++++------
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/Documentation/userspace-api/seccomp_filter.rst b/Documentation/userspace-api/seccomp_filter.rst
index bd9165241b6c..95098c20c3db 100644
--- a/Documentation/userspace-api/seccomp_filter.rst
+++ b/Documentation/userspace-api/seccomp_filter.rst
@@ -151,6 +151,11 @@ In precedence order, they are:
 	allow use of ptrace, even of other sandboxed processes, without
 	extreme care; ptracers can use this mechanism to escape.)
 
+``SECCOMP_RET_TRACE_ALLOW``:
+	Like ``SECCOMP_RET_TRACE``, but if no tracer is present (or the tracer is
+	not listening to seccomp events), allow the syscall rather than returning
+	ENOSYS.
+
 ``SECCOMP_RET_LOG``:
 	Results in the system call being executed after it is logged. This
 	should be used by application developers to learn which syscalls their
diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
index be84d87f1f46..7d9997a98d06 100644
--- a/include/uapi/linux/seccomp.h
+++ b/include/uapi/linux/seccomp.h
@@ -39,6 +39,7 @@
 #define SECCOMP_RET_ERRNO	 0x00050000U /* returns an errno */
 #define SECCOMP_RET_USER_NOTIF	 0x7fc00000U /* notifies userspace */
 #define SECCOMP_RET_TRACE	 0x7ff00000U /* pass to a tracer or disallow */
+#define SECCOMP_RET_TRACE_ALLOW	 0x7ff30000U /* pass to a tracer or allow */
 #define SECCOMP_RET_LOG		 0x7ffc0000U /* allow after logging */
 #define SECCOMP_RET_ALLOW	 0x7fff0000U /* allow */
 
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index b6ea3dcb57bf..af7d38666b6c 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -623,6 +623,7 @@ static void seccomp_send_sigsys(int syscall, int reason)
 #define SECCOMP_LOG_LOG			(1 << 5)
 #define SECCOMP_LOG_ALLOW		(1 << 6)
 #define SECCOMP_LOG_USER_NOTIF		(1 << 7)
+#define SECCOMP_LOG_TRACE_ALLOW		(1 << 8)
 
 static u32 seccomp_actions_logged = SECCOMP_LOG_KILL_PROCESS |
 				    SECCOMP_LOG_KILL_THREAD  |
@@ -630,6 +631,7 @@ static u32 seccomp_actions_logged = SECCOMP_LOG_KILL_PROCESS |
 				    SECCOMP_LOG_ERRNO |
 				    SECCOMP_LOG_USER_NOTIF |
 				    SECCOMP_LOG_TRACE |
+				    SECCOMP_LOG_TRACE_ALLOW |
 				    SECCOMP_LOG_LOG;
 
 static inline void seccomp_log(unsigned long syscall, long signr, u32 action,
@@ -646,6 +648,7 @@ static inline void seccomp_log(unsigned long syscall, long signr, u32 action,
 	case SECCOMP_RET_ERRNO:
 		log = requested && seccomp_actions_logged & SECCOMP_LOG_ERRNO;
 		break;
+	case SECCOMP_RET_TRACE_ALLOW:
 	case SECCOMP_RET_TRACE:
 		log = requested && seccomp_actions_logged & SECCOMP_LOG_TRACE;
 		break;
@@ -832,6 +835,7 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
 		seccomp_send_sigsys(this_syscall, data);
 		goto skip;
 
+	case SECCOMP_RET_TRACE_ALLOW:
 	case SECCOMP_RET_TRACE:
 		/* We've been put in this state by the ptracer already. */
 		if (recheck_after_trace)
@@ -839,9 +843,12 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
 
 		/* ENOSYS these calls if there is no tracer attached. */
 		if (!ptrace_event_enabled(current, PTRACE_EVENT_SECCOMP)) {
+			if (action == SECCOMP_RET_TRACE_ALLOW)
+				return 0;
+
 			syscall_set_return_value(current,
-						 task_pt_regs(current),
-						 -ENOSYS, 0);
+						task_pt_regs(current),
+						-ENOSYS, 0);
 			goto skip;
 		}
 
@@ -1374,6 +1381,7 @@ static long seccomp_get_action_avail(const char __user *uaction)
 	case SECCOMP_RET_TRAP:
 	case SECCOMP_RET_ERRNO:
 	case SECCOMP_RET_USER_NOTIF:
+	case SECCOMP_RET_TRACE_ALLOW:
 	case SECCOMP_RET_TRACE:
 	case SECCOMP_RET_LOG:
 	case SECCOMP_RET_ALLOW:
@@ -1591,12 +1599,13 @@ long seccomp_get_metadata(struct task_struct *task,
 /* Human readable action names for friendly sysctl interaction */
 #define SECCOMP_RET_KILL_PROCESS_NAME	"kill_process"
 #define SECCOMP_RET_KILL_THREAD_NAME	"kill_thread"
-#define SECCOMP_RET_TRAP_NAME		"trap"
-#define SECCOMP_RET_ERRNO_NAME		"errno"
-#define SECCOMP_RET_USER_NOTIF_NAME	"user_notif"
-#define SECCOMP_RET_TRACE_NAME		"trace"
-#define SECCOMP_RET_LOG_NAME		"log"
-#define SECCOMP_RET_ALLOW_NAME		"allow"
+#define SECCOMP_RET_TRAP_NAME			"trap"
+#define SECCOMP_RET_ERRNO_NAME			"errno"
+#define SECCOMP_RET_USER_NOTIF_NAME		"user_notif"
+#define SECCOMP_RET_TRACE_NAME			"trace"
+#define SECCOMP_RET_TRACE_ALLOW_NAME 	"trace_allow"
+#define SECCOMP_RET_LOG_NAME		 	"log"
+#define SECCOMP_RET_ALLOW_NAME		 	"allow"
 
 static const char seccomp_actions_avail[] =
 				SECCOMP_RET_KILL_PROCESS_NAME	" "
@@ -1620,6 +1629,7 @@ static const struct seccomp_log_name seccomp_log_names[] = {
 	{ SECCOMP_LOG_ERRNO, SECCOMP_RET_ERRNO_NAME },
 	{ SECCOMP_LOG_USER_NOTIF, SECCOMP_RET_USER_NOTIF_NAME },
 	{ SECCOMP_LOG_TRACE, SECCOMP_RET_TRACE_NAME },
+	{ SECCOMP_LOG_TRACE_ALLOW, SECCOMP_RET_TRACE_ALLOW_NAME },
 	{ SECCOMP_LOG_LOG, SECCOMP_RET_LOG_NAME },
 	{ SECCOMP_LOG_ALLOW, SECCOMP_RET_ALLOW_NAME },
 	{ }
-- 
2.24.0

