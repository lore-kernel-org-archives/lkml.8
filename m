Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C9BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 19:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 767D82076C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 19:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CCtjUjay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgHZTkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 15:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgHZTk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 15:40:28 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5E0C061757
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 12:40:27 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 67so1598407pgd.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 12:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OG8uhnCA9kG3csdFryFQgnoVrLmqM/Aisjk2iXjlTO4=;
        b=CCtjUjayr/qntPIykQMCTBeZZeCK50TmOXnltMMVDBp3CR9A65E334WHfJcIaB+qj5
         lM0Ab5TQ23N8QqsdlltlQODO+OGXq6MmQcJBd+tA7A5w2hgKBd/HXsYX/JCZnPLsvU76
         Fc4t/yR7DlFMji9jHEtdubrTqLh5q1Ob78A9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OG8uhnCA9kG3csdFryFQgnoVrLmqM/Aisjk2iXjlTO4=;
        b=q4vLw1SeFFhPfD0MiGtLswPMuwi7+G2vHQZWbMlPvPxBEeNkD6Sg8Uzrn/G8vKfadL
         jTr9qHmnIV3ogcQmo/GJt1oi5RYXlKG4u4+cGe1a2kQ0x+Hh2yEe2z2AW4Lc0WsVQOB8
         xh+GJYeJnk2vpayfFEyKfo9122S3n5AuZ7m/tAcwK76xIKNU6sVB8HxMQbWtnR8a84cC
         USHSSmeRnAR8LjtflT2L98szY8Hj6sTOC2JcjQD/5y7NAelgisB6AZF0L/MpBpYEHleg
         CNtZ1mO5mvhLdUcPcu3FfgibyGuUyVtkumi1U+ejyQ53uUE/samD3KpkmTKmkhrjiTRw
         DB+w==
X-Gm-Message-State: AOAM5309SUEuN/+i5WCzuDgtf4nGTC8ZX6hFLQZIXa49XuC8OrbG5nim
        Bz9iO1uDxs68XRQc+s6mxlBUuQ==
X-Google-Smtp-Source: ABdhPJwoFPtYUC9LMuzuxI/JkcSQzWHlHT55l/323/HECz8Y1hZ6XBGrFMmE05TvFRpD7eDwLUE2Aw==
X-Received: by 2002:a63:516:: with SMTP id 22mr12143709pgf.316.1598470827209;
        Wed, 26 Aug 2020 12:40:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e16sm3774598pfd.17.2020.08.26.12.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 12:40:26 -0700 (PDT)
Date:   Wed, 26 Aug 2020 12:40:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stefano Garzarella <sgarzare@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
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
Message-ID: <202008261237.904C1E6@keescook>
References: <20200813153254.93731-1-sgarzare@redhat.com>
 <CAGxU2F55zzMzc043P88TWJNr2poUTVwrRmu86qyh0uM-8gimng@mail.gmail.com>
 <82061082-42c8-1e1c-1f36-6f42e7dd10cb@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82061082-42c8-1e1c-1f36-6f42e7dd10cb@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 10:47:36AM -0600, Jens Axboe wrote:
> On 8/25/20 9:20 AM, Stefano Garzarella wrote:
> > Hi Jens,
> > this is a gentle ping.
> > 
> > I'll respin, using memdup_user() for restriction registration.
> > I'd like to get some feedback to see if I should change anything else.
> > 
> > Do you think it's in good shape?
> 
> As far as I'm concerned, this is fine. But I want to make sure that Kees
> is happy with it, as he's the one that's been making noise on this front.

Oop! Sorry, I didn't realize this was blocked on me. Once I saw how
orthogonal io_uring was to "regular" process trees, I figured this
series didn't need seccomp input. (I mean, I am still concerned about
attack surface reduction, but that seems like a hard problem given
io_uring's design -- it is, however, totally covered by the LSMs, so I'm
satisfied from that perspective.)

I'll go review... thanks for the poke. :)

-- 
Kees Cook
