Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB40C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A618820730
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSJ3K0vV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgDIUNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 16:13:52 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60354 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726796AbgDIUNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 16:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586463232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kTLWkgFqIWtmgZhxyEFwT9Gdraxy4vIoTKEB+6ASHaE=;
        b=gSJ3K0vVi/r4TAvUhQVbFPOgyQGFvJ6LpJppP8Adcw6n4/tIKgalZkoRQ2yLU/t9d5Brav
        Zx5nghGrA06wsFDKP8wnvVxgUkqyxqX86/iwJtVe/Bl2xANuASKsXAP81i86gOLcH6L6aA
        3T1ZZPVovi8eGo6K2EubOvAJ5NDBJ3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-oyh-4vdpPAmGQxPtYSw5EQ-1; Thu, 09 Apr 2020 16:13:48 -0400
X-MC-Unique: oyh-4vdpPAmGQxPtYSw5EQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEA2210753F3;
        Thu,  9 Apr 2020 20:13:46 +0000 (UTC)
Received: from krava (unknown [10.40.196.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DB04760BFB;
        Thu,  9 Apr 2020 20:13:40 +0000 (UTC)
Date:   Thu, 9 Apr 2020 22:13:36 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "bibo,mao" <bibo.mao@intel.com>,
        "Ziqian SUN (Zamir)" <zsun@redhat.com>
Subject: Re: [RFC] kretprobe: Prevent triggering kretprobe from within
 kprobe_flush_task
Message-ID: <20200409201336.GH3309111@krava>
References: <20200408164641.3299633-1-jolsa@kernel.org>
 <20200409234101.8814f3cbead69337ac5a33fa@kernel.org>
 <20200409184451.GG3309111@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409184451.GG3309111@krava>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 08:45:01PM +0200, Jiri Olsa wrote:
> On Thu, Apr 09, 2020 at 11:41:01PM +0900, Masami Hiramatsu wrote:
> 
> SNIP
> 
> > > ---
> > >  kernel/kprobes.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > > index 2625c241ac00..b13247cae752 100644
> > > --- a/kernel/kprobes.c
> > > +++ b/kernel/kprobes.c
> > > @@ -1236,6 +1236,10 @@ __releases(hlist_lock)
> > >  }
> > >  NOKPROBE_SYMBOL(kretprobe_table_unlock);
> > >  
> > > +static struct kprobe kretprobe_dummy = {
> > > +        .addr = (void *)kretprobe_trampoline,
> > > +};
> > > +
> > >  /*
> > >   * This function is called from finish_task_switch when task tk becomes dead,
> > >   * so that we can recycle any function-return probe instances associated
> > > @@ -1256,12 +1260,14 @@ void kprobe_flush_task(struct task_struct *tk)
> > >  	INIT_HLIST_HEAD(&empty_rp);
> > >  	hash = hash_ptr(tk, KPROBE_HASH_BITS);
> > >  	head = &kretprobe_inst_table[hash];
> > > +	__this_cpu_write(current_kprobe, &kretprobe_dummy);
> > 
> > Can you also set the kcb->kprobe_state = KPROBE_HIT_ACTIVE?
> > 
> > BTW, we may be better to introduce a common kprobe_reject_section_start()
> > and kprobe_reject_section_end() so that the user don't need to prepare
> > dummy kprobes.
> 
> sure, will do
> 
> thank you both for review

ok, found out it's actually arch code..  would you guys be ok with something like below?

jirka


---
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 4d7022a740ab..081d0f366c99 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -757,12 +757,33 @@ static struct kprobe kretprobe_kprobe = {
 	.addr = (void *)kretprobe_trampoline,
 };
 
+void arch_kprobe_reject_section_start(void)
+{
+	struct kprobe_ctlblk *kcb;
+
+	preempt_disable();
+
+	/*
+	 * Set a dummy kprobe for avoiding kretprobe recursion.
+	 * Since kretprobe never run in kprobe handler, kprobe must not
+	 * be running behind this point.
+	 */
+	__this_cpu_write(current_kprobe, &kretprobe_kprobe);
+	kcb = get_kprobe_ctlblk();
+	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
+}
+
+void arch_kprobe_reject_section_end(void)
+{
+	__this_cpu_write(current_kprobe, NULL);
+	preempt_enable();
+}
+
 /*
  * Called from kretprobe_trampoline
  */
 __used __visible void *trampoline_handler(struct pt_regs *regs)
 {
-	struct kprobe_ctlblk *kcb;
 	struct kretprobe_instance *ri = NULL;
 	struct hlist_head *head, empty_rp;
 	struct hlist_node *tmp;
@@ -772,16 +793,7 @@ __used __visible void *trampoline_handler(struct pt_regs *regs)
 	void *frame_pointer;
 	bool skipped = false;
 
-	preempt_disable();
-
-	/*
-	 * Set a dummy kprobe for avoiding kretprobe recursion.
-	 * Since kretprobe never run in kprobe handler, kprobe must not
-	 * be running at this point.
-	 */
-	kcb = get_kprobe_ctlblk();
-	__this_cpu_write(current_kprobe, &kretprobe_kprobe);
-	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
+	arch_kprobe_reject_section_start();
 
 	INIT_HLIST_HEAD(&empty_rp);
 	kretprobe_hash_lock(current, &head, &flags);
@@ -873,8 +885,7 @@ __used __visible void *trampoline_handler(struct pt_regs *regs)
 
 	kretprobe_hash_unlock(current, &flags);
 
-	__this_cpu_write(current_kprobe, NULL);
-	preempt_enable();
+	arch_kprobe_reject_section_end();
 
 	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
 		hlist_del(&ri->hlist);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 2625c241ac00..935dd8c87705 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1236,6 +1236,14 @@ __releases(hlist_lock)
 }
 NOKPROBE_SYMBOL(kretprobe_table_unlock);
 
+void __weak arch_kprobe_reject_section_start(void)
+{
+}
+
+void __weak arch_kprobe_reject_section_end(void)
+{
+}
+
 /*
  * This function is called from finish_task_switch when task tk becomes dead,
  * so that we can recycle any function-return probe instances associated
@@ -1253,6 +1261,8 @@ void kprobe_flush_task(struct task_struct *tk)
 		/* Early boot.  kretprobe_table_locks not yet initialized. */
 		return;
 
+	arch_kprobe_reject_section_start();
+
 	INIT_HLIST_HEAD(&empty_rp);
 	hash = hash_ptr(tk, KPROBE_HASH_BITS);
 	head = &kretprobe_inst_table[hash];
@@ -1266,6 +1276,8 @@ void kprobe_flush_task(struct task_struct *tk)
 		hlist_del(&ri->hlist);
 		kfree(ri);
 	}
+
+	arch_kprobe_reject_section_end();
 }
 NOKPROBE_SYMBOL(kprobe_flush_task);
 

