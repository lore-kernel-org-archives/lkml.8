Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0E6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 00:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33BAD2076C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 00:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="aJ49HXpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388666AbgEYA2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 20:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388431AbgEYA2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 20:28:35 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D69C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 17:28:35 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id n24so18868922ejd.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 17:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EwykEdM3SyRomohU3e5rjyCqJmUudG4184nZb0VuwGU=;
        b=aJ49HXpD8xoJymFOGHw1Nc6cTn41t6yYceBnCnsfkEqmu3aJ27VyozXfpO/GoSZC/R
         UJ3yEwYnBWMl9OKyjjI9EdX90Lxbf6cWAp4os/Ue1Q8oVNySS2a/98rceH1q0GTQbg9B
         nP4GgcY/CUptu5HoHw/M/CetsHczAvdav/BPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EwykEdM3SyRomohU3e5rjyCqJmUudG4184nZb0VuwGU=;
        b=snD7T7VzKYDuq7O056b9icJkzxrBgbBsH/SQuiBkziY4WaIJzr1tNHNeNSBmvTDLYA
         elLr6JECf1aQVoSv/IGITcDCa6Dno+J+BGypzS1DcwvNJ4BH17i9iHix0ujGEYReJBKw
         FMA2CxeK5rf4l7urUkQqUcq2tplmLFxA41/Nl7pbJ+G0Fw5DyThsqKLP2XmD88kkPrKl
         1XAnOVPK1cX7X2xzkRGf3W3FGDQIh7bMI7taQiaucBifKINqD5h4tz45adzUcVzWC+RC
         sB0ijyK7RQPd/zaWowbKRiPNkllEIQz9DjT/B2AQ0yl+NakofFKvj8IUWyTYfslVcVyY
         VGaQ==
X-Gm-Message-State: AOAM533m+/WpQh0DnMSAxlkI/zexK7i0hErF2AcYM/9ttVAF7KSXetQM
        L8dPvTMdFnJKHUlO4PliCjdi+S0nPYJu1gQB2HiF7Q==
X-Google-Smtp-Source: ABdhPJycfYQqMDOhoxG3T5+gzE+Rmy00QjGgDHzGZQDgo60Ypn25+O9Pk4JaxLFwqVLwUISA9KAsAIHoohWFwCKAGh8=
X-Received: by 2002:a17:906:2cc2:: with SMTP id r2mr16329022ejr.269.1590366514113;
 Sun, 24 May 2020 17:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200524233942.8702-1-sargun@sargun.me> <20200524233942.8702-3-sargun@sargun.me>
 <20200525000537.GB23230@ZenIV.linux.org.uk>
In-Reply-To: <20200525000537.GB23230@ZenIV.linux.org.uk>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Sun, 24 May 2020 17:27:58 -0700
Message-ID: <CAMp4zn-F3b8Z4ZDjgnJM1Fbban2oVtCm_rZkhBhDKs6fw2_=rg@mail.gmail.com>
Subject: Re: [PATCH 2/5] seccomp: Introduce addfd ioctl to seccomp user notifier
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Jann Horn <jannh@google.com>, Robert Sesek <rsesek@google.com>,
        Chris Palmer <palmer@google.com>,
        Matt Denton <mpdenton@google.com>,
        Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 5:05 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sun, May 24, 2020 at 04:39:39PM -0700, Sargun Dhillon wrote:
>
> Bad refcounting rules.  *IF* we go with anything of that sort (and I'm not
> convinced that the entire series makes sense), it's better to have more
> uniform rules re reference consumption/disposal.
>
> Make the destructor of addfd *ALWAYS* drop its reference.  And have this
> function go
Are you suggesting the in both the error, and non-error cases the ioctl
invoker side is responsible for fput'ing the final reference in both the
success and non-success cases? Would we take an extra reference
prior to fd_install?
>
>         if (addfd->fd >= 0) {
>                 ret = replace_fd(addfd->fd, addfd->file, addfd->flags);
>         } else {
>                 ret = get_unused_fd_flags(addfd->flags);
>                 if (ret >= 0)
>                         fd_install(ret, get_file(addfd->file));
>         }
>
Wouldn't this result in consumption of reference in one case (fd_install),
and the fd still having a reference in the replace_fd case?
