Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EA6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 05:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67037208A7
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 05:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b+xhwSdO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgE2Fls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 01:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgE2Fls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 01:41:48 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20C4C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 22:41:47 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f21so833830pgg.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 22:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H/R94Eu/RNJtahNdn/v25EMpYZHnvSETPnW83BQF4hk=;
        b=b+xhwSdOs1ea1UPd5iO5kXTgR7LIJ/6VVvEbO3LSMEG6M6uLPgR52UNsTA5UmnGJLq
         WePyqktT/sjTXiN5FQUG8Jl/G6bGYgQEJ3tNzv92wHIk3CbtCCuyonCsjE2A01j3iY7c
         BeGyXPFVtRU3E0v6USHet6cLGTUwUsogQyqW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H/R94Eu/RNJtahNdn/v25EMpYZHnvSETPnW83BQF4hk=;
        b=KAxSqxCvm6D1r+ZvevfWdUAkOUukqU9yWcr5Mg9VFsKPys/DBgo7x/Ergj/nQ5enB/
         TmOrVra2XU5S1LCYt4AjSvt8KscEUWtxGU2ivSjQqeoYuK3LT/Uy8Axz8bGPlXZTt4CG
         v/klbkiDJWx41Roj4soVlvwoQE4H5Gjbw5ry1pJs2CRdjJgoSDByIZcVjcNX4bN1c2Jo
         fzYJZA9WWwqqyPiyPdTua5Ta+jAAeyyOmNCihbcxsBaSSYG/bOTsckJhLSqs1LMKzOn9
         BBg//Bj7wCjlnZjs4XjSn55m/jQF0cBmHb2WyCgFT8bZqWVyP/5SxixqdsWU3qXPsTwu
         57/g==
X-Gm-Message-State: AOAM531f7ksKZ9BegyJ3eqtoVimltimk9rCey8yqC54hyIURmeUuPSo/
        lj+T4VuB1I4Q+/ot/Iv8mVoLrg==
X-Google-Smtp-Source: ABdhPJwnghVE9Q0R/RPNlTKokvs94soHX1clk7e0bynVwyaomi3TgNaLq1N8p7hKKSTme3qp/b82GA==
X-Received: by 2002:a62:e402:: with SMTP id r2mr7098143pfh.300.1590730907371;
        Thu, 28 May 2020 22:41:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 74sm2894496pfa.87.2020.05.28.22.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 22:41:46 -0700 (PDT)
Date:   Thu, 28 May 2020 22:41:45 -0700
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
Subject: Re: [PATCH v2 2/2] tests: test seccomp filter notifications
Message-ID: <202005282240.B9AE912F6E@keescook>
References: <20200528151412.265444-1-christian.brauner@ubuntu.com>
 <20200528151412.265444-2-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528151412.265444-2-christian.brauner@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 05:14:12PM +0200, Christian Brauner wrote:
> This verifies we're correctly notified when a seccomp filter becomes
> unused when a notifier is in use.

While you're adding this, can you adjust the other user_notif tests to
check for POLLHUP as well (i.e fail if it appears)?

Otherwise, yes, tests look good. :) Yay tests!

-- 
Kees Cook
