Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4D7C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 01:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A40EF2076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 01:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rFyRARAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbgDPBRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 21:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgDPBQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 21:16:06 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17460C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 18:16:05 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id ca21so7322658edb.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 18:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DqhZGRoL70sm5/RzVHO716gnr2CLOKeQ+jLS9k1/y4Y=;
        b=rFyRARARoNvifTie3IBinXaGw3HxWbMokaBEk9FRXHKnN2o9HQhSGjBCrKKdNUYv+q
         ySccDKON48Kn5CX1Hb2xKb3O+fhncJOjdCjC0t2l1Q6XCKyMahaZUP34nUWaFw0LiVI9
         r3pjyTURPGWopwqma4Z6YJa5jtcZf1Bz+K56h45IUS205NJ3gScZV0yC5wQSyQ8z50l1
         Gvin7IoCG734F0kcIVUghxfJXGxvt9U2omfAFExwvrNieQpeK98ioL52hWBJ5aGWexXy
         3kD1KIFDI5I4GMiAAQlLfEpqutRTj6lMTdeNaJftbg1z01fnoFuiQqpeAYHnmay+F6J9
         rd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DqhZGRoL70sm5/RzVHO716gnr2CLOKeQ+jLS9k1/y4Y=;
        b=CJjq6EhlLT0HLSEsrwaJVWq5yMpizRBYWT+VJlLBXPhnOJ+aHYiAeXCrn1Nw6Coy4h
         sX55DyUoo9kLE/s51JwXWD/hrsiRl2FYsDV2/j7rtmtXEEBQASdAFx35j8SnFO2xvx1b
         F3urlohvbjw4fBH8CPieP6I8A39nzeaSW9lcDjKfkQ+3wOFmX2YmDg1azbopaW+lqzHn
         5eRQ1O+WsR9wIMDklakczEWGGrfftDaUvKsNu9sST4M3MwnfBo1s4Guc65fa36Dq3nfv
         QMfLeVeWPYoDs3nDxOGOV2wnDNm8OW5vd3WWhcJTPyAMPBoH4Uzeh902dYHnPMOM0gE1
         DqSw==
X-Gm-Message-State: AGi0PuYayGss6YeYsJ9q5ywifVUmwNeHKhgcTlgkoEbRTsGKOH2NuBUO
        mzTnJgWNaWC4k8NAxd+1mSr/Wr3RQ8Zs8ZRvqSTw/A==
X-Google-Smtp-Source: APiQypJdK40vPIhcswQ8xkik3AhhbZAYcvE2Hh6OIrvYJSqpheM1v+mhi3nUTHnpQhjxo0F4dTdt0+eK0N4jSjhfODc=
X-Received: by 2002:a50:a9c5:: with SMTP id n63mr27903084edc.312.1586999763505;
 Wed, 15 Apr 2020 18:16:03 -0700 (PDT)
MIME-Version: 1.0
References: <CADyq12wPW69ovpW4akDY5PGBbrvnwsLO86=sSKTU4CB3dNwG3Q@mail.gmail.com>
 <20200414214516.GA182757@xz-x1> <20200415031602.22348-1-hdanton@sina.com>
 <20200415142546.GO5100@ziepe.ca> <20200416000229.GA9922@redhat.com>
In-Reply-To: <20200416000229.GA9922@redhat.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Wed, 15 Apr 2020 18:15:26 -0700
Message-ID: <CADyq12xg8vxetG8y=M6i2m4qYrtjsRhmpds-3yKTY2icrHG2GA@mail.gmail.com>
Subject: Re: Userfaultfd doesn't seem to break out of poll on fd close
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Hillf Danton <hdanton@sina.com>,
        Peter Xu <peterx@redhat.com>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sonny Rao <sonnyrao@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,
Thanks for taking the time to reply.

> static int userfaultfd_flush(struct file *file, fl_owner_t id)
> {
>         struct userfaultfd_ctx *ctx = file->private_data;
>         wake_up_poll(&ctx->fd_wqh, EPOLLHUP);
> }
>

Yes, I think that something like this would work for this situation and eventfd.

> If eventfd and pipes all behave identical to uffd (they should as they
> don't seem to implement flush) I'm not sure if there's good enough
> justification to deviate from the default VFS behavior here.

Pipes actually behave a little differently, in the case that you close
the write end of the pipe the read end will break out of the poll with
EPOLLHUP, but I suppose closing the read end while the read end is
being polled would be more analogous to what I'm describing here. And
this is why it felt weird to me, in these situations the kernel
_knows_ that after the close nothing can happen on the file
descriptor, so what's the point of keeping it in a poll? As soon as
the poll breaks any read, write, ioctl, etc on the fd whether it's a
userfaultfd or an eventfd would fail with -EBADF.

And all of that I guess makes sense in the case of a non-blocking fd,
but what about the case of a blocking file descriptor? Both
userfaultfd and eventfd can seemingly be stuck in a read syscall with
no way to break them out when the userfaultfd/eventfd has no further
utility. Here is an example:
https://gist.github.com/bgaff/607302d86d99ac539efca307ce2dd679

For my use case adding an eventfd on poll works well, so thank you for
that suggestion. But the behavior just seemed odd to me which is why I
started this thread.

Thanks,
Brian
