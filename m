Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5944C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E72C2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LM+9Emsg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389668AbgFXHVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 03:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbgFXHVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 03:21:00 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEEAC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 00:20:59 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id d6so784733pjs.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 00:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pjnQ7WBzCOByclYff5fag1J6k77rRFjTJeOwwIhXIsI=;
        b=LM+9Emsg/Bnt9ZPqcCtr1BIO53wrwaXkstgGZO8mwi6wqv0h60blnansku5od/fTJN
         owpxS2UsG0aNQ+ZThFnv5sjD8qtDr2g6ICUJoExlIp4x+ifOT9hyUOwAARo7C4YxFk1b
         ruSfG+DQPOplV5fZHpAsmSK1cGDsDRMt9v2fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pjnQ7WBzCOByclYff5fag1J6k77rRFjTJeOwwIhXIsI=;
        b=cVycf/9A7CT+Pwa9UuHK8B9jlLtkG28zWKCBmaEds2hy10pp+bOIJ1+PyMcIGS5q8c
         M0J/ylDZe+GUAzHEXWI8sA4LQ0+vTrNgfGuHFNvCIUgGPwCXfMGwJYeIvn9sFc5jS9hR
         q1+AE5hqcModHylhlcvaVExylUh91+16e/SMvdXOrdSwcZ2Tzd1vknb5YDeYHz046HgV
         pZ08CEHveDblcG1o3NGjy2mYObZ3pzGc4dM3UUTHDzeiA4hYqObMKYaeOQ3TntXEgA51
         DA6NAYpiGQjR2R5+dUrtnukaRl/1ZBuUqXKlRUGtUlvjXeq7Sct7MdLe5VEAOby8GbwX
         8zCQ==
X-Gm-Message-State: AOAM530ldXOUOUiVwplvR5XmhYk/PPcpMsr9zhUbWDdcyof4rxIw5gSB
        g2odCCxkNhj5Uc+pRCvVNeLfvQ==
X-Google-Smtp-Source: ABdhPJx0mccfQsquGoFKjKPiTC10fC3qOuSqvdb6OgKAmDilcLtaiwiVyjw/1caXio4aFtntnNK1MQ==
X-Received: by 2002:a17:902:bd0b:: with SMTP id p11mr26994367pls.91.1592983258898;
        Wed, 24 Jun 2020 00:20:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u20sm1917349pfm.152.2020.06.24.00.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 00:20:58 -0700 (PDT)
Date:   Wed, 24 Jun 2020 00:20:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        arjan@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        rick.p.edgecombe@intel.com, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v3 09/10] kallsyms: Hide layout
Message-ID: <202006240013.7806A28435@keescook>
References: <20200623172327.5701-1-kristen@linux.intel.com>
 <20200623172327.5701-10-kristen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200623172327.5701-10-kristen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 10:23:26AM -0700, Kristen Carlson Accardi wrote:
> This patch makes /proc/kallsyms display alphabetically by symbol
> name rather than sorted by address in order to hide the newly
> randomized address layout.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Tested-by: Tony Luck <tony.luck@intel.com>
> ---
>  kernel/kallsyms.c | 128 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 128 insertions(+)
> 
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index 16c8c605f4b0..df2b20e1b7f2 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -25,6 +25,7 @@
>  #include <linux/filter.h>
>  #include <linux/ftrace.h>
>  #include <linux/compiler.h>
> +#include <linux/list_sort.h>
>  
>  /*
>   * These will be re-linked against their real values
> @@ -446,6 +447,11 @@ struct kallsym_iter {
>  	int show_value;
>  };
>  
> +struct kallsyms_iter_list {
> +	struct kallsym_iter iter;
> +	struct list_head next;
> +};
> +
>  int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
>  			    char *type, char *name)
>  {
> @@ -660,6 +666,127 @@ int kallsyms_show_value(void)
>  	}
>  }

The #ifdef can be moved up to here:

#ifdef CONFIG_FG_KASLR

Otherwise without CONFIG_FG_KASLR, I get:

kernel/kallsyms.c:714:12: warning: ‘kallsyms_list_cmp’ defined but not used [-Wunused-function]
  714 | static int kallsyms_list_cmp(void *priv, struct list_head *a,
      |            ^~~~~~~~~~~~~~~~~


>  
> +static int sorted_show(struct seq_file *m, void *p)
> +{
> +	struct list_head *list = m->private;
> +	struct kallsyms_iter_list *iter;
> +	int rc;
> +
> +	if (list_empty(list))
> +		return 0;
> +
> +	iter = list_first_entry(list, struct kallsyms_iter_list, next);
> +
> +	m->private = iter;
> +	rc = s_show(m, p);
> +	m->private = list;
> +
> +	list_del(&iter->next);
> +	kfree(iter);
> +
> +	return rc;
> +}
> +
> +static void *sorted_start(struct seq_file *m, loff_t *pos)
> +{
> +	return m->private;
> +}
> +
> +static void *sorted_next(struct seq_file *m, void *p, loff_t *pos)
> +{
> +	struct list_head *list = m->private;
> +
> +	(*pos)++;
> +
> +	if (list_empty(list))
> +		return NULL;
> +
> +	return p;
> +}
> +
> +static const struct seq_operations kallsyms_sorted_op = {
> +	.start = sorted_start,
> +	.next = sorted_next,
> +	.stop = s_stop,
> +	.show = sorted_show
> +};
> +
> +static int kallsyms_list_cmp(void *priv, struct list_head *a,
> +			     struct list_head *b)
> +{
> +	struct kallsyms_iter_list *iter_a, *iter_b;
> +
> +	iter_a = list_entry(a, struct kallsyms_iter_list, next);
> +	iter_b = list_entry(b, struct kallsyms_iter_list, next);
> +
> +	return strcmp(iter_a->iter.name, iter_b->iter.name);
> +}
> +
> +int get_all_symbol_name(void *data, const char *name, struct module *mod,
> +			unsigned long addr)

This can be static too.

Otherwise, looks good!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
