Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00F3C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 22:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17BA20873
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 22:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="OHUFj0mV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgBLWiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 17:38:21 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39397 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbgBLWiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 17:38:20 -0500
Received: by mail-qk1-f194.google.com with SMTP id w15so3785022qkf.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 14:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wZAgduaulew5xs0mDPyKP8Dt1/4k4uuQj0GhkxD82NU=;
        b=OHUFj0mVm/niHRieSJJsyde147mXao42JpBXjmrBE46NbFcv7REFDzwKwhMNXUmwA2
         HyssDB+2lB3+spXMTqRVVEBo/DM797tmAkZ2Gpx4+jIiI8qdqOg0B/x0+NNuUsoGAs8k
         cXv2lr6mdmY9kQuWXmlQiIC1g+SPJO8Vms1us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wZAgduaulew5xs0mDPyKP8Dt1/4k4uuQj0GhkxD82NU=;
        b=EfiPQudwbpULgqR0pb/+unwq8X+UUfbgAR1035iGefbctFeqOi+kIgRa2nheHq7i/F
         1J8ZklY0fUqi3i2RDIgKRQAMv+eqkmlPLwUELIKn5D+VJjKjpx4pghDQ0e9U5sXy3Pqc
         /Jpho3usO5qFRi9/WeCP1LV0LWBnuWqL0+AIH4ceXbU+G0h10hWEjBLFbQJHMUODK+e8
         dvZ/bqbXg6Rmw/AnK4fI6PzklCSw5Zu4Ev59yoIkWUc3mfqfsvI86uLzncvcsq1E3cTr
         svQuFwZ9kGsLlGSZd00cjU0Wqittbvq9ldKlJcAbyk2d49ON749vXoyN3hYrqzTTIKrf
         sJ1Q==
X-Gm-Message-State: APjAAAXVNBMtqq2l538G/4on42XOt0j83HLb7bLl4DOlhewYLB0I6k6Y
        XrAks9eHqTuLOcQsGU6EMFOUSw==
X-Google-Smtp-Source: APXvYqwrwDORsqMvXp6lWqe5/mlr67wfSg2ox7qEAyWpjxvOye3bYqC3ZzKxpguP4UYez14gI6De0w==
X-Received: by 2002:ae9:f442:: with SMTP id z2mr13280596qkl.130.1581547099598;
        Wed, 12 Feb 2020 14:38:19 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id b7sm184312qka.67.2020.02.12.14.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 14:38:19 -0800 (PST)
Date:   Wed, 12 Feb 2020 17:38:18 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com
Subject: Re: [PATCH v2 2/9] rcu: Mark rcu_dynticks_curr_cpu_in_eqs() inline
Message-ID: <20200212223818.GA115917@google.com>
References: <20200212210139.382424693@infradead.org>
 <20200212210749.915180520@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212210749.915180520@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 10:01:41PM +0100, Peter Zijlstra wrote:
> Since rcu_is_watching() is notrace (and needs to be, as it can be
> called from the tracers), make sure everything it in turn calls is
> notrace too.
> 
> To that effect, mark rcu_dynticks_curr_cpu_in_eqs() inline, which
> implies notrace, as the function is tiny.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/rcu/tree.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -294,7 +294,7 @@ static void rcu_dynticks_eqs_online(void
>   *
>   * No ordering, as we are sampling CPU-local information.
>   */
> -static bool rcu_dynticks_curr_cpu_in_eqs(void)
> +static inline bool rcu_dynticks_curr_cpu_in_eqs(void)

I think there are ways to turn off function inlining, such as gcc's:
-fkeep-inline-functions

And just to be sure weird compilers (clang *cough*) don't screw this up,
could we make it static inline notrace?

Build tested it on the tip tree on top of your patch:

---8<-----------------------

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f3cb824fe5bbf..078d56951c8e7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -294,7 +294,7 @@ static void rcu_dynticks_eqs_online(void)
  *
  * No ordering, as we are sampling CPU-local information.
  */
-static inline bool rcu_dynticks_curr_cpu_in_eqs(void)
+static inline notrace bool rcu_dynticks_curr_cpu_in_eqs(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
