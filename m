Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28111C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F31E020870
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="irV5u50v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgGCJpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 05:45:46 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53223 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726409AbgGCJpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593769543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AA5KODddQ3HbG0ydkjTXDrfB0iva22PrfbR0RkgNHDk=;
        b=irV5u50vm0VEkKTDPDqhOwE/2mle/q8T9ktqBXfYGub35k1UVJvVFNQdmeBrzHm7Ky4CW1
        MpsUWja6eP4MI39oCH0pYROBsZvQEYKLi5l2ntO/8naTsy2xUMjs00/gyQPKCKCs0aN0Vt
        GDm06/NxBaFKo3c236sZNLWbAoeddPU=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-YSa3hZm2P7aPi1WdG5DqCg-1; Fri, 03 Jul 2020 05:45:41 -0400
X-MC-Unique: YSa3hZm2P7aPi1WdG5DqCg-1
Received: by mail-ot1-f70.google.com with SMTP id 14so4149842otd.23
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 02:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AA5KODddQ3HbG0ydkjTXDrfB0iva22PrfbR0RkgNHDk=;
        b=aOQXfX8BOXI3XFvBgolcSB5aqTDUIRpnw5MBhkhRm+KplpIblW8dWcPuSFbYocpLRp
         yOfmYmPnFtQZGbkRywtut/ME6vVYQWMPjd1qYFmGYt6H2s3sTMoyxO4KfoF9JbxditZS
         JfYEuGuyp124wJTftI/0gHS/qjEUgj8Zd4h2ic55Op1eB1ULj1vxFDxKXd+7lwZcnPZq
         VNw8e+zstuwGYKxNFzkfDsI/ywqiBwEQIqkJCWHZZCCt7N69445hrKAS7KOksqKGCOSU
         gtmtbMfLHPklFGXeRealkFz2RR2mIkHGF4Lg9NCv9sMXRcLrBVYLnSKOTLkmdoAgZRn6
         5NRQ==
X-Gm-Message-State: AOAM531Y+SspFEJgzDUMA8nA94EPZkAgYdsupt2EGJKMaK6F4eZaMbzZ
        um/3drAQ8+HVuKacSBt2npuseXDZum20jAIlKI6qDYUz4UOl4DS4u8sxOJXwObXF7V69fZdmMjm
        LdyM2rqHZChZJ1SeXa4O5mzc2/gRv7AK5U85ZzHta
X-Received: by 2002:a05:6830:1c6e:: with SMTP id s14mr25164696otg.58.1593769540762;
        Fri, 03 Jul 2020 02:45:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+Ce/YV4Ri2FhaSPK6PoutDZUmwdOzBUZOLe5RemGei+boqUpH8/2S5wzAt2YXKDn+6fKVwICp10PF4itwpMQ=
X-Received: by 2002:a05:6830:1c6e:: with SMTP id s14mr25164681otg.58.1593769540566;
 Fri, 03 Jul 2020 02:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200702165120.1469875-1-agruenba@redhat.com> <20200702165120.1469875-3-agruenba@redhat.com>
 <CAHk-=wgpsuC6ejzr3pn5ej5Yn5z4xthNUUOvmA7KXHHGynL15Q@mail.gmail.com>
 <CAHc6FU5_JnK=LHtLL9or6E2+XMwNgmftdM_V71hDqk8apawC4A@mail.gmail.com> <CAHk-=wiDA9wm09e1aOSwqq9=e5iTEP5ncheux=C=p62h7dWvbA@mail.gmail.com>
In-Reply-To: <CAHk-=wiDA9wm09e1aOSwqq9=e5iTEP5ncheux=C=p62h7dWvbA@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 3 Jul 2020 11:45:29 +0200
Message-ID: <CAHc6FU5rz+2NZwvXqAxSAme9uvY8cGEHjnBmwi0S6NFnHRbUCA@mail.gmail.com>
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

On Thu, Jul 2, 2020 at 10:18 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Jul 2, 2020 at 12:58 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > > Of course, if you want to avoid both new reads to be submitted _and_
> > > avoid waiting for existing pending reads, you should just set both
> > > flags, and you get the semantics you want. So for your case, this may
> > > not make any difference.
> >
> > Indeed, in the gfs2 case, waiting for existing pending reads should be
> > fine. I'll send an update after some testing.
>
> Do note that "wait for pending reads" very much does imply "wait for
> those reads to _complete_".
>
> And maybe the IO completion handler itself ends up having to finalize
> something and take the lock to do that?
>
> So in that case, even just "waiting" will cause a deadlock. Not
> because the waiter itself needs the lock, but because the thing it
> waits for might possibly need it.
>
> But in many simple cases, IO completion shouldn't need any filesystem
> locks. I just don't know the gfs2 code at all, so I'm not even going
> to guess. I just wanted to mention it.

Yes, that makes sense. Luckily gfs2 doesn't do any such locking on IO
completion.

Thanks,
Andreas

