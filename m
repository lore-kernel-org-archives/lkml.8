Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA908C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4AB0204FD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIC8z7I2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgHOVyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729114AbgHOVwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:36 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174EAC0612F4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 20:52:32 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id c6so5295502pje.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 20:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x70ZbpZnKBRKGaABGtYI7hkwARLwGl0g0AbXbJj38qo=;
        b=QIC8z7I2pOk9WGL3pODELePJrQrCwG3qkPanGNpky5u87PHfgSdCI0pBF+QnxTTf0g
         iOUY7R5ymcJl5OLjfj7WpcEAAqIPJHY2WCZ08wgZ3qRPU8St2EscMsg2kiknXoUTwVlD
         GG/Zz+L1S6z1HOXnNrFfACU+mNZ7DElHl3hLCWh2iANHKjR1jJd7QK6ga0SO0qNOKX+8
         6+SSRO5ctwA1BUZMi0kVtarKHaLq0dRz4l8fc6hwoU6cF/R31/LaRtHi6lLuC3Fat3KW
         4yHoaUcZOsvyT9aUiIKMbx7Xe8n9Lq65w8qaE7Pd6mOo5Id4VorhCFeDenmg1DEg2b3D
         BdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x70ZbpZnKBRKGaABGtYI7hkwARLwGl0g0AbXbJj38qo=;
        b=HLgrKtG8aPwKfE5525ItGELbQ9C3oTNuLUjH4PLI4m0pKgC4/SVwI9NPSSh1aaYCBb
         FgymRidNkBHji0dlYS6JjeXbI/1EAyZjQPtFCLVAp2GCkqS72P4tzgjn9WeY3pBo6anN
         3hTUtgsql08loRu/VM9nzVyd7o90+JhyEl+J9o9XpjDBcd1ILEPAotazBcHld5XJk7Re
         jZZvVZQ5gF7Gx5kK4syDw63CKkKZREhDhPvXp/gQRiEFJqdCD3EBxpNAXXEoA7ooLJzu
         Ue6lmLL+ujd+ym72aHwiYGxhatEYjKSwWwgHQTDTDIC3+n+7+o4Pg4dWAE5W2jDUgLUp
         k4ZQ==
X-Gm-Message-State: AOAM533AEDwwgtBFlvtNSjTThrZ4yec27urbDbu+HTnEeqUOv+6UH5AC
        m4OGSS8Tj6l2jh5QR6EjV6Y=
X-Google-Smtp-Source: ABdhPJxzUv6FF/UEFlE3TNcT9qDpThU/RB7nLUhSbAswGmLPQGWY0y2IzHxVanJ7hBBeYruA/GUFdw==
X-Received: by 2002:a17:90a:c58b:: with SMTP id l11mr4618708pjt.195.1597463551500;
        Fri, 14 Aug 2020 20:52:31 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id x23sm10570909pfi.60.2020.08.14.20.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 20:52:30 -0700 (PDT)
Date:   Sat, 15 Aug 2020 12:52:28 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [RFC PATCH] vsprintf: Add %pv extension replacement for
 print_vma_addr
Message-ID: <20200815035228.GC582@jagdpanzerIV.localdomain>
References: <09f11651f0e913e159b955ac447cd8cadf36cb0d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09f11651f0e913e159b955ac447cd8cadf36cb0d.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc-ing John

On (20/08/14 10:53), Joe Perches wrote:
[..]

In general, the idea looks nice.

> +static noinline_for_stack
> +char *vma_addr(char *buf, char *end, void *ip,
> +	       struct printf_spec spec, const char *fmt)
> +{
> +#ifdef CONFIG_MMU
> +	struct mm_struct *mm = current->mm;
> +	struct vm_area_struct *vma;
> +
> +	/*
> +	 * we might be running from an atomic context so we cannot sleep
> +	 */
> +	if (!mmap_read_trylock(mm))
> +		return buf;
> +
> +	vma = find_vma(mm, (unsigned long)ip);
> +	if (vma && vma->vm_file) {
> +		char *p;
> +		struct file *f = vma->vm_file;
> +		char *page = (char *)__get_free_page(GFP_NOWAIT);

Hmm, this is huge. For the time being this is going to introduce lock
inversion chains:

	PRINTK -> printk_locks -> MM -> mm_locks

vs
	MM -> mm_locks -> PRINTK -> printk_locks

Another thing to mention is

	PRINTK -> printk_locks -> MM (WANR_ON/etc) -> PRINTK

we are in printk_safe, currently, but that's going to change.

We might not be ready to take this as of now, but things can change
once we drop printk_locks.

> +		if (page) {
> +			p = file_path(f, page, PAGE_SIZE);
> +			if (IS_ERR(p))
> +				p = "?";
> +			buf = string(buf, end, kbasename(p), default_str_spec);
> +			buf = string_nocheck(buf, end, "[", default_str_spec);
> +			buf = pointer_string(buf, end,
> +					     (void *)vma->vm_start,
> +					     default_hex_spec);
> +			buf = string_nocheck(buf, end, "+", default_str_spec);
> +			buf = pointer_string(buf, end,
> +					     (void *)(vma->vm_end - vma->vm_start),
> +					     default_hex_spec);
> +			buf = string_nocheck(buf, end, "]", default_str_spec);
> +			free_page((unsigned long)page);
> +		}
> +	}
> +	mmap_read_unlock(mm);
> +#else
> +	buf = string_nocheck(buf, end, "CONFIG_MMU=n", default_str_spec);

Hmm, we don't usually do that CONFIG_FOO=n thing, I think we just need
to skip %pv and print nothing. Otherwise on !CONFIG_MMU systems the logbuf
may contain a number of CONFIG_MMU=n messages, which are hardly useful.

> +#endif
> +	return buf;
> +}
> +
>  /*
>   * Show a '%p' thing.  A kernel extension is that the '%p' is followed
>   * by an extra set of alphanumeric characters that are extended format
> @@ -2254,6 +2304,8 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
>  		return uuid_string(buf, end, ptr, spec, fmt);
>  	case 'V':
>  		return va_format(buf, end, ptr, spec, fmt);

+ #ifdef CONFIG_MMU
> +	case 'v':
> +		return vma_addr(buf, end, ptr, spec, fmt);
+ #endif

>  	case 'K':
>  		return restricted_pointer(buf, end, ptr, spec);
>  	case 'N':

	-ss
