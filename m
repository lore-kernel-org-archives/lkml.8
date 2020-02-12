Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F11C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4911D21569
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581523148;
	bh=cwp8aLRXoFn/Mb1HJoRZJdKN/1M27LTXc5yobJKF+44=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=R9f8p7dyxwKkEu8uVjJsX62gjOUdtKeL63ZjSOY7SrbptsgEZqpBtfNRS+xPwE9ba
	 OZMbZ1Jr5O2Mr+6lAM5ZDDM/qbcxXh/2SsqipPu3SrPNdYFbaS8TZFW8QAU2ooUtlx
	 phIHm7B1s71mgmqRVP/jjHVzmdJyqiPDsA0fTDQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgBLP7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 10:59:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:51654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727458AbgBLP7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 10:59:07 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E69252082F;
        Wed, 12 Feb 2020 15:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581523146;
        bh=cwp8aLRXoFn/Mb1HJoRZJdKN/1M27LTXc5yobJKF+44=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AKHNCeDGe09QhQn2+jEEUSxZD+VmL+Yfbw5hv6eqnx3J9ZaX+xn0Q506FLb48XM06
         N3DMJTOSd1pzaPBwCK1tI/lKpxhoClud79huRCQCBeqjefrz3SaedEWiB4DQX5ccQc
         bKyad7yczWKCXZCYxYp3wUs8FUUIOL8Mrc42SErk=
Message-ID: <1581523144.8740.8.camel@kernel.org>
Subject: Re: [tracing] 9fe41efaca:
 BUG:unable_to_handle_page_fault_for_address
From:   Tom Zanussi <zanussi@kernel.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
Date:   Wed, 12 Feb 2020 09:59:04 -0600
In-Reply-To: <20200212113444.GS12867@shao2-debian>
References: <20200212113444.GS12867@shao2-debian>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2020-02-12 at 19:34 +0800, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 9fe41efaca08416657efa8731c0d47ccb6a3f3eb ("tracing: Add synth
> event generation test module")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git
> master
> 
> in testcase: rcuperf
> with following parameters:
> 
> 	runtime: 300s
> 	perf_type: rcu
> 
> 
> 
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2
> -m 8G
> 

I think the below patch should fix this, but I'm not able to build and
test on a 32-bit system at the moment - my system needs an update to be
able to run the qemu lkp-tests and my real 32-bit system is also having
problems of its own.  I'll verify that this actually works on the lkp-
tests once I get to the point of being able to test this on i386.

Thanks,

Tom


Subject: [PATCH] tracing: Remove bogus 64-bit synth_event_trace() vararg
 assumption

The vararg code in synth_event_trace() assumed the args were 64 bit
which is not the case on 32 bit systems.  Just use long which should
work on every system, and remove the u64 casts from the synth event
test module.

Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/synth_event_gen_test.c | 4 ++--
 kernel/trace/trace_events_hist.c    | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/synth_event_gen_test.c b/kernel/trace/synth_event_gen_test.c
index 4aefe003cb7c..2a7465569a43 100644
--- a/kernel/trace/synth_event_gen_test.c
+++ b/kernel/trace/synth_event_gen_test.c
@@ -424,11 +424,11 @@ static int __init test_trace_synth_event(void)
 	/* Trace some bogus values just for testing */
 	ret = synth_event_trace(create_synth_test, 7,	/* number of values */
 				444,			/* next_pid_field */
-				(u64)"clackers",	/* next_comm_field */
+				"clackers",		/* next_comm_field */
 				1000000,		/* ts_ns */
 				1000,			/* ts_ms */
 				smp_processor_id(),	/* cpu */
-				(u64)"Thneed",		/* my_string_field */
+				"Thneed",		/* my_string_field */
 				999);			/* my_int_field */
 	return ret;
 }
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 2fcb755e900a..e65276c3c9d1 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1883,12 +1883,12 @@ int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
 
 	va_start(args, n_vals);
 	for (i = 0, n_u64 = 0; i < state.event->n_fields; i++) {
-		u64 val;
+		long val;
 
-		val = va_arg(args, u64);
+		val = va_arg(args, long);
 
 		if (state.event->fields[i]->is_string) {
-			char *str_val = (char *)(long)val;
+			char *str_val = (char *)val;
 			char *str_field = (char *)&state.entry->fields[n_u64];
 
 			strscpy(str_field, str_val, STR_VAR_LEN_MAX);
-- 
2.14.1

