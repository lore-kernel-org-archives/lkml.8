Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0D6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 22:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 755F520709
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 22:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595370479;
	bh=8XYnaCQEOFl0NQ5fHpYLBPbPYdR2ckzyWqk+qUj4s0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V39oV4+i6evVYzu3tqrjxFWqI06DVfFuH3KQt7iba/KFHeNBKbcnVsAMIolI0oRQ6
	 Xd0/vlg1/hCz0UeUC8OUu5CEgqCtI0RvlKzHlDlsgibFcIKZav2xNJ4EERGqXU/j5P
	 tj1jxYeHbX/pQSXDRJgE98mHN/RQDSeDq5Usds7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgGUW16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 18:27:58 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34204 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgGUW15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 18:27:57 -0400
Received: by mail-vs1-f66.google.com with SMTP id d198so126283vsc.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 15:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fwAi8CKhNi9kUtBAHHmNZzLLaAUQLEIM0QwmpiKPOJ0=;
        b=T6kKJ/zSnD2xOohrgrpmM22op5Z1L3EVg+o1j8M/KkCJDC7pI040R+l4n16uhqxcQe
         EqX0fxOoeAfIRAazMrKrfFcCWGVIGtU2z1ekLBAlCdYcwPF4GCfuTm2DYHD2sdez/Nvp
         VTHSj2G+gthiQdTCN+2y6SHmGmQfzW7RjejQC+lS6qaYHz0JLMzK37VwlPfzo3fIuNRj
         wtnmySkvLWpO2mghT1bwXC0i2fwoZe15S20dtPSF04QeG4mVuZdNRYKEtjS2BElhVJEC
         UUdnR/ENtj1JIOc9b+UAz+4crONw1fLAxqlMj/ez0+0bhl4t26aVnMBeDdagjJr056Jy
         bn2w==
X-Gm-Message-State: AOAM531lQmjFewzfYYv03Puk1+mltybseZnK4aUeMO1XkgB5cG98MbAF
        2vfakixvytcGCsLmsm+dGIk=
X-Google-Smtp-Source: ABdhPJwkiVHHEkhsbBt7+Xu2mtpyqUq4XHNR3iqOyrapQT0eUxvLKas09r18YYnPrL5vlHNGA67x5Q==
X-Received: by 2002:a67:e046:: with SMTP id n6mr22949972vsl.6.1595370476473;
        Tue, 21 Jul 2020 15:27:56 -0700 (PDT)
Received: from google.com (239.145.196.35.bc.googleusercontent.com. [35.196.145.239])
        by smtp.gmail.com with ESMTPSA id v63sm3603321vkf.45.2020.07.21.15.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 15:27:55 -0700 (PDT)
Date:   Tue, 21 Jul 2020 22:27:54 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH v3 00/11] i386 Clang support
Message-ID: <20200721222754.GA820494@google.com>
References: <20200720204925.3654302-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720204925.3654302-1-ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 01:49:14PM -0700, Nick Desaulniers wrote:
> Resend of Brian's v2 with Acks from Peter and Linus collected, as well
> as the final patch (mine) added. The commit of the final patch discusses
> some of the architectural differences between GCC and Clang, and the
> kernels tickling of this difference for i386, which necessitated these
> patches.
> 
> Brian Gerst (10):
>   x86/percpu: Introduce size abstraction macros
>   x86/percpu: Clean up percpu_to_op()
>   x86/percpu: Clean up percpu_from_op()
>   x86/percpu: Clean up percpu_add_op()
>   x86/percpu: Remove "e" constraint from XADD
>   x86/percpu: Clean up percpu_add_return_op()
>   x86/percpu: Clean up percpu_xchg_op()
>   x86/percpu: Clean up percpu_cmpxchg_op()
>   x86/percpu: Clean up percpu_stable_op()
>   x86/percpu: Remove unused PER_CPU() macro
> 
> Nick Desaulniers (1):
>   x86: support i386 with Clang
> 
>  arch/x86/include/asm/percpu.h  | 510 +++++++++++----------------------
>  arch/x86/include/asm/uaccess.h |   4 +-
>  2 files changed, 175 insertions(+), 339 deletions(-)
> 
> -- 
> 2.28.0.rc0.105.gf9edc3c819-goog
> 

This looks great to me! I applied it to for-5.9.

Thanks,
Dennis
