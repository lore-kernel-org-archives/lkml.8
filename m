Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727D8C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 03:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434B620726
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 03:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QveIo4Xi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgCKDgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 23:36:00 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39806 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbgCKDf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 23:35:59 -0400
Received: by mail-qk1-f193.google.com with SMTP id e16so798309qkl.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 20:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wCWT2o5DFKKbBLuoSAVQOpMO8+LfC0dfYXlp5Cfyx5Q=;
        b=QveIo4XiPZyXhpsCHpYBHBIaDmxvs9lx/j4w1Zlq1KgieD+UXs0M8K332X10crh0WW
         rZDoxfAV8uOfh/CSthrLcWP82zySmkq0ZzljKC9hKbtF8SvLyhHda7MPLiYW3JAKRlPs
         Mxd3e/vj0/qGIXkJkZMgL5YxBl7oDPBBErf/Q8LoQshpbvUQdbwRlQYBt143XIsehgcx
         z0plpjm3N7wWr7yZLuelfn4chkqudfklm7C04wAbAahgxD4f+zkGUcvY++GpAMtGiSsk
         067xIhxvA6G1JuXsEPCRpkqOSUtRJgBxdjcBNRVpMxevwIN46g4vpLjJaXmL4gMeNOgd
         Ih4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wCWT2o5DFKKbBLuoSAVQOpMO8+LfC0dfYXlp5Cfyx5Q=;
        b=Qc9DZTj8YGztpXctaH0IOhADDttSr6HL1K75FeNoaagf4Is0Q3Y4I6KsqEohk2YCQE
         vldgn8ChOEHPmziZ2M+d9SvNjxhEK8a1l67XFP0MRpdBs7Zu89GY1jsqH1Ku3Aiv2enN
         1hj1lTd9dhTJ5jAZMwtTvqAmXryiu1MnraMVpLNaEvnS5PsLHoBkh/G2vS3jlgpqJUL9
         2YvmaArzvM7ou2hvlFKv9tJkMWysGMuVy+tpts2jRfOjUghmjAkdEEjeEWcfwS4fiMyj
         8AksaoXuU2z23WTDwUhL/I4B1yfQVDFxb0+KfzgWsZgE2TGBhQwW3BYCyZWRkuRP/TN0
         1hGA==
X-Gm-Message-State: ANhLgQ19MrqyE5ev1Jz8fh8uTxOfP9psfC8v2wCmRsUMh/NZ/9owkATG
        mgO3fQoyMBKRlKsYtJ60B54=
X-Google-Smtp-Source: ADFU+vsC+ly4UL0+Oz7izjR+zZLM45UVgl4Jty5phpX2+9h59lw4KRivmGBCNPmXKI0V/m50TadHqw==
X-Received: by 2002:a37:b041:: with SMTP id z62mr894840qke.487.1583897756906;
        Tue, 10 Mar 2020 20:35:56 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id w2sm25034621qto.73.2020.03.10.20.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 20:35:56 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 10 Mar 2020 23:35:54 -0400
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
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
Message-ID: <20200311033552.GA3657254@rani.riverdale.lan>
References: <20200307010353.172991-1-cannonmatthews@google.com>
 <20200309000820.f37opzmppm67g6et@box>
 <20200309090630.GC8447@dhcp22.suse.cz>
 <20200309153831.GK1454533@tassilo.jf.intel.com>
 <20200309183704.GA1573@bombadil.infradead.org>
 <CAJfu=UfPKZwqjGR5AdhFRo_je7X5q2=zpBSBQkrbh2KhYrOJiA@mail.gmail.com>
 <20200311005447.jkpsaghrpk3c4rwu@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200311005447.jkpsaghrpk3c4rwu@box>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 03:54:47AM +0300, Kirill A. Shutemov wrote:
> On Tue, Mar 10, 2020 at 05:21:30PM -0700, Cannon Matthews wrote:
> > On Mon, Mar 9, 2020 at 11:37 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Mon, Mar 09, 2020 at 08:38:31AM -0700, Andi Kleen wrote:
> > > > > Gigantic huge pages are a bit different. They are much less dynamic from
> > > > > the usage POV in my experience. Micro-optimizations for the first access
> > > > > tends to not matter at all as it is usually pre-allocation scenario. On
> > > > > the other hand, speeding up the initialization sounds like a good thing
> > > > > in general. It will be a single time benefit but if the additional code
> > > > > is not hard to maintain then I would be inclined to take it even with
> > > > > "artificial" numbers state above. There really shouldn't be other downsides
> > > > > except for the code maintenance, right?
> > > >
> > > > There's a cautious tale of the old crappy RAID5 XOR assembler functions which
> > > > were optimized a long time ago for the Pentium1, and stayed around,
> > > > even though the compiler could actually do a better job.
> > > >
> > > > String instructions are constantly improving in performance (Broadwell is
> > > > very old at this point) Most likely over time (and maybe even today
> > > > on newer CPUs) you would need much more sophisticated unrolled MOVNTI variants
> > > > (or maybe even AVX-*) to be competitive.
> > >
> > > Presumably you have access to current and maybe even some unreleased
> > > CPUs ... I mean, he's posted the patches, so you can test this hypothesis.
> > 
> > I don't have the data at hand, but could reproduce it if strongly
> > desired, but I've also tested this on skylake and  cascade lake, and
> > we've had success running with this for a while now.
> > 
> > When developing this originally, I tested all of this compared with
> > AVX-* instructions as well as the string ops, they all seemed to be
> > functionally equivalent, and all were beat out by this MOVNTI thing for
> > large regions of 1G pages.
> > 
> > There is probably room to further optimize the MOVNTI stuff with better
> > loop unrolling or optimizations, if anyone has specific suggestions I'm
> > happy to try to incorporate them, but this has shown to be effective as
> > written so far, and I think I lack that assembly expertise to micro
> > optimize further on my own.
> 
> Andi's point is that string instructions might be a better bet in a long
> run. You may win something with MOVNTI on current CPUs, but it may become
> a burden on newer microarchitectures when string instructions improves.
> Nobody realistically would re-validate if MOVNTI microoptimazation still
> make sense for every new microarchitecture.
>

The rationale for MOVNTI instruction is supposed to be that it avoids
cache pollution. Aside from the bench that shows MOVNTI to be faster for
the move itself, shouldn't it have an additional benefit in not trashing
the CPU caches?

As string instructions improve, why wouldn't the same improvements be
applied to MOVNTI?
