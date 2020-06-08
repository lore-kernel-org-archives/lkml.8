Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB36C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 11:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78B2C206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 11:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CRqLZ1Mu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbgFHLV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 07:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729437AbgFHLV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 07:21:56 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7105AC08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 04:21:54 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x13so16972429wrv.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 04:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7JmnrVrM4jkbvqvmDrON3ernI9z2Q/Y9U63X+bmDAOc=;
        b=CRqLZ1MuGY1z2cGvlwtskR4dOsxSsAi20t5GbQzQ0udQ+qbKVQkCJIyS1gJrq3sS7b
         LKgq0PLbbuJvp8P56G5pUBv/PcCEBmziZiwAqEiRRSBWmfRowixyqjKblYQfkZb1gbmg
         iWhuZ/s/e5AUiqOMXBKVF/2JFAKGaHZ1+ykkXYo5B2IUNcNRV13ip9nXISHCPw9vr+xm
         g9PrAspMRyM6KU+XcEzam6SEhZRlFRMwVZHHr+DqohLelGHFQ00fmw0yXDpHD5izupoh
         eFoE7VUvm5VSpmNPil+lOrgv2J/5eLs3Xzw75UywDdPxdmusdBVYzGAXMBah+DuuhtU9
         3LeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7JmnrVrM4jkbvqvmDrON3ernI9z2Q/Y9U63X+bmDAOc=;
        b=FYYToChSJ4gw5gu9KeKm/M30vZNlw9e5MwSbR8Qs90BeIX54yjTI+iisNHsaFkoGZk
         dOzBZvffaxehYSF6BeZb7oPOfarS0VgocElmEuy7xQVQADvZmRRqdCmjktMqbWDGmdtx
         9QJGYiu6DWZIGmOtGXHXYw4Y+FWTESmZgftJkzjPtf68S42hPfCLfTHlO3Jvg3acmHnM
         1yXYAi70tzcGfzCBB+4QU9A9zDzvLBNcRZNceORlV9Ta4rCpNT/cMNu1QqWQSMvjWeEc
         ver7hyEOWRLpvlMQ/muVb9iO2dQquzDdYH9VEMk3lLV0lKkyy3HPEMgDsCB07rGXqaIn
         1WSA==
X-Gm-Message-State: AOAM531XVKwTq18ERXL88ONMBIrv+bXM886WL5VmqDs44ptpR9G2w+mj
        BvunYUaRRCdLg+gMKgF7SesuIWJGC+0=
X-Google-Smtp-Source: ABdhPJy4vr6BsQajdSAzDMV3idbn19bJt8HGtRYVkfzgDxowIPBiwVFrBubghoPsSC4idFsaDnxhGA==
X-Received: by 2002:adf:a34d:: with SMTP id d13mr22107475wrb.270.1591615313014;
        Mon, 08 Jun 2020 04:21:53 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id f185sm12437862wmf.43.2020.06.08.04.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 04:21:52 -0700 (PDT)
Date:   Mon, 8 Jun 2020 12:21:50 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH 03/16] dyndbg: refine debug verbosity; 1 is basic, 2 more
 chatty
Message-ID: <20200608112150.7ohrax6pzpi7ss2l@holly.lan>
References: <20200605162645.289174-1-jim.cromie@gmail.com>
 <20200605162645.289174-4-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605162645.289174-4-jim.cromie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 10:26:32AM -0600, Jim Cromie wrote:
> The verbose/debug logging done for `cat $MNT/dynamic_debug/control` is
> voluminous (2 per control file entry + 2 per PAGE).  Moreover, it just
> prints pointer and sequence, which is not useful to a dyndbg user.
> So just drop them.

I'd assumed these messages where to help the dyndbg implementer rather
than the dyndbg user. If the verbose messages really are useful to help
users who (mis)configure .../control then should the enable/disable
control be shadowed in debugfs to make it easy to find?


Daniel.

> 
> Also require verbose>=2 for several other debug printks that are a bit
> too chatty for typical needs;
> 
> ddebug_change() prints changes, once per modified callsite.  Since
> queries like "+p" will enable ~2300 callsites in a typical laptop, a
> user probably doesnt need to see them often.  ddebug_exec_queries()
> still summarizes with verbose=1.
> 
> ddebug_(add|remove)_module() also print 1 line per action on a module,
> not needed by typical modprobe user.
> 
> This leaves verbose=1 better focussed on the >control parsing process.
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  lib/dynamic_debug.c | 21 ++++++++-------------
>  1 file changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> index b877774dba96..5900c043e979 100644
> --- a/lib/dynamic_debug.c
> +++ b/lib/dynamic_debug.c
> @@ -105,12 +105,15 @@ static char *ddebug_describe_flags(struct _ddebug *dp, char *buf,
>  	return buf;
>  }
>  
> -#define vpr_info(fmt, ...)					\
> +#define vnpr_info(lvl, fmt, ...)				\
>  do {								\
> -	if (verbose)						\
> +	if (verbose >= lvl)					\
>  		pr_info(fmt, ##__VA_ARGS__);			\
>  } while (0)
>  
> +#define vpr_info(fmt, ...)	vnpr_info(1, fmt, ##__VA_ARGS__)
> +#define v2pr_info(fmt, ...)	vnpr_info(2, fmt, ##__VA_ARGS__)
> +
>  static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
>  {
>  	/* trim any trailing newlines */
> @@ -198,7 +201,7 @@ static int ddebug_change(const struct ddebug_query *query,
>  				static_branch_enable(&dp->key.dd_key_true);
>  #endif
>  			dp->flags = newflags;
> -			vpr_info("changed %s:%d [%s]%s =%s\n",
> +			v2pr_info("changed %s:%d [%s]%s =%s\n",
>  				 trim_prefix(dp->filename), dp->lineno,
>  				 dt->mod_name, dp->function,
>  				 ddebug_describe_flags(dp, flagbuf,
> @@ -771,8 +774,6 @@ static void *ddebug_proc_start(struct seq_file *m, loff_t *pos)
>  	struct _ddebug *dp;
>  	int n = *pos;
>  
> -	vpr_info("called m=%p *pos=%lld\n", m, (unsigned long long)*pos);
> -
>  	mutex_lock(&ddebug_lock);
>  
>  	if (!n)
> @@ -795,9 +796,6 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
>  	struct ddebug_iter *iter = m->private;
>  	struct _ddebug *dp;
>  
> -	vpr_info("called m=%p p=%p *pos=%lld\n",
> -		 m, p, (unsigned long long)*pos);
> -
>  	if (p == SEQ_START_TOKEN)
>  		dp = ddebug_iter_first(iter);
>  	else
> @@ -818,8 +816,6 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
>  	struct _ddebug *dp = p;
>  	char flagsbuf[10];
>  
> -	vpr_info("called m=%p p=%p\n", m, p);
> -
>  	if (p == SEQ_START_TOKEN) {
>  		seq_puts(m,
>  			 "# filename:lineno [module]function flags format\n");
> @@ -842,7 +838,6 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
>   */
>  static void ddebug_proc_stop(struct seq_file *m, void *p)
>  {
> -	vpr_info("called m=%p p=%p\n", m, p);
>  	mutex_unlock(&ddebug_lock);
>  }
>  
> @@ -905,7 +900,7 @@ int ddebug_add_module(struct _ddebug *tab, unsigned int n,
>  	list_add_tail(&dt->link, &ddebug_tables);
>  	mutex_unlock(&ddebug_lock);
>  
> -	vpr_info("%u debug prints in module %s\n", n, dt->mod_name);
> +	v2pr_info("%u debug prints in module %s\n", n, dt->mod_name);
>  	return 0;
>  }
>  
> @@ -964,7 +959,7 @@ int ddebug_remove_module(const char *mod_name)
>  	struct ddebug_table *dt, *nextdt;
>  	int ret = -ENOENT;
>  
> -	vpr_info("removing module \"%s\"\n", mod_name);
> +	v2pr_info("removing module \"%s\"\n", mod_name);
>  
>  	mutex_lock(&ddebug_lock);
>  	list_for_each_entry_safe(dt, nextdt, &ddebug_tables, link) {
> -- 
> 2.26.2
> 
