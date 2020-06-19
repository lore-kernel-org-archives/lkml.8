Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6918FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 462ED20C09
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ha9Efugf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388248AbgFSTxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387750AbgFSTxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:53:51 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D671C0613EE
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 12:53:50 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id h185so4871905pfg.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 12:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=anG95SJd4AOjTnI4MV3+T4SvuNW+x6NMVdWZoSy8e08=;
        b=ha9EfugfFqrYvP9ncS5JDX/+xka+I18knexTDvSEUg3ZZbryI7a/FLIh6rXbkvHOES
         h9ujOx/D0LNG/bvHVXHGHYuGvaBOEvr390y7KSfwiaD/IR/aV/nVT/jKrFqWjIHCUjyp
         pKx8tPOkcfw+AMC9k4Y1o7kg3qc1QC/Tvgvsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=anG95SJd4AOjTnI4MV3+T4SvuNW+x6NMVdWZoSy8e08=;
        b=IVYJcZ9TlEUcXkieYUJYVJ7I8RLIM8S+PYWheGZOizgxkkgpeY4Oe2l1uiwYF9c6VO
         TTnnWeMMqVY7woGAoXJkhpYTd8jDMN1RwkBpQq3G3CT17Qxd30usKJjQpT31hUUQiqA6
         CA+PZZ2mKEp7cb1AfgD1lDvEiivviBlbeQU1ltOTIsb6WN+1Ah/bL5Nc1YsRX7kcoegZ
         cWknYagkMa9z7gqVBuxrGL9MPrKiuzUNGbvKAQ2pt/OpYtzQlpnzxluKh2wP0f+9U8P5
         763D5tvIwZTX76wXGdcB/aWzCEdnpTwanJf2o/r12ekeMwuXNmAbCVbvB3GcZHRaTF0y
         OzAw==
X-Gm-Message-State: AOAM531MTpFBEM/fI77D7qQrtSNA65s91+1B81Q6A/oWOgxlBeH6mnTj
        gqd7sXeqDS9/f1ppf/Lbsq/Mpw==
X-Google-Smtp-Source: ABdhPJzHp+ulgh26iR+Xv3g/K0aOiw7U9M6bVmBEmxiFXk8mFx/tiNvkiTra7x6B5etHiCFnYsht0g==
X-Received: by 2002:a62:5c03:: with SMTP id q3mr9555744pfb.58.1592596428586;
        Fri, 19 Jun 2020 12:53:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h20sm6473821pfo.105.2020.06.19.12.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 12:53:47 -0700 (PDT)
Date:   Fri, 19 Jun 2020 12:53:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>, Will Drewry <wad@chromium.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] seccomp: Use -1 marker for end of mode 1 syscall list
Message-ID: <202006191253.B00874B22@keescook>
References: <202006191236.AC3E22AAB@keescook>
 <CALCETrXM5gneAC40RLWyjnCeHE6JFVOKnM0ooKLooGGaVV1KOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXM5gneAC40RLWyjnCeHE6JFVOKnM0ooKLooGGaVV1KOA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 12:42:14PM -0700, Andy Lutomirski wrote:
> On Fri, Jun 19, 2020 at 12:37 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > The terminator for the mode 1 syscalls list was a 0, but that could be
> > a valid syscall number (e.g. x86_64 __NR_read). By luck, __NR_read was
> > listed first and the loop construct would not test it, so there was no
> > bug. However, this is fragile. Replace the terminator with -1 instead,
> > and make the variable name for mode 1 syscall lists more descriptive.
> 
> Could the architecture instead supply the length of the list?

It could, but I didn't like the way the plumbing for that looked.

-- 
Kees Cook
