Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC20C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02C6D20724
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bFkV4pDN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgGTBZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 21:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgGTBZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 21:25:33 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8DBC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 18:25:33 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a9so3712771pjd.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 18:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=omIvPcttgu5j5wSkx+ZzUh0WkKQ80FhNwSZ+LIcgfdY=;
        b=bFkV4pDNWUAjKk14sFZtOi41d9jfYk6ONr1UWvb1qKHVwcKGZapxut84X4PS7DttVk
         YukMDyq6uwIr53VzLfImMKiGYi4X+b6YuvUzP82E0Xk6FDaGLk4KOmZpbzbOQOQt29ES
         TEbjQdkE8iHsXTA3pL3oTnXzcpXqCiQnP1ekg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=omIvPcttgu5j5wSkx+ZzUh0WkKQ80FhNwSZ+LIcgfdY=;
        b=KFCa6KDrd+uipu+Q9e2IUiACUNPCeZYoDUth4ueJDZYMT299o3rFjP3OwwkVSgVkt6
         Zc61SBK3/Y1uji30v8b/rVLWgVzBfcghCklfMvIG7HMi6ork2DEuQUQeWOKqy6KVUjFc
         ljZULAEvVslx/aB4YM7LrA9tRK9YagZk+ELl+p0V5YtYfHyzzOhLtgSPuBYGaOgnaDKz
         Bwjz3nhiUWBS0Wc29AeVZEAmC/dC4ooWxZHbg7if/8DSo+gXDln+cSI7cHyIKRwfhKX4
         a8SA10kHxblScfZSSSfK4gyVmgmYfxGK6Vprr+pDD0FSIpgL3SwOG2qTZardIJ6Ij8+h
         Es3A==
X-Gm-Message-State: AOAM530BCzelB9Ae/7N6wJHwglNZ+BOJt7lHOxkUDqeVWDcVu4EAZ94/
        9MutlIqNA0/Tui1wujGThqoDbHaYmE0=
X-Google-Smtp-Source: ABdhPJweJHQ1lV0dJDJGJ11FcH/6Ri+AqIj0q0iZH4W+xWDvCVqXb16WCXGEE9cFpj6PGcb87hwwhA==
X-Received: by 2002:a17:902:900b:: with SMTP id a11mr2290929plp.315.1595208333314;
        Sun, 19 Jul 2020 18:25:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g8sm13526791pgr.70.2020.07.19.18.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 18:25:32 -0700 (PDT)
Date:   Sun, 19 Jul 2020 18:25:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        arjan@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        rick.p.edgecombe@intel.com, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v4 09/10] kallsyms: Hide layout
Message-ID: <202007191815.D39859C@keescook>
References: <20200717170008.5949-1-kristen@linux.intel.com>
 <20200717170008.5949-10-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717170008.5949-10-kristen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 10:00:06AM -0700, Kristen Carlson Accardi wrote:
> This patch makes /proc/kallsyms display in a random order, rather
> than sorted by address in order to hide the newly randomized address
> layout.

Ah! Much nicer. Is there any reason not to just do this unconditionally,
regardless of FGKASLR? It's a smallish dynamic allocation, and
displaying kallsyms is hardly fast-path...

> 
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Tested-by: Tony Luck <tony.luck@intel.com>
> ---
>  kernel/kallsyms.c | 163 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 162 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index bb14e64f62a4..45d147f7f10e 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -446,6 +446,12 @@ struct kallsym_iter {
>  	int show_value;
>  };
>  
> +struct kallsyms_shuffled_iter {
> +	struct kallsym_iter iter;
> +	loff_t total_syms;
> +	loff_t shuffled_index[];
> +};
> +
>  int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
>  			    char *type, char *name)
>  {
> @@ -661,7 +667,7 @@ bool kallsyms_show_value(const struct cred *cred)
>  	}
>  }
>  
> -static int kallsyms_open(struct inode *inode, struct file *file)
> +static int __kallsyms_open(struct inode *inode, struct file *file)
>  {
>  	/*
>  	 * We keep iterator in m->private, since normal case is to
> @@ -682,6 +688,161 @@ static int kallsyms_open(struct inode *inode, struct file *file)
>  	return 0;
>  }
>  
> +/*
> + * When function granular kaslr is enabled, we need to print out the symbols
> + * at random so we don't reveal the new layout.
> + */
> +#if defined(CONFIG_FG_KASLR)
> +static int update_random_pos(struct kallsyms_shuffled_iter *s_iter,
> +			     loff_t pos, loff_t *new_pos)
> +{
> +	loff_t new;
> +
> +	if (pos >= s_iter->total_syms)
> +		return 0;
> +
> +	new = s_iter->shuffled_index[pos];
> +
> +	/*
> +	 * normally this would be done as part of update_iter, however,
> +	 * we want to avoid triggering this in the event that new is
> +	 * zero since we don't want to blow away our pos end indicators.
> +	 */
> +	if (new == 0) {
> +		s_iter->iter.name[0] = '\0';
> +		s_iter->iter.nameoff = get_symbol_offset(new);
> +		s_iter->iter.pos = new;
> +	}
> +
> +	*new_pos = new;
> +	return 1;
> +}
> +
> +static void *shuffled_start(struct seq_file *m, loff_t *pos)
> +{
> +	struct kallsyms_shuffled_iter *s_iter = m->private;
> +	loff_t new_pos;
> +
> +	if (!update_random_pos(s_iter, *pos, &new_pos))
> +		return NULL;
> +
> +	return s_start(m, &new_pos);
> +}
> +
> +static void *shuffled_next(struct seq_file *m, void *p, loff_t *pos)
> +{
> +	struct kallsyms_shuffled_iter *s_iter = m->private;
> +	loff_t new_pos;
> +
> +	(*pos)++;
> +
> +	if (!update_random_pos(s_iter, *pos, &new_pos))
> +		return NULL;
> +
> +	if (!update_iter(m->private, new_pos))
> +		return NULL;
> +
> +	return p;
> +}
> +
> +/*
> + * shuffle_index_list()
> + * Use a Fisher Yates algorithm to shuffle a list of text sections.
> + */
> +static void shuffle_index_list(loff_t *indexes, loff_t size)
> +{
> +	int i;
> +	unsigned int j;
> +	loff_t temp;
> +
> +	for (i = size - 1; i > 0; i--) {
> +		/* pick a random index from 0 to i */
> +		get_random_bytes(&j, sizeof(j));
> +		j = j % (i + 1);
> +
> +		temp = indexes[i];
> +		indexes[i] = indexes[j];
> +		indexes[j] = temp;
> +	}
> +}
> +
> +static const struct seq_operations kallsyms_shuffled_op = {
> +	.start = shuffled_start,
> +	.next = shuffled_next,
> +	.stop = s_stop,
> +	.show = s_show
> +};
> +
> +static int kallsyms_random_open(struct inode *inode, struct file *file)
> +{
> +	loff_t pos;
> +	struct kallsyms_shuffled_iter *shuffled_iter;
> +	struct kallsym_iter iter;
> +	bool show_value;
> +
> +	/*
> +	 * If privileged, go ahead and use the normal algorithm for
> +	 * displaying symbols
> +	 */
> +	show_value = kallsyms_show_value(file->f_cred);
> +	if (show_value)
> +		return __kallsyms_open(inode, file);
> +
> +	/*
> +	 * we need to figure out how many extra symbols there are
> +	 * to print out past kallsyms_num_syms
> +	 */
> +	pos = kallsyms_num_syms;
> +	reset_iter(&iter, 0);
> +	do {
> +		if (!update_iter(&iter, pos))
> +			break;
> +		pos++;
> +	} while (1);

Can this be tracked separately instead of needing to search for it every
time? (Looks like it's modules and ftrace? Could they each have a
*_num_sysms?)

(I need to go read how kallsyms doesn't miscount in general when the
symbol table changes out from under it...)


-- 
Kees Cook
