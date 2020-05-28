Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A28C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 04:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B87F20888
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 04:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fEXn0tJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgE1EO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 00:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgE1EO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 00:14:56 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F120C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 21:14:56 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z13so21955223ljn.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 21:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=whokj7dhyD8nKdYthVeJGDFA0AYbgH+VAE8dNabj+Nw=;
        b=fEXn0tJWaEcS1/o9rxuVZxV/ZZ8RppTt9wKLPP/VzEZKAcFJF1/V5Xxm71Geeljn7x
         8KdzwbxxwOaUxY2h4tCDaNXTmaagWb12o7BSvnVuNSK5+cVn1ayVf4F4F36HF/mNWA0E
         CrmAraECFr86U8gMhGTqyqYw81IuVNGhevHsd5hDPnYljHUudd3UM8/8PUMgnqsxACE5
         lt1dTFS8UP8pSzzUwqm64j8JOFez8tg3ldCFxRxqa7EzJX7Up8FV+tQXLUUpnqH8+Mn9
         7urqU0X7nx40l7g0xlIh9J/zcrXKTDzwXgUEKukSDIcEKxl5XzLzGFH5TLbCcolu9FPa
         kAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=whokj7dhyD8nKdYthVeJGDFA0AYbgH+VAE8dNabj+Nw=;
        b=sIS3Y2mgboEjt3LYN+s8NTmF+4ZHoNwZfuk1/7Ezq1+ZsPxaIoVT6aJFHmI8dGE70a
         7o/sLcpiWl6gEF0UdPaLdqKOnLeyqDDRpVewXM7ElPp1Kshqt+SXFnhSXNSK6nNCxmT4
         kwF9YmhK7sdWXqcEZ9KMgo43/l8otIful4YzUz4B2Y/2RvDRTXMvb4MBhQv6Cwd35qbm
         6hnYw5AJOeJNq7VTXC8oK4hzQLmoKGq2V6g2R5vH/s2FllbG+9rW/luHU1bN1J8VBxRy
         GT5raGYDE/2Kp/LokXoSul3aoywkvNUYmDDOXxaN07z3l6fWy/rh9r4KYIfllroj56VU
         OVmg==
X-Gm-Message-State: AOAM533hRy269jNie9YigWbwbRTC5HIwCY1G1keLgYxsyu6Rh/MQliKG
        MuNk5Z7y1Mg/zdzDyC/jecqdElzXMmzYFv5W+/X1nvn9
X-Google-Smtp-Source: ABdhPJwj+PIfUBYviPwcbQC2/sgGSyj7GVt/ly1AHD6JA7ry08MYxylj/6ZU9cubc2XQbE8HW1jFAhlShFrz9Iv0jy0=
X-Received: by 2002:a2e:91c3:: with SMTP id u3mr476939ljg.365.1590639294595;
 Wed, 27 May 2020 21:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200527111902.163213-1-christian.brauner@ubuntu.com>
 <202005271408.58F806514@keescook> <20200527220532.jplypougn3qzwrms@wittgenstein>
 <202005271537.75548B6@keescook> <20200527224501.jddwcmvtvjtjsmsx@wittgenstein>
 <20200527231646.4v743erjpzh6qe5f@wittgenstein> <202005271851.B7FBA02F@keescook>
In-Reply-To: <202005271851.B7FBA02F@keescook>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 28 May 2020 06:14:28 +0200
Message-ID: <CAG48ez017z2SrNvvc0BfsCM4DTXTdzMPdfYcT61XsXU2a4FUZQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] seccomp: notify user trap about unused filter
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Chris Palmer <palmer@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Robert Sesek <rsesek@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 3:59 AM Kees Cook <keescook@chromium.org> wrote:
> On Thu, May 28, 2020 at 01:16:46AM +0200, Christian Brauner wrote:
> > I'm also starting to think this isn't even possible or currently doable
> > safely.
> > The fdtable in the kernel would end up with a dangling pointer, I would
> > think. Unless you backtrack all fds that still have a reference into the
> > fdtable and refer to that file and close them all in the kernel which I
> > don't think is possible and also sounds very dodgy. This also really
> > seems like we would be breaking a major contract, namely that fds stay
> > valid until userspace calls close, execve(), or exits.
>
> Right, I think I was just using the wrong words? I was looking at it
> like a pipe, or a socket, where you still have an fd, but reads return
> 0, you might get SIGPIPE, etc. The VFS clearly knows what a
> "disconnected" fd is, and I had assumed there was general logic for it
> to indicate "I'm not here any more".

Nope. For example, pipes have manual checks based on pipe->readers and
pipe->writers, and manually send SIGPIPE and stuff from inside
fs/pipe.c. And pipes are not actually permanently "disconnected" -
someone can e.g. open a pipe that previously had no readers in read
mode, and suddenly you can write to it again.
