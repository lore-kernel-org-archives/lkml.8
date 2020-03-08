Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B70C10F28
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 06:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0726E20838
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 06:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583650386;
	bh=hBDQFgPtphwwSawhrbt7C7AkzAT18PpDYg22vxfvIAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dLc1iBbi1hIXH5PRfIiRmnKq5yGzDrLyW4kcuUzFwyp35bXel4SbI529Pr98clBEt
	 jcEBrbV9fzj3RYCPfsYwq9LOKsLR2GM0InTPwO1Wp3w2IVbHzK2UMZsjf/IVk9Ji2E
	 lc+rL0Et5+eFhW2q8BiTDkDTijIhQoZR47Su01kQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgCHGxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 01:53:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:60166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbgCHGxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 01:53:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CC8920828;
        Sun,  8 Mar 2020 06:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583650382;
        bh=hBDQFgPtphwwSawhrbt7C7AkzAT18PpDYg22vxfvIAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pJ7Ma/y7bJJ6Y2DrIql2rks56aF+JKzf7WAiUVdvSNlbJm1GniWdEuxlCuqixFiXN
         fi56OmdZPmgXmU3LZEbHfIESZx3JwbLBHHAMf4zx1tX13CwUTm3roMX5qKnxcRAmeh
         /i6rcWPH0nKZXSEOQsYpujnVKrXQkOwRz/sD0lLE=
Date:   Sun, 8 Mar 2020 07:52:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v2] Add kernel config option for fuzz testing.
Message-ID: <20200308065258.GE3983392@kroah.com>
References: <20200307135822.3894-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <6f2e27de-c820-7de3-447d-cd9f7c650add@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f2e27de-c820-7de3-447d-cd9f7c650add@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 07, 2020 at 05:28:22PM +0100, Jiri Slaby wrote:
> On 07. 03. 20, 14:58, Tetsuo Handa wrote:
> > While syzkaller is finding many bugs, sometimes syzkaller examines
> > stupid operations. Currently we prevent syzkaller from examining
> > stupid operations by blacklisting syscall arguments and/or disabling
> > whole functionality using existing kernel config options, but it is
> > a whack-a-mole approach. We need cooperation from kernel side [1].
> > 
> > This patch introduces a kernel config option which allows disabling
> > only specific operations. This kernel config option should be enabled
> > only when building kernels for fuzz testing.
> > 
> > We discussed possibility of disabling specific operations at run-time
> > using some lockdown mechanism [2], but conclusion seems that build-time
> > control (i.e. kernel config option) fits better for this purpose.
> > Since patches for users of this kernel config option will want a lot of
> > explanation [3], this patch provides only kernel config option for them.
> > 
> > [1] https://github.com/google/syzkaller/issues/1622
> > [2] https://lkml.kernel.org/r/CACdnJutc7OQeoor6WLTh8as10da_CN=crs79v3Fp0mJTaO=+yw@mail.gmail.com
> > [3] https://lkml.kernel.org/r/20191216163155.GB2258618@kroah.com
> > 
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Cc: Dmitry Vyukov <dvyukov@google.com>
> > ---
> >  lib/Kconfig.debug | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > Changes since v1:
> >   Drop users of this kernel config option.
> >   Update patch description.
> > 
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 53e786e0a604..e360090e24c5 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2208,4 +2208,14 @@ config HYPERV_TESTING
> >  
> >  endmenu # "Kernel Testing and Coverage"
> >  
> > +config KERNEL_BUILT_FOR_FUZZ_TESTING
> > +       bool "Build kernel for fuzz testing"
> 
> If we really want to go this way, I wouldn't limit it for fuzz testing
> only. Static analyzers, symbolic executors, formal verifiers, etc. --
> all of them should avoid the paths.

No, anything that just evaluates the code should be fine, we want static
analyzers to be processing those code paths.  Just not to run them as
root on a live system.

thanks,

greg k-h
