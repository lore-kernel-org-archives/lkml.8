Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BBBC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 00:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D0B21927
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 00:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CEJyrcgj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgCKAVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 20:21:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44145 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgCKAVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 20:21:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id l18so303115wru.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 17:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VG39e13IjUh+6IPexLga2X6dE7NDW4YKhNNoDdtQTnc=;
        b=CEJyrcgjzufz/+0cmY0Ssuxr3+VeaFEHWwjniP12MWqcDr0Rux5aEA6AjVLbHYBCy2
         h3JLPurUaQ+Ys5qAgbDGy/q63E+FBqoopQzUcYe2iTBuOjvpeUs/HAG+Jv6hVjeZdY+N
         H3XXY0oypkmS+puVDFLS0ICPG5HlpcfNCeEFrtmQYjGGhHjZcqMpyf23+NqpbIzq14UF
         Ehe9C6+xqoab5ITOiM2wA+laCJ/pX2ONA29/FJJAzAVHUbu2oo8tp8PgRgkix4O1fz3d
         q7X8PXxZADuT8AO9BUAXS895XhPNLo929Owpr+BJy2bdkLQW4ObbjG3cz2ESbm1zh0SX
         tCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VG39e13IjUh+6IPexLga2X6dE7NDW4YKhNNoDdtQTnc=;
        b=p1R0gA1/IU8wZNRcXumClf62dKSt35NljGVII1SIEuTcnZGnAtN4PRS0Heo4Q5DXhS
         7KJYEHIQfJD7LPJ0cX3FlKb8ROlhcSrwwLGgKJImX7dtXb4mvo+hCUO4SefalFBA85GF
         vW3KP7IAUGzk0N8e415rRlAD9xQgax+TEmwe+l269vNv52nFhe8k5JxvvNomS/XRZW1s
         +iAVnXYNy/Y3whKXW11vEzpBC4A5VYwdZ/uG17hVVvDn8X4dD+1bfT/VGUxHqpgxQvok
         KbKtLhh/xf7L4ZakNJGl3zwq9+CHpfrB/n1lOk50uH0DDyKlSU3xIgVuM5X1FIDnafhL
         zhdw==
X-Gm-Message-State: ANhLgQ05jnlm/mNoJVUks1WzhRK9sM5HQPVgJdCvtFnJe9XWBqsrI7uz
        oEX+xOnu/HCafY+3UeLAoDS1VW8v1vJDRF4MLzmXEw==
X-Google-Smtp-Source: ADFU+vvM6yw2gskZ5Rc7Ir59YS/n9v7GDnPLr6BSmxFaPG4y62GGienY0KoelFGNyMpz2ZNAI/adslNAS3RbDAqPyDQ=
X-Received: by 2002:adf:90cd:: with SMTP id i71mr469656wri.63.1583886102039;
 Tue, 10 Mar 2020 17:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200307010353.172991-1-cannonmatthews@google.com>
 <20200309000820.f37opzmppm67g6et@box> <20200309090630.GC8447@dhcp22.suse.cz>
 <20200309153831.GK1454533@tassilo.jf.intel.com> <20200309183704.GA1573@bombadil.infradead.org>
In-Reply-To: <20200309183704.GA1573@bombadil.infradead.org>
From:   Cannon Matthews <cannonmatthews@google.com>
Date:   Tue, 10 Mar 2020 17:21:30 -0700
Message-ID: <CAJfu=UfPKZwqjGR5AdhFRo_je7X5q2=zpBSBQkrbh2KhYrOJiA@mail.gmail.com>
Subject: Re: [PATCH] mm: clear 1G pages with streaming stores on x86
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andi Kleen <ak@linux.intel.com>, Michal Hocko <mhocko@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Salman Qazi <sqazi@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 9, 2020 at 11:37 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Mar 09, 2020 at 08:38:31AM -0700, Andi Kleen wrote:
> > > Gigantic huge pages are a bit different. They are much less dynamic from
> > > the usage POV in my experience. Micro-optimizations for the first access
> > > tends to not matter at all as it is usually pre-allocation scenario. On
> > > the other hand, speeding up the initialization sounds like a good thing
> > > in general. It will be a single time benefit but if the additional code
> > > is not hard to maintain then I would be inclined to take it even with
> > > "artificial" numbers state above. There really shouldn't be other downsides
> > > except for the code maintenance, right?
> >
> > There's a cautious tale of the old crappy RAID5 XOR assembler functions which
> > were optimized a long time ago for the Pentium1, and stayed around,
> > even though the compiler could actually do a better job.
> >
> > String instructions are constantly improving in performance (Broadwell is
> > very old at this point) Most likely over time (and maybe even today
> > on newer CPUs) you would need much more sophisticated unrolled MOVNTI variants
> > (or maybe even AVX-*) to be competitive.
>
> Presumably you have access to current and maybe even some unreleased
> CPUs ... I mean, he's posted the patches, so you can test this hypothesis.

I don't have the data at hand, but could reproduce it if strongly
desired, but I've
also tested this on skylake and  cascade lake, and we've had success running
with this for a while now.

When developing this originally, I tested all of this compared with
AVX-* instructions as well
as the string ops, they all seemed to be functionally equivalent, and
all were beat out by this
MOVNTI thing for large regions of 1G pages.

There is probably room to further optimize the MOVNTI stuff with
better loop unrolling or
optimizations, if anyone has specific suggestions I'm happy to try to
incorporate them, but
this has shown to be effective as written so far, and I think I lack
that assembly expertise to
micro optimize further on my own.

But just in general, while there are probably some ways this could be
made better, it does a
good job so far for the workloads that are more specific to 1G pages.

Making it work for 2MiB in a convincing general purpose way is a
harder problem and feels
out of scope, and further optimizations can always be added later on
for some other things.

I'm working on a v2 of this patch addressing some of the nits
mentioned by Andrew, should have
that hopefully soon.
