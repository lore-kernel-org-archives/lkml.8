Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B08C33CB7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 02:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA732468C
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 02:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="MSAL+3bf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgASCO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 21:14:27 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:50359 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgASCO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 21:14:27 -0500
Received: by mail-pj1-f67.google.com with SMTP id r67so5004963pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 18:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wKnHTOsGYbWMuEtHLalSufdyt5LKcQfM0ik/ggkorb8=;
        b=MSAL+3bf/Sr2q37mtoS4XEMfewmJNpRseZ6b4abZn9jW7t3K12vCcgectB7jCIDb7/
         j6RbLWT4TqX3yfnuGs+zMOw7LRrOGeL5RmzFVP9zcT49BJEUaASoMtd4wJqKyv97Ir+q
         BXawhfdNbTXCBZp2wkM2yRwSvg0ywrzs26GfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wKnHTOsGYbWMuEtHLalSufdyt5LKcQfM0ik/ggkorb8=;
        b=YIb4iuaZkDs9Hchd35Z/P41WcvAmCG6kieO97BJFUHLOz1yJQe/ySzZPoihU2185/w
         /pXwpFWtryV24WR6lNjAqZKtOcUAi3Dw1FM/YUGNYgNqY8OvG3tJYFIJ46+aDjITMRe9
         Or7PRPdk6GYGydBkG63SnLLuD95YF2ISQgp9onHtJZIO2WUxPxy6po6GmmM+nQOSQgkk
         hENy/KzGHnmiPl7cHIoORwTxcHC4M8QTfEKE9Qo4mep170vv/EU/scUbcYIxm2JNtPT3
         FQ0wLy0nL1l8CFbe2Be+ZNug2YzG+TACAvdam3tUUNEemlr6Q6Kr0Ax6Y0GTRoFU5Kr1
         xqeA==
X-Gm-Message-State: APjAAAVg+/RvGeLg+lHLGK/Q97T04bZq6TRnlSFUVxa1xC0UYAHJOxZy
        6eZGsBky2mRcACd9BZo4//yM6A==
X-Google-Smtp-Source: APXvYqy1q/djUVAv160MfTz3J71YGDJtMyBxn5miqmwtbqWbxd3BLPJQgl9/gbHhVY35TvtnaXx2tQ==
X-Received: by 2002:a17:902:9a8e:: with SMTP id w14mr7598767plp.315.1579400066308;
        Sat, 18 Jan 2020 18:14:26 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id h7sm35796636pfq.36.2020.01.18.18.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 18:14:25 -0800 (PST)
Date:   Sat, 18 Jan 2020 21:14:25 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Amol Grover <frextrite@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: Re: [PATCH] rculist: Add brackets around cond argument in
 __list_check_rcu macro
Message-ID: <20200119021425.GH244899@google.com>
References: <20200118165417.12325-1-frextrite@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200118165417.12325-1-frextrite@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 18, 2020 at 10:24:18PM +0530, Amol Grover wrote:
> Passing a complex lockdep condition to __list_check_rcu results
> in false positive lockdep splat due to incorrect expression
> evaluation.
> 
> For example, a lockdep check condition `cond1 || cond2` is
> evaluated as `!cond1 || cond2 && !rcu_read_lock_any_held()`
> which, according to operator precedence, evaluates to
> `!cond1 || (cond2 && !rcu_read_lock_any_held())`.
> This would result in a lockdep splat when cond1 is false
> and cond2 is true which is logically incorrect.
> 
> Signed-off-by: Amol Grover <frextrite@gmail.com>

Good catch!

Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> ---
>  include/linux/rculist.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> index 4158b7212936..dce491f0b354 100644
> --- a/include/linux/rculist.h
> +++ b/include/linux/rculist.h
> @@ -50,9 +50,9 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
>  #define __list_check_rcu(dummy, cond, extra...)				\
>  	({								\
>  	check_arg_count_one(extra);					\
> -	RCU_LOCKDEP_WARN(!cond && !rcu_read_lock_any_held(),		\
> +	RCU_LOCKDEP_WARN(!(cond) && !rcu_read_lock_any_held(),		\
>  			 "RCU-list traversed in non-reader section!");	\
> -	 })
> +	})
>  #else
>  #define __list_check_rcu(dummy, cond, extra...)				\
>  	({ check_arg_count_one(extra); })
> -- 
> 2.24.1
> 
