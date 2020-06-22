Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFBCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56CED206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XG1VeH52"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731346AbgFVXHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 19:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgFVXHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 19:07:13 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E37C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 16:07:13 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ga6so594453pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 16:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z20zxmu7BXaJTc0tzUXoDHwEuwGLB9cwURxhD+oh4+g=;
        b=XG1VeH52GZUyvhcE9tbM4IoixaqvBmVHBTbaAPa1sHlwz6UTK5qC09lefX0IGKu1sw
         vcczs5K9f5eGPiFG77ESmvfY4NW193Q4M2tAwPqTwmKe/Aw8vn4j561cnqYHf7qIoFQz
         RUWRINhgB754vJIqeOOwfgYGnA7h4+Ot4qxfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z20zxmu7BXaJTc0tzUXoDHwEuwGLB9cwURxhD+oh4+g=;
        b=lrs6RXu6yz4hkC+LTRAt2h3/ryuwPepop/Rz87tHA9x0HU6w/QXvlhsCm+NRVFu9Ks
         F2ONv69zKha+D/WAqGxdxGFGimNZS//2uiEYAr25Tpj+9o+k9VegZh80Z/G9Kzi6kXnP
         DykSuYVo+myb0z2WfMVhSVtNyEPNfq/vzOcFVk/wnGk8PQJT/UTNCi0xuJQ6gaU9Iuja
         t1I8j32CQFH5LOJQPW8osQ/Lqtkv3dAOTxAauNXWI8p4iZbtnAVDRFPYM3y64wiJl/AF
         tyEGsR1nY31CKHk03LN9mesSZFeVAFJ654mrOZyB6Z6g/CstqN/ON0kDUvCE/vsy+Y41
         TUJQ==
X-Gm-Message-State: AOAM532ioSYQOdcjNYxaBoezeJayCdIrHd45S0MvgnDQyzfBmkPeAE5e
        FacG4B1NLrrsnsO56HtVI6pn9Q==
X-Google-Smtp-Source: ABdhPJx/PfvGuvPHST8NkvXqx8YdMlxhEJDw3qi2G3DLjazOqp+Vo/e1zvIb/b99UCM7dwt0/xj29g==
X-Received: by 2002:a17:902:7611:: with SMTP id k17mr21505128pll.255.1592867232960;
        Mon, 22 Jun 2020 16:07:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k126sm15106305pfd.129.2020.06.22.16.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 16:07:12 -0700 (PDT)
Date:   Mon, 22 Jun 2020 16:07:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
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
Message-ID: <202006221604.871B13DE3@keescook>
References: <20200622193146.2985288-1-keescook@chromium.org>
 <20200622193146.2985288-4-keescook@chromium.org>
 <20200622225615.GA3511702@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622225615.GA3511702@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 06:56:15PM -0400, Arvind Sankar wrote:
> On Mon, Jun 22, 2020 at 12:31:44PM -0700, Kees Cook wrote:
> > +
> > +#define add_random_kstack_offset() do {					\
> > +	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,	\
> > +				&randomize_kstack_offset)) {		\
> > +		u32 offset = this_cpu_read(kstack_offset);		\
> > +		u8 *ptr = __builtin_alloca(offset & 0x3FF);		\
> > +		asm volatile("" : "=m"(*ptr));				\
> > +	}								\
> > +} while (0)
> 
> This feels a little fragile. ptr doesn't escape the block, so the
> compiler is free to restore the stack immediately after this block. In
> fact, given that all you've said is that the asm modifies *ptr, but
> nothing uses that output, the compiler could eliminate the whole thing,
> no?
> 
> https://godbolt.org/z/HT43F5
> 
> gcc restores the stack immediately, if no function calls come after it.
> 
> clang completely eliminates the code if no function calls come after.

nothing uses the stack in your example. And adding a barrier (which is
what the "=m" is, doesn't change it.

> I'm not sure why function calls should affect it, though, given that
> those functions can't possibly access ptr or the memory it points to.

It seems to work correctly:
https://godbolt.org/z/c3W5BW

-- 
Kees Cook
