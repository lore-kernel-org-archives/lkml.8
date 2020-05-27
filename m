Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8FFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A55D2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lAj3+1b/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389204AbgE0O0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 10:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389036AbgE0O0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:26:23 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF37C08C5C2
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 07:26:21 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j198so2401803wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 07:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mly88rOWldb2hn6ZUpBbudlq0QPli1OI+xak074b4r4=;
        b=lAj3+1b/p3m/ElrnylWgfn/5vAM5qlt1rTY6GYJMqKlpy+5swWInxuNIz8ay89ysVX
         hc8Pzyf7c0E+jRldyVyLLE8rScc7piJOSxcjE8PLU1GH0bXHL0rfcGhfwDFAVn7FKZ94
         f3HVHC9HU1SoQHT7yZOoYKcHdZWZL70//b9+xYaGv5rwmkxCyLnRWFHLChSXU3dsBxNV
         tPNC8prFGFq+u/6YnTni0cBmAkN2MQc5sSCySaBzuOkCenirCZgX4UP9Q0EoxKOd5nzv
         keB2wPsIVLoFf0Y5FLqgvswggZtbokmEZQP7V5VJJTCJ0soabWSO4axKZgomC8qEW/T1
         /lMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mly88rOWldb2hn6ZUpBbudlq0QPli1OI+xak074b4r4=;
        b=HhAwbPfC9fQp2UXgGD19I7u5VqM1id6H1YwEwvZQ2zAGYiYU9aFDbGU0lLClWPi8AZ
         sAUbjAh1wy39EGVAPRYBZQYtI2LY2ItrmbTG4tvgCMXcVTB1YCkHwXbgK2yf1RQPg4uR
         fb00JIKU12Ox1rc8s0SR7a0ThcWEdV1OMpS3DNHZwcCQmDxOR4lSnAoywg6KVriE0DCJ
         4ECcstW7TJAHZ2Plsm51h2FKrxXp8ssMydwXrkQ1mDPHNtv4tbPvuLt3x8zr0shQGQSF
         6+7tostZy9yKiW1UnHTQSgDRtspo0G5gxRmcvz7vPHNy4w+54KTh/lzmvvJXAd4nUaHy
         1PEw==
X-Gm-Message-State: AOAM533TWdWjo+A9DkO2zpDLpHXBvrR9gE0dUt9yAd7DJDOkpJYyt5ZJ
        4Pc6zXwyDiRi0J/GjDqB8QdHpQ==
X-Google-Smtp-Source: ABdhPJwSEI2N+Z0JrEzzTe6BWOigRZOSAIjRwq1zxP+KiTxFgPixzdvK7ac/pvk3MQ7iCOeGdGApOQ==
X-Received: by 2002:a1c:f315:: with SMTP id q21mr4299691wmq.114.1590589580237;
        Wed, 27 May 2020 07:26:20 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id s2sm2777668wmh.11.2020.05.27.07.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 07:26:19 -0700 (PDT)
Date:   Wed, 27 May 2020 15:26:17 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] kdb: Make kdb_printf robust to run in NMI context
Message-ID: <20200527142617.t7dzal7ok5i3exra@holly.lan>
References: <1590560759-21453-1-git-send-email-sumit.garg@linaro.org>
 <1590560759-21453-4-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590560759-21453-4-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 11:55:58AM +0530, Sumit Garg wrote:
> While rounding up CPUs via NMIs, its possible that a rounded up CPU

This problem does not just impact NMI roundup (breakpoints, including
implicit breakpoint-on-oops can have the same effect).


> maybe holding a console port lock leading to kgdb master CPU stuck in
> a deadlock during invocation of console write operations. So in order
> to avoid such a deadlock, enable oops_in_progress prior to invocation
> of console handlers.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  kernel/debug/kdb/kdb_io.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 349dfcc..f848482 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -566,7 +566,17 @@ static void kdb_msg_write(char *msg, int msg_len)
>  	for_each_console(c) {
>  		if (!(c->flags & CON_ENABLED))
>  			continue;
> +		/*
> +		 * While rounding up CPUs via NMIs, its possible that

Ditto.

> +		 * a rounded up CPU maybe holding a console port lock
> +		 * leading to kgdb master CPU stuck in a deadlock during
> +		 * invocation of console write operations. So in order
> +		 * to avoid such a deadlock, enable oops_in_progress
> +		 * prior to invocation of console handlers.

Actually looking at this comment as a whole I think it spends to many
words on what and not enough on why (e.g. what the tradeoffs are and
why we are not using bust_spinlocks() which would be a more obvious
approach).

  Set oops_in_progress to encourage the console drivers to disregard
  their internal spin locks: in the current calling context
  the risk of deadlock is a bigger problem than risks due to
  re-entering the console driver. We operate directly on
  oops_in_progress rather than using bust_spinlocks() because
  the calls bust_spinlocks() makes on exit are not appropriate
  for this calling context.


Daniel.


> +		 */
> +		++oops_in_progress;
>  		c->write(c, msg, msg_len);
> +		--oops_in_progress;
>  		touch_nmi_watchdog();
>  	}
>  }
> -- 
> 2.7.4
> 
