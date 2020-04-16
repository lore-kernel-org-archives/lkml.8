Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CF1C2D0EF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 04:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D6F320767
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 04:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EcJutLlh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392031AbgDPEkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 00:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390974AbgDPEkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 00:40:09 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31105C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 21:40:07 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id g16so234567eds.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 21:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1TmAq26FwNb/+my3FNLYsjFmfOxy1GujQDz0h2Jw32I=;
        b=EcJutLlhow0uYQmo8crq4m4T0KDsDHGOBouftcX0wT4Y0o7bFLqgYyHUBSuHzqLdML
         BB/t6pjPuFQPd+ex7e9GH4Hzv4GOeochpK9O0XayObREuFm9JpqYqHJRZKrP/+CFkY2P
         RXujhkieLHZOsc8dQhSLobjzvNzkU6nmhCrt5NaZFCBJLGvdZUAt0KchwFBMCJC9IzoB
         NRzKTHEyu8uMPsm94Q+Fl9NSeulheLNEejw5G6wLIY5ygFYEnrWKFSpXL4aMgtnFUc6n
         O7Z5Bp5BzhXvLize3Jr5TZZJEEdjNZ9VU4VwAOUFxWe3lRHGVTO74K7NYCs6/ai9NCfw
         ++EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1TmAq26FwNb/+my3FNLYsjFmfOxy1GujQDz0h2Jw32I=;
        b=aPlsvVJmD5A+7ru11t+G0nDgUUIB5nLm3IpQFVKIdGajdpEjquLKeraBDzkKIN7C0m
         dEU1UcAaXQCaAdSwI8LdSExzT1YcYvxg1F3jyU8Ydawd2Oa2JxmllWDBOTJe/myBhx/6
         yVSKb82lvAH1tBYS2yPzlAKCiL30K4EvOyb3iJiVJ2Lq2jV9QwIHPf1XmRziWSiUQo+Q
         9dy9VXab6sOJO/AgSbkbnbq96Z7jAZcrcjALgmKki6jfUdhaYORSJ3zwSjOwQoWsRxzu
         eBBdUqjdq09dnAz5eWHYs6IdLqdfnox4EAvggsgapoxi63RI0qQvQHgoIv/X6rSDFZ9+
         jfVw==
X-Gm-Message-State: AGi0PuZZwby0ovTA1V2GlwAeDgVnLhJST8+jHch5iPiqVIE49Kh3fJQG
        bGrTC0dDXBQbKvuSwxYu8Vy3mnHz5s7DR2uwsj31sQ==
X-Google-Smtp-Source: APiQypKuTs4ZTURfnwA3k9c3Sa6FarUnuNry42NNEmMYT4WoMaYpxBqdtlKm739fvWDGWqpS2PBNJmaOJbqjbj85g8Y=
X-Received: by 2002:a05:6402:17aa:: with SMTP id j10mr27011118edy.146.1587012005301;
 Wed, 15 Apr 2020 21:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <CADyq12wPW69ovpW4akDY5PGBbrvnwsLO86=sSKTU4CB3dNwG3Q@mail.gmail.com>
 <20200414214516.GA182757@xz-x1> <20200415031602.22348-1-hdanton@sina.com>
 <20200415142546.GO5100@ziepe.ca> <20200416000229.GA9922@redhat.com>
 <CADyq12xg8vxetG8y=M6i2m4qYrtjsRhmpds-3yKTY2icrHG2GA@mail.gmail.com> <20200416013744.GA230737@xz-x1>
In-Reply-To: <20200416013744.GA230737@xz-x1>
From:   Brian Geffon <bgeffon@google.com>
Date:   Wed, 15 Apr 2020 21:39:28 -0700
Message-ID: <CADyq12w3zO9iFPhCMzX=QXM88bvWjRUVdrbV637a-1Mwjvxp9w@mail.gmail.com>
Subject: Re: Userfaultfd doesn't seem to break out of poll on fd close
To:     Peter Xu <peterx@redhat.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Hillf Danton <hdanton@sina.com>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sonny Rao <sonnyrao@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Peter,
I see your point. I'm totally fine if we just leave this at: just
don't do it. lol. I appreciate you guys taking the time to talk
through this.

Brian



Brian

On Wed, Apr 15, 2020 at 6:37 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Apr 15, 2020 at 06:15:26PM -0700, Brian Geffon wrote:
> > Hi Andrea,
> > Thanks for taking the time to reply.
> >
> > > static int userfaultfd_flush(struct file *file, fl_owner_t id)
> > > {
> > >         struct userfaultfd_ctx *ctx = file->private_data;
> > >         wake_up_poll(&ctx->fd_wqh, EPOLLHUP);
> > > }
> > >
> >
> > Yes, I think that something like this would work for this situation and eventfd.
> >
> > > If eventfd and pipes all behave identical to uffd (they should as they
> > > don't seem to implement flush) I'm not sure if there's good enough
> > > justification to deviate from the default VFS behavior here.
> >
> > Pipes actually behave a little differently, in the case that you close
> > the write end of the pipe the read end will break out of the poll with
> > EPOLLHUP, but I suppose closing the read end while the read end is
> > being polled would be more analogous to what I'm describing here. And
> > this is why it felt weird to me, in these situations the kernel
> > _knows_ that after the close nothing can happen on the file
> > descriptor, so what's the point of keeping it in a poll? As soon as
> > the poll breaks any read, write, ioctl, etc on the fd whether it's a
> > userfaultfd or an eventfd would fail with -EBADF.
> >
> > And all of that I guess makes sense in the case of a non-blocking fd,
> > but what about the case of a blocking file descriptor? Both
> > userfaultfd and eventfd can seemingly be stuck in a read syscall with
> > no way to break them out when the userfaultfd/eventfd has no further
> > utility. Here is an example:
> > https://gist.github.com/bgaff/607302d86d99ac539efca307ce2dd679
> >
> > For my use case adding an eventfd on poll works well, so thank you for
> > that suggestion. But the behavior just seemed odd to me which is why I
> > started this thread.
>
> Hi, Brian,
>
> I think I can understand you on the weirdness when comparing to the
> pipes.  And IIUC that's majorly what POLLHUP is used for - it tells us
> that the channel has closed.  I believe it's the same to a pair of
> send/recv sockets when one end closes the port so the other side can
> get a POLLHUP.
>
> However IMO userfaultfd is not such a channel like pipes, as you have
> already mentioned.  It's not paired ports.  As you've given the other
> example on "closing the read pipe when reading the read pipe" - I'm
> curious what will happen for that.  I feel like it'll happen the same
> way as being blocked, just like what userfaultfd and eventfd are
> doing.  My understanding is that the Linux kernel should be thread
> safe on all these operations so no matter how we use the syscalls and
> in what order the kernel shouldn't break with this.  However IMHO it
> does not mean that it'll guarantee things like "close() will kick all
> existing fd operations".  I don't know whether there's any restriction
> in POSIX or anything for this, but... I won't be too surprised if
> someone tells me there's some OS that will directly crash the process
> if one fd is close()ed during a read()...
>
> Thanks,
>
> --
> Peter Xu
>
