Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B28C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8910D2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tgg8ByCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgGMIHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 04:07:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45621 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726360AbgGMIHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594627657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=thokzV2lTPzLARMZ2GmJNDEymlOB144wptcD2yJ3eYo=;
        b=Tgg8ByCxPgAW6x6k/Pxla+AwCeYhQ4fjL45v5n0B9HihP6R1bfYcYK/uVjP+qzSPS6Q6UV
        dMFMIlu+ir+OEUeidzqmIThyPfYpP0nqsBv+0kp8E3NaCOXimeV5cNCOJ9zSy2IrznkAdh
        mS+XjsPYamhfW01Ob6e59iGPjPEiVm4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-S60BqLIBPCa18PpvdAtrTA-1; Mon, 13 Jul 2020 04:07:34 -0400
X-MC-Unique: S60BqLIBPCa18PpvdAtrTA-1
Received: by mail-wm1-f72.google.com with SMTP id z11so17729742wmg.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 01:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=thokzV2lTPzLARMZ2GmJNDEymlOB144wptcD2yJ3eYo=;
        b=S72Y1u6DG0s7YVjHHBTRWTndPJJ/6d2MEDEcDwPSKVXs6c4rzMpOVEOFOt8nYwgKem
         ccNxZP1TfmBoLWOUrUjnaLBn+yUoDbEX6iNjl/M29bOEQtSzbjx1kxx2KRpYuH/Psptl
         IZ5dbqx6RcsPmH+cxnCll67ml3fBm5Qd3nuSJXQ3voygGyhcz4f8yartZpdCFTqfdlAa
         dvaJm05fWqKE/NBZxmetO/KSfPEdeWTD63yZKpYmilvfCF3vHQ3zoUy2QXxMgIXduc6z
         KicNnVM/0oVjw9mdYMkatf6h6gVKBgtQN5mgp8HhZFG0FMEtruuto8Vui+V9YGKxnUci
         oGrQ==
X-Gm-Message-State: AOAM531IM+oBwZ+E7QWPTsjwhZ+v2U2LBei7UA3GNe1Ix1NfK18H9rbc
        wkM+cZaGceNa18LIx3BlhVyxCudd2U0ItFHYjoMipl6KcTKOHzN66L5eWFh5+KC45iX1wf4FDhV
        cPG67ybAkvZSPluq+73VqI6+G
X-Received: by 2002:adf:9051:: with SMTP id h75mr84159394wrh.152.1594627652976;
        Mon, 13 Jul 2020 01:07:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6ugR4SJYyS+JyXgFpzVLUdQEd9gIqid8od/rTaiAEg/puVly9toFCtHHU1aU3hfbT+UQRmQ==
X-Received: by 2002:adf:9051:: with SMTP id h75mr84159371wrh.152.1594627652750;
        Mon, 13 Jul 2020 01:07:32 -0700 (PDT)
Received: from steredhat (host-79-49-203-52.retail.telecomitalia.it. [79.49.203.52])
        by smtp.gmail.com with ESMTPSA id w16sm26837072wrg.95.2020.07.13.01.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 01:07:32 -0700 (PDT)
Date:   Mon, 13 Jul 2020 10:07:29 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Jann Horn <jannh@google.com>, Aleksa Sarai <asarai@suse.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        io-uring@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH RFC 2/3] io_uring: add IOURING_REGISTER_RESTRICTIONS
 opcode
Message-ID: <20200713080729.gttt3ymk7aqumle4@steredhat>
References: <20200710141945.129329-1-sgarzare@redhat.com>
 <20200710141945.129329-3-sgarzare@redhat.com>
 <f39fe84d-1353-1066-c7fc-770054f7129e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f39fe84d-1353-1066-c7fc-770054f7129e@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 11:52:48AM -0600, Jens Axboe wrote:
> On 7/10/20 8:19 AM, Stefano Garzarella wrote:
> > The new io_uring_register(2) IOURING_REGISTER_RESTRICTIONS opcode
> > permanently installs a feature whitelist on an io_ring_ctx.
> > The io_ring_ctx can then be passed to untrusted code with the
> > knowledge that only operations present in the whitelist can be
> > executed.
> > 
> > The whitelist approach ensures that new features added to io_uring
> > do not accidentally become available when an existing application
> > is launched on a newer kernel version.
> 
> Keeping with the trend of the times, you should probably use 'allowlist'
> here instead of 'whitelist'.

Sure, it is better!

> > 
> > Currently is it possible to restrict sqe opcodes and register
> > opcodes. It is also possible to allow only fixed files.
> > 
> > IOURING_REGISTER_RESTRICTIONS can only be made once. Afterwards
> > it is not possible to change restrictions anymore.
> > This prevents untrusted code from removing restrictions.
> 
> A few comments below.
> 
> > @@ -337,6 +344,7 @@ struct io_ring_ctx {
> >  	struct llist_head		file_put_llist;
> >  
> >  	struct work_struct		exit_work;
> > +	struct io_restriction		restrictions;
> >  };
> >  
> >  /*
> 
> Since very few will use this feature, was going to suggest that we make
> it dynamically allocated. But it's just 32 bytes, currently, so probably
> not worth the effort...
> 

Yeah, I'm not sure it will grow in the future, so I'm tempted to leave it
as it is, but I can easily change it if you prefer.

> > @@ -5491,6 +5499,11 @@ static int io_req_set_file(struct io_submit_state *state, struct io_kiocb *req,
> >  	if (unlikely(!fixed && io_async_submit(req->ctx)))
> >  		return -EBADF;
> >  
> > +	if (unlikely(!fixed && req->ctx->restrictions.enabled &&
> > +		     test_bit(IORING_RESTRICTION_FIXED_FILES_ONLY,
> > +			      req->ctx->restrictions.restriction_op)))
> > +		return -EACCES;
> > +
> >  	return io_file_get(state, req, fd, &req->file, fixed);
> >  }
> 
> This one hurts, though. I don't want any extra overhead from the
> feature, and you're digging deep in ctx here to figure out of we need to
> check.
> 
> Generally, all the checking needs to be out-of-line, and it needs to
> base the decision on whether to check something or not on a cache hot
> piece of data. So I'd suggest to turn all of these into some flag.
> ctx->flags generally mirrors setup flags, so probably just add a:
> 
> 	unsigned int restrictions : 1;
> 
> after eventfd_async : 1 in io_ring_ctx. That's free, plenty of room
> there and that cacheline is already pulled in for reading.
> 

Thanks for the clear explanation!

I left a TODO comment near the 'enabled' field to look for something better,
and what you're suggesting is what I was looking for :-)

I'll change it!

Thanks,
Stefano

