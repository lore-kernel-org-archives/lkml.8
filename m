Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E8DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C67E1207CB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OuQ4zejb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgE1B75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 21:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgE1B74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 21:59:56 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569A9C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 18:59:56 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t7so10882907plr.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 18:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=skRmpQrx0Bu6pplBqt5P6Q0/9YqagFaf+WzRCjLT0y0=;
        b=OuQ4zejbp8XFw2QDETmgayWcc8as7wGuNp0zKX2AIdjNb4qpj+aKBKzGTbcWg3zN5I
         EifZ9h8IFq1+tZrVgdMnK7aw5/bdYNQaTrJ0mHUqqM7gsBVvOxkhz5Gy4LXCxLyebGil
         btX9EThQ17zSTo/cSGIHarxM+H8ccMHkt7Gi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=skRmpQrx0Bu6pplBqt5P6Q0/9YqagFaf+WzRCjLT0y0=;
        b=Hz3ZnTyasDUNYe4MRQxlo5VMk8GJJAb1VYd43iaYwJhmL+Nu/P9JIjx/BXgaon0gYx
         FJq4IX8T+TdEGUNy6Vob4eIr+Tup+EaE/UhU4nIcgAH/7RZnMJ/1H0hyPcD4/ldirWkL
         0VXi7j8v2MIryDPVjdcbqXRM1bvYnjCRB1Qv5pWOVwiEf1JGeHm+j/7vj0wOLCOfez5U
         +WZ4cT/YL1G7eo+J1t/6lJaqqVZRPNxQi/es7/ecOaXT7DBjJqxkTRFPs2AMXz3AKY69
         qCCoaWS6s2DX5GdH7XnpW08ujla3d6iq0i8UXqMdJyPA16c4ztb7JLIid2NDh5q/zua+
         vRog==
X-Gm-Message-State: AOAM532yXGd70TPrXBnjA7XcDO9FPgOsViUKA0EOLpU6qfSU7FcRCq8b
        TrtGEx2JdHKMSF6mjuWCQP8QVA==
X-Google-Smtp-Source: ABdhPJzaBGk3LrPQfPJmtMlBm+/AztujZVXj0LaZRmROarIyW/K1jgXC/5bJTmj3s6JcrNWxkQVurA==
X-Received: by 2002:a17:902:d883:: with SMTP id b3mr1208810plz.133.1590631195854;
        Wed, 27 May 2020 18:59:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s9sm2961756pgo.22.2020.05.27.18.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 18:59:55 -0700 (PDT)
Date:   Wed, 27 May 2020 18:59:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Robert Sesek <rsesek@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH 1/2] seccomp: notify user trap about unused filter
Message-ID: <202005271851.B7FBA02F@keescook>
References: <20200527111902.163213-1-christian.brauner@ubuntu.com>
 <202005271408.58F806514@keescook>
 <20200527220532.jplypougn3qzwrms@wittgenstein>
 <202005271537.75548B6@keescook>
 <20200527224501.jddwcmvtvjtjsmsx@wittgenstein>
 <20200527231646.4v743erjpzh6qe5f@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527231646.4v743erjpzh6qe5f@wittgenstein>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 01:16:46AM +0200, Christian Brauner wrote:
> I'm also starting to think this isn't even possible or currently doable
> safely.
> The fdtable in the kernel would end up with a dangling pointer, I would
> think. Unless you backtrack all fds that still have a reference into the
> fdtable and refer to that file and close them all in the kernel which I
> don't think is possible and also sounds very dodgy. This also really
> seems like we would be breaking a major contract, namely that fds stay
> valid until userspace calls close, execve(), or exits.

Right, I think I was just using the wrong words? I was looking at it
like a pipe, or a socket, where you still have an fd, but reads return
0, you might get SIGPIPE, etc. The VFS clearly knows what a
"disconnected" fd is, and I had assumed there was general logic for it
to indicate "I'm not here any more".

I recently did something very similar to the pstore filesystem, but I got
to cheat with some massive subsystem locks. In that case I needed to clear
all the inodes out of the tmpfs, so I unlink them all and manage the data
lifetimes pointing back into the (waiting to be unloaded) backend module
by NULLing the pointer back, which is safe because of the how the locking
there happens to work. Any open readers, when they close, will have the
last ref count dropped, at which point the record itself is released too.

Back to the seccomp subject: should "all tasks died" be distinguishable
from "I can't find that notification" in the ioctl()? (i.e. is ENOENT
sufficient, or does there need to be an EIO or ESRCH there?)

-- 
Kees Cook
