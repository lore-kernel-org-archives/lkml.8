Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD1DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11D7720734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgFJJrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 05:47:43 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56561 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgFJJrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 05:47:43 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jixKb-0006ae-2c; Wed, 10 Jun 2020 09:47:37 +0000
Date:   Wed, 10 Jun 2020 11:47:35 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Sargun Dhillon <sargun@sargun.me>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Use __scm_install_fd() more widely
Message-ID: <20200610094735.7ewsvrfhhpioq5xe@wittgenstein>
References: <20200610045214.1175600-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200610045214.1175600-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 09:52:12PM -0700, Kees Cook wrote:
> Hi,
> 
> This extends the recent work hch did for scm_detach_fds(), and updates
> the compat path as well, fixing bugs in the process. Additionally,
> an effectively incomplete and open-coded __scm_install_fd() is fixed
> in pidfd_getfd().

Since __scm_detach_fds() becomes something that is available outside of
net/* should we provide a static inline wrapper under a different name? The
"socket-level control message" prefix seems a bit odd in pidfd_getfd()
and - once we make use of it there - seccomp.

I'd suggest we do:

static inline int fd_install_received(struct file *file, unsigned int flags)
{
	return __scm_install_fd(file, NULL, flags);
}

which can be called in pidfd_getfd() and once we have other callers that
want the additional put_user() (e.g. seccomp_ in there we simply add:

static inline fd_install_user(struct file *file, unsigned int flags, int __user *ufd)
{
	return __scm_install_fd(file, ufd, flags);
}

and seems the wrappers both could happily live in the fs part of the world?

Christian
