Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36191C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 21:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0714820734
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 21:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591739117;
	bh=ZY4Cx5/3wFFlzCvlf1GcovX/L6l91uTsdeclxs8GR5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=axXFYVRQaWWHAplz0breFuR6dWBVz6BcX4Dbe6uy/6LWO+cXgE7zo812EgrfbX3ss
	 JlTV2W6zroFyFdFKUJsP/vc2A3iHNAZwVHpcE4Tplm+eQ4XuauiqbzxeDq4wvgBmIa
	 RlF2KutKEL+jk8uBHI0h9ujyQv997gS2oEsDDNQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgFIVpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 17:45:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728061AbgFIVpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 17:45:14 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D33820734;
        Tue,  9 Jun 2020 21:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591738711;
        bh=ZY4Cx5/3wFFlzCvlf1GcovX/L6l91uTsdeclxs8GR5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dtrhGd0UWqgzVpTJrefK5wMOmp/2rIXyO7xI7RLrrO65jeGQt9kjPllDHHB/C6pWC
         NPvviiFafe8YZCmN49IMEtVPDWivkGI9BW372NAOwIYAjsOOjs5KO1G2paPDx+33h2
         OPZGFtiyTM6anBAKfoqA8swyWS1pYZ/eZcYOEaTU=
Date:   Tue, 9 Jun 2020 14:38:29 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        frederic@kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        cai@lca.pw, mgorman@techsingularity.net
Subject: Re: [RFC][PATCH 7/7] sched: Replace rq::wake_list
Message-ID: <20200609213829.GA789@sol.localdomain>
References: <20200526161057.531933155@infradead.org>
 <20200526161908.129371594@infradead.org>
 <20200604141837.GA179816@roeck-us.net>
 <20200605002433.GA148196@sol.localdomain>
 <20200605074154.GB2750@hirez.programming.kicks-ass.net>
 <20200605161532.GD1373@sol.localdomain>
 <53318971-561c-b445-0408-530b3d3ba44e@roeck-us.net>
 <20200609202134.GA1105@sol.localdomain>
 <20200609212509.GA239889@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609212509.GA239889@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 02:25:09PM -0700, Guenter Roeck wrote:
> > 
> > Still occurring on Linus' tree.  This needs to be fixed.  (And not by removing
> > support for randstruct; that's not a "fix"...)
> > 
> 
> How about the hack below ?
> 
> Guenter
> 
> ---
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index c5d96e3e7fff..df1cbb04f9b3 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -629,6 +629,15 @@ struct wake_q_node {
>  	struct wake_q_node *next;
>  };
>  
> +/*
> + * Hack around assumption that wake_entry_type follows wake_entry even with
> + * CONFIG_GCC_PLUGIN_RANDSTRUCT=y.
> + */
> +struct _wake_entry {
> +	struct llist_node	wake_entry;
> +	unsigned int		wake_entry_type;
> +};
> +
>  struct task_struct {
>  #ifdef CONFIG_THREAD_INFO_IN_TASK
>  	/*
> @@ -653,8 +662,9 @@ struct task_struct {
>  	unsigned int			ptrace;
>  
>  #ifdef CONFIG_SMP
> -	struct llist_node		wake_entry;
> -	unsigned int			wake_entry_type;
> +	struct _wake_entry		_we;
> +#define wake_entry		_we.wake_entry
> +#define wake_entry_type		_we.wake_entry_type
>  	int				on_cpu;
>  #ifdef CONFIG_THREAD_INFO_IN_TASK
>  	/* Current CPU: */

Does the struct actually have to be named?  How about:

diff --git a/include/linux/sched.h b/include/linux/sched.h
index c5d96e3e7fff42..14ca25cda19150 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -653,8 +653,14 @@ struct task_struct {
 	unsigned int			ptrace;
 
 #ifdef CONFIG_SMP
-	struct llist_node		wake_entry;
-	unsigned int			wake_entry_type;
+	/*
+	 * wake_entry_type must follow wake_entry, even when
+	 * CONFIG_GCC_PLUGIN_RANDSTRUCT=y.
+	 */
+	struct {
+		struct llist_node	wake_entry;
+		unsigned int		wake_entry_type;
+	};
 	int				on_cpu;
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/* Current CPU: */


However, it would be preferable to not rely on different structs sharing the
same field order, but rather write proper C code that uses the same struct
everywhere to encapsulate these 2 fields...

- Eric
