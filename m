Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2722C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 19:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A61520728
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 19:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589570623;
	bh=TuKsKP6cbt7gD83ko2QaqNWtZkkxPgW/pFRBoMPgw40=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SgtTdh/c4miO/dE/uR/gxsVjfbk/fXp6jYJfm2GVUUMfdZsQKEwSQFaQ+NpHavp4c
	 7aA4rzPoyx05yndpegNw3sOdFI1c5HANtRlG2XeX943C5WWtmLBLaOvsNOrk52xhmA
	 gipSt2ya8wq8+wTaUMznfFqGnr7GnpxaF1N7hHHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgEOTXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 15:23:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:41716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgEOTXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 15:23:42 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A5682070A;
        Fri, 15 May 2020 19:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589570621;
        bh=TuKsKP6cbt7gD83ko2QaqNWtZkkxPgW/pFRBoMPgw40=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kXG5ksATrfPQ9YZ98bZkSV7yFZnEEoxkrv61rl/aO77GO8la7+StdMay7mOAu8sDO
         JPjDmL12Qy0RtsBkqUmMoFEUNc4xREd5P+gS/F1PWPDuaqcN0P4ftHGUB+aNV9CvQy
         CFnBD7ljcndESEroYiJ6qA+nZ6PPagiFF8mti1ic=
Date:   Fri, 15 May 2020 12:23:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Guo Ren <guoren@kernel.org>
Subject: Re: [PATCHv3 12/50] csky: Add show_stack_loglvl()
Message-Id: <20200515122340.d0d93b7a29846934e161ef41@linux-foundation.org>
In-Reply-To: <20200418201944.482088-13-dima@arista.com>
References: <20200418201944.482088-1-dima@arista.com>
        <20200418201944.482088-13-dima@arista.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Apr 2020 21:19:06 +0100 Dmitry Safonov <dima@arista.com> wrote:

> Currently, the log-level of show_stack() depends on a platform
> realization. It creates situations where the headers are printed with
> lower log level or higher than the stacktrace (depending on
> a platform or user).
> 
> Furthermore, it forces the logic decision from user to an architecture
> side. In result, some users as sysrq/kdb/etc are doing tricks with
> temporary rising console_loglevel while printing their messages.
> And in result it not only may print unwanted messages from other CPUs,
> but also omit printing at all in the unlucky case where the printk()
> was deferred.
> 
> Introducing log-level parameter and KERN_UNSUPPRESSED [1] seems
> an easier approach than introducing more printk buffers.
> Also, it will consolidate printings with headers.
> 
> Introduce show_stack_loglvl(), that eventually will substitute
> show_stack().

The csky code has changed a lot in linux-next due to 18c07d23da5a
("csky: Fixup calltrace panic").  I redid this patch as below.  Can we
please review and test?


From: Dmitry Safonov <dima@arista.com>
Subject: csky: add show_stack_loglvl()

Currently, the log-level of show_stack() depends on a platform
realization.  It creates situations where the headers are printed with
lower log level or higher than the stacktrace (depending on a platform or
user).

Furthermore, it forces the logic decision from user to an architecture
side.  In result, some users as sysrq/kdb/etc are doing tricks with
temporary rising console_loglevel while printing their messages.  And in
result it not only may print unwanted messages from other CPUs, but also
omit printing at all in the unlucky case where the printk() was deferred.

Introducing log-level parameter and KERN_UNSUPPRESSED [1] seems an easier
approach than introducing more printk buffers.  Also, it will consolidate
printings with headers.

Introduce show_stack_loglvl(), that eventually will substitute
show_stack().

[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u

Link: http://lkml.kernel.org/r/20200418201944.482088-13-dima@arista.com
Signed-off-by: Dmitry Safonov <dima@arista.com>
Cc: Guo Ren <guoren@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/csky/kernel/stacktrace.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/arch/csky/kernel/stacktrace.c~csky-add-show_stack_loglvl
+++ a/arch/csky/kernel/stacktrace.c
@@ -91,14 +91,21 @@ static void notrace walk_stackframe(stru
 
 static bool print_trace_address(unsigned long pc, void *arg)
 {
-	print_ip_sym(pc);
+	print_ip_sym((const char *)arg, pc);
 	return false;
 }
 
+void show_stack_loglvl(struct task_struct *task, unsigned long *sp,
+		       const char *loglvl)
+{
+	pr_cont("Call Trace:\n");
+	walk_stackframe(task, NULL, print_trace_address, (void *)loglvl);
+}
+
 void show_stack(struct task_struct *task, unsigned long *sp)
 {
 	pr_cont("Call Trace:\n");
-	walk_stackframe(task, NULL, print_trace_address, NULL);
+	walk_stackframe(task, NULL, print_trace_address, KERN_INFO);
 }
 
 static bool save_wchan(unsigned long pc, void *arg)
_

