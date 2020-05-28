Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C064EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 978E220776
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="dNV+oUPb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437446AbgE1XJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 19:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437333AbgE1XJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 19:09:01 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E167C08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 16:09:01 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id z80so637840qka.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 16:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2dnQmLcNwbQCSIJxeSwlgwxT1s89DA1/++ZPTT1pghI=;
        b=dNV+oUPbMYnX3ZVWLV7i45oA5InzscTd+GbDZvrGNuYf/NfzEFogrtiKH0tdUm0cxm
         LbQUylckxhhhOs8hrestvkZsG8sn1OmP4VJGq/clZ11NSLg5ObOKicUC2wzcC1ySEkY1
         UW2ORv4VqdAvZIdt3CwLn/kwDJ8BqfX+dQpc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2dnQmLcNwbQCSIJxeSwlgwxT1s89DA1/++ZPTT1pghI=;
        b=MgXHLine9WUMDjJolqXy3GQsecoF9oXw1PGgIIuMm8TlFkSVbIEiDw2SbBZ3TBf98u
         f9OLmcmMA2UM4m/Pcsx1Juy8IYs0AuoNlN67Obccof5LgIVAij5dnf88bTAB+BVHs1N0
         LSxEaWIEqUcfjVMS7Zj8ZevyRd03WqCK9k5CUAOnwIPBmuuz7vD52URgzt78QwHwhlVm
         6wfSn4avD42PpX/TnAm8e6EQO9wN0D0dFE129bvFVS/eEYUr6DFpDa18eZ51vYCXwy/1
         6xWVmYnFhTEYYbkX9BoBwSR+MIGLsj58u3cONic091YgVFuCf45JBC4rwWcPk6MI5rSt
         vbjA==
X-Gm-Message-State: AOAM531ioRIPF2tNOkad4CxJww2uMSN7+9Lav0auwUvDBDNnRPaC2QiR
        9V8+wa2BZDfZflkNT8n3JAcMtg==
X-Google-Smtp-Source: ABdhPJxChNjfy6WC1kuEUmZdOSOPxtRbz+ckOLFPKwUAzbVz3A1ubwgMbk7zbhsDz/iQ5QH/+LtbBQ==
X-Received: by 2002:a37:46c1:: with SMTP id t184mr5479963qka.192.1590707340169;
        Thu, 28 May 2020 16:09:00 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a1sm6383240qtj.65.2020.05.28.16.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 16:08:59 -0700 (PDT)
Date:   Thu, 28 May 2020 19:08:59 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        matthewb@google.com, Jesse Barnes <jsbarnes@google.com>,
        vapier@google.com, Christian Brauner <christian@brauner.io>,
        vpillai <vpillai@digitalocean.com>, vineethrp@gmail.com,
        Peter Zijlstra <peterz@infradead.org>,
        stable <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] sched/headers: Fix sched_setattr userspace compilation
 breakage
Message-ID: <20200528230859.GB225299@google.com>
References: <20200528135552.GA87103@google.com>
 <CAHk-=wjgtD6drydXP5h_r90v0sCSQe7BMk7AiYADhJ-x9HGgkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjgtD6drydXP5h_r90v0sCSQe7BMk7AiYADhJ-x9HGgkg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Thu, May 28, 2020 at 03:21:56PM -0700, Linus Torvalds wrote:
> On Thu, May 28, 2020 at 6:55 AM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> >
> > On a modern Linux distro, compiling the following program fails:
> >  #include<stdlib.h>
> >  #include<stdint.h>
> >  #include<pthread.h>
> >  #include<linux/sched/types.h>
> 
> You shouldn't include kernel headers in user space - that's the job of
> glibc and friends.

Ah, my bad. Sorry I read the docs now and looks like I got it all backwards.

> 
> > --- a/include/uapi/linux/sched/types.h
> > +++ b/include/uapi/linux/sched/types.h
> > @@ -4,9 +4,11 @@
> >
> >  #include <linux/types.h>
> >
> > +#if defined(__KERNEL__)
> >  struct sched_param {
> >         int sched_priority;
> >  };
> > +#endif
> 
> This makes no sense.
> 
> The point of a 'uapi' header is to export things to user space. Yes,
> they sometimes mix kernel-internal thngs in there (because of how they
> were created by just moving kernel headers to the uapi directory), but
> that ' struct sched_param' is very much part of the very interface
> definition that that file is all about exporting.
> 
> So no, this patch is fundamentally wrong. It negates the whole point
> of having a uapi header at all.

Sorry, I naively assumed that headers in 'include/uapi/' are safe to include
from userspace. I feel terrible.

> The glibc-provided "<sched.h>" should have been where you got all
> these declarations and #defines from, and the point of the uapi file
> was always to help glibc (and other library implementations) get them
> from the kernel.

The problem is <sched.h> still does not get us 'struct sched_attr' even
though the manpage of sched_setattr(2) says including <sched.h> is all that's
needed.

> 
> So why are you including kernel header files and mixing them with
> system-provided stuff?

The include of <sched.h> does not result in availability of the sched_attr
header.

Also, even if glibc included 'include/uapi/linux/sched/types.h' to get struct
sched_attr's definition, we would run into the same issue I reported right?
The 'struct sched_param' is already defined by glibc, and this header
redefines it.

Sorry that this patch is wrong, I'll try to fix it the right way. Thanks for
your help.

thanks,

 - Joel

