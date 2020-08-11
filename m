Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785CBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4212920756
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Orbth0ob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgHKVnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:43:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54527 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726115AbgHKVnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:43:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597182181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GOplycSYlrE/8t7FkYQABzHBjonJiVQgHyqp2y7F7QQ=;
        b=Orbth0obdp4LDiHi/W1QgBqHm85F/ed6OpnpONFGsKomC1+xwobevC1JkIWqjzlbvNIgIR
        0L6Vx3t9A/PjZnLqFbOuyvw04O3a2d/JfXYaMgbYYYzQKBlnPKC8sciOE70srqe0kkVvfg
        HknZBSHVHkcDgGVGaHbhz6QkxZ/hIEQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-fyehHW_zMH6ngrbNV0dgrA-1; Tue, 11 Aug 2020 17:42:59 -0400
X-MC-Unique: fyehHW_zMH6ngrbNV0dgrA-1
Received: by mail-qv1-f71.google.com with SMTP id k17so21709qvj.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:42:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GOplycSYlrE/8t7FkYQABzHBjonJiVQgHyqp2y7F7QQ=;
        b=jH1/4KCJl+rSK8HbNVI3VpjtnsYsw1Vd5oMzYW2FISTyAmv1UErfPwSD+gPru9r9hV
         /MzmsRZSp3tN7APX+kvSBR4jqNNZfhIcccgaaISWfirWD+a3hffnId+PY2hs3f52BstN
         HSX+k7Fk5V/1/XYoAQahAHvcmkPPfdprOwhdCgXxsnmHfmXZDCVyq0mOrCJ9qkMFidBf
         y6rx2LGZwhGG3IsK4APtOdO0YBJZiD7Vl3yEJOMtc8B84Xf6bYFGIgTQLII9HOfuhy8C
         ybIziuFRgAjfuG3ccrFW+tdwtLpoo9jnt2IplluCRKlv733CrqsfLjjDDvy5LGwMPc6a
         bjaA==
X-Gm-Message-State: AOAM531K8v5wDWJKdSH8+oRyCKi6jmxrsbMaRuoENubO1QLZHCnXjTO2
        W13bFBsknJKg67flNzdK91f85l9HdE8GsGVI8uSXhem8aM4VNG2MiCnNfGFCS373M/pgrCRMKyY
        4dcfyBS+2EjiIKNZfp4eSEtCs
X-Received: by 2002:aed:32e7:: with SMTP id z94mr3339913qtd.17.1597182178812;
        Tue, 11 Aug 2020 14:42:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyo8F+uTEcgTbzU3zN2GBs9m/OPQosEA3NnwKTPKN2JruuWVxB92nyAAocuBVSKKliRSGcX9A==
X-Received: by 2002:aed:32e7:: with SMTP id z94mr3339893qtd.17.1597182178579;
        Tue, 11 Aug 2020 14:42:58 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id d198sm99118qke.129.2020.08.11.14.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 14:42:57 -0700 (PDT)
Date:   Tue, 11 Aug 2020 17:42:55 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v3] mm/gup: Allow real explicit breaking of COW
Message-ID: <20200811214255.GE6353@xz-x1>
References: <20200811183950.10603-1-peterx@redhat.com>
 <CAHk-=whQM=m5td5tfbuxh1f_Gxjsa74XV962BYkjrbeDMAhBpA@mail.gmail.com>
 <CAHk-=wit7LDr0tA2eVn7yHHEH76oK=Lfm3tTs8_JxO8XEED4_g@mail.gmail.com>
 <CAHk-=wifRg0pDhufQFasWa7G3sMHbG0nahnm5yRwvTKpKU9g4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wifRg0pDhufQFasWa7G3sMHbG0nahnm5yRwvTKpKU9g4A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 01:46:05PM -0700, Linus Torvalds wrote:
> On Tue, Aug 11, 2020 at 1:06 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Maybe trying to reuse the page just isn't worth it?
> 
> Well, the attached patch boots, and hasn't slowed kernel compiles
> down. But it may do horrible things due to leaving swap cache pages
> and KSM pages to be reaped by the memory scanner, instead of being
> reused.
> 
> I wouldn't notice, I have too much memory in this machine anyway.
> 
> It might have positive side effects too, of course. Not waiting for
> the page lock in the page fault case could be a big win on some loads.
> We do_wp_page() was one of the paths to the page lock that caused the
> nasty latency spikes (I'm not sure it was a dominant one, but it was
> up there).
> 
> So maybe it is worth running some test loads on. And while this patch
> doesn't do it, applying this should mean that you can just revert all
> the COW games entirely, and we can remove the should_force_cow_break()
> from the GUP paths.
> 
> (Also - if this actually works, we can get rid of reuse_ksm_page(),
> this was the only user)

I don't know good enough on the reuse refactoring patch (which at least looks
functionally correct), but... IMHO we still need the enforced cow logic no
matter we refactor the page reuse logic or not, am I right?

Example:

  - Process A & B shares private anonymous page P0

  - Process A does READ of get_user_pages() on page P0

  - Process A (e.g., another thread of process A, or as long as process A still
    holds the page P0 somehow) writes to page P0 which triggers cow, so for
    process A the page P0 is replaced by P1 with identical content

Then process A still keeps the reference to page P0 that potentially belongs to
process B or others?

Thanks,

-- 
Peter Xu

