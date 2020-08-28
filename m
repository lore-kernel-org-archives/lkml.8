Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60E9C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9059920872
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hYXbCUPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgH1U32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 16:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgH1U3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 16:29:21 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412D5C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 13:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UIDvYBKnCCjagIrDmteTKKKORK1KkRoA8eLAlbMun3E=; b=hYXbCUPhotZKUnq1DGoXFiIqnn
        bHD12zJ+0WY4Jen0dT7kOKWObdc3uHlb4DpjVZwU/5FwmeCKJkdk7f6de7zVkIv+uGNjU+aKjkc/w
        0fHKSKWsZoGKuvrJl5Vm9F6Zd4hykncMWfnYL4vz4FX01hRVyYpaexoR9N/r2s1V3BGeVINBB6Buq
        qpgYwmszU04iMgDdeTv1XhD+vvCovsG/Gqn8KGZnu+OAXWHmw1aa6JcUHLfsRY6dmAwSuTbklAtIy
        f2jztSFpkaOklK/nXWB3kAI40RA34N6RFVNpLE2hX42M4y9OG6mpnAn4OHn5c+x0rYc8bAykL+q5o
        PdItLtWA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBkzr-0005zb-K9; Fri, 28 Aug 2020 20:29:15 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 02227980DC7; Fri, 28 Aug 2020 22:29:12 +0200 (CEST)
Date:   Fri, 28 Aug 2020 22:29:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 19/23] kprobes: Remove kretprobe hash
Message-ID: <20200828202912.GA29142@worktop.programming.kicks-ass.net>
References: <159861759775.992023.12553306821235086809.stgit@devnote2>
 <159861780638.992023.16486601398173945135.stgit@devnote2>
 <305dad6efa9e4c42b13b72a5f770b933@trendmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <305dad6efa9e4c42b13b72a5f770b933@trendmicro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 07:32:11PM +0000, Eddy_Wu@trendmicro.com wrote:
> 
> > -----Original Message-----
> > From: Masami Hiramatsu <mhiramat@kernel.org>
> >
> > @@ -1311,24 +1257,23 @@ void kprobe_busy_end(void)
> >  void kprobe_flush_task(struct task_struct *tk)
> >  {
> >         struct kretprobe_instance *ri;
> > +       struct llist_node *node;
> >
> > +       /* Early boot, not yet initialized. */
> >         if (unlikely(!kprobes_initialized))
> >                 return;
> >
> >         kprobe_busy_begin();
> >
> > +       node = current->kretprobe_instances.first;
> > +       current->kretprobe_instances.first = NULL;
> 
> I think we are flushing tk instead of current here.
> After fixing this to tk, the NULL pointer deference is gone!

Ah, very good! I can indeed confirm that that cures things.

---
Index: linux-2.6/kernel/kprobes.c
===================================================================
--- linux-2.6.orig/kernel/kprobes.c
+++ linux-2.6/kernel/kprobes.c
@@ -1275,9 +1275,7 @@ void kprobe_flush_task(struct task_struc

 	kprobe_busy_begin();

-	node = current->kretprobe_instances.first;
-	current->kretprobe_instances.first = NULL;
-
+	node == __llist_del_all(&tk->kretprobe_instances);
 	while (node) {
 		ri = container_of(node, struct kretprobe_instance, llist);
 		node = node->next;
@@ -1871,6 +1869,7 @@ unsigned long __kretprobe_trampoline_han
 	struct llist_node *first, *node;
 	struct kretprobe *rp;

+	/* Find all nodes for this frame. */
 	first = node = current->kretprobe_instances.first;
 	while (node) {
 		ri = container_of(node, struct kretprobe_instance, llist);
@@ -1900,7 +1899,7 @@ unsigned long __kretprobe_trampoline_han
 	while (first) {
 		ri = container_of(first, struct kretprobe_instance, llist);
 		rp = get_kretprobe(ri);
-		node = first->next;
+		first = first->next;

 		if (rp && rp->handler) {
 			__this_cpu_write(current_kprobe, &rp->kp);
@@ -1910,8 +1909,6 @@ unsigned long __kretprobe_trampoline_han
 		}

 		recycle_rp_inst(ri);
-
-		first = node;
 	}

 	return (unsigned long)correct_ret_addr;
Index: linux-2.6/include/linux/llist.h
===================================================================
--- linux-2.6.orig/include/linux/llist.h
+++ linux-2.6/include/linux/llist.h
@@ -237,6 +237,14 @@ static inline struct llist_node *llist_d
 	return xchg(&head->first, NULL);
 }

+static inline struct llist_node *__llist_del_all(struct llist_head *head)
+{
+	struct llist_node *first = head->first;
+
+	head->first = NULL;
+	return first;
+}
+
 extern struct llist_node *llist_del_first(struct llist_head *head);

 struct llist_node *llist_reverse_order(struct llist_node *head);

