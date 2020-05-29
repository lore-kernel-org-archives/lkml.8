Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50C8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F736206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PKvBlHRs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgE2IC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgE2ICU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:02:20 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51609C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 01:02:20 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id cx22so883811pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 01:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FH4qW28ZV11K1NJ8SgsxqpyEJdDXv+9PfynuvH0m1ZA=;
        b=PKvBlHRssXBF/CGUw0qX4NviijQzAG0OL5AGitmwtk1EWwxFWvDwx+ZQH+228Vc7Yi
         7SYv8mVyb6DJ/1xrXsGkJCiM+bn52Nr5TZbmGN1RyTPQXVAZXQ9breNX1wunEuo/73H+
         plPjjqJYBoXFjV2VIDZ6SdREICwi4b0BPZ9Kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FH4qW28ZV11K1NJ8SgsxqpyEJdDXv+9PfynuvH0m1ZA=;
        b=o4n9DcZlyAMCaNjfMb4fLcV4jQpohGwSJXZAMqvbQsp4/y7wD+pXCv070m1rkvHwvJ
         +ne+RqDdLEK+DxjW3SkhlZRzN+fFPPmTpEY+sIWjXL9dklgbHvTxLE9xh5H5+QU3SaLU
         QHyqDS0+zXkxk+2hlTjDrhhswO0dtZcvgiWMOzN1VDXGy2hVU82jTvsSogAjfERQIiYv
         HxPX0OMEVcI6qZFcOeYrxvPKtYxtvoNCgbZeqhEfBRoSAm+POqj60kIGfbO2oNKJCgYQ
         ZlQDS44VKIH/yCv+U4/PJh7OrCEJ4kBaDbp+aALJ06cHjBVLk22cVgtdEdPkaA7Xale/
         70Mw==
X-Gm-Message-State: AOAM5308Vf7Ey+YSztgSKbma/zgR/jxcJ7uzAhgYk92bGrH+Wv/w7vr7
        6iOIdIIVYbslmRfAiZ6FrfgvT/TyEy5NEA==
X-Google-Smtp-Source: ABdhPJxOxAOl3PDJHnW4UY/3/6ePmWU/5PEvPRRRRXIViE/b/RGVejNHgYBs2M8HkKHPoKhkoJXufw==
X-Received: by 2002:a17:90a:c004:: with SMTP id p4mr8581844pjt.170.1590739339904;
        Fri, 29 May 2020 01:02:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c7sm7574099pjr.32.2020.05.29.01.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 01:02:18 -0700 (PDT)
Date:   Fri, 29 May 2020 01:02:17 -0700
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
Subject: Re: [PATCH v2 1/2] seccomp: notify user trap about unused filter
Message-ID: <202005290058.926E6B5421@keescook>
References: <20200528151412.265444-1-christian.brauner@ubuntu.com>
 <202005281404.276641223F@keescook>
 <20200529074744.nf6g5mdeqz6zp4un@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529074744.nf6g5mdeqz6zp4un@wittgenstein>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 09:47:44AM +0200, Christian Brauner wrote:
> Well the correct way would probably be:
> "usage" -> "refs"
> "live"  -> "users"

Yeah, I like it! :)

> So we'd need a first patch to convert "usage" to "refs" and then
> introduce "users".

Yup, sounds right.

> > signal_struct has "sigcnt" and "live". I find "sigcnt" to be an
> > unhelpful name too. (And why isn't it refcount_t?)
> 
> I think I once looked that up and there was some sort of "not needed, no
> gain" style rationale.

hrm. it uses _inc and _dec_and_test... imo, that should make it be a
refcount_t. Even if we're not protecting some clear UAF issue, it's
still good to notification of potential bugs.

-- 
Kees Cook
