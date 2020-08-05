Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D331C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EC9F2076E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tlMr0ee5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgHETuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgHEQxw (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:53:52 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF741C034611
        for <Linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 05:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=unp2ULRv3n88LTY/GZXfJgG6CYh6rsWdx2r0Nn+lYa4=; b=tlMr0ee5tqEHn8jmPLIhwMd3R4
        xHTX+0F6Xm0542kkqE05tQMKd8tUr3AmyWi/BoiRJ9hWbnzctbx2gROvD45wboJGPP6Nc4xz+rKMn
        6O1h0X+hb6hw7qL9CsRplNZwx+ozmZFh4c+67CZZSyRL71NM9wuMRbMw9OWnnpArjcR8EtJ0wipRZ
        NjhLoY4BxwBqBww+csnY9YUWwwwdble4rvygMYwTh8s3UgluucVW+cJhmW5S4pPzGL2G0qCUCnOI5
        fV470+cIrIItw06PjGGTSC2oVxFLelj0iHWRzXWigoIOq9x9k+h2YT7ACf6Qdprs2egJDNhRKDvOl
        SHB+dleQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3Imv-0000GA-Lo; Wed, 05 Aug 2020 12:44:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BC085301E02;
        Wed,  5 Aug 2020 14:44:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AE16223E7A6AB; Wed,  5 Aug 2020 14:44:54 +0200 (CEST)
Date:   Wed, 5 Aug 2020 14:44:54 +0200
From:   peterz@infradead.org
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     mingo@redhat.com, oleg@redhat.com, acme@kernel.org,
        jolsa@kernel.org, Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com
Subject: Re: [PATCH v1 2/2] perf/core: Fake regs for leaked kernel samples
Message-ID: <20200805124454.GP2657@hirez.programming.kicks-ass.net>
References: <20200731025617.16243-1-yao.jin@linux.intel.com>
 <20200731025617.16243-2-yao.jin@linux.intel.com>
 <20200804114900.GI2657@hirez.programming.kicks-ass.net>
 <4c958d61-11a7-9f3e-9e7d-d733270144a1@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c958d61-11a7-9f3e-9e7d-d733270144a1@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 10:15:26AM +0800, Jin, Yao wrote:
> Hi Peter,
> 
> On 8/4/2020 7:49 PM, peterz@infradead.org wrote:
> > On Fri, Jul 31, 2020 at 10:56:17AM +0800, Jin Yao wrote:
> > > @@ -6973,7 +6973,8 @@ static struct perf_callchain_entry __empty_callchain = { .nr = 0, };
> > >   struct perf_callchain_entry *
> > >   perf_callchain(struct perf_event *event, struct pt_regs *regs)
> > >   {
> > > -	bool kernel = !event->attr.exclude_callchain_kernel;
> > > +	bool kernel = !event->attr.exclude_callchain_kernel &&
> > > +		      !event->attr.exclude_kernel;
> > 
> > This seems weird; how can we get there. Also it seems to me that if you
> > have !exclude_callchain_kernel you already have permission for kernel
> > bits, so who cares.
> > 
> 
> In perf tool, exclude_callchain_kernel is set to 1 when perf-record only
> collects the user callchains and exclude_kernel is set to 1 when events are
> configured to run in user space.
> 
> So if an event is configured to run in user space, that should make sense we
> don't need it's kernel callchains.
> 
> But it seems to me there is no code logic in perf tool which can make sure
> !exclude_callchain_kernel -> !exclude_kernel.
> 
> Jiri, Arnaldo, is my understanding correct?

What the perf tool does or does not do is irrelevant. It is a valid,
(albeit slightly silly) configuration to have:

	exclude_kernel && !exclude_callchain_kernel

You're now saying that when you configure things like this you're not
allowed kernel IPs, that's wrong I think.

Also, !exclude_callchain_kernel should require privilidge, whcih needs
fixing, see below.

> So the new code looks like:
> 
> if (event->attr.exclude_kernel && !user_mode(regs)) {
> 	if (!(current->flags & PF_KTHREAD)) {
> 		regs_fake = task_pt_regs(current);
> 		if (!regs_fake)
> 			instruction_pointer_set(regs, -1L);
> 	} else {
> 		instruction_pointer_set(regs, -1L);
> 	}

Again:

	if (!(current->flags & PF_KTHREAD))
		regs_fake = task_pt_regs(current);

	if (!regs_fake)
		instruction_pointer_set(regs, -1L);

Is much simpler and more readable.

> > > +		if ((header->misc & PERF_RECORD_MISC_CPUMODE_MASK) ==
> > > +		     PERF_RECORD_MISC_KERNEL) {
> > > +			header->misc &= ~PERF_RECORD_MISC_CPUMODE_MASK;
> > > +			header->misc |= PERF_RECORD_MISC_USER;
> > > +		}
> > 
> > Why the conditional? At this point it had better be unconditionally
> > user, no?
> > 
> > 		headers->misc &= ~PERF_RECORD_MISC_CPUMODE_MASK;
> > 		headers->misc |= PERF_RECORD_MISC_USER;
> > 
> 
> #define PERF_RECORD_MISC_CPUMODE_MASK		(7 << 0)
> #define PERF_RECORD_MISC_CPUMODE_UNKNOWN	(0 << 0)
> #define PERF_RECORD_MISC_KERNEL			(1 << 0)
> #define PERF_RECORD_MISC_USER			(2 << 0)
> #define PERF_RECORD_MISC_HYPERVISOR		(3 << 0)
> #define PERF_RECORD_MISC_GUEST_KERNEL		(4 << 0)
> #define PERF_RECORD_MISC_GUEST_USER		(5 << 0)
> 
> If we unconditionally set user, it will reset for hypervisor, guest
> kernel and guest_user.

At the same time :u had better not get any of those either. Which seems
to suggest we're going about this wrong.

Also, if we call this before perf_misc_flags() we don't need to fix it
up.

How's this?

---
 kernel/events/core.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7c436d705fbd..3e4e328b521a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6988,23 +6988,49 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 	return callchain ?: &__empty_callchain;
 }
 
+/*
+ * Due to interrupt latency (skid), we may enter the kernel before taking the
+ * PMI, even if the PMU is configured to only count user events. To avoid
+ * leaking kernel addresses, use task_pt_regs(), when available.
+ */
+static struct pt_regs *sanitize_sample_regs(struct perf_event *event, struct pt_regs *regs)
+{
+	struct pt_regs *sample_regs = regs;
+
+	/* user only */
+	if (!event->attr.exclude_kernel || !event->attr.exclude_hv ||
+	    !event->attr.exclude_host   || !event->attr.exclude_guest)
+		return sample_regs;
+
+	if (sample_regs(regs))
+		return sample_regs;
+
+	if (!(current->flags & PF_KTHREAD)) {
+		sample_regs = task_pt_regs(current);
+	else
+		instruction_pointer_set(regs, -1L);
+
+	return sample_regs;
+}
+
 void perf_prepare_sample(struct perf_event_header *header,
 			 struct perf_sample_data *data,
 			 struct perf_event *event,
 			 struct pt_regs *regs)
 {
+	struct pt_regs *sample_regs = sanitize_sample_regs(event, regs);
 	u64 sample_type = event->attr.sample_type;
 
 	header->type = PERF_RECORD_SAMPLE;
 	header->size = sizeof(*header) + event->header_size;
 
 	header->misc = 0;
-	header->misc |= perf_misc_flags(regs);
+	header->misc |= perf_misc_flags(sample_regs);
 
 	__perf_event_header__init_id(header, data, event);
 
 	if (sample_type & PERF_SAMPLE_IP)
-		data->ip = perf_instruction_pointer(regs);
+		data->ip = perf_instruction_pointer(sample_regs);
 
 	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
 		int size = 1;
@@ -7054,9 +7080,10 @@ void perf_prepare_sample(struct perf_event_header *header,
 		header->size += size;
 	}
 
-	if (sample_type & (PERF_SAMPLE_REGS_USER | PERF_SAMPLE_STACK_USER))
+	if (sample_type & (PERF_SAMPLE_REGS_USER | PERF_SAMPLE_STACK_USER)) {
 		perf_sample_regs_user(&data->regs_user, regs,
 				      &data->regs_user_copy);
+	}
 
 	if (sample_type & PERF_SAMPLE_REGS_USER) {
 		/* regs dump ABI info */
@@ -7099,7 +7126,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 		/* regs dump ABI info */
 		int size = sizeof(u64);
 
-		perf_sample_regs_intr(&data->regs_intr, regs);
+		perf_sample_regs_intr(&data->regs_intr, sample_regs);
 
 		if (data->regs_intr.regs) {
 			u64 mask = event->attr.sample_regs_intr;
@@ -11609,7 +11636,8 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (err)
 		return err;
 
-	if (!attr.exclude_kernel) {
+	if (!attr.exclude_kernel || !attr.exclude_callchain_kernel ||
+	    !attr.exclude_hv || !attr.exclude_host || !attr.exclude_guest) {
 		err = perf_allow_kernel(&attr);
 		if (err)
 			return err;
