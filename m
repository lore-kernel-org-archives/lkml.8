Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A159AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 05:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75A4D20734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 05:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PIgAxHYr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgFJF2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 01:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgFJF16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 01:27:58 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CA7C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 22:27:57 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u5so478971pgn.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 22:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YuvdGzIyUzej8b6gdTa5D7P2JhC6M3cmDi3clfShF/E=;
        b=PIgAxHYrxUvRr9+6B+Y6rNbCq5cYmCyrWJFoGVB5vsnqF1cxlaBH0TdQtEogAZhAkK
         0IZo+oyIm9PFRRK9u2lfat+U9IAqccCDhsh4QXM2Gz3Qz/v7cJ50lWwTlK+oRjnhtS65
         WPTyN5BUNxT9qFvRvz655OCTZSSLHH3QKWdPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YuvdGzIyUzej8b6gdTa5D7P2JhC6M3cmDi3clfShF/E=;
        b=fmZ4ksJIMXULCRayuV2YVIEph0Modp1M7xdLw1DJi/CgIBP2Rc3zdL0gncXC9sMg6C
         xNBgEz1/JXX9hOWfQ8P1tNvdG/TwRlfr63R8fozM4IN8naIJDBgxXY2rRwdg8nD75FGx
         csHwtnJ21EcgLGpTZHizAW6ZfBv3Bx7aGAomyE6JcqhkdAb024PGLpps4foINHqkKXth
         YkU2TAHbtMxzfpSkcV/FoYm07Oov76ZlljjW4Br3dX4Yyi+O7zebeUSEH8DgwCDajs4Q
         q/aV0eTQUvvnosmM9vixSrMXrTmfxA7WCDvy4FsV2w9aPYuwWYh+/72xgKs8Q4ycP9UQ
         4wiw==
X-Gm-Message-State: AOAM530iYIzMJENbvYyLLn39M2Yx7fmoywqHLfEexz6D2Z/jv5mATLOE
        wyr25pmkmnYwJutYOBACGXWqzA==
X-Google-Smtp-Source: ABdhPJxlpq2wABOjHadp4pv2ChXznPW+NT4TMS3Cp+fGD3SZI3IGpPc5oHKwOnJ2E6uX2YT9b+mkZA==
X-Received: by 2002:a62:1917:: with SMTP id 23mr1215614pfz.272.1591766876846;
        Tue, 09 Jun 2020 22:27:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x3sm11513892pfi.57.2020.06.09.22.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 22:27:55 -0700 (PDT)
Date:   Tue, 9 Jun 2020 22:27:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     containers@lists.linux-foundation.org,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Robert Sesek <rsesek@google.com>,
        Chris Palmer <palmer@google.com>, Jann Horn <jannh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Wagner <daniel.wagner@bmw-carit.de>,
        linux-kernel@vger.kernel.org, Matt Denton <mpdenton@google.com>,
        John Fastabend <john.r.fastabend@intel.com>,
        linux-fsdevel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, cgroups@vger.kernel.org,
        stable@vger.kernel.org, "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3 1/4] fs, net: Standardize on file_receive helper to
 move fds across processes
Message-ID: <202006092227.D2D0E1F8F@keescook>
References: <20200603011044.7972-1-sargun@sargun.me>
 <20200603011044.7972-2-sargun@sargun.me>
 <20200604012452.vh33nufblowuxfed@wittgenstein>
 <202006031845.F587F85A@keescook>
 <20200604125226.eztfrpvvuji7cbb2@wittgenstein>
 <20200605075435.GA3345@ircssh-2.c.rugged-nimbus-611.internal>
 <202006091235.930519F5B@keescook>
 <20200609200346.3fthqgfyw3bxat6l@wittgenstein>
 <202006091346.66B79E07@keescook>
 <037A305F-B3F8-4CFA-B9F8-CD4C9EF9090B@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <037A305F-B3F8-4CFA-B9F8-CD4C9EF9090B@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 11:27:30PM +0200, Christian Brauner wrote:
> On June 9, 2020 10:55:42 PM GMT+02:00, Kees Cook <keescook@chromium.org> wrote:
> >LOL. And while we were debating this, hch just went and cleaned stuff up:
> >
> >2618d530dd8b ("net/scm: cleanup scm_detach_fds")
> >
> >So, um, yeah, now my proposal is actually even closer to what we already
> >have there. We just add the replace_fd() logic to __scm_install_fd() and
> >we're done with it.
> 
> Cool, you have a link? :)

How about this:

https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=devel/seccomp/addfd/v3.1&id=bb94586b9e7cc88e915536c2e9fb991a97b62416

-- 
Kees Cook
