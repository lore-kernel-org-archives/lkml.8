Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD22C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 07:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D74320709
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 07:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="tRD/6LNm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgESHY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 03:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbgESHYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 03:24:55 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BF5C05BD09
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 00:24:55 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id 79so13472982iou.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 00:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XTX48UHIYrdm7+oEjTcRQnC536L6yCH/aZ7dAWVWPyo=;
        b=tRD/6LNm+jP7lIRDrecYBHFdUUu/qddKNdZeQzkU81q6GlU1P2PqoHKmTQqBHRBS87
         6tBdY5IQAYWaIK9MiYAfd58PJzLM5DyAc+7Og/4J/Lge0QZr3IZRiAMU/YW9LgnvdXK9
         2N9nzV+8GZto3cOMvM1vFMUUxhdKyjt7xyUnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XTX48UHIYrdm7+oEjTcRQnC536L6yCH/aZ7dAWVWPyo=;
        b=QNUu1GtwK4ibLk+hV1pnJQWSgIZCwtnvo5ZisFYc6uuN4MtHyzov+VhOsHRaUDWJKt
         VFRm7YE8W9aVi854gUFsxwVV51BUJM5fMbZyb6unsKxhM3SrkeEOZ8ZStYxVa6c2Z4Jh
         bq/c+eAULJvflHo72FdeprmjYT8YT8g/BkgJsUbYznbsdNI+i00pd8tnU/apav4FZp6L
         iQMK8XVVkl6UsqXHPsG+3+YMmiv2/ahAIfgaUsKaCIlKXXE5dtzxI3e/ujAc6TJDiKGL
         KvW6/Y33eyWARpzAbKwABPQkzRveRSMGKSv2VnZI2Ybj0mJi4HUJd/FZhPbxHHi2YRj5
         HPmA==
X-Gm-Message-State: AOAM53194Tnxh2V91EkPCE/lIdmUJ/YzRQCpbAS3DCgEOj1EdlfGiTun
        3kzioTDQWf13E+Gdo3aL9HMDyg==
X-Google-Smtp-Source: ABdhPJz2ZihNKVaQTcw8L30+QB9S0lcU2ayc1arLlc7WCpfR7gcfQURqStw7mlIv4UvxTdGz2s3z4Q==
X-Received: by 2002:a05:6602:2c45:: with SMTP id x5mr17431038iov.80.1589873094884;
        Tue, 19 May 2020 00:24:54 -0700 (PDT)
Received: from ircssh-2.c.rugged-nimbus-611.internal (80.60.198.104.bc.googleusercontent.com. [104.198.60.80])
        by smtp.gmail.com with ESMTPSA id n25sm4689058ioa.29.2020.05.19.00.24.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 May 2020 00:24:54 -0700 (PDT)
Date:   Tue, 19 May 2020 07:24:52 +0000
From:   Sargun Dhillon <sargun@sargun.me>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: seccomp feature development
Message-ID: <20200519072451.GA3128@ircssh-2.c.rugged-nimbus-611.internal>
References: <202005181120.971232B7B@keescook>
 <CAG48ez1LrQvR2RHD5-ZCEihL4YT1tVgoAJfGYo+M3QukumX=OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1LrQvR2RHD5-ZCEihL4YT1tVgoAJfGYo+M3QukumX=OQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 12:39:39AM +0200, Jann Horn wrote:
> > For user_notif, I think we need something in and around these options:
> >
> > - make a new API that explicitly follows EA struct design
> >   (and while read()/write() might be easier[4], I tend to agree with
> >   Jann and we need to stick to ioctl(): as Tycho noted, "read/write is
> >   for data". Though I wonder if read() could be used for the notifications,
> >   which ARE data, and use ioctl() for the responses?)
> 
> Just as a note: If we use read() there, we'll never be able to
> transfer things like FDs through that API.
> 
Although there is no good reason for read being able to receive FDs, there is
precedence for recvmsg being able to do this. Either way, I do not think
it's a good idea to recv file descriptors, and instead file descriptors
should be fetched via the pidfd_getfd syscall.

Injection is more complicated, and for now, I believe that "writes" should
be done via ioctl, or in the future, something like sendmsg might work.
