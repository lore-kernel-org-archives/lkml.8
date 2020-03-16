Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BE3C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 10:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6902071C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 10:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584353942;
	bh=Vefw0rWCOZpqAUIZntXEt6tl/ofqhSugEWMHFuHnX3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WkrXvKCgoIkAffNBjM6qHagzvB/45XfAuyplfg/eaiQ9EdXUGVjKZ9OSUeHTh2ngd
	 prcDYeIWylrXMkV5H7NCZZ6pUvbrPZx8vnaG3rcdQCW+YP+Z9TehYxeqjCmuFm04OX
	 wI+/sNQy3OlnyqptuWQimJ/W0cJrVGrXBhCQhwuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730584AbgCPKTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 06:19:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45586 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730478AbgCPKTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 06:19:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id t2so10368473wrx.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 03:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=by4TvxxMh1J37odWANeJUA5THAbr8krIjoLe+U1XJ7k=;
        b=fy6Pxjb7f9i/Uf8ak/mOk1sGETUJYFpwa99IINLRopQEC1xvjHPAhxKAjci2bAomd8
         GQkOUhK8VhXbHKWa3Gf0w+cgir0N8yaHOtFqMG8jhGnsm7hZpV9Nwrp5F6yeOjemGod6
         utu4+syylb8pYmdD75rS2eNqMhtf+kaVPPOpPSYrDadmzAyQZxY1UtofVPgs4rf8dXLB
         KMQ9oulCw5w6E7fYbHVpSeiGUO8BPuUeBifgmWVwJ6xW+0UR16se+rBuJYY9YWw/G5sd
         93KgPixxC2kpzqGvQMU3Fv+YX5iTU2FN433+p9JHba3QOtc26xPfvqtEl4JLyYYcJQEP
         uRhg==
X-Gm-Message-State: ANhLgQ2Mb2kZcnmPqMefKzV27AWylhXYU56U3IAI/Vj/fqK/d8jGpbSC
        DIGPg+FcUjkniqtux2muwDs=
X-Google-Smtp-Source: ADFU+vvY2dgrTYsWHy/KEnlB83n0mcQTm5pzCWK5yaHgD/keyG/GxRuHniGV5zf0c0nY9Snhutdulw==
X-Received: by 2002:adf:e4c9:: with SMTP id v9mr6105982wrm.188.1584353939301;
        Mon, 16 Mar 2020 03:18:59 -0700 (PDT)
Received: from localhost (ip-37-188-254-25.eurotel.cz. [37.188.254.25])
        by smtp.gmail.com with ESMTPSA id x17sm55358420wrt.31.2020.03.16.03.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 03:18:58 -0700 (PDT)
Date:   Mon, 16 Mar 2020 11:18:56 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Cannon Matthews <cannonmatthews@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Salman Qazi <sqazi@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] mm: clear 1G pages with streaming stores on x86
Message-ID: <20200316101856.GH11482@dhcp22.suse.cz>
References: <20200307010353.172991-1-cannonmatthews@google.com>
 <20200309000820.f37opzmppm67g6et@box>
 <20200309090630.GC8447@dhcp22.suse.cz>
 <20200309153831.GK1454533@tassilo.jf.intel.com>
 <20200309183704.GA1573@bombadil.infradead.org>
 <CAJfu=UfPKZwqjGR5AdhFRo_je7X5q2=zpBSBQkrbh2KhYrOJiA@mail.gmail.com>
 <20200311005447.jkpsaghrpk3c4rwu@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311005447.jkpsaghrpk3c4rwu@box>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-03-20 03:54:47, Kirill A. Shutemov wrote:
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

While this might be true, isn't that easily solveable by the existing
ALTERNATIVE and cpu features framework. Can we have a feature bit to
tell that movnti is worthwile for large data copy routines. Probably
something for x86 maintainers.
-- 
Michal Hocko
SUSE Labs
