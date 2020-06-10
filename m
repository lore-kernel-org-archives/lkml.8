Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CADC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B233204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PIR7AKWK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgFJRDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgFJRDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 13:03:07 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747A3C03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 10:03:06 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id s88so1129721pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 10:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WnFhsHiRkjL5CKHVcJANd7l4RT2J9uPwXvDpKNqYxnE=;
        b=PIR7AKWKofwN1umcHuM09ZxByEVhsJVOX+V/OkCyg+RRtageSmj5AXBOw1PgAVS82M
         nNByVjXpoDHIG7eGGtgax/8dEArheP0Cpq0o02PdjBud76Rvs9QkyZ3aBIhNBoYq68xw
         0mWR8ibZsAqaCi+pwdrY/Z2pKEems7YkZMReI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WnFhsHiRkjL5CKHVcJANd7l4RT2J9uPwXvDpKNqYxnE=;
        b=H2vO+PkjZGYZ37X8q47UelBe+vuZl+DMJFGqaE+JIv11P5+Ikc0HV4c5Rgux2FAOZF
         PMKV0mf5ph1YL5zQxiXeuNaVnV9VyCa7mTm5yxV0yLiNQVR+RxmcUSAPTseqLbTBO9rJ
         bQI1+3Auf7IZoLx9+Xm+mdjSFyy24XX1DSDobyv250peHVnDSInARZ5JQdgpIHEJxSP3
         Y+ikgrsar3p8povyFu7zT3uii9wAVMHuLrAp5JjWaFy7F5wfT/o4O5BpAe3VLQp//LnT
         /u/+ljfE+vMCaGUqc+O31s8QTnn6r++GShSlbrgZGJd7PlwARRik12MRfvyTeDTafZ44
         X05Q==
X-Gm-Message-State: AOAM530/14wqJlm4duAZSEbgoxx+dZjH9cpg9pStbnGJq9EajNAAPBjo
        9SfLqkDw+jCZzPGLWAk5EP91XABmUr5+nw==
X-Google-Smtp-Source: ABdhPJw4PWREPUlcxU0tV+ltlwQoUM1QOuUEjsfwJs5U+2uv2dt2CRp1VjaG5JfN4FoaNx1oCuRJ4g==
X-Received: by 2002:a17:90a:fa95:: with SMTP id cu21mr3859547pjb.56.1591808585874;
        Wed, 10 Jun 2020 10:03:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n189sm449402pfn.108.2020.06.10.10.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 10:03:04 -0700 (PDT)
Date:   Wed, 10 Jun 2020 10:03:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Sargun Dhillon <sargun@sargun.me>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Use __scm_install_fd() more widely
Message-ID: <202006101001.6738CA0@keescook>
References: <20200610045214.1175600-1-keescook@chromium.org>
 <20200610094735.7ewsvrfhhpioq5xe@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610094735.7ewsvrfhhpioq5xe@wittgenstein>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 11:47:35AM +0200, Christian Brauner wrote:
> On Tue, Jun 09, 2020 at 09:52:12PM -0700, Kees Cook wrote:
> > Hi,
> > 
> > This extends the recent work hch did for scm_detach_fds(), and updates
> > the compat path as well, fixing bugs in the process. Additionally,
> > an effectively incomplete and open-coded __scm_install_fd() is fixed
> > in pidfd_getfd().
> 
> Since __scm_detach_fds() becomes something that is available outside of
> net/* should we provide a static inline wrapper under a different name? The
> "socket-level control message" prefix seems a bit odd in pidfd_getfd()
> and - once we make use of it there - seccomp.
> 
> I'd suggest we do:
> 
> static inline int fd_install_received(struct file *file, unsigned int flags)
> {
> 	return __scm_install_fd(file, NULL, flags);
> }
> 
> which can be called in pidfd_getfd() and once we have other callers that
> want the additional put_user() (e.g. seccomp_ in there we simply add:
> 
> static inline fd_install_user(struct file *file, unsigned int flags, int __user *ufd)
> {
> 	return __scm_install_fd(file, ufd, flags);
> }
> 
> and seems the wrappers both could happily live in the fs part of the world?

I combined your and Sargun's suggestions. (It can't live in any more
net/core/scm.c in the case of CONFIG_NET=n, but the wrappers make the
changes much nicer looking.)

https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=devel/seccomp/addfd/v3.2

If 0-day doesn't kick anything back on this tree, I'll resend the
series...

-- 
Kees Cook
