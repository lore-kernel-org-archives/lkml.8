Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A45C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 789972071A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WYviMdqQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbgFONd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:33:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60303 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730065AbgFONdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592227999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rW5iv07E6/hrUraCliFumYl+bzeZy7nOt0DSLH2NiHw=;
        b=WYviMdqQ5pSKcUymcCZwcFnPBBDDxM8N7S2qDqxKWsLmg8BZrcjA2zm7V0UJ7IWQlAbMw1
        IgLRhXJZywWBIG1Rchi272wNlbFeeAF3Cfn2/QPNRbpFyak1QTUna84NvYLWLygb6wsdkI
        UuPGliWCafBuCEk0ZtJmGAFKeqW4P98=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-sS7K9garOXu5AYIN-tR-MQ-1; Mon, 15 Jun 2020 09:33:17 -0400
X-MC-Unique: sS7K9garOXu5AYIN-tR-MQ-1
Received: by mail-wr1-f72.google.com with SMTP id e7so7097830wrp.14
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 06:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rW5iv07E6/hrUraCliFumYl+bzeZy7nOt0DSLH2NiHw=;
        b=eCKfQ+QYAeKjNTPBQA9F58m/6Hno9IbHOwDXXvtnzjlQLkur99HYbWP4fsB3kgnLwR
         WYBoK9ha/ms4SIjGaQSLvfgVOnJGO0LHNVXMZDNqPllwqN02PKtp2EJQY7ZgF0T5aU34
         96gYtzFUDn+csFBdnxt4vWkTZsPiLwOUHTK7/62wMIKNX7EYIJANibw9e+PNthYgTSvo
         TpUIUEOYJ3IU0+vvH6S/8pv6c/dCgViAcowweowm7Rqquu+X9iYc15n0tsCXLqTKR/1x
         NZ6ysF0lveANIgBAQfdJahIw0WGlu/usEGceKinGmWgxnmEJccodd2b2kq9x+4LXHv1e
         7PUA==
X-Gm-Message-State: AOAM533fC56xxQEyevxDt9jz4FhrK6RETyMPvKEOLP5zTknedhcrXfj/
        6neawttGuxWshbEWWvC8G4I8F4kHFvdHTDk2rqL3j15dZcgURWoUyMTtkYqAwzoDkt1XEKq+dtO
        l/CiIrSLbZ5p45sQcbl4RTJcw
X-Received: by 2002:a1c:dd44:: with SMTP id u65mr14130849wmg.180.1592227995767;
        Mon, 15 Jun 2020 06:33:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTmQVyxizijdU9DGs+rVmKRlfN8AQJjZJCbybP3u6h9bBk/MGo7QOVBdSHWtcmKkOZgBvGeQ==
X-Received: by 2002:a1c:dd44:: with SMTP id u65mr14130816wmg.180.1592227995477;
        Mon, 15 Jun 2020 06:33:15 -0700 (PDT)
Received: from steredhat ([5.180.207.22])
        by smtp.gmail.com with ESMTPSA id b19sm53221wmj.0.2020.06.15.06.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 06:33:14 -0700 (PDT)
Date:   Mon, 15 Jun 2020 15:33:10 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <asarai@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        io-uring <io-uring@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [RFC] io_uring: add restrictions to support untrusted
 applications and guests
Message-ID: <20200615133310.qwdmnctrir5zgube@steredhat>
References: <20200609142406.upuwpfmgqjeji4lc@steredhat>
 <CAG48ez3kdNKjif==MbX36cKNYDpZwEPMZaJQ1rrpXZZjGZwbKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3kdNKjif==MbX36cKNYDpZwEPMZaJQ1rrpXZZjGZwbKw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 11:04:06AM +0200, Jann Horn wrote:
> +Kees, Christian, Sargun, Aleksa, kernel-hardening for their opinions
> on seccomp-related aspects
> 
> On Tue, Jun 9, 2020 at 4:24 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > Hi Jens,
> > Stefan and I have a proposal to share with io_uring community.
> > Before implementing it we would like to discuss it to receive feedbacks and
> > to see if it could be accepted:
> >
> > Adding restrictions to io_uring
> > =====================================
> > The io_uring API provides submission and completion queues for performing
> > asynchronous I/O operations. The queues are located in memory that is
> > accessible to both the host userspace application and the kernel, making it
> > possible to monitor for activity through polling instead of system calls. This
> > design offers good performance and this makes exposing io_uring to guests an
> > attractive idea for improving I/O performance in virtualization.
> [...]
> > Restrictions
> > ------------
> > This document proposes io_uring API changes that safely allow untrusted
> > applications or guests to use io_uring. io_uring's existing security model is
> > that of kernel system call handler code. It is designed to reject invalid
> > inputs from host userspace applications. Supporting guests as io_uring API
> > clients adds a new trust domain with access to even fewer resources than host
> > userspace applications.
> >
> > Guests do not have direct access to host userspace application file descriptors
> > or memory. The host userspace application, a Virtual Machine Monitor (VMM) such
> > as QEMU, grants access to a subset of its file descriptors and memory. The
> > allowed file descriptors are typically the disk image files belonging to the
> > guest. The memory is typically the virtual machine's RAM that the VMM has
> > allocated on behalf of the guest.
> >
> > The following extensions to the io_uring API allow the host application to
> > grant access to some of its file descriptors.
> >
> > These extensions are designed to be applicable to other use cases besides
> > untrusted guests and are not virtualization-specific. For example, the
> > restrictions can be used to allow only a subset of sqe operations available to
> > an application similar to seccomp syscall whitelisting.
> >
> > An address translation and memory restriction mechanism would also be
> > necessary, but we can discuss this later.
> >
> > The IOURING_REGISTER_RESTRICTIONS opcode
> > ----------------------------------------
> > The new io_uring_register(2) IOURING_REGISTER_RESTRICTIONS opcode permanently
> > installs a feature whitelist on an io_ring_ctx. The io_ring_ctx can then be
> > passed to untrusted code with the knowledge that only operations present in the
> > whitelist can be executed.
> 
> This approach of first creating a normal io_uring instance and then
> installing restrictions separately in a second syscall means that it
> won't be possible to use seccomp to restrict newly created io_uring
> instances; code that should be subject to seccomp restrictions and
> uring restrictions would only be able to use preexisting io_uring
> instances that have already been configured by trusted code.
> 
> So I think that from the seccomp perspective, it might be preferable
> to set up these restrictions in the io_uring_setup() syscall. It might
> also be a bit nicer from a code cleanliness perspective, since you
> won't have to worry about concurrently changing restrictions.
> 

Thank you for these details!

It seems feasible to include the restrictions during io_uring_setup().

The only doubt concerns the possibility of allowing the trusted code to
do some operations, before passing queues to the untrusted code, for
example registering file descriptors, buffers, eventfds, etc.

To avoid this, I should include these operations in io_uring_setup(),
adding some code that I wanted to avoid by reusing io_uring_register().

If I add restrictions in io_uring_setup() and then add an operation to
go into safe mode (e.g. a flag in io_uring_enter()), we would have the same
problem, right?

Just to be clear, I mean something like this:

    /* params will include restrictions */
    fd = io_uring_setup(entries, params);

    /* trusted code */
    io_uring_register_files(fd, ...);
    io_uring_register_buffers(fd, ...);
    io_uring_register_eventfd(fd, ...);

    /* enable safe mode */
    io_uring_enter(fd, ..., IORING_ENTER_ENABLE_RESTRICTIONS);


Anyway, including a list of things to register in the 'params', passed
to io_uring_setup(), should be feasible, if Jens agree :-)

Thanks,
Stefano

