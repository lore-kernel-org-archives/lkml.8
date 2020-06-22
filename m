Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68F9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B946B207BC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlW8G6Xn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731281AbgFVW4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730785AbgFVW4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:56:19 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C112EC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:56:18 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id x62so10668584qtd.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J4t/1UJvzfHD1sfeMp1vjjaj+f6i6rz7qh/A+MZJ/fk=;
        b=TlW8G6XnBweeMXO77mxR2aTGOdh/2ICx7gObCjvLq2UNfL3/HDbW+smIfJOMVG2gcL
         lsY37DUopQMvf8Aca+IyTniz/bSKymGHBgUBT8nPFFE5LfOKsAb6xRKdQ7saIovM7jrz
         Gcc7IZlLGgRdweoPdYugiSt13kCP7q8v92Q1ZSA7kXWZCK09UI3aXlgORpVu1BOgkZDq
         KDwTv2gMH5q3ZqUHxF0USrzHhMhxWfDoPXI6D1xlqh2UyyT5+bslyfezaLU9LBmlRGsx
         GS3T0H++0asrVBHeSwjH4ZsuIs3LUcr8V5bHV9uV19oqodtzFYLrhzNFidLkn9FNGOCd
         RV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=J4t/1UJvzfHD1sfeMp1vjjaj+f6i6rz7qh/A+MZJ/fk=;
        b=XKmrERd8fBxA9Tl0g8D9d+MdlHviwu+l+0wc9ZXqCwJHnjfAVdA008ReHYLJxumcYv
         nEaqVgL5104cRHprj7zcaHzCMnHyM5a8PeFzlRlquqo/dR1TdxHtbwOqK8F+UrVSsewe
         nBUmoq3m/LPxb4vOw5UHv/i0p7LzxodZHhUmzKf8e2V3jffx6+o/mKc59ti0x++y4o15
         lzoXPmKhXklD0MLdgt8cTVYqCyZOU0J04Sv4pp3u5ocbKC3qOGJf9uSKoliXY70erV8C
         JkJh6D0QIoOSVm/D4twPF3YMPf0yyv0NWyOz0fcZ/8yafC4jAyRFDciYvYCX3rEWdxK1
         /ZUQ==
X-Gm-Message-State: AOAM533PmA5Jarx6ger5Lfd+gFGXgkGAmpPP8uQhnHQJuPle3E+dVIY3
        BG572UuyPG/cwr+k4zLsIbU=
X-Google-Smtp-Source: ABdhPJx6ViX3VUi9U5rO1UC8eBAxyutLutchUmhepd+t1xhXYQPr9V9FJEHmR0NJcQTmGq+2dhFMVQ==
X-Received: by 2002:ac8:72d2:: with SMTP id o18mr6306890qtp.208.1592866577875;
        Mon, 22 Jun 2020 15:56:17 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o8sm3348262qkh.100.2020.06.22.15.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 15:56:17 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 22 Jun 2020 18:56:15 -0400
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] stack: Optionally randomize kernel stack offset
 each syscall
Message-ID: <20200622225615.GA3511702@rani.riverdale.lan>
References: <20200622193146.2985288-1-keescook@chromium.org>
 <20200622193146.2985288-4-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200622193146.2985288-4-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 12:31:44PM -0700, Kees Cook wrote:
> +
> +#define add_random_kstack_offset() do {					\
> +	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,	\
> +				&randomize_kstack_offset)) {		\
> +		u32 offset = this_cpu_read(kstack_offset);		\
> +		u8 *ptr = __builtin_alloca(offset & 0x3FF);		\
> +		asm volatile("" : "=m"(*ptr));				\
> +	}								\
> +} while (0)

This feels a little fragile. ptr doesn't escape the block, so the
compiler is free to restore the stack immediately after this block. In
fact, given that all you've said is that the asm modifies *ptr, but
nothing uses that output, the compiler could eliminate the whole thing,
no?

https://godbolt.org/z/HT43F5

gcc restores the stack immediately, if no function calls come after it.

clang completely eliminates the code if no function calls come after.

I'm not sure why function calls should affect it, though, given that
those functions can't possibly access ptr or the memory it points to.

A full memory barrier (like barrier_data) should be better -- it gives
the compiler a reason to believe that ptr might escape and be accessed
by any code following the block?
