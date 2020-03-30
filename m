Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB7EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1027F20774
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585611023;
	bh=Y7ER3dlZBrPi+ataV+7Z5F/+VEyWcrrMDkj9J6vpEeU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=csoBJoEqtUKZ1HHFwz14rimTLyqAbACGWdH5qXE9V4Rxj6g3w3iDIL4hl9ShZeI4C
	 jr4TLfwnqCvQXsrSajiGuBWqWOZ2GLX+bZlAPxpmT6yXXaDLwT0aHZyEpAeXXDCFXs
	 3rKSIRaJc27KMLkUb02HurL0/zveefJsqraYL688=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgC3XaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 19:30:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:37872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728537AbgC3XaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:30:21 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C926D20771;
        Mon, 30 Mar 2020 23:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585611020;
        bh=Y7ER3dlZBrPi+ataV+7Z5F/+VEyWcrrMDkj9J6vpEeU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ds1bkViWG00jIm0WOighGk47cdO0TnLYGidI+AR+O21BLBm/VPEqpAxTjktw+sJlH
         x9QL3QfVErtrrCYvtfJbYmhb7l4+qbGZQlYkAKeVMOYTlGdCfEw/EJHQMuE7u+0zwj
         XFmg4lmF+NaXqODR3IIMw7HO9ZOSFLW4iSwVvajY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A1C903523140; Mon, 30 Mar 2020 16:30:20 -0700 (PDT)
Date:   Mon, 30 Mar 2020 16:30:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Maddie Stone <maddiestone@google.com>,
        Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 09/21] list: Remove unnecessary WRITE_ONCE() from
 hlist_bl_add_before()
Message-ID: <20200330233020.GF19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200324153643.15527-1-will@kernel.org>
 <20200324153643.15527-10-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324153643.15527-10-will@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 03:36:31PM +0000, Will Deacon wrote:
> There is no need to use WRITE_ONCE() when inserting into a non-RCU
> protected list.
> 
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Will Deacon <will@kernel.org>

OK, I will bite...  Why "unsigned long" instead of "uintptr_t"?

Not that it matters in the context of the Linux kernel, so:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

							Thanx, Paul

> ---
>  include/linux/list_bl.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
> index 1804fdb84dda..c93e7e3aa8fc 100644
> --- a/include/linux/list_bl.h
> +++ b/include/linux/list_bl.h
> @@ -91,15 +91,15 @@ static inline void hlist_bl_add_before(struct hlist_bl_node *n,
>  				       struct hlist_bl_node *next)
>  {
>  	struct hlist_bl_node **pprev = next->pprev;
> +	unsigned long val;
>  
>  	n->pprev = pprev;
>  	n->next = next;
>  	next->pprev = &n->next;
>  
>  	/* pprev may be `first`, so be careful not to lose the lock bit */
> -	WRITE_ONCE(*pprev,
> -		   (struct hlist_bl_node *)
> -			((uintptr_t)n | ((uintptr_t)*pprev & LIST_BL_LOCKMASK)));
> +	val = (unsigned long)n | ((unsigned long)*pprev & LIST_BL_LOCKMASK);
> +	*pprev = (struct hlist_bl_node *)val;
>  }
>  
>  static inline void hlist_bl_add_behind(struct hlist_bl_node *n,
> -- 
> 2.20.1
> 
