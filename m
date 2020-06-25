Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A39C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 20:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A536520679
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 20:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KGopbzvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436549AbgFYUUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 16:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405161AbgFYUUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 16:20:22 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C600C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 13:20:22 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ev7so3101378pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 13:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ug4I/46fw0495bLPFBA/k3xYDvMnBATxK4UfYwCoaoY=;
        b=KGopbzvm5BpYniSH2K0+paJmHpTp+pCLlRL8KoRzn74lKvNPdqLiCIa/PGQ7ZvurIF
         iPu0E5smqiq/bPrwskx3t0lZAGZarGOvEYpBClk7TWB0t/ufUVKdmc7zfehJfzcxAod8
         /p4rIKNUn5c0nOm5Ftrv04PMidmTCbxbsUiZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ug4I/46fw0495bLPFBA/k3xYDvMnBATxK4UfYwCoaoY=;
        b=pNlVW4UEMSbjujVZTx8QJDGiuzD+UUoT1fO38hXAX2oj8bxVa0nZ5PNURZtnAPJm6s
         Hn++6R/0nIhX1ZHpNKIO9xIBcU/0BMJ0W/zZxmgTzoN2k3n5Dc3SgrjhjVMyPmIBT4Ye
         KtRctl4jNljRiuwbnVq1EU3+nnxvm1jMiI80fUoW0nvDqTZJHsmXMLDCTkz+TN8acK5a
         mkX67o/SLbACuCyb7brEFJauDOXLM9pckB7wm9nDpCy4XcfFGN+Wcj3QTSYGPpd6Cawk
         t3J7AmF+JbtnggIDVBZn0J82l5muHzZFl6ZEzTC8hCqV/ngZEinYMTBRAbid7YEM5vmF
         6Ugg==
X-Gm-Message-State: AOAM530NmNNeTcyYqCIxeDJnc2BC/7OiPHCsQABYmxvTGTSk0Yi9/3wJ
        MRX07X6NfOrpxA1h/+3TUv1x/Q==
X-Google-Smtp-Source: ABdhPJzGnXSKcKv640pilStEymH+KEsxNzTGHCSzU+d99YhMWTpOoqRKyY5eD7zRrwkO1ebD4RVH4g==
X-Received: by 2002:a17:902:db83:: with SMTP id m3mr10332668pld.176.1593116422110;
        Thu, 25 Jun 2020 13:20:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f20sm3668653pfn.51.2020.06.25.13.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 13:20:21 -0700 (PDT)
Date:   Thu, 25 Jun 2020 13:20:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Ben Hutchings <ben@decadent.org.uk>
Cc:     Christian Kujau <lists@nerdbynature.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org,
        klibc@lists.zytor.com, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: process '/usr/bin/rsync' started with executable stack
Message-ID: <202006251253.2893D4F67@keescook>
References: <alpine.DEB.2.22.1.446.2006231023390.3892@trent.utfs.org>
 <20200624165148.GD31008@kadam>
 <202006241238.E9CB1CE85B@keescook>
 <20200625100429.GB2571@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625100429.GB2571@kadam>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 01:04:29PM +0300, Dan Carpenter wrote:
> On Wed, Jun 24, 2020 at 12:39:24PM -0700, Kees Cook wrote:
> > On Wed, Jun 24, 2020 at 07:51:48PM +0300, Dan Carpenter wrote:
> > > In Debian testing the initrd triggers the warning.
> > > 
> > > [   34.529809] process '/usr/bin/fstype' started with executable stack
> > 
> > Where does fstype come from there? I am going to guess it is either
> > busybox or linked against klibc?
> > 
> > klibc has known problems with executable stacks due to its trampoline
> > implementation:
> > https://wiki.ubuntu.com/SecurityTeam/Roadmap/ExecutableStacks
> 
> Yeah.  It comes from klibc-utils.

This is exactly what I was worried about back in Feb:
https://lore.kernel.org/lkml/202002251341.48BC06E@keescook/

This warning, combined with klibc-based initrds, makes the whole thing
pointless because it will always warn once on boot for the klibc stack,
and then not warn about anything else after that.

It looks like upstream klibc hasn't been touched in about 4 years, and
it's been up to Ben to keep it alive in Debian.

A couple ideas, in order of my preference:

1) stop using klibc-utils[1]. initramfs-tools-core is the only thing with a
   dependency on klibc-utils. Only a few things are missing from busybox.

2) make the warning rate-limited instead?

3) fix the use of trampolines in klibc

Thoughts?

-Kees


[1] Ben appears well aware of this idea, as he suggested it in 2018. :)
    https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=887159

-- 
Kees Cook
