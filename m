Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDFCC433E8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 23:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36FF3206E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 23:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595460333;
	bh=hYqsyhLKTw7SYDQuBg9iw65OEkIN6QuUV9+qjRkDs2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sV0SxFudKyF1nQguxGsHPI/7m8B74S3oUSmxD6yaEGvZ6+Irv5QAmmCosuIOeQ6Rm
	 ronhu5fjUkJrmDSkvIVfiTcGJ6qXpvgdYQtEKFlUe2azN3EFJsq4exoNXWyQ44o9Gl
	 X8e64pv7k/Rf+qeZWpF8guvBLh00wP/35idz5n+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733117AbgGVXZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 19:25:32 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:41801 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgGVXZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 19:25:31 -0400
Received: by mail-ua1-f65.google.com with SMTP id u6so1213802uau.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 16:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u16+n9WUBgulDsvWWrvJlcH01cdO9g6pus/V2E/LhAg=;
        b=fq6lOH97yCzuzTsaYXarxZcnj5SElSaF1BkOcjcMbU24dYM5fSrEdHhIKagBOMjn/u
         G/VYGn4tG5nW9Bfsd0+0Hh1julm1ZtKwd4Zqtvl66JJXNyZBm1j4J/KVLJFAlr6u7AzZ
         5nd+zvfjps5/VlLHTuN0jmHTT3zSnDRguXMfqR1jCf25SSwAfXuQ+nf7ooEgtItSDjn1
         g4M10hmYlMLyJQ62FVs2j4/Ev2CLvR3kEnSnQ7gz2v0rKE2/yMnI3M4IZPIxK8Ix2l36
         ziUfQlFNaMgtDYlJ4i5Nsx91qXOwYCZ9HSHLm7XdMv6Xufbd+lGXVPCtPFLzaTEhVqqq
         78+g==
X-Gm-Message-State: AOAM53056FiWb1ur8mY4gZmVGUX1/HCQUMZ+wTJPq1SkVqOx0j6uC800
        kSldDdZOmnB0WXxH9AMpPNg=
X-Google-Smtp-Source: ABdhPJx3mn6PghznvnUicOsiOgC9gFhfrzrSafwZ5co810gAMiLWKEnqgtngZefxJUyHNt9CpQqGuA==
X-Received: by 2002:ab0:7551:: with SMTP id k17mr2018238uaq.102.1595460330003;
        Wed, 22 Jul 2020 16:25:30 -0700 (PDT)
Received: from google.com (239.145.196.35.bc.googleusercontent.com. [35.196.145.239])
        by smtp.gmail.com with ESMTPSA id n2sm164181vsa.11.2020.07.22.16.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 16:25:28 -0700 (PDT)
Date:   Wed, 22 Jul 2020 23:25:27 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dennis Zhou <dennis@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH v3 00/11] i386 Clang support
Message-ID: <20200722232527.GA1156429@google.com>
References: <20200720204925.3654302-1-ndesaulniers@google.com>
 <20200721222754.GA820494@google.com>
 <87blk7ywp1.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blk7ywp1.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 01:08:42AM +0200, Thomas Gleixner wrote:
> Dennis Zhou <dennis@kernel.org> writes:
> > On Mon, Jul 20, 2020 at 01:49:14PM -0700, Nick Desaulniers wrote:
> >> Resend of Brian's v2 with Acks from Peter and Linus collected, as well
> >> as the final patch (mine) added. The commit of the final patch discusses
> >> some of the architectural differences between GCC and Clang, and the
> >> kernels tickling of this difference for i386, which necessitated these
> >> patches.
> >> 
> >> Brian Gerst (10):
> >>   x86/percpu: Introduce size abstraction macros
> >>   x86/percpu: Clean up percpu_to_op()
> >>   x86/percpu: Clean up percpu_from_op()
> >>   x86/percpu: Clean up percpu_add_op()
> >>   x86/percpu: Remove "e" constraint from XADD
> >>   x86/percpu: Clean up percpu_add_return_op()
> >>   x86/percpu: Clean up percpu_xchg_op()
> >>   x86/percpu: Clean up percpu_cmpxchg_op()
> >>   x86/percpu: Clean up percpu_stable_op()
> >>   x86/percpu: Remove unused PER_CPU() macro
> >> 
> >> Nick Desaulniers (1):
> >>   x86: support i386 with Clang
> >> 
> >>  arch/x86/include/asm/percpu.h  | 510 +++++++++++----------------------
> >>  arch/x86/include/asm/uaccess.h |   4 +-
> >>  2 files changed, 175 insertions(+), 339 deletions(-)
> >> 
> >> -- 
> >> 2.28.0.rc0.105.gf9edc3c819-goog
> >> 
> >
> > This looks great to me! I applied it to for-5.9.
> 
> You applied it? I'm not aware that you're maintaining x86 nowadays.
> 
> Thanks,
> 
>         tglx

I'm sorry I overstepped. I've dropped them. Please take them with my
ack.

Thanks,
Dennis
