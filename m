Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5900C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB35E20828
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="SGsrGjLu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgCCO4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:56:42 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33684 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgCCO4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:56:41 -0500
Received: by mail-io1-f65.google.com with SMTP id r15so3920320iog.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 06:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fI36G/uNvKx+9em/Fb6KNNLc+Pcmg8HngIG58Zd5Bs0=;
        b=SGsrGjLuucyjNPy56WlED0A/hHbh6zFQXdmMsXJn+8s4bETmyO3nLcYzinbl/ngv+8
         IVKhqaOlqrRKDviqybo8oORit6u91nGx/5vVDjBs0/tD6eZgDmofo2eq8Bo2gGZcT1xY
         +t9xxU/5y3XRc3m0rgzn4quxb+9h/ryIW1vMz4ckmA4gVb/AdsO6VAHSNTNELSps/IVn
         SHCqqyzQvCyt6M671NE0lay/rsZnAO2e3mGPSqbcC1r2pnKg6zXQYNTsTP0+DeuSMd6P
         G0k1DIJGkebMvuotzhR3v44hLe+VY1RllkvovDIlo1F5B+yOi419w1Zb7TtZwYbOotlC
         8Ltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fI36G/uNvKx+9em/Fb6KNNLc+Pcmg8HngIG58Zd5Bs0=;
        b=bAlYhwsqy+n2ez6Q7uY4ee6tzF4TcwSKcEvID7ZJVKixsGrKN6AQK9Uuj5H70BLHHE
         IFNvhdEmIqGX9Ku6C6r9lyxixpmVPJeCWhOyrP9dYcRIQsbbIrEQptTvwILIO6zaB5K9
         4RezBFB4saKIEqb2P+i0EnqvOZBgVv/Tf+d4QKxeseO1Y9ZaXELcJ0EuGeDq9kqQ4w07
         7H4KWKtQt6AX4paKPsth+jIqOUbXzEjb100t1E1aCPll6SurMBk54eg4bPoh/JLYiHAl
         Ny6GcoRqWoG+B750f1+SAJQ4vDQNq2eNLT5M7047umAa5gFxxTFupYgYfssaG4mVgghO
         DRHw==
X-Gm-Message-State: ANhLgQ2WByHE7Jpyd/6jfx5AbdrdhA9qoqdbiNn+7kyzvibspbqjXJki
        9mbMkkd8GhK1EkHz9X41tZrT99Vuerg=
X-Google-Smtp-Source: ADFU+vtqpoVzbflFuQQFjuIuApY+svOKbk76HieyVxNhS2HKuBmLUM9p7YPXyY5XbYz+6BTrYQ2yoA==
X-Received: by 2002:a5e:c603:: with SMTP id f3mr4216930iok.250.1583247398211;
        Tue, 03 Mar 2020 06:56:38 -0800 (PST)
Received: from cisco ([2601:282:902:b340:5dcb:1549:835e:4d6d])
        by smtp.gmail.com with ESMTPSA id z63sm8001645ilk.44.2020.03.03.06.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 06:56:37 -0800 (PST)
Date:   Tue, 3 Mar 2020 07:56:35 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Matthew Denton <mpdenton@google.com>
Subject: Re: [PATCH] seccomp: allow TSYNC and USER_NOTIF together
Message-ID: <20200303145635.GC15783@cisco>
References: <20200206165027.18415-1-tycho@tycho.ws>
 <202003022137.9DAB55E6F0@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003022137.9DAB55E6F0@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 09:48:34PM -0800, Kees Cook wrote:
> On Thu, Feb 06, 2020 at 09:50:27AM -0700, Tycho Andersen wrote:
> > The restriction introduced in 7a0df7fbc145 ("seccomp: Make NEW_LISTENER and
> > TSYNC flags exclusive") is mostly artificial: there is enough information
> > in a seccomp user notification to tell which thread triggered a
> > notification. The reason it was introduced is because TSYNC makes the
> > syscall return a thread-id on failure, and NEW_LISTENER returns an fd, and
> > there's no way to distinguish between these two cases (well, I suppose the
> > caller could check all fds it has, then do the syscall, and if the return
> > value was an fd that already existed, then it must be a thread id, but
> > bleh).
> > 
> > Matthew would like to use these two flags together in the Chrome sandbox
> > which wants to use TSYNC for video drivers and NEW_LISTENER to proxy
> > syscalls.
> > 
> > So, let's fix this ugliness by adding another flag, NO_TID_ON_TSYNC_ERR,
> > which tells the kernel to just return -EAGAIN on a TSYNC error. This way,
> > NEW_LISTENER (and any subsequent seccomp() commands that want to return
> > positive values) don't conflict with each other.
> > 
> > Suggested-by: Matthew Denton <mpdenton@google.com>
> > Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> 
> Thanks for this! (And thanks for waiting on my review!) Yeah, this
> makes things much more sensible. If we get a third thing that wants
> to be returned, we'll have to rev the userspace struct API to have an
> "output" area. :P

Yeah :)

> Bike shedding below...
> 
> > ---
> >  include/linux/seccomp.h                       |  3 +-
> >  include/uapi/linux/seccomp.h                  |  1 +
> >  kernel/seccomp.c                              | 14 +++-
> >  tools/testing/selftests/seccomp/seccomp_bpf.c | 74 ++++++++++++++++++-
> >  4 files changed, 86 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
> > index 03583b6d1416..e0560a941ed1 100644
> > --- a/include/linux/seccomp.h
> > +++ b/include/linux/seccomp.h
> > @@ -7,7 +7,8 @@
> >  #define SECCOMP_FILTER_FLAG_MASK	(SECCOMP_FILTER_FLAG_TSYNC | \
> >  					 SECCOMP_FILTER_FLAG_LOG | \
> >  					 SECCOMP_FILTER_FLAG_SPEC_ALLOW | \
> > -					 SECCOMP_FILTER_FLAG_NEW_LISTENER)
> > +					 SECCOMP_FILTER_FLAG_NEW_LISTENER | \
> > +					 SECCOMP_FILTER_FLAG_NO_TID_ON_TSYNC_ERR)
> >  
> >  #ifdef CONFIG_SECCOMP
> >  
> > diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
> > index be84d87f1f46..64678cc20e18 100644
> > --- a/include/uapi/linux/seccomp.h
> > +++ b/include/uapi/linux/seccomp.h
> > @@ -22,6 +22,7 @@
> >  #define SECCOMP_FILTER_FLAG_LOG			(1UL << 1)
> >  #define SECCOMP_FILTER_FLAG_SPEC_ALLOW		(1UL << 2)
> >  #define SECCOMP_FILTER_FLAG_NEW_LISTENER	(1UL << 3)
> > +#define SECCOMP_FILTER_FLAG_NO_TID_ON_TSYNC_ERR	(1UL << 4)
> 
> Bikeshed: what do you think about calling this
> 
> SECCOMP_FILTER_FLAG_TSYNC_ESRCH
> 
> to mean "I don't care _which_ thread, just fail" (See below about the
> ESRCH bit...)

Will do.

> >  
> >  /*
> >   * All BPF programs must return a 32-bit value.
> > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > index b6ea3dcb57bf..fa01ec085d60 100644
> > --- a/kernel/seccomp.c
> > +++ b/kernel/seccomp.c
> > @@ -528,8 +528,12 @@ static long seccomp_attach_filter(unsigned int flags,
> >  		int ret;
> >  
> >  		ret = seccomp_can_sync_threads();
> > -		if (ret)
> > -			return ret;
> > +		if (ret) {
> > +			if (flags & SECCOMP_FILTER_FLAG_NO_TID_ON_TSYNC_ERR)
> > +				return -EAGAIN;
> 
> Hm hm, I think EAGAIN is wrong here: this isn't likely to be a transient
> failure (unless the offending thread dies). The two ways TSYNC can fail
> are if a thread has seccomp mode 1 set, or if the thread's filter
> ancestry has already diverged. Trying again isn't really going to help
> (which is why the original motivation was to return thread details to
> help debug why TSYNC failed).
> 
> In the case where the thread id can't be found (container visibility??),
> we fail with -ESRCH. That might be more sensible than -EAGAIN here. (Or
> maybe -EBUSY?)

-ESRCH seems good, I'll resend with that.

Cheers,

Tycho
