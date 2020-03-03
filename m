Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67059C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 21:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3851820848
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 21:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vr9laNZh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732443AbgCCVLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 16:11:16 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:53629 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732393AbgCCVLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 16:11:15 -0500
Received: by mail-pj1-f66.google.com with SMTP id cx7so1908194pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 13:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=r6q0DPuFy1mAtJuSAiMz7w4srajxqnfipEX7Gy6ZAFQ=;
        b=Vr9laNZhX8SMnV0houi9WlY1wvzPQx9E7i4R/qO9l+MfwRn603HnTOXB/j0g/TT2p5
         KPVX/menTdQ08/g/8Ng4n5AJmF1mT50yjWbl3AnXYb/EvA66oCq2TlTBDVbQXpkdlTCJ
         ie8OseG56iFZm0MxeiW91FXSxC2t5pvfgUosQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=r6q0DPuFy1mAtJuSAiMz7w4srajxqnfipEX7Gy6ZAFQ=;
        b=hBeqnDHbfRUgSLn8l9IkCl6KGYbdg1C70PJXj+iNcz0+eUSwNY39gHn9H1gHDyOIkk
         t3jTAVVE2uYkT9y7VnGDGj66sKnSD3rj2RwPakX3VdBXpt1lFrXh+RWVjQ8mtKr13IXa
         5xeiKRTD99h7HJv5pAol1pGOOMIDVxUu9nOj4pTjlKXT7PSDGowEO4gkdcgXOdXX6/ws
         hTL5hGQCcq/bbagR1Kw0ug9uVyr/QA10NyAs0bTmQwKWQErGzK7nEr9zJbhElwJuZSnC
         B6T9t5iUB5uGCRl1S2X73/kpnMyqWFGIwLyb/0HxEe5Uvb/UlaJN2O8+6xyXC1+hqqeP
         nYaQ==
X-Gm-Message-State: ANhLgQ2jp7lo3nkIycT4EJ5REZRqlVbxXZrxem3rTd3gNE4ll0KfZho+
        PQ2MH0JRN89dFQ+ERcCs5VfY7w==
X-Google-Smtp-Source: ADFU+vt+JB3T6f7Z3SScsrYCpiEa675gWMHdof0twNnrB39g3RtC8mXdZDZvl/oosIAGandDnKIPRg==
X-Received: by 2002:a17:902:9b8a:: with SMTP id y10mr5723381plp.114.1583269874614;
        Tue, 03 Mar 2020 13:11:14 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d22sm134532pja.14.2020.03.03.13.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 13:11:13 -0800 (PST)
Date:   Tue, 3 Mar 2020 13:11:12 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alexander Potapenko <glider@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fcntl: Distribute switch variables for initialization
Message-ID: <202003031310.40AF706A8@keescook>
References: <20200220062243.68809-1-keescook@chromium.org>
 <202003022040.40A32072@keescook>
 <e06d74ad7dc02fb3df9ab4ae26203a85ea2ed67e.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e06d74ad7dc02fb3df9ab4ae26203a85ea2ed67e.camel@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 10:55:22AM -0500, Jeff Layton wrote:
> On Mon, 2020-03-02 at 20:41 -0800, Kees Cook wrote:
> > On Wed, Feb 19, 2020 at 10:22:43PM -0800, Kees Cook wrote:
> > > Variables declared in a switch statement before any case statements
> > > cannot be automatically initialized with compiler instrumentation (as
> > > they are not part of any execution flow). With GCC's proposed automatic
> > > stack variable initialization feature, this triggers a warning (and they
> > > don't get initialized). Clang's automatic stack variable initialization
> > > (via CONFIG_INIT_STACK_ALL=y) doesn't throw a warning, but it also
> > > doesn't initialize such variables[1]. Note that these warnings (or silent
> > > skipping) happen before the dead-store elimination optimization phase,
> > > so even when the automatic initializations are later elided in favor of
> > > direct initializations, the warnings remain.
> > > 
> > > To avoid these problems, move such variables into the "case" where
> > > they're used or lift them up into the main function body.
> > > 
> > > fs/fcntl.c: In function ‘send_sigio_to_task’:
> > > fs/fcntl.c:738:20: warning: statement will never be executed [-Wswitch-unreachable]
> > >   738 |   kernel_siginfo_t si;
> > >       |                    ^~
> > > 
> > > [1] https://bugs.llvm.org/show_bug.cgi?id=44916
> > > 
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > 
> > Ping. Can someone pick this up, please?
> > 
> > Thanks!
> > 
> > -Kees
> > 
> > > ---
> > >  fs/fcntl.c |    6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/fcntl.c b/fs/fcntl.c
> > > index 9bc167562ee8..2e4c0fa2074b 100644
> > > --- a/fs/fcntl.c
> > > +++ b/fs/fcntl.c
> > > @@ -735,8 +735,9 @@ static void send_sigio_to_task(struct task_struct *p,
> > >  		return;
> > >  
> > >  	switch (signum) {
> > > -		kernel_siginfo_t si;
> > > -		default:
> > > +		default: {
> > > +			kernel_siginfo_t si;
> > > +
> > >  			/* Queue a rt signal with the appropriate fd as its
> > >  			   value.  We use SI_SIGIO as the source, not 
> > >  			   SI_KERNEL, since kernel signals always get 
> > > @@ -769,6 +770,7 @@ static void send_sigio_to_task(struct task_struct *p,
> > >  			si.si_fd    = fd;
> > >  			if (!do_send_sig_info(signum, &si, p, type))
> > >  				break;
> > > +		}
> > >  		/* fall-through - fall back on the old plain SIGIO signal */
> > >  		case 0:
> > >  			do_send_sig_info(SIGIO, SEND_SIG_PRIV, p, type);
> > > 
> 
> Sure, looks straightforward enough. I'll pick it up for v5.7.

Awesome; thank you!

-Kees

> 
> Thanks,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

-- 
Kees Cook
