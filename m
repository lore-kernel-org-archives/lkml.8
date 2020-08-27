Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED97CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B815C22BEB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YCB/pEU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgH0HYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:24:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38614 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727115AbgH0HYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598513050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ri7f4MnEHGg+Eh3Xov6f6gkwDfi0Dd6vvMS8AIDLQKU=;
        b=YCB/pEU9HC71u0HFEKaE7mDZ3JDRBj/nk3+0p/EJchISNgeqQkzTtAoaeSKHvfRtaJCQSj
        lVby6HvILsJ3qNQWeiTfJfDyQ0RfW2/TK1FljMIcMevWzWEzpyOc9DPUNo35gqzShfGSJP
        G37O/F1rh5eHEl50SpcwagGgm6vSw6w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-8mnBavNZOli4Jirmifw8cw-1; Thu, 27 Aug 2020 03:24:09 -0400
X-MC-Unique: 8mnBavNZOli4Jirmifw8cw-1
Received: by mail-wr1-f72.google.com with SMTP id i6so1179973wrs.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 00:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ri7f4MnEHGg+Eh3Xov6f6gkwDfi0Dd6vvMS8AIDLQKU=;
        b=dET3TDjLgH0Y9aP6/tSV3UwdsCVMpwiVakE1JqLwmI+DFlmsl9sQVt7LH1a7zB26fT
         6MQBL9Glq7fakwyIO7Sy5MBi4uxEjCD6t9V+cnS1rc93RFJNAyR+1nUc90mgePOAY67R
         XAcEGtlrycXK5LW/eCmMyicv30tAxwWwkB/J+nfHkJGqJGX9uhg/E7vJzU+4LR/T1zmV
         ZwRRUa3/nc2+9FQqK/D6CIZGjJTHdrGqkuuQtw51/QcJz63oPds6fL3Z+/esMiApbT2x
         AOjT4XGrEh+yizhmG6Scv38sgmAwbNkdWzB0Ofn+WtduAwwhjH6cHsRJfmwF+Ycd1qAU
         UrqQ==
X-Gm-Message-State: AOAM532LBHnySI5y3PlEM10SUjYHbrEIXtGzCMKxwouZJq1UfySCP9kq
        yn5Labz/yj94qYxAenlzJdMwQeC57rTQpSKo589bi8ravAOofw3C1jKstAvKaENoD5NoPYmbNYI
        3hBifdfvxoH6QmmrOkMbD5SMt
X-Received: by 2002:a5d:4ecf:: with SMTP id s15mr19040992wrv.202.1598513047594;
        Thu, 27 Aug 2020 00:24:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9Qp8WqcCYQavb33blI2gxdMXFRgjEWEltO/ZyM+YWomBld9pX31Pz59UjLz4iXha0wYfDuw==
X-Received: by 2002:a5d:4ecf:: with SMTP id s15mr19040959wrv.202.1598513047320;
        Thu, 27 Aug 2020 00:24:07 -0700 (PDT)
Received: from steredhat.lan ([5.180.207.22])
        by smtp.gmail.com with ESMTPSA id t25sm3145541wmj.18.2020.08.27.00.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 00:24:06 -0700 (PDT)
Date:   Thu, 27 Aug 2020 09:24:01 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Kees Cook <keescook@chromium.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Jann Horn <jannh@google.com>, Jeff Moyer <jmoyer@redhat.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <asarai@suse.de>,
        io-uring <io-uring@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] io_uring: add restrictions to support untrusted
 applications and guests
Message-ID: <20200827072401.6o5bqg6r5iozpcgc@steredhat.lan>
References: <20200813153254.93731-1-sgarzare@redhat.com>
 <CAGxU2F55zzMzc043P88TWJNr2poUTVwrRmu86qyh0uM-8gimng@mail.gmail.com>
 <82061082-42c8-1e1c-1f36-6f42e7dd10cb@kernel.dk>
 <202008261237.904C1E6@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008261237.904C1E6@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 12:40:24PM -0700, Kees Cook wrote:
> On Wed, Aug 26, 2020 at 10:47:36AM -0600, Jens Axboe wrote:
> > On 8/25/20 9:20 AM, Stefano Garzarella wrote:
> > > Hi Jens,
> > > this is a gentle ping.
> > > 
> > > I'll respin, using memdup_user() for restriction registration.
> > > I'd like to get some feedback to see if I should change anything else.
> > > 
> > > Do you think it's in good shape?
> > 
> > As far as I'm concerned, this is fine. But I want to make sure that Kees
> > is happy with it, as he's the one that's been making noise on this front.
> 
> Oop! Sorry, I didn't realize this was blocked on me. Once I saw how
> orthogonal io_uring was to "regular" process trees, I figured this
> series didn't need seccomp input. (I mean, I am still concerned about
> attack surface reduction, but that seems like a hard problem given
> io_uring's design -- it is, however, totally covered by the LSMs, so I'm
> satisfied from that perspective.)
> 
> I'll go review... thanks for the poke. :)
> 

Jens, Kees, thanks for your feedbacks!
I'll send v5 adding the values to the enumerations.

Stefano

