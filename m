Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92828C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 20:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B4D52074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 20:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oFcZE28a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgFAUJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 16:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgFAUI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 16:08:57 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB4DC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 13:08:57 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 64so3958210pfg.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 13:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F+/+2neDGL2cmCsPYCmTZ0xH01UfLhvyIOnhwmkXook=;
        b=oFcZE28aSVeWJm8YRaZ9q024/uVZkhNfOgmkducQGtYNXMy2t618CIyQiWea9M6nWN
         lr101AC4MjOWfQxsYp/ixWH5Dg5YNd5Jg4ZeGKi8+tzKNs8uvHwCHC9OfB6R1KsOw/9z
         9nq7pXknIAJtHYlhR1NJ2y5i6Jnf1LOKvGNwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F+/+2neDGL2cmCsPYCmTZ0xH01UfLhvyIOnhwmkXook=;
        b=iandkQwKcRariw6/wIHjEX3VzMTzJGxxJf8RSrMFdlqM+B6Un0TNGm/grhHphczpZB
         YqWNRk3jd/24khEgjeAh5evo+Wh+1wfhntrxkhHjQB8qgAZ+B6UNg/c1Na0/+INXQMjh
         44oRAecq6V9ALa1nIPCl/K+MkYMtU8uEKD41GfByKcHdEzTyqs9IE5y2cjnqaLlDmLQV
         394XLskL6B+fELpbNoWAK2tOW/N1S5IWsO6mh908AM3C8GYQJ55FyDWgxdCU53LLiGsx
         WuIjaPCv83uOT+mG6EvuW+n1pHnnwl1T4B9uQiKcjV3wkgrz/3GEXqO7qNLG2Pzua7Jr
         iPZw==
X-Gm-Message-State: AOAM531sj2pbZvYT1KMt3z/GOc6142adzQriF4ien+GLIQsP6XYSePSi
        YK3fLA+i4kJz5QCWbhzvRAGrQw==
X-Google-Smtp-Source: ABdhPJxPQbwHJUOo7/3Umh6kkW47GconO6IP422nJGIHyPNlnaJJrQ7lOQMrX/HpEGHocNVX7hBw6w==
X-Received: by 2002:a62:1d4c:: with SMTP id d73mr21302296pfd.226.1591042136517;
        Mon, 01 Jun 2020 13:08:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b1sm270733pjc.33.2020.06.01.13.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 13:08:55 -0700 (PDT)
Date:   Mon, 1 Jun 2020 13:08:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Paul Gofman <gofmanp@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Drewry <wad@chromium.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Zebediah Figura <zfigura@codeweavers.com>
Subject: Re: [PATCH RFC] seccomp: Implement syscall isolation based on memory
 areas
Message-ID: <202006011306.2E31FDED@keescook>
References: <85367hkl06.fsf@collabora.com>
 <079539BF-F301-47BA-AEAD-AED23275FEA1@amacapital.net>
 <50a9e680-6be1-ff50-5c82-1bf54c7484a9@gmail.com>
 <CALCETrX+CEN7Sq=ROP33MAGn2dTX=w0JHWb6f4KAr-E9FE4YPQ@mail.gmail.com>
 <a14be8b0-a9a2-cf96-939e-cedf7e0e669a@gmail.com>
 <CALCETrV+rYnUnve09=n+Zb8BR8mDBq6txX9LmEw7r8tAA7d+2Q@mail.gmail.com>
 <CALCETrWr_B-quNckFksTP1W-Ww71uQgCrR-o9QWdQ-Gi8p1r9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWr_B-quNckFksTP1W-Ww71uQgCrR-o9QWdQ-Gi8p1r9A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 31, 2020 at 02:03:48PM -0700, Andy Lutomirski wrote:
> On Sun, May 31, 2020 at 11:57 AM Andy Lutomirski <luto@kernel.org> wrote:
> >
> >
> > What if there was a special filter type that ran a BPF program on each
> > syscall, and the program was allowed to access user memory to make its
> > decisions, e.g. to look at some list of memory addresses.  But this
> > would explicitly *not* be a security feature -- execve() would remove
> > the filter, and the filter's outcome would be one of redirecting
> > execution or allowing the syscall.  If the "allow" outcome occurs,
> > then regular seccomp filters run.  Obviously the exact semantics here
> > would need some care.
> 
> Let me try to flesh this out a little.
> 
> A task could install a syscall emulation filter (maybe using the
> seccomp() syscall, maybe using something else).  There would be at
> most one such filter per process.  Upon doing a syscall, the kernel
> will first do initial syscall fixups (e.g. SYSENTER/SYSCALL32 magic
> argument translation) and would then invoke the filter.  The filter is
> an eBPF program (sorry Kees) and, as input, it gets access to the

FWIW, I agree: something like this needs to use eBPF -- this isn't
being designed as a security boundary. It's more like eBPF ptrace.

> task's register state and to an indication of which type of syscall
> entry this was.  This will inherently be rather architecture specific
> -- x86 choices could be int80, int80(translated), and syscall64.  (We
> could expose SYSCALL32 separately, I suppose, but SYSENTER is such a
> mess that I'm not sure this would be productive.)  The program can
> access user memory, and it returns one of two results: allow the
> syscall or send SIGSYS.  If the program tries to access user memory
> and faults, the result is SIGSYS.
> 
> (I would love to do this with cBPF, but I'm not sure how to pull this
> off.  Accessing user memory is handy for making the lookup flexible
> enough to detect Windows vs Linux.  It would be *really* nice to
> finally settle the unprivileged eBPF subset discussion so that we can
> figure out how to make eBPF work here.)

And yes, this is the next road-block: finding a way to safely do
unprivileged eBPF.

-- 
Kees Cook
