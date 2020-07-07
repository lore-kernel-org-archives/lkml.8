Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DE0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEAC52063A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UBPngXuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgGGOaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:30:35 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37724 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725944AbgGGOaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594132234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jdHAIpfWqWHafM+znmNZIJaMTPI5wENHSEaIJXcuW90=;
        b=UBPngXuIiEZzuwJIG2dZRDDRKGA9AiIVA8AeoZhBuCfqZ35Rdy08U94NniJTr3LYDplDYT
        4mdZAJZ30koB5CO8gUOJmFNLMC4lJqP+me/5eqVKHqZoRplt/PRDRLs7hm404+DCU/VlJs
        uCQcRNd+RZxbnuZJ8WDL9Y3y2Olr90M=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-VCk3zA_XN2OtFN2ghVchuQ-1; Tue, 07 Jul 2020 10:30:32 -0400
X-MC-Unique: VCk3zA_XN2OtFN2ghVchuQ-1
Received: by mail-oo1-f72.google.com with SMTP id a24so13020565oos.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jdHAIpfWqWHafM+znmNZIJaMTPI5wENHSEaIJXcuW90=;
        b=QWPOFRqpTYQUkyII3gf39rY6gwjc8tqaFN0MD30LjhFzez8k68XbfCRu+nNgGVMFSq
         cnCvCENiE4rGI4uoJ3SeWeaQOaKI0C3DVP9q3YU68hEZYOp5OHLJQWngsvPnc9h3R2fD
         N30DlXz0QH1v11FgtVOHcnwU+O2q1VIxbunzvgHx2aPi7HG7989B9fC9RIcplk3zqpSL
         EAqN0udlqqlFTvSTwL25vevMcx2wzww9TAKWKao6l/RlBmrabRJEksaocz6rgm8YyR2x
         0YZulvSLPBFpBLbrETo6C1VPTTCNqJIr3L9ZpCjC/aIrrqntcmkVlVWysUFeW1jM7UUY
         NEMQ==
X-Gm-Message-State: AOAM531fRwEWbdqL/XsmjXkvoQFtE5qgV/Mf1ne7S9bTyQjZyuIW55WE
        oY6wLEUGOmcPUQiizcGj7tVQl5hiHi/xuqdVSVNf5J+fAfDSFF2ckh/KMpLeKbO0AfEdkZR0b0b
        jA5gXohUCw6386cUa6odvYcMJczZEgYmTXCcLMSRT
X-Received: by 2002:a4a:868a:: with SMTP id x10mr47045441ooh.31.1594132231277;
        Tue, 07 Jul 2020 07:30:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxkyrmC9YyVoZKCHhEbKVmEbE0QU21dPZEuBspnOoCY6PvjRo2XRprybq1+LMm+sMOQeYKXQRvYJk4hHGy4wPw=
X-Received: by 2002:a4a:868a:: with SMTP id x10mr47045402ooh.31.1594132230968;
 Tue, 07 Jul 2020 07:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200702165120.1469875-1-agruenba@redhat.com> <20200702165120.1469875-3-agruenba@redhat.com>
 <CAHk-=wgpsuC6ejzr3pn5ej5Yn5z4xthNUUOvmA7KXHHGynL15Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgpsuC6ejzr3pn5ej5Yn5z4xthNUUOvmA7KXHHGynL15Q@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 7 Jul 2020 16:30:19 +0200
Message-ID: <CAHc6FU6LmR7m_8UHmB_77jUpYNo-kgCZ-1YTLqya-PPqvvBy7Q@mail.gmail.com>
Subject: Re: [RFC 2/4] fs: Add IOCB_NOIO flag for generic_file_read_iter
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 8:06 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Jul 2, 2020 at 9:51 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > Add an IOCB_NOIO flag that indicates to generic_file_read_iter that it
> > shouldn't trigger any filesystem I/O for the actual request or for
> > readahead.  This allows to do tentative reads out of the page cache as
> > some filesystems allow, and to take the appropriate locks and retry the
> > reads only if the requested pages are not cached.
>
> This looks sane to me, except for this part:
> >                 if (!PageUptodate(page)) {
> > -                       if (iocb->ki_flags & IOCB_NOWAIT) {
> > +                       if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_NOIO)) {
> >                                 put_page(page);
> >                                 goto would_block;
> >                         }
>
> This path doesn't actually initiate reads at all - it waits for
> existing reads to finish.
>
> So I think it should only check for IOCB_NOWAIT.

It turns out that label readpage is reachable from here via goto
page_not_up_to_date / goto page_not_up_to_date_locked. So IOCB_NOIO
needs to be checked somewhere. I'll send an update.

Andreas

