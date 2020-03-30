Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EB0C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 667AE207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X+fgDi3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbgCaOPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 10:15:24 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55074 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730466AbgCaOPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 10:15:23 -0400
Received: by mail-pj1-f66.google.com with SMTP id np9so1124692pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 07:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zTyZUZyP+zXDM17uOl5EO7jnuzHUmLuralf0hD1C7uQ=;
        b=X+fgDi3MlKSPCh2sgIYL+gkLlsZfyMGWwuidp67Y/1xJSJpN6GiCrcKj4vscCntt5X
         AsoSD/y4zBkHXejpqSRnno4P4EIdp8HhS1WuvfQUKvsUfsyvyJIqVP5BNhp1WI9YXqSe
         Z6QL0bcqJwst77oznDjNOVFNBeNpNp6rUlFeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zTyZUZyP+zXDM17uOl5EO7jnuzHUmLuralf0hD1C7uQ=;
        b=YvBjd9LKmw8vy4V3i2GhoVm3R3ZQ7NwM0slfJ4Yr2/QU80g60CBH52lhKaeoxq818O
         Zg+ptt7gcfFBnjCUfxkYkX//AjmVYcBV5BVQtORcr6p2MT6Y3RzpvRG7jieEOfZWbaUH
         HyeCF3mH+otb2MKvJ+EaXhS5hoAVyvg+inn35j7lnrf2vBXN0RaEyvDeNNyl6wuXtTcc
         g28dYaBPH5j1FXtEW7/AqkPjGX5LgxGoi6CMSDDQQZYOkRq5yuh2d01b/dUAhVRHUp2q
         q2ZYUm/JsyK/gJU4u0hatUrfX7cKlEPrS2TOJ0HPa/j+m8NLIHRVqVCa84Fd4+MeAxEW
         TvSw==
X-Gm-Message-State: AGi0Pub3z0MZtxLpXRs05zSXzW+foHPF7l1yoPcBOL2LeBSQ+mCAt2Fl
        zuBOiLr9sxbniS3KsrGv9eKzfw==
X-Google-Smtp-Source: APiQypIT3n7KLf8ko7LebvhJ17T7gGW5sDePBsyltHCF4aEdKZNxQ/m3qhCvFd7PBcLmqZTusgipUw==
X-Received: by 2002:a17:90a:202f:: with SMTP id n44mr4330392pjc.150.1585664122467;
        Tue, 31 Mar 2020 07:15:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c10sm5076661pgh.48.2020.03.31.07.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 07:15:21 -0700 (PDT)
Date:   Mon, 30 Mar 2020 11:18:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] stack: Optionally randomize kernel stack offset
 each syscall
Message-ID: <202003301116.081DB02@keescook>
References: <20200324203231.64324-1-keescook@chromium.org>
 <20200324203231.64324-4-keescook@chromium.org>
 <20200330112536.GD1309@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330112536.GD1309@C02TD0UTHF1T.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 12:25:36PM +0100, Mark Rutland wrote:
> On Tue, Mar 24, 2020 at 01:32:29PM -0700, Kees Cook wrote:
> > +/*
> > + * Do not use this anywhere else in the kernel. This is used here because
> > + * it provides an arch-agnostic way to grow the stack with correct
> > + * alignment. Also, since this use is being explicitly masked to a max of
> > + * 10 bits, stack-clash style attacks are unlikely. For more details see
> > + * "VLAs" in Documentation/process/deprecated.rst
> > + */
> > +void *__builtin_alloca(size_t size);
> > +
> > +#define add_random_kstack_offset() do {					\
> > +	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,	\
> > +				&randomize_kstack_offset)) {		\
> > +		u32 offset = this_cpu_read(kstack_offset);		\
> > +		char *ptr = __builtin_alloca(offset & 0x3FF);		\
> > +		asm volatile("" : "=m"(*ptr));				\
> 
> Is this asm() a homebrew OPTIMIZER_HIDE_VAR(*ptr)? If the asm
> constraints generate metter code, could we add those as alternative
> constraints in OPTIMIZER_HIDE_VAR() ?

Hah, yes, it is. And this produces identical asm, so I've replaced it
with OPTIMIZER_HIDE_VAR() now. Now if I could figure out how to hide it
from stack protector. :(

-- 
Kees Cook
