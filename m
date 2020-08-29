Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16C1C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 01:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F8A420838
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 01:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598664220;
	bh=F9hBNWLyRra68dxRI9RjiTAZ+LKfG5JEo8sjnz33zCc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=MalE1IqGutxnUPi4k/pk9la0JOFT3xkc4kQ+zsyu0ABJhGDzkh80cSW1L7CANCIbt
	 ckBP2xzgxN4T892ksny5DYsEw2kvUoI8pBMwXWn+lH73en5eJwj3ErQzIs5kKX2wTg
	 1P9eX//68Og5pgDJYT/wDKRkZdFi6T5sbQiaGBWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgH2BXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 21:23:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbgH2BX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 21:23:29 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC84B20838;
        Sat, 29 Aug 2020 01:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598664208;
        bh=F9hBNWLyRra68dxRI9RjiTAZ+LKfG5JEo8sjnz33zCc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jgBBE+4c0RiZ5IEdLtfaymXw5yZkMh5DpJkc+9SqLP7mQQ90m5xTJY94GpiDTJsGF
         PtrJEBxj2Kou4GRAF9fNWphtMLCuW3qrlkyQlUsTXWu4B9whZektNEgnmfiFI0XTyo
         /OqlkqyTzB+w8o7IHL8633EelnXWYZDBQ4jUaaCw=
Date:   Sat, 29 Aug 2020 10:23:24 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 19/23] kprobes: Remove kretprobe hash
Message-Id: <20200829102324.fcbddbca8a122814d0508abe@kernel.org>
In-Reply-To: <20200828202912.GA29142@worktop.programming.kicks-ass.net>
References: <159861759775.992023.12553306821235086809.stgit@devnote2>
        <159861780638.992023.16486601398173945135.stgit@devnote2>
        <305dad6efa9e4c42b13b72a5f770b933@trendmicro.com>
        <20200828202912.GA29142@worktop.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Aug 2020 22:29:12 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Aug 28, 2020 at 07:32:11PM +0000, Eddy_Wu@trendmicro.com wrote:
> > 
> > > -----Original Message-----
> > > From: Masami Hiramatsu <mhiramat@kernel.org>
> > >
> > > @@ -1311,24 +1257,23 @@ void kprobe_busy_end(void)
> > >  void kprobe_flush_task(struct task_struct *tk)
> > >  {
> > >         struct kretprobe_instance *ri;
> > > +       struct llist_node *node;
> > >
> > > +       /* Early boot, not yet initialized. */
> > >         if (unlikely(!kprobes_initialized))
> > >                 return;
> > >
> > >         kprobe_busy_begin();
> > >
> > > +       node = current->kretprobe_instances.first;
> > > +       current->kretprobe_instances.first = NULL;
> > 
> > I think we are flushing tk instead of current here.
> > After fixing this to tk, the NULL pointer deference is gone!
> 

Cool!!

> Ah, very good! I can indeed confirm that that cures things.

OK, I'll merge this too.

Thank you,

> 
> ---
> Index: linux-2.6/kernel/kprobes.c
> ===================================================================
> --- linux-2.6.orig/kernel/kprobes.c
> +++ linux-2.6/kernel/kprobes.c
> @@ -1275,9 +1275,7 @@ void kprobe_flush_task(struct task_struc
> 
>  	kprobe_busy_begin();
> 
> -	node = current->kretprobe_instances.first;
> -	current->kretprobe_instances.first = NULL;
> -
> +	node == __llist_del_all(&tk->kretprobe_instances);
>  	while (node) {
>  		ri = container_of(node, struct kretprobe_instance, llist);
>  		node = node->next;
> @@ -1871,6 +1869,7 @@ unsigned long __kretprobe_trampoline_han
>  	struct llist_node *first, *node;
>  	struct kretprobe *rp;
> 
> +	/* Find all nodes for this frame. */
>  	first = node = current->kretprobe_instances.first;
>  	while (node) {
>  		ri = container_of(node, struct kretprobe_instance, llist);
> @@ -1900,7 +1899,7 @@ unsigned long __kretprobe_trampoline_han
>  	while (first) {
>  		ri = container_of(first, struct kretprobe_instance, llist);
>  		rp = get_kretprobe(ri);
> -		node = first->next;
> +		first = first->next;
> 
>  		if (rp && rp->handler) {
>  			__this_cpu_write(current_kprobe, &rp->kp);
> @@ -1910,8 +1909,6 @@ unsigned long __kretprobe_trampoline_han
>  		}
> 
>  		recycle_rp_inst(ri);
> -
> -		first = node;
>  	}
> 
>  	return (unsigned long)correct_ret_addr;
> Index: linux-2.6/include/linux/llist.h
> ===================================================================
> --- linux-2.6.orig/include/linux/llist.h
> +++ linux-2.6/include/linux/llist.h
> @@ -237,6 +237,14 @@ static inline struct llist_node *llist_d
>  	return xchg(&head->first, NULL);
>  }
> 
> +static inline struct llist_node *__llist_del_all(struct llist_head *head)
> +{
> +	struct llist_node *first = head->first;
> +
> +	head->first = NULL;
> +	return first;
> +}
> +
>  extern struct llist_node *llist_del_first(struct llist_head *head);
> 
>  struct llist_node *llist_reverse_order(struct llist_node *head);
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
