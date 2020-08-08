Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D109C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 15:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 171D720747
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 15:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596899803;
	bh=vrXTQ3jqGq9bkLQtR5Gb87NhwvMknSluQpWc0Gpsrt4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=pXJ+k8npLAwUvytcWma5fNz6Uzf14r3gwDE45+4frPrbtakHIV66yllqiA3D7IHTk
	 9uaC1vH+SgEdUeBIxi/X/Uq/I9xLk1JlA1TI6y2Pm3/mYlNEwe4+tADJ1KMNmnOT8E
	 8BvHxf+L30MGhaGHPVrwJI8bEhVsSLRF3CGEB1SY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgHHPQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 11:16:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbgHHPP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 11:15:58 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5542420747;
        Sat,  8 Aug 2020 15:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596899757;
        bh=vrXTQ3jqGq9bkLQtR5Gb87NhwvMknSluQpWc0Gpsrt4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=jLS3anyGaaxQB6c23CMnTF4eDIsWFRzeTik5+FWSGzktOuj8ygF6HZ9It8MmKQjZq
         kBdASt0NZm6Ok0jgsccgYTo0Au5VuwIo1PmA2YymibVFS5pcXYOMbp8nm/kXKUOeqb
         8d0ToNexxouV8YlDgWLzWErgofr8EbdmHjTycz6Q=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 32FDC3522622; Sat,  8 Aug 2020 08:15:57 -0700 (PDT)
Date:   Sat, 8 Aug 2020 08:15:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: Fix function name trailing double-()s
Message-ID: <20200808151557.GB4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202008072348.3BA3DD14E@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202008072348.3BA3DD14E@keescook>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 11:49:59PM -0700, Kees Cook wrote:
> I noticed a double-() after a function name in deprecated.rst today. Fix
> that one and two others in the Documentation/ tree.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

For the RCU hunk:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

Or I could take the Documentation/RCU/lockdep.rst portion, if you
would prefer.

> ---
>  Documentation/RCU/lockdep.rst                           | 2 +-
>  Documentation/process/deprecated.rst                    | 2 +-
>  Documentation/translations/it_IT/process/deprecated.rst | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/RCU/lockdep.rst b/Documentation/RCU/lockdep.rst
> index f1fc8ae3846a..cc860a0c296b 100644
> --- a/Documentation/RCU/lockdep.rst
> +++ b/Documentation/RCU/lockdep.rst
> @@ -49,7 +49,7 @@ checking of rcu_dereference() primitives:
>  		is invoked by both RCU-sched readers and updaters.
>  	srcu_dereference_check(p, c):
>  		Use explicit check expression "c" along with
> -		srcu_read_lock_held()().  This is useful in code that
> +		srcu_read_lock_held().  This is useful in code that
>  		is invoked by both SRCU readers and updaters.
>  	rcu_dereference_raw(p):
>  		Don't check.  (Use sparingly, if at all.)
> diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
> index 4a9aa4f0681e..918e32d76fc4 100644
> --- a/Documentation/process/deprecated.rst
> +++ b/Documentation/process/deprecated.rst
> @@ -142,7 +142,7 @@ only NUL-terminated strings. The safe replacement is strscpy().
>  (Users of strscpy() still needing NUL-padding should instead
>  use strscpy_pad().)
>  
> -If a caller is using non-NUL-terminated strings, strncpy()() can
> +If a caller is using non-NUL-terminated strings, strncpy() can
>  still be used, but destinations should be marked with the `__nonstring
>  <https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html>`_
>  attribute to avoid future compiler warnings.
> diff --git a/Documentation/translations/it_IT/process/deprecated.rst b/Documentation/translations/it_IT/process/deprecated.rst
> index e108eaf82cf6..a642ff3fdc8b 100644
> --- a/Documentation/translations/it_IT/process/deprecated.rst
> +++ b/Documentation/translations/it_IT/process/deprecated.rst
> @@ -130,7 +130,7 @@ chi usa solo stringe terminate. La versione sicura da usare è
>  strscpy(). (chi usa strscpy() e necessita di estendere la
>  terminazione con NUL deve aggiungere una chiamata a memset())
>  
> -Se il chiamate no usa stringhe terminate con NUL, allore strncpy()()
> +Se il chiamate no usa stringhe terminate con NUL, allore strncpy()
>  può continuare ad essere usata, ma i buffer di destinazione devono essere
>  marchiati con l'attributo `__nonstring <https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html>`_
>  per evitare avvisi durante la compilazione.
> -- 
> 2.25.1
> 
> 
> -- 
> Kees Cook
