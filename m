Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70295C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FB0520786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jCAO6CFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgH0HMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:12:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47499 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726882AbgH0HMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598512355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JL0Nic4lUYEvTQAyILRqVFTBlq5K5PuaRWhSncRHSwg=;
        b=jCAO6CFiJ9r6N/6UpmAGenQWzEPJIHktVq1NqHm2KN58QA3uTsDaFBuus38oJ3tDapI1IC
        7wlAuPnRJmNB2qpIqoYQuaEN6W1diKZzGCWrNY5L5bjzveisDExKyUcDVsCZPcvzGSL6rT
        P1fubMEUWWDu5swIjr1Z4fzsNZh1WXc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-F_7j9Gl-NeKDSTdDslVWvQ-1; Thu, 27 Aug 2020 03:12:33 -0400
X-MC-Unique: F_7j9Gl-NeKDSTdDslVWvQ-1
Received: by mail-wr1-f69.google.com with SMTP id f14so1147966wrm.22
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 00:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JL0Nic4lUYEvTQAyILRqVFTBlq5K5PuaRWhSncRHSwg=;
        b=bMn1Xg/luKJQZfnOdMt00qj0dugmmtEgkbjyo/BQjJcSakOM+HkvW5dz6kJVFuo7sn
         ge+Adz8WSj49wnlRiEujiMNIMe3KAX9g7E8nSf1hxXyWy8d112ewytuPvHe6pd23JQBq
         GTIdKKbAlpIyxINNRTDCP8yrbTMGoF6gpBgcUkANrqs8Y4pf/NkCbLxxss8sViLiRxxK
         oZePj51cDaYq33x3K5wnfWEJeo1bZXluVrR+lYiB/IUG/PoobS0MEil+ZZF4yG+u/FfB
         1R8HNJgO2aMFiOPsumgTljVOAskr0iGp3SQjgCHMYYEPyr70BQQ9lJ8+QdTGYwGxxupZ
         V6sg==
X-Gm-Message-State: AOAM530CwE1ncItvprqrfiNLMDaS9FRbn3BeuHvrUMv0E8w7gSxtxaxM
        h0+l+4sErfbF6H2ZVldaof0bjLUCUbwYxxZGnFMET544KYKUOcH91wtNi9C1LJMOFT4CkCBroAv
        FxauPU5P056b6R2MbrsPWhiCR
X-Received: by 2002:a5d:650b:: with SMTP id x11mr305696wru.46.1598512352239;
        Thu, 27 Aug 2020 00:12:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUHzxCz2Spgqmv60oYq58isMCoWeEsBIsG0b8y0nTVMsLWHJ63NS9EGPcX3VzzE1QFXWCdbg==
X-Received: by 2002:a5d:650b:: with SMTP id x11mr305672wru.46.1598512351999;
        Thu, 27 Aug 2020 00:12:31 -0700 (PDT)
Received: from steredhat.lan ([5.180.207.22])
        by smtp.gmail.com with ESMTPSA id h11sm3694657wrb.68.2020.08.27.00.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 00:12:31 -0700 (PDT)
Date:   Thu, 27 Aug 2020 09:12:27 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jann Horn <jannh@google.com>, Jeff Moyer <jmoyer@redhat.com>,
        linux-fsdevel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <asarai@suse.de>,
        io-uring@vger.kernel.org
Subject: Re: [PATCH v4 2/3] io_uring: add IOURING_REGISTER_RESTRICTIONS opcode
Message-ID: <20200827071227.tozlhvidn3iet6xy@steredhat.lan>
References: <20200813153254.93731-1-sgarzare@redhat.com>
 <20200813153254.93731-3-sgarzare@redhat.com>
 <202008261245.245E36654@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008261245.245E36654@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 12:46:24PM -0700, Kees Cook wrote:
> On Thu, Aug 13, 2020 at 05:32:53PM +0200, Stefano Garzarella wrote:
> > +/*
> > + * io_uring_restriction->opcode values
> > + */
> > +enum {
> > +	/* Allow an io_uring_register(2) opcode */
> > +	IORING_RESTRICTION_REGISTER_OP,
> > +
> > +	/* Allow an sqe opcode */
> > +	IORING_RESTRICTION_SQE_OP,
> > +
> > +	/* Allow sqe flags */
> > +	IORING_RESTRICTION_SQE_FLAGS_ALLOWED,
> > +
> > +	/* Require sqe flags (these flags must be set on each submission) */
> > +	IORING_RESTRICTION_SQE_FLAGS_REQUIRED,
> > +
> > +	IORING_RESTRICTION_LAST
> > +};
> 
> Same thought on enum literals, but otherwise, looks good:

Sure, I'll fix the enum in the next version.

> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks for the review,
Stefano

