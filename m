Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA389C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 907552078E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmeJX2eq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgHKP2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:28:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59035 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728833AbgHKP2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597159683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kntGr4b8AGMa950lPlvHff9JxOpLqYWCa31pRH+o+N8=;
        b=SmeJX2eqVgSc3T96ffnO5vcI0gHsPFWw3x2QO5qe8XcN6sc2qun1DkxBS0Yt+Hv1Rx6BhG
        b/vT2xWQnUoc4kWnvTLj+6vJBCrv6gbRYteIWlffK+pvASP+6SGYukOMs961rObx/Z51V/
        tibAv8IPHN8NHp4b0JVFq8oaK/84/zg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-UJYnVUqyONKbt5zNYDgnOw-1; Tue, 11 Aug 2020 11:28:01 -0400
X-MC-Unique: UJYnVUqyONKbt5zNYDgnOw-1
Received: by mail-qk1-f197.google.com with SMTP id n128so9623596qke.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 08:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kntGr4b8AGMa950lPlvHff9JxOpLqYWCa31pRH+o+N8=;
        b=lv56JZjrUpBVexk+NE2YAn21l3RrwUF4AjrHEQkhDNQfelqZCqKtTlfRi83k+uqRZU
         53KvoL8Vvpc8HBc6ENqQ2AhU2aibSC94t/1jmyk5QOHOcPODYuTfMV0ABlXJDMmY7TGI
         7hNXIcJZXwM9LFVy2Bn1oah3poNaKcR2+ZrCiA9ffiyl4byju3QTqlgilSOJcYACE1nA
         j/rG8Q08OYyOIlB+0XTA2hx/vz0kLPBYGtLdVwLUuwIXr83RchbReAvSkJl+zez7Xq2y
         1M3u1qU9gWtYH+sHKdTV503RS9yPF1/mUoTTJx/lZ13w+e/O8l8CKKCK0HODoiJ3BIR/
         k7Yg==
X-Gm-Message-State: AOAM53121eV7/p9raz1x2jqfBfMfg9yun93CSPNyplpKcm4oer8yrU93
        95mJUdUKeTUuvn25OJXaujecAa+SI1o8w9a8A4Y0wkBm1gQSMzCvUXXdtrR2Qt9ggY5Gijt2cF+
        cZ8TQkoHfp41URexFO2bNG9k6
X-Received: by 2002:a37:e89:: with SMTP id 131mr1632426qko.279.1597159680784;
        Tue, 11 Aug 2020 08:28:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTYChHahVyWGo6bHIYjUeN8Nr/1KqCb72Lik8z7WOi9WG/C2DjjMZQyPq8XLNgOv7ZtnMbsQ==
X-Received: by 2002:a37:e89:: with SMTP id 131mr1632402qko.279.1597159680464;
        Tue, 11 Aug 2020 08:28:00 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id t187sm4247605qka.26.2020.08.11.08.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 08:27:59 -0700 (PDT)
Date:   Tue, 11 Aug 2020 11:27:57 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] mm/gup: Allow real explicit breaking of COW
Message-ID: <20200811152757.GC132381@xz-x1>
References: <20200810145701.129228-1-peterx@redhat.com>
 <CAHk-=wiSF+aKhDOewxQGCGUPyGnA=K7OtAczL5M7aisA5mgFzg@mail.gmail.com>
 <20200810191520.GA132381@xz-x1>
 <CAHk-=whUVHA-=4mwGaUA42teESc2mX1nwZjbbOMQsvPaoYxh3w@mail.gmail.com>
 <20200810215734.GB132381@xz-x1>
 <CAHk-=whng9zK-GMM+UHsTptF=mgH164Zt_Gok3ohbcWaYee71Q@mail.gmail.com>
 <CAG48ez1R_F-Oxz++sQ0dGTqZKHCyKazVEKZTTAutQbSuohXXnw@mail.gmail.com>
 <CAHk-=wgyrfrpRvM8CYiiZR8s7MKC_exFDw=mPGnEKzqXBcYJxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgyrfrpRvM8CYiiZR8s7MKC_exFDw=mPGnEKzqXBcYJxA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 08:05:22AM -0700, Linus Torvalds wrote:
> On Mon, Aug 10, 2020 at 4:39 PM Jann Horn <jannh@google.com> wrote:
> >
> > The way I understand Peter, he doesn't want to avoid doing COW; he
> > wants to decouple userfaultfd-WP's fault handling from COW, so that
> > userfaultfd-wp notifies only when a previously-write-protected page is
> > actually written to. In other words, he wants the COW to basically
> > happen as it happens now, but it should only create a readonly PTE;
> > and if someone later triggers a real write fault, the fault handling
> > path would run again, and this time userfaultfd-wp would be notified
> > before that readonly PTE is turned into a writable one.

Yes, that's what I meant.  Appreciate your help, Jann.

> 
> Ahh.
> 
> A light goes on.
> 
> Thank you.
> 
> And apologies to Peter - I misread that patch entirely.
> 
> That said, now that I (finally) understand what Peter wants to do, I
> don't think the patch does what you say.
> 
> Because the GUP will now indeed avoid userfaultfd-wp unless it's
> _actually_ a write, but then any reads will cause a COW that turns
> things writable. There is no second fault.
> 
> So now later writes will never cause any userfaultfd-wp notifications at all.
> 
> Which for all I know might be acceptable and ok, but it seems to be
> against userfaultfd rules, and against the whole synchronization idea.
> 
> So I think the patch is broken, but I'm less fundamentally concerned about it.
> 
> Because at that point, it's "only" userfaultfd that might break.

Right, v2 is broken on that.  That's why I pasted another chunk in my previous
reply to still inherit the UFFD_WP bit even for COW [1].  Previously it was not
needed because UFFD_WP must have been turned off for the pte/pmd/.. before COW
happens.  However with enforced COW that's not guaranteed any more.

I'll post v3 soon.

[1] https://lore.kernel.org/lkml/20200810191520.GA132381@xz-x1/

Thanks,

-- 
Peter Xu

