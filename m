Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A1EC18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 00:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C03FD20663
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 00:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="WSmMpUZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgCKAyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 20:54:50 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33511 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbgCKAyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 20:54:50 -0400
Received: by mail-lf1-f67.google.com with SMTP id c20so236461lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 17:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dU7rtCVt6go/gNNK8rtDCCujWIWJ/R6M8Id+CxlENYo=;
        b=WSmMpUZsEPdj4pzVZWkKiN2YJ2Xi/GcQiJMhcJAb0574DSfV2UkfOcbsZtw64fN819
         RWXkgIKwU851T08tcRgLSg54v9iVaGeZYkaaivk6T2m3S6m1YvP90hIvc6EhAQ8C0lNo
         MTjDnnpP1YzW5/19aJ4rIEKxuCiL1MFm8mRrK7aHKtfpFU9RL7AnSD03Q2m4uJqn5+QZ
         tyiF+GdemDV3kfurtm6Kt6/CSFiiWxaC4LrOEH1LyWihqsq5yivUvVXH5DHVNe8Ux5rA
         DhBMK6hGceXQhAm+5gLO71tmopU4AAUPsI1bs3qdXLJMO62dktnNNsqPMSwu+jqdveUa
         NECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dU7rtCVt6go/gNNK8rtDCCujWIWJ/R6M8Id+CxlENYo=;
        b=KiqNDZ4SdjotCzp3cyn+FG7L/occZFruvfP/LJOpoDGcPUQWKuX8LLoTFGn/B/L6oh
         QoVoyjZEQaFCOSSV02hAco/tXBSS8X+Dfkqecs8OltQUTKB0zYhPzVvlmHCE2Mh+Mmae
         8of6FYWOVWHKD1iMSwmJPnan1aUHmUXELrN6nPaAl5JfEAVGd/VbIW797TLtAdeq9L57
         yggzt1C+F5SNX+8tErrBJ7d2iE7nYfXlYRo3ESfu4DAU4XDrBJsliu6lKQHS8BZv5ZFC
         D+n2ZUs4Td5wDz9/rTuI1vMDDJmoOkC3BGeWZyWVogkVs8JajMoUKiXwdvKa6AkudslL
         l27g==
X-Gm-Message-State: ANhLgQ0qZ8/ZwcQLhrsp+8tXBTFs6SjkxxHtwpkT/44Z534lD6ZZH5RE
        62t83E5dvJGqiU0I35ei69jwPw==
X-Google-Smtp-Source: ADFU+vsXiPvXIDKQPuN/RXNRI1rzt32lyC92lEXxkc2mW2G48M5+okJRIYfpt0ctOGr7QqHYwldSVw==
X-Received: by 2002:ac2:4565:: with SMTP id k5mr436749lfm.8.1583888087712;
        Tue, 10 Mar 2020 17:54:47 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id k2sm5652992lfo.36.2020.03.10.17.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 17:54:46 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 81493100F99; Wed, 11 Mar 2020 03:54:47 +0300 (+03)
Date:   Wed, 11 Mar 2020 03:54:47 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Cannon Matthews <cannonmatthews@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Salman Qazi <sqazi@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] mm: clear 1G pages with streaming stores on x86
Message-ID: <20200311005447.jkpsaghrpk3c4rwu@box>
References: <20200307010353.172991-1-cannonmatthews@google.com>
 <20200309000820.f37opzmppm67g6et@box>
 <20200309090630.GC8447@dhcp22.suse.cz>
 <20200309153831.GK1454533@tassilo.jf.intel.com>
 <20200309183704.GA1573@bombadil.infradead.org>
 <CAJfu=UfPKZwqjGR5AdhFRo_je7X5q2=zpBSBQkrbh2KhYrOJiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfu=UfPKZwqjGR5AdhFRo_je7X5q2=zpBSBQkrbh2KhYrOJiA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 05:21:30PM -0700, Cannon Matthews wrote:
> On Mon, Mar 9, 2020 at 11:37 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, Mar 09, 2020 at 08:38:31AM -0700, Andi Kleen wrote:
> > > > Gigantic huge pages are a bit different. They are much less dynamic from
> > > > the usage POV in my experience. Micro-optimizations for the first access
> > > > tends to not matter at all as it is usually pre-allocation scenario. On
> > > > the other hand, speeding up the initialization sounds like a good thing
> > > > in general. It will be a single time benefit but if the additional code
> > > > is not hard to maintain then I would be inclined to take it even with
> > > > "artificial" numbers state above. There really shouldn't be other downsides
> > > > except for the code maintenance, right?
> > >
> > > There's a cautious tale of the old crappy RAID5 XOR assembler functions which
> > > were optimized a long time ago for the Pentium1, and stayed around,
> > > even though the compiler could actually do a better job.
> > >
> > > String instructions are constantly improving in performance (Broadwell is
> > > very old at this point) Most likely over time (and maybe even today
> > > on newer CPUs) you would need much more sophisticated unrolled MOVNTI variants
> > > (or maybe even AVX-*) to be competitive.
> >
> > Presumably you have access to current and maybe even some unreleased
> > CPUs ... I mean, he's posted the patches, so you can test this hypothesis.
> 
> I don't have the data at hand, but could reproduce it if strongly
> desired, but I've also tested this on skylake and  cascade lake, and
> we've had success running with this for a while now.
> 
> When developing this originally, I tested all of this compared with
> AVX-* instructions as well as the string ops, they all seemed to be
> functionally equivalent, and all were beat out by this MOVNTI thing for
> large regions of 1G pages.
> 
> There is probably room to further optimize the MOVNTI stuff with better
> loop unrolling or optimizations, if anyone has specific suggestions I'm
> happy to try to incorporate them, but this has shown to be effective as
> written so far, and I think I lack that assembly expertise to micro
> optimize further on my own.

Andi's point is that string instructions might be a better bet in a long
run. You may win something with MOVNTI on current CPUs, but it may become
a burden on newer microarchitectures when string instructions improves.
Nobody realistically would re-validate if MOVNTI microoptimazation still
make sense for every new microarchitecture.

> 
> But just in general, while there are probably some ways this could be
> made better, it does a good job so far for the workloads that are more
> specific to 1G pages.
> 
> Making it work for 2MiB in a convincing general purpose way is a harder
> problem and feels out of scope, and further optimizations can always be
> added later on for some other things.
> 
> I'm working on a v2 of this patch addressing some of the nits mentioned
> by Andrew, should have that hopefully soon.

Have you got any data for a macrobenchmark?

-- 
 Kirill A. Shutemov
