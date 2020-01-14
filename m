Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD3BC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E5324680
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="uCm0rVgZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgANN4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:56:24 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37665 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgANN4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 08:56:24 -0500
Received: by mail-pl1-f194.google.com with SMTP id c23so5275857plz.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 05:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DqPI1GLrGJXBj+O6IFIkf5XomA9VNoprsRGLS3MppCU=;
        b=uCm0rVgZLRB1i5s5loIxhdMgUpCBJ+R/Ry9xBIwxa2MOLxVyZJPOMLlWDJx0Lvl7Wy
         jDsSZ0smsJVMkI3Sy6l6DVQha3cx/ZzM8yzVfd29zn4pD0I7Eq2bX9W79TFt5yHTE5c6
         nhz2bse4CtZrPIB0pzQBMn52qlEfIZ+/WV0f8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DqPI1GLrGJXBj+O6IFIkf5XomA9VNoprsRGLS3MppCU=;
        b=Cuav+x+RTS5jynYovDLKlpPpW47YRV+A+CC+ivIId5oDm/VsrKficZ8CsWpFU/o/6v
         PPWtbe5Fs844Q2xhxKacFn+6wnafjDfmJ4jOh+Lb9GgXD9jlm6s3lpDKpX4laf/oDnC3
         N7zbYkXm6uok+w9gXgdy0pgmfuCtm4pKAFLvCxFeKOEMWKR5qzpREHKzPlS56qoaFrMj
         Rj44SlyzHPINL9dCazKOzhJWIxpMnQrXrcmc3iq+tTiolJB7Z3C11Umla5vgWD2SOT55
         m7dQ5stbCrQ2Ne4eW0mkLu5OuRksbE88VynU6b4wUqujIUHShBQZRUak0qUx1VtwgQSN
         j1vg==
X-Gm-Message-State: APjAAAW33EY+vmYCuLvhR/+IxLukzq6mshfNlBmkw2rP+fwkMYZ/N2FD
        z0dvrflRxp4sp7xPXr2HqiLKXg==
X-Google-Smtp-Source: APXvYqzZwbq+6agksox4JTtePeSkSMcxnX4qMmb7s17AoIO+KvYXN/biV+h1flAWmRcpHZ7Vcq+FCw==
X-Received: by 2002:a17:90a:2ec5:: with SMTP id h5mr10252278pjs.79.1579010183377;
        Tue, 14 Jan 2020 05:56:23 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id x4sm18184869pff.143.2020.01.14.05.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 05:56:22 -0800 (PST)
Date:   Tue, 14 Jan 2020 08:56:21 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, paulmck@kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -tip V2 2/2] kprobes: Use non RCU traversal APIs on
 kprobe_tables if possible
Message-ID: <20200114135621.GA103493@google.com>
References: <157535316659.16485.11817291759382261088.stgit@devnote2>
 <157535318870.16485.6366477974356032624.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157535318870.16485.6366477974356032624.stgit@devnote2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 03:06:28PM +0900, Masami Hiramatsu wrote:
> Current kprobes uses RCU traversal APIs on kprobe_tables
> even if it is safe because kprobe_mutex is locked.
> 
> Make those traversals to non-RCU APIs where the kprobe_mutex
> is locked.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

May be resend both patch with appropriate tags since it has been some time
since originally posted?

thanks,

 - Joel


> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/kprobes.c |   29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index f9ecb6d532fb..4caab01ace30 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -46,6 +46,11 @@
>  
>  
>  static int kprobes_initialized;
> +/* kprobe_table can be accessed by
> + * - Normal hlist traversal and RCU add/del under kprobe_mutex is held.
> + * Or
> + * - RCU hlist traversal under disabling preempt (breakpoint handlers)
> + */
>  static struct hlist_head kprobe_table[KPROBE_TABLE_SIZE];
>  static struct hlist_head kretprobe_inst_table[KPROBE_TABLE_SIZE];
>  
> @@ -829,7 +834,7 @@ static void optimize_all_kprobes(void)
>  	kprobes_allow_optimization = true;
>  	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
>  		head = &kprobe_table[i];
> -		hlist_for_each_entry_rcu(p, head, hlist)
> +		hlist_for_each_entry(p, head, hlist)
>  			if (!kprobe_disabled(p))
>  				optimize_kprobe(p);
>  	}
> @@ -856,7 +861,7 @@ static void unoptimize_all_kprobes(void)
>  	kprobes_allow_optimization = false;
>  	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
>  		head = &kprobe_table[i];
> -		hlist_for_each_entry_rcu(p, head, hlist) {
> +		hlist_for_each_entry(p, head, hlist) {
>  			if (!kprobe_disabled(p))
>  				unoptimize_kprobe(p, false);
>  		}
> @@ -1479,12 +1484,14 @@ static struct kprobe *__get_valid_kprobe(struct kprobe *p)
>  {
>  	struct kprobe *ap, *list_p;
>  
> +	lockdep_assert_held(&kprobe_mutex);
> +
>  	ap = get_kprobe(p->addr);
>  	if (unlikely(!ap))
>  		return NULL;
>  
>  	if (p != ap) {
> -		list_for_each_entry_rcu(list_p, &ap->list, list)
> +		list_for_each_entry(list_p, &ap->list, list)
>  			if (list_p == p)
>  			/* kprobe p is a valid probe */
>  				goto valid;
> @@ -1649,7 +1656,9 @@ static int aggr_kprobe_disabled(struct kprobe *ap)
>  {
>  	struct kprobe *kp;
>  
> -	list_for_each_entry_rcu(kp, &ap->list, list)
> +	lockdep_assert_held(&kprobe_mutex);
> +
> +	list_for_each_entry(kp, &ap->list, list)
>  		if (!kprobe_disabled(kp))
>  			/*
>  			 * There is an active probe on the list.
> @@ -1728,7 +1737,7 @@ static int __unregister_kprobe_top(struct kprobe *p)
>  	else {
>  		/* If disabling probe has special handlers, update aggrprobe */
>  		if (p->post_handler && !kprobe_gone(p)) {
> -			list_for_each_entry_rcu(list_p, &ap->list, list) {
> +			list_for_each_entry(list_p, &ap->list, list) {
>  				if ((list_p != p) && (list_p->post_handler))
>  					goto noclean;
>  			}
> @@ -2042,13 +2051,15 @@ static void kill_kprobe(struct kprobe *p)
>  {
>  	struct kprobe *kp;
>  
> +	lockdep_assert_held(&kprobe_mutex);
> +
>  	p->flags |= KPROBE_FLAG_GONE;
>  	if (kprobe_aggrprobe(p)) {
>  		/*
>  		 * If this is an aggr_kprobe, we have to list all the
>  		 * chained probes and mark them GONE.
>  		 */
> -		list_for_each_entry_rcu(kp, &p->list, list)
> +		list_for_each_entry(kp, &p->list, list)
>  			kp->flags |= KPROBE_FLAG_GONE;
>  		p->post_handler = NULL;
>  		kill_optimized_kprobe(p);
> @@ -2217,7 +2228,7 @@ static int kprobes_module_callback(struct notifier_block *nb,
>  	mutex_lock(&kprobe_mutex);
>  	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
>  		head = &kprobe_table[i];
> -		hlist_for_each_entry_rcu(p, head, hlist)
> +		hlist_for_each_entry(p, head, hlist)
>  			if (within_module_init((unsigned long)p->addr, mod) ||
>  			    (checkcore &&
>  			     within_module_core((unsigned long)p->addr, mod))) {
> @@ -2468,7 +2479,7 @@ static int arm_all_kprobes(void)
>  	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
>  		head = &kprobe_table[i];
>  		/* Arm all kprobes on a best-effort basis */
> -		hlist_for_each_entry_rcu(p, head, hlist) {
> +		hlist_for_each_entry(p, head, hlist) {
>  			if (!kprobe_disabled(p)) {
>  				err = arm_kprobe(p);
>  				if (err)  {
> @@ -2511,7 +2522,7 @@ static int disarm_all_kprobes(void)
>  	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
>  		head = &kprobe_table[i];
>  		/* Disarm all kprobes on a best-effort basis */
> -		hlist_for_each_entry_rcu(p, head, hlist) {
> +		hlist_for_each_entry(p, head, hlist) {
>  			if (!arch_trampoline_kprobe(p) && !kprobe_disabled(p)) {
>  				err = disarm_kprobe(p, false);
>  				if (err) {
> 
