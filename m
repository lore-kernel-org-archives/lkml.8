Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D92CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68EC32072F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h6bs3+G5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbgFJOww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 10:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgFJOww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 10:52:52 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC34C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 07:52:52 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id m2so986074pjv.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 07:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ckx78+M0dnRp7CDkC5nlJq2ut/FC9a32QsYoXEVdcyg=;
        b=h6bs3+G5nSDTlpNrGYt9iAuFmhG2Sg/bwOcVNh68S54fSpp6+3iuYc63IZsJR0uFY/
         H0T6iKW1Pyt/NsDQ8xFB1zDFOcY7SkRzaCeO8PXntNq0e4pqonIuXqdo/tly0vqJXDYg
         XZrXxWEiyKmfMrmOJKNmNFIktRzO7EoUbxq28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ckx78+M0dnRp7CDkC5nlJq2ut/FC9a32QsYoXEVdcyg=;
        b=gtO49dUPGaYgw8xNWR8f0yNPz/8gu/84gYiiZvaIobrZhLPb82IZPUU0M7u8tVTxAc
         T9g/3Oqbh78sX9HLwfjxIxIL0z9mfNkxvVMW6MGxHZ+6Jzx358St6y86vtvcjpYrRFO9
         Sbzu5JvM0+um7NoQb+vuB6ZDfujGmtYq/hlTf7p0oSLHF4KYVUqmjlRZyjcyE9sQ0b2s
         Xz5TAI8A4fZq1d/VzfR8901/aUfXsxpKQxyjzkGglUj2nTicwKjliYMVMrcEvUqEA6g5
         6mIHXXetQTYiwNkdvOCysh6S7Pu0cP4YPNh2OlCRU/6toYotCGefzsuRNFbriD6nrfNJ
         iuvw==
X-Gm-Message-State: AOAM533iPICtH4bRSct1vy+d7LQ5TZBsC45jl4LjEv8Mg0yEC2kXf+bh
        xDt4fkKK0HWVAxpQv1T0zrBLUw==
X-Google-Smtp-Source: ABdhPJzqtF7DhpFtsIEUN3dyziIjVeiOboqgoatIxkdBLv1Tfz5qR6gDF1qjp80pofVuzJfDJJjtIw==
X-Received: by 2002:a17:90b:238d:: with SMTP id mr13mr3525434pjb.19.1591800771850;
        Wed, 10 Jun 2020 07:52:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l3sm149507pgm.59.2020.06.10.07.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 07:52:49 -0700 (PDT)
Date:   Wed, 10 Jun 2020 07:52:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Sargun Dhillon <sargun@sargun.me>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Use __scm_install_fd() more widely
Message-ID: <202006100750.3CCF6242B4@keescook>
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

Yeah, this seems good. I also note that randconfigs are kicking back my
series as broken when CONFIG_NET=n (oops), so this needs some refactoring
before patch 2.

-- 
Kees Cook
