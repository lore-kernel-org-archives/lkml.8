Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C936C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E041720759
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f1Zw2us9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390181AbgF2VCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731176AbgF2TMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:50 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98232C03079A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:32:57 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id i4so8182942pjd.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4t61qDcD9t0KKwIOWrgMLHqw6luF403ud9+USbhr5Do=;
        b=f1Zw2us9o49Eu71aJrlGHo04ZRY7QZzbRup9cDhXPrdys5NCbtrwwZ9pEbrgIAcFDV
         eM2fom5cdkPTZmiR9/3k2DDYeAe7mz0pGBRrmu9J1eZQ5+pU8OQPFma2kxCA8YoEYT6/
         QNTls6pHGfC4NzMoKRE9KfVtOP3HYkGtLvqY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4t61qDcD9t0KKwIOWrgMLHqw6luF403ud9+USbhr5Do=;
        b=cVE18yf2oqtJPIMSy7Rnbp1GGyPNS3APSZN9CCSxlCNlyiAZ5B/L/Z9IQhbC9KKTDb
         YvlFhG5+QfZCxZydmMftihq7O4X0xaOlNKn8RsoPMzw1EFZ4EYh1N+E0pNWjdt88B/0n
         47Dm31snvufPyml9kCnGoRpZbZ3gnderpZTj3hdtX2oNoX/Y8Xq2d+o0HnaWE3Hr+C02
         hYnysXjWIKXIde0KLItaJNN7CXGa1cC+PJM3W1uV1/ELLlJuvnIjqI1FVyK8ABjt+Sn1
         3bQlrjzBy8VFJdNLqADTvNcf1fUTNzoLGSp05SfqCkinbivh2edlbbAkfklo4iIFJHDM
         0wZQ==
X-Gm-Message-State: AOAM530WrrvPydG49qZvpsR7S9m8WBES/cLapxqhNsXyOoeooPyCtIjZ
        LGg/cDJuyztZD1oQvX4b5CKRjg==
X-Google-Smtp-Source: ABdhPJzcj9ClCuDDBM/Zy5UtPW75kM74Sk8AWoUEmrvlZaKFndJT7HdEDX9CcTWtQPZhETha0qm7rw==
X-Received: by 2002:a17:90a:2a04:: with SMTP id i4mr17890051pjd.91.1593444777172;
        Mon, 29 Jun 2020 08:32:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n189sm122007pfn.108.2020.06.29.08.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 08:32:56 -0700 (PDT)
Date:   Mon, 29 Jun 2020 08:32:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Martin Steigerwald <martin@lichtvoll.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: Re: [REGRESSION] 5.8-rc3: seccomp crash with Chromium, QtWebEngine
 and related browsers: seccomp-bpf failure in syscall 0072
Message-ID: <202006290831.E9E695450@keescook>
References: <2293324.KF7j4Pszzj@merkaba>
 <202006290739.8AB49B15@keescook>
 <20200629150807.GB3183@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629150807.GB3183@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 04:08:07PM +0100, Mel Gorman wrote:
> On Mon, Jun 29, 2020 at 07:41:56AM -0700, Kees Cook wrote:
> > On Mon, Jun 29, 2020 at 11:08:10AM +0200, Martin Steigerwald wrote:
> > > Dear Andy, Kees, Will, dear kernel community,
> > > 
> > > With 5.8-rc3 there is a seccomp related crash which prevents Chromium and
> > > QtWebEngine from starting:
> > > 
> > > Bug 208369 - seccomp crash with Chromium, QtWebEngine and related browsers: seccomp-bpf failure in syscall 0072
> > > 
> > > https://bugzilla.kernel.org/show_bug.cgi?id=208369
> > > 
> > > Reverting to 5.8-rc2 fixes the issue.
> > 
> > Hi,
> > 
> > It looks like this is from e9c15badbb7b ("fs: Do not check if there is a
> > fsnotify watcher on pseudo inodes")
> > 
> > Currently being discussed here:
> > https://lore.kernel.org/lkml/7b4aa1e985007c6d582fffe5e8435f8153e28e0f.camel@redhat.com/#r
> > 
> 
> It's a definite problem. I've sent a revert but it hasn't hit lkml yet
> for whatever reason.

Okay, thanks! (Yeah, I think vger might be stuck?)

-- 
Kees Cook
