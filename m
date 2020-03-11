Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F445C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2EAE2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="M5XMYAyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgCKIQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 04:16:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43870 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbgCKIQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 04:16:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id r7so1237973ljp.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 01:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MVBDlNhw2NYKxoZpQeQrialLnIij6F1TEtrFXBbpHU0=;
        b=M5XMYAyAY0cEwOy2MUq6YnSIgX1ogiSDgW0PkSLbaPmNwnY9BfZVhWYPkjHJJnJqze
         zhTu3jBozHSoYyjAXN1NS6H/Y6y9tAXfRb1EUqWD0OAx+R8MAULIbZqNn7D8vTavjCyd
         zNHJFYuQK5ZNqhFhOCx7jYFJBNhg/FzfbBjWY1O5LY9UN/Lpa9A8MvTMxrxpzskSOju6
         w5WP0rq5zVv4L8gtt5pG5AMoT8fEfqeJ82IFS/P5TrMgYmVeCoRGZdghEFLHLwvlMkVi
         Qy4tm+sq7PW17hZ3ltSz9C+5KF/j8eeG2HKR4ECA9h6d2kEPc/0YvLyMHduMfZZuDzrB
         +g/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MVBDlNhw2NYKxoZpQeQrialLnIij6F1TEtrFXBbpHU0=;
        b=GKIx4UwgSdX6HaC0iLymKUd47VMxm4cngvTvzJd4BshcvOygg89PLw8WXFenRuxLaD
         tXr5jvSdgcihb2FcvCQIfwAQ8HGUw8txbdRgE5Q6Ygdmbp6KeTN+HI+vBAiSZk8JGYxI
         QAy7qDytatGk+30kmHfjSe3w2SFN9rH5rBS6SWjBPvLxYLnWhcPnBHJUi+/RhuNvgA/f
         gthqEvdkN7aqSD57BhuoJBqkZBKU7hTf4rwtTSELwe8uAFytKfemTOtFWY2NoAf0YY2+
         DpiTNn7cLG3L4SMMbZ0zRIVWDOgfopkIzGdi6gtVAqr90ICND0Xh1Qg/FRZVLncSsWsi
         RrVA==
X-Gm-Message-State: ANhLgQ0i/2xOOJDa+ZizMksVa1x5gi5NDKTQzLGvGRAEJOSwQ+up3pFr
        lZ9AQ2HoP0yK0QkTXFIKpJRiwQ==
X-Google-Smtp-Source: ADFU+vvr/CgCEv+uGOL6zeUqw9uqOFgyGugiloRUjU23ZdS3BB0BsivJ0kYOrjylvVTrSms6wroA/Q==
X-Received: by 2002:a05:651c:30d:: with SMTP id a13mr1420115ljp.272.1583914567351;
        Wed, 11 Mar 2020 01:16:07 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id u9sm16456303ljo.106.2020.03.11.01.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 01:16:06 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 723E0100F99; Wed, 11 Mar 2020 11:16:07 +0300 (+03)
Date:   Wed, 11 Mar 2020 11:16:07 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Cannon Matthews <cannonmatthews@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Salman Qazi <sqazi@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] mm: clear 1G pages with streaming stores on x86
Message-ID: <20200311081607.3ahlk4msosj4qjsj@box>
References: <20200307010353.172991-1-cannonmatthews@google.com>
 <20200309000820.f37opzmppm67g6et@box>
 <20200309090630.GC8447@dhcp22.suse.cz>
 <20200309153831.GK1454533@tassilo.jf.intel.com>
 <20200309183704.GA1573@bombadil.infradead.org>
 <CAJfu=UfPKZwqjGR5AdhFRo_je7X5q2=zpBSBQkrbh2KhYrOJiA@mail.gmail.com>
 <20200311005447.jkpsaghrpk3c4rwu@box>
 <20200311033552.GA3657254@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311033552.GA3657254@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 11:35:54PM -0400, Arvind Sankar wrote:
> On Wed, Mar 11, 2020 at 03:54:47AM +0300, Kirill A. Shutemov wrote:
> > On Tue, Mar 10, 2020 at 05:21:30PM -0700, Cannon Matthews wrote:
> > > On Mon, Mar 9, 2020 at 11:37 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Mon, Mar 09, 2020 at 08:38:31AM -0700, Andi Kleen wrote:
> > > > > > Gigantic huge pages are a bit different. They are much less dynamic from
> > > > > > the usage POV in my experience. Micro-optimizations for the first access
> > > > > > tends to not matter at all as it is usually pre-allocation scenario. On
> > > > > > the other hand, speeding up the initialization sounds like a good thing
> > > > > > in general. It will be a single time benefit but if the additional code
> > > > > > is not hard to maintain then I would be inclined to take it even with
> > > > > > "artificial" numbers state above. There really shouldn't be other downsides
> > > > > > except for the code maintenance, right?
> > > > >
> > > > > There's a cautious tale of the old crappy RAID5 XOR assembler functions which
> > > > > were optimized a long time ago for the Pentium1, and stayed around,
> > > > > even though the compiler could actually do a better job.
> > > > >
> > > > > String instructions are constantly improving in performance (Broadwell is
> > > > > very old at this point) Most likely over time (and maybe even today
> > > > > on newer CPUs) you would need much more sophisticated unrolled MOVNTI variants
> > > > > (or maybe even AVX-*) to be competitive.
> > > >
> > > > Presumably you have access to current and maybe even some unreleased
> > > > CPUs ... I mean, he's posted the patches, so you can test this hypothesis.
> > > 
> > > I don't have the data at hand, but could reproduce it if strongly
> > > desired, but I've also tested this on skylake and  cascade lake, and
> > > we've had success running with this for a while now.
> > > 
> > > When developing this originally, I tested all of this compared with
> > > AVX-* instructions as well as the string ops, they all seemed to be
> > > functionally equivalent, and all were beat out by this MOVNTI thing for
> > > large regions of 1G pages.
> > > 
> > > There is probably room to further optimize the MOVNTI stuff with better
> > > loop unrolling or optimizations, if anyone has specific suggestions I'm
> > > happy to try to incorporate them, but this has shown to be effective as
> > > written so far, and I think I lack that assembly expertise to micro
> > > optimize further on my own.
> > 
> > Andi's point is that string instructions might be a better bet in a long
> > run. You may win something with MOVNTI on current CPUs, but it may become
> > a burden on newer microarchitectures when string instructions improves.
> > Nobody realistically would re-validate if MOVNTI microoptimazation still
> > make sense for every new microarchitecture.
> >
> 
> The rationale for MOVNTI instruction is supposed to be that it avoids
> cache pollution. Aside from the bench that shows MOVNTI to be faster for
> the move itself, shouldn't it have an additional benefit in not trashing
> the CPU caches?
> 
> As string instructions improve, why wouldn't the same improvements be
> applied to MOVNTI?

String instructions inherently more flexible. Implementation can choose
caching strategy depending on the operation size (cx) and other factors.
Like if operation is large enough and cache is full of dirty cache lines
that expensive to free up, it can choose to bypass cache. MOVNTI is more
strict on semantics and more opaque to CPU.

And more importantly string instructions, unlike MOVNTI, is something that
generated often by compiler and used in standard libraries a lot. It is
and will be focus of optimization of CPU architects.

-- 
 Kirill A. Shutemov
