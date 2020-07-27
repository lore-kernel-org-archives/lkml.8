Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F88DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01AB62083E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859245;
	bh=r9nzgQaeZR71FIFN/VCqxekjVrWwR2TUFPDQJB65kYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t32plDdfFoFiC2K1OW47rGUSYojWjYtcRVrLG2fszBC0LnM+AWleiwn3zs7D2ELyA
	 gkRpuw9pLfc0/SrW8F/Pq0LmdU3MqVWkboRYTR016exTrWi28zX2cMNgrNJFBRQFZF
	 rTfCbbJsq50FNk1qkhruMiwo1+Qg7ZK+YcjKPJZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbgG0OOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:14:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730425AbgG0ONz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:13:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 037722073E;
        Mon, 27 Jul 2020 14:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859234;
        bh=r9nzgQaeZR71FIFN/VCqxekjVrWwR2TUFPDQJB65kYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EMMy/foxLLICpLqSPQI4rGZMkG85jpNgyCi5ZqJmw4wH1B/1yodp8nYMM8ne+7CC/
         gRwS3gwKll6Sw+8cqxQSW2aFeR83cIYhr0azAS8O62VoEmP8Z73jPH3ZdSN5Qaz9EV
         3nftzJ/bS1PPmcZI/Sh8aTU1ErHbWAUOOew8uUP0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaron Merey <amerey@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: [PATCH 5.4 029/138] uprobes: Change handle_swbp() to send SIGTRAP with si_code=SI_KERNEL, to fix GDB regression
Date:   Mon, 27 Jul 2020 16:03:44 +0200
Message-Id: <20200727134926.828947590@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134925.228313570@linuxfoundation.org>
References: <20200727134925.228313570@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleg Nesterov <oleg@redhat.com>

commit fe5ed7ab99c656bd2f5b79b49df0e9ebf2cead8a upstream.

If a tracee is uprobed and it hits int3 inserted by debugger, handle_swbp()
does send_sig(SIGTRAP, current, 0) which means si_code == SI_USER. This used
to work when this code was written, but then GDB started to validate si_code
and now it simply can't use breakpoints if the tracee has an active uprobe:

	# cat test.c
	void unused_func(void)
	{
	}
	int main(void)
	{
		return 0;
	}

	# gcc -g test.c -o test
	# perf probe -x ./test -a unused_func
	# perf record -e probe_test:unused_func gdb ./test -ex run
	GNU gdb (GDB) 10.0.50.20200714-git
	...
	Program received signal SIGTRAP, Trace/breakpoint trap.
	0x00007ffff7ddf909 in dl_main () from /lib64/ld-linux-x86-64.so.2
	(gdb)

The tracee hits the internal breakpoint inserted by GDB to monitor shared
library events but GDB misinterprets this SIGTRAP and reports a signal.

Change handle_swbp() to use force_sig(SIGTRAP), this matches do_int3_user()
and fixes the problem.

This is the minimal fix for -stable, arch/x86/kernel/uprobes.c is equally
wrong; it should use send_sigtrap(TRAP_TRACE) instead of send_sig(SIGTRAP),
but this doesn't confuse GDB and needs another x86-specific patch.

Reported-by: Aaron Merey <amerey@redhat.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200723154420.GA32043@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/events/uprobes.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2205,7 +2205,7 @@ static void handle_swbp(struct pt_regs *
 	if (!uprobe) {
 		if (is_swbp > 0) {
 			/* No matching uprobe; signal SIGTRAP. */
-			send_sig(SIGTRAP, current, 0);
+			force_sig(SIGTRAP);
 		} else {
 			/*
 			 * Either we raced with uprobe_unregister() or we can't


