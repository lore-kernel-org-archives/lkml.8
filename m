Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEF1C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 03:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F00120810
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 03:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kMEJZWXT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgE3DR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 23:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgE3DR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 23:17:56 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C55C08C5C9
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 20:17:53 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id k5so1606171lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 20:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qAzzi6iT/99Kzep9I6N6vUOQSaglX3NMEqv/R35zMzg=;
        b=kMEJZWXTCuXXpMzPmI1oXS8B+nPKTCFTFJeWDNanOkoeAWo0NajeLc14NLFwtXu7TD
         T1esDDSnFxgbWr9UHpuKYsKhwIEfcbW9guLsK7BEC3IU1PHw7e8Jo8W9QMRKDPcmexGH
         2pL6zks1ywxdNUYWD9luZ3HodypdOe4QbDbeH054DV9+nVJURp47JX23CbAY9mms1WZy
         g32iddYT4guKgxTH6aECpechaohc+xsEXkXZUyd85nhD+Vu89iXgz5aTQwnUfQ0MGMTt
         KAucywSTUO+PUvGYPObqYElbCE7OapYyow/1m6glLRIq0ZYLtkXvHirthic91m514SKm
         oT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qAzzi6iT/99Kzep9I6N6vUOQSaglX3NMEqv/R35zMzg=;
        b=S+8r7P6DL12SxnBEtq/PMWJh2YheIIE5MF/Vf5p436itgrmgAl48h5adYdX7stybwP
         1pyQgC63LS2o8Q+aWh13O7FgR6zOg6rSxHo7DNlIFaP5xRWzh3RZaUofbxqooX2IXEj7
         xFwD9p0Oee3q2CTK8++WDQGgOVlNWK1ikOuLxcEb69U5Auy8KdfEN0g2x/dj3CBkeRG0
         459cdEn7MOFDgkDwiBfbjji+uK3LFU5W+jnxs+lDikuiSnkJUeEfrR0tC+NX0ooCHr6V
         gqLfCMzXFuS933ZRbYt60uxMIfP1//xaxveFpqDS4hHWE/v1/VqrDHoBX9dzsPryA5qa
         LsKw==
X-Gm-Message-State: AOAM5334JjfOv6wNdE+Z6tnGw/+RPF9k9cjz4T8Pd/ju0ewXtWhcjAw5
        kdIOLJ84d7/iLNxX4YY3bvXQ2CmHYP3zT/j+p8UkNA==
X-Google-Smtp-Source: ABdhPJwVr1MLXqp8e8epUu6GNQxDXbxAvK0QuUf9kOz8L3PrS50T9ROfiZz8JKiyr98eRsYs/2ctRWjx1pcKrAK9R9M=
X-Received: by 2002:a2e:1f02:: with SMTP id f2mr5178479ljf.156.1590808671140;
 Fri, 29 May 2020 20:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200528110858.3265-1-sargun@sargun.me> <20200528110858.3265-3-sargun@sargun.me>
 <202005282345.573B917@keescook> <20200530011054.GA14852@ircssh-2.c.rugged-nimbus-611.internal>
 <202005291926.E9004B4@keescook>
In-Reply-To: <202005291926.E9004B4@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 30 May 2020 05:17:24 +0200
Message-ID: <CAG48ez0+BvbLoSc+zcZwnwfOSCFt2LHnUkzzt-d4LQFJYXZC9w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] seccomp: Introduce addfd ioctl to seccomp user notifier
To:     Kees Cook <keescook@chromium.org>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Chris Palmer <palmer@google.com>,
        Robert Sesek <rsesek@google.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 30, 2020 at 4:43 AM Kees Cook <keescook@chromium.org> wrote:
> I mean, yes, that's certainly better, but it just seems a shame that
> everyone has to do the get_unused/put_unused dance just because of how
> SCM_RIGHTS does this weird put_user() in the middle.
>
> Can anyone clarify the expected failure mode from SCM_RIGHTS? Can we
> move the put_user() after instead?

Honestly, I think trying to remove file descriptors and such after
-EFAULT is a waste of time. If userspace runs into -EFAULT, userspace
is beyond saving and can't really do much other than exit immediately.
There are a bunch of places that will change state and then throw
-EFAULT at the end if userspace supplied an invalid address, because
trying to hold locks across userspace accesses just in case userspace
supplied a bogus address is kinda silly (and often borderline
impossible).

You can actually see that even scm_detach_fds() currently just
silently swallows errors if writing some header fields fails at the
end.
