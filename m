Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA53C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 01:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A0E120644
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 01:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wxy3FCUW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733011AbgDPBiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 21:38:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60398 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726201AbgDPBhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 21:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587001072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZfkM9hUy9zY+sn22WstUWSEoLkl7MJxK53li2vbwwE8=;
        b=Wxy3FCUWojgqhk3BVPlQb351aSOp52Jgc1xvclzFJ49XXhJGTShUX3IHQXTbVpOPgvUIgO
        183/9GaunEa10OB3Ku467QLFPMohbY3qFiB6m0Ny3MQWyQ6cQ8IbjQ32N5KJsgFLL4Ld7j
        hrZHZlgIafugKzLRfTJS7VE9N1OfKok=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-nnMzANk8OmWDhNDUlwIn3A-1; Wed, 15 Apr 2020 21:37:48 -0400
X-MC-Unique: nnMzANk8OmWDhNDUlwIn3A-1
Received: by mail-qv1-f72.google.com with SMTP id cf1so1940244qvb.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 18:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZfkM9hUy9zY+sn22WstUWSEoLkl7MJxK53li2vbwwE8=;
        b=XhADieTAZXB5rGXSOqhGgLB8fCnu+HrZADOtq0L+49CMQM5MyjV463Ab1VI5G8QvN4
         3U8p+cWe+V/vE62QKwhEk0pxLgAkzBHmEs9uvibtFRfdFysK/3+77uWu9zNPKFXoOJ3Y
         A4auMFmnqXHYt7SDLLKmRRddGisUzB2zLQCslmNCAm5SUr8PLf727yjToNNfZib2O2IC
         E0acpy8iugpS1xUZvxK2ooAYTYGpff30iu66Mb1Lu5cGU8Jys/PSJhOXdW4i0B66NGfA
         rU2VSUAtrnqE3TaFA/OJ14xpK71UilU1U8GT67878Mda2i1nOUEYFCFnWjjZoE4s67nZ
         Y6eA==
X-Gm-Message-State: AGi0Pua6O/oCq07GrLHIpSeGrqDnxvciczS/yqTnCDHvgdYmHARJX41p
        NX+mHOLTu7kqVWDsT2md77yqxkI4e27LqRJpZ0+MuLcjoGrB4naBOug/X/mtieDBGGx0/sPs3Ya
        Lbu3w3KFymCxzuRsGanZ9GEeo
X-Received: by 2002:a37:4c0a:: with SMTP id z10mr29869990qka.408.1587001067616;
        Wed, 15 Apr 2020 18:37:47 -0700 (PDT)
X-Google-Smtp-Source: APiQypKu25hAnhaOqxgMVvWBsBq179+ZUjbR20/zB2+uR1lrIRr4rItY+cn29bRqSm8w0u6rR1LxeA==
X-Received: by 2002:a37:4c0a:: with SMTP id z10mr29869971qka.408.1587001067262;
        Wed, 15 Apr 2020 18:37:47 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id k35sm14857556qtc.28.2020.04.15.18.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 18:37:46 -0700 (PDT)
Date:   Wed, 15 Apr 2020 21:37:44 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Hillf Danton <hdanton@sina.com>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sonny Rao <sonnyrao@google.com>
Subject: Re: Userfaultfd doesn't seem to break out of poll on fd close
Message-ID: <20200416013744.GA230737@xz-x1>
References: <CADyq12wPW69ovpW4akDY5PGBbrvnwsLO86=sSKTU4CB3dNwG3Q@mail.gmail.com>
 <20200414214516.GA182757@xz-x1>
 <20200415031602.22348-1-hdanton@sina.com>
 <20200415142546.GO5100@ziepe.ca>
 <20200416000229.GA9922@redhat.com>
 <CADyq12xg8vxetG8y=M6i2m4qYrtjsRhmpds-3yKTY2icrHG2GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADyq12xg8vxetG8y=M6i2m4qYrtjsRhmpds-3yKTY2icrHG2GA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 06:15:26PM -0700, Brian Geffon wrote:
> Hi Andrea,
> Thanks for taking the time to reply.
> 
> > static int userfaultfd_flush(struct file *file, fl_owner_t id)
> > {
> >         struct userfaultfd_ctx *ctx = file->private_data;
> >         wake_up_poll(&ctx->fd_wqh, EPOLLHUP);
> > }
> >
> 
> Yes, I think that something like this would work for this situation and eventfd.
> 
> > If eventfd and pipes all behave identical to uffd (they should as they
> > don't seem to implement flush) I'm not sure if there's good enough
> > justification to deviate from the default VFS behavior here.
> 
> Pipes actually behave a little differently, in the case that you close
> the write end of the pipe the read end will break out of the poll with
> EPOLLHUP, but I suppose closing the read end while the read end is
> being polled would be more analogous to what I'm describing here. And
> this is why it felt weird to me, in these situations the kernel
> _knows_ that after the close nothing can happen on the file
> descriptor, so what's the point of keeping it in a poll? As soon as
> the poll breaks any read, write, ioctl, etc on the fd whether it's a
> userfaultfd or an eventfd would fail with -EBADF.
> 
> And all of that I guess makes sense in the case of a non-blocking fd,
> but what about the case of a blocking file descriptor? Both
> userfaultfd and eventfd can seemingly be stuck in a read syscall with
> no way to break them out when the userfaultfd/eventfd has no further
> utility. Here is an example:
> https://gist.github.com/bgaff/607302d86d99ac539efca307ce2dd679
> 
> For my use case adding an eventfd on poll works well, so thank you for
> that suggestion. But the behavior just seemed odd to me which is why I
> started this thread.

Hi, Brian,

I think I can understand you on the weirdness when comparing to the
pipes.  And IIUC that's majorly what POLLHUP is used for - it tells us
that the channel has closed.  I believe it's the same to a pair of
send/recv sockets when one end closes the port so the other side can
get a POLLHUP.

However IMO userfaultfd is not such a channel like pipes, as you have
already mentioned.  It's not paired ports.  As you've given the other
example on "closing the read pipe when reading the read pipe" - I'm
curious what will happen for that.  I feel like it'll happen the same
way as being blocked, just like what userfaultfd and eventfd are
doing.  My understanding is that the Linux kernel should be thread
safe on all these operations so no matter how we use the syscalls and
in what order the kernel shouldn't break with this.  However IMHO it
does not mean that it'll guarantee things like "close() will kick all
existing fd operations".  I don't know whether there's any restriction
in POSIX or anything for this, but... I won't be too surprised if
someone tells me there's some OS that will directly crash the process
if one fd is close()ed during a read()...

Thanks,

-- 
Peter Xu

